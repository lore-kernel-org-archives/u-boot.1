Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEEFCD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC6384B2C;
	Thu,  7 May 2026 17:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="BYjRzazN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60BFD84A7B; Thu,  7 May 2026 17:04:27 +0200 (CEST)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::190a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DCA84A93
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gBFs51sYpzW6g;
 Thu,  7 May 2026 17:04:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778166265;
 bh=Rt6rbponnh1mtHZvesAorRkx9wFNe3w/5JBfFFesuek=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BYjRzazNjaRj8b4EqKfoDikCx7I3P+bgvAFooGDCGeiXE5mES+nOlX5mhkolx1XW5
 Sfo3c9fu+Dd3u7Rr84viwNF+JHovtlzI7igop18usZ4PzcZ3jyppdxIWA/iFwgzBdz
 yfePZx83DT7GTRg7zwhIrLhRg3XXRfq8DUQlLGKJ+GHniJITbLcsPD+4s6TooCKDfO
 y3/BQoIVHzLC+Mszu2SKRLYuXXEcHUfGbs8DUYToEPW8Zxe9I/9OMXSKMautSDDIHA
 O0m6FqieOyUIAv/Co/+r4Dfkbowk5xKpLCmCC6wVIXAz2Zly8pQn3zenhvIABvVnXI
 E7bFQEFHRt33w==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gBFs44KqnzVcv; Thu,  7 May 2026 17:04:24 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 07 May 2026 17:04:05 +0200
Subject: [PATCH v2 1/3] cmd: boot: fix edl being shown when not supported
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-doc-sysreset-qcom-v2-1-37fef7a9cf92@cherry.de>
References: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
In-Reply-To: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

edl is implemented in the sysreset_ops.request_arg callback of the
qcom-psci sysreset driver. That callback is only called from
sysreset_request_arg() which is compiled only when
CONFIG_SYSRESET_CMD_RESET_ARGS=y.

Therefore, only show the edl option if that symbol is enabled.

It is in a separate if block because any option but -w will only be
handled when CONFIG_SYSRESET_CMD_RESET_ARGS=y as seen with the
implementation in do_reset() in drivers/sysreset/sysreset-uclass.c.

Fixes: ef06c5d76ff4 ("cmd: boot: Add '-edl' option to reset command documentation")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/boot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cmd/boot.c b/cmd/boot.c
index d80f9d8c05d..29cdf4a9a81 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -60,8 +60,11 @@ U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
 	"- cold boot without level specifier\n"
+#if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
+// All options handled by sysreset drivers via their sysreset_ops.request_arg callback
 #ifdef CONFIG_SYSRESET_QCOM_PSCI
 	"reset -edl - Boot to Emergency DownLoad mode\n"
+#endif
 #endif
 	"reset -w - warm reset if implemented"
 );

-- 
2.54.0

