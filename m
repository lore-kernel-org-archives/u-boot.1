Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B7606A32A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ncQQaIoT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QScLR9Q8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C847680D8F;
	Mon, 16 Nov 2026 15:53:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aP6iFn_LqjZg; Mon, 16 Nov 2026 15:53:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D247980D50
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794844408;
	b=W7FbkE8GcreGjOUYWNtXiKd4Vb0LypG7G4c8d42sY2q2cC35Lqb0ssbbYm44vSzGX9KP
	 ewEQJRm/HIVyogRetZzZmNUwsx9DoRTd8hlLrbMWvZXVKaleUnnb87JN6yCj4CpC93F8D
	 H5Mimed3wY5g5DF2PB9w5tBgizZ60c07SyCSqcaeTlFuBloAJb4ujWvyCiUtkiQWMb3Ir
	 a1Y801objpqFupcKJ6RDRAvrySqsjm4xsiyYcqO6bqtXpeKxtiksSNw/3huDe+Cb8UHxm
	 r8vV8v13RaekER2e/omIZ4MCuXw1ZtVgTZtQCU2aOflcyfOd/fptLXOUtCjewqmP+AQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794844408;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WoFF6RV5QfIRodSNqmJcmqpYiUNm7nr2hilP3fxUobE=;
	b=RufT8ZEQypg4Du5gJ2j51u36Ocgr9QLmz2TfLxtA17zZHnmNCQtAJbPseQAVn7a9lTP1
	 df7yzmtgsDtwpyBDNRUyUY+XE7jL4J07LHimXAH46cfB1gp4A9huGflaotBySvuDlj/R9
	 U3qBKvqrcLfrnCte46RMOqi0mA9gy32WJpriCxg+iSVoRw8tPS6ekx+UhtYP68XGg71w+
	 SaOZt+iygMTWW+2ARsWsLTDu+sz2JaIb0ND5xZf6A3MJFIrTbEoujneFEjrwDqh0thOeZ
	 vUWON8Uo3MERN3hjSDEzv1sUVPHr1t9YFdwVlxBuBq1+MLhF3MDaGk5CFUCWgWhj9wg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794844408;
	bh=WoFF6RV5QfIRodSNqmJcmqpYiUNm7nr2hilP3fxUobE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ncQQaIoTMyyCA2Wwyx1HCOtCXNvtN9yKtiDAZyez6eY5wiAtPWPg1cOiVMcn+IgQ5
	 5cc5bq28imU9vsNVMf95q6CdHHtxh0tGFrVwmUw0W31jb31oiDpgsP1VmGYoZGK//I
	 MEkBZ6nuhQB41lalwQf9JQ1OeNfdpAUoBT/ZCVBfv4JgkjflQKGCRHKn7TVTBseEwH
	 6Pc7ppdS7L0TBvvttoXKCtmvs1hu53hh0YUAUrgEwyJIqqS5A+o33meQWj/C/bXKGT
	 OLLC7FUpU9/ILAgfNa62kzvx79RYOw1OWLooPDvIjKzJqNm8AjSnAyxYUuOGw/rrzd
	 G1l/rpkSKzm3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D247980D50;
	Mon, 16 Nov 2026 15:53:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CF78169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 632FB607CE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTR9-TWiYpoj for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3313060782
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=jernej.skrabec@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=QScLR9Q8
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3313060782
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:53:24 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1458667f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794844403; x=1795449203;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WoFF6RV5QfIRodSNqmJcmqpYiUNm7nr2hilP3fxUobE=;
 b=QScLR9Q8FgILbU5qieVAqGBjZ50YIScuHMootL4aeX5Hr61LW0KTagAe1PNuuAaJ+P
 +Uv2fjCA3PD61ciY0lQnuYY9BWBK6UFeoQR1QeyH/l4rDyGRF0PW8q1sDa/BX6/s9/ee
 IOUkldGi0a8rHuq0vmMMrUuff3qTCcYCiREmB85hFAtquMmebYSAS5IvISqVtD9C6W+m
 ctLHar01NE2kCqNiTWrrFRCuF3ycWtwH0Vm8f4HWQRfS3xTCSiEzcQZE7TNaAvju94KX
 lHrBavwN5uNjqm7EhRd4xTChZ2xgrad654A/JShP/0G4TVd8irywPJ4QpPWKX8JmlTBU
 +JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794844403; x=1795449203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WoFF6RV5QfIRodSNqmJcmqpYiUNm7nr2hilP3fxUobE=;
 b=wJV0xUY+7TzTROYPVIJJaa0RPRds5zHvUJF1tgZ7sAsdeH7OWIi6CM0v9cxH3G/gPV
 sgy8oIIsvplalr4SVArd1CUQc5a8+fp5CFH8OV7Od+5Upbswan86BwwbO/f5viiXQ1w5
 4NiK4A60C+/kSDtoPNXqMs4wH/IjCrDslCVnL6wmjL2YkOUHLIwO2gBJ1ynS4jAqNQ7X
 H/K+KLEacd/eXG7YOkKX79wsX3BJr5QcKFee5MIB4WgJyk+QOlY+YBBJqovCAhK0FH1R
 XQsVhtGsuSiHOIJAfOTO9hwOwV9NfjizNXwOFQmKVvHygrnSjWqUXbXLKMlS/7A7P7FZ
 Dt2A==
