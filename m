Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C22C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 16:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 711C083FA6;
	Mon,  4 Aug 2025 18:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ufcTX6Ki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E1A683FBC; Mon,  4 Aug 2025 18:57:00 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD8D83F9D
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 18:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45994a72356so13712115e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326617; x=1754931417; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JtNyt0Ze94A0Jvgj+SuFY9sfRm6ch3WFoVHd1gVf3SU=;
 b=ufcTX6Ki0po/RF2VZmn2pdTv5BUX4+4T9EieIPcGCEyu55CJCQJwnlrDhtKapZO3SP
 yv5H4LVA3BzXIUIYLeJ2fkfXJ5H//n7yqgFBlcuH7llg+zAv5t6+vVMu+RcN+x+QhIxB
 0wUPR2Nj6jLuBxLKzSH62Gv2qpGbIPcdX17JDDUJvnR0sLNWS4BF198uz76RLYTyHPYT
 SLInDLr6ZQttwEctPBDOckMl1JYvJxyvKD3AECt55H3tzIPjpoQgnQAA+eZin2s6zK7j
 xag1en3MDV7kzTxaO6E/VK5IZAj7irNltT9PxqULxDj+XtWg5SqvazADNeEdjQnsPg9U
 DFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326617; x=1754931417;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtNyt0Ze94A0Jvgj+SuFY9sfRm6ch3WFoVHd1gVf3SU=;
 b=eJL8ZVnyUQZxBvHc7FxOUIRuTU4zr4Kdy7Y4sFmehFp1wM4kTSQmNR2ChHs3IYnHgf
 mQP5ASgwE0iqKQDj1JvuGHVKfx4GWSjjk0xnHtJ48RdY/yB4bkfE8wuHmxiNI5GmuV6K
 B3obDxmKSS6ZfcQoyjOHgn9LjVcZqxC9QCL1A52hEZGdqzc3iCgW9lC/KDDg6zL+j+6p
 CfIIGrdCo3xG4j6APzPqCAu7NhnSALS+3lBmfQDEzGIGPLuXK8rdIwUzYxkgZmoK05u0
 bivCg3EzYU8KyAmg52HbNsIbrUA6SDz+xtK7DmPpsnCTIGvn+XTRdWTM5lDP6Hwg4nZc
 UQkg==
X-Gm-Message-State: AOJu0Yw4p+8SWl2GO0VqS26YPE+dJkBGjtU0XYCDJRiUoCWiSeo5PWJx
 BX+W/HD6Wmi3/aQfgFNR7Bxnoix/RfCMhGQudQSffji/yaoOnPUYtHyMFhzXfZ+R3JDGWII81Aj
 xxTzM
X-Gm-Gg: ASbGncuIpX5rS6ry2jv7+N4wcUHdPWvQUcxDjp9SpJHr+lfS0tnKVivs0XoNKP2OASk
 wysxt8ij1/jM/2dqh3p3iQ73kpo+L2pdebQm1mh3s6SC/kDfEKBiLO2N/5m1Uomlaw3refLNiHo
 6gIRmsUCTcxyPkx7L0/cXKHy7+hybXM2e5w8KaRNgPwiJ+4/tSTut31n1cIQ0zvCN/knYcRMlVf
 p571i2DDhsGO4AWQyRWBU5S+K+PfwxEuEJJ5mOqrArRK8faJCOWQJys29IV2Hm6l1kLsWZZsFZS
 ZNGMjHidBwdZu+wqDZySK8FZd0fAwXORj0mhooKfLa3invDKc5EZdPqag0hpOrztqvbP8AZ6q5v
 Ttm83iCEJFsahM2jua90YYzPQnUUq2fa9vkZaNUxZDETQiPwHv+p2aTYD4ITlww==
X-Google-Smtp-Source: AGHT+IFBCXCFG1MRr7kbs0orvuG/wrai+ITl12a9VhGMQn41nSbQ/mKXobL5EazV6PQDy11QDO/DZQ==
X-Received: by 2002:a05:600d:a:b0:459:dd1d:2ee0 with SMTP id
 5b1f17b1804b1-459e0b1d154mr2439255e9.0.1754326617151; 
 Mon, 04 Aug 2025 09:56:57 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:1ba5:34a9:feb8:a948])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ececdsm43054265e9.1.2025.08.04.09.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:56:56 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/5] net: fsl: Fix some Smatch reports
Date: Mon, 04 Aug 2025 17:56:54 +0100
Message-Id: <20250804-fsl_enetc-v1-0-0708a826f9fb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbmkGgC/x2N2wqDMBAFf0X2uYF4JfRXSpEkPdEFTcuulIL47
 8Y+DmcOs5NCGEr3aifBl5XfuUB9qyjOPk8w/CpMjW1662xnki4jMrZoWhu63tUuuSFS8YNXmCA
 +x/l6rF43yDV8BIl//8jjeRwn8mjhVnQAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
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

Smatch reported some issues with this driver. Firstly a copy/paste error
resulting in the wrong return value being attempted to be used. Secondly
some variables being dereferenced before being NULL checked. Lastly
another case of the wrong variable being returned on the error path.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (5):
      net: fsl_enetc: Fix copy/paste error
      net: fsl-mc: NULL check dflt_dpio before dereference
      net: fsl-mc: NULL check dflt_dpbp before dereference
      net: fsl-mc: NULL check dflt_dpni before dereference
      net: fsl-mc: Incorrect variable used in error path

 drivers/net/fsl-mc/mc.c               | 28 ++++++++++++++++++++--------
 drivers/net/fsl_enetc_netc_blk_ctrl.c |  2 +-
 2 files changed, 21 insertions(+), 9 deletions(-)
---
base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
change-id: 20250804-fsl_enetc-30b45818f86c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

