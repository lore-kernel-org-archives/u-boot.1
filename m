Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE4ACAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 15:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C710581E13;
	Thu, 18 Sep 2025 17:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oa3+8DyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B93182ADA; Thu, 18 Sep 2025 17:05:40 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7523F80B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b4c1fc383eeso750403a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 08:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758207936; x=1758812736; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K/AUmY9mLHNPBXaus4TsM31G34aYZCW9i8lmY311XFk=;
 b=oa3+8DyZgFn4m9S6W1XeEAvlj7XBvsoFZhjfgMBdzPv5oB1YnRulVNzQizI9wXFd0j
 ryrJ6uDVmBICot3ZppbTolDv2z8qUGLJeC8PNOcPdRoOEyX9YtVB9KJ0tB9cydEuPTg+
 E72bnNY/rkxb+ZWMcOhDGgYfP2u1DybbpourUk+oFaI6gKhudV3lvZq1rhr5ZL31fy2I
 jikfwnVqc3EruC7cIt49YVyKCGriqNvfVVjsKsjHMEmrWcQU4E7ICSF2T78k/6e/pgks
 nou78Q4OWsSopdgqztMB4N0NZCrXRe+93GAPWNNHQWBGTHFofD/Q92/oT3H5fcbUW3zq
 QXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758207936; x=1758812736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/AUmY9mLHNPBXaus4TsM31G34aYZCW9i8lmY311XFk=;
 b=O6LMXNNzqSXOzaYQbjYmXk3w+jxXse66PUGrj3kiOjq3KD6RbYf6OZIEyKsvj/O6UR
 OT2VI0RH8L8Sqf/kJ1jWv16qfYAnl1PShrd/bkoy+5IaCZVJ0i2GGPAjjmYnZ1amxnvw
 5/F8HDTE0HzhoXthH4kMMopV5mjbtOP7sFvd/HTb60V27SBDRLmZQ3NJht39hZw6euZV
 QI7ZM/IJ08v5avnIzXj3TZfs4ZVCV2O0b6UAwDpiQ4fxUhD+K0qAM6rm6jizvitICiDs
 kuHNIFwZ7GKTnAlF6Fm1MxSDFcsKMuJTMKJNKhTESpq77nJgpvSWgqnqmsLsBLtREn0S
 Y75Q==
X-Gm-Message-State: AOJu0Yw7nOgZHCgAtkhhHctIEQ7Qw4INEJhH1KtQYyPf2Yg7sAu1IsGu
 w7vuJPNo6BVKLrxpCbUYJbfVA2B5J86Jak3GelHqlhXCJRNnyF7ouwA+TlFX8ta0JPN7O5c6Z59
 IYHs3sdqYYWKho05WdUzQYNLR8bQy83u5GJIhwnvnyQ==
X-Gm-Gg: ASbGncvu3sDAfrYQpKoim5i079mRndRmTgfNg4AIowP8RvnNKlVEwnPTplsfmBdqp6Z
 RAmBFlvNbxHcvYaSGRpqP2YGkhS70yefq9kciLLNRgIATc7nLe7s9B47oOR5b2pFAKfJ+ipO5Pc
 H4DJhkPSgVPNm2F0LOYeK1stSbmy3L6VT+QO7Q9Rxdc8jex5/1lNS+4VHJqNodV6vKH7/cDgPKJ
 suMJT3XWv539B98fQSdjILUkgdx
X-Google-Smtp-Source: AGHT+IGBKQ4GMdV4LPacW5otkENpU5OWEYkd5PNwBEM4R2dOWKNKmy0HUSLVsHkxjJs0UrNRdpGZSVA/M6UD8LtU2JM=
X-Received: by 2002:a17:902:f682:b0:269:aba0:f0a7 with SMTP id
 d9443c01a7336-269aba0fe75mr13910545ad.2.1758207935608; Thu, 18 Sep 2025
 08:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-4-raymond.mao@linaro.org>
 <20250916182747.GA124814@bill-the-cat>
 <CAEfUkUKX6zM+=R4s9UOQAmDho-V9UULvky0rG7H1CVj6uJCy9g@mail.gmail.com>
 <20250917174612.GN124814@bill-the-cat>
