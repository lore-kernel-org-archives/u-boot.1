Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD6ECCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 18:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 179C6408EB;
	Sat, 17 Oct 2026 18:46:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZ7ZXzXw01op; Sat, 17 Oct 2026 18:46:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ED9A4408F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792262793;
	b=fALkTbafWeXC7s/e84n0ESV46E7zEEzIAvGRFlXywRppSE0qJrxSWztnCgav0R0r3+tl
	 iHb/PxJvofznoOI25I2Mip2nGFERQRNEcvtuJ/qsvxd5DyCP1UMEEyRPHmO0mXamYQ5f4
	 eRSyCI7TdVrwleSuXcq18SJjNNgJs7jEGavO4LRnmHHPOxJ/XX389biZByKt5aUdHONPp
	 FSpO7hqBVHIGD86itRYep5TiPRUs9JCDHEzekSXknk1NZgd/txN2yaAYIrzOZfcgf72rz
	 JuqwwR2r2YE65RfhXhArDnOWB1rOsNIoKceSXkym8n8A1p2BiaFH2doBo0IGsEfON6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792262793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sDRm6GaPm/KO+PtErSfzlDIWb0BtyfLMU4My/pTkJYE=;
	b=N4glJ47wOmxe08yi4ZTppIpn+i37VNRmhozZITnZB+Aes6v62+2RGwXoaDA9dc6KIWNz
	 Wn7jSvbtjAb9W6T+Sw0zxiuz5k2AaoB7PWQInKQ+TMOD2YWxQAj+jfjTeKZxS5DpAv6eW
	 /FGPoNwIAt74DjXeTviDFrh8Cxi3PfAzJ7ugcnzQ9lOZgR/R2uz75bLC2W2iKY5WhZe6H
	 pZi0SRovdZFiKYVwcuii6ezGXwegfduKiqY+tyDsXRIm9WSpawMDVByB8i0zj4pu+zOVO
	 Y//+vyXpOuKMicLk4BxQSKM67CZWgjB6mMzsyOTEKuMA9likcKPb7huKCOASHgy951A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QF8Yrmdf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792262793;
	bh=sDRm6GaPm/KO+PtErSfzlDIWb0BtyfLMU4My/pTkJYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IDJi1Wl1WjLZnAse6nRaYCC/2iVx7xca9fj8vWdH/M2MsQZ2d5tsFVoV+AISGfwgX
	 XcGTn7AmNTh9KUHlbtzk4pHgJNothxLVSnCsFMiT4YxxflmrM5194VwrQlxJ9/OrKs
	 sr+SYwf2scxTxsofEWBw265VJgJhBWv2Qu5153Q6UbxaWsruKGDCynhOBTm2hRL2sQ
	 yrFu3dVLD4veMhd6+zwT+4LqgKQxk6+N2LM+MHsWDUZD4PXCq6oMAPDQg0WHTiZjns
	 +PxD0wOGtmSvlt25tcHx/Ey+4ySo/Pk7Q1vsTIftruYn0p2R8rWonhy+NNS6Pa7z0A
	 v9U4mzdoJeGog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED9A4408F8;
	Sat, 17 Oct 2026 18:46:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91768977
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83651408F8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tl0Fv3hjMbFl for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 18:46:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74C78408EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792262790;
 b=KygObRlqhPqegGGrZ2Uj+5SM/+Ee9fqaBTpl02p3BHAitgxqTIOMhXnsTQXjvAEY6O/v
 ljD7r9VMh/zRu5IDx8//FedMLju42ovjV3XrcKminBCtYZhwC+O25ePIOVyXT+/HbZy2q
 vfLDQJ6A0CqIo/vL5nWRe4AAMC6HHs6wABLLX00WEf63A6npsujqcVCkGKwZ3trJcO1Kg
 Fbj2rQcQ2tYNJ+LxT6odixJBdur8MtmRslyoJUyVo7jgCAi/6iHu7gu4bVDKBTQ6j1V9s
 c7qgiAOP4upLo4Z/EFxSEQHOlkbeCqO5UUH0SjwMfLGEiGVn47jlxBYJwRP2OtLvgGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792262790;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sDRm6GaPm/KO+PtErSfzlDIWb0BtyfLMU4My/pTkJYE=;
 b=X/dkOK/y1lH7JulOnxv2QUnQXrS8Dhs+jzWe1h6tyLS9lKDv/+AhgJe2HT5sYgT/oaXV
 WDICoRA47lE9BOm8PFq1CG3Evfxq4+jEVDghalms6nurSxd5OHvg/cCZ+1I2UEeFATYH/
 A/l4YhCz/Ne85eCAlwxEsol7OcHCUmCMjVd1AGRsFDyxsS4DRzHqQklBL4WQ+kxSenXJr
 09Yr39eo4/tUOsZvAbNM+Q9IfQBaazlfAa4pEbEdUvFPa5ootML+/YbhZoZxtlliE4z5O
 9udmJgtbqSvgySazNBuz9g0GGaVu8yIbF+Kv8dl4kzloOp1qljow55MbiCrd5fdJNwQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QF8Yrmdf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QF8Yrmdf
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74C78408EB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:29 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-3514b90bb89so2397673eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792262789; x=1792867589;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sDRm6GaPm/KO+PtErSfzlDIWb0BtyfLMU4My/pTkJYE=;
 b=QF8Yrmdf2WVP35rPWDUr5lJLxxm40BiTFEi7Y9TIgfve8lKVnIOx0uVBwsHfumwe5b
 rloQ59Z7C+kGmxsD1/zC8u/HEb7m+yN2tPjCVCFbcGOLM+ZmuP/2VEsLYEaZ4EkKTkgR
 6tMb0OqeKbbjoGTosKSSk6KSXsvQ1q4PRJEKN0anlpzNWKQo5diNjpOJnq27C/akBUXr
 I/1gyqgO/1iw/+KLU+DA1xZtzC4+frYV3tw8N94p1uSywbue4ql1ySTI+4XQNYi35Zyj
 cR4LBGmF6vyw5p30EA93dGAui38cQwlSGFerHxRDDVbdqmA7wBJQ5D72CWD8wRFsoyb6
 jw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792262789; x=1792867589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDRm6GaPm/KO+PtErSfzlDIWb0BtyfLMU4My/pTkJYE=;
 b=1o8KNYhoJVnni5DPDrQTl48NGuv+/GNc+y3y55trwOvQp3xsi9WmRRXREnl1buWTT/
 oLXn+KqRWw48w5EIr8MxwAHtG4gXlWuQ9rDKFku5Ipguas1EQfFSO+TWpiMdjK49AZGd
 NOt5Y1ri/+v7fc3gKMbN/p8fAXcTMi51FhYjLfDenaAh4bSuhFB1KxuUoWqWQTmbTGgI
 u+HFq68XvK1w3bsmf4cHCFCF5iUANl4gPCv1nTUXyMUhS9w2ISkStUl6K4FlHOMR6KGr
 AzG+2MFcyet6sJveXp3z+7yPJlJNYAQNTu8lvDJKmz+EyL0VYiXxJw1ftxLBNtH4Dqdy
 kwbQ==
