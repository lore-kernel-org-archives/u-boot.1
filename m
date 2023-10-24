Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C90C07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 19:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D3787056;
	Tue, 24 Oct 2023 21:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oJ1KslY7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A542E8747C; Tue, 24 Oct 2023 21:52:27 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87E3A86FF3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 21:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40853c639abso35272265e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698177144; x=1698781944; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J7zT/CCW0q+VHD6rtydD3BpKF7+0oYtAwGjInLPDJGc=;
 b=oJ1KslY71VjNIqxNuxkUxwNaE9/XFQk9Uf25IesnEe0/ltSJzOpKwXvCn+XRjii78l
 MUsDH+NXRrz8AK/MGspG2ZOOlyHJpvIN6KN1BNDAv8DJMjTaR9dXdlC4GdewXDvsUC24
 aT1eppYP9Vlz7KmmcgvKSVoW37WvfvXFsIB70anMfGSj+2IBhW1YAQejmnhaJ9EXYa8m
 yNy9b5S1iniwSw8x+b6MTUWagjzKd7VH+iVVBiseVlXgH0vqABaOfUSRmWKbTJaNxCiA
 90MYuJ+MvBYFkWYAVTz5yCi1s3yENVU8gWCyax2QKDjCUfZQT8nMGkj59R6aeqnwtR1b
 pipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698177144; x=1698781944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7zT/CCW0q+VHD6rtydD3BpKF7+0oYtAwGjInLPDJGc=;
 b=djeQ6jFqcNgj046wg0NYYzL1cVIxa4jVW137D2L9Rec21qSNytCo/A9cAsOau+9Ahs
 XLAJFNv81NzP6/BozSHrb55JEaXIDIL5RhtzwUXyHRd37YL9QtpkablPDHYnrBJA11WV
 1qWqU7VjS+1QblrqLmZ49Jzj3XNuXTfbY7oPK2RMvSJvfFZfjQ/ylAIZyZ5+/CaurMGl
 xHE1aEpeqL6mQ/rnm8kP/yEcyJ4iOm59Mj9ICefe8YIW30zRDjyCuuPCrA0TIk7nQQEc
 c42ZvGwn4lGyy0U+GO6jGZ0Xb97eEcNUTRuRa6wEQ8J9WqfulzhUYFqbFnxatYwKc9HR
 RTkg==
X-Gm-Message-State: AOJu0YyMhPdQIKiqIeXIj4K3vmg4aknsO7wUsImjbFl4hctuQzLOrZVa
 mbFcCrScIzzmf/4reTkPy2IkMg==
X-Google-Smtp-Source: AGHT+IHVCFnkFV/zbkVnqoC33k0AMANbir4zi2FpXXRokFJ3ySjWPCBX0a4S/xRENN9tn5I/06mX7w==
X-Received: by 2002:a05:600c:a47:b0:408:39d3:a26b with SMTP id
 c7-20020a05600c0a4700b0040839d3a26bmr9647384wmq.40.1698177143866; 
 Tue, 24 Oct 2023 12:52:23 -0700 (PDT)
Received: from [192.168.1.15] (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c2e4c00b0040648217f4fsm17410855wmf.39.2023.10.24.12.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 12:52:23 -0700 (PDT)
Message-ID: <a4979be1-2267-4cfa-b412-f66e7455258b@linaro.org>
Date: Tue, 24 Oct 2023 20:52:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: init: add an option to use FDT from previous
 bootloader
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20231024-b4-prevbl-fdt-v1-1-541f71dba802@linaro.org>
 <20231024192530.GH496310@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231024192530.GH496310@bill-the-cat>
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



On 24/10/2023 20:25, Tom Rini wrote:
> On Tue, Oct 24, 2023 at 12:32:35PM +0100, Caleb Connolly wrote:
> 
>> Add a new config option to allow u-boot to reuse the FDT provided by the
>> previous stage bootloader when available.
>>
>> On some boards the previous stage bootloader can populate
>> platform-specific parts of the devicetree such as the memory node, this
>> allows us to avoid hardcoding it in u-boot and instead determine it
>> dynamically at runtime.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>> This patch will improve generic support for Qualcomm boards by enabling
>> us to configure the memory map at runtime rather than having hardcoded
>> maps on a per-device basis. I've gone for this approach initially to try
>> and avoid introducing board specific code where possible, but I'm happy
>> to rework this into mach-snapdragon if that's preferred.
>> ---
>> base-commit: e65b5d35c9116485366bb08138043d51220551da
>>
>> // Caleb (they/them)
>> ---
>>  arch/arm/lib/save_prev_bl_data.c |  7 +++++++
>>  boot/Kconfig                     | 10 ++++++++++
>>  include/init.h                   |  9 +++++++++
>>  lib/fdtdec.c                     |  7 ++++++-
> 
> So what is different with this instead of using save_boot_params ? I'm
> not saying this isn't needed, but I don't immediately see why
> save_boot_params + (OF_HAS_PRIOR_STAGE=y&&OF_BOARD=y) isn't the solution
> to the problem.

OF_BOARD would work here by implementing board_fdt_blob_setup() for
mach-snapdragon, my hope was to avoid doing this in a board-specific
way, but if that's preferred then I can totally do that instead.

I left a comment below the patch about this, although it probably wasn't
super clear.

Thanks,
> 

-- 
// Caleb (they/them)
