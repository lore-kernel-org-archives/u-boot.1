Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9ADDCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 11:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C149844BF;
	Wed, 13 May 2026 13:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZZIdx/BM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A75845E3; Wed, 13 May 2026 13:59:16 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4D9836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 13:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-656d749109cso3885570d50.3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 04:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778673552; cv=none;
 d=google.com; s=arc-20240605;
 b=EGXMJd5uGWhXaXxY/XRbrq1ltTz/oP5NEAnydoQ9ikhKQV5jEg5zNOlB/8FpfLbs29
 hmlt1sP3amPIAP9G2jo0WqROsy3A/C+nPrxNBi+mY36E/QFSkYZUM5NCwx7aQxydcDmw
 Sr3xfT4bwpZ5yo8JczcJvipYllt1VfIcCUOhaaMmEs68We1lyJanVTMvfUyUWYA9MeUd
 SV2t9r2m3vAhkZk+GQRXx8e8eNXzt5qY+nQMrqaUYPLqBckFHY2GKjr5XclWhhpV7U90
 38bK9VliSYcVemxHkVV7sevfcpsQIExShgfHn+oX1oLoezgTXWkpphK/Pq8K027lUYPq
 v/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5vvwS9hoZx8wbN7EvGS9aBvcCYryu1CZA9iR91bh4yo=;
 fh=XcbmqoyqH4WbqoC+n8Nn0hwh8HqkWgNmcxokjaFJNbM=;
 b=ZzjpzIj8Hm0RwjbkvigsMOMbEreyIDJyZ9YKhDjsYaTMNuYQl8/d1y5TyCh1skGkMb
 rH2ojA307lvfUCv2Y2fa3gCSKC31Yz+jHShDn096Sty5z1mnQm/zJfdBVTHu26gGNqHD
 gE2jYuSLqFhiPF4n9x/c17llozy8oW7cMJjaN2SVo6XDkR8dbcAUuGkqo4sfZlumEuKg
 B1zxXnqQB0qQckWejmNP/eA1/SEKdWJNINYCLmQHIVJfOZAlJbVK8CUFiFpuwnX4mYiN
 8WIOncrfkXao9UvOB5Bn0+0B8aUVK8Odf3I4kHJL+Ja2XjJZ7F4iufultd/DS32A838a
 lX6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778673552; x=1779278352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5vvwS9hoZx8wbN7EvGS9aBvcCYryu1CZA9iR91bh4yo=;
 b=ZZIdx/BM1DA6f7RqFka3FJ7wbvdJ9UkeLLtv9teIGEDwHHB3fxWYah+SRrm9zKMpVj
 tXaozA6olFFvaZmRHh4l7c8qpWJDXaocRvp8g5EcDWIMwgl38W/QzZ3o/WlMqXAmNphi
 Vef0rHpLLg+jL/b4O0BEf3yzA2gy0eZ4hrTCcgNQd59TC+JqrD6+N9HTyWeuFrFbcEj9
 xjaQe9EB/2+iXNAcx9L9FwdXzj4f3tAcAHOadNsk1T5SLo8DHg/XQDwn2O5LpHaQyyPL
 mjjVJf3r2tx+muOS+ny75QyhKCx9sUNy0JnXyaIDb7KuPvflWfs22jgQkQd2rtvwcJnR
 5ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778673552; x=1779278352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vvwS9hoZx8wbN7EvGS9aBvcCYryu1CZA9iR91bh4yo=;
 b=aQArISmqGQriM+OhUWXhtV1bMOjbW/kLCeUynC5liuC28YQfd184ldVqe5Rapps4GO
 mRAd5bEiEan0iVEDIEiR/Ce9wp0nB440Cx9JsQ/ZFtWjCu/agiIeFXMK8Fk4oLdRr5o3
 H3f8obLJU11AaOpN4K807jEoTPZLc4AjSD73RKuQNLGPyYKveZpuy0uXYknmmHg+VaWT
 CrWtez+sPMx382p5q/k65weN7XA9wh2HhGgffm8MIQoK2ACq1rVp+ZW2nMVQpNRhspij
 zvVqc2P8z1D6grn+rLSqfqwFVQ7vkROu4V3kUQK/Q+Dz8qhLS6LCpg3RwFBzGihaL/az
 c+KQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9N1Bkq9VZMgH56fweS4fyLtMxYkH5T3p98N6leQxmlBXRApbpj2sMoLylt8x6QNUmj8N+NNDE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxd8k95LsSx2/C6s2kWr/ZPb/fJFA2SwgpPy+sXygUR8vr08LWc
 oZ/BhN6vOs/U3AFWqXrkbO8pBlqYKcXNef0PUn0O/Md7Ny9Z3RAv43hEBp3Gb17mu+bF2h48yXD
 oMl1sdBfxqnXRdzYU47nSnxX7cucpxFcJ/O82ZTYlnQ==
