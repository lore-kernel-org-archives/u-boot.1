Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C1C369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6244582F8E;
	Mon,  7 Apr 2025 19:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DwIa37XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34F282FBE; Mon,  7 Apr 2025 19:00:04 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677E082F65
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso9581480a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045202; x=1744650002; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pCoOZv9or9BzWey4m07vZTF7LsPfdKPsl2USNT1th3s=;
 b=DwIa37XGyk+XG/kN/J0KUOqF5KIZdae5YSfusRg7XE7moNgXpO/hGj5XEQXKUpRRny
 rqQwbOldn+3ql/zVqzcD/SS9oLMprz6tyWiWBWO5uczoYQ30E4JUhyHMSxu1/f9TqKsy
 H+KTmRoroLJs+grZwjsiMriRbFM+W/o4KCjEksr9qvzQwL2ZtyoLlNI/EX+/5TWmuDxD
 B0yq6XkejhUUA0zMOMCgjmjNQDSNEYzGjMoKfTnUxomcekimwSYhWxW8eN2Z2CuRL40O
 OU/GJ6oeOwi+v39O3GYZIs2bSNcISxkaa/0obGroVqvMgAs9dYy+dFCchZv6c2Ocpzp5
 FETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045202; x=1744650002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCoOZv9or9BzWey4m07vZTF7LsPfdKPsl2USNT1th3s=;
 b=PB3Trug6c8RZSBBjNeez8o2MLi9c6gOYLsjAW+wBhyMHf9vh0QPPX3dAe0o7khuxBf
 ZrQTYX7p4dX4dru1Otz3U6V0lBrZonBpRAIEAFLzHvn278BTsHt1QpxIpwcYpEIc+0QG
 bxK5IvaWFcuuOdsAtYAZhSMM+5cvH9GtWtCK9DegpwQoXm2UhiKuJu/K8bfWkBGdDxLI
 VrYMCGzke8veX59vIybuiLGdeYHoGRXr/YhdlJxeb403o7yiblhKHe4+6fkAE4C6/+Eb
 MhmrTzAKoEhN6GvTQ7s+O78l0goQiseBgH+BifWY3jUGUWgW0TYpzPOej0a4lOhUWA+I
 WkCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUzKySSlKlg1FB93m7dWLbdYKBs6PJd0rMLWFVEogVJGchccDMDYkF258NF/7aj/+7aikA1U0=@lists.denx.de
X-Gm-Message-State: AOJu0YzoJKjUWadosMA4/6iUe9oppnRG2Y4/Zvgs+lL4fPG2ptr4RsPR
 tGbX8nu604RLld1ocYVldiij6jGYZxGHMuXZyWoOjUAFS2N1c1sC0HCQpvUfdEw=
X-Gm-Gg: ASbGncu1PUbyTHxdxlOBBhNQeBN8cprMClGKenf0T1JGLPA3+eU46W7I0LGXCUu+qUn
 m4VJMxtq7F3/F3hpdx0x4BDrZopQEOgMypip5buHV+OvJKY9KgKj9m/xZotlJcBTiBCxmGd/GI+
 Q/Fu28Pfct8fQJqMAvRobf1XSfcciv0sOmN/E1fHzkXVWbOU2zWR/ygXbqZteKVB9MoiOGo4I1Y
 +M9KXQ4XajrRcM2DfWevp7XHoebbnicVyoALZYySZItbqA4Bvr7vC88Zemx+l+rP3OrRi3LtXaQ
 n8oTvz4U3Zj3+XVi5W5pyscYqEEWc/tbwnKz/VgI0OndQMgYae4V9tiJKBeevv792s7q
X-Google-Smtp-Source: AGHT+IEBV3f4MQgeK5qQKI6ybziXhW2wWyA1fd3yOGrMZXmReW6k/2icb1BCafTChu7asu8Z+caFzw==
X-Received: by 2002:a17:906:c153:b0:ac7:4f1:65c5 with SMTP id
 a640c23a62f3a-ac7d1b9f1b2mr1176977466b.54.1744045201790; 
 Mon, 07 Apr 2025 10:00:01 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:01 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:28 +0200
Subject: [PATCH 07/13] board: dragonboard410c: Use dynamically allocated
 load addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-7-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

The generic Qualcomm board code allocates addresses for loading the kernel,
ramdisk, DT, fastboot etc. This also happens on the DB410c and already
overrides these definitions defined in the default env. So let's just drop
the static ones, since the dynamic ones work just fine.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.c   | 2 +-
 board/qualcomm/dragonboard410c/dragonboard410c.env | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 61d68e7f0c6bed16861e6ceaefd2c7dc94807d65..697e3c9b08b5c874912eb66ff4f0b3d32deaae01 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -66,7 +66,7 @@ int misc_init_r(void)
 
 	state = button_get_state(btn);
 	if (state == BUTTON_ON) {
-		env_set("preboot", "setenv preboot; fastboot 0");
+		env_set("preboot", "setenv preboot; run fastboot");
 		printf("vol_down pressed - Starting fastboot.\n");
 	}
 
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
index eb42c0abcf11fedf7ab86d1340531b4ff5b52bf5..0032dc3592a1021e4bb422357867cc26b4b30551 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.env
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
@@ -1,9 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-loadaddr=0x81000000
 initrd_high=0xffffffffffffffff
-kernel_addr_r=0x81000000
-fdtfile=qcom/apq8016-sbc.dtb
-fdt_addr_r=0x83000000
-ramdisk_addr_r=0x84000000
-scriptaddr=0x90000000
-pxefile_addr_r=0x90100000
+fastboot=fastboot -l $fastboot_addr_r usb 0

-- 
2.47.2

