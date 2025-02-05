Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A4DC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57384807C0;
	Wed,  5 Feb 2025 02:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nlTwxnE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F59807F1; Wed,  5 Feb 2025 02:57:34 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7D98091B
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5f321876499so231026eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720647; x=1739325447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60ddC5PWqYlhlU/z35GZtb4E4G7/vlmLz6/ZBd8A/Mg=;
 b=nlTwxnE6/v+i9hNLKEYLZzNpMT93eIjfoMEtcSdWvAjkhzFsUctiH4ya1JC+/3Ih00
 h8a566fRvydBspTfDr4Cj+Q0NOuw4R9z4/7xlMIBV1uDTcc6rDhJ0lsBskuEBoo3Q8tN
 YUlVVMKwff4mKoWhDy8dkzhcLncpVBD1zHuxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720647; x=1739325447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60ddC5PWqYlhlU/z35GZtb4E4G7/vlmLz6/ZBd8A/Mg=;
 b=B+kNKPEGU/RUzdiZd4mRhSSSHgNYlyXiC/tjvH5i5V6eGx6BByawPhMiI5BikmuqNZ
 W6/qmJZ3EUkhCRX3Z6YoRwoKdYdwJt/FbzuEQtSdaZMsRd5Zo40llcl5rhm0KfiDdWDf
 oYa0sIaESLbkkDTa94WrvugEnfUfZQig+3nKx1zhYOzFHKVKx7eVLy8344Cwx2DRv7Tr
 LERWHRV5P8XNe8WBVEeUhTt+DM//Kho0s91R2v43YY4cNjzOgctgFEcYoSlxT1rPgfFH
 5ECnMwa4H3XqYWinJSImk39dcjQ/D7UGOiugbFLZzqdcOia0TEOzRoE513D2MYjQ3pLE
 QB2Q==
X-Gm-Message-State: AOJu0YxwLW3kJ7/ExwCwYFHEMgKH3w/eUD4kT7uIqvjcb4TUILSSgfGw
 1IWPfws+uN/sSgxnUEgX0tO1D7wAYli4FzCZABldcyFPOBeLuQQ1QeR/nQ5haMUO+uEM9+DtS7Q
 =
X-Gm-Gg: ASbGncsAshqx3uacD+DILPOxdFku43JCFMM5ldh1eTAiPG7HpBIWAm1QqxpHdefHV+/
 F22oUO0DOjhJNd7DoO/cxJHLwTBPNM1jlkux1d3uLDZW+MZHXQo6ZDVhi2ft8/9U2mzXf9GEgqz
 FFNtauUtpT2dkTVRk2zFiWuI9KnbkyvxNbg0nDGcaqfuQ/ZFvjEuu31xFafIb2+2sblB2XZENV6
 oizRfJzfaO9zIjqGpr+UX3NQnnYv+FsfEZhHTZj5S7niyvbq5l5XGOL2EYKQcF2srEbi3+pkswk
 Q/ab+TwpIqvs+GADVl89re8P/Q+xfQo3oGB6Wn9mQbQmBFgUENyL
X-Google-Smtp-Source: AGHT+IHxFdQUiL0T7M8w0vNm+p8CoznhKHlnHNzfIJ18Aj/9WjUrWC5qp0TgMZBOVuj/nzHF9B9g1Q==
X-Received: by 2002:a4a:d08b:0:b0:5f2:c0df:7ed5 with SMTP id
 006d021491bc7-5fc3bf5874fmr3219476eaf.3.1738720647698; 
 Tue, 04 Feb 2025 17:57:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 20/29] rockchip: Update rk3399 bootph-tags for VPL
Date: Tue,  4 Feb 2025 18:55:10 -0700
Message-ID: <20250205015606.2686149-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

When VPL is in use, memory init happens in SPL, so there is no need to
include the DMC device before that. Adjust the tags to save space.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rk3399-u-boot.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 2bec139d833..76efd703902 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -71,7 +71,12 @@
 	       0x0 0xffa88800 0x0 0x1800
 	       0x0 0xffa8a000 0x0 0x2000
 	       0x0 0xffa8c000 0x0 0x1000>;
-	bootph-all;
+#ifdef CONFIG_VPL
+		bootph-pre-ram;
+		bootph-some-ram;
+#else
+		bootph-all;
+#endif
 	status = "okay";
 };
 
@@ -118,8 +123,10 @@
 };
 
 &sdmmc {
+	bootph-pre-sram;
 	bootph-pre-ram;
 	bootph-some-ram;
+	bootph-verify;
 
 	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
 	u-boot,spl-fifo-mode;
-- 
2.43.0

