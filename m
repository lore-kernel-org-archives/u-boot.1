Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78524606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NgD2Vep4;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=iGFhqIeO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E979C40EC9;
	Sat, 21 Nov 2026 12:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XKmG9aV1s899; Sat, 21 Nov 2026 12:36:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F24C40D76
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264550;
	b=BCK2gHq6geuzwajwh6GiaEXiDqA9JvEjanEscUeI3X4Xlc9UrA81i80oER8Y5Kh1TGR0
	 6iba99+VD0dy01mI/T5WBsKvmuNGZBeZMx34uPnTUzd6G2ShDcfihHkmAPZmLouxU6Kpo
	 Ps8L8xgDC+MP8H8ZNwf0RQ4pMy/BPKhcinHpOQuBnz3uRopd9H/hL3sTjzyG+lnxYJllv
	 uB0DDfsmPHYHcnkboZHIh3He1PjK1bDgCKg5BPrWSRzbaSFHcti2ow/1lVPMuG+Pft8Yl
	 6ov5JwwKR0FqaeCfR1FOoaZgzkLQsxGyy+eAOI6MOBH1tmM3mhr66CHnJAS2s6KLOPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jEOybXixJJqY8dcaXOXiI81lM2ifuYZDk5tDSYU4ljY=;
	b=KXXfDSbPT8A6TeQR/EMGhtzIQdc2FmPxcCaKi4Rn7B0sKsOiOXSOIuiogL9TqFT74xBa
	 +MYPYjUNPzR67yw/R6nbc/fIRGUIpuvCNlwsd++Ap6FflmqNqh9Vej1agZoFwo36NgfUu
	 tbYMb/bmwWPCVG/poZOJ70TWMu4B5j4NXWKngn7orKkBQqLtbiYwexsXsLvOiPNYi4oeQ
	 vkhNGHhRqk3xc/qg7lCWkCLHdGM8CA9OSxZOyLJYop9Kpr/WWCusbtGJWlD2vgTxrp1bQ
	 l48ks4diKEIrfMq8MhRGv0++qnr7eKi/J5rFQKcTPPeQoheBu1mZx6qgBFTlkmcStOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=iGFhqIeO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264550;
	bh=jEOybXixJJqY8dcaXOXiI81lM2ifuYZDk5tDSYU4ljY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NgD2Vep4jnJ863fi/cwXZACdtewcg5QPQb7tfBAlFfwvXFpiHNHBs2aYVQIT555Jz
	 C7DPp4ER0ZaVUf1bhK7H/yp7S/y8DJgZLY4E9TawgZXzWDI+ePxgdv1TN9vJ+FnkmU
	 owBc1TvwN/Ve6rC6h9LCwG8kAHwYD0vPie9yA0Q2oqRyT6JiDNoPpgtgODE/J3RTcn
	 ZMqp6kXEYyq0/8L5gvk/ai9YahA3T+/peddmPWe6bYkCaBMgQSKHXTnNewjfiSrl9m
	 dXACUa/gOl279kcUEP/iisFT4UZ3GBRkHgFm+p6h9ZpIQBp4SdTw5c/36Ri90ekEmt
	 /ZJjgoUcaGsaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F24C40D76;
	Sat, 21 Nov 2026 12:35:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6E6C465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6C0F40D55
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ks1HKR528ZYL for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 314D2409C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=iGFhqIeO
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 314D2409C8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:43 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-491971ac844so1587008f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264542; x=1795869342;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jEOybXixJJqY8dcaXOXiI81lM2ifuYZDk5tDSYU4ljY=;
 b=iGFhqIeOHcRRXS81KihnQNKRqj8pm3ZP9c3U3htJSLEoZs7/YrmSW1Wjdu1EHys9Y5
 dgtBiwP1ZH82iJZdmG7kwdFwLvnWa8qM82RuCL6Lf7kzktqwPx6IXbwhaFoX/pY/l5+P
 NquAvNsqRz1/9S457JRrOijBQ0YXXQ7GZ4SaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264542; x=1795869342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jEOybXixJJqY8dcaXOXiI81lM2ifuYZDk5tDSYU4ljY=;
 b=oFZSjO/3KmWs1XmkxQbu8FRWTDPv84i0FgkupuNPJbCVPZm9Gp4uO6tuOHhMXQcHU0
 GQ0fkn5/vY5M7dFi4JQwfj2xJWPxCiawaoRCQtXA/JUhX8n3RH5MMczafPb8Os6F+ryr
 Ys7axkr2jFEvoiHO04ySDxYe56mNzt5BT2hXaQg/nWbGAUHgbrpZz+Mb+rbOOERNHrep
 5lFK/Nw3BWD3/RI7Nb5OODKkZYsgQ1d7TYnd2Atp+CGsGyLUWqsVLRhYge1P/pWmrKFk
 P833F8y4YgFVRNQRe58rNtxUqF/7Gf+EDIOFSjVIXiAPuRazIH4kr7p52TzMpGo77HR1
 jNsg==
