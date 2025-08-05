Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E1CC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 15:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3A2838AB;
	Tue,  5 Aug 2025 17:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zp4u5SqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881DE831E4; Tue,  5 Aug 2025 17:45:52 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC0E83890
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so19227655e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754408749; x=1755013549; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiAnBXUSb7JI/CQtcPCOCw2UecsuQFWWbeKmhn8jcHo=;
 b=zp4u5SqItEEzjU4KjTVXfWzgSeKbmvsbF3J5EHFjXN3ukjxFhztNc7mUdSpE5W9t6V
 cxic+uZ4p/3h5Q1I2DYEgPHo0OzlTYWUBQdgsPiCXU4LOc3d55Xy1UgKXeDGd3VGApaC
 M8p40GxxR4MbWXT2Yb7OXfAXEvCPexU01YQ8R62l/hMfiArVUKn3rgbidY2I/d3nFhAY
 UaEPn0qrOR4CwVct1gStZtXVx5KYb7XgNwdykvdvDPl/qLl8uGLsr5fY2UngmocIJWjF
 1VTuAqNK1TF0+3yaCmmqtbniuSHulkmtMztSSaxDWizi6K1FtkkJYuhxrlEE7S6r7zxm
 mB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754408749; x=1755013549;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZiAnBXUSb7JI/CQtcPCOCw2UecsuQFWWbeKmhn8jcHo=;
 b=xSqVvPP7QefELHU8LRtsPjdihCEv6prHkJgTW4JxF0fHSvzECaXrty8hnT2L6h9x1z
 fVxTiT35T7zqbVXCUaHO1ALgT6VkUOKu1kRYiJctZlWS74EzQPylTu1OccP1SfJXcnQO
 GPTd8KqA0fu2zZqyDQICTyQ2Z/capiroSxz0CA4AviM4k/n3RnRslTvOPR/RVUlmyrzQ
 IGVVxTGoitm6vYVCO1CpJM92Ozd9bISbqBgd+3qIn7+n4d5mS0tpKxj57wZNEsCYEnkW
 w2ABQmk6Npv9QBKrr0WqqJZpHe0wViQhnF3jk3VQ/G5a76CqpQWPe+wFjJhJDOy9szQD
 5RlA==
X-Gm-Message-State: AOJu0YxiEBSQBSQXOQyG0E9qsqhddc+Of0KbAnmSYqidmMFKMVvdplVN
 nRM4LNb6o3bMnXZsl26yKHG8i/WKJkTXhpG21OB3NPAKRqZo6WTJIg5an2epjpvnzAE=
X-Gm-Gg: ASbGncsoNyFKQWtf2tIr83qIn14FdssHoibJMO3RSLm+sSW5QKQTEKmZAJRBtilVLWL
 uuKzgc9ulJXZ5Yi2ppkw5+0FUxWrrfhHxpSUgU3IyZXUmIdg5OcWXyqsfLSknQOnE8i1Q4hKX6B
 xqWe+vVychD5tMJkv4WceG/YxOFIyeqxT81igcO0Ye5GQ3OuH0qesQtahDo4nZ7oY9Z+E7D265m
 z56PenfjG43F0yLvvNH6F6/12bc/hg8vrh72jXxEOW3TDfqC2+OFxbLWeveSAQXJsErWskAQIFJ
 wLheGO4Q7kg2PqhcvYFzQnLesD7C1NNFJL2l0XSf6fiV+p8tCTAEMLO2RrMPEBE6uzo2EIcFutV
 JAsOYI/LEnqLyJZcK1Z0n7miuVPUxNROfJZNLApK0prUvyybopvk=
X-Google-Smtp-Source: AGHT+IE2xoZDXemWqBuDGOG/7wvxZcGmHnemOhfpRbMLJ+nznPu2aVg3xbfnyqQgxlvWrGcSdMS3lg==
X-Received: by 2002:a05:600c:630c:b0:456:dc0:7d4e with SMTP id
 5b1f17b1804b1-458b6b3327cmr120001885e9.18.1754408749564; 
 Tue, 05 Aug 2025 08:45:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm9007255e9.9.2025.08.05.08.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 08:45:49 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] net: octeontx: Fix some Smatch reported issues
Date: Tue, 05 Aug 2025 16:45:46 +0100
Message-Id: <20250805-net_octeontx-v1-0-637095d82265@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAConkmgC/x2NwQqDMBAFf0X23EAa0Eh/pZSyxte6hyZlN4gg/
 ntjj8MwzE4GFRjdup0Uq5iU3OB66SgtnN9wMjem4EPvR9+7jPosqaLkurkYfRpGBI6RqSUTG9y
 knNNyRh+2Cj3FV/GS7f+5P47jB9oDgRt3AAAA
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

Smatch reported two cases of redundant code which can be removed from
this driver. Also a case of leaking memory on error exit.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      net: octeontx: Remove unneeded code
      net: octeontx: Remove unneeded test
      net: octeontx: Free allocated memory on error

 drivers/net/octeontx/nicvf_main.c | 51 ++++++++++++++++++---------------------
 drivers/net/octeontx/smi.c        | 12 +++++++--
 2 files changed, 34 insertions(+), 29 deletions(-)
---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250805-net_octeontx-770c68e2a77a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

