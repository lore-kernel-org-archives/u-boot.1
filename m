Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836B2C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B07883BA;
	Sat, 20 Jul 2024 14:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L3F5iQ7z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AI2LRDPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144D888CD4; Sat, 20 Jul 2024 14:44:09 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED45883BB
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WR5nz0433z9sWw;
 Sat, 20 Jul 2024 14:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=we5qOAljDLyG1dh+ecoe8mC4Fl+NGmTydZV3Fr3baxA=;
 b=L3F5iQ7zfLfCaDAJGtY31AEdn3vfL21AR9nXVoz/BOMuOh55+iIuc3lmJ2Nq2Gpszphh4S
 iAFYPTOdm2TZtHnh4SXpvD5F2MoxPG0+KDp3ZmDSYca1yHR2P63E2evOGvtzZRzsRVv+j2
 O0MsZfpV/t8ulsrxjFL+fLPyBVwXV4yAI+YsBbWOO7pnn8JYhoG5YlwYTQOp5d4g4bVgss
 2XVVmUFbfaOCE39ljuunomhmd4qDtqUwAVk/4IS8HqibUmf/qSyfYeod2wzBFRAU0cH9lo
 +1/sQ2KAlsg71iT1wxXIkTnh84i8L62W5hOACs58Wy6ue8US583p76g0wZvZyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=we5qOAljDLyG1dh+ecoe8mC4Fl+NGmTydZV3Fr3baxA=;
 b=AI2LRDPlQ9FnK4CvbMhAPFwbSkMJIFJDt08lt3FJ0Ck5Lrsc9et54fkAjJvyYVOKjeTLpU
 6dhwK07uAVfFqGAakumEZoV4+uhVGBQ3O5+/Cg/zQYbozmFyKXkSNCx408VWSp+3DnTVg9
 fn8oCMSRStin84ijnok06Xv3z9pW5QdrHQaQKioi+139ROy0gyU9vtUNiCTUoa4XWfUMdc
 KqIodWE/lxPYvFhN1dqpY0OiIwjuebV2VBBv0vF0qGaWuZL1wLdUY2oRw9kmf44KmPc/fm
 tKtY48qJ20RIh8kdj+hr6GCQfdFdSKvaxKnHh3/cQJawDq+gw0lss0du9hUbpA==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 37/40] drivers: tpm: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:41:02 +0200
Message-ID: <20240720124239.7553-37-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 68dae6f289aade71555
X-MBO-RS-META: agkjexwb7fprh567i8hbmepr4b4csqq7
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/tpm/tpm2_tis_spi.c | 1 -
 drivers/tpm/tpm_tis_lpc.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
index b0fe97ab1d0..d35a4dd3a36 100644
--- a/drivers/tpm/tpm2_tis_spi.c
+++ b/drivers/tpm/tpm2_tis_spi.c
@@ -175,7 +175,6 @@ static int tpm_tis_spi_read32(struct udevice *dev, u32 addr, u32 *result)
 	return ret;
 }
 
-
 static int tpm_tis_spi_write(struct udevice *dev, u32 addr, u16 len, const u8 *out)
 {
 	return tpm_tis_spi_xfer(dev, addr, out, NULL, len);
diff --git a/drivers/tpm/tpm_tis_lpc.c b/drivers/tpm/tpm_tis_lpc.c
index dec7acb0c7b..e53af25a456 100644
--- a/drivers/tpm/tpm_tis_lpc.c
+++ b/drivers/tpm/tpm_tis_lpc.c
@@ -453,7 +453,6 @@ static int tpm_tis_lpc_get_desc(struct udevice *dev, char *buf, int size)
 			chip_name[chip_type]);
 }
 
-
 static const struct tpm_ops tpm_tis_lpc_ops = {
 	.open		= tpm_tis_lpc_open,
 	.close		= tpm_tis_lpc_close,
-- 
2.43.0

