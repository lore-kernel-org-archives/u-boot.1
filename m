Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A8BC5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 13:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08DA82B0F;
	Sat, 31 May 2025 15:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZvDsSSO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD5282AE1; Sat, 31 May 2025 15:10:25 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D470782102
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 15:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9D2DF5C557B;
 Sat, 31 May 2025 13:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35011C4CEEE;
 Sat, 31 May 2025 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748697021;
 bh=oqtgR9Ttm29fv2XsmgYLt8RYqWSEnXj/XUuDIAYCV6A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ZvDsSSO59Ut7Z/WNsc3PNphRQe2T/lyHXiF+UqslNG/w7yUgYCVkoL5cZWMh9zeKL
 PlgxEQx5/Nkcyfg5rqHgfHmYtwmujtkgrVzKK1IhmMmtBvwtEuHFeHFLCOv1dLeMZX
 t+p/JK5MrVMCroUm5CtsDSjPwAIAGxQcP67vL3s+h8+u0v509Zn2ZlqWsho5xHjVoX
 whzcOMUNXkoSmWJMga2GnM7epd2n8P3iWW/Cn1SWYxtURf6Tcxr/K8RgHev4Xz3Km7
 AbB14PCcIe16xvtiu0NufuCqeJ1Ufmm52m77KUnSPWV0MH6Cfhd/CUehYBLqO4k31b
 V05LWFHUkVotw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 29310C5B559;
 Sat, 31 May 2025 13:10:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 31 May 2025 21:10:03 +0800
Subject: [PATCH 2/2] arm: qemu: Add imply CONFIG_POSITION_INDEPENDENT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250531-pie_blob_fix-v1-2-7b4a37987dbc@outlook.com>
References: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
In-Reply-To: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748697019; l=834;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=tmfpcKi7hSRAY+ZRTdHYSRSCz90BoQaXCuM3tnV10mM=;
 b=bslIUZLubvHfstdqGLkBVv0YZM9ELaZDqmAcUZghxEfADLEKlamBa9K4fzMcjSk9kSZOmuuDY
 VoTrLKGBUX2Aa33klr7f//foJGRqrxr4hSSEq94L46pIkX6REl5FvkI
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

Add 'imply CONFIG_POSITION_INDEPENTDENT' for QEMU arm arch. This allows
qemu arm boards to load u-boot.bin at any address. It is skipped by
default when u-boot is loaded by either --bios or --kernel.

To load u-boot.bin at a different address, one can use u-boot
chain-loading or qemu loader device[1].

[1] https://www.qemu.org/docs/master/system/generic-loader.html

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 79f60eb3f349..6ff3f2750ea8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1091,6 +1091,7 @@ config ARCH_QEMU
 	imply USB_XHCI_PCI
 	imply USB_KEYBOARD
 	imply CMD_USB
+	imply POSITION_INDEPENDENT
 
 config ARCH_RENESAS
 	bool "Renesas ARM SoCs"

-- 
2.43.0


