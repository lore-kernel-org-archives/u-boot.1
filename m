Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD41C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 10:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A81844C7;
	Thu,  7 Aug 2025 12:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zsuI1S7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3700D83C46; Thu,  7 Aug 2025 12:04:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E530683C39
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459e20ec1d9so7474165e9.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754561046; x=1755165846; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=thuwGn6BhdyBIfsoa4lR/ZAVU7jk6hrXQ52uW43ho2Q=;
 b=zsuI1S7luEkGidX7Bzd6Eo0bagyZaQTE9++01y0XfhYrSIBt9NEep59mi1LU+sf7N9
 sUg/72Zm279tc2bIvU7uNLOpwbigq0Bkeh7AgPArspLAMsll1d+RaMDXmuorzq/EdRdW
 oNz+ggrgbbyGDe71ft4oIHK8r8tOA5a9iSMle9UQ7uZzEvOaO0IHsv1QgZ/JhvVzq4hT
 C/DhCXjcO/IPwZyGDhsgn1z0zqf9h1BYjROBfG5h62n34kUOc7OkkXW7ZEjK4KT8sVZu
 4+0jRCnAm9b6EYxZAL1ERFsVRE6h3ZBtnNsNIo0yEBL+T9fq1sBhjq9pteIptkYpzL7Q
 uyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754561046; x=1755165846;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thuwGn6BhdyBIfsoa4lR/ZAVU7jk6hrXQ52uW43ho2Q=;
 b=xMQmCUzImERS6mAP6tx0giEQuvsqxXPdE0cnFGjb7UPkDH/W0eDcb6wQ/cp6znN+nh
 8YNfqwGK3XafGEWTxOPDV6jgXq1g/4SEy0FFEnVgU2yo6yCZOXhjQ2xmlN5rqsy9a8t7
 o8rrEzwl31iJ3FKc7YPfWDwzzlb15bD+Z0EnEL0I8x2V6uRb60e8gHiaZqv+r93Tp9me
 +CLrTS87XNYO6hy8A007eHYLVTvHFCAePpTPrNNIqFh2n993qw+HGpBXcyANzwOZ/jyL
 bA1iUyWba1L1qJB5TT63sQJozuSZ1QvUL5MdFp6eUG8ZipK8GzK60+9IYkdfnu5K7pUT
 taHg==
X-Gm-Message-State: AOJu0YybXs5qxDoKka+rRxPlocxIfAbiYBoMYhsMvJRnjec93SEc6Pf/
 jyPdN0gkUsf8jxj7t3NT+t7ac/AEraKLFDeq/BCWbWjTFLjny4+iqp0Z+fF9t8OQh/iAtlytaxN
 dIKSNXvg=
X-Gm-Gg: ASbGnculb3GCrW9Qj3LFSj0NhrzWcgUh0qCyu5d3DAmUj1XI1DOAN6eqGpBghbjVMN5
 qhbXxWBstwcArQ8tgnlgtqMdBPxGoX9C6mejC9GapZcEfcG5RIa9jQnPSzJxDwWYgM7EK5bot/L
 M/d2T9jhZzlVH9LGz9EO+IhQ03aJz81R9cQaUWX5rE4bg9LKUwnEXdd2IensUJUZyczr6ts0TUB
 2dqkmGqNUJHEHRInrTq1p25mF8Jv9cFQC1HhiF39WvTiN29ahc+gTtXufjuGY87nz/ttMSkCDUD
 TtL+3khghHqg9J9jGHlHG32zwlEyKKBAyZxDe3W5NFo9XUFGSjqodrrwwZTe///vIHG23TtOtsX
 0P7AquTDdt/MRtwCIUq+2IGISrjCZgw6z8FCZ35x5tnt2iJQqjLQ=
X-Google-Smtp-Source: AGHT+IGlUNKn+xWxODn+yrPJiO8FKrHAW7ta4nivZYCj6/4OyVCgbHLW6Gf1kYrI2ZVsaIug3s7uvQ==
X-Received: by 2002:a05:600c:45d0:b0:458:bf9c:274f with SMTP id
 5b1f17b1804b1-459e7478234mr51814065e9.29.1754561046325; 
 Thu, 07 Aug 2025 03:04:06 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm358481575e9.25.2025.08.07.03.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 03:04:05 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/4] pinctrl: Address some issues reported by Smatch
Date: Thu, 07 Aug 2025 11:04:01 +0100
Message-Id: <20250807-pinctrl_misc-v1-0-eeb564a1b032@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABF6lGgC/x2N0QqDMAwAf0XyvEIVndVfGUPaNGpAqyQyBuK/r
 +7xOI47QUmYFPriBKEPK28pQ/koAGefJjIcM0Nlq8Y625qdEx6yDCsrGhfa2HRYPl0dISfBK5k
 gPuF8R6vXg+QWu9DI3//n9b6uH/CVVLB3AAAA
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

Smatch reported some issues with pinctrl drivers. This includes
unreachable code, duplicated code and uninitialised variables.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (4):
      pinctrl: single: Remove unreachable code
      pinctrl: stmfx: Remove duplicated code
      pinctrl: zynqmp: Ensure ret is initialised
      pinctrl: zynqmp: Avoid using uninitialised variable

 drivers/pinctrl/pinctrl-single.c | 2 --
 drivers/pinctrl/pinctrl-stmfx.c  | 2 +-
 drivers/pinctrl/pinctrl-zynqmp.c | 6 +++---
 3 files changed, 4 insertions(+), 6 deletions(-)
---
base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
change-id: 20250807-pinctrl_misc-8b7d59c1684d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

