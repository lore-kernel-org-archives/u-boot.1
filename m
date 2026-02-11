Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C82EA3F27
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 10:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8E083A5A;
	Wed, 11 Feb 2026 11:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M4dXxij4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051C883CE3; Wed, 11 Feb 2026 11:22:56 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF2C82BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 11:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7964fb9ae3dso31133087b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 02:22:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770805371; cv=none;
 d=google.com; s=arc-20240605;
 b=CBGbFq9g1ihwuns08Vvw913e19wn3g6zGs+XuKIxrixEh17JJ9eia0ETJQqevCNU58
 auHHa5G9kwFHGc536qwzKdrRUp9pWx+Ix6vBEYUcZmEln8oz5tt9YhutXGVSdxteB2jA
 Rjqg8lS9+wOZJDrR3lif+MfgiLEror/qLyJWR7eDb5Fq3vi3CklGPTqe6aWPjgovm4YP
 /VAW3PBi9opz5CY61i+S089no1fq4DFFuwD0op+aCOvPAQfn0FQE9k3yYNzb0MhX9IPx
 wZmPaMo6HWuCJ+jEmbz9WXBH/+kRpdofbLrBLSS1ssZu1c3o0BrxxomDqEoVJGXFgzmC
 UCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ul3qcrzc4dm5bssw3E3JpcNIBi2zWqOd1IoLuR0i+b8=;
 fh=H4ZpI2fHgDkKD1n76f/ADbZZSvaXcHHkOkI8hGPqZwY=;
 b=c2M1Nb2zqoSGRJl3vxnphgMow7aF1OS938bY27cZizxzHOPxNiuKhszHTgai+ADiKP
 L+Ys2dVg/9KzVj2aTUeiTOKTdZXZIuqe+iSgJl6Mq9W3pIfBsswu3nMSWbhWwxvosu2f
 mpI8L0lPDLqSOpG/8Ky5QoKWbm8psiG6rP1Wm6imQCW4hJVTV6nUlqgZ/Nisb447TBMX
 K4yAd4AJTb67NquYmNeUHMh9rcoxdp3jt/jJDpMByYg8YCp8HHgzL2KTOFEyt+uvJYO2
 W+xUoN73EH5gyT+LhRhhhAWAyT1IEe2n3hNotJuf9tz3mWepf4A/KvwfhDs+qC/D37/E
 q62Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770805371; x=1771410171; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ul3qcrzc4dm5bssw3E3JpcNIBi2zWqOd1IoLuR0i+b8=;
 b=M4dXxij4U9bL0OJp+UB9+FTw4nGpv5+jbewClmFd1DixwIMuNU8XUYkEFrbeXY1SQe
 3JOkS/fJrfUt4rB0lQf7FphnIz7JB+/uKEPwIWwfyCdHlroyIFKWmrT9byo3lhOd7jU9
 /ukWOZYNDboFCwQg8AkVUi75V1HYFnVwqGXyHZkILYLw/spqEwbkHKC4cC/JOMYBlSxO
 Ns1JR0DZpVXXDsQStgbOPSkmaksMYtYFJOJJbtdCajML6BXuUZQA7LnhRzQtCt0F7iSh
 gluYDIvATfdwQaSylUV5tjb3MX8tRP8OmDlB+LuOsT1SJYHhtf8QGSmT8r1JWsKbVMBL
 GZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770805371; x=1771410171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ul3qcrzc4dm5bssw3E3JpcNIBi2zWqOd1IoLuR0i+b8=;
 b=O2Xq0hLHDpWkWtgb6V+Sw3ulq3fO+WdeyuBaLgHowSKj5/Yua+4QPmAOWXpdorND4K
 H7V4U1PZhPBofzUTk+KK2FDDohufboRM9GjqTLlyoOR6LSy8kovhZLfaMJayyOsl8lYw
 YNQgcUsHMlM4uGKzQL38miVmwoiNCmEHUxdsbp5lvbjerti1U7gVqJravMibB8MbHxo4
 AZVMAHNI1SPTFUBZQ8evwsk5b3UhAEfyZNM7xE2Q4uWVUjbSzoRdAbZpXW5w2kEH0cGp
 whqh5SyNgDSAammqMwYPZaCwLOb9C3EJ9EvLJhAnwIzF7xLfcS7REPldGGqFj8BedSsF
 //PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs790stKCl1zzix87zQ+6Y63QYxEHo5QFP2K+1J1GYUNoB7gqMta6txOxrnRUO693GHxS9i8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyAnT6jv1TljE9N6Ya25jdY6bOXeIgV6th8qcyMtgZNh5TJsC30
 hsghx0Nx7q2xpeJSBEW+tpv7mtNHXaVdzkIYK88hcvyn+KyCB/VG10DnRX8RXROgeRdR3ZcVJEA
 QykpfDL0Nz1gf1v5j7ZjE0FitooF9VJjC5utA5DCIXw==
