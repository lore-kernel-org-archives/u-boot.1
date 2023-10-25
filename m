Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A444C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 18:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FF987A3C;
	Wed, 25 Oct 2023 20:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A9On6pBq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25DB887A33; Wed, 25 Oct 2023 20:23:52 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50795874A3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 20:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so9054470a12.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698258226; x=1698863026; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bv6Rc7eCGxT1hLdKAZ26PCJYT+cfVnjIoEIbO8p7Ru8=;
 b=A9On6pBqplKJarWJFzPD3eQbfTtCSrPu60MyfOffE71Gt/SqCqTb4FkiejXXbdYrHV
 HKyZTPUjYx3Sx2ZsfEpfo5G5EZVsOj6SPIc2sakBQZkP6wOqTr71FtvYcO+UNSnNtj96
 WMtPbLZY8tzu8SztHRhW700GP/FEnNYdISb9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698258226; x=1698863026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bv6Rc7eCGxT1hLdKAZ26PCJYT+cfVnjIoEIbO8p7Ru8=;
 b=Xe8KCuE7msaI9HvpirwPaxEd/KG6ZYUBP4r1XJ8ZsJKlr8xPI3kIDy1bPUU+y1Nphz
 QP25JGguC0I0L9NIQAfaPVEyy/1Kseb/hw37T5lK7LWp+6AwB2w53uKCVbqWP+Kf/hRr
 0ycPva/r87xjgTpJzm+u9eXbp/OFxiaMWmghGgfme1i/mFsDAOCGMBCZXxpmEhds/izs
 IGa6H3nc5eb3aJ3Y8oMKoANPIe1BvkEk+OpSWdJN8VaYlrvx0uR7pDjCYD8+MmZBF+JE
 hRjOcwgd4+InHm+ptpjDbI+TRRUOfzJyRz6cUwJiP6O04Wa9R8tMs5N+asfkWKxRUr8Z
 nR7A==
X-Gm-Message-State: AOJu0YyHkXw7Oc7M746btUpyMhBRMVx6Ar1d6wc8QRrWygZap/b6ku9D
 9q58PjLEN3vyIOCG/9OxCuPy1h4W58tx7PBPykPenA==
X-Google-Smtp-Source: AGHT+IF/oEDoDt4rvrz7FejzTBCQZ2H/fw2oWLeQdW+l2BJSQURevCF5f/QPt5DjEG543MX61dtJAEufeb7csWbDnN8=
X-Received: by 2002:a05:6402:11cf:b0:540:346c:7b2f with SMTP id
 j15-20020a05640211cf00b00540346c7b2fmr8701361edw.40.1698258225630; Wed, 25
 Oct 2023 11:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231025072525.3960316-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20231025072525.3960316-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Oct 2023 18:23:33 +0000
Message-ID: <CAPnjgZ0swsWDbxCNMURdkRoby1tDLK5LT4aRGNBCNnOKCNyJ1Q@mail.gmail.com>
Subject: Re: [PATCH] test/py: always use autostart on tpm2 selftests
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>
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

Hi Ilias,

On Wed, 25 Oct 2023 at 07:25, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> commit 789ed2784256 ("test/py: replace 'tpm2 init, startup, selftest' sequences")
> changed some of the tpm2 init sequences to 'tpm2 autostart' instead of
> calling 'tpm init', 'tpm startup TPM2_SU_CLEAR', 'tpm2 self_test full'.
>
> The autostart command calls the afforementioned sequence and on top of
> that deals with the 'tpm2 init' return codes if the tpm is already
> started. Since we initialize the tpm from various subsystems now,
> replace the last remaining instances of 'tpm2 init' with 'tpm2
> autostart'.  Since the latter calls 'tpm2 init' anyway we will still be
> implicitly testing the validity of that command
>
> It's worth noting that since 'tpm2 autostart' performs the startup and
> self tests sequences of the tpm we could drop
> 'test_tpm2_sandbox_self_test_full' and 'test_tpm2_startup, but let's
> keep the since they test tpm commands and options
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  test/py/tests/test_tpm2.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index 47392b87a98f..1d654cd4a23b 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -61,7 +61,7 @@ def test_tpm2_init(u_boot_console):
>      skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
>      if skip_test:
>          pytest.skip('skip TPM device test')
> -    u_boot_console.run_command('tpm2 init')
> +    u_boot_console.run_command('tpm2 autostart')
>      output = u_boot_console.run_command('echo $?')
>      assert output.endswith('0')
>
> @@ -100,7 +100,7 @@ def test_tpm2_sandbox_self_test_full(u_boot_console):
>      """
>      if is_sandbox(u_boot_console):
>          u_boot_console.restart_uboot()

We should not need this. Can you please take a look at what reset is
needed in the TPM code to get the TPM back into its original state? We
have dm_test_pre_run() which could call a tpm_reset_for_test()
function, or similar.

> -        u_boot_console.run_command('tpm2 init')
> +        u_boot_console.run_command('tpm2 autostart')
>          output = u_boot_console.run_command('echo $?')
>          assert output.endswith('0')
>
> --
> 2.37.2
>

Regards,
Simon
