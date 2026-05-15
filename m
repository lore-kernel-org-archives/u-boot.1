Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6A8CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A7BA8469A;
	Fri, 15 May 2026 15:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lLfY7ZaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D7B8469A; Fri, 15 May 2026 15:06:30 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC21D84099
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd0fc4c336eso1027144666b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850388; cv=none;
 d=google.com; s=arc-20240605;
 b=EzvRHQrjV4AXe9IgxCZU02wH/ge2SwY8zYW6K/vWdmDta4JMy7F+hiaZgGiOJ/OmcJ
 EKCXQ7vRVRmA+Vkgre8gU+Lx6nQInQXvkxjzKYo8yGp4xgYDTwQvzgsw8W0z71CeDDWK
 1c7E59FwE/U1H3/MFZ4cu5TY+99ThpuvgKz0v/9QHBkI92F0ntvzvwOnTxp/d7rAFcbQ
 AEpa2WdZ0N1JVGVhdGcETkehWCjgj1DzboUC7zq7Fc8zC7B5OFASAcso1ynOgeakNM3s
 lg+1dyWNckQG4DV+r0Jch9hPwSbojhJmnjpBDF0SJph79e8kixbY6cSIN1b6l+ukUwUC
 6yMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AiZFl5agjcJ8F1jPE1osPAzD3b8rSNohiPHfqM4pVd8=;
 fh=uHnctjfjo81NP+4b9H5aVwcI8F1nm2RvYATNLKEK624=;
 b=iNkNAYKzy7QL82V3BsrnPeSahuDJpqoJjcbt/xIsAU4sSSXJoF5YbCDYvlGJCjBPlg
 TWhAiZ06ofvFg2iyEuXDgs+WBiIsbAWKpL0yWCeJfrqfGVNZQPJS4O9cNkuPvzCg1fOU
 SNzYrzN8oUIbG4PZimR/bemWNGM1prcqBFsN987URpE5ncAojyGxCr8ZXx9HMuye9dmR
 03lBv+YXaZT6wLaZaK+1RloUj1HJvKFmpn/OjByCJqijAq84PWrrqwOialD6HC4SR2KC
 WwJ0z4GF3CvzaeUpRexQ2NpxmiArI4fpDCx125QpJpmNoV4PialfH4qdo13esRztf3VX
 MXpw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778850388; x=1779455188; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AiZFl5agjcJ8F1jPE1osPAzD3b8rSNohiPHfqM4pVd8=;
 b=lLfY7ZaCvANskJMpgKjzYwOHXmlkH+7wagShBGHmHOlwVzQqxtRgzVASbe62B3k/4y
 H8baj+tBeS89mPoUiic8kWti9q5LstaZULQn2GEQ29PyE7oAhvw89oZ25eMfIJDm6zWD
 O1bHTiYsPNPoLGRRUM7TaDOqSKzm6SGh0q9HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850388; x=1779455188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AiZFl5agjcJ8F1jPE1osPAzD3b8rSNohiPHfqM4pVd8=;
 b=FYisf8d2H6mViLxC4mDxgf7PHmGulqKKL7thrYmsRQijHE8dF2W1hlfzXgiD2KAUHi
 TTyktCaWUKcw8X2jSLlpFLI89UQdjY5TvNSNK2K6dKONc/qPOS/X6Onvras8F2Mk0NKe
 mSxVkgPOR/LvT1lIwIl/AiR+S8KLoqJHoTyobA+y2NWD4G7rHD+FSQeZOwKH+Mdy4J2I
 w4znPcftNBUQbf5xIDrBM1fiNTVV83n+4lOi6Vpc/dn8tRQeiuri5TQ0uXtI4TIqU4iQ
 LjnZhN1KK2oz27GqKgkXnyihxYWUZ1p9rZnJo93mG82e8s0TOhW51DveZoidQc8ZT1Ic
 bYJw==
X-Gm-Message-State: AOJu0YxXgeZYSm7ZE016bzajL0dD8R2eHGy+yEwSfwnVJxdOfsdJuMPl
 0KeRvj5osliO7uayPfnfrYu5LLZANXOp/PnXoCgRoIP7/VKZ4XG6rVZ/kZbZjFsBL0vxfatJLI8
 8sMZHd8GKZJ47J7oXMkQmrRujCw0RU6ivCJStp9ndXmMWaFaHsPU=
