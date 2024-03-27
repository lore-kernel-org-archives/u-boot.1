Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EDFC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05E3788103;
	Wed, 27 Mar 2024 13:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9pcuaDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 746BF88104; Wed, 27 Mar 2024 13:13:23 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35C728802E
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-341bba83366so1255149f8f.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711541600; x=1712146400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+gZ4iu/vVwiITKdl8KYk5d/fpc7a1F4/PZY2RN7HCX4=;
 b=O9pcuaDskzoQyyFyljf4yj2GnrNGOMq/lFHfnOytMu2XK9zLFu+9Qo8zBYBrmhuw4p
 HpNjsmu/oeCkJxCaAtaNf9HgpA2dkL8X4od9tXxESGDZHOybBgTvFKhL6cWPkD+430JT
 NSWASRU8R6E8cTTa/OlxTLLC6kWDURE6mPKu6Udun/CY+1KXyCmD9NZCcCd7RvZhC/NH
 0p0Rvfmwf0kGmCMZEOY3hgMDXjHKluqi6imdDylQdRE4cXg003TfcsrQMY56P/Vrt4FH
 OLAw2HK9M2jQOCm8IH6r8WPCmJgPFGjiFe3WShZ/sg/U3WXOTWTyTlQkfJz8dYxEaVAn
 Bl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711541600; x=1712146400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+gZ4iu/vVwiITKdl8KYk5d/fpc7a1F4/PZY2RN7HCX4=;
 b=a/NVlg9ERil8zza36JcQidSBP2cpOXMLC+7l+MCQ4+Q2usolZxrD/EkZLlQytou4hl
 gQQKTekNNPvHSYbelf80hOXfGeVIamacbNYE8H5rjxhxJRgkZEEonh6d/yfF5DypWUz5
 0jVdA0RhjbKUP74S74luHDX+Q28l62f9oocZGweEQ3oY3H3PVqk8IEuEMSjaM7FBtqrc
 E9ZF4cQ30lwEF8cSy1D48z2ZkCc4zzsDa/SagxnJfx0ubijvPDi+UhXk0IVStTFpspHF
 R8MAZ4mDaDYPeJ1CFivnaZy0uJIB8lNyhmo5VEC88cJK5t0b+RqGb8SKWSIp6Wc2KNtj
 yKwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfqPiltt79KgkByZcqSHUPeBaiSJlYStXD8gZ1vlf+AKkz0KcprhRnlq+QIKhXu/FzlZW4STfj+nGdfh6G+baHi8WfmA==
X-Gm-Message-State: AOJu0YxI4UCAszdtYWKOtAKXS7adHyWAeAkUuFEpvXL1j6T9Zx+kBD0F
 g+PjJI67PQqOldcepe1TUS7qd09yJo8FoIm2bHTAJiHm3CIG0eZkc+crqph5E+OAZxBNoRdnHje
 heuY5eDOxMUlJay2cBtICDFJg3OQ=
X-Google-Smtp-Source: AGHT+IEWjYzT9BZcCmHxNyq5hKAs14GkQS1nnqjRrf7kr47zrtp7t0MlJDbiPpY96Ec6Aws/3OXqo0Ser7xsygzUF1Y=
X-Received: by 2002:a5d:6147:0:b0:33e:cf2f:b0 with SMTP id
 y7-20020a5d6147000000b0033ecf2f00b0mr8826178wrt.3.1711541600235; 
 Wed, 27 Mar 2024 05:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
In-Reply-To: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 27 Mar 2024 13:13:08 +0100
Message-ID: <CAByghJY17Z42heuQiAruJPHKpQ-3_Ge-bqt70LC3g+2M7dAyvg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] TEE: minor cleanup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Ilias,

On Mon, Mar 4, 2024 at 6:45=E2=80=AFPM Igor Opaniuk <igor.opaniuk@gmail.com=
> wrote:

> - Address some spelling errors and typos
> - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python tests
> - Remove common.h inclusion for drivers/tee
> - Add calls for closing tee session after every read/write operation.
>
> CI build:
> [1]
> https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=3D28&view=
=3Dresults
>
> Changes in v3:
> - Added calls for closing tee session after every read/write operation
>
> Changes in v2:
> - Fixed chimp_optee.c:37:9: error: implicit declaration of function
> 'memset'
> - Applied R-b and T-b tags
>
> Igor Opaniuk (6):
>   tee: optee: fix description in Kconfig
>   tee: sandbox: fix spelling errors
>   cmd: optee_rpmb: close tee session
>   cmd: optee_rpmb: build cmd for sandbox
>   test: py: add optee_rpmb tests
>   tee: remove common.h inclusion
>
>  cmd/Kconfig                        |  4 +++-
>  cmd/optee_rpmb.c                   | 23 +++++++++++++++++------
>  drivers/tee/broadcom/chimp_optee.c |  3 ++-
>  drivers/tee/optee/Kconfig          |  2 +-
>  drivers/tee/optee/core.c           |  1 -
>  drivers/tee/optee/i2c.c            |  1 -
>  drivers/tee/optee/rpmb.c           |  1 -
>  drivers/tee/optee/supplicant.c     |  2 +-
>  drivers/tee/sandbox.c              | 10 +++++-----
>  drivers/tee/tee-uclass.c           |  1 -
>  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
>  11 files changed, 49 insertions(+), 19 deletions(-)
>  create mode 100644 test/py/tests/test_optee_rpmb.py
>
> --
> 2.34.1
>
>
Are there currently any comments/objections that can prevent these cosmetic
changes from being applied? CI is happy now and all tests are passing
successfully.

If there are any - just let me know, thanks

Regards,
Igor

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
