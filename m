Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93C4D25944
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 06:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1045683FA7;
	Tue, 27 Jan 2026 07:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PVpGQOjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95CD83F85; Tue, 27 Jan 2026 07:24:16 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D9D683FA6
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 07:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 93E8860051;
 Tue, 27 Jan 2026 06:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8260C116C6;
 Tue, 27 Jan 2026 06:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769495053;
 bh=1xBptnT2sA1khTMkxatZTvcx9JrjRa7mAMuHOOfnpg0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PVpGQOjGubdDECAyUbXzPu6QZce0wNpwZhZGdObRAb3t6hGs5InQYKx0fsXkh1cKB
 3XbUW2f/ubtYFFDTBqdhXAQnHNDnyDEzYxBKwBnDeBJhkTWqbYu6beRItPUOlRkrm6
 PkbOKn3qOMTk7/uEHLmZOCVEmcgni3SDQBvpkw5b/UAB+0Ojtwf9YAlPYE5QS/7dEo
 mfnAOan4xlMt7tHz0Z1aUGk1+CeASXQYCCduPCD3eevJaZDGOsjHFKLI24SpQPwENT
 HJWKdM1wlPT29xpHwanqXZMKTBRxKRQYykC3+2vJQ/Tp0noH+V24H1WDp5pb0BGfv4
 bWGW2943QJcCQ==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v3 3/3] board/qualcomm: Introduce TF-A and OP-TEE config
 fragment
Date: Tue, 27 Jan 2026 11:53:41 +0530
Message-ID: <20260127062341.723966-4-sumit.garg@kernel.org>
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

Recently upstream TF-A/OP-TEE has started gaining support for Qcom
platforms. RB3Gen2 being the first one and more to come. U-Boot in
corresponding boot flow is packaged as a position independent executable.

So, lets add a generic U-Boot config fragment for Qcom platforms to
support TF-A/OP-TEE based TrustZone stack. Build command:

$ ./scripts/kconfig/merge_config.sh \
       configs/qcom_defconfig \
       board/qualcomm/tfa-optee.config
$ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2

For more information refer here:
https://trustedfirmware-a.readthedocs.io/en/latest/plat/qti/rb3gen2.html

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 board/qualcomm/tfa-optee.config | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 board/qualcomm/tfa-optee.config

diff --git a/board/qualcomm/tfa-optee.config b/board/qualcomm/tfa-optee.config
new file mode 100644
index 00000000000..1e8364c114f
--- /dev/null
+++ b/board/qualcomm/tfa-optee.config
@@ -0,0 +1,4 @@
+# Enables support for TF-A based OP-TEE as the open
+# source TrustZone stack on Qcom platforms
+CONFIG_TEE=y
+CONFIG_OPTEE=y
-- 
2.51.0

