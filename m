Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1C606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uf3jhbzl;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=DmMKvOYD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B873605FF;
	Mon,  2 Nov 2026 19:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfZE_wnSlKp1; Mon,  2 Nov 2026 19:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2197F60600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793649155;
	b=K60++7rSwp35M5vw4noWlWBgLpSty75Ajx2FRHpJoWmCo0D60CEfKDvoqtIEdYhR13jM
	 nVADCQKJ9Z8axVXCQAmVoMgSONjz1BRE7nQDmp2rdMjJ57sEnglT6EfLZnj+yF7JTNi/r
	 4r0Zr5KuOjKCA7t4h4Z0wFl1iEUK7UknG2nOtyzkvr2pa2s9CNhQtzT8QQn/B1ObTSPDU
	 v1K4Tl1SQjPCIJaVMKp4uzvH6M5eawUSTyTa1l0VOlrDkEve9AbE5RNo+Wk8YCeMMng1B
	 US+3zXJTszdz1ftpneR7aEougsvty2D8hQUZyRk0ktasmBP/LkRSaQcrC8KWDZlEvZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793649155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d2KEsTWj+jgPV6SrhtL7+OxEPanXyY7qi5PnHYNC1bg=;
	b=offbpANjetgaZvU9VYhp/1xL9HfeMD1qLIT6NnIynwUM/BoJzCzVSsRtNaWdzNbF95WR
	 cZ40ac8LJ8Xr2xXaiHZFa2tNPiZx47x9FY92MII3cuWhXm2yINuTphEIIUpBbyEJgMxBB
	 0XfGYYYk/gS3SmxFq6ZhdcqsFGhlY8kb7pAb7RwrfZERahE3dbyGqlWDv3yPR+JRG0oYd
	 U9I/ylhm68D8o49AN7tEVfpHrV0Hkpr5aaSbtP7uCejbHJV7HAXBoslLLJwLqDj/PGXvx
	 3NWQNm72l2TrcbADGLUfuetYAKMbnH1XtNjxBXA7+8/NF96T0uqDgENUqcx/BTn2fag==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793649155;
	bh=d2KEsTWj+jgPV6SrhtL7+OxEPanXyY7qi5PnHYNC1bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uf3jhbzlBaGhgqzaoaJiqXViP/yHgbc6fp5+/ewz8LPRoWzXrPUI3sfMVN5HmuOXy
	 JKBZDqr5DRh5uWGOHdNvaEfuQuvwQ9W1AyehXPXWI1J9WY5Cu6ERlfXaO3Ln7QYAWH
	 nSJOMXDplqCg0cBYWcYipYzxgX2ckvhv0S+ewQm73GnLdoldDw/yyOX1z1mZJap8D/
	 59nuIGv/JHWZEoSxHJiRp+ssWszzQ5iFIe76lZL7wEZZ041Hx2OnYJ6DdyFck3WXGQ
	 ClzFTTRiNXkngH51Bp7xELe6ZQtMuzzp1nVM6s3EKVMWZCch4ls+PrItCEuyXTsJWe
	 SK/2IqtE1Y6xA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2197F60600;
	Mon,  2 Nov 2026 19:52:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90C8B411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8269D40540
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XFWbUQmrgVNH for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 19:52:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4624440515
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793649152;
 b=kSXfuktjteY9wQU27IHJ4QvDmmJTCkKzVLB+XQlsNvzpRf+R3I/E1FeTi0WWDBQSwnrU
 OfFftXVag35XeYC+Xlw+QRucej1Q2Q421ixfxoL0uTIqjQ+xpBR1iy8EmqyZa8Yko1Bjz
 0qmEB8pVAzOnHed3/nXvrMPDIlAjV6yzcUjbQgLG3XP1XPhE8RXqwKoBTbGREcljR0FCA
 FsZ2LIK2TQtQ0adqt22XCkjw2llx0sgZQAIk0YkAYdH32FN96fYTFiX17lepjPz+zAd1P
 gzd6eEIvTXUoxo9hRvPAQQ75G4JL+M35TBvxPV//q4J+2smbaJ/YBfMrOLGkPdMQViw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793649152;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=d2KEsTWj+jgPV6SrhtL7+OxEPanXyY7qi5PnHYNC1bg=;
 b=Ib8r8ZpIhQZ4mFhQUU1jWMchgJl7JCU+0EmDoG8dLoZso1GuU6myo/Z0KmB0hpKHDfHQ
 PHcw1bKI4jOEshI8fNYErRZS/9KombNRiDq2WI4aAlOITUDU1quAWTaoHKIiReRoFvQZF
 QfWNQd9yNBvy1PrpUGqRc0gbm6CYsQ8o1hUcOdIRzthaeDvnGOu6yOYSqi8G36esplC+h
 bn7nEnvEFnHoMNNiL5h5eTTPBJyG2sWX3f2SX7MbwbNPyffp6tIC4QzS+ndFfSp2bfdEB
 mSkcKkHzV14QwW7yOEcWx4LnPDFsdpxBj+/lMHXiVVedYcocYhcfGjMIlQAla8gnMFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DmMKvOYD; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=DmMKvOYD
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4624440515
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793649105;
 bh=d2KEsTWj+jgPV6SrhtL7+OxEPanXyY7qi5PnHYNC1bg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DmMKvOYDVC0JfzZ/FFM3Nle+X/NYaTFIH4ZzStZ0zwNU/QjGhKO61q96HPKvqwyzX
 goADssfJV5B/7GogB01danz1vaaph4Bp3392ZjgpPCMPqI562N/CjxSFpn9TYWZ93Y
 GLAOqOX9+PY8NBkMQQa10KmMpmEA/wG03+xcdA8uPKxQmuPd6GkLuVyr9IhVIPsgym
 O2c1wwpXeTy2YIhDYkuJFx1wkUP+1m08haMgyCNZAT4cmkpVyq4wg6mMeN3hcEcNW9
 oTDE2GgNxOeL4iolTdhHznZMFMOrTdBcXPGs7nfNVteT13kbjB95BAGEePslSwwvgZ
 knyRAi3prYqZw==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 39F6DB220F49;
 Mon,  2 Nov 2026 20:51:43 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH v2 2/3] riscv: dts: spacemit: k3: Drop guest properties from
 M-level IMSIC
