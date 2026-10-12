Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684F7CA9EDE
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8361606DE;
	Mon, 12 Oct 2026 17:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfSClezyP3j1; Mon, 12 Oct 2026 17:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1589605AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791826652;
	b=ZDWZR66QxMszKruBG/jqmeiARazbbVekyxutC3NVFii34AulPyeer9xkxm7+e84qsVig
	 nDrZ331/8wfZFXj7uh5zlD1AK5HbqbTXaHc/hFFvont3l99dc2Gl9vwLMK8bEqxJeLjBP
	 0ovYKvUbBtQ4YfrBhvxy07lv1ZB5b1mW/r/fwHpx+2Cz0ph8mO0FNUcx/z3WMw1/0H4Fq
	 X9HrOfTp+kWdpa/O27PrRh4DOLUtNDe61dK7Rw55zxxKTTFxDh1BQLzfyWsa2Dgwmmyzt
	 RWEhC+Rr/Q/TVTrauu4z6pVHkGsZRFxDsrXCcupUhrDmBIMW+da63zfTH5Fxko/10gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791826652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PC9rLfORlBTlP0+RD3oiA9zopH5BkTxUSbJQueW6GR8=;
	b=B1gPtc2+8dJKWWt2LeR3pnw5dZea1Ao8pX3RjAIRBqJAdYjP8+lMtAhKvYPnolkr4++v
	 gR6ZqdlMortoscP+sjDC9zc6ZURgyNSyUGdk8LdWr7JETRNF6GS8Y3sluIA5iGbYIJa1y
	 ePMmAfALsqBzTtIUpldKzzuNqYQeO2zr7P8eUtYvmU7OQAy9BpvwUg6AUa+q+uqzEa5FS
	 dZKiw+HKxb0VWqerqTzukbPihpLdvOqz3lLDddTuQAGG5A25D4JfToJ5Wz2mwbRktoyv4
	 bMUGd1Shgr4BtRix+VX5148pWR2YSXaX50i3m17RZ3D0gBT+Ud6wdvDfmJx3EIUw+tg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r7LEV8ZG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791826652;
	bh=PC9rLfORlBTlP0+RD3oiA9zopH5BkTxUSbJQueW6GR8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NTH51A5bMI3AdCsvO1fXAMueBxiunY4F8kIya7kNtctmgLe3qqIBHVal84DuNs79E
	 phlxhB/C5aadRuHJGrUG5ddIna3vjib1kEKOE/aDjtT25t2AMhZGUvvtNXDv2Rf1kj
	 WBJcWZF1dtiWwoNxDyIw6HQdvzetIKziE1OoqZQo0eKy0Ns53XIbnYqd8PnGND086X
	 bgXFgImk1ca6AWmbk3BLzonJpsc8whDQSLxJuUJ1hByzZtIZZUsaBciLgVZ8jiPV/T
	 hAy4fIFelb4vywFierI0Yk1H2k9+d0Jlrha1bmesUHVKeMZ3P7jnKX/Gppod2jiWYi
	 JeEy0aAqi0Kpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1589605AF;
	Mon, 12 Oct 2026 17:37:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DED29380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C506D60680
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NaFeDg0odZs5 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:27:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EDD2A605D1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791822471;
 b=A3bLZ6TcbTLrxNO1jmcKHP8BwAqkShXt5sBXszGZc/bN3Qph+SFm/fAvEPETZybITp9y
 gHQrujeCIpMCW8nVifrXI514I0yNQ/pD82jZMjDn0MpgbIzE+0tgh+zjDko7aeET88Mcj
 JhLYzOPcGeG9mSh9ayJoKyUm6TnTI+4n7zQt9rQs9wEp1wgvBNBYYhE41YgLai1W8cR1A
 4BqyXIy7nnk0NF5BgqFhXAIQ/1Z83/trXtpeK5PRFR94OTnjBHuGv/WE6VoJfDdbTS272
 PUScccQPJuJG0SVt0mF0aOI6F8VFUkWfGHxmCETeOoSMYoGLB5vpg2kqsA7SrcOP+JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791822471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=PC9rLfORlBTlP0+RD3oiA9zopH5BkTxUSbJQueW6GR8=;
 b=nMLm0ccRgNhJNehjtnDDWkMOuS3fYa0yDv4Aopt3pGZtPVVXEfnjItwiLM1lefMfRTZ4
 H0UK+/U9kLKGWhKCTRbxzrH/PIL7M21nkUt0aQ1iEo6Gi9aBSCUmpT/z4Lmq2ZrZJKc55
 nsLmMkGDuJ3Z7crlqDeJmnEDU2xsWipfqNK0xla3cuY7R3rwXKUBO/ewolzKahSVbsVGJ
 r2Ld47eki+jSjYUn5PsuQXrQn9kNapBsjiSfjpvfmaCKF5qBMaq21eRFjkG6KDUxpFExb
 MYESwtNvmaFv7uv7ejBB3rKCNPPhwjT8puPypYfBqTDPvoNBLV+xFeAUUJmsIkCkLpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r7LEV8ZG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=lucienzx159@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=r7LEV8ZG
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDD2A605D1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:27:50 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3514e7cbbbaso5226278eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791822470; x=1792427270;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PC9rLfORlBTlP0+RD3oiA9zopH5BkTxUSbJQueW6GR8=;
 b=r7LEV8ZGDbwmiBTIRWcJnjfL9ktWejbpmW/20P/BPcjQ8rs64LdrXzZNLBOP9INplg
 yCbIaN00RuwjemFkuD9ijb9J0ZT1qGzCbQWNYpiimgJqN3fMMkVryqez8ozFxqH4pKVm
 WSsRO8Jxqn7s4bXfaZph4L4SZsWUZnIbdv8E0v3EQLKcJ0YVz5lT9p5XhZ1nw4BXiZ+c
 4AqPfytmvKeLmuWsJ0fQU2ECh8orT/AbeUakut0RN6xhX8fpd2A1eLNZLqVsY+T6eZeN
 0gzaheqheEWtVThYC2m5vUejxeBaFjhR6UIu9GU9y7/6xlyuIXiY1FBsfQOrfcIz9vIL
 GZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791822470; x=1792427270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PC9rLfORlBTlP0+RD3oiA9zopH5BkTxUSbJQueW6GR8=;
 b=irWB24UI7AYhe4kWhSbdgCNwMjZ/qU3qwXTMOJw65un43GpW9rNA4vG+BYl3/qd81M
 gIpcSkzHyJKqFlpQwf4Fh2HgMF7LTE4280BKWMj/8ZWq8IO8wJ9PNqifm/Jn7nExRPvk
 NFsWAuz1Gah8Ulq5l4vwnv3/OO8EXk6kfNroot8wdZic7KeFKf/HulC6KQSScMQHuD8J
 +JxSMgugKAOfAlSjkJdeUdv419vQtagPthh04Am49FXZ2h6iYJ8eRfPgYkuNgjvEegbY
 wkSTFY8J2GQHzpZXjGwpvRXFvUNmuoBMJypCNAfGtSNtqRBK9TJaAQjUZ908wAO+/MjR
 hyJQ==
