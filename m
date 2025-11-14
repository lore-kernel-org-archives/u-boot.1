Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6D2CE7AEE
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 11:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B9C840A2;
	Fri, 14 Nov 2025 12:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LtbDTZxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B151C840A6; Fri, 14 Nov 2025 12:46:28 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4678409E
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c70fcc8561so677964a34.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 03:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763120785; x=1763725585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8tvr8lroF92CICnuHQBhwxyWWVGgJ2MDh5Af+LX+pPQ=;
 b=LtbDTZxk+TqQQd6Z3omTOeAJ3GO1YzT2aBNf4vxTZ8Zq2qeCadFtDwCJw0Cd6Cdb5R
 snBQukdUIZf1Pb9QsQ9QTAGT58/oPtBW8IkCBcOFFNab0Qg29zq+y2WzlwTuwbsV/DuQ
 5f1W2IkPpCzsohTV2n/4Xd26UuHRx7bqwWoie/fbRnWBNsJHrA3vDH9TVFw1DzzMNTin
 BM8p87GAhpgiUE4Ycyt0afZ5BVOTfdO9cuyyqnXduZFxWwcTaLlOQePfknqrJJuDTfd7
 PvCzXkm5PEH9rEGtN2IQIxwuLsyrw4jemr7IIaNHYwe9AMOwI59RsfjKZItPovCZPZZA
 tgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763120785; x=1763725585;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tvr8lroF92CICnuHQBhwxyWWVGgJ2MDh5Af+LX+pPQ=;
 b=XgWTD7qw6oyy6uNz/8QnCf0mvfgypyrl6lRwZZ4XqEglXfRyjG6jZ2bmCEUyEWyCTk
 dI5Ogre4FI0iHPjXmvp6CZJtfS//mF0uRaXX0/SbVolE6gI20XeAwDliDsTfN5wVOztD
 Gj/S8iCLrJ/Qr9su49x8GoFfjzg6eezdWRdq+B7JdY2BgNHUwsC3QPk0CfKAH1Il+qRa
 SH/YkrIqIv4T3HZIFRmhSGHf6MmCLYrY0Lw0No2UzHpKZiqcThI36tXEbGbf/cFPL1Oy
 wbo1TYlG0EJp1mthwFwM3cY90M8iN/sAfJCVNf7iQt7XqOBk4LcEieWqODN4d2dRFGnh
 2iEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq2TCw5yuEBp7VVygJ3OYmruU7ea/h+KbWf3Rw9hgs6K4H181X78lFi2ra5WSvpbrb64QoRRM=@lists.denx.de
X-Gm-Message-State: AOJu0YzUVEBIGCCIMgy7oW4BCZOo965N2dodgS7lvOg9WtYi4EzWq18Z
 Ao+ScnrQpqEyz1Lr7kgb5fHKYeBtkuY5sYH5RSs9XWpzNyf7Vq3HZk9T4Xyd0OElCh/B+iwREqi
 Y5tGDksD4Zi7axm/E+lslgJ+6X3vz2Do=
X-Gm-Gg: ASbGncvlXdsesxncPmEzu8x2tADJT3yyLGBF8jIgoJD2y9FzbTFpTycbIuikaFWttDP
 VA4IEy7yAY4jQ3JGgYp1cSQUPgFQtqqNQfEPKjS2dwQVNObf/RyIeBtSgV/OnZfxAQCJxzZjir4
 xN6Z63chD8kzyOYo/HVp6QiTORsEhd8naVO1LQpzZkhowHE0RTYAoilr3EoFtU6T2VjRlDePoQY
 cGGqbvQJ4EsoA5M00YrAjbZyZriTiSKCo+LnJluzs/qTq2mnzrYQRi9un8rTDmzRi+GQdSt
X-Google-Smtp-Source: AGHT+IEfoyins5mCbUWS3sOHidBLD/wgsJsFw139XLyJvr9Wpv1C9BC8HCfjepApBdXVaw2HM8/JyxYdFO2Kp/6EJDk=
X-Received: by 2002:a05:6830:2b2a:b0:749:fac2:92fe with SMTP id
 46e09a7af769-7c74408b8f9mr1448468a34.0.1763120785178; Fri, 14 Nov 2025
 03:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
In-Reply-To: <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 14 Nov 2025 19:46:13 +0800
X-Gm-Features: AWmQ_bkpyxY-nssg2o-voUT01sLcwoPFIwtrUI3VZG9wW0z9qXBM1LNUc_yzRPM
Message-ID: <CAN7C2SCB+ENfHQ2T9X9d_vokxLFzS=WayyAjSkznmt+2pmihTg@mail.gmail.com>
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

> To clarify, as of today, the driver model has already been implemented
> for Agilex, Agilex7M, and Agilex5. For older SoCFPGA platforms, we will
> ensure that SD boot and existing functionality continue to work while
> maintaining compatibility during this staged migration.

No, there is no ensure that SD boot by just checking what the previous
patch or patches had done.

Simply deleting the most critical line and just feed-in new SoCFPGA required
code breaks the SD boot or possible ROM as well.
And this is not the proper way to patch things.

There is nothing to do with drivers here, in this patch.

So either you revert the old patch or repatch a new patch is your choice.
I had no right and no place to tell Altera what to do, however, simply
breaking mainstream u-boot code is completely unacceptable.

Brian
