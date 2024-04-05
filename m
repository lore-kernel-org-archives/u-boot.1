Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5460CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885CD884E6;
	Fri,  5 Apr 2024 11:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t8tUFo6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9D9884CA; Fri,  5 Apr 2024 11:08:54 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C14E884EC
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e28be94d32so14531475ad.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712308129; x=1712912929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rK9W2AGbnOfcXupe9xf5SOw7PSXaV/7az0Pvlu4dzww=;
 b=t8tUFo6TlcxkfnEWzhjHs/bPQeRtbGjvafQUfRDzJOoSvb5xydy3IPrxzXDfTBE/1K
 8EGoMTnfgjkHC/26uom6Hhb1MYPCp03pq+PEYgPTiqRofFI0x2thtSD21cYVktI4yMgd
 xJI0tk1sr7uIGm9eF1tIK7HLMWKVBqryHbjUIEnqe7BlPCDMQTaWeUXw9/YAZhq27Jca
 PbA6mz0HPg44B1+pWbI0+lLdqMd4efDC8OLGjYcj6FsEGIybI5fXNh5khAZd7TJ5FPzg
 ttD9yWf8KpOGMQK+BHlhTI5vk6Z1NyHits8WSFu/R1iLrwMtLSYGQRUrfHkiWwcZLcNh
 j8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712308129; x=1712912929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rK9W2AGbnOfcXupe9xf5SOw7PSXaV/7az0Pvlu4dzww=;
 b=anQwteXFqLAAPXHujBH548YSORsbcODPNmcrNLi0FZsJgnw0E3uVmOJAhpDkgGAbqU
 FitHdOJXImEECP0LPbFzMbG65O/oYwaguR92EX1iFdx0IFRlkBJJ8IaWMCn6ervxFyBb
 DwaO+D734YVbLBYKu8FGJl766HsSlutUkrPUxei1bPffJRSVDbRnmOAWrKwNWys/QzMm
 f+V61Rv3S8h9NpzF1aRkBqGkm4b5ELQerD2bnFBFkRloVm//ZDzsmaTadYTfSSHumdEH
 lVqZJv4duMGaD/uXxRZAeeBTBF+vyEdQbq1a5Oq82MjfFECjn7QH7IMTCfDmE+NBY3pY
 V5og==
X-Gm-Message-State: AOJu0YwIL0VeDrvFAc9DIDEGxaSKEp0TFuk1RGrgwEHPQtIU/ryhsSwC
 nDUe5Fsno4Lfijxk0CfxIScGpM1TIxXC7dlnIbIWwbCpv+UC+P5RHsapk+m4D6D2RTbxZbqOxfc
 v
X-Google-Smtp-Source: AGHT+IHTxuu1ZXBtI4CvxIqVRYJheO4e6a8jV3gOHRsg4KSNsSAReVREUG9yYWjIn7vmsposo/U3ZQ==
X-Received: by 2002:a17:902:c94b:b0:1e0:999f:c9bf with SMTP id
 i11-20020a170902c94b00b001e0999fc9bfmr949797pla.47.1712308129439; 
 Fri, 05 Apr 2024 02:08:49 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.62]) by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001e2c0b77b53sm1055959plk.255.2024.04.05.02.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:08:49 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 5/6] pinctrl: qcom: apq8016: Add GPIO pinctrl function
Date: Fri,  5 Apr 2024 14:37:41 +0530
Message-Id: <20240405090742.4148304-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405090742.4148304-1-sumit.garg@linaro.org>
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
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

Add GPIO pinctrl function to enable driving GPIO pins as output low or
high.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 1ee8b7db1a2..b14a8921af4 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"gpio", 0},
 	{"blsp_uart1", 2},
 	{"blsp_uart2", 2},
 };
-- 
2.34.1

