Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A197CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEA384859;
	Thu, 28 May 2026 19:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sc2vce3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D57847C4; Thu, 28 May 2026 19:11:15 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4AE98341A
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso11036793a34.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988271; x=1780593071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SK2R0QOmRQQRlXGtA1ePpBAMVcC75WrmGw3iYFBs5o=;
 b=Sc2vce3lNBVtPjSm8EBu//ZXmIp2SC/EiuOkcZ5oCy8sD3qoHLjZ+jqJUz8xP6rGeS
 hDGnLORCSf04YHKrdoOejqJHBHuABmqMwBL7NHGo4wsTh2Nh+OqKNS9LP1jMF9VapxxK
 IgSk4X5pjebNoTOJRvLR/ySlF9csDVr4g/J1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988271; x=1780593071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0SK2R0QOmRQQRlXGtA1ePpBAMVcC75WrmGw3iYFBs5o=;
 b=B30BzbGYf9FsevZIGdQZ9LCMizFETc8/mOuyGB1EtTI4W7pRwTR1iaWP31Jl8fOXmK
 4xPQzit2VNiTusm12ZApo1gWC0/KhsFMGX55A8w75YchBmQNz06WzOiISLP+lIQlOc+2
 a64Xlh+ZnHpCB1jOGW6LAiTHGTef9feb8EyF/ajCDjJgvCyU9tA+EEuZJ8UTCtLQ9+YE
 RCabl0PsW9oZIVufjjIK7ILTlKndU8E9TRXv2i7IVLzSkqXu9eOxqJV/qayO6umfaHs1
 wd4oLRsJ9zIQVRe4ZWzSGWibVr/+TYTdY6cSnSM4WZ8FLsafjOtot3Ixgn4Bu9gk1Aod
 hkvA==
X-Gm-Message-State: AOJu0YwnoO8a2PSb3stP602ygfl8KZ8uWRlbGcdDiFDi4PSWOAfobMzo
 rBE5N82yx/f3cI/esxjnBhzryvRm4kwXOT4ajWMTb7Q3T2gOAG9PC0wmh0sXVmIhrfUaUKHdZar
 eMU/EEDkm7fo=
X-Gm-Gg: Acq92OHQDj2+6+UInDH7XGcQCIg4fOVB3kM6RN5HuvAFmMhLxk0d6Hcn1Aw69ZgFJib
 w1jqKK8Q/XalVkOlrZBKdvQ/GH40hdTbNFtlIqYCxMGkUxF3+faa3n32DXUnTFJqlk57mEmnVIl
 r1d683SodymWGPqEL8Chca6sgok37VRHrlJDvhp1Q4KXGKUPvcwMJdwFDdpGVxqyk2VG7yvcqii
 xFCxLFJA7baxM12mH3IS+5gUzmBfoafo7ewHTffO6g2WdrK3FI8/Z5OznTlxG6Iq6xru2M2yIt2
 GScEG3cnMdv5+6epapfe39wzP7K2sCMGmW8itxl90hEVTBKwzNL4CkhM7l3Bh7oSLKSLGg6PGXu
 O2Im7fjLSQKScDoujnEtZlWUlx/6G6a3TLGRN/qx67LzQn3x15tugcV7tKiaMwPaRAIJa/WG712
 0q+p9TrJmFmewx4IJv90+D0trE5dRt
X-Received: by 2002:a05:6830:83b0:b0:7e3:fa31:1104 with SMTP id
 46e09a7af769-7e5fef61165mr17375544a34.22.1779988271706; 
 Thu, 28 May 2026 10:11:11 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 08/22] rockchip: Add SPL into the main FIT
Date: Thu, 28 May 2026 11:10:15 -0600
Message-ID: <20260528171043.910264-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

VBE may want to load the SPL image from the same FIT as contains U-Boot,
if there is enough memory, so add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Use FIT_ARCH instead of ARCH

Changes in v2:
- Move VPL things into a separate file

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 475dbc53796..dc1664d7b2d 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -38,3 +38,32 @@
 		};
 	};
 };
+
+&binman {
+	template-1 {
+		images {
+			spl {
+				description = "U-Boot SPL";
+				type = "firmware";
+				os = "u-boot";
+				arch = FIT_ARCH;
+				compression = "lz4";
+				load = <CONFIG_SPL_TEXT_BASE>;
+				entry = <CONFIG_SPL_TEXT_BASE>;
+				phase = "spl";
+				section {
+					compress = "lz4";
+					u-boot-spl-nodtb {
+					};
+					u-boot-spl-bss-pad {
+					};
+				};
+			};
+		};
+		configurations {
+			@config-SEQ {
+				fit,firmware = "atf-1", "u-boot", "spl";
+			};
+		};
+	};
+};
-- 
2.43.0

