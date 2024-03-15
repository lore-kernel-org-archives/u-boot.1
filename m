Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C20FC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D249588054;
	Fri, 15 Mar 2024 16:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XOC8eiGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0955D87FBF; Fri, 15 Mar 2024 16:10:51 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCAAE88064
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ecb04e018so875219f8f.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515441; x=1711120241; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LlTy2SH0jD+rDZMfgaioHxBqgSU8ahy9ZHuQdbxygR8=;
 b=XOC8eiGLM4u/J1fApuujNS+0hVshfzrbZb3z2il7hkbBc4tufZmrgL7Cr5zmhki+sY
 pIcF9UZhozoqcqd3LCm93TrS8WoTcGAvp1t72nk85jVPBti+MUSSoMCErjVUyP2IB4ZM
 xYbXLaCE/Lc3xeIxGjWb+oWHYSfjapAhxPo2wnCdLOD5qgjyp9DKb5JV2sNMLerTB4vO
 vLZVCXX1agUFecLSqZ7opRg7uvT2QLo9VWFdoM/Yc7wfbWM8GAyA0AHGIeJe+XcOUb0r
 QwKzMITykeePdXo0BttNoSFgQx1sc66zJVBKKYUOahwSQHHOYD0mAzivaZYfarttFrhZ
 z5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515441; x=1711120241;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlTy2SH0jD+rDZMfgaioHxBqgSU8ahy9ZHuQdbxygR8=;
 b=hFF0S+jOvZGHSyVlRIoOCIyJHHwrdWSbCBDzJP0ux76VUKXfEH454AuU+yD94a/k4/
 nxOOcY0ZkVPkMp+57K4K7JIbvbiWoEJ3Gv8iBGLRlHHsAXLQd6eD8+cxBu39jtO0Wne0
 DNnvjA6YTcIj0imIwKt7LLP6cltnNoEFeqaslHoDaR455F3QrU6S5PS9T9ZYXS5sZ5pc
 dkS47aGBXFu4EIhPRMhyzmlLuJY6ocCc65yBWogtLs3tHd41+ooJNbsPz3VZj8+mHx6C
 zYyvyl5x/kU+3MxPQss4AQMagqzFv6IFG5tCVroUWY6aZrXVm2S/URLzzjPM6lQFKhdi
 cZ1A==
X-Gm-Message-State: AOJu0YyJ2wjx7dQvmOaKStcsMV/7ItYhzy20j0NNBBx4ffHVvdVUFx+p
 acbGDuWGHeeaiQVJXBqnkxqWmlUztXUQxmptj3kMRtg+WN5tw7/IPb9qaUL8P6ltTalwVrHICD+
 v
X-Google-Smtp-Source: AGHT+IF3+TrYDQB/HGBdUgAY0a4SkjRnZOpIq4o58FfxZi9v6xkn4arFEqTYKjuksDlmVDxGv9BJwg==
X-Received: by 2002:a5d:4577:0:b0:33e:9116:bef4 with SMTP id
 a23-20020a5d4577000000b0033e9116bef4mr2507240wrc.14.1710515441730; 
 Fri, 15 Mar 2024 08:10:41 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:22 +0000
Subject: [PATCH v2 13/14] qcom_defconfig: enable livetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-13-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=K+hGLekjLNLv+gZXUcwWJjU4qq1J3VQmPrhkKGcSqhI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKU9E5ry9df6YZP58I6kfH2bvS/L16RCotNq6lLs6z
 DKwZcrrjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRJ0yMDLMmcHlzrp3lc/Ds
 oZ8z7d9Jzll26s6+Bkm+D+0m/1q/ffNj+J/Ys5754dZTn6wNeAP9vjZuaFVoC21b6H/z54mSmqf
 Ox/MA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Qualcomm FDTs are on the larger size, and with the addition of DT
modifications during board_init() it makes sense to enable OF_LIVE
globally. The cost of building the tree should be offset by the
increased efficiency at which we can walk it.

Some rough measurements with CONFIG_BOOTSTAGE suggests that this might
add 0.1-0.2ms to the boot-to-console time. However the reset-to-reset
timer difference is in the range of 0.5ms so this could just be noise.

Suffice to say, no significant slow down.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index cbc612b44bd9..eebd0d74bd51 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -25,8 +25,11 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
+CONFIG_OF_LIVE=y
+# CONFIG_NET is not set
+# CONFIG_OFNODE_MULTI_TREE is not set
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y

-- 
2.44.0

