Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30534C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889FB80107;
	Fri, 16 May 2025 17:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lmeZ8ZQ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 122088059D; Fri, 16 May 2025 17:40:02 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCA78006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6006d5c3a0eso2194995a12.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747409999; x=1748014799; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b9SLi6dNQ7+vHHijp9HS2KIAiHMLAjRDRHY1A8VehX8=;
 b=lmeZ8ZQ0UjcA0eQ5dCaaSPObe/XB96rkqOLwyRFrNUI+JEhq/mrLVVq0Ng1sYZliA6
 2heqKDxDk6oBPgqs3eCOWlNCnzGBW03j29+8IXrLWA/VLMy1x3oXf18RBsapsE2pU+8J
 ELkNxXeHRBCi1ZG/FR1Yv8j5EKQ/hhdCnjNU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747409999; x=1748014799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9SLi6dNQ7+vHHijp9HS2KIAiHMLAjRDRHY1A8VehX8=;
 b=XcbYTsPx30dNiYUkdgBCJeciveR2HEgad516CjUyHYCDYcOtYkvAYNNe0nAc6BKdpM
 QMuILtIMoWp2xsKyjGXtskLqrW3tfjYym/ekGdu2WlQqyt8wlozbyMCqPiiMveI7yyq6
 l4N/BQ47MczsYwHJCt0EO1l6LtcBW2UaZaRo1MNUFjpZ/QtKdsjjVfyVHgEO2qTvk+ZI
 H7wszZv40MTQWRonML7fU0Ep+FiBK8yXdviGQgePyk/8My8c+HythTD5SV07GfsjbZol
 B8lF+iwBI7ElC5joxKN/zw38sQ8Nm1gLCFCoNBXbP9/WVKwcWRhN9CG3RJ3YpqS7o9rA
 V4pw==
X-Gm-Message-State: AOJu0Ywrze+zCFp56isJBLgKVQ30nCNWtF5dulE5Ww8inQ0J+ZPwUGiV
 HuD44ij1Ot54yM8YDLe+8kcfb0zlJZZ2zXAx6FADyp7Rq8wNQZFGqd8ZVH03O6gszrN4H35mTXl
 StxAnmd1HAL4HrnFRwING16vROHRHEoPL6JZExgH8
X-Gm-Gg: ASbGncv8hQ9oTaE2GclNeqRwDeD8dSDTWYCUEnzqyF39L8c65HjbBUcJ2HUKazCNGMe
 M2426aqmYCmU9nzY9JT3/dxVXO+Bycfi1TdgMpkhPDS1U5ciA6KZ/KqLz6HKdjoj/PjQWBZP3th
 wvZFBdA/0byCqeGZ49jUTIFnNdVrhy8gRJXQ==
X-Google-Smtp-Source: AGHT+IGengcUbo6M1oe7lJdcpwc8Ik+CKCg+VSKJEjAaj+ufbJS+WjP10ETPFdE8jsu0u4WkVDKIu4WELG02x4UbKxU=
X-Received: by 2002:a05:6402:2108:b0:5fa:b131:f009 with SMTP id
 4fb4d7f45d1cf-6007e825a98mr3339076a12.0.1747409999249; Fri, 16 May 2025
 08:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510134253.1581164-12-sjg@chromium.org>
 <20250514215831.GE603748@bill-the-cat>
 <CAFLszTjKuPSHovFsoKFBiWTmn_2LSENjNQ0r2bGjBSXQOxJfxQ@mail.gmail.com>
 <20250515204538.GC100073@bill-the-cat>
In-Reply-To: <20250515204538.GC100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 May 2025 17:39:47 +0200
X-Gm-Features: AX0GCFt1VFOMw_udMeDTCO-rFzcgvxnhqdCbztTq783H8gcv1tkQ60XJNJcFk8k
Message-ID: <CAFLszTgjNqAME_g5b5skP7qzx0T85L4uFg+=MBqNyX_enMNPcA@mail.gmail.com>
Subject: Re: [PATCH v4 17/22] passage: Add a qemu test for ARM
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, 
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