X-Gm-Message-State: APuU4Z9zhURfV5TNjBCmLLX5kUWhZJhLt46yjHbL+6VSjRc/gW584WSY
 WoHl3STTjSboXwITIIJbCh3WZdrwGnZJeB8vkw0mbYisN6zcZu0wRDOF26EoHwlxUuvlBYoQMwE
 Sdhxo
X-Gm-Gg: AZFdTZcVLIts9U8+FCTJ1Rky7BGyfkqwAd9Ro/8reRj1JIJeWRUC22Owj7PiPOrq2Wt
 uEzy3BQ48/QGKU2ZuGriYp/K0Ok3aht1j7suQ3qW2jaXbGjUV34L0juC7YCiZ0m3Z9BDe8OQYCa
 HTkmktooAnO+QQ3f1HxIjqqyR+JRP6Jt9gwd1w/0KtfU5KTlbdNbEWPeVN/h8C2mrDdN+hcUqdS
 1ptiWeYzRa7XXkxmPYkiaQsRF3bB64Z69+6yPK5stht/3A4gPUCcv5QKopXP6LDTxpDDKePgKLt
 ZjtVHRbcBJlDZUTwpMTLuCkbPXFlIpI6zzLRzi7QgjsmaoJf074Ap3W6RoZBJxDHGD4uAi2mE9S
 7a760Z8WU6ZIxksHWYiOSB1oN5X11WUGN+eFwMHAKIPSDnTuYTuBX1UQbYFkszVz474yj1xSjkw
 Jh/xOM1NfnZ9GZ03VNPMNUkZlQN3MLVX4xbcxMf2b472YEUVLYqWFk6q0ra4BeGfVuZ6D1do+As
 jrCEku2uykrNAc7mxR0AaokojxjF+PpLWFpL44lokAtpy7Wq7WZmKwxCT51wD6fx8u2Of1S3+uv
 MT/SaLIvTOMAgB+0vyH5fJg6QowPl+EIsOg2NXtBcEP6jXtYRFfUvhyg4tC+DT9ybb19kHHTtHh
 SxZqgbnA7IJ6zrjFPpRYZybiCq1EVMh7hlhluVCjCgEi8UMR/ie434r1B2q1W70Og6MyjuAT8gL
 ShFIup5q+cIUqRFpIufbiKzMwVSA==
X-Received: by 2002:a05:6000:41d2:b0:48b:1296:52ec with SMTP id
 ffacd0b85a97d-4abb0c5d65amr12335116f8f.18.1795264541964; 
 Sat, 21 Nov 2026 04:35:41 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:41 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 22/25] video: bridge: samsung: support simple frame-buffer
Date: Sat, 21 Nov 2026 13:34:12 +0100
Message-ID: <20261121123451.2471185-23-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If you want to pass the frame-buffer to the kernel, the video output is
initialized by U-Boot, and kept by the kernel. The patch does not turn
off the power domains or disable the peripheral if you want to support
such feature.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/bridge/samsung-dsi-host.c | 9 +++++++++
 drivers/video/bridge/samsung-dsim.c     | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/video/bridge/samsung-dsi-host.c b/drivers/video/bridge/samsung-dsi-host.c
index 32257cfcca4c..5d01a0540be1 100644
--- a/drivers/video/bridge/samsung-dsi-host.c
+++ b/drivers/video/bridge/samsung-dsi-host.c
@@ -1281,6 +1281,7 @@ static void samsung_dsi_set_standby(struct samsung_dsi *dsim, bool standby)
 	samsung_dsim_write(dsim, DSIM_MDRESOL_REG, mdresol);
 }
 
+#if (!IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB))
 static void samsung_dsi_disable_clock(struct samsung_dsi *dsim)
 {
 	u32 reg;
@@ -1294,6 +1295,7 @@ static void samsung_dsi_disable_clock(struct samsung_dsi *dsim)
 	reg &= ~DSIM_PLL_EN;
 	samsung_dsim_write(dsim, DSIM_PLLCTRL_REG, reg);
 }
+#endif
 
 static inline struct samsung_dsi *host_to_dsi(struct mipi_dsi_host *host)
 {
@@ -1515,6 +1517,12 @@ static int samsung_dsi_enable(struct udevice *dev)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
+static int samsung_dsi_disable(struct udevice *dev)
+{
+	return 0;
+}
+#else
 static int samsung_dsi_disable(struct udevice *dev)
 {
 	u32 intsrc;
@@ -1532,6 +1540,7 @@ static int samsung_dsi_disable(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 struct dsi_host_ops samsung_dsi_ops = {
 	.init = samsung_dsi_init,
diff --git a/drivers/video/bridge/samsung-dsim.c b/drivers/video/bridge/samsung-dsim.c
index 5a366fa976c5..531303617989 100644
--- a/drivers/video/bridge/samsung-dsim.c
+++ b/drivers/video/bridge/samsung-dsim.c
@@ -158,5 +158,8 @@ U_BOOT_DRIVER(samsung_dsim) = {
 	.remove				= samsung_dsim_remove,
 	.probe				= samsung_dsim_probe,
 	.ops				= &samsung_dsim_ops,
+#if IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
+	.flags				= DM_FLAG_LEAVE_PD_ON,
+#endif
 	.priv_auto		= sizeof(struct samsung_dsim_priv),
 };
-- 
2.43.0

