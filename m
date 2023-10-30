Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D034AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 11:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4C386F65;
	Mon, 30 Oct 2023 12:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ll8Aci+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27D987A8D; Mon, 30 Oct 2023 12:41:50 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CE986F64
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so5998105e87.2
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666106; x=1699270906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2Dwuguc+waskS3iTW6qclpgHM0QgOtWfjweDDJj32pw=;
 b=Ll8Aci+tecdtGkODjErmTw4P1T4bcMGep0dYYPfymPjD1UqyZj4A26qOYD1v/UwfkB
 c1/IL5x40fYa47QQrU1RW96Tp+3UwfEDFN/uRZe/YKgnU5N30Qhk4c2/j65gkNogreAh
 aDDooxFjHTbA37+x+2Xut+/sh83hlN0ZF0/bAzlGBgl5mlL6lODbExdRFMKPnuuLNXxp
 l57wwD47b+hiPNHK/ZQu68YqmmlZTttXe/gDwphK8EjPHS0G5d7APvbtKTrEcw17soet
 lEYB+FtwZ/bUDeilyeiJKyYRSlo3HH2lqGehCfyBk9N9PeOTQ3LTINqQoWbRS3hS/pko
 IVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666106; x=1699270906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Dwuguc+waskS3iTW6qclpgHM0QgOtWfjweDDJj32pw=;
 b=qcQQCcRJ+ZP5HrTxBw2f75EpmGeh4o51f1L4NdPU+6ajKQYn/94aEOkyV3LYBEZoof
 jNV5nlG69TiyGTmlcskcw4q9aS9xbe/uBqJN9hh7qykJpp9KU/ZpwmqicYBAYF+sUrW+
 l/gi6u0KH5s+NRHqokhccoSwFx6cg0NYg/LPOsS9fdwN5Sm1vuj9YqQGXEjW/eptoqvg
 HBlI8NWMmew8Zn2d5yAZ/QZr6GRTYuujRkmLqM0en2vKDUB3CC25iubuRoX/I5DOXuaK
 C5Y8qEgrrqNSbOYumyc/YPAb5Ao7NJ9SnsShYjznZ/4rO5cXtKYejf9yRgnTqWpU65rR
 VQUg==
X-Gm-Message-State: AOJu0Yzf9F0QGXxcpj8PvIj/SwoHrtqW7Gzcn6MGsvJAMUixIum4zRzL
 KT6US/RvaXSMdB9Eh7Qn5BOO5sGGxAQkMVBOZ9pp7A==
X-Google-Smtp-Source: AGHT+IF6CTW3WU42j/5FY0lBZCfoc2AGRgf+QCyjnrDMfyfa0coGlYHp6VPhv0hK5VwvhbdkqCHqEb+IfYQJ3RuMANs=
X-Received: by 2002:ac2:5304:0:b0:507:a650:991d with SMTP id
 c4-20020ac25304000000b00507a650991dmr6696205lfh.58.1698666105693; Mon, 30 Oct
 2023 04:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231029042817.3938657-1-sjg@chromium.org>
 <20231029172813.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
In-Reply-To: <20231029172813.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Oct 2023 13:41:09 +0200
Message-ID: <CAC_iWjJ8N+61EYpUVnr_ONKLx2SBiV0nkJ9Ny7_aOeT+aPWRFg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tpm: Convert sandbox-focussed tests to C
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>
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

Hi Simon,

Thanks for fixing this.