X-Gm-Gg: AZuq6aJxzq7YurfoYVH870Zqx2LDTR6juyGUmUngjNq44Ca5FiXmRklMFen1hyiVl9R
 fwlQIQbSe1+YwKscQ4LrxgqAUvrYI/51B0DuJ46JAJzzevymQY6whWvhyYd2tIffgL1xCjoPrek
 q7DkvVTXW/YZ5XTG/t/4PusTAWneSHFEsFMjn5VIX84r8DQkuCWVBd9stcOVOVSp655c8kCfOf+
 qjrqqGxf0kybqowKixFFLKRPmCjrpDs9QZjjXMG0BR/eZwx2eZYvYv5lqGAS5xBbowuBMHr5KIE
 Q7rMQ8YcEK7JTeZ/8BmWI3xke4gaLD5woywRPXL8hKKXCCJwsQQ57IX2aAqPW9YJrwdoiWfla+P
 lxXNUFwe7lIfTDKL8qf4DJUnWnQ6CN0HD1LRU3g79Fdz7SqULByWT/rZiGOA7VWz7S/WuO0P0ft
 VJlhQzhGrtb4bQJBGZg1KW+PkrjKegwAImIv68Wqr41Lk9CMndbrVfOriDeUMh8oUVs+sQR8Zgh
 Qm7ictJvsuVWQMv5Kd/d96QQR8SOdKrSYX4KxrPofGOUgSuHyxgS362iEKNjmV29gyFphduLvrN
 FBSB6aotLwsfLVVuAM2igPXYbAxx6DAfzDSKpDd1RFCB
X-Received: by 2002:a05:690c:c4f9:b0:796:3981:fd6e with SMTP id
 00721157ae682-7966bd94426mr10195677b3.10.1770805371116; Wed, 11 Feb 2026
 02:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20260114095654.736511-1-kory.maincent@bootlin.com>
 <20260114144918.GC3416603@bill-the-cat>
 <20260206151945.4448af9d@kmaincent-XPS-13-7390>
 <CAC_iWj+XZ46w859tFJc4FSEX-AOUGgmbwe=1dyU8-bPG7+R3+g@mail.gmail.com>
 <aYxWBRTdktKn8DRt@a079122.arm.com>
In-Reply-To: <aYxWBRTdktKn8DRt@a079122.arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Feb 2026 12:22:14 +0200
X-Gm-Features: AZwV_QjOCsvrebkBQHPteZcYE-shfcaZVgX3rCMs9CCcDcyRJck3piZykdlFyIY
Message-ID: <CAC_iWjJL_tUV2E33QvqXAStN3e92a8J6rueo9neYtYwzwBTOqw@mail.gmail.com>
Subject: Re: [PATCH] fwu-mdata: Allow multiple metadata storage drivers to be
 enabled
To: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 thomas.petazzoni@bootlin.com, Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Wed, 11 Feb 2026 at 12:12, Sughosh Ganu <sughosh.ganu@arm.com> wrote:
>
> On Wed, Feb 11, 2026 at 11:04:17AM +0200, Ilias Apalodimas wrote:
> > Hi Kory
> >
> > On Fri, 6 Feb 2026 at 16:19, Kory Maincent <kory.maincent@bootlin.com> =
wrote:
> > >
> > > On Wed, 14 Jan 2026 08:49:18 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Wed, Jan 14, 2026 at 10:56:53AM +0100, Kory Maincent wrote:
> > > >
> > > > > Change the Kconfig from a "choice" to a conditional block, allowi=
ng
> > > > > multiple FWU metadata storage drivers to be selected simultaneous=
ly
> > > > > instead of being mutually exclusive.
> > > > >
> > > > > This enables systems with FWU metadata on different storage types
> > > > > (e.g., both GPT-partitioned block devices and MTD devices) to hav=
e
> > > > > both drivers compiled in. The board can then select the appropria=
te
> > > > > driver at runtime based on the devicetree description.
> > > > >
> > > > > The change converts FWU_MDATA to a menuconfig and replaces the
> > > > > "choice/endchoice" block with "if FWU_MDATA/endif", making
> > > > > FWU_MDATA_GPT_BLK default to 'y' for backward compatibility.
> > > > >
> > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > >
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > >
> > > Hello,
> > >
> > > Any news on this patch? Does something prevent it to be merged?
> >
> > I cc'ed Sughosh which maintains fwu. I can send a PR if we get an ACK
>
> Apologies for the delay. I will get back on this by tomorrow. Thanks.

Thanks Sughosh. If you are limited on time you can ignore
https://lore.kernel.org/u-boot/20260206152027.1c371812@kmaincent-XPS-13-739=
0/
I've already reviewed it and I'll send a PR to Tom shortly.

Cheers
/Ilias
>
> -sughosh
>
> >
> > Thanks
> > /Ilias
> > >
> > > Regards,
> > > --
> > > K=C3=B6ry Maincent, Bootlin
> > > Embedded Linux and kernel engineering
> > > https://bootlin.com
