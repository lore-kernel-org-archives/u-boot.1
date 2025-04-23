Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47264C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6500180050;
	Wed, 23 Apr 2025 14:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dzg8qzxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E48D8006D; Wed, 23 Apr 2025 14:27:43 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126308003E
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso1153583966b.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411260; x=1746016060; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjNI3Hj4xaYykypNA08IALyerR+u/xwYGIUUdsU1pkM=;
 b=Dzg8qzxrbpthHqlcEbMFghn7rBAiT48decPrH3ShxLEXtw/xJyI8D1DJWjenewd5Et
 4AIpp9c4prJR0IghrnRpKihnYtct48F1fQGpiIAaZw5LasP+cH7BDOnZsG1hZ/9zKeTk
 wspZNxr3diOfAC6G+O5sqMKpVyawyczNoG+KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411260; x=1746016060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjNI3Hj4xaYykypNA08IALyerR+u/xwYGIUUdsU1pkM=;
 b=oXCmCqk/356ZBnElKhS3rJlHbQ1tfTHGeTEqZltt6S7tF7HCT2ltCKlkbK9znuYnuU
 2Te/nlJyamMa7bxqz8Ccjx9mEK82f89HquwZvGOQV0m8S0x58LjSr63vRSuYmOAWYp7s
 SR48PnZbCpy2CB+G3NbfJpaly+dEaMThauZXGmXH6lPr0RG+X/KC2ZZwpjheuNI+39AE
 yl/ak3AAe2tDKXAvlgnSXTZYGXtTpqRpZAvBVHW8LW3IhrmRGhl+SLTg2gi4teoAj1kz
 /UFUh3H/JqML0heGijQPROi5fyuPRuW9SCcOBBH2vWCeAl+LXorEOIH/qyiAY0iYXkTz
 Xqiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkhGcqZ4G7rS9/3sswRk53LXREadTVI0T//ZseP9AXd2wDGKzEz5tlZp/FUIHhF7UTr/FzYPI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv6DszQo6VFONU5GhIp6nL+7pZd8VZSDXDIblmoFzsc7LRUHZ5
 fLBewxMxDDA8W48szQkSCnOQW4PVTLn/XAdiwwry8oYIZ7tF9G0xG6qA/qaVdsESNEJAIjlQB7C
 LUqsXVKheGGzoRo0Kn/XUs9zpBc/toyZNvfhN
X-Gm-Gg: ASbGncsl2IqA5teJOv24YA5rigsmsJ4fciJ2z08KQ5F8cumZXr3b3TBP/9a29WNt7xv
 JvdAh1fABMn2syfpmuqWiv3y+fkgY1Q1sp6N/jqpjjV8ao1HuFPQln+ZKFUnNnXwIDRizK5IH7H
 QJ+2GU/r+PSo1Y5vpNDOi9Vkirk8x/tMxoqg==
X-Google-Smtp-Source: AGHT+IHg18PF19BuVClPeBtZ7VtbfqOcD6dYgXtRrzjNbzrfyhkWdJ+Rvpf6LLMCQ1rGUQyT0jqQipI6qWMgAXz20Cs=
X-Received: by 2002:a17:907:86a0:b0:ace:3952:c375 with SMTP id
 a640c23a62f3a-ace3952d6ecmr354208666b.42.1745411260289; Wed, 23 Apr 2025
 05:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250418-binman-pubkey-dir-v2-0-b6b90a765ffe@cherry.de>
 <20250418-binman-pubkey-dir-v2-2-b6b90a765ffe@cherry.de>
 <CAFLszTh49HqGC4P2=nefc8vgdWrLe_p6HoyoEZ=FkadNBLsp3Q@mail.gmail.com>
 <f9f57c41-9623-45da-878b-f62927beee9e@cherry.de>
In-Reply-To: <f9f57c41-9623-45da-878b-f62927beee9e@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 06:27:28 -0600
X-Gm-Features: ATxdqUGUkKpJ6Vt_hDYxIcfN-n0ifBr_hdVFA2LYhCuQ4bXKFwcUjZ3oGhzedKc
Message-ID: <CAFLszTgDJsO5UFVhpWfo3zoLmjC_o=GnONjQeeWU=mejfMbNDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] binman: etype: u_boot_spl_pubkey_dtb: provide more
 explicit error for key-name-hint with path
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Alexander Kochetkov <al.kochet@gmail.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
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

Hi Quentin,

On Tue, 22 Apr 2025 at 02:53, Quentin Schulz <quentin.schulz@cherry.de> wro=
te:
>
> Hi Simon,
>
> On 4/18/25 7:19 PM, Simon Glass wrote:
> > On Fri, 18 Apr 2025 at 05:26, Quentin Schulz <foss+uboot@0leil.net> wro=
te:
> >>
> >> From: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> key-name-hint property in u-boot-spl-pubkey-dtb binman entry may conta=
in
> >> a path instead of a filename due to user mistake.
> >>
> >> Because we currently assume it is a filename instead of a path, binman
> >> will find the full path to the key based on that path, and return the
> >> dirname of the full path but keeps the path in key-name-hint instead o=
f
> >> stripping the directories from it.
> >>
> >> This means mkimage will fail with the following error message if we ha=
ve
> >> key-name-hint set to keys/dev:
> >>
> >> binman: Error 1 running 'fdt_add_pubkey -a sha256,rsa2048 -k /home/qsc=
hulz/work/upstream/u-boot/keys -n keys/dev -r conf /home/qschulz/work/upstr=
eam/u-boot/build/ringneck/u-boot-spl-dtbdhsfx3mf': Couldn't open RSA certif=
icate: '/home/qschulz/work/upstream/u-boot/keys/keys/dev.crt': No such file=
 or directory
> >>
> >> Let's make it a bit more obvious what the error is by erroring out in
> >> binman if a path is provided in key-name-hint (it is named key-name-hi=
nt
> >> and not key-path-hint after all).
> >>
> >> Fixes: 5609843b57a4 ("binman: etype: Add u-boot-spl-pubkey-dtb etype")
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >> ---
> >>   tools/binman/etype/u_boot_spl_pubkey_dtb.py              |  2 ++
> >>   tools/binman/ftest.py                                    |  7 ++++++=
+
> >>   .../binman/test/348_key_name_hint_dir_spl_pubkey_dtb.dts | 16 ++++++=
++++++++++
> >>   3 files changed, 25 insertions(+)
> >>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > The change log seems to be missing?
>
> The change log?
>
> Between v1 and v2? It's in the cover letter of the series, this is how
> b4 handles it, not per-patch change log.

Oh dear, that's harder to work with. I believe someone is working on
b4 so perhaps that feature could be added?

>
> Or are you talking about another change log I am currently unaware of?

Regards,
SImon
