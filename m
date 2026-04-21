Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81770EA71A4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 05:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9FB84258;
	Tue, 21 Apr 2026 07:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CBzjmEXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D1A8426E; Tue, 21 Apr 2026 07:20:06 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7852183C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651bc8f864fso2123416d50.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776748798; cv=none;
 d=google.com; s=arc-20240605;
 b=VaYJFWkvsQjpSYRYE3sMMMay/q+25pOn+I92HeCW2VOToGjGIlYc4r5UJQagbXsIyz
 sG1OqQiRqTpZLYurmEYCDiykL050lXyupomtjnaNBrsnA+TMU+agxX2oKYfy0+WIHJot
 yaQvPY/t8wOrd3gWpNdy6wHQhtsRXU3K9Pr9LOMpqLGXT5KgjpdRyPTYUlIlPppOOJvj
 YwN0fsccX2r9H8RrIgz17AEO0S0QQzrhmz9m1yoz2CYM8lNOB7iTXU5HAzJeDkD6ijhb
 scD7n3pImyQt7LS5v/ewuxoVT7PAaTeX81OIyXedi5hUEkKHF4vwLE5EyrybdARKidwY
 iLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3+2vcVbhGWw7yrc+HQ9uuq1/zm1q+g74sogCOCTG0vg=;
 fh=09XrjUL2JcVLcq1jOQEoGL+f+ZlQ6S83D6NmBzL553o=;
 b=Nmd0d6DGHBQjd3FxGZdTk6Cn7+o9wyvmVTx07ISeAQXix+PbU83zchZueHiJF0Zkmc
 dKZFxjPd8ijU4HSEIY8nmCOnWUmInsDfVyeKCGWCznA9DNb1Xk/I7hJuQ8pxezAKhPuk
 c0k5AAemh7fU5znBFQMs0zO6TN42j0KPzzBekLswxH9ETKXXJNdiLlq3dmwodFcWaAiW
 z9xBFXHeogyCu8whBZ8PN5oC6CNUBDhbGzUJfLb7/gEo4fXYND8407MGD2542ghNxp+c
 NHgzaPloFWQXGuw2O7zVtHS7hY2BpKqWWEw5oh5eZOsd0R0V3NUMZTcmrduV9TUeJk5Q
 YOxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748798; x=1777353598; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3+2vcVbhGWw7yrc+HQ9uuq1/zm1q+g74sogCOCTG0vg=;
 b=CBzjmEXbRnye0sjnb4UJdeWpk6vxufJnxV65t1SNrN6AYiac3QWa/31METecIOktIP
 jq7G3GUG13BRwEbJpJQCddAGmH5mxRBVviOGC+40CtLg1+tJnsaN3VANMZ5htr5R96ux
 +p872nFRlVpej1Wqm5RC+8XjwxaNhCCSL9rJm7GjXC/2wg5zPZc532iKaXRACstio009
 8jwtUSlKqfwOHu5xMVqGv/Z9/6rGqnCiDt+eomb892Fb5wg3esT+bzdbuVqgjHEpqMM7
 l2h9/6f73gLpyY0/XvEJwXzPD0pedXbo0lbONJWL+4jW2DPQ6+wDYmgFEYwdwTSJ8cgT
 RCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748798; x=1777353598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+2vcVbhGWw7yrc+HQ9uuq1/zm1q+g74sogCOCTG0vg=;
 b=EVpAtLG1GGFOjlEm58Z2VXxG0sOWQgccMfatSTPGXG4UnHQhLefAnFB5odgVEKCakV
 IO35owu1XvO9Sh6a7qhyI4ZcfSW7cpZitg5I6DDdCkt5QoLCa8HQqFw28C4ZkhJGGYi2
 om3iL0OnWnx11A/dw8BzCHHnOJ0gF9eDRoE9BZ+3DUVnEZ98gyRVTej/0dgmtzcf/iTZ
 hjzCG92ppEixWuGs+xhQ9qiIqLS3dT40reIVPL2MGYh4hO1Zvw1dcVARzNMRxXupRUzW
 W7R9SzunqFS0fDY1pmu7/cgLrccUd7uVtYHGUi+1yl8jHw0fK2PaaIYRvHkTKQcWOVOx
 +ySw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/rxqM8ekrxjVV0AqrIlSVTtk0ioI2sJygY8M9KXtVg34jKDJLaI6i0mmltesAzqUH/YfvUYVM=@lists.denx.de
