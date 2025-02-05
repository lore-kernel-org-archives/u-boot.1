Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C7AC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E6680A2A;
	Wed,  5 Feb 2025 02:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WtJPJLy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A174D807FB; Wed,  5 Feb 2025 02:57:52 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F9A807E4
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5fa8fa48f30so4681792eaf.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720668; x=1739325468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IYPyCD4icVqLSS2O7/dYDHPbnuDx3/KHwKfp1pP/bY=;
 b=WtJPJLy6G04miVHVoXS5XYkOAJAQ86deCro/TnQi++2WGJAlIycdFU/oOiz1crnRU1
 ccnt2V/GBkpbKhvzTRc9ZC36j3cZvjqMeL13GZD77Ur8yxkckWDVQqFsV7u/q7B1NNv8
 BVRtVLZ6lff+HljWUmp1xT/5VQB6KeIBcQMfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720668; x=1739325468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IYPyCD4icVqLSS2O7/dYDHPbnuDx3/KHwKfp1pP/bY=;
 b=Eb6wDz+rJby7sBsYXn6iV0pq2O0/h8Tt8wynxEnJJ4eWrbwPcWsW9yRXse1AYbf8LG
 +Ds76dZiMw8Lb8ezhdycAM3cIrDl6XHrsk7lhBy2ctT8B0zU0ywNiAaYTVMCyxAVzhjz
 yHveJ1rqILHKDuIuu9oX8LIPoGZ5gyhSVLKes9pfeE+Q0TK1eWkIJEsgbQbnt+dshTZn
 EvI75OUw5cD2xRktJ90YZKe6bWiZv6qj/P+VwiisGhamlNviM5mheENNAxe/0dygnrrd
 asx6uOCt+3345wwbbACprpKqDiKWqfAMFb+F2KH28hyuEDzj9K/ty0LE1PQiiKj38jAI
 EkHA==
X-Gm-Message-State: AOJu0YyilyAG0bWrmAOof4146GMduBMNFoVojPDsBOu+4uvDIsySgzR7
 KprzktbwTKkzDTlQc01HWRc8pxEcPXSvLdKq/Lq3lwXTVRuyWu9iwzZcbncSbSEQNEdAg1z2v88
 =
X-Gm-Gg: ASbGncsNdqvAIcstd80E/8EIkT2O1tOzUTGSwVOhXzj5UlJV+51SPVBBcZceqO8urmf
 +SSMnbmOTS381RNvQEpKpYeD0X2CLAeRYpKKoHKcjgGMr7vg+8JqEUt1CnOIo4SoaeFSat8DRWS
 n5O/vKzomG5iy7onPcrjtRebbRg3fNkm+5isPaPS/utIKZLpY6Jv4iK3+zCS7BtGB6D4k2KKFiV
 G30oFqgqqbPdR0a8WtUFuBFWWjpDiK1jVePa1wXrKV378w2Ih+Kuu/GbLqhey1gm1HuJadgImP9
 /Y3BW8Wj8ey2l1iR5WobQrJvXTczMUViJl+GTGuJcn3T2XQ99a0u
X-Google-Smtp-Source: AGHT+IENR6vVajoSQibZsDw6Y398zlMp6lNuMujNE2VyEHhharZXEwtvV/Fr0PEq+G/0BaSVU3w4Lg==
X-Received: by 2002:a05:6820:1b07:b0:5fa:8494:f25d with SMTP id
 006d021491bc7-5fc47a4dd64mr815425eaf.8.1738720668487; 
 Tue, 04 Feb 2025 17:57:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heiko Stuebner <heiko@sntech.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sebastian Kropatsch <seb-dev@mail.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 26/29] rockchip: Add documentation for VBE
Date: Tue,  4 Feb 2025 18:55:16 -0700
Message-ID: <20250205015606.2686149-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Now that VBE is running at a basic level on rk3399, add mention of it in
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/board/rockchip/rockchip.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9bab86d2347..97c2bf04b6d 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -487,6 +487,19 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
+Verified Boot for Embedded (VBE)
+--------------------------------
+
+VBE is supported on rk3399 at present, with SDRAM being set up in SPL. The full
+A/B/recovery flow is supported in U-Boot.
+
+To build this, use the rk3399-generic board, setting CONFIG_OF_LIST to the list
+of boards you want to support. All boards must use the same SDRAM type.
+
+VBE uses internal SRAM (IRAM) for the TPL, VPL and early SPL phases. The stack
+stop is near the top of this (0xff8eff00) with the 256-byte bloblist immediately
+following.
+
 TODO
 ----
 
-- 
2.43.0

