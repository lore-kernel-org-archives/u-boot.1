Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02162606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bt10iCZk;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q7Aq0art
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3FA1813EB;
	Fri, 23 Oct 2026 04:59:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qjIP8A90kWcW; Fri, 23 Oct 2026 04:59:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B479F8129F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731579;
	b=eJvbkqHTYUboi/KKXT50a58W6l0HMrX3/cGhtplliMabeN2VjFpnDI35w7msjSWZAMOc
	 SGe6LqMEbvBNCWuPYe/g5CyfIF9lSKjWcA1LsRRTAtvMauqzCp0QL5T9P8YD9hTnnnzfZ
	 xG1Xp+KJemfgSBFOgiKwW80zjkowxw1xETNhS7JxO1RlbIutNkW39Ymum6qlBut+y1lz0
	 9vVhd/uBU0TudaSFOjowp/tN12IFnoKvgX3V3IBcvke62Hvgm6um0g0EfIyCmRDeukLBG
	 r99fx1khpxLlWGaBXU0sphldd/kzETMcV5m19sSvLE26E9RLikKgUQaUJzsGBMTi/qw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=BzAianqwjfKbu1mmFgOEg/OZIJXxfMfrXrEifesL0dQ=;
	b=Lch++gC5HYcJSBh9j4O41aL2QKmuB7bc7LaJs8Ctihs25SGPyhMMEyna/WPtikClG/IW
	 t71yNhTWtHEAk77OpDb7EzoqsrDMwZDlnIPK2SKeCFRI+kGLTOTNuGzKdHcRRRmGm0PR2
	 hnr0E1ZrlC3PiHIGzhM6AghnaEOfQh7gOHz61idhjSlJHOM4nD/gGYT/INc0Ijbgmz6dl
	 O2YYhnp9yCV2Ffq3uqTfo846dfmV5SQEtuWYPgVGNxowEgUMJFLPKU4hrnCh52PKlAYU8
	 Kh9m5VzxBTxPaXYeOhMHkJBz63CDFdhr/w67LCkH5i4iDEfi3hl7UzZiV0YTJX4wxFw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731579;
	bh=BzAianqwjfKbu1mmFgOEg/OZIJXxfMfrXrEifesL0dQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Bt10iCZkcDv5dD0/8SzLJKxa4mqnvvOHP7XHYgZz8P0bjrdsZ5nWCACWt0AWvw9no
	 eH7CWdZEeuC29yDZNZ8wITlzqf4s85Xw9QlzdVKM8lmHwYMMnqOb7LOuXMg75LXbVO
	 iyyGghSLQv4CLqAql/A6iLPUzw8I5Y0wwS0jH07oAZnOM8sZvfMx68CgKEf5EvPanM
	 KfONNG/f7DrTamUYTQvZRGJFimiyUN195cUY2XBIYAUFRL3YS9LokbCQVvkYbkap0P
	 A2vMe9gPMR109444N5FiMJX7dXPW3T0OXqD5VR3YitUC17EyQw+QYYaew9XfWvlFNo
	 tsakmdJyTvoew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B479F8129F;
	Fri, 23 Oct 2026 04:59:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A0D2356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E408D6063F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id flFFjiBZ7xcR for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 03:10:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA45560640
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792725031;
 b=jGv3XdaAF+xnxMcSW+PTIRgOV3xwDlZYsOFik6xHKHEj2+rOlrKo0L/0cp4/fEw9ucIA
 Ap2PEiC0LNku+H31rerVLqi/ruqlFjeka49i/jZR+S4N53cfsaPgmlZqfzXvaaz13l5FG
 XKnwK72uBF0o39ugJwu+5EAQgrlPf1a1rWv8Tbzew8gl17xGQVNgK/c92SQ3RlMIKwmFZ
 f6alSk2HxCf9KHndwkN8kjl+BeWjWMyhq/zMxNnf7N+YRQ9064hFeewUPVmImMvj5g4HZ
 EaO1inOa5sv5+gfK4nGH8XTOasmEmFwGxm2qbCC8Axo5hG2nw31m/3kM2xfXLOxb1tQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792725031;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=BzAianqwjfKbu1mmFgOEg/OZIJXxfMfrXrEifesL0dQ=;
 b=gsLsJmRUB1hFuDwg7RIf0LjCdUSxCT+L3o4Vo6AogGA9L3JLxnGo+eBhutH7OlwXbXjL
 ljwLDOaJ9MPnqLSbFs8LrDHyynRgDrEDwhVEvpdXqsjuhfT2Jz4SlbMIn9QiA5DUk2gR7
 VQvPbExVG5OghhCftkTLb6TX1z/x/efKs8+3PiTl0bs4G06zWNCL1XctAIG+VvR7cUYbG
 6iLpLRTYhEt/duFnX/G00M4YuNYBmKgCphNVtqMOk4q60wahtdeQFwFMnY/3WwZaKPdhc
 hwH/qhkXtmkLwDWLBeGyIRg3PFz0TyYhHvQ5SQ1K7k+BKoto7UFL5zXNnX1PdlDOn5w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Q7Aq0art; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=devnull+1579567540.qq.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Q7Aq0art
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA45560640
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:10:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98EA041078;
 Fri, 23 Oct 2026 03:10:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792725029;
 b=euFY5smGZCCzw8AkETgaC2BJDwSLY4vAWYrkRfltoak1MVQB3R0C3paWYzuoc4BVWnxG
 CX3e5QXk8x9LTkVdpeDpr1uvPKh386Gciu1A71YYdRa61qNM2KBKhkAOroLZH1ITJY+wy
 awZyeO+icpc6//gQKEE03FFcaRH4KND0TnYue0FkdSKv8xGMPtbH0u+beCfGXMr5oKadB
 DmKdIrY6BY6rmhAczd1WB3Y+/mcLkTqA07w59nD2o6C8SwTSzroK6WhNygTHMe1fLam48
 WKwS8G5Tf6HR1riaEalvgDWuOyfzgzBnwrcdfU6HvC8IuySMhBg9ThtVxXqWWxGDmdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792725029;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=BzAianqwjfKbu1mmFgOEg/OZIJXxfMfrXrEifesL0dQ=;
 b=i214q13lo70xS8i1iMXv2HfAsDCYn1Bn35OIw/ic4wrqNOZwSaZajIPiQC7RNPdQOQXn
 GgYzT4DHUyq+gU8ysMvF7KHlg/dLt17tI+5tqpLtuQt5SssmGK5tIanuvq+4dgppm9ABW
 vL43tnM+EZbgvAoiD6695LkDXaNI0ean2V0JvnUDB/f7wN2g5plkw4ljRBKCKrjsvHwJO
 X0fQHCev5Njn1xO59wGqV1NvuOiikbq/zYM1H/Pzop2+Gh0f1sLeudDTOy5YGYJkVrrbs
 CQv9S6Yt353XkF2FLRC2Q54J6zPd8i5QHFTF5VvTk/EHGZNgcgH01YqEpR2aOuOjDnA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 067021F01828;
 Fri, 23 Oct 2026 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792725029;
 bh=BzAianqwjfKbu1mmFgOEg/OZIJXxfMfrXrEifesL0dQ=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Q7Aq0artqGqZZGh+mBIji9MLj8etz1QzLWmwN4dPg1pRq7ZfY/wDCTO0BKgjp4e8C
 Si6aN++6+5wYmCZ+OaE08/F/tLy7zXP3BPLiPGmfs8ZbQ6zXonb6yd0zdzO4hemdfa
 SmlmJ50vYg42J87erS+4+ComWCPuV1+M0HztwYCfSl1DZXZC20O/mLjTFOVi4F31aB
 Om4DQ+cTS0a0cDnp6g9jkpFP79kY/FEq1BdvM0H4KNYBDfin3TgzZXSRgJF+hET0Tm
 M66U9+jKRJYVoLZROotLRGkZQSDrFOk4uzjtaAWbHtWzk8e3VyJeF5nwrb7b51rrzV
 ef8ZduOCrffpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5DCC2421BF;
 Fri, 23 Oct 2026 03:10:28 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Fri, 23 Oct 2026 11:10:23 +0800
