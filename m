Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA39C52D6F
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 15:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414B188D02;
	Mon, 19 Aug 2024 17:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/AkHVwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8118A88CEC; Mon, 19 Aug 2024 17:02:09 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118248641A
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-27012aa4a74so1804278fac.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724079726; x=1724684526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvwJElt4YUfFpBwvQE1FxCIY+djXkU5S5UfwCL3zens=;
 b=Y/AkHVwjcvGGJKGJmB+3QDvpfCgdPLzXPRjhd2ysE1pKK/bcUf4bRezsvJkNTXQxjC
 +XnLkZa1bPuLw5BTLAQ1qJr/NB0i9ls3A3oUhR4NKCfzA6qN6yBaOWBaiQAlptN4armk
 0stpImgiUBkSpAu9D9FVe7IbkIMnp+0xXEAhCnALibmdxboSFqrPjQYaiZLIGeWKqHjK
 YyFqWhZqztQLtGNUqiCvLgN+Nk7iB6kUunD50LvX1hJfkFa1FHOvoabapZY92AnYBHm+
 +OyJEjQlVtbO7A23GK/mYiFT/j0VBJUjaIm3f+dpRKSxcPJr011tgokNyogWotM9lrhj
 WNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724079726; x=1724684526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvwJElt4YUfFpBwvQE1FxCIY+djXkU5S5UfwCL3zens=;
 b=R6bK8T6/2UJ4pShQWeX2liVovDfjy8eqCb2euJzUaENTvfd7QKQnH/R5EEnzYtO00k
 Zb93RLcy9+t/l7MIjfSBIdQpMYvaw0gd8Bx4LBjut6U9bBvne++XE5BoqtgXntcR6uR0
 HePqZvCRLV8uiMxL0+f57dE0A/pupnNq1i9K/J9o0MFsitgIJzd8hcozm/ZUWMzz0Luh
 wq4niu8+A0C2KD5iUMnAexLDn2Fj5HuZMBvCbGZ5T+2HdOPG2e3LBNrjTELmHevgTBs+
 iXAU7nJWAZd6zK+nVyLGMfR4oGY2pw6rrcbdydQKXeyW8k7tr843eupW4HibdEC90A+C
 9N3Q==
X-Gm-Message-State: AOJu0YyOjcgr9UPytZ5NplgJqbhg7fCVDANhOMUO5m0S/Oi65/NlJDr4
 63euW2O2eSgmPhmOKnLWNFPmFtKmEwf6x3H1GcHeOhC+3CQBcwsXnZDcJQ==
X-Google-Smtp-Source: AGHT+IHnTA6//OhariupgMVxqPieNyMDOoc9ieVCe6eN2SSk5WYUpdoMAWgrW21qMgEzRePZWlkAFg==
X-Received: by 2002:a05:6870:232a:b0:268:b62c:d084 with SMTP id
 586e51a60fabf-2701c33fb5dmr12971773fac.10.1724079725573; 
 Mon, 19 Aug 2024 08:02:05 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-27004432d18sm2945189fac.7.2024.08.19.08.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 08:02:05 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com, iuncuim@gmail.com,
 sumit.garg@linaro.org, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 6/9] arm64: dts: allwinner: h616: Add r_i2c pinctrl nodes
Date: Mon, 19 Aug 2024 09:59:35 -0500
Message-Id: <20240819145938.503221-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819145938.503221-1-macroalpha82@gmail.com>
References: <20240819145938.503221-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add pinctrl nodes for the r_i2c node. Without the pinmux defined the
r_i2c bus may fail to work, possibly if the bootloader uses rsb mode
for the PMIC.

Link: https://lore.kernel.org/linux-sunxi/172252952262.1669767.7675865282122079154.b4-ty@csie.org/

[ upstream commit: 7c9ea4ab76176f65f4f55aa144f9145a4bccaacb ]

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
index 921d5f61d8..41f2c23e07 100644
--- a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
+++ b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
@@ -836,6 +836,8 @@
 			clocks = <&r_ccu CLK_R_APB2_I2C>;
 			dmas = <&dma 48>, <&dma 48>;
 			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
 			resets = <&r_ccu RST_R_APB2_I2C>;
 			status = "disabled";
 			#address-cells = <1>;
-- 
2.34.1

