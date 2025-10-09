Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD4ECCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 15:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAE4844AE;
	Thu,  9 Oct 2025 17:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="b8StFxuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B9484558; Thu,  9 Oct 2025 17:00:00 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE84084181
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-57bf912cbf6so1134950e87.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1760021998; x=1760626798; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zD3B9HrUJqoSAwXB9G8KMgyMIdZkO7cN1UAxgQWNUSQ=;
 b=b8StFxuEji7KSrxLgpKol+QYbbFDBoqDSti3RHn5I6nDn7hs98lLkoaL6krOZ6uM0Q
 NfRZ24tUwtmYnc8Fl2VILbY7GxXXN5ilsJzYSx1mniu0WyQxDNiXam8Z59oOGwUHHMz8
 /Gaee0Fu6QriojbysRsVZFtDFHeboAhYpl/LXclocKez9h/lQMyevPsVWyhjUMgchA0F
 OaO/F54/CGfhsJv1RxMUIIFlkp9hvMGdBsc9uglEaPGLL7eRe3aG3ao+nvjDUPJ9zpzG
 bGhZYSzX/PnuO1rvdXa6GWpkFc/yt9JnOckM/XuAQqnjI1pkGVsryw3K/MJISdSVr46C
 t4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760021998; x=1760626798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zD3B9HrUJqoSAwXB9G8KMgyMIdZkO7cN1UAxgQWNUSQ=;
 b=JXQs5hE1nod3S7to3wII6jNuSCiH/z15v331WfgEZphW4lxK6cFueo9S0VjSyI/F8A
 BwFOUWU14waScxHS+Anw5KWpiW/iNfrxJRx8zVl0bj+e7F0DFxe2IZKlKS2rXWPviAmH
 /cQxhfbzlABDlTsRwkze0E9q2BbveQjaa+FdmEMcv+O0j+fk1MrOtbYWzB1eWwTvxgi8
 AcZR5qBWaATxuDIBpxNxm38xPHJqwR0588YAP77TCkxqhC6EoC6eXPWtHFz5gcXY3Jb1
 WvupUKc35c41oXwrq4OvrFtSDJP6CeQDVKJEqVu33hUHqJXJNogC4dsOUFL6+edVpzFz
 e7UQ==
X-Gm-Message-State: AOJu0Yy+C0PFtVcbFtQi+YOqjBCF5p/qC8Gj675iCvfX9JSRlPhgWhyE
 hp/64/zSuYv0mFPd+NW2SF8dEZiKti8Wi8HqQy73Gd5p2BtLxYpnzA4+ssoMnAz5NZvz/EIhzoi
 05u7BPsV6zCQVT6DM576DN6kT/NdhMYA=
X-Gm-Gg: ASbGncsoMIj1JgLUB6dL72Icm6THEHGJjbKbGXwtC/DXDThYE9opI+Zn2/F8SCPiqIF
 MITbDHrr6NwIAHBoMfEHNizLNNMwvMyX8jeVXz1VwkJMIDR7UhcpQoQVbmYOeHNuBHyIULuXFOU
 JAI2ft3lt/9iVy4UQEuDSBd1hCgxbezL05mJl2BC4cmtUsCageF9mo5hJhq/w2rbWvK8BQ9YgAc
 xzBpuDbt7OydBkJgSCdyTdejo+gY52G
X-Google-Smtp-Source: AGHT+IG8v/muyGMAy7CAf8o0iwJgk58RPdja0g0LwMQP/IdIlVoApxVY+O8sN7ynFoi6YIt+3miZNRNPXNwJ77+dyfg=
X-Received: by 2002:a05:6512:3ca9:b0:57e:4245:114e with SMTP id
 2adb3069b0e04-5906dc18396mr2279325e87.24.1760021997773; Thu, 09 Oct 2025
 07:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251009130844.11703-1-patrice.chotard@foss.st.com>
 <20251009130844.11703-3-patrice.chotard@foss.st.com>
In-Reply-To: <20251009130844.11703-3-patrice.chotard@foss.st.com>
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Thu, 9 Oct 2025 16:59:45 +0200
X-Gm-Features: AS18NWCYuu3-bk5PDEc1L_bncwrYGVRefQ7kWm3KXDekVY472_l2bSia4MYl2_0
Message-ID: <CAGm1_kuxrK+Fzd0qZiejw7uHnGGGZUa0dxNMt=17Ei7YAhkBxg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] led: Add LED dependency for LED_ACTIVITY and
 LED_BOOT
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On Thu, Oct 9, 2025 at 3:09=E2=80=AFPM Patrice Chotard
<patrice.chotard@foss.st.com> wrote:
>
> Add LED dependency for LED_ACTIVITY and LED_BOOT.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>

Reviewed-by: Yegor Yefremov <yegorslists@googlemail.com>

> ---
>
>  drivers/led/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> index c98cbf92fab..7ff5cefd29d 100644
> --- a/drivers/led/Kconfig
> +++ b/drivers/led/Kconfig
> @@ -11,6 +11,7 @@ config LED
>
>  config LED_BOOT
>         bool "Enable LED boot support"
> +       depends on LED
>         help
>           Enable LED boot support.
>
> @@ -22,6 +23,7 @@ config LED_BOOT
>
>  config LED_ACTIVITY
>         bool "Enable LED activity support"
> +       depends on LED
>         help
>           Enable LED activity support.
>
> --
> 2.43.0
>
