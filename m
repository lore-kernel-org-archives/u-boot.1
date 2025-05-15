Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49909C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:52:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 752A382B63;
	Thu, 15 May 2025 13:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TGue/lQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E12382B70; Thu, 15 May 2025 13:52:38 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8F88006D
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a1fa0d8884so428620f8f.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747309955; x=1747914755; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LUq2b6K48eY+dPxPVJ6c/yNJ7TIwTFPH7RsNJr+1L/A=;
 b=TGue/lQhe/fZFK2v4dqYmAELj2khPoYADXx0Az7bE6fAPidZZWdMUfTf4yVjEONiis
 iufkjiZcm7U/rgRTwrVHRdflI29HwdKuEhgyR4mvAhkJWiDN2z0oQDT8dY8IWJqtXa8W
 SSCA+Zoklu8zQQ4ZH44fX7yum31N8Or5Blc29naaDTIiVevWy75HdeB3Vu8BjCbEq8Ln
 UgMKFJXkAYgi+e0fluXYUSUm4B6Gpw5bEUUGS/1WmOmj3REwgxlt4O9b3LzHcLayGWZm
 IEvKG0FS+8ghwTVSJT/bxte8PDW9mNM7nO/mtu2rWq13vGly2rmdq0yRVnAQdEyHrvt9
 2dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747309955; x=1747914755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LUq2b6K48eY+dPxPVJ6c/yNJ7TIwTFPH7RsNJr+1L/A=;
 b=u5uD2SFb8+0169bib9HVAU6R2WGBQdjimSTLvqN0ZkVl2IX/g2YNevJG4i2a4VtV70
 FU1+56cevN4wQYDsjkX6jLwYxco6e6jUaPr5SWDtanpjzRRtYwCtrHtGUIiIz7YUkWhJ
 yFA5gm4/GlHaynAtYwDROSYatqRai21Xg2TkFSgnjq04EjZbR7Pcc2+sfQRodUSqM3Md
 vjzbwkqblx2a3ez0DEOqoLQK4HiH/NGiOdyysavtb71aaCXjJshNZ9o+dY8k1UNm9Ry6
 KhvsDsu0ccMu0+jAxC5U4BcRgR+vsyHoEh/wwkaeEa249330D8yN+OVL+Xye4Wsyp9cN
 347Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVba3yvo4c7NAILJfHiVNwfkTWmV4bMGPQ8Uuew4vdAmgzWFwTwYdBYsHR1T17r6Nefxag0eIE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt8wnSks1zVIvZoPTYtuRRB7cEa1tPyrSPrMu/SqWFZblW41Ni
 Odikeu7p8JY8DOHEmoHfBH4VECnc9YlZoigu5MGwqlCXJPe8uTixkNobmK0X3VA=
X-Gm-Gg: ASbGncst5XNpf8E1RadgrbV8+TNclf2XVMjzpSq5jJulCYNPvENfIBjqrBGQ9wcqLqa
 ZFaasSDjlhIk6h3KM8UjsbDYxP/7hrsDfHHO2DSodUCESppWEhtDW7kNRefyqTb0Wt93epDE5or
 Qgz8ILueNb6yUSD/DN8G3Er4emzSCqwqcXvXLM2/2jKlhBtnDz6ERXwnDig6AvH2wAhv1DdYoO8
 RaDN1dTUH1ak/v8BdhPovyZjdHUECy6FfteroGT5thm8EyicwEyxYvWXCpakId+fNxt1jbThHFr
 4V0+hEySXWe6OSiletW6snBM9W/HXf2hywHk38k14IDyLpmfT+h3El0tnjNTJeQnRyubtvmH76I
 AUVJma7CXk/w04Mt7iSvD+UgV
X-Google-Smtp-Source: AGHT+IGD0DTdfbd8o6BFsbNRlXR+gqx6LnezkdVLook8zuVV/zyooZa5fBbhj8wgWTgAoCwrolVtOw==
X-Received: by 2002:a05:6000:2501:b0:3a3:55e6:eac6 with SMTP id
 ffacd0b85a97d-3a355e6f03fmr1573857f8f.17.1747309955582; 
 Thu, 15 May 2025 04:52:35 -0700 (PDT)
Received: from [10.61.0.89] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c5a4sm22442933f8f.81.2025.05.15.04.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 04:52:35 -0700 (PDT)
Message-ID: <8b273e29-2339-415f-bdb6-1f6ac35cb4e9@linaro.org>
Date: Thu, 15 May 2025 12:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] global: Avoid indirect inclusion of <env.h> from
 <command.h>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Bosch <stefan_b@posteo.net>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250514225002.15361-5-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250514225002.15361-5-trini@konsulko.com>
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



On 5/14/25 23:46, Tom Rini wrote:
> The include file <command.h> does not need anything from <env.h>.
> Furthermore, include/env.h itself includes other headers which can lead
> to longer indirect inclusion paths. To prepare to remove <env.h> from
> <command.h> fix all of the places which had relied on this indirect
> inclusion to instead include <env.h> directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org> # spawn

Thanks,
-- 
Jerome
