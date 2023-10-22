Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2D1CDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 21:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA99E8773E;
	Sun, 22 Oct 2023 23:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bmFKhJl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D4B8774C; Sun, 22 Oct 2023 23:31:55 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B0B876EF
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 23:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 964073F65F
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 21:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698010307;
 bh=nPzONPuhPUXk3fbT9jlfmoHUjbDag3uX4UMlR/mJKTw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=bmFKhJl/Vft9nFeh7XDLJZnj+oUuojIXt1YK0yxEC+HQoiqu5np7E6DgHE4EM3xRo
 +e8/o/B7iRcYU7Kc3cwGbnxSuU2gEG5plabwVCq6JXpzXTNL9Qg+wakOFfIgq47vFe
 obOFTJFEXtmt3DYxfIUaZabsXziEwH66drk9T5ZAnxW+bbpzrkQA8fmjomQzDmj6ha
 OkcIMnRplU6HRntvzrQasZ3jOJeqcr9qaNN9VheTTlFyXRinDqfOMXZ17CkuyHuniG
 d+w0ure5ukGFYmusEq1599JhTDlo0FtZkUeyv7fB3w7UcUufLHnsKsU84ZaCWbdJdM
 NaUFaSW9W5IrA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084a9e637eso16823345e9.2
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 14:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698010307; x=1698615107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nPzONPuhPUXk3fbT9jlfmoHUjbDag3uX4UMlR/mJKTw=;
 b=xKkqCoHhm73lIn3iFup8yTQZnTSLHwzTF7guDbowjaew4sdKw7wEyQQ7Fuo0hyhFZ2
 YjvKzODh44ISWvEu/oVYXAPygPJif6HePfTeNUERIV73mUyWnSRNPkTx7i+4EbEMs3jd
 QREYmCeIGbrisP5BCg5FKqXZPAHNDKUWZ86yXfM5SeStKuiUi8APZ7iU0RiRbLHPP6bN
 l4HinnrIDfN5+amQy87juM9mj2ymRxn/qskg5SReaUYHcVgt80DqsF6gqcKYMYIJD1Hi
 kwalFDbl+H5QwQMq5YWk533OJE3rgLRf5bzshDuTmbS+p261v9F2JJO3jnh63ao0s3Vt
 qqkA==
X-Gm-Message-State: AOJu0YxoLlfeo4QyiD93UDc+Wc64lXCN4A9JUXDhqiJ1O/t2FA0p7UUb
 JkK0QUsFKsMY43SL+9L1itoLhD2yjoPE3Y8ncbE0qvqkhOlx8gpMtWSaDXM/kS9cHrDmfwX52hm
 F5KJxNcYzFtrsm7bNsuwIJ/q8ezeKJJ8=
X-Received: by 2002:a05:600c:3ca2:b0:406:517f:ac85 with SMTP id
 bg34-20020a05600c3ca200b00406517fac85mr6375473wmb.18.1698010307172; 
 Sun, 22 Oct 2023 14:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsAs/2M/glQ++q0XVl0WKlHB32det7MbyjSaPWyujX0dQxLwySmnYoidcSXDANNZKoVAwu3A==
X-Received: by 2002:a05:600c:3ca2:b0:406:517f:ac85 with SMTP id
 bg34-20020a05600c3ca200b00406517fac85mr6375464wmb.18.1698010306586; 
 Sun, 22 Oct 2023 14:31:46 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c158900b0040776008abdsm7758263wmf.40.2023.10.22.14.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 14:31:45 -0700 (PDT)
Message-ID: <36e1a60c-3aa9-4f06-9920-c7b0a1d12c19@canonical.com>
Date: Sun, 22 Oct 2023 23:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] efi_loader: expose the device-tree file name
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
References: <20231022084733.113326-1-heinrich.schuchardt@canonical.com>
 <20231022155543.GC496310@bill-the-cat>
 <4c4fee5a-82ab-46e2-a450-f874b2a9ad5c@canonical.com>
 <20231022170812.GD496310@bill-the-cat>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231022170812.GD496310@bill-the-cat>
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

On 10/22/23 19:08, Tom Rini wrote:
> On Sun, Oct 22, 2023 at 06:34:08PM +0200, Heinrich Schuchardt wrote:
>> On 10/22/23 17:55, Tom Rini wrote:
>>> On Sun, Oct 22, 2023 at 10:47:33AM +0200, Heinrich Schuchardt wrote:
>>>
>>>> Forward and backward compatibility of Linux kernel device-trees is
>>>> sometimes missing. One solution approach is to load a kernel specific
>>>> device-tree. This can either be done via a U-Boot scripts (like the one
>>>> generated by Debian package flash-kernel or by a boot loader like GRUB.
>>>> The boot loader approach currently requires to know the device-tree name
>>>> before first boot which makes it unusable for generic images.
>>>>
>>>> Expose the device-tree file name as EFI variable FdtFile.
>>>> This will allow bootloaders to load a kernel specific device-tree.
>>>>
>>>> The variable will not be exposed on ACPI based systems or if the
>>>> environment variable fdtfile is not defined.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>> v3:
>>>> 	Add documentation
>>>> v2:
>>>> 	Use a unique GUID to enable future U-Boot independent
>>>> 	standardization.
>>>> 	Do not try to add the variable on ACPI based systems.
>>>> ---
>>>>    doc/develop/uefi/uefi.rst  | 17 +++++++++++++++++
>>>>    include/efi_loader.h       |  5 +++++
>>>>    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>>>>    3 files changed, 52 insertions(+)
>>>>
>>>> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
>>>> index fb16ac743a..a81d09ae81 100644
>>>> --- a/doc/develop/uefi/uefi.rst
>>>> +++ b/doc/develop/uefi/uefi.rst
>>>> @@ -916,6 +916,23 @@ So our final format of the FilePathList[] is::
>>>>        Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>>>> +EFI variable FdtFile
>>>> +~~~~~~~~~~~~~~~~~~~~
>>>> +
>>>> +Ideally U-Boot would always expose a device-tree that can be used for booting
>>>> +any operating systems. Unfortunately operating systems like Linux sometimes
>>>> +break forward and backward compatibility. In this case there is a need to load
>>>> +an operating system version specific device-tree.
>>>> +
>>>> +U-Boot has an environment variable fdtfile identifying the device-tree file to
>>>> +load. The content of this variable is exposed as EFI variable Fdtfile, vendor
>>>> +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the device-tree path
>>>> +name as a NUL terminated ASCII string.
>>>> +
>>>> +On 32bit ARM this is currently only a file name, e.g. 'imx6dl-wandboard.dtb'.
>>>> +On other architectures the file name is preceded by the vendor directory, e.g.
>>>> +'rockchip/rk3326-odroid-go2.dtb'.
>>>
>>> The Linux Kernel has split 32bit ARM up by directory now, too.
>>
>> Since Linux v6.5. That is why I wrote "currently". Once we migrate the
>> values of $fdtfile in U-Boot we may want to change
>> distro_efi_try_bootflow_files() to search both with and without vendor
>> directory.
>>
>> Are there already plans for that migration?
> 
> Right, v6.5 is out and has this change and v6.6 will be out soon enough,
> so the documentation we're adding here and now should be worded such
> that doesn't get stuck on these specifics.

Should I add a sentence:

Linux v6.5 has added vendor directories on 32bit ARM and U-Boot is 
expected to follow suit.

Best regards

Heinrich

> 
> And then how this kind of breaking change will be handled by
> distros and everyone else is something I wonder about.
> 

