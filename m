Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BC4FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2DDA840ED;
	Sat, 25 Apr 2026 18:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pc6/puB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D884383FF5; Sat, 25 Apr 2026 18:49:35 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA1B841F2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-479d593a0c3so4850732b6e.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777135772; cv=none;
 d=google.com; s=arc-20240605;
 b=Z+1McaHd1eitJ5r2uCqxMqln9RlSi3rM/X4dlFDnMTuTYTtzBDZNBnmFdIsHQNzU0H
 rQ+IMl9ImvF+o2O85Fpy75l4LSDErv8Pg3DzFiV+sJkGj+xkzsXomSkcexscV3zjZXTi
 VAVJEp543KiPSLhpDQXTJGpItKgfbjH01zg2dQZRDXLydo3HYrutHiImYVjV3r5FRxc2
 w00WZ9/JraPAZ8hvNBs+iQv0DL/Ci6aWWrnLaDVZd1IC1ikbklsLL4Re0nZltyljCWdg
 vOhTs4R0Yj9LRxmi0yFEeuzN7hhXS3aV89EE+57JO/LJIvqsmHXT7Wve0evQv5ugNoCB
 szTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u6xU8clAbf4HDOpo5MM54IdK0X8LJrdkKD6LDLWugi0=;
 fh=iI0k2WOlHk/i1DDgkPxRh2JLVGuTZOkAhh6iawqqQt8=;
 b=EQ4wK2A4K2h4N50MTWI4d3+Z4ejrROhAG/ihKdqIKjT9usrZBbjym/oF1CEooreAaM
 mwl3DMw/7vsEkCkvsgE6m7jqokP9tgai6IEARx4BTCZ3LvUWyOe6qSLAs23LhC6YFP8J
 hfp800zwPrAof+CUqOW6DCu/4EK0oeM66fUYIgPsisu9BRoG/n4Q68AS+oiOMy4DVIEu
 bvGfIasO07GLFsPLBhtpzi8mhZNqZ+3ypxS2raWqoJe5CL5aGYkTYltsaHEUdrIRnsg1
 bU0GHsFCCmnHEkEMD6LkkKDRvg5OYyGasXvv/pqaGaLoEtBUQXXvNag1xmbGLZFO4fr4
 VxbA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777135772; x=1777740572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u6xU8clAbf4HDOpo5MM54IdK0X8LJrdkKD6LDLWugi0=;
 b=Pc6/puB/IPJHn9P7Cie+KYGN7yDnHpPiAAicLXZeJ/4YocBtplT5ugGj7JGd9r0FIh
 ZWxStYMptGHCsNjIWwP6or5e0cK6APqFDdF5NBz0TVqI8+xTQl8BPzxILpqtN99eE2jR
 ui/LffnXviezg0ZtxTKMztJ2I2jBTQAmRMXn/R7MZbJ1Wzq5ZzzzJ7W5mk34eziKdE/k
 SJ0aXkXQSBebVOndECSmnj/7VurKEO9cEJyTIA/bp4jfGX9n4gtA6EoN5RBsvU9AkvSL
 KyKsYR+gVKjJ9TpzWWWZ0iTTrUPlGbkIewQjd+66tOr9JE1+FPQPuxTwM0V9l6n2vJwK
 yEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135772; x=1777740572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6xU8clAbf4HDOpo5MM54IdK0X8LJrdkKD6LDLWugi0=;
 b=R17O9fCPo79c9lGtlBMl6PgszozONx9DFTYs5+WHjCjbEHPIVxffJ2RBMc3pqjCvEr
 RmLrnnArrPZWtbWV3hAAtZ/V79IkM2xka6F8o191osIAQXLEodFC0afvMYk2bZ+rNklA
 TsmTb4YAn9bUM+UaLU/G3ZRR8dhf1SL36WgJzhycGStSFleqzBv1jZXcBjTH1IDq3omy
 3Cqa7imzyl2rNVGEzeI1vBopdJl0SBbXyXzLN//ZETd5TwXmpZYcDI060r1whn1c/sfr
 Ojyc/8VV6ap2mQv5BliaJAoOG0T3Su72aFADWk5dXADvdy2stUHzI39dTV/cM4dv/zV5
 Qc6A==