X-Gm-Gg: Acq92OHa/OSKvLvUziIZstHmywnspN+32qLCbgfZhLChIm1pOxLXIXqLK39hlAoSpkH
 nt1hqFg3sIcEZR5+AI1lNDqHatSo+4qAQVH7HBCD6cynaeUAOp5yhcGKiKGqsgb7sMvHAE9Y7S0
 Dbxyu/bpVvhiCbPAalmJWE8KXkMrf1j+X/DMs/XW0JdGSGmlbSrJnLsEtpSXQKpai2OC2npIe90
 CZCNQplsHzSUAZSI5qmt8kN/SjJZeAyUDQOqdl55QT0nAlTl/ulnr0P2V9H/GO9LHg1H3vbgQ9z
 16oE9A==
X-Received: by 2002:a17:907:c486:b0:bd5:7a3:a590 with SMTP id
 a640c23a62f3a-bd51797a605mr195508166b.47.1778850387944; Fri, 15 May 2026
 06:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260512161631.284143-1-ravi@prevas.dk>
 <20260512161631.284143-3-ravi@prevas.dk>
In-Reply-To: <20260512161631.284143-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:06:12 -0600
X-Gm-Features: AVHnY4IMK8xwR0LabkshGNzy4luXO9LXrgC7l0UYvkjQOLwgsz_DNR2jFAy76zc
Message-ID: <CAFLszTjjSHWVUjsCCxK2+w6Cp4W56xDis2sWiYFUDDdeAafwjw@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: hook up test of allowing control DTB to act as
 FIT image
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Rasmus,

On 2026-05-12T16:16:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
> test: hook up test of allowing control DTB to act as FIT image
>
> Add a test demonstrating how one can embed various scripts in the
> control DTB and verifying that the source command can be used with
> ${fdtcontroladdr}.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> arch/sandbox/dts/sandbox-test1.sh     |  4 ++++
>  arch/sandbox/dts/sandbox-test2.sh     |  4 ++++
>  arch/sandbox/dts/sandbox_scripts.dtsi | 18 ++++++++++++++++++
>  configs/sandbox_defconfig             |  1 +
>  test/py/tests/test_source.py          | 12 ++++++++++++
>  5 files changed, 39 insertions(+)

> diff --git a/arch/sandbox/dts/sandbox_scripts.dtsi b/arch/sandbox/dts/sandbox_scripts.dtsi
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/ {
> +     images {
> +             default = 'test';
> +             test1 {
> +                     description = 'Testscript';
> +                     data = /incbin/('sandbox-test1.sh');
> +                     type = 'script';
> +                     compression = 'none';
> +             };
> +             test2 {
> +                     description = "Another testscript";
> +                     data = /incbin/('sandbox-test2.sh');
> +                     type = 'script';
> +                     compression = 'none';
> +             };
> +     };
> +};

There is no image called 'test', so default = 'test' points at
nothing. Did you mean test1? Fixing it would also let you exercise the
no-uname case (see below).

> diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
> @@ -34,3 +34,15 @@ def test_source(ubman):
> +    output = ubman.run_command('source ${fdtcontroladdr}:test1')
> +    assert 'aaa' in output
> +    assert 'bbb' in output
> +    assert 'ccc' in output
> +
> +    output = ubman.run_command('source ${fdtcontroladdr}:test2')
> +    assert 'aaa' not in output
> +    assert 'bbb' in output
> +    assert 'ccc' not in output
> +
> +    assert 'Fail' in ubman.run_command('source ${fdtcontroladdr}:no-such-script || echo Fail')

The cover letter calls out 'source ${fdtcontroladdr}' (no name,
falling through to /images/default) as the headline use case, but
nothing here exercises it. Please add a case for that once default
points at a real image.

> diff --git a/arch/sandbox/dts/sandbox-test1.sh b/arch/sandbox/dts/sandbox-test1.sh
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +echo 'aaa'
> +source ${fdtcontroladdr}:test2
> +echo 'ccc'

The commit message is very terse for three new files plus a defconfig
change. Please mention that the test also verifies recursive sourcing
from the control DTB (test1 invoking test2), since that is a
non-trivial property worth flagging.

Also, could you add to doc/ ?

Regards,
Simon
