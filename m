Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B884CA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 20:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CCA1406BE;
	Sun, 11 Oct 2026 20:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hcwxn_JRoUzZ; Sun, 11 Oct 2026 20:13:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 017F940651
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791749586;
	b=HC8fKDnrDYuO01Dhnzoaq++dnMXx53JEc3XpJ16970PL1LwizovMwepKQTT6QXWEzDQD
	 WlpBQeP+L0LjZYfcrEzF/UlU7YbOlVvMS566xqvRuHTDrkK2MC8RQdsFGV7LhyvSERO3F
	 wo9dPENuU1+cH0Amakycz8mP9PvMXjgKuZALZtsK819WdiuLuo040QxpMCgpj7uKC03fW
	 3ToVm2Uy1r4gIuvdskRyIE9KppwAnaEPMDHbJJ78iffOFNfNGoacUXSqhcuv4PTiw0fGC
	 ys+Fdx/7/N/bgtJOmvJEwk1obz6bbj0MuDw7w+XFfXfPghxQSYe8N3yFrvv/NiUZEIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791749586;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=G+rNpJqVnG5yv/AzzKQZx4UVSPa8I2iC19asjNKnXRU=;
	b=Xqs0PW6J5xYGraIanAQZM54fy/FfrX4/Sm6nH+stgG7tsLaoom/vfxAsaqP04EhTbLoa
	 QhyvBgx5/8BFQx5aSg81JSn6ZALJijbHrWEMFQUSSl+SS2qLakMinmxZWd/8TKWkJTKi1
	 MqujmLCCRdvzigEkMZYA0SKX2JGsHh4GBNOQUVBgoh/r1Yj7gJjLkaK/sldSqg9RY9fye
	 ImrrObabrUQoKJBUyao6Qi8OYeveYuYlOZ4sJlCa95lNo/RljzRLJL2wsKQugQoWWLyMU
	 cs8pAWHGREjoiVvLZ3Mgou8vI0LmrAUV19djeYZzofK6lNAgbPwu/1yGrhOgeldltVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791749586;
	bh=G+rNpJqVnG5yv/AzzKQZx4UVSPa8I2iC19asjNKnXRU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Pbyu5ZP2dBF5yKZjuG0k02n2q5YeVH8WZ33vLYHm/OxN2EYjjBuWDlKTznHi8aEvt
	 zTjonwozQSapNVcLbZjpE184nbRbIyq2oaWH7AKZzVP2aPHMBTpZERJft5FbVJjROv
	 chrPHbrdMXjPhlnkY4kLFd81sbGbed/aadf/hRYywyaa9xIjDTnyJ0i0PmBo0eSjMR
	 lgbqBKaADQlDpi2iQNT3Fq7GMDDeX+m6wdNOASlyaVMLrbQVPAyq/PWjPA7pwPoBw3
	 FIdrchEBDketk5LYPjygVM+UqD1H0E8aqGRxJ+6SW+jQu76Ggo3NTiJdlbC+xfU4Dr
	 xmBSEIvxzerkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 017F940651;
	Sun, 11 Oct 2026 20:13:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A10A1194
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9DC8A6061E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ECAK5u0xNkuH for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A026D60614
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791747351;
 b=pzt/PE1CFJCI1XqgluwoNoxCGXhSq2GzsvMmfOfkmpE7r+Oy1Q1dl2/3KdTHq2tqd7U4
 s+nYYf/ZRHeKgW8UaUC5uQKYa8j67KnrmyxOluAKa9IbYnp6JhHJ+s7d0jkXwoVl5C+PH
 vLe34k+sMF+4E4S/9l684kbq2tXAjpTY46mPTjiMJ8Vf1oOS6T0cu5156iRhiD2O7fCPd
 gi7w6qNDLksCT54mfp0AV4PQBrgUTtlrriLKjgvl6qDwSxs8HxDkn1QoUSzDVkFMpdHLO
 KGCFZiWkW6ol/L21qVCsiViNVMLw8Sn8bJ4me5NnUf6u3sUcLnGoBD7Cms/zsJxRdHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791747351;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=G+rNpJqVnG5yv/AzzKQZx4UVSPa8I2iC19asjNKnXRU=;
 b=s0QMtVky8toQOmluouy8s7ClhXtlhgyoZxhLRFOG5Gc5qXdXsJtBuPb8coFWSbGr3ZPR
 oEIVv99tLBFOjKjeukODaxEoQXWdnEopXdH0q0OElKt05Fk1aKBqx6uvY+vQiRcMs798i
 hz9FNB0rhuRNiqFuwiO4Idpdhrtz8JUe2B3M4S9WWJRuxBzbnbz9yR8MDtiGpvGn0dAIM
 9GvLUofBT/VYcOKTGI++RZO4ItjhTS0b+SszOq5gt5ipKCWwPkgZtHRER+/rGBuapqtCz
 aW9tOnvO04FnZkjcMg/2jkfrUg4DV6tufTVS1H2l9T1uG03cB/Hyn09DP9Nw4ay90Fw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Z5EVR23U; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Z5EVR23U
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A026D60614
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 19:35:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A921C60142;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CC4EC2BCF5;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791747349;
 bh=dba+wZ4GWswf8j64nQOiyY0s/U0yDCoqlqv8gJK8MFs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Z5EVR23UiwD+Of/uFX3KggARiY7S5nDsGQYfSq/8rC9XmPKWaxASMMrpYuNZFEdzt
 V4wdEr0ZWRcElis173PzOLsc+dscA/qvsWrNRrGwAp3hCSr9wF53oD47eJRQHSp0Dd
 W0Oj6hRj2uKeOpskG8yxMkmb+RKeODHrnS9kXCEJfDULnm23+4NDqx6X03KWMfoF/F
 Vf6GxnvwDQaZOD8W0Xw7rRMi1OWFo5X4tLBqMVuBIMdHckFxqH6Xwngzl4tbYgOTl9
 g1V3587szSUUl5p5YTJZpJw7qfbaxyCWOe+YbYkDeFk9l+bjf11Wh3PADiZbdcUHSn
 urMkGPL4F3+oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 477DACA9EC7;
 Sun, 11 Oct 2026 19:35:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 11 Oct 2026 21:35:45 +0200
