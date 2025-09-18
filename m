Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480E4CAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 22:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54153829E7;
	Fri, 19 Sep 2025 00:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wHZ4Qrdn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDE582C84; Fri, 19 Sep 2025 00:44:29 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CC5800D7
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 00:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b54f57eb7c9so858008a12.3
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 15:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758235464; x=1758840264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F0rB3Ar4+luMEc6UBZsOFlc2NUdsx//bcfVko4qwWB4=;
 b=wHZ4QrdnXkx9Dljs5b2sj0GpI990/ApB0rbepbQ22Ip7eIkfKqv8z3rcjSvyGQ2JYx
 CDw4MmHL8Iks6yMFT9960L6Wy+SWokx1m8LjFaYj5cqzRectqQXnN6/OXnVdpTFNG8/k
 mlR7I1iccR5imfltqOiyNm2tNy7d9y8QXnHqdB6xr7CdrJLmmWE9UjD2QxKqZX3TxHZV
 VQ9OcVxSxidXA50x4WWu4gYavg74H8y4xBZLPJvvpHeFjJOysY479rNrvWfnUnPByWIG
 YMRVnWx0LZknUzv4gQBtDr9xC6G2hdzt7oQmKogDN4ImhTLPMc04mVKx1+zn3ggoE2u8
 hkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758235464; x=1758840264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0rB3Ar4+luMEc6UBZsOFlc2NUdsx//bcfVko4qwWB4=;
 b=HY+Yq+0nXI7NpdY4bYs4zLWTpjNo4D20HXC737h8PBFyFF4f7PIe01QRJl18KJmQcK
 fxWG40jpBWBu3Pve56cWPjJJSaRNqGOpaSu2b/ajBC6RxkRWJogg/DcLa+wtUb+OYjIo
 +PcM7zsq6/vV9Mbns5OUxJbEaVjK2hiy74vy/F8xZdP2U75u+FRj4Kz1P8lrLFy4JgKA
 aPuB6hCYV667lwcNPcf0Dbf0wPZQ7F//ql2/nrgaMHobKIYdvbu7tC42IsHm/DVfEI/M
 GKqxA9EZZTuYKTyJHHY9rO8OfaEukK0DwaJM9cUH+/+HVY8Pg6+q5BANxd8H36lQx+k6
 RzKw==
X-Gm-Message-State: AOJu0Yx/GqdICjHJns/KO6SJzl3a3iHo3q4zYzH3t7ra48h1I1M/0dh9
 CWgcgJvTtmhnszyRnDR78e/5FcP55VdiRG0thzelra4HKQoieGGeAVa212AAcP4Rz1As7DBJRAD
 i6G+MAFOxO2KlzKClesbc4JeB97/huP95hmvWHDvOkg==
X-Gm-Gg: ASbGncvZOqALUHyLISh5klR0ScQ6nVWhgg/oRGZla+HRMxU95LTu9v8szb5NhLOveNc
 IC/mQqsMHCFETx1JpSCphMj2YmJYfzgFnpZKL+LMIdIgZJyQVcCd/2AQomccPv8/VTeVP6wqZUW
 68mNcPjkf1Pg3p0m/cbZiLn4bGxHMn0yCp73lBk5CZYOQRNw5p/NBjl3YOstHRXpyHLy3RniSex
 0McM12f8Da83mVsR+jznWtF7Qyh
X-Google-Smtp-Source: AGHT+IFfu3k8/vJNN9x8tA2PD2SiChe02Pc2EtTOTX6Nz4Y0IA1b4KXssYULplaJb5rWDdrU6a0rzPmCCu/Gu0w2R2o=
X-Received: by 2002:a17:90b:3fd0:b0:330:852e:2bcc with SMTP id
 98e67ed59e1d1-3309834e1f2mr1051955a91.21.1758235464081; Thu, 18 Sep 2025
 15:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-4-raymond.mao@linaro.org>
 <20250916182747.GA124814@bill-the-cat>
 <CAEfUkUKX6zM+=R4s9UOQAmDho-V9UULvky0rG7H1CVj6uJCy9g@mail.gmail.com>
 <20250917174612.GN124814@bill-the-cat>
 <CAEfUkUL_YzG41ta=2XRv_XWY8A43ZZ9aX3Fci6f9D0zjoDjwzw@mail.gmail.com>
 <20250918200919.GO124814@bill-the-cat>