X-Gm-Message-State: AFq9FYL1Qg6kY599lMuNjPm1uOTdwChW5I8LtyuAtB6jkkZ1LDmTIebi
 qH+h38IgDsjmsqd2iq7H7o0GQ4i4+ec1/m6fjaJeaQQCEDamZsL8jaDE2eKR6A==
X-Gm-Gg: AYBFou0PJ6UeQKXolP6eSisiHNRK8kGyh2jY+xEc+e8+Wldw1O782sJEuh/99Ebrfec
 +SNEyXqMFANnObXwmW8r+miS828udaiSICeaBb6AfYDaCAYxtjbzZIWpTfnxHFLqEcAfMErM3th
 yaaPdyhB+PP9Db6LiC6w71NZwJbaUaHbmrtWIihfU6QdQKfpjuFPAbOOyXMbZf9RW0GAie/fdOu
 Ay7hme2hOl/AltXVrUFR4YzPeDw2GAbT31JBOeYkBLQtNa3J06T2LF2pRsVFWfxmrYgvq7FJTth
 7iveeBmtkXAP2RoKjLiRNhZYB3N4UeMyMrw+1FR6ajs3ZLqG0DU7nVL+iBnHVhACV7WIvo1VQIW
 NHLUUYO/v9p+vHEmvUhW73+DJdHTZkT4msLfy83uFgMPZasY8vwSj0T7HEcjGC2OrcxbGhpO1+k
 PgzyEeTwORE0ttD3Zm8b7REW17YIwDvk6cI47fvjITOuOCRgnj/TvvFTDxFxGLn6bivy4IRYvCO
 6CTwCZRTQtN+x8JhpfJ3BsDkeadZFpIPS6c79FzmI6yaUvB1uByKJ7Vxh3DRTDGSNxSIiboS+hC
 bs0l
