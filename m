Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD0FC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8540382B72;
	Sat, 10 May 2025 13:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="THmkMUXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7D082B72; Sat, 10 May 2025 13:27:45 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF6982B54
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5fcf1dc8737so644490a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876463; x=1747481263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LFY9Vmgud15RvScgwD/r3Wm4iHq557sQ8MvmPl6CW/Q=;
 b=THmkMUXiGAEgOHerGIONJUcc2eyS6Oc/M8TeMttEUR7aPX7YSLWXeRDSafGbr/Voxg
 71vycUHOhYSbeKSvyV1bYswp3/YwPfQyVXFZsx54ngHQiwYRacrBJaLiX8Y7B7Dh0+3E
 quALvF48Tz83WfYhI0havw1qi1moHlfRTQUzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876463; x=1747481263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFY9Vmgud15RvScgwD/r3Wm4iHq557sQ8MvmPl6CW/Q=;
 b=q+6P08giE3bn62kd4fSUkWZEnEVV0mxdjutzKDrV8GjKpNzkQ/jqe+kTQpx/YLwmFB
 oaJdpQ+ls2ynkyqsw4+T4sFt3RN7TPu+QrvU8zRrV0lORGTdEuklUXJll0vH4qzweh+k
 QtiZnbhsl882TN2T0KUar3Yhge6v2Q9lNiXhjiZmHWgBhewA1FkYaefbito47RRO3vHr
 i3xZGg9u2PMVLJQk08yXRcs4Mw98S8IOD4ugUabORRE3ulTK74bzOcR9oMAWysJQdRkY
 drmLxQMnA9M9Gi4NGgzARHZ+uTabr5dNR2l9wa1Cm/Fze3CCrZwX1dr+4mWhn+iuhfee
 wJXA==
X-Gm-Message-State: AOJu0YwGjFzX8WHLQsTIVHAFUqK3abwvrQh25xWNofSKKphpsXmHL3P9
 3/zugwxTsminRWuhqaOy8Bj+39l0VIVDC0DBDWSJuNUrUSojFpvI1DF5VFe57xQ6XuhgLclpTev
 RLoSKVZ31YJWXwXR9BuA5WLouHyvR6Wp9yvEIPG7KrZh8j7XB0jQeJEV02Q==
X-Gm-Gg: ASbGncsc+8gNx/e5PbZyk3eKRCPZ7ZytlS5rm8ljN9dV1Wsvvpz3FAYsruenizrO9Ti
 4Z8UthEtX9QTDwn2jP9RtSo8L1pDpr2B2Wz6kvp0CrRutqe06PhOC62ZU5FIAz1x989RKYIqTrh
 649QCisoRODZVg3QJPjbl7QM41W+stCIMz7A==
X-Google-Smtp-Source: AGHT+IF0w5I4DK24syMRtyjuC8NWAvx8BlT0JyCVa/l1WfklwcAHcIDPAVd4kKs4s3rPqHp/2RrX9YEeLmQTYCl3m3U=
X-Received: by 2002:a05:6402:5244:b0:5fb:1fba:cd93 with SMTP id
 4fb4d7f45d1cf-5fca07307b1mr5384272a12.5.1746876463175; Sat, 10 May 2025
 04:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
 <20250508214222.643020-3-trini@konsulko.com>
In-Reply-To: <20250508214222.643020-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:27:29 +0200
X-Gm-Features: AX0GCFt3J_z-WRP44xyilFh4z51QI0KIdlivFW8dzHZWp6pCEuol8Ft7lyWy-a0
Message-ID: <CAFLszTg_qX5K44BThRHjeOeBGcZd21+BE4QRBApzmf8+kLPAhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: pytest: Document the test_bootmenu test
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 23:42, Tom Rini <trini@konsulko.com> wrote:
>
> Add this test to the documentation. There was already a function comment
> that included the argument, so convert it to the right style to be
> rendered correctly in output.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/pytest/index.rst         | 1 +
>  doc/develop/pytest/test_bootmenu.rst | 8 ++++++++
>  test/py/tests/test_bootmenu.py       | 4 ++--
>  3 files changed, 11 insertions(+), 2 deletions(-)
>  create mode 100644 doc/develop/pytest/test_bootmenu.rst

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW ubman is a little more than the console right now, but I suppose
that doesn't matter.


>
> diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
> index cd6eb5f038f3..4d949cfd1d2d 100644
> --- a/doc/develop/pytest/index.rst
> +++ b/doc/develop/pytest/index.rst
> @@ -19,6 +19,7 @@ Individual tests
>
>     test_000_version
>     test_bind
> +   test_bootmenu
>     test_bootstage
>     test_efi_loader
>     test_net
> diff --git a/doc/develop/pytest/test_bootmenu.rst b/doc/develop/pytest/test_bootmenu.rst
> new file mode 100644
> index 000000000000..e2ff5c4c201c
> --- /dev/null
> +++ b/doc/develop/pytest/test_bootmenu.rst
> @@ -0,0 +1,8 @@
> +test_bootmenu
> +=============
> +
> +.. automodule:: test_bootmenu
> +   :synopsis:
> +   :member-order: bysource
> +   :members:
> +   :undoc-members:
> diff --git a/test/py/tests/test_bootmenu.py b/test/py/tests/test_bootmenu.py
> index 66f3fb8a1310..be8257fe3e8b 100644
> --- a/test/py/tests/test_bootmenu.py
> +++ b/test/py/tests/test_bootmenu.py
> @@ -8,9 +8,9 @@ import pytest
>  def test_bootmenu(ubman):
>      """Test bootmenu
>
> -    ubman -- U-Boot console
> +    Args:
> +        ubman: U-Boot console
>      """
> -
>      with ubman.temporary_timeout(500):
>          ubman.run_command('setenv bootmenu_default 1')
>          ubman.run_command('setenv bootmenu_0 test 1=echo ok 1')
> --
> 2.43.0
>
