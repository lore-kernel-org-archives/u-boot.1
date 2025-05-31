Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABA7C5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 13:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00C2B82B37;
	Sat, 31 May 2025 15:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fTEjVJ2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A6D182102; Sat, 31 May 2025 15:10:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AEB82AE1
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 15:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D1DBD6111F;
 Sat, 31 May 2025 13:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D04AC4CEEF;
 Sat, 31 May 2025 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748697021;
 bh=Z54a9U4uKb9N8e6Ikkjm4ImrdBA90F03K4ieE05Uodg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=fTEjVJ2Wy+ag+NaU45Rn1hHUMpbu0kgZ6tF8bvN8OcKuDfEyy4TwjLry6lVsOxtPc
 HjKYX/b4gnCmdgGx/Yr0V/H9W938YwZ7XKvccl45YGpf4pXDXgBj0CFeJTruo6Jens
 QMnrxmGjLGdsm2BrGDs/wJN4E0uv2oTkZO5Pfop71xrf9UyAWajbsALspp7cN9LzTb
 m8S31MrCBJrW2xGNs3vpcKKqJ/w2VbT3F2HWqhO8K3y5UwUySlHDF7BWwv/wM5Ui8/
 GoUBZvUvkDoYpwdjvhKKEX25cQgwtvzmTIYauxSYhEfdi71NgOSx50sfoeNUAHWS1H
 /Jsfgx5ZhVNBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1C46AC5B549;
 Sat, 31 May 2025 13:10:21 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 31 May 2025 21:10:02 +0800
Subject: [PATCH 1/2] arm: armv7: restore section to .text after saved_args
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250531-pie_blob_fix-v1-1-7b4a37987dbc@outlook.com>
References: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
In-Reply-To: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748697019; l=787;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=jpS30FhFq7BpJW0prlSwZ9UeWyw3m/sRYRuGCarZRng=;
 b=6g3n8LEXd5CF2RoHf/TZY2u8HdHXE0/xdLGXiVGwfCb+q7qz1Fn22/1hkLOTqAwYI73JrcA0a
 BL0AfPouGZnBeK67jql2ZnRkW9JqPdb4aEGHiPx1+PLwpva8auBD6jD
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

when CONFIG_BLOBLIST is enabled, the section is switched to .data but is
not switched back to .text. It makes all the code below placed in .data
section, also breaks CONFIG_POSITION_INDEPENDENT.

Fix it by adding `.section .text` to switch the section back to .text.

Fixes: 5103e69344d6 ("arm: armv7: save boot arguments")
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/arm/cpu/armv7/start.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 959251957de4..833486817f84 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -182,6 +182,8 @@ saved_args:
 	.word 0
 	.endr
 END(saved_args)
+
+	.section .text
 #endif
 
 #ifdef CONFIG_ARMV7_LPAE

-- 
2.43.0


