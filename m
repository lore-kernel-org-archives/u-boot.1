Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56850C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B8082D40;
	Mon, 26 May 2025 11:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iHUcMFnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB5682D4A; Mon, 26 May 2025 11:40:47 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C0B882CF8
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad216a5a59cso261826866b.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748252444; x=1748857244; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3KnqDqX/Qz90PdClbM8mu9yLJR9a9fHQqk4cOJ/Ub8=;
 b=iHUcMFnx1P/xZM6mrVu45iK619alfTKtiNvRvAwCK8THep7Kaw2BFaOOsKsl6hX0E+
 Qh04bGBiTRDrNj1CtLiRUd2SihhWb8s0mcO/B2GAyIa3mQFcas4HcAY7kX7+VnMoxhgb
 OQNqctA7bXGpNoNFuXbyk4DSkkoaxYxquSpJqS5cIjnn8VXIY3dkaHgk/WdRhx3aY8g/
 Q3MIgeKk+aqtlBBX8dgAeFSajmRdnJbxfiTg+F6Dirpo0Hf/0vkwK6nmgtvDb8hVJqfr
 qg95YWsfwxbHoQvOnicDuR9Xx3i9PXglADCYPc5sN37t9fTUFp2n/F7NzXBY9QY26FmQ
 l5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748252444; x=1748857244;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g3KnqDqX/Qz90PdClbM8mu9yLJR9a9fHQqk4cOJ/Ub8=;
 b=ovghPJRGlqvqfUutb4tH4c1RNjJTvN20XjOFhjfqioiHc5NuGTBZQZoaD89mJhxCvT
 W5jH2kcDz1T7FXZ8xohqNe9dhnWg5Adv5pPSN0qOV3zEN8qOdAWHBvbj3lkWR3mXy6r0
 PJD1ZOwkc2aJyb9SJhrfTMcIpkWv3V+g1C9dgrAY+uF0rpMkBMQ3AuUN7Dk7awtNi4UN
 o9cvzygm2/YYg+qfImNP81zKAOkGB6Sk6syRrBMkS8Kx2a4iN0X2cW2q8KA6DuQw/WrR
 ClANrYbVEb8H+Wr+DnGkHSzRNeHML/EYdPcMOp/Wjpzr9hCuPlZzIlZfIkcUoVFICxF+
 ZMEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqbG9oQlPLZl8lTErq+L+ktacBqeuM01QqPQBYB2Y5j7tcPZv6V+PXIKAwsiF7zWdWvqtADwg=@lists.denx.de
X-Gm-Message-State: AOJu0YyRkOR/8jm2sSFl1qQzsrRVX5xcGm+W3y039hEcETbRmwudcqFR
 6p62yfR6UqAU5shdhaD4YFQPXS8eH+uw6VJ9C3BL4wrIhCkcq2LPcjLf6K6UfzZS2AQ=
X-Gm-Gg: ASbGncuk7p8ESMB8m5TQAmOff+nEiBb1nYglzW2Q2E77TmZUuhnto/r4PE7biF1ZmW0
 Uj1b1PKWlkj2rCj0NWqMx5jgbr2yLIaFof16dd7wYQWoA3fFsXgqXhr6LjyZm4Z+AG/QeHRWHOK
 SCHFdJZB/X+rfX3qbmcNr0ckBJ+b3tGqijfFE5LPuY4HrWmaMpfPTk2zHy+DWk3aQHnexjuVV3v
 xUWzUg+YJwT0rT2WXs2L0pf+VSNgwzxrVOL+0i1bQUqqTN7OS+dkSN8ljlsRPehKjtjl2+QQwvE
 5aPqJyut564hOgU7obo3sMFAJZWSqZ3vrvPY25xDnOjvDDw8vWm2HTtG7Yj8odZPOjOhYkXLxcD
 oVHb2jLzCrv8XAw==
