Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF9C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 13:44:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D0982B20;
	Wed, 18 Jun 2025 15:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qiTwc5q5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B8782BCD; Wed, 18 Jun 2025 15:44:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6A3380E9A
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 15:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B277437D0;
 Wed, 18 Jun 2025 13:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A96C4CEE7;
 Wed, 18 Jun 2025 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750254235;
 bh=VhgVNmIzACA0dhc7H4QC5Az0I1uiyvq1NF6TymijgMA=;
 h=From:Date:Subject:To:Cc:From;
 b=qiTwc5q5wc5RAwPIgj3GUii0X6uNpSbdTLmgbztEMwYp8exOS9nhduOrBf2qW2Jm+
 BvBrOLYHUyCa9RcyTqVm2UPnMwLWXkT5/2/aliyiwP1f42x1Tt1GJkv8oSVkyWfyID
 y3eHPwHY/RsrfCRBvtSmTg5NX12e6nnhxMDTsv7fwBnYgRQHlHA9NsXufH3yutPcV/
 jlogtI0WdzcIW/5cA72/0OtqrOy58PGzqmM76xbds3E98MGTAhkJgEPjeE4Zyh/ntH
 /beKHOtEZOWQeYafO1PSU6ogJvovRcA7tzTxcXrXWwYwdPr66GLarry1/C3dwz+Pxr
 Z0ovMDypztlFg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 18 Jun 2025 15:43:44 +0200
Subject: [PATCH] MAINTAINERS: Add common/spl/spl_dfu to DFU entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-maintainers-dfu-spl-v1-1-03f4bc745e36@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI/CUmgC/x2Myw5AQAwAf0V61oSyiF8RB48uTViyRSTi320c5
 jCHmQeUvbBCHT3g+RKVzQVJ4wiGuXMTo4zBgRIySZFWuHbijgB7xdGeqPuCJRObos+JMoJQ7p6
 t3P+1ad/3A6OPPqtlAAAA
X-Change-ID: 20250618-maintainers-dfu-spl-7e2e56b42232
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=841;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=VhgVNmIzACA0dhc7H4QC5Az0I1uiyvq1NF6TymijgMA=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBoUsKZWesk9wzLFqC3Yf9xPj1tQP5pGdF8aLk1O
 KWOO6jz0mGJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaFLCmQAKCRAZDR20Zk4Z
 NXGsCADc1GD0OM61tAkP351D6374wOm1qdLRFGNucA4eafBRkEk8PQ1bcUqVNEhsOKD35iljPju
 XRPgrWS/2bYHzSsiJ28Hp8Mmy4IrMbCmc1hM2qn2pHyWJbxV0EDO5RMvDhmL67Lo2UBGHxOsnEp
 dYYjAt31Fgf50R8n3aj+4wVkUbUlb6wfx9LBtCnq69ZZ2jtkLSh6T/22g3x8YTiQJ2cPZTZPghH
 pFbHKrxfWGAEH0o1wKXa+B/vCkaLuhbAeGNSYyZSCIdpnzM6qja3I8Q/r1RcmOQKulW9glJ6Zuk
 /qIA2kvGdqbynaKxv4bewdwKGYv0+vOxKyLVr+ORgOT6+gRL
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

This was not listed as part of the DFU entry.

Add it to make sure that the DFU maintainers get CC'ed on
patches for spl_dfu.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385bf50cb48831049a3ee1189d75f579..114522c4758c0cee97a9bdb86a7a2c8b3bf3fdc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1073,6 +1073,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	cmd/dfu.c
 F:	cmd/usb_*.c
 F:	common/dfu.c
+F:	common/spl/spl_dfu.c
 F:	common/update.c
 F:	doc/api/dfu.rst
 F:	doc/usage/dfu.rst

---
base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0
change-id: 20250618-maintainers-dfu-spl-7e2e56b42232

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>

