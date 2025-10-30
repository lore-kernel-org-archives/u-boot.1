Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0890BCCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10A7836D3;
	Thu, 30 Oct 2025 13:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XR3Ym1ns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98945836D1; Thu, 30 Oct 2025 13:16:44 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79CB838C7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so23216866b.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826600; x=1762431400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faClGJzrpy204EnSqYVEJwpkdn7+uePH9VNQnNvd5uE=;
 b=XR3Ym1nsa6oN7pEuzAMDkQZlnNX1DwQIVUGUf6ZceptzaBGW6d+TV/Ex+wd/TU6QwS
 UK297nimh2BzUEwzMw1pu8gqvAQ4cR41ckbqtv6WQF7vDVLXNRhE4rClkAPDUjgH2Klj
 UKT3q0o/BYz3DBxe6s6VP60yrd2rWLoLa1vaKni5q5xaSX7NEbzWAyIZeyf335hDCIbF
 rf8F6azjvssbq/GsdW5cG6yYkjTEk/Yus9e+xI6B6vk+MKRciR1HmQlnNtAJbo8jdO6/
 x5AirTsXQE1M8jD/yC3AhyjA/VK44h5HXuRJ1VC4Jv+IIihZtL+e1kDzzCo6anXql4Ha
 l3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826600; x=1762431400;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faClGJzrpy204EnSqYVEJwpkdn7+uePH9VNQnNvd5uE=;
 b=qzkJ1ejD7fi8iKKzpV1KfNvmg45Bms3pOJpbvje4Pg+ThsZWJal5DOdjC1Y95LJ2dX
 bNvFLY64b1EoRpqqZvghtLc0ofWSiToeo8v/MIs7ACCtPM8rNlFr+dFHsDG4XJfUB8wn
 kB3mP4BXQRHPPcnEpM61ET8f52in39vnygubhESkTPnietjPQ+u+PJ6+9+Xxel/54aeQ
 jTYFQHRhZCnJhrvDbQ1frHuspg0beN5BuQSIlH9BPfDQDTiZZrPFqfzPc1u9ms1uQFMh
 UTXIC2ZtADKvydNbUYX0CX4kLlDUillGbzFVuKlLXM5nKga28VxgNnTRIjTMBaZyZ8Tt
 BOgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdLsZkzszzWIG9hBOxYmrr7OAFxfDCd15EhReCbLwpPjYEusRhpLIZqj9v3n/5jJEzo/Qum/I=@lists.denx.de
X-Gm-Message-State: AOJu0Ywu1Lk095+4Xp/2xTDrlp0z0BE+y2gNcNhyCkTy8n2JVCcTpYkD
 37Ng+WUy9enuyDkNLKGpBBsrzrvn2MBIDqTqcllf2fibkNZra6VPGdWXQjd6JPZ0FM+hgvl+YXy
 aYWypWF4=
X-Gm-Gg: ASbGncvaLVzUpUWMFcUl/VOHblfCglbsesDG1qw20eZbYQcG3Ot0nERB2Pnc1rFfT0e
 86RpyOlD7CVV1s3/CZ2k8GYkBBqJIQof7/FUz2cGMtwrUqG0A/W/2nWpAJTsZaw4HscV/V4XIZd
 eZ9r/9ZBCKE1OtN+IzZc9OfFKK6eubjDW2yozy7CgXxoO7Qrj8Ofh3RG8pv4e9wGg+fyxHoYWcX
 exaowkOVMFegmyfj1S+ZFw6MIMPqw69McM9K0XlK2Lu2hKJPDtiScgwgrYCQ+8NRHiIBsyL7q1s
 cJBSeT7XcMK/NGHqlAz1yHgiQAVmMGShhGZVTxrh6IckYlJJlKpvXq/kT939KfOyE8FmaqT0vj2
 8BoUGNm9DUo6eCp8HMEe18iQkIv6VBBs4JK6ENY9YBueY1oiLQNuRTqT7/7jZzgJ2cKiQZ9wgB3
 GxtcGvpwSD/FDcgJ83cHcsXYU9hPXEDepa6MIfsxpv1syitcqWsk6yHEg=
X-Google-Smtp-Source: AGHT+IGZTfgnl+RUXx8LXfW07C1Dn4SQoQKWKKU5IUcaElo4ceWuFMzPxaYN2tHKUndRN5RGvoUrbw==
X-Received: by 2002:a17:907:3e14:b0:b6d:5c4e:b09f with SMTP id
 a640c23a62f3a-b703d2b1eeamr592384566b.5.1761826599920; 
 Thu, 30 Oct 2025 05:16:39 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:38 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Marek Vasut <marex@denx.de>, Casey Connolly <casey.connolly@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Jianfeng Zhu <JianfengA.Zhu@sony.com>, Jacky Cao <Jacky.Cao@sony.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
References: <20250407-ehci-msm-fixes-v1-0-f8b30eb05d07@linaro.org>
Subject: Re: [PATCH 0/6] usb: host: ehci-msm: Clean up and fix crashes
Message-Id: <176182659844.4111945.15817879599309212674.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Mon, 07 Apr 2025 11:54:20 +0200, Stephan Gerhold wrote:
> The ehci-msm driver has several subtle issues and stale code. Most of them
> are minor and do not cause issues during normal usage. The last patch is
> the most critical, it fixes a reported crash when stopping/re-configuring
> USB, which has been around for a few months now.
> 
> 

Applied, thanks!

[1/6] usb: host: ehci-msm: Fix pointer check
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e179d750c751
[2/6] usb: host: echi-msm: Drop ulpi definitions
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4286c37853b0
[3/6] usb: host: ehci-msm: Disable clocks after all register accesses
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3d14ccba5355
[4/6] usb: host: ehci-msm: Use clk bulk helpers
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8b500c715f47
[5/6] usb: host: ehci-msm: Drop redundant EHCI register writes
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/cfcb30960aa4
[6/6] usb: host: ehci-msm: Register ULPI PHY through NOP wrapper
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/cfd083ff4d4d

Best regards,
-- 
// Caleb (they/them)


