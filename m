Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C71CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 22:08:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC7A846D2;
	Mon, 11 May 2026 00:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="eRhLHt+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DB9E846E6; Mon, 11 May 2026 00:08:26 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E01E846D1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 00:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 248DAB00535;
 Mon, 11 May 2026 00:08:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778450903;
 bh=9Py32B90x6zTYxPzkSCdE5wSBbSnNSlS3IUifIA5vXU=;
 h=From:To:Cc:Subject:Date:From;
 b=eRhLHt+QupDhVd+5S1GqglbIN4diK7ANZS0PCPEf3hg6UFhqJS6rASRxLxSwl48XA
 nHlO1PoFFw0qiQjLYHr85N7v4v0gj7QResEz77wBh6wnzIR6nnbghUjxW2WGitQW5u
 fjazPLXRbJW5VmeZZvOS2w3tHHyvdR8Fo3379s3pVFJDC2GI1b8GuN10dh/4DZkgM9
 9lZpobUdoIuhd3Q3QYqK8p69pzvyHonxMQnpApEKilOkOPJixmR0mtCA+//bJuXeIJ
 69/GH8KFS7WS/CC2MYHf39GgnR5p4VSLAy8f72hIiFd21BQGh/FXzg9PHtAoTWzuC6
 QHQNkJ1hi9prw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH v1] board: nxp: common: support CONFIG_FSL_USE_PCA9547_MUX
Date: Mon, 11 May 2026 00:07:30 +0200
Message-ID: <20260510220751.578230-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

Use select_i2c_ch_pca9547() only when CONFIG_FSL_USE_PCA9547_MUX
is set, but several call in board/nxp/lx2160a/lx2160a.c invoke
it unconditionally,
or using unrelated Kconfigs (CONFIG_EMC2305, CONFIG_VID).

Compilation with LX2160A target that omits the mux therefore fails with

  error: implicit declaration of function 'select_i2c_ch_pca9547'

Add a static inline stub with -EOPNOTSUPP for the
!CONFIG_FSL_USE_PCA9547_MUX case so all cases compile cleanly.

Adapted from the convention used by include/scmi_nxp_protocols.h for
SCMI subprotocol stubs.

There is no functional change for NXP boards: all eight upstream
LX2160A defconfigs (lx2160ardb / lx2160aqds / lx2162aqds and their
secure / stmm / verified_boot variants) already set
CONFIG_FSL_USE_PCA9547_MUX=y, so the real declaration wins.

The purpose is to support new boards that do not use the PCA9547.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 board/nxp/common/i2c_mux.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/nxp/common/i2c_mux.h b/board/nxp/common/i2c_mux.h
index 0870c1918e6..ef7ce8e2e51 100644
--- a/board/nxp/common/i2c_mux.h
+++ b/board/nxp/common/i2c_mux.h
@@ -10,6 +10,11 @@
 
 #ifdef CONFIG_FSL_USE_PCA9547_MUX
 int select_i2c_ch_pca9547(u8 ch, int bus);
+#else
+static inline int select_i2c_ch_pca9547(u8 ch, int bus)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/nxp-common-pca9547-stub
