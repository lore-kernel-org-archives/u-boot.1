Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E92EA71B7
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B39A83BC8;
	Mon, 20 Apr 2026 04:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LmMjULZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E30284286; Mon, 20 Apr 2026 04:59:50 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DD283B99
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so26845666b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653988; cv=none;
 d=google.com; s=arc-20240605;
 b=TVQmA2CNJowWysJFjQgBYqSYXciSZsBD2UE2z4prS2LwK55o7BV/Oc2ZtAr++D72Qa
 0baUzN83lwCAEI4IOP5CHUw3jqycMSo6Y3Hy/oQkFafkqjD7U5Xxh/vAOnUCnpVPf4SE
 uMgefOiyaCx2VOlZ3DqbUeFIdRMjmaXLhigX1ifuee5K6bjk6RejaIrqKYjlw3uCAIfA
 EWb/eWa0QidEpwnC3unPH6Y8e01DzxM72W9KCCRxlWQeuRcchcIXz8MhLTLPWKpOKIKQ
 CmBiEx6g3sqiEWdIi4GGMuBGuwSsD8JXHTIoG3380c/CDmQMDcHzhpeRv5V1nfBx0v2B
 HKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S2p9YUJR0RwQmgNr6j1WD67MfdV0sz6Rh00ijNmu3II=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=C6og/j2i4qKmvSvNeIs5vlBFihECiy+fp2MHzHou16/9s1l0Y1PkGm678I++dUvLr0
 swhITHOP7Z8feXdbn1RIvQrU+s6BY14ZArDN1YYfDissy+dCsbR1W0o4CMReqNJKSfyx
 5efhG5N1wB58FHMCtjHoDRnhmrvIHvgUJwkC9e+DBDJIdYumdqM2tUZLjaRnZG1m54rg
 EG8ir7bxrwewguXtjfPDofIAOvwmc852nQ1gtjQmv6Ty72jmIi4BolsCHi63qu58dgrw
 HIyENkXx9Hdn52Lm0/BItwn4bKVQ/hUtmafzBuDb9d7fV1Gb5zfPJ2/lrMB6g0hjWhYk
 gStw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653988; x=1777258788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S2p9YUJR0RwQmgNr6j1WD67MfdV0sz6Rh00ijNmu3II=;
 b=LmMjULZTOb47sPJItnYAzOCdVzFWhkQdk0wErcuYlhs1njI1RQhL3RNakmDHCPMRj+
 oviGh50vd80G00+PkKWhKPHIVt4PuE2WNBuXKnSFszRAvjb1eOtmnAVb8CqpacafBB75
 kjKX2rW+oabEhIXtdrzy5caShAyOJ5Q52K/Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653988; x=1777258788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2p9YUJR0RwQmgNr6j1WD67MfdV0sz6Rh00ijNmu3II=;
 b=pw16ifdZbHVMPb7KAh94UoSfSarrbQgRrHm0gQZhl88wAomgrmE+AmjbaYqA6RqGVY
 ZtiaLPgtfVTeYZXGokEmyr+9o0rFEiyg0FIrZz968qW4CFrk4svFb37eXD4pZes8wliA
 +/b04p7KsM2HFY1mFJWjbskdjUILnuKfg1dPil0wIHTmYS8czCWaM+7hLSEtHtxmBWRP
 nju8Gq784WSsqwK3wqF9NV9v+qGXxU/2qwmDTa+dDwvQ1I/muiGHk9f+D+Nt19xLuN4f
 skRYFc4FjpGu1oEpnbc9D/52B76DMUG4tPPsGDw0SefZs41S9JFKqpM3CM8ErDXc/8j0
 m0uA==
X-Gm-Message-State: AOJu0YzbJxhTn1/nyH+e4UiXZsC1dPwZyMYcqzUtlKAeYTsSsbvo6Q98
 PIQFH/rtdCF+6ee8K1AI32+MgSFajBrzWL3Ao9l+nuhOl8dqa2AAac53K3XQ6lM7lyhTPMjpF+L
 m7ElB+A3xiddOhwJWFOGdP/dYh7v0Q+AQT+JFogUW
X-Gm-Gg: AeBDietKNyL35I0vrZD5U5LuX5g2tZpZ13dovKa7ESrjjAOq6bBPT/Qa/8STvu9rY6W
 asA9YHpCeOUKzOmiMpqhxcQZgHzzyhIWXsM4h7jtMjcJ8ZeyCYgG8BukKkCbVH57CQ3AMNnbMGr
 yjFyDu3khWVvf2G/z5uwm7B7HFTMaS8BCILxFwVBYfODoO18t5KsPiOaMi7l7NL7+UaJcOOiINm
 3dBqeQokRxox89ZAam/AbuJgg7XV8+aQBsVV+Hc8RljxsGA8pDOn6DpLugxiWz6Sz9q5k4akeRD
 FxYuBf+ciSw+7Ve8TB4D
X-Received: by 2002:a17:907:26c4:b0:ba6:1662:e7b3 with SMTP id
 a640c23a62f3a-ba61662e81dmr234655866b.34.1776653987633; Sun, 19 Apr 2026
 19:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <4b5af507bd698752af52fd318273fb5fe40e53d4.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <4b5af507bd698752af52fd318273fb5fe40e53d4.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:59:35 +1200
X-Gm-Features: AQROBzC0KMzf-Ay8_rVqp6HkWVbHFvh-8S5MgquwJAk7xC6xpcHaF1KPDx7R2mk
Message-ID: <CAFLszTj9nd+1N7U5DyQfmnx67F67OTdHFo0FSArpLMv0qSZgAg@mail.gmail.com>
Subject: Re: [RESEND v4 14/14] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and initrd_addr
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and initrd_addr
>
> Add fdt_addr_r, kernel_addr_r, and initrd_addr to the SC5xx boards,
> to be used by the booti command.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezlite/sc573-ezlite.env         | 4 ++++
>  board/adi/sc584-ezkit/sc584-ezkit.env           | 4 ++++
>  board/adi/sc589-ezkit/sc589-ezkit.env           | 4 ++++
>  board/adi/sc589-mini/sc589-mini.env             | 4 ++++
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 4 ++++
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 4 ++++
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 4 ++++
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 4 ++++
>  8 files changed, 32 insertions(+)

> diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
> @@ -3,6 +3,10 @@
> +fdt_addr_r=CONFIG_SYS_LOAD_ADDR
> +kernel_addr_r=0x80008000
> +initrd_addr=0x85000000

The kernel_addr_r value 0x80008000 looks incorrect for this board.
CONFIG_SYS_LOAD_ADDR is a2000000, and sc594-som-ezkit uses
kernel_addr_r=a3008000. I suspect this should be a3008000

Similarly, initrd_addr=85000000 seems inconsistent when the load
address is around Aa000000; sc594-som-ezkit uses A8000000. Please can
you check?

> diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
> @@ -3,6 +3,10 @@
> +initrd_addr=0x85000000

The standard U-Boot naming convention is ramdisk_addr_r - would it
make sense to use that name?

> diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
> @@ -3,6 +3,10 @@
> +fdt_addr_r=CONFIG_SYS_LOAD_ADDR
> +kernel_addr_r=0x84008000
> +initrd_addr=0x85000000

The commit message says these are for booti, but adi_boot.env uses
bootm with fitImage and does not reference these variables. Is this
preparatory work for a future patch? If so, please mention that in the
commit message.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
