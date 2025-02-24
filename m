Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7CEC021BB
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 14:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E11780EC0;
	Mon, 24 Feb 2025 15:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dTAacces";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52D080F3F; Mon, 24 Feb 2025 15:30:49 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8A48081A
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38f24fc466aso3410646f8f.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740407446; x=1741012246; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrBo6wQ8ZyqATF+prkLRlmajKQj/05G5DKIgACBeVeQ=;
 b=dTAaccestU24CNIG+l01G5CFVhM6tU2PwW02I/kIuoLrtNRTnNx/ms/XD3o03JmGWa
 ryKGTtVL86CTfrFeUh/M79uIAoGlnJy0t8kI1O3AqOKogW1iENSTjyWybEUspVAmOGQo
 4i4Os5Uexy0IRZ96oy88Yq2b0jbxc2hmfdg2Mnb1zQRTn9xNERCDWJrHzxjwoq8EYTYN
 KEp9rl+xHdbi0E7CUdZYAcnQM4OhLLlxpiHDPlxgW3//skkc2/7vsPsTOUokYZBh78PW
 0gj36LqJDf9vnxQavhoqPxGB3BusN7p/svz1ZzUDHX9HD1GJsP7qlDkTHtM6aZ2/bhdf
 kN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740407446; x=1741012246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrBo6wQ8ZyqATF+prkLRlmajKQj/05G5DKIgACBeVeQ=;
 b=o4328vN3rQwrD9pivSRQNetD+Hs+51+W6Xga7jfo2Ang7OIJJKftBr1zQP+VrApXYb
 ZXnfidmfjfF40K5ekr54jI6weJPiZTQ/XoRJd6k3hfVYrVeZ5yHO9nXBIca0bF2jSiw5
 1fRWo+0S+DogyDTlD2oKsUeUYac2f+QRvLzWskfhugGbglKnY5ekPQQVToxTYhQy6Edg
 H7ythxxP3h3skeUu4Ue+4TZBggpdxrHy+2/6SMKzwaqI/3guHpwoKC7bjO61/ntZbsWJ
 i9igLnpiOajK6yj4uoxvyVfx5btCQFYKAj55AGPsgdfse4O1j9qqQboRUo6Sj0zUvjBw
 pZYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXQl5N/SQZ91ZGquygZ9yIUiaX32cZ3hkGLfYIxPxMktsh4op4o2C60dsWglH7lTVHuKaFImg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7dAzTIe4MujWhSzGmcnTE1w3X5LjJUyBKuTKLLsDiY3oCq4nf
 BumxJfCDvZLbovShAlU+d8nYI3/RXYf5/0HejRVrEK2s67LK4EszuQN/zt0or7PeGl2PPCon/ee
 DoFvZpw==
X-Gm-Gg: ASbGncsdCDQazUqKcJeXYWXw3I8gcUVpOVjBptsqeG7oxKbSHD6RARUKJptgnByKcOK
 9udENL9dxAkj5hOYhMMSntAUednQLU12wrdFZMKPRxJQcpc0DtU2ftZnzy4vw7wIv3Qby4Lo8XZ
 7ljgYH86ko10v8k+MTvjT3IQJHLsanSeZyRbeGSBj8rvSBLdhp8eDqFReR9LfJ7na7Jb89RUTKx
 jObxEV4wzr8/2bzdioYF0E6drLK4Xrgye/Be7yd35B/E/LNRE/jhpKFzwhIAm2s35pLH/p1DNcC
 AAY1fjs6ENUwJusUf91EH4AUwfIHyEZpeGhR3vUkhRvJJSi2b5mZRJqJ2lVHUk/tEvxKmNtFsjE
 6S7h2XI4=
X-Google-Smtp-Source: AGHT+IFcXPTEBFpraOZdOYsyrKvUV8jDIxFMgCKEJszfy7/1NF1049llcUAxKdJwHU7HLNLbCINoHQ==
X-Received: by 2002:adf:e309:0:b0:38f:2b59:b550 with SMTP id
 ffacd0b85a97d-38f70857b6bmr8858863f8f.50.1740407445081; 
 Mon, 24 Feb 2025 06:30:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:3974:dc91:a561:d080?
 ([2a0a:ef40:1d11:ab01:3974:dc91:a561:d080])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915719sm32133826f8f.60.2025.02.24.06.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 06:30:44 -0800 (PST)