X-Received: by 2002:a05:701b:2512:b0:149:1feb:6da4 with SMTP id
 a92af1059eb24-16a6250bc3emr13248747c88.32.1791822469476; 
 Mon, 12 Oct 2026 09:27:49 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a4429603sm29760202c88.17.2026.10.12.09.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:27:49 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 ryder.lee@mediatek.com, weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, dlechner@baylibre.com,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com
Cc: lucienzx159@gmail.com,
	frank-w@public-files.de,
	daniel@makrotopia.org
Subject: [PATCH v1] clk: mediatek: mt7986: drop duplicate dt-bindings header
Date: Tue, 13 Oct 2026 00:26:56 +0800
Message-Id: <20261012162656.6918-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 17:37:26 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: "Lucien Jheng" <lucienzx159@gmail.com>

include/dt-bindings/clock/mt7986-clk.h duplicates the binding header
that is already provided by dts/upstream/include/. Since the U-Boot
include/ directory precedes dts/upstream/include/ in UBOOTINCLUDE, the
local copy shadows the upstream one regardless of CONFIG_OF_UPSTREAM.

Remove the local copy so that the upstream header is used. The only
symbols used by the clock driver that differ from upstream are:

 - CLK_TOP_MMPLL_U2PHYD is named CLK_TOP_MMPLL_U2PHY upstream, with the
   same value (14).
 - CLK_APMIXED_NR_CLK is a sentinel not defined upstream. Use
   ARRAY_SIZE(fixed_pll_clks) instead, which is also 8, following the
   ARRAY_SIZE() pattern used by clk-mt7987.c and clk-mt7988.c.

No functional change.

Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
---

Notes:
    Tested on a Banana Pi R3 Mini (eMMC) using the downstream devicetree
    arch/arm/dts/mt7986a-bpi-r3-mini-emmc.dts from Frank Wunderlich's
    U-Boot tree, together with the upstream header
    dts/upstream/include/dt-bindings/clock/mt7986-clk.h.
    U-Boot boots normally and TFTP transfers work.

    checkpatch warns that DT binding headers should be a separate patch.
    That rule targets the Linux binding workflow; here the header is only
    a stale local copy of the one in dts/upstream/. Removing it and
    updating its users in clk-mt7986.c must happen together, otherwise the
    tree does not build in between, so this is kept as a single patch.

UBoot init log with upstream dt-bidings header:
U-Boot 2026.07--gedb017c49881-dirty (Oct 13 2026 - 00:14:37 +0800)

CPU:   MediaTek MT7986
Model: Bananapi BPi-R3 Mini
DRAM:  2 GiB
Core:  46 devices, 22 uclasses, devicetree: separate
MMC:   mmc@11230000: 0
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial@11002000
Out:   serial@11002000
Err:   serial@11002000
Net:
16384 bytes read in 2 ms (7.8 MiB/s)
131072 bytes read in 9 ms (13.9 MiB/s)
mtk-eth ethernet@15100000: MD32 firmware version: 24112802
eth0: ethernet@15100000
Hit any key to stop autoboot: 0

 drivers/clk/mediatek/clk-mt7986.c      |   6 +-
 include/dt-bindings/clock/mt7986-clk.h | 178 -------------------------
 2 files changed, 3 insertions(+), 181 deletions(-)
 delete mode 100644 include/dt-bindings/clock/mt7986-clk.h