X-Google-Smtp-Source: AGHT+IGnaFQntNFs8/NZIii6zuY88PTLiUo5SAjfrpRIFofFbKuYUzjP3S7fB1wi4wO8DV3eIFuanA==
X-Received: by 2002:a17:907:1c1e:b0:aca:d6f0:af0c with SMTP id
 a640c23a62f3a-ad85b213551mr718360966b.59.1748252444314; 
 Mon, 26 May 2025 02:40:44 -0700 (PDT)
Received: from localhost (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4e8afdsm1665514366b.176.2025.05.26.02.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:40:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 12:40:42 +0300
Message-Id: <DA5ZROS80I01.25NCAU84JM742@linaro.org>
To: "Simon Glass" <sjg@chromium.org>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Mattijs Korpershoek"
 <mkorpershoek@baylibre.com>, "Tim Harvey" <tharvey@gateworks.com>
Subject: Re: [PATCH v3 2/4] tpm: Convert sandbox-focussed tests to C
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.0
References: <20250524130642.902486-1-sjg@chromium.org>
 <20250524070636.v3.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
In-Reply-To: <20250524070636.v3.2.I8ff77e0c1288f6a4da564e9454eb223f72809839@changeid>
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

On Sat May 24, 2025 at 4:06 PM EEST, Simon Glass wrote:
> Some of the Python tests are a pain because they don't reset the TPM
> state before each test. Driver model tests do this, so convert the
> tests to C.
>
> This means that these tests won't run on real hardware, but we have
> tests which do TPM init, so there is still enough coverage.
>

What's needed to run DM tests on real hardware?

We have full coverage. The auto start command, which is not removed from th=
e
python tests, will run the selftest command so I think overall this is ok.

> Rename and update the Python tpm_init test to use 'tpm autostart',
> since this deals with starting up ready for the tests below.

may 'since this fully initializes the TPM and performs the self tests'?

Other than that it looks good to me.
I can rewrite the commit message on my PR to Tom if you don't want to send =
a v4.

With the changes above
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Use 'check' instead of 'test' when naming test helpers
> - Add missing tpm_self_test_full() call
>
> Changes in v2:
> - Keep test_tpm2_continue_self_test()
>
>  test/dm/tpm.c              | 77 +++++++++++++++++++++++++++++++++++++-
>  test/py/tests/test_tpm2.py | 38 +------------------
>  2 files changed, 76 insertions(+), 39 deletions(-)
>
> diff --git a/test/dm/tpm.c b/test/dm/tpm.c
> index 962a3fd1943..87c5c416daa 100644
> --- a/test/dm/tpm.c
> +++ b/test/dm/tpm.c
> @@ -49,14 +49,87 @@ static int test_tpm_init(struct unit_test_state *uts,=
 enum tpm_version version)
>  	return 0;
>  }
>
> -static int dm_test_tpm(struct unit_test_state *uts)
> +static int dm_test_tpm_init(struct unit_test_state *uts)
>  {
>  	ut_assertok(test_tpm_init(uts, TPM_V1));
>  	ut_assertok(test_tpm_init(uts, TPM_V2));
>
>  	return 0;
>  }
> -DM_TEST(dm_test_tpm, UTF_SCAN_FDT);
> +DM_TEST(dm_test_tpm_init, UTF_SCAN_FDT);
> +
> +/* check TPM startup */
> +static int check_tpm_startup(struct unit_test_state *uts,
> +			     enum tpm_version version)
> +{
> +	struct udevice *dev;
> +
> +	/* check probe success */
> +	ut_assertok(get_tpm_version(version, &dev));
> +
> +	ut_assertok(tpm_init(dev));
> +	ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
> +
> +	return 0;
> +}
> +
> +/* test TPM startup */
> +static int dm_test_tpm_startup(struct unit_test_state *uts)
> +{
> +	ut_assertok(check_tpm_startup(uts, TPM_V1));
> +	ut_assertok(check_tpm_startup(uts, TPM_V2));
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_tpm_startup, UTF_SCAN_FDT);
> +
> +static int check_tpm_self_test_full(struct unit_test_state *uts,
> +				    enum tpm_version version)
> +{
> +	struct udevice *dev;
> +
> +	ut_assertok(check_tpm_startup(uts, version));
> +
> +	ut_assertok(get_tpm_version(version, &dev));
> +	ut_assertok(tpm_self_test_full(dev));
> +
> +	return 0;
> +}
> +
> +/* Test TPM self-test full */
> +static int dm_test_tpm_self_test_full(struct unit_test_state *uts)
> +{
> +	ut_assertok(check_tpm_self_test_full(uts, TPM_V1));
> +	ut_assertok(check_tpm_self_test_full(uts, TPM_V2));
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_tpm_self_test_full, UTF_SCAN_FDT);
> +
> +/* Test TPM self-test continue */
> +static int test_tpm_self_test_cont(struct unit_test_state *uts,
> +				   enum tpm_version version)
> +{
> +	struct udevice *dev;
> +
> +	/* check probe success */
> +	ut_assertok(get_tpm_version(version, &dev));
> +
> +	ut_assertok(tpm_init(dev));
> +	ut_assertok(tpm_startup(dev, TPM_ST_CLEAR));
> +	ut_assertok(tpm_continue_self_test(dev));
> +
> +	return 0;
> +}
> +
> +static int dm_test_tpm_self_test_cont(struct unit_test_state *uts)
> +{
> +	ut_assertok(test_tpm_self_test_cont(uts, TPM_V1));
> +	ut_assertok(test_tpm_self_test_cont(uts, TPM_V2));
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_tpm_self_test_cont, UTF_SCAN_FDT);
>
>  /* Test report_state */
>  static int dm_test_tpm_report_state(struct unit_test_state *uts)
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index 064651c3e23..e55adfe784c 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -56,7 +56,7 @@ def is_sandbox(ubman):
>      return sys_arch =3D=3D 'sandbox'
>
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_init(ubman):
> +def test_tpm2_autostart(ubman):
>      """Init the software stack to use TPMv2 commands."""
>      skip_test =3D ubman.config.env.get('env__tpm_device_test_skip', Fals=
e)
>      if skip_test:
> @@ -65,19 +65,6 @@ def test_tpm2_init(ubman):
>      output =3D ubman.run_command('echo $?')
>      assert output.endswith('0')
>
> -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_startup(ubman):
> -    """Execute a TPM2_Startup command.
> -
> -    Initiate the TPM internal state machine.
> -    """
> -    skip_test =3D ubman.config.env.get('env__tpm_device_test_skip', Fals=
e)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -    ubman.run_command('tpm2 startup TPM2_SU_CLEAR')
> -    output =3D ubman.run_command('echo $?')
> -    assert output.endswith('0')
> -
>  def tpm2_sandbox_init(ubman):
>      """Put sandbox back into a known state so we can run a test
>
> @@ -92,29 +79,6 @@ def tpm2_sandbox_init(ubman):
>      if skip_test:
>          pytest.skip('skip TPM device test')
>
> -@pytest.mark.buildconfigspec('cmd_tpm_v2')
> -def test_tpm2_sandbox_self_test_full(ubman):
> -    """Execute a TPM2_SelfTest (full) command.
> -
> -    Ask the TPM to perform all self tests to also enable full capabiliti=
es.
> -    """
> -    if is_sandbox(ubman):
> -        ubman.restart_uboot()
> -        ubman.run_command('tpm2 autostart')
> -        output =3D ubman.run_command('echo $?')
> -        assert output.endswith('0')
> -
> -        ubman.run_command('tpm2 startup TPM2_SU_CLEAR')
> -        output =3D ubman.run_command('echo $?')
> -        assert output.endswith('0')
> -
> -    skip_test =3D ubman.config.env.get('env__tpm_device_test_skip', Fals=
e)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -    ubman.run_command('tpm2 self_test full')
> -    output =3D ubman.run_command('echo $?')
> -    assert output.endswith('0')
> -
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
>  def test_tpm2_continue_self_test(ubman):
>      """Execute a TPM2_SelfTest (continued) command.

