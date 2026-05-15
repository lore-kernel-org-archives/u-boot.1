Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C9ACD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C82D8467A;
	Fri, 15 May 2026 15:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHkHt4a1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05EDC846BD; Fri, 15 May 2026 15:36:52 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB4F84676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:36:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-365cae89bf5so4081659a91.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778852208; cv=none;
 d=google.com; s=arc-20240605;
 b=DMFO7pRdfnMVH4sUPRwwvTXygrNfpXOba3aP/zJTOaYRzSu2U2t66pJwB6MaT/Xv9m
 BRU0EM39Lw/iXe/xTZpqecqN742uiCPwK+SxV83yoG7B9wIFnyuN1wFlyj79N0FtDMaa
 kIZxW36E/qS1YpkMvOZPesIAB0IcM8R18GU/TXjYljbDEHZ7JmDSkPuHbqf6Crq9BNYv
 kpBz/iJZt7aUSPkWtfTfTGPNDIuqcohKQ5DvLaOloCEHdM7w3DDbeVkne0WH/9isLIvm
 ryRLG/GqkUBNXdfIebSxiwNEa8nor1j/3Y94zdGzkDUJ5sv8DTBOD7fnhOsixf8roHlp
 K2fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eLXq7Lq5kykAq6ahMnL4A2dcaiBV9/D8vIDVnc0Jlb0=;
 fh=VGw2T5L2m7Yh9U17+9EpcVjHk1AL8r4EmR5Gn6A4xk4=;
 b=ipHKRCAFs4on6YafZFKz8uYkc/peT+22NoJQ2/ryiYCRqeN9O8HHFuTiTJAZ1fmeyh
 PMC2A9NOn6cv9ijn5/l0pcsBWQMgH9qFhmlmwLFkx7+s4ETBuXaA/Hty7ryXe/D6PiY6
 HwlUg3GuhmxBNR8wB4hPy0f8/1bYYQCIQsMt8j/H3Ui4jIhuSgJTgxheJHFRnZ5Rj6sj
 t5zijivYCXYaXwaflOmePwuJLhj5jZXEfdT1adQ06FgQ+3yuLlbJ2FS9m71PSr2uI4CA
 +Vy/Ker6kXMllljFnJ7GtxhvWN6Gms5QVuncGPsyvr/RF882/5x3JK/zF607vhYvjiNH
 0YPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778852208; x=1779457008; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eLXq7Lq5kykAq6ahMnL4A2dcaiBV9/D8vIDVnc0Jlb0=;
 b=EHkHt4a1yzW2T6O+oS/YskOcOUgHIjhi1Iv6iLReH4igRxLLQCuYsIDVwxhzKHiCkl
 AmMzmUJGPvy9GNMLHRj9iaAK4mQbCrTI+omPSFH0RNSXSlXt8hnZDMYFiGoAPRtTnYGW
 KH1S9//90yl0WY4fOmu8l4RnUe6CBX5v6X1dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852208; x=1779457008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLXq7Lq5kykAq6ahMnL4A2dcaiBV9/D8vIDVnc0Jlb0=;
 b=Ncj6pkIfdLshoe5q1bxFcenNydt4KjZwwsAClfc7eDWd32NYCN92XNCaRbxn6QOVv2
 eQb3501kXfXpEqOnxzDxEQCkIDdnSLjovKbzqYHVbIDgtqEW6C951JUcZ/YzDVbPHl/l
 ON72QDdyNchLD8zNrlmA4ebmnnSc/X8udO0q1a11rqUjKWgEhnLUaflrgA2z4PyIULEc
 14NW4cZ168baCM5hHIkscSKRuFGPkgS43lI3HpUDHIlpUNnGKBOiGeB+8LHlPhX1FWX5
 bOJRcZokir1C0y6gDZ5By+Hq2B0cof9sNIr6yS1Xx1fJfSXN3q/zFPsEpIZye6YopQsA
 wirA==
X-Gm-Message-State: AOJu0YyvQY2NQJ5Z12/I93nrJETqAxNxswtj5nrlXx5/Orpa3nKbm0dm
 jMv8F01HHD2nfrWPRZMsawVecA3+UexDBgmKu07Id/FtRfMS1BosGlhVt798PzSz+ciQoLuP7Ou
 rsgYFj5RiRNn3uXofgcCCgLT5UgUCQuY1TaJbQXhp
