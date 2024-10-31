Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB0D74958
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 13:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62E789293;
	Thu, 31 Oct 2024 14:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jSq1db20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D711589241; Thu, 31 Oct 2024 07:56:52 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3FD789283
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 07:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so4700295e9.1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730357810; x=1730962610; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2LwUXhqQv+Iw+QMLEygAkyoahHnM8C9bSd5wJCtXjg=;
 b=jSq1db20RA1X68cjG/20X2D6f+CtbdhRMnCm+6xDyyXRO6fy42DAnKeZ4tqDHygPcJ
 Nz6aeXIKlsdS13n++BJoSViciZ5snGiAwyNGD1GL0fS09vinxaiAEXlOq7y2RZxHi4uQ
 p6TUN0DobdDBjalcT6YAMLWiWDeM86GXMSu6axzsmJ/RfVYyf0IXsOntJIUYngQvOXf2
 2R1h6OOwSMfHccf56h4S+5bLwqvLyLbyHlN96RtUJWuLHp4i/40XlvGdxAK3nc62xhCp
 NpAVCvx/CYIrzyCZ366uDJFk/lLLV33cFPf4rRI6fpabHLmQ/GSTBySq3Ty8JG6MZ0oO
 WE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730357810; x=1730962610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2LwUXhqQv+Iw+QMLEygAkyoahHnM8C9bSd5wJCtXjg=;
 b=nd3KiCrOX1d+MCv65QSfKoccmbS24LALImVRJlOWxkIYWQdgCr1K7mxOXNYprNv4sa
 HXR1frmsSvHEA3m4c0tFmJaCZ+7U0i8k86IccV9V+ei0bFNMwxhlflHA0bumDxAr7pLI
 QrraaKPaZDbPhKT6gb9s64nP0TALaN3VtKQcrwha9Q5x0cnFPlf43Zc6eMimsI7ntUJc
 DBYR90iymVwbPXwrgW9A7EVQFiMtizOkX2fl7KXt/BzUpHDI1C8PZN33UihjphWLVNzO
 Pi0wKtCLxFV6UnkCoIJyyltMRmVkJU3P2+nmAzctJJgRfCLHLZQ41s/zh4lc0f007+TN
 F2Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYFAmh3NaRgKpyR5QOhmJU7HUDeWBiwQcyGF36xHVUWB0dLAwDVsr4BS1sbrOmrVWo9Eolo6I=@lists.denx.de
X-Gm-Message-State: AOJu0YwTqe/d4QnuHsLKUMixUr0l9Bidsnx2i21q3wlXu7x8tN4eIOC6
 TZRBA1Rfz41gsRt7Ghg++XwhvBhta3hkt/K8nZ9wBLHI18DbD8CTcsR/Ut9ir8A=
X-Google-Smtp-Source: AGHT+IG5aPFteT9oL2BJv7UwEufN5PlIyp4QCG4DDIW6OgkSu3oeHpjI3uckuBiqFQd+JkXa+ARQpg==
X-Received: by 2002:a05:600c:4da4:b0:431:5d89:6465 with SMTP id
 5b1f17b1804b1-431bb9e6016mr53370845e9.34.1730357810379; 
 Wed, 30 Oct 2024 23:56:50 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd910357sm44507335e9.11.2024.10.30.23.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 23:56:48 -0700 (PDT)
Message-ID: <f5e21529-00ce-4eb1-b606-e300cd4d6e74@linaro.org>
Date: Thu, 31 Oct 2024 06:56:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Michal Simek <michal.simek@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
 <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
 <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
 <f797cb27-84ca-41c3-83a5-b9044f2d5e5c@linaro.org>
 <3835b139-ae37-423e-8a24-a958ece69c0d@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <3835b139-ae37-423e-8a24-a958ece69c0d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 31 Oct 2024 14:09:45 +0100
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

Hi, Michal,

On 10/30/24 3:20 PM, Michal Simek wrote:
> Jagan is aware that we are using this configuration for quite a long
> time and we are still here and not leaving.

Okay, great. Would be good if you/your team can allocate time and
review/test patches that are improving/fixing the stacked/parallel bits.
Help in reviewing other SPI NOR bits is appreciated as well.

> As you know Amit is trying to find a solution in Linux but nothing has
> been agreed yet. If there is agreement to separate it to own driver or
> so we will be definitely working with u-boot to get it to the same state.

Okay, thanks!
ta