X-Gm-Message-State: AFq9FYIN25kAuqAr2tPxTg7sPM6XgaxF7XqN/MuMLkQwF6epbgxWF/3A
 /hjkgsnZgoeJzjMeMLjTNxG/Xn8W/nMBRwxnd0Pi4YVgH94hzWF6x4jPX8qHnvJG
X-Gm-Gg: AYBFou3cxjUFd63cS5NyyfW5A/0muKXlwZZ8pUCyWv+77RUaD1UcyGiauDvqqchGFnS
 1zGXhm1Ia8zJdpU24U23El3HSWv52Hi2yZmgavvKl86bFcDcr1mCeP6AXFCLnbofpVAK93qLJrV
 cEVO8G0K1Gtmoti6iFdbXfXGcQoYoQPvCCrLDd5xJpqrGKowkPKYJBYPIp7G0hHZzdCNC9wtJtu
 Sq9O8xJMtoyMj46vGrr+QXkz93L+ZlgGu7UmKbydHlDYEt62B9PqGOyFVC7SniTWSnIlrZESFHo
 PSGHBOHJo29ji+UdtHiadNiU/FAnVweIN86onkN8LUFKqN/nT0QakoYMScCIgxJhwX93JGEEqkq
 Dfq5xmMX42TiXo+/YwiJsjQXgb8MYQse/1AemOlD9x2yEFSUp3vE6xUqHDDigIsY5cK1kMdJAPY
 cth7Uad4zme9ITDi64wODTn4Ij/oVyqPhtk1GzsiHmV+D0TfGg/DOVoxN95kJEdryxvEB6X9B5N
 z54EfXYcZIL4JYuiKE6VFY0PFytv8zpajyq8fBIGIMh3WyuL8XNJ6QwKJL2547DPfShy20KWQVM
 jpe3+HfdQCrU4uWVrrDCqDlXuq2L05xtaRYdiUQ/9xI0Z8P/kO0spg==
