Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD24CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 04:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2204E83280;
	Thu, 11 Sep 2025 06:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zmfw1FxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E65783253; Wed, 10 Sep 2025 18:55:02 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E710831D5
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 18:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-624fdf51b44so5284987a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757523299; x=1758128099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hUme8iRJpsEYZ0gQDWQjmNewG2jb+bCZwNwXYH0opYw=;
 b=Zmfw1FxXUqgMxCWJPtnuLvI97L/6y9SxOFnSZox1S+iPzrBwxeRB+3B0wzTxqC7Rjp
 NRqh1rLK72y82gHno1WyK2oSnALTGkhSBjr2CUC20PbzDkR3TMMJprGx0i0cLhypnPlQ
 gVBp/nRwPnLufc3QgB0hhKNnn5h3JCc2/pCAOMZt10tbBXVYKZZ7J+KZFs9YECSBnrOt
 aMRDHyd/bX6zi9SFu6ZihVkp3Yet6RgYyQUeiBOX+Mw8QG5ryxb/lLvfhODzTU/97pH/
 9f1ZFhkcz3RqHFBcotoo0iCRSljRlaLw54BBzyCs+40MbQHEi5rttUcLvKEQAEuPK5s+
 Mjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757523299; x=1758128099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hUme8iRJpsEYZ0gQDWQjmNewG2jb+bCZwNwXYH0opYw=;
 b=RZoXy722OnuuUsGgcuyaWOp/FgemQo8Ps0FPrSBf4CkOB6OrEe7QxR4DfJvSnZklNE
 c/0adRJkENQZaf6ceT8hY9O3nhXSAtmUF/VXhkKzjz2QMqdKNs2bekqPyrPnJ+5nHRk8
 UGFQle6hiA92vVHifHMZgNjPRrhQcElEbv+DuQz9jA6huwHZN8+CiGp+zcn+g63PhnHU
 qlqoBPyf+K8IG+S4Z9OGKlHk27GLlvs+4+Da4WhCTRB5fVyiOH+FpeKsh2XfwQv2Ju3d
 u675umAEd3odrATmfFgYhEDDPLu/QfSDw+aFXihpldskY1QLIBk5U85t+7NqGQ7i9iM5
 /AcQ==
X-Gm-Message-State: AOJu0YzmCkWHNOezjDPysE2rebUP3dDF207ubESqjjTVEObLUzbwrfji
 q+SK2nPiilTqCyGR1v+M2c4+Rtpjzw65XFhJYmPKihETBUbjCT2j4n/Kxw+4AJg86UvogV5RqHq
 oiUUyK2orlyUmBItbNJSBFQsx0un86E2xh7or
X-Gm-Gg: ASbGnctT7j5KJwD0c+w3DJ0J86ZEv79jNRX2Db12C1IpHmv/NtnAOO2dg2DV/NCGuJE
 U5P9vEHrfzCpdEJhuYO2LhLbLMVEFC+cDNCcbSouNy60+d1L1DibnQQtqSHdpCkwf9AQDaGCZx1
 MGt8FmtJp2AWOQ9qS/rNMfTgMF2A85oe76QZR22mhipAQST5RQUfTOsz08qY8SeVOsUEgZ7kyBr
 J4vuwDwCfARfZOyhDyL4jTzXNNMawq/K3waFfimGg==
X-Google-Smtp-Source: AGHT+IE7uODlSeFuRaVi7LrQu6/mU8ulIfWyKqudY3B/u49HIMXWi+pp6usYGX5il1z2AM0Wn8kidOQruZWPX9wzv4M=
X-Received: by 2002:a17:907:3e99:b0:afe:74a3:f78b with SMTP id
 a640c23a62f3a-b04b17d9920mr1553525666b.59.1757523298840; Wed, 10 Sep 2025
 09:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250903202043.285746-1-sidharthseela@gmail.com>
 <20250908055429.598536-1-sidharthseela@gmail.com>
 <20250908215825.GT124814@bill-the-cat>
 <CAJE-K+C0FHwxi4DneqqasD0D7H73BNk-ZO4GE+ZWSN=a0fdtqQ@mail.gmail.com>
In-Reply-To: <CAJE-K+C0FHwxi4DneqqasD0D7H73BNk-ZO4GE+ZWSN=a0fdtqQ@mail.gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 10 Sep 2025 22:24:47 +0530
X-Gm-Features: AS18NWCA8sy6FOid-tm8JzQ-Zn3cmKVR4fBP0tgiOEGZGs3ZMDx0iiNjsjLofrk
Message-ID: <CAJE-K+Bhk+jqYpdqLxtTYQA7bCM9i_MNrAnSM+9Pcfu838gb3w@mail.gmail.com>
Subject: Re: [PATCH v1] doc: board: ti: am335x_evm: Add documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 11 Sep 2025 06:57:44 +0200
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

Hey Tom, could I get some feedback on how I can get my patch accepted?
I am a bit new to this, sorry.
-- 
Thanks,
Sidharth Seela
