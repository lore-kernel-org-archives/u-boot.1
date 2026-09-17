Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1171C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C55EF8112D;
	Thu, 17 Sep 2026 17:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEWfuCkfOOMC; Thu, 17 Sep 2026 17:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1C83A810EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665594;
	b=krd+o6uSFXhAHqBlUWMC5yvoKVkmo1s4hxol+zsVrrEJXmv+G7qVGbqXcxDVZLqSrd7L
	 VMi/2tAXjEVruZFNui2891SvhD8BGVN9DrKL8J61+KcMRfH6N+sdt/UDUUY11Ulzvfxg7
	 qOtxg8JXSYDTPk5oYkw5OxOV1lMxQKczvwl2tnQfxeqX4CfaiBycGFFZH2cRnMMGwgDmK
	 Krzzy8KnmP/rWeKEHzN1IMJ6gTViP8OhlbA8hxhrGYHR1doze6dRQfJGUChI4qjBBkfTf
	 j8S+lAcTHivhfs++5CFvk7Cg/FQWcvC40npoLPPtfsn/pwFrFAmfLbzyoAZ4RfJVDKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=I4HEIZztFQXifaNbLwSuzNPoi4l8W8NqPqgg5GPpZdA=;
	b=CIHBJlp286xaC361nNEkaMYskmuxPeLWkJ5QBKOEcsxNBbNTzzvH1fA/rBld1IFud0lD
	 Uw1xFmXB+nSQsYudrLAAVL4YkG6We7MG3ai7NjYpmStx1QyDQxtgm6W9LO13/TtLUafM5
	 J2yZgjBvY1C7hKFZCSqHZQ33qALrytUs9qJwwOJUz3Hmmbtyw4ZY4ORVf4WTN/3bDKQfl
	 gak1xHIsbDmdhLziUmMrjZD2HimrpXGzcLp4vc50KdLVAz4XEqgU99m8IxMovLadeWnch
	 NYZA5pW+dRfd9TWPcyIdG9foJutPm4MyfnH25v+ussS8UYORgWqOuauZA3lGpusViZw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665594;
	bh=I4HEIZztFQXifaNbLwSuzNPoi4l8W8NqPqgg5GPpZdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h/dx5FB/fLuHK7GyGBFM5Yp8Ha61rw1qMzimfTwJTbecutIThik36AZxUF/2+znup
	 z7MCKcXW4DkII/8OLq9XeUiiVSg0iLI2/ER2Lve7gtm7GZhSuJWI2yrN1dQWWB5Cxz
	 cGAtLzhXPTNDJ6lxne3Cq+3pNyOTwjuUnCSdYheuCDgiOTxDBvcvAroIydi7Zy5F2L
	 N4+VAQ51T5MWrDM8vaTmkD7j0nbMnyraspCXEthaIUXHt1KltAyKRkC+HSpVO6kX7C
	 aYAu/E4R01Qb8uoibx5SH3NovAYcpDddntBxDwejiTGVOKkKc7LskXWlknqwz/A9AL
	 kEe1Vh6KSu4MQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C83A810EF;
	Thu, 17 Sep 2026 17:19:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E64837A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BDBB60B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yR55TGS2rE5g for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6B13360B58
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665538;
 b=Zsx0S3/gE6E0YdbbuoSK5P069arjQbERDb2jybAOUqwBwdsUBVs1RFIB++/oijc8wuk+
 f1ha9Nb72BWaWPa1OEeokXTEitbZjGyBvG8ClxFtlPD58yhqtWkb/Q/aCkOHPAoiIApMJ
 RMVoZmeXpLaDX4X+JaWSTMW0dNt+Sr9gZluoj63eek7lS/sakP656nMWlxFQ4CK6cklWn
 8+rHPz58322BlhC8Fp4l8FyqRU1w+nIGw9/1ht0mtNTdD9CaHIFwsXCqT1N8MiJZBaWBB
 1bD3q4lewsys1RcNzwvfQpxwhlGVlJTQcFIaCg5DQdYYfXfsyCTCViL4Xr7XbNfrAzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665538;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=I4HEIZztFQXifaNbLwSuzNPoi4l8W8NqPqgg5GPpZdA=;
 b=EQ/xmsXGNFWNBKZFWjjcujgx5llJXdA+uLgYsVe8Teor6iVKMYL92qHo3zRUcU+pFq9b
 Agb4J1a24anUAOD++uUhOaFzxlvL+rmVh+wg5L7sa3TKrtpJhJ6Y8wM4M3uBnSfzybcS0
 QTC/fZuS2FjQVd4oL52HKrdvqC04fJoFnM5/rirDQn5fYSDn3+I61Q7gN84gNW/0r0Kie
 7mJbArYbM1g7WdkN+ReyFCmqUfB0CsteHxcpPHS5u0Oyf969ehqp03CiSfz3wuJ3/5CcC
 WZ9BHL08b3/cWlb63Qoo4ucl5SiehTH9ppDWK1XfQwQkIlNDjA5Bw6cBdE99Ewvnh5g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="YxDN//e7"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=YxDN//e7
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B13360B58
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DCE1F37;
 Thu, 17 Sep 2026 10:18:53 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B44DC3F7B4;
 Thu, 17 Sep 2026 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665537; bh=DhJ8k1jmzYCe75bR53kHeoUtTtrbvOTMjy+bIHaYO4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YxDN//e7i7CicTkbjl5DPjXfjDeTQR9SRnyP/vWY+4R3tu7L/s/DRk8znHiNuuSo+
 Efat+/pAslLpZbOQDGvXzKXBe8siWFRL+VRsnOfCLFoeoE1MG+s5sCKxdHUVYj9LOJ
 0I3F1FEJi7TY/ZAZa0feGyX4fVGPzB11USKP8STc=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Davidson kumaresan <davidson.kumaresan@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 12/24] efi_loader: fwu_arm_psa: Add set_image() support
