Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26345C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 13:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D3B84B92;
	Wed,  1 Jul 2026 15:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fD6TxiMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557BB84BB2; Wed,  1 Jul 2026 15:00:10 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0277884B88
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 15:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664cdeab266so753151d50.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 06:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782910806; cv=none;
 d=google.com; s=arc-20260327;
 b=aAbpjX91/Brtxvsv9NiFwEnXHwbw1dgwGagFGZuuwapJDL3cZ3r04c0APwu1+KZDTp
 pWeE9+JY91gV8sV+/hZxSxiLO3SDaUuiriaMUpMGEWpJpBQ4THhpDMrRopWU8uSmiktz
 wyhhImFDp9PoPKShIDTiihbhTVkqBkNtmj4/OL5DDucfUkRZOdRC5zGQUGHniKUGk1hf
 Vhx1fUPOmz3POZKO+xqj5jRx6cTn7TbJoBHV/wjRU4a9Nf9xgPRf0j/AQAxyptctydm2
 WLFr/1lTg+BZJiKZ0AFa1GuCO6s5Su52Ly7kdtCNjK3sDzzUbDfMNjpDdOfJjJJBMyRV
 f+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tBugRhtSBRIA3aFbs6rSjlUL9acGGvtTQ3WDJPzWGMk=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=FLDBUbvUhzNAGmCh1YOQdKT4IsmYt6GdTc9dwfg4H99tw6c5ckEniEv0hD7GUgV/QQ
 78pvG4VZ28KuOWhEDTnzwss0gYp9BBbyqP2zoDw+nQy3oiygmnz2P2FGrUm71F8eWypG
 yqASgVn+b9Tsy1n4UEosgvkZzXd1DDyOPM5o3+47zTIuH3CKk3zihZVNV++h6XzhWdu/
 GZr2tzW8OV3+0N6TRKIuHF+w3MRIIY1kQKJscQaPpzQvyZguqjvRJAgDxulYyhnMLnXw
 pu2DqxeGLCRI9y+j1H1FaCCUI8tZfGV1/6pA1qIJse46bPwU6BeulF01F75pN9zKh6SA
 SjZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782910806; x=1783515606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBugRhtSBRIA3aFbs6rSjlUL9acGGvtTQ3WDJPzWGMk=;
 b=fD6TxiMDBWDC+8riF6RzR8w0XH17MVQxBodZgJdkOpaTe1Md9pZnRQfzAA57Vearwc
 6nAQqLqx/foJPcrTYzJ2sjmBNOiEdzPWaNWHqngKzT6k4qmrpa6PEFawnPAZptyIAZNi
 UpF5XIZzPZwCjvcUhTp2cfu6ml19ipNjc9tGm+k8fv7lUalpKs1CmbraQSuevmOMSJ/q
 11quqgKBoEdaHCQ8GBMmL/FgDOgVGROTcyhEmbpWHEyH1D/fMzMS5T1fIY7bySqQnBpw
 EBQuD0IoprW0A3rn/2uzaUk8haN+ZWPcgn4K+3cLGwfcKQz/tSQGzJyGWFiO6JUQC9N1
 LS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782910806; x=1783515606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBugRhtSBRIA3aFbs6rSjlUL9acGGvtTQ3WDJPzWGMk=;
 b=q9z05M7OjloW8lqPatHcXmJZGOkjFa7Vv1YMNftIEqfqC+/GmLiQEnb4bHDGRgf6Ef
 TPP2EQG4iZTTVTt5liA2JdmzBnRQaeAlKwDUVlyZrURN4EDcKCcYV4VYsItlxkE6i4L4
 ETOD3DsdZjIWHKu6pqlpWqm85uaQTiaSP0uQbBnYgIN3tnuHcymVsPK9WjdXepiMxjNH
 ptuE1kI7wVQIhRtU5RL7UenSJAwEPQyoytT4inCs+AYhft0Ic/XI6h1qbY5YU0p3JbCY
 gBgxqTvHaCBQlZsTX4d181CE8eYMpD+U1ny+YPzPWcRCLbCQpBXtMfwzDlz+O0PqaHr9
 dSBg==