X-Received: by 2002:a05:701b:2618:b0:143:297c:276c with SMTP id
 a92af1059eb24-18513107afdmr4644225c88.33.1792262788764; 
 Sat, 17 Oct 2026 11:46:28 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b1722asm17228401c88.1.2026.10.17.11.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 11:46:27 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
Date: Sun, 18 Oct 2026 02:46:18 +0800
Message-ID: <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
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

Add a driver for the virtio RTC device (virtio device ID 17), which
QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.

The device exposes its clocks through a request virtqueue. As the
virtqueue must not be used before the virtio uclass sets DRIVER_OK,
which happens after probe(), the first read looks for the clock: it
asks for the number of clocks with VIRTIO_RTC_REQ_CFG and queries the
type of each with VIRTIO_RTC_REQ_CLOCK_CAP. Reading the time sends a
VIRTIO_RTC_REQ_READ for the chosen clock and converts the nanoseconds
since the epoch with rtc_to_tm(). Each request gives up with
-ETIMEDOUT if the device does not answer within a second, as virtio_9p
does. The clocks are read-only, so there is no set operation, and the
optional alarm feature is not negotiated.

Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock.
Linux registers an RTC class device only for such a clock and skips
VIRTIO_RTC_CLOCK_UTC and VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED, which may
step on leap seconds. QEMU, however, exposes a single clock of type
VIRTIO_RTC_CLOCK_UTC, so following Linux strictly would leave U-Boot
without an RTC there. If no clock smears leap seconds, the driver
therefore falls back to the first UTC or maybe-smeared UTC clock. A
leap second step matters little to U-Boot, which only reads the time.

Like Linux, the driver stops looking for a clock as soon as a request
fails. After a timeout the request is still on the virtqueue, so its
late response could be taken for that of a later request.

VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
VIRTIO_RNG does for DM_RNG.

If none of the clocks is UTC, the driver remembers it and fails later
reads with -ENODEV at once, as the set of clocks never changes.

Tested with QEMU v11.1.2 on qemu-riscv64 over both PCI and MMIO.
Sandbox tests, which emulate the device, follow later in this series.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
Changes in v3:
- Give up on a request after one second instead of polling forever
  (Kuan-Wei)
- Remember that no clock is UTC, so that later reads fail at once
  (Simon)
- Expand the VIRTIO_RTC help text (Simon)
- Drop __packed from the message structs, which are naturally aligned
  (Kuan-Wei)
- Prefer a VIRTIO_RTC_CLOCK_UTC_SMEARED clock as Linux does, fall back
  to the first other UTC clock, and explain why in the commit message
  (Kuan-Wei)
- Stop looking for a clock as soon as a request fails, as Linux does
  (Kuan-Wei)
- Mention in the commit message that sandbox tests follow (Simon)