X-Forwarded-Encrypted: i=1;
 AL+hErG81GhDRQjXvPP9+++kvIDOLqdut5NtHQibGmtxXFbJ0SbJFYmIhdhMCF2xLP+6izs2AMsYXTU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/x7ZZjT9HphHbEYHzIixbTYx9g9s41MtmUVZM1y+MhBU6ZnebT
 1W9bMxx7EFmxRDW9u0Z+kYbqsYrPVAyrRxSm/T6Mu1hjeTCEDfcmpIPa
X-Gm-Gg: AZFdTZcxibvoHuMmn00RbTRDzD8QtPAB23dZXrHa0VwQRbWJT2wDQY6glnN1d3MQoCb
 zDDweXx6dhM4YheAHbwigld+g6CxJ5RduDsZuSMKUaLUF+NP3tZMTgsB6EtKF5TAO66qi+H/jNS
 scJLmPXcC3UrOsvrKgUg9u7YZ7pboX+LYc5DXiSmMrH0dh/G6X6/16HICGgjY7/vf2OmkkQzkIy
 SmXflmm44KRH/+lezI8HIsX50Ul6o6fGUUyQEML43+yts25SbjJGzK9+VsaBYK733AfgMfTNIyv
 zwhswJLguHuGhxeUCM/vJvZpZxrWKWAjyLcD7iaTUxlFh9H67wlSyq4cjMxKMqYHhYr98K02vXz
 XhKWgqEc82N3q4i0r1mMuEjEbnwPO1/vVwqx42FlE/3YJZTzJHxvwgJUY6o7599D42RoIAlN8/2
 TLIrqLdH6TnubWOSe20G6Jy0qpE7sKLKL/EU1v3GOczD1bvaSASFSPh8rhx8qD2Af6x91R5WpDV
 UY9JXMRuOZSlqSGEXmBItGeYzhoI07cZTDdIJESLVtQuKESzXXLK1SE62VXpz48POOctlsziM5k
 5EH5DiZd76ecmrsOtI+xuZX2J7uEqxLQ7A1SpG1uWWW61Q7MShZagYmcW3PKjLElekmrfAhgpfC
 aMBe5mmdXbe0ciF1CeCkzYp7uLJe5M1H/zcbPMerTtWlQeeXwuF7T+t5Wvy1hSft+vUBqnKo2Z+
 tBvEALW9ls3Wa7KNAxXUqX1eSowRcbZ4D3g1FHB/2+Yre91XMA+rBlJLvaRWO/N9wQGbGpyPEC8
 x3ecZdJ/jddZK6JSu7+cEhTpLYGwYT/E2yAEiKT7IqXx3U=
X-Received: by 2002:a05:6000:2405:b0:492:20e0:f200 with SMTP id
 ffacd0b85a97d-49c71e3e0cbmr28524229f8f.14.1794844402861; 
 Mon, 16 Nov 2026 07:53:22 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60021375sm21455893f8f.29.2026.11.16.07.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:53:22 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: marek.vasut+usb@mailbox.org
Cc: trini@konsulko.com, u-boot@lists.u-boot-project.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2] usb: host: ohci/ehci: halt the controller before booting
 an OS
Date: Mon, 16 Nov 2026 16:53:19 +0100
Message-ID: <20261116155320.34570-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, OHCI is not stopped before OS starts booting. This means HCCA
is still being written into during OS boot. This may cause all sorts of
random and hard to catch errors, if same area is being used for some
other needs.

Mark OHCI and EHCI drivers with DM_FLAG_ACTIVE_DMA so remove hook stops
both controllers before handing over to the OS, same as xhci-dwc3.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- use DM_FLAG_ACTIVE_DMA instead of DM_FLAG_OS_PREPARE (Tom)

v1: https://lore.kernel.org/u-boot/20261112182838.2792025-1-jernej.skrabec@gmail.com/

 drivers/usb/host/ehci-generic.c | 2 +-
 drivers/usb/host/ohci-generic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
index 1ae3619ce25d..f5dd6e855be0 100644
--- a/drivers/usb/host/ehci-generic.c
+++ b/drivers/usb/host/ehci-generic.c
@@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) = {
 	.remove = ehci_usb_remove,
 	.ops	= &ehci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ehci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags	= DM_FLAG_ACTIVE_DMA | DM_FLAG_ALLOC_PRIV_DMA,
 };
diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
index cc44226f5e0b..b7b2a4eb4891 100644
--- a/drivers/usb/host/ohci-generic.c
+++ b/drivers/usb/host/ohci-generic.c
@@ -110,5 +110,5 @@ U_BOOT_DRIVER(ohci_generic) = {
 	.remove = ohci_usb_remove,
 	.ops	= &ohci_usb_ops,
 	.priv_auto	= sizeof(struct generic_ohci),
-	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
+	.flags	= DM_FLAG_ACTIVE_DMA | DM_FLAG_ALLOC_PRIV_DMA,
 };
-- 
2.43.0

