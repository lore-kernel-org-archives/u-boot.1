Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C8CC83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 16:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FEDF82F8F;
	Tue, 15 Jul 2025 18:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="rNu9Eew9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 135E883071; Tue, 15 Jul 2025 18:20:41 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF9D82E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 18:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c14138668so2130681a34.2
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1752596436; x=1753201236; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ov2MFjr1moIiyZ4E6KClSIQJYvH/KFKFxD/Oyf++tyE=;
 b=rNu9Eew9DuGmPiHWeVLILLZ4/RCAaJG2PveexZPZYssZZeNLPKCWxL+iHUFSMdPOWE
 5HgGY4UfTFPH488bR6QTYxHkUuJ5fWn0wNwvL501kfJyAaZuo4t+zyIboZUweTeW1hoR
 +9bJ37oiSSzqIRTrBAXDDS4pMlap0aeCRzGC5bJfhV6DaFfW0USQGwUU5SRmg048tliS
 s7I+akS7ilWkQmaYdVksP6k5ZnqOJdb43V7Q1wW12HGTMCFduvZyskTTSEj+Q75qTzZn
 G1DCkpIHElTeZdOHbINCP+ljqgtQEznVbIl/rZ0h93VcqvtnL5OOXb9MKnvIjcXNxFi3
 /HdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752596436; x=1753201236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ov2MFjr1moIiyZ4E6KClSIQJYvH/KFKFxD/Oyf++tyE=;
 b=eDxlk95rRVlaehq0gPTwxwPzQwNxygqFdyoT+aeOR7jmmEf4jSnQTHejgOq2vjDvTn
 8/+kdjoXn1CzXUFZNHjst+/Ottk8JUjteXrW8/0n7YlaA2lip/bdnhH0On3F1YCOD5H3
 RC1oFuFviUYvSb+ItBhZfEWAGKP5gUgUKDyPo3jWVvYv9JBs1CeLLoPyUAnE1bmsSW0E
 7jQ+yIlxmbNId8tnNHGoHRL4ofjibGF4YY/ifP5l8UBokHzIRR/e3SJMosuUsws0Vtnd
 vhsv0g6y2RFJj4IdDY2cAneJ3irltGEMkVxVGt7r7k7DLZUN3ytW2t9UaKFM3Ns621fT
 PUkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt9Fxkw+iXvvq6ZAwy/biOJxzoY0VXFr+A1cms1itlM5GqWD0TwkLGGtdabJAuyprDsMd/sQw=@lists.denx.de
X-Gm-Message-State: AOJu0YwEtAerd7ssPaN30rzn7rRbp+mY4+/YWFDDIWh8OB/uomr1Jx9Q
 uioxjHgQlyMwm7Tm6v0SyVlo4z1AZDg4UzajgW0bKtjew3wTgy5+a7L1OvfFP4PSRDL45d9oV/0
 AJvE/6SMUCBvPSxNrcAbnAg8emVRM6quh2i8N5+Xu/w==
X-Gm-Gg: ASbGnctwWjoSYHB9AsTrEP2+P6+IcnZRZVaO5VCGU1+khldXP24LknILMWUo1K6NUCk
 SkD8X0bBu7velMXpedz8fsQgBuzr46wgWG1wQv8YIufsm8mSpnqmy+pdfj6Yf1tNcwy6v+xTvs0
 c+Qik2P9tmNW0xKwyA74Zx6Iu0uEe8TE0mJ8IyhEDnYlMTy17+JRDsieT5x+x7bqqB7+vh8Hkw7
 UCc8cA=
X-Google-Smtp-Source: AGHT+IGnP5qlaVRawsStP/oXodcTWv/8hhZyOtKHM8xTmsWTxxOQgko7sug8Fp/SJmN9mVWESVYDHiiH/tBUCGUQhAc=
X-Received: by 2002:a05:6830:6619:b0:72a:449e:2b69 with SMTP id
 46e09a7af769-73e64b1bc59mr29219a34.28.1752596434864; Tue, 15 Jul 2025
 09:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250715-binman-typing-fix-v3-1-86739854cf4f@phytec.de>
In-Reply-To: <20250715-binman-typing-fix-v3-1-86739854cf4f@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 15 Jul 2025 09:20:23 -0700
X-Gm-Features: Ac12FXz4Ia8qYwYL9SMz-Kaf-kudPqz3UTnxjN7sJOv9NKbjSOITjLcDHwCi19E
Message-ID: <CAJ+vNU0c5s87ZFj1ApwYc9nDYMA6O3NS1OyMrAbrfV=QOHCHiQ@mail.gmail.com>
Subject: Re: [PATCH v3] binman: Fix typing for python >= 3.7
To: Yannic Moog <y.moog@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jul 14, 2025 at 11:21=E2=80=AFPM Yannic Moog <y.moog@phytec.de> wro=
te:
>
> To get the [] annotation working with python 3.7 and 3.8, import
> annotations.
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Fixes: 21bc3433a43d ("binman: rework dropping absent entries from package=
d image")
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Changes in v3:
> - drop the deprecated and soon-to-be-removed typing package needed for
>   python 3.6 and 3.5 support. Instead use __future__ which is supported
>   by python >=3D 3.7
> - Link to v2: https://lore.kernel.org/r/20250714-binman-typing-fix-v2-1-d=
be6519c43a0@phytec.de
>
> Changes in v2:
> - drop newline changes
> - Link to v1: https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-6=
6ab075015ac@phytec.de
> ---
>  tools/binman/etype/cbfs.py    | 1 +
>  tools/binman/etype/mkimage.py | 1 +
>  tools/binman/etype/section.py | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
> index 5879f377231bf94697bea97c3cfc3a2515665b8f..9cc4b756b3f735b51d66f790c=
c61d77e50f18eea 100644
> --- a/tools/binman/etype/cbfs.py
> +++ b/tools/binman/etype/cbfs.py
> @@ -5,6 +5,7 @@
>  # Entry-type module for a Coreboot Filesystem (CBFS)
>  #
>
> +from __future__ import annotations
>  from collections import OrderedDict
>
>  from binman import cbfs_util
> diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.p=
y
> index 75e59c3d3a3104da7559982f64968fdd99b7bd5f..9fba902bdadfbde3b9c50ba98=
3a475b30aca305f 100644
> --- a/tools/binman/etype/mkimage.py
> +++ b/tools/binman/etype/mkimage.py
> @@ -5,6 +5,7 @@
>  # Entry-type module for producing an image using mkimage
>  #
>
> +from __future__ import annotations
>  from collections import OrderedDict
>
>  from binman.entry import Entry
> diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.p=
y
> index 03c4f7c6ec74c6fa75c9362e2fecdb0e6ab568cb..6a26d687056bbb4eaece86991=
6ea1a796ec1bd95 100644
> --- a/tools/binman/etype/section.py
> +++ b/tools/binman/etype/section.py
> @@ -8,6 +8,7 @@ Sections are entries which can contain other entries. Thi=
s allows hierarchical
>  images to be created.
>  """
>
> +from __future__ import annotations
>  from collections import OrderedDict
>  import concurrent.futures
>  import re
>
> ---
> base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
> change-id: 20250710-binman-typing-fix-a207bed6416b
>
> Best regards,
> --
> Yannic Moog <y.moog@phytec.de>
>

Thanks Yannic,

This one works for me as well.

Tested-by: Tim Harvey <tharvey@gateworks.com> (Python 3.8.10 on Ubuntu
24.04.6 LTS)

Best Regards,

Tim
