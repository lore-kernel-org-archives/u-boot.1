Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AFECCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 07:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7F42605E6;
	Mon, 19 Oct 2026 07:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZWYDw72qT1Fr; Mon, 19 Oct 2026 07:36:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3124160606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792395382;
	b=dq8cX+XdSqii87HDA9eHaGVxTSXurbylJ5CTUBqScIdrJKQ9WRJNq5z5Nanr8VPMfJD3
	 CwsinOkFK4Fa1zFO1BfBpTCpKCNTbVUgXwkpOCIJTdcmPqhfTRckt4rI1YCPN2/JCes3A
	 wHl7lH70pe5aPXYgOaeDduiD9W/DXoEGxv6rarto6XJEM2GmhkOIIyHN4VRjmiEvO+qag
	 cY3bZz2iWyFf6HhHyB+/H3opja96rLhJ9R7OISfO67KSS8zQfwC/ls4PS5+ckEXmaiAg8
	 PgkBoBwbmSmWHX+oFV/aKG7ZLIXlV4vYCN//MVKCNo7sGqH+RoOpwsubyqiAB9UJqNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792395382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=rfSDuo1WkvALtTPOm448g4cSmW3ZglDjYlqFFzRLqzE=;
	b=W/lUM1IAujVf0lF56HJ/z0RS/rWmpk41k01YB4RI7g51W3iBM+VNd5TqpDueNxkvA/84
	 2WAc0fqpataNDghnuRoOdaDm4euuaa7N9w5DkYyhaTocq2nhLL6CI4UtTWHs5X/dotvho
	 R0wKNRFnzfxIvCCRlzrFC8oUG3FY5T1S/yNKityPn77dva2Xybr6TGaXQwjx70OCn410c
	 9gfuQfKWsg/dcjyJvdZKzZmYrq9s8om34vx4OzHixr0btog2ZxovHh8IbPC6LHBHSF1g1
	 zvNwuHmpjF1zyNOY6FnIT1jzD0aMX1YRtRM0UCWaM73kxJF5R2hhFWC0tFqg/cSx8XQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792395382;
	bh=rfSDuo1WkvALtTPOm448g4cSmW3ZglDjYlqFFzRLqzE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Iyj6jt9+MpKIRRZyyeChsUS0SqVfIC4FG9Pyjr6frn+g7n+E2SgTqk2sdQuQd4/YJ
	 VMoMSNNerd1KfexDGDLqWa+gKsWg8ukulJUoYz14Ic1AEBHX0tf1rXJQeljMjnaNgw
	 9jjAPK4qxCVzhztrs5SnQg7cKfj4D4fiPBwAMQpGewzNC8yjieRBziuqHrqkDALdth
	 gBAFDW6fm3xuD50Lhiz5zt0aVVSdon+TEj3rPm/R1kMRKDnWyZx+6tFF3TL61Ycla4
	 SMK+Lud1pKt2DPuCEQzD/nLTCKjSddTZHI3jmQhUeYdaW4XKLv8Ns6IWGvqAPG87cX
	 8eWsBVgjpi9iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3124160606;
	Mon, 19 Oct 2026 07:36:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38A9275
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 07:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AA25401D5
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 07:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbUUVAx490tb for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 07:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 717EB400D5
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792395085;
 b=Y4aWkXXa9I5i5Qjc9ORrHZgYgPEhmrdSLBiEibsZrfdd/KL8SnhguBXI4WR/nBbZ9Six
 e28ZUAkU64Qx+LG9r5at1qkWOkOpc7dz6A6BmPD5Vd51p3+Snfd9hclxVaBCHk1RK7zt8
 V41jcCfjI4b3XmJfc1FZGC9O+NHvfrwyFawG46932vABCMdFkRTM5xtevdKpMYojff9ui
 qlExl/xfi/Ww55M80mfUB+AHPhe9QltNGUus+YXhApiVlpJu4XwTMz/ECjC6YykktZe7L
 stxyaEPcuvV74xJZytX34rKinKwyCQEPk3vEvErvuTIItoOiN53hlC14DzCf82ARn6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792395085;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=rfSDuo1WkvALtTPOm448g4cSmW3ZglDjYlqFFzRLqzE=;
 b=fScTRA1SM9KLNbRlljRjuG0JgETqEyNIHffANZ6+9GDcyEm8g3YReDHHOq1+htp5dDQt
 VQ9v1r9r8Gn0fG0y0UyY7JjraSXsjd2T81Z6pREtR0lrV6mnCRuJ/kYtxRn0bwnfu8mmP
 V29MSwtNikZNJ37Og4yPtQZtlZFql6snQOyes/GiR1PmwqVDoLxPPrdrenqKX1hNjLrFT
 a5PohYQPif45/+KRGWXIBMjML6BXobNKTii7sQaBKwFCHPP9Y3JFtuEcxKz1Pztgr2GkG
 noDRqOIT02C89ah2GkejLh4CtKlMEASikgFH/49Aaf3MVlTHk2kmM3xoFZDlyn6mgeA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cXfOhNtl; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+1579567540.qq.com@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cXfOhNtl
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 717EB400D5
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 07:31:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 48F82437C5;
 Mon, 19 Oct 2026 07:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D425C2BD01;
 Mon, 19 Oct 2026 07:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792395084;
 bh=LYj/7xNTefmKvoC2D0fM82n7tRh4bFr/M132dCZaLPo=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=cXfOhNtl3oODHP59BhWLHQ3HMztfPoQKiTsIP1a50DnPkrBwSgoC1gMC0Qbf9w/MD
 fnAOeBYHUBtcOZY5mO28IN5rtLOxSMoMCs6C++O0kGp6zAw6PAYHSIMCDkSH5h/oPt
 OL9ANHGkrxd0lEFKc5Ca/Ri8xa87Q/XCpMBj0tUloSbID/pa+xTozSu/Smhglyg85l
 EZpZEdBKCEl3kOlrSsJOBWnvFrE7nUg2ZVYel0TD6VkOUz4hGyscG+8JPBpNxAeaem
 nY+XnHXjFM0KID5u08s7+uoeZKUqLSkaa5GsZB96uqVm07XcG2y6DnijQWkENiwWg6
 myosu3i2IzDfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 16D2BCCF2D3;
 Mon, 19 Oct 2026 07:31:24 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Mon, 19 Oct 2026 15:31:14 +0800