X-Gm-Gg: Acq92OHPjM1BtYoPMgJZTCqiusJqgQa7J5bWgjhDh6qQkLV9zeYJABPDWWXk4rjG1GL
 ryRkJFBWV99F74uSPyqdDOGHhnhOmNx41Ng9Ng/OJzLkULMSSmUc68kCegvmBXZhLeG9050gZZN
 IUubAJyd9qff54q2SqCfosSQR591oVbyC0MFrYlrE99N4FbpZf47CFkPeCcK8OOaJrYDxt2L2P/
 +/LytNKzf6eIqhTF7j/rKcM/iLpOhnfZQ8oTHUNDIvw6slaANyuJDokAUD0LxLxfybJWMs0THir
 SH74zQ==
X-Received: by 2002:a17:90b:1c82:b0:368:a1c2:57fc with SMTP id
 98e67ed59e1d1-36951a1d593mr4253360a91.12.1778852207889; Fri, 15 May 2026
 06:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
 <20260513141027.351280-2-ludwig.nussel@siemens.com>
In-Reply-To: <20260513141027.351280-2-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:36:33 -0600
X-Gm-Features: AVHnY4LY6lOLllz-CLt4gPqc9cDIMRC29uhiw3q0wIi82UGd-zylflYWEDk6mUo
Message-ID: <CAFLszTg5BuodFz-CGpgABoqiA+OEWq3rfBCyw9y-Nms7=xUHGw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS
 in test_vboot
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Copilot <223556219+Copilot@users.noreply.github.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, Simon Glass <sjg@chromium.org>,
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

On 2026-05-13T14:08:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> test: vboot: handle CONFIG_FIT_REQUIRE_CONFIG_SIGS in test_vboot
>
> Make sure test_vboot works with CONFIG_FIT_REQUIRE_CONFIG_SIGS set
> and unset.
> Enable CONFIG_FIT_REQUIRE_CONFIG_SIGS in sandbox_defconfig and leave
> it off in other sandbox configs
>
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> configs/sandbox_defconfig   |  1 +
>  test/py/tests/test_vboot.py | 60 ++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 49 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> @@ -21,6 +21,7 @@ CONFIG_EFI_CAPSULE_CRT_FILE='board/sandbox/capsule_pub_key_good.crt'
>  CONFIG_BUTTON_CMD=y
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
> +CONFIG_FIT_REQUIRE_CONFIG_SIGS=y
>  CONFIG_FIT_CIPHER=y
>  CONFIG_FIT_VERBOSE=y

Turning this on in the main sandbox_defconfig means the 'Test FIT with
signed images' section (behind 'if not require_config_sigs:') is no
longer exercised in CI, and test_global_sign() is skipped entirely. We
lose coverage of image-level signatures and the pre-load global
signature path on the primary sandbox build, both still supported
features.

Please leave sandbox_defconfig alone and turn this on in a secondary
config (eg sandbox_noinst or sandbox_spl) so both paths keep getting
tested. Or restructure the test so the image-level path still runs
when require_config_sigs is set. Worse cas I suppose we could provide
a runtime mechanism which the tests can control. What do you think?

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -306,26 +306,54 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +        bcfg = ubman.config.buildconfig
> +        require_config_sigs = bcfg.get('config_fit_require_config_sigs', False)

The same idiom is repeated in test_global_sign() below. Please put
this into the outer test_vboot() scope (or a small helper) so the
build config is read once.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -485,6 +513,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +        # test_fdt_add_pubkey reuses this tmpdir and needs sandbox-kernel.dtb,
> +        # so compile it unconditionally before any early exit.
> +        dtc('sandbox-kernel.dts', ubman, dtc_args, datadir, tmpdir, None)
> +
> +        bcfg = ubman.config.buildconfig
> +        if bcfg.get('config_fit_require_config_sigs', False):
> +            pytest.skip('simple-images.its has no config-level signatures; '
> +                        'incompatible with CONFIG_FIT_REQUIRE_CONFIG_SIGS')

Worth mentioning in the commit message that test_global_sign() gets
skipped, otherwise it's easy to miss that we silently stop testing the
pre-load global signature path. Also, the comment suggests the right
fix may be to provide an .its with config signatures rather than skip
- is there a reason that won't work?

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -306,26 +306,54 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> -        ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
> +        ubman.log.action('%s: Test FIT with unsigned configuration' % sha_algo)

Good catch!

Regards,
Simon
