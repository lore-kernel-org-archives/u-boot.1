Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92FBC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C354B87F1C;
	Mon, 12 Feb 2024 08:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A5787F1B; Mon, 12 Feb 2024 08:48:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CDFD687F08
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0166DA7;
 Sun, 11 Feb 2024 23:49:26 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F6333F762;
 Sun, 11 Feb 2024 23:48:41 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 19/21] tools: mkfwumdata: fix the size parameter to the
 fwrite call
Date: Mon, 12 Feb 2024 13:17:10 +0530
Message-Id: <20240212074712.3657076-20-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
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

The fwrite call returns the number of bytes transferred as part of the
write only when the size parameter is 1. Pass the size parameter to
the library call as 1 so that the correct number of bytes transferred
are returned.

Fixes: fdd56bfd3ad ("tools: Add mkfwumdata tool for FWU metadata image")
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1: New patch

 tools/mkfwumdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index ab07623e25..426d221ac7 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -338,7 +338,7 @@ fwu_make_mdata(size_t images, size_t banks, const char *vendor_file,
 		goto done_make;
 	}
 
-	ret = fwrite(mobj->mdata, mobj->size, 1, file);
+	ret = fwrite(mobj->mdata, 1, mobj->size, file);
 	if (ret != mobj->size)
 		ret = -errno;
 	else
-- 
2.34.1