X-Gm-Message-State: AOJu0YzHqMEX5zEWUeenqrtHfBi5ks9wm2Yppj9X7+YEK1EJXhTLKWhj
 RcDw8OzpWc4PjMHO1YqvBY1LC2W0NRvTZncHZLI9yPLNsKRg5HT6JWnDf6s74Zz2SW6A9JK3sNm
 SOawuoDDHHmq0c5G4XT5zYUthvFRvms6jW0g0ZDjWapnH2WGdC+1RkWQ=
X-Gm-Gg: AeBDievOE6vTNFGY7QNYDyB0amy15Ohy8jR+EVVW5wsKHV4b3VXmvPPUdhq1yzJ0V62
 W3tSdgUA+7pA+RTP5p4F/Og2VuR709QHF2AUtEFj/GoJCMt7DExn5QDi7EM1lw7NsozYl7GsSIe
 45nHjLM3iG+Knk3Ne411Ogg0sCgzJIcx/N1EQz7LYkgHv7JeXV2wlaPCX4JAI4fiM712H+QO/fu
 MAvps3QUjMlviBSJ8UwvaNNRGrWWjFdeE9KfKjEftGvyJzKz0J70sqv0Cp6eJhSpTRjRFJ5ErVH
 hv3Gd/Uz47Yf7Ub0z6hfbNHiALrUhZ5n1sIvwHESNoargy4MbW0ZxJ3yHihy3k2BbmEhupZmV0k
 AcUZHPojBO22nC13Mb8K05zCkL9N2yqpjnaiGn+IwC8CPIzyJOec836MLdszRkOT4EI9Bu6FCac
 LFBrnbgDWzA54Yk5+Cb7yOrCr/snisCig+O89jVR2cYdHiRQbOz6odT4PoliImJRQwSdeb0LCPm
 0npqiCrYOHpOPmIKvOxucdNeuO7TNJkl9OPOfdjRhYh26YDmqdVciI5r91PB28JyTF/3CJ7IqIL
 ZxlHUvIHIF4qSkNFCtH1T/EIL++IJ2cK5GZd3mehjIMt2qRrIJzO+oU5KOSOl8xRbA==
X-Received: by 2002:a05:690e:1697:b0:650:3124:b8c9 with SMTP id
 956f58d0204a3-65311a9ee43mr16685531d50.20.1776934707189; Thu, 23 Apr 2026
 01:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260422193846.1333146-1-raymondmaoca@gmail.com>
In-Reply-To: <20260422193846.1333146-1-raymondmaoca@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Apr 2026 11:57:50 +0300
X-Gm-Features: AQROBzDP_acyoPcX7-eUfMU2MQgb1_DARbXSY7B-r5k9ZVuSDfGoEd4PnKK4UMo
Message-ID: <CAC_iWjLJCzKRxEvCOH7RHSrvNUtPPJxBgwfAJ5GBfKTMSu-TUQ@mail.gmail.com>
Subject: Re: [PATCH v2] smbios: Add an explicit bounds check for Type 9 length
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@riscstar.com>, 
 Tom Rini <trini@konsulko.com>, Samuel Holland <samuel.holland@sifive.com>
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

Thanks Raynond,

On Wed, 22 Apr 2026 at 22:38, Raymond Mao <raymondmaoca@gmail.com> wrote:
>
> From: Raymond Mao <raymond.mao@riscstar.com>
>
> Fix Coverity Scan defect on Type 9 length.
> Type 9 formatted length is built dynamically from peer_grouping_count.
> Although peer_grouping_count is a byte, the resulting formatted area
> still must fit in the SMBIOS header length field (u8).
> Add an explicit bounds check before extending len, so the size used by
> map_sysmem() and memset() is guaranteed to be valid and consistent
> with hdr.length.
>
> Fixes: a8442c226635 ("smbios: add support for dynamic generation of Type 9 system slot tables")
> Addresses-Coverity-ID: CID 645487: Insecure data handling (TAINTED_SCALAR)
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> Changes in v2:
> - return len 0 for errors to align with the existing convention of the
>   file.
>
>  lib/smbios.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index d5f18c8bd69..fdab5948aad 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -1093,6 +1093,9 @@ static int smbios_write_type9_1slot(ulong *current, int handle,
>          * TODO:
>          * peer_groups = <peer_grouping_count> * SMBIOS_TYPE9_PGROUP_SIZE
>          */
> +       if (len + pgroups_size > U8_MAX)
> +               return 0;
> +
>         len += pgroups_size;
>
>         t = map_sysmem(*current, len);
> --
> 2.25.1
>
