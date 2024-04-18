Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA95C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 07:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB4287D6B;
	Thu, 18 Apr 2024 09:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Dt4uhvnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3EFB87D6B; Thu, 18 Apr 2024 09:06:51 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E78387CF8
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 09:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713424007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0wzqcfFFtSrOkEkbVjRByfePp/A3FUTb64NCC73Z9fg=;
 b=Dt4uhvnErh9EipyftURSFXE64y9ocoemP+hNU/084xfRMchxnZNqZxJTgLSWAhWmOPGUb2
 GM6BJ9n6K8IzhJi7RzQ7YJt05GYLXRQwYhqdRZwPvjed737FbKCjY0q5lQ18d/seQ0SkgH
 gaLWRKxLlY38Fev2Amif6xk3PoW5oSi4vUW88dwQrMg/O6oJ8uOhFK+t7v+Smmmr3KvikP
 yjHEy57NjH3pMsgRQj4gkOF+IGwcijjROYe408O6i0uPePu/cS8eSCjXMzZK5jY/XCRqhy
 GTaKpKwKd91uUXchGQJncMCqSrdk0Pk4PyexJfhXjFaTcbkqbhfBhYD28nU1BA==
To: u-boot@lists.denx.de
Cc: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Subject: [PATCH] board: rk3288: simplify the DT file list in MAINTAINERS
Date: Thu, 18 Apr 2024 09:06:38 +0200
Message-Id: <369151a2b8d73d733ca79eca98d4d5958f90d491.1713423687.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Use a wildcard to simplify the list of board DT files in the MAINTAINERS
file for the Radxa Rock 2 Square board.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 board/radxa/rock2/MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/radxa/rock2/MAINTAINERS b/board/radxa/rock2/MAINTAINERS
index 5328fd76014a..af974c983047 100644
--- a/board/radxa/rock2/MAINTAINERS
+++ b/board/radxa/rock2/MAINTAINERS
@@ -1,9 +1,7 @@
 FIREFLY
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-F:	arch/arm/dts/rk3288-rock2-som.dtsi
-F:	arch/arm/dts/rk3288-rock2-square.dts
-F:	arch/arm/dts/rk3288-rock2-square-u-boot.dtsi
+F:	arch/arm/dts/rk3288-rock2*
 F:	board/radxa/rock2
 F:	include/configs/rock2.h
 F:	configs/rock2_defconfig
