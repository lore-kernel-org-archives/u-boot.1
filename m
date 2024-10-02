Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67903CF6D28
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3789F892F0;
	Wed,  2 Oct 2024 16:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PrEHSg2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D63B5890DF; Wed,  2 Oct 2024 16:52:51 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968DF88DEF
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so143039866b.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727880769; x=1728485569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIALLUv2TiSgifNaCXPdvMDBFxeZRSDQQi8L85UuWvs=;
 b=PrEHSg2Lt1Md+TumjoUSzFk1Pn760HnKkmzOGw3VcQOJ0RZmyWqscqzokfMBhO72Yq
 hLX2Eg5OzvL9nnHu9mQjrJhw6pn4QAw7nC3xwVXuJg9l2BXfw7htz96ZthAUu6nGDilW
 2hwWPylWevi2VDayvapXSaftQZ4eRwNQP0Z7DHLX5Fsm8o5qzlYA9H3AeU5361CcsrTq
 oRZifeXYThihrvDnCLACbhUMxkSz2BuzIthUsKdnjfeVeJLT5mExSZdb8hsB6b8KymnW
 /U/jj3kBGcNGHBlKxnpnjURNmAmjL6QbGwwIsqF7kr2ZJQXixmtuGRbFFjI4vJhBzB5d
 uRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727880769; x=1728485569;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIALLUv2TiSgifNaCXPdvMDBFxeZRSDQQi8L85UuWvs=;
 b=fsHuyIw66LCaJk0dWktXJHnwrZAJ9xHR9Th1yN4WyfvCUI8WQlKu1WfCuQQtaFrrZr
 KYafCx4P1TIz1WaXf9UlBVQ+XMLq9ds1KVqW4vHqbFFqK2Vpt9WyQm15r8TqZ9UQn+0L
 sISnv5b68C0iWHoNbF+tuIklOwRpdxXLHvrZTng/6tRvQo2LDAhXQdwsGCDd3wxGdw+V
 VT0m0Th5BfZRpJWQ7BAMaD+Po/MVm7HedzFWjD8nnr5eL7qEnzSJSO2vX/oMANVPc9LP
 A/c7WjGqV8kFlAwhBXcnH904+fwyScF5w6IR/SJEIf8jzjDowCOsEsfwOYWErpHlkWgL
 GpDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR+eDSHl0Ogn6E3m+s0FYzgxEiyXUxjck/ruBsgOCAZxxpmYgmTkKEyakdLGwM+oDoZQUeQqg=@lists.denx.de
X-Gm-Message-State: AOJu0YxhfeDvOfLmGaw8A5TSbGP2kc9jnMiJct3K9z7fsG1v7Mcv/C6t
 +2T6q1GLwo2Ctjzj1ngii8tpwffnD07+WTlYqyFmKs+vw4141dZV+CnXQHEuiM0=
X-Google-Smtp-Source: AGHT+IGA01Ff9XwU8vKmoK/S0/DbRUFqXKnPNpvczO/1BpILWR+wxlXIhbNtYa/fv9uNAhvdvHWokg==
X-Received: by 2002:a17:907:7fa7:b0:a93:a664:a257 with SMTP id
 a640c23a62f3a-a98f838dde3mr346082866b.61.1727880769071; 
 Wed, 02 Oct 2024 07:52:49 -0700 (PDT)
Received: from [192.168.195.50] ([95.90.247.28])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297be12sm889785666b.179.2024.10.02.07.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:52:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
References: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
Subject: Re: [PATCH 0/4] clk/qcom: implement clk dump callback
Message-Id: <172788076765.935801.8728096845283608347.b4-ty@linaro.org>
Date: Wed, 02 Oct 2024 16:52:47 +0200
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


On Mon, 19 Aug 2024 21:34:16 +0200, Caleb Connolly wrote:
> Add support for dumping a few of the clocks used on Qualcomm platforms.
> Naming the Global PLL's, Root Clock Generators, and gate clocks.
> 
> This helps a lot with platform bringup and feature enablement by making
> it easy to sanity check that the clocks are programmed correctly.
> 
> == Usage ==
> 
> [...]

Applied, thanks!

[1/4] clk/qcom: implement clk dump
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c0999fefc80f
[2/4] clk/qcom: sdm845: add dump data
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/2880a076b4c1
[3/4] clk/qcom: sm6115: add debug data
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/84b2b8dc2991
[4/4] clk/qcom: sm8250: add debug data
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/866cda772046

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