On Thu, 15 May 2025 at 22:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 15, 2025 at 09:26:54PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 14 May 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, May 10, 2025 at 03:42:15PM +0200, Simon Glass wrote:
> > >
> > > > Check that the standard passage works on ARM, by setting it up in SPL
> > > > and making sure that it comes through correctly in U-Boot proper.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v3)
> > > >
> > > > Changes in v3:
> > > > - Add conditions to avoid enaling the test on qemu_arm_sbsa
> > > > - Add support for a 64-bit test also
> > > >
> > > > Changes in v2:
> > > > - Add a devicetree for qemu-arm so that qemu_arm_spl can work
> > > >
> > > >  configs/qemu_arm64_spl_defconfig |  5 +++++
> > > >  configs/qemu_arm_spl_defconfig   |  6 ++++++
> > > >  test/py/tests/test_passage.py    | 13 +++++++++++++
> > > >  3 files changed, 24 insertions(+)
> > > >  create mode 100644 test/py/tests/test_passage.py
> > > >
> > > > diff --git a/configs/qemu_arm64_spl_defconfig b/configs/qemu_arm64_spl_defconfig
> > > > index a9ed47c8d3b..60651f80938 100644
> > > > --- a/configs/qemu_arm64_spl_defconfig
> > > > +++ b/configs/qemu_arm64_spl_defconfig
> > > > @@ -33,6 +33,10 @@ CONFIG_USE_PREBOOT=y
> > > >  # CONFIG_DISPLAY_BOARDINFO is not set
> > > >  CONFIG_PCI_INIT_R=y
> > > >  CONFIG_BLOBLIST=y
> > > > +CONFIG_BLOBLIST_PASSAGE=y
> > > > +CONFIG_BLOBLIST_SIZE=0x4000
> > > > +CONFIG_SPL_BLOBLIST_ALLOC=y
> > > > +CONFIG_PASSAGE_IN=y
> > > >  CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=y
> > > >  CONFIG_SPL_NO_BSS_LIMIT=y
> > > >  # CONFIG_SPL_SEPARATE_BSS is not set
> > > > @@ -47,6 +51,7 @@ CONFIG_CMD_EFIDEBUG=y
> > > >  CONFIG_CMD_TPM=y
> > > >  CONFIG_CMD_MTDPARTS=y
> > > >  CONFIG_SPL_OF_CONTROL=y
> > > > +CONFIG_OF_PASSAGE=y
> > > >  CONFIG_OF_BOARD=y
> > > >  CONFIG_ENV_IS_IN_FLASH=y
> > > >  CONFIG_SPL_DM=y
> > > > diff --git a/configs/qemu_arm_spl_defconfig b/configs/qemu_arm_spl_defconfig
> > > > index 9c4408dc73c..cf8ac703577 100644
> > > > --- a/configs/qemu_arm_spl_defconfig
> > > > +++ b/configs/qemu_arm_spl_defconfig
> > > > @@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
> > > >  CONFIG_DEFAULT_DEVICE_TREE="qemu-arm"
> > > >  CONFIG_TARGET_QEMU_ARM_32BIT_SPL=y
> > > >  CONFIG_SPL_SERIAL=y
> > > > +CONFIG_SPL_SYS_MALLOC_F_LEN=0x9000
> > > >  CONFIG_SYS_BOOTM_LEN=0x4000000
> > > >  CONFIG_SYS_LOAD_ADDR=0x40200000
> > > >  CONFIG_DEBUG_UART_BASE=0x9000000
> > > > @@ -34,6 +35,10 @@ CONFIG_USE_PREBOOT=y
> > > >  # CONFIG_DISPLAY_BOARDINFO is not set
> > > >  CONFIG_PCI_INIT_R=y
> > > >  CONFIG_BLOBLIST=y
> > > > +CONFIG_BLOBLIST_PASSAGE=y
> > > > +CONFIG_BLOBLIST_SIZE=0x4000
> > > > +CONFIG_SPL_BLOBLIST_ALLOC=y
> > > > +CONFIG_PASSAGE_IN=y
> > > >  CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=y
> > > >  CONFIG_SPL_NO_BSS_LIMIT=y
> > > >  CONFIG_CMD_BOOTEFI_SELFTEST=y
> > > > @@ -44,6 +49,7 @@ CONFIG_CMD_PCI=y
> > > >  CONFIG_CMD_TPM=y
> > > >  CONFIG_CMD_MTDPARTS=y
> > > >  CONFIG_SPL_OF_CONTROL=y
> > > > +CONFIG_OF_PASSAGE=y
> > > >  CONFIG_OF_BOARD=y
> > > >  CONFIG_ENV_IS_IN_FLASH=y
> > > >  CONFIG_SPL_DM=y
> > > > diff --git a/test/py/tests/test_passage.py b/test/py/tests/test_passage.py
> > > > new file mode 100644
> > > > index 00000000000..4d95287fe55
> > > > --- /dev/null
> > > > +++ b/test/py/tests/test_passage.py
> > > > @@ -0,0 +1,13 @@
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright 2021 Google LLC
> > > > +
> > > > +import pytest
> > > > +
> > > > +@pytest.mark.buildconfigspec('qemu_manual_dtb')
> > > > +@pytest.mark.buildconfigspec('arm')
> > > > +@pytest.mark.buildconfigspec('of_passage')
> > > > +def test_passage(ubman):
> > > > +    """Test that the standard passage on ARM from SPL to U-Boot works."""
> > > > +
> > > > +    response = ubman.run_command('bdinfo')
> > > > +    assert 'devicetree  = passage' in response
> > >
> > > Why is this test QEMU specific? This would be at least as interesting to
> > > run on vexpress_fvp_bloblist and then any other real platform which also
> > > uses this in the future. Since the time to run this test will be
> > > negligible I don't see why it should be omitted elsewhere.
> > >
> >
> > Yes, I can enable it for that board.
>
> It's not a per-board enablement, it's dynamic because that's what:
> @pytest.mark.buildconfigspec('of_passage')
> gives us.

Yes, agreed.

Regards,
Simon
