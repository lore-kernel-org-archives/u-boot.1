Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94395C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248BA8777F;
	Fri, 10 Nov 2023 12:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d5QZJiwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF78874D3; Fri, 10 Nov 2023 12:50:44 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 073DD87585
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-543923af573so3244000a12.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 03:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699617036; x=1700221836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qiq2YU+lHBsE2MwSPnvnwBvo4qRHFyLp1sgqgWravFM=;
 b=d5QZJiwxiqvunTKW8vfMOg8m1nk2nE9io0U8iqsVtlT/8L7wJUee1iF+stej75BGV2
 weHQud3Xw1Tu1SBGt5JRLqRWOmoeTLD/NuLjpHFSEppF0Wew4fsU8jQQthtzcpKumXJV
 YlAFmAv2kn2sqsM4CwoOrgJCdeCpYWAukT4Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699617036; x=1700221836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qiq2YU+lHBsE2MwSPnvnwBvo4qRHFyLp1sgqgWravFM=;
 b=CNXp07AQqOBKmeLxe+QwiU2/RT8V6tZP4lQ44Z8sFZbxph8i9PvhoulNP7movnpc/a
 dC5dbdGUbNAyXoIHTTgoRwHDcRkCQZ0ttrmbWhn3n2mfsIDwOFKonOZdK9mhkKUwoW7Z
 COxzVS+7tc42zxbRJ4H8zDUv3hqDB6VF1pKbzrShzdTKkz5luOO6xUOc7CfH4bMvadyt
 S1+2GsbEvrB6eY9z5K4dWX+cR0DHEFhdDRK05B7ZpLcYv3mm/vl1qWi06DjP6ZC4iciY
 bd90ItaLIAV2RV/r0ZdbZJvb+y845jPF4uaRgB5tvSAODhBBwzIz9VD5CT1YpS233i/R
 OChA==
X-Gm-Message-State: AOJu0Yzjk4sbpxdAX2ByFmAdlE8TE1aOQgRFYk0nmCmLNk1RJeTCVpNd
 gEhIFjtkpSvb0zgtslmbbtZN2wzHkwO4To5CnixCWQ==
X-Google-Smtp-Source: AGHT+IHhE7KLB1gBGuN5th3GkCGAfCa8FrQQ+wqkittuW+OeW6qmN70eqmwux5yQC+VT9gSxqphxmxGi+Snji96VWpM=
X-Received: by 2002:a17:906:4712:b0:9e6:7f83:6547 with SMTP id
 y18-20020a170906471200b009e67f836547mr597551ejq.48.1699617036142; Fri, 10 Nov
 2023 03:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20231109031448.138723-1-randolph@andestech.com>
In-Reply-To: <20231109031448.138723-1-randolph@andestech.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 04:50:24 -0700
Message-ID: <CAPnjgZ2_JUdLXvUM7DdhjyqEOA4o+pSPKnSnYMQ6m3Ca=N35YA@mail.gmail.com>
Subject: Re: [PATCH] riscv: binman: fix the load field format
To: Randolph <randolph@andestech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, randolph.sklin@gmail.com,
 dylan@andestech.com, 
 tim609@andestech.com, Yu Chien Peter Lin <peterlin@andestech.com>
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

Hi Randolph,

On Wed, Nov 8, 2023, 20:15 Randolph <randolph@andestech.com> wrote:
>
> The #address-cells is now equal to 2. The format of the load field for
> the Linux kernel doesn't match.
>
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  arch/riscv/dts/binman.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
> index 6b4eb8dc7b..5117d7c8c9 100644
> --- a/arch/riscv/dts/binman.dtsi
> +++ b/arch/riscv/dts/binman.dtsi
> @@ -50,7 +50,8 @@
>                                         os = "Linux";
>                                         arch = "riscv";
>                                         compression = "none";
> -                                       load = <CONFIG_TEXT_BASE>;
> +                                       load = <U64_TO_U32_H(CONFIG_TEXT_BASE)
> +                                               U64_TO_U32_L(CONFIG_TEXT_BASE)>;

Does this work?

load = /bits 64/ <CONFIG_TEXT_BASE>

>
>                                         linux_blob: blob-ext {
>                                                 filename = "Image";
> --
> 2.34.1
>

Regards,
Simon
