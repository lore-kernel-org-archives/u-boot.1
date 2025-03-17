Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31123C28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F75F819B1;
	Mon, 17 Mar 2025 14:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OZdA9s4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7944281877; Mon, 17 Mar 2025 14:48:27 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0D58081A
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so12022305e9.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219305; x=1742824105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1/z2QFHl/qqDcFuV+ujN3omVBV4GpVuxXZfl/Q5CXg=;
 b=OZdA9s4jKcUaKLoL1QG/onpPNujSMXYpNujfyF1PDbQeksFPiurwf6Z6koVohI1sgz
 iiDawcvZfQAEQ2EmXe2SxvKNSPwMUVItvdvEm01IdiHW7tqjr8CHFI8852GrfT8K6Toj
 0A7f70DQb0H8i8SS+xdpNjIgZ2zrdpImZDGjg5TaEbYxoXD1gdWQm+NLJOvVKb/cQoYV
 a9oCR9qgMvvbePWNnKO57S9PenhjY7wR1eI9NQH66NSU++QWJjCbtKbEFEc4G0iKDD6R
 oGUbRFDSwk7ZMdnzk9UP9PZLKm/OWtPrldj1AcoDsIh1wSXU3HQOmRkQCT/qTHgd71mM
 CZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219305; x=1742824105;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1/z2QFHl/qqDcFuV+ujN3omVBV4GpVuxXZfl/Q5CXg=;
 b=ivafYxdEALf3JPGgX7QkmFm5EFx5nq1OwWbCpS6iohmNEF9FO18ymigBDWEIjtj8Qx
 xM8TvxcftlQEpU2EgmCeF4IgWtedtRKHsPxQlQmZ0bwF66aFr3aeZL7xVQ8u3Nq5rC7c
 b17a5MzyhUKqizYpChhxIOj+ssngP0XbucObl8id7JRwX2zqdCUBA6m+hwERVySJd5A2
 M9FkTYB2i3YSAtAse5zn/DAof+7wh95wzMbYZbdhfPE8oE/5IbPy6kz2hE2AI/3LHHBD
 Th1CaljmqRhQofWdjITemJ+SaMTf1pwQ2Duf8lr4N8ZTHupGqYR/l5uC2zqu3y9+nzKQ
 dZyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAl1bQDe92Wj12CnBDUnij6cdAKyIYrQrnc+6Qhs6KTR3cUIg19mt2yQBdYjNuuI7bqkpEr64=@lists.denx.de
X-Gm-Message-State: AOJu0YzWnivvahlSkUCRn4oZ74dT1OB0PyBnurJNPlH1KGdkYiRd/6kK
 gAM8/xX6zV8ATA/UtcOq2p6N8tIot8IJX2TfQjstLKIIrGw8EEErsJl4o/jPHCI=
X-Gm-Gg: ASbGncuH3hY3ZuqNWkzAu2LAb610TGl5HsQdLwKNxCGneriW3Ggz8YYpUOotwR+ALSJ
 OzpdDuYJo9lB9dLLEpNyqzY19+5V7nQ4l88aEAyxXRg+xD5F5a8mdAdehE+d1JURMubLGm+gppn
 bjHBVmCDdXZHdHW9ELo4huBnxJPouYzaquXP+Tpmq9YJtgbxXI/KWdQHLcbraJxfoRNUiiDN8Vo
 fu84mq77/qsuxAVUu7Eh3TrA00l1vxbRI+Nk7OxATR7DgOboktTQ3Usp++MZhfDaZD3QMZQjC28
 PySUsWvTV5WDE2+vgZXN8cb4LgksqOuWimjuJBQLV5/aLQqpVN8b5mUwMyhu
X-Google-Smtp-Source: AGHT+IGQlGRimvZMUu58dnSlR8Zwv+yX6I0QUmssO8u8Ti6I02+SfOpJatA9N2AWE5DXitiEvubJ/A==
X-Received: by 2002:a05:600c:420b:b0:43b:4829:8067 with SMTP id
 5b1f17b1804b1-43d1806c066mr145986335e9.6.1742219304665; 
 Mon, 17 Mar 2025 06:48:24 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sumit Garg <sumit.garg@kernel.org>, Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
In-Reply-To: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
Subject: Re: [PATCH v2 0/5] rng: msm: fixes for MSM8916
Message-Id: <174221930340.73541.8589905483285508278.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:23 +0000
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


On Wed, 12 Feb 2025 07:01:20 +0000, Sam Day wrote:
> The msm-rng driver is currently broken on MSM8916.
> 
> The first issue is that the core clock isn't defined and thus not being
> enabled before registers in the PRNG block are accessed.
> 
> The second issue is that the enable method is only initializing the PRNG
> registers if the block is *already* initialized. This would have likely
> caused issues elsewhere once the driver was in more active use, but the
> problems on MSM8916 are immediate: trying to modify the state of LFSR_CFG
> causes SErrors, presumably because this register is protected by TZ.
> 
> [...]

Applied, thanks!

[1/5] clk/qcom: apq8016: use BIT macro for clk en_vals
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/61781206cf19
[2/5] clk/qcom: apq8016: add PRNG_AHB_CLK
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d146a8771f87
[3/5] rng: msm: don't enable PRNG if it's already enabled
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6e933cd69ad9
[4/5] clk/qcom: apq8016: improve clk_enable logging
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/dc8754e8e408
[5/5] rng: msm: keep core clock disabled when PRNG not in use
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/2babb61428dc

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

