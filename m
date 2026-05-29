Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA88CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DF1D846E2;
	Fri, 29 May 2026 09:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bb0llhst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60BF846E6; Fri, 29 May 2026 09:02:40 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFF883FF5
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bda62f13d90so1479014566b.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038158; cv=none;
 d=google.com; s=arc-20240605;
 b=T10c7htkDtQ54Cu4FAkzqNCx+3N9qQHmMT6UsTFMG3HrYHxMrqd4rOEQJc+s/StA/Y
 JXHShb643XBbQq8IiuI1UYhncXxr+zIEq3ubsqGuSzeydPFxh9Xxy13wzP8kXfHXRvQ7
 4bW5TgcFFx7B1C0qX/cWbWR6+s43lzIWl/c1rpQOGb/kDWwCtZzpQ/XUltKPRvVmM0q9
 awNNGmTy32SdNkMnKrMirTe2R0IdT9ZvsjiwUaLp1eCehfoyWSF/PIkac6TNp7I2jjaE
 7tXCU2wAQHJivfIj1A2hxMEYYhiqc/Dg/it67MUJwTlGo6pBM4K7N126TqVhTT1prFqq
 +3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g2lNC8HtQrJAVUUysbqLMIvo9E9iSWU6H0e3Q4+gNhU=;
 fh=XXcfzCiAuQMJyMuyiaSz7X2bqP/dLoxll3XeZkNPATA=;
 b=HSEu5oKqBDbC5oVAzZagds83jMqAwELCgm8YV9SlRpmtX+rGwXn805qyha4d8vbAhz
 dD3OhwMW14VcPMRHSI4dlHaIxmJ9Ke2ckZd5rfBenYYL4hyhQR0dmOs6/VJ6P/JGt0Bd
 //lEeLrFKcbl7mh/D3k//XkytwzxPHNCF176rv7cLneh4zH+UmGbSyZpPwoQjl2DZOBj
 0dvr0Ws4pjc5OLkQxc9qRKRpGs+Y85LF+PZE1HTAs0az1mE2iK1E5pjC7YCSbKkIj/2B
 PxrNP+xN51wxVPu8DEkZ/iga6xBPVQGQ7cFh5VZdFjxYs9rzXDMugdaih92o/zUXnYd/
 QjyQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780038158; x=1780642958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g2lNC8HtQrJAVUUysbqLMIvo9E9iSWU6H0e3Q4+gNhU=;
 b=Bb0llhst3GQq7g7nOZMspatb0J03ht7C5jNHZGp1RYrXrLMRTpXoVOR1nMMDTeANUH
 r3fVmslacDPNtGb/cMPcO+Z5cLx4rsHxsTS6wGM8LhnjG0X7o26I8LRSCmht+ynJFkyu
 BWECzMrPPdts/TgX6/cbUYdd6iSmnw7Uep7J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780038158; x=1780642958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2lNC8HtQrJAVUUysbqLMIvo9E9iSWU6H0e3Q4+gNhU=;
 b=ZBwykIgommHJvKxgFC5Mzxm9bmGfgLrEok85oplbjcHM6M2mx4DNvN8o64mVhsdS7h
 n8ct3Vu4lOYKsAiwBBa0VV06ysOjpZvPDYGMM9Q5LGw5+tSx6yhrTq3wSuQUEUCcMdDD
 tMyp6i8gbP/jFNNUM77hxC//NSaHSvpHiJkHrervoSsmmbZIl5U9V8+KYzlmjtifz7Fc
 +nj+Ynuuvx9OeDnOiPJ/pMD0E74wJPhiimD0lFV4yNVa0ECKO80dfkX3+69+7IXPDX1a
 ohUe37h67BzEiMqjw/iJkmBSThRdrm8ZRiMhhOoNHbPihJeXLEsbg1z8j6JZxP3uReUm
 zvCw==
