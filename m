Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5654DC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 13:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8202B875B2;
	Tue, 28 Nov 2023 14:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U72yepZC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32A60875B5; Tue, 28 Nov 2023 14:56:22 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2298758C
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 14:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-332e3664665so3306426f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701179776; x=1701784576; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kYf0mrAnvbWTpBe5+QuF8DYjtIyv+Zz7MPS3RlELR4w=;
 b=U72yepZCDl7ljMu90EQSOt9UOjwBSFf+xCtIp07ggwwMTEXRRD44jk9VSsMsdPyHMo
 vug3ORGmegAyeclSumYWoJ+97Vg1i/Ae0m9go787sltrYEOBxa3O30yZ0Ok3zNp+wUMl
 zccUKDVHipowh6dPwnwHuWt0rac+S/kQD/jbbMg8/SYcVVZ/OSaKv7ABAlJHqVmgBh9+
 odM4niS10YZSEwnos3+ceKaWjClPZYgzuR7U/LfD3z7+z4E1AaTZttiryXfIMnT6hnD9
 GBeoGr8hYBm4A+lLvCp+t3bAI/hcicxIztSOURooWuRsu5LGIwvz0m7jMlyPkpU3DLZv
 naKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701179776; x=1701784576;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYf0mrAnvbWTpBe5+QuF8DYjtIyv+Zz7MPS3RlELR4w=;
 b=DzyjFfZcvSx5UW+uUS/cRjDiznhUMFK+slSxtqw7fT+QcVBUI974Bg2G+7DHwKDsbE
 erENz/GgdfnmU1N8Sem6RUyhTkSq4bj5gqs8XRw7hzHI4hza1mr13T7q9Yw2Q2xF+2UC
 MJ/iUXx/YAGEe7J1Z23qVJCoDPI6HxZrKp9YoDyO2TZ+yFAV/3jd2YRqEtRHUSfpel4h
 3WnGKBzw5h+wklIItvaQnuGIq3LEk7x6vGrslGfWoZiTDT5MUBA3KtZYbRH580Wj2FzE
 CcNg2uuwUYliSIe8OnJ0JGwSksPKQ7Dr1Tj2bO+FEJe2po8xxdU+KhAZ8pdpG4JkdLHW
 vanA==
X-Gm-Message-State: AOJu0YxI4hYmi2SK0tvSQzj4pZxK31TkUG9vdJKdz+RxUvUND5bwJV1j
 lPnSDy6AND4jOS7hSgU73nmJ0A==
X-Google-Smtp-Source: AGHT+IHQlj+Dof6bbqVYCDzbLxHa5qaIjPxGrPc2p5cT0zyg/4sH3E2/7WHWG1IvZ2lAddbdpul5Ew==
X-Received: by 2002:a5d:4ac6:0:b0:332:e42e:6dee with SMTP id
 y6-20020a5d4ac6000000b00332e42e6deemr10949536wrs.71.1701179776248; 
 Tue, 28 Nov 2023 05:56:16 -0800 (PST)
Received: from [192.168.1.7] ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 t10-20020adff60a000000b003316db2d48dsm1741630wrp.34.2023.11.28.05.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 05:56:15 -0800 (PST)
Message-ID: <bd0c4ce1-c50b-4ea5-8527-d20db78359a5@linaro.org>
Date: Tue, 28 Nov 2023 13:56:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] gpio: qcom_pmic: rework pwrkey driver into a
 button driver
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, u-boot@lists.denx.de
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
 <20231114-b4-qcom-dt-compat-v3-2-88a92f8f00ba@linaro.org>
 <CAFA6WYNXrknzFHNvuZxwx1st4NmM_vGr44yBsZoYrHX2kGGYqg@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYNXrknzFHNvuZxwx1st4NmM_vGr44yBsZoYrHX2kGGYqg@mail.gmail.com>
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


>> +                                       pm8998_resin: resin {
>> +                                               compatible = "qcom,pm8941-resin";
>> +                                               debounce = <15625>;
>> +                                               bias-pull-up;
>> +                                               status = "disabled";
> 
> Is there a particular reason to keep the resin button disabled by default here?

Just following upstream, it's not used on all boards.
> 
> -Sumit
> 
-- 
// Caleb (they/them)
