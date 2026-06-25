Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6A1CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E828495E;
	Thu, 25 Jun 2026 10:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oIJT6BwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0818284962; Thu, 25 Jun 2026 10:53:49 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39E5846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2bf1cda2b17so4426445ad.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377625; cv=none;
 d=google.com; s=arc-20260327;
 b=mRfWlsKvPhZqbqCPp+gUZhxxLMkjusgX+HR/xDMfelilj/SfIQKAYrhgiRycQFc4Rx
 SpQcKYzurmY/rwHwP3Js4MqIxxfKmChmZlutRSZEO9JpVFqb594vPayw617g0bKGyvHi
 O1JppEk7fT7DJxa7iKuE5RP7Lkm4tfHUIAi+eeW1xMPrJyic0CtTiNLczIDyPZQyQ+vq
 2IEJxXSmk209cwaB6g69Cy2u7JjQ+XFz71frNtg5aVAvMIuoooCAbMj80Pk2mdfXZe9y
 XRt75X//VhtPPAI8KDnNIl/kB6/NQ+WEAlp9zbdFGgQ4fvkkyEeT4C3fk9fPK6LRNEBt
 +2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e1eLzu44bAWhAJplRZasX27t8LdEtqwqyh19Ra+0LYs=;
 fh=I16IQhF0mw/rgTi3ni9gUjxZyN7jTDX5zFA39Enuj38=;
 b=M2Cr+HlZG/zRH93NjqTURwsJ7BRj9Cign6lBOHupWdbLRSy0fy1TPdpPStvVhsJU2Z
 hq40cH+2KYFl146uNXIbrJZonRxYXZ0D2LQYjlHts/gxMW1tKTgkS7J78SfvWqIk3Zlx
 oHrhK0HZrE/fRg7YMuJTPIzgoD3Jq7Jj3YvQytuHESmDIQFia3S8YRkZKDYnScfgQ401
 MtDl5Dt8f2OsTBxUusuJYQjAdD+TJ9N1gw38IOMPcd/PaxcGBG4pzfc0AL29g/g4kvcn
 fa0fdm7m01Zd4mAcVuWMVWAd+coah39mYgFtRj5P8cu2GhBwx95mka89ZEHnTtuYJy/L
 uzbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377625; x=1782982425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e1eLzu44bAWhAJplRZasX27t8LdEtqwqyh19Ra+0LYs=;
 b=oIJT6BwPNHL3n4FBEs0hgjLWdaNIh0QJY3vRPHorYkVX2SjP0ZWoojR5QwKF4Pg2sv
 AP7JQApKgj31s/qbmwOqoTGOTz/hLysTFsLuhjlTyT1erOVKn30ydUGnQBPVxdiN8p4e
 XF/B4c0QOAnzoV39QHDtA96G63YJRgW+IYTLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377625; x=1782982425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1eLzu44bAWhAJplRZasX27t8LdEtqwqyh19Ra+0LYs=;
 b=leCQIUhW//Ohog1XXKQtcAQ6I6EIia074/ZjiLHzFa01jl8Fsk/vGbojOMeb6zwgTD
 g7//eIRnwebFv53gVN9mmLv0N4fYFefM8gqznhQUcU0UnkjAC+3esF5JETm9pQE0m0TW
 fhjYdDYWMVmN6tUSSNDzEOe91xWKct4VtdDdK53bpx5+lY6Q6/9acz4NW6Fc8IFLIaXg
 pbruPinDcEihOVelaV69M2Gag7DEC/70GRp2HmYEna9ZVusF5ckg+NhoOkojgm/WJkZP
 JxBx8cdJSqaTbOrUM08XQpnWFjFQWt8ExINRXPZxaVdqwKVLvAWVuU0Xzd1KamOUWHkQ
 cUGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr71NcfGSX2foijIEs1EGSEhTnGBlPBQF/OawdXeFJp0ns+N3bdg8fhH+KHxTuSb+XlwhG6+X0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz06O2jFF4BpRaArMh8CfjuUn8nA/rH5AI3c2FNStbebneQbwZn
 OYOIbpYZWLKhkhKmPSdQD+1BtrjNov3ZtpMWHRJ5yLpdPYPQsK3SYPE8q1GxIh1kjAUtP4QthnC
 wiaerQrkvygFhQI2/o0bkgwsWAc2GjzsYmkUpC0cb
X-Gm-Gg: AfdE7clUxj0RuZURUNcXsO7RAhaZQBOABFtj4DScUF+f2V6DFTv6vN4zZZADeEbQtpJ
 b2xFVzZSPJRhCQyB6oZVA+/u1froctTscR+Fbg2EucFmFAB7t9VzwbQhnj44hSWdNR735NJ6sTD
 /2Nv2U8QnaqZuCx7VaPach86WPQdu6OF4cjQ3VXlgZcOIEatcMByew5AfGgq/t5AxX8bBg2k17X
 jCZEpe/c1+Wpqym9430jheEAQ6BvnhRoggohG84BCsGi3GY8U37qJnDHXiB0I/h8MlW8wkt5A==
X-Received: by 2002:a17:902:e748:b0:2bf:1845:baf5 with SMTP id
 d9443c01a7336-2c7fcf6aaaamr13466335ad.12.1782377625174; Thu, 25 Jun 2026
 01:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-8-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:53:05 +0100
X-Gm-Features: AVVi8CfUYLd54ZKhxrjoZE7nPMl8eg9gTlzi872nZrux65VvX-RHgRhuH52RN2g
Message-ID: <CAFLszTjWF57UXqzhpg-HtNeVkWv4AAJrt_w8sRD3Hb39AvB8hA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] efi_loader: move string helpers to efi_app_common
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: move string helpers to efi_app_common
>
> Move the shared string-processing helper to efi_app_common:
>
> * skip_whitespace() - advance past leading whitespace
>
> Remove the now-duplicate static definition from dtbdump, initrddump,
> smbiosdump and dbginfodump.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/dbginfodump.c    | 13 -------------
>  lib/efi_loader/dtbdump.c        | 13 -------------
>  lib/efi_loader/efi_app_common.c |  7 +++++++
>  lib/efi_loader/efi_app_common.h |  8 ++++++++
>  lib/efi_loader/initrddump.c     | 13 -------------
>  lib/efi_loader/smbiosdump.c     | 13 -------------
>  6 files changed, 15 insertions(+), 52 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