Changes in v2:
- Look for the UTC clock on the first virtio_rtc_get() instead of in
  probe(), as the virtqueue must not be used before DRIVER_OK (Bin)

 drivers/virtio/Kconfig         |  11 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_rtc.c    | 249 +++++++++++++++++++++++++++++++++
 include/virtio.h               |   4 +-
 5 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_rtc.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 55b444280..48ab669f3 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -84,4 +84,15 @@ config VIRTIO_9P
 	help
 	  This enables the 9P transport driver over virtio.
 	  It can be used with QEMU based targets.
+
+config VIRTIO_RTC
+	bool "virtio RTC driver"
+	depends on DM_RTC
+	depends on VIRTIO
+	default y
+	help
+	  This enables the virtio RTC driver, which reads the UTC clock
+	  exposed by a virtio RTC device. QEMU v11.1.0 or later provides
+	  it as virtio-rtc-pci and virtio-rtc-device. The clocks are
+	  read-only, so the time cannot be set.
 endmenu
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 6e7bcfc8e..ddb5ce4eb 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
 obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
+obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c163b2fd7..c6cf55922 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
 	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
+	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
new file mode 100644
index 000000000..806abe237
--- /dev/null
+++ b/drivers/virtio/virtio_rtc.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+ *
+ * Driver for the virtio RTC device (virtio device ID 17). The device
+ * exposes one or more read-only clocks through a request virtqueue; this
+ * driver reads a UTC clock, preferring one which smears leap seconds, and
+ * reports it through the RTC uclass.
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <log.h>
+#include <rtc.h>
+#include <time.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <linux/types.h>
+
+#define VIRTIO_RTC_TIMEOUT_MS		1000
+
+#define VIRTIO_RTC_REQ_READ		0x0001
+#define VIRTIO_RTC_REQ_CFG		0x1000
+#define VIRTIO_RTC_REQ_CLOCK_CAP	0x1001
+
+#define VIRTIO_RTC_S_OK			0
+
+#define VIRTIO_RTC_CLOCK_UTC			0
+#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
+#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
+
+struct virtio_rtc_req_head {
+	__le16 msg_type;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_head {
+	u8 status;
+	u8 reserved[7];
+};
+
+/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
+struct virtio_rtc_req_clock {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	__le64 clock_reading;
+};
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	__le16 num_clocks;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+	u8 type;
+	u8 leap_second_smearing;
+	u8 flags;
+	u8 reserved[5];
+};
+
+struct virtio_rtc_priv {
+	struct virtqueue *vq;
+	u16 clock_id;
+	bool clock_found;
+	bool no_utc_clock;
+};
+
+static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_len,
+			   void *resp, size_t resp_len)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_resp_head *head = resp;
+	struct virtio_sg req_sg = { req, req_len };
+	struct virtio_sg resp_sg = { resp, resp_len };
+	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
+	unsigned int len;
+	ulong start;
+	int ret;
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(priv->vq);
+
+	start = get_timer(0);
+	while (!virtqueue_get_buf(priv->vq, &len)) {
+		if (get_timer(start) > VIRTIO_RTC_TIMEOUT_MS)
+			return -ETIMEDOUT;
+	}
+
+	if (len < sizeof(*head) || head->status != VIRTIO_RTC_S_OK)
+		return -EIO;
+
+	if (len < resp_len)
+		return -EPROTO;
+
+	return 0;
+}
+
+static bool virtio_rtc_is_utc(u8 type)
+{
+	return type == VIRTIO_RTC_CLOCK_UTC ||
+	       type == VIRTIO_RTC_CLOCK_UTC_SMEARED ||
+	       type == VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;
+}
+
+static int virtio_rtc_find_utc_clock(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_head cfg_req = {
+		.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CFG),
+	};
+	struct virtio_rtc_resp_cfg cfg = {};
+	u16 num_clocks, id, utc_id = 0;
+	bool utc_found = false;
+	int ret;
+
+	ret = virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, sizeof(cfg));
+	if (ret)
+		return ret;
+
+	num_clocks = le16_to_cpu(cfg.num_clocks);
+	for (id = 0; id < num_clocks; id++) {
+		struct virtio_rtc_req_clock req = {
+			.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CLOCK_CAP),
+			.clock_id = cpu_to_le16(id),
+		};
+		struct virtio_rtc_resp_clock_cap cap = {};
+
+		/*
+		 * Give up on any error: after a timeout the request is still
+		 * on the virtqueue, so a later response could be mismatched.
+		 */
+		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
+		if (ret)
+			return ret;
+
+		/*
+		 * Like Linux, prefer a clock which smears leap seconds. Unlike
+		 * Linux, fall back to the first other UTC clock, since that is
+		 * the only kind of clock that QEMU provides.
+		 */
+		if (cap.type == VIRTIO_RTC_CLOCK_UTC_SMEARED) {
+			utc_id = id;
+			utc_found = true;
+			break;
+		}
+
+		if (!utc_found && virtio_rtc_is_utc(cap.type)) {
+			utc_id = id;
+			utc_found = true;
+		}
+	}
+
+	/* The set of clocks is fixed, so remember that none of them is UTC */
+	if (!utc_found) {
+		priv->no_utc_clock = true;
+		return -ENODEV;
+	}
+
+	priv->clock_id = utc_id;
+	priv->clock_found = true;
+
+	return 0;
+}
+
+static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_clock req = {
+		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
+	};
+	struct virtio_rtc_resp_read resp = {};
+	u64 now;
+	int ret;
+
+	/*
+	 * The virtqueue must not be used before DRIVER_OK, which the virtio
+	 * uclass sets only after probe(), so look for the clock on first use.
+	 */
+	if (priv->no_utc_clock)
+		return -ENODEV;
+
+	if (!priv->clock_found) {
+		ret = virtio_rtc_find_utc_clock(dev);
+		if (ret)
+			return ret;
+	}
+
+	req.clock_id = cpu_to_le16(priv->clock_id);
+
+	ret = virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(resp));
+	if (ret)
+		return ret;
+
+	now = le64_to_cpu(resp.clock_reading);
+	do_div(now, 1000000000U);
+	rtc_to_tm(now, time);
+
+	return 0;
+}
+
+static int virtio_rtc_bind(struct udevice *dev)
+{
+	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
+
+	/* The alarm feature is not supported */
+	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
+
+	return 0;
+}
+
+static int virtio_rtc_probe(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = virtio_find_vqs(dev, 1, &priv->vq);
+	if (ret < 0) {
+		debug("%s: virtio_find_vqs failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct rtc_ops virtio_rtc_ops = {
+	.get	= virtio_rtc_get,
+};
+
+U_BOOT_DRIVER(virtio_rtc) = {
+	.name	= VIRTIO_RTC_DRV_NAME,
+	.id	= UCLASS_RTC,
+	.bind	= virtio_rtc_bind,
+	.probe	= virtio_rtc_probe,
+	.remove	= virtio_reset,
+	.ops	= &virtio_rtc_ops,
+	.priv_auto	= sizeof(struct virtio_rtc_priv),
+	.flags	= DM_FLAG_ACTIVE_DMA,
+};
diff --git a/include/virtio.h b/include/virtio.h
index b981eead5..95069a2de 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -32,12 +32,14 @@
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
 #define VIRTIO_ID_9P		9 /* virtio 9p */
-#define VIRTIO_ID_MAX_NUM	10
+#define VIRTIO_ID_CLOCK		17 /* virtio clock/timer (rtc) */
+#define VIRTIO_ID_MAX_NUM	18
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
 #define VIRTIO_9P_DRV_NAME	"virtio-9p"
+#define VIRTIO_RTC_DRV_NAME	"virtio-rtc"
 
 /* Feature bits for virtio 9P */
 #define VIRTIO_9P_MOUNT_TAG	0
-- 
2.43.0

