Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD503CEFC54
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 20:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FC788F6F;
	Tue,  8 Oct 2024 22:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AyrXx0Ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDB3088EA7; Tue,  8 Oct 2024 22:06:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41F0888B63
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 22:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ecb7=RF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1728418009; bh=tBMaZJNAVDXNI/rNf007gpKqZTt6oJKJFEGX/mKU3Tw=;
 b=AyrXx0Tifsbzy+HIoa1ACy8E/uW9aZLunLO+awa5VMKMbseGx7IpAPiYZVOs0afBqs6zvyc8a
 yLhOmgdfnN1UBozpjcctw2YPV4mb9+ndA+qNf96+XMZJJ6RfT7oM0UMbqGUHL8XIFdeY/w+4aM0
 fBBj7aVrYyz/h7OVC8TrMU3g8xZoI95Rk43t9f/vb9KE9TUnSeHNucrNXIWMC4aWhRMXdLu/uYo
 cqx04HNUOos+U6zes8mwxO90WxBC2qWJ/PNfW7hny3AfQ/pQnTYHVOxdoR2gS60iDi7huwGKmhr
 HsGoVw7BCmiDWvPCOodpUSvOFqsGsY39VIQgW57XvtJA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Aurelien Jarno <aurelien@aurel32.net>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/3] arm64: dts: rockchip: Correct vendor prefix for
 Hardkernel ODROID-M1
Date: Tue,  8 Oct 2024 20:06:33 +0000
Message-ID: <20241008200641.2203023-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008200641.2203023-1-jonas@kwiboo.se>
References: <20241008200641.2203023-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 670590d97d6a06543222dbf9
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

The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
rockchip. Use the proper hardkernel vendor prefix for this board, while
at it also drop the redundant soc prefix.

Fixes: fd3583267703 ("arm64: dts: rockchip: Add Hardkernel ODROID-M1 board")
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20240827211825.1419820-3-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 735065e774dcfc62e38df01a535862138b6c92ed ]

(cherry picked from commit e7259a2c4a6f2ebdfc96b8bbffc77fe67604b11f)
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts b/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
index a337f547caf5..6a02db4f073f 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3568-odroid-m1.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Hardkernel ODROID-M1";
-	compatible = "rockchip,rk3568-odroid-m1", "rockchip,rk3568";
+	compatible = "hardkernel,odroid-m1", "rockchip,rk3568";
 
 	aliases {
 		ethernet0 = &gmac0;
-- 
2.46.2

