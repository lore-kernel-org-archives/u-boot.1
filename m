Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D078CCD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:39:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D0B846C1;
	Fri, 15 May 2026 15:39:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ISoxQift";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ED3A846CB; Fri, 15 May 2026 15:39:10 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B04846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c798fc1a28cso4355928a12.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778852347; cv=none;
 d=google.com; s=arc-20240605;
 b=d2G5TI/CIMVStx3iDa/ANFQsuskDZwCTGHNgwlHwlpBhSwiYeqGxCNc8zIPBUEmJuT
 wLl8j5GNud2iDY9qIJ3Yj0LiIZ2yc5U/Q9bTLh1R1WnOQC6J96YvZEZwVGZIsahoBNGh
 XXuMFmNXzrn8oM7ymI4niu7XT71poViDlbtDBHyalnqbE7eemnnxCnbYqaiikO03p+6q
 auliJGT2+mc4ZMFWWbZ0EVx4ezGqzr3zjbRCNLAr2n6NKqRfHdMtijXy4/7q6FsGWoqX
 pmrWQ0cN7eosJfyh5h/tY4PfenpSzsEAAaHdSq9yKjP6I874OJxXqzMgffpNN2Dgi3iJ
 5usw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xy9lnQdWv+XREvwlxpA37M8H2H78e0Wa/Lsl2pPsVXw=;
 fh=xHK6CupDzzdbpP/i/a1o87iRrHeT9Qd/cPmyT6fsEU8=;
 b=iW93MEqZQUmAl1oUe5K8AS4uRZxbGO09vUi2xBxoH/rjEvUr/wlmRqMsGVEUh93vaI
 OsTBI+q3AUdAIGHUplkC5we3nU95RqquFL9oMBPzuKieVD5QkU5F5pOD03qcLGlysLfJ
 TaTv3mkgluXrxTaWCjcfmk4U5N+VRu8535sZcrkOrgoA+lZXQdLT89hKkuofu2ybwTEC
 D0r5c4Rbxmlnf/Eqtz0VU1ab/jVVrSKpCFYmNkzL8F2xMxy9RRMFNMRYTMWYddQJdJ2b
 Xpyj7wNdI5J6i7SsaDJDxkPi6BKwngRc9Lcsv83lmJIQOdepzKOjRW9h+tChQYPg2r3M
 O2Tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778852347; x=1779457147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xy9lnQdWv+XREvwlxpA37M8H2H78e0Wa/Lsl2pPsVXw=;
 b=ISoxQifty6dfIss8lFfXlny1EMAcgcp15zJPscwGHGgWfpLuUKjhuJJQyknJN5Gerv
 mUEYKS+uV9Xvaw5+FgiwsBnAGMMKGw9qfBJ+xdrtigDV5kARMUu1P5yq4khUe9W2BQne
 qmv7vVDW5Y6SJt/QDIQDfw/ktj0lU4hZ0pmR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852347; x=1779457147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy9lnQdWv+XREvwlxpA37M8H2H78e0Wa/Lsl2pPsVXw=;
 b=oRu4My0OcFgHUjq43Hr9jtoqpn3XyKXuBfiWESPjoTLf/DJERCDMNhJVAvymI39OBd
 cvtoqwO51A2JisSFhKEyXLi4DehtAGyFaVfanqYP2o7v8Obh0o2qPadR55Xbnl+nkuFB
 dfPf/ld9H8Uoe5x963q7VyMAm6Ki5CtAeLw+LmJPAUvXR/EQr4BdG9btsY6WXhIuYKaM
 TaGh8GBPGj9eoUAf/ccXLBPZ/VjV/9IDyXPzFjMFmOQRIG/ja7IlTwIcNVD7TSHMtWos
 WY1oqlM+e7izyexv4YpV8AH1lCYg+xQADBrNNXL/OxGiBbV/nF/T4pHO1jAmCSFgW9+s
 p5MQ==
X-Gm-Message-State: AOJu0YxOQ027AVaRva1S/qhJzr272eK2apKwD8BRUPMQDtqt/kToDDB+
 kI6FD0Gcn300HogXP8vRuY+flkU85qzqhDSGv7ZHLYX4pktRRcs+rviF6ZyoBYkholS8kV7Wlzf
 WXa46JgSk7FZYE6N8tFPmLdKFB2R3Jrqi8XfaV83w