X-Gm-Message-State: AOJu0YxKNTt4JlDwLJf6oBBZ8AVvv3zOm1qm+GDJeScFpSErTUrkT2Sz
 mcxoOpb5bP7ihZb2ix5qVBlW+QnXVrzkXoNJ3npI8EL2bwg8Y9tRTs0Spbv2mtdBzsF74YvMRES
 4UXHc5bDOVH98drprDLuwY1Va7UJJEqmrTHK+tBxv3w==
X-Gm-Gg: AfdE7ckRdOgS5QhIbbzbljQLGxN/D6Fj25dUW5+xggqnAohfelK6D461g1cDOtN/Fk/
 ngNojzxXZ+zkKRSIsqMvhdbrQ3cr8DZQLbh0Yzk/b2hj+sq281ZJ0ENpgyNhA2rmaDnY6htM55r
 OFFVldOY8eM19LbPRag8WiEbdd0ECbHlp5IqbKm9W3Jqu2QvdzGmcyC97lrHtzo+idZjANLOS/O
 xKd4DZ5LzDcsno/GXomDS5aNTzjrBbgVrJ9g0dgzXc65Mug5h+STA0RFWM1A7mc7spvN4R91L6w
 iHzoG8OQtH8mDxUJb8Srn+Xs3HNhpBTdKMnEDpCduMMT9G/cdXtc/thsObFLROebV2iFGkef2Nn
 OsON3R3AeBD7ULcNGw3jDkANBTs6qsF6dYwC9PohBBLcGaH340CH73c19puloKQhkfqdULQSsP8
 +g5F31UdW+z2ABl84F59wOIdXviHABoNUdDk0YbBDaIcQcCkJHuV1w4gUOSmNHnsgLauMzjTV1L
 xJNO14usiGGWfR7QMQvRrMYvFxjPguTTW3jSBD8rSKqZl5j2/v+3RAiwu5bd67hA/6o7GaC/p3x
 F31yoY/8NMNgXCFAucqSDj7poNu5DHnqHmGjHTSrnfBLWekYobeVnrwoH2KeLIGqX12m3XbiULM
 bwV0nrA==
X-Received: by 2002:a05:690e:c4f:b0:660:68ac:21d7 with SMTP id
 956f58d0204a3-66521a780e3mr1713459d50.35.1782910806192; Wed, 01 Jul 2026
 06:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
In-Reply-To: <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 15:59:29 +0300
X-Gm-Features: AVVi8CfCimq8CBLB8WMDr4tia5OhY6gKNGTVyN6ZVaHL2Yliae5KJGKT-26-bw4
Message-ID: <CAC_iWjK_qvhpQh0opx_Wzw_3BYxGWupF8w7OMQGyxCCcU-3p-A@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] arm-ffa: add FF-A bus runtime support
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
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

Hi Harsimran,

On Sat, 27 Jun 2026 at 17:44, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Add the FF-A runtime infrastructure needed after ExitBootServices() so
> EFI runtime services can continue to use the FF-A transport layer.
> Introduce drivers/firmware/arm-ffa/arm-ffa-runtime.c and
> include/arm_ffa_runtime.h with runtime-resident FF-A helpers for
> direct messaging, SMC invocation, and error translation. Add the
> sandbox runtime SMC wrapper, the ARM_FFA_RT_MODE Kconfig option, and
> the ExitBootServices hook that copies the required FF-A runtime data
> into resident storage before enabling the runtime context.
>
> Tag the runtime code and data with __efi_runtime and
> __efi_runtime_data so they remain available after
> ExitBootServices().
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

Having the FFA driver in  drivers/firmware/arm-ffa/ in fine. I am not
so sure about the parts that touch the efi_loader though. I would
prefer having this there. Is there a reason you are defined this in
the ffa driver?

[...]

Thanks
/Ilias
