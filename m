Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA8D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84A38919A;
	Fri, 18 Oct 2024 01:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A9dy//2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFAE890F8; Fri, 18 Oct 2024 01:12:10 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29C588DD1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b147a2ff04so128654185a.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206727; x=1729811527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gyYov5xahHrl41maVcF3utsI/ZgGz814Z6miJo32VmA=;
 b=A9dy//2rKTbVQOD3swTy6o9mWrTlE2thnzTazCvT1si5cw7EawRw+Qy05j31XqDeBZ
 GulLJLXE9ArLYHU7QWG3GLlU/XauTUturqmjT+LjDz8l3Gmmx7G4HmsbWUr3peHaN34R
 R7ozdJ4wPGHkMUaT/rzu0byx4vpww1HX+74ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206727; x=1729811527;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyYov5xahHrl41maVcF3utsI/ZgGz814Z6miJo32VmA=;
 b=NqRCBQ3DHr0XZ0MqWAW37xrCe9bfeLqZmgWwwil0fZre9thLl3jYln3N1l7CHKvV4s
 TqzzCMf/L/KgM5q2+tjbfZfDHL/TO9MERB1u7aPe3BidHKRd9O2Xdc/7iR2o1RC2HSh5
 h3xCVml3MVofsF+ikglx21NR6NxpFLzLXuJu/voU9cp2tH1lMnBr1qZ3Tepeab8Jr/S6
 Vb8v7ep88GnYfNqGeR3KCbD8kV8T2H63Uo69bz/8LvZWOdHCi90SZvGhw2mMmwY/mXm8
 lFHaqfry0qr6TFzMJzcmP6vk+JwYDDKUY+EHKwX8fjN8v+ubbI0tI/WD+5+QXz5Q54iN
 djuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9fZDKMTqUsfJUHuVu/xTDwGCF+aAiG47x42bZnKk02e4cjVYleh0guk2kI4SvwSn9DlWVBOs=@lists.denx.de
X-Gm-Message-State: AOJu0YxPWHb0QHGkgH/nytsgB8KeA6B4zIdJzDCpDcEBppaBrx/oS/8A
 iscjMOVMMX4lA5kofAvREZNN0sM1difB3NmeOMk960AuITTcFQS2lXvlIQepWpfq+Hm92ACWHES
 +ySUYkaUULPO5rOtysx5EI4F07Pr+Zq6zibZv
X-Google-Smtp-Source: AGHT+IFsM68U2E96MebXjbnxuIMCOEytfaTgOTDQuSolBKwzB+XiGNe2Pnu/mJv2BINjUFEOxygix0w3zq95f/jKlUg=
X-Received: by 2002:a0c:fa52:0:b0:6cc:364f:fc32 with SMTP id
 6a1803df08f44-6cde15ec092mr6294126d6.32.1729206726943; Thu, 17 Oct 2024
 16:12:06 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:06 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240901222734.462334-3-sjg@chromium.org>
References: <20240901222734.462334-3-sjg@chromium.org>
 <20240901222734.462334-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:06 -0700
X-Google-Sender-Auth: sCXteeoeRkFGfw38N4l_HX_mjoM
Message-ID: <CAFLszTjCKa5NikYfT-f09C327rafhNNp=OPBTw80bTcme9a=NQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] bootstd: Avoid calling unavailable block functions
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
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

When BLK is not enabled but BOOTSTD is, some features of standard boot
become unavailable. Add a check for this in the only site that is
currently apparent.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

Applied to u-boot-dm, thanks!
