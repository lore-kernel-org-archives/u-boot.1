Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193F3C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 14:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A03A8748D;
	Thu, 26 Oct 2023 16:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MgK6K+Rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7D08749A; Thu, 26 Oct 2023 16:49:08 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AFB8744C
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 16:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5079f9675c6so1497990e87.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698331745; x=1698936545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tZH0T1RS292QL8fMTbKd/ZWaaBgtZGG4pAGkypfWpyw=;
 b=MgK6K+Rq7xN4xh8mEHPWZM4ntHugUg77tH5DLekWKaUKgjhPOc95i2JWtbH2MZSNKB
 U2c5PcuIhX9WgRWWenVKPGdHB1/kcj8Gav5tO/9h6qjxQ5jDp3PkDVNghpdjZNubXBWK
 hX/0Oy4+hIOTZO5WGVajjcDocVArMofvhRuMZhxq2eEeCH+Nr7mX18YK7Z2n+I18J65U
 VNvv4tPTu2nsWwSVobDcEJfD5rPGMtuJsIssXc4DxDrvgB6NtDTY9En3rJ0qEA2PbNAp
 10ig0CpytaJRPkt0ZF3yPK/biVxXAOJ9COF4/Wy0Faq0q30gUrb1zrgER7XwDJNyPN5i
 ZLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698331745; x=1698936545;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZH0T1RS292QL8fMTbKd/ZWaaBgtZGG4pAGkypfWpyw=;
 b=dXcomNK6f+eiZjJkaDjgXxEavczl5i8fUGa7SZl2wjgdPSoScoOqfzoJHkmwo0JoVc
 HskhUxuR85++CAYRNRH6nFGEq+lp085YyGbQrRhngSqQmQBk8m+aSeSb3oTfIWawaJGw
 y9z55uSXSSf1S+6aNkDHrCyvkCaDh2EXAQbE2a5TJhty86tFYO96IneDRv2oMa3G3qkw
 AW/zrZJjISgwDaSX+wjrCgEi36vl0GnhodQrVs+v3eeJsB3CA4UDu20VpSk/nRcT3vKi
 i9/4DknE8qxWO+SPBJ906oT6Ml/e8B2W0j35q7NFxjxvEdRAzml5hGtlKiexk4gJ8RoN
 mxPA==
X-Gm-Message-State: AOJu0YzLTQAuJtltp2B8jNoXE005T8dni5aohG8RKoZs+XxOP12ezT8U
 Uk3Y6qX2UjtEgOYNtGhwBtw=
X-Google-Smtp-Source: AGHT+IGmFT72Nd+QQ6E9tQ4g5re+4w3F73f90qQiB2xCIRyW3eRv23xpYw0xHGON3L0uXPYHocNu8A==
X-Received: by 2002:a05:6512:1396:b0:507:9615:b918 with SMTP id
 fc22-20020a056512139600b005079615b918mr15280546lfb.52.1698331745272; 
 Thu, 26 Oct 2023 07:49:05 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.167.217]) by smtp.gmail.com with ESMTPSA id
 e9-20020a05651236c900b00502e0388846sm3036932lfs.244.2023.10.26.07.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 07:49:04 -0700 (PDT)
Date: Thu, 26 Oct 2023 17:49:01 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 3/8] power: pmic: add the base MAX77663 PMIC support
User-Agent: K-9 Mail for Android
In-Reply-To: <20231025133712.GL496310@bill-the-cat>
References: <20231024074110.199623-1-clamor95@gmail.com>
 <20231024074110.199623-4-clamor95@gmail.com>
 <20231024191757.GG496310@bill-the-cat>
 <CAPVz0n3b4eH0q3sPGD7UkjVo56r__6AzoJsuwKy+XVPPCQX+xA@mail.gmail.com>
 <20231025133712.GL496310@bill-the-cat>
Message-ID: <B68639B5-C9EB-4300-B745-0265604BAFE6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



25 =D0=B6=D0=BE=D0=B2=D1=82=D0=BD=D1=8F 2023 =D1=80=2E 16:37:12 GMT+03:00,=
 Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2=
(-=D0=BB=D0=B0):
>On Wed, Oct 25, 2023 at 09:10:12AM +0300, Svyatoslav Ryhel wrote:
>> =D0=B2=D1=82, 24 =D0=B6=D0=BE=D0=B2=D1=82=2E 2023=E2=80=AF=D1=80=2E =D0=
=BE 22:18 Tom Rini <trini@konsulko=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5:
>> >
>> > On Tue, Oct 24, 2023 at 10:41:05AM +0300, Svyatoslav Ryhel wrote:
>> >
>> > > Add support to bind the regulators/child nodes with the pmic=2E
>> > > Also adds the pmic i2c based read/write functions to access pmic
>> > > registers=2E
>> > >
>> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > > Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>> > [snip]
>> > > diff --git a/drivers/power/pmic/max77663=2Ec b/drivers/power/pmic/m=
ax77663=2Ec
>> > > new file mode 100644
>> > > index 0000000000=2E=2E4070235d3c
>> > > --- /dev/null
>> > > +++ b/drivers/power/pmic/max77663=2Ec
>> > > @@ -0,0 +1,86 @@
>> > > +// SPDX-License-Identifier: GPL-2=2E0+
>> > > +/*
>> > > + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> > > + */
>> > > +
>> > > +#include <common=2Eh>
>> >
>> > Should have noted sooner, sorry=2E Please don't use <common=2Eh> in n=
ew
>> > code, and audit the include list you have as well (this one looks
>> > reasonable I suspect, all the same, so general advice)=2E
>>=20
>> Each and every driver in pmic dir has common=2Eh so it was an obvious
>> move to include it as well=2E I haven't seen that this header is deprec=
ated,
>> if so, sure, I will not include it further=2E
>>=20
>> About auditing inclusions, I never include unnecessary headers and almo=
st
>> all the time run tests to determine the least amount of inclusions poss=
ible for
>> correct build and work=2E
>
>Yes, it's more recently formally deprecated, and just removing it fro
>existing drivers is on the TODO list=2E
>

Should I reload patchset with requested changes?
