Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73B6CD128D
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 17:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3317388254;
	Fri, 29 Mar 2024 18:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ip3jsFjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D18880A1; Fri, 29 Mar 2024 18:51:57 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F84B8824A
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 18:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d47a92cfefso26051301fa.1
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711734715; x=1712339515; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NPyKR8c+HUGd7Kj901YcjRNsUpk2pLmpbpRUS6I1Fs4=;
 b=Ip3jsFjC7ttOQ/b4EHBAziIsdVULxyEwHEyvOD3T8/ngCTdH7FIxFgZpTiCpN64jOo
 HdkJQUz9WfSvTOo3K7lCGG4vTZ3c/QcKamUE+9UIEOZD8+dWh8R2dhVeN1BvUcznFBZ7
 IkRqbrjqb6aKPri7uB3dgHlc1Wfc9i3aBsFzzjeWvb8HOi2Tj5+wRANkgJASTmbhcpPE
 mdkJ5nRd/CD32dOUk4zXPnY7I0C2k83IgP4vL3r4HwbATPKxOpfa5KPauUwhPfceM9Ja
 En/TZ5lwqK5qTs6DoW/wEZReTX+3d1/xAQT8evDjx7eaGLVnKetDwiY6k3VORc3rniQF
 Hiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711734715; x=1712339515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPyKR8c+HUGd7Kj901YcjRNsUpk2pLmpbpRUS6I1Fs4=;
 b=Gw5XHwadNTKhNJYrdX37pJgaD54/VQ+3UjRdFXqyQkbhjn8hI3xilT/QrOGp2zYq4C
 4L8GQtdRjD0uN4GgrfJjJsuXo3T6u/rYVFo6KSQuq5jjLLWUWZlqIXESOtixh6Aw4juG
 vJhakSs80KLiMQnNrumWXqj3s0lBxO8Y+khmuc0i+o+XYfkHgwp67V/yJDq93QK+RVOA
 v0DI6NBLdKxyMWa0jgcsnWNZMiy7Kh8dOqNa/YjzBkctIpR0cvmJ0Sri4b+SenNR+S44
 vSuU46vua1kZzaWr9Ul6EuRq/6dNLPKE93s5/xv+yQIqAfU0X29dzIg1EG+hTZyL1L0+
 zdDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFnZVB6TL+YWeGpHUUHtVMxvX6ut72chKoyfgtuFe7yB5uKf5qw5hsYZe0JA94LjMGznmJ0Ma36u4v8HiWL42ixBzo1Q==
X-Gm-Message-State: AOJu0YzfjELOMWWqAGX37JLowQpP1EZ5YI8AzpXpGp36nh4hldDM0hRV
 cRIYeYjSlUBMWe0GZfpbyAvqotkK+LZ2FvGBhvMPb+7CjN5m7vDagVY6G7oiC8A=
X-Google-Smtp-Source: AGHT+IHda5KRDcIgbWGgiYkYmU4Mq4v/hgUUv1mVABwTqPdTmQu4D/HkT59pIJ0ndW+FJDHTRyxB3w==
X-Received: by 2002:a05:651c:104:b0:2d7:3c2:ef4b with SMTP id
 a4-20020a05651c010400b002d703c2ef4bmr1458172ljb.26.1711734714786; 
 Fri, 29 Mar 2024 10:51:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a05600c3ac700b00415509b33c0sm2127781wms.10.2024.03.29.10.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 10:51:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 Mar 2024 18:51:48 +0100
Subject: [PATCH v2 1/5] configs: meson64: remove amlogic prefix in fdtfile
 when CONFIG_OF_UPSTREAM is selected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-u-boot-of-upstream-v2-1-2512ad3eb63d@linaro.org>
References: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
In-Reply-To: <20240329-u-boot-of-upstream-v2-0-2512ad3eb63d@linaro.org>
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OiGcdP/E7JFCNo2hlX3NguWrFUlUUO8UFZQtO3H7QGw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmBv+2yPFsmFhev0pPFOcV9ZVH7Bc7O2OhuuQc83r2
 WVObhHWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZgb/tgAKCRB33NvayMhJ0VChD/
 9arAZCfqUHs84bfiXwuUWWObnocgxbGCSsm/NYMvvFYRXBV48kJbichYfscuihsgh7UuXW9O7G4FxX
 VzPHPZhGeaIcoQ9StxqkqzGOivEDNZ0rQhJax8JN7GFqVaz+Ewsc5Kd/i99AFqVG21MJkodl0HBAPJ
 Cx8W0p7Th1ZRBkCgVcZ8Bpk6xwFRc3R7ET3GhmU6u0BmXsEltaaL0l3qGk3Ur14DKjvT3TaTVERou8
 dWv5cv9brb35eHv5ef9uwJVxbs1JQiCPyNGXr6Uxsw3Ee3c+Pc0A/KgFpbCxJD7VpiO9jsd3RM0mge
 UhSqQXRgZSjfR6XzPHGYNN98rNKJwm5d8rLHNTe6MKUBmFqyVq4PL2W6IcNfZuK1luO0uV1VxqO9dd
 ERrhXzSHbScuaEfR9OzPPVXWjNXiUgKmeI0o2bas/HBTFI/zpUZKc6Af118MHAwlLTmhDYMHQKMj7Y
 U6fWLtOgdzIuYTj/PrNVomuFMJnkjinJRGGGsL0NrH9LExy+UAt0jAcGeQTBn9mXSNFRm/GEnkWDDt
 +bV9NOAtr3Jg/eUouRR9nbcUVIhQXHWgpC8wFPinFqAOBvx5oxAexUUFvX9GsYScRVi92KipVfhQBA
 g3og2a4nFGVzPwhgpoMeb+ls6xC8y1R6uMWngwQBK469VVPBAEAKQWThQs9w==
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

Remove amlogic/ path prefix in CFG_EXTRA_ENV_SETTINGS fdtfile when
using CONFIG_OF_UPSTREAM, otherwise amlogic/ is added twice.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/configs/meson64.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/configs/meson64.h b/include/configs/meson64.h
index efab9a624d..65fa5f3d6d 100644
--- a/include/configs/meson64.h
+++ b/include/configs/meson64.h
@@ -120,6 +120,12 @@
 
 #include <config_distro_bootcmd.h>
 
+#ifdef CONFIG_OF_UPSTREAM
+#define FDTFILE_NAME		CONFIG_DEFAULT_DEVICE_TREE ".dtb"
+#else
+#define FDTFILE_NAME		"amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
+#endif
+
 #ifndef CFG_EXTRA_ENV_SETTINGS
 #define CFG_EXTRA_ENV_SETTINGS \
 	"stdin=" STDIN_CFG "\0" \
@@ -133,7 +139,7 @@
 	"pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
 	"fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
 	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
-	"fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
+	"fdtfile=" FDTFILE_NAME "\0" \
 	"dfu_alt_info=fitimage ram " KERNEL_ADDR_R " 0x4000000 \0" \
 	BOOTENV
 #endif

-- 
2.34.1

