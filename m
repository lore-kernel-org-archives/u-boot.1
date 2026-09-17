Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88288C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F8F281104;
	Thu, 17 Sep 2026 17:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7HvgwVu8Kxf; Thu, 17 Sep 2026 17:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B4FB98113A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665600;
	b=U4coCBJTKlHj7k4CjjK7OOdT0yDRij2z5NGkR1vdVUV99TBYygaW00stV1oh2R/OmXOu
	 G6mxy98l/HtRlqqbfA4Cn35iiYFKybWtaDQPp9GZwGnNn+Vv+IfAiWrvdrMgjezuCwXCd
	 VvLnm1SnUjabae2xD+Xckdc463alvujFAgK1PbW9XEthg6YeDIFkkEuJLPIQVkRLenszU
	 H0iQse7oT1I7HTnKLnJBril59KIllh5S9TjA2MYspKUipkfj8rRc6G6qOuXKj0pSJxqy1
	 IvG4hb1+ktLOSl0mvYJyYhCtSUdjx53rE8DhQ6xuLBLxIv26Z8Vs/LITh3YBnyGFCHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665600;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kL95eau756O03Fd1h0J4Jsc/5WfCopBQCiu++YOK4XE=;
	b=fwxKn43S/k+Mf0HzqGTsaUb2gE+MyhlnSyPAlUPhDol3Ud/y2qhhewZMLfrYZqbAdZZQ
	 Xm7zKD5ldCamEyhKr2TrAIDbauQ4srlzebS3kl1xPwZVDaBnL1AiiZAhom4rP31xkTi8L
	 hqgHoYmpBkS5Bsp21I+RkruCTlIlnkufwRh9VVhH9CSKMsZBld9KTflxo2e6YMzUGX/ng
	 ih34BYn7lwYFO9a/Pbou3iryxkzWBb/djgfwNbZYqoU5zcCrLhTT6ijVkKppfkttEO98U
	 2RbO9YinEMZWW2kKMf+jHMMupTmINOpV74BdGgTXod5QSXD5Ihe8cw0yz6liuCdmyug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NkAEn8r7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665600;
	bh=kL95eau756O03Fd1h0J4Jsc/5WfCopBQCiu++YOK4XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GO4OUU2R4ZpuouIpRRHpDnjWu9eH3q03DLVKgn9GLJqCbrSJYTzTOucQHSXciZhXj
	 1uiywIA/rqwQdjQI0tq6NxqnOmz4u8Agc78vtW/ML4mkoN5MsFxR9G6Ld0JbwEmhCG
	 Jcc7sxaiNIzG3BkCCwD+QtT1XxCyAm82w2SFuuOV+PhYKo3+mVl+pmG2bp2vOpvfZ7
	 xXaSMIhkUXZ2vqTd7dFmdWyD1WakKBfDsLAJXRN1dpGUF2o8/jE2/VKtu2vub7YEjY
	 oiQ/VBHTTOholwde3GhF1q506h8LLyUJH0Nq9uaCbieb4SK68Jvm5kCjXVl8GUeHoJ
	 xaM45gIvH7UVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4FB98113A;
	Thu, 17 Sep 2026 17:20:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EADF2352
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F7318108A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OamI381GoDWg for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF7CC8108D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665544;
 b=BLhyRAMXLBvYYLxIMegsVzSfu3yIlXDks/nh5MjT+HxDNz9elzJW9VVhJ4Pn3iENd4J8
 T9ghQn1+Ebvbw8wpLdJ51Uviv5ELkRe++OI5VRvLUdxryH25yzTvKyCSF+nnf6yGl6qDT
 RRABTFnh9BtV7UDFaZ403TYTKGsIczLNHhoZN1lk9u765etqnW911V3v0MpY3z0w1cBDP
 j5otipm9D4R+Uvvmb7eDAlpB1oM0eGRR8WeUx75eKYQN5v1OeaGwcZdNy3y1apUG60vRr
 nULRyUlkDgQEAy/WFWf5scoyvnxTHt3ELUteFLn+Zo2exkRsQ88njyT4pxUWDbmPXKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665544;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=kL95eau756O03Fd1h0J4Jsc/5WfCopBQCiu++YOK4XE=;
 b=Jc7LQuZBjTdSPwZt018O/j2YM66oPyp9LAB7tNltq5TCn94bYgqM9BMPLWK/H0BheIEW
 9F0Rdd7Oy2ysde8FloL1vMlRmOK+GHsslg7ofFUjGP1UeQovqbZAptahjDSKPt5k7Xqmg
 hvVPekkheh0pOLZRi/d+du8U0d7Hf7BXc8o3TpPVBdsYuA9LwX8N8LJ/eReUgOwyuA6xw
 3ZC50U89d7eLcUHxsnuhesHsf1ubtyHHbnYmKPohinyTYUG+9nd3iA7v2T74O95I5jRwb
 hX9O70rXjweGCrVmZcUL0z9ODEaFFBiRVG88rgDK2IfzLCXHJ94rYENkUgT/nPUltIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=NkAEn8r7; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=NkAEn8r7
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF7CC8108D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644411F02;
 Thu, 17 Sep 2026 10:19:00 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7163F7B4;
 Thu, 17 Sep 2026 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665543; bh=65+v18BwIlQSw0N12cyEpUvyJxPWdRyJ0tILJsuXJfk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NkAEn8r75JEY0/ISgF2O174VZMY1bPDf5oqekVIwo8cjqn0DkQlI4Jj9dQY0qJJz4
 08zFvvVT2gBZrVG76gaxFIBK8ctGEcUygO/aq3xmfGd4l7jcrg/6Jj+txrIme0sLQl
 NilFVdepTU3imt0jTlBEUHzm4obGi1E9m3qLdf5s=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, David Hu <david.hu2@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 15/24] efi_loader: fwu_arm_psa: Disable trial state handling
