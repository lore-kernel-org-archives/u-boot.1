Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5736C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45B9780A23;
	Wed, 22 Jan 2025 17:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TC5r/OhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E21680B9C; Wed, 22 Jan 2025 17:12:59 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ABC380A09
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dc0522475eso337519a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562377; x=1738167177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOVBwdVbw6m2ux2L8l2ACwMzCJFyid/INpS3UEqxuSI=;
 b=TC5r/OhVBvyKNwvqIF2WLiGQXdAqik94wN8hcDuQyBPh0BjR9UaWdGs7/syGqYz8TO
 1uktkW2OkXaSBB+Phf8jbi+uKCaXRrw+6rUmqCG/vuvy8/Jze1khUDFq26/nO48YYM/p
 mTeNKSet05wqZ6wwxVR8IZ85eu+CdV94SOhaGjNrxNbY4XRT2H0ttgaSrkMspsL4tG3j
 Hqb5Nl50K7Sxn83MMXRgu6SmRTMyOFPgojjYlmzvvg0CvP281qHdMhfl6eiTH36sz5+L
 zmoIEObVk26hrIFA070l6H/IBRzJGoQ6SWimNCWt0hM95I5JHdP/4PbjuJ4sYUJRxFDn
 vfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562377; x=1738167177;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOVBwdVbw6m2ux2L8l2ACwMzCJFyid/INpS3UEqxuSI=;
 b=WsJccMfHM8MMq9gNn5Njvd94Dksj4/R++up5WrZ8QmJi6GRh8I7xm/axAwx4Fj7U9G
 3KF/zGY5VauclsdSV2gywsu4bWyI0w5rI3A5nhcD6DKZeyCFRqQKe5eblxQtZQWj86zK
 yOX7/FLS/wBTzyLA9npEoX6sKu9sVxiEWja1HHskwTev2ln56DtOslRzNJPNEoEpWScO
 vBjZLIDZtIFQ0H5eqPCxAw/t8lf8/GxR0Ypur4XjPpSLtt8xlkn+79Zg+s/cSVNTbwsc
 uSgGVIyTdlORu9n6OsJMARmcW2c4SZL10K/5VAGbaaUhjBpCb5Vatfpc/sBBjdKUhxYG
 Gb+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqyrFg+mJequQVTXuT3c/79MFLoMqJYegXd4gW6KigEO8JBW4dnFW01ykyYalfW0jdOZhpVbY=@lists.denx.de
X-Gm-Message-State: AOJu0YzZMNFC6Gk3/S09LCUNkBmcevnedZp2tkN7aqmVm7mYON9m2Mhw
 vMlrXuJ6suFmALegzUkWip+IIJZ3uRgS4DuUtkIb6dgOPGFDuiYys5Mo7oW66vk=
X-Gm-Gg: ASbGncu8e22UJdlgTCD1QGUzz3+Qz2h2R9zilhjvEota6nkpFovo7dfj5pIpWGf23B3
 YSVtMbekpxz7Y0i7y1+A0arjZg3kk1VZHwkx8TKgnkDXqnwGsRHvpxxPaKBXPNbN0SCrEoW+EFU
 lqsZAYn6vRjKKnhU/y8OXyR4yqzuMW6andQuhkytMD5Y8ihPgl55p+wk6f7wiwzqhYLnYsU+a4m
 hrXHkDIfqELv+V2SwBUXFS4dmEZ8bGTJfizGOFGqYc5r/uV+CZx7LQ8M6md4nR3nUm5y+w4n5jd
 TGXQ3IaJ23TR
X-Google-Smtp-Source: AGHT+IHzAwxe6SfNubqOnx1PJohYEuUAlC7CBBrDQuJUWz0u8VBUMzkHK3IPc3GrCrI0VNBLri7N6A==
X-Received: by 2002:a17:907:97d6:b0:aa6:8ed8:a82d with SMTP id
 a640c23a62f3a-ab38b163bf5mr1811312066b.31.1737562376575; 
 Wed, 22 Jan 2025 08:12:56 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:55 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
References: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
Subject: Re: [PATCH 0/4] clk: qcom: add PCIe clocks
Message-Id: <173756237544.1864727.6203455789831989605.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:55 +0100
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


On Mon, 25 Nov 2024 09:34:25 +0100, Neil Armstrong wrote:
> Add the PCIe clocks for the SM8550, SM8650 and X1E80100
> platforms to enable support for PCIe feature.
> 
> Depends on:
> - https://lore.kernel.org/all/20241118-topic-x1e80100-clk-v1-0-8841e87ad81f@linaro.org/
> 
> 
> [...]

Applied, thanks!

[1/4] clk: qcom: add clk_phy_mux_enable() for PCIe PIPE clock
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5b359312e5f6
[2/4] clk: qcom: sm8550: add support for PCIe clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5310a13b56f7
[3/4] clk: qcom: sm8650: add support for PCIe clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bb77008c526f
[4/4] clk: qcom: x1e80100: add support for PCIe clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/cd86b564c8b6

Best regards,
-- 
// Caleb (they/them)