X-Gm-Gg: Acq92OFzZE4g3gndpG4T0LSaVnEggni/H4e5lz8WECshS1JnInfRSluCo3Q2tN7780x
 6KNqJHWTkVVG1ox7MQMo+w3S91hgpfuhd+1iZPu+nQ/oNYwptTUprc3JDCMOR8YSv8C0tHIFhnb
 Rf7fgPIQOKH4pz3g/Jsn4tTXiid1X1dfJFgPmQ3TqpErsj6AOSQ8qsnBKFJryOyKi3Cc/2aduUO
 U7yyOFMkUl2kpeE5hpizfjWLaFofi7Zzb0Ssbw/gQU+Gka4lSfeVcLbJ4uyRQkVHxd3AtfUV0YZ
 OepObMLcIJbqkZOvSHLuM5a/Is+KD9iO7xnepj54+VH9U+OImnYWrPq6dCINsapkYdm8UC9OpWx
 oolTwxHgDIgpE8sVc+nr3w1deZ4U8Kz1P3FzCyQXRyEAgQOVoK2Byb1c2sKrJg8b1IgdmGm3aIP
 BM8uR/iehtSoR/5FRxY2tTf7tMPRixBiEyJ1mVacqLT6sGk8s+qCNkSTpwY+z3uI0b2IjVdOTHp
 oqe6qAVaHC7zxog7x2xHwEUJMKcc4qKSAxpBb6ZEbNBWBzKPF1ITkGUAqzTv/Tk4JbmQ8hbCSnl
 5yiO8pw1b+6OMs7pRzjFbCilJQM5z1LTkOXVBfkJiJ3vT1M/odxhwcs7f691mVjR+9KVAetmRNj
 QZt0X3Q==
X-Received: by 2002:a05:690e:13c2:b0:65d:8f98:6bb4 with SMTP id
 956f58d0204a3-65df62339ecmr2796001d50.29.1778673551660; Wed, 13 May 2026
 04:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
 <0f23738b-b6cb-44f5-8b89-2f74760f1bf2@foss.st.com>
 <CAC_iWjLe9cv9C=uMjuMJVhLJ7P=RA020PO4GqZ8UjX8z0yfdyw@mail.gmail.com>
 <731224c0-a38a-41d4-959b-1b05d608cf28@foss.st.com>
In-Reply-To: <731224c0-a38a-41d4-959b-1b05d608cf28@foss.st.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 14:58:35 +0300
X-Gm-Features: AVHnY4JSqFi92mlQlqwc_9IGUCUKe_kjCjl0XoqeTpDN4ss9vDnx31D_M0fzwJg
Message-ID: <CAC_iWjKM1MOLdnd2WyGgAkZwzdZ6_sBvA4HMYnOOQbzXNQzk9A@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] Support metadata-driven A/B boot for STM32MP25
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de, 
 linux-amarula@amarulasolutions.com, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 John Toomey <john.toomey@amd.com>, Jonathan GUILLOT <jonathan@joggee.fr>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

On Wed, 13 May 2026 at 11:15, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 5/13/26 10:00, Ilias Apalodimas wrote:
> > Hi Patrice,
> >
> > Can you please get an Ack from Sughosh before queuing these up? I'll
> > also ping him and see if has time to havea  look
> >
> > Thanks
> > /Ilias
>
> Hi Ilias
>
> Oups, i already submitted the pull request including this series.

Ok, I don't really mind the changes to go in. But I dont have the
bandwidth to have a look, so an ACK from Sughosh would be great

