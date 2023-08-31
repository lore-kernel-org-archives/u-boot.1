Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52CFC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 08:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A0086545;
	Thu, 31 Aug 2023 10:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EygbwH1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CBE86546; Thu, 31 Aug 2023 10:11:55 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6742A80374
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so1159157e87.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693469512; x=1694074312; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bfDWfia7P9lcXGP2dXPON4oFcbyIYkdWNURp7aAW1sk=;
 b=EygbwH1T9r4S/rKgfDacDDUxu8KMH+DYtY80YfJHnPCb9Iq5eIAIvmsA+IZBPcSW17
 iQtKxiExnnxHLJcUmGWo648Jt3gjtk6UYV68xFalsrVLZmw/rb0QUxQrBigcgFFK9XGf
 QjDWV70mceaxTCwteCEZIyxSXc1RiZg3L9WRp8gMzi+wqbg1b561jRKYemDMeb/xvE/V
 4OWm27G3exD6WhvTHWts4bFwtMYwOibLuQm69SAPISD+C/e2dzl260LQJrUOlqQ5x7na
 Mg50LulinezSi5ZZQC+gi5Vyf9G/v9zYj1NU/gwD1J+yeU7vAxQ2soYtyO3M95cmG4OM
 LwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693469512; x=1694074312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfDWfia7P9lcXGP2dXPON4oFcbyIYkdWNURp7aAW1sk=;
 b=c4HcMOZstbsAHCQSg1sj+KlxOglldvvpByHzooPp8yM8RmMgUzmMuqIYWSSeCP/Fm+
 ldgZ8Nhjdab0VNTniPW2/+c2G+1YEd+ooSClP0QPhmODgF/228Affxpx3ys9VesHtuE7
 agkLeRb/znHc+x56k/LYD/5Ktm211N+d9sO6EG/lb835SO2IfRj9KnzdwFzoMX9VBbaa
 ke/czW/I6WZbpF3gsJs+0H5LXu7fTB3G9GLPliUzyvAKzzGW0ua5CJH2lQlHVMyumMbo
 tjj0psFlKzfGN4z5693gzQbGyAOooNgBTJyKevgZjDN3VJ4NtvknSYvwTXvyNMuGUp3+
 V9JA==
X-Gm-Message-State: AOJu0YwBsxRIP/ItEjQnLha7CITkl3kK8Cto2Klwq8Pwa8w8Y5YmHzys
 lGDXqSeOHIce5+g0DNVXoIOCIzKOKfPKNsvo4upSAgJme0uHSaKvbQ4=
X-Google-Smtp-Source: AGHT+IHwb/8Dpggti7el+xnecIk9Uuk1pZ+nZDj+ym4Co/Uf2zkfAjxcgGRiY8GcPoJQGJX3qnR4rO3SGZg+tco2xCU=
X-Received: by 2002:a19:7b06:0:b0:4f8:5d0f:c779 with SMTP id
 w6-20020a197b06000000b004f85d0fc779mr3112823lfc.40.1693469511490; Thu, 31 Aug
 2023 01:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
In-Reply-To: <41f932e52bdd206b1b68d5ff313fc29b794a70e7.1693413381.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 31 Aug 2023 11:11:15 +0300
Message-ID: <CAC_iWjJ1Fmdpz1R3szgUkz7duwgJCFo=Ny2Wg0BjmeazOjoiqg@mail.gmail.com>
Subject: Re: [PATCH] test/py: tpm2: skip tpm2_startup when
 env__tpm_device_test_skip=True
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>
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

On Wed, 30 Aug 2023 at 19:36, Michal Simek <michal.simek@amd.com> wrote:
>
> All tpm2 tests should be possible to skip when
> env__tpm_device_test_skip=True but test_tpm2_startup is missing it.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  test/py/tests/test_tpm2.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index fce689cd992d..c2579fa02c58 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -71,6 +71,9 @@ def test_tpm2_startup(u_boot_console):
>
>      Initiate the TPM internal state machine.
>      """
> +    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> +    if skip_test:
> +        pytest.skip('skip TPM device test')
>      u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
>      output = u_boot_console.run_command('echo $?')
>      assert output.endswith('0')
> --
> 2.36.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
