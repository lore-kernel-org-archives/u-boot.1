Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49BBC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3753983B0E;
	Fri,  1 Aug 2025 22:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xTN9UipK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7232F83B0E; Fri,  1 Aug 2025 22:35:54 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB7083B21
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754080427; bh=XmLjPnySX0HvepQSyfgBRYXlhER0ydyp1C2L/fjN0y0=;
 b=xTN9UipK5q0jlIwLZ2mdUZ4FBzd4UxgFi8LA1wi6QfH7gtaSuQWNBzDVzRHhvM9vAEP4sidoM
 frxbigfEODzFVeNeQ1TVIpiFJpSdQanVfdNChoY9Gq35thDeZehBUDzU+QrFnZqYBFBYP9Hnue8
 3cfjq89IQrj8HJVRY7148PPLwn6lL4uKfJeWobpVj8iFRjjfjNCRkauV04043YLC9fb911+5Izw
 ki+zX9zSf8cq3n+A+lIElbChtjEahwkhl9y1PDBqNx9+EZBBt4ql25YTHGCM8osn5jqkJRaU6ot
 0XZu9wacODqvBdGGEIs0jZlMZyvKPE1B6zuUnXSMUTSw==
X-Forward-Email-ID: 688d249003c11ad40176092a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 6/8] usb: dwc3-generic: Use combined glue and ctrl node for
 RK3576
Date: Fri,  1 Aug 2025 20:32:42 +0000
Message-ID: <20250801203255.2590535-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801203255.2590535-1-jonas@kwiboo.se>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
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

Like Rockchip RK3328, RK3568 and RK3588, the RK3576 also have a single
node to represent the glue and ctrl for USB 3.0.

Use rk_ops as driver data to select correct ctrl node for RK3576 DWC3.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 3cda2b74b7e3..cdb997ea6e48 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -699,6 +699,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
+	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
-- 
2.50.1

