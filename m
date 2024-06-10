Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168D4C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E691880AE;
	Mon, 10 Jun 2024 16:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dv2Ism81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0880687D0A; Mon, 10 Jun 2024 16:00:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B7188546
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 664043F72E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718028024;
 bh=W6TNLRrgkkBo0rSg8SqtYUrSiYtL8zv2GXMNCMCXK4g=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=dv2Ism81FhIUy6iTH8hGzcr5BNUH188bIIsufxOKdpg+Yk3GC0yYpqaMrFitkZzl/
 jOsAMrK3eHODvybIeEo1SVSaBbW5HxsdfDFGB+f3nu7vBlFsfl40DfB0siHCSTZgO3
 yGNjzwa5Fgf3JIM3JXcn3uxCrZ84LGf4P2BaY1W1MGEDfHio0isrWSeBLUp4S7eKaL
 WaNRkoqNtjaoLdbIIqHgT0QHqLDStP5pkwgEj2PSvbelXv/b7+wZ8HUnJphFQoeyQy
 3N1P4jVvjl95Fqlh69kLsaK40Tana44hgDc9grKZ7Su6PQn8LkMRoKyUWdwWiTq44W
 jiFrcrna1OErQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-421811b92bcso102875e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718028024; x=1718632824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6TNLRrgkkBo0rSg8SqtYUrSiYtL8zv2GXMNCMCXK4g=;
 b=A2IvD6aAoEdbw7vEGZe11W9eyF9LDqt9oumXE9H0aCddrWb+Z/WS8jPvDMkrn9OeXB
 A8JR+vF1/raEKJ4rGRaU0oeKhAihbd5W9H+UuakW2LxLUyopv7c8VGmEnqKCe8QPIz5D
 aaUjoocmTAouc81h8hqFdthjct8pcXtnnSuwqQ+sikUEChuOkJ+fk0d+IeKsxR4bnHNM
 ZOGxMoGGuLrBIAG2cs3Cq4sa8rBUkGe1XZzED3HnXN0uV9jFlgYKjF6o15AGJXKHMzwt
 a6SG4BcSGkLIXiLKYZidPlQfFlK2lCV1D/gLFG82cHhjZoYhGy49xHD2cBvNstVTdxMX
 XCsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/F+nvcgZj2o7WcuqsnLf9+Kf/orrqfAKGJmd0WekgfUbYDVmoOxA2KyrOyWUokI+eJUi/oV/JU45csNOVQUuKO+DC2Q==
X-Gm-Message-State: AOJu0YxFTyzMFEknPboJlBeErb/hNoRfBFzSR8eNZFh2z9SgEgFEY6Rr
 guD/5ZvrTtdyDSYEo4p4QnqwAgKdQ662pAdLNEOQMc5YJnxwnDD0kDFvDpha/pydLnNiDqhNRPc
 vrGcAeQN7Fb60CmN+9GyUNKNpor4b5aCi0AjnOz7SJxqL7cT64wO83dbwv3vTHkl1BUE=
X-Received: by 2002:a05:600c:1c90:b0:41b:f30a:41f1 with SMTP id
 5b1f17b1804b1-421649ec967mr66299575e9.7.1718028024049; 
 Mon, 10 Jun 2024 07:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEtKssHbremwxMMRSvZWLfJhennIGh1Zn1R0wlPR+hPOlnPiHA6rKz7SLoYWgAzyMR5dRJag==
X-Received: by 2002:a05:600c:1c90:b0:41b:f30a:41f1 with SMTP id
 5b1f17b1804b1-421649ec967mr66299355e9.7.1718028023616; 
 Mon, 10 Jun 2024 07:00:23 -0700 (PDT)
Received: from ?IPV6:2a00:20:43:88b5:6b2b:e162:4c45:5c4c?
 ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1c2027cfsm5408473f8f.116.2024.06.10.07.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 07:00:23 -0700 (PDT)
Message-ID: <a9462414-c8f7-4a2a-9dd0-f39ee24876f8@canonical.com>
Date: Mon, 10 Jun 2024 16:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] efi_loader: improve device-tree loading
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Shantur Rathore <i@shantur.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, Bin Meng
 <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
 <CAFLszTgcnftK=GqZ0LGue2Y8-YkRhOKzPuc4Yf1CvhzAGO+MTg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgcnftK=GqZ0LGue2Y8-YkRhOKzPuc4Yf1CvhzAGO+MTg@mail.gmail.com>
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

On 10.06.24 15:53, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 10 Jun 2024 at 03:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> In U-Boot EFI boot options can already specify both an EFI binary and
>> an initrd. With this series we can additionally define the matching
>> device-tree to be loaded in the boot option.
>>
>> With the last patch the boot manager will fall back the device-tree
>> specified by $fdtfile in directories '/dtb/', '/', or '/dtb/current/'
>> on the boot device if no device-tree is specified in the boot
>> option or via a bootefi command parameter.
>>
>> v3:
>>          Add missing '@' in EFI_LP_DP_PART_FDT description.
>>          Use calloc() instead of malloc() in load_fdt_from_load_option().
>>          Add missing '@' in load_fdt_from_load_option function description
>>          Rename struct efi_initrd_dp to efi_lo_dp_prefix.
>>
>> v2:
>>          Update efi_dp_concat() instead of new function efi_dp_merge().
>>          Carve out a function efi_load_option_dp_join() which we can
>>          use both for the eficonfig and the efidebug command.
>>          Rename variables id_dp, final_dp_size.
>>          Rename create_initrd_dp() to create_lo_dp_part().
>>          Use enum as parameter for create_lo_dp_part().
>>          Put all related changes into one patch.
>>
>> Heinrich Schuchardt (8):
>>    efi_loader: allow concatenation with contained end node
>>    cmd: eficonfig: add support for setting fdt
>>    cmd: efidebug: add support for setting fdt
>>    efi_loader: load device-tree specified in boot option
>>    efi_loader: move distro_efi_get_fdt_name()
>>    efi_loader: return binary from efi_dp_from_lo()
>>    efi_loader: export efi_load_image_from_path
>>    efi_loader: load distro dtb in bootmgr
>>
>>   boot/bootmeth_efi.c                        |  60 +---------
>>   cmd/eficonfig.c                            |  83 +++++++++----
>>   cmd/efidebug.c                             | 130 +++++++++++++++------
>>   include/efi_loader.h                       |  24 +++-
>>   lib/efi_loader/Makefile                    |   1 +
>>   lib/efi_loader/efi_bootbin.c               |   2 +-
>>   lib/efi_loader/efi_bootmgr.c               |  75 +++++++++++-
>>   lib/efi_loader/efi_boottime.c              |   3 +-
>>   lib/efi_loader/efi_device_path.c           |  40 ++++---
>>   lib/efi_loader/efi_device_path_utilities.c |   2 +-
>>   lib/efi_loader/efi_fdt.c                   | 117 +++++++++++++++++++
>>   lib/efi_loader/efi_helper.c                |  44 +++++++
>>   12 files changed, 445 insertions(+), 136 deletions(-)
>>   create mode 100644 lib/efi_loader/efi_fdt.c
>>
> 
> Somewhat related, what work has been done to support FIT, or to locate
> a DT using the compatible string?

CONFIG_BOOTM_EFI allows booting a FIT image containing an EFI binary and 
optionally a device-tree. You can manually select a configuration when 
invoking the bootm command. I am not aware of any automation for this 
selection.

Best regards

Heinrich
