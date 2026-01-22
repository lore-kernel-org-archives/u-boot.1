Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B29C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8CF83AC5;
	Thu, 22 Jan 2026 09:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edgr1+XI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ABA80077; Thu, 22 Jan 2026 09:58:50 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31AA83AC5
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 12637600C3;
 Thu, 22 Jan 2026 08:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAFBC116C6;
 Thu, 22 Jan 2026 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769072326;
 bh=mJpJZ0Nn6eZNWMT8dD7to/s5D8SmzygGv8NqeAYCXs8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=edgr1+XI3Cf6TdeAnE5LHobBXEia8c9E7G36Pi54En+KMNJizjHlveBxCQWYxmJRR
 4Qj3ha6m5NC9M7k4lJi8O0KysYYI+RnfFK+rbBCcxpzUS4GQXqEY4KF178pDOOkHSu
 fYDXrNDVKNNs4S3oxunpKpvUMVNKMGREbPB3jBbQMODS0kJXXGrQgGkqYEidp/nkco
 W0J25SBlYbkKOQdeDefJ4RPSlyx0vXD1DJITmwlhp1+AwEFZxF+BQr2ygtO4TsdzMr
 ekZx2HPflhhVBQ9pwhx+cl8I5Ba0h2xiTJtMzNSoXkk2WjcT2nBm5Y+rXWB6HS0bzz
 p5kXGwRnltJ1A==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 1/3] tee: optee: Export OP-TEE message UID check API
Date: Thu, 22 Jan 2026 14:28:04 +0530
Message-ID: <20260122085806.542149-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122085806.542149-1-sumit.garg@kernel.org>
References: <20260122085806.542149-1-sumit.garg@kernel.org>
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