X-Gm-Gg: Acq92OGdaSlfTOrk70Tt65VWsYhQitiBEvJ8k7l/43hrS94WdhAW9c87VxRXKNNM4rl
 4QpD44Wgx8QwVh7Acr6vIhj7c8lyP3VhX474WZyoLEIFqPEvS+DWyHM9Uf1fkntFCLguq1jmbFw
 Uwy0xX1M8MZmh7yEE4Fnza+qIoPtNCtYtSz2rR3paK8yfNRsz9s5CJn0hkn3LJnJNA3NzuWga2Y
 Ytg/95CcyoGGUMCgirDoSH1O+1MHNLOn0odaXPE1cSpg2U3KRYdqSawXfwDcGDnFdCrFq1KP8n4
 fiooxA==
X-Received: by 2002:a05:6a21:9982:b0:3a2:d838:bfd1 with SMTP id
 adf61e73a8af0-3b22ecac1admr4700401637.30.1778852346859; Fri, 15 May 2026
 06:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
 <20260513141027.351280-3-ludwig.nussel@siemens.com>
In-Reply-To: <20260513141027.351280-3-ludwig.nussel@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:38:52 -0600
X-Gm-Features: AVHnY4KouRul52WD-0om_ipMA3t1Lhdz-14pQKWWioJAUP7HdQZ_fUdvyZMSMmQ
Message-ID: <CAFLszTgTtAyBGHdsw4k7dE7sDJzNN+Wpijda4+Ufim56bMjBAQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] test: vboot: add iminfo checks for config
 signature verification
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Copilot <223556219+Copilot@users.noreply.github.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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
> test: vboot: add iminfo checks for config signature verification
>
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> test/py/tests/test_vboot.py | 47 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Various improvements below.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -231,6 +231,34 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +    def run_iminfo(sha_algo, test_type, expect_string, succeeds, fit=None):
> +        """Run an 'iminfo' command in U-Boot.
> +
> +        This always starts a fresh U-Boot instance since the device tree may
> +        contain a new public key.

The commit message is just a subject - please add a body summarising
which cases are covered (unsigned config under
FIT_REQUIRE_CONFIG_SIGS, signed config, corrupted-signature) and why
-E is skipped.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -231,6 +231,34 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +        assert expect_string in ''.join(output)
> +        if succeeds:
> +            assert 'FAIL' not in ''.join(output)
> +        else:
> +            assert 'FAIL' in ''.join(output)

This is a near-duplicate of run_bootm() - same arg list, same restart,
same expect_string assertion. The only real difference is the command
list and the 'FAIL' vs 'sandbox: continuing' tail check. Please factor
out a helper that takes the command list and success sentinel, and
make run_bootm()/run_iminfo() thin wrappers. The current shape will
tempt the next person to copy-paste again.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -326,9 +354,11 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
>          if require_config_sigs:
>              # DTB has no /signature node; FIT_REQUIRE_CONFIG_SIGS makes this
> -            # fail-closed, so U-Boot must reject the unsigned config FIT.
> +            # fail-closed, so both bootm and iminfo must reject the unsigned FIT.
>              run_bootm(sha_algo, 'unsigned config',
>                        'No signature node found', False)
> +            run_iminfo(sha_algo, 'unsigned config', 'No signature node found',
> +                       False)
>          else:
>              # No required keys in the DTB, so an unsigned config FIT is fine.
>              run_bootm(sha_algo, 'unsigned config',

The else branch is left without an iminfo check. Since patch 5 changed
iminfo to call fit_all_configurations_verify() in both modes, please
run iminfo here too and assert it succeeds - that's the path where the
new -ENOENT relaxation in image_info() actually matters, and it's
currently uncovered.

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -438,6 +474,15 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
> +        # Test that iminfo also detects the corrupted signature.
> +        # Skip for external-data FIT (-E): fdtput rewrites only the FDT
> +        # portion of the file, truncating the appended image data, so
> +        # fit_all_image_verify() would fail on a missing-data hash error
> +        # before fit_all_configurations_verify() is ever reached.
> +        if '-E' not in (sign_options or ''):
> +            run_iminfo(sha_algo, 'corrupted config',
> +                       'Checking configuration signatures', False)

The expect_string is just the banner that
fit_all_configurations_verify() always prints - it tells us the path
ran but says nothing about the failure. Combined with 'FAIL' (also
produced by fit_all_image_verify() on a bad image hash), the assertion
is loose. Please key on something more specific such as the per-config
FAIL line preceded by the config name, or 'Bad Data Hash' / the
signature-verify error string, so a regression in
fit_all_image_verify() ordering can't silently satisfy this test.

Regards,
Simon
