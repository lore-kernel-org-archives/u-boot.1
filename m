Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F465C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 16:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4442A88644;
	Tue,  9 Jul 2024 18:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366808861D; Tue,  9 Jul 2024 18:23:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0F5AC88570
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 18:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5825D153B;
 Tue,  9 Jul 2024 09:24:00 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C27A53F762;
 Tue,  9 Jul 2024 09:23:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Etienne Carriere <etienne.carriere@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] driver: rng: Do not check ARM_SMCCC_TRNG_VERSION
Date: Tue,  9 Jul 2024 17:23:09 +0100
Message-Id: <20240709162309.1531981-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 09 Jul 2024 18:36:59 +0200
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

As described in the document SMC Calling Convention (ARM DEN 0028 1.5 F),
section 7 "Arm Architecture Calls", the SMC call SMCCC_ARCH_FEATURES is
not expected to support the function ID ARM_SMCCC_TRNG_VERSION. Trusted
Firmware-A follows up the specification in its implementation.

This commit removes the invocation to avoid the failure - which is a
wrong calling in U-boot. The later code invokes ARM_SMCCC_TRNG_VERSION
for retrieving the TRNG version, except it can read back the version
number, it also can be used to detect whether the TRNG is supported or
not.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/rng/smccc_trng.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
index f59b80666b..1da1affd8e 100644
--- a/drivers/rng/smccc_trng.c
+++ b/drivers/rng/smccc_trng.c
@@ -135,10 +135,6 @@ static bool smccc_trng_is_supported(void (*invoke_fn)(unsigned long a0, unsigned
 {
 	struct arm_smccc_res res;
 
-	(*invoke_fn)(ARM_SMCCC_ARCH_FEATURES, ARM_SMCCC_TRNG_VERSION, 0, 0, 0, 0, 0, 0, &res);
-	if (res.a0 == ARM_SMCCC_RET_NOT_SUPPORTED)
-		return false;
-
 	(*invoke_fn)(ARM_SMCCC_TRNG_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 	if (res.a0 & BIT(31))
 		return false;
-- 
2.34.1

