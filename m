Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C193CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAC7882AC;
	Thu, 11 Apr 2024 14:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kigWImQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B2288263; Thu, 11 Apr 2024 14:43:13 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F252D88280
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d700beb60bso125209221fa.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839391; x=1713444191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VybDRgXCZwMAEsluFwy+hYBnpW4jPQuOkxPkGN410qQ=;
 b=kigWImQvIdXGwW2WH6ujCMTTJiTPdonNVo366gLV1fjfx6vgrrvOvKrUN0SGFtxAMM
 SaOpo7QZCFlDehwpt86Ry7mgri2tKBO3ZEu5e5yhKYXCWCQh0vy+0s4LKSgINJi2WnIl
 ZPJQDSVexK1SnJ6cMWeA5EXJwc6PtGfMFsIO0Lm5+nm04DGdc+o3i6uYiLb8EiCfcTTI
 ZsokwFI979d+LkUwXvohCf0E68887vyCFA7dVNZoeSPUabJyf30mkgLxhekcK2XHZh5s
 TqBnH+1xEmE938O1+CLav+IV3/g7XAnVc/doYQRETWCWvz8lrtLBgWt9LGBUs7Tc+Raf
 Tj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839391; x=1713444191;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VybDRgXCZwMAEsluFwy+hYBnpW4jPQuOkxPkGN410qQ=;
 b=TMS38L0bXcATFIbR0bUVjD6LOxX6wIWDcwiWbO2I82ozgRwkBcAGflWFyqTbF/YQWO
 W5ZfcHQfZL4riVEyQQxsf81AtgRqXy3CT500Ec+t/8NGBY4hNaGu/02yqYjzIeAkBsFA
 u/RWqYDjpB1AVRBxhX4H9KGCZqCZnzCQH8oUD7XIW36O4UZxBijHJBxaAoNgpHOFNwZi
 sY89BuyAcgQ5tHxBVQYg3i0796og9hNcmz/Fy4bhQytglq3SEbOqR5cJVN2KW6Oc5NXW
 vFNxZWcRCVO1uwwyVk64URJfSW+YaDb0as6onHgHO7fBNtOBUWMcGJh+ZAoZVgQF+MMF
 q1mw==
X-Gm-Message-State: AOJu0YxjxZA0hbXnN3mDMjwqsmwvYzMae7KKmc4LDjwLdWF60fvVVslo
 Op6VeO1Qo4zhaJ0Keb3TFml/KFx0J49j9zcLYHzLbU0GOT6jxzJ64VUFMxn8oGmhMQ7ojx3nm4r
 S
X-Google-Smtp-Source: AGHT+IFH9wjLD93bugu5I86vlZW8JxJTBlAhYyXXzo7Et+0vu90ZnyTk/KJrPgda2goUPPv+qkw5AQ==
X-Received: by 2002:a2e:855a:0:b0:2d8:3ccc:60e8 with SMTP id
 u26-20020a2e855a000000b002d83ccc60e8mr5084414ljj.48.1712839391155; 
 Thu, 11 Apr 2024 05:43:11 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a170906844100b00a4e8a47107asm710491ejy.200.2024.04.11.05.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:43:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
References: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
Subject: Re: [PATCH 0/4] qcom: clock drivers for qcm2290/sm6115/sm8250
Message-Id: <171283939005.622116.16840902634068607898.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 14:43:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Mon, 08 Apr 2024 15:06:48 +0200, Caleb Connolly wrote:
> Introduce clock drivers for three new SoCs and enable them. This allows
> for configuring UART and USB on all three as well as controlling
> relevant resets and power domains.
> 
> 

Applied, thanks!

[1/4] clk/qcom: add driver for qcm2290 GCC
      commit: 7a8efc12ddf7ad2345725821377aa90e1972f366
[2/4] clk/qcom: add driver for sm6115 GCC
      commit: 5f38a7b36468c3a78570822676ccb8d0057f33b1
[3/4] clk/qcom: add driver for sm8250 GCC
      commit: 45271bce0478276158ebbe8e0113b9a887f88ae9
[4/4] qcom_defconfig: enable clocks for qcm2290/sm6115/sm8250
      commit: 642ad0402c0654841c9096e2fadc753e5bb86348

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