diff --git a/drivers/clk/mediatek/clk-mt7986.c b/drivers/clk/mediatek/clk-mt7986.c
index e4abddbd515..862e0ce912f 100644
--- a/drivers/clk/mediatek/clk-mt7986.c
+++ b/drivers/clk/mediatek/clk-mt7986.c
@@ -78,7 +78,7 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	PLL_FACTOR(CLK_TOP_MMPLL_D8, "mmpll_d8", CLK_APMIXED_MMPLL, 1, 8),
 	PLL_FACTOR(CLK_TOP_MMPLL_D8_D2, "mmpll_d8_d2", CLK_APMIXED_MMPLL, 1, 16),
 	PLL_FACTOR(CLK_TOP_MMPLL_D3_D8, "mmpll_d3_d8", CLK_APMIXED_MMPLL, 1, 8),
-	PLL_FACTOR(CLK_TOP_MMPLL_U2PHYD, "mmpll_u2phy", CLK_APMIXED_MMPLL, 1, 30),
+	PLL_FACTOR(CLK_TOP_MMPLL_U2PHY, "mmpll_u2phy", CLK_APMIXED_MMPLL, 1, 30),
 	/* APLL2 */
 	PLL_FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", CLK_APMIXED_APLL2, 1, 4),
 	/* NET1PLL */
@@ -227,7 +227,7 @@ static const struct mtk_parent u2u3_sys_parents[] = {
 };

 static const struct mtk_parent da_u2_refsel_parents[] = {
-	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_U2PHYD),
+	TOP_PARENT(CLK_TOP_XTAL), TOP_PARENT(CLK_TOP_MMPLL_U2PHY),
 };

 #define TOP_MUX(_id, _name, _parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,    \
