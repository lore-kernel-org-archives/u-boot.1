Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356A9C83F0F
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 03:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A4B8364E;
	Thu, 10 Jul 2025 05:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="M/QdtmDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839A1835CD; Thu, 10 Jul 2025 05:42:25 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9EE98363C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 05:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7602D25D78;
 Thu, 10 Jul 2025 05:42:23 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PGndvGeRGSTY; Thu, 10 Jul 2025 05:42:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752118940; bh=3SBzsIuyXzWZPv4jwTrBrWyK437HeH6tNLHUj6DjyyU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M/QdtmDc+xy+D+BBN5QFIEABehORTn/OC5Vl6z+4lBoBGYz9F8F0HOd7JcoJvH7ck
 7iz0mFBBvDPAqqZtudwpZVIPxomTabQr2igMjTpBlVvj2RM6EJWUiX3C9TVXey0758
 B+A+rRaH8waph/H824JAqJvKN7LxDAO/+4od1oTJ+gBnUT4qmpWsFMGOMzFty0tUWh
 uPw6bw5x8gNXkLVXXcjwc0LHiYJM/zBjjzuJCR1wkkvE/l2VSKv7YRZgsIaDI2C9h6
 Hrq7mx34VmDuWXkSvZjIz4Lo1prm+rYSwEDRWQ9QRrU9InVGwfuH2NwhErxfQh81VV
 haow4ylDW3lsA==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/5] clk: thead: th1520-ap: Correctly handle flags for dividers
Date: Thu, 10 Jul 2025 03:41:57 +0000
Message-ID: <20250710034201.39901-2-ziyao@disroot.org>
In-Reply-To: <20250710034201.39901-1-ziyao@disroot.org>
References: <20250710034201.39901-1-ziyao@disroot.org>
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

Unlike the gate clocks which make no use of flags, most dividers in
TH1520 SoC are one-based, thus are applied with CLK_DIVIDER_ONE_BASED
flag. We couldn't simply ignore the flag, which causes wrong results
when calculating the clock rates.

Add a member to ccu_div_internal for defining the flags, and pass it to
divider_recalc_rate(). With this fix, frequency of all the clocks match
the Linux kernel's calculation.

Fixes: e6bfa6fc94f ("clk: thead: Port clock controller driver of TH1520 SoC")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/thead/clk-th1520-ap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index b80ad05b8ad..822cf0809d5 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -32,6 +32,7 @@ struct ccu_internal {
 struct ccu_div_internal {
 	u8 shift;
 	u8 width;
+	unsigned long flags;
 };
 
 struct ccu_common {
@@ -79,6 +80,7 @@ struct ccu_pll {
 	{								\
 		.shift	= _shift,					\
 		.width	= _width,					\
+		.flags	= _flags,					\
 	}
 
 #define CCU_GATE(_clkid, _struct, _name, _parent, _reg, _gate, _flags)	\
@@ -182,7 +184,7 @@ static unsigned long ccu_div_get_rate(struct clk *clk)
 	val = val >> cd->div.shift;
 	val &= GENMASK(cd->div.width - 1, 0);
 	rate = divider_recalc_rate(clk, clk_get_parent_rate(clk), val, NULL,
-				   0, cd->div.width);
+				   cd->div.flags, cd->div.width);
 
 	return rate;
 }
-- 
2.50.0

