Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39F3CAC5A0
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1323B83642;
	Wed, 17 Sep 2025 17:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vo95CaTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB428365C; Wed, 17 Sep 2025 17:54:22 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B90383631
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso4392b3a.2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758124458; x=1758729258; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UM0nyEGmYnxrzpF8oXE9UjtJq4+OVLyIC1FeFoo0xSA=;
 b=vo95CaTDTHawOfBVDb1B6+YBpKpmKJaoqQLrGvsw+eAyl0BBhu7tSn6UJGY/0NCe59
 HX72tHDi+IbCThCVz7/j7pB8mOoNGzrYoPhVUL7Y4JgvIZwgIYrC7PE/7G+bF9nM+51T
 qPLlfuXq4JVzAcXnWS8xBkQN2Fql5JQkcI70mIWhOCEckyEyHFlca4kxnPMqxdDLp0nb
 sL0ccgnpLD5+UyfeC/b2vzA0aWtRwzbSim0q6Bk+MUqJ4ctlbCO+urTKGKJuY3oipAFj
 e0/QaFNfcSPl4zRYHFMJfe2cm/F3P/tL0p5zhNJ/YUWAhgkDliiVkCcoOuBvMUydoDD1
 VPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124458; x=1758729258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UM0nyEGmYnxrzpF8oXE9UjtJq4+OVLyIC1FeFoo0xSA=;
 b=HNutEuxfjkytsD+iiyFYNMHDWNOCECZTZBXPjK7iyPH1pSbxCDm9V2Un8/PtdtCfxu
 Cy0gtPIi0czuJv4/Q8Gz2Mafd4XYqBhmFyAWLe3d3V0+5rkTiCUMCDJd4cAw5fY7Ocyo
 2dlkKaggMvC180w3gMl3ZM5uMvBFryT+5W4D6UvsuUIOjpV5QzBb5kmAjfSm0MsO7QsU
 RFg62MpGOw03+N9+HFCYcbF2jXLKkP5a+56l4VzOXkKDkPs6iibFJARQ3hcFm9xtd9VQ
 HKWXkuaPFkpDJX9RWdN3N3gXSMXQNg3JhpZYT9NVjLarRxsGo7jQrSDhaS5etKXlsiBm
 +luA==
X-Gm-Message-State: AOJu0YyrQpWzYXOEsb3P1MimWXANN2EZbnqpjmaKyCaaC0Bb7RdBIesB
 HbZ7KQfwxmTllHNyiESxyXmrT0iGOI+2xE8A3SgNM94wVAtPRLdNqL4Sm+m1RSv3UojZlCTp/g9
 mrIfuxanU8fCmCG6HApgUQn3OXtkAadggQh931XX6QA==
X-Gm-Gg: ASbGncvAqJUch8SU36f4nWWYEZcpJV9Sufzq5b6ktQ6HAfUzZo86nBTZbYw3b1WpHdD
 lMTvNfqw/DfDYS9Y+wmN7heVy/jE8f0733OhBFCqTRctdnJ10gUAYgCyghHh7A8NKZL2i8JthbV
 f1FFdGXeLgzYz4dkFFQB8RFR/A10UXGnzB7WLVr4B5kebRdpItiVLAwggST6scryUjh9+b2c2VV
 o79nmEAMA==
X-Google-Smtp-Source: AGHT+IE7HucQ+x2wIlR4mE13K6MS1Gr/EyHlIBciR8GFR/fvTFeUuH2j/f5UYG2b1xz8HWgSDSbgyKwIbFePZ+/DYkA=
X-Received: by 2002:a05:6a20:a108:b0:277:f962:3163 with SMTP id
 adf61e73a8af0-27a94827d99mr4164876637.19.1758124458492; Wed, 17 Sep 2025
 08:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-4-raymond.mao@linaro.org>
 <20250916182747.GA124814@bill-the-cat>
In-Reply-To: <20250916182747.GA124814@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 17 Sep 2025 11:54:08 -0400
X-Gm-Features: AS18NWBqqRyMipQdxJ1n8g5GhuMD0ZDoRuy66C73JEO-cUk8gW15FTMAn8SCpvY
Message-ID: <CAEfUkUKX6zM+=R4s9UOQAmDho-V9UULvky0rG7H1CVj6uJCy9g@mail.gmail.com>
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

On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 16, 2025 at 09:14:19AM -0700, Raymond Mao wrote:
> > Add test cases to validate FDT and TPM eventlog handoff from TF-A
> > and OP-TEE via bloblist.
> >
> > For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> > OP-TEE indicates a successful handoff.
> >
> > For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
> > and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> > successful handoff.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> >  create mode 100644 test/py/tests/test_fw_handoff.py
> >
> > diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/test_fw_handoff.py
> > new file mode 100644
> > index 00000000000..4cdf51a4375
> > --- /dev/null
> > +++ b/test/py/tests/test_fw_handoff.py
> > @@ -0,0 +1,94 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +#
> > +# Copyright (c) 2025 Linaro Limited
> > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > +#
> > +# Validate Firmware Handoff from TF-A and OP-TEE
> > +
> > +import pytest
> > +import re
> > +
> > +def _norm_ws(s: str) -> str:
> > +    """Normalize whitespace for robust comparisons."""
> > +    return re.sub(r"\s+", " ", s).strip()
> > +
> > +@pytest.mark.buildconfigspec("bloblist")
> > +@pytest.mark.buildconfigspec("cmd_bloblist")
> > +@pytest.mark.buildconfigspec("of_control")
> > +@pytest.mark.buildconfigspec("cmd_fdt")
> > +def test_fw_handoff_dt(ubman):
> > +    """Validate FDT handoff via bloblist."""
> > +
> > +    if (ubman.config.board_type != 'qemu_arm64' or
> > +        ubman.config.board_identity != 'fw_handoff_tfa_optee'):
> > +        pytest.skip("Test only for qemu_arm64 with ID fw_handoff_tfa_optee")
>
> This (and the other tests) should be more pytest.mark.buildconfigspec
> but for TARGET_QEMU_ARM_64BIT and then relevant TF-A/OP-TEE options. And
> even then, possibly just the relevant TF-A/OP-TEE options as it should
> work on other platforms too, yes? Thanks.
>
Just like what you commented to my test-hooks patches, if we can merge
and use a general conf qemu_arm64_na, the check for the board ID is no
longer needed.
But still this is for qemu_arm64 only, since the TF-A driver is
platform-dependent, thus the feature currently only works on a few
platforms.

Raymond

> --
> Tom
