Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46CBCD98D2
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5C88484C;
	Fri, 12 Jun 2026 20:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V5SR2/6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D7584895; Fri, 12 Jun 2026 20:19:11 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FCE28484A
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-beeba001887so177409966b.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288348; cv=none;
 d=google.com; s=arc-20240605;
 b=Rp6wBU6AZrZ4VKxw+m6fNGhzl0CSO1kGY+JyCaIWz8Y3b0HAyntnHRsOtBX/c3BiuG
 ILrwfVWasmV893+5+Q/rHo7s/0J2yBgAOnWdsM0gRJSbB1QNqcT9wY5CCblSrS4v91yC
 Mhni+htVCrDYTMYqDnktPPBP9WHXZNgxekbj6R5ROwsWPBnczcbhYNOrAXUb0mAuP66q
 sTjvAKOjWeugk4rXk9UuIiYgRJ2IJbCB2gTh1HIbCPlEeO6CVxvLKrTli19kZE1cKSGK
 x8aOXUl/GOg6SDk45ffkp/X2gpmR9Q6C39GGOzjCu9wQ8iMMexoNVHWn2tdpk7kYNdQo
 BLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=teGnjVBrGdmQX9c1SIN+v2CwgZJTWdh0yT3qA8MTOEU=;
 fh=qtZRkKziB4+j3oJg+nqi3i3iCcgGxOjMSobmXz0DBC0=;
 b=XJouvw6SXS9UXjbsU7Ca9JP+VKICU97VKdySQP9uupgGq0LowrlMms9GxJLZhpz0Kp
 dxf3Epu0KXbq/mKuW1mijYvPSsY+O2PbZH81w3+V7WOYYXvstxm17n2Aow74ppKOgP1a
 Blq4lpfTynTeRY2Y3kpnXmuBEH5/k1J6Z14DU02UwCcfiO9DCwZWStmLRCAm7hurQ/Cc
 uimVmewhJeX6EqZZsTlAlT04DKRHhtry2re+5SAA7UjG4RhFLKatGkB/dSifS3yxQAlX
 2NPycu1nWw5p7dm6S3y4qt8inwSL5GW7kRJ/DNWb7r5jn40ViKIbQ8RnOSD/9IjL4xAI
 H1dg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288348; x=1781893148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=teGnjVBrGdmQX9c1SIN+v2CwgZJTWdh0yT3qA8MTOEU=;
 b=V5SR2/6e6vYX9Fl4HkH6AeGwGOBfTlHc6+th1kpqgbEKyfjUAwoDjQp5U9kDGxAb35
 3zL19FhdezQFDsIplYNdPM0w6Z34wrV/klerNPcwNIzmrEagdSjytEj6iyqhQitUTstZ
 /CkfSOsMg5abxYPvt6Vwh2/ovLOrVI0kR/uts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288348; x=1781893148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teGnjVBrGdmQX9c1SIN+v2CwgZJTWdh0yT3qA8MTOEU=;
 b=kJKq1shj/pAwbp65vO78/aeEuIxUWuMfWTGxMJGnAY1QXkqIlyzLm16zwYeRnFCdu4
 leSdgIJLA3s0/mdkTm2Ma2x2Czxef/baRbfbBjJObnBxOR805noEp0hkAGMI+1OXBOLk
 SL8NHQvxKieJ/em9sl3jZDEK7H/hwGaIZbeDIkNRjlQLDgLsUiC41NPTAlqoAhkchsCg
 ysmxwvBwknXue4EZIWjTDqhaXF93mh5c1gbC0nFgndoyl/iAyCXJT9Qtam8vA4ikJeeo
 7bLu16hUolsrt0IqEJbEZ77N66IivSThilBsK3ru6Jkt29ErUA6E1ekEqC6DywAjTAW1
 MnAQ==
X-Gm-Message-State: AOJu0Yy0lvCpjWY8ejYez51nHw//rdA+gpfzBRA44HxNaAh25u3D2zvO
 txh6izkPHo3VoVY665CFysxXr/Nx2TVT0FFagXUDtkrllIzBH6Qa4cYmlY7eT3V7pdh5tOzq1II
 d4dRwQUtg0C+T2Xy8dVNNAO5Et7qZNAu4AyojNC460Xa/vPdlwz4=
