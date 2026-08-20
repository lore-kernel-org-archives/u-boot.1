Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC14CC5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 10:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94FE680989;
	Thu, 20 Aug 2026 10:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WSS32X624edr; Thu, 20 Aug 2026 10:25:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787221531;
	bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pf6sjufDM5o++tJQsQAJ7gx5GWkiACXw54aob51VLZmAuV9s6m2JkoWRbIKB6Bv30
	 xAuoKPckswAe4xE+vSR5zP+PzJL2TN352F1MnyGi+nJrRkgKEYtLMRmHAvkwjccA2r
	 dPY7dgpUoKslibz8A1tJMvOf4brzzyz4AoxsRvwZ1Ihyf/zwoDYxfLDEOcAs0rNGX8
	 I4a9vLn/3DJx3ueJL25+xFUQpWAKT+WXAmi4vpLu79hRk/mc051XOmB1tQPUaLm18a
	 MRJ2VMUKCTOv2SihyTqoAg8Oruw5NgM2KMOwSqAN88PkKvTeZt8wofw7r9MNVjeA77
	 Rwv+KUROtOTaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0BAB80C66;
	Thu, 20 Aug 2026 10:25:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DE19C1460
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBA2E60689
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52XOaJ1lWome for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 10:25:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=I0pgRKQp
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDA8C60656
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 10:25:27 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-499a4d1d7f1so17477195e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787221526; x=1787826326;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
 b=I0pgRKQp1J2HIOSejpsFGQ72h2TR1yC+a9QMXhliF/IpmmUIh8Et6k9LMCsCT7W4Zu
 mM+tmlIK1TP5is+abWI7FFjCe+8ryfSVK16seC+UqMUiENZ35lGXWmeG26/WSmxcnExu
 B+Yt3PQqOq7bacQUzTfKwwfe2wvjnROkEF2m4O5mK5CPWJlNKWON6DatGu6W25VRgBCc
 mRrOH6TryLx4OKQS2EIzTpiVOBqvODY7AiZcwVPJVB98rYXdWY3O1JL6KIoweIfi3NJ0
 rDDxfjuqNbp5WFdTeiJFgJ7/rMsjbhfoOSFFklVT99N37EV5f/ZMZzSLdvGxA+1Q1W59
 mk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787221526; x=1787826326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTqY5/xtQJJvReH3AzNyE1oeO6MHpRLoR64TzjmQwk0=;
 b=cerA6+r3qbmpcxWQy5l1Ir0Jl8AYBDk0XltOFZpeXZs/DNx4XbZ9kxd22XwtFnEiV9
 rwCPanOjaxTRKiFyLFjIw3SX2oQFzU/7626RvUpK0uxaFzrl/52USxCjxo8Scp1IjTCw
 UXg08f/oVb3ky0InfXGUIP8PLy0djvtZT69NHpoyKpSz53wJnP2q5M6S9y7SoN5LbOzC
 dtI/91ylM2Ua1K7eNbEpohluHhRLvMx+WdO2WAv/BdHynGhc86IIYQnkmeL1q5mEofxs
 hiBXnT4k55tmwoKWMA5rIe7ZPPB3G+TdqKqgcPHla087XxXEA9SdbOCy+KvHPCCrlpn3
 IKgg==
X-Forwarded-Encrypted: i=1;
 AHgh+Row7QyItHm9luzllQtLZ99eEWAoksQ+WturmuoH2eYu3HF9D1DG8IJ3b6PRuW8Rydzf7o5Lwqg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxKtykn/NK7v29uSjv5y1uLULux8yngnmfijQrNhmauv0q2nYch
 xsUNrob/02if6j9vzc/2Hk7kY/ppY5N4m6TM2iAyqGtADo+lqxuqdIGZ
