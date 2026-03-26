Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B6910A3D80
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 12:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC47183E76;
	Thu, 26 Mar 2026 13:08:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hd/w4YN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA8283FA3; Thu, 26 Mar 2026 13:08:26 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06BB483E76
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 13:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso18448455e9.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774526903; x=1775131703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gVQKnJrqFmndyfPGajYI2v1TJJhYYnjqTw5bKsVt/5U=;
 b=Hd/w4YN2Vp2msJU+OBPHath5EsRtujpf1VUrmkay635nM3eCks9VVo1sqKZiI4LGSO
 I8M5ev+fPaDtBfZOSWggxDDBQtq617HVt9J/3F1RLj1wc1kJwlzBl01OUoNgyRecCAXR
 xqFgMEK9U3GPrCE4pXRmlCRz0IQzUi1XP3H4B84TyN4CKKUjKNcANiqYAbaxhUDW2/SF
 yeQ1OjBsjL0xCn2+K78z2RhZaooPq95Pus3qfBLhzwOj7Dy/XmDXg2HYio1UKMrEl6xr
 OHwlxXxaBR7u/sVJIRFNaKBoO1Ksycrw/A2IzXD6LyQirYHhhn40k7skjyZLHzv+J0bF
 1OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774526903; x=1775131703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVQKnJrqFmndyfPGajYI2v1TJJhYYnjqTw5bKsVt/5U=;
 b=j/EC7md47jCXUYVsFW3V3wWQImuA/eDtyC1VQZbVZMZAUQiVp97htW4AjkcxRz+o2M
 1XlFOYFt+0VX07GlKAQlzSMOnNV6h1wes7qL1fIU6N1+paE3Zd+ZOKTvF6ktkHAg150W
 t7IKhHhK/aiwmE33Hgheajv+ZiFbspHnb1KuIlT5TKHKrYHVG008fsUGr5X2uAV5pE93
 6n9LCRjv3ijckd2OgP6SENigk0tOmpXV/oHHMySoQZUU7mq4KHNWHd4gWqqfiRj4YLFw
 g+GdKx5kDCgeUIGqjgi7P1Nr3+WTlnB5ToLJASd5p3M/k8jG/SnfXJtwOuuHnZk+qpl+
 OAWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJCgQRVxDIM+/b5kVzHuFzXYFVjV7Vb3H1HYPIQ5TmiFjluicXqueYtZjqo1elZzFY6mh/6M=@lists.denx.de
X-Gm-Message-State: AOJu0YyDM/G8i23+2Wo79saKg9DkFWj8ocBJ0sFKw1gIKSRUpE93bKCA
 0IOHfGRRusmMW/MDShgYbGXZxaf0YXoDhYZBUuxEkPYXynH581idNVnjX/CHW1EqEZs=
X-Gm-Gg: ATEYQzwAzHwqHQmfVKf228A+VydxOPvzu211Jmt8mEF1+TNkyam1rXwVbCLTmAxvhDx
 c9oObjtGPiXY7uSZDB04JGNPwXe7hr5sd7xVephhNLIgp52vRtk9uyEjv7c391l0+G+VQh5z+CX
 AEzriYZc3+7F+m734Ig0//yll5y7FE78FjpZzwCsJCOYfHRC7iQdknJUUu7mY8EWSbERqeWuNnj
 IUnBDcr87iC5N/VC0RmFt2eylbVRs71GmHfSMIiY+4J7SOPCpeEctP6j2ObOYxr1a48O4W+TgoX
 qgOgzjfMwegO84kZtd5sRhaZ22L4giwK/Dla12sQh03ET3bDX8qh088MDYEeRpx/E4cYQeBFkdd
 chRauY4GajH0B4BQBGsm+PRj/mfoKjUq5KNacUNEnjXYbafaveCzKf1zIogkZhNPv72ltnS2OsF
 cxuEdurhbwR95PegdOXu54I4J4CIAG
X-Received: by 2002:a05:600c:4e4f:b0:485:50ac:b8cf with SMTP id
 5b1f17b1804b1-48722ad3f0fmr22947665e9.0.1774526903352; 
 Thu, 26 Mar 2026 05:08:23 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48720925591sm13483345e9.25.2026.03.26.05.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 05:08:22 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:08:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vincent Guittot <vincent.guittot@linaro.org>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>
Subject: [PATCH 1/2] firmware: scmi: Fix setting the function
Message-ID: <401560217b674c299cb0f344e6f24c271fa7583a.1774526652.git.dan.carpenter@linaro.org>
References: <cover.1774526652.git.dan.carpenter@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1774526652.git.dan.carpenter@linaro.org>
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

Set BIT(10) when the function needs to be set, otherwise the setting is
ignored.

Fixes: 1048331f5d3c ("scmi: pinctrl: add pinctrl driver for SCMI")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/scmi/pinctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/scmi/pinctrl.c b/drivers/firmware/scmi/pinctrl.c
index 47f7a8ad9b81..e670538c87f9 100644
--- a/drivers/firmware/scmi/pinctrl.c
+++ b/drivers/firmware/scmi/pinctrl.c
@@ -259,6 +259,8 @@ static int scmi_pinctrl_settings_configure_helper(struct udevice *dev,
 	in->attr = 0;
 	in->attr |= FIELD_PREP(GENMASK(9, 2), num_configs);
 	in->attr |= FIELD_PREP(GENMASK(1, 0), select_type);
+	if (function_id != SCMI_PINCTRL_FUNCTION_NONE)
+		in->attr |= BIT(10);
 	memcpy(in->configs, configs, num_configs * sizeof(u32) * 2);
 
 	ret = devm_scmi_process_msg(dev, &msg);
-- 
2.53.0

