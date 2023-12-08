Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F508C10DCE
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 10:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64AFB874B9;
	Fri,  8 Dec 2023 11:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="JrHSDbFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6340E870D5; Fri,  8 Dec 2023 11:52:19 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A53386C8E
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 11:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4b2e0492fffso547550e0c.0
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 02:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702032733; x=1702637533;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJBn5sBWddScih8gGo+SSLRyQV4a7jHfId68sG0SUtU=;
 b=JrHSDbFB0am4LwjyIyeUCde/nDsdU0md29v6S2NoLQ7FhZGz5sZBYNPZgiSrSLSbzz
 eY43wuN8tc4K4VuU0bbJqqdIluIw6pwCvq9iZHyZK6neAEXRMKUL8rxpZ/NgrIB5zxIK
 Ff7dcdWKoqleMWrp5S2MF5UwI3gtqp2NM284XdllLBVqmpclfU2UuzHlzNbbYG+yCEn5
 w0JwiWELKVrp72Vo7My9jrEOy5/wYSUY8NerqIFW+NgEnspXM5qefnmOEGvK2eNGqpwq
 XgS68Ge1J+6IGHH2/n4Id9nSJeakOO3nSiAccf9z2z8njMR2tvKrs4e70rHrpSmNElm7
 YKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702032733; x=1702637533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJBn5sBWddScih8gGo+SSLRyQV4a7jHfId68sG0SUtU=;
 b=ufdT428l1rBs3X3AQcrgx8icPpXnpbBuDhChQBHm3UzC+f01aWOGOVmeLOAbNVb9yM
 SbV9M362QqF+s2wsLFWnNKpA/+aFf2bvLvX3ZC1ClKH0iOXFtU1wqJnWnh8iDym8uuC6
 th55IYsVoPO+zK/qVtTIgft/98i+kjBqtBnolcOtis0wVJGEIJfy9WP+rhopMZ1bVa+g
 PtSSZu1FmurRR8fpR1w2JnYXr33BdB+c/+4oqb/4tlwJOSK7AOG3L1A5PFE2zXIz1wug
 cehnniW2FE/u+nbuGnBbnnimYR2U6my4rWGjow2AS6G8J1PdW5EVQoWPG+NHf7DYDc0/
 wtJw==
X-Gm-Message-State: AOJu0Yzw4WasrRagciiZqm59KllIIXDj5xJ5F382ZPbjH6GOPAKE1eju
 i3mY/ShRabTwFgE7Zpyw4j75gV6HDt/YBk3RdLwcwpZ+KIMAXM8QHl5gwiQo
X-Google-Smtp-Source: AGHT+IF/sWncCleMGGph508oyrn2mYQ2dZGXeLkO9CVEDqSv9tYoK9fz+R4B1OioHVuuPYA1Q8/sELMTPiIeTn6VzXY=
X-Received: by 2002:a05:6122:2013:b0:4b2:8efa:65df with SMTP id
 l19-20020a056122201300b004b28efa65dfmr4420345vkd.14.1702032733614; Fri, 08
 Dec 2023 02:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
In-Reply-To: <20231119172310.1307942-1-i@shantur.com>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 8 Dec 2023 10:52:02 +0000
Message-ID: <CABEcMwW14BFrA1ZYWTh7iQTsnrXA7LdBPcREKf_QeO71op+Wdw@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
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

Hi Tom / Kever

On Sun, Nov 19, 2023 at 5:24=E2=80=AFPM Shantur Rathore <i@shantur.com> wro=
te:
>
> Rockchip SoCs can support wide range of bootflows.
> Without full bootflow commands, it can be difficult to
> figure out issues if any, hence enable by default.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>
> (no changes since v1)
>
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d812685c98..fca6ef6d7e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
>         imply CMD_DM
>         imply DEBUG_UART_BOARD_INIT
>         imply BOOTSTD_DEFAULTS
> +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
>         imply FAT_WRITE
>         imply SARADC_ROCKCHIP
>         imply SPL_SYSRESET
> --
> 2.40.1
>

Can this please be merged in ?

Kind regards,
Shantur