X-Gm-Gg: Acq92OFABxLsuIp65hJrLWEaurzJ2nwJueQXvlkoWlxAZz1ZOCMx0dXjIkilrTSInDK
 a22bsUAd0AWeihe0I8HMj3U1778th0DQwctIOYx7uPu5p+PoYUymmchQvRTLtvPrjhqN0tvPiRW
 tWLn589R5Ii8NLAhFPDfc2W0UObEtKsC5pq9+j4cgXVeBcKc0P8jQ+9JVvXiYIk3gHWduE5a8pm
 Hl5IQ7WhvxpCrMFCs2ytun3lJ24rZy3Yyww6WNr9SqM98LBJhPX4nRqbbRmJ2VJtS8ISGVcJRSf
 RvcXuDXaKfBExIqC
X-Received: by 2002:a17:906:8473:b0:bfe:ed35:e85a with SMTP id
 a640c23a62f3a-bff4c9eaf3bmr28078366b.50.1781288348008; Fri, 12 Jun 2026
 11:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260601131311.1163914-1-vjardin@free.fr>
 <20260601131311.1163914-4-vjardin@free.fr>
In-Reply-To: <20260601131311.1163914-4-vjardin@free.fr>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:18:54 -0600
X-Gm-Features: AVVi8CekbGCKBuC0IGp2xEKtpCszqN-iHiTejVRJSwYCg-qJAlRC-FzZkMg1qEg
Message-ID: <CAFLszThtQOE3LZvGoyaWjSvdjSLTaE5PQ82oD9908hxQyGAfyg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] test: py: load: check null_dev_desc_ok dispatch
To: vjardin@free.fr
Cc: u-boot@lists.denx.de, Sean Anderson <sean.anderson@linux.dev>, 
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

Hi Vincent,

On 2026-06-01T13:12:01, Vincent Jardin <vjardin@free.fr> wrote:
> test: py: load: check null_dev_desc_ok dispatch
>
> Some pytest modules exercising the dispatch added by
>   fs: dispatch null_dev_desc_ok filesystems before lookup
>
> test_load_semihosting.py:
>   "load semihosting - <addr> <file>" and the optional
>   [bytes] [pos] variant. Runs on qemu_arm64 with
>   CONFIG_SEMIHOSTING=y; reuses test_hostfs.py's host-staged
>   fixture.
>
> test_load_sandbox.py:
>   "load sandbox - <addr> <file>" and the optional [bytes] [pos]
>   variant. Runs on sandbox (boardspec('sandbox')); the sandbox
>   fstype is registered with name='sandbox' and
>     null_dev_desc_ok=true,
>   so the same fs_lookup_null_dev_info() helper that
>   routes semihosting also routes the 'sandbox'.
>
> A "load ubifs - <addr> <file>" test is intentionally not provided.
> [...]
>
> test/py/tests/test_load_sandbox.py                 | 53 ++++++++++++++++++++++
>  .../test_semihosting/test_load_semihosting.py      | 39 ++++++++++++++++
>  2 files changed, 92 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below:

> diff --git a/test/py/tests/test_load_sandbox.py b/test/py/tests/test_load_sandbox.py
> @@ -0,0 +1,53 @@
> +@pytest.mark.boardspec('sandbox')
> +def test_sandbox_load(ubman, sandbox_fixture):
> +    """Run load sandbox - <addr> <file> and check the bytes."""
> +    response = ubman.run_command(
> +        f'load sandbox - $loadaddr {sandbox_fixture}')
> +
> +    # Fixture is "Das U-Boot\n" (11 bytes).
> +    assert '11 bytes read' in response
> +    # Negative-guard the pre-patch failure mode.
> +    assert 'Bad device specification' not in response

The negative-guard is redundant. If '11 bytes read' appears we cannot
also have hit the error path. Please drop it.

Regards,
Simon
