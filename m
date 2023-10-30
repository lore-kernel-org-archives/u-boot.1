Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5370C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 11:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F98A87A8E;
	Mon, 30 Oct 2023 12:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UVdoz16Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A2687A8F; Mon, 30 Oct 2023 12:43:29 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1428E86F64
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 12:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507c78d258fso6294447e87.2
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666206; x=1699271006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Nzlhs7VZUZASQNZp+UPFFY3jA6BjwYPIF7lT5BbCbU=;
 b=UVdoz16QJO7DfUock6hAVeyRNeEJONxdcV+h34PEv/vXsmagWw61hUK3drc3WH48t1
 973NNExPdh0gT90aLEXwYbm4rpbvYo3uKdjkwI3k8mhRx+41MAhSNpUJOOx62JvrQiai
 5bg3LGH6jWqTxSb27cPLG1YD6NQQr7Ckn7x+3OocFg+f/WefQC39QRRqTi4Wq5Al57wU
 Vq4+FgdO1BjdOHmg0qlsL3TZcTQgIymn/0INFZOM4MtolX6bxzhwFjRcoV/BD8/juC3m
 K6um0t/Lbj5gOoVtcSjATKYl6TQkSErHbZLWtua8L7owsmLvL2cI3AEOomuG+QkJSvph
 duRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666206; x=1699271006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Nzlhs7VZUZASQNZp+UPFFY3jA6BjwYPIF7lT5BbCbU=;
 b=HC6eqnSZp/kopGO0ahPGYI4B+Wzqe9z81YawOmjpQGZ/CPVtLd1qDtVc+1NJoiNVRQ
 tAAKqEqNkZP/K1Xl2kOIK9FPcAqMxHy4AtEgbKa5/Mvo8FuThhKdMQ1iROWjyHHTZgyW
 Sewn6mXkNSjIOU1QRV5M47ElKIu6GTVNgYRJho5yS1EJYVBE0mPEEf2C3Lv52xKZrnFR
 64bxUV8DywV5VxD5rv4/RF8za3I7TQU7nZdV3+9PitHrdPM5oQ3VFdIV26vjj3wfnzyn
 1VnNj2axQSeL9xFtJmYK6h2cvByiVHr9wP+gW7/ZpZQOEa8PZqDNge/VCanulDpDtyGS
 E8gg==
X-Gm-Message-State: AOJu0YzU5cRgqPnWZiil11Q+H3+PucL3Y5PVaivTbENvvcB3y4wx2OJ2
 JbkVl9BSxMYDNccubUL6PH17xek8NWRkzAYXtAiltg==
X-Google-Smtp-Source: AGHT+IFy6WOj/EQDzr9vR8wwNFana1gQtHCHuXVpzCrProMaxIs6rYFhObrCR57ykvHvyAkRLvSlEvNMyOPknVfJUxg=
X-Received: by 2002:a05:6512:401d:b0:505:783f:bc65 with SMTP id
 br29-20020a056512401d00b00505783fbc65mr8508006lfb.66.1698666205893; Mon, 30
 Oct 2023 04:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231029042817.3938657-1-sjg@chromium.org>
 <20231029172813.3.I3c84965a4b5e3019562b86a47b34ae4b12469070@changeid>
In-Reply-To: <20231029172813.3.I3c84965a4b5e3019562b86a47b34ae4b12469070@changeid>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Oct 2023 13:42:49 +0200
Message-ID: <CAC_iWjLyFQuMX4-Jen_db39TNJH_HgbA155ne=5_LBX-=yxidA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tpm: Drop unwanted special cases for sandbox
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

On Sun, 29 Oct 2023 at 06:28, Simon Glass <sjg@chromium.org> wrote:
>
> These don't seem to be needed.

Please metnion something we can refer to in the future. e.g.
"A previous patch moves most of the sandbox tests to C code, those
arent needed anymore" etc

