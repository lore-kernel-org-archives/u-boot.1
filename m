Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2080C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 13:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E38587E40;
	Thu,  8 Feb 2024 14:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KbcRPXXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36CDD87E51; Thu,  8 Feb 2024 14:41:55 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E729387E37
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 14:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40ff28388a6so16599965e9.1
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 05:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707399712; x=1708004512;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vct8k7VPFSy/582A0Wm1Z5eua0LOlLnWo9u8Zomt0Tw=;
 b=KbcRPXXQdQv+qZE7eMKe4oqNWMQbdzsYGUFXI2N3ibNmnbMkdzvSvdswwyyHcHdlWh
 ylICfEiS+tvxxw/1vQgv+vXDYzuQqsgyCHHbr8rMaFJkdfpz7afIfRDhdtR8hDGlB23g
 e2uKKGHANICnlNdiT2jyofh5Rh5pQxJ/GJh6jeggOhHyIypNuFY9Au6M6dK8cldPI0lG
 gYIkZv/DWkYr/heaCMRRssY2O4DWve56frFDp1n/Tfwgr2Rhv7avn3dY/XNDGHRqHWMr
 u6ipc8uh2nrLpjLB2bDuNVhkzjhGcqD5mFl56DH5hCP2IX8msJnV3OccjmTWzghHOhea
 Oevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707399712; x=1708004512;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vct8k7VPFSy/582A0Wm1Z5eua0LOlLnWo9u8Zomt0Tw=;
 b=jp5ZnAsM0wS2BBNXupnyaoe+dWZ8ulyvDHrwg3bizwR+zuzkd89g8zla0Oi8zUoRhR
 tS1NDXI+uLIK3l6nomnDkL+gYMVrv8VkhfmV1UyEFhpuq1pKSklzDow2oooYj9UpNf4u
 pdvO59rqV9nzpCyIc5mVp8bYOjfkRCfMYySCoEoDfrE6eyNkiN+UA8ncnbwqHUso643u
 yuiA9RPVXcT3lN+1i5defKiXlPv/tLtQXHp7Ji55KEBpcPKAieDajkbeG6A39SD9YYUO
 N5z0ZS4CtLKt6sBMrlAkkY6s4mxb/giZ+ynTcx1TR25ol6AfDY+NfIBasHdY3Dj5LZ89
 AvCw==
X-Gm-Message-State: AOJu0YyiXtvOHRvIoa+5gAvAimNpydunX9HAGpJ0l3BANq3O5gAxdzVR
 WdKdizWSWgkL7B/Pe4O/ydkm4Atfliv0oUCWr8PPqLs30E/+9VFErJJNixtexsA=
X-Google-Smtp-Source: AGHT+IFu66uvYxP3ARCTNeIKj3NhFnfv3P+m/JL/fxaJ7bAHDNnkDlYMDjVumlLH6NfumR/doZG1IQ==
X-Received: by 2002:a05:600c:4f41:b0:40f:bde9:6e29 with SMTP id
 m1-20020a05600c4f4100b0040fbde96e29mr7501965wmq.39.1707399712254; 
 Thu, 08 Feb 2024 05:41:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV09iuzWoQgr1NKbqiQMIY4eTI0f6OrjcIGWLtAfXwNhM2HLMpMpyBkzAqzzcg2898O5o7ImpFXlNKf0JXqI5yDPEkk6IS0WkQv+oX3RnlHRP0/TDaGWe3zUsLdU67swZmywngIiZ9TS2Ffhq3wAlWBDQcAqb8653rdDu8/25Rt8fmmpdSTburIQ9yi5oF5khkXlklOjh9cF2UZgSsTS26mvWWybK1lWRZ0qeuho+gQCIP2YgQ0ocMBbPKq9hTAVM4fAwBFPVaVmVF6fKaJ33rQEobrKRz6qgoC1ek=
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c044a00b004100b3c41absm1606204wmb.30.2024.02.08.05.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 05:41:51 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Ivan Khoronzhuk
 <ivan.khoronzhuk@gmail.com>, Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, Stefan
 Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 2/7] avb: move SPDX license itdentifiers to the first
 line
In-Reply-To: <20240206223153.3060433-3-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-3-igor.opaniuk@foundries.io>
Date: Thu, 08 Feb 2024 14:41:50 +0100
Message-ID: <87bk8rjco1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Igor,

Thank you for the patch.

On mar., f=C3=A9vr. 06, 2024 at 23:31, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Move SPDX license identifiers to the first line, so it conforms
> to license placement rule [1]:
>
> Placement:
> The SPDX license identifier in kernel files shall be added at the first
> possible line in a file which can contain a comment.  For the majority
> of files this is the first line, except for scripts which require the
> '#!PATH_TO_INTERPRETER' in the first line.  For those scripts the SPDX
> identifier goes into the second line.
>
> [1] https://www.kernel.org/doc/Documentation/process/license-rules.rst
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Nitpick in the title: itdentifiers -> identifiers.
If no other remarks in the series, will fix when applying.

> ---
>
>  cmd/avb.c                              | 4 +---
>  common/avb_verify.c                    | 3 +--
>  include/avb_verify.h                   | 4 +---
>  test/py/tests/test_android/test_avb.py | 3 +--
>  4 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/cmd/avb.c b/cmd/avb.c
> index 783f51b8169..ce8b63873f2 100644
> --- a/cmd/avb.c
> +++ b/cmd/avb.c
> @@ -1,8 +1,6 @@
> -
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * (C) Copyright 2018, Linaro Limited
> - *
> - * SPDX-License-Identifier:	GPL-2.0+
>   */
>=20=20
>  #include <avb_verify.h>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index 59f2c25e0de..938a5383b5d 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -1,7 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * (C) Copyright 2018, Linaro Limited
> - *
> - * SPDX-License-Identifier:	GPL-2.0+
>   */
>=20=20
>  #include <avb_verify.h>
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 1e787ba6668..2fb850044d9 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -1,8 +1,6 @@
> -
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * (C) Copyright 2018, Linaro Limited
> - *
> - * SPDX-License-Identifier:	GPL-2.0+
>   */
>=20=20
>  #ifndef	_AVB_VERIFY_H
> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_=
android/test_avb.py
> index 238b48c90fa..865efbca4de 100644
> --- a/test/py/tests/test_android/test_avb.py
> +++ b/test/py/tests/test_android/test_avb.py
> @@ -1,6 +1,5 @@
> -# Copyright (c) 2018, Linaro Limited
> -#
>  # SPDX-License-Identifier:  GPL-2.0+
> +# Copyright (c) 2018, Linaro Limited
>  #
>  # Android Verified Boot 2.0 Test
>=20=20
> --=20
> 2.34.1
