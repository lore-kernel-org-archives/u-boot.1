Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0F7CF3195
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 05:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C615388E77;
	Wed,  2 Oct 2024 07:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DkkZo2fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE90088E77; Wed,  2 Oct 2024 07:36:43 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9613388BD6
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 07:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e07d91f78aso4759947a91.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727847400; x=1728452200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Upmt7nXMUwEcEzrv7l8TStkol9DXnCZcgvvRSobyCbI=;
 b=DkkZo2fg9WDSBGz/zicCqAXUAGVHMlswHMB0/36puNuW4E5YnY2A1LFahp73S6k9W7
 Q/c+noTM/E6SSF6/LnhrUfNa/c9T/4vsm9AiyDG2CD11N/MLFqxqA1nr5fgaIC7QKIrE
 8ASMa9JJhZa/kiq9lUlCqhJnJhrbylFo/dsFS+/mZC2X7E0wH+87NO+23qAv1Ersoxz7
 ToEaoKDvP1zS5QZMylYJlVkVVF9FphipP/0RnNlTROLHOCoodbeHdQ6fbum8PX0e2pNb
 dPOiP5XwQkdVtAiRFIFOUpHFlvZ1INJq4EKeEltu8P3/pNJWG6HyYIdc5waMx5hKuFTp
 /U1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727847400; x=1728452200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Upmt7nXMUwEcEzrv7l8TStkol9DXnCZcgvvRSobyCbI=;
 b=OrVBI6OvM/KUFiGMojQ3gunFQDJPQZGWY+TYmfUWd3tCzUgx9/x2Iq4bgeNt8hCKPY
 XzDWzo2s6K/ODe8+7lqhjmEET029rKIekZ7It+YCaRLZs9XikN26olxvFyuQwhZZf/2a
 haYnQeVbsUZ/BXjvt+Ygcbi1OW4k05GZOTq+QqxSKV+Aig0+zRMDdtNuG1AyrQkKc5TE
 b+gQLdKUjMly6WiKb1tAShqGt1yVVomablND3wOUcJh6UuyBConpctGhpgQsufdAzzKG
 wU2KrJfe8LrvF6IAE/gV7MmdfATNDOgs12CjYQG0UAtFwXmc8/zF4RYCiSKzzIQHRztz
 AyCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUehprw7iTv9NfbWLPs5zGDOL2z76gU7ma/jxDFhhVAWA/ZdBe7ibG6E19GRPFHIp2+DmoeKs0=@lists.denx.de
X-Gm-Message-State: AOJu0YznP0PQhBKbsyHrUpde+yE95K8/q6m/+ZCgsTaHOiaJlfy2EZrX
 DgrVx0S7/bUYaT4M7ENjqdEQWol7GuynjcGZMYYlXMCzmItIDQxx6m8E3Zf1hzfjx/cswJL7qTS
 /YK24r6WBhT1XD//4z5kfUazZsr+77mb1kw41oaOALQSjE/+eei4=
X-Google-Smtp-Source: AGHT+IEKmTtvo+CxvOQlfPI2s1xO9VOJeORV5Au2UxDupWTT6Citr8s2JPBHehTizggdvd+IuNP1/CcfviVxAC+czLQ=
X-Received: by 2002:a17:90b:4a51:b0:2e0:9b50:ae28 with SMTP id
 98e67ed59e1d1-2e184901f12mr2637421a91.31.1727847399826; Tue, 01 Oct 2024
 22:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20241001225335.45680-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241001225335.45680-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Oct 2024 08:36:03 +0300
Message-ID: <CAC_iWjJ+BS6spMnfsJkxxcz8vHNSoAmv2oXK3-FaHs7vo2vm-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: don't call restart_uboot in EFI watchdog test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 2 Oct 2024 at 01:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Calling u_boot_console.restart_uboot() in
> test_efi_selftest_watchdog_reboot() may lead to incorrect results.
>
> While the watchdog triggered reboot is running thee test environment may

s/thee/the

> need some time before triggering a reboot itself. This may lead to
> duplicate output of the U-Boot greeter which is recorded as an error.
>
> Reported-by: Tom Rini <trini@konsulko.com>
> Fixes: df172e117d1d ("test/py: test reboot by EFI watchdog")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_efi_selftest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
> index 43f24245582..310d8ed294a 100644
> --- a/test/py/tests/test_efi_selftest.py
> +++ b/test/py/tests/test_efi_selftest.py
> @@ -58,7 +58,7 @@ def test_efi_selftest_watchdog_reboot(u_boot_console):
>      u_boot_console.run_command(cmd='bootefi selftest', wait_for_prompt=False)
>      if u_boot_console.p.expect(['resetting', 'U-Boot']):
>          raise Exception('Reset failed in \'watchdog reboot\' test')
> -    u_boot_console.restart_uboot()
> +    u_boot_console.run_command(cmd='', send_nl=False, wait_for_reboot=True)
>
>  @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
>  def test_efi_selftest_text_input(u_boot_console):
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
