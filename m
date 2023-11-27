Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC57CC07CB1
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFD487763;
	Mon, 27 Nov 2023 14:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jIUsB8u0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBA0C8776D; Mon, 27 Nov 2023 14:01:23 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E918773A
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507962561adso6360728e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090077; x=1701694877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4j6+qpoA6hnnQp3dMONk9xuQKO/Y7fQKEWvrs3eGzk=;
 b=jIUsB8u0Q8NdmNBJAvSsfAuY5uZYHU26R3F+wjctWsuFwquU7p0JIWuucVpo5u8Fwg
 7duGuUmkeQAneECwGHsXuSiaGibNaZQKY5di1l9j4nhuGjOjYr0jMnWb4rAG/y1NZH4B
 pEGAvT7awbOyTFDy5fAjQMEYcDdOFACjjUNWmNGiLSmyfc70NYTuLdrxEuTTayW8+0Dw
 P/cTyeswD4WGPzIKSHpvEnipWtNAzW1gsLPkFra04mIb02ZNjibqMUxjQlSdGn8XrvBa
 JoDCwo2Ut/PYg6b6fz14XtgAihBrtFMfmMZ4t5VxV8dG7umIPKJyILS49a0wSrd1U+ZB
 4EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090077; x=1701694877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4j6+qpoA6hnnQp3dMONk9xuQKO/Y7fQKEWvrs3eGzk=;
 b=CHfLeo/qKVpJLEWP/CoigXp6NikU/HBZwZuvByLRfxq7AFNvUwjRaHanJDIeZ7jIgS
 CzpWn/FSglb5yP0FlFKAQmVCtwv7SNJJiH89hB/1YxSZ7O3eHsVGawLXrWNhHI+3jWz2
 soHhFsjgDrTmhJXr5xVw/AWqdPtKo/yF6ZfLdvjE8wStw2ow/FmkLY2eUAKR22hN7bqA
 URaYLGo8gaUSho5iO4OgElTj+61FSiwOvFe0wIWb637xrfySB/QwK/MyHlMEwuDFXbSA
 rj/lKSrkJrYplPBxo44hInvl+xcLeRcZ6BoxoVgOM3HwdLcQT4vFVVuHXf3ewhu3X/aL
 8bcA==
X-Gm-Message-State: AOJu0YxLGYAET5Ai3xfcN9J10hT2RM06O9UzFZu3HpkPI8dtFzcYm5j3
 RBcdLZ/gBYlXQibLA5hLF3D5l5ouA4fxoGvFCEz5CA==
X-Google-Smtp-Source: AGHT+IFRhRV723LnyfvJLMzTTT46zisP5n4CIc2QYGQ5NNhf4J/2rmPRoFN2+dSMBGkR/AJmC8RJRw==
X-Received: by 2002:a05:6512:2815:b0:50a:a61a:58cc with SMTP id
 cf21-20020a056512281500b0050aa61a58ccmr9937126lfb.55.1701090076710; 
 Mon, 27 Nov 2023 05:01:16 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:16 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 29/43] configs/am335x_boneblack_vboot_defconfig: enable LTO
 and increase SPL size
Date: Mon, 27 Nov 2023 18:57:12 +0600
Message-Id: <20231127125726.3735-30-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Increase allowed binary size to fit lwip code.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/am335x_boneblack_vboot_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/am335x_boneblack_vboot_defconfig
index 531703010a..4f06ed1b76 100644
--- a/configs/am335x_boneblack_vboot_defconfig
+++ b/configs/am335x_boneblack_vboot_defconfig
@@ -94,3 +94,6 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
 CONFIG_LZO=y
+CONFIG_LTO=y
+CONFIG_SPL_MAX_SIZE=0x1c000
+CONFIG_SPL_PAD_TO=0x1c000
-- 
2.30.2

