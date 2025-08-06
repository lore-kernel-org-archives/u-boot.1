Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F63DC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 17:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B0184379;
	Wed,  6 Aug 2025 19:03:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EGukn2l+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F6084379; Wed,  6 Aug 2025 19:03:33 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B1884375
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 19:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3b786421e36so10945f8f.3
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754499808; x=1755104608; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rUf/iuWAdW5aHo9vK4eCFApWHue64vMzCuK0ghr/PS4=;
 b=EGukn2l+o326CuKGYl1lnUMa1d2+dqQMnUmaNNjd4XgKRIU3DSW0VPgB1bUxTSk6R4
 2HKqW0im1RMfOt536WQ/LZmSQVEDUNSqlEE8qOm1jIjA27DBGb9DQE7/kTJgEhdw+ZeY
 sMHjxu9YjqndIf+VcJ9uBaQKYlEoX3VavYkv53T/Fz+ApJj+wX7YqGfFDtIdQojhGM5x
 m2pAXhXuunMyYaXZXz7fARwutg+JLflNK9EJp9o65wmjMhsRSPVrI4qB8CW9OJF9i9gv
 8+5ufFIt3wZZ5XWx472X85rbS5alIqR/HzVom0WtF40JnTmV878lI/RqZGqbt0zFLDpv
 9HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754499808; x=1755104608;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rUf/iuWAdW5aHo9vK4eCFApWHue64vMzCuK0ghr/PS4=;
 b=WwfEltXz+84L9NEolfEGflXXX7/AevRQG69AHYbL/eQ1o4Ylz8rB0OiL0SotE/3Odg
 CP8R9z2kz2zjNXxMdL10uNsmAVXCii0d5ENbXieosffweXUbvSbMuTBlPRPXY5eQrb63
 KjJvE+uJ6QDVJTHnBB5Bi57or7ygPZeAwFkw3h6rzMoz6oHZQvsMPLn2Qp588kg5+hfY
 8gXFNPy/0bvXGMRm9iZwaADpHvEaqAwymxnlE8me/ZRUvGT4BoCT9gvc4kM/drhKZ3OX
 Lvu9M1vCjLmrvpy4UQlLAyDmSfA8S2evuWwzWk61EC41SbDVxk3EQ+QrM7LEMP30PP7a
 oU6w==
X-Gm-Message-State: AOJu0YzBQ+4oM2ZWVzpnHR4HvWQuaPuHsAs7igPLzRc2sJucCAmilsGK
 q0bCZR8RH2TruQhlZ6iHl/nBgrOtzQf/iVBCHYeL3av1baYPZLUTG3zunktbHdpl+UeZ049RlGB
 XPrHe
X-Gm-Gg: ASbGnct3z0nOWNk7qVN/xqVHWthqOmRemhzfBeQ9c2xeK2TOcZz64GTbdr4ETDtC3tw
 UD1lYkTf9RJ5/g5JJtB0cfHrmDMnUZ4A2R/GzwUkY3+FSeTYc9gibeX/UeqLkuoHHfy/1d/3j6s
 H9ayP0MU3P72vZ3hI6QCLdxY1xJPW6CCirlXMGXlVNW8f1BBFF4jlCtgM9N2RH2QoAcpEn/qfvE
 Gng7071cYeIu9jqAzmRBZLpuVeTodAN6vzwJ2qtuRHDrGhRySO3/zuVLdVca/B7QNJOB95uDCm8
 AObw9AiX5gDwQYGvUJHB+b0L3Srlslqj34sZ7o0ntX7C43wPXBogj06E6PzUXvKpVc97ikpMizq
 y6908ZPn/gmf8Z4i+1LXwybgU8RiwLg9I6Np02GU+H9kSru8jcmJt6YG1KgO4aw==
X-Google-Smtp-Source: AGHT+IE6Sh2GpN0Fat3RD89ekLweUJX41tGVvMHWDabdsUARFXF1IidkEjvcjDNG5qv0tWu6BjNM9A==
X-Received: by 2002:a05:6000:2408:b0:3b8:d360:336f with SMTP id
 ffacd0b85a97d-3b8f41f4becmr3061639f8f.28.1754499808460; 
 Wed, 06 Aug 2025 10:03:28 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5d0b1afsm53118805e9.26.2025.08.06.10.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 10:03:28 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 06 Aug 2025 18:03:26 +0100
Subject: [PATCH] phy: ti: j721e-wiz: Set error code before goto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-phy_ti_j721e_wiz-v1-1-9b6649dda32a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAN2Kk2gC/x2N0QrCMAwAf2Xk2UKXMZ3+ikhp18xGsI5kqNvYv
 9v5eBzHraAkTAqXagWhNyu/coH6UEGffL6T4VgY0GJrO3s0Y5rdxO5xwprchxcTsMVz03Q2xgF
 KFrySCeJzn/bw6XUi2cUoNPD3/7retu0HSbr+mXsAAAA=
To: Tom Rini <trini@konsulko.com>
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

In j721e_wiz_probe the test for too many lanes jumps to the error exit
path without assigning an error code which could lead to calling code
silently ignoring the failure. Set the error code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index c69a342e2b4..6e2d4bc2b05 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1201,6 +1201,7 @@ static int j721e_wiz_probe(struct udevice *dev)
 
 	if (num_lanes > WIZ_MAX_LANES) {
 		dev_err(dev, "Cannot support %d lanes\n", num_lanes);
+		rc = -EINVAL;
 		goto err_addr_to_resource;
 	}
 

---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-phy_ti_j721e_wiz-b25293380ddf

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

