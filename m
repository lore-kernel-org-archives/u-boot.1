Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC3AD149EE
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 038EC89079;
	Fri, 25 Oct 2024 22:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA8D89017; Fri, 25 Oct 2024 19:18:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AF31389017
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB775339;
 Fri, 25 Oct 2024 10:19:12 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 070793F71E;
 Fri, 25 Oct 2024 10:18:41 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/8] arm: total_compute: Remove unused bootm_size
Date: Fri, 25 Oct 2024 18:18:16 +0100
Message-Id: <20241025171821.624702-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025171821.624702-1-leo.yan@arm.com>
References: <20241025171821.624702-1-leo.yan@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Oct 2024 22:14:52 +0200
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

From: Boyan Karatotev <boyan.karatotev@arm.com>

The whole DRAM bank is used for loading and U-boot can detect the
overlap between the kernel and initramfs. So it is safe to drop
bootm_size.

Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/configs/total_compute.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/total_compute.h b/include/configs/total_compute.h
index 8053dca315..4c966ce4bf 100644
--- a/include/configs/total_compute.h
+++ b/include/configs/total_compute.h
@@ -12,7 +12,6 @@
 /* Link Definitions */
 
 #define CFG_EXTRA_ENV_SETTINGS	\
-				"bootm_size=0x20000000\0"	\
 				"load_addr=0xa0000000\0"	\
 				"initrd_addr_r=0x88000000\0"
 /*
-- 
2.34.1