X-Gm-Message-State: AOJu0YyWskVbuPtxl86htFsmhs+7TEWyoZ0NDh/qsRhT2WRB+1r+Kw6e
 CW4tqKvefqQ8xWf/ne8Qk5sih+edIwOyN44SKKMMInEehwnAFO6xs209YC/AzToMLlvewU5d97Z
 UeCmE6XVYyhoDnLN/+PyonauxUW3MmQl5yhrDdzo8
X-Gm-Gg: Acq92OE/tJZDQbh+dA45/RvNw8Tg1JZ+JUNWqwNadBBjfRrb4aK163UqFM1T9w9qqV9
 S7byAA+CBj8DSC/3Mhklbd3w4mdUAs+Kw9TlgjUO+uurNvEQpZgRW816QP39poTb3dPlm3KzyO1
 pD3DA0jSNGoRVL1t6IVlINkJYoKeocll/0yNkcAb2g/rGITPMXXeuCloXw++nrqiMQqLrnTnGJd
 B93lfJCOR1BiGLsO479HWSADiOHwneHEEZJNlLVbsj/pSOikw58wCr8HpwZqDwbc3345kcWOAq9
 JdDVyU9j8hW53P6qgUA=
X-Received: by 2002:a17:907:c312:b0:bde:2f9b:bea1 with SMTP id
 a640c23a62f3a-be9caf14d10mr72589066b.24.1780038158010; Fri, 29 May 2026
 00:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260528114900.1505642-1-ludwig.nussel@siemens.com>
 <20260528114900.1505642-3-ludwig.nussel@siemens.com>
In-Reply-To: <20260528114900.1505642-3-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 02:02:25 -0500
X-Gm-Features: AVHnY4IAniHBOyNcjkd91aI8AeHh9Tlmljf58mI_0X40j6cpiDhkDMhSnqnDRZY
Message-ID: <CAFLszTjviFtxumnftej95LVMpuY4Pj5P3aryPu0Mp8ZYp2GE1Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] test: vboot: refactor run_bootm
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
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

Hi Ludwig,

On 2026-05-28T11:47:57, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> test: vboot: refactor run_bootm
>
> - split off a generic part of run_bootm. The helper function is for
>   future use in similar commands
> - moves u-boot restart below section opening for better log structuring
> - only look for expected string in last command. This way a failed
>   assert() doesn't dump unrelated output.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> test/py/tests/test_vboot.py | 54 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 14 deletions(-)

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -151,6 +151,37 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +        if not fit:
> +            fit = '%stest.fit' % tmpdir
> +        # run commands that just prepare for the actually relevant one
> +        ubman.run_command('host load hostfs - 100 %s' % fit)
> +        if (len(commands) > 1):
> +            for cmd in commands[:-1]:
> +                ubman.run_command(cmd)

The 'if (len(commands) > 1):' guard is redundant - for a 1-element
list commands[:-1] is empty and the loop is a no-op. Please drop the
guard (and the parens, which aren't Python style). While you're here,
please use f-strings for the fit default and the 'host load' command
to match the new f-string in run_bootm()

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -151,6 +151,37 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +    def run_fit_commands(commands, expect_string, fit=None):
> +        """Load fit image and run commands in U-Boot.
> +
> +        Asserts that 'expect_string' is contained in the output of the last command
> +
> +        This always starts a fresh U-Boot instance since the device tree may
> +        contain a new public key.
> +
> +        Args:
> +            commands: list of commands to run
> +            expect_string: A string which is expected in the output
> +            fit: FIT filename to load and verify
> +        """

Missing a Returns: section - the function returns the joined output of
the last command and callers rely on that.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -166,20 +197,15 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +        with ubman.log.section(f'Verified boot {sha_algo} {test_type}: looking for '{expect_string}''):
> +
> +            output = run_fit_commands(['fdt addr 100', 'bootm 100'], expect_string, fit)
> +
> +            if boots:
> +                assert 'sandbox: continuing, as we cannot run' in output
> +            else:
> +                assert 'sandbox: continuing, as we cannot run' not in output

Please drop the blank line directly after 'with' so the block reads as
one unit. Same in run_fit_commands() and run_iminfo() in patch 7.

With those:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
