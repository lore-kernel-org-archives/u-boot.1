Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F1DCA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0133405D1;
	Sun, 11 Oct 2026 20:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9X4Zk1zEdl0f; Sun, 11 Oct 2026 20:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC3CB405CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749573;
	b=lp8tUXN3AOtnGigIPNJ+ieAuoZOq0GMVPnZwzq5lcBJr6WrrEFx7W+lGzrUpnVhgKOhA
	 d8DViyeypdWoDBFL8YDXK2D4/Qwa/3xtnqr5L9OqWtzO6W4PEDQruiz1OYF1Ga9NogFeB
	 CPox3cWoRqh85/9i5NHkkpAEJbLS9drEjDGTSVHBiKJs6Qq5PLy3u6QG7kTPLy+8n98wI
	 yuOCf4/JOWo3LWWajC1v/sRkApG4hPfJqQU6jMVqhIVuNw27fcHqm8/HvZ5meyKIcducW
	 IieFRWlaqjhAjgclQzF11pffZBzo7GvnPSlAkoQXIMIQusqOY8HyDjR+5nJGufGwc2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=rO8OXnZX6bssJpANboMTE8giAgE0wckR0pSdcnFxpEc=;
	b=dOCXqkCplpf0xmLmDKwe7dd1AGF9YzBizroN8TVrxzMO0PyySidzKTqrZYLAYOJrZzgx
	 TviyIwWbkzESL4QQIecU5jDWSqr015IqV2Ox1kW5C1BXMz+UFhHCZkAYLGV2yHITcdR39
	 wc5p1SsnEXiVHBGGSvcmHMkY78VceQHewbZOXMvwDBZC+ukD9o7yOQHjPg/EQZ1O8OWRb
	 1uRzKWWa4Ei4b1r+3i6mBfeDsUNx8IO+3OpiAfcdLPUd56ekQkoOUxoeWLKF4uLIhuEuF
	 CPVNEOjjFruHmsyjJG/Ge4RgOyWA3lmn2UiCIzkgOB/qQXvmqFvGo5lIVPAzKKfvihA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749572;
	bh=rO8OXnZX6bssJpANboMTE8giAgE0wckR0pSdcnFxpEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Zz9efxjaYfw8gxXoWqlwfsvxcrG9+RMTbbeVZpMkgSaY5jxKmIkrV/3vCjE4qt/d5
	 efb8nNWcbNFXTqi1goA1N76S6W84iW0g4HtoSNz5OHvuYKyWP4qASb9JutqFLRwVEt
	 8ZRsQnf3tqO4ap6GG16s/s4Ih+4QF4m+SwbQxV538M/llX9hK3zBtvD3Tjr5GmIRhs
	 mZV/+EGtUnM63xNAp28KE15BQ3CL6wIHv6P8lr3iZnp1RO58ovYnUxx3YM4kzb0xmr
	 eOvu18hRberboYxP2Zr78tYr4UAh9ounOXo4I+FHAkaujIrPip100FRvUh1Kr/3Aaf
	 2KHEisdZLuzhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC3CB405CD;
	Sun, 11 Oct 2026 20:12:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D47DDE0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A01F80CBF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eKdCTWREOa7i for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C268B80CBD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747350;
 b=WO67fHOYaInFNe4kMzgxoWNSZE1i4teS4ZVv21Xc6p0ub4C84qQBfdAMGzr3EVxy3IPS
 oZ7EfL20dOtx2/G/RD8m/nW3FvohnotxZgjp6P41fO1LWSOhmgrT3koQ3WdBCbZ++ebRq
 3wI9zP0s5a/DfrWjD0ME5ZGNW2RNqKZzdos5AnhrgmzWj4MXlZgrOjKGviIXjqVp/NJox
 W7VCHhnBzt3C1sr8CnrXcd81HmqvoIhHPJw4togym/AapwoGN4mZL5VQzm2pYp2BmEtCa
 BgfGcU8ZN1HU7NwRx9ikwHi+IjT2yW8KOEiNZAu7ZRcwbbjYoNlFTijigdboXyWXjOQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747350;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=rO8OXnZX6bssJpANboMTE8giAgE0wckR0pSdcnFxpEc=;
 b=DbE07w4LigWykym3PNjm5Ozk4o0S+VMPjreN2upPrU4eUFdM5n8UQ9qyqemalSqF8ELD
 FyjYoyjc/w/vGuI5y6flIAkGz2y6ltBnXJcJzkdV1c9a1yBnoUorKnR6p7GJS0ymCr8pd
 OZ5zJFaUTsLelyqoDCWlBlgg4GJCPHKKt56BsPYWrx01b8vWVM1Q+L+QQ3YARgWKrl309
 IT3rKYyuPqcf7m/xpYNgAS8oyjsd+O9+jOPnR7w8jhTLFczrfQGv/OmgM2y9fBgevxMAi
 ybRdgydmMXhF/Spu0LcyfqB5RqPjvAEXeblfwiQtQ0isi9b6mksKINH9QVI48I8iXUw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EE1p3VuQ; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EE1p3VuQ
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C268B80CBD
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A176E43F87;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86BF7C2BCFA;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=tbcx7ycqvutACoFVFlY9hIzW2nHeMiqWJ6O8DZ0x2JE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EE1p3VuQod58R0spq2oGnPJBzZrfxPbRCP8CDzEA9u1G+6cfludS/RWKZdBjbuKfV
 +hUM38ewThPfRPNXOrIft/NyFnACaIYAiyVfaUS4b8YRuJ7V9E1vdEwFyRor/Z4Tb3
 9gQXkyQV7/VjAfWDww+GU27umqrdq7ZmKh3oQzp2fON1kIe3tebTOEon8RlKZx0mmi
 FwTU+MiMWwKN4kHd6XhtFk07aVbFs1A6zoFf25CE8Y36+JGLAFth33ep0i5dYj8XAG
 oLXnJ7CFsvJ2u5+FvxOCfRbfBTfSkp/BwTVoBSkyM3MHT7jNLN90NaV6n8vZPywkr0
 8okbyKEdKfzKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 76B54CA9ECF;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:48 +0200
