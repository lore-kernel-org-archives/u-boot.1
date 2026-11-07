Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF6606A334
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uPD6etxK;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CyRDkAsI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFA3560A8A;
	Sat,  7 Nov 2026 14:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AoXBOZ0jUwQa; Sat,  7 Nov 2026 14:34:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 315F9608E3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062053;
	b=DxccGIWw3thU5cK+zLJtqyBv+g0BLARJdCuyLG8wEOd3VbUPfcRxe4aRrBai6PRqUD4o
	 oKmFmTRE3BJPOCWaHFno/D7SAz6sUjDsjGpoNrbz/ErUpfvRoLZ53ahpLXOidVla9OffE
	 bm55boFrlz3HUBri9OQ7Ss9GJLeJ8pivFEz0vCRjQxI7Dxpg63baOzPpVJWn4vr+A4cqs
	 OZiGnAkMY1Qd3IHtR47wCroXxiBgGPUvdbqE4P6j+6Jia3hISU9R0i39Su2m/ya+GHTu3
	 eAzW1zfU4kt0lu1n0qpEbY4VpdirhASbJ9aUoxsRv+1vbMAwA1HLFV2fiCkIwcK950w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=++OYwq/kf0odgtRk6nXICVDkhN6FKl/YG/KKASFdtjo=;
	b=ib9pg/P42td401PcNWCyjpu4UNqv67COs0MCSc8h66awvcRnRXCnpFBug2zRntV/2wEf
	 eZtZeu1dH0JAFxjKstnugK7agOwTqTP7pjNlsTq2Dnv2rzs01j5moP3ZghQmdGtPdqetd
	 0xo6GA4x8umhGjkiZ4OAvurnOBVz6acvKTWg9lfLqcFkffEN4C1xEOxm4PlRC5XpOn9Ut
	 OgFdf2uFradvfpGWx9p+ONLwJ86MLz5chEV3oekM9A3fWPc6tLbIXsgCvNcNKjJ6d5ZYe
	 QbB+T9IqNXS7kF6od9z/619r3/3kIZVrgFX7b4jquzKL5EG3Kteh/V9sCrT27ePPMGg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062053;
	bh=++OYwq/kf0odgtRk6nXICVDkhN6FKl/YG/KKASFdtjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uPD6etxK8rkhaOC9iQby4Q6x+LxbyYhLvtV0G4Ci/jqC4c4JRVhZkGpUra3meTHIl
	 7Jyu9KxmO/OzkWbGfuGrQ1QL6OmKkLufDgipSgEDitc//8qbJ77mPOKGbWg+WUf8RT
	 XhiR2fE5bSrUh++yAEcezG2BTRL0wedkBqXeUlFVG6YxuUvCegFD5zfphrbg56wnr3
	 yBG7SfvQ4m3QMgi71X7BVmlmqNUzMH+SZsU9RxNuAus2e+8zh8otmKaMs7nITqUIal
	 9VbBD1MQXDBt2sbQtgZtoEego0Zb55/t6ekJ0UZ0OthDCQFLSfQLBdQBHbUaue+YMp
	 /phn/EARqwy0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 315F9608E3;
	Sat,  7 Nov 2026 14:34:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2190537D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 073034075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6jRjtXd3OJPz for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2193F40757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=CyRDkAsI
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2193F40757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:42 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so793679f8f.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062021; x=1794666821;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=++OYwq/kf0odgtRk6nXICVDkhN6FKl/YG/KKASFdtjo=;
 b=CyRDkAsI+DLtEfJOrRDl7OFLIYbAsfNKSkfba4qy7oSWe6kw74cnYOGbCAuuKFpnnC
 XTpgpbtYIXR+dgzrQVMJiMS07zoLVXESWWzASLjSLGqFEsGhE2ZDTHsOfSGi7WH4p9Uv
 /+hkqiZAmcEnTQlvNt8lVxHuimP/Xn0+W96Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062021; x=1794666821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=++OYwq/kf0odgtRk6nXICVDkhN6FKl/YG/KKASFdtjo=;
 b=tSdulbpjiBg2/0QW6JXNloXQ0NVbxY/KHEZZrbluTyEuOtOKMDG7KMUyLeqjeMhIYZ
 YQxt7WtGWdVMuqWgQ8sblQ0Qru6fiBSgt6mMEbougKutqOPOIgxZFsqooEG5uTmHKnxm
 aVXsUgXkqP0QBbtlmYAvpUHBoF49QVF8powz+FOnTQKu3qLf8vuhe1O9lv1K56teFEFl
 iw+gZvA8rk/7WWyWou6UwNhcr9MhijREnj/owyX1ki32qklQSF4gr2H9SyvmYZREYSoh
 UgAXLwrPVllVwQm5LYLV01FgNJ5rp9y0R1W9+Agt51b+Rqc/J2u73bQ79etAO1EkXIdB
 mkGg==