In-Reply-To: <20250917174612.GN124814@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Sep 2025 11:05:25 -0400
X-Gm-Features: AS18NWC_oZL6lwrL97EiEItCs68lA0BQOQFgOVu0XwTRjVJJwOuUEiYnbU26jYE
Message-ID: <CAEfUkUL_YzG41ta=2XRv_XWY8A43ZZ9aX3Fci6f9D0zjoDjwzw@mail.gmail.com>
Subject: Re: [PATCH 3/5] pytest: add test script to validate Firmware Handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

On Wed, 17 Sept 2025 at 13:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 17, 2025 at 11:54:08AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Sep 16, 2025 at 09:14:19AM -0700, Raymond Mao wrote:
> > > > Add test cases to validate FDT and TPM eventlog handoff from TF-A
> > > > and OP-TEE via bloblist.
> > > >
> > > > For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> > > > OP-TEE indicates a successful handoff.
> > > >
> > > > For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
> > > > and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> > > > successful handoff.
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > ---
> > > >  test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++++++++++++
> > > >  1 file changed, 94 insertions(+)
> > > >  create mode 100644 test/py/tests/test_fw_handoff.py
> > > >
> > > > diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/test_fw_handoff.py
> > > > new file mode 100644
> > > > index 00000000000..4cdf51a4375
> > > > --- /dev/null
> > > > +++ b/test/py/tests/test_fw_handoff.py
> > > > @@ -0,0 +1,94 @@
> > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > +#
> > > > +# Copyright (c) 2025 Linaro Limited
> > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > +#
> > > > +# Validate Firmware Handoff from TF-A and OP-TEE
> > > > +
> > > > +import pytest
> > > > +import re
> > > > +
> > > > +def _norm_ws(s: str) -> str:
> > > > +    """Normalize whitespace for robust comparisons."""
> > > > +    return re.sub(r"\s+", " ", s).strip()
> > > > +
> > > > +@pytest.mark.buildconfigspec("bloblist")
> > > > +@pytest.mark.buildconfigspec("cmd_bloblist")
> > > > +@pytest.mark.buildconfigspec("of_control")
> > > > +@pytest.mark.buildconfigspec("cmd_fdt")
> > > > +def test_fw_handoff_dt(ubman):
> > > > +    """Validate FDT handoff via bloblist."""
> > > > +
> > > > +    if (ubman.config.board_type != 'qemu_arm64' or
> > > > +        ubman.config.board_identity != 'fw_handoff_tfa_optee'):
> > > > +        pytest.skip("Test only for qemu_arm64 with ID fw_handoff_tfa_optee")
> > >
> > > This (and the other tests) should be more pytest.mark.buildconfigspec
> > > but for TARGET_QEMU_ARM_64BIT and then relevant TF-A/OP-TEE options. And
> > > even then, possibly just the relevant TF-A/OP-TEE options as it should
> > > work on other platforms too, yes? Thanks.
> > >
> > Just like what you commented to my test-hooks patches, if we can merge
> > and use a general conf qemu_arm64_na, the check for the board ID is no
> > longer needed.
> > But still this is for qemu_arm64 only, since the TF-A driver is
> > platform-dependent, thus the feature currently only works on a few
> > platforms.
>
> My point is that if a platform enables the correct U-Boot options (and
> only would if the rest of the firmware stack supported it, yes?) then
> this test should also run correctly. Right?
>
In U-Boot, Firmware Handoff is sharing the BLOBLIST kconfig, and with
two prerequisites for a "handoff via bloblist" happen:
1. BLOBLIST is selected.
2. Registers are carrying a bloblist compliant to Firmware Handoff
plus expected conventions.

But a platform selecting BLOBLIST does not necessarily enable Firmware
Handoff - Simon designed the bloblist with other purposes other than
handoff.

Regards,
Raymond

> --
> Tom