>
> Add a few notes about what to do next. Also mention parallel tests in
> at the top of thefile.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  test/py/tests/test_tpm2.py | 44 +++++++++-----------------------------
>  1 file changed, 10 insertions(+), 34 deletions(-)
>
> diff --git a/test/py/tests/test_tpm2.py b/test/py/tests/test_tpm2.py
> index 522ed41de633..e01a05143b63 100644
> --- a/test/py/tests/test_tpm2.py
> +++ b/test/py/tests/test_tpm2.py
> @@ -27,6 +27,16 @@ behavior.
>  * Setup env__tpm_device_test_skip to True if tests with TPM devices should be
>  skipped.
>
> +Parallel tests
> +--------------
> +
> +These tests can be run in parallel on sandbox. In that case any action taken
> +by one test may be independent of another. For sandbox, care should be taken to
> +ensure that tests are independent.
> +
> +Unfortunately, tests cannot be made independent on real hardware, since there is
> +no way to reset the TPM other than restarting the board. Perhaps that would be
> +the best approach?
>  """
>
>  updates = 0
> @@ -50,11 +60,6 @@ def force_init(u_boot_console, force=False):
>              u_boot_console.run_command('tpm2 clear TPM2_RH_PLATFORM')
>          u_boot_console.run_command('echo --- end of init ---')
>
> -def is_sandbox(cons):
> -    # Array slice removes leading/trailing quotes.
> -    sys_arch = cons.config.buildconfig.get('config_sys_arch', '"sandbox"')[1:-1]
> -    return sys_arch == 'sandbox'
> -
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
>  def test_tpm2_autostart(u_boot_console):
>      """Init the software stack to use TPMv2 commands."""
> @@ -65,20 +70,6 @@ def test_tpm2_autostart(u_boot_console):
>      output = u_boot_console.run_command('echo $?')
>      assert output.endswith('0')
>
> -def tpm2_sandbox_init(u_boot_console):
> -    """Put sandbox back into a known state so we can run a test
> -
> -    This allows all tests to run in parallel, since no test depends on another.
> -    """
> -    u_boot_console.restart_uboot()
> -    u_boot_console.run_command('tpm2 autostart')
> -    output = u_boot_console.run_command('echo $?')
> -    assert output.endswith('0')
> -
> -    skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
> -    if skip_test:
> -        pytest.skip('skip TPM device test')
> -
>  @pytest.mark.buildconfigspec('cmd_tpm_v2')
>  def test_tpm2_clear(u_boot_console):
>      """Execute a TPM2_Clear command.
> @@ -91,9 +82,6 @@ def test_tpm2_clear(u_boot_console):
>      not have a password set, otherwise this test will fail. ENDORSEMENT and
>      PLATFORM hierarchies are also available.
>      """
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
> -
>      skip_test = u_boot_console.config.env.get('env__tpm_device_test_skip', False)
>      if skip_test:
>          pytest.skip('skip TPM device test')
> @@ -114,8 +102,6 @@ def test_tpm2_change_auth(u_boot_console):
>      Use the LOCKOUT hierarchy for this. ENDORSEMENT and PLATFORM hierarchies are
>      also available.
>      """
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
>      force_init(u_boot_console)
>
>      u_boot_console.run_command('tpm2 change_auth TPM2_RH_LOCKOUT unicorn')
> @@ -140,9 +126,6 @@ def test_tpm2_get_capability(u_boot_console):
>      There is no expected default values because it would depend on the chip
>      used. We can still save them in order to check they have changed later.
>      """
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
> -
>      force_init(u_boot_console)
>      ram = u_boot_utils.find_ram_base(u_boot_console)
>
> @@ -164,8 +147,6 @@ def test_tpm2_dam_parameters(u_boot_console):
>      the authentication, otherwise the lockout will be engaged after the first
>      failed authentication attempt.
>      """
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
>      force_init(u_boot_console)
>      ram = u_boot_utils.find_ram_base(u_boot_console)
>
> @@ -188,9 +169,6 @@ def test_tpm2_pcr_read(u_boot_console):
>
>      Perform a PCR read of the 0th PCR. Must be zero.
>      """
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
> -
>      force_init(u_boot_console)
>      ram = u_boot_utils.find_ram_base(u_boot_console)
>
> @@ -217,8 +195,6 @@ def test_tpm2_pcr_extend(u_boot_console):
>      No authentication mechanism is used here, not protecting against packet
>      replay, yet.
>      """
> -    if is_sandbox(u_boot_console):
> -        tpm2_sandbox_init(u_boot_console)
>      force_init(u_boot_console)
>      ram = u_boot_utils.find_ram_base(u_boot_console)
>
> --
> 2.42.0.820.g83a721a137-goog
>

With this rebased on top of patch #2 & master
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
