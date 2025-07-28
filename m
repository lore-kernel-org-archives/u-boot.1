Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4602DC87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 14:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E0682E52;
	Mon, 28 Jul 2025 16:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AkLunAwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72B282F6F; Mon, 28 Jul 2025 16:25:46 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC64B82CBB
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7746135acso2092618f8f.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 07:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753712744; x=1754317544; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xKeMrx+2+PSlJCjSzTCEbUlzjFFXilnu4GIRGDAAdTY=;
 b=AkLunAwprZcLmWiSFDQZXGUnEjaFsAQDqCJ4JlN49ZQdo3iGC1ubQdAaV8S+WY2xsf
 bASdUfrDGR9OCN/ctPpMeNZj7oR1+ev6yuEFXOX0wvutXewvLVVWYcMPvNGbv8TW4Ooc
 x43Gk0DVOHeSb/z9ilclBBcrIb1BF3oATA4qXvWW+yF0SaXFu2+T8bs3CynGAAiUIanX
 XhsR7LQmZnVxUPHdHPzelL0lXqmuFCnme/1ZfHfzAG/+rIJ8MTVHNhwajw9itU0eX7ZW
 SolEuL3oO2NXYr0iMjIqTQAwDakFcByu23Pk6DBRkE8ZjLZxe+yP8ce3+g0aUNGBjetf
 EM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712744; x=1754317544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xKeMrx+2+PSlJCjSzTCEbUlzjFFXilnu4GIRGDAAdTY=;
 b=wX+5NFbmR3aNQ1cptqp8wxo0OYiWftL+n2AUozMl9UvF6zaowJRtBg2XTEaO6af4nf
 qsDom9ayk5TRzsuPmP7dmCwwXGXF5D8Q8/0o1AhNUatQC7+HLT/848iNQRgCxlixhUFx
 +SlrM3l7JvWyitnQuk6JIETZhd4+F5heXmFCHlMv8asqM6Cy7xnKP2X1ZnEH+QUI7CSX
 /Z7HWpX8aS0b0BC1bMhc8VO+dq8LBBVWt4mfJuANtkZTFNEeUrZ++ih08sDApvK/umuP
 w7a55P0J4w0iGMB4dZPW4yrnIjK+8XKPTyWjLgqT/huy8Z0P8mtaCvEfpol/so8Di/8e
 0EXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmC6aG4xEyCTIivXb6XffDc6ebZTkBDKL9AHuD3bgHLNTAKWSgDgGH5izoN9h4sfDapOZlTgA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg+kkhfLR496FzzPY/DghgG3Ql55eP8yyqfWg5y4ptylfAeSth
 oKkveCV7pJitHZ9S2jfwFBWfgR6SDDHJCnwxXMKJj6x30ovQVcvIZ3WLWYo+KbF+tzpI0645fNm
 iU2Cs
X-Gm-Gg: ASbGncuZKOhUusVJpN4TLKHfX8ATPWeGU4RgOTTkwDbjJbeVJApOlaYsMsJYPWRWLEe
 YOIhKo5MHTg0m1EMKQXQI15Ku4t9o5VplGE1LGdEk1/TquQzek7XVgrqRxkqctzGC0kgiwzPw4G
 qVbU57CuWLrVqwKcDKVRMLt/+5qmJrRoFsfU0aOcU4pmryKa9gy1pzeTnK3sUoRXjqWNit1PXf8
 aubM2n5XpqQQ5vSfKW2+6JudYR8li0U8NMhV/vdVnjyr+UzJ6+MF7+B4IckiZ55i3eokm5vdctE
 2LhXGLwEECQNfQeXYY2CJpN9B4VjT9FM0n8bqLs7wB218tvvzP63Z1HEO8Fen2wfYKaCwOU4wmI
 Mceu7WCF+olZjRc3rj9KFCTx3Tgl2tNuZBFo8sVXVXWjec4l0a1qi3ASLWTRpdRdu/CdvcLx5y6
 8=
X-Google-Smtp-Source: AGHT+IFvyQHJAoIBKkgsdrMKYaxg/CzYr+3JnhyqJGqtXXlr4LjcH9OeoSy6Ph6MGkXCQ014gB7wCw==
X-Received: by 2002:a5d:64ed:0:b0:3b7:8d70:ed05 with SMTP id
 ffacd0b85a97d-3b78d70edabmr259205f8f.5.1753712744031; 
 Mon, 28 Jul 2025 07:25:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3?
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b783454d65sm6088056f8f.1.2025.07.28.07.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 07:25:43 -0700 (PDT)
Message-ID: <95d77991-77ed-4af5-8ba9-a4acc57e7a21@linaro.org>
Date: Mon, 28 Jul 2025 15:25:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch issues reported for Marvell a38x DDR4
To: Stefan Roese <stefan.roese@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <fbf8148c-1b30-40bd-b709-1b4b6817de4d@linaro.org>
 <d0e95f4a-6870-451d-a730-0eef30ed4401@mailbox.org>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <d0e95f4a-6870-451d-a730-0eef30ed4401@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 25/07/2025 14:02, Stefan Roese wrote:
> Hi Andrew,
> 
> On 24.07.25 18:01, Andrew Goodbody wrote:
>> Hi Stefan,
>>
>> Smatch reports the following issues
>>
>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:1029 
>> mv_ddr4_center_of_mass_calc() warn: unsigned 'd_min' is never less 
>> than zero.
>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2192 
>> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2270 
>> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662 
>> mv_ddr4_centralization() warn: unsigned 'if_id' is never less than zero.
>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662 
>> mv_ddr4_centralization() warn: we never enter this loop
>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:911 
>> mv_ddr4_dqs_reposition() warn: always true condition '(delta >= 0) => 
>> (0-255 >= 0)'
>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:924 
>> mv_ddr4_dqs_reposition() warn: unsigned 'delta' is never less than zero.
>>
>> As I have no way to validate the correctness of the code I am not 
>> confident enough to attempt to make the appropriate fixes in this case 
>> as it could affect its operation. Perhaps you would like to take a look?
> 
> Sure, thanks for all your work on these smatch issues. Really
> appreciated.
> 
> But frankly, it's not easy to test anything in this area. I still have
> access to one board (AFAIK), but minor changes usually don't really
> make a notable difference in the DDR controller configuration here.
> 
> My suggestion is to send the patches (or one patch) "as best as you can"
> to the list for official review. I'll try to review and perhaps someone
> else with access to such a board will take a look.
> 
> Thanks,
> Stefan

OK, patch coming. It was not as invasive as I feared.

Andrew