On Sun, 29 Oct 2023 at 06:28, Simon Glass <sjg@chromium.org> wrote:
>
> Some of the Python tests are a pain because they don't reset the TPM
> state before each test. Driver model tests do this, so convert the
> tests to C.
>
> This means that these tests won't run on real hardware, but we have
> tests which do TPM init, so there is still enough coverage.
>
> Rename and update the Python tpm_init test to use 'tpm autostart',
> since this deals with starting up ready for the tests below.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  test/dm/tpm.c              | 77 +++++++++++++++++++++++++++++++++++++-
>  test/py/tests/test_tpm2.py | 57 +---------------------------
>  2 files changed, 77 insertions(+), 57 deletions(-)
>
> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> index cde933ab2848..f8264af13789 100644
> --- a/test/dm/tpm.c
> +++ b/test/dm/tpm.c
> @@ -50,14 +50,87 @@ static int test_tpm_init(struct unit_test_state *uts, enum tpm_version version)
>         return 0;
>  }
>
> -static int dm_test_tpm(struct unit_test_state *uts)
> +static int dm_test_tpm_init(struct unit_test_state *uts)
>  {
>         ut_assertok(test_tpm_init(uts, TPM_V1));
>         ut_assertok(test_tpm_init(uts, TPM_V2));
>
>         return 0;
>  }
> -DM_TEST(dm_test_tpm, UT_TESTF_SCAN_FDT);
> +DM_TEST(dm_test_tpm_init, UT_TESTF_SCAN_FDT);
> +
> +/* Test TPM startup */
> +static int test_tpm_startup(struct unit_test_state *uts,
> +                           enum tpm_version version)
> +{
> +       struct udevice *dev;
> +
> +       /* check probe success */
> +       ut_assertok(get_tpm_version(version, &dev));
> +
> +       ut_assertok(tpm_init(dev));
> +       ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
> +
> +       return 0;
> +}
> +
> +static int dm_test_tpm_startup(struct unit_test_state *uts)
> +{
> +       ut_assertok(test_tpm_startup(uts, TPM_V1));
> +       ut_assertok(test_tpm_startup(uts, TPM_V2));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_tpm_startup, UT_TESTF_SCAN_FDT);
> +
> +/* Test TPM self-test full */
> +static int test_tpm_self_test_full(struct unit_test_state *uts,
> +                                  enum tpm_version version)
> +{
> +       struct udevice *dev;
> +
> +       /* check probe success */
> +       ut_assertok(get_tpm_version(version, &dev));
> +
> +       ut_assertok(tpm_init(dev));
> +       ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
> +
> +       return 0;
> +}
> +
> +static int dm_test_tpm_self_test_full(struct unit_test_state *uts)
> +{
> +       ut_assertok(test_tpm_self_test_full(uts, TPM_V1));
> +       ut_assertok(test_tpm_self_test_full(uts, TPM_V2));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_tpm_self_test_full, UT_TESTF_SCAN_FDT);
> +
> +/* Test TPM self-test continue */
> +static int test_tpm_self_test_cont(struct unit_test_state *uts,
> +                                  enum tpm_version version)
> +{
> +       struct udevice *dev;
> +
> +       /* check probe success */
> +       ut_assertok(get_tpm_version(version, &dev));
> +
> +       ut_assertok(tpm_init(dev));
> +       ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
> +       ut_assertok(tpm_continue_self_test(dev));
> +
> +       return 0;
> +}
> +
> +static int dm_test_tpm_self_test_cont(struct unit_test_state *uts)
> +{
> +       ut_assertok(test_tpm_self_test_cont(uts, TPM_V1));
> +       ut_assertok(test_tpm_self_test_cont(uts, TPM_V2));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_tpm_self_test_cont, UT_TESTF_SCAN_FDT);
>
>  /* Test report_state */
>  static int dm_test_tpm_report_state(struct unit_test_state *uts)
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index c2579fa02c58..522ed41de633 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -56,25 +56,12 @@ def is_sandbox(cons):
>      return sys_arch == 'sandbox'
>
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_init(u_boot_console):
> +def test_tpm2_autostart(u_boot_console):
>      """Init the software stack to use TPMv2 commands."""
>      skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
>      if skip_test:
>          pytest.skip('skip TPM device test')
> -    u_boot_console.run_command('tpm2 init')
> -    output = u_boot_console.run_command('echo $?')
> -    assert output.endswith('0')
> -
> -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_startup(u_boot_console):
> -    """Execute a TPM2_Startup command.
> -
> -    Initiate the TPM internal state machine.
> -    """
> -    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -    u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
> +    u_boot_console.run_command('tpm2 autostart')
>      output = u_boot_console.run_command('echo $?')
>      assert output.endswith('0')
>
> @@ -92,46 +79,6 @@ def tpm2_sandbox_init(u_boot_console):
>      if skip_test:
>          pytest.skip('skip TPM device test')
>
> -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_sandbox_self_test_full(u_boot_console):
> -    """Execute a TPM2_SelfTest (full) command.
> -
> -    Ask the TPM to perform all self tests to also enable full capabilities.
> -    """
> -    if is_sandbox(u_boot_console):
> -        u_boot_console.restart_uboot()
> -        u_boot_console.run_command('tpm2 init')
> -        output = u_boot_console.run_command('echo $?')
> -        assert output.endswith('0')
> -
> -        u_boot_console.run_command('tpm2 startup TPM2_SU_CLEAR')
> -        output = u_boot_console.run_command('echo $?')
> -        assert output.endswith('0')
> -
> -    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -    u_boot_console.run_command('tpm2 self_test full')
> -    output = u_boot_console.run_command('echo $?')
> -    assert output.endswith('0')
> -
> -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_continue_self_test(u_boot_console):
> -    """Execute a TPM2_SelfTest (continued) command.
> -
> -    Ask the TPM to finish its self tests (alternative to the full test) in order
> -    to enter a fully operational state.
> -    """
> -
> -    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
> -    u_boot_console.run_command('tpm2 self_test continue')
> -    output = u_boot_console.run_command('echo $?')
> -    assert output.endswith('0')
> -

Can we please preserve this one only?

>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
>  def test_tpm2_clear(u_boot_console):
>      """Execute a TPM2_Clear command.
> --
> 2.42.0.820.g83a721a137-goog
>

Thanks
/Ilias
