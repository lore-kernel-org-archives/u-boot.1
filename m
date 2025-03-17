Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB03C28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A98B8081A;
	Mon, 17 Mar 2025 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j66L6Ear";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 730D28129F; Mon, 17 Mar 2025 14:48:34 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A3B38081A
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso13124925e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219310; x=1742824110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Lw93ch+O5qiSz4mD+ye04F1Jzvx1xp+fmMK/f2V1lo=;
 b=j66L6Ear4hF1Lmj/XeCKgE7TCqc+TuJgD6CMkJGl02uGHULbs4ds2hKeA8odrVHUgh
 e1Qj9Lb7AFiQ8ECDjldCMX6SZ6ZhO5rZXnN2Zg+B2Mq2AiwpSMC0JRizI1E4q4ICSPcW
 W5DDhyBfNk3lz2eL3zUacw3qleHis7Z/hJ+sLS7MK//Y1qTITEss9T8IBUb0Ij/ZIYIU
 7TRqePOyAyr1lqkoQjXxb3X61ZbyAFVtGBimNAb/LBQcO479Rezb0k4Cl1zXUKk8sI1Z
 KhWYdgI1hQNFpGANaR9kjp3YiADjrvg5qQ0woetgvUWcELPDtJxN2sQJuTWVFdSh8qVy
 L+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219310; x=1742824110;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Lw93ch+O5qiSz4mD+ye04F1Jzvx1xp+fmMK/f2V1lo=;
 b=HaWdt5/646EuZ7RW0JL9af7cSWPCfPufYvv/KA7AgeDur/mVE9n4m3pmtRxk3QGrU6
 2hEOMlm1/uvpBn2wH+4fwpmFWG5dvYJFijraglIP+vf9Nc76zv2+Kzu0riNPGROyYy8X
 9w28W3Jw/k1s7sAs3B0IEjYEINTXJ3D8BISqR7RA5OBGJqtPc/L+KM7wXAaSzVg1B8D8
 GVon/HCs0yjqrOUzSPHpwnsYfnunbwYaw8eo4XarFkTn/f81+VkAUF5C8pk88DYuyv+S
 L9rflv7N62jI6IHelHQXkAcA4/cDY+uF1Abz/50laFA+w5ICPaOTSLN+C83j7evjKZw8
 Y8dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTV0Atqu8+uBHI3zSu/ubstsZS6kfe7zPIldve0NwOYRPONtAwIv7l8LPo3OHzyxJ7C9Cv24o=@lists.denx.de
X-Gm-Message-State: AOJu0YyXWpf14Qs7SHn8YV2DbEVwrkRverEvILI1W+qKjjjDtbqnCF0m
 lWG4V8j+XH1LIhI0Ty9KNkj+Ta0nw1rTN68xd8rSnaFYRtBsaVN+T2JVzCRwRrw=
X-Gm-Gg: ASbGncuqVgdmp4YYEs2aFkRsomSPt3X7Tn+TlegEdgwjQBNIxh8CM0ZJI1yjeoq9yic
 uf0Dnc2ev554cTcPqKV/Izzqgi626qf+Ayzq0uO5Frmsop1vtCglV0sOUdZAOzXtAVxH6rd1ASd
 5HbBls2+evqv1xNlJ0PybFlSQ33iMnjthtkcRqB5PbIeGcSlUk12bwfgaz5B+jAMQ+FyRyNC2T3
 uPtBH2TOMbzLvXI1UdSmEHP/KhOSi7vR/d6p8wSkh9+Cta6RpfdFuPZYqHZfxU+N9PzNs1d8thP
 IbMi03b98N40y7ZYbL/oFndkeri3eRGH3GNizIOmRI4oPkdOKMbU67LLYJt0
X-Google-Smtp-Source: AGHT+IFTHlnELhmliiXPlzcxAQWH9qFIn/wS8yiDoI6449SXwOh3bbVd3Q3z8aPSW6VKaOYpCwdKnQ==
X-Received: by 2002:a05:600c:470e:b0:43c:ee62:33f5 with SMTP id
 5b1f17b1804b1-43d1eccf8c6mr107607605e9.27.1742219309876; 
 Mon, 17 Mar 2025 06:48:29 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:29 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
References: <20250125-msm8916-sysreset-v1-0-62073932ff0e@samcday.com>
Subject: Re: [PATCH 0/3] qcom: MSM8916 sysreset support
Message-Id: <174221930882.73541.17773646420323155053.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Sat, 25 Jan 2025 19:59:11 +0000, Sam Day wrote:
> Most MSM8916 devices shipped without PSCI support in their TZ firmware.
> Instead, they use PSHOLD. These patches enable both PSCI and PSHOLD
> sysreset drivers in qcom_defconfig.
> 
> Caleb had already submitted ([1]) a patch to do the switch to PSCI
> sysreset driver as part of the UEFI capsule update series, but it seems
> that the sysreset patch didn't make it upstream.
> 
> [...]

Applied, thanks!

[1/3] mach-snapdragon: use PSCI sysreset driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/61a1a1b8ca73
[2/3] sysreset: qcom-pshold: remove ARCH_IPQ40XX dependency
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/11c7187253df
[3/3] qcom_defconfig: enable SYSRESET_QCOM_PSHOLD
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/904379210985

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

