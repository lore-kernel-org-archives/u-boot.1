Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430B7C87FDA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 10:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A490844DE;
	Thu,  7 Aug 2025 12:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DpXymXhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFFD883A26; Thu,  7 Aug 2025 12:04:21 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A8E843E3
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so437402f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754561049; x=1755165849; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZOGMX37/3+cIXMQNcUF+yNX4VyOJQeQmLKWoRlFI+jA=;
 b=DpXymXhCxn0mphNXzaQ3kR7Qn9OvRgF877RFd/2WHhrWM/qvMYyktMRo2P46hb3br0
 +NmagtHUenGN67puTkDjxBC96u8WyqfKeaCzHk5D72uYezvCF+tqp8Ln5xC1FH0H7fny
 H+516y/jVcdJVa+wZPliSLNnRW2DD9Db+CZ3TR1qrIrLH1RqTnqGAZ+YifWmsw2x7s6/
 LexlFp9NgzPCr5IJz3NKV8JJ3VkzLS16QbrJ21nWd8Eo4LI7Rw5dXYwIhzY78Z2gGETm
 bBqzex+cfjGyNwl8MfL0/LMaY9ODv9J4IF8JLY7kGwhYgODvSKG4nYVoAEIFbrygCij4
 jWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754561049; x=1755165849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOGMX37/3+cIXMQNcUF+yNX4VyOJQeQmLKWoRlFI+jA=;
 b=WYk6pf49D3X25rYWWpPv0AjvWKPsMQh4mT0Wb0tEWwynhc75N1O6ZphH/Ur7daaCAI
 8UVKbwnGFX7POD5iCEBXlRFk53JxyyxkjwwKINnRuO+bap8sLgeYKkfpFSpqvYsp6UET
 HzEAk+94q7+xpAxHsT/Rj5G1rYqct8YeMyYPhCgr3hSVPoVNTcgElaNx587JPIovRglN
 BlS2WAHTDvY3U0JlVtx0bT5ckCgjMKas1DHDZBlc6Se0k8VLshAw/GHn76Er4TzsNDnl
 m7KiecENiEHP3F1l4UNzjOP16C3edih+1V73sB8u8SN02hD0zV254K8qAUY/Z9oICs7J
 Urkg==
X-Gm-Message-State: AOJu0YyoamKFJLQesmxzEJ/xNTy6eXnHEWv1Y01xWdwetGbUPVyiOHe/
 0ewUElVJwClA6ZqYVjhXI7dD/KD5aNfJWdn0u2A+oIIYCfa3mo+9mTzhkMYdRIcRc23+FWslGpK
 /D6pJT6I=
X-Gm-Gg: ASbGncsGmK8s2OlBVmiLrwfB8WuwRpyzzsHzq8ophSVGHOnDnmyaTg+eJ2H75raNyx+
 ggIToH2gKJjB7cPgMvrsACAsyZT4qRASeCh6tohbfzsV5SId+p49fCGRv1i/BOk4U/9k7RcoQ2K
 GCPQAVgC2pk2kR/w9ajfn7RwmY/Vt1+JXn74nAmLhIj/C+hm+5mmNQsfL0QzKojjTgJcdc0qBSk
 8pEhxNcltgMdho6QI/Co5OnTR2I3G9RLnyYNIUqR4RfpW/fb80XceRnZm1USvtFv/btgsMYXLj4
 pTNv1hgw7mLHPw+fkEh7iJzMxyHo+SwOZ0YPCOs3SHQs62JPOgi8qNZUOeL4oDCRbvXzAvs56vw
 F8DJTKJXSmSWG8dNGbALzwy+TgMtTBGoU3WrXoDGGZOKqjUJDxgw=
X-Google-Smtp-Source: AGHT+IG3jRXg+SP673penIjizLmPcQdg6VoyPg8eiaAeGSAmpYeopvOy5fzTqnAYUsRMAAESiUTDDA==
X-Received: by 2002:a5d:5d8a:0:b0:3a4:f70e:abda with SMTP id
 ffacd0b85a97d-3b8f9f20ff9mr1771361f8f.10.1754561049489; 
 Thu, 07 Aug 2025 03:04:09 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm358481575e9.25.2025.08.07.03.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 03:04:09 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 11:04:05 +0100
Subject: [PATCH 4/4] pinctrl: zynqmp: Avoid using uninitialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_misc-v1-4-eeb564a1b032@linaro.org>
References: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
In-Reply-To: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In zynqmp_pinconf_set if param is PIN_CFG_IOSTANDARD or
PIN_CONFIG_POWER_SOURCE and zynqmp_pm_pinctrl_get_config returns an
error then value will not be assigned to when its value is tested to be
not equal to arg. Add code to only test value not equal to arg if ret is
false.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 27dadbff8ca..665b76a7d4d 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -460,14 +460,14 @@ static int zynqmp_pinconf_set(struct udevice *dev, unsigned int pin,
 	case PIN_CFG_IOSTANDARD:
 		param = PM_PINCTRL_CONFIG_VOLTAGE_STATUS;
 		ret = zynqmp_pm_pinctrl_get_config(pin, param, &value);
-		if (arg != value)
+		if (!ret && arg != value)
 			dev_warn(dev, "Invalid IO Standard requested for pin %d\n",
 				 pin);
 		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		param = PM_PINCTRL_CONFIG_VOLTAGE_STATUS;
 		ret = zynqmp_pm_pinctrl_get_config(pin, param, &value);
-		if (arg != value)
+		if (!ret && arg != value)
 			dev_warn(dev, "Invalid IO Standard requested for pin %d\n",
 				 pin);
 		break;

-- 
2.39.5

