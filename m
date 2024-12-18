Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C91E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F6B80241;
	Wed, 18 Dec 2024 15:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bd+eYz47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B2680283; Wed, 18 Dec 2024 15:14:45 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6D28022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a68480164so1061057166b.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734531281; x=1735136081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aEdW+CB1uK3lVzJFVhDcH1F6wQaiRvEqgzuFnEj5v5A=;
 b=bd+eYz47VrMW9cOJCfqjJC8GulgXrLd2tC4i283ysQQuSgWfhJrIv/+yspnw0FYGCE
 +vnloFXrzU2HJyMn9vbQf7/QJSK43IAnfcSnCnjQWkzhrcCxVysFo7tge4ixKJfzoMDS
 nZaLbdDdzTh6JyZzm/o2/C5TtK6wOksPYhE0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734531281; x=1735136081;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aEdW+CB1uK3lVzJFVhDcH1F6wQaiRvEqgzuFnEj5v5A=;
 b=vxs7BgCBKXZbEmQ6g+d1OAMRZQdBVtSszkqRIqBLL3wAs+2u2ivJex0nA5TYCEB+0v
 uwW0l3MG7SaJogXuItynGoDC6kCET2QwjQgAJdjoBpLb7SpFAEp3kkZQVP7h2bA6ivAc
 62xW/rBn4thLK1nuw/QXbAW92bBQ5AzEBGhdIeHw6D7+i9J2IJ0iMWmShKoFC4CseTPQ
 v/q7YsgB+IcWHPiR84Kz6DJaUAh7/yDAR0xo9Kmdp/Hxj9UXyUozPDbo/L8n1ccxKzTw
 5ia1erXmFcZPNWlTqQxOAdUp/IRqkiyIyB5DZrxdDT9gOfFchpyEqB3Jf99MuYJaWpVh
 9n2Q==
X-Gm-Message-State: AOJu0Yzl7kbx9CJ82JZ1OHsOosONePirabkYGTeI+9kd2CLwy7j+zNPL
 UnHQ2H4kCZNxlfLH+7wc95NMJ/soKHNu9KP0ZEhsqYWqs18noLW+CfhtF+E/0je66WfIZVdILkZ
 HPNTRJoBBCXAf3qJhkELAdIbWOT80uxQrdRIDdxYD6oPYBA4Rig==
X-Gm-Gg: ASbGnct8bQbUkBi0eJ5cK58iIRG40lj6fjSYtsIvEvGn2TWmRdc+ysepha+fQBjw7ae
 7JGwEfC9aEZXejg9vOjYaLuww+Odt7G+fJ+GBVrg=
X-Google-Smtp-Source: AGHT+IFU0zMIVF5eybnamupVjexkID2GH0HfWf7E4WvVRPaFaNoIBdbB0BAxQ2ahb7kfmjClgBbeL194DWXh7oUTipg=
X-Received: by 2002:a17:907:708:b0:aab:736c:558 with SMTP id
 a640c23a62f3a-aabf4907a08mr332885866b.55.1734531281479; Wed, 18 Dec 2024
 06:14:41 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Dec 2024 07:14:30 -0700
Message-ID: <CAFLszTiU0K2Wc0iOvWnnK21H+JiGbswc1avqrS9BP8wXF1uV9g@mail.gmail.com>
Subject: cm_fx6 booting
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
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

Hi,

I have a Compulab Utilite cm_fx6 in my lab but I am not sure how to
make it boot.

I am using:

dd if=u-boot-with-spl.imx of=/dev/sdt bs=1K seek=1

It does seem to detect an image on the mmc (since it doesn't boot from
SPI flash), but SPL and U-Boot output nothing.

Does anyone have any ideas? Perhaps this device is a bit old.

Thanks,
Simon
