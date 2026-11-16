Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33094606A882
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PyCII0mu;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=l1jlWw2Q
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05BC9607E5;
	Mon, 16 Nov 2026 13:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zi65M8E88eaY; Mon, 16 Nov 2026 13:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6345B60777
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837373;
	b=QC5KUl4ZpHB1oMIvrfCRPIZ3fj05SNpGHWs2vyqkejW4b1mX1iukeDnDDCAWoXWue8az
	 6yu9he2pVZKwwxUd1lWYTo+VwgZjPmsnG9y+uzGuMjXfPMb+nP2whCK2CP7ple+3zVYt9
	 i4tABiCam81u2/SKGoydvb4WwZ80JPtE7bnAaA/Igy3GYQNL9uRyu64Fr3lNQJ1orU6/2
	 Sl0bmHTLCN2kKZh5G8SZ0JuFDGN/zDecT3uLog8U/PyTGIgzhy4N1+v2q6s+79WMedkP9
	 5K3o/AMrtMx9BQKQTMD56NGGSlL2pbOxdqA8uR2t+1TfDepXmp/+SFVIOIc9XFEZCQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837373;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Shc33IVqJQoF6Iwj5rszf/JZL7LMeCMpJ1OhnuWzJuU=;
	b=Dq95L7kN73bdBtwf92RVPuc30PaRb75HdI8UjEDMxsjAVOXCSJgdYhcZ7HiPKYMuK+Wz
	 1uM98caXG9ebKDkop2w8I/yfD0n3/nOVfPax1/5D8A5C9lHUnnqUHU+jfkouej7yz1DNX
	 VkbBj/RP7gzldEVuIa+6FCCv6L+K1DevuU1jE6AYcdggb9HYrC4SF8n+4Trk9BJI3oNKr
	 NuOOZHd7nByEpeIT992g302H9AqETWRAr5GhNMlo58cnLQ4Nx5vdyPBF+I1Pi2i+1ewjG
	 tZ/YC6rsxbFLxG50n7qz8jjp7NHWWL4TLj7USoCdqcz5+jyugAinzygg6vQ7sD4AXhA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837373;
	bh=Shc33IVqJQoF6Iwj5rszf/JZL7LMeCMpJ1OhnuWzJuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PyCII0muNebPIMhyyM4ZDh5mMIKeuX0ENyzSakY83geZh2Pp9gJ9pc8eTPQUQpGIO
	 Nzd1dXD2TFt3M+fIMiN05If3pnyRMLuUu9jTzGQiq6fU9D+wQHFddbVmKCB8kzaDXQ
	 coezUZ83tW7JGeZ1f9ITGxqk3LBaJPMmnMb2tU4G2yMxCdXeub8xhmcTQgZ5biuwUl
	 sz1cFi+XCTvY0RjQPpu3NemGcQJFJOCyP7sobhO9Eyvz77ifqqcUFtj2+yNDSBRCEd
	 T7xu4a4Po/oec83HSKYe1gEKQLow6KZe4TaF5T9GaGBm/2590Pmp7Y7++ZXmVPXxjk
	 7f3n1rJx+XCIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6345B60777;
	Mon, 16 Nov 2026 13:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8292428C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7449740274
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-pqjiSM4t-M for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CE0FA4009D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=l1jlWw2Q
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CE0FA4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:56:09 +0000 (UTC)
Received: from francesco-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 3B4EA22206;
 Mon, 16 Nov 2026 14:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794837367;
 bh=Shc33IVqJQoF6Iwj5rszf/JZL7LMeCMpJ1OhnuWzJuU=; h=From:To:Subject;
 b=l1jlWw2QOgw/aYUarPHMMr3OeFGOlvvcFsx2t4FYEPs51tWHvuS1gr3UpMYJUfQKU
 ftNHLo0Dsk1eDI7asVMrfr6cSdAfY4ZYC7+wiCM1nzKoZsuV5BgcahetZO1nH4fPI9
 AxTlOi56VD8k7HZ/NTpcdK/XoAF0awT+BHiBTT2Gx3+F3PCVt2UQ7EP0c5H9yuWUbu
 HC5JnsvGrXrYcp/kAaGgy6RmaxQhWobqtpKXSN6VuGhdF2f2y5dUzBo1ZWFaG4Lwh6
 eS0NtikV7IDNVGw10nKnXuQuoTX8ikTkERpiizw7+GHeuSky3b/j4sN64yYfo2+4M3
 zU3RjzhFmCckg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 3/3] board: toradex: smarc-imx8mp: remove CFG_SYS_UBOOT_BASE
Date: Mon, 16 Nov 2026 14:55:56 +0100
Message-ID: <20261116135557.187445-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116135557.187445-1-francesco@dolcini.it>
References: <20261116125622.174214-1-francesco@dolcini.it>
 <20261116135557.187445-1-francesco@dolcini.it>
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
not enabled on SMARC iMX8M Plus, and the module has no NOR flash.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 include/configs/toradex-smarc-imx8mp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/toradex-smarc-imx8mp.h b/include/configs/toradex-smarc-imx8mp.h
index 3d5fb854fc80..033ac6472a75 100644
--- a/include/configs/toradex-smarc-imx8mp.h
+++ b/include/configs/toradex-smarc-imx8mp.h
@@ -7,9 +7,6 @@
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 
-#define CFG_SYS_UBOOT_BASE	\
-	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
-
 #ifdef CONFIG_SPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR	0x184000
-- 
2.47.3

