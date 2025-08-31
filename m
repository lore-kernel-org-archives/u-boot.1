Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CC5CA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 11:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C5A83948;
	Sun, 31 Aug 2025 13:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VfhNb5i+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E8983952; Sun, 31 Aug 2025 13:21:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584748393F
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 13:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0b89=3L=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1756639285; bh=uQEwxJm69Hv6l7oGBLavud5infbqzroOQUPnoXz3HBo=;
 b=VfhNb5i+Hl9J482lx5fsS7O0jGurmPvH4P+ONsFuvWo9Eg2FgMsluqhwb7Kwtt7PY7gZZ9s6m
 sTNwTr8ns066362BGLQtUCZOWM3NCJ8hzYDJK+RPtR0Cu1D2/D4zw6h4Ox/ixqAVVH0uEAbjE8F
 LSBKCOgtjNuyly4IsMgKkAAlfFrWZfqnwt/g5U9fXLQM3HN9DwCQO8Ru+4jZDKypyexuuRaFJyL
 W1xbR8ya4iS7bg3bOcvnSpWXEXQdkGZ4EdLSD6v5aOlm22112noNcSAuKSOu44Tb8m2Tuz03921
 hD38QEyQUXsLDiHtWOuoit3AoeyxVNaihyjHFSh0rP4g==
X-Forward-Email-ID: 68b4303232f03f9a5e9086ab
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v3 06/10] arm64: dts: rockchip: Add UFS support on the ROCK 4D
Date: Sun, 31 Aug 2025 11:20:27 +0000
Message-ID: <20250831112046.2642363-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250831112046.2642363-1-jonas@kwiboo.se>
References: <20250831112046.2642363-1-jonas@kwiboo.se>
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

From: Detlev Casanova <detlev.casanova@collabora.com>

This device supports removable UFS chips, add support for it.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Link: https://lore.kernel.org/r/20250708155010.401446-1-detlev.casanova@collabora.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 00abee2b18342d6c2f6f37225682fa7ca0d33142 ]

(cherry picked from commit cf9888548489f76f0d6416782ca4bd9e8bca3c87)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
index 0388d72076bf..22ffa15abc9e 100644
--- a/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3576-rock-4d.dts
@@ -745,6 +745,10 @@
 	status = "okay";
 };
 
+&ufshc {
+	status = "okay";
+};
+
 &usb_drd1_dwc3 {
 	dr_mode = "host";
 	status = "okay";
-- 
2.51.0