Subject: [PATCH v2 3/9] video: dw_mipi_dsi: sync LP command and clock lane
 handling with Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-b4-pinephone-pro-defconfig-v2-3-6b7be35fbee7@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791747347; l=3331;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=6U3A16Eh7TIqRpAkW4FUKZxONalMrKI8Ls2Fpm0hs50=;
 b=b6aQScNsLBCPpJoveMBfxFAmPmVPhqI28C7Anr4GOqXpjTYWYIBhpT+mfann8jay6VzMltGX1
 Vg30HTyqvbtDLizbPRlkR75tvypHhLbPxRwQpf2MfcxDDA93mamNfaR
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

Program DPI_LP_CMD_TIM when configuring a message, switch the
low-power command bit in VID_MODE_CFG instead of gating the clock
lane per message and set the clock lane control in set_mode()
for both command and video mode.

Based on megi's 0711c54e94c ("video: dw-mipi-dsi: Sync-up with
Linux driver"), https://codeberg.org/megi/u-boot

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/video/dw_mipi_dsi.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/video/dw_mipi_dsi.c b/drivers/video/dw_mipi_dsi.c
index c74fe678d12..fa22ee82b7e 100644
--- a/drivers/video/dw_mipi_dsi.c
+++ b/drivers/video/dw_mipi_dsi.c
@@ -85,6 +85,7 @@
 #define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
 #define VID_MODE_TYPE_BURST			0x2
 #define VID_MODE_TYPE_MASK			0x3
+#define ENABLE_LOW_POWER_CMD		BIT(15)
 
 #define DSI_VID_PKT_SIZE		0x3c
 #define VID_PKT_SIZE(p)			((p) & 0x3fff)
@@ -293,13 +294,28 @@ static void dw_mipi_message_config(struct dw_mipi_dsi *dsi,
 	bool lpm = msg->flags & MIPI_DSI_MSG_USE_LPM;
 	u32 val = 0;
 
+	/*
+	 * TODO dw drv improvements
+	 * largest packet sizes during hfp or during vsa/vpb/vfp
+	 * should be computed according to byte lane, lane number and only
+	 * if sending lp cmds in high speed is enable (PHY_TXREQUESTCLKHS)
+	 */
+	dsi_write(dsi, DSI_DPI_LP_CMD_TIM, OUTVACT_LPCMD_TIME(16)
+		  | INVACT_LPCMD_TIME(4));
+
 	if (msg->flags & MIPI_DSI_MSG_REQ_ACK)
 		val |= ACK_RQST_EN;
 	if (lpm)
 		val |= CMD_MODE_ALL_LP;
 
-	dsi_write(dsi, DSI_LPCLK_CTRL, lpm ? 0 : PHY_TXREQUESTCLKHS);
 	dsi_write(dsi, DSI_CMD_MODE_CFG, val);
+
+	val = dsi_read(dsi, DSI_VID_MODE_CFG);
+	if (lpm)
+		val |= ENABLE_LOW_POWER_CMD;
+	else
+		val &= ~ENABLE_LOW_POWER_CMD;
+	dsi_write(dsi, DSI_VID_MODE_CFG, val);
 }
 
 static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
@@ -463,17 +479,22 @@ static void dw_mipi_dsi_set_mode(struct dw_mipi_dsi *dsi,
 				 unsigned long mode_flags)
 {
 	const struct mipi_dsi_phy_ops *phy_ops = dsi->phy_ops;
+	u32 val;
 
 	dsi_write(dsi, DSI_PWR_UP, RESET);
 
 	if (mode_flags & MIPI_DSI_MODE_VIDEO) {
 		dsi_write(dsi, DSI_MODE_CFG, ENABLE_VIDEO_MODE);
 		dw_mipi_dsi_video_mode_config(dsi);
-		dsi_write(dsi, DSI_LPCLK_CTRL, PHY_TXREQUESTCLKHS);
 	} else {
 		dsi_write(dsi, DSI_MODE_CFG, ENABLE_CMD_MODE);
 	}
 
+	val = PHY_TXREQUESTCLKHS;
+	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
+		val |= AUTO_CLKLANE_CTRL;
+	dsi_write(dsi, DSI_LPCLK_CTRL, val);
+
 	if (phy_ops->post_set_mode)
 		phy_ops->post_set_mode(dsi->device, mode_flags);
 
@@ -544,14 +565,6 @@ static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
 	dsi_write(dsi, DSI_DPI_VCID, DPI_VCID(dsi->channel));
 	dsi_write(dsi, DSI_DPI_COLOR_CODING, color);
 	dsi_write(dsi, DSI_DPI_CFG_POL, val);
-	/*
-	 * TODO dw drv improvements
-	 * largest packet sizes during hfp or during vsa/vpb/vfp
-	 * should be computed according to byte lane, lane number and only
-	 * if sending lp cmds in high speed is enable (PHY_TXREQUESTCLKHS)
-	 */
-	dsi_write(dsi, DSI_DPI_LP_CMD_TIM, OUTVACT_LPCMD_TIME(4)
-		  | INVACT_LPCMD_TIME(4));
 }
 
 static void dw_mipi_dsi_packet_handler_config(struct dw_mipi_dsi *dsi)

-- 
2.55.0


