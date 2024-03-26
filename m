Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBD6CD11DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 09:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B0488011;
	Tue, 26 Mar 2024 10:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MPS3WBCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F160A8801F; Tue, 26 Mar 2024 10:24:07 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C0087FDA
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 10:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d49f7e5c2cso70297451fa.2
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711445045; x=1712049845; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kLFYPSUYd6QvFV/CPS7ViM6lgPdq4J6gHIFNErBrCy4=;
 b=MPS3WBCm/AFN5wIF/HYSqIwCCjYqFJH4hh+3DVW+j/tEQgkGDHwjqiW2/GiPosOolF
 ek8EMEPwQnGXbFtDVX+eXKprgApzmFJWzEAolpsuQp+cs5+bpgRslQLkXhfgSv4IZXfH
 NvMLwLFiE7DBnlo0He7NM0lrkZadNHizVCBKYoxdDuiU15qF0x3Vcry32AHNtZpMTQlY
 PalwMp58iPWyUor88/qk9sy+mWYosVq7IMPKgp2ItrijirGxPR34QdvQmRvmPkcnyHYy
 i5Izj9zdU5Tm3lwYDSYzOkdb/6l1dZb/W8KdhJjouHB0D3MSBJEeYCzb3/XTVUS8BJOT
 X1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711445045; x=1712049845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLFYPSUYd6QvFV/CPS7ViM6lgPdq4J6gHIFNErBrCy4=;
 b=dkExpkHItMdtEBXqm2Eje/aW7FqquAw0b2UMvPzOoe3U5KB3yOJN63shi75prgL1kz
 yLT4WmhqwvGT55MqWJjNzeiJ6bnT5N9Z5nFyiSRAsZPdlEjkWbqCNCoolveTgNyDMR2A
 WKH46JHP0HgTchFj9brJdfXae506OkIS4J3TE0zw3zVGXGjppcwofnGvYqDuKacaI75C
 27VCwxFaFVGV1xeIi4LU0Gh8aoPwKlXHKnjRcZY5V5hVJr5WbV+Q+GVcpDQ69AWq9Tpl
 Lk0WRz3FY+0iV/oLikKmX6WUUUUqU7hj6ubNwcIzpMr+MfHQuvsyfFdqVW5MaaEJWsKj
 eBAQ==
X-Gm-Message-State: AOJu0YzcRGWFkUwZIO0/B7NfuyQa83pI8eT5ErJ2UM2GidKz7O0ieVpm
 hBzdzHFP7OSkmWr+PouUI0CuVsjjS3THLUNYXEN/kAKQnrYym56SlA5ZQxt4eGbqqcd1+ihfWPI
 RMaAJl/eGqI8+17f9rwWc7jLHROePlw9gIT2KBrtIpwycDbug
X-Google-Smtp-Source: AGHT+IGUTcS3Ag+GM/tx1wkhfEkNSD/u+VHMIGC7qDcOs3JCKHy7l8jDvbpleNJpPvszqVduz4rQfcBPQLKejN/fj/s=
X-Received: by 2002:a2e:a272:0:b0:2d4:5ce5:2323 with SMTP id
 k18-20020a2ea272000000b002d45ce52323mr5461248ljm.34.1711445045068; Tue, 26
 Mar 2024 02:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU12-4EJN_RPGPPTfTVden2=beq-XaeFL=dF7t+AAqje=Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 Mar 2024 11:23:28 +0200
Message-ID: <CAC_iWj+B0r7o8Hwi_KZM=+L9t6=THH=pzY38jrcDDdAntWT3Rw@mail.gmail.com>
Subject: Re: tcg2_platform_get_log failing to read address and size of
 memory-region via ofnode_get_addr_size
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>, eajames@linux.ibm.com
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

Hi Tim,

On Tue, 26 Mar 2024 at 03:15, Tim Harvey <tharvey@gateworks.com> wrote:
>
> Greetings,
>
> I'm unable to understand why tcg2_platform_get_log is failing to read
> a memory region.
>
> For example the following diffs:

I am not really sure what those nodes are supposed to do in sandbox.
Pehaps Eddie remembers.
What exactly are you trying to achieve here? Read the eventlog from TF-A?

Thanks
/Ilias
>
> diff --git a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> index 7b2130dbdb21..57b3c227ceaf 100644
> --- a/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> +++ b/arch/arm/dts/imx8mm-venice-gw73xx.dtsi
> @@ -112,6 +112,7 @@
>                 compatible = "tcg,tpm_tis-spi";
>                 reg = <0x1>;
>                 spi-max-frequency = <36000000>;
> +               memory-region = <&event_log>;
>         };
>  };
>  diff --git a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> index c305e325d007..697fd1148785 100644
> --- a/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> +++ b/arch/arm/dts/imx8mm-venice-gw700x.dtsi
> @@ -13,6 +13,17 @@
>                 reg = <0x0 0x40000000 0 0x80000000>;
>         };
>
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               event_log: tcg_event_log {
> +                       no-map;
> +                       reg = <0 0x40000000 0x2000>;
> +               };
> +       };
> +
>         gpio-keys {
>                 compatible = "gpio-keys";
>
> And at runtime:
> u-boot=> fdt addr $fdtcontroladdr
> u-boot=> fdt list /soc@0/bus@30800000/spba-bus@30800000/spi@30830000/tpm@1/
> tpm@1 {
>         compatible = "tcg,tpm_tis-spi";
>         reg = <0x00000001>;
>         spi-max-frequency = <0x02255100>;
>         memory-region = <0x00000025>;
> };
> u-boot=> fdt list /reserved-memory/
> reserved-memory {
>         #address-cells = <0x00000002>;
>         #size-cells = <0x00000002>;
>         ranges;
>         tcg_event_log {
>         };
> };
> u-boot=> fdt list /reserved-memory/tcg_event_log
> tcg_event_log {
>         no-map;
>         reg = <0x00000000 0x40000000 0x00002000>;
>         phandle = <0x00000025>;
> };
>
> So why does the following code in tcg2_platform_get_log() return -ENOMEM?
>
>                 if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
>                                                0, &args))
>                         return -ENODEV;
>
>                 a = ofnode_get_addr_size(args.node, "reg", &s);
>                 if (a == FDT_ADDR_T_NONE)
>                         return -ENOMEM;
>
> debugging shows that dev_read_phandle_with_args returns non-zero but
> args.args_count is 0.
>
> I feel like the construct of using dev_read_phandle_with_args followed
> by the ofnode_get_addr_size is just wrong but I don't understand why
> nor do I understand how my dt changes differ from what is in
> arch/sandbox/dts/test.dts (other than its using address-size=1 which
> doesn't appear to be the issue in my testing). The abstraction of the
> ofnode and fdt stuff always trip me up... very confusing.
>
> Can anyone explain the issue here?
>
> Best Regards,
>
> Tim
