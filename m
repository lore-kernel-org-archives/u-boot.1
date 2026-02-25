Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF0FD3767
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604BC84013;
	Wed, 25 Feb 2026 15:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="evhfN7jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D88C8401A; Wed, 25 Feb 2026 15:45:48 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (unknown [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B5284008
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 15:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-5fdf6ad2517so4309888137.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:45:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772030681; cv=none;
 d=google.com; s=arc-20240605;
 b=H80vjt7KEJcVk4y/NaEP2FpFEC3PxldWGbrNimm5RxCzmMmahnuEMQJhoYFKwx2CHG
 wJyRB2NUHvuBw6OLcUaXOZBkzYVl2Miq9ShQIF9pnyH4pupH9YgO+w5FBIvtObdx6j21
 f/SZ7y3U6AJuPWZ6v5HsZSZS1KLcCyUTUdfKFzFLL6vajE7JZjj0QGHdtW8IOIeEAvUe
 JHlHz+qr3IRKqHol8/ORaTkZ5p0Z8HdLzgv7JgG2UycT/4lJVtdrtoupPDwAypYODGOT
 0qXpKmDcJXaO66g3/bZ/Zur2Hpkq8bZVzFpBjall3n5d0uc4hkBX9+gCaXAIwzJEYHM7
 x2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JRTTGByiTpydyzIXY2OsXfta3eF8pZE0zNgaSzFnyBo=;
 fh=NJC98CYmoOMuOUQ6moeWKWdStS9d0DkepP2bE5OamAA=;
 b=OqWKPeuq+pgrt310unHJZO/KeUynvtvIgsQjDNpVWCXegwsTn8n0M6zuC16yM0L7Jb
 dstkD3/FrRS1XvfSX0EXdreyiMRiJTCcKuC+FLV+CyVxmCucX/LHAVzL+ThoCLOBefx6
 93XbjUIsUHixU0tnzHDsEOawiLtcCJrJAkH/nZ7vKj2ZzDWdbAnlY3VEnV62CAInGM4s
 gSOUyr91lDRTmKO98gFUN7qiD2aS7zkFEMrV45kA4LmXhB8M2hRd4kOMMrdt4+0l1KCE
 cKcCo0UP25gmQjcE6CA+bJnSoqIsoEjVAawZ/hDMSkgWSMyOrS0rIHP1XaPOC9WBELHE
 OKfg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772030681; x=1772635481; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRTTGByiTpydyzIXY2OsXfta3eF8pZE0zNgaSzFnyBo=;
 b=evhfN7jfSXxpM1CyUGfPKIN6gGjBX+RaYgkszBnKgIbG8L93lVgZGqYIeZ0KM0TXSF
 wsaUE7INauH6nLzWim3k13VF/QlPFdTVxQjYzvKLVs3fQX5rAYVPzhh0Z83TIG0/P7Gp
 /hBG5m262+YWROXC6rBkZ9F3jiilGcQvtrHbiG0dW08sP7phZz1ZnY8AsRcMuxrZhThB
 nTxuBNiAEBJ+SuGv43pEW5A5mZzSCssoOEjGeA2oQvSQEZm8R2cMQ7Ic2I5nKDtB8O7B
 +ycINBM08qO1ZgNtoRu0AI50jHwiOQOZLytw5HvUQ4oc6bGhik0E8RIPHBwoFUpkqirH
 6KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772030681; x=1772635481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JRTTGByiTpydyzIXY2OsXfta3eF8pZE0zNgaSzFnyBo=;
 b=VSGzftJD0io1FDyo/SNredOib2sXWjwnugvcWcYXIGwK/uDLUjpmd6O+wGgBLX25JT
 QWWvUUetsaL90U28emZ8z+29pNV0Y/RAlQN0TlXUJJO5UCXeEpctWEBkrOW2x0CmbeOq
 g9omffI5SoS6o4y0HrVi1Rcp7OULAf71msdciOKwIxI394/wnfd2PIbyD1mbweBgkmQQ
 +5ZZONea2siVLSwtRFZ9LKEHL4g40Bxu3uz2BY97Xk0VDXTDF3R6YANgYm0t7UR5Y78M
 FXIx+F7um3s8ervr1m4x2pKJYZ57cTyLxlkqXoJszRpZLVAQxMSaBBlFu/hjL3GmxFZ3
 b1ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/kOkk+CkuUJ6BOCF+ma/G7KYHvizBfGUL48k/kDvCAPvICka89n+DcL63UQ/AP0YrwGPcJ+I=@lists.denx.de
X-Gm-Message-State: AOJu0YxzQ2W0tY6ObpwqMDL72K+TkCbn1WCIPeEfNipiFKlbfgWyTl2N
 m/5gUAny3YDJ+lHTyb3uWdsHPItlg+zVTnDlBLTKQgbWDWckkhq19lFdi6sv5Dkd/VicQu8zXub
 OLuWDL2LC4+5/wHrEpGK5kl3I1fZU8k8nRfxh
X-Gm-Gg: ATEYQzzDe1+3LoW1rJOy5VQTmwdNoGkG6H2ZwE2TLfry4m4Gy2Xh8RbwBuaZKr0grwx
 ZPQKL2liUB3jjM4/1ZVol/2on1xQ8Ukrd8PCF4sb8Kun5RPomHFOmTJqm3rDJ3HsrCmjSDmAD5T
 KJx/mHD10TK5QhIu5CtnU7epeNr+r8vnii4MB2D6hrrM+mU1FRxL6swLNScdTP1vfn93RrU0s4k
 RomY+50ONvu6wio23Qz/9ImuuDhlgfFmtjF8SjWyOnOyhsJES2PQ9oBtNnUSXI7bU4UOHPgZPwX
 T4Gq7mzD
X-Received: by 2002:a05:6102:3f4e:b0:5ef:2548:76b9 with SMTP id
 ada2fe7eead31-5ff13e5d91amr405581137.10.1772030681050; Wed, 25 Feb 2026
 06:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20260225072359.50691-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225072359.50691-1-heinrich.schuchardt@canonical.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 25 Feb 2026 09:44:29 -0500
X-Gm-Features: AaiRm53vO1zjLtu6m7fJg1rl_stughrE6aEgE_I_3iyTDZSXFmzY5rPRSeYtUFg
Message-ID: <CAMDkj5w=HoumBCvDB9LTTXAQbLpExzTcaSGtf-5atOLQP_8YWQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mbedtls: don't use non-existent
 CONFIG_TPL_LEGACY_CRYPTO.
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Wed, Feb 25, 2026 at 2:24=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Symbol CONFIG_TPL_LEGACY_CRYPTO does not exist.
> Don't select it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

>  lib/mbedtls/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> index 789721ee6cd..1e0cf8579df 100644
> --- a/lib/mbedtls/Kconfig
> +++ b/lib/mbedtls/Kconfig
> @@ -556,7 +556,6 @@ choice
>  config TPL_LEGACY_HASHING_AND_CRYPTO
>         bool "legacy crypto libraries"
>         select TPL_LEGACY_HASHING
> -       select TPL_LEGACY_CRYPTO
>
>  config TPL_MBEDTLS_LIB
>         bool "MbedTLS libraries"
> --
> 2.51.0
>
