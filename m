Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF83C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7D287A1D;
	Wed, 25 Oct 2023 08:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4j6SS/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E884D87A22; Wed, 25 Oct 2023 08:10:26 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE6887258
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32d8c2c6dfdso3356669f8f.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698214224; x=1698819024; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHm9JKG1jCvI/3gOMKyLzBKVKLNP430LtTSWUIIaM0U=;
 b=D4j6SS/lfDzP/KA1JjJ0o+1FAHc/uz2hN32o8lLk4ZCEj4jHiUH9aPk2xeRzKb5lTu
 JIkyOhteQRqyigRrDGOSM3WhiIgah8ZBC68zvqgldzcS0fCCbQyKEUuQZL3e8c4zMt89
 zzfkPDE9k/Beb8Ux9WHvxRo0cUgmcQD62x98OVcKmtlInbu7Je/f7kdcqt+5zl4MGPVt
 4K5KhymXNjCWVn+aFm1oASOpk0y+vyyDc2UsldGrE60ugdGhMbrliIo5pf28BQPeQXDQ
 7OgmrASowJSqJPN+2h8BkY906ZTqz0Y9MAmDZaDu9qTr8gI5Smjj5s4yqV7Q4MwXyaGe
 /z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698214224; x=1698819024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHm9JKG1jCvI/3gOMKyLzBKVKLNP430LtTSWUIIaM0U=;
 b=AsBnJX9Tfa3s48BKdehNzbCfpUTek0IY2JVlAhBoqDnU7A7TF+38BlBgh7kN75JERY
 sij/g7KKPFP3BW5lgVovcHct+4Zncuc9bM3eWUApRsSUia52vQkW9Tl85OvK/xe2iqjB
 PRLzehuox8YpIAp2BeXdb2/sNJnK5q5IJbDsVHdFH3gf9EXGg4vs6DgxyLmXC8fAMUo3
 9KaoD8h7+GnVR2gv/z+rfRLBkh7RUc6G+uYdTCiDd6asw8RBVbDMfTtZu32MfyzC8ZJL
 qVaKovVxriRkouq+Sj+Y75CZWQMRL93SvA4skGHXOQOMju0bNkGojUui1ep7y+Of6cHX
 rW4w==
X-Gm-Message-State: AOJu0YxFkc9IMDYRbCnljbAvIPvd4AyljCW6dexP4c3uNFsz8+S51eMz
 wCJRaVe573PA+8Zc6D1W232bgWOkONCJGgthKf8=
X-Google-Smtp-Source: AGHT+IE1TWQduM2TuGOtUFu8YUgOevrh3x+mpg+drCS/bO/OBn/2iqU1/B+Cb711MpG+5epgF6DUCv20/6iw3GN84hU=
X-Received: by 2002:a5d:62cd:0:b0:32d:9df1:6f6d with SMTP id
 o13-20020a5d62cd000000b0032d9df16f6dmr9528848wrv.17.1698214223967; Tue, 24
 Oct 2023 23:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231024074110.199623-1-clamor95@gmail.com>
 <20231024074110.199623-4-clamor95@gmail.com>
 <20231024191757.GG496310@bill-the-cat>
In-Reply-To: <20231024191757.GG496310@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 25 Oct 2023 09:10:12 +0300
Message-ID: <CAPVz0n3b4eH0q3sPGD7UkjVo56r__6AzoJsuwKy+XVPPCQX+xA@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] power: pmic: add the base MAX77663 PMIC support
To: Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

=D0=B2=D1=82, 24 =D0=B6=D0=BE=D0=B2=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 22:1=
8 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Oct 24, 2023 at 10:41:05AM +0300, Svyatoslav Ryhel wrote:
>
> > Add support to bind the regulators/child nodes with the pmic.
> > Also adds the pmic i2c based read/write functions to access pmic
> > registers.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> [snip]
> > diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max7766=
3.c
> > new file mode 100644
> > index 0000000000..4070235d3c
> > --- /dev/null
> > +++ b/drivers/power/pmic/max77663.c
> > @@ -0,0 +1,86 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> > + */
> > +
> > +#include <common.h>
>
> Should have noted sooner, sorry. Please don't use <common.h> in new
> code, and audit the include list you have as well (this one looks
> reasonable I suspect, all the same, so general advice).

Each and every driver in pmic dir has common.h so it was an obvious
move to include it as well. I haven't seen that this header is deprecated,
if so, sure, I will not include it further.

About auditing inclusions, I never include unnecessary headers and almost
all the time run tests to determine the least amount of inclusions possible=
 for
correct build and work.

Best regards,
Svyatoslav R.

>
> --
> Tom
