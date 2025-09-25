Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D471CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40A78362C;
	Thu, 25 Sep 2025 22:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V9dbQzGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8AB8362C; Thu, 25 Sep 2025 22:56:29 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5B00833ED
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3197f534179so1261822fac.2
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833785; x=1759438585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZw8lE4utHBiiUbhHKXvyY9syDPWCkvC2/VktzwxHFA=;
 b=V9dbQzGsC0KCS6601nUcsQKBnJxAcqum/oYM7heHtLKuJhqPtoEcyk1NxrpFJx3pFf
 tj07+u0alDEL+b4CyGc+J/fl3GvLAXCKEFHK69YuTY88XoxGkSSRnznm3bjDUpKmZPm+
 yqejUHYrKsXfVx8NmzrnTLVzhU0fLrpdQ36wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833785; x=1759438585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZw8lE4utHBiiUbhHKXvyY9syDPWCkvC2/VktzwxHFA=;
 b=txXeEMRIfef4tOStkJIY3oVa+IkL/YYnKr3HOf0h9/qUoCsxrTkqY071FZprw5fNRd
 zwF90JIFaMAFTv7Iqn9modvFd0j0vcC9BiJGE1AZDCILsgqRfEZFVw+6b/6QUZh07Tj1
 /5Zo+mMyBuenwe/NiCMUPhG7NDCHsUYooTVzXN4bLKZYndKDxNG5DGCeTT4ni4gkFK7J
 ca+A0HbFp170E1NGU4uSIqw56ivVgos0zVKhZ4Ve3CCczveXRLLrXsHklwOjoR19DQ3w
 g01K//BzAisClP+ZvB9NgFru+0j3+zM+7skVS40NvRohaXpgGgeVhSJRitTnBSJW6BfM
 Xakw==
X-Gm-Message-State: AOJu0YwOnHmWTThChaICmqSVRF29ujuWXLuSo5sQVIgWz8kwUcVuNztP
 txN8XwCxfsBIMxSweWD0zBXprxubQBWt7pOdXboqcKoVZ4ZEfagzU+kTSJZXCIvWk5FJooMy/hP
 Ym0Ol59E=
X-Gm-Gg: ASbGncugWGaPdACSUTcrfnvIWuqmFeqLY3OiM7AiKa4A8AKZOnHITJAY71Oq4O1hCD7
 5Anl84xn+6li4PZPkCQ3i9yDBMCGRCCzfED5sE2qAD+MoM7heVW0P1ZSSjIYiyz6hdkuws7iDXw
 RFTpjQsf8F2KRj7Q8Uf3EGNOd5LUhgRjtXi9yirWv3pQ/1LS9VuvQZTrzfsEIJJ0EbMiaBj60pz
 FxkzI3jP/rG8tdNER85/RV+LvL1bjCOGoSwt1gV5FnFn5/OVgvAEb9k49tYG7XT7c4GbAojzUuY
 5bTEP4SEQXTR9VjBChMDMxDGQaoI9UKgVl1q2Rrkl+BxnZkCEWRJTKMcH/uvQnxBVQQUmv/r41T
 bkpTIgiaczSa3YLE5GAZR7GQiFUUBOfWJZYpKG1ygoUacR66xD4ZXlEXaBfg=
X-Google-Smtp-Source: AGHT+IH9zPzQXfUIAL8qDPBh0ya8O7rHfYGmBEZdFO5rCekdW3Wi2Dde/YEmA79vMKH52ygzGx5xZQ==
X-Received: by 2002:a05:6871:6618:b0:301:fec8:fc5 with SMTP id
 586e51a60fabf-35ee8a36e55mr2610608fac.23.1758833785485; 
 Thu, 25 Sep 2025 13:56:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a3d46c71sm837275fac.11.2025.09.25.13.56.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:56:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] tpm: Make U_BOOT_DRIVER entries unique
Date: Thu, 25 Sep 2025 14:56:23 -0600
Message-ID: <20250925205623.3562621-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

All instances of the U_BOOT_DRIVER must use a unique name or they will
lead to link time failures due to name space conflicts when both are
present. In this case the driver was reusing the tpm_tis_i2c name.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/tpm/tpm_tis_infineon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
index 30f23f8610a3..c1e7b98295c5 100644
--- a/drivers/tpm/tpm_tis_infineon.c
+++ b/drivers/tpm/tpm_tis_infineon.c
@@ -626,7 +626,7 @@ static const struct udevice_id tpm_tis_i2c_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(tpm_tis_i2c) = {
+U_BOOT_DRIVER(tpm_tis_infineon) = {
 	.name   = "tpm_tis_infineon",
 	.id     = UCLASS_TPM,
 	.of_match = tpm_tis_i2c_ids,
-- 
2.43.0

