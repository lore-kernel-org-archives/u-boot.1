Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B32C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 850838821C;
	Fri, 22 Mar 2024 11:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D93888218; Fri, 22 Mar 2024 11:59:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AE9A58817E
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 501C61692;
 Fri, 22 Mar 2024 03:59:48 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350553F64C;
 Fri, 22 Mar 2024 03:59:10 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 19/20] MAINTAINERS: add entry for FWU multi bank update
 feature
Date: Fri, 22 Mar 2024 16:27:32 +0530
Message-Id: <20240322105733.203888-20-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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

Add an entry for the FWU Multi Bank Update feature.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd9b2d42e8..5409b1d78a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1147,6 +1147,14 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git
 F:	drivers/watchdog/sp805_wdt.c
 F:	drivers/watchdog/sbsa_gwdt.c
 
+FWU Multi Bank Update
+M:	Sughosh Ganu <sughosh.ganu@linaro.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
+F:	lib/fwu_updates/*
+F:	drivers/fwu-mdata/*
+F:	tools/mkfwumdata.c
+
 GATEWORKS_SC
 M:	Tim Harvey <tharvey@gateworks.com>
 S:	Maintained
-- 
2.34.1

