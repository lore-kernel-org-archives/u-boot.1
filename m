Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC3CC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 13:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 854CD87773;
	Mon, 11 Dec 2023 14:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devialet.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=devialet.com header.i=@devialet.com header.b="ZG92Dsrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC1D18761C; Mon, 11 Dec 2023 11:06:48 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E00C3876B6
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 11:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devialet.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nicolas.heemeryck@devialet.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c9ba170c89so14326941fa.0
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 02:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=devialet.com; s=google; t=1702289190; x=1702893990; darn=lists.denx.de;
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+gMFKjR+CavV994muLxP0+51mO6c4Bz+bePyXvOAnKc=;
 b=ZG92Dsrld1T7xKa+Fp1n2KpP53BXAv2o2QTHp3MQ79zOsVHteMGHzptF7Y2/V5ga8L
 nP5yp/6vWbPPEw0wMgV808ih4a95+1A8W03D09/yhOcYxxdLru1b/L7GGsleuCj84WL4
 bvHigVkzYP0B8QEy0zXzWMhKLT9Yiw5AYAWXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702289190; x=1702893990;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gMFKjR+CavV994muLxP0+51mO6c4Bz+bePyXvOAnKc=;
 b=HZtY2FQ9T3gzqMegMYMCL3fUXMhHypSiwSwCOyE7FbnaTGTjzdmSjSeYbV/NA8tbG/
 1IA6Cl41ImzZZRCLIRSwDb+TBJOEoO9ILqAvuEWWgnyeQQRha3PVwO4rjBKRY4MzQ0Cn
 ijwaRuTCWYt/hfqv2srONBb9qqJ7ySVo8xYSyp+M8raNsPmCMBMcwnIGyKjrBVqOh3Ux
 L8bLMmjSTGqfqwt34wEcGnSDEvWwBGowyjcvAi5JU5La4LY2wh3MxTm9TpcT+vVSlL2n
 0QB6Ujb44E9ZQLFvza1gOWfDTTmIv8c1UuMUdTtuCoEyICaHbkYx7fjbmv3g6yRAwnSH
 F9/g==
X-Gm-Message-State: AOJu0Yxpa3o/vg5PJleHyUpcwi8SCvxYBOAFSah9MeUdxBOMgkDPc522
 Pkf+nCNh/PUERZ+BszrM6eoocrf4UoT2mZrcRsQw6G8YAbtQXCNFH5j7yNZDP/nNtPepz/Vfm7G
 bqeYQlQPHIH+WMl5iAA/Q6lGNB26ICfxkJSGxrCe3hQYHlxbhXMYvykcU+2d60qtDz3K3eZVXI4
 YcUV5/2wzVcWQ=
X-Google-Smtp-Source: AGHT+IHf8saLuAGktTrb3mSfNSs7h5fhOxHwwgTZmu2EkNH3zjhtq+Shjawxld/+JCkfmxs2HZ0ZTg==
X-Received: by 2002:a2e:b750:0:b0:2ca:2db:23fa with SMTP id
 k16-20020a2eb750000000b002ca02db23famr3203019ljo.5.1702289190392; 
 Mon, 11 Dec 2023 02:06:30 -0800 (PST)
Received: from nicolas-laptop.. ([2a01:e0a:297:6e80:8c1:cec5:e3b7:94b1])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b0040c31bb66dcsm12173591wmq.20.2023.12.11.02.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 02:06:30 -0800 (PST)
From: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
Subject: [PATCH 0/1] Add PWM clock support for imx8mn.
Date: Mon, 11 Dec 2023 11:06:12 +0100
Message-Id: <20231211100613.46650-1-nicolas.heemeryck@devialet.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Mailman-Approved-At: Mon, 11 Dec 2023 14:47:26 +0100
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

This patch intends to bring PWM clock support on imx8mn based on the
Linux kernel and other imx8m.


Nicolas Heemeryck (1):
  clk: imx8mn: add pwm clocks

 drivers/clk/imx/clk-imx8mn.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.34.1


-- 
- Confidential -
