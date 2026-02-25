Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9032AFCEE91
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 12:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E16F8366F;
	Wed, 25 Feb 2026 13:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="X0Zgnp3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E31483AA9; Wed, 25 Feb 2026 13:03:39 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFE182A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 13:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D30B13FB6B
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772021016;
 bh=HfZBWjqxzh/3+iVVUIGZnjHGk2rb5zzLZBKXnXW5cgA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=X0Zgnp3iRDJcvqHe97vsvPqXbANeinz7zqmeqvfBje2v0WCK9lVWplzPXW9cdnV23
 frSsEX21eJ4HpmvYLaDjknDm64BTVb1BQPfTm2RLdV2NtXf5AJXv/Bvk5SfnF5Zl2n
 BUvDBa6ZFTEqapndFtM8FypmlRFM34C5Ei3ZS+e/mTsTTEotrcWVDwlBR+yHIov+B6
 czSrEiWDyAZJ1dFJMOH8IJ1ZrYgIEoGoB3EYPDHKcwE4RQhLDOu8KlKQrWtpv9oJPy
 3bnaT0DMt5SBGFw9+Y9N/PMdTeccEgdlFexlwbSedA/PCgEst2/lU6vyPpimsFMRXN
 8zqP8fZUi9sHmDvph91HWPYr4NLTvOMfKMZzORhVgRxXzHoStfIVyk5YXSBwaOF7uX
 5iBGFWD6K7dsbDM5unXWWW57a/1qTT+9fjMZmBL9sOCRen6yDot6voLqFqCPRqs1MQ
 TcIyopJHthIUVhdcStxerRQsvYqvDI/yCgkc9xEWXYPPFldrx8O0wQ81AJhgG0LZAy
 DYxfxtew3St8th+gUYJr2fGDu3FdkRoMV+M6t8EYgGDDU+H4joP5SlKdSJ/AnQHSM6
 Gv2RkLlYIUpYtHrVd9G7fB5lPSS19zCz14PXnwOA5iggxf4YEN9ZM+8EoX7fGpimRB
 YdRW0OmpjkGy9DmUUgbm+97E=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836cf00787so11201715e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772021016; x=1772625816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HfZBWjqxzh/3+iVVUIGZnjHGk2rb5zzLZBKXnXW5cgA=;
 b=PEZLUENloBJU2D9mdM4vNCxanAoYcZ/gQ6IVVdwT9W9OpgVQPN/e3YjHHbcKM8COS9
 RvRP0npZ8yfwJlm4RC8QN+vWMR5yecOPMLeaBL+gorO0h5/cpSvEn4x97OOseeRstA4N
 FMjm6vR581rQyhNVOL/OEXLSVxjPoCW5sg8lR91gtkv9G/Oa1Nwq+R1JAE59RkKW6thv
 4W1nIJvU6SsviPTKO21D/q2bZZtaOM4TxApl62ryizHVwr2YDxj51RjHoA3V4/phoOwH
 ZlylgTUKpmGQhOgX2L1R6U/7kTCXJxbqo1d6FFyAbhIcSfTN/eCqzwwLE0YmyRcAOtZ9
 IKdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYqBvxlcdaTs2BFH6IRsP3xunscpjR24wheXkjN4yQjlH4jFSvM0Eg/NYmDgu0Sxzel+rFonk=@lists.denx.de
X-Gm-Message-State: AOJu0YwrAPbdGOT72d+Qn96pLdqAmdZ9uwy4NBVNuXSRtd5GSTDDtxoD
 ZmhlXqf7Niu7oYqCDF6CRS0CDkp/xeSs9BHgiJbIHm5BF0SSdkQZ5OptRAaaXJ4kk/ywNU3K9V3
 ZZDcBRzHTdvgMvJbSWtD3J0lFo2d4nZFjMBB/GL/E4zmE/lPEtx8g4wkS5zsD2xgVMpnOla6cmq
 egbQQ=
