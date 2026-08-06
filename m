Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B247EC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 09:27:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 268ED40589;
	Thu,  6 Aug 2026 09:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-jOBgFku3yJ; Thu,  6 Aug 2026 09:27:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EEFB40566
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786008448;
	bh=5oayyJ68R834TLmTKMmpnV/zfA7PV7+p7yRGe5VtqI0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TheUae3XM2IEDFG+0fEW8dZbOEz4NEu4vbQN9cq8rmsXrbcc8sfyOl1JInQhwtoa/
	 yoDhUDodM98w2KrOgwsemHpYVQhlJOHF986lWiw5gviZb7+4vYsIfB7wtif4HToAc3
	 U3PYxd7EcR09ulSc/SVINiRhLrW/1pZ6ra2//DkZs9UjTu89pH8I/lt95OoDpdh0Vz
	 F8t2gAzQM2Q4UHcYFdylUuT+9/jxT3Z8scOtCO6ZKVHS8GB75jXck0l8RGnlKCBT5s
	 Nvn46v2NuxBv5AyZAfCCgWtWGNxnX2RRtNtpFDhnlcz4FURa+baMKoETvVLKBU1DlZ
	 vSCmKxE8rw94Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EEFB40566;
	Thu,  6 Aug 2026 09:27:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D1F0198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EE2380D86
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLDYk9TVEMiM for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 09:27:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 12AED80D81
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12AED80D81
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12AED80D81
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 09:27:19 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-472326ca506so1333427f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 02:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786008438; x=1786613238;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5oayyJ68R834TLmTKMmpnV/zfA7PV7+p7yRGe5VtqI0=;
 b=cJRAYvjzg/NSwOVEDsP5LGZn2/YDStM9MGWVWGO5K5tjUpE1dNgp5JK9KoTIfvl6LW
 iD88t72sFsds6MGiByfS2lM5xOHoaLDpvV/76Tsh2klDsmPTrtNGjl+wuRaxsMgZdYtp
 E9XduINiNmoTsNamntoqDbzzOHUTbB79BYSnKu02wp2nv8gsKJJ8YRPOSM7EQJ/T7nff
 NfTaHXEW+PR02hLgJ52/u8pQ8Pb9ph1hHWXOA5LoRbTwYgWyz94Ib511MZ4H88HMBSKH
 uRLm8jnvkDm4czLNUHsyWO4rZg1Nc1BRkjr+dn7r98XOUc64RJz0lTDoQ35R6ItJs276
 U+NA==
X-Gm-Message-State: AOJu0YxfLdlTpFEJaQdKLfVOD36g7c6ibaGdvxnoUIiLwdrQtaBEzNoY
 6eKi/nRmLmdNlxELLUy86RVqIDBIFS+Z+I3GIWXGdrGfP0S36a7IznJ67Z9bx8LaAio=
X-Gm-Gg: AR+sD11FQVdLLugYyPV9iU4yb2k0pnFdaZkclXZqDantNaxCz5oOKB9mYfNLAdFG3/A
 7gMfRzCkX4JUSEIriAMxPcnDf0bPFCKvKm6+UJ4xQJHnaq+VxB0TZalzyAYwlrQihvy7vaec4xX
 ItcQn5ECxmKEQDhvHdtSHK7erEBfKuZC1ghTxYQdTzCEndao7YihGBvaFwBue2ymHpMa7baz3jh
 fKQhj/76RhvVLGw9EnC9UFX745Tly1VjtSq0ys9b7afCbWCZwhFKH2CVzb0yQwe5bpVjifbjpr8
 2l/6zvr41IVsoiUttewVOdCl8AcGIufRTMGCWX1+fsgS6W/1mJQeObtua4mMVDJFZMpTFBojEBB
 ko7PtfukoKarJh8yFSYJKmXVc1MB1UgXSEX/Y+B68skC9kYM5+z/9mFQRJwcQ5twjYd0jAw34bd
 LEZm9Wl1KFlgfU83LCUDt+nKDJBZZbahPphme/eWj+JOUIjyYQCkOwlFpIp+jugqkM5Ab62UgS9
 LFmzcO5OmXEGILK/GUjA4tjtylT0B/LPqNzCPGLUY+5SWISbPQkQ2FgHgLPiC8bGSqv2de6wuBh
 GFKTAijHSrkyMZUiqsjgR9Tqxrfhw84fTay6VtZ6uQ7dtw==
X-Received: by 2002:a5d:5f48:0:b0:47f:9404:5185 with SMTP id
 ffacd0b85a97d-47fec63136fmr20347765f8f.24.1786008437950; 
 Thu, 06 Aug 2026 02:27:17 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b31975sm4147248f8f.33.2026.08.06.02.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 02:27:17 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 11:27:11 +0200
Subject: [PATCH 5/6] video: panel: renesas-r69328: use common
 mipi_dsi_dcs_write_seq macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-5-6b533788d0ac@baylibre.com>
References: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
In-Reply-To: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786008438; x=1786613238;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5oayyJ68R834TLmTKMmpnV/zfA7PV7+p7yRGe5VtqI0=;
 b=cim8JjF0DJU2wJYFEuwdRL0eqqyZwv1csP1WTn1EnbHExu9aOuibAgeEpPvQUiLkrn
 PEoh2/91h9TWB2fgmO1oRD1HhzF3b0RWBblPRnWY4v80V3gsmmOzAftJZ4CFGEx+zYjq
 HIb5iwu8f8zT6Hk0PCqR6nq2u63ziaTjMsiI5dU6HH3AfDbok4eDSkaOGWNLfYtBiFKM
 d3qdHEw9o9qfOKve3CI6ehy0wZ1tBoQyZr8ZKiP5wG6Pbn0QRhnEnkj1Jm+qCOgeNYMW
 caH/94IAQe08j0uJSmQofAq1dSl7i2avwEhFSqh6xLIqY4wRY6CgdTnTMLJpb1wnzpAz
 WXqA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cim8JjF0
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The current driver defines dsi_generic_write_seq as a wrapper around
mipi_dsi_dcs_write_buffer.