Subject: [PATCH v2 6/9] video: rockchip: dw_mipi_dsi: add a UCLASS_DISPLAY
 adapter for rk_vop
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-6-6b7be35fbee7@protonmail.com>
References: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
In-Reply-To: <20261011-b4-pinephone-pro-defconfig-v2-0-6b7be35fbee7@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>, David Heidelberg <david@ixit.cz>, 
 Ondrej Jirman <megi@xff.cz>, Tom Rini <trini@konsulko.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=3146;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=6hSnXMLgy2pp8V/d20bSewBWBcxQsq0mThDI41dm2aw=;
 b=bFem8m9wo0HAitsmp1zaKfmGH1CQnBQjssrtxBCb8e2tgAvNTRomhiw7WOwLnD6t4aMehnfdv
 z88ANes7MrnACqK3gC7Ze5gbdRSQx/N/ZlTAWHa3HNscDOu0xiFuSxy
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sun, 11 Oct 2026 20:12:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

rk_vop.c only looks for its encoder in UCLASS_DISPLAY and knows
nothing about UCLASS_VIDEO_BRIDGE. Bind a thin display device on the
DSI node that forwards read_timing to the panel and enable to the
bridge. Enable goes through video_bridge_set_backlight() so that
dsi_host_enable() also runs and the controller leaves command mode.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c | 67 +++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
index 49835587aaf..9d0dda86726 100644
--- a/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
+++ b/drivers/video/rockchip/dw_mipi_dsi_rockchip.c
@@ -10,6 +10,7 @@
 #define LOG_CATEGORY UCLASS_VIDEO_BRIDGE
 
 #include <clk.h>
+#include <display.h>
 #include <dm.h>
 #include <div64.h>
 #include <dsi_host.h>
@@ -798,6 +799,18 @@ static int dw_mipi_dsi_rockchip_bind(struct udevice *dev)
 		return ret;
 	}
 
+	/*
+	 * Bind a thin UCLASS_DISPLAY adapter at the same node so legacy
+	 * rk_vop.c can drive this bridge without either side needing to
+	 * know about the other's op table.
+	 */
+	ret = device_bind_driver_to_node(dev, "dw-mipi-dsi-rockchip-display",
+					 "display", dev_ofnode(dev), NULL);
+	if (ret) {
+		dev_err(dev, "failed to bind display shim to node\n");
+		return ret;
+	}
+
 	return dm_scan_fdt_dev(dev);
 }
 
@@ -997,3 +1010,57 @@ U_BOOT_DRIVER(dw_mipi_dsi_rockchip) = {
 	.ops			= &dw_mipi_dsi_rockchip_ops,
 	.priv_auto		= sizeof(struct dw_rockchip_dsi_priv),
 };
+
+/*
+ * Forwards the two ops rk_vop.c actually calls (read_timing, enable) onto
+ * the real UCLASS_VIDEO_BRIDGE bridge and its UCLASS_PANEL child, which is
+ * where this hardware's own panel.c-based driver (e.g. himax-hx8394.c)
+ * already does the real work
+ */
+static int dw_mipi_dsi_rockchip_display_read_timing(struct udevice *dev,
+						    struct display_timing *timing)
+{
+	struct udevice *panel;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_PANEL, &panel);
+	if (ret)
+		return ret;
+
+	ret = panel_get_display_timing(panel, timing);
+	if (ret)
+		ret = ofnode_decode_display_timing(dev_ofnode(panel), 0, timing);
+
+	return ret;
+}
+
+static int dw_mipi_dsi_rockchip_display_enable(struct udevice *dev,
+					       int panel_bpp,
+					       const struct display_timing *timing)
+{
+	struct udevice *bridge;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_VIDEO_BRIDGE, &bridge);
+	if (ret)
+		return ret;
+
+	ret = video_bridge_attach(bridge);
+	if (ret)
+		return ret;
+
+	ret = video_bridge_set_backlight(bridge, 100);
+
+	return ret;
+}
+
+static const struct dm_display_ops dw_mipi_dsi_rockchip_display_ops = {
+	.read_timing	= dw_mipi_dsi_rockchip_display_read_timing,
+	.enable		= dw_mipi_dsi_rockchip_display_enable,
+};
+
+U_BOOT_DRIVER(dw_mipi_dsi_rockchip_display) = {
+	.name			= "dw-mipi-dsi-rockchip-display",
+	.id			= UCLASS_DISPLAY,
+	.ops			= &dw_mipi_dsi_rockchip_display_ops,
+};

-- 
2.55.0