X-Gm-Gg: ATEYQzxRPLk1weobgO8qnqOfJI7Yxsjh63PE9oR/PAh95JPxWEq7/eAevF6FT9Hbgda
 2u5e7mfTYgBWpctXbTGkyyXnHlpiEoTrIoPv2mNoufiTQXlwnVBjlm6ZpQJYhW6+SD5Ds5mbSio
 dLrbLhMiz8wuVOJcxfF7QzSlK8Puwbxsqp4xjRBzcGjlFdroWpOfevtFn2AJyPqyeXAqpCUzSRq
 THf9bY/rNI4uLvHdSSGlsYoyIhzfTes5Rms9D4bCThS2zeOVc4RnJlSGG0y06rvoCzYJ7dx8x26
 FfzcgTREx3JT2F8qRJwOH+B+4iYfOPwYqJt32K/Gv+m7GShZEH3/hOdniCgOAaR7uHKJxOJdlXH
 QrquLVVqebE1eGy6PzfFI+4cKLmeNAiVyq7vSSr4L4jUylqNbaANFek4S5af4xacoN/FsZAovLZ
 XweZFu7O+zUMRyPvC8qtcdMGD/5d7bUoAzLosSku6E6xqLsoTpeUE=
X-Received: by 2002:a05:600c:3414:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-483bd713545mr37529345e9.3.1772021016424; 
 Wed, 25 Feb 2026 04:03:36 -0800 (PST)
X-Received: by 2002:a05:600c:3414:b0:47e:e051:79ee with SMTP id
 5b1f17b1804b1-483bd713545mr37528965e9.3.1772021016004; 
 Wed, 25 Feb 2026 04:03:36 -0800 (PST)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e6c9sm52663485e9.8.2026.02.25.04.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 04:03:35 -0800 (PST)
Message-ID: <7ac69957-8fe5-4d14-b849-3d410868b0fb@canonical.com>
Date: Wed, 25 Feb 2026 13:03:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't
 exist
To: Conor Dooley <conor@kernel.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260225102831.48857-1-heinrich.schuchardt@canonical.com>
 <20260225-bagpipe-jellied-de21366481df@spud>
 <6d35ccaf-3276-435f-b953-8023985f31f3@canonical.com>
 <20260225-scooter-dutiful-6ee0efe16a8d@spud>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225-scooter-dutiful-6ee0efe16a8d@spud>
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

On 2/25/26 12:09, Conor Dooley wrote:
> On Wed, Feb 25, 2026 at 12:00:13PM +0100, Heinrich Schuchardt wrote:
>> On 2/25/26 11:40, Conor Dooley wrote:
>>> On Wed, Feb 25, 2026 at 11:28:31AM +0100, Heinrich Schuchardt wrote:
>>>> Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFIVE_CLINT.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    arch/riscv/cpu/mpfs/Kconfig | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
>>>> index bcf1ede818b..8054313d182 100644
>>>> --- a/arch/riscv/cpu/mpfs/Kconfig
>>>> +++ b/arch/riscv/cpu/mpfs/Kconfig
>>>> @@ -6,8 +6,6 @@ config MICROCHIP_MPFS
>>>>    	imply CPU
>>>>    	imply CPU_RISCV
>>>>    	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
>>>> -	imply SIFIVE_CLINT if RISCV_MMODE
>>>> -	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
>>>
>>> Is this correct? Does it not mean that I just didn't update these to
>>> match the rename done in 9675d920278 ("riscv: Rename SiFive CLINT to
>>> RISC-V ALINT")? My original patch I think predates that rename, so I
>>> probably just sent it on without testing these since we don't use SPL
>>> or U-Boot in M-Mode. If the generic CPU wants them in these scenarios,
>>> then we do too, so the renamed versions are probably a better fit?
> 
>> MPFS boards neither use SPL nor do they run main U-Boot in M-mode.
>> (SPL_)ACLINT seems irrelevant here.
> 
> Fair enough. Should cite this though in the commit message, to explain
> why removal not fixing with the correct symbols is the correct thing to
> do.

What should happen with non-existent MICROCHIP_QSPI in the same file?
Is that meant to be called CONFIG_MICROCHIP_COREQSPI?

Best regards

Heinrich
