Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22F7F46139
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EC78418A;
	Mon, 23 Mar 2026 16:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QcpFvEMt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE018418A; Mon, 23 Mar 2026 16:30:24 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9016484144
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79a74765703so26411267b3.3
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 08:30:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279820; cv=none;
 d=google.com; s=arc-20240605;
 b=ceybYvZFiyOoPlVwygfsRMljR0q2y0b3HptXkYOon2hChEhl3Hs/vl4T0kuCBMSuRx
 MCVjxXMgltZZTviqSKTrAVpFG/Y6CSdZ0QYny9I8qK1xA17TAdclP0RU77xveHdPTX5Y
 ezBSG4dnlUgTWcv8ltx/WJX83KIu5F+IEOH3zYwEVlJjs9Fs+vtITL27easZ719TTaKI
 CGfkJD6UiZ+7yVWFsBeHfqm4mTW1t5W2rRymF00vy2VOgKQ54HAIaZHBF+5YfLPkzwMA
 O0vndCVbPTVL8SUC4lgp+dyBQAek9DeAhUc7ZWOJw4EDY7ti0s7KN72nRMMS9ORw0mnA
 Wuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vZmxDxjrQ4WlpQ9kHXNemZeGflf1otO2H0YnZ0H2A/c=;
 fh=Sm85NSXZ4Zd87FSCB53LZttHN6qS1hdtUgXzpD2h2tg=;
 b=GCnz9Vqn8JKrmkuXqQmYGH4G9lo79AlLZgpJPH9wXduPYVbeR6QQ87sFQgHCh0gqBu
 G6ZneVBUjARfYHunEedQSdpYjfKlrCVZm5FgNBSlkRYdQQlMTDlyR+G0NSPblxSeYJAv
 eV6KXsxvOdBEpU/HVDchnOANhrJbsdID2YS/plOMyDaN20XXqXmoy7R0TQYH3nQBZNCL
 LLNz/YqtDgDfe9xGJyJMMtDon/McQ342oWLPEFQ5OSKsw63h66gfwmQN8/vkb/PeKKrS
 Ln5AeAv/zrC9vGcGlMofSmC9/u0leYB453Ux6OeFG77uVQuGkOmrzSrFIpJp+zZdohO4
 ww9A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774279820; x=1774884620; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vZmxDxjrQ4WlpQ9kHXNemZeGflf1otO2H0YnZ0H2A/c=;
 b=QcpFvEMtOc13M/kLghuJdUE1OmUpUobBU1IgQ13soEzN0KJk9GSq3Xw97/ANMh3ERG
 DJZod9trl+HXLXbKZAjqlfyD4nsw9gu3BNju7xr6tKmLZTVixglfYL8+WkfljTvcKgT1
 dWWrnqE70LPPJv5FShaLumy3o5Stjk0cydrMBZUur8DN8CT4eVbsnjxVDNQX2KUHsrPi
 kBe1w6kExeJY+z0DvvW/AFHSVCxrjOqUcXj/3PMyz8hI63m0LigfHJVrdc3tOf0fcaKO
 TjRZ6KvcDoRqbafgHsJdWy1FyriWks/bmfPhkKCkH5gSQgbb4GakbYj2VxG4iwuLjVoC
 osmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774279820; x=1774884620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZmxDxjrQ4WlpQ9kHXNemZeGflf1otO2H0YnZ0H2A/c=;
 b=NR65d/UCI+GxV15MQH/bSBpeHflkGOycWbDlMM47rtmGAE1sDzyJ8ZPSIUOHk79Vx1
 xy1dETaBdNLuq+0FCCN39i5J79GyOjsCbG7mKnWlWI19Bk45NLzppGVrdvXHlWln/X74
 YQZR5CSfhwwSEIbTzkw+nZH6n3Osx6z/KAYeChTxXar1LqPW3WURT2Vpt79BWbl30q5E
 WPA2CJD2NIdiU+60pp+neLg1WUIuX6ZMI6JeWBuHc2V21HynhrD93CuJq81DUj3Z//Id
 da8HnOFfOt79z8jTxrWJLymoYPfKAM0c3jTYkZtVDxQaae7NuGljyFe3l/OFTz59TWkY
 pKeg==
X-Gm-Message-State: AOJu0YyM4HAhWejm4QCSTUeCEQIa0t1BBP3KRETQhlXejUvMghpKFCvu
 5NpFZK8pXjY43xMu993JN6+VYd1lgZsEce2Nptzc5+CmmNL3Jf2psty5Wy881+czIYAYyd2p81g
 sKYhRoSngGS2t7HdB2FxEQbH2liftUMUkk5qJnSk5sw==
