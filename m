Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910F1C44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 08:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C7483B22;
	Thu, 22 Jan 2026 09:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VD78vLBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E79B80077; Thu, 22 Jan 2026 09:59:00 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3FC083B22
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 09:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 73E81406EF;
 Thu, 22 Jan 2026 08:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C99C116C6;
 Thu, 22 Jan 2026 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769072336;
 bh=1xBptnT2sA1khTMkxatZTvcx9JrjRa7mAMuHOOfnpg0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VD78vLBVbVWCvM987NBnbRvQNTbdoEy1lQVTpnqcroBpcb5+3KwMCnS8dzuYU/zg/
 A3+VdAHyMgqTsOlu3gbgRWrch+FdlWqErDMC6eyEG1vNz++gp42v8OBRKyTV4XLGdZ
 feqRA1xmKhPUVqU5sRxTenjIRNX/RNS6fisufh1+iipTujk8POidM868YwMUfyHp4u
 mS3ZJLQZ5L9J4cnoxlPllXF7lc+gslbMZfhb+ez8ZHFu8B/Z82llejWyiIYU/4k2OB
 xlpc8xlgDI6xhyHxDz0iFtXOmvdpOaePFEaCNSBu1B+DCoFjjgfXgrF4jX9Ja0SiQc
 XPGNsjkZBAF3Q==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2 3/3] board/qualcomm: Introduce TF-A and OP-TEE config
 fragment
Date: Thu, 22 Jan 2026 14:28:06 +0530
Message-ID: <20260122085806.542149-4-sumit.garg@kernel.org>
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

