Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41374CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 11:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8752D81D6A;
	Wed,  1 Oct 2025 13:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q/iV0g9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A00834D4; Wed,  1 Oct 2025 13:55:40 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1E52800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 13:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso833920f8f.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 04:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759319737; x=1759924537; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G/HUjGUo0aKYoELgZUt7ZjvTCq4Ih2WIvDuv4ZSp38M=;
 b=q/iV0g9xrSNPV+ob4dXfTNhvNUjemjshoMzG5t9wCWm1GFw91AjKmSTerufj1fjH1b
 wzFYAc9RLa3LxSH5y7g2YbONoEeARtJXOGhkrI+8w2vi8VUkZpSIzu6B08hzjpGiThIt
 ik2sKDI2WH0y9B47Pnt70Amigw5rafEd8rS4VkoG5LW0stcCyYxxM/GiYarBsmE5VWqd
 Dc8ryxTTa4XfcB8nrK0chg4dLfFhi3/KcPn2m0wy2JY3aa5uSyIIUntFiXC9VW9lLyys
 7Ajs96HfI/izGqVwxwtQWYAbMVJqrr0do+yxPY/aaG+LLP0lwdNWDZGatXzaT7leU9Ks
 FhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759319737; x=1759924537;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/HUjGUo0aKYoELgZUt7ZjvTCq4Ih2WIvDuv4ZSp38M=;
 b=HDQYS9L5y6qGhmgI4b/y9zvO8aGdC+1WvIqjF2/j1rnKaGLklsov3rsTOn9cYLvnRC
 BuIX5WQIWC72NrxhIVCNUWrLu7d1g90E6RJn4Sqh+KrO7SvD6SX5SkBfxZ++lxP9JeRP
 ouiZSWHYNlaC1DYLqBrRJdNJ/xMFMNZpTaFnUpsEKjbL1S39aWwPWPQ8dOBq3RBkmdkA
 0YJHnWGqivbAEu3z6q6NIgdR2KzIDggCN/HN9VLxYWTOpLEUP9vWmXVWVe+1xoQ+qTX9
 hw75W0E1HRNj35JtF4aEbLVbBj9VLC0A32tDdMuwUXMF2fFqnsBfwd7EEoQYhT01FKG6
 7f8g==
X-Gm-Message-State: AOJu0Yw9TXFWhKtGlwePFirvOqi/Lj7E+wdVsjpic0xa6eBu0klGn+aK
 8KIzE9sRQfGKqRZthbeEgoa8/qyFAAWa/2O2ssvfN3bJ/SGooubyZFAIA6sCNDjDP5k=
X-Gm-Gg: ASbGncu+S4Z803ih8SUbFXahQFPUlxJ1pmk9Ls8M3U9NVTkgVo3/Id8HOnihVsVKue2
 Cxjok6NEDotqSCNvllJIOYBCVGobmwjTOYfD5k7RyeRZN/kWLCwHrQFwY1S9cRoLpsXnwKZAQAj
 h8YdZVEgTEVK4pBwYTWftuCmaAk+ZQ5AxhANIW7l9u+uCGhmHIWXdDTlylhrSLxpJzfC5GKl1KY
 dD0arjZ+lZhyZngic/vqNAKSfIE5Nb0wfFIt2Y2eHKxSPpS6GpcLIWJx1+lYdjaK2HHH7dFj2ny
 qk2olznjCcL4K8Rmk/NekOHCQjjDuYDZo4LgEu9uzczsZj5qdGOPoJOboBkSCEvoDeiBZ0FMG9O
 Hj74IE5ko4+o2TYu/+jRvWxMH7HtLTbBO60QPh2YaQ41uuJ+fNmk4WrGarbz9pXtvgjojpewON/
 Y=
X-Google-Smtp-Source: AGHT+IHgIttllbdOnePXzZQY0woHHgFJ9w9n/+NSOzC29TP1wrDlgZzucmd8JuevWtyKjUs5KdUvtQ==
X-Received: by 2002:a05:6000:2901:b0:3ea:6680:8fb9 with SMTP id
 ffacd0b85a97d-425577761c8mr2863792f8f.3.1759319737171; 
 Wed, 01 Oct 2025 04:55:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41855fc661esm19224117f8f.45.2025.10.01.04.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 04:55:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] video: tegra: Address some Smatch issues
Date: Wed, 01 Oct 2025 12:55:35 +0100
Message-Id: <20251001-video_tegra-v1-0-faaf48dad062@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALcW3WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3bLMlNT8+JLU9KJE3SSDpDTzNIO0ZENjMyWgjoKi1LTMCrBp0bG
 1tQCAxpinXQAAAA==
X-Change-ID: 20251001-video_tegra-b0bf7f0fc136
To: u-boot@lists.denx.de
Cc: Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

Smatch reported some issues with this driver including unreachable code
and the use of an incorrect operator.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      video: tegra: Remove unreachable code
      video: tegra: Incorrect operator used

 drivers/video/tegra/tegra124/dp.c  | 2 --
 drivers/video/tegra/tegra124/sor.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)
---
base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
change-id: 20251001-video_tegra-b0bf7f0fc136

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

