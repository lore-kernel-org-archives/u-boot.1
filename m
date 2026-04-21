Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B97F327C9
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C6384461;
	Tue, 21 Apr 2026 11:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="bRMY4BEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B6584462; Tue, 21 Apr 2026 11:05:39 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD00B8439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from y14 (unknown [IPv6:2a01:e0a:2af:22b0:6ee8:ae48:54aa:4eff])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 1B6D8780516;
 Tue, 21 Apr 2026 11:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1776762337;
 bh=eP8f8d4hGpIAJK3ihXc4iqkryf+tMzGu9HZeqZnm6ts=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bRMY4BEmzOQn7X4u0yB4YSduO1U1wXzzRIT1/HjQ9vs7sfdJt6hHtkeOAxQo623q2
 MgNllmeq2HOnja9hBAHsLDcy/HxVrK0DL/6lGMJd6WCZGQaTiXR8/OwxV8Ki764+sE
 XQ5JlEErD7noTo3cb8CWkCmJve/UYCwUm8BAiXNQU/nG0Ge8S7R2higi8DLXnUL8PI
 iMIpLth5fsjVbiUtC8FMjOC9xwBZLsQ4ta0dKyyYPu/sFh+9LTyKrUIr+cVexXHkOr
 UjUV90BUJAkpvlPkxdVb+5JpNjLeFZQnYHjxSItFUBHt2If9CbdhxmEtEoBa6Ixcbr
 93wIrC0Cvxtrw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 5/5] arm: dts: armada-8040-nbx: add U-Boot dtsi for
 conditional OP-TEE
Date: Tue, 21 Apr 2026 11:04:59 +0200
Message-ID: <ecc1235c183176c761ab49b9cded20b77c78e6b1.1776762022.git.vjardin@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776762022.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
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

Add armada-8040-nbx-u-boot.dtsi with the firmware/optee node guarded
by CONFIG_OPTEE. This allows U-Boot to probe the OP-TEE driver only
when OP-TEE support is enabled in the configuration.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
---
 arch/arm/dts/armada-8040-nbx-u-boot.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm/dts/armada-8040-nbx-u-boot.dtsi

diff --git a/arch/arm/dts/armada-8040-nbx-u-boot.dtsi b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
new file mode 100644
index 00000000000..dec473b7156
--- /dev/null
+++ b/arch/arm/dts/armada-8040-nbx-u-boot.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Free Mobile, Vincent Jardin
+ */
+
+#ifdef CONFIG_OPTEE
+/ {
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+};
+#endif
-- 
2.53.0

