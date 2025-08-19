Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE2BCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 11:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F61180FA1;
	Tue, 19 Aug 2025 13:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CzCkBPhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61F282BF6; Tue, 19 Aug 2025 13:13:46 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F2D802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 13:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6188b5b1f1cso6095997a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755602024; x=1756206824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ydr2WfEtOgMsHZxNJTgMKODrTIF5R1/fFcCX7R0mmsc=;
 b=CzCkBPhPcvq7G9O2w/tumWoD6JjBQyBZOewr3dsrhqur6TjQWWdIjjKja4D34IFzB1
 dn6KngMFGqBD+ZEAWFlakBvHEu3ADQT8DdLBjBHKi/N+RwiGCsiEpwQXN8AbAYFu8/uU
 yYvD1GUwqyHCQDKkrI0/zxPzf0/rc5YG8OC4vwKcmRIirXB2qgT6uM8tPc1ghPu6LF4i
 PgNRuRpR0Tx+Rd7Dd4fXtNB06d92WVJJa+rG2oyLNsWZZUV80sTuRboNKazBypbsoOL7
 OgIceivqv92J0RkfMGkdmNy063pUF5Fa2PquENLtvRkNpJOwr3O8TPj94psHW27yIlvF
 2EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755602024; x=1756206824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ydr2WfEtOgMsHZxNJTgMKODrTIF5R1/fFcCX7R0mmsc=;
 b=LqRkWbMgDxsWw8pY/vqXDP/U1BqrYfvdod6wbospNakPuEYeJPfh9b+7fSgSZivFKr
 LMYyDg0so5V2cS5Wj3yL1FXMP7qM4PzV2YrsVn7lsqgnW1bmvRO4sk6MPY5ch3XTQcpp
 3ToqfdrgJMWjE2rGaEBnn4LceMnK9OKA/4gya7u0+5tb0f0LqDIrf17OZbd0uRzlml3l
 AwXdiFY+8mmAIXZpWBYnrcrZksJ0tGsGNSRl8c081w6fQ/YkXn9USHhyIT0FbXRK1ipU
 4ErYjVYXSXs16mrid2FwhNH0uiOB+DrgTMB2Na57p26Xj3VcesoqR4FehycUUwgWAimv
 RP4Q==
X-Gm-Message-State: AOJu0YyX0mOhdVT88/x3qTfjo0JGEPA+ZhB7haQFf1pkmsCHLKiNEqzG
 B7T1sYj/m2ndzDoIbpQ0AEn+LrY/fQXpsGd9Ce3Fc04QfjtRZLwPCRiN9kq0go0KrhaeJ/FB9iR
 jNDrgsJKWgGOgsVjQqmmKozLyZyUwAXU=
X-Gm-Gg: ASbGncsk/s+HqxcVyb1XY7vurcUVl/7QPmNEmaDKtykmIq22KLyuEjkVCN5eYrfpl74
 VuzF1MHtHIqS5YCHWCvhxKnexL/gu/tBEqM/sGUhEQH1U3F9pzZsZPEa/cDMbTecF/9KzjqzprV
 s2byrQzANdn0SFZQyXlEbVd4g1DGXrQ0cHx4DNzoI4x2QJuTrwN8ikPfQYlfr6wjxwhJ7HatbBZ
 ml0kfU=
X-Google-Smtp-Source: AGHT+IHvLySV+Qv8dROb8RCi+M6P6MoGODehV2vMQK2E/sUtw3IOcSffIcKJMSRFehnaC7Fz3ZfK9G/YFbxvJqagU5A=
X-Received: by 2002:a05:6402:26cc:b0:618:9908:d2c2 with SMTP id
 4fb4d7f45d1cf-61a7e74099dmr1678637a12.26.1755602023896; Tue, 19 Aug 2025
 04:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250818165119.3193853-1-trini@konsulko.com>
In-Reply-To: <20250818165119.3193853-1-trini@konsulko.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Aug 2025 12:13:31 +0100
X-Gm-Features: Ac12FXxutlAB7sliBYsW7ZPNXxE3G9v2S5dDoRwRJHU-aOwQiDdLBzkWyAkB0hw
Message-ID: <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
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

On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> wrote:
>
> At this time there are still major Linux distributions which by default
> boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> DISTRO_DEFAULTS to ensure these platforms can still boot.

What is the legacy image format exactly? Does select make it non
optional, can we use imply or similar here?

> Fixes: d780965927d4 ("Drop the special am335x_boneblack_vboot target")
> Reported-by: Sascha Silbe <sascha-pgp@silbe.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  boot/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 2ff6f0037384..a6fc46ff4f5f 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1163,6 +1163,7 @@ config DISTRO_DEFAULTS
>         select CMD_SYSBOOT
>         select HUSH_PARSER
>         select SYS_LONGHELP
> +       select LEGACY_IMAGE_FORMAT
>         help
>           Note: These scripts have been replaced by Standard Boot. Do not use
>           them on new boards. See 'Migrating from distro_boot' at
> --
> 2.43.0
>
