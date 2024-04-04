Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761BACD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13BA8801A;
	Thu,  4 Apr 2024 09:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HlXFbcrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3C8988044; Thu,  4 Apr 2024 09:22:15 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D4EF87F2D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56bf6591865so886754a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712215333; x=1712820133; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+L4qlF2QqHMP40Q27yn1cuK/1KvNz0frfaBn96uTKTk=;
 b=HlXFbcrlxWNmqUh6mwUFGX3FbmQIK1TOhiMOsywfjLNLoI6NVPHIXGZrR1PbFfroZ9
 h+LWUUbPhkuN3xbBj6KKUta8nteCU3JDoJ66DyLLy1Rl1NZEwgy6uSiKHbQIbLfyl5HC
 JkNgxFxSdzKtRKP6lMkYhHvKeU8XxnbfTDmc9YyqH8u5HWO+yeTJLl/cSbZsJirXGHk3
 zQ38NQYbRqb1v67O61zovEE4IOq3yL2dUUz+wnwyq3Lu1F6ltBmptF33LwiIjLoznmde
 4nu88g7OLI17MMO3/GR2LHhP0GVeftIUyXzGuJnovO4jxaV6MN56KEAH64jfNPC+sfUN
 TOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712215333; x=1712820133;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+L4qlF2QqHMP40Q27yn1cuK/1KvNz0frfaBn96uTKTk=;
 b=J3UoIgbKzvdprPm11GhKjQR6+pwWk8Cgz2rS+zDmqtBH6qBDA5YMvXTLeic1pqmzk9
 XJuLBZoL1/5mae6RrDfKk1heCw00xQOjPGNCsX5CVTEdnno1VAXpBk8qWp5GJ0ClJKvG
 B1sfVMupziBKC9/1akuDj7WczSCDGL7fjmP2SMcTr+HzCKhw5rlCS4YDF+z90MVsAFlq
 HejbT5GHW1hkKl+y1YiXh0BKv97HVafD2b9nKUsiXficekj/8cQBMb0iA/qzKTAKOXKL
 Msxmjch4KanOWtMeCSIhlkLXgz35eDSOJz4mZdAVU7IZ5Oqoda0VXz0/oWicKHNXhbZR
 Tsrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQDBCsFMrjwz/tvqoU4jt4KKWBHdGzrtvsYzwfa3yYU3s6vHWmOprwMoykHdTkGe6XxBR8J30e3DnvgNH3DS+oKRB41w==
X-Gm-Message-State: AOJu0YxrLOpiazX9jO88wxmV6Nvs9whODsR+NPJk+qbsX+/IwuuydPlK
 0sjbKsJSFYDm5TG8lOtwzYX9TQE9vshVMIL/3YWhP67P6/3OsRkfQnToIYhHC2g=
X-Google-Smtp-Source: AGHT+IFXzqySWd55Kc6Rf3LIVV54T1BOW5DGuuaf1zajEPYda7Dr1s+O2Vm724BUY5G3AHVhtis/wQ==
X-Received: by 2002:a50:d696:0:b0:56c:5990:813e with SMTP id
 r22-20020a50d696000000b0056c5990813emr935195edi.13.1712215333098; 
 Thu, 04 Apr 2024 00:22:13 -0700 (PDT)
Received: from hera (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 ig10-20020a056402458a00b0056c0a668316sm1827108edb.3.2024.04.04.00.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 00:22:12 -0700 (PDT)
Date: Thu, 4 Apr 2024 10:22:09 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/6] TEE: minor cleanup
Message-ID: <Zg5VIfnPElreq3ls@hera>
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
 <CAByghJY17Z42heuQiAruJPHKpQ-3_Ge-bqt70LC3g+2M7dAyvg@mail.gmail.com>
 <CAC_iWj+Uq0NZhBKuAbbM5asvUuTBku0OZDSu+b68rtqNFqFCDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWj+Uq0NZhBKuAbbM5asvUuTBku0OZDSu+b68rtqNFqFCDA@mail.gmail.com>
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

I tried to apply this to master and send a PR, but unfortunately it needs
rebasing. Can you rebase it and resend it?

Thanks
/Ilias
On Wed, Mar 27, 2024 at 04:17:09PM +0200, Ilias Apalodimas wrote:
> Hi Igor,
>
> On Wed, 27 Mar 2024 at 14:13, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
> >
> > Ilias,
> >
> > On Mon, Mar 4, 2024 at 6:45 PM Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
> >>
> >> - Address some spelling errors and typos
> >> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
> >> - Remove common.h inclusion for drivers/tee
> >> - Add calls for closing tee session after every read/write operation.
> >>
> >> CI build:
> >> [1] https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=28&view=results
> >>
> >> Changes in v3:
> >> - Added calls for closing tee session after every read/write operation
> >>
> >> Changes in v2:
> >> - Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'
> >> - Applied R-b and T-b tags
> >>
> >> Igor Opaniuk (6):
> >>   tee: optee: fix description in Kconfig
> >>   tee: sandbox: fix spelling errors
> >>   cmd: optee_rpmb: close tee session
> >>   cmd: optee_rpmb: build cmd for sandbox
> >>   test: py: add optee_rpmb tests
> >>   tee: remove common.h inclusion
> >>
> >>  cmd/Kconfig                        |  4 +++-
> >>  cmd/optee_rpmb.c                   | 23 +++++++++++++++++------
> >>  drivers/tee/broadcom/chimp_optee.c |  3 ++-
> >>  drivers/tee/optee/Kconfig          |  2 +-
> >>  drivers/tee/optee/core.c           |  1 -
> >>  drivers/tee/optee/i2c.c            |  1 -
> >>  drivers/tee/optee/rpmb.c           |  1 -
> >>  drivers/tee/optee/supplicant.c     |  2 +-
> >>  drivers/tee/sandbox.c              | 10 +++++-----
> >>  drivers/tee/tee-uclass.c           |  1 -
> >>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
> >>  11 files changed, 49 insertions(+), 19 deletions(-)
> >>  create mode 100644 test/py/tests/test_optee_rpmb.py
> >>
> >> --
> >> 2.34.1
> >>
> >
> > Are there currently any comments/objections that can prevent these cosmetic
> > changes from being applied? CI is happy now and all tests are passing successfully.
> >
> > If there are any - just let me know, thanks
>
> IIRC I did run this version on the CI and everything looked fine. I'll
> send a PR to Tom with it -- apologies for the delay
>
> Regards
> /Ilias
> >
> > Regards,
> > Igor
> >
> > --
> > Best regards - Atentamente - Meilleures salutations
> >
> > Igor Opaniuk
> >
> > mailto: igor.opaniuk@gmail.com
> > skype: igor.opanyuk
> > https://www.linkedin.com/in/iopaniuk
