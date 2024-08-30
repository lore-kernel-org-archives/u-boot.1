Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B61CA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 11:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04A4F88B40;
	Fri, 30 Aug 2024 13:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06DC388B39; Fri, 30 Aug 2024 13:41:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 153B688A10
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC9E5339;
 Fri, 30 Aug 2024 04:41:47 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBFE43F66E;
 Fri, 30 Aug 2024 04:41:19 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 5/6] fwu: add dependency checks for selecting FWU metadata
 version
Date: Fri, 30 Aug 2024 17:10:56 +0530
Message-Id: <20240830114057.891069-6-sughosh.ganu@linaro.org>
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

The FWU code supports both versions of the FWU metadata, i.e. v1 and
v2. A platform can then select one of the two versions through a
config symbol. Put a dependency in the FWU metadata version selection
config symbol to ensure that both versions of the metadata cannot be
enabled.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/fwu_updates/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index 51b7fbbefd..a722107c12 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -40,6 +40,7 @@ config FWU_MDATA_V1
 
 config FWU_MDATA_V2
 	bool "Enable support FWU Metadata version 2"
+	depends on !FWU_MDATA_V1
 	help
 	  The FWU specification supports two versions of the
 	  metadata structure. This option enables support for FWU
-- 
2.34.1

