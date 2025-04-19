Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E634BC369C9
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 20:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181B381E72;
	Sat, 19 Apr 2025 22:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WBk6S55W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4774F81E18; Sat, 19 Apr 2025 22:40:23 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FEA782006
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 22:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso2430467a12.1
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745095219; x=1745700019; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InL4yBSfZfPnMMN+4Fo0i84tW2pF5bgpKXxQKYoyeD4=;
 b=WBk6S55WJmwT2bSGqs5leJyKkrDNLJkLSOBZLi8gAuYAQgnJgoul/gxFcQS6VqZuS2
 lrixYgw6NQ3+pibi5dLHK8jBWXaqs5YuBi7HkylMpfOKHYKmdeb5gUkjHbk58R2R4aqy
 LFdnm4Gnou/Mh4HaErcN8sNy8cmHGBzWdRSrErfFTxkytpjsLvDWk09INcozdCS9Q7Eq
 9PHNcAJyoWaEZoiWKs0/thdjgQ140r6gBsCJcyJ5uUgFu9Vkbac80xRD3NXZgJecCGt+
 6aIVtj7p9zitMgjAlUGlyCJEo6TtxgpsP2sIKz4aCmAb/SwXa7KErdThgt2s8Ne5vsDm
 q0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745095219; x=1745700019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=InL4yBSfZfPnMMN+4Fo0i84tW2pF5bgpKXxQKYoyeD4=;
 b=UEPyxHBrA51y1ETy2tmDM3GMvC/XbH69osTxbo/jTiqIwHRP5mUq9eyQsoB3HfzGCU
 bQXfPnbAQT9mcJz+Q9CNoJ/UuzLyxZ8dss1TUgjGqTVO9917IjIr0v2C2+14daMBaNHW
 ekhv1rtLhtifwOzVA/ERG7k+EkQaqNFJrGrUaIJ1iEjleduKJe+c93eV8s7OAW3JLK9z
 8vILPv3eEHJbxqDxvVMasK3rMQTA6EFjoDB8ixNJ3kB7xFL0djvXSA19ERm5hqpOUViS
 w0VBFpefNjBfV+W1iyu5ekc8OBHXsJKs35DiDvdWpW44ey7Lc4BRNZPVvvaN/eG3uA5O
 jiRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNge8R2Jg7JkIMJUPOLsLaCibBgZ/f+0vvkgYUT8fMr84HIqnBLC554CeiUTQRzi4xgK1I+7k=@lists.denx.de
X-Gm-Message-State: AOJu0YxWdXHKs4e+IcwF1y90eYR2Otl4gxRmS+aFpaNg9VqBOyTjehb8
 Ogt4RPf/NLxvykqZz3I3mmcw4OgluTWuqZAJ+ldDzn/ThwRH0KA4yaybE5Bf+KbPXqRJO08BrkD
 kH5Ny/tAyde/xpWXOXWmpcqlQHeM=
X-Gm-Gg: ASbGnctzLynYexPaHLj2zOeU7qqsU+g2R6MzRFjfgMVjqJWQi+4YynFmSE26F5aKLPd
 8yb80br4zsK3HnmqsMDoJsRDO57AfIkBhF2+11MuffgMTNmlZDx/8yQWGrwCikDvQqVAmMY6MZq
 854/eIMAMiNySyHTHRsPHmqV84lwZkRq+M
X-Google-Smtp-Source: AGHT+IEZJlFw6FRcRU0dj6CDOtcPXS9+/Q8UPMCnsTlJYupCWrlkOV4LCbD6FFu0Tq/6ZkcJ96RGD0JVUiejbj6ez1k=
X-Received: by 2002:a17:90b:510c:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-3087c37c36emr9339185a91.17.1745095218828; Sat, 19 Apr 2025
 13:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
In-Reply-To: <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 19 Apr 2025 15:40:07 -0500
X-Gm-Features: ATxdqUHWwBY0wmVfHsbRSlURT0OGQqzDAfN6uN1eFJ81BwJWAwB_2vqheCLkMyg
Message-ID: <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marex@denx.de>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Sat, Apr 19, 2025 at 2:12=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Marek,
>
> On Fri, Apr 18, 2025 at 11:53=E2=80=AFAM Marek Vasut <marex@denx.de> wrot=
e:
>
> > The "clock-output-names" is NEVER used for any clock look up.
>
> In Linux, "clock-output-names" is used to register the name of the
> fixed-rate clock.
>
> From Linux drivers/clk/clk-fixed-rate.c:
>
> ```
> static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
> {
> ....
>
> of_property_read_string(node, "clock-output-names", &clk_name);
>
> hw =3D clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
>     0, rate, accuracy);
> ```
>
> In U-Boot, we should register a fixed-rate clock with the same name as in=
 Linux.
>
> This patch aims to make the U-Boot fixed-rate clock name conform to
> Linux standards.
>
> > I am fine with the first half of the description, but the second half i=
s
> > wrong and this actually does not fix anything. Simply remove
> > clock-output-names from the osc_24m and the code will be broken again.
>
> In Linux, if "clock-output-names" is removed from the osc_24m node,
> the console becomes corrupted
> on an imx8mp-evk.
>
> > The clk_resolve_parent_clk() is meant to perform the aforementioned
> > resolution(), that is what "[PATCH v2 00/24] clk: Add
> > clk_resolve_parent_clk() and fix up iMX clock drivers" actually fixed.
> > It seems there is something still missing and clk_resolve_parent_clk()
> > does not do the resolution properly for some clock, but that is what
> > needs to be understood and fixed, not worked around this way.
>
> Please try to reproduce the problem on your end.
>
> On an imx8mp-based board, run 'usb start' in U-Boot, and this command wil=
l fail.

From what I can tell, on the imx8mp, the usb_phy_ref parent->dev->name
value s "clock-osc-24m" which never matches "osc_24" and I put some
debug code into clk_mux_fetch_parent_index.

I think clk_mux_fetch_parent_index needs some additional logic to go
up the chain to the root node and look for 'clock-names' to match in
addition to what it already does. I am just not sure of the best
method to go up the tree to find the root node that defines it.

adam

>
> Thanks
