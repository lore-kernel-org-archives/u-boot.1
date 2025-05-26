Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D665C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 19:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CAF82F66;
	Mon, 26 May 2025 21:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rm8GImvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D33582F66; Mon, 26 May 2025 21:48:24 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2097A82E67
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 21:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so2909480a12.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748288901; x=1748893701;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLsGuxK/lxlxGymsNoCnrEwVCRldjS1bh+q96LnUTa8=;
 b=rm8GImvNpLnyeQxKiTH/Er870JIp3WZZdOogktOxaEhQR6llLX3Q83SFdkUPWzDbeq
 v9feL/bxTLAP8UQE113Hs5WJuZXl/Lj+Ay5aPRB8yUSV3W2F6uK/Wr8Z3/S9RXQYKQbO
 bLQcABUhkzVHC9KSjVWSLeB5ByFkrvUoFmKCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748288901; x=1748893701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLsGuxK/lxlxGymsNoCnrEwVCRldjS1bh+q96LnUTa8=;
 b=aVEGOvHj6nQQ3XSUe816EqYqAb6ycb7Y62qnsvqEPRGtpuBd9CJf77QT3JC6EXVpga
 V6+KrntzSk1//5SYPyVEQSLFELlI+uJTgNl92dn7i5324buYdf878PX+S7STEu5WTLEU
 QvjtffwDlUKnRznn0ldxdE4hMWI4fFyXMhgTOklTislrB3dDqgyP5khtVr2yjYbtc5jv
 BocR3XV6lTx1jnLmULw7N+7KgU98GoFyK+XtsYxExq/p1Op7Iw9M7f6eaw6trAbjOWdq
 DRieBW0ImypNi8x7teUWlAeCGDHifPVhy1CBaZ3Tc37uxUJPEHWk+eFaUZuKwJk7cUro
 g9Xw==
X-Gm-Message-State: AOJu0Yxnm5UlOqmZyhBDRDtfp52m+f/SB2ADA/AYEmdUlDarG7c/lvt/
 Q+e37rWvXhq3GT0yH5Jn7PPJJ040pQHTf8DKWqXCFHSSLtO85oE6c1R/9hf/6iHhc4KVOINPkb2
 L+YrxjEU4ZA==
X-Gm-Gg: ASbGncvUDst6Dsh6K1qs/22plegs15yvEL9OZzF7D2gs5XXrhn0J54/Mql+T6VO7ITG
 ICdzYtp21QFWmpREVMeaZydqpIaqOBRd/XYQMY+kODe18hiQ7zoEC/euRKtf7oCnRaqHqWmgNpV
 R79wwmIb/8HZhyvZnfHjucKaUQ5ufWQAHyq9YWYobykKFsT0g8IbDItFXQgQOzMch3y3nSuRczS
 1Aq7heH6pfnWpHx4vRUQBsataouviYkaE+AIJ1bVoiE+cdeW+Te1m0t1m0J0/DAQ7zjGDYTxz6b
 TmRTrUvxeYhxZoD2M+qrnFfHS7j4BCUKN6G80MZrcGE2CSAivynAT2+6XZgGcKjNdNngIOj5K60
 =
X-Google-Smtp-Source: AGHT+IFwHMVGEvLn7pdpvdNw6R6pmsze7mquPx905RhDVgGZiS+EDivcWSLorfAUg3KWOwFMRhMZ1A==
X-Received: by 2002:a05:6402:350e:b0:5fb:6172:c0fc with SMTP id
 4fb4d7f45d1cf-602d9af7e43mr7540388a12.11.1748288901005; 
 Mon, 26 May 2025 12:48:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6467:4426:e776:7e5f:5044:b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-604c0084c2dsm1416109a12.3.2025.05.26.12.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 12:48:20 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] mtd: mxs_nand_dt: Move from clk_get/clk_enable to
 clk_bulk api
Date: Mon, 26 May 2025 21:48:00 +0200
Message-ID: <20250526194811.1179530-2-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526194811.1179530-1-michael@amarulasolutions.com>
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
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

Make simple the clock registration and enable and allow later
to add support for other platforms

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v2:
- no changes

 drivers/mtd/nand/raw/mxs_nand_dt.c | 48 ++++--------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/raw/mxs_nand_dt.c
index 11dbcbbf442..b62474bc5ab 100644
--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
@@ -100,9 +100,7 @@ static int mxs_nand_dt_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_CLK) &&
 	    (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M))) {
-		/* Assigned clock already set clock */
-		struct clk gpmi_clk;
-
+		struct clk_bulk clk_bulk;
 		info->gpmi_clk = devm_clk_get(dev, "gpmi_io");
 
 		if (IS_ERR(info->gpmi_clk)) {
@@ -111,47 +109,11 @@ static int mxs_nand_dt_probe(struct udevice *dev)
 			return ret;
 		}
 
-		ret = clk_enable(info->gpmi_clk);
-		if (ret < 0) {
-			debug("Can't enable gpmi io clk: %d\n", ret);
-			return ret;
-		}
-
-		if (IS_ENABLED(CONFIG_IMX8)) {
-			ret = clk_get_by_name(dev, "gpmi_apb", &gpmi_clk);
-			if (ret < 0) {
-				debug("Can't get gpmi_apb clk: %d\n", ret);
-				return ret;
-			}
-
-			ret = clk_enable(&gpmi_clk);
-			if (ret < 0) {
-				debug("Can't enable gpmi_apb clk: %d\n", ret);
-				return ret;
-			}
-
-			ret = clk_get_by_name(dev, "gpmi_bch", &gpmi_clk);
-			if (ret < 0) {
-				debug("Can't get gpmi_bch clk: %d\n", ret);
-				return ret;
-			}
-
-			ret = clk_enable(&gpmi_clk);
-			if (ret < 0) {
-				debug("Can't enable gpmi_bch clk: %d\n", ret);
-				return ret;
-			}
-		}
-
-		ret = clk_get_by_name(dev, "gpmi_bch_apb", &gpmi_clk);
-		if (ret < 0) {
-			debug("Can't get gpmi_bch_apb clk: %d\n", ret);
-			return ret;
-		}
-
-		ret = clk_enable(&gpmi_clk);
+		ret = clk_get_bulk(dev, &clk_bulk);
+		if (!ret)
+			ret = clk_enable_bulk(&clk_bulk);
 		if (ret < 0) {
-			debug("Can't enable gpmi_bch_apb clk: %d\n", ret);
+			debug("Can't enable gpmi clks: %d\n", ret);
 			return ret;
 		}
 	}
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
