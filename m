Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3F2CA0FE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 11:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 623DD88A8B;
	Fri, 30 Aug 2024 13:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6331688A92; Fri, 30 Aug 2024 13:41:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 69BFF88A10
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD31339;
 Fri, 30 Aug 2024 04:41:50 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BBDC3F66E;
 Fri, 30 Aug 2024 04:41:21 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 6/6] fwu: do not allow capsule processing on exceeding Trial
 Counter threshold
Date: Fri, 30 Aug 2024 17:10:57 +0530
Message-Id: <20240830114057.891069-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830114057.891069-1-sughosh.ganu@linaro.org>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
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

When in Trial State, the platform keeps a count of the number of times
it has booted in the Trial State. Once the threshold of the maximum
allowed count exceeds, the platform reverts to boot from a different
bank on subsequent boot, thus coming out of the Trial State. It is
expected that all the updated images would be accepted or rejected
while the platform is in Trial State. Put in checks so that it is not
possible to apply an empty capsule once the max Trial Count exceeds.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/fwu_updates/fwu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index a94a769a2b..7f085a0211 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -113,6 +113,8 @@ static int fwu_trial_count_update(void)
 		ret = fwu_revert_boot_index();
 		if (ret)
 			log_err("Unable to revert active_index\n");
+
+		trial_counter_update(NULL);
 		ret = 1;
 	} else {
 		log_info("Trial State count: attempt %d out of %d\n",
@@ -762,8 +764,8 @@ static int fwu_boottime_checks(void)
 		return 0;
 
 	in_trial = in_trial_state();
-	if (!in_trial || (ret = fwu_trial_count_update()) > 0)
-		ret = trial_counter_update(NULL);
+
+	ret = in_trial ? fwu_trial_count_update() : trial_counter_update(NULL);
 
 	if (!ret)
 		boottime_check = 1;
-- 
2.34.1