@@ -526,7 +526,7 @@ static const struct mtk_gate infracfg_gates[] = {
 static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
 	.ext_clk_rates = ext_clock_rates,
 	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
-	.fdivs_offs = CLK_APMIXED_NR_CLK,
+	.fdivs_offs = ARRAY_SIZE(fixed_pll_clks),
 	.fclks = fixed_pll_clks,
 	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
 	.flags = CLK_PARENT_APMIXED,
diff --git a/include/dt-bindings/clock/mt7986-clk.h b/include/dt-bindings/clock/mt7986-clk.h
deleted file mode 100644
index 5da260386fd..00000000000
--- a/include/dt-bindings/clock/mt7986-clk.h
+++ /dev/null
@@ -1,178 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2022 MediaTek Inc. All rights reserved.
- *
- * Author: Sam Shih <sam.shih@mediatek.com>
- */
-
-#ifndef _DT_BINDINGS_CLK_MT7986_H
-#define _DT_BINDINGS_CLK_MT7986_H
-
-/* TOPCKGEN */
-
-#define CLK_TOP_XTAL			0
-#define CLK_TOP_XTAL_D2			1
-#define CLK_TOP_RTC_32K			2
-#define CLK_TOP_RTC_32P7K		3
-/* #define CLK_TOP_A_TUNER		4 */
-#define CLK_TOP_MPLL_D2			4
-#define CLK_TOP_MPLL_D4			5
-#define CLK_TOP_MPLL_D8			6
-#define CLK_TOP_MPLL_D8_D2		7
-#define CLK_TOP_MPLL_D3_D2		8
-#define CLK_TOP_MMPLL_D2			9
-#define CLK_TOP_MMPLL_D4			10
-#define CLK_TOP_MMPLL_D8			11
-#define CLK_TOP_MMPLL_D8_D2		12
-#define CLK_TOP_MMPLL_D3_D8		13
-#define CLK_TOP_MMPLL_U2PHYD		14
-#define CLK_TOP_APLL2_D4			15
-#define CLK_TOP_NET1PLL_D4		16
-#define CLK_TOP_NET1PLL_D5		17
-#define CLK_TOP_NET1PLL_D5_D2		18
-#define CLK_TOP_NET1PLL_D5_D4		19
-#define CLK_TOP_NET1PLL_D8_D2		20
-#define CLK_TOP_NET1PLL_D8_D4		21
-#define CLK_TOP_NET2PLL_D4		22
-#define CLK_TOP_NET2PLL_D4_D2		23
-#define CLK_TOP_NET2PLL_D3_D2		24
-#define CLK_TOP_WEDMCUPLL_D5_D2		25
-#define CLK_TOP_NFI1X_SEL		26
-#define CLK_TOP_SPINFI_SEL		27
-#define CLK_TOP_SPI_SEL			28
-#define CLK_TOP_SPIM_MST_SEL		29
-#define CLK_TOP_UART_SEL			30
-#define CLK_TOP_PWM_SEL			31
-#define CLK_TOP_I2C_SEL			32
-#define CLK_TOP_PEXTP_TL_SEL		33
-#define CLK_TOP_EMMC_250M_SEL		34
-#define CLK_TOP_EMMC_416M_SEL		35
-#define CLK_TOP_F_26M_ADC_SEL		36
-#define CLK_TOP_DRAMC_SEL		37
-#define CLK_TOP_DRAMC_MD32_SEL		38
-#define CLK_TOP_SYSAXI_SEL		39
-#define CLK_TOP_SYSAPB_SEL		40
-#define CLK_TOP_ARM_DB_MAIN_SEL		41
-#define CLK_TOP_ARM_DB_JTSEL		42
-#define CLK_TOP_NETSYS_SEL		43
-#define CLK_TOP_NETSYS_500M_SEL		44
-#define CLK_TOP_NETSYS_MCU_SEL		45
-#define CLK_TOP_NETSYS_2X_SEL		46
-#define CLK_TOP_SGM_325M_SEL		47
-#define CLK_TOP_SGM_REG_SEL		48
-#define CLK_TOP_A1SYS_SEL		49
-#define CLK_TOP_CONN_MCUSYS_SEL		50
-#define CLK_TOP_EIP_B_SEL		51
-#define CLK_TOP_PCIE_PHY_SEL		52
-#define CLK_TOP_USB3_PHY_SEL		53
-#define CLK_TOP_F26M_SEL			54
-#define CLK_TOP_AUD_L_SEL		55
-#define CLK_TOP_A_TUNER_SEL		56
-#define CLK_TOP_U2U3_SEL			57
-#define CLK_TOP_U2U3_SYS_SEL		58
-#define CLK_TOP_U2U3_XHCI_SEL		59
-#define CLK_TOP_DA_U2_REFSEL		60
-#define CLK_TOP_DA_U2_CK_1P_SEL		61
-#define CLK_TOP_AP2CNN_HOST_SEL		62
-#define CLK_TOP_NR_CLK			63
-
-/* INFRACFG */
-
-#define CLK_INFRA_SYSAXI_D2		0
-#define CLK_INFRA_UART0_SEL		1
-#define CLK_INFRA_UART1_SEL		2
-#define CLK_INFRA_UART2_SEL		3
-#define CLK_INFRA_SPI0_SEL		4
-#define CLK_INFRA_SPI1_SEL		5
-#define CLK_INFRA_PWM1_SEL		6
-#define CLK_INFRA_PWM2_SEL		7
-#define CLK_INFRA_PWM_BSEL		8
-#define CLK_INFRA_PCIE_SEL		9
-#define CLK_INFRA_GPT_STA		10
-#define CLK_INFRA_PWM_HCK		11
-#define CLK_INFRA_PWM_STA		12
-#define CLK_INFRA_PWM1_CK		13
-#define CLK_INFRA_PWM2_CK		14
-#define CLK_INFRA_CQ_DMA_CK		15
-#define CLK_INFRA_EIP97_CK		16
-#define CLK_INFRA_AUD_BUS_CK		17
-#define CLK_INFRA_AUD_26M_CK		18
-#define CLK_INFRA_AUD_L_CK		19
-#define CLK_INFRA_AUD_AUD_CK		20
-#define CLK_INFRA_AUD_EG2_CK		21
-#define CLK_INFRA_DRAMC_26M_CK		22
-#define CLK_INFRA_DBG_CK		23
-#define CLK_INFRA_AP_DMA_CK		24
-#define CLK_INFRA_SEJ_CK		25
-#define CLK_INFRA_SEJ_13M_CK		26
-#define CLK_INFRA_THERM_CK		27
-#define CLK_INFRA_I2C0_CK		28
-#define CLK_INFRA_UART0_CK		29
-#define CLK_INFRA_UART1_CK		30
-#define CLK_INFRA_UART2_CK		31
-#define CLK_INFRA_NFI1_CK		32
-#define CLK_INFRA_SPINFI1_CK		33
-#define CLK_INFRA_NFI_HCK_CK		34
-#define CLK_INFRA_SPI0_CK		35
-#define CLK_INFRA_SPI1_CK		36
-#define CLK_INFRA_SPI0_HCK_CK		37
-#define CLK_INFRA_SPI1_HCK_CK		38
-#define CLK_INFRA_FRTC_CK		39
-#define CLK_INFRA_MSDC_CK		40
-#define CLK_INFRA_MSDC_HCK_CK		41
-#define CLK_INFRA_MSDC_133M_CK		42
-#define CLK_INFRA_MSDC_66M_CK		43
-#define CLK_INFRA_ADC_26M_CK		44
-#define CLK_INFRA_ADC_FRC_CK		45
-#define CLK_INFRA_FBIST2FPC_CK		46
-#define CLK_INFRA_IUSB_133_CK		47
-#define CLK_INFRA_IUSB_66M_CK		48
-#define CLK_INFRA_IUSB_SYS_CK		49
-#define CLK_INFRA_IUSB_CK		50
-#define CLK_INFRA_IPCIE_CK		51
-#define CLK_INFRA_IPCIE_PIPE_CK		52
-#define CLK_INFRA_IPCIER_CK		53
-#define CLK_INFRA_IPCIEB_CK		54
-#define CLK_INFRA_TRNG_CK		55
-#define CLK_INFRA_AO_NR_CLK		46
-
-/* APMIXEDSYS */
-
-#define CLK_APMIXED_ARMPLL		0
-#define CLK_APMIXED_NET2PLL		1
-#define CLK_APMIXED_MMPLL		2
-#define CLK_APMIXED_SGMPLL		3
-#define CLK_APMIXED_WEDMCUPLL		4
-#define CLK_APMIXED_NET1PLL		5
-#define CLK_APMIXED_MPLL			6
-#define CLK_APMIXED_APLL2		7
-#define CLK_APMIXED_NR_CLK		8
-
-/* SGMIISYS_0 */
-
-#define CLK_SGM0_TX_EN			0
-#define CLK_SGM0_RX_EN			1
-#define CLK_SGM0_CK0_EN			2
-#define CLK_SGM0_CDR_CK0_EN		3
-#define CLK_SGMII0_NR_CLK		4
-
-/* SGMIISYS_1 */
-
-#define CLK_SGM1_TX_EN			0
-#define CLK_SGM1_RX_EN			1
-#define CLK_SGM1_CK1_EN			2
-#define CLK_SGM1_CDR_CK1_EN		3
-#define CLK_SGMII1_NR_CLK		4
-
-/* ETHSYS */
-
-#define CLK_ETH_FE_EN			0
-#define CLK_ETH_GP2_EN			1
-#define CLK_ETH_GP1_EN			2
-#define CLK_ETH_WOCPU1_EN		3
-#define CLK_ETH_WOCPU0_EN		4
-#define CLK_ETH_NR_CLK			5
-
-#endif
-
-/* _DT_BINDINGS_CLK_MT7986_H */
--
2.34.1

