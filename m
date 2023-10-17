Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8429CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 09:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD17786D4B;
	Tue, 17 Oct 2023 11:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VpTCDlua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE4186D4D; Tue, 17 Oct 2023 11:23:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C972C86BB4
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 205613F692
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697534615;
 bh=CvK33tEB908Qlsb5W9ued12hJBjXQHDRzg27T1SzgNM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VpTCDluaeAEAFu2w8mCm8kAPWfi9soM+10rFnrM+isjtEydT9BwcVhB6mlqABu5tV
 L2u0j8J2rS3+3ZBFJOJ82ip8itcnVZA6jrZfJxazpx3km5FZE5EeqjrwoCQqjWDjyd
 UYf2xJy+dppQ9QPGsxlUrI7t84ZePFji7SXcuCMlAJObscb8zEydFM9uYGx/CV/HOC
 APHeG7y57NTd3VK8pyxrzsLVuWt10Dbqnp/lyLtTXF2T1GykcevBcGpCENY6PdIZFU
 axLQTQxlxWx9/nndGX1/Mij0r9s7Yjlg3H+MDUenXQAhEe7pxlaKY5Ke/R3z6JTZoj
 c3fobPgYUWA3Q==
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c503af866dso42221841fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 02:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697534614; x=1698139414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CvK33tEB908Qlsb5W9ued12hJBjXQHDRzg27T1SzgNM=;
 b=MIL4Ucu5c3GmxW+nbENtjDTiHL5pY3p5ND4m8/Fg+/xscW+bV4MJz0brQ6CQHObXqp
 LSLeh+vt+Xh4aFUj7jIiHUH+YtW6Jl9SPG1hgU7s/g4RsjJrSRBf4KWeHAW4jdRcgHGp
 0j33mkKqcf3ct9q9ggYFe/wDYTUvVbp0i59UC6Rc6/DmUCMbi0iCeNF9ejY793zKeqpu
 dW2tZvSb4d3DuawKpO8lK90rbI1DzViVLUPVl0EgCLWOshwWP8ftP+gE6B3lAQYX0x8U
 hzSpPwGv8jCQ0KD36llJvgBaqYUxzgwpT3+4ligaQUjmvEHOkHSj8A9quggTGh8outHV
 aKTQ==
X-Gm-Message-State: AOJu0YyV8X+LB8/zkfr+aAGHWMSP3QhgfUkhqI7G38Zj9UvY9EIgqLjI
 JBXQBcisAvfDaqV1kvzZDLehcKqrQgqC4BANr72R3AcMjAbmgJTi3hQOxs5BtXVbtuv6cE+UJCO
 6odIaKcm8PFD+hy4k/WQyxFjIOGR9cv2LAqjlb7k=
X-Received: by 2002:a2e:a308:0:b0:2bc:eceb:6a4b with SMTP id
 l8-20020a2ea308000000b002bceceb6a4bmr1258825lje.28.1697534614190; 
 Tue, 17 Oct 2023 02:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj3AkbLDg09p/HNoeuspDfy7XyA78Y/Eg1xZEFVdkbKMw/0OnaQMNNiL7eRwMJrvxuFQAX/Q==
X-Received: by 2002:a2e:a308:0:b0:2bc:eceb:6a4b with SMTP id
 l8-20020a2ea308000000b002bceceb6a4bmr1258812lje.28.1697534613783; 
 Tue, 17 Oct 2023 02:23:33 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b00405442edc69sm996900wmm.14.2023.10.17.02.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 02:23:33 -0700 (PDT)
Message-ID: <cf0e5002-223e-4777-ab6f-654747c516b1@canonical.com>
Date: Tue, 17 Oct 2023 11:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: expose the device-tree file name
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
References: <20231017085507.12094-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjLgt0USVOQxp6WE_1edxMYMdGzfhvEFM67e91m-_iYn-A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjLgt0USVOQxp6WE_1edxMYMdGzfhvEFM67e91m-_iYn-A@mail.gmail.com>
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

On 17.10.23 11:14, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Tue, 17 Oct 2023 at 11:55, Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     Forward and backward compatibility of Linux kernel device-trees is
>     sometimes missing. One solution approach is to load a kernel specific
>     device-tree. This can either be done via a U-Boot scripts (like the one
>     generated by Debian package flash-kernel or by a boot loader like GRUB.
>     The boot loader approach currently requires to know the device-tree name
>     before first boot which makes it unusable for generic images.
> 
>     Expose the device-tree file name as EFI variable FdtFile.
>     This will allow bootloaders to load a kernel specific device-tree.
> 
>     Signed-off-by: Heinrich Schuchardt
>     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>     ---
>       lib/efi_loader/efi_setup.c | 26 ++++++++++++++++++++++++++
>       1 file changed, 26 insertions(+)
> 
>     diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
>     index e6de685e87..b24feb94dc 100644
>     --- a/lib/efi_loader/efi_setup.c
>     +++ b/lib/efi_loader/efi_setup.c
>     @@ -26,6 +26,27 @@ void __weak allow_unaligned(void)
>       {
>       }
> 
>     +/**
>     + * efi_init_fdtfile() - set EFI variable FdtFile
>     + *
>     + * Return:     status code
>     + */
>     +static efi_status_t efi_init_fdtfile(void)
>     +{
>     +       char *val;
>     +
>     +       val = env_get("fdtfile");
>     +       if (!val)
>     +               return EFI_SUCCESS;
>     +
>     +       return efi_set_variable_int(u"FdtFile",
>     +                                   &efi_u_boot_guid,
>     +                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
>     +                                   EFI_VARIABLE_RUNTIME_ACCESS |
> 
> 
> Why is runtime access needed?  Wouldn't the choice be done before 
> ExitBootServices?


Having runtime access will allow to use the content of the variable to 
write a devicetree command to grub.cfg or to copy the relevant 
device-tree to a predefined location.

As GRUB cannot read EFI variables, yet, this would be the easiest 
short-term approach.

Best regards

Heinrich


> 
> [...]
> 
> 
> Thanks
> /Ilias

