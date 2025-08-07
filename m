Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E86AC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9062F84494;
	Thu,  7 Aug 2025 10:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eyaa8LtG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4A883AD5; Thu,  7 Aug 2025 09:46:17 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAE683A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-31ec651c2a1so671833a91.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552772; x=1755157572; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ta22rS5KGSdOV+FfcXSPMFOwcs7voqJ6XAGBLUf6WZ8=;
 b=eyaa8LtGA7II56hkHvZXmknju4oTlh+VqWhL+iS0A1Pxx7H7JQLu/aqJq26YcRtKlz
 2rsbNo49B5NUO4y1DROsRs1+gEg+a18QJGSadIJFV+BUUGJlIPvoL+WDI4Ew36tFE2z2
 /ccgQhtxXXKt5EaGqcFy3TVhjXwFQBy0a+gaaMDRol/RKBQTM1j94J2zx+GvpnEDY+Ia
 WRO2kYpuSjI05qe+RzSfo7fL/AjU0+jbfuaHa6z1F41jNoavxqY6yyl0YoUK++kqV0vv
 Rm1bhoHVqDIw5d4nzOaCaIJpO1ygt40T2AlLi1NYfjCQqEEpH+w33KL2UJYmE0Wv58fO
 s0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552772; x=1755157572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ta22rS5KGSdOV+FfcXSPMFOwcs7voqJ6XAGBLUf6WZ8=;
 b=Z1IMN4yVhVnjtfLP+szq12nymAIVZmaJfaNpeMneYf3/v110MIu9s+OfkcoOg7KmRV
 ec6JHn0Kc4DeEeNC2XIKg28ryOB5TmSEA4lgcSkW/xsCiA7WEb3Vzez31ykgYfnlG3Wf
 Gn9iL4FCL2z5oP8lCCCNxnc36enhUfn/3NFsIG3NjX9m15R78xcwgemYJTWt9oAwHVgn
 KcRu1dQEL+P2+iQKKn+O65H9SD8CqXvQy76G60jPldn61oYTLC9uAB+7VRNzpTWieaGL
 wN0KkY4+uSIZJd1fVBvq+a93vy9urvT4EPOqoj+LsVgKXbGmGAQ74mgPw0VDZ6+8Fx1x
 0fVQ==
X-Gm-Message-State: AOJu0Ywjepmc8hjkXL4U/aO7DprPC4Jbd8hoEBK6zs87ZJV2MMNuyd5i
 VDYOpc5YCK/D24ATGxS4n5lejrR7SYMFHEo3jOJ+ENqmuYZ66kVhC7oVFouPmR9o
X-Gm-Gg: ASbGncs1N40p+Z0pJG2HIY7Y2jrTQOgxAy1njcKF2i9yTQRAgUMj0dsYV1modL2vcxZ
 IPvWaWTlTOtGfdAAblWwWva9WkKt6t41y9LyY/Or4414v6QWiljsoFhvqSoYeOzl7evZqm0kzeH
 b8rQc+eT2LXJfB6+nMTiKBCgIrlHgnWT+i21tKXrLFhCwFDjhGs9BipQ+p0kG656hJuWnR2Gup8
 YNQEL5LpeFn+dgEfwaBJIjL5y/9rU+JTFJG8XcYTI9xw0isI+AfWV+0fIhnixwhFwhPBW5tV0wz
 LF578xXh59rQNxuH7Flc4dGdBpVP8LdDysQ3ug9TQxRmae8nY9LKMkDx8PbmqLb2uKUYlPfyqZr
 H2G3Ox8sv/cSFSSIWKug0oYEfWfBU3d3Zc3OK
X-Google-Smtp-Source: AGHT+IGq/s/hDPB2KuBXejvU8BOGT1oAKlqLH4ouurcGy0rqbCvbUzoQeZPWHra1gjgPli2VEzfzUA==
X-Received: by 2002:a17:90b:28c6:b0:311:ea13:2e61 with SMTP id
 98e67ed59e1d1-32167578960mr7239083a91.34.1754552772373; 
 Thu, 07 Aug 2025 00:46:12 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:46:11 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 05/10] clk: rockchip: rk3368: Adjust pll clk get
Date: Thu,  7 Aug 2025 15:44:13 +0800
Message-Id: <20250807074419.336752-6-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Patch get form Rockchip downstream uboot repository.

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 drivers/clk/rockchip/clk_rk3368.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index aba7f2cd47..2a20c8b50f 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -534,11 +534,13 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 
 	debug("%s: id %ld\n", __func__, clk->id);
 	switch (clk->id) {
+	case PLL_APLLB:
+	case PLL_APLLL:
+	case PLL_DPLL:
 	case PLL_CPLL:
-		rate = rkclk_pll_get_rate(priv->cru, CPLL);
-		break;
 	case PLL_GPLL:
-		rate = rkclk_pll_get_rate(priv->cru, GPLL);
+	case PLL_NPLL:
+		rate = rkclk_pll_get_rate(priv->cru, clk->id - 1);
 		break;
 	case SCLK_SPI0 ... SCLK_SPI2:
 		rate = rk3368_spi_get_clk(priv->cru, clk->id);
-- 
2.39.5

