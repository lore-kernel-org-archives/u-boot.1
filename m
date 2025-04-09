Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1603C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F2D83930;
	Wed,  9 Apr 2025 19:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S+jr1+IP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85AA18393C; Wed,  9 Apr 2025 19:21:07 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B8983929
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so50400305e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219264; x=1744824064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEhaA4grcfa+UhXD/CxudINcP1E4sA/e0mODN38IrFU=;
 b=S+jr1+IPOfyVRzxaMLn3adCiSzVHUojsR++B3IBDpaFxZhbfrmtWz44C0o/9bV0SxR
 5Wh7jDLiOnBfTDC1keJHgEcCsqCM8lO6pas1aCxSbsWIH/f94uEoq5MOZYhd1k+6M4Pf
 jbq7Ui743MTD9NC+9Yaxj8Q0xm9h5DPbbKgd9/kkOzZUDOwrQBalFIqnhK0kz/s8Bk0i
 aFpkjeiaz28e9PuDlvHWvd5e2MTQFs6A+Cz75pFW33oWvcMKCO8RA3eTlVDcNoR4X5On
 m4DdQi7tU8BYTTdGi/ZlCOsR/ATJ+Gu8CPChNmxTFPaywW7MMuRw3SrH+neMnlQLLrl6
 2xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219264; x=1744824064;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEhaA4grcfa+UhXD/CxudINcP1E4sA/e0mODN38IrFU=;
 b=wQSga2gz44Y/EwiawyeGLXL0vKVz7Cagt6T7W2Ztp4KIZju+eNNE4TA6j9VByeUBpV
 AKQ+qlRMB2xN84JEpb6utj8MHKhuMythJs88iA/SwyxNFWO8yglJDqUNluk9tOC1MMCs
 7uQTBWJ+UMEqcTZ+JKgm3XRQSl+f3hY1Q5U06WroDKHkC/t7jWl5qwQcxHpWYdTXzWSD
 So+FMzyGaRE6wbc/kuSC78BZC4bhE1d9HbbK1QvVIFEI0KAwB6oivEJo9rm8g+qdCY5R
 bYfpnxpO9vqGJ7IYs0klPvbhhg9zn3Nd1uiaFk+ER1mJLOaGlGomus9064Bxzsz0U1zF
 NzVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3lcQyvU5EZRjInukq6+fMsNefwbrXez4eU+fjguaFHx4wqCtshncjizxJ48LFicwZbO3DqqM=@lists.denx.de
X-Gm-Message-State: AOJu0YygD9OU2szEAEN53Tu/w3ppLDudYvGl2946tM+buduXQs7hMa7p
 RljKPbhigWeJktiCHysje6EnWa24mN4t/aQPULaeYL1tV6s4SK+76nR4pAqo6V1kjHv4/8/47/j
 gmfM=
X-Gm-Gg: ASbGncsDu/DzGwRYs44i/uWF78TEGx6/7o7/tph47G8xwUxA3Uc2NjvoCLYSQoKebvY
 JMMUkr0riDJdwvzdC6r1mi/UJofbMNWhQ37CVR/fGFUPbQfGOZZ/ONqnRQGlpoEsaB5iXnnq0fm
 qDpvFyD8VYcZyTwX6nfwJR4Xzaf6tGPAEHwuEoqYZXvyFXOnaZao2+i+QnpFbIzHcC5mDZp6t2O
 UcBPLeF5mt/TjEbBkGLMXhygeEDQSOj4vOKOmzDIkuLs3F6AYMLCxtW8HLdZNqtvhBtqucFwfos
 mL87ApMDC4DJiU3wrs2ph69LMcFiLDmpE/t3+KQ6sgTI8YPhD7B7ZY05MFtrEAq4mkwTJYep8e/
 H3o4fI04hv6inz3Kz
X-Google-Smtp-Source: AGHT+IGAXGJ4tgq7uUY9eNGyo5BaYA/LENhL0ca+NBq3sM+YxB6GgT4tyRHlDI1FWYxBlmHPYYaoSg==
X-Received: by 2002:a05:6000:4283:b0:391:45e9:face with SMTP id
 ffacd0b85a97d-39d87cdaeb9mr3700295f8f.54.1744219264352; 
 Wed, 09 Apr 2025 10:21:04 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893612dbsm2167529f8f.1.2025.04.09.10.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:21:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
References: <20250407175617.3494506-1-jorge.ramirez@oss.qualcomm.com>
Subject: Re: [PATCH 1/5] board: qualcomm: dragonboard820c: update readme
Message-Id: <174421926310.1813778.2002926345158169782.b4-ty@linaro.org>
Date: Wed, 09 Apr 2025 19:21:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 07 Apr 2025 19:56:13 +0200, Jorge Ramirez-Ortiz wrote:
> Update build instructions.
> 
> Be sure to use the u-boot-nodtb.bin image, as the Snapdragon platform
> prioritizes the embedded Device Tree Blob (DTB) when present, rather
> than the external one. The external DTB—modified by LK—is the version
> required by the DB820c.
> 
> [...]

Applied, thanks!

[1/5] board: qualcomm: dragonboard820c: update readme
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/805d2d4d3662
[2/5] clk/qcom: apq8096: fix set rate for the uart clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5cbc99a3119f
[3/5] clk/qcom: apq8096: fix the sdhci clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ed3417741fdd
[4/5] clk: stub: add qcom,glink-smd-rpm
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1a3a35c1fb35
[5/5] configs: dragonboard820: updates
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e4ffc6a32358

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

