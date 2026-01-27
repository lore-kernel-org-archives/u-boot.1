Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09742D2594B
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 06:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836FE83F98;
	Tue, 27 Jan 2026 07:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BM9JWF3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E95B83F85; Tue, 27 Jan 2026 07:24:06 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2D783F98
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 07:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7333E60051;
 Tue, 27 Jan 2026 06:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BA4C116C6;
 Tue, 27 Jan 2026 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769495043;
 bh=mJpJZ0Nn6eZNWMT8dD7to/s5D8SmzygGv8NqeAYCXs8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BM9JWF3mGb3Kp/JWk95CGu76Zr8j4+hcc50ToZ4NPAXYiZP46bBi2YoC2Tq+RobSV
 Lovr1DhGeBfBuP0tfUCJAwCiLORIAvfNushd64SKoC1WqrqtXMd7mQCvSFYF3Tve8w
 yCpwoSK9tA8E+G2yvoCxmuGut2dLAFg/vP71S81t6ZiKfrkXO5oVzon3DIzGKhgz+k
 RdVIL9L7Oj/dKzoLLOTdwJQv/YVBCuDF9IuHJia1Cny+ey2hTmi9Lr6idPN/wQsZMf
 bE6j/42ipZNoGR6dSyig6AHAOc1+d9cnb2jP5XftWB1R2V1QXeMkvBWmhBXFBRBrpg
 tfhgEBoT2WR7A==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 1/3] tee: optee: Export OP-TEE message UID check API
Date: Tue, 27 Jan 2026 11:53:39 +0530
Message-ID: <20260127062341.723966-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127062341.723966-1-sumit.garg@kernel.org>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

OP-TEE message UID check API can be useful to know whether OP-TEE
is enabled on not assuming the corresponding SMC call is properly
handled if OP-TEE is not supported.

This API can be used by platform code to know OP-TEE presence and
on that basis OP-TEE DT node can be added as part of DT fixups for
the OP-TEE driver probe to happen for both U-Boot and Linux.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/tee/optee/core.c | 5 +++++
 include/tee/optee.h      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 5fc0505c788..4d67c948ec1 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -795,6 +795,11 @@ static optee_invoke_fn *get_invoke_func(struct udevice *dev)
 	return ERR_PTR(-EINVAL);
 }
 
+bool is_optee_smc_api(void)
+{
+	return is_optee_api(optee_smccc_smc);
+}
+
 static int optee_of_to_plat(struct udevice *dev)
 {
 	struct optee_pdata *pdata = dev_get_plat(dev);
diff --git a/include/tee/optee.h b/include/tee/optee.h
index 77729450bb6..d1194493780 100644
--- a/include/tee/optee.h
+++ b/include/tee/optee.h
@@ -65,4 +65,13 @@ static inline int optee_copy_fdt_nodes(void *new_blob)
 }
 #endif
 
+#if defined(CONFIG_OPTEE)
+bool is_optee_smc_api(void);
+#else
+static inline bool is_optee_smc_api(void)
+{
+	return false;
+}
+#endif
+
 #endif /* _OPTEE_H */
-- 
2.51.0