X-Forwarded-Encrypted: i=1;
 AL+hErE+oYKFYU/KyyWVfX9ybFoQEUGfgLHwO1NkHRqGK4k6ZkT5RUD35AixQefb7L0sxIgXh0ciQSA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+O5CL72gQWbGkQIWeMS55q+FdiqSolir5vPPiw4x813sb7+V88
 8/lw66lAHuwBPNwW9bLnnfW23i86igEtOeCGrZOYg6Fz/8HSkG1c3A1oUhWIlTROLPs=
X-Gm-Gg: AYBFou2nko73sD4qyBjfRcn2KQVGx73J53QjrI7mZl4P1QwoilcOaKEcRsd9uT63a1l
 Q3TlcM5DseryZASrKKId220Ofq9H7p0dFk4QOwFm5YAJ0QKuEvZdNgSFfb78IngkEbqs+RIlaT3
 QtHw980A1iilRGV6YAPHNidRZDhFw4ywquHnKvzZBruGG7hBhilHd7CB3XzhjvaZFEgT8CfXXBE
 so+WaFj603Yh924cGTpfDceIyKUjbbf27utFQIA/TU7S6nFrEfIEjS3InPTeUIiTs7OgBQ0BxW7
 4SYjkKijKL8yRgC4+ec6jvGbQjZkPbQjfLk3HO5eZ3Gg/eKmIvHt8LB3DLbramlI0vGeM310bP5
 MUm4ZHziJCvZcQpSyKoWIjNxu9OZ4gdnRWdsFeXALPIKA6b/aZzThaE8AdtBtP2yS40Uj5lx/8t
 YwlC+g+qqAIcHWY1aa4x0l38hjXUvoWH2Led7ZqQcZeIoTJ3dJ1vhyYyhrPfHkj6Nxb58iTD6iW
 gRhGChFXl8v9RJDn141VDZV366YvEaR0YgoUz+0EMcHWsEsvKmLGjXD/h2Y13FTvzef7zojOe9o
 1FRhsEMQ4KdDKzKpvxfXZlB3K5/bL4W1kYaQNKUI6BScdBG17mwkDDTIlq9jgYLTXuUTVZ7eqYK
 wJX/3gmLKCMFUr9gUHXRMrOpWD7MkwYDpXudUJ2QscEqGuW9umt2zg+YanCCfjzYgIi56k1FMME
 lVG5B5rKjJ3qufjBzU1yvo6Zh/Zg==
X-Received: by 2002:a5d:452b:0:b0:490:9fe2:6a2d with SMTP id
 ffacd0b85a97d-49276f38648mr6635391f8f.26.1794062020992; 
 Sat, 07 Nov 2026 06:33:40 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:40 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 28/35] video: simple_panel: add Ampire
 AM-1280800W8TZQW-T00H panel
Date: Sat,  7 Nov 2026 15:32:18 +0100
Message-ID: <20261107143241.2236511-29-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add timing data for the Ampire AM-1280800W8TZQW-T00H 10.1" LVDS panel
from Linux to the simple-panel driver.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/simple_panel.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 1cf587f973be..e674419fd912 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -208,6 +208,23 @@ static const struct panel_ops simple_panel_ops = {
 	.get_modes		= simple_panel_get_modes,
 };
 
+static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
+	.clock = 72400,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 40,
+	.hsync_end = 1280 + 40 + 80,
+	.htotal = 1280 + 40 + 80 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 18,
+	.vtotal = 800 + 10 + 18 + 10,
+};
+
+static const struct simple_panel_drv_data ampire_am_1280800w8tzqw_t00h_data = {
+	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
+	.num_modes = 1,
+};
+
 static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_CLOCK_NON_CONTINUOUS,
@@ -240,6 +257,8 @@ static const struct simple_panel_drv_data tfc_s9700rtwv43tr_01b_data = {
 static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "simple-panel" },
 	{ .compatible = "panel-lvds" },
+	{ .compatible = "ampire,am-1280800w8tzqw-t00h",
+	  .data = (ulong)&ampire_am_1280800w8tzqw_t00h_data },
 	{ .compatible = "auo,b133xtn01" },
 	{ .compatible = "auo,b116xw03" },
 	{ .compatible = "auo,b133htn01" },
-- 
2.43.0

