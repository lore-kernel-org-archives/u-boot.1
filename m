Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F42BC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 13:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59CFF87A77;
	Mon,  8 Jan 2024 14:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IkkbJTpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57AF587A7A; Mon,  8 Jan 2024 14:16:59 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B68887A76
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 14:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id C096DB80DAD;
 Mon,  8 Jan 2024 13:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E67EC433C7;
 Mon,  8 Jan 2024 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704719816;
 bh=XX+tXlgHl2iqGFIc4EXIARMqCoYd4xBRTovr/iW/914=;
 h=From:To:Cc:Subject:Date:From;
 b=IkkbJTpmMAP7e5Q4CdinDNU+LNi86iB6lfGzkbqLa5MXCQVI+sEyIK4Gv9GCuS7PI
 Cbw1CILqDj73WSWadN0DxV41wTjVmI6z0qTYowMu0Rsrt5FFnecsASMvGBhVdZS4Yt
 zsL7eYc1bb8ulja8cFMhveFrQPxY4BAh00pNNIlAyjsBf4Dg6za6ZMYJhysOX7cAC3
 RGO9y7/Ejb++v3DbFGhvSvfKRWgp+5nDo+PI8blpBE9KCtdlu1l2W5Exj8zXeEtIRm
 HarCauAqQjxytClf3L1wB58jdTYJNKcmlPL8gyVCoOVNV+nQQqrhww5o4aY2trgc3G
 DHpg4Y+k3yIkA==
From: Roger Quadros <rogerq@kernel.org>
To: vigneshr@ti.com,
	trini@konsulko.com
Cc: praneeth@ti.com, nm@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] board: ti: am64: Support TMDS64EVM
Date: Mon,  8 Jan 2024 15:16:50 +0200
Message-Id: <20240108131650.100519-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The TMDS64EVM [1] ships with AM64X SR2.0 HS-FS chip
and a slightly different board name in the board information
EEPROM header. Support this board.

[1] https://www.ti.com/tool/TMDS64EVM

Gets rid of below message at boot
"Unidentified board claims AM64-EVM in eeprom header"

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 board/ti/am64x/evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index a6dcff2eb4..a7ca6be436 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -18,6 +18,7 @@
 #include "../common/board_detect.h"
 
 #define board_is_am64x_gpevm() (board_ti_k3_is("AM64-GPEVM") || \
+				board_ti_k3_is("AM64-EVM") || \
 				board_ti_k3_is("AM64-HSEVM"))
 
 #define board_is_am64x_skevm() (board_ti_k3_is("AM64-SKEVM") || \

base-commit: c2c598e87cfe56f5991730762c00733c5aa9a994
-- 
2.34.1

