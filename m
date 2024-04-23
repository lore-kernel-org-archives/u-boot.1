Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000C9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716D2885C4;
	Tue, 23 Apr 2024 13:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w5LVfKsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F0C885A6; Tue, 23 Apr 2024 13:43:23 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 025AB8859C
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a5878caeb9eso100103466b.1
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713872601; x=1714477401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b46/2ye7NKIbR83gxGDg3TNE3BmYqcblowRCDArnKb0=;
 b=w5LVfKsBo1rYDU6+n5SnH2uWxozanswjkup8er4PI3LDeXK2mS975p738/aRYeEpLu
 cszGJZh0azXv3vOwSwbIWJu2E/AgMIAObh0hx7rlKVr7VqmLOA6o0GvbGDQeH2qLF1OV
 L2P2cKSVG5A/U1Lq8Y2IDd2DdGVw/4UH1DSBODd3ne2jTGh/lUGBnevJKe8lauOojZfa
 8gtujZ7dmYWMs7OUF7hGblKmycDon6+4RPCm3zi7CabWxL5gIKg1qm4cSRIxGQ5WDwyM
 fcrCXRYbx5nNdV302LneUPbgpZljzYBjpWL6Q+HTwc38mHEY8u6xwZo7WaUX7dWeNCUZ
 m/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872601; x=1714477401;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b46/2ye7NKIbR83gxGDg3TNE3BmYqcblowRCDArnKb0=;
 b=vHqcvSyHs3kfZt6IbxylLsqmc+kHNJMXv65lhqeLQIZWjf6ga7eceKUE7YtqFtJPKG
 OVDVXeTvLmquSI4nwg/kqUoEXlERhTSVyu5xC2LYvNlC2aRA1LyQmJedE+WN2udmFogD
 oMJZJnN51tghcXGoUouKaKOtZEE/27fQbSmtVK9yMO2wISwYQwodnxFqFjyjnSnxMdel
 FaS7BoVqS5EkevbTBe9hinkEQrYFx2t3iii/lAlK4wKxhzdqGY/QFliN/ALk3aFbBVcT
 aT6e/dbRCKkoG1Yk/ObhIw8e7d2/LK34Mc2h0b7aeLu7/HbvOn0/7N59ZAg0SNCOzcGN
 RlAA==
X-Gm-Message-State: AOJu0YwCjp8g3iqSEVVyMlmskwsYhiOgdRgkvamFvHDrBckvsFkMcVAF
 rZtYMoLI3aAcCkYSfs+L3gBwia6pbdItVccWIWVI7idc4nJsPfQ6eaQceaHK+sk=
X-Google-Smtp-Source: AGHT+IGF91tjposbxp+uSnqpKJlFcSmcxS2UqHlTZQNW0rYexGLZ4lU17bWYQesYueuRaAS86Q7Y4Q==
X-Received: by 2002:a17:906:f0c6:b0:a51:e5ac:7b7 with SMTP id
 dk6-20020a170906f0c600b00a51e5ac07b7mr7247634ejb.71.1713872601554; 
 Tue, 23 Apr 2024 04:43:21 -0700 (PDT)
Received: from [192.168.0.114] ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906164400b00a55967a9038sm4507528ejd.95.2024.04.23.04.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:43:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
References: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
Subject: Re: [PATCH 0/4] smpi: msm: fix version 5 and add version 7 support
Message-Id: <171387260080.2280908.6689234271606743626.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 13:43:20 +0200
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


On Fri, 05 Apr 2024 10:21:52 +0200, Neil Armstrong wrote:
> First, fix version 5 support by using the right ch_offset in
> then msm_spmi_write() reg accesses.
> 
> Then:
> - properly format command by importing helpers from Linux driver and
>   use a switch/case to handle all versions in msm_spmi_write/read() command.
> - handle peripheral ownership by poking into the cnfg registers and
>   mark periperal as read-only when the owner id doesn't match
> - finally add version 7 defines
> 
> [...]

Applied, thanks!

[1/4] spmi: msm: fix version 5 support
      commit: c2de620d64d462c1404ca383ad55aecf3f5a972e
[2/4] spmi: msm: properly format command
      commit: f0b604d9491dc92c9cb092a9e4c0fdf2036cdb8d
[3/4] spmi: msm: handle peripheral ownership
      commit: 59e0482b5edc1fceded3967306561a57f60ba4b3
[4/4] spmi: msm: support controller version 7
      commit: ee1d8aa5ecf77991d3bbcfea2d5b37d88bb19473

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

