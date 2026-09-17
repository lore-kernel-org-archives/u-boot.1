Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB00C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F59D60BDE;
	Thu, 17 Sep 2026 17:20:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OUv0U9a_hq6J; Thu, 17 Sep 2026 17:20:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B8B4A60BC6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665595;
	b=oE9REoDG7BxYy9iszFIBmGFYZrZmYq1O4uz+r555MXZdFNA4aq0eQtqEDFdtcViEjpxu
	 CAtMmNbt6fpyfv7VzfvpUNUttB+BWidLCL7WiG/US4PJcKULKsCdGFtSjkHbegUzT5E2y
	 U1a5xeFqtkzPV48pq87uCDdUpGjC3vhQqxsr1h253D2Xf/55DgWiiwIAW5eDPRrEivXWm
	 /Cijsm0b+laTQvdFXixsrJqUIvFbD7+XqqNe/9hPAXTZXCciN77jqreapWed6OAn9BTZX
	 kMM9oVicd9NUuRxhWj0mEGwCWS250smW6wwsdPFMkfJjtFz/2IkWV6P9yjwBVOch5eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665595;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b78Z2ehKr5nfNzjTxB5pUA1y6ypXiOah18wKAA7S0Cw=;
	b=EwJ6+VIoVluAwuuj8SxJV6ZmbHFQO4sGNUmvFVYqmF9ECkTy+eh5aGjw2KbTXbAzsOIW
	 KE1ciN05RfsNIVlM4uNPZNR/H9czJ2Ibdm1N/RmSSbGWJiDu4lDHLbjKLAh87PQRE74+Z
	 XMYCQ1VDwNIq73qXL6BwbKXDTPt4Y7zcwAQAuHuX5Yxi5FqViEhvEEa/n9/O5womxsFEy
	 y/twnE4b1xXpEXh6R50BgfmUUfLDbaqiWpqE9hO+fZxo5ZKGlr+MMTGcWeJwu98RTIFz6
	 dXi0PKnOtOTGYJGGqJ9ZUDlj7pL4xD/Zu52vw6uLhUOz46wj2Ham641oIcyQBvye/aw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665595;
	bh=b78Z2ehKr5nfNzjTxB5pUA1y6ypXiOah18wKAA7S0Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L4Ob2sVydB+VHDTXKcL7hinnlKExp3iFy5B9jsO3HaHDVHd/IZMp7aF49t9MrDtf2
	 JlZO0se2p7jyDdC9EqrIw1LrRTEwgYr2swmcrw1BOVK5wAaXKYtf1iaYF6KLDZu1CZ
	 3MIjzVMUG1YQDG2eQPnSx0R1sssuuIcv1Fyc8G6qJPkv7e8JCMPr8N7l9dcIJfEzvN
	 ub7O2dhhHhGhaHkrbA3aWn20G+8r+z8PKFftWkEa1cbqhVoS4e8aHzs3lLsH08Qhj8
	 NzDc3mfcpYn6cZ2ddipb/mW3PjVYEZ3bEUL+vsHKNgV45EtnAiognJDcLPvNMQ7uyS
	 IETTDBSkO94sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8B4A60BC6;
	Thu, 17 Sep 2026 17:19:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3436A422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FEAA407D2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kIKWqIIBUnj for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 62C91407C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665540;
 b=E02Is2gX3t/oFks+vli37c+7kFMVHwITwBTGhXXhbXRPVA2YzGnYb4d71yKT9SDivfAL
 Ct7StNHd7ClCHOUzLOcOe/V3b/VQYQ96VJimIdnvC/KQHd+Bn83VkCbr7bVgV8ubVoDBH
 3WHInM2he4+0QH46m9akzzv0obawiXVrBKOc8o1n+3+fFpuDxvfDO6avZ0VuanawNyrqG
 8FqWqX1nN7H9wjwQuVp3wtX5sn01REZSa/DppkdeYQnFZCJZ3epZXmOgg1zPNEiBLmJGc
 MFiCjDVwgAZoOya4pebExnarC4Ll5KdG+2KKeC84v+FP2UFOGwBvOnMc1EkzWaKeF5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665540;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=b78Z2ehKr5nfNzjTxB5pUA1y6ypXiOah18wKAA7S0Cw=;
 b=e/Ns4Y+rh3LGn0hYZeWlqC/5o5u5HYonkHF73Rar+xZKUs3pfv49padFw3CYqU/4ewby
 o6TEpsoFCfAQ07O6Gm6MtHgDG0WPFe57fuzFwIuE6FIsSzbhlG2sHDc2Wn7OvEK0ujVYT
 5M5A6dgCIljedzi226qydqlZwdXD5RtwTY6GKmy2baObM68I6vYBfpSHua1VSQ9EUUti4
 7LlAE6100B2hVwdLILzk3uevxR1z4EIkW91vQekgSYiVLf6UF2EH0VkMCWlji3xs8qjVe
 Jwqi/S+UwJStVWD7s87cpgiCE+ofnnpYFIh54kK+krpa4LE5ScCu+jX+qJptYPxxF3g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=Obm9ioDc; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Obm9ioDc
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62C91407C8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A33143D;
 Thu, 17 Sep 2026 10:18:55 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE8F73F7B4;
 Thu, 17 Sep 2026 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665539; bh=HLOpJbfrWUJ0//2B6VGIeYyTJtYWB2jTKWCzz/tRpNM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Obm9ioDcEnVmllSj5IzoInJijvJidncL+1YBP/CfTvGOFK6Q3fnASsdaQVT6UmIj+
 AmM7QrccaU9lUafCTDPr3oa93HfmIlwV7DUrTo1s1+CVpy1jUkHibPvncx0f2E8vho
 3lPBP3TaCVDFg4ZSzcXmkd0hQUvArCw1hroLUvZQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 13/24] efi_loader: fwu_arm_psa: Allow keeping the FMP
 payload header
Date: Thu, 17 Sep 2026 18:17:59 +0100
Message-ID: <20260917171810.4122899-14-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Allow sending the payload with its FMP header

The Secure world needs the data provided by the payload
FMP header. So, let's allow the user to keep it in
case of FWU_ARM_PSA. This is controlled with
CONFIG_FWU_KEEP_FMP_HEADER.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_loader/Kconfig        | 8 ++++++++
 lib/efi_loader/efi_firmware.c | 7 +++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 483d2c6dc18..50302a03eae 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -387,6 +387,14 @@ config FWU_NUM_IMAGES_PER_BANK
 	  Define the number of firmware images per bank. This value
 	  should be the same for all the banks.
 
+config FWU_KEEP_FMP_HEADER
+	bool "Allow sending the FMP header with the payload"
+	depends on FWU_ARM_PSA
+	default y
+	help
+	  Select this option if you do not want to strip the FMP header
+	  of the payload
+
 config FWU_BUFFER_PAGES
 	int "Number of 4KB pages in the FWU shared buffer"
 	depends on FWU_ARM_PSA
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 290db9d27eb..09d386cdf9a 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -512,8 +512,11 @@ static void efi_firmware_get_fw_version(const void **p_image,
 		/* FMP header is inserted above the capsule payload */
 		state->fw_version = header->fw_version;
 
-		*p_image += header->header_size;
-		*p_image_size -= header->header_size;
+		if (!IS_ENABLED(CONFIG_FWU_KEEP_FMP_HEADER)) {
+			*p_image += header->header_size;
+			*p_image_size -= header->header_size;
+		}
+
 	}
 }
 
-- 
2.43.0