Date: Thu, 17 Sep 2026 18:18:01 +0100
Message-ID: <20260917171810.4122899-16-harsimransingh.tungal@arm.com>
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

No need for trial state handling in U-Boot for FWU Arm PSA.

In FWU Arm PSA mode, trial state is handled by secure world. Implement
local trial and update checks and dummy active and update bank hooks
required by capsule handling. This avoids using shared multi-bank FWU
metadata.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: David Hu <david.hu2@arm.com>
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
 lib/efi_loader/efi_capsule.c |  9 +++--
 lib/efi_loader/fwu_arm_psa.c | 72 ++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index fe14eebf867..26cd5ccd636 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -553,10 +553,12 @@ static efi_status_t efi_capsule_update_firmware(
 	uint update_index;
 	bool fw_accept_os;
 
-	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE) || IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
 		if (fwu_empty_capsule(capsule_data)) {
 			if (fwu_empty_capsule_checks_pass()) {
-				return fwu_empty_capsule_process(capsule_data);
+				return !IS_ENABLED(CONFIG_FWU_ARM_PSA) ?
+					fwu_empty_capsule_process(capsule_data) :
+					0;
 			} else {
 				log_err("FWU empty capsule checks failed. Cannot start update\n");
 				return EFI_INVALID_PARAMETER;
@@ -1374,7 +1376,8 @@ efi_status_t efi_launch_capsules(void)
 
 	efi_capsule_scan_done();
 
-	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
+	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE) &&
+	    !IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
 		if (capsule_update == true && update_status == true) {
 			ret = fwu_post_update_process(fw_accept_os);
 		} else if (capsule_update == true && update_status == false) {
diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
index 83c876d5d8a..40e0611adb9 100644
--- a/lib/efi_loader/fwu_arm_psa.c
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -25,6 +25,7 @@ static u64 g_max_payload_size;
 static u8 g_fwu_version_major;
 static u8 g_fwu_version_minor;
 static bool g_fwu_initialized;
+static bool g_in_trial;
 static struct fwu_image_directory *g_fwu_cached_directory;
 efi_guid_t g_update_guid[CONFIG_FWU_NUM_IMAGES_PER_BANK];
 
@@ -1225,6 +1226,77 @@ efi_status_t efi_fill_image_desc_array(efi_uintn_t *image_info_size,
 	return EFI_SUCCESS;
 }
 
+/**
+ * fwu_update_checks_pass() - Check if FWU update can be done
+ *
+ * Check if the FWU update can be executed. The updates are
+ * allowed only when the platform is not in Trial State
+ *
+ * Return: 1 if OK, 0 if checks do not pass
+ *
+ */
+u8 fwu_update_checks_pass(void)
+{
+	return !g_in_trial;
+}
+
+/**
+ * fwu_empty_capsule_checks_pass() - Check if empty capsule can be processed
+ *
+ * Check if the empty capsule can be processed to either accept or revert
+ * an earlier executed update. The empty capsules need to be processed
+ * only when the platform is in Trial State
+ *
+ * Return: 1 if OK, 0 if not to be allowed
+ *
+ */
+u8 fwu_empty_capsule_checks_pass(void)
+{
+	return g_in_trial;
+}
+
+/**
+ * fwu_get_active_index() - Return a dummy active bank index
+ * @active_idx: Pointer to the dummy active bank index
+ *
+ * When U-Boot takes the role of Update Client, the active bank is managed
+ * by the Update Agent in the Secure World. This active index is therefore
+ * not required and a dummy value is returned and subsequently ignored
+ * in capsule handling, fwu_clear_accept_image() and fwu_accept_image().
+ *
+ * Return: EFI_SUCCESS if OK, -ve on error
+ *
+ */
+int fwu_get_active_index(uint *active_idx)
+{
+	if (!active_idx)
+		return -EINVAL;
+
+	*active_idx = 0x0;
+	return EFI_SUCCESS;
+}
+
+/**
+ * fwu_plat_get_update_index() - Return a dummy update bank index
+ * @update_idx: Pointer to the dummy update bank index
+ *
+ * When U-Boot takes the role of Update Client, the update bank is managed
+ * by the Update Agent in the Secure World. This update index is therefore
+ * not required and a dummy value is returned and subsequently ignored
+ * in capsule handling, fwu_clear_accept_image() and fwu_accept_image().
+ *
+ * Return: EFI_SUCCESS if OK, -ve on error
+ *
+ */
+int fwu_plat_get_update_index(uint *update_idx)
+{
+	if (!update_idx)
+		return -EINVAL;
+
+	*update_idx = 0x0;
+	return EFI_SUCCESS;
+}
+
 /**
  * fwu_accept_image() - Dummy hook for accepting an image
  * @img_type_id: Unused image type GUID
-- 
2.43.0

