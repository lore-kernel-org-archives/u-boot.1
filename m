Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67508C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF5886FA5;
	Thu, 16 Nov 2023 19:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bzM7MgA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591B2870D2; Thu, 16 Nov 2023 19:15:37 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15790863FD
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D7453F87C
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700158534;
 bh=wBvHwhnaqGLFywHnNN8GfG3LmS5y0Urf8tIC+y5lCME=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=bzM7MgA8rPt+dmatYdkE7QsanM935IjU/YQeO62sldcty+ZRlJdN8eiSD3wu9BG4H
 JRIKDmJ3AYbOoHnNXJUJcymRKY1q+/fnZbirkd8DJMOFuTn8Ch6Cb1uk8AUtpY59Od
 wqpeLkd0BL0KzVhGGu5lgtgEEcSnVu4fhBu991nzVGt81urC9BV6bOpLHsCjeWOsxg
 Ha6HJpkVzjTv/c9J7fscRd9V70q8jWMEs+sSJ85LRsss4duban0wnyy3E1uLCZzzbj
 P3T51Ew0soY+PhlGdUMxOR5BqWB89S0mMfR2RIZd9X5olDp1R/vHtNmK4sjnrercaD
 VB+Pcvq2WmA/g==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32f8c4b74f7so550266f8f.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700158534; x=1700763334;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBvHwhnaqGLFywHnNN8GfG3LmS5y0Urf8tIC+y5lCME=;
 b=b8BvyLXBqgSZDucnOoxgcbViPN2VmbyqVUhROEILd2eoRIJ7XAt+xlRniz7+INHBh3
 T4ljKqe+gqYVEHqO9O4xGbId0pzBRD/SKVvUrVm52LaisHltpbXIFiqh9NpPcHZeB6Ym
 zEdyKvzd9RBweBzXodfFYhw3tGhoofdUN36kior9WXVQVGL8NzglWObajMhJed22JrBG
 4WF1N9B690Y+wsSgMq9PddzauJb6TbjmyGNgtsF5noMSsd2Tt0dM2YoyMbQKfyakb0nP
 fQouvQ/ma72T8stA5iahcgTCq8qWBR1lOyYKpD8ejfonmMIVdsHGdTa6FODqghtmYZCt
 8QAg==
X-Gm-Message-State: AOJu0Yzp4ZhKntURtxd/fhwdpJyaXvfwJBWRCB8wDiryK5fWo4rwocKV
 eDc6eC11s1e7B3FLnrXBdf1BBdgMZHNiGGQgC9Af7N71o1i+cgqH39y3LeFn1hoKTti0872ZlSP
 htQpQYo4CoBaT0TaEF9tNBGtvn5L2HBY=
X-Received: by 2002:a5d:59a2:0:b0:323:2563:be13 with SMTP id
 p2-20020a5d59a2000000b003232563be13mr2552262wrr.52.1700158533957; 
 Thu, 16 Nov 2023 10:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM+BOimhqrylgRcNSfPjgzPZsnpIfRxFh4evb4evNzWTzxhpOaQx73eg7UqODuVuNYW83QmA==
X-Received: by 2002:a5d:59a2:0:b0:323:2563:be13 with SMTP id
 p2-20020a5d59a2000000b003232563be13mr2552247wrr.52.1700158533560; 
 Thu, 16 Nov 2023 10:15:33 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 b15-20020a056000054f00b0031980294e9fsm47053wrf.116.2023.11.16.10.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 10:15:32 -0800 (PST)
Message-ID: <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
Date: Thu, 16 Nov 2023 19:15:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bootstd: Support for distro specific EFI folders
To: Shantur Rathore <i@shantur.com>
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
Content-Language: en-US, de-DE
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
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

On 11/16/23 17:52, Shantur Rathore wrote:
> Hi Simon,
> 
> Currently bootstd - bootmethod_efi only looks for the default
> bootxx64.efi in /EFI/boot folder only.
> Generally many distros end up putting their bootloaders in
> EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> 
> In x86 worlds, the NVRAM is modified and new boot entries are added to
> support these but in the U-boot world the NVRAM variables are
> read-only.

I guess you are referring to UEFI boot options. These typically are not 
stored in non-volatile RAM but on a SPI flash device.

> 
> What would be the best way to implement this?
> 
> I was thinking of having a "efi_prefixes" environment variable which
> can be set to "ubuntu debian centos" etc and bootmethod_efi can try
> all of them. Will bootmethod_efi be able to support multiple entries (
> thinking of multiboot ) ?

On my laptop I have:

EFI/Microsoft/Boot/bootmgr.efi
EFI/Microsoft/Boot/memtest.efi
EFI/Boot/bootx64.efi
EFI/Boot/fbx64.efi
EFI/Boot/mmx64.efi
EFI/debian/shimx64.efi
EFI/debian/grubx64.efi
EFI/debian/mmx64.efi
EFI/debian/fbx64.efi
EFI/ubuntu/grubx64.efi
EFI/ubuntu/shimx64.efi
EFI/ubuntu/mmx64.efi

Obviously each installed operating system provides multiple EFI binaries 
and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu 
debian centos" would not be able to describe which file you are looking 
for.

We already have the U-Boot command line eficonfig and efidebug commands 
to set up UEFI boot options which can describe which EFI binary to load 
and which command line to pass to it. These are considered by the 
existing boot flows.

If you are installing the shim-signed package on Ubuntu, the EFI boot 
option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the content 
of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() and 
therefore should work with current U-Boot.

Patches are pending upstream to make EFI variables writable from Linux 
if they are stored in the RPMB partition in the eMMC. See this series:

https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima@linaro.org/

Best regards

Heinrich
