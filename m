Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08EBCA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CC4D80BD4;
	Tue,  6 Oct 2026 13:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fdpGQvHhfVkt; Tue,  6 Oct 2026 13:00:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4F7E680DA6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791291635;
	b=gFXxZcCMSHSHAzawMQV984TiT8/zGJ29N3uzQaK8tqm+3Ob3MNEYFY1DDqypwm2QT8FE
	 CsA7m6Vq/9goRIa1AyLip8CWFZLaNtbc5wgeKrPbFiF0uagIaIqgCElEMyJa85Nji+Mf5
	 Q7EO4nwiukmJjJAeGonSTyHyTN1nh3fxcTfDK5XAo4+v0MrsVQNveHUUVvTcfknEXNjlx
	 jBlWC8GJu6RxzH4z6E8xRGB2j0ZEEB3u9B8DbcjsO5Q8oqwvN0SoY1dKuZo0vUZbIDz+V
	 abcklvFU2NypzvVaglZN92n1A/9UbEuhFlw5N+WLkPwT4dc81JqIoqndm0vlHE8uURw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791291635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R3lVBsmsCxFAMajnaA3qzBN1k8+hpevTXP912tp12Hg=;
	b=UhJXNysWpUDJ/NTkCJmpOQ8IWSky4QUbIxtZi8YO8XOE8eoWW7nPaHMLiVqTa/A2oZLp
	 ImSn4l3Ak415/NzMI7ALaG60KeqM2U/RlNa5XgS6RkbYQM6A8rdG4CyYr8PsLkQF78Sqb
	 J2fWjN8+RSe33xLlK6oBBBHsloAn6Re0TOBs4vDzKvx6xrfhDR8QKon9kXj7lg+ZU0bHs
	 F+GsVgei2qT0jNcpAg88cuZIqWWTmRBnwp//X08XVZqPh4mDI/WC4UF9xTHXMnJ+5Tpb8
	 0mzPbXegYpk8CFZ2XYQWwq0E64NrNAlKtXmDJnjf8CbMNuC7CoqC35r7a4llIzaJgPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791291635;
	bh=R3lVBsmsCxFAMajnaA3qzBN1k8+hpevTXP912tp12Hg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o/GiuHYVNZYXFS+W4YlxfzvyhufamSD3PBtMrB6BQ+IszoukmGC0j10p4CjW0mM/L
	 +mt/93ZKLn+soaMZDIt5ZaTey54i6iMbZl2WBwv0xO/KzTBHYjv0QikNPmQ87cmeC4
	 KBRzuMkEsbatfH10YGTfJJeZ+W30h+nEdicW8nq8ohgEt/tisyKhQwLnzQLOlhT4Gp
	 3OlCDZnSJVdMKyB/odyG6JTxnyEge7lerXOnyY+7tDLP8dmD8MMePuBUkV3Snoha4B
	 x+rMc6WbDJdthFyOeGHC8n80jKPNNM+yhbPwAh//8zEW+644nRbS6KBLSueMM5CoIx
	 Z6XPqUW6CTGXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F7E680DA6;
	Tue,  6 Oct 2026 13:00:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A54E32F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37C9760739
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2w5399i81CtK for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 11:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5E520606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791285246;
 b=YzjQB2AIHyZku87zoasR55IUl9RStjg7VQ/YM+IoxIsmAqCegQeSlz9K8n5P6IMiuGqs
 ZK0nfBv2KcH11nFjhLbS8tuEj3ELPkeXrlgxS1qu8mDT5farX4W8XKaxvyH1sL4vsmZsB
 jpgBrwuaLtFFJQI/P7kQYishTpPI/PV5Y3rabNgtA85jH5SjQTgBFi2EURIQa7xZoKWp1
 qmjNVuXQJpuEKZFYwcPMdO6wO3NFo7hAwyWvCynUbhAXlBWA1AXbzQMElBIg8G7P/WwP0
 t7NBnYnYIDTkhEai5LfOCcFtZinF5mpYctl3KNb1DGKn0VCbAfnr6ezZC0pR/k80FRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791285246;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=R3lVBsmsCxFAMajnaA3qzBN1k8+hpevTXP912tp12Hg=;
 b=VzqDlQZGoJpmD7xR/bHPUVx+C/9SJNme1D40td1nV4moTgMeHB8VmuTJ8lAvBReHCUbn
 IWVBGgS84mK8NFR/qoFz9MF6eiVzzuRYZ+XpX8sGW6mdQv6U454XJgwr0Yi00gYwiUC3q
 PJ2LOgIcrWSkf+WxWdTdRQ1fuxqda0pTXx1Yz5HUDpProsL/Zobg7ocJcE5I/bJdYTjpz
 k75wFXVrZ8+b/DhQ7ufE13F9V7BsDVJ/N6nFBbd9NThl1LV6sRLVc+XnbnbURUMQC0Pnq
 i4q5qW3cZ+v22ydnqvcwzOLJ/WNWQ2OVSKz/DIFmfP2BopOft7R+8bKhenx5t7e/XsA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NjCNeLYH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=kforce@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NjCNeLYH
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E520606C2
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 11:14:05 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e4c080a472so6881175ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791285245; x=1791890045;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=R3lVBsmsCxFAMajnaA3qzBN1k8+hpevTXP912tp12Hg=;
 b=NjCNeLYHzpOUWraQcfQUgT/eljQvk1yvNJ0rcTc2WjYfCsaCGC5UFTCGQcHJVG+GjP
 H2oAd9HTZuDuP7B3Rfp0DJ/09pR91Fmg1jdKVPQ+58HrhpB8Q7P44Kmp11g2vB8HhbMF
 Azr7l6NSyEXD4lnCCT6ZMt2ObIA3kmu7xYQ5W4Y+xq9fOKp/M+oi/pIhwokI8fyMjZsp
 6+zV1t9Ky61iQ5GxzUiGz5HKiPDFjaN2qtkGf5ORiaUMYCQkm9x5zC0seb5uK6s4/FuZ
 ZgposKiyLq685GRbuQOBDC5sG+kgBBe/OYCaYXwus0Egm111WLebXksfKk9YYOU3OCaD
 USrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791285245; x=1791890045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R3lVBsmsCxFAMajnaA3qzBN1k8+hpevTXP912tp12Hg=;
 b=KIXuY6k5ZWu9oK4y6hEWEx5Dc30a2LtQdQ8RhmpBFkzTXd+qeTfR4Qy1v1bVEAe2Eb
 xQGWQ41dEYtookW5G82ZjiXdHHythUdVPBlAqZ+hp90wxsHLxNqjciBcc29JZS/PBHp4
 b0mRh2CdfR7BjLQ3VewGHmEwVNKKeR+PESyYQBxRN4iUSkzohXue3VBCetGnnjxBE7VR
 39jn1Y9lOjsDYvKV8a3e0BluEF/mRcyU1jq0/bQvIJEc90toFQ5GCqvgZzl+vA1LQ2zW
 LMVvsM4bSsKTocY4JGshOYZu17MtnmAaOV8nYAqGEIuP42BUnXZ4KgtcadWz8HqZNaP5
 EMkA==
