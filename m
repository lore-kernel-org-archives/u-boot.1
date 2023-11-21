Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D32C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 23:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E9F87635;
	Wed, 22 Nov 2023 00:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="DHy0va+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24C0D842D0; Wed, 22 Nov 2023 00:58:34 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020A38760F
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 00:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32dff08bbdbso4668181f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700611111; x=1701215911;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvhsChdo98FReLSUWqDYmnUwXMi77JOWr8LL7oOHqSk=;
 b=DHy0va+tGpYgyJR1xGFCXE9k9MR7PA0NtNeQoQ9QKSz3htLorUyLokUE7gBDv5n/P9
 3qZFUBLx18NW/F6WfrxD85j8Bd8V67uW1J5yXCLSAxxi2nHs/VoZgRaKWg8cZlI6tutU
 2g5uXBTRC+xcAuTpsUL2JdyI2h34UpScOct6MvOMR5lvnacQm8ULTJYiM4GtuYGfrb5r
 6srHKo1Q+eFwOwBbZj/Yl1CUyWSICUmAgchSCZYUkpecDo76Fco1OS+qhTY71QXT5gww
 Fv500Co4r7v7beffDcGiGf9HSXM4ywS94iwSFHeeXikAFlyewaCJwvS6xAAMIQMm1Fhd
 g2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700611111; x=1701215911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UvhsChdo98FReLSUWqDYmnUwXMi77JOWr8LL7oOHqSk=;
 b=vvINrsG94O+f0NUFLTws+ELsvkXSb1egY2vVRHG6PvW4m8+5qfqPelDvZZZd+o9nni
 CWa1z2RGffNaxFZ5tB28wxPI3P6RGGJbBRbWpzLgCucWNPaVzrwC/3gXz80NYSOKmLng
 Carei2Vu++W5cKAkguUCkJCDv9Nd3YNwLYaDueWa62qtjTihZgdkvcfyJQk4Vo6XGk0Z
 mjeiqXkeZ+FIJ0CHsOEmoZupwmdWmVNY6OTTXPuY9cn6RxwkxXvqB3ITJE9OqW09qFq9
 yF0wT91s+/7gzIcJpfVzOPBOSbjAKDX0Kc81mwmbOdPWXMdHyw/tiyW9epgWqsFIMprI
 wgbw==
X-Gm-Message-State: AOJu0YwiiNPCgjhBFnwM3kN+I8JpPqFfrPUZv69mm9svPg4cPNGtXn5Q
 8qQpejmQvVXXfvJe5IY6bsC7nXw2ZFbsqffYGqH+MA==
X-Google-Smtp-Source: AGHT+IELwKJuUiIB+aXHLQNa43JVsW4eWhRndL4yQH0lwTZ1bY3j4DxXbH5VvY35dZ9JrW52XjRgvw==
X-Received: by 2002:a5d:4c4c:0:b0:32f:b419:6ec2 with SMTP id
 n12-20020a5d4c4c000000b0032fb4196ec2mr314616wrt.34.1700611111160; 
 Tue, 21 Nov 2023 15:58:31 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 d1-20020a5d5381000000b0032f7f4d008dsm15625566wrv.20.2023.11.21.15.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 15:58:29 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Akash Gajjar <akash@openedev.com>, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v1 3/3] defconfig: rockpro64: Enable SF EFI var store
Date: Tue, 21 Nov 2023 23:57:13 +0000
Message-Id: <20231121235614.v1.3.sf_efi_var_store@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121235713.1530289-1-i@shantur.com>
References: <20231121235713.1530289-1-i@shantur.com>
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

RockPro64 uses SPI Flash for storing env, also use it store
EFI variables.

Signed-off-by: Shantur Rathore <i@shantur.com>
---

 configs/rockpro64-rk3399_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index affb6137e0..b9dededc9a 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -8,6 +8,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_EFI_VARIABLE_SF_STORE=y
+CONFIG_EFI_VARIABLE_SF_OFFSET=0x7D0000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-rockpro64"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
-- 
2.40.1

