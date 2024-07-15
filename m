Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483D5C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019E68889B;
	Mon, 15 Jul 2024 15:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T/xLQIOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A364488898; Mon, 15 Jul 2024 15:31:30 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29BFF8889C
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b5f128b18bso23790636d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050287; x=1721655087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HQpf9s39j7mc3YvelKFp2b7kOLOy+i0GrR+uJ/yYIu0=;
 b=T/xLQIOHBH0mxvstU5502kqeUgulx1VDh/bUy+VbqXMKykIws+lNrkwYSleBBOManS
 rWhE8awJMXGAM8AtEdw8Qs9wAkZYzfckJCml08k4vhBx7V4qdtCDdTlMkY3fV+Z3w/en
 hBP5Ihr0kmDX9E72/vJrNvtDJv8WNDtk9KbDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050287; x=1721655087;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQpf9s39j7mc3YvelKFp2b7kOLOy+i0GrR+uJ/yYIu0=;
 b=Thj3ciwTbUdr5Euf/aQscb/wLKFbR4U/UlZ8riVM+rgyKN1v3p+EbfYVtQm5qSF53f
 z2KiIf4R3JHyCdB0dMjyTYvQgcenALSBet+BbsqcZPuRSugHTlMKwRA29oDinvRpY1ai
 DI+h5EepbZxB06RTFOH7/vEtANFG5spfgTXqp5rMQr6UqZlte91vcSm+TI9nJ5hzwNvv
 BOyiI/NhQIsC4IHTiM1yvqA/4bATfQHTFCrAwj+1Lpp4EsJX5KZvshewkg8ryAC8/Beu
 sNP+lE3NlETItjPfaE09H2gHhUvj12x4COjBvSgCCi38fqRfAmMPUF7wQiQUli+pu90k
 HBIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU12SNbpKd96J48b293zaLk7N8Tfa0ENsLzKu3hzUmPkB3RTCJ15tBeru02QzBac8Gyr+rX1UOFzv9WUGvo/tBpoCLWUA==
X-Gm-Message-State: AOJu0Yx8Kl8RmsERByEVew7QqvuGQRzK/vbMZ0NMXlYiYI/UWh4OdHCg
 iuaTIgRK9IRSdJ2Nequc55CnsY6ZMbQVgYBi2uB/WRxpRD8vYx6dz6TDb1dKzDFHD+4yfCGpRXi
 j+zAOrdMBSVhArAr87bj7eySn7EbxTbIfeLJlbrUmKwUN1M8=
X-Google-Smtp-Source: AGHT+IEpxLnvuoVUMUyuqBYdH8P3UNMSmYs0cmhSlxOOXjByIS7ZsgGXx2CfcEYTFASfpT4GsyTYYX8K5rXChbzFPhM=
X-Received: by 2002:a05:6214:501c:b0:6b5:e6b3:72fd with SMTP id
 6a1803df08f44-6b61bf61768mr253936926d6.29.1721050287107; Mon, 15 Jul 2024
 06:31:27 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 08:31:26 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-12-sjg@chromium.org>
References: <20240623175515.1466908-12-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 08:31:26 -0500
X-Google-Sender-Auth: LNe56NFQQhYy1Kuhc00mE5pS5Mk
Message-ID: <CAFLszTgs-FqduQ9S966k2Pkb+bFTGXAaEkte+7MYEGfbf4259A@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] buildman: Avoid rebuilding when --mrproper is
 used
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

When this flag is enabled, 'make mrproper' is always used when
reconfiguring, so there is no point in doing it again.

Update this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
