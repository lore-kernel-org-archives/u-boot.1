Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36E0C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 165118122F;
	Mon, 17 Mar 2025 14:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZ1o3ugT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D8FC811DF; Mon, 17 Mar 2025 14:48:23 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2AA3800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so12021405e9.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219300; x=1742824100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fCC6ssaTjWquuWUUPr5wVdktCcNO9CCBrLHHTPkwy54=;
 b=dZ1o3ugTRv5olcNvqMzUpLrTkDjpUY1Q3j4fuL0HG8QS4vIkkli4jQndbePL5xZdGZ
 NcnFnKfpwDostH9c5UjQzRwvh1zBgRvZlIi2XKC9kscWre55vYu4RWxVZP2HCw6Pq/W+
 ZUJZWT8L/sChR1StIxBvfzouYSlhn8Am3eJg0QC5g8oTIsOXzZ7UZbM9hfbsYqzBudQh
 G17fuahVbbAe1j17Q8yHpjN1+S+6cbROhOCgfyu8eBwuYqRKuXfqq0cSpPVUUkZOblbY
 7IA5G8aOa8X4YWiRUctQ0gfkFVSGM72DC/ne3Pe7+QjAFAzP2wZDVcU/n+y4YFxkGLBf
 ZGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219300; x=1742824100;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCC6ssaTjWquuWUUPr5wVdktCcNO9CCBrLHHTPkwy54=;
 b=qe2owD0HzAULk07bdhoN4wboKvyQuZWxpGDVYURaLLoxT3eNCBjBXCgFE6kXu4PSbs
 pYIWVdC/eBXUI6SNlzitSTEvKExZzuJPoiKJ/nQoxAXaJpA7udM5PDDGRPMYef0sPLyg
 zoovWi9falqqK5+NBUNVxgAO2LGZnhP/CkBwF6sfoQe93uCZaQ2R6Xu9RHVUMwIBr038
 QYT7G6OoSWJAKkSjRHH8UWlWKZOphmZz1i6NDLGU/TOvb6ntGibnCIW2yGiV77bBlwGg
 Jhd9P2b8C5u1snvt1CibpqBn9dfbKnWKnjvxYwLSK9oVAO/tCSBwjQThV/ahqnxgZthg
 4fKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGKcWVSlYHhCIOyHr4/49vf4TytDe0cjH2EIxnfZe8LD/NUrxZyxiRpfCbgcPgJEuqpVz+va0=@lists.denx.de
X-Gm-Message-State: AOJu0YwsoYqdoAhBuMeOiez+kyzatvjjrqd0UvXh9BUMMYUXNZf+bnJU
 ZNunnAg4A65UbHgeM/bTRYxwo4WCO8MmwTJAuY3zrMOP3iSZPJKtahSVq+TFjmU=
X-Gm-Gg: ASbGncvLl7q0iLvulblDcjnRFmUBAugAA+Of0jJvRb2M72quGRbVArdwPmDuCxFlBtt
 3iU28JCZDj5MJ1/I9kJklAhuoXQXI7xoOQYBbucP/gqcddNWIMfrqSukR0vYrS0FLgsOkotJzhJ
 xWyX5y3dNgyrvkxaW9Sl6g4Cc8bo4wW4EoCdbcCz3hHGMALMuAsT6g0lm5iRLyMYUB1nf3PLzcr
 TPYBMmu/EGnekMeXbxY40zQXPJof2XVl+LL6Ei0fET8bMjuRHTLdrQRRGtN4bBlP1/6f942PwdK
 QyVN5O+Yu0maWAGaV5CwtJ7lZvOHp/Uv4MIoi0v/IvfLg8GIQGXdLNRRGNg3ITK8w/Pwcf4=
X-Google-Smtp-Source: AGHT+IHUQjFWn13Om1b9epLl4TIjW25FguE9SkKSfIOEbZZsQoZRFOTgGTBPqN97+SalW4LkwWkVPQ==
X-Received: by 2002:a05:600c:2191:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43d1805a5b1mr163314285e9.2.1742219300247; 
 Mon, 17 Mar 2025 06:48:20 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:19 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, lukma@denx.de, 
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, Volodymyr_Babchuk@epam.com, 
 lehmanju@devpi.de, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org, 
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
In-Reply-To: <20250130053751.3148614-1-quic_varada@quicinc.com>
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
Subject: Re: [PATCH v2 0/6] Add initial support for IPQ9574 based boards
Message-Id: <174221929860.73541.5722921702095270974.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:18 +0000
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


On Thu, 30 Jan 2025 11:07:45 +0530, Varadarajan Narayanan wrote:
> These patches introduce the initial support code needed
> for the QTI IPQ9574 SoC and RDP433 board.
> 
> 	SoC	: Qualcomm IPQ9574
> 	RAM	: 2GB DDR4
> 	Flash	: eMMC 8GB
> 	WiFi	: 1 x 2.4GHz, 1 x 5GHz, 1 x 6GHz
> 
> [...]

Applied, thanks!

[1/6] dts: ipq9574-rdp433-u-boot: add override dtsi
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/25edbbf7fde8
[2/6] clk/qcom: add initial clock driver for ipq9574
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ad3e8a2f59e7
[3/6] pinctrl: qcom: Add ipq9574 pinctrl driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/1b734e019048
[4/6] mmc: msm_sdhci: Reset clocks before reconfiguration
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5bff42afd1c0
[5/6] qcom_defconfig: enable ipq9574 clock & pinctrl driver
      (no commit info)
[6/6] configs: add ipq9574_mmc_defconfig
      (no commit info)

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