Cheers
/Ilias
>
> Patrice
>
> >
> >
> > On Wed, 13 May 2026 at 08:48, Patrice CHOTARD
> > <patrice.chotard@foss.st.com> wrote:
> >>
> >>
> >>
> >> On 4/30/26 10:06, Dario Binacchi wrote:
> >>> This series, the mainline version of [1], provides the necessary changes
> >>> in U-Boot to support the metadata-driven A/B update flow for STM32MP25
> >>> boards. It implements the logic required to dynamically select the boot
> >>> bank based on FWU metadata.
> >>>
> >>> These changes are designed to be backward compatible while providing
> >>> the necessary infrastructure for the A/B scheme.
> >>>
> >>> The series has been tested on the STM32MP257F-EV1 board.
> >>>
> >>> Additionally, some patches in the series propose changes with
> >>> general-purpose utility:
> >>>
> >>>  1/7 lib: uuid: add partition type GUID for extended bootloader
> >>>  4/7 cmd: part: support lookup by UUID in 'part number'
> >>>  6/7 fwu: add helper to get image GUID by type and bank index
> >>>
> >>> [1] https://github.com/STMicroelectronics/u-boot/pull/6
> >>>
> >>> Changes in v8:
> >>> - Skip the test in case the CONFIG_MCC is not enabled or the mmc
> >>>   device is not found.
> >>> - Add Reviewed-by of Patrice Chotard
> >>> - Skip cmd_test_part tests for configurations where MMC is not enabled
> >>>   or the device is missing
> >>>
> >>> Changes in v7:
> >>> - Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
> >>> fwu_mdata: add test for fwu_mdata_get_image_guid"
> >>>
> >>> Changes in v6:
> >>> - Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
> >>>   tests for part command"
> >>>
> >>> Changes in v5:
> >>> - Update doc/usage/cmd/part.rst to reflect the changes related to the
> >>>   part command.
> >>> - Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
> >>>   image GUID by type and bank index"
> >>>
> >>> Changes in v4:
> >>> - Place the part command tests in the cmd suite rather than the dm
> >>>   suite.
> >>> - Order the include files according the U-Boot coding style.
> >>> - Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
> >>>
> >>> Changes in v3:
> >>> - Wrap lines exceeding 80 columns in test/cmd/part.c file.
> >>> - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
> >>> - Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
> >>>   in fwu.h.
> >>> - Add log_warning() messages to fwu_platform_hook() to catch inconsistent
> >>>   FWU metadata (boot GUID found but root GUID missing or viceversa), as
> >>>   suggested by Simon Glass.
> >>>
> >>> Changes in v2:
> >>> - Add links to the XBOOTLDR specification in the commit message of patch
> >>>    1/7 lib: uuid: add partition type GUID for extended bootloader.
> >>> - Update help for 'part start', 'part size' to mention UUID.
> >>> - Add kerneldoc comment for fwu_mdata_get_image_guid().
> >>> - Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
> >>> - Add patches:
> >>>    5/7 test: cmd: part: add UUID lookup tests
> >>>    3/7 test: cmd: add unit tests for part command
> >>>    2/7 test: dm: part: add test for part_get_info_by_uuid
> >>>
> >>> Dario Binacchi (8):
> >>>   lib: uuid: add partition type GUID for extended bootloader
> >>>   test: dm: part: add test for part_get_info_by_uuid
> >>>   test: cmd: add unit tests for part command
> >>>   cmd: part: support lookup by UUID
> >>>   test: cmd: part: add UUID lookup tests
> >>>   fwu: add helper to get image GUID by type and bank index
> >>>   test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
> >>>   board: st: stm32mp25: support dynamic A/B bank bootup
> >>>
> >>>  board/st/stm32mp2/stm32mp2.c          |  32 ++++
> >>>  cmd/part.c                            |  12 +-
> >>>  doc/README.gpt                        |   2 +
> >>>  doc/usage/cmd/part.rst                |   6 +-
> >>>  include/configs/stm32mp25_st_common.h |  15 ++
> >>>  include/fwu.h                         |  11 ++
> >>>  include/part_efi.h                    |   3 +
> >>>  lib/fwu_updates/fwu.c                 |  33 ++++
> >>>  lib/uuid.c                            |   1 +
> >>>  test/cmd/Makefile                     |   1 +
> >>>  test/cmd/part.c                       | 227 ++++++++++++++++++++++++++
> >>>  test/dm/fwu_mdata.c                   |  48 ++++++
> >>>  test/dm/part.c                        |  53 ++++++
> >>>  13 files changed, 437 insertions(+), 7 deletions(-)
> >>>  create mode 100644 test/cmd/part.c
> >>>
> >> For the whole series
> >>
> >> Applied to u-boot-stm32/master
> >>
> >> Thanks
> >> Patrice
>
