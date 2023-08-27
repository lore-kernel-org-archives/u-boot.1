Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2AEC83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 19:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABCF583F80;
	Sun, 27 Aug 2023 21:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYLdo78g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCBD83F80; Sun, 27 Aug 2023 21:17:50 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E5F186199
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 21:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3ff5ddb4329so21481565e9.0
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693163866; x=1693768666;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yKqOrErGq5Vduvi+6POZnt7MsebRO3ojKhurbDdcm/0=;
 b=HYLdo78ge3awQTIyig0xztaP5yeDXRCf8CcPKI6yvXElSFSeX1dgJ61E2dZn8mNdLd
 wvcPHLhR+RBWI1BPLnJpzle0ku02WBW5ldWPpLt/osEbB/eWuroQ0T01ufeXYBWjbyTV
 OZO8kOf4Y+8IenEA3AsRH1IKDfXAorbPqyTbR1N96OSDNtwk8FiZae4yXPWFPlGDNyqf
 6tY0TdyY4mwuH9gYmZW0EOZgfoFJop37bM2JiH0iLYSrmRKd7wL7YqjS1irdB0+K2b8Y
 GTRFJD7xQuO7kiGoJqe4frZIK6bXxpJeIgIlxeF/x0nJU1cIMAFbTESKYy2bC9m6kN6U
 LgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693163867; x=1693768667;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKqOrErGq5Vduvi+6POZnt7MsebRO3ojKhurbDdcm/0=;
 b=G6OZLPL0peoKv0Z80uJc75XxBunyoBKjkW+QtiTG643a7eS44G7a7JyxH0RpIM0OZs
 CaG3/HW/xdNzCS5Bzgb5YwuRjBZxPj9zrvTX3kfkMGSor3GdResOiVVJO87JZFPUdlWw
 HawEVZCyLSSRCpcSMbP5HXwpmGgEQf+OSQsY+KwrCaA94+JG0khw1CxB5WPdkLmFSetG
 ACw2Ry0KPMeJE49W2EaGq2OuUaj7CHia4C7+RagArw+sSE8mIUIWoenvmBlOpTPqysaj
 nhjbQDzO2sp6PnP0s4bXFc3D7y7v1RjYu7eWdirCLdzMyp6nbL27JpjEiXQjWz+JYOPH
 cKXQ==
X-Gm-Message-State: AOJu0YwoG219WfYql4UnMPedg2Ffne8od/2vLiBivXRMGG6eLPW4IsAV
 sILBrsT4CqSicykNh6lYbdU=
X-Google-Smtp-Source: AGHT+IHrhehfPDhPcaSaZSk42BBjuHLj7Ceqgb74PIGCoU3COVJN9VszyfnmxODvboA3wQxK2wQieg==
X-Received: by 2002:adf:e584:0:b0:319:7908:cf26 with SMTP id
 l4-20020adfe584000000b003197908cf26mr21490274wrm.26.1693163866608; 
 Sun, 27 Aug 2023 12:17:46 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 f17-20020adfdb51000000b0031912c0ffebsm8291758wrj.23.2023.08.27.12.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 12:17:46 -0700 (PDT)
Message-ID: <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
Date: Sun, 27 Aug 2023 22:17:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Dillon Min <dillon.minfei@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230824030304.1555547-1-sjg@chromium.org>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <20230824030304.1555547-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2023-08-24 06:02 +03:00, Simon Glass wrote:
> In this early stage of using binman to produce output files, we are mostly
> seeing people using common extensions such as '.bin' and '.rom'
> 
> But unusual extensions appear in some places.
> 
> We would like 'buildman -k' to keep the build outputs, but this is hard if
> there is no consistency as to the extension used.
> 
> This series adjusts binman to enforce just 4 extensions for output images:
> 
>    .bin
>    .rom
>    .itb
>    .img
> 
> Other extensions will produce an error. With this rule observed, buildman
> can keep the required files.

I dislike this limitation. We know what files we will generate, they are
listed in binman dtb, so we can add something like `binman build --ls`
to print their names/paths for buildman to preserve them.

Regarding the output directory suggestion, I think the binman outputs
(not temporary/intermediate files) should be in the same directory as
make outputs, and the Makefile should default to O=build to achieve the
"output dir". I'm not sure if that's going to happen.
