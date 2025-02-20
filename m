Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19438C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C937E80F53;
	Thu, 20 Feb 2025 22:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ut56HcBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D742B806FE; Thu, 20 Feb 2025 19:19:07 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183A480077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-220c8eb195aso26679125ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740075543; x=1740680343; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXYWVizzj0CwoOuHfF0+6S+Lx0kkYXMwCGx5W9tc5fc=;
 b=ut56HcBS+8ELm+7pVnQuSChEPZ4YNPP+EsxlK86LMZ4dADb1WF79zR8Sk4RyESGjwo
 ayhnZD97vO1dDRSsKbx8DiBXFsUAXBfJl3EG55Ah/i1s6D/AUImuo1PuBnoZAlPITAZC
 ZwNV2c2kjQINXqMg5m2mGw+WlVY5mSwM5pWnb0a1dedJoKnbAE1kAdSGUQCPy8Q6gWTs
 Ubc5nkoUKV4MF3/28A0ZTNT5Fdc68sp8udtqFmrhDSGjImv+5c14nmW9bRfDrvXgfXw0
 p6CBm9bZ/CqOWldFWlBPEyhw8PUHHQcENbRgOwU3F0830WwG6Ex4kUi6CxEGmdpMCuHV
 jR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740075543; x=1740680343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXYWVizzj0CwoOuHfF0+6S+Lx0kkYXMwCGx5W9tc5fc=;
 b=NNM7Wq2VVBUU0gwiMWcHISsHFK90amwXfVCq0F9fbk8pdasrEMxv95FUdVhVsDoGjV
 Fl9ogwlbonsTDK1hTbeUsXMqAdyN9YY01QJUaGCqXFQJ5DIxHOj21Q2tR63VdBcPVYTm
 FWTYRiHOtJOI41wN3OTRk/w0pY+l+E0MR6hWz1rFejhB4jQBzuJ/AAV8knfbN7GrBtOq
 rW0skmChWGNyclSqH5FOdEt1P5UY0wVgYinszAt32liR3OcirmHi1d1mv2KKSPvDTklQ
 PRyYvdfIhhCD1E7pkBXout6jAWlnEly5cm5F6a6nq37TSDhCyTSexHBSByqBxIv8ygrx
 oZ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrMLr7tTofxBNsfuGTkxYmUv9Kkt53GP7F7K17FhpFfu/OFE4tjVXBp6x3fpp8fCw7ZH2I3oY=@lists.denx.de
X-Gm-Message-State: AOJu0YzIUIDnvxs+M8Z/PTg+FOCz+vCwasB+cxHmENpXnxTH8MLDAPhe
 kOw2/oGjjcdeHfQKQ7TPwfrHOHZ+2N6ZPtwucyMZUpje4+XTrMha2HHHpCQvWgI=
X-Gm-Gg: ASbGncvnxp8gvOdCY5z1qoBSY6tcKIuzZ/gK3XXHj109r3VQaoOxVuVOFgt1lgmBQaG
 krTMhc24HuqGvSfQvPdxPN162B/PcJKfW5INcVjhGBKyXI8p1EOQ4NXx1JDhZw7dpKMwG7nWSJq
 ZHkEyWlL4Wc9m6YlD4esfdjLKWuE2HgqwQMc19OLEjwm672RynvB856Zd8xVzPt2G6NOyx6IHcQ
 6DXoBK7ee7lK3ymtRRuwakWG/WEaulafDKyKKWsSrQPG790QktPWYqO+0wVLeu6bFPfjlRELhwu
 ItXjyAR2C7r3Vw6FEnyUoDzuF38KbCnp+qd/2lmeIGpBSty18BBQz64=
X-Google-Smtp-Source: AGHT+IHGrbemacPFc91n1kKczs7Pq1ZmXaouQnw2UP49HcQ42bHcvSWkNF3nHHMIgQMHGJhoazdsPQ==
X-Received: by 2002:a17:903:32c5:b0:21f:1096:7cb with SMTP id
 d9443c01a7336-2219ff50eecmr1743655ad.20.1740075543576; 
 Thu, 20 Feb 2025 10:19:03 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349019sm125048885ad.36.2025.02.20.10.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:19:02 -0800 (PST)
Message-ID: <2fc6d515-3f72-48e4-8913-b69501b3f144@linaro.org>
Date: Thu, 20 Feb 2025 10:18:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm: Prepare linker scripts for memory permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 mark.kettenis@xs4all.nl
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Marc Zyngier <maz@kernel.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Edwards <CFSworks@gmail.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Alex Shumsky
 <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
 <20250220135506.151894-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220135506.151894-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

On 2/20/25 05:54, Ilias Apalodimas wrote:
> Upcoming patches are switching the memory mappings to RW, RO, RX
> after the U-Boot binary and its data are relocated. Add
> annotations in the linker scripts to and mark text, data, rodata
> sections and align them to a page boundary.
> 
> It's worth noting that .efi_runtime memory permissions are left
> untouched for now. There's two problems with EFI currently.
> 
> The first problem is that we bundle data, rodata and text in a single
> .efi_runtime section which also must be close to .text for now.
> As a result we also dont change the permissions for anything contained
> in CPUDIR/start.o. In order to fix that we have to decoule .text_rest,
> .text and .efi_runtime and have the runtime services on their own
> section with proper memory permission annotations (efi_rodata etc).
> 
> The efi runtime regions (.efi_runtime_rel) can be relocated by the OS when
> the latter is calling SetVirtualAddressMap. Which means we have to
> configure those pages as RX for U-Boot but convert them to RWX just before
> ExitBootServices. It also needs extra code in efi_tuntime relocation
> code since R_AARCH64_NONE are emitted as well if we page align the
> section.
> 
> Due to the above ignore EFI for now and fix it later once we have the
> rest in place.
> 
> Acked-by: Jerome Forissier<jerome.forissier@linaro.org>
> Tested-by: Neil Armstrong<neil.armstrong@linaro.org> # on AML-S905X-CC
> Signed-off-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> ---
>   arch/arm/cpu/armv8/u-boot.lds  | 59 +++++++++++++++++++++++-----------
>   include/asm-generic/sections.h |  2 ++
>   2 files changed, 42 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