X-Gm-Message-State: AOJu0YwM2PHu+Y1+4fzdCey5R2HG16e4/+usfHrfpKbZOTDUkwBrIVIS
 Tur+BMmbG5zba/bokj9eFYvGffRTTo7OzvhfeCjWR2JoIkqiOkyZtNw/QQoU4JPf+s5Ceeh27/n
 i9XayuRR14M7n2oxWmel5TJ6w84T+wctyo4Ieajr3jw==
X-Gm-Gg: AeBDieseDu9dk5eSKLAZLHyo1W6nUwFymLvWgD/yK4AFXoohwYMjyjYtdMFkAtpuoFD
 R3ai46GFNbL7EbatnQ/uvM7GoYon84iVTuQDodgsJCDXzi4DFCPKdUGxgo0JrkJK2kb8GLAP4Du
 mTphEseWji+wxBnEeHthdcCjcs4E7YKScNR+wPJWfmb6iG/Fk6g5dFBfVrbQeTv+EANmNs/Kxle
 sKSicHdHlB7atlbaq5cDGFjbP5qOa8hiHZCWFRJyo1x8QrPZmQF9Tild8WlT2jEX988+orzp0yX
 WCjYIFeieQfG7+RCUeA79BIzVCxqf4Q3ppcy0AO4rQJCN9WM9e96iUHlzk2pLf1DR/XvDPSyF9R
 wSpQnt2CT8CWmoll1ct1uWSqcyT64ymuNjlvRAZZIZKYeFxUYgilxlWkBpWoThbu9LWD8mOSzpV
 eKivPx4CnBeNXpbi4iOmqkxEyKLIrt0eYkwjxa+1pfEsC0/8tvi519HAHBBgZU1KQzjBKidwwXw
 969zb1woBugI1ZV75eRnXTHrGt5XaU7899XyO1VyfTpXID7geVD3TLlba5oC1Iraeu6GqPFDUtR
 ZsOlImK8CnilRQ3Y8GJAF6f9PEv//3UGjpo9avJsDQ/fgeIbpOnUlzY=
X-Received: by 2002:a05:690e:1656:b0:650:ea3:de9b with SMTP id
 956f58d0204a3-6531086ee3bmr10824998d50.21.1776748798264; Mon, 20 Apr 2026
 22:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
 <20260420220321.71147-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220321.71147-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Apr 2026 08:19:21 +0300
X-Gm-Features: AQROBzCPMmtPYshmXATVnWtKzyA4JpW-ih9sKH7UPhI8vZfoj12ovsZdRzF1K1Y
Message-ID: <CAC_iWj+h1nTUs8KGY7oTFX4EwniLzgnutUTSXnJi8CY_uoo0kQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] efi_loader: correct efi_binary_run_dp() return
 value
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>, 
 Ying-Chun Liu <paul.liu@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
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

On Tue, 21 Apr 2026 at 01:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> efi_binary_run_dp() is expected to return an efi_status_t value.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Fixes: 6422820ac3e5 ("efi_loader: split unrelated code from efi_bootmgr.c")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
> v2:
>         new patch
> ---
>  lib/efi_loader/efi_bootbin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index b394f0d60ce..144266b785f 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -227,7 +227,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>         if (ret != EFI_SUCCESS) {
>                 log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
>                         ret & ~EFI_ERROR_MASK);
> -               return -1;
> +               return ret;
>         }
>
>         ret = efi_install_fdt(fdt);
> --
> 2.53.0
>
