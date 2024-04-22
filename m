Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B030C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE93883CA;
	Mon, 22 Apr 2024 11:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iQE8eBfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1335188349; Mon, 22 Apr 2024 11:34:01 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3CF6883E3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41a74e60753so3120385e9.1
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713778437; x=1714383237; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ghnYoEUk40/o3zk4NjX6BQxvc1KAJCGlPQfAooJ36vY=;
 b=iQE8eBfcchy17//FtXn40cXk1rr/klSc4/h8WNiHpto9SI9JfHJgNoIrcfWaAXSXf6
 RU2msXysJ7fDjBXYC765YJcK3TbDLU92tkiCcn51gBejAv0wvKLre0Q+E+Ibh14PJvoZ
 JNiSLJudPpZQ4Pnhd/JioS2SlH5hWQaAKqMGW7ptESsTUqYCi67oMXwyX1wFjRX2Wzd+
 bKAdvHZlFSW1hiIzOaai5IHaWLr1c8+vh72ZFLlFKto8nJfPCHoUiYzxhY4yrbwYw1lw
 +7MEsxRiAQCdV1ZQxV4lAgjsA6KhjXuvUhcIqN78oHk/mZOYt/UYWvnyuF8/8/lAmZbX
 sA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713778437; x=1714383237;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghnYoEUk40/o3zk4NjX6BQxvc1KAJCGlPQfAooJ36vY=;
 b=LYukQ6frnClgiGFzkyiE8Ap8up5/FKeTnbMH2RDOW2ZxQ/JlBxXtWU+5A7eM1zbwTs
 NyoubSbfvLQrp0tQ93A4SRf1xKwi90IAAlEubSS7FVcGNk5KXir588BGznnisBzvJVfp
 IcGoRFFEIKbH3B2LjB0COqY7sKO6cSXPLGsk80HBLADjoSSGa83my9cmzPkLLtYnv16t
 wRZQMgUxIvAb1dDJV4LBNm2/alklImCCfjw/XVWf7WATmhP8XAHMXjkFBJlfnsf0YTvh
 sjB/uLYbidIf8BQCmdFGjf1H7LYPhraO/vKFmUG1sdN5zv35KTM1vj0S2xnfIpOPCzh1
 mwvw==
X-Gm-Message-State: AOJu0YwpUGtb6JgbvN/MWRz0BS+SJ4XTrU0k0XOARcKpxcXd/xpznGTc
 chf7QDIznkqFx/sv0Xu/gVwAyV2Rr7Ns8gEMzsXvzpqCZ/Pwg+jOISJiiKZXB40=
X-Google-Smtp-Source: AGHT+IHInUpISXLYJRQa9w97cbUAIS4nG9KU7DBVBbYYup/FfWMaARGfmQrOh8oWB+9Zo48Vh+f7NA==
X-Received: by 2002:a05:600c:c19:b0:41a:741b:300d with SMTP id
 fm25-20020a05600c0c1900b0041a741b300dmr809100wmb.2.1713778436934; 
 Mon, 22 Apr 2024 02:33:56 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b00418a6d62ad0sm19755138wmq.34.2024.04.22.02.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 02:33:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 22 Apr 2024 11:33:53 +0200
Subject: [PATCH v2 2/2] configs: qcom_defconfig: enable GENI I2C Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-topic-sm8x50-i2c-v2-2-f9ad61c33b07@linaro.org>
References: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
In-Reply-To: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=625;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0l4s3Af6IDIwKQhBsTS5QWo6ORXMbRIIuHK4qrkcyh4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmJi8CzZMF4MjtBn4vGIm8/bisyroWhKB28R/J/3Qu
 p4xlPyeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiYvAgAKCRB33NvayMhJ0VMHD/
 9XClS74prezIy7Ffg5hF0tyJBuTAyLqSJrWvv4oUcYixt50SOsp91fKFKzqkDCXmeYx8DoH6Xy/pGW
 Uo/E9lXTnNUijlGMNt8dA0ZNjfazvUwwig0Hsh+bz+jAcXiLm+TlJ4tN/eiZGHrzhVF8vuUyucpNED
 uwFZAdHCVgC8ngkYefis10Zty5/bBmZmAi86g1S3qaBqCzSC66VPc4DfzMUV2XWltsx7vdZLUz5G1+
 tUDnNq/VfrbJwg0VJM/yMmF2bjQJZjx8MMZ9x+84wfb0GLQ1+86Q8mR4ys87H9eaHGbb4Ygvc2PzQ/
 nG9aEwappIIyITOLK8qK2MIy0VsoTm79zIYg10DyuZh/TbB/rAfZtVLyazZerQHtPP8crrtbN6Tf+e
 5podlGO0I/UcNkHb8cuOoTNSCyMZJuY99w5I0ofpsZpwXHkF8qZ++9lr6MTxYPqI3NUyyr3aSM+lpK
 q6kct7p5Hs8zFDfUHWUqHCMfXpNjGj6JQtLHttj5RaAi0gpuQSrv2zGSARrsGQdkTMgPysRxw0skUB
 MqMsNPd01M2Fw0m+ssUgZqYAPMx46v+nNkGPwUKWpvgeCn6UnraS3zNMLxiBwJ8N30xoWEIfTvnwjq
 YZr4UY1vUt6HVMEBk4TN5NRDUrk3SImIVCJY/no9KQ55eXOntaLTjprlRMAg==
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

Enable the GENI I2C driver in the default Qualcomm defconfig.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 1abb57345ff..8d440b23625 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -41,6 +41,7 @@ CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y
+CONFIG_SYS_I2C_GENI=y
 CONFIG_I2C_MUX=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y

-- 
2.34.1

