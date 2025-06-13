Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FDAC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 18:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0A9B82F5E;
	Fri, 13 Jun 2025 20:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kpcfem/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F8682EA3; Fri, 13 Jun 2025 20:10:22 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA0682E5A
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 20:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so1954882f8f.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749838220; x=1750443020; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hy9f1fn3I5ALecq0gO7fGgrlqtFF5LhMfrdPKYET62Y=;
 b=Kpcfem/uxPpb86CMXdTWpTdYYUqD3ckLvFjh6XNUJVeO+SyMlvQWQxQNt/MNGH18am
 rTQGxatWGALUtd3H/XHlp5W5+8JwH+7+gJ9yfXMMP2oJXwfobJGhKTL51/jAySI9shOX
 XdWmNKMo7xAbG5oOlqH4FAo0cGI+3aLUmeU0AbI1M0SIWMlbEwAIXk1ky30c7PJtHB+7
 F80W8YMMH4mCJq+sQap5A7odPatZfSLQkxI/RUOor5pu8tuNqDL50Qh1o4U5fO2cutjf
 kqqyuovZ+Wy8TtmzBNLdUxee+sxkG7rHLXRPYw7vY4+A4uHxGS61mn8polDA64sa5erc
 Xh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749838220; x=1750443020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hy9f1fn3I5ALecq0gO7fGgrlqtFF5LhMfrdPKYET62Y=;
 b=l54E8mYVOtDB16LRbdGMFJv8tD92bMv0f/3z6ip26ou93j8dusP3agzcmMPSabKwLO
 +dZIZr/5XUFkbju5w+OqGN4vjKyoQFliGFP5SnshDnT+/O4K8Eu3DY9vaQ1nc0d3StoC
 g7OWpnfLVHcx5/WLu2ISq5NbkgMsMIHk1Mpgc2aZWuxKK74NPgnWRqsWZMFkXhYZsLbH
 IMhhFGfax7qm20jSCozlCS2L685xMbfILW5ZDJ8Ds7hVgHl3RKS09oUV3k3XIMvgLAs+
 +hRGuwv4H5wKSDyow2AGVcVAGH1s2+WX3/rmC4nALtkYxCYIQRBdwKcF5lAUN2/dDf0j
 fG8w==
X-Gm-Message-State: AOJu0YxOj35gdVNj1pX6CNKOa8Sws8A1KDs79hnl3DYG7nl0xWO0Wvgd
 gWWbbTLByuSAmCFToFqvVMIU0ANKFEXYuhrvvDY5SibE9KdcuuTe7OBndSEMl05DVyA=
X-Gm-Gg: ASbGncsCumqtqNDuyt8MUFv97r9ZzUxVQVMauuvk5bItuC3c8O/zv2qvqyEub3Jh888
 E4RWQy9Lwe0p21WQE7lMitz3QryRsSxrPpPgvhT+N/g5wCCaxrSKkviRVK953AbAczcDM0eVGgi
 S8OdFAyLn7l+Wc7Q4FJhLv65kIvRfabSiR2Hh9oYAfuqxxUUH4teJHcEEJo+cnC04eSLif8oWbR
 vuJSWGRGI0LX8wtKOHW+ikFDgNeGGn7EdiaavIomzQSkgfHV3LZIWKOWC5C1yqzZZF2tK8URbL6
 SHcJjIX/CrMnHUuYtOu1rXihWPtiWl8756TfCSDZAoXhKRk73mISAfe7kHmq221mN9GP
X-Google-Smtp-Source: AGHT+IHzrFy7ahO8SXqwDzTSjA3vTZDWjKOeAlP+UX12SzG5nd11ZKZzPG3cq9cfmJWt0nUH5bmjbg==
X-Received: by 2002:a05:6000:402a:b0:3a5:2cb5:6429 with SMTP id
 ffacd0b85a97d-3a572e92000mr796084f8f.43.1749838219736; 
 Fri, 13 Jun 2025 11:10:19 -0700 (PDT)
Received: from toyger.lan ([213.240.182.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc98sm61511975e9.29.2025.06.13.11.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 11:10:19 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 13 Jun 2025 20:10:14 +0200
Subject: [PATCH v3 1/5] i2c: geni: fix error message wording in clk_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-geni-load-fw-v3-1-be778b3b101b@linaro.org>
References: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
In-Reply-To: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=kzBWmmFWAnrmw5DkvENtcU1+kVlPOh2dJ5Hl8gqjEzg=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTGmHkXJLQy8Nk7iBTwuZBuc/ODJmJHdC5yMUf
 Bkl6a0nfO+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExphwAKCRAFgzErGV9k
 trz+D/sEbaUEuZyDm2VTvvBECrAoB8/Z+q7BGMTyf2VoTT3FUUViyD0G4QZcyXaHmMfSQyU/QSY
 m7f/omLTmBjho6nq6om8E2WW8w2klG5sElIMAJL2PlfynTtIFmp5BjSAFWdBrdVS+q07T/JZJof
 Tw5p4UkH0ZoBqz3rfc5p/f/KEyBgtcuvQF4a7b5GQP/R2g0KOPgpwMWEcSZI/hq6ja8u1hwl9Fu
 qy+GCHtyC+aDYoi8ctu/PaXxu5v7FnnAzgzo4GCqgF14HUx227R1CtHdvVqKj5Bt8wuf4X42oLr
 X8abk7yLTUtuxn3gtrhc2rPXpxFt/3O2qZSBt6phBrRPku/LLxTg2BWEYO497xBPBg5Mkb2DEh3
 fuXZWxHq/KR2AZnQ545WLeaiM9jBU/p0vPOYpCxUKSZPS/CRdlKiRaxQbM8J1zVga9PHkqT7OiW
 CHaQ08ncxI4hbcce2AkHA2nNhryraz9Pu4i0ERDd1+YdaPqq1vhkn9PymVG/mKIbJslnv9YqSQ3
 CaTs3VMVMQf1oDNW0zGTQGNdHEnZ5LrrpoVU//QzgJRkkZ8ot8q68OM7jd3BRbsfDqK+G9N/uDg
 MZQ2XLgnXpTmYoUjNVOi0YJyTwnsGXRJzjI0HLov+30q0DW40yZIi2iLDVSVBfXMeannzggV+s6
 7Ld46Ht3Xr/7bKg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Correct the error messages so they accurately describe that we failed to
disable the clocks, not to enable them.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index eabf5c76c21c2bc12c80dbb9fb498a0080928248..4eb41ba852f7790ca646c8ba38f29fdb727fa804 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -330,17 +330,15 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
 
 	if (geni->is_master_hub) {
 		ret = clk_disable(&geni->core);
 		if (ret) {
-			dev_err(dev, "clk_enable core failed %d\n", ret);
-			return ret;
+			dev_err(dev, "clk_disable core failed %d\n", ret);
 		}
 	}
 
 	ret = clk_disable(&geni->se);
 	if (ret) {
-		dev_err(dev, "clk_enable se failed %d\n", ret);
-		return ret;
+		dev_err(dev, "clk_disable se failed %d\n", ret);
 	}
 
 	return 0;
 }

-- 
2.49.0

