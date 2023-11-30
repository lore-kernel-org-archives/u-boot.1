Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A681C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1042876BD;
	Thu, 30 Nov 2023 15:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m8tkp5fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B6EC8768A; Thu, 30 Nov 2023 15:40:45 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C51A876A8
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a00a9c6f283so146180966b.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 06:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1701355242; x=1701960042;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJf5mHPlhnOmzg+lkJJXHrUWrAapNUPp+/I6FVPwS4Y=;
 b=m8tkp5fvtmc43bEwKJKOMCm3pc6rwLLQxbczcomp9iarz6gWNpJi76Opik9mLuCS/P
 /S/byH/lBra/kLoolQ1qOmTJP/ro5fWIdnwW++Qls2jR9E00mZvXFe3rfHHlfASW0LzA
 gxNftzZN7Mejv3fheY/sScIykQZ7/RFV7CgO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701355242; x=1701960042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJf5mHPlhnOmzg+lkJJXHrUWrAapNUPp+/I6FVPwS4Y=;
 b=bFql/Qj9ajQzNFVMUV+wtrK0KSd+2Flsn6Mv2kjfA74Sl19p7mi8vOZFTNEw+XEcvW
 x2OtfXvIG+kOj6D8kZuop3pQhQzh5Jox9vomLjUTF26vSXniT9MpYGHJo0SRi2liylm7
 ed+wqQMhQv8NzUzcQP+rwHPys2xgDe3FMT3eJXh7liuaQJuIcXHA9+Dv2dNhVKX/5TJ7
 x7nx7xLMGeaP64rg99V1EdRXT0XMYvkIDwR+76lx7cGk4M+InPZNF9SM4I3Bhsdweksi
 JXK/9hO/+rY+Ozt02+RTosxCgSwXHAPZzYWutEBr3tEmt6yBdTnPUkJZcPX1voIYq0UF
 fZcw==
X-Gm-Message-State: AOJu0YyA5iTKlcnYewRvXMtFDdgwvgKjciWntZ43h5mwIBf4cYnUof6m
 sdizc06/1+btjIa4tRGgahOWFegLMyLwzwOKNbLHPA==
X-Google-Smtp-Source: AGHT+IGUPOBJfuvQbUjMYV5306BpwsYU58Tx+lQuNj6CTgJ18BY6A7ryEMRRbyK8AVxX5vILAivGJA==
X-Received: by 2002:a17:906:bc8a:b0:9b2:d554:da0e with SMTP id
 lv10-20020a170906bc8a00b009b2d554da0emr15166130ejb.69.1701355241693; 
 Thu, 30 Nov 2023 06:40:41 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:d1eb:b106:516d:db0a])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a1709064a9500b00a18399ff790sm733470eju.215.2023.11.30.06.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 06:40:41 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [RESEND RFC PATCH v2 2/5] ARM: dts: stm32: make the LTDC clock usable
 by the clock driver
Date: Thu, 30 Nov 2023 15:40:03 +0100
Message-ID: <20231130144033.1850298-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130144033.1850298-1-dario.binacchi@amarulasolutions.com>
References: <20231130144033.1850298-1-dario.binacchi@amarulasolutions.com>
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

As described in [1], the "clocks" property contains "a phandle to the
clock device node, an index selecting between gated clocks (0) and other
clocks (1), and an index specifying the clock to use." The current version
of the clock driver, unlike the kernel, is currently able to properly
handle nodes with "clocks" properties with an index set to 0.

This patch is preparatory for future developments that require the use
of the LTDC clock.

[1] Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag.

 arch/arm/dts/stm32f469-disco-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
index c07e2022e4a8..dcc70369cd0d 100644
--- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
@@ -134,6 +134,10 @@
 	bootph-all;
 };
 
+&ltdc {
+	clocks = <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
+};
+
 &pinctrl {
 	bootph-all;
 
-- 
2.43.0

