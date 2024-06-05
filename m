Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8EDC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A76F882ED;
	Wed,  5 Jun 2024 05:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZGlSdszl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D7E88315; Wed,  5 Jun 2024 05:26:42 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2D2882DF
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-374b05c4f40so3589325ab.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717557998; x=1718162798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zv6C3op4MH2MkMkOMJhljeFlThCAUnVbQHGZunveQ1g=;
 b=ZGlSdszlHO8cCO3CQnr6fRiBBLFyqljjXDGcNDr2W2C83qKF/cFAjKe0ersTYeDQWT
 6///REZR6vwrHJIpv3PHwYkDwtNNXMx5Y79SV6GA/QGAv2qn4z9yzPZjel8RT16OO1/S
 rQsRAFzg/mKes4qAbak7uhT163od6uV+KKlO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717557998; x=1718162798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zv6C3op4MH2MkMkOMJhljeFlThCAUnVbQHGZunveQ1g=;
 b=Naz9keM0AlStoRTRjyE9V+dTzvfeafocnrvfElzsH/oUjgAxiPIgGoPJT/VHtQeE9y
 F6BoIwDkfxYzUzNGO78Ly62MvVELSFfhfcXJBLl2o54h5XCjOo4E8fkH+cfBIP+YaBTP
 fdXz3eexh+uH+Z7zzs1K0oblBwGKGZyRkMbDdpWv/nZWeupoDNr+pcDVp7dVQOkTTQhp
 imMwxGnY+hC1c6P+TqJrsIO10sXGm4ai3sk2rrAk6PFNbauQ+j5XKeGFiaBpgJ+1+B64
 nhUzwOaLxyLZI0Wum9MsmmT0/guC04uGNQI1Z/TWj2Mlv4njDKUv1ughXkxWtkei+A+j
 DLEw==
X-Gm-Message-State: AOJu0YxoXpDmpHYISLPI6xxUuMYDpPStWj3htxWQvH5vV2ysthmGB7W0
 P6O0JZRBtmHsDvyt2Wz6IhclivP2IXWpskxf5gtPa3atjuwpijAp0q47I0CHy7zuaToSUcrP6wL
 QLNpR
X-Google-Smtp-Source: AGHT+IEtNMNGGDTvROMe+HMxslBF11S1DoiAmyEmjcgl4ECshoNwzRHiQ7G4Wyn5+mLIFVnt8XgNvg==
X-Received: by 2002:a05:6e02:b23:b0:374:8a84:6bf7 with SMTP id
 e9e14a558f8ab-374b1ef309emr14784425ab.8.1717557998558; 
 Tue, 04 Jun 2024 20:26:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH 3/9] rockchip: veyron: Add logging for power init
Date: Tue,  4 Jun 2024 21:25:15 -0600
Message-Id: <20240605032521.1142768-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

Add better logging for power init so that CONFIG_LOG_ERROR_RETURN can
be enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/google/veyron/veyron.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
index 32dbcdc4d10..23fe8bf088c 100644
--- a/board/google/veyron/veyron.c
+++ b/board/google/veyron/veyron.c
@@ -29,44 +29,41 @@ static int veyron_init(void)
 	int ret;
 
 	ret = regulator_get_by_platname("vdd_arm", &dev);
-	if (ret) {
-		debug("Cannot set regulator name\n");
-		return ret;
-	}
+	if (ret)
+		return log_msg_ret("vdd", ret);
 
 	/* Slowly raise to max CPU voltage to prevent overshoot */
 	ret = regulator_set_value(dev, 1200000);
 	if (ret)
-		return ret;
+		return log_msg_ret("s12", ret);
 	udelay(175); /* Must wait for voltage to stabilize, 2mV/us */
 	ret = regulator_set_value(dev, 1400000);
 	if (ret)
-		return ret;
+		return log_msg_ret("s14", ret);
 	udelay(100); /* Must wait for voltage to stabilize, 2mV/us */
 
 	ret = rockchip_get_clk(&clk.dev);
 	if (ret)
-		return ret;
+		return log_msg_ret("clk", ret);
 	clk.id = PLL_APLL;
 	ret = clk_set_rate(&clk, 1800000000);
 	if (IS_ERR_VALUE(ret))
-		return ret;
+		return log_msg_ret("s18", ret);
 
 	ret = regulator_get_by_platname("vcc33_sd", &dev);
 	if (ret) {
 		debug("Cannot get regulator name\n");
-		return ret;
+		if (ret)
+			return log_msg_ret("vcc", ret);
 	}
 
 	ret = regulator_set_value(dev, 3300000);
 	if (ret)
-		return ret;
+		return log_msg_ret("s33", ret);
 
 	ret = regulators_enable_boot_on(false);
-	if (ret) {
-		debug("%s: Cannot enable boot on regulators\n", __func__);
-		return ret;
-	}
+	if (ret)
+		return log_msg_ret("boo", ret);
 
 	return 0;
 }
@@ -81,7 +78,7 @@ int board_early_init_r(void)
 	if (!fdt_node_check_compatible(gd->fdt_blob, 0, "google,veyron")) {
 		ret = veyron_init();
 		if (ret)
-			return ret;
+			return log_msg_ret("vey", ret);
 	}
 #endif
 	/*
-- 
2.34.1