Now that mipi_dsi.h defines such macro, we can use the common one.
Note that we use mipi_dsi_dcs_write_seq instead of
mipi_dsi_generic_write_seq to keep the same behaviour.

While at it also use mipi_dsi_dcs_write_seq instead of direct call to
mipi_dsi_dcs_write_buffer for address_mode, and remove static
address_mode variable.

No functional changes intended.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/renesas-r69328.c | 69 +++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/video/renesas-r69328.c b/drivers/video/renesas-r69328.c
index 0954b04b62e..e4f563c09c5 100644
--- a/drivers/video/renesas-r69328.c
+++ b/drivers/video/renesas-r69328.c
@@ -40,18 +40,6 @@ struct renesas_r69328_priv {
 	struct gpio_desc reset_gpio;
 };
 
-static const u8 address_mode[] = {
-	MIPI_DCS_SET_ADDRESS_MODE
-};
-
-#define dsi_generic_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static struct display_timing default_timing = {
 	.pixelclock.typ		= 68000000,
 	.hactive.typ		= 720,
@@ -70,8 +58,7 @@ static int renesas_r69328_enable_backlight(struct udevice *dev)
 	struct mipi_dsi_device *dsi = plat->device;
 	int ret;
 
-	mipi_dsi_dcs_write_buffer(dsi, address_mode,
-				  sizeof(address_mode));
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE);
 
 	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT << 4);
 	if (ret < 0) {
@@ -88,35 +75,35 @@ static int renesas_r69328_enable_backlight(struct udevice *dev)
 	mdelay(100);
 
 	/* MACP Off */
-	dsi_generic_write_seq(dsi, R69328_MACP, 0x04);
-
-	dsi_generic_write_seq(dsi, R69328_POWER_SET, 0x14,
-			      0x1d, 0x21, 0x67, 0x11, 0x9a);
-
-	dsi_generic_write_seq(dsi, R69328_GAMMA_SET_A, 0x00,
-			      0x1a, 0x20, 0x28, 0x25, 0x24,
-			      0x26, 0x15, 0x13, 0x11, 0x18,
-			      0x1e, 0x1c, 0x00, 0x00, 0x1a,
-			      0x20, 0x28, 0x25, 0x24, 0x26,
-			      0x15, 0x13, 0x11, 0x18, 0x1e,
-			      0x1c, 0x00);
-	dsi_generic_write_seq(dsi, R69328_GAMMA_SET_B, 0x00,
-			      0x1a, 0x20, 0x28, 0x25, 0x24,
-			      0x26, 0x15, 0x13, 0x11, 0x18,
-			      0x1e, 0x1c, 0x00, 0x00, 0x1a,
-			      0x20, 0x28, 0x25, 0x24, 0x26,
-			      0x15, 0x13, 0x11, 0x18, 0x1e,
-			      0x1c, 0x00);
-	dsi_generic_write_seq(dsi, R69328_GAMMA_SET_C, 0x00,
-			      0x1a, 0x20, 0x28, 0x25, 0x24,
-			      0x26, 0x15, 0x13, 0x11, 0x18,
-			      0x1e, 0x1c, 0x00, 0x00, 0x1a,
-			      0x20, 0x28, 0x25, 0x24, 0x26,
-			      0x15, 0x13, 0x11, 0x18, 0x1e,
-			      0x1c, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, R69328_MACP, 0x04);
+
+	mipi_dsi_dcs_write_seq(dsi, R69328_POWER_SET, 0x14,
+			       0x1d, 0x21, 0x67, 0x11, 0x9a);
+
+	mipi_dsi_dcs_write_seq(dsi, R69328_GAMMA_SET_A, 0x00,
+			       0x1a, 0x20, 0x28, 0x25, 0x24,
+			       0x26, 0x15, 0x13, 0x11, 0x18,
+			       0x1e, 0x1c, 0x00, 0x00, 0x1a,
+			       0x20, 0x28, 0x25, 0x24, 0x26,
+			       0x15, 0x13, 0x11, 0x18, 0x1e,
+			       0x1c, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, R69328_GAMMA_SET_B, 0x00,
+			       0x1a, 0x20, 0x28, 0x25, 0x24,
+			       0x26, 0x15, 0x13, 0x11, 0x18,
+			       0x1e, 0x1c, 0x00, 0x00, 0x1a,
+			       0x20, 0x28, 0x25, 0x24, 0x26,
+			       0x15, 0x13, 0x11, 0x18, 0x1e,
+			       0x1c, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, R69328_GAMMA_SET_C, 0x00,
+			       0x1a, 0x20, 0x28, 0x25, 0x24,
+			       0x26, 0x15, 0x13, 0x11, 0x18,
+			       0x1e, 0x1c, 0x00, 0x00, 0x1a,
+			       0x20, 0x28, 0x25, 0x24, 0x26,
+			       0x15, 0x13, 0x11, 0x18, 0x1e,
+			       0x1c, 0x00);
 
 	/* MACP On */
-	dsi_generic_write_seq(dsi, R69328_MACP, 0x03);
+	mipi_dsi_dcs_write_seq(dsi, R69328_MACP, 0x03);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {

-- 
2.54.0