X-Gm-Gg: AR+sD11cqQITiD8zSWt5QLOF6u9nLtyiZVNEdj5floD3uXanXiiT7TMMltkH2Pq8Jpr
 Pn64kgZXtZ/BBZltRGTph0/2ssBVXZJdEmedTcbZBv2lcsr0poMFCrX1M+st7PuGcInLlHXem35
 LF/DHOWga1GVfVvrIp4DbcZvmB64/EEA5Jg1t+DyXqpoUEu+uf1h8jWCJ0yyFDtN3WVzagl97hu
 nFmE2xwQkL8+HQIoo2o/QdkjMu431E9aZl9NA8h6PSULPAP3vHYZ9w+XVBHEuUGJKyrgjXQcGMD
 efIvmEI0/gDGyyIUQc4llG2/MAmJ1imBVPPU/NXw1k2r5QX0ZZH8hzXByRdzMObbynUh1/TA4g1
 Q3IY1wyG2kxF9/z/0iD/VRhxxcqkzdseUo2VaYEB9a83rIxS3nDZIwYnNbONliuTE21A8YX/4iZ
 0WLQV6kEr4Y5cY3Cf5t2hgpfsbK2aIUdJOHX2M79rCZRA6B7/9qLULseYmbg1TaxrNww==
X-Received: by 2002:a05:600c:1c22:b0:499:9240:9a1c with SMTP id
 5b1f17b1804b1-499aa1f5589mr192614825e9.15.1787221525596; 
 Thu, 20 Aug 2026 03:25:25 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e8b700sm134803915e9.6.2026.08.20.03.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:25:25 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v3 1/2] dm: core: read the device tree into plat data after
 pinctrl
Date: Thu, 20 Aug 2026 12:25:22 +0200
Message-ID: <20260820102523.1076815-2-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820102523.1076815-1-mehmet.fide@gmail.com>
References: <20260820102523.1076815-1-mehmet.fide@gmail.com>
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

device_probe() calls device_of_to_plat() before it applies the "default"
pinctrl state of the device, so a driver that acquires resources there
sees them undone by the pinctrl state that follows.

It has not always been that way. When the pinctrl uclass arrived in
commit d90a5a30dec1 ("pinctrl: add pin control uclass support") the
state was selected before ->ofdata_to_platdata() was called, and it
stayed that way for four years. Commit 29f7d05a347a ("dm: core: Move
ofdata_to_platdata() call earlier") then moved the call up so that the
platform data would be read before the device is probed, which is
reasonable in itself, but it also moved it above the pinctrl state,
which nothing asked for.

GPIOs are where this hurts. On most SoCs the direction of a pin lives in
the GPIO block, so a pinctrl state cannot disturb it, but on Vybrid the
output buffer enable is a bit of the pad register that pinctrl writes as
well. A fixed regulator asks for its enable GPIO in of_to_plat(), so the
pin is configured as an output and the pinctrl state of the same device
then turns it back into an input. The USB host VBUS regulator of a
Colibri VF50 is one of those: its pad reads 0x22ed once the regulator
has been probed, the value from the device tree, output buffer disabled,
and no USB device is ever powered.

Move the call back below the pinctrl step. That is also the order Linux
uses, and the order the board code of these boards used before the
driver model: set the pin muxing up first, then take the pin. The
pinctrl step itself cannot move up instead, because it relies on
DM_FLAG_ACTIVATED having been set to break the recursion described above
it.

Nothing between the two positions needs plat data: the parent probe, the
power domain and the pinctrl call all work off the device tree.

Tested with test/py on sandbox, before and after: 11 failed, 414 passed,
210 skipped, 1 xfailed, 20 errors, the same failures both times, all of
them from tools and images missing in my environment.

Tested on a Colibri VF50 V1.2A on an Iris carrier, U-Boot 2026.07 from
NAND: the pad of the VBUS pin reads 0x22ef after "usb start" instead of
0x22ed, a USB stick in the host port enumerates, and Linux still boots
with Ethernet, SD card and USB working.

Fixes: 29f7d05a347a ("dm: core: Move ofdata_to_platdata() call earlier")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/core/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 6024534ff93..ccdf0ab9220 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -500,10 +500,6 @@ int device_probe(struct udevice *dev)
 	drv = dev->driver;
 	assert(drv);
 
-	ret = device_of_to_plat(dev);
-	if (ret)
-		goto fail;
-
 	/* Ensure all parents are probed */
 	if (dev->parent) {
 		ret = device_probe(dev->parent);
@@ -552,6 +548,10 @@ int device_probe(struct udevice *dev)
 				  dev->name, ret, errno_str(ret));
 	}
 
+	ret = device_of_to_plat(dev);
+	if (ret)
+		goto fail;
+
 	if (CONFIG_IS_ENABLED(IOMMU) && dev->parent &&
 	    (device_get_uclass_id(dev) != UCLASS_IOMMU)) {
 		ret = dev_iommu_enable(dev);
-- 
2.54.0