In-Reply-To: <20250918200919.GO124814@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 18 Sep 2025 18:44:14 -0400
X-Gm-Features: AS18NWBTOjQ66y-UtcehMz8pStQLgGf6VwS_m0IPEZXtslpcuVVNhIfuU_hqkEs
Message-ID: <CAEfUkULbRavxp+xd8TDwihRk6tVGxicgd0oeDxs9wZSdudBzNA@mail.gmail.com>
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

On Thu, 18 Sept 2025 at 16:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 18, 2025 at 11:05:25AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Wed, 17 Sept 2025 at 13:46, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Sep 17, 2025 at 11:54:08AM -0400, Raymond Mao wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Sep 16, 2025 at 09:14:19AM -0700, Raymond Mao wrote:
> > > > > > Add test cases to validate FDT and TPM eventlog handoff from TF-A
> > > > > > and OP-TEE via bloblist.
> > > > > >
> > > > > > For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> > > > > > OP-TEE indicates a successful handoff.
> > > > > >
> > > > > > For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
> > > > > > and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> > > > > > successful handoff.
> > > > > >
> > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > ---
> > > > > >  test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 94 insertions(+)
> > > > > >  create mode 100644 test/py/tests/test_fw_handoff.py
> > > > > >
> > > > > > diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/test_fw_handoff.py
> > > > > > new file mode 100644
> > > > > > index 00000000000..4cdf51a4375
> > > > > > --- /dev/null
> > > > > > +++ b/test/py/tests/test_fw_handoff.py
> > > > > > @@ -0,0 +1,94 @@
> > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > +#
> > > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > > +#
> > > > > > +# Validate Firmware Handoff from TF-A and OP-TEE
> > > > > > +
> > > > > > +import pytest
> > > > > > +import re
> > > > > > +
> > > > > > +def _norm_ws(s: str) -> str:
> > > > > > +    """Normalize whitespace for robust comparisons."""
> > > > > > +    return re.sub(r"\s+", " ", s).strip()
> > > > > > +
> > > > > > +@pytest.mark.buildconfigspec("bloblist")
> > > > > > +@pytest.mark.buildconfigspec("cmd_bloblist")
> > > > > > +@pytest.mark.buildconfigspec("of_control")
> > > > > > +@pytest.mark.buildconfigspec("cmd_fdt")
> > > > > > +def test_fw_handoff_dt(ubman):
> > > > > > +    """Validate FDT handoff via bloblist."""
> > > > > > +
> > > > > > +    if (ubman.config.board_type != 'qemu_arm64' or
> > > > > > +        ubman.config.board_identity != 'fw_handoff_tfa_optee'):
> > > > > > +        pytest.skip("Test only for qemu_arm64 with ID fw_handoff_tfa_optee")
> > > > >
> > > > > This (and the other tests) should be more pytest.mark.buildconfigspec
> > > > > but for TARGET_QEMU_ARM_64BIT and then relevant TF-A/OP-TEE options. And
> > > > > even then, possibly just the relevant TF-A/OP-TEE options as it should
> > > > > work on other platforms too, yes? Thanks.
> > > > >
> > > > Just like what you commented to my test-hooks patches, if we can merge
> > > > and use a general conf qemu_arm64_na, the check for the board ID is no
> > > > longer needed.
> > > > But still this is for qemu_arm64 only, since the TF-A driver is
> > > > platform-dependent, thus the feature currently only works on a few
> > > > platforms.
> > >
> > > My point is that if a platform enables the correct U-Boot options (and
> > > only would if the rest of the firmware stack supported it, yes?) then
> > > this test should also run correctly. Right?
> > >
> > In U-Boot, Firmware Handoff is sharing the BLOBLIST kconfig, and with
> > two prerequisites for a "handoff via bloblist" happen:
> > 1. BLOBLIST is selected.
> > 2. Registers are carrying a bloblist compliant to Firmware Handoff
> > plus expected conventions.
> >
> > But a platform selecting BLOBLIST does not necessarily enable Firmware
> > Handoff - Simon designed the bloblist with other purposes other than
> > handoff.
>
> Ah, right, OK. So we need to make the test opt-in (via the board env
> u_boot_boardenv_...) instead then. We can't hard-code a board ID in to
> the tests, that's not portable.
>
Well, I can create a 'u_boot_boardenv_qemu_arm64_fw_handoff_tfa_optee.py' with:
'env__firmware_handoff_enabled = True'.
Then in the pytest get it via 'ubman.config.env.get()'.

Thanks.
Regards,
Raymond

> --
> Tom
