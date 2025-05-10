Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A404FC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09DA82B5B;
	Sat, 10 May 2025 13:27:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XXlXzRnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511C7826AA; Sat, 10 May 2025 13:27:50 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD2182B39
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad238c68b35so103843866b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876467; x=1747481267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2qXv1n8dsF4dxc6+1POFDPO/o8zc4dGaMyRkUPWNoso=;
 b=XXlXzRnlHubzg2S36FBrlN3n4mVtvxvqhBsxgqb6NYm+0m/d2fosodZ71ZWSB1N4e5
 8FVZeKNjHa8jl3/gcKoTmd5PlvZHdFYJL9/bdJh2JkZS80I11J+CawYGL9RFu0rO0/3/
 59x62tnI0jY5PpsgefIFJauYZYyzL3X7Y2Ndk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876467; x=1747481267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2qXv1n8dsF4dxc6+1POFDPO/o8zc4dGaMyRkUPWNoso=;
 b=Mu9UL6ZVKPeOj+7a+isNcyAmBgdkD0h540VH+vyncGCV9T6zpc230hj/NueOVdXW6R
 ZruNhc3mNS5sxKa0eJf5pmfmK0GsE2Zx4x/Q0UiowSaqmNCmVl9jJgKAdgOPBAJ/iWh3
 hF1JmDRmFLWELCFLns8WAhqsadloiWDnjWaGp2bVDRfdbeh6gXG7z+uUBv/8fsbWAiq1
 JJ1ZG+m5SmPJ+6bjYJtinqp5opDm7ouKuzLCWMjeHoos0+ImRnh7CbCz+FzFQszGuV7D
 Ik5UPUX1HasqsA1Dw7vGX6bBhdyS37QqKSvgutJgvm09XDzE+b8hsDtl7LIC7p9Ru3L3
 2/8A==
X-Gm-Message-State: AOJu0Yzo7ypkwOAtAzu1pqpoonQIfe9KWuZnJ1qkFjtGsbT3eRG6QVV2
 NLUKE57KiYLHyL23wkcQwVbBCO/rA5UPfu2QfHK9jPY1XZUJMGU24x2UpT+zwRIghLdP5XDgxk7
 7Gxwb23M9kbSRrNcW+g32VTABUPY+k6uXNH/4EjqfKfglsNNS4dMqxBuMlQ==
X-Gm-Gg: ASbGncsg+e+ApvFb96tnxw2ni46qMYhb9Q+SWGWikqz+jkwIh6PK8Uqjo9GZYyicdZ8
 /OCOqFjQ1tTg/8DfmtDx0s5c6np0iMdY6gadtgPe6F5l3RmVT0DsGQtN1Vhakkd+SqPXUENbZ3Z
 lTPdvYU9AB47XfBZP6oGFxe+rrPK0QjrGd3w==
X-Google-Smtp-Source: AGHT+IHVyqfwZ9kESWIoG5dzN70MWhqJVqOysDMrpl9CNLBZD0Z1yziTuC2Gp3RUjzbspfSJjXBRgNCTa57EWdq+fJI=
X-Received: by 2002:a17:907:a605:b0:aca:a539:be04 with SMTP id
 a640c23a62f3a-ad218e49fd4mr696500266b.4.1746876466984; Sat, 10 May 2025
 04:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
 <20250508214222.643020-4-trini@konsulko.com>
In-Reply-To: <20250508214222.643020-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:27:32 +0200
X-Gm-Features: AX0GCFsdb-S5430Nv3dPgx6jAuH_8fP0FEJOl5GJnmdx9H7p21v4TbLbr0QQKhI
Message-ID: <CAFLszTh4h9E9ZprrBdz4dKzUQZBm_bXduG6L53a5mPHBv+GBjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: pytest: Document the test_button test
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
> Add this test to the documentation. No changes to the test itself were
> required.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/pytest/index.rst       | 1 +
>  doc/develop/pytest/test_button.rst | 8 ++++++++
>  test/py/tests/test_button.py       | 2 ++
>  3 files changed, 11 insertions(+)
>  create mode 100644 doc/develop/pytest/test_button.rst

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
> index 4d949cfd1d2d..0a7c1b21a24b 100644
> --- a/doc/develop/pytest/index.rst
> +++ b/doc/develop/pytest/index.rst
> @@ -21,6 +21,7 @@ Individual tests
>     test_bind
>     test_bootmenu
>     test_bootstage
> +   test_button
>     test_efi_loader
>     test_net
>     test_net_boot
> diff --git a/doc/develop/pytest/test_button.rst b/doc/develop/pytest/test_button.rst
> new file mode 100644
> index 000000000000..4e5a29f20a7b
> --- /dev/null
> +++ b/doc/develop/pytest/test_button.rst
> @@ -0,0 +1,8 @@
> +test_button
> +===========
> +
> +.. automodule:: test_button
> +   :synopsis:
> +   :member-order: bysource
> +   :members:
> +   :undoc-members:
> diff --git a/test/py/tests/test_button.py b/test/py/tests/test_button.py
> index f0d85be896d8..f3f68169e148 100644
> --- a/test/py/tests/test_button.py
> +++ b/test/py/tests/test_button.py
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
> +"""Tests for the button command"""
> +
>  import pytest
>
>  @pytest.mark.boardspec('sandbox')
> --
> 2.43.0
>
