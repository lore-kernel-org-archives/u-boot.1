Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE97E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AAB186E11;
	Sat,  7 Oct 2023 23:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QANrZmBp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CSMZZ/c2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3D086977; Sat,  7 Oct 2023 23:41:30 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB0386D3F
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 23:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S2zJK10Mbz9snn;
 Sat,  7 Oct 2023 23:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRu67jTGfIMlcAdLgXrYyMI7jKYC6HLWuDAUUpsY3Mo=;
 b=QANrZmBpAbnMwY5OVaQHMyGcGe7OTaWZCyJ4w/wOdMonFr3fW7o7mYrdWojZb1lzJayOjl
 brb5428frs0ZCJJ+A9KARVYCkf0X7gyyuX7X8rI9OW8VDz3by0U4Lqv6Ilcc3GHk1AT7pe
 ScaPb/LKthzukfUi6RVt0P/YbpxeobHVzW1miqkwR4IflvDLOvWmh0kmlHu3IGCI8qrEQW
 AInnH0JyP/p+vHzs3jmdrIoKnv3Ru5yPFaqclKxbSuZ6sIa1r9vQyGnYO3ccdUQnsTc+6M
 ENJVSUeArT0Lbo32/txmuid1u/y9GZ4qsKzn9HuUX4CTEu9ASvHhWZPv1IuMlw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696714879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRu67jTGfIMlcAdLgXrYyMI7jKYC6HLWuDAUUpsY3Mo=;
 b=CSMZZ/c2H1kOW51phxA+cojKdf0Us8G7bl0/cGnOmJeHOKPtnm5hvywGdj2g5S85lankuo
 4GCutAAi3wYoAOSSDy4zvsWP/bK3KAuvAMvsLMBBTaDbr+xWXTYJQtk3NiwwaMF3/9XfxN
 p08WW7jPtTpSBm/JpjnxBzyewnyuKq7isD7OEw+E/7ZMY1VA78c7Tjtb05knTZc2ST4IUu
 w9Ft8VigSwG883KnuTkRtiFumnWNLMKsxzVr8399YH4ZDtUzsx9h5/OdSe09ZmqNx4LOj0
 RpHfrJEd0t18WXI0Lpsb8ysXqMnUwdo1rIc1BiBgSea6/mj1DxiNXI2bmPt06A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v2 4/9] configs: sandbox: Enable GETOPT for sandbox and
 sandbox64 target
Date: Sat,  7 Oct 2023 23:41:01 +0200
Message-Id: <20231007214106.15744-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 97bcc3473434b0b906f
X-MBO-RS-META: rp5q6orpjrhp8jwpx64uqen6qxq3dmcx
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

Enable GETOPT so that 'bdinfo' command with getopt() support can be
tested in CI.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Add RB from Simon
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a033b22018..e937ac66964 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -262,6 +262,7 @@ CONFIG_CMD_DHRYSTONE=y
 CONFIG_TPM=y
 CONFIG_LZ4=y
 CONFIG_ERRNO_STR=y
+CONFIG_GETOPT=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 01830c7bd25..019e41580c1 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -338,6 +338,7 @@ CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
 CONFIG_SHA384=y
 CONFIG_ERRNO_STR=y
+CONFIG_GETOPT=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.40.1

