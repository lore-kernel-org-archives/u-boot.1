Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708E8C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73B8E88094;
	Tue, 19 Mar 2024 13:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SlU3V4nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D0587FEE; Tue, 19 Mar 2024 13:22:57 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69118809F
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-513dc99b709so4725579e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850969; x=1711455769; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=48uNnDAkvYwLB+hn6AaR+SUk3vahtEnsgd3/D8PKPeU=;
 b=SlU3V4nxWaAV0fKBH2n0Fg6odDWsp3j2R24awpKxWpeHEn5mYFrv0je/OT2YkEaNcK
 lKldp6lJH/rsMSIQZMkNQOqY7g+aL5OvPX1eIYm2+MZOpdDNDPZrRRTiT7EW0B/8I7jJ
 Dnk/fKuglC/1JWe0F2ert0BVwbNJ8lG0VLL3jMxB7dWO/Hl70bJtrUrBekkyK/bNW7tK
 1a+DriUoNFNKRrKW+D+n2pkv1P/IicBp7VoCIT6rcJ8OdlSB+YlEEHlB4UQJEhE1noZQ
 iFwqocJINg7HG+QSqmtjXF/6DXlIegWxQU1uaeG5WRWRuUPRiPY7GFaxFGtB2VBMAD5R
 a6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850969; x=1711455769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48uNnDAkvYwLB+hn6AaR+SUk3vahtEnsgd3/D8PKPeU=;
 b=jai44PrvvKl22gj80aqzQz79zLlJtNfCGaEHnD4/kOlMgrdd0QEyn62tw7fQ4Ocorp
 rRmVU54GJMHMw0xe8jNmlVEheg1QxWT5U8B+WjwihWqeFBw9ZTDsbZzjyNYOJn3FYHBV
 TdoI82rjlmh1Kq/rkrLgP/vxrHmaEfSgUDP72v6B04G4bIWcb5orA+FJpC6t/HhyAxpZ
 lbpS+n9aU9vcbVgcsSV9QecLpGrLvNR2peGffRD8Law7hvDoJISyvYGs+Xu0VaA1uB5k
 z6xmaPzQI8uCSYGGVjUcWhs9x880JTOCk9oHvp/yc/T07tJBzZK0Nom4TgkqMDBRznTl
 W/sg==
X-Gm-Message-State: AOJu0YyJF+unWkMlxw45rX79uRZPtBvyZD3QdKXVHySqlTWNugbwbSum
 ctLy8lkqH2/R6+7aBOgjeMKFVih0TY6Hadvo7Jsx3SL6HHIY30HiWxYJ1mPCq0N8vWy2etkuvH8
 3
X-Google-Smtp-Source: AGHT+IHXz+0kukAi9uNosjd0fF/VhEjEUmZwGEIL2cMnHGXyVnfJlfU5aw7G0J0I/2u6cSB0P9ukNw==
X-Received: by 2002:a19:8c03:0:b0:513:e677:793c with SMTP id
 o3-20020a198c03000000b00513e677793cmr1476258lfd.54.1710850969018; 
 Tue, 19 Mar 2024 05:22:49 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:12 +0000
Subject: [PATCH v3 13/14] qcom_defconfig: enable livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-13-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=83pJ7Dj+lR4t58XfH6x/vmjgvz7E3CotE7pIbUV2N/8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzV1zjjxPa4ucVyGjWGV0ap+ML6eUSmZA+Saz6a/XH
 VyzMMm1o4SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEwkaSvDj3X677dc1z34yYqH
 c5LetO/+VvMOBT47JnNJ7liQ2dRTSQz/06tPHO0yTGZuy7+75nV823aX5z3cSkW7ZrufcKipm5L
 6CwA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Qualcomm FDTs are on the larger size, and with the addition of DT
modifications during board_init() it makes sense to enable OF_LIVE
globally. The cost of building the tree should be offset by the
increased efficiency at which we can walk it.

Some rough measurements with CONFIG_BOOTSTAGE suggests that this might
add 0.1-0.2ms to the boot-to-console time. However the reset-to-reset
timer difference is in the range of 0.5ms so this could just be noise.

Suffice to say, no significant slow down.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index cbc612b44bd9..eebd0d74bd51 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -25,8 +25,11 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
+CONFIG_OF_LIVE=y
+# CONFIG_NET is not set
+# CONFIG_OFNODE_MULTI_TREE is not set
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y

-- 
2.44.0

