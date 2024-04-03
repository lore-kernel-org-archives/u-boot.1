Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE6FCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C52EF883CA;
	Wed,  3 Apr 2024 14:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RzJvP38o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8FDE883C5; Wed,  3 Apr 2024 14:08:05 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E89883A3
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a467d8efe78so783724166b.3
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146082; x=1712750882; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CEa1uvzHHZiFQ7KW80s5FU7jkCJCbFju98xTsCLC/qw=;
 b=RzJvP38opPIdGya2mtqh3yh4LEGZse+ifnd+NENAlsbKqOLmI9oe5n8pWt8ghCq+dT
 02KlDtkEyJC414d0tliybd7qxVzmw0liz0HexK0Dyw7JbVEb1ZrZovia+kT1+LsQcVQZ
 kuvy7L1+O0zkyA9pHhajSETDFouMrqB4booZRwGlBc1r17v2eEURj6oCJ4REWQMwykYY
 e55IP8y9p+j0K2b4kSuxCVu+FA8tL+qsvpw+cjFNHhzB9mYgw6n+4c5av5QIemZ03jLD
 6u0eJ2mcBTDmTSBsw8TUV9uUQL3dMB2VgT2pEhP/GqoCKLUg7milA79jDemV80RLFjoa
 +YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146082; x=1712750882;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEa1uvzHHZiFQ7KW80s5FU7jkCJCbFju98xTsCLC/qw=;
 b=qliGGSDsgHqF/07bqlYZLeOwPVIgq8/67KLdtc4fA/4bMzvksI6pgLpZIvrRn41pR6
 VowbZu7AMxnOsH1X/4SRDZxFkVB83JU2KUMLJp3hiN3nbzaND+Mjbk2Vkj6/9s3vpK2t
 9o9hsxkEu45LIwmTXG6HP68/ey3SBoOijMtmSBrtVwaGjmhUOLnW+o+/AFwF8dEHo/wy
 2fYuFQ0tpN/oMklwpmhiXRxNCXmjB3meQXetXOZxmtLnT6KXYQXl/BrwekHvDLp26fBd
 8TVqSdezsZEHBWdQbdEswwjYKa779tszZusY1Okae7KowEgiAI7dqb66HetepnZUzVU1
 zhSw==
X-Gm-Message-State: AOJu0Yy2DFjvrnDSLXMEWJa5ll5DVhe4oVrZP6Vj+qDcNoGWYRpNZy4N
 N3iKO4mO1BWWQ0GgJBV23fQbE3MUmQIaGkSpUNXUZKjjxfytKV/JxYpJZHM3ff0=
X-Google-Smtp-Source: AGHT+IHlTT2kyheE5l/03l/vtOIAmIcIV/rmxdR+74dcrnh3g/7IrbFNurQ5oPc4ZkvnhStzfd3Xjg==
X-Received: by 2002:a17:906:16c4:b0:a4e:22a6:17c0 with SMTP id
 t4-20020a17090616c400b00a4e22a617c0mr10952894ejd.53.1712146081900; 
 Wed, 03 Apr 2024 05:08:01 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:08:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:47 +0200
Subject: [PATCH v6 12/16] mach-snapdragon: call regulators_enable_boot_on()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-12-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dRy9leI1WDAXwtHW2U3ZWullcNHhVVqJ6wANm74o24s=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaRT6gwNE9TIZsxlDpzZdOMhwcl1VvaTLGHz
 9IQiwT0U1GJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 tjVsD/90ZXPSFb7gqqq0TidjFs87orWP+jL+D/sxXi2KZJNh7GzWB6j1lkFG55C3wxW+RkyaY9a
 LTJqMP1XJYHSViqqbmQE6RaJT+fTXKDxchRTsAbzBdZ6G+ubSNeJIX/6o8EfwYz+E0QTcqMfpdT
 iPkUgJg+2MKdbib+S23wYkH96Nx1KyLIGwEwnzwfZnGdYOGqaqZhDXohKgoExBKiTn0e2Uf/a3r
 4lGwgxiouHFrOdmJkBax+Ll6c5jQhBqyjenZMUf9LYgJU0Yhc3xFKzyddJxT4lW+pUKet8M9b8c
 BCPiIX6uOzh3lbWREFYO3avQVdmcg4A9iX2hNFe5ZOnIwc6eCdnvH4lXeK1Q0OoD6IRoTBcYqGZ
 dCEjRumfTEtT6FY3ALgDdXtcGqv4pJchO0S75L/YQux+d3OJY20IzKo2TMjdHdgVk4YRb6SYXtU
 jHZ+ahXYCUW/0SHWH0IAuO4w/ZDPI9Odt3OBQu/pkr8wm2PDLwKHlN2YPARz/Mkqo/TPbyOb2p3
 oYzHbTKQWb/eKeIVQp12Eih67Oi7iXp8bbnapi7S6g9w00L6SnbxIkGNUHW076KkOyrKuX24/CZ
 p7gPCwUTLiEhg6sMs8D/T5YRHykACqInLFA76Nhx5WATRvBzGZGT7RrjuHpit/CwiJLqQU4rmQ2
 H4sGleZbrzcAexA==
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

Make sure we power on any boot-on or always-on regulators. These are
used for peripherals like USB on some platforms.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 65e4c61e866a..3d5994c87886 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -15,8 +15,9 @@
 #include <dm/device.h>
 #include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
 #include <dm/read.h>
+#include <power/regulator.h>
 #include <env.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
@@ -160,8 +161,9 @@ void __weak qcom_board_init(void)
 }
 
 int board_init(void)
 {
+	regulators_enable_boot_on(false);
 	show_psci_version();
 	qcom_of_fixup_nodes();
 	qcom_board_init();
 	return 0;

-- 
2.44.0

