Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5B4C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F02782C38;
	Thu, 15 May 2025 16:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nlk1o0/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D3982BF3; Thu, 15 May 2025 16:55:59 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E05082C2B
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so4583065e9.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747320956; x=1747925756;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwN75m+sVnVmVKY2ow8k0Z1tOZJQ++TuOYhd9r7fe/I=;
 b=nlk1o0/h8kiw5vjzyh/Zg6cbaAdptg8mN4PJz4H0JGpSNyKDuT+ZEXqCbM1Vs6f4Vn
 cvMBKWTrSqdlRR/m7DLT/UL3KOWdI4Fm3PrDc8Qfym0KTZxhNKUM+xhk5FKhPgw/VPjt
 EsB60pR7mA0H7uVDI+vJl2BIYekydGo8RcjoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747320956; x=1747925756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwN75m+sVnVmVKY2ow8k0Z1tOZJQ++TuOYhd9r7fe/I=;
 b=odDfOcTdAdgWYRjXzvkzo978R+WUZwkmlke70b1HXFFR9PrRn622XoewQFv3J3evmR
 ev116g/X/s68LYoEqmMh7mQN1Uvp2yDG8XFzdphyr5zcNYRoqdauwcgyhxFZw8Z6C6Fa
 8qDMFHmKVK02ukFPr3sW54ZOavIOleGTQ7ju1uBKvG06o4FEfc2S8tuyH0/U6eI7L2wC
 ghpkDjuKBLDu6tdXMAugjrkJg8Rk/Oj6qOnlvpUp6rYLlXnPGIpKGiCjux3dnEzgKEKB
 q4LR7MiaRgj/FDAg+UVUZ0xl+1cFzJHdRRI0Gm6JU1V9l9YZbcZyJiGMl5iPiUuXBkdR
 nQZw==
X-Gm-Message-State: AOJu0YwvjYRJO86xATtap5lPb+76KlQ/z3arfmWocZ7D7D9mMqj+S+5z
 /JE0tYHW5yiSJbBrsb+pTqPo+QjD1wIDy+CVdm8AxLsGaoa96mCBSxNjV+N56t3mNQM1U5bEAB8
 N2QVKG0iQnw==
X-Gm-Gg: ASbGnct6fbMQcPqG8rBOIcFztLS89A+d86gM0mdO2wUyA/H28B1Hs5+wJlsMMl0ecOq
 ejW3xz0nyHlMjL11Al8tjXP5ui88y87tddm9g37XGCQIwYftxxawKEb7wqCX8lDJ2kWMbAkSW3I
 PDWsP3ZzdC7ZlSVdehtPWtNCffb5zIxfNUoXInaAVK+Y1of+0jQvchqn6z/QN5jb14y7YPMse3R
 9ZuJG3zm6NcPjAyXl4g2UpY+6JgQwYdkE9TOkse6CyovpulDcwCEUaYrNl2TdxvWLvE2Kn4qqpF
 DKqo/TwM425WTCC7E4DXErk8TZUpv+IRSy2d9mjrVXa+AcRkOX3tExM7iNZ6aYXGhYZCfppNzrU
 Ni2avWFOoeRjoqpzS+FNAo75rsTO5wb6xY83Uo6E7QSg=
X-Google-Smtp-Source: AGHT+IEb+ZUT8p26OL9w6vtmmHWqAw5gGhhVAO/dpoO8nWNQVqDJoBs43u5eZjOVyzEru3SWBXhFPw==
X-Received: by 2002:a05:6000:40cc:b0:3a0:bdeb:c48c with SMTP id
 ffacd0b85a97d-3a35c845faemr52208f8f.34.1747320956524; 
 Thu, 15 May 2025 07:55:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.client.m3-hotspots.de
 ([46.189.28.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3369138sm77030235e9.8.2025.05.15.07.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 07:55:56 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v2 3/4] configs: imx8mn_bsh_smm_s2: load U-Boot from raw
 NAND
Date: Thu, 15 May 2025 16:55:36 +0200
Message-ID: <20250515145541.886857-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
References: <20250515145541.886857-1-dario.binacchi@amarulasolutions.com>
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

Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options") breaks
the boot of the BSH SMM S2 board. Add options to load U-Boot from raw NAND
sector.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Drop CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR.
- Add CONFIG_SPL_NAND_RAW_U_BOOT_USE_SECTOR and
  CONFIG_SPL_NAND_RAW_U_BOOT_SECTOR options.

 configs/imx8mn_bsh_smm_s2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 9ffcd3b221c3..1c11d4705419 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -47,6 +47,8 @@ CONFIG_SPL_DMA=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_MTD=y
 CONFIG_SPL_NAND_SUPPORT=y
+CONFIG_SPL_NAND_RAW_U_BOOT_USE_SECTOR=y
+CONFIG_SPL_NAND_RAW_U_BOOT_SECTOR=0x300
 CONFIG_SPL_NAND_BASE=y
 CONFIG_SPL_NAND_IDENT=y
 CONFIG_SPL_POWER=y
-- 
2.43.0

