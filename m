Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3A0D1AD33
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 09:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A68188E81;
	Wed, 16 Oct 2024 11:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xZixX6Ty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D45188E69; Wed, 16 Oct 2024 11:25:37 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601D788ECC
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43124843b04so37791355e9.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729070735; x=1729675535; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KN+NIntnJ7NJNYG4SzWr5IagW9pyFEVhnSjafdGhiac=;
 b=xZixX6TyWZuwqFYBE9ug9xrMsnjtP2+YFJJ02FhBXKSX6WPfwmx33TQ7u+pXFXEAqR
 miXh0GqA1PccPTxGvGstsYQnycPm7ep8HL9YjBJJE2PUjlaXpPqO7AAs54dfwKUj5mWT
 Tjozi9lvU2pQ0b4WeqtJ2BJjZcOm0Xn110V0R75SNL0DDEIDOlljJRj2PZxMVjLI2kZ/
 ZfQsCOPlJkGOHoeoLiLuoaOH5OQJISSmbkO6DGH1mAr5gnYuJWB85IBnm8NcaDKROqIh
 xz7ougpf5nSyK87Z6TNE/sqJIhxL6E6JzIIELM+/SCszXwEYHEKEkcjdmYEhzNZeAFQs
 FPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729070735; x=1729675535;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KN+NIntnJ7NJNYG4SzWr5IagW9pyFEVhnSjafdGhiac=;
 b=k3VLG4vwMo9Vmunsi9LiiCZDTmI/GakNYI3fIzCYJOgsq27CQNEBEJoaJn0LRJI/vm
 xpBDt046E29xeEtJZkQMGYY86lH0iygTyuwDtLHmVV6ArOhz9GG+zeRpqEwxztTVCsd0
 cii11261c8ZTNDbzephzHjHMGodnwdW7O4yjsaKQ0q32oAgZpemBz6f3ktiWAQwRt2wZ
 bWpP2Jy6nvWUYXOQRdkeZrGtfvfz1URYslEKSARBVqOL+eSCoQ+vJsFifd89Gu/E1Yy7
 fYNJJ6OFjt6T8XgSbgjK/r+Y7QW7jvUEbU8YCeB5WDhFbQbudaS8gmTHpLU6At8HJGGU
 c4/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlMHXI/WcODv4fzb6u5pmKhEa85ZHYuQKO9IwfZxhbI0UV3TvzT4TWoWgvOuLxdkSBiHuI1BA=@lists.denx.de
X-Gm-Message-State: AOJu0YzGrYoiT/LDMbToacTsrnkZczolZxtSszah/gFLBpSCNEhNkrNa
 wypu7jdhXRFs2dh3QTlu8GuRFfORjWGBHcq/90yhxIQyQM33cFqIVVKvPPQk5SI=
X-Google-Smtp-Source: AGHT+IG+CuA+vyU/P+/fQ04QLLJ0rTTbxBp46hwrzDmvWCuVQfsLPkTRTLTPYlhPWbw581mRQWSrsg==
X-Received: by 2002:a05:6000:111:b0:37c:d537:9dc0 with SMTP id
 ffacd0b85a97d-37d551847cfmr11732376f8f.12.1729070734785; 
 Wed, 16 Oct 2024 02:25:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43150469a35sm14997115e9.1.2024.10.16.02.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 02:25:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 16 Oct 2024 11:25:32 +0200
Subject: [PATCH] ARM: mach-snapdragon: configure a larger default
 SYS_MALLOC_LEN for fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-topic-sm8x50-bigger-malloc-len-v1-1-361b132ce7d4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIuGD2cC/x3NTQqEMAxA4atI1gYaqT8zV5FZ1BproLbSDiKId
 7e4/DbvXZA5CWf4VhckPiRLDAVUV2BXExyjzMXQqEaTog7/cReLeRvOVuEkznHCzXgfLXoO+CG
 a2HRG6X6BEtkTL3K+g/F33w9E8/yxcAAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=945;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Mjv5xc2PH8Z3Q++ru+s7oDgKTJNheGgC/rKJaaJSfrc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnD4aNFG8eR7GAZBJ2PxvORLrqUPSBt4Zivz0ggCun
 lvjq+neJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw+GjQAKCRB33NvayMhJ0Y7LEA
 CPrVa+eT3JPIHpVXGw0mrFB/fu3SsRE4/giJvd2sPOmRjxQ3dZFRUrnTZm+GIueTISYBXP0k9zlhxs
 ZvK0EHDj3f0em3O4zL7GgrkPC8KRzVIIv8UrrVdaR4t5erjRqSDpD3OOYmddzR33BkL13UajC1OT3j
 0dyPl3UB4Q+BGMJhvN90WPXqLmVQDY67gk0wL/XzgsctQ2rBLjMV5MbOhX+ER1NLdEIqIzeG9Jzmzx
 SOyS1OvM6VyoaO98ah6wxdzWsLQUY6h4cSBqjnUAimsMvpolhvrCGqkgQBvHQKJukXBm+5nbTVhupv
 q1d0vKs8Q8J+UUmmDMgHmBq4IhZHrZzs/P/wo3gsa+yN02wxE4qQO9+5LBFKucwFu9VJyXfW2mqPV9
 ZokS5S/JMifXVYHknCuGubAEB5LcHJr9MMRj6DGdOEjkdwzuiAj2xInr48WI/yz/mpHID+zzaYIXEa
 t7RkeUl09CwV//0rRINWaltu88Yxk47mkdc3p1qVdJkuW68DaSYMAbkY6yda67q55ramkouGTI/PIb
 NXtdzppZQNWjnKM9xBQQkRfYk7pEr+LKwphPg/WyCu6/MrCCXOcIhAEAdbwmqaLAdVfshj0p24/8/v
 e7aEHO7QjME+OZanNlfEElckWbAjMMfQdMZletYsrkSys5mwhY3oBgh5oc3g==
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

Fastboot is very hungry when it flashes larges chunks, and 8MiB
is way too small, allocate a much bigger size like other platforms
using Fastboot.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 536960b83c3..2985d9d3ca4 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -11,6 +11,9 @@ config SYS_VENDOR
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
 	  will be used as the custom board directory.
 
+config SYS_MALLOC_LEN
+	default 0x10000000
+
 config SYS_MALLOC_F_LEN
 	default 0x2000
 

---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241016-topic-sm8x50-bigger-malloc-len-911bea6a047f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

