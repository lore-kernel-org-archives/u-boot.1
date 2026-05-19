Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B78CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1946843B6;
	Tue, 19 May 2026 14:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ACuLwCK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 635A984659; Tue, 19 May 2026 14:15:47 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A1C80433
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 14:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso9161834a12.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 05:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779192944; cv=none;
 d=google.com; s=arc-20240605;
 b=GZQeFEHw4VCyS4iraL1ewe81EHSUJPUr407gb3ZYV63Qq5+zHG//3H4Yh5w4bw+kpR
 erw8lx/AifXmTfRHB/MuXsDP5HAQqtWW79I98cdIJjK1c4xKSAe4LVUr1DgY99LMzMPN
 3LyE5tZPmWYR4wsxEukchfegye+tUmL5o85UeGA1SI+IHLsyDXxR/7tWF/zAm7V2qeDH
 f4MIbcSmbGVe52XjRB2FtAZflAUKFd8H5JqgjaabY+epFc4nN4UPvAMdMEIt+eCFtetn
 2E819kIiMCVJAwFLGBtduqh+CaewqXoc7GeIB8tRwQ8oODtmuoCqWamD+xJrPengoWP7
 cwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V1Q4cb0Lp/tYqFyrsmS8afJRZNJKh/3u/OkpeNKB+Cg=;
 fh=e1z00lmJpA6t+BfI+V9AMsQowPo1a8zK98y0Y5z181k=;
 b=A6ecYZE3STiO5TOsxMJ/KOd6S+7XAlU4jI64PcLoAluP3nXWC5uWoH+xBlXNXT/WdF
 j5nyxnAdS32Q7Xj1BzRu4x1bnMt6MXKsvyHWi+pZQkFnTDTwG9RN33jwTRo4KCfEw0QX
 vBJVaxnD0w+tu5ERVYnUXDfpmY/LXSkukn1pmP7l6+8LUnOGjjgrzJtVEwfciSNr8GXO
 cHqKUrZfYrWlSJLaO9cpH6q86ICoxXOss4zZezwdAQbfTCahYCRaVMccgWQTSf8licxt
 06TIZwsT6CmjrCQLvnfX/goNbTd53sgPpjfX8an/VmFxHz2La2iEQ7tqXuOn7JyISScl
 F3lA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1779192944; x=1779797744; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1Q4cb0Lp/tYqFyrsmS8afJRZNJKh/3u/OkpeNKB+Cg=;
 b=ACuLwCK8Mve9GXRcqcWmcnRsMsryiXsSY2/rTOdHeAXyOcjLAPDl86kbLbMglC1Wlc
 aeBxkY7I6XJnrVuGrTzCYW6R8IKpLJ7qFuLZ7HrkLqUTzOhEVs3JsMD4mnumbVPSNba7
 edKtIPYESXdFtM9PWw0+TORGx8G/dnYeIAjR+opweCojud+gBg44giYolSnVLfzmzuXF
 sok+nQXqbzcdP9M+5FmGXEHQbVh3oh291aDr6cF3NfiUkzEj+A2rwA/bT+Wp7MbGtGHY
 wCwOILoClGCAjkULKRFmydCJpvRG/RyTVfD25AcorqLjKqY2vE3RsFIZMRvJSIP1UN5q
 Kf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779192944; x=1779797744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V1Q4cb0Lp/tYqFyrsmS8afJRZNJKh/3u/OkpeNKB+Cg=;
 b=e2RGaTq2I7nUbCo8l08zID72wmmwgrRlDYpl4Zs6UZXRSLtgz+SV/o97Qk3VdFgBF+
 eBaEpx4PoopSbYLbB9PTA2NJWvueLHcbGcGXwbaMpeAATYb0mynrtQ1iwhVAUJTz+Lb8
 D0iDypmoji68OwYopLuMfvG+ck8OCWlrf+qZXcpZAsXx3h43aSHTaCRRLJPdOl827f+2
 uvXEjvjCYLV+K8O7LCH6W14/s5F/7cQqX6P0wTI6eHWHRdFYdIMvhLaras1mfDSsOhWW
 yOjN+HhJGl4yYdAZDTgKOSPbLCa+xCLDfta9W4b+3ElGw5vI6t3pgjWBV55Sm3aFkyGO
 gIiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WEogz3I3eyjPqjb7aII3Tdxx5AOXXfujVXEZGW6JwkEOW1TutXpC0tYE8EDexRtxQM/2hWEM=@lists.denx.de
