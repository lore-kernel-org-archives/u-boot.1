Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B63CED61E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB6A88F4B;
	Wed,  9 Oct 2024 10:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pQsA7gjl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1026788EBA; Wed,  9 Oct 2024 10:02:05 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C2E88F4B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so67166775e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728460921; x=1729065721; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jrizSI+ELeBvfxtAi3OSK9ynlbK/KOEjGCmCUv3PK3I=;
 b=pQsA7gjlWseAFs16bTlNOh31h4dRapbKvuSVsiE/ifgQjmlISsEqUNnK2748dCRFzn
 y5M3roYSWn9JtRbAGll/wCeZ4vkmVCzkge+whvIiw63yxgssDe0vN3h+AZAddbEQmWhJ
 sETLSI2n2JjQJL8btcvAugA4DnGiskQmwI9x+lJsEXU1g+wW9eA44/tzWnHv6sZVuqBa
 UliovpvIPrUaG2we+Ga+6wFnrI+JcVgT31VJK6W1it8vZHuKV+BUxW6wpGSuPcC3z/n5
 bcE9fPpdw+FhN+jW/UUb3bhgL7j6+wQFRoSiH08f4NUrwRALB+z261zFL8jL9mfTClJj
 8dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728460921; x=1729065721;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jrizSI+ELeBvfxtAi3OSK9ynlbK/KOEjGCmCUv3PK3I=;
 b=T1Cnr1a6Mxj8qKywZianqgJfC2QcoTxd8pnqgykQ9zFELbdheoSeOH3t0qxneS1LoP
 sC2WhT/SSdeoAaZ8tTOLIQ8ZAPSQJFyPnl3eHgp2rwu52cqsn0AiJkoPzxbRBC0v62Fd
 poZjeo+3Su++zPWw+ykD4TWcmE/xL1tZUtrl4NAdwe0uVy0GRUG8HX5ZHdG6IqKmoZit
 y/obLa3nFTV2AccEaZLp5xmsfzy//ZS79eNU/8hV2uUO6CPgAvGtnAJMVEYofDbzMsMA
 /UxKJfKKo4c4gPd6UV6CPR94BX8gCMSZMcttXmKM5DNOPtjfCq9zFrqjCQ9MKChkGkK7
 XuEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUh999UAXcW7iY1+Pk6evlB2l+asJSihS7J5wER457YpHqci+76HhbBr9xfl0EctarIPh+kN0=@lists.denx.de
X-Gm-Message-State: AOJu0YxiWogY1wGLedZZiXInJbixrrPvb2OWnhlnsgEQtZUntvBNjTbn
 SicQKd+44PA7h7erCrO3+37iwibai57Ctuh/Rb/llYdx6kWoLYc+RRF/KFdmMGc=
X-Google-Smtp-Source: AGHT+IHdnmDhIU6ot3F1UXcCd6yjW9/mg/OHawQyiH93sQCv18qy+1FhURQwC20XlXw9u4AH2lXgzQ==
X-Received: by 2002:a05:600c:1c8b:b0:42c:bbd5:af60 with SMTP id
 5b1f17b1804b1-430d6faca75mr12231315e9.24.1728460921392; 
 Wed, 09 Oct 2024 01:02:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5f462sm11991225e9.23.2024.10.09.01.02.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 01:02:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Oct 2024 10:01:56 +0200
Subject: [PATCH v2] video: meson: dw-hdmi: do not fail probe if HDMI
 regulator is already enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-u-boot-video-fix-hdmi-supply-already-on-v2-1-4478a28d1f49@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHM4BmcC/5WNQQ6CMBBFr0K6dgwtRtSV9zAsCp3CJNghU2gkh
 LtbuYHL9/Pz3qYiCmFUj2JTgokicchgToXqBht6BHKZlSnNRZflDRZomWdI5JDB0wcG9yaIyzS
 NK9hR0LoVOABe7d16U7caW5Vtk2B+H6VXk3mgOLOsRzjp3/p/I2nQUFlturryvvL6OVKwwmeWX
 jX7vn8Bo0/PCd8AAAA=
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IXHFvbVWLsi7Byr7b1kFIvrgdwygIPJYK6vOYIuphXw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBjh3tpt0WZKKGqSIqO8c/FqgwbIOAavBcdSbAKta
 Ya0tX42JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwY4dwAKCRB33NvayMhJ0QEbD/
 9Kq498cpAgZcrhgjI04kb+9LuN3zIYsBgFef8n+JwVwf6I8T/jRvY8SaquuDM0MA3cG3UjMhcgoL1i
 INeONlv7kWgTUODyMQkcw56mcxBxfjySAipedhERFvGERPYqnUCvmkwQ4dL6JmtZxw022WBnLz2m2Q
 mhOjq9O06WzlmvDeAs+I7iss9zYXxy+AmQA3GT6w3VeR1/A9qVoinM3jd0TKNnJgc+ezzurwoU2a1v
 UOgCLIszTVGY1ostCza+mhyCXysKUEp3Pq340T0RQOceFQDY+Zf/UTldX1FNdI0WntAuc9KJ+TmjtD
 JBFbRvjTXuOvEIPY5QaPA11TC2UZCHsP7mzpnQRWzT4EBmuh7oWwdA2FMeA1PORn8yFuJSCX8Z0DjT
 D5AeVZUzAzvVgWIEgjDUR3Yux9kH6Lbf4Xh4JY/mbQfJV5AioINmyL/rMVkhjZp6bNx90G+b1aGP40
 ZElzkcfrPLYsnLgySaKAQCMP5Y8yUQucuYhIP7u8fxxkE/nZLkMXbHhiJ5BHWyVp2O5osxNVx+WX5y
 /JHGAfaqN4mdRtzn9ZBk2LGnTBIXgkD55b71Qt1tK/yVEEEFMMeL/IjxW9UodTzX0KxTO0PzqGkwrG
 J5kTFWYMH9pfhTULXcp0WL6hVuViOVm6kKkf+Ceghue/aKoNardOQg7UjBHA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

If the regulator is already enabled, this happens if the regulator
is set in regulator-always-on, regulator_set_enable() return -EALREADY.

Ignore the -EALREADY return since it's not an error.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Switch to regulator_set_enable_if_allowed thanks to Jonas's suggestion
- Link to v1: https://lore.kernel.org/r/20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org
---
 drivers/video/meson/meson_dw_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 587df7beb9b..1631dc38416 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -418,8 +418,8 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 	}
 
 	if (!ret) {
-		ret = regulator_set_enable(supply, true);
-		if (ret)
+		ret = regulator_set_enable_if_allowed(supply, true);
+		if (ret && ret != -ENOSYS)
 			return ret;
 	}
 #endif

---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241008-u-boot-video-fix-hdmi-supply-already-on-e6a9af27b1eb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

