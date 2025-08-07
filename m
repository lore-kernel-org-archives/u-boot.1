Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9C0C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 10:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8CEF843E2;
	Thu,  7 Aug 2025 12:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FZ3DpqK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 938AC844D3; Thu,  7 Aug 2025 12:04:17 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 605C5843E2
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459e1338565so7598855e9.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754561049; x=1755165849; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NWmcgE1aBA51xD637InwQt/TNC6PnCEa7tdsryQhb90=;
 b=FZ3DpqK3Dm1a/DvDVzrPPKC74B42tN8yD8x6Ns1xtEUJyEaYYpSf/Onvu+iZUhX2rR
 4/nroDV7bi/eV01cpjZ+VvrShywd/dBStG5JhLCNirngWhEuVfzHfjwoPzsStD6f6i+E
 dOdUqLaiS0cy7I2MAb/JJDeivl3f/sYYoZ/lpgeEN2ikbBFXQiu5ZxKHdVPQgkYclAOA
 /FwsWXyIV4kH0xuNnYLqU59bLzzX3u62pmpkT1AffQl3lnyeMkt07a5l2cJHGwvvlb2b
 wn0HEGxLQVq+c4cUZ7/gDcNCIYFke0MiqD8byURMjZxLGZ2lOdUrMH7VXTz65WCYca6U
 d4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754561049; x=1755165849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWmcgE1aBA51xD637InwQt/TNC6PnCEa7tdsryQhb90=;
 b=rPAzn2Iwg58O89gAeqs6Z7+OBkq008nZyOyEI74/7lVOZp5/0CVfEHpxs3lv8/pF/o
 4HTsRKsvex3L+wc+3IOSRb0Mjo8RsUXZgucNWdgFyBJ3FAiO/hWGvwjwloM+9Mfqn/xA
 y13T3N9+ouU2wOfomwPfnNYG65E9m444hFOOGrrXvAmrRfsxVXQbsV5J3ZnTgAglvwip
 tsjUXduIBT2F1Q5KSJ6vVR3WG6szChQ8yPdVpQIUWqS5T8E+NS/Fjdp4Vmn5igVoM+1m
 Xn+qJPKZEHvgjFNwXHdmYVqSf3uiAfVpRtCxROx4deymjRacbGnQYnD72Ce3ljrC94my
 aSXA==
X-Gm-Message-State: AOJu0Ywt33J0NwTtiDDnkzdOfvNm4UvNAnDsdQKLdsxVVg2D9IkBsfL3
 kmJrBrVgW7vwAtny+S4IGcoDpMa75U7qR7StGwZtRqjbnVxgjJFdasbRcIlopGnCvpZ/Ll7wSp8
 Qn4e5dgQ=
X-Gm-Gg: ASbGncuzKj7Nm0YrnBjeHN4bMBDDWEbP06koXx+YpBnN2uNZj1O506yoyFYaVB1WKfw
 YHNT4IkOVbMtdgIy0KoO8WEJztt4pEJWt7EIwZbwxUfM0SSD9BFsAx7bXGHsyDIa/Q38EUQy3Qj
 IWM98fQstDN2aM9Xf7O3/FTDGg5qmQaS0s8d032Q9O2mLex79RJLnAVFO70IBCWYOKAzfwvxZTD
 hMG6r5blgtgS8cMWLiUmdmK6YhekZDPDD//Y+UI0aME2FVfQeYzV10/fKbTtMm6QEt3Qg5gBFL0
 nr0MNSGMpzwTDqip9Pw4liBudyLj+WkAc7v21hf5vlARSDugAWcvzp5jkaQWOiLUxlT7UJVRIfv
 aH5k1A5P1ZeE5CfM6fiaqtAnWCHF/RDagOfxhLvbQnb4VKc+RTYU=
X-Google-Smtp-Source: AGHT+IHI614TRbGBYy+TwQEwQrP0yM0OIFYIfT1xbyW3DGNjHAnLriRO+ufs5t3DK8/eQLnM1jn/CQ==
X-Received: by 2002:a5d:5d85:0:b0:3b7:76e8:b9f7 with SMTP id
 ffacd0b85a97d-3b8f48de5demr4783729f8f.10.1754561048694; 
 Thu, 07 Aug 2025 03:04:08 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm358481575e9.25.2025.08.07.03.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 03:04:08 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 11:04:04 +0100
Subject: [PATCH 3/4] pinctrl: zynqmp: Ensure ret is initialised
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pinctrl_misc-v1-3-eeb564a1b032@linaro.org>
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

In zynqmp_pinctrl_prepare_func_groups if called with func->ngroups == 0
then ret will not be assigned to before its value is returned on exit.
Initialise ret to ensure it is always valid.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 6fa203a3b86..27dadbff8ca 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -204,7 +204,7 @@ static int zynqmp_pinctrl_prepare_func_groups(u32 fid,
 	const char **fgroups;
 	char name[MAX_GROUP_NAME_LEN];
 	u16 resp[NUM_GROUPS_PER_RESP] = {0};
-	int ret, index, i;
+	int ret = 0, index, i;
 
 	fgroups = kcalloc(func->ngroups, sizeof(*fgroups), GFP_KERNEL);
 	if (!fgroups)

-- 
2.39.5

