Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53ED1C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 07:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 185F380982;
	Thu, 20 Aug 2026 07:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VLbo7935X5Y2; Thu, 20 Aug 2026 07:15:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787210143;
	bh=PQjnLBoUZwUSpRAE3+AtGe2gan7wbp/+fD5Po9gMQ/8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lBly8C+lELD5agag+Cge00u4BHcD6LIbSUE49w1JJbf2PyaoBwFc1xMH8LcZ3/zLu
	 g8pJc1Y9XCZUQrB6ycjGB/zGNVXsyQVKUYMrgW6w0URZ5FPzd4H8HqfHn27hG5UEu7
	 JiXXleabKsq9pIM6IxdZ5Zg6+/uWT3WZbA8Eq5U5ispreoaSf2nhKhjhos4h83HLhM
	 WXeehtZS60K9V9kOzh82VUsE9olom9do7trmxQleHVOUEPFa/IVzEwoT9ZvfhFojIP
	 iLkOzp/9dyEADlyx2dTlV+ukmQmDlI6ohqFZUuIcI8vFWnFqmAiYOOAAeVw2jYTYAc
	 OoZy/40ZyxHfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FB97809A7;
	Thu, 20 Aug 2026 07:15:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 911552FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 837F1809A7
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDKThP9qhWj6 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 07:15:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=P8z4Xp4y
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EAC980965
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 07:15:40 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-495437bb891so5349325e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210138; x=1787814938;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PQjnLBoUZwUSpRAE3+AtGe2gan7wbp/+fD5Po9gMQ/8=;
 b=P8z4Xp4yUV8/LsP1Lj46CwWqzUq0J6CBqdf/gRx0sr6yai9yUfwlKsRqLiDgYJ7pNP
 /5Z6DQIQZJZKOb8y/QPW36hr4KzxsBwYW+9fhyPpQcW99VYY5ujgFcsg9iO5AeFvD4k0
 VR9et/B9BCDTuWU1NEmrLjuNw/butYHC7c7zHFPtWSmpJdoP9nsRCOuqzAsweGWVNomS
 y5pxo5OPUlT+kpt3z4peL/t9MbiPgtlbEKLyIcQNNozNvSxegP8wiEhQMbSLbJUIiBMK
 bZnHEXjiapRbj9EPycOdlonwPxLE5BQSyO0F09iIuvxlENDsfLI1cT3J/cQomS/JpZbK
 BTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210138; x=1787814938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PQjnLBoUZwUSpRAE3+AtGe2gan7wbp/+fD5Po9gMQ/8=;
 b=R8NfaseV4WQPQN3rgNxH0AdgMwAQckz5XJPfanEbRaHFkN4xWxudaruOcWfiVQKsS6
 htWSAPfYiz/x34G4S4p6ad5AY+lxTsErVxHGeIjZcT1G84yv1xxcmHzWeV1tPSpiHWEE
 aCQJIL5b+VZMy8eqVFLgWCTP+lINmxkC4YqGF+yv7627PELVaB/udZBJslfehUmXcMY8
 DT9O/dD/Ye/OGKIQW6vtEuEjqrnezcM1neGHOwS54QoPr4Zy8PkuwbnbYt0ZjASkBFea
 Nw+Jj2wJyeB/6/ohXf8UcOk4yxQ2Zd4r0kCsaQnUsVAP70tnUp7DY0fSgKIaC6SOfElo
 epFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYzsalVNvUuSUuNwZeFXm+esGgR5BRnv9ga5YPbJctjp0y9AjATItgy7H9nbvAUP0xxYAgUdM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YykjWUyrQ4U3eDj9voJKk6w8/4wXnTGs/8wNdoi7JTrRhPZnWfy
 Y/sGA0nlMMGn4PswL1a5kYW0uNfDyv67B5j7hdZdXOUcQpyCiFIttFRV
X-Gm-Gg: AR+sD12h/r3/kvG9ip5yCtlV5ro3uqzhDDMQfMN8nIjnGyJCQ/1zPZNrq/9E5ccciM6
 0VQOyI52ZZxRM+DAAP1TBxqY9DxLHUi6pg1z5mtNTLFytjtOn36LshLrnw36cFaDiUlIEPIF7v2
 EliTT7g+WXQPW/UM+W8Gz7Dkbye4HRh1zqgJ+VIrykHlAO4lA+Om0vCUFUhIcxPxCKJqzbNBciv
 UkM4NQtet3lUyMy45+tHVk21qK1k0UJ/gy4mgOyrYvs4RgzEcrHYtxfVk7no0NmgdCVIl/dXJ+J
 ciZtXb8WbGGf4P3X/ch1wkux2Szt3TkZe3toscalCJmeAPM/RqiqTxid+rqGaH4Mvcsih22FFVw
 H2I/BPEd+yBWNQGopHg/2nWsmViNz8TjxEAf2yTvYHfLn9m7k8SwwwBMXs8BSeCmTdk0bnf6L15
 KdcqYMNWKXn2KgE+cm3hkWa0N6aBbW9NEClldEEzbhSZAf94rR0VRvu8kAxttUx6Y8IRdYQhMUz
 Xa/
X-Received: by 2002:a05:600c:810a:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-499b06a5900mr34922775e9.1.1787210138124; 
 Thu, 20 Aug 2026 00:15:38 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2b23a00sm19197705e9.3.2026.08.20.00.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:15:37 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 0/2] vf610: make the USB host port usable
Date: Thu, 20 Aug 2026 09:15:34 +0200
Message-ID: <20260820071536.1036898-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

A device plugged into the host port of a Colibri VF50 or VF61 carrier is
never found, for two reasons.

The pin that switches VBUS never becomes an output: device_probe() reads
the device tree into plat data before it applies the pinctrl state, so
the fixed regulator asks for its GPIO first and the pinctrl state of the
same device then rewrites the pad. Harmless on most SoCs, where the
direction lives in the GPIO block, but on Vybrid the output buffer
enable is a bit of that pad. Patch 1 moves the call back below the
pinctrl step, where it was until 2019. Unchanged since v1.

Patch 2 makes the driver enable the vbus-supply of its port. In v1 it
guarded the regulator calls with CONFIG_IS_ENABLED(DM_REGULATOR) and a
NULL check; as Marek pointed out both are unnecessary, the calls return
-ENOSYS themselves, so it now looks like the adc-uclass example he gave.

Patch 2 applies on top of

  https://lore.kernel.org/u-boot/20260820071511.1036506-1-mehmet.fide@gmail.com/

Testing. test/py on sandbox, before and after patch 1: 11 failed, 414
passed, 210 skipped, 1 xfailed, 20 errors, the same failures both times.

On a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from NAND:
"usb start" finds a USB stick, its partition table and blocks read back,
the pad of the VBUS pin reads 0x22ef instead of 0x22ed, and Linux still
boots with Ethernet, SD card and USB working.

v1: https://lore.kernel.org/u-boot/20260819143543.427396-1-mehmet.fide@gmail.com/

Mehmet Fide (2):
  dm: core: read the device tree into plat data after pinctrl
  usb: ehci-vf: enable the vbus supply of the port

 drivers/core/device.c      |  8 ++++----
 drivers/usb/host/ehci-vf.c | 25 ++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.54.0