X-Gm-Message-State: AFq9FYKyIYNIHlsm/KfIYNg5J8MwvDmMF+ipwFEmAK9ryMp5z2WwJsmS
 1J9P0yzuwWwI65aqFamZb2ZvB2jauo5pGnuv3OOIHDCaGjZx3cRJtQENe2Gz4yUbhsw=
X-Gm-Gg: AYBFou2wv+L63dMe9J18XXlZxt+YXPGJu7BNsOHEeTeD76c69pjRXEdL0CthjX2Vnoa
 59ght7HIHp+TKsrzKLxyWtZu3gEPRm9/SRiNOPmIFz7UAlwRPk/1rqN6LprSWvJsVvgXWSAnRn0
 1ack8WQ6bpt0lKyMlXnUqFX7DL2N8jw5njRYGtiHZn/vsJhBAUqJ+gfLowW6e2Hk34ZdgJ0QMvi
 ZRGXthdtFN2aeS5LiRIZAOg09JafyK0THj96zHJLxOQn7K39mIC4IvAtxWTl2DyLbvhzgyQ2Apr
 q4lb/pwBs4xnf7YrSfhZZQtp686xIM9D0chTMaxwwrIGOeA58s/txwkibX6Hjc4fk+JkLy6Mjie
 ZTcRdHRbzHrq4mLOai3GFUkrE8eUSvULHKGaGay8rcP1baUkoD5iYzuIkPFlzeLoPuuY9AquXW7
 E2afQHJC5tqAgXntujm6rvGKNSbXC3rDEUS17N3tCpqD46VCc1mYuApxKoitBWSg2nSapRQWDJy
 V8dLAZXW4gFWuA6WZfJhmIx2/RruIpsqw9M84jfzYg1poa5SV9WW+rB83vUA/gnlnqD
