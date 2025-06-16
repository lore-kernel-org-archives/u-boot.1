Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00346C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D57182C4D;
	Mon, 16 Jun 2025 11:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T4YGp9Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC0580C93; Mon, 16 Jun 2025 11:44:53 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0032780C93
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so50915965e9.3
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067091; x=1750671891; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hy9f1fn3I5ALecq0gO7fGgrlqtFF5LhMfrdPKYET62Y=;
 b=T4YGp9YcK+w6OO+zB4jqGNECnRO2C1S2XzGGOKYntn6pWnIx0Tv54YSHQUSn12ME2n
 QrT90S7MCb+b03N94yz+bzQvH680J+vOExGtO4T8w3+AGnkVhY70TivXIFTHbCwtcGF2
 j9/nTPczSQ3Mm1OlYR2AwDH+U/+1LqvKxlgEzgpbroT+tBdMq/P2n88pD+7ad5DjDUK6
 IO9mUXg29VD3vAzZAJz+CXdywozDzDkmOJ3zjXrRFNU82m/1qe+FoCrpkZIdEioiUS3k
 JyzIACep6CQ7QFW6CrOu5ciYdk2hnSbgulWZEVrrJWACv4BZtwnXgxXmyYCt3YPrpano
 rHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067091; x=1750671891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hy9f1fn3I5ALecq0gO7fGgrlqtFF5LhMfrdPKYET62Y=;
 b=ql7ILx+BwWejg/2HlBZD0jrhgJEWruPzbsFE/KkVYMdYEimaPiNurdBAGLuA3LPs1c
 E45mjOtDz5mAklYxktWxtQ2SXVehbOupnb+8GltWyXGrPl4R7f2SqJ4mJ9oGK1iY608A
 zdBnGHwJklM6aiglkBmZL/rtMCwYzYTaBmBoOo2hPjUFXFxfU5ba6SELvUb6Qb4lbW0f
 pNbo/FlPSOi+CKhZVuEqKaIrKkm82OA5aLRweXEMBjb1MIA6XV7PVaiw/XCLetm6heIV
 BZkCaN8UxvoQAlyPlIE/ql9R2JDa1UGzwrYCQqgh7FS3aBSO43z9Lx5hH142BmwMkjyq
 hiow==
X-Gm-Message-State: AOJu0YzEcfxCuwqB3Zihga2LpuuOMkeEYWzKPTDIoLtH2vtbirYPHR5J
 zdmIyQw3dxvuS2ww9QFaKV5aSybeExnFQ4Y+D2Qm0cx+pyNRtz9gjtFY90QOacoBa8Y=
X-Gm-Gg: ASbGncvQB0mpXJ0rgJ2QcoQLrnUZMAV8k+Lwe00tovJsaN3+pLlCgQrqMjPT0kQx038
 Ral72G32MB7mXR46vLo8nhSW+CTJNUXbPFDH2/pWYiyAUQjlgPIwZPvjEGrxC+Ud+i1+MD6iIAq
 vp/UGrsfDWV8yuZ3CaEBNAPF3kOI5AYESu2wqIdYIFrvHJWisyO6N+1oQ7TZPDuEFz7c0Yo1dh4
 SzFo5s8BxnSPIml3nkTE9K8MD0S3NGbHh9m6cLrufZ6LBPANdHcs3LhCHILXI7NTeFum3p6kXNI
 NBBRIfX50KD/v7oCtrcGNakNzhMZbGzvZ8hzYssCDlebTDM9ej+vCxkCeMHb+LYffUWjbTJ1ULC
 6upxW
X-Google-Smtp-Source: AGHT+IHuchW8jt35zUG1HyeqhZSMq27upPSW9Gy5CA22OxBYpT8Rz3WlKE1Q/VeHPrwb+HeJZwT52Q==
X-Received: by 2002:a05:6000:26c3:b0:3a5:2ec5:35a3 with SMTP id
 ffacd0b85a97d-3a5723af286mr6480300f8f.45.1750067091413; 
 Mon, 16 Jun 2025 02:44:51 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:50 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:44 +0200
Subject: [PATCH v4 2/9] i2c: geni: fix error message wording in clk_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-2-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=kzBWmmFWAnrmw5DkvENtcU1+kVlPOh2dJ5Hl8gqjEzg=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eNSHq4PEtVMHRHkmB+HBGa41DseDqmsEtNB
 m5oqnv5cuWJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njQAKCRAFgzErGV9k
 tl5AD/9R3Jk5H+zWg00tw+Mk/kZt1N3yC5u7AU3kzS99nB3ySkAPa8zRdBlaQQK+7UO74QjThzE
 EdlY0rOdCCPQKZC2iVZYf+vy4TBkmf63I07xj5CfZHvvdxCyHR3CorG2uInyKcaQqGRX9F2zCpo
 WTz/RbTi9/kp2tTMNQdeAc4lycF3Tuo1pwa8ZB5EsiMDIWHbRCK5BZhzPS2QztY7hzR+lBgG1Kl
 TK8z077KbfLp1w+HUj26XfNz5yxsHfzK7zUCoQzTADVFehtwE+SRWFTgR4SIq3oTSrt324qV2AH
 tmtYlqoBkVM6lnHUVdglLINbWW4CqVwNLW1qMRAwm1JTSDZdUmFyvkIvODSN+S3RWyOBwIytdPR
 XR48kIDEZBkYwRsJLVCjF8pfFoOitITQhWxDf0s5tNM6VqxyJFPAaumVDRhkvYunhnV125AuBLo
 DIUrtJZ7P0MBekFzz7vBdHC22CVxU25LrgN6xyWSfN8FAqUiesbr6oBhrCfaKZ/4biC7uoiuJIc
 zSqQs98r3ZugNiTvENuZfL0uoBdKTKPhEdaid1rpDPWEyXVO5vzn2FKS5bEBmiuRQClvdb5BXxe
 VzNG6snUVOdYwfa1lje+SbbAuoqNQ+BvXtF3EBL1ZQu2A5SmWeMyY5qYx+QGPbA2Amt7sy4+WDX
 0T0QXS74FEQEgjg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Correct the error messages so they accurately describe that we failed to
disable the clocks, not to enable them.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index eabf5c76c21c2bc12c80dbb9fb498a0080928248..4eb41ba852f7790ca646c8ba38f29fdb727fa804 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -330,17 +330,15 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
 
 	if (geni->is_master_hub) {
 		ret = clk_disable(&geni->core);
 		if (ret) {
-			dev_err(dev, "clk_enable core failed %d\n", ret);
-			return ret;
+			dev_err(dev, "clk_disable core failed %d\n", ret);
 		}
 	}
 
 	ret = clk_disable(&geni->se);
 	if (ret) {
-		dev_err(dev, "clk_enable se failed %d\n", ret);
-		return ret;
+		dev_err(dev, "clk_disable se failed %d\n", ret);
 	}
 
 	return 0;
 }

-- 
2.49.0

