Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBE2C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 09:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE198058A;
	Sat, 15 Mar 2025 10:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VvqGbFCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6792C806FC; Sat, 15 Mar 2025 10:41:16 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45B980540
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 10:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so710880a91.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1742031672; x=1742636472;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RUGrQmCLcmSj+VnDfkCBt8nMdq/nUEufPPEs14TNubc=;
 b=VvqGbFCrQJ/QkXQ+LrZXdViujv2olNbOhoMG4ofxvTCEE2gBKviRDwsrKJfpGZ+ecm
 NwexpJRL1z9fyhJMVwq/6ReGjrugSrRAYxV5LtZKNTKkyvxquKHEN+lLzLhZqRU7AcdB
 zGO7lwsiCcFBSM83fbXanY991tTRt8LWXx2GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742031672; x=1742636472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RUGrQmCLcmSj+VnDfkCBt8nMdq/nUEufPPEs14TNubc=;
 b=kc4/d/ICLKAEaB8Lx4wywmIBt4GnZc9/Et/OnIL+c6RWQy9l/737S12l38kc/YWcTs
 4pMyirzDbxrlYGa8XrBP1KHXTGzs0o/y88WdY2Sy85F00jGrPtsNuyBUCM9VHnC6zM4E
 bwwYHPcb+nU4k8XKeiSHQa1xrMIOxOC3W69lqE+IpA3gN2siuvQ6xO318KJ5vT7KkCRf
 x+p9aCXbSEkexf6ntt2cmVkfIFxEB0gDl1M11xP50LUTeASryRBbFXhYYhh4j0sijQh5
 90W9BAECRH+C15WCbbRsmAgskORO0N9lZsKd3D1X+dsNGaG8ZImERBX/oA4p97OBBZdr
 6d8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKx1QsvuIEqEOAJIF0/c+zp+pkhvFoG/zKtyFtpd2rA4Hc0h3DZwVmBzewwmlg1nqpvcOe1SU=@lists.denx.de
X-Gm-Message-State: AOJu0YyQLmuUeAJ8LzfKxW3e8kISOIQjVVkWLz0YqqNnOCl7lxROBm78
 pYgHrAQ5XrladNARr9hq6yXP2CpAVwSmgR2kChLmqKflLZvA10utDusDtW/Oh/8rNXJffs/0K3H
 JmJFnSwZogfnOQdJtJrLaud/614WxDD5Jsq1Ljg==
X-Gm-Gg: ASbGncsMsOhTpFboF3Tw6Vsjp7dNJDwlEMLjVMt5qeQ+tLWVcQ+wn7EV/tuBijl0u+i
 ULKEGdgH9l71mAG6fYF4MKVM9s9eDaq3Ez5yAWrRqDIBwmRfaVCc1UPaldyXevHI6Iim0Xd5it/
 GpkzI32ZsOpEtMs68/ABc/3IQ=
X-Google-Smtp-Source: AGHT+IGSuwTPIJ0n6mf7YxDZFK6ZF6lzjWHLWFHdfGBIRXSw9HS9mkBFKPP3svfJxhvUpVSHtaU09j2zhi/ofzIBdNI=
X-Received: by 2002:a17:90b:1113:b0:2f9:bcd8:da33 with SMTP id
 98e67ed59e1d1-30151cef70emr6028291a91.21.1742031671824; Sat, 15 Mar 2025
 02:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250315092420.793-1-ansuelsmth@gmail.com>
In-Reply-To: <20250315092420.793-1-ansuelsmth@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 15 Mar 2025 10:41:00 +0100
X-Gm-Features: AQ5f1JpyK94d33O7eJxJk1amgfM38GiU-Lbp7plF6KZ88TCiR_n_KwNU0Pq8_qQ
Message-ID: <CAOf5uwmbO3iKtzJKPqcJp1utTaSY87i0AsfTqFZ2P6QCdzJ4Gw@mail.gmail.com>
Subject: Re: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Tero Kristo <t-kristo@ti.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

On Sat, Mar 15, 2025 at 10:24=E2=80=AFAM Christian Marangi <ansuelsmth@gmai=
l.com>
wrote:

> It's currently possible to make the bootloader crash on calling
> clk_set_rate caused by the loop in clk_clean_rate_cache.
>
> The loop assume that every child of the clock node are also clock
> device but this is not always the case. For example it's common for a
> clock to bind to a reset device or also expose a syscon if the clock
> register map is also used to apply special configuration.
>
> In such case, on accessing a device as a clock, the bootloader crash. To
> correctly handle this, check if the child device is actually a clock and
> ignore otherwise.
>
> Fixes: 6b7fd3128f71 ("clk: fix set_rate to clean up cached rates for the
> hierarchy")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> RESEND as there was a problem with email To:
>
>  drivers/clk/clk-uclass.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 353ae476068..8f3309d9530 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -554,6 +554,9 @@ static void clk_clean_rate_cache(struct clk *clk)
>         clk->rate =3D 0;
>
>         list_for_each_entry(child_dev, &clk->dev->child_head,
> sibling_node) {
> +               if (device_get_uclass_id(child_dev) !=3D UCLASS_CLK)
> +                       continue;
> +
>                 clkp =3D dev_get_clk_ptr(child_dev);
>                 clk_clean_rate_cache(clkp);
>         }
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Michael


> --
> 2.48.1
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
