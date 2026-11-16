Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B2D606A889
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z2DZg+z2;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=ADjYbEqC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A61AB80F19;
	Mon, 16 Nov 2026 13:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5V0UrZS7Qgyg; Mon, 16 Nov 2026 13:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EC60680E03
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837376;
	b=j9/fCoEZsAr5zC8kpyDr71jjmRWltQmH25/rlfHv+PQ1QNCnTVtfveQUdv4g7oVz67Bu
	 V9HpdE1OQAa9Z59gyHkSNWyeHdRkheYq/jJfF4tvdxMz5vvCRj1qLGUVv1HDwAqVAGb0Q
	 jDrtIK9m9UK0CS4Gd+BFoRUtikrmGd6T+lP/omTDlkStpG7OLlxMAoXusQhI+02A7q/Sh
	 F3SE1Kdmbrdx0iSKJaXkW9KbSr7KnRTwu8UBc9iZ43X+wDl2LWC8A78TYC7DlI9O8CGsE
	 KKiEifO7WN/wPSTNOiMrUKZww8BRR1Ybsjvrfvg7Y5VQZufpKiWlcoVXL6CFGMcYDtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837376;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UAb8TP7wGhmfwScJOiwkQJ26iEQMxemS6qNxU5argrk=;
	b=EdS5MTHxIuYXFGflsdIURTxzlLv8AWoQbxdO30/4WrX1VLTGPtZVeC2Brhv6eSpJDSm8
	 FTuKBis2PHToWD7LYTnRcd+WMeMQ9qTgmKtSKPVvAFAyKS9dUChJmcjK8dFrJBjo/5WRX
	 hMNU1wBuoM7tIWssVox6AH6zjh/+wCfpeiD7Y6eMvlQshUk/ZnZsuzrqOwHgMD+6DSqvn
	 u9as/Z//gGhpsWshNk+2ZorBPzTd+Jb9b7ltM/0rvrrQuUiqac5xYn/N9Vipwq8Nlh51h
	 VyLXMPKFwmytfbIDVxpeXSVHBsNI904y7u2R+OuhG/mlCv5gQ7EvonNMKrM6MPbqyEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837376;
	bh=UAb8TP7wGhmfwScJOiwkQJ26iEQMxemS6qNxU5argrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z2DZg+z26bG+I/E9pA9JN1fjYW7wHzJIBRu2fz/e/S4lsqzbH96IeBKeMSjIrdD6a
	 XJWFwJk0H5H7rc6fv7jR/81BMnZAcHJ4bQAgd7E5mAqQ3K3cx1w+IkpQXMlZDlDVbM
	 Uvd4Jv2psEW7BiQqnhxDFoMR0t9c5Y+McEfguG0P4cOz7Cwk8vLVpC3X8cu8oMYdc8
	 oE3Ox/Y7xMN3Y3fdzOKI5RY+hF9ccdvlWlJeIK0VLkkRZ7JZJtRrop2fUPr1yHqbrO
	 3gJXnbShg2dIzOSFsdrdUCRjZbYCPxsjJ9tMhOkwibp7XO7Aw4tx1wFpvC2i/sWbM7
	 1Lt6YWpmVRI5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC60680E03;
	Mon, 16 Nov 2026 13:56:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F24B2109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7EEE607B9
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mUbaSOGjw9o5 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9BBF7605DF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=ADjYbEqC
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BBF7605DF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:56:09 +0000 (UTC)
Received: from francesco-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id D5B66221F8;
 Mon, 16 Nov 2026 14:56:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794837367;
 bh=UAb8TP7wGhmfwScJOiwkQJ26iEQMxemS6qNxU5argrk=; h=From:To:Subject;
 b=ADjYbEqCsCFLAC+JPZdj8BSDmACxXcDG611xJIQO9U8jfvhYyZAu2MiTdxiIeXKmW
 VjlVsXRxW/avTIM8/qqPIgQYwqnz1HGD105Ukc/4BHCJFupPo+EeO/vC8Q7GMi+xLK
 YliSyk2a9L7T4naNdKFJwG3KF3VNPkBNyonwDqhOyzXHGDczFTu5fl7wmTJYGo2Eku
 brgUUOraM0dKyhdJHV6Iespxh+PyjNw0vhNFavxu6kAsjJl6UG9oCTJU1aWlZW7xoM
 /nI2iyAyl4qfvggwkf9rHYXu1UUhcVGd4hKFn15dR0lxRgWwdtV8DMLk0WrTWr7G5u
 R81qe3i3ANUdA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/3] board: toradex: verdin-imx8mp: remove
 CFG_SYS_UBOOT_BASE
Date: Mon, 16 Nov 2026 14:55:55 +0100
Message-ID: <20261116135557.187445-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116125622.174214-1-francesco@dolcini.it>
References: <20261116125622.174214-1-francesco@dolcini.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

CFG_SYS_UBOOT_BASE is only used by the SPL NOR/XIP boot code, which is
not enabled on Verdin iMX8M Plus, and the module has no NOR flash.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/verdin-imx8mp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/verdin-imx8mp.h b/include/configs/verdin-imx8mp.h
index bff417fdafba..4b09745de49f 100644
--- a/include/configs/verdin-imx8mp.h
+++ b/include/configs/verdin-imx8mp.h
@@ -9,9 +9,6 @@
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 
-#define CFG_SYS_UBOOT_BASE	\
-	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
-
 #ifdef CONFIG_XPL_BUILD
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
-- 
2.47.3

