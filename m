Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1EFC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 21:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6679383DA6;
	Thu, 10 Apr 2025 23:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="oQH8cioU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBF383E3A; Thu, 10 Apr 2025 23:45:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C541583D92
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 23:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c990=W5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744321538; bh=sMiTUsLkp8hscPDX3/cIUjHva6AoppXT/7kJBu6NBi0=;
 b=oQH8cioUUOHUK8ABfOn/cQXwcxMRZy9kjxdADL+JqrDSmtk7lbxNxdoQ5U9c5mU2PeE2Y8hvl
 GD9FaJ23fni2Efp4Qyl2nygjUzFQlcK8FzLe3A7CDAN4idJvUn45S+2pGudGyHHEj/m0XMHRnpq
 g5GQ8vRjYJGGDO50OC72pNvZvFPGm/4eSIECvf6SOA+6srgPJ2CwDqIZP8V8oSU/IHpifI/tBgP
 RzGWouRy3Yp/vod11l0xcyFVlhLsNZmI1TnJGrQDud+1mxRQRSuAvhQZk7LRD3noxiwifO+Hyls
 bbPKglkTdE8zukh75asEl/KB/nWb0UvDA6VelpWHij9g==
X-Forward-Email-ID: 67f83bfc0ebe9f861dbcc3a6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, FUKAUMI Naoki <naoki@radxa.com>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v5 6/7] rockchip: binman: Include a compatible string in each
 configuration
Date: Thu, 10 Apr 2025 21:44:55 +0000
Message-ID: <20250410214506.3575404-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410214506.3575404-1-jonas@kwiboo.se>
References: <20250410214506.3575404-1-jonas@kwiboo.se>
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

From: Simon Glass <sjg@chromium.org>

Provide a compatible string in the config nodes that U-Boot can use to
help decide which configuration to use with SPL_LOAD_FIT_FULL=y and
FIT_BEST_MATCH=y.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v5:
- Update commit message
- Collect r-b tags

Changes in v4:
- Split from "VBE serial part H: Implement VBE on Rockchip RK3399"
---
 arch/arm/dts/rockchip-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index e97e9d23834c..f60cc31fb1a6 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -145,6 +145,7 @@
 				fit,firmware = "op-tee", "u-boot";
 #endif
 				fit,loadables;
+				fit,compatible;
 			};
 		};
 	};
-- 
2.49.0