Message-ID: <c39b654f-c93d-42d9-aedd-ca06f1d9169c@linaro.org>
Date: Mon, 24 Feb 2025 14:30:43 +0000
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
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAE-0n502oMFrpxpu1bdh2zGj4--SybHbAPE1ndXr1f90vTme1Q@mail.gmail.com>
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



On 2/22/25 00:20, Stephen Boyd wrote:
> Quoting Caleb Connolly (2025-02-20 17:00:30)
>> Hi Stephen,
>>
>> On 2/20/25 20:58, Stephen Boyd wrote:
>>> This series supports running U-Boot as a payload on sc7180 Trogdor
>>> Chromebooks like Lazor or Wormdingler. This is a jumble of different
>>> patches to get to the final goal of booting a Linux distro from the eMMC
>>> on Lazor. I've yet to craft a USB stick with a stock distro but I'll
>>> probably do that next week.
>>
>> \o/ wow, this is awesome!
> 
> Thanks!
> 
>>
>> you might have some luck booting pmOS, we build depthcharge compatible
>> images for trogdor
>>
>> https://images.postmarketos.org/bpo/edge/google-trogdor/
>>
>> There's also a generic ARM64 EFI image that should work. You may need to
>> edit the image and remove efi/systemd/drivers/dtbloader.efi from the ESP:
>>
>> https://images.postmarketos.org/bpo/edge/postmarketos-trailblazer/
>>
> 
> Cool thanks for the pointers. I'm loading u-boot as a payload from
> depthcharge so that I don't have to remove the write protect on the
> flash. It's the altfw boot method.
> 
> I tried to boot the Debian ISO from a USB stick but it looks like the
> FDT memory node isn't modified when I use u-boot to load the DTB from
> the one flashed to the eMMC for the ChromeOS installation. Does the
> efi_dt_fixup_protocol run in that case? I've never tried any of this
> stuff before so I'm learning while I go.

The /memory node isn't used when booting with EFI, some EFI table is 
used instead. I also don't think we use the DT fixup protocol in 
mach-snapdragon so that should be a no-op.

> 
> I've been using this sort of flow to read the DTB from the FIT image
> that chromeos has:
> 
>   bootflow scan -l
>   bootflow select 2 # Select the MMC partition for cros bootmethod
>   bootflow read
>   bootflow info
>   fit=$hex_address_for_FDT_from_info_above
>   imxtract ${fit} fdt-22 ${fdt_addr_r} # fdt-22 matches my board variant
>   fdt addr ${fdt_addr_r}
>   load usb 0:2 ${kernel_add_r} /EFI/BOOT/BOOTAA64.EFI
>   bootefi ${kernel_addr_r} ${fdt_addr_r}
> 
> This seems to work to get me to the installation menu but then when I
> run installation the kernel doesn't boot and it looks like memory hasn't
> been updated per the earlycon info that I see. I'll continue 

That's weird indeed.

I think once the FDT is loaded you can just run "bootefi" with no 
arguments and it should pick up the USB drive automatically.

If you have some logs I'd be happy to take a look? You can find me 
@calebccff in #u-boot-qcom on libera.chat

> 
>>>
>>> The first few patches add support for the particular SoC sc7180 used on
>>> Trogdor devices. The next set of patches move the coreboot logic out of
>>> x86 into lib to find the coreboot tables on ARM and stash them in global
>>> data. Then I have a handful of patches to let the coreboot commands and
>>> utilities parse and populate various things like pstore and DT with the
>>> proper data from the coreboot tables. Finally, I add the calls to
>>> coreboot dram parsing code in the snapdragon board so that if coreboot
>>> tables exist we get the memory info from coreboot instead of from an
>>> earlier stage DTB.
>>>
>>> I tested the spi driver with the crosec command. The cros bootflow
>>> method almost works, but it seems like chromeos userspace blows up
>>> spectacularly likely because crossystem can't figure out what board it
>>> is running on. I don't really care too much about booting chromeos
>>> userspace here so I'm going to ignore that problem and assume that I can
>>> boot some Linux distro because the eMMC can be read by U-Boot and the
>>> kernel boots.
>>
>> Guess it's time I finally get my hands on one of these devices :D
>>
> 
> I bought a Lazor from eBay for a couple hundred dollars refurbished and
> it is basically brand new because the battery was replaced. I want to
> get the display working, which I think will require me to port the dsi
> and eDP bridge code over even though coreboot would have left everything
> largely configured.

Ahh that's annoying, Coreboot doesn't just give you a framebuffer you 
can write to?

Kind regards,

-- 
Caleb (they/them)

