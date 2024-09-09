Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D97ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7F688DB7;
	Mon,  9 Sep 2024 13:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D8388CBD; Mon,  9 Sep 2024 13:20:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 81BC088CE4
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9292AFEC;
 Mon,  9 Sep 2024 04:21:12 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 348F13F73B;
 Mon,  9 Sep 2024 04:20:41 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 4/6] fwu: add dependency checks for selecting FWU metadata
 version
Date: Mon,  9 Sep 2024 16:50:19 +0530
Message-Id: <20240909112021.1962801-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
References: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
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
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
Changes since V1: None

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

