Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8653C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B726E87B30;
	Sat,  3 Feb 2024 17:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xb9LNjXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352BF879D7; Sat,  3 Feb 2024 17:38:21 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078AD87C13
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6818aa07d81so19346126d6.0
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978296; x=1707583096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsFoFiFJFdTM63u/auxH+O3T6fcEUW7OB0tALJkqxAw=;
 b=xb9LNjXUF008Gv86LrkO/4yvbVHIJGBtASuuQRjS0Sr7ZLIlCoU8cWcNWn4m8rM8Tr
 /4Vr94lqLsbqf+aO5gR/U1oDROBivC8M/HVlW7tSw9jllON+lm4EZyRr9Xgz9jH2Mh3E
 l5m1TImUFosEyAk8K/vTy/hAvxMzX9DilNYrAv/+f/FNd8ticDHe7ylxnoQsNTdu67vL
 oAibdNbCizN8ZSdHUKSd5Fl9/pcyEuY2ovvCfC7JjjzDstj+01fRGjTM23+/sTZjzbCL
 M0ggJOUBoTwK0uUuTgYXAw5oQSHoqkSAj2n1f4GQncybpt4OMYEATMUzsT1SdJzVht9T
 40VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978296; x=1707583096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsFoFiFJFdTM63u/auxH+O3T6fcEUW7OB0tALJkqxAw=;
 b=nSmYc85uo8Qvz4Y3SBVdhTvNdEWEX2/NdZoXuUISQgVjqi5V0Rbsbj3QTUGUMd5taA
 XzU7Z8eKd10Agy8pWVbq27AlTysQXk+mmYvUxhuiPzwsmtBRqC5Tm2uudo/TqUN1ioRU
 nynr+ikYH9VHL1tjYp6dlxufwOH7hZIbOaFaWXqG47YGARsQLeEyqx0r30f1AjtxNFfZ
 l9Wzz/IhYCU32/xoFiVabydI0O25vqdXe/C42CFryUUtev3SzZl3s3dz0uChOPi80h7q
 5oYeKPeoKqSf9kL+Z9WnjdzJwzs+IXnVznqM7CbMCHwjUWkcuEn4hNYvN8CIBjCHaH8R
 NfcQ==
X-Gm-Message-State: AOJu0Ywa6R4C21xeECA7S0BODBpKapgb3L6thuSu3ir2UU1aHOn+tyJh
 Zcg5DkSZ18mfnrtsxXvJuYKXNWZUBDcgNhPjyLm6Smautn18cIEulCu8sLubxTjWUAYw1srRzWM
 c
X-Google-Smtp-Source: AGHT+IHB8+Orp5xG4AUUx5uVBhkdQxDpUuHzd67LicBQqhiYbTwtb7seIVVkGb35FzCourVDWmAYmw==
X-Received: by 2002:a05:6214:19e7:b0:681:781f:6781 with SMTP id
 q7-20020a05621419e700b00681781f6781mr2791586qvc.1.1706978296492; 
 Sat, 03 Feb 2024 08:38:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWIPGt6JDFG754UGZ3ff0Z47bq6P1zM6gQew8MQ7yvqJVYW8wzwkoHU168b6nuTycUEZPLFYLiMo2q7FJToYsHuVrS0xTmxdY3DcjJNbaWnFF2yx5mokHK7IVEmWA6LSm2w7IKWayAwaTJ4fsHASGfa2/dqJr5gMqM17nZm7sEcgo2Ej3QMGVdTluLqxEY6aojdn4X5sZtXgeoqq77dN6MSkmemuE+mAAhymd8RA1rWun0jfRSFTCzdUXkxRBifg6OAJGBM67b6XU6dPTdJbCPt8eiI5mhD4QE/+y3RB/YhevFVXFfCSixykX20x4S7/7h/UKs3XKk9Nqlc11SLqtviWmkHmu21tx7KLn9PzlWDpmgRlSdsI7aJf6zR/bnI3erDY0FNWA0u6Js3BP+TWcqx3rdvFZsH7J4/2Do7eInqYOGMuY4GttSIp8nefCD6LJrdilb6Pw==
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:38:16 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v8 8/8] dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
Date: Sat,  3 Feb 2024 08:36:27 -0800
Message-Id: <20240203163631.177508-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
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

When BLOBLIST is enabled, FDT is expected to be from bloblist
carried from previous stage, instead of from OF_BOARD, therefore
only enable OF_HAS_PRIOR_STAGE when BLOBLIST is disabled.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in V7
- Initial patch .

 dts/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index 00c0aeff89..def0e17241 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -121,6 +121,7 @@ config OF_BOARD
 
 config OF_HAS_PRIOR_STAGE
 	bool
+	depends on !BLOBLIST
 	help
 	  Indicates that a prior stage of the firmware (before U-Boot proper)
 	  makes use of device tree and this board normally boots with that prior
-- 
2.25.1