X-Received: by 2002:a17:902:e84a:b0:2db:3d84:effc with SMTP id
 d9443c01a7336-2e5dcd0fb4amr10967365ad.6.1791285245109; 
 Tue, 06 Oct 2026 04:14:05 -0700 (PDT)
Received: from myosdev ([121.165.170.166]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a55b6df6sm20725755ad.10.2026.10.06.04.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 04:14:04 -0700 (PDT)
From: khaliforce <kforce@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Samuel Holland <samuel@sholland.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] serial: ns16550: make probe clock enabling optional
Date: Tue,  6 Oct 2026 20:14:01 +0900
Message-ID: <179128521949.5.18128894373298117517.uboot-uart@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Oct 2026 13:00:03 +0000
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

From: Samuel Holland <samuel@sholland.org>

Some platforms need the UART clock gates enabled before NS16550
register access. This is required by the downstream Allwinner D1
port used on the MangoPi MQ Pro.

Add CONFIG_NS16550_CLK_ENABLE to enable the UART clocks during
probe when explicitly selected by a platform. The option defaults
to disabled, preserving the existing behavior on other platforms.

The clock-enabling code originates from Samuel Holland's D1 work.
This patch makes that behavior optional through Kconfig.

Link: https://github.com/smaeul/u-boot/commit/0617377a2555031f02a459b3451fa33ce53e9b74
Signed-off-by: Samuel Holland <samuel@sholland.org>
Co-developed-by: khaliforce <kforce@gmail.com>
Signed-off-by: khaliforce <kforce@gmail.com>
---
Tested on a MangoPi MQ Pro with the downstream D1 port based on
U-Boot v2026.10:

- With the option enabled, cold boot and warm reboot succeeded
  through SPL, OpenSBI, U-Boot, GRUB and Linux.
- Removing only this patch, without adding diagnostic code,
  resulted in no UART output at all, not even a single character,
  and the board did not become reachable over SSH.

The standalone patch also builds on current upstream main for
RISC-V64, ARM64 and ARM32. An additional RISC-V64 build with CLK and
NS16550_CLK_ENABLE enabled passed.

With the option disabled, the tested ARM64 and ARM32 NS16550
.text sections were unchanged. Checkpatch reports no errors or
warnings.

 drivers/serial/Kconfig   | 7 +++++++
 drivers/serial/ns16550.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ffc58d663ff..4c5400a3816 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -821,6 +821,13 @@ config SYS_NS16550
 	  be used. It can be a constant or a function to get clock, eg,
 	  get_serial_clock().
 
+config NS16550_CLK_ENABLE
+	bool "Enable NS16550 clocks during probe"
+	depends on SYS_NS16550 && DM_SERIAL && CLK
+	help
+	  Enable all UART clocks before register access.
+	  Select this when firmware does not enable the UART clock gates.
+
 config NS16550_DYNAMIC
 	bool "Allow NS16550 to be configured at runtime"
 	depends on SYS_NS16550
diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 10271f46aa6..217a7cf7238 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -516,6 +516,15 @@ int ns16550_serial_probe(struct udevice *dev)
 	if (!ret)
 		reset_deassert_bulk(&reset_bulk);
 
+	if (IS_ENABLED(CONFIG_NS16550_CLK_ENABLE) &&
+	    CONFIG_IS_ENABLED(CLK)) {
+		struct clk_bulk clk_bulk;
+
+		ret = clk_get_bulk(dev, &clk_bulk);
+		if (!ret)
+			clk_enable_bulk(&clk_bulk);
+	}
+
 	com_port->plat = dev_get_plat(dev);
 	ns16550_init(com_port, -1);
 
