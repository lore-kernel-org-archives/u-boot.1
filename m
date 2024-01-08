Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7809CC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 15:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768CE87A77;
	Mon,  8 Jan 2024 16:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ILAhnaJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8B487A7F; Mon,  8 Jan 2024 16:34:04 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6729D87A35
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 16:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d5a41143fso22471225e9.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 07:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704728039; x=1705332839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Djf2VOIsiPNzb63DUIxbLl10/dZ9vIbkFTNsHbExmT0=;
 b=ILAhnaJmATLy6DK8mCLdCcC4x6rJSNmtpIdJKClrOtgcFDkbnmYNz3cDvEbRFzuwba
 NsuH2Xj610iY32v77P+udQmMaT4j22PeHPd139D8c/w/1ZeWCvr4re+9C97V4bqP45QE
 TbHTRF05J/1zDOafx/EBak2WHWZpsK5fMWqqJhFFZegJO4z6H6LhFlw8LvfjDr/5+HTv
 vkAbvU/603g3f+P45S/8PvEuU16o5vbtgFPfJX3yHv2xJFZBongovg3gGXHpKQP5GMZ0
 eH45DTDGa4BwYRRTzU7PInTW+IAucSLy1eNCDTucWSPpt1fwwhUGSjkspEZ7FfblaCA2
 kPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728039; x=1705332839;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Djf2VOIsiPNzb63DUIxbLl10/dZ9vIbkFTNsHbExmT0=;
 b=glwN3C85JC0zlLf4LpVl5ZSlE+E0x5nb0Ih5dMRvZyfiXYygRMcgRSsaQPDGfaRqpA
 kS6YxPsqC91pMq0JN0N16rHi0Bi7vdcIhWWkq1KjZID6dr631o41Rcu33ldC4Urh4L2t
 lseQWt1xwSnPWs7hrAIjUUvuRa206o/P6mCsl/kmf0hrcOTJ5G1MPKjmYscFPBcw9l4a
 oDXdeJBImlSeuMIrJus8MNl32dZio19iqbhjjj5ylQ3nF3S/8N87aRADw4s6NitOXCz1
 oKE5sYD+xQsIRkEg61+a3yCQHoZNxkMwdyv2uE6Y+NK4Nc6IPaM9/U//CZ38KMIyzc9+
 8ZVA==
X-Gm-Message-State: AOJu0Yzf7j7Q0h/867QFXcwowyNH6Kd3ierxrzXi0uwY8kDP2wpzJ3hh
 khKBwn9Mq+ISldBr14l8I9VKc7iQNlAj9Q==
X-Google-Smtp-Source: AGHT+IFYolRRatto3g/KDAjBPS6H/fRVzGt0kOuFA/ENslMfkDtRZdQIq1k6m5v4Hrkgr0tXzFxiyA==
X-Received: by 2002:a05:600c:4f02:b0:40d:8ff4:ea02 with SMTP id
 l2-20020a05600c4f0200b0040d8ff4ea02mr1925235wmq.86.1704728038837; 
 Mon, 08 Jan 2024 07:33:58 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-230.as13285.net.
 [92.17.96.230]) by smtp.gmail.com with ESMTPSA id
 df18-20020a5d5b92000000b00336a1f6ce7csm8075266wrb.19.2024.01.08.07.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:33:58 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] v2 test: spmi: fix tests
Date: Mon,  8 Jan 2024 15:31:44 +0000
Message-ID: <20240108153351.1605918-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.42.1
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

With the recent changes to the Qualcomm PMIC GPIO driver the sandbox
tests for it no longer pass, update the DTS and tests to work with the
changes.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
I'll pick this into qcom-next as it goes along with the PMIC changes there.

V1: lore.kernel.org/u-boot/20240102-b4-pytest-sandbox-spmi-pmic-v1-1-227d1062b3d1@linaro.org
---
 arch/sandbox/dts/test.dts | 2 +-
 test/dm/spmi.c            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 4fe72664c4b3..e264b29554cf 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1544,10 +1544,10 @@
 			spmi_gpios: gpios@c000 {
 				compatible = "qcom,pm8916-gpio";
 				reg = <0xc000 0x400>;
+				gpio-ranges = <&spmi_gpios 0 0 4>;
 				gpio-controller;
 				gpio-count = <4>;
 				#gpio-cells = <2>;
-				gpio-bank-name="spmi";
 			};
 		};
 	};
diff --git a/test/dm/spmi.c b/test/dm/spmi.c
index 9cc284b98cb0..97bb0eb30fc9 100644
--- a/test/dm/spmi.c
+++ b/test/dm/spmi.c
@@ -81,7 +81,7 @@ static int dm_test_spmi_access_peripheral(struct unit_test_state *uts)
 	int offset_count;
 
 	/* Get second pin of PMIC GPIO */
-	ut_assertok(gpio_lookup_name("spmi1", &dev, &offset, &gpio));
+	ut_assertok(gpio_lookup_name("pmic1", &dev, &offset, &gpio));
 
 	/* Check if PMIC is parent */
 	ut_asserteq(device_get_uclass_id(dev->parent), UCLASS_PMIC);
@@ -92,7 +92,7 @@ static int dm_test_spmi_access_peripheral(struct unit_test_state *uts)
 	name = gpio_get_bank_info(dev, &offset_count);
 
 	/* Check bank name */
-	ut_asserteq_str("spmi", name);
+	ut_asserteq_str("pmic", name);
 	/* Check pin count */
 	ut_asserteq(4, offset_count);
 
-- 
2.42.1

