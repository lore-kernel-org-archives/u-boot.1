Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AC4C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0E5883D1;
	Mon, 22 Apr 2024 08:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="O5j5s7VT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E93E883CC; Mon, 22 Apr 2024 08:31:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082AD883B5
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767472; bh=D/feagGcxBpMbH076qVPsCPUR/XgA4kJqrmmdlug2us=;
 b=O5j5s7VTyLanmwcM8OXv1gUNWuG01TITVXTRN6GkynBTBGXzR3jNO7LMNHCRPJ38AHQf04wi0
 pyLNMMpr+liexufQ2WDhQKoAKp4/jyVt9YB00x80tEhD0e69I1wt+7OZDP69PgEe4zSM59Eiu8y
 JBBfyM+dCv2/Qcb2bxL7F7beungTNgLRZF2P0uGs1XOd1zCftUPewwxX/OgpkIF9K8n7ihbItUL
 0Zsjhf5HEbb7gipQ9PUrZBBCB43lRPbVCNEIz+cH3riBaaaafVQ0Phu/oJgA7H3PuFD7Q+dZ6BJ
 J5w89a5V9apH27a4K2K8PIOsrmxIdbUhBqFvIe2GPnLw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 26/28] rockchip: rk3588-generic: Use M0 iomux for UART2
Date: Mon, 22 Apr 2024 06:29:03 +0000
Message-ID: <20240422062936.681359-27-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626043034ba165ad4474480
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

The default pinctrl for UART2 is using M1 iomux, however, all other
supported RK3588 boards in U-Boot use M0 iomux for UART2.

Change to use the M0 pinctrl for UART2 to match other supported boards.

Fixes: b54c3d0dd69b ("rockchip: board: Add minimal generic RK3588S/RK3588 board")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch split from rk3588 bootph patch
---
 arch/arm/dts/rk3588-generic.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
index e4721d97a87d..baafe7463f1b 100644
--- a/arch/arm/dts/rk3588-generic.dts
+++ b/arch/arm/dts/rk3588-generic.dts
@@ -40,5 +40,6 @@
 };
 
 &uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
 };
-- 
2.43.2

