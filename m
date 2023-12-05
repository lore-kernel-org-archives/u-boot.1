Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C00C10DC3
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29849877C4;
	Tue,  5 Dec 2023 10:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bttm7m2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B74E87623; Tue,  5 Dec 2023 10:03:40 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8243886F1F
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54c70c70952so4115496a12.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701767018; x=1702371818; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGx9ajeiXYXb9+sm0eyvOigFrwmo/xhBErAmK1hiZpY=;
 b=Bttm7m2I3gA7M32zKO0yfTxYajA0f6HTXVPp5V3T+iVDzXkLeXzBiF55UWpELrExkc
 dscAPelZAUajGR+mVh5Ng+C5E1hUXpRzbolzA4xeE59qJP6ZmaL7wFGM5yLyjMI1+tm/
 ztPjNrSXrE9vw7juczOAwcjB8KNIW/oMYyyvg92s8iSMu3ohqTkbs7aMYrs5Y6N52uSm
 BWXtjZzcdW0HPQ45bfZqyF616BefQT8h2VSd7SlCYpl8Ir22ZWf9tOtqaWpV/ORQgkel
 BGaiAYz+YBdSvGfZHfZnuvSwNyTETyCY8ohoAEgKzlAk9hC+cdgNRkXipAOrNGoqav7x
 CJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701767018; x=1702371818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGx9ajeiXYXb9+sm0eyvOigFrwmo/xhBErAmK1hiZpY=;
 b=gzovzxhkKOJUGtI577L2+JM2aZcUxFM5VrOA8BkqSEhJ6DicGDTAPnlyuStoLUbHM6
 gqhQbpW6nfQHzUv7Lq44vMqWG7JKX3zEnZUwpueEF9HMQ/0bcrDKsHx4Z2oB97NB1G1f
 F3ghXkMI1aNX/6vFHNptp8ipG6ugWFyk3WUt05GINeonqYqr802nKNMUzlJjyJhID4L5
 Dwmi2sh7cAtA3P5He7i4d6iFtAle5aF45h2BnfFhukFK5rZmHiYIUzu+xFpT72yJoFwo
 3DqWrTQiTXABNL8HGXQxmMb0GEYxmgmwgyc2uFuaI/BukTxjSWBFdkwuyQ+LRpK5tMR8
 qHug==
X-Gm-Message-State: AOJu0YyYOFODlbe8jhDmAR0rFxr+f2RPd7zr/G2EuqgyCfbRtuEHVXLE
 injL7QqO89JitbtRrS2tsyzYxUCZEv9TezPQk9F+P4Sp+4M=
X-Google-Smtp-Source: AGHT+IERMg9Cvroc4R3au2Pu1KrOYLDHuCz35t/6VHQ+Vbqi5eZ0/4fTmjkA8Ns2Dmu035n5AVdRvTpLbePOIKZL7Zg=
X-Received: by 2002:a50:d4c4:0:b0:54b:2199:c936 with SMTP id
 e4-20020a50d4c4000000b0054b2199c936mr3145276edj.33.1701767017745; Tue, 05 Dec
 2023 01:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
 <20231204120446.3277-8-maxim.uvarov@linaro.org>
In-Reply-To: <20231204120446.3277-8-maxim.uvarov@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Dec 2023 09:03:25 +0000
Message-ID: <CALeDE9NzzwyTE29GCYxRdb-B7OGNgaC11VCR3btmZj91=F=khQ@mail.gmail.com>
Subject: Re: [PATHv1 7/9] bcm_ns3: fix overlap define with lwip
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sjg@chromium.org, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, bharat.gooty@broadcom.com, 
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 5, 2023 at 8:56=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linaro.or=
g> wrote:
>
> Rename declaration to not overlap with lwip.

I think the commit message can be made more generic like "Use device
specific naming for variables so as to not overlap with common
function names", I also don't think you need to include the compile
error in the commit. Code itself looks good so:

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> aarch64:  +   bcm_ns3
> +In file included from net/lwip/lwip-external/src/include/lwip/etharp.h:5=
3,
> +                 from net/lwip/lwip-external/src/core/init.c:55:
> +net/lwip/lwip-external/src/include/lwip/prot/ethernet.h:69:
>                   error: "ETH_ADDR" redefined [-Werror]
> +   69 | #define ETH_ADDR(b0, b1, b2, b3, b4, b5) {{b0, b1, b2, b3, b4, b=
5}}
> +      |
> +In file included from include/config.h:3,
> +                 from arch/arm/include/asm/string.h:4,
> +                 from include/linux/string.h:21,
> +                 from include/malloc.h:369,
> +                 from include/stdlib.h:9,
> +                 from net/lwip/lwip-external/src/include/lwip/arch.h:83,
> +                 from net/lwip/lwip-external/src/include/lwip/debug.h:40=
,
> +                 from net/lwip/lwipopts.h:93,
> +                 from net/lwip/lwip-external/src/include/lwip/opt.h:51,
> +                 from net/lwip/lwip-external/src/core/init.c:38:
> +include/configs/bcm_ns3.h:52: note: this is the location of the previous=
 definition
> +   52 | #define ETH_ADDR
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  include/configs/bcm_ns3.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/configs/bcm_ns3.h b/include/configs/bcm_ns3.h
> index 47de4bc201..7c6e0725a6 100644
> --- a/include/configs/bcm_ns3.h
> +++ b/include/configs/bcm_ns3.h
> @@ -45,11 +45,11 @@
>  #define PCIE_ARGS "pcie_args=3Dpci=3Dpcie_bus_safe pcie_ports=3Dnative v=
fio_pci.disable_idle_d3=3D1\0"
>
>  #ifdef CONFIG_BCM_SF2_ETH
> -#define ETH_ADDR "ethaddr=3D00:0A:F7:95:65:A4\0"
> +#define BCM_ETH_ADDR "ethaddr=3D00:0A:F7:95:65:A4\0"
>  #define NET_ARGS "bgmac_platform.ethaddr=3D${ethaddr} " \
>         "ip=3D${ipaddr}::${gatewayip}:${netmask}::${ethif}:off"
>  #else
> -#define ETH_ADDR
> +#define BMC_ETH_ADDR
>  #define NET_ARGS
>  #endif
>
> @@ -749,7 +749,7 @@
>         OS_LOG_LEVEL \
>         EXTRA_ARGS \
>         PCIE_ARGS \
> -       ETH_ADDR \
> +       BMC_ETH_ADDR \
>         RESERVED_MEM \
>         SETBOOTARGS \
>         UPDATEME_FLASH_PARAMS \
> --
> 2.30.2
>