X-Gm-Message-State: AOJu0YxGx5LZ74IPWm13B8WRzm9M7G/uDvvRlOCuOKJMIDYUHo6vEqoM
 LXIesI1N12TKpfm+Hp8nzyJF3j0eAg3qK0kth+feASNz2POWnTmRoUH4nnnTG55YhLLXHl3dJ1H
 HbrVefU/aAGV4QM66gEFOsma4Z+vNoH+gWYuPmgYv6w==
X-Gm-Gg: Acq92OHWJVn926iG1rb+Lqz58M7w4mvHNUE207An8UO9rtEaj1tDfxWOqYH6/c+UnsC
 8iymfnuUmmv1vSl4D2rJ+XFiK5FsklB2HNqituhmQ817IoKwKG9DuYrgtICxYYL/C7BlhljjeWe
 YDjZ5V48e8Gg46IeUISSf2sdRaXRzF2DAZB0z9N7UYyIEzzEUb9a1B4DQggQXUz0ShCGHn2qxG9
 jCWtfkJIls2AO8GE8/g6SIlOOg0PFd5VNi+qgugvSj2MW7wNX6Fou/z3IKVfWTyNdSQIh7hxN3u
 fEObMpyixJDGrIhBuY74tvJr5vT3XgYMU4H4UrKXhKcxcayvkuktZ0Grvyo6t72OqdLWuSqz8na
 tpaSlRjDMpXtaMCX9VpErPTnPJF8=
X-Received: by 2002:a17:906:fc10:b0:ba7:41d0:5efd with SMTP id
 a640c23a62f3a-bd4f34bd0afmr917873366b.28.1779192944015; Tue, 19 May 2026
 05:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
In-Reply-To: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 19 May 2026 14:15:36 +0200
X-Gm-Features: AVHnY4LPuMCR8cf9dcMtVslzdswfPfqIbNrty7F1HA1YP19ojCSK__c2cMLYZOM
Message-ID: <CAEHHSvYaF+NaSRvrzMrdD_6_puongowkFaJ80P9wxtHYSg3GAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] configs: mediatek: genio: enable common options
To: David Lechner <dlechner@baylibre.com>
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
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

Le mer. 13 mai 2026 =C3=A0 00:32, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> This enables some common options used by the default board support
> package for the MediaTek Genio EVK boards. These options are already
> enabled in mt8189.config for Genio 520/720 EVK boards. The patches in
> this series make the other recently added boards match that.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Removed CONFIG_CMD_PART from the defconfig.
> - Added a similar patch for mt8365 (Genio 350).
> - Link to v1: https://patch.msgid.link/20260507-mtk-genio-defconfig-v1-0-=
5ca5d5c956cb@baylibre.com
>
> To: Macpaul Lin <Macpaul.Lin@mediatek.com>
> To: Tom Rini <trini@konsulko.com>
> To: Julien Masson <jmasson@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: u-boot@lists.denx.de
>
> ---
> David Lechner (3):
>       configs/mt8188: enable bootstd, FIT and DT overlays
>       configs/mt8195: enable bootstd, FIT and DT overlays
>       configs/mt8365: enable bootstd, FIT and DT overlays
>
>  configs/mt8188.config        | 4 +++-
>  configs/mt8195.config        | 4 +++-
>  configs/mt8365_evk_defconfig | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> ---
> base-commit: e662ef4ea8e18887f97c07f64f2ebe17bdb15cac
> change-id: 20260507-mtk-genio-defconfig-7b165d83a812
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Hi David,
Thank you for this, tested on genio-1200

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Tested-by: Julien Stephan <jstephan@baylibre.com>
