Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD4C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 18:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF8888BD2;
	Fri,  2 Aug 2024 20:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="TKIHg48t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF90C88BE8; Fri,  2 Aug 2024 20:00:36 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5157288BE9
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1722621628;
 bh=jdp35xC0Gr6kLcaEJ8Vc4EmeSokwFyEVk75lPiACHTc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TKIHg48teZml/mTuRQgyhsTgspypDATY101Dm9yOxCWLFtuBT5296C1mCkmJuI4dh
 UYo0bn6XPOLaDHeD3qdsKYpAfzY1JbME9xxkHIg8sLKPyh6lUc4NGZvOZvjRLHthTc
 9jKon5Enq7vfRxp8YoofVsEePbfbb3NtlghiFrwJk8Xw1PFX0lrcIZxQ70JxMuG4n5
 bJzID/a89Qn5oiuGRSo6uSLh6ZwIhcztU7FJNOuWw9thVtcMfekmw1I8rPTRYPQwxm
 jp3mYSUBBrh6J7/p7/VD25pfVMVsNuMNPJ/uJPqazXls3056w36Y9xHlVSg3QxuK0M
 +WUtE+C3z78Hw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5FB14378221D;
 Fri,  2 Aug 2024 18:00:28 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id D18D04800F5; Fri, 02 Aug 2024 20:00:27 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 4/7] board: rock5b-rk3588: enable USB-C in operating system
Date: Fri,  2 Aug 2024 19:59:34 +0200
Message-ID: <20240802180027.139193-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802180027.139193-1-sebastian.reichel@collabora.com>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
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

Since older U-Boot releases do not negotiate USB PD, the kernel
DT may not enable the USB-C controller by default to avoid a
regression. The plan is to upstream it with 'status = "fail";'
instead. U-Boot should then mark it as 'status = "okay";' if
it negotiated USB PD. Currently existing upstream kernel DTs do
not yet have the USB-C controller at all, so we ignore any
failures.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 board/radxa/rock5b-rk3588/rock5b-rk3588.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
index 1c17ae93c76c..4e926ebf2cb0 100644
--- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
+++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2023-2024 Collabora Ltd.
  */
 
+#include <fdtdec.h>
+#include <fdt_support.h>
 #include <usb/tcpm.h>
 
 #ifdef CONFIG_MISC_INIT_R
@@ -33,3 +35,12 @@ int misc_init_r(void)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	if (IS_ENABLED(CONFIG_MISC_INIT_R))
+		fdt_status_okay_by_compatible(blob, "fcs,fusb302");
+	return 0;
+}
+#endif
-- 
2.43.0