Subject: [PATCH] rockchip: ram: Fix LPDDR5X size decoding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-lpddr5x-size-fix-v1-1-3688217baaa2@qq.com>
X-B4-Tracking: v=1; b=H4sIAELH1WoC/yXMQQqDQBBE0atIr22whUjMVSQLnSljixiZjiIR7
 +6oy1dQfyNDUBi9ko0CFjX9jhGSJuS6evyA1UdTnuWFZFLyMHkfHiub/sGtrtw2ECe1FE8Pirc
 pIM5Xsnrftrnp4X5nh/b9AIm7Afl0AAAA
X-Change-ID: 20261019-lpddr5x-size-fix-fbe1c1a168de
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Anshul Dalal <anshuld@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792395082; l=2803;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=uoV5703LbUklS2lJ/0yaFsSZJhHH9ohGZItMvS3T4MI=;
 b=OwlMi7Oox5Q027sA4pWfN2ECgwJ6HC9eKx+Z+CtY4NrkhD+cM2XvViZ3DrYQjYlWDL/2TbCPN
 ulKj2h3auTxCfmu0Qz902eEU6ZLnFX3zt2t6XZgZ5P7Ez2PMONtFaJj
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
X-Mailman-Approved-At: Mon, 19 Oct 2026 07:36:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: 1579567540@qq.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Cunhao Lu <1579567540@qq.com>

The shared SDRAM decoder treats type 10 as DDR5 and uses the wrong
bank count for LPDDR5X. On the 4 GiB OK3572-C, register values
0x100043c1 and 0x30001001 therefore produce a size of 1 GiB.

Define LPDDR5X as type 10 and DDR5 as type 11. Apply the existing
LPDDR5 bank decoding to LPDDR5X so the same register values yield
4 GiB. The type values match include/soc/rockchip/rockchip_grf.h in
the kernel-6.12 sources of Forlinx OK3572-C BSP Alpha1.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
This patch fixes LPDDR5X capacity decoding in Rockchip's shared SDRAM
decoder.

The geometry registers captured on a Forlinx OK3572-C with 4 GiB of
LPDDR5X are 0x100043c1 and 0x30001001. The current decoder labels type
10 as DDR5 and uses the generic bank calculation. With the bank bit
set, it assumes four banks instead of 16 and reports only 1 GiB.

Define LPDDR5X as type 10 and DDR5 as type 11, following the Rockchip
type definitions in Forlinx OK3572-C BSP Alpha1. Use the existing
LPDDR5 bank calculation for LPDDR5X so the captured register values
decode to the correct 4 GiB capacity.

The fix applies to mainline independently of the RK3572 SoC and board
support.

Host-side validation of the decoder with the captured register values
reproduced 1 GiB before the fix and returned 4 GiB after it. Regression
checks for eight other memory type codes produced the same results
before and after the fix, with no UBSan errors.
---
 arch/arm/include/asm/arch-rockchip/sdram.h | 3 ++-
 arch/arm/mach-rockchip/sdram.c             | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
index 476fc1c4e..f5a213fde 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram.h
@@ -14,7 +14,8 @@ enum {
 	LPDDR4 = 7,
 	LPDDR4X = 8,
 	LPDDR5 = 9,
-	DDR5 = 10,
+	LPDDR5X = 10,
+	DDR5 = 11,
 	UNUSED = 0xFF
 };
 
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 2e404df1b..b58919137 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -403,8 +403,8 @@ size_t rockchip_sdram_size(phys_addr_t reg)
 		cs0_col = 9 + (sys_reg2 >> SYS_REG_COL_SHIFT(ch) &
 			  SYS_REG_COL_MASK);
 		cs1_col = cs0_col;
-		if (dram_type == LPDDR5)
-			/* LPDDR5: 0:8bank(bk=3), 1:16bank(bk=4) */
+		if (dram_type == LPDDR5 || dram_type == LPDDR5X)
+			/* LPDDR5/LPDDR5X: 0:8bank(bk=3), 1:16bank(bk=4) */
 			bk = 3 + ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
 			SYS_REG_BK_MASK);
 		else

---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261019-lpddr5x-size-fix-fbe1c1a168de

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


