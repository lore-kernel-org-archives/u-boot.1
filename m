Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637A8E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F3C1801DA;
	Fri, 13 Dec 2024 00:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oTdTtj/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36CA801EB; Fri, 13 Dec 2024 00:58:05 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9916A800B6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047880; bh=gwVsA1xKeKtTrZ/S4+emiHfTojvHyi/n+IlKYqoVNG4=;
 b=oTdTtj/msSNLaZOGy60XCr5atvNRWCZp9/9BrxsrrWK4tBI4pmpXz2Fg2VRE4l45hH82qJ7Jg
 7EfhhU+7oJyHe6v2MB/ar6E/EE5x/d7EmvpwywSOmGOjGyOrbNqO5SkEraIUr7gZeE0P7SUxAJv
 n+SeZwqmTIRPyYOyIAQHC0JdCKhulUUrPSuFaBKS6LPci0IdcgV2zIQ5s65jfLnetB9pA7o95um
 YfUOFJSkLCx87WYYFHG+FxMLRDkXtkw2TzoaAQgcvgZI8QSBWzUWcCbUm6lcHsGkyI2dbzGHU+v
 pVEKbdy9rsKhhn4cooF3/2VxNugHlB476GLHFTigf+tw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/12] rockchip: rk3399-gru: Fix include of TPL in u-boot.rom
 image
Date: Thu, 12 Dec 2024 23:57:11 +0000
Message-ID: <20241212235735.164272-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b7887a511ed8f0b3fe296
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

The chromebook specific u-boot.rom image does not include TPL when
building with TPL=y or ROCKCHIP_EXTERNAL_TPL=y.

Fix this by adding rockchip-tpl and u-boot-tpl nodes to the mkimage node
for the u-boot.rom binman image.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 81a3c6fc972b..bd7527dde223 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -39,6 +39,14 @@
 
 		mkimage {
 			args = "-n rk3399 -T rkspi";
+			multiple-data-files;
+#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
+			rockchip-tpl {
+			};
+#elif defined(CONFIG_TPL)
+			u-boot-tpl {
+			};
+#endif
 			u-boot-spl {
 			};
 		};
-- 
2.47.1

