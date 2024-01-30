Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D6CC47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290F987BEE;
	Tue, 30 Jan 2024 05:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFgcp7EC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7A6E87CC0; Tue, 30 Jan 2024 05:37:41 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C97887BDB
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-68c2f4c3282so27523506d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 20:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706589458; x=1707194258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XIzZ1gT1xffukuXnwslTYmCWc3Ss0ZcYGFNfGhlew4=;
 b=GFgcp7EC4VzJIIV4Wx3EvYf4hlTmcmsnuKXP8X6NRMXwPfNJFSxH4d8v2GQTUaJzGN
 gPvbfH2YQqoNAhSw6r/w9Y1tPUaC601Ya4ot5qcM4yVGXjd7KabwZI0ZzctZTUhLNcGZ
 QGeGnRKaBoiUtRFiyQVmcowtivvn1cT9bCqOHrNY7JLFxwi6hM2Oefm4KfgjZOXFIhAP
 gsXFuZDYsHG2hyJP6yTWKT3ZgDZsIOKt/y1YTbKoFIihrcHLmbuwVzlTgFiXofvdWmBq
 B8vUN8d8aNUsoDqkp7QKM77XUFwNIyzlfhmnxQWZE166WH3w2PRC/P5wj0GUjqvujzQc
 siQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706589458; x=1707194258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8XIzZ1gT1xffukuXnwslTYmCWc3Ss0ZcYGFNfGhlew4=;
 b=QWDpkynbw0ornGLuUy43l38voPrWFX/TlH03RkW/HhbQFwwrMC225S4uz9ZRNLT8Ct
 ko4eVK7+ulhc01MdzW8Klho7cQ1kCZ3gjLjUyM2IZOP8ntgA84mZDLyvKpny1byr11aD
 tr0zRagggGCVQ6ESMQZgtrg/QfBRN6CGVUI8u8WTkuujAG6hFZKNTy4ysAmGPkKk6jYB
 S6x6pwFVUfDQ86pSoM0XpaPl5AFQb6zBQDM7Lm7Okyh23qiBZDWG6EthEZRNvJ/QYi9s
 /JWzY9+1fs2fG03r0Gq0oFLXBb08nzIcL2dUVbYZCjMf3v91qy+Waw9KBIeDcKs11wOS
 ihpA==
X-Gm-Message-State: AOJu0YwRkYhnJ+KfvS2X1WPW4jBH4oG2mOQYxyrAZEnKih/aK3ZtVv6T
 v0Oiv7isWBgjqzl7KYcGS+I7IxVueyNadxxetqaDw1fx4bmxgerV
X-Google-Smtp-Source: AGHT+IGazJXx/uU89mvLrEIUbKw65IbqFggaabT5eaFT6mA1gZX0oLuR7MN3h0yH5Eh0Qtct9FJ67g==
X-Received: by 2002:a05:6214:4008:b0:686:abd6:b3f4 with SMTP id
 kd8-20020a056214400800b00686abd6b3f4mr7285032qvb.50.1706589457975; 
 Mon, 29 Jan 2024 20:37:37 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 pj2-20020a0562144b0200b0068c445b747bsm2650683qvb.59.2024.01.29.20.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 20:37:37 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: neil.armstrong@linaro.org,
	Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
Date: Mon, 29 Jan 2024 23:37:32 -0500
Message-Id: <170658777076.694990.4714326241904351501.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231218-uboot-meson-clk-msr-v3-1-acf4d90ccfee@linaro.org>
References: <20231218-uboot-meson-clk-msr-v3-1-acf4d90ccfee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Mon, 18 Dec 2023 10:47:55 +0100, Neil Armstrong wrote:
> Amlogic SoCs embeds an hardware clock measure block, port it
> from Linux and implement it as a UCLK_CLK with only the dump
> op and fail-only xlate.
> 
> Based on the Linux driver introduced in [1].
> 
> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
> 
> [...]

Applied, thanks!

[1/1] clk: meson: add Hardware Clock measure driver
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/2da1331d20b3

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
