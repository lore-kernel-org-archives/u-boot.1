Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C47CC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C907880DE;
	Wed, 27 Mar 2024 15:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IdjK9iO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BEB880E0; Wed, 27 Mar 2024 15:17:49 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC62880D2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d6a1af9c07so91466521fa.3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711549066; x=1712153866; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pfb7Ru0wHai7n4C797DPWjcsyGNGoAmf9zvf9u1/Tr4=;
 b=IdjK9iO6qosNdip45KSGQP+sAf66FGUWE4n1sJ2eaisPu7J4N9RtULLeNLom6zQhZV
 00Pf4DsmBxjQWqfYSxbCJWgF26PBxk+qVZ0hbc2yADpGZaTyUsXYbz0bjUDD2wd9lvfH
 qbz0cbteU0FOqYdG8hnU8vfveupDlQQzuFTItfmqPpneANCOPh/QWF76nfACAX7Lcrfs
 NxuyAbt1Ua1zIchXxaHutiWzMQ6+TDiWBtvdcoYDTWWLFOc+BOHeQi7u4B1Y0AXKrqI2
 8ce5Vqs4nqwKeZcd08gijE8l8CVI34riDi+HjVSBCJZDJ9hW0uyVbHdn+TnkPob/dSZ9
 P4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711549066; x=1712153866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pfb7Ru0wHai7n4C797DPWjcsyGNGoAmf9zvf9u1/Tr4=;
 b=wgqvp84mTtvx0G53mz+KUw3iq9Nc4nmVdKcG1TJZP1NTrVvXbSqqRHERCNctexi0zH
 W54DuIOUDVnJ7UDOjSsLdG6+1a9qo7bPGHbEX2r2JsAlOU/GmQ++CfsdIdOQYh0be49O
 81sCg3RoqDD9WUMwQkOUZ5qpsHncThne7O+rIPRVobGnCOLnraYIq/if3VfK5WRw8P/D
 MuyPk8vLb+AXYfR7SGTV9er2iR/WdwB9A8uzwW7RinRZr+Gz5YsnxLJrNVDMdgNSAwq3
 fCdBk6Z/+lxig3rgdJd612ssKP4aOKxYMXtcT4jG0JiEukD0Yo0y8NeQCr2gKNsmaSBt
 bS+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXodMXC8s2oOw9NZAZq0ikdnTAfSpvsv10D/L+z3iCd3neUucALbGpbQkj92mdqClnZoVRo0FZg3eLIeKh/rgJsQwghGw==
X-Gm-Message-State: AOJu0Ywjlge/3JLbXWj9ayVZlNDaaHa5t1st1ybvMGnbHt8aVO01vb7/
 LLokkQw2HAXDyA+dwfr4DXHAYLtTyZ+vXDZMVFkohhQRiG/F7bCO4488sn/2yrTiTZyt9cxMOcP
 dpLg8hQHb2vLyi3H8uCYXqbtCQkbS9KUlz3YaDA==
X-Google-Smtp-Source: AGHT+IHxghJHNpmxBV4+PCTL1UadEO2gfpn43Bqbz/S7XBQmhclnF/mV+S36Fuefas/uYFum05C6Q05AjS02KPbH9IA=
X-Received: by 2002:a2e:9545:0:b0:2d6:db57:83c1 with SMTP id
 t5-20020a2e9545000000b002d6db5783c1mr92488ljh.35.1711549065984; Wed, 27 Mar
 2024 07:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
 <CAByghJY17Z42heuQiAruJPHKpQ-3_Ge-bqt70LC3g+2M7dAyvg@mail.gmail.com>
In-Reply-To: <CAByghJY17Z42heuQiAruJPHKpQ-3_Ge-bqt70LC3g+2M7dAyvg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Mar 2024 16:17:09 +0200
Message-ID: <CAC_iWj+Uq0NZhBKuAbbM5asvUuTBku0OZDSu+b68rtqNFqFCDA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] TEE: minor cleanup
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Igor,

On Wed, 27 Mar 2024 at 14:13, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> Ilias,
>
> On Mon, Mar 4, 2024 at 6:45=E2=80=AFPM Igor Opaniuk <igor.opaniuk@gmail.c=
om> wrote:
>>
>> - Address some spelling errors and typos
>> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
>> - Remove common.h inclusion for drivers/tee
>> - Add calls for closing tee session after every read/write operation.
>>
>> CI build:
>> [1] https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=3D28=
&view=3Dresults
>>
>> Changes in v3:
>> - Added calls for closing tee session after every read/write operation
>>
>> Changes in v2:
>> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'mem=
set'
>> - Applied R-b and T-b tags
>>
>> Igor Opaniuk (6):
>>   tee: optee: fix description in Kconfig
>>   tee: sandbox: fix spelling errors
>>   cmd: optee_rpmb: close tee session
>>   cmd: optee_rpmb: build cmd for sandbox
>>   test: py: add optee_rpmb tests
>>   tee: remove common.h inclusion
>>
>>  cmd/Kconfig                        |  4 +++-
>>  cmd/optee_rpmb.c                   | 23 +++++++++++++++++------
>>  drivers/tee/broadcom/chimp_optee.c |  3 ++-
>>  drivers/tee/optee/Kconfig          |  2 +-
>>  drivers/tee/optee/core.c           |  1 -
>>  drivers/tee/optee/i2c.c            |  1 -
>>  drivers/tee/optee/rpmb.c           |  1 -
>>  drivers/tee/optee/supplicant.c     |  2 +-
>>  drivers/tee/sandbox.c              | 10 +++++-----
>>  drivers/tee/tee-uclass.c           |  1 -
>>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
>>  11 files changed, 49 insertions(+), 19 deletions(-)
>>  create mode 100644 test/py/tests/test_optee_rpmb.py
>>
>> --
>> 2.34.1
>>
>
> Are there currently any comments/objections that can prevent these cosmet=
ic
> changes from being applied? CI is happy now and all tests are passing suc=
cessfully.
>
> If there are any - just let me know, thanks

IIRC I did run this version on the CI and everything looked fine. I'll
send a PR to Tom with it -- apologies for the delay

Regards
/Ilias
>
> Regards,
> Igor
>
> --
> Best regards - Atentamente - Meilleures salutations
>
> Igor Opaniuk
>
> mailto: igor.opaniuk@gmail.com
> skype: igor.opanyuk
> https://www.linkedin.com/in/iopaniuk