Subject: [PATCH v2] rockchip: ram: Fix LPDDR5X size decoding
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-lpddr5x-size-fix-v2-1-508af15a8200@qq.com>
X-B4-Tracking: v=1; b=H4sIAB7Q2moC/32NwQ6CMBBEf4Xs2TVsjYie+A/DobSLrFEKLRKU8
 O8WvHt8k5k3MwT2wgEuyQyeRwni2ghql4BpdHtjFBsZVKoySumMj85af5wwyIexlgnrismQpiy
 3DHHWeY7xpryWPw6v6s5mWD1ro5EwOP/ePkdae3/0IyHhIctzRadKa62Kvt8b94RyWZYvBSsIt
 b8AAAA=
X-Change-ID: 20261019-lpddr5x-size-fix-fbe1c1a168de
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Anshul Dalal <anshuld@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792725027; l=3059;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=Bbkz+sqnOaC5URhlYmuQwWxOxVGyouyfDvk0pO4AQps=;
 b=5b/+ZGGowbFUGMrs4DmKe9fN3nFqSq9EADGGIk17+MtRi55yYDlnecYI37GPC1AyO0sY7oB5a
 eD8jHcXnzP1B8sLssdSvxAjH97qHdWLRW7QvliKnRgiNFHgqa2T2gVy
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: 1579567540@qq.com
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cunhao Lu <1579567540@qq.com>

