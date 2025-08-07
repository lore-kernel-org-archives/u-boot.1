Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DACCC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 488D783C40;
	Thu,  7 Aug 2025 13:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DAmJbqgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B70B844EC; Thu,  7 Aug 2025 13:20:08 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6594A83C34
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b8db5e9b35so429170f8f.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 04:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754565605; x=1755170405; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rL1hAuDPKwoLExywXBGDNOdwy51AMArXZ8sv0KhpqMo=;
 b=DAmJbqgEAs+Ip0+xT+ZvpjOvEka+mLRaTd7ZUuvE+/ZMAP0UfgAdbQrvyJ3Eyghr/7
 dy64f7FD8j61YlULpubO5kWXXzo5u3RMMe5gHn8U2T9auvXOgHl0JvdqhS80F0ssXYxf
 b9j7gIdeZA/ktVNJDeMxLzXAUBjh1KjJoUqftPwp2gteXfuKvM8ZDFSI7jPNEhE/62S4
 uOW3SSbf5NYI2Wbj7IipQmOrRzx87nOyIX7G06l0emcLIXgovSl09qxu6fGUcyqdTP/J
 jshqLeNZGF8Lcpwcg/ztDPNO7brzQQm4LeVPoL/+sGYCHaqIv4MsrxI6ZM1Tb9DnhCcX
 Xiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754565605; x=1755170405;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rL1hAuDPKwoLExywXBGDNOdwy51AMArXZ8sv0KhpqMo=;
 b=kI9ueXNxyiytXMtzuuGxVTdx3cEG35wgGa9HzVwKNqoiXO04/u3tje/JgilXUSkCke
 ME6DhpXhZdSBtcu8b27y8SQKf5jmSQX+jRFdkbVL+au7FXZXoZgxmFnioIHLbtdHWbWO
 jba4DfRmqpd4Z1eAAgZMfltAQjdsRSTu7X3NMoyqqWn57vaEkh2uvhNFTSG1yJei4j98
 p9xmG/AO06dkZAhBA4MWnRCNjRzoeezB43tk6cQbabo7X9O3PWrRX2Jj0osGYSJ6gQXP
 I1WFoIDAjD7WqKlK5J25CJr/SHToqZl1gedY3gq2qKg3LAUV/4EApbQ6Jb7D+TdhphED
 uqsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTfVkhYVNgELWhK4qKD2io4I0kzh1TAD0zxi5Si2VgepPQ385oUymP91q6eSc+SUnPfBiCgAc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz+uqwlocMcusJOEx2pbCHG5Av9AjCtHQnixtVZSTIXqfpI/zr
 VDUFCptxBGqMLoXam3aPh7izU6j54fzh6GMqslNITaYGPHFYGH1cGvSUbsMGyW/pDBc=
X-Gm-Gg: ASbGncvOL2sLz8xLkthdAIHoRNPN+csJElLcZTR7w82fJ84UnuAqaU0ewuMVxtd2arl
 8URHo9rU9krGHjZz/AeA+kbOChHB8kDVyOjBJzyqLiiwUWdt6sBRLYw/hfmhVj5bHHQw9wL4bDt
 /eXzOO3f0mOI4UYHTUObG3W90jCIQWnG8tnhOg1kyglVj61WL05YHG8/SrYXweekJRGV3YXkywR
 uaNgHzeleJVmcBQDzWmkm3FPTc8OflHbrTZVWU4nYERue3BQ7f2QOLi2GTTnuK4Bcz4ARp1RWfY
 SCODWuYpYptBVKo581p7mm2Vyso6fulbPvhhk4ooXdu1Oj8BQF43uKJ3KdQfR6xjbNoktd0hngn
 zxnWpS5ztLNl0jiPIujqLsEK4JlT+CH2sHUKPtz3uMDChiPN5pdg=
X-Google-Smtp-Source: AGHT+IGz0k8mvYGez2y9BKc7lBlKes0yVRjIkzya5QHccz26308bwti4yrJYwvILrRygv2zdCa5AuA==
X-Received: by 2002:a05:6000:40c8:b0:3b8:d955:c598 with SMTP id
 ffacd0b85a97d-3b8f41ab350mr4802709f8f.30.1754565604491; 
 Thu, 07 Aug 2025 04:20:04 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf956sm27038612f8f.24.2025.08.07.04.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 04:20:03 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] pinctrl: qcom: Address two Smatch reported issues
Date: Thu, 07 Aug 2025 12:20:00 +0100
Message-Id: <20250807-pinctrl_qcom-v1-0-42fac6707fd5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCLlGgC/x2N0QqDMAwAf0XyvEJVimO/MmSkMWpgVk1EBuK/r
 /p4HMcdYKzCBq/iAOVdTOaUoXwUQCOmgZ10maHyVfBP37hFEm36/aw0Ty4gNkx1qH0ZIScRjV1
 UTDRe0YS2sV5iUe7ld3/e7Xn+AWDyQmB3AAAA
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
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

Smatch reported issues with the limit checks in these two drivers that
could lead to an index in an array going out of bounds.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      pinctrl: qcom: sa8775: Limit check for array index not correct
      pinctrl: qcom: sdm845: Limit check off by 1

 drivers/pinctrl/qcom/pinctrl-sa8775p.c | 4 +++-
 drivers/pinctrl/qcom/pinctrl-sdm845.c  | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
change-id: 20250807-pinctrl_qcom-5aa7ec35301b

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