Date: Thu, 17 Sep 2026 18:17:58 +0100
Message-ID: <20260917171810.4122899-13-harsimransingh.tungal@arm.com>
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

Implement set_image() using efi_firmware_raw_set_image()

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
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
 lib/efi_loader/efi_firmware.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index b41969c70fd..290db9d27eb 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -14,6 +14,7 @@
 #include <efi_variable.h>
 #include <env.h>
 #include <fwu.h>
+#include <fwu_arm_psa.h>
 #include <image.h>
 #include <signatures.h>
 
@@ -312,14 +313,13 @@ static efi_status_t efi_gen_capsule_guids(void)
  *
  * Return		status code
  */
-static efi_status_t efi_fill_image_desc_array(
-	efi_uintn_t *image_info_size,
-	struct efi_firmware_image_descriptor *image_info,
-	u32 *descriptor_version,
-	u8 *descriptor_count,
-	efi_uintn_t *descriptor_size,
-	u32 *package_version,
-	u16 **package_version_name)
+efi_status_t __weak efi_fill_image_desc_array(efi_uintn_t *image_info_size,
+					      struct efi_firmware_image_descriptor *image_info,
+					      u32 *descriptor_version,
+					      u8 *descriptor_count,
+					      efi_uintn_t *descriptor_size,
+					      u32 *package_version,
+					      u16 **package_version_name)
 {
 	size_t total_size;
 	struct efi_fw_image *fw_array;
@@ -765,6 +765,15 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	if (status != EFI_SUCCESS)
 		return EFI_EXIT(status);
 
+	if (IS_ENABLED(CONFIG_FWU_ARM_PSA)) {
+		if (fwu_update_image(image, image_index, image_size))
+			return EFI_EXIT(EFI_DEVICE_ERROR);
+
+		efi_firmware_set_fmp_state_var(&state, image_index);
+
+		return EFI_EXIT(EFI_SUCCESS);
+	}
+
 	/*
 	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
 	 * dfu_alt_num is calculated by (image_index - 1) when multi bank update
-- 
2.43.0

