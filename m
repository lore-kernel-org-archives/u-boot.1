Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783A5C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 22:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6B982D6B;
	Wed,  9 Apr 2025 00:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="frsvwzAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63EA8318F; Wed,  9 Apr 2025 00:12:04 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585F0801BE
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 00:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6bf1=W3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744150321; bh=KIcwXFFlm1Ul35XjP/LyWYdFvS8hoCur0Hc03t9Yrtc=;
 b=frsvwzAPF57gl+NjAm2CRl9AkRCgRI738FC4HMa7HAX152kxCSR16fBtJEqp/4C8TkG0/8D5p
 9tWcEjCA6S/K4gX3lj1BQ343LyoIhUaRdKqhQCmUR3E55cqdvmIZywimZQc9f6Wic8pEnQhWWqp
 K7HGnCpf+46uAHrxNOgppHMrrIHbjCZP9hrGXAZRqmyIWvQJEpllb1etxkXRXNxvADV28EJwmNF
 O3ZQtReiph3MA2mtDLODJtuXvdT0BxS3VHGrl/BRwhhJay0TdtqyyKL1TWFNM8DnXitRoOafLCo
 msXWV65vDnS//jyX++ypDjB3FIGsbef0tfHCW/6MXruA==
X-Forward-Email-ID: 67f59f2f9e1b52744186aca5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/4] rng: rockchip_rng: Add compatible for RK3568
Date: Tue,  8 Apr 2025 22:11:42 +0000
Message-ID: <20250408221151.2762853-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408221151.2762853-1-jonas@kwiboo.se>
References: <20250408221151.2762853-1-jonas@kwiboo.se>
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

Linux commit afeccc408496 ("arm64: dts: rockchip: add DT entry for RNG
to RK356x") merged for v6.12-rc1 add a proper rng node to the SoC DT.
The compatible used differs compared to what U-Boot is currently using.

Add support for the rk3568-rng used in upstream Linux. Support for the
cryptov2-rng compatible is still kept because PX30/RK3326 and RK3308 are
still using it.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split SoC u-boot.dtsi change into own patch
---
 drivers/rng/rockchip_rng.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
index 2426648fbd57..f673e2657c94 100644
--- a/drivers/rng/rockchip_rng.c
+++ b/drivers/rng/rockchip_rng.c
@@ -312,6 +312,10 @@ static const struct udevice_id rockchip_rng_match[] = {
 		.compatible = "rockchip,rk3399-crypto",
 		.data = (ulong)&rk_cryptov1_soc_data,
 	},
+	{
+		.compatible = "rockchip,rk3568-rng",
+		.data = (ulong)&rk_cryptov2_soc_data,
+	},
 	{
 		.compatible = "rockchip,cryptov2-rng",
 		.data = (ulong)&rk_cryptov2_soc_data,
-- 
2.49.0