The shared SDRAM decoder treats type 10 as DDR5 and uses the wrong
bank count for LPDDR5X. On the 4 GiB OK3572-C, register values
0x100043c1 and 0x30001001 therefore produce a size of 1 GiB.

Replace the DDR5 symbol with LPDDR5X as type 10. Apply the existing
LPDDR5 bank decoding to LPDDR5X so the same register values yield
4 GiB. The type value matches include/soc/rockchip/rockchip_grf.h in
the kernel-6.12 sources of Forlinx OK3572-C BSP Alpha1.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---
This patch fixes LPDDR5X capacity decoding in Rockchip's shared SDRAM
decoder.

The geometry registers captured on a Forlinx OK3572-C with 4 GiB of
LPDDR5X are 0x100043c1 and 0x30001001. The current decoder labels type
10 as DDR5 and uses the generic bank calculation. With the bank bit
set, it assumes four banks instead of 16 and reports only 1 GiB.

Replace the DDR5 symbol with LPDDR5X as type 10, following the Rockchip
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
Changes in v2:
- Drop the DDR5 symbol instead of assigning it type 11.
- Add Jonas Karlman's Reviewed-by tag.
- Link to v1:
  https://patch.msgid.link/20261019-lpddr5x-size-fix-v1-1-3688217baaa2@qq.com
---
 arch/arm/include/asm/arch-rockchip/sdram.h | 2 +-
 arch/arm/mach-rockchip/sdram.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
index 476fc1c4ee3..1c28d4aefb9 100644
--- a/arch/arm/include/asm/arch-rockchip/sdram.h
+++ b/arch/arm/include/asm/arch-rockchip/sdram.h
@@ -14,7 +14,7 @@ enum {
 	LPDDR4 = 7,
 	LPDDR4X = 8,
 	LPDDR5 = 9,
-	DDR5 = 10,
+	LPDDR5X = 10,
 	UNUSED = 0xFF
 };
 
diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index 2e404df1b20..b5891913701 100644
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
base-commit: acc808479730e13e74199119eb9b2b9113999244
change-id: 20261019-lpddr5x-size-fix-fbe1c1a168de

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


