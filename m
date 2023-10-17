Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9A4CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 10:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B8C86D7F;
	Tue, 17 Oct 2023 12:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ml88ZqkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE51D86D7F; Tue, 17 Oct 2023 12:12:26 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9707A86D4B
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 08F173F443
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697537539;
 bh=WD2P7YK/CzWWJ+of6e2MjMOrOg/HpIl3ZSxDuQx99jg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Ml88ZqkPE4MEh6Cc2Rdsu6HMOASssfRRv1PAQj1dD75aLGHdG1qJ/u9ytkJKKlYiy
 Mgk2lk1o7GaA00cYu7iWnsTnT5i0tmTjbctSbzX4y5mNfO0VJFq+7ypuxSAKR3l9p7
 RqQndrMAUETr8+qRyVj9EyOg4oJqzb7ARQMnJWFTYLETFKldTWsqeidshOXq7eu5De
 fkcycPy1oIByODx9GCa/3OIZ7tuziUE53bBkhSqpAGv90TUnq0WseAelY6JBi6esRY
 eD48Y/Rh4CZ2y40zpmUsG0fjEKLUoZy+hIAc5kzOssNOHDJ8HHMUun7vmrtMu2IPoV
 M1/yST5fZy4bA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4077ee09a4eso17835565e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 03:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697537538; x=1698142338;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WD2P7YK/CzWWJ+of6e2MjMOrOg/HpIl3ZSxDuQx99jg=;
 b=eE24qyj/PLPPXfV2ci+vlDrLhas0h20WWsZW6n5Z91C/l/FHCshgWm852UCEv3Wgl9
 cPtH7TPTnsRdOZL6IdWtKqrYfR2hwCUjUuP+DVOJ6AWCXZl3SUDTVCQjGkxYEdilPDyc
 iZELmqopYo+LS8ipyPSjDskgyPsj2ntxlxS7YR8UcOq/jT3dkHRlzA4ZmKHS934xyhZA
 /7itDl21t5W/lxxJs56m8XFxHhv2wPy+MyN9oZYYvwemWeZAa6BC4fukBiuwlYMHTKWv
 00mjHKQCcopROqCyuPUP3jxLFBKAqXRbdnb48toZsHUI54Xra/GsBTsIdpZzw1QjDVrn
 tYXg==
X-Gm-Message-State: AOJu0Ywb/rGNsIlYPZUxRbcJZmy5F33HdPGwii5d3Z6PXeXtLqVgRYbe
 +8CN6BgPujWQcdjq6TQpE6c3ejYCiMHaTTaAaKSycqZEI2hTf8qXAL/EPnVX/Ej+5PdwtDjpLIL
 riXGL9iyVzeJS19/L+glw6i8PEBcLR6M=
X-Received: by 2002:a05:600c:3110:b0:405:359a:c950 with SMTP id
 g16-20020a05600c311000b00405359ac950mr1335626wmo.19.1697537538595; 
 Tue, 17 Oct 2023 03:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr1Np6fMWUs/hiwOx2Z+9Pt4LMX+l0KOkN36MWV0JTg+78bRgsjqC2skgCXOGkzR3F9gF0JA==
X-Received: by 2002:a05:600c:3110:b0:405:359a:c950 with SMTP id
 g16-20020a05600c311000b00405359ac950mr1335610wmo.19.1697537538255; 
 Tue, 17 Oct 2023 03:12:18 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 d9-20020a05600c34c900b004063cced50bsm1478357wmq.23.2023.10.17.03.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 03:12:17 -0700 (PDT)
Message-ID: <794f1510-72bb-4463-b1f1-18c9e06d2d94@canonical.com>
Date: Tue, 17 Oct 2023 12:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: expose the device-tree file name
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20231017085507.12094-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjLgt0USVOQxp6WE_1edxMYMdGzfhvEFM67e91m-_iYn-A@mail.gmail.com>
 <cf0e5002-223e-4777-ab6f-654747c516b1@canonical.com>
 <CAC_iWjJ41LUzR-1GV4MCvgBADqB9Ba-hHT+7M2BEsQC_uz3-Lg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJ41LUzR-1GV4MCvgBADqB9Ba-hHT+7M2BEsQC_uz3-Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17.10.23 11:49, Ilias Apalodimas wrote:
> 
> 
> On Tue, 17 Oct 2023 at 12:23, Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     On 17.10.23 11:14, Ilias Apalodimas wrote:
>      > Hi Heinrich,
>      >
>      > On Tue, 17 Oct 2023 at 11:55, Heinrich Schuchardt
>      > <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>
>      > <mailto:heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>> wrote:
>      >
>      >     Forward and backward compatibility of Linux kernel
>     device-trees is
>      >     sometimes missing. One solution approach is to load a kernel
>     specific
>      >     device-tree. This can either be done via a U-Boot scripts
>     (like the one
>      >     generated by Debian package flash-kernel or by a boot loader
>     like GRUB.
>      >     The boot loader approach currently requires to know the
>     device-tree name
>      >     before first boot which makes it unusable for generic images.
>      >
>      >     Expose the device-tree file name as EFI variable FdtFile.
>      >     This will allow bootloaders to load a kernel specific
>     device-tree.
>      >
>      >     Signed-off-by: Heinrich Schuchardt
>      >     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>
>      >     <mailto:heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>>
>      >     ---
>      >       lib/efi_loader/efi_setup.c | 26 ++++++++++++++++++++++++++
>      >       1 file changed, 26 insertions(+)
>      >
>      >     diff --git a/lib/efi_loader/efi_setup.c
>     b/lib/efi_loader/efi_setup.c
>      >     index e6de685e87..b24feb94dc 100644
>      >     --- a/lib/efi_loader/efi_setup.c
>      >     +++ b/lib/efi_loader/efi_setup.c
>      >     @@ -26,6 +26,27 @@ void __weak allow_unaligned(void)
>      >       {
>      >       }
>      >
>      >     +/**
>      >     + * efi_init_fdtfile() - set EFI variable FdtFile
>      >     + *
>      >     + * Return:     status code
>      >     + */
>      >     +static efi_status_t efi_init_fdtfile(void)
>      >     +{
>      >     +       char *val;
>      >     +
>      >     +       val = env_get("fdtfile");
>      >     +       if (!val)
>      >     +               return EFI_SUCCESS;
>      >     +
>      >     +       return efi_set_variable_int(u"FdtFile",
>      >     +                                   &efi_u_boot_guid,
>      >     +                                 
>       EFI_VARIABLE_BOOTSERVICE_ACCESS |
>      >     +                                   EFI_VARIABLE_RUNTIME_ACCESS |
>      >
>      >
>      > Why is runtime access needed?  Wouldn't the choice be done before
>      > ExitBootServices?
> 
> 
>     Having runtime access will allow to use the content of the variable to
>     write a devicetree command to grub.cfg or to copy the relevant
>     device-tree to a predefined location.
> 
>     As GRUB cannot read EFI variables, yet, this would be the easiest
>     short-term approach.
> 
> Do you mean to write EFI variables?  If you want GRUB to be able to do 
> that, wouldn't it be better to use a generic GUID instead of the U-Boot one?

No, I meant read. It is U-Boot writing the variable.

Concerning the GUID the UEFI 2.10 specification requires a unique 
VendorGuid other than EFI_GLOBAL_VARIABLE.

If we think about adding a recommendation to the EBBR, it might make 
sense to use a GUID other than a U-Boot specific one (at the expense of 
16 bytes of code).

Best regards

Heinrich
