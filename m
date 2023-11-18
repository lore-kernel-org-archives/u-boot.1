Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082C4C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 07:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ADFC86D9E;
	Sat, 18 Nov 2023 08:36:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z1UPbu5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047B786CBD; Sat, 18 Nov 2023 08:36:14 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A43C86E42
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so34474581fa.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700292968; x=1700897768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JSrdffDTlLIvNxjuslDHGB/gkOxpqoo0kMkzmga/GNM=;
 b=z1UPbu5bOvV+DEqENB+MU1IoWeLlsizj2WfUkPFJszW5ilQKjzUbZicWCn7fsBuG+j
 +dB7pqCraOloiakL25E58CQXR35MbQNAqfjzWQJ65ZF34pJNHkSlonYHqWmI5GtcEbXa
 +ZhkrwnFV6QZFyJVjhBrlNTJB2mD2KpxQAlU50cHIkjuUbMZsoysW5x0flqH8uBF0hGy
 L69OvZj4uKGJxtR//TwBur3+eVmigznlieyhqmJQold3BDC8bNwqjQUOnsmIMhM1OcSp
 DIanBVgK6/qpukORGNMtCRvh1K7Zmzb3MQxe/KslfB2h3TXrOT2rvLmHEOe0Kvt/UT1M
 BA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700292968; x=1700897768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JSrdffDTlLIvNxjuslDHGB/gkOxpqoo0kMkzmga/GNM=;
 b=gX2/UxGP2xAhXKN2n3pVhNwJT/NLPrWeo4Gm1Ye+xwkF38GRB2Yn1cRbajbr5Ajf26
 215EYtwZWaGUN51KlaagqgJHxany7zjreitIVjoF+6e2wkuk6pCYzK9DH2kWIUic2HzD
 jUPIW7jndPy/2xvC2bkDbOPieVbx2Yosz02DBDXM2v8tE3cgGcl7XSNjq3lx5vzrNzSF
 ROb8zXL+tdmdC5zpDoepXPcGJTDoHYAQizCU3bkMbzYovQE68IFMVYRtLh/oDlzo8Pu9
 Y328CRj/to4K7SRPm8F8pNQnsM8NZhjOg/E7VFcv6MZNAaV1NBgNBYlMEufXutifXnJU
 0bWQ==
X-Gm-Message-State: AOJu0YzRP+VBWNivefWi7qGRuIOda+NmHigccv6TELWoNUsaXKBq/M1b
 iOVIr6NxnndOu+vWKMTpROOUAoMQpl7M6jqokiKzwQ==
X-Google-Smtp-Source: AGHT+IHfap8rej7O/6Tv2di4YQb0Rcu3bA81gAhe6pUaT2dWhReAUe0DXEHwHzLKjJ7wTgA7qetal7TBtB07S/RgLGo=
X-Received: by 2002:a2e:81d8:0:b0:2c6:f625:cc61 with SMTP id
 s24-20020a2e81d8000000b002c6f625cc61mr1354307ljg.31.1700292968608; Fri, 17
 Nov 2023 23:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20231116230806.20506-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231116230806.20506-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Nov 2023 09:35:32 +0200
Message-ID: <CAC_iWj+=XdBzhnLvTp9Sv=bc6aC5pzUQD0ZQkUdagAhJ037Adw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: eficonfig: create shortened boot options
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich

On Fri, 17 Nov 2023 at 01:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The boot options created by eficonfig should use shortened device-paths to
> avoid problems if drives are enumerated in a different sequence.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/eficonfig.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index e6e8a0a488..3d95092109 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -528,6 +528,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
>         p += fp_size;
>         *((struct efi_device_path *)p) = END;
>
> +       dp_volume = efi_dp_shorten(dp_volume);

efi_dp_shorten can return null.  Dont we need to check that here?

Thanks
/Ilias
>         dp = efi_dp_append(dp_volume, (struct efi_device_path *)buf);
>         free(buf);
>
> --
> 2.40.1
>
