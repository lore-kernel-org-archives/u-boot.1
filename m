Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19A8C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DB4881A6;
	Thu, 28 Mar 2024 16:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711640078;
	bh=Mv3ImWb/673DzaeGruwLaQ9BcQoZ8rmRlT0cvRzkMVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ick5+1Ujl3gD+tLsbsqFWiGgb9VnU0y966jBagYQbnUQughVlfZQlpOLrDFIRaDiL
	 HLILSZrn2mRFapcAtqMZjYf/fQ+HoeLyX+syEeC5KehK4LGgT4emP2cRqw4wxzPJ06
	 eQI6gihFBRHFDDD8x+YCmDT31TJ655VqELK2TYVqhlsfENsEaaTmk+QH0cYh6lMcTY
	 Ymg0yIqCOFRpEXgatooZBBMWNWGLSy5ARE9nqCjrcKUXk9U1HsMhAAtVJm0ulB5K2b
	 mTtR1tOdmd+nxfXBkLQjztlvUmUIMzmU4SjfDU8ITa4bHqsQhNC0M+2ZwE4yQKZ4vc
	 OIxkBLmsju08A==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DF54388196;
 Thu, 28 Mar 2024 16:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711640077;
 bh=Mv3ImWb/673DzaeGruwLaQ9BcQoZ8rmRlT0cvRzkMVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lxUmsuNjS30Pp+FuHeByAApm15JDedB3/CZNlCUUc+D278RK6POMZGpXsBPxwMyE2
 xvWBFeBZkxrGksRn+K+2CWIBVHYg7mmhujcHbbe0bGv/pCyUcHZL670viXAU45sV0M
 VtS8uYuxHyfKzSMXKAnFZ48UMlvTnS8ple2bIiLMz77prmf3Z1bQ/NQ4+90Oy4ZldH
 zPqc10L6aQhzgWgnoJWdlQSEGJnV0EXRkQAxrawkZuSEQdf8xfDErY8j8KWlGrO7DQ
 ROFG4m1A1tfAYsB/7Ub8syjBP2vy26eufYL1g+dU0OLYU0rrEe4LxKsmztp47TSpPJ
 /yp3Lw44TQydQ==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] arm: spl: xea: Remove I2S pins configuration from early
 initialization
Date: Thu, 28 Mar 2024 16:34:10 +0100
Message-Id: <20240328153415.3706637-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328153415.3706637-1-lukma@denx.de>
References: <20240328153415.3706637-1-lukma@denx.de>
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

XEA is not supporting and using I2S codec, so there is no need to
configure pins for it.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 board/liebherr/xea/spl_xea.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/liebherr/xea/spl_xea.c b/board/liebherr/xea/spl_xea.c
index df354cac64..551ed6fbae 100644
--- a/board/liebherr/xea/spl_xea.c
+++ b/board/liebherr/xea/spl_xea.c
@@ -112,13 +112,6 @@ const iomux_cfg_t iomux_setup[] = {
 	MX28_PAD_I2C0_SCL__I2C0_SCL,
 	MX28_PAD_I2C0_SDA__I2C0_SDA,
 
-	/* I2S Codec */
-	MX28_PAD_SAIF0_BITCLK__SAIF0_BITCLK,
-	MX28_PAD_SAIF0_LRCLK__SAIF0_LRCLK,
-	MX28_PAD_SAIF0_MCLK__SAIF0_MCLK,
-	MX28_PAD_SAIF0_SDATA0__SAIF0_SDATA0,
-	MX28_PAD_SAIF1_SDATA0__SAIF1_SDATA0,
-
 	/* PWR-Hold */
 	MX28_PAD_SPDIF__GPIO_3_27,
 
-- 
2.39.2

