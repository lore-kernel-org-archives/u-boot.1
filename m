Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C581D2A52D
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 15:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB4088D14;
	Wed, 16 Oct 2024 17:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QHbNeQ+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F9C88D1C; Wed, 16 Oct 2024 17:47:01 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAEC88C05
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 17:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-430f6bc9ca6so54012485e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729093619; x=1729698419; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2k0fDqhAU9GuO+iIITj+cQaEAQZMXktlZX10M26tAaU=;
 b=QHbNeQ+ks/83m9irVbf93c4NGLuV/NbNswVUsbJOqHtlA2/hRYTZrizT4LYjD+UdqA
 pU7XV1UH9bZM+F2vCdOqzC+Yf7jrSGJU6WeT4B2bkcs+yvN/ao5gfiKXYco9/Jy3LxHZ
 zPK5e/JzY1n4BBOlf5Y/IcPMqpyStAukY7IuAuyPqTSZ4pRbzGCO/DkqE5bRZak2JCUr
 EE6YGdmUnRQAacPsyy6ca4U+CW52IOiQkAErIa0VlUyVl61UEekzuVPWZYjyUCM5Iq30
 e+SZJW5k3ulqMLcGBsyFEJtdNNwGifZ+i5H8+Fwfz+eg7PVGEgh8H0IqLTEFQXaYV4zP
 Fscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729093619; x=1729698419;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2k0fDqhAU9GuO+iIITj+cQaEAQZMXktlZX10M26tAaU=;
 b=eRJpWEKNasHSfReXso7JVYq4kHxbiyPQ0RkHpy81A+5i4ecNQt45rcIML6erpaXa9f
 DlxOiqDgsZz+jJwFG7DzQleoe85QEyHYGblXSze1uB5gKG4pS/C1Ze21eDQNfSYsX8iX
 GjQ4n+lruDyvej9jJigm78IAyrHoDUjHkGYdAsMSo+XvqC4/x3kkYIFigjVB5+CgdvS+
 gE2wGzScVNaIa7b3AP4zADExpoyedH3TfYjqNxSXihENfo/Q1znUPTYQ7XM70KVi3vPz
 BIF8UlLrjI+Mp0RvcJ0gkwWMS3GTYWFI1IQ+CUwE5hHetXMszd2CoKvRSKjUL6mTX5pn
 nJ3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMu4Gx7tbJ/BfYiRDxEkzGf5oTs81Dxuo7RyCT8wWn8NN8nEVKDffF/GVjeY8wApCeM8F8lIA=@lists.denx.de
X-Gm-Message-State: AOJu0YywLsqqLuUPWkurl+tC5YMdvgkd/+L8mZ9zjqDhvUJtQlYdrwOD
 z1YG7d5OIoNAxvVbWxEjDU2wr3EzCfY3L7M/Vkq4vo4iDctpcb8q+UetUqlZP/c=
X-Google-Smtp-Source: AGHT+IHlmq3KstXDb8OOTP+zkyfujkjVGGNON+k1cvCNiyL7txkcoF7xfCCAB81ToSX7bg3XHdiCMg==
X-Received: by 2002:a05:600c:3b8e:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-43125609939mr131191085e9.22.1729093618911; 
 Wed, 16 Oct 2024 08:46:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4314a6fbb77sm37767315e9.14.2024.10.16.08.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 08:46:58 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] image: android: misc fixes when using on Qualcomm
 platforms
Date: Wed, 16 Oct 2024 17:46:47 +0200
Message-Id: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOffD2cC/x3MTQqEMAxA4atI1hOwVvy7yjCL1kYNopWmDELx7
 laXHzxeAqHAJDAUCQL9WdjvGepTwLiYfSZklw1VWdWqVA1Gf/CIk5FovY848UmC2/qAtxk712p
 je+2sdpAnR6A3yY/v77puMY7ekXAAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nWiBQLdR+une3q+GRvJqA+doTBESuuTfabHiJMIdFu0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD9/wxoXd619I3y4bkqNMIwGubkBRnpdHHH/axFDw
 C2NUuouJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw/f8AAKCRB33NvayMhJ0WicD/
 9VFvlOi6QnS5RJ9MZRY7l83Py7ZPiF/7AypWB+lPiAMrff7U3N14ALGG91XySWCapd+f3WIjPjs/Kp
 85KXUCg4GulM+L/2jPl/i6yxwAxl4qbbVTNe1XQJjPKsJOSjl6ZD2nicvUunVrhJHuLHl9Z2/kY6+W
 8G/01VcTFtEP/zlIMrBwu6S+r94FcPda8G3X9zjrc3xu2K79huK09FA4PjlNNmXn00kh80f/yLemTC
 4yZ3M6L64U5hJSNVGCQBegCJjz/oTBxFg8HaIgOzdmeosFl8sXSR005pL+KDnMfUNy5UVHg/r7dCCG
 neUSZLR0NKHXOLlt+h1FSGNihr7UFfIl5uJyzd382jRhW2DV8im0M0a5e0x8IMKXPQQp3xsXc5URrY
 Up4jahn1Aa74CwjfxjfhFxBd0ncNYt1iIogC4IsccBq+wwrNswQaiXvexhEHWUMWegtvPtzUa0Q3cB
 Q7OAi17VbSBT0ghlHbBXsIZPmfvc27U8zfIqICVA7W21T5mKyY3FWpU2CQ4IdftU/PmT7/howPpBj9
 exMMw2UZAlTZtUjqKXo+3KMBhG1J328y4YGeq7vTDwksLKbcUwqB/ADJZoryXRqMmTP8/pPZgicFdD
 hN1OYgW3FZiVyhgBSF4uHAUGI2yPqkCTiT43JZrRRdBaRe2xcZY+YjhSTHRg==
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

When trying to use the Android boot image with header version 2
on recent Qualcomm platforms, we get into some troubles.

First the kernel in-place address can be > 32bit, then since
we use the Android mkbootimg, it uses the default load address
which isn't big enough to uncompress the kernel.

Finally, the ramdisk also uses a default load address, and
it should be taken in account like for the kernel address.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      image: android: use ulong for kernel address
      boot: image-android: do not boot XIP when kernel is compressed
      image: android: handle ramdisk default address

 boot/image-android.c    | 60 +++++++++++++++++++++++++++++++++++++------------
 include/android_image.h |  2 +-
 2 files changed, 47 insertions(+), 15 deletions(-)
---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

