Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52663C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336F08786B;
	Wed, 13 Dec 2023 21:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fhpsuM6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2689587863; Wed, 13 Dec 2023 21:39:15 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E3B487864
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3363397426eso2068780f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CXAXMmOaqymM2OY1vcAqeEa97tpfZU/mU066IPZiSks=;
 b=fhpsuM6MAr8FAapAK6nzHkQcCS1CFZWSoKaMi9apd/+GQ9zsWwUcCXE96Cw35MqMBi
 MW8WxYs0LpqFikWbYZW3t+pgZplQzbZWja5gDBQDq75pmue/FcldxR1yuca4r0b3+6IF
 eGV7NDdKRIUSMpEgr9dyudX22tBiRYzOtUQZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CXAXMmOaqymM2OY1vcAqeEa97tpfZU/mU066IPZiSks=;
 b=OTV+8nsaaRLxAuVJ+HLxniCO2oROB9TVJHSR6VY+hOaWQiQe8M2D6PoYiStrKTn7LZ
 QSqEq4CZ/mDt/JRZrsRN1DyjCWa1+5CtW/mzm8l1khIVJ/hy3Ut0G8Wu1MHmzaRItiS7
 FaXao3DUWf70pjLWcbrcDdrNgV4LYjlaTDqyiylOA01R8AmsqODUuPbYST0AGETsX5O7
 dsABZjZIz1HtdPMxJh7vqugVhy5kMbUrQuJAnP4LMGCiJdE5KJ9AuzCEYHPDxp2Wxrqw
 Qot0I7/y//FSuHOKew7cgk9Qbv/Sq96SLNVHFaO2zN3Af11MXWJz4BtaDWjHori8/ipM
 K3aA==
X-Gm-Message-State: AOJu0YwZ9EjqV6Ic/iyo9hF2V5UFzXXTLpe3VGNII/4e4HnF0zQGKUFa
 og197KYh3sbC4u3vnVAuNb9C2YqB3RgwMQODnLiQ/A==
X-Google-Smtp-Source: AGHT+IEhMq5OtEKY2OJdaWda8L3jFPd1QvYhdsyQQY3xrf2qrPIn4Idi0kSHASAZDat/uCsJ9uTapXLhHmIda7wt+Pw=
X-Received: by 2002:a05:600c:354e:b0:40b:5e21:dd49 with SMTP id
 i14-20020a05600c354e00b0040b5e21dd49mr4679723wmq.119.1702499952349; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:09 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119153611.639252-5-sjg@chromium.org>
References: <20231119153611.639252-5-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:09 -0800
X-Google-Sender-Auth: -Ea6REdON9BfJE97PmP3WEk0F30
Message-ID: <CAPnjgZ0C2qwKZ-1=iCNr16OP4Xju7XYGyUzdn7jQtKJiZSK-8Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] u_boot_pylib: Correct files used for pip release
To: Simon Glass <sjg@chromium.org>
Cc: Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

The files list is incorrect and dates from a time when the script was
run from a different directory. Update it to match all the other tools.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/pyproject.toml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
