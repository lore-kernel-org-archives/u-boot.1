Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40826ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AF088DC6;
	Mon,  9 Sep 2024 13:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1EEE88DBE; Mon,  9 Sep 2024 13:20:41 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D3C5388CBD
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3E2BFEC;
 Mon,  9 Sep 2024 04:21:07 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85A6A3F73B;
 Mon,  9 Sep 2024 04:20:37 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 2/6] fwu: v1: do a version check for the metadata
Date: Mon,  9 Sep 2024 16:50:17 +0530
Message-Id: <20240909112021.1962801-3-sughosh.ganu@linaro.org>
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

Do a sanity check that the version of the FWU metadata that has been
read aligns with the version enabled in the image. This allows to
indicate an early failure as part of the FWU module initialisation.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 lib/fwu_updates/fwu_v1.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/fwu_updates/fwu_v1.c b/lib/fwu_updates/fwu_v1.c
index efb8d51500..023e43728d 100644
--- a/lib/fwu_updates/fwu_v1.c
+++ b/lib/fwu_updates/fwu_v1.c
@@ -146,6 +146,7 @@ int fwu_init(void)
 {
 	int ret;
 	uint32_t mdata_size;
+	struct fwu_mdata mdata = {0};
 
 	fwu_get_mdata_size(&mdata_size);
 
@@ -157,10 +158,16 @@ int fwu_init(void)
 	 * Now read the entire structure, both copies, and
 	 * validate that the copies.
 	 */
-	ret = fwu_get_mdata(NULL);
+	ret = fwu_get_mdata(&mdata);
 	if (ret)
 		return ret;
 
+	if (mdata.version != 0x1) {
+		log_err("FWU metadata version %u. Expected value of %u\n",
+			mdata.version, FWU_MDATA_VERSION);
+		return -EINVAL;
+	}
+
 	fwu_data_init();
 
 	return 0;
-- 
2.34.1

