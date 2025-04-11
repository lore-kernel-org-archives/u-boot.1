Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286F0C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDEC841C2;
	Fri, 11 Apr 2025 17:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V+liYRb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CFC5841A9; Fri, 11 Apr 2025 17:31:03 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD0A841AB
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a823036so21651985e9.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385460; x=1744990260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kFFsVYgIy4+Sawto1O49iXalaUGkgNmp2yrRqQpTYM=;
 b=V+liYRb/+C4QuXwCRLwG7wEiC9h0KAcH9GfoZLV59YXHBNkUkSMZB2qZDKiGq7uWrj
 LK95io9FPVLDH+ge4cXZldISknjG63m741tZZiC6uO8XJ/q8qLhb9W20WSjRZc87rVgz
 UOsksMmXtPpvm/9b+DCX7VKfnZt50SEn9yhoXicXwqc/ml/ELfUKNST6JVJUs0hkbA1Q
 wio5Q1yMhs78rtjZjOXReL1jEp+1ybXtzmVoY85qtuuJNHcaB3IwhjZJb4vyjOaV5wUc
 Zxq80ZCmj1rk7wCpnLWs5VPUAnTz44CaDSEnttK8a8fwhMSRqbp3+Aq8Nf7lHnJ7wHVl
 KaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385460; x=1744990260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kFFsVYgIy4+Sawto1O49iXalaUGkgNmp2yrRqQpTYM=;
 b=Ar+LypT9BBvE/eKPmrpSI4mQOtnUqU5NLY62KXXe5hzvPSv4LwqKzgq66l95KCmEdE
 C8somiabtrmyI19LioisyfqdkrbzpF2wRvYl/xHB/Fh4daPeXBfAsrpVjsN2tJ4Pujrc
 fqgIiJIV5GpWd4Xed6diQ7V2D7HcC23Ul7SLeSJcS4GZde1m8Gfc9ZFCPeiLAZ51cHQQ
 PoLxa9cVZqOfvHUs06k19RVdOP5Km1EJoscl078ZI3Un/VkzwvceFe1iUCfrcoCC5z2e
 t0MyBbvHvhzh2OYf/sZndkX452amYq/zKeCW0DIvIiCEDYPn4iHPH85D1ZnRF8uX4fGk
 zEtg==
X-Gm-Message-State: AOJu0YxBnSfaZRp1PWSvLMaRHubzdUQ+XvSc9T0C+L3oX5N6FrgS2zFC
 t4IyFXtaATGJv7X0oEtM8bRpYJ3nSLHsy8X8dLws/gPfWKcykwxFU3jc+E7s+Zgl0prqd/0RRes
 y9vw=
X-Gm-Gg: ASbGncvTwE0Nex2o8+9OqN1xFR0hGXNtfAx/FEXgJvgDQP8G/PxDgMcpfPXFzEa2Mzo
 dYPDUzwyAAR9TrlgiYBSyw9QKsu9Fo+z22Cy69NBVH3/zdbbM5mdtpREqu9wGq5Nv3txzmMXaR+
 GwbShc2Mg7L8vzuL8oQL+H/unkg4WPt8gXoSxAY/dwvpp8RZ4OXMbTxs5WgCyn78F2rwY4XfC/h
 m2ZulqybwdjsoTAUvCffs8LCAaGhLpS4xT4b5TyuEaFK/iE6otSbw2zBegzLUGFQRVisWtdXaZo
 H2CEqrDAI23B1OdqW820OWFGlQjvCcE/1iq9vXanwVhas+ziKQ==
X-Google-Smtp-Source: AGHT+IFjGW3haav5A9G/qVjAbu0jrZgof8cKE+JQCLYuhd9uMTS0q9u5PAjUGXhkGxFYLZeNclPZSA==
X-Received: by 2002:a05:600c:4e13:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43f3a9add63mr33398905e9.27.1744385459966; 
 Fri, 11 Apr 2025 08:30:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:30:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 6/7] sandbox64_defconfig: enable bootstage report in
 JSON and InfluxDB formats
Date: Fri, 11 Apr 2025 17:29:32 +0200
Message-ID: <20250411153040.1772000-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411153040.1772000-1-jerome.forissier@linaro.org>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
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

Enable the bootstage report in JSON and InfluxDB formats. This also
enables the unit tests (test_bootstage_report_json() and
test_bootstage_report_influxdb() in test/py/tests/test_bootstage.py).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 configs/sandbox64_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1236ce474a6..c006a3300cd 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -20,6 +20,8 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
+CONFIG_BOOTSTAGE_REPORT_JSON=y
+CONFIG_BOOTSTAGE_REPORT_INFLUXDB=y
 CONFIG_BOOTSTAGE_FDT=y
 CONFIG_BOOTSTAGE_STASH=y
 CONFIG_BOOTSTAGE_STASH_SIZE=0x4096
-- 
2.43.0

