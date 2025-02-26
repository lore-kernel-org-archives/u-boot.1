Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E49C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33383801DE;
	Wed, 26 Feb 2025 12:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i3EkNbsI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48EB580805; Wed, 26 Feb 2025 12:04:34 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7254880077
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so2576510f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740567871; x=1741172671; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jqOrygzuL08fzlgqvHTlWBjyrrMf2ZEZtCj+iL6dGSo=;
 b=i3EkNbsIBJwEy0Kxf3cswvFB9I4GJYUSq+zXXCdr8p6tgT97j2h8WzM4/p5sW8JmVN
 2G85p/NMrQx3YxyGzM0KR15pkyRbAXVpeNCLfAb8rr8+dTMoiIseXsrw7jnwb8ifnjyr
 roe3NKzM/8zl+F62bkF2o81OvQgWOBnYQefA3FA7jT7dBHrIvDHIEa+jXIXMJrAfDbTP
 Wpo74SMUyEyODQdKLay3VrTnMxDdOdJHFYJJABcISlH1bLeOhDEUJHc3/dRcW5SZ26QG
 4CfrxklaoLPHmW8yjy7GfSZso2JIXD2TkVgDErvR5/aEjczF2nv719Iqksjfwi/Fs2RF
 Ieuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740567871; x=1741172671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jqOrygzuL08fzlgqvHTlWBjyrrMf2ZEZtCj+iL6dGSo=;
 b=TDRp+bjPPo0kiJa2FcSKFgccOxxHCGR7tuf9gp/gxty8xj5O7LZcj7FOP9AJrdS+aC
 4PkfAXa8JxKuNm8IQov/TsWbABTsCOZqz68jDDUw7a9BaSRr9JzpoAEy9PvD5+1lo/9b
 u7m0ddYFPVgjdoFMAV16hSSfP6CP1BC3/g3yGmNy2aeOKT1ihRDvZhe92S1Pa7X4u5QG
 ywnXByAphIT+Ggfy6xtzTmX3d4Zl0qwak9ZhyeXTWBa6PhIDrm/e1bNisEhEkvQ4428R
 xNneXixSwGDs5NxVO9fD4Oj+1SongnWG1Vyue/0hmUL2p/72Sc3PPe7CckOO607mb4kL
 FCOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgz4//LpDQB5itUOcDVsATdjG5h2C9DFXJ9HBYtmpVElvtJd8VHqsGaoJDDRmgyB+FJ1sXsHs=@lists.denx.de
X-Gm-Message-State: AOJu0YwizmWmhuvJrV0v1YGxZF860xJB9+zk97eI2W1Xys5ouc8YMjQs
 d+wux0EgF0Yf+tYGIlO1kBAURCKJHdMnCBG9Q6ELwm5Cgyhsv1uXUJxbwS7AcbU=
X-Gm-Gg: ASbGncv5EGc1TA58pNyszbeJjlzODP7kW9zaElfTfxZaAV4Pe35OuuDHIj5EBSdmZ49
 aWnnhYP+nZqcYRSXraAMlYCGUxXqAc9IBUL0pSm8AymWAuYf/33QCieLrrqoOkg3KgDfWDv7XW1
 HZIxS/pv/92oS5EdS1rEcNjpveWiSfjYBICF60NW2w5JkjMCLpZXJEGV7Td390I+l2H9hYNNghV
 Iv6HYfGkhxA2zbUlpaU8DGwzWiAQ8HARfrBOajOZrYpKzxoVxGbeNgmk4cmQNELD63eMCHecLFx
 9I04JinDepJ6r29U2cSzmqlYY1+eHIMntfrPyt3CbKYND9BAHZOH8cy0hMOcB+liST6pjt4pRF/
 zhjvp6iU=
