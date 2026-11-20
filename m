Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2B606A331
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zCFaQYLe;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=iHu1EGMw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6502560B8C;
	Fri, 20 Nov 2026 15:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DACR8uspBoXQ; Fri, 20 Nov 2026 15:55:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F25AB60E71
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795190128;
	b=VUiPvottHzltKLKx1ld62Vjspn4rr6v+cJMjBA553Os/ubVno4F2+al/97Z7mOe09ba4
	 e6MhjscRtkvGyHD1y6qqtIsu62rGI6fTiF0QkWRFOhwamuLdr07cfALD9h/xjJWyxqQ10
	 0yQatMo39V1ziykRfCrzwkOPWpLgFfr8Xq5K8q+Ob3uTi4vrFQfT7bC0UrcJCwXGSc84m
	 02jBgKvO+UfL3nMvRK3kTKRB2xQ1/S0IuYLVDDiKlDd5AZJqWZ+6RVNMcWYI4nUqa5BqI
	 qstiFzhVLs03DYbSxk8S6BYlodBzu3AyzeuD3Q8+H9RdDd0lC7rETDUpzcBJsXGIKCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795190128;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xGdZDNcWkbzDWiKf8c0YvQlwQy8AEkxnsoPiYStrzLM=;
	b=MTGSYVOEzVYZh6d7WaAwf5wqeG1AYB914r8TmwQ9XKgguvCO49lcx7aG/Va+jk6zf5hD
	 slzVf41NZqirk85RXWLTSOgjKLc4VUqQR8tt3gnLo+kFmcKRDFFFGowSqkqtpX0287qlm
	 IRMX98Daog+2xmRNrVlhZQBz3wTGKI+Kku3bhPlPFuBzw5doT9zJj6Wj+iRDkP7Uf7Rii
	 e8okUyOWrPE2J/fQg1Zc3FkWqUADLYkNjAIBmttrFe641hKhx7XVrR9eORz267MWrYCFS
	 DAAWlcoreIKRVN7NPenfrIpqBakdni19vbIOH55YJV7OTq/C5fXPT+oRkKSELjKskgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795190128;
	bh=xGdZDNcWkbzDWiKf8c0YvQlwQy8AEkxnsoPiYStrzLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zCFaQYLe1T8ik8pSVr4Nas3pzNQeHdzUfUE3c3Wc2Nk1netYXonGsIW9KfAhIh4Jp
	 5L/5BlRX2gu4Dou28h1AqH/xbu1GKXtoVt7d3hG83kb9U1TsQsW7kT15B+e5DN3tIa
	 QpUzHR2rlCNB8eCkI5fJsn1DQUBsnTCO21Rx6r+ugHjxnfYtTaImkoWguNnH7QRgeD
	 yebV5OEcF3ELZVCjI0v4PzieJN2rcsoODFRLpv6PNK3UWQFjQp2ADMwDVqLdGAJLeV
	 KCefni7lN1Xd1r6g6WLQKIf4MbYLJoRtABy5hTIzdLRdjgdl9RxkAvEV/OHp6/adEC
	 8+gi2v429w1RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F25AB60E71;
	Fri, 20 Nov 2026 15:55:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C65EBE22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8A0F40050
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYkpbCalhTVQ for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:55:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00B5040098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=84.16.66.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.168;
 helo=smtp-42a8.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=iHu1EGMw
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [84.16.66.168])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00B5040098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:55:19 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jWKfs3M4rzqf1;
 Fri, 20 Nov 2026 16:55:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795190117;
 bh=xGdZDNcWkbzDWiKf8c0YvQlwQy8AEkxnsoPiYStrzLM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iHu1EGMwFQ7ye+J3p3DfZWaeHXIu41mb4/U+e9Jbh6gZtdSQy2WdiXSPFiQ60ZOwl
 lv9LNWG3MzKViYO2939reKL7ytHAqMluXzShYVYGnRj4cGOez5N2xfm46oyEvqCvDE
 IVfi39n220sltP725n87eEMZb5mysGpdQ29dCTKFywJCMUb7+j/LPTE1n2C8iGzQbb
 cIg2P9/Qmdovt2V7Ye37peB/S6A7QEBKOTly/+PB7Lhq6WVo1dDiV6nNEXBMgXkz9M
 /YLAxdLivIpF61UjD0UEUTCl6n7xI/GSYYXY0ckML0bMTm0oNq8lQTTygPzoURiWfH
 5mlxHTx25bvZA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jWKfr1wgvzMXD; Fri, 20 Nov 2026 16:55:16 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 20 Nov 2026 16:55:00 +0100
Subject: [PATCH next 1/2] arm64: dts: rockchip: Use GPIO function for PCIe
 reset on Orange Pi 5 Pro
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-orange-pi-5-dts-sync-v1-1-bf749974a410@cherry.de>
References: <20261120-orange-pi-5-dts-sync-v1-0-bf749974a410@cherry.de>
In-Reply-To: <20261120-orange-pi-5-dts-sync-v1-0-bf749974a410@cherry.de>
To: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>
Cc: Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>, 
 Dennis Gilmore <dennis@ausil.us>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Dennis Gilmore <dennis@ausil.us>

The PERST# pins of pcie2x1l1 and pcie2x1l2 are used as reset-gpios,
but the default pinctrl state muxes them to the controllers' dedicated
PERST# function instead of GPIO.

Linux happens to work because the pin is switched to GPIO function
when it is requested as a GPIO, but the devicetree should describe the
pin function the board actually uses. Bootloaders such as U-Boot apply
the pinctrl state as described and do not change the function when the
GPIO is requested, and probing pcie2x1l2 then hangs.

Add GPIO pinctrl nodes for both reset pins and use them in place of
the PERST# function, like other RK3588 boards do.

Fixes: f47af8ebbe53 ("arm64: dts: rockchip: Add Orange Pi 5 Pro board support")
Signed-off-by: Dennis Gilmore <dennis@ausil.us>
Link: https://patch.msgid.link/20261002025746.3284691-1-dennis@ausil.us
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: e95e4fcdc4541e999888f297174e8f6f5f5f899a ]

(cherry picked from commit c97400c6ce5b953b21da62233c26224680693a85)
---
 dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts
index c9679bac1db7..783675337ab9 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588s-orangepi-5-pro.dts
@@ -188,7 +188,7 @@
 /* NVMe */
 &pcie2x1l1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie30x1m1_1_perstn>, <&pcie30x1m1_1_clkreqn>,
+	pinctrl-0 = <&pcie2_1_rst>, <&pcie30x1m1_1_clkreqn>,
 		    <&pcie30x1m1_1_waken>;
 	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	supports-clkreq;
@@ -199,7 +199,7 @@
 /* NIC */
 &pcie2x1l2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie20x1m0_perstn>, <&pcie20x1m0_clkreqn>,
+	pinctrl-0 = <&pcie2_2_rst>, <&pcie20x1m0_clkreqn>,
 		    <&pcie20x1m0_waken>;
 	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_eth>;
@@ -223,6 +223,16 @@
 		};
 	};
 
+	pcie {
+		pcie2_1_rst: pcie2-1-rst {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2_2_rst: pcie2-2-rst {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		vcc5v0_otg_en: vcc5v0-otg-en {
 			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;

-- 
2.56.1

