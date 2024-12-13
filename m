Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6A4E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921A2801BF;
	Fri, 13 Dec 2024 11:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KkFA/HmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09EBA8022E; Fri, 13 Dec 2024 11:23:43 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D869980224
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 430435C6B33;
 Fri, 13 Dec 2024 10:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A0FC4CED6;
 Fri, 13 Dec 2024 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734085419;
 bh=47mRPTDoRe3HAKD0S9OAvWgpv/FiICr31xe+D7Jjir0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KkFA/HmVGD21WwkybZe2ymWJBRCVZkk0d1Tcc5kZTOGBtV4nZh0sWBif7zA7HMPZ7
 52MJyO3TnbgsF1OTEIkwQKWJoZWgi5HWk5l86JkhjApDi3FHDz++xzrFnTcRztuyy7
 Xh28MOI7Sk6bLGOtqSZ6KhnwWkidxIhM5HCmanhXOdzAR6fCUqZll++Ve0up7L1b2U
 N6l6RrVzzbpmDjMH1NOwoN/O9jiMeRicyT2gLy4l9TuLLklioZRFFnUC3Uwq4Wo7I2
 exhs+eK6EXdONFqTp+H+Q5eyeCgp7uxdN9rCDg5Hqzh2td3/dk5G+azwu0W5uyJVb2
 VJT8k9qHp3U2A==
From: Michael Walle <mwalle@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, heiko.thiery@gmail.com, thomas.schaefer@kontron.com,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 3/5] board: sl28: fix network on variant 3
Date: Fri, 13 Dec 2024 11:23:19 +0100
Message-Id: <20241213102321.2166920-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213102321.2166920-1-mwalle@kernel.org>
References: <20241213102321.2166920-1-mwalle@kernel.org>
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

Network is broken on variant 3 boards since commit 61ff13283c3b ("board:
sl28: move to OF_UPSTREAM") because it was removing the variant 3
handling. That is because at that time the var3 device tree was not
upstream. FWIW variant 3 is actually the same as the base variant, but
I've missed that the -u-boot.dtsi is not inlcuded in this case which
will set the ethernet alias.  Now that the var3 device tree is upstream,
just re-add it to the SPL handling again.

Fixes: 61ff13283c3b ("board: sl28: move to OF_UPSTREAM")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/kontron/sl28/spl.c       | 3 ++-
 configs/kontron_sl28_defconfig | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/kontron/sl28/spl.c b/board/kontron/sl28/spl.c
index 45a4fc65120..6b31f5e3a7c 100644
--- a/board/kontron/sl28/spl.c
+++ b/board/kontron/sl28/spl.c
@@ -50,9 +50,10 @@ int board_fit_config_name_match(const char *name)
 		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var1");
 	case 2:
 		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var2");
+	case 3:
+		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var3");
 	case 4:
 		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28-var4");
-	case 3:
 	default:
 		return strcmp(name, "freescale/fsl-ls1028a-kontron-sl28");
 	}
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index eae06b546da..1f684093252 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -78,7 +78,7 @@ CONFIG_CMD_RNG=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
-CONFIG_OF_LIST="freescale/fsl-ls1028a-kontron-sl28 freescale/fsl-ls1028a-kontron-sl28-var1 freescale/fsl-ls1028a-kontron-sl28-var2 freescale/fsl-ls1028a-kontron-sl28-var4"
+CONFIG_OF_LIST="freescale/fsl-ls1028a-kontron-sl28 freescale/fsl-ls1028a-kontron-sl28-var1 freescale/fsl-ls1028a-kontron-sl28-var2 freescale/fsl-ls1028a-kontron-sl28-var3 freescale/fsl-ls1028a-kontron-sl28-var4"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-- 
2.39.5