X-Gm-Gg: ATEYQzwP7psFJpDbehTRdYuJsuIyZNzeUktJq7G/wJfjddo7Rczt8B/0xGvdaWTKpM1
 AedasZMCRsdDR8gvlrL5Raq8fk65xrfs/je4cNpadQCFEbufIIIugthb6vUuHZO7G+1JSvvi7hw
 MZxCpH9A2JCxGGM2YZOKeW0SxNs7k8ybKJZ6dLMhSiddDpgqHv5hQCR2rA366Ahz53s4oMKDwTE
 klrhLQkiO/NKhOgCJ+cSxp7advrVfxVLW0lttkLd4BTQDRrlFusrBo0vBE+RVwqUbV2do74feNO
 cV4V/y61e1pMEgFHHEFP5IC/1bWxNbO9wViSP4Vu+lAEpxcyoT0gQpNVq1W9SK6aPTaCCXEXURU
 nBsFwPdD2qjkCEVHrWpMNMqHWs4LY26LzzBTV+XCECnN1iJGJAxd/2B7S2kCWf4BXyyqvUtxAa6
 uBjirP3//0ioyPYXX19FOZhSDbjMuLLKRl3St6Fx0sk+L+MWFXxrva1P2Wx2i95Ij64Cxtm61/g
 HQ4gvARf9RxsovyMSHq9dsjoan9AiiKPD9M7ARX+Hum69ji8wOzkQb/EThufYxQKZopWZYobZAA
 wetBq1GUXQ6h1MHeMoDkz/CfMly3S7CJuwWQhhSaDhgK
X-Received: by 2002:a05:690c:6706:b0:796:3e50:77b with SMTP id
 00721157ae682-79a90ac1280mr128552107b3.6.1774279820074; Mon, 23 Mar 2026
 08:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <99ed0e792590ecfc1a3f056f234e053013ffd981.1773904505.git.michal.simek@amd.com>
In-Reply-To: <99ed0e792590ecfc1a3f056f234e053013ffd981.1773904505.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 23 Mar 2026 17:29:44 +0200
X-Gm-Features: AaiRm50b3fA1TvI9s8YahwYwYaLyqHKEApwwSo4KkAm7k3smJwX69cXS_heW_DM
Message-ID: <CAC_iWjKQXd+wgChZU3wuUgfEHkhvOezgXVD8-G-uMjHF-mwk7g@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: efi_var_sf: Do not fail on blank SPI Flash
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, John Toomey <john.toomey@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 19 Mar 2026 at 09:15, Michal Simek <michal.simek@amd.com> wrote:
>
> When SPI Flash is blank (first boot or erased), efi_var_from_storage()
> returns EFI_DEVICE_ERROR because efi_var_restore() fails on invalid
> magic/CRC. This prevents the EFI subsystem from initializing.
>
> Check the magic value before attempting to restore variables. If
> the magic does not match EFI_VAR_FILE_MAGIC, treat it as an empty
> store and return EFI_SUCCESS, matching the behavior of the file-based
> efi_var_file.c which deliberately returns EFI_SUCCESS on missing or
> corrupted variable files to avoid blocking the boot process.
>
> Similarly, if the magic matches but efi_var_restore() fails (e.g.
> corrupted CRC), log the error but still return EFI_SUCCESS.
>
> Suggested-by: John Toomey <john.toomey@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Changes in v2:
> - Remove magic checking which is the part of efi_var_restore() already
>
>  lib/efi_loader/efi_var_sf.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_sf.c b/lib/efi_loader/efi_var_sf.c
> index 6eae8d464645..b84ec8e67dce 100644
> --- a/lib/efi_loader/efi_var_sf.c
> +++ b/lib/efi_loader/efi_var_sf.c
> @@ -98,11 +98,8 @@ efi_status_t efi_var_from_storage(void)
>                 goto error;
>         }
>
> -       if (efi_var_restore(buf, false) != EFI_SUCCESS) {
> +       if (efi_var_restore(buf, false) != EFI_SUCCESS)
>                 log_err("No valid EFI variables in SPI Flash\n");
> -               ret = EFI_DEVICE_ERROR;
> -               goto error;
> -       }
>
>         ret = EFI_SUCCESS;
>  error:
> --
> 2.43.0
>
> base-commit: 85854708c4d707d9db8ec84c11e1686a32198d91
> branch: debian-sent3
