Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7A0C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 19:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B024A8814D;
	Fri,  1 Mar 2024 20:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxvnbrH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1AB88147; Fri,  1 Mar 2024 20:31:34 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15BA68814D
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 20:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d7b8f563eso1463620f8f.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 11:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709321490; x=1709926290; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w85y9oaIQjDlzBwbpflCbtK2AJ5lrRO35ICTsA8deg8=;
 b=qxvnbrH3GJQpwzzmADie5uIRYZc0Zz2p7fP9OU+NSpsWRkusJRtImAaWlUt9erXdOp
 9IDqvLZSF/VqRIQY0INL+IERk6bOxV417yHeNlTeDOvkTvFSm/1fCwOg3/sxZnbkuYGT
 w6TJc0y8zYQ0BBrO1lajD2xYsRkQ8sFdiwCbW2aWHeWpY9FWfhUcY4iLPE6ibT0y6PsM
 vD3Lgqy3zYKXVG0hWgqMdFUlNQfc1vMzZmkfIg98JNd62vE9Tm0uBRaGS80j/g+j9+n1
 vv29GA5jMHy0h4XTxFqcc12gB6sNslqF4PLlYf6lBNgmrBjOSVxT01wsQo0+iPSM/UvB
 3hgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709321490; x=1709926290;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w85y9oaIQjDlzBwbpflCbtK2AJ5lrRO35ICTsA8deg8=;
 b=HYloMeOPeyfAk3GxzJUBLsBjHv4JD5JxG3Jkkx5IvNTdgO2+P0D4bLobFJFxh6eqN+
 l8sSLJPE0dATaKdw6HHF7py+8XkfOuzF2tV23iq84V5B1i3WuZ4VLWPDYcKYxGaOQmNO
 mDYuTQtB9c9ofkLN5d7p7AR+7vFouBGyqr7D1k8QzBCl8r6+xA+1Ij0q23hfUL2/HyVx
 mlaMnEow5dVbSHP6LStBvUtyjNg0aWg6+csQGl6Ilb4cI/GlIOpoRTG8yJZ09B1lOnBV
 g7eW7AtwQ97QNs767qLOZoco9AdUNICQ4jlER9YERDBl10LnBki0a0o2/o6gUWyUsTVs
 pf5Q==
X-Gm-Message-State: AOJu0YwvKIS9S4MIMM2hR4vOO8gW5URKRPVgzPNrONO1glL4a+2S/5dr
 fVW68FXhO4ey3H2xpMXw6D92Uf99eT/hxHybiHTo+ANYlh+yxN1qS0GKUV8RXQc=
X-Google-Smtp-Source: AGHT+IF28pOXNHsOkql4FD5s6zBg+H0XXhLR5fJSJRwI333THxWCrKk3mxjYPuY4zvOGySrNrYI6lQ==
X-Received: by 2002:adf:dd89:0:b0:33d:2775:1e64 with SMTP id
 x9-20020adfdd89000000b0033d27751e64mr2069953wrl.27.1709321490370; 
 Fri, 01 Mar 2024 11:31:30 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a5d5052000000b0033cf4e47496sm5263952wrt.51.2024.03.01.11.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 11:31:29 -0800 (PST)
Message-ID: <c2dcee0d-336f-4042-89c7-4d60f3a498cc@linaro.org>
Date: Fri, 1 Mar 2024 19:31:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] clk: qcom: add driver for SM8150 SoC
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson
 <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-6-volodymyr_babchuk@epam.com>
 <c1dc5e6b-7289-4671-ba55-1a26add7e99c@linaro.org> <871q8t6bbl.fsf@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <871q8t6bbl.fsf@epam.com>
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


>> Please reorder the patches so that the power domain driver is added
>> before this so we don't break future bisects.
> 
> power domain driver is added in the previous patch: "[PATCH 4/8] clk:
> qcom: add support for power domains uclass"

Ah, my mistake!

>>
>> Just in case it's useful to you, I have some work in progress patches
>> for dumping the clock configuration, I hope to upstream these eventually
>> but in the mean time you can find them here:
> 
> This is what bothers me now. Looks like I jumped in the middle of your
> USB series and Sumit's Qulacom device tree binding series. I don't want
> to interfere with the ongoing work, so probably I postpone posting my v2
> unless at least Sumit's series are taken into the mainline. On other
> hand, there are couple of patches that are not directly related to the
> SM8155P-ADP, like my fix to the clock driver or already mentioned "clk:
> qcom: add support for power domains uclass", which you can reuse. So I
> can post them separately or you can include them into your series if you
> want. What is your opinion?

The big conflict is really just the board support stuff and DTS. The
other patches would definitely be good to have.

Could you rebase this series on top of qcom-next [1]? The big series has
gone in now (and should be in U-Boot next shortly) so we shouldn't have
to delay yours.

Your last patch introducing the board support will conflict, but you
don't have any heavily board specific features so it should be pretty easy:

* Drop init_sm8150.c and sysmap-sm8150.c (everything they do is handled
generically in board.c)
* Drop your changes to mach-snapdragon/Kconfig
* Delete board/qualcomm/sa8155p-adp/Kconfig
* Replace CONFIG_TARGET_SA8155P_ADP=y with
CONFIG_SYS_BOARD="sa8155p-adp" in your defconfig
* Set CONFIG_SYS_CONFIG_NAME="sa8155p_adp" (or rename the config file to
use a '-' instead).

It's now possible to use pre-processor directives from defconfigs, so
you could also rework your defconfig to #include "qcom_defconfig" and
that way only have to define your board specific options, but I guess
there isn't much room in the hyp partition so you might not want all the
bells and whistles - totally up to you.

If you could split this into series, one with your fixes and drivers,
and another adding the DTS and board changes I think that would be fine.

Regarding the DT stuff, you probably drop your sm8150 DTS patch and
instead select OF_UPSTREAM for ARCH_SNAPDRAGON, I'll likely send a patch
for this soon.

[1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon
> 

-- 
// Caleb (they/them)
