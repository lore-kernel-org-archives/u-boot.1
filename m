Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FFBC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D690387688;
	Thu, 30 Nov 2023 21:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QGMBQ+Oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC948765B; Thu, 30 Nov 2023 21:13:58 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1466587626
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-58d12b53293so800898eaf.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375233; x=1701980033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwiKhfGYzd+YXYdJvZ0z4sS7kSl3wVtFL9OhV858Pdk=;
 b=QGMBQ+Oavfgocsy9YpXAhdOGlABejrGLeNBJs2Z1+rQRdAnCp06be2HAsqiRVlYTQK
 bQY3XWlocP9WllvBVFN3hlSdAxO+grJEY10IGMdjHGzBPMs+Zsz2AdiK9+RAAOmIQqPR
 yIVWAOdFYuZChO6vGQyCKVxTuybSoWt9CXTCB1DxVXHqM1P0MpYbgpjxFEqsD2bbHuah
 X3ZblkgD/mDLx36PkFY/DB1ih8YbDDb1uKN/s9aSJiSceF1+Aw9+pw+dLa/s1l3H1stX
 B5SY4cBS0A4+1ztnaR7AWK+/Q9W7liPkGuVwxpts5cvEGwBrrfD2fPQGIhbzsf3lgapX
 d+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375233; x=1701980033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwiKhfGYzd+YXYdJvZ0z4sS7kSl3wVtFL9OhV858Pdk=;
 b=l/Br+rkd7I8Q3/6DmrjoDP67y+s7yIw41rC5uQSNde/8r27mu8dgvADGWnYPuSEkqL
 g+km5kMnqu1ZoS2UMuAdD9Da+LC7LWDS2bsUqL5vTdyjRXyGROnLEEhWJMRJLIMFeXo2
 E5CrJcaiDcra+4vv4CSrnOXlG6avFvJxuN/Zc75nsEuq5MCUYJohiFSZH5vWOnEp2spV
 OONP45KTgWafykYSGTEJ7WoMN7WKJScEhj5ailJAMURtdIUg8qIAzkLrI7ceM7mV9twG
 prXaUBlMeT/ZQnwdoUkY+TQb8/gJC8LZ4re8VXzfp5glswnhM7rciHZyLEYPv/MnOJY+
 9Xbg==
X-Gm-Message-State: AOJu0Yw08GZvpDXlxvIRBnUvYKVC+tOzHCJsNJ3xC+bzcHYX882sEgze
 Zi4k9BJs6VCEq1oaQWxg/Cnrkg==
X-Google-Smtp-Source: AGHT+IGVqSxBdAcUKO70hcZbtldInhMiIRQgQCbiFL+q4U7rQnMDVFnVfNX/xzgMFoYgcB0bgBLazg==
X-Received: by 2002:a05:6820:1623:b0:58d:981e:bc5c with SMTP id
 bb35-20020a056820162300b0058d981ebc5cmr813454oob.7.1701375233701; 
 Thu, 30 Nov 2023 12:13:53 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 eg7-20020a0568200b8700b005879d3aa1bfsm284406oob.5.2023.11.30.12.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:53 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 1/7] pinctrl: exynos: Improve coding style
Date: Thu, 30 Nov 2023 14:13:46 -0600
Message-Id: <20231130201352.6379-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
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

Style commit, no functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c | 3 ++-
 drivers/pinctrl/exynos/pinctrl-exynos.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index 898185479ba3..995a3a0ee5fd 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -57,7 +57,8 @@ static unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
 
 	/* lookup the pin bank data using the pin bank name */
 	while (true) {
-		const struct samsung_pin_ctrl *pin_ctrl = &pin_ctrl_array[pin_ctrl_idx];
+		const struct samsung_pin_ctrl *pin_ctrl =
+			&pin_ctrl_array[pin_ctrl_idx];
 
 		nr_banks = pin_ctrl->nr_banks;
 		if (!nr_banks)
diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.h b/drivers/pinctrl/exynos/pinctrl-exynos.h
index cbc5174b48cb..6b19f196bc3a 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.h
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.h
@@ -27,7 +27,7 @@ struct samsung_pin_bank_data {
 
 #define EXYNOS_PIN_BANK(pins, reg, id)			\
 	{						\
-		.offset	= reg,				\
+		.offset		= reg,			\
 		.nr_pins	= pins,			\
 		.name		= id			\
 	}
-- 
2.39.2

