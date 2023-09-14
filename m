Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A62EEAA56
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7AF186A7B;
	Thu, 14 Sep 2023 18:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OtIMCkmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C73686A3C; Thu, 14 Sep 2023 18:20:41 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E2A86918
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bfbd7d49e7so18452301fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708438; x=1695313238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iqjo/S2dlM9bmalrr162ON2R3PCrWmnEZHSq09Dn8Zw=;
 b=OtIMCkmwQRto17VAqLzQvOkYwr0pVKZDZbmF90bFQjzGT7I5OhcwdKkjYASESFFKHU
 XeP9tiDuuCAJbngWXjX9ye589ilBDDkJO/7Msc/i0QucvYbXX8m2LFr/JREKYB8sJ0XN
 VwUEH/yYZ0YO2jr+e2B7bsTZg2c8U3l8lf1nCqof6/s1BtiFyEvhtcscZ96Ya9vD8Oir
 yTGfa54qeFRMS6YNLxS1qIlEYq0G96DDDNBuUNGLbYFKTe5/5d2Bj2+ay3nT4/CH9voj
 YgD+2J+QDGPX723M0RDVE+qbo11y6mk915tfeHjv3Dc6OOOyWn93mA/yDjnZr1+vF7ks
 mwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708438; x=1695313238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iqjo/S2dlM9bmalrr162ON2R3PCrWmnEZHSq09Dn8Zw=;
 b=AILWgGaxUdKjcaWNgsJDauhT58YNLwBZJcKwaS/1dRujeYyVU/sq9aWg1oRUrsKUuK
 84HRbal0q1lfF6wy0AgGUDw/riY8AGRrU5fSwlpzrdNMImLERiH1NtFDXaOt64X2XvAa
 dP021rSzXqfgtz75gxrfLKGcCq6JDrOSguAwOFCzYwFB3HVt5CgKWwtoTlgrHsl6PXrh
 Q+71GS6h25pf3FVp/lrf/kXTuSqFiTsyB+kj9g5zJKMSfU/gG9mYDyHAGdXNt52kSO2A
 1kF6o5Mw8eeYBqFGsCTVJ4+N/M7QkhBFsJV24sseYKHj1TVxTwEZgYllKrsf/Ygzpwuu
 oqoA==
X-Gm-Message-State: AOJu0Ywj5VMO/M9y1BGBR7sUiKmbwMdFob8F3lzEoFjmAM6lvzGLLRtL
 PNqtV9Uh04xZVqOHqS1lTEFT5nQbo4cHvO3WjnDwWw==
X-Google-Smtp-Source: AGHT+IEz740p8q/N0Sy5NHx49YQCr1bgkS2UnERt6UDk+WHWMlrcv2/JSs4OgiZoBqyhDy6PLjrDIg==
X-Received: by 2002:a2e:93c5:0:b0:2b6:d89e:74e2 with SMTP id
 p5-20020a2e93c5000000b002b6d89e74e2mr5071779ljh.7.1694708438105; 
 Thu, 14 Sep 2023 09:20:38 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:37 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 01/15] submodule: add lwIP as git submodule
Date: Thu, 14 Sep 2023 22:18:14 +0600
Message-Id: <20230914161828.3662-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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

add external lwIP library as a git submodule.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 .gitmodules            | 3 +++
 net/lwip/lwip-external | 1 +
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 net/lwip/lwip-external

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..245ecff585
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,3 @@
+[submodule "lwip"]
+	path = net/lwip/lwip-external
+	url = https://git.savannah.nongnu.org/git/lwip.git
diff --git a/net/lwip/lwip-external b/net/lwip/lwip-external
new file mode 160000
index 0000000000..84fde1ebbf
--- /dev/null
+++ b/net/lwip/lwip-external
@@ -0,0 +1 @@
+Subproject commit 84fde1ebbfe35b3125fc2d89b8a456cbacf148e9
-- 
2.30.2

