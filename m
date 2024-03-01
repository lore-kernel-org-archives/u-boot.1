Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2BCC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 09:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7979888128;
	Fri,  1 Mar 2024 10:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zklWQgdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F07188129; Fri,  1 Mar 2024 10:41:29 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CC288126
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 10:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d204e102a9so18634621fa.0
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 01:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709286086; x=1709890886; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwn7rij1IGl4y5rf8+A8zesMejg3jQlb2cfcXixUJ0c=;
 b=zklWQgdBAuLVZtmg/p4yHYqhNs8/n0LsnCPIO2ZWghWeduY971up4TPmEjhmFgk7q4
 K/9y+KENWLjanmWelO4AF/clL0Mzzxat4axvr6VtdtH8rqfGq8U+/+op5qLybjwkrs5h
 Gi14TlGZiTU+xxrpGYrgDiAb3l8IJ47PPQI70X0aiI/qHkgGXM7E2GNlB/pbDuvc4nmd
 Fzt94ertMSVeVSPjmjnr9sypOTUx1ANTtHNXLr2lrxvg4F0I6DiA2jKDWW2jZhnzQSpZ
 fANH2VXup3K+36nci/BBaALvLsJVu6BK3V/85uRlgOrBshVBidA7J8Rt4rwyYoYqYn4w
 /PHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709286086; x=1709890886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwn7rij1IGl4y5rf8+A8zesMejg3jQlb2cfcXixUJ0c=;
 b=va1pGSTtidBeLSE/e6cYlJMFH4dvcVNdY41ZNLqe17o/yWsnVH9NXxXWiRNUnlCWww
 pQMowoMWN1ozqPgB/Kjt9B5CeTJk9WoQv8wGNFakbS1ZT97WRcgjUvZFSoqziVIka25G
 rHBwQm6DWKSNZBMQjHO/9gMiaFYh5vlJP5Qp9NxbsYwcAIDg0gt1vpFz1+0dSuE96/rR
 0eboNuITA+89M12DoZ795d4wI9ggxhyw1uZConQ5dR2XvZpqiC4MXRr5aT0S/7rX1aef
 W+h/x0n9lp/pFJ9Qe+fcmR9cMIuD+F+3MdIE/Y3UuBhDM6eerFZSfshhWJTdnvpiY36R
 IBsA==
X-Gm-Message-State: AOJu0YwVqsJl4XdIwJv6nVgi8qcY6uTSCvIihwD9hKbs4LNzkKDjUtPo
 sitmHZRCbKvMlbwk/dAtQ4WHSqa9K2D+E6aSsLRaIHW90t6cWiYoqBRfdpzNIO3rjKetxkOUc2p
 5KD64o4NEMH+IssheZD6vcFoCcfH7kOBoRhSn2g==
X-Google-Smtp-Source: AGHT+IH15NkqJg+cWOXdLSDhkKfQcb27kqKJm7qSiQlAw+mFyEwq/dS4paFdbVRG67A2PW7ei7b7tRG5A1O6ZQrgyLk=
X-Received: by 2002:a05:6512:304f:b0:513:3429:88f8 with SMTP id
 b15-20020a056512304f00b00513342988f8mr464189lfb.68.1709286085842; Fri, 01 Mar
 2024 01:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <CAByghJY_Eyf6s=V+5Hjo1gVxkzCPieABkk_NpFK5HM_K=SE_+g@mail.gmail.com>
In-Reply-To: <CAByghJY_Eyf6s=V+5Hjo1gVxkzCPieABkk_NpFK5HM_K=SE_+g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 11:40:49 +0200
Message-ID: <CAC_iWjJv-v0pu9cZza0WghJ-rPJdD8Lmng_ms7d17a=K4nSzjw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] TEE: minor cleanup
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
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
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 29 Feb 2024 at 21:11, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> Hi Ilias,
>
> On Wed, Feb 14, 2024 at 7:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundr=
ies.io> wrote:
>>
>> - Address some spelling errors and typos
>> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
>> - Remove common.h inclusion for drivers/tee

CI fails on https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines=
/19780
Can you have a look?

Thanks
/Ilias
>>
>> Igor Opaniuk (5):
>>   tee: optee: fix description in Kconfig
>>   tee: sandbox: fix spelling errors
>>   cmd: optee_rpmb: build cmd for sandbox
>>   test: py: add optee_rpmb tests
>>   tee: remove common.h inclusion
>>
>>  cmd/Kconfig                        |  4 +++-
>>  drivers/tee/broadcom/chimp_optee.c |  2 +-
>>  drivers/tee/optee/Kconfig          |  2 +-
>>  drivers/tee/optee/core.c           |  1 -
>>  drivers/tee/optee/i2c.c            |  1 -
>>  drivers/tee/optee/rpmb.c           |  1 -
>>  drivers/tee/optee/supplicant.c     |  2 +-
>>  drivers/tee/sandbox.c              | 10 +++++-----
>>  drivers/tee/tee-uclass.c           |  1 -
>>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
>>  10 files changed, 31 insertions(+), 13 deletions(-)
>>  create mode 100644 test/py/tests/test_optee_rpmb.py
>>
>> --
>> 2.34.1
>>
>
> Are there currently any comments/objections that can prevent these cosmet=
ic
> changes from being applied? If there are - just let me know, thanks
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
> http://ua.linkedin.com/in/iopaniuk