X-Google-Smtp-Source: AGHT+IGEG4P1wrQTCmRcQo3/HiB17eczmrbCypLZnNk42/8N++Ow7CxzKLdmhW3EHJvcFCGWaxY9Yw==
X-Received: by 2002:a5d:694d:0:b0:38f:5014:22d with SMTP id
 ffacd0b85a97d-38f6e97a02cmr11537815f8f.30.1740567870798; 
 Wed, 26 Feb 2025 03:04:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:8f7c:8645:e842:b70f?
 ([2a0a:ef40:1d11:ab01:8f7c:8645:e842:b70f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fb50asm5095801f8f.82.2025.02.26.03.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 03:04:30 -0800 (PST)
Message-ID: <cafefdb1-f6fe-4100-bfcd-9c8d98568dd4@linaro.org>
Date: Wed, 26 Feb 2025 11:04:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Support to run U-Boot on sc7180 Trogdor Chromebooks
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <af7c7c35-04e0-4374-b99b-addeec485619@linaro.org>
 <CAE-0n502oMFrpxpu1bdh2zGj4--SybHbAPE1ndXr1f90vTme1Q@mail.gmail.com>
 <c39b654f-c93d-42d9-aedd-ca06f1d9169c@linaro.org>
 <CAE-0n50U4c+9Y7uOBT2Go5yobBZwXmK63XhiUze6XoOid83ggw@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAE-0n50U4c+9Y7uOBT2Go5yobBZwXmK63XhiUze6XoOid83ggw@mail.gmail.com>
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



On 2/25/25 21:49, Stephen Boyd wrote:
> Quoting Caleb Connolly (2025-02-24 06:30:43)
>>>
>>>>
>>>> you might have some luck booting pmOS, we build depthcharge compatible
>>>> images for trogdor
>>>>
>>>> https://images.postmarketos.org/bpo/edge/google-trogdor/
>>>>
>>>> There's also a generic ARM64 EFI image that should work. You may need to
>>>> edit the image and remove efi/systemd/drivers/dtbloader.efi from the ESP:
>>>>
>>>> https://images.postmarketos.org/bpo/edge/postmarketos-trailblazer/
>>>>
>>>
>>> Cool thanks for the pointers. I'm loading u-boot as a payload from
>>> depthcharge so that I don't have to remove the write protect on the
>>> flash. It's the altfw boot method.
>>>
>>> I tried to boot the Debian ISO from a USB stick but it looks like the
>>> FDT memory node isn't modified when I use u-boot to load the DTB from
>>> the one flashed to the eMMC for the ChromeOS installation. Does the
>>> efi_dt_fixup_protocol run in that case? I've never tried any of this
>>> stuff before so I'm learning while I go.
>>
>> The /memory node isn't used when booting with EFI, some EFI table is
>> used instead. I also don't think we use the DT fixup protocol in
>> mach-snapdragon so that should be a no-op.
> 
> Oh right, thanks. It's been almost a decade since I booted anything from
> EFI :)
> 
>>
>>>
>>> I've been using this sort of flow to read the DTB from the FIT image
>>> that chromeos has:
>>>
>>>    bootflow scan -l
>>>    bootflow select 2 # Select the MMC partition for cros bootmethod
>>>    bootflow read
>>>    bootflow info
>>>    fit=$hex_address_for_FDT_from_info_above
>>>    imxtract ${fit} fdt-22 ${fdt_addr_r} # fdt-22 matches my board variant
>>>    fdt addr ${fdt_addr_r}
>>>    load usb 0:2 ${kernel_add_r} /EFI/BOOT/BOOTAA64.EFI
>>>    bootefi ${kernel_addr_r} ${fdt_addr_r}
>>>
>>> This seems to work to get me to the installation menu but then when I
>>> run installation the kernel doesn't boot and it looks like memory hasn't
>>> been updated per the earlycon info that I see. I'll continue
>>
>> That's weird indeed.
>>
>> I think once the FDT is loaded you can just run "bootefi" with no
>> arguments and it should pick up the USB drive automatically.
>>
>> If you have some logs I'd be happy to take a look? You can find me
>> @calebccff in #u-boot-qcom on libera.chat
> 
> I figured it out. There were 2 problems with Debian. First, Debian uses
> the coreboot framebuffer driver and it is missing commit ecea08916418
> ("firmware: coreboot: framebuffer: Avoid invalid zero physical
> address"). This causes the system to crash pretty early because it tries
> to create a framebuffer when coreboot doesn't provide one. The second
> problem is that the kernel is so old on the netinst ISO I was using that
> it doesn't enable any drivers for SC7180. I can block the coreboot
> framebuffer driver from loading on the kernel commandline but then the
> problem is that the mmc can't be mounted and the serial console doesn't
> work because things like the clk driver and pinctrl driver never probe.

yeahhh distro support for qcom is still in it's infancy really, at least 
on pmOS we can mostly rule out missing modules for this platform since 
it's already for sure supported.

> 
> I tried flashing Fedora 41 Workstation to a USB stick and it "just
> works" after loading the DTB from the FIT image stored on eMMC. How is

Nice! Glad to see Fedora has the right options enabled

> this supposed to work in general? Should I be storing the DTB on disk so

The SystemReady approach is that firmware provides the FDT, if you don't 
pick a DTB then the one that U-Boot itself was using will be passed 
through instead, this ought to work assuming there isn't too much churn 
in the DT upstream (and assuming you keep U-Boot up to date, I'd really 
like to spend some time on LVFS at some point...)

However, acknowledging the limitations of this approach, there's a few 
pieces that move together to try and load the DTB from some well-known 
paths on the ESP:

1. efi_load_distro_fdt() - this is called into in the "bootefi bootmgr" 
path (which is what you should be using fyi, see also eficonfig) if you 
don't provide an FDT explicitly and will search for $fdtfile in /, /dtb, 
/dtb/current, and /dtbs. This works on a few distros but not e.g. debian 
which puts everything under a versioned path.

2. $fdtfile - the filename of the DTB to load has to come from 
somewhere, in mach-snapdragon/board.c we have some basic logic in 
configure_env() which tries to piece this together from the root 
compatible array.

The $fdtfile logic is not flawless, it only works on boards that follow 
a specific pattern in their compatible and filename, it just happens to 
work for most of the basic ones. I would be happy to see this logic 
expanded though.

> that U-Boot can pick it up somehow? I don't really want to write the
> kernel's DTB to the flash, but I suppose I could do that if necessary.
> Eventually I'll need to parse a FIT image looking for the right DTB that
> matches the SKU and board ID that coreboot tells me U-Boot is running
> on so that the proper display bridge is used. Right now I'm just
> hard-coding this all.
> 
>>
>> Ahh that's annoying, Coreboot doesn't just give you a framebuffer you
>> can write to?
>>
> 
> Yeah, on ARM64 coreboot leaves that up to the payload. Once the DSI and
> DSI-to-eDP bridge code is ported over to U-Boot I should be able to get
> a console on the display instead of over serial. I'll work on that next.

-- 
Caleb (they/them)