Date: Mon,  2 Nov 2026 11:50:41 -0800
Message-ID: <20261102195101.103363-3-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102195101.103363-1-e@freeshell.de>
References: <20261102195101.103363-1-e@freeshell.de>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junhui Liu <junhui.liu@pigmoral.tech>

The mimsic node describes the machine-level IMSIC, whose MMIO region is
0x10000 (64 KiB) for all 8 harts. However, the node also specifies
riscv,guest-index-bits = <6>, and per the AIA specification the
per-hart stride is 2^(guest-index-bits + 12) bytes when guest interrupt
files exist, i.e. 2^(6 + 12) = 256 KiB per hart and 2 MiB for all 8
harts. The described region cannot hold even a single hart's files, so
the node contradicts itself. OpenSBI enforces exactly this constraint in
imsic_data_check() and rejects the node with -EINVAL, preventing the
M-level IMSIC from initializing:

  fdt_driver_init_by_offset: interrupt-controller@f1000000 (riscv,imsics) init failed: -3
  init_coldboot: irqchip init failed (error -3)

Moreover, guest interrupt files exist to act as the supervisor-level
interrupt files of virtual harts; there is no machine-level counterpart.
riscv,num-guest-ids is equally meaningless for the machine-level IMSIC.

Drop both "riscv,guest-index-bits" and "riscv,num-guest-ids" properties
from the mimsic node so the node matches the actual hardware layout.

Fixes: 56f37e391a62 ("riscv: dts: spacemit: add initial support for K3 SoC")
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://patch.msgid.link/20260729-k3-mimsic-fix-v1-1-368c0aec04b9@pigmoral.tech
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 01e2f07c44fc46180bdb10e70506f8acf44a53dd ]

(cherry picked from commit d44cd4bcf93bb5c99a4762ed5f11656b93f9e5cc)
---
 dts/upstream/src/riscv/spacemit/k3.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/dts/upstream/src/riscv/spacemit/k3.dtsi b/dts/upstream/src/riscv/spacemit/k3.dtsi
index c3f2dce0969c..2d022e1364f1 100644
--- a/dts/upstream/src/riscv/spacemit/k3.dtsi
+++ b/dts/upstream/src/riscv/spacemit/k3.dtsi
@@ -1287,9 +1287,7 @@
 					      <&cpu4_intc 11>, <&cpu5_intc 11>,
 					      <&cpu6_intc 11>, <&cpu7_intc 11>;
 			msi-controller;
-			riscv,guest-index-bits = <6>;
 			riscv,hart-index-bits = <4>;
-			riscv,num-guest-ids = <511>;
 			riscv,num-ids = <511>;
 			status = "reserved";
 		};
-- 
2.53.0

