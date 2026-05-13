Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17908CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60555836AC;
	Wed, 13 May 2026 10:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hxYDSIU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C033383EF9; Wed, 13 May 2026 10:01:06 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322818056B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso7063375d50.1
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 01:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778659262; cv=none;
 d=google.com; s=arc-20240605;
 b=esxGIB9Go9PRHb4rAeewbw5nAQ58ZZWh24i3SU7zkp8JVN3vT4gUNAfEhSrIfJduII
 wPQllmeDrhDYw5etppX0SX4RjX5G1ubQ6APAtzIlkuKkE72uKJlTjhncuZMPkfJUV526
 DQ0g8uJE0JePlK/4rTVp15ps3FUc3O9lFsjJP5qKED17CH6uVbLOhS5iSe6uANs4e78e
 j8UiPu/zS2SsxdT6EIivYAG4ID5AkPgMdUAC3JpKTtMZ6B1gk7i2g3pfHmkGyIH1b1gU
 qadqAPacCjXWj6ASSHG3ak1k0wRU7QcexMExHBZrnw8H+Y34oiMLRwLhTb2tuMWrHs3w
 tYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xxcIO+CWAuVR9+qO2DURnno8/2vnP3jUmz8qVpdtAsU=;
 fh=E4LY2AjsZTheRaKVa0SJbuMk4/aewjXQLb6xgRYIt7o=;
 b=LY2sQZ1h5ASqtqeeAJdhm3xHb/RQ1wPPnCHPRht2qtnVGI96/hg/lM/3hs2NygUrv9
 okeqb4yK7uxove6L+EnfCPlHcXH3HDuoXFHR2ECdLcZcsZHWhSDqgGDu1g/K7fWXdMBw
 KXleygT+6H2s+cQpy1eGyw2uPPCfI7nFSLu18IfWVyinExsYHQsrd0FN6WA+MeVe/Cuz
 Xab2xJnO1IZ+ai9thGFRBZh+ekUjdzkBa5ZgfVWPIfvCJLq36AM4ViZo6Fpi9K6r5RtS
 Tl8ynGrQK2WZfcErUDYO2waILfkymdZ5thlTNlI7/i1l9ceIpMWx/aPpJJDfMDkgkADl
 xWQA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778659262; x=1779264062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xxcIO+CWAuVR9+qO2DURnno8/2vnP3jUmz8qVpdtAsU=;
 b=hxYDSIU/1cyWlCfvSL1mjlMQHjnbP6W9MxQyreAbz2XqGpW3qK/Gj5xsA96VwqLUkx
 KDyuiwPSmQcTLEEYJ+/B+GMztn6/vHlRQ6cZl8cWthnLijnITK9iW3L1AGtB6T4wtTXa
 pRGdZejE2Rw4xSFWt877VwsoYS/e4QqmVHNHP7Ho9/3gJA/zZ8iUSAD4Shsf/pmFRXDu
 Xl1c9tw2LvQKe67n0agA/rdOMU69ycZct+Pi7OHkaltUSiglgw2i9dBh3RC0CR27ZXkE
 GGWgWol/q0g6Hbjxb1/w6Er4I7iWJfpT/F6oP5MauBZbWqY3AqKbrNtEUpwMzWUYYLdc
 NpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778659262; x=1779264062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxcIO+CWAuVR9+qO2DURnno8/2vnP3jUmz8qVpdtAsU=;
 b=WVcJnC2PtNRCLPDvhTt0ydDRNSecl1fa/E4QfxU1bf196e53lE7Kcr9tVOwj4ryXr3
 WWcMBEn8ylnGGV9OI7tKDQLtKByXuOV9LwhjPs0LUUNX7hcn2rzH8WWo8VHEas+miuAl
 nXAPC/5YzSTXdUfgez1PGEJHC8kQjCdN6J96YyOHZNbk8ADY+YQJyIevmFLcdiACzB9A
 lYHQTTshD1tombdb3Hmis64i9k7ORalejrPavKeYYHf2D0GcjYsCNIk1PAMkoxMpXU9u
 k2RDzGsM04+4TndmRE5NdSkWz+FcsgGzo6IMLP539r3MhMY9bUS6DXKY3zDUJ5vrTiaZ
 qUSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QmGBtcVKxQ2ZpUrQmOqp8WC9UDK0k8Z9XS0LHhymtiAbBpcEmNys+OCaCcfjIRSev7k7CXtY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywo4q/TYSlTW+6PGBaHUwHem4uR3n1Suy/teJ22OvzY+cGHrnuq
 WOcBSwwglNXum13YPNZL6ZY79RL0FUXffb1r9dapTEpS6MA/C+QOskg+ggAg6InqGRck89zNdF6
 ws8Taw8gFsi0253wwFUpJH6J9U8bRkegj7jhy0TNiPw==
X-Gm-Gg: Acq92OE8P7AURXKxLxVA7zkUcOypvuefYkgZ80gnjykVIFG5RTyYTO7QYQudQbbAa4p
 MTOQWABAcp4mhkQjS2ok+SrH4pLPshVKdKQRSrbjwckTr/qWaxkbbnAyn8NMEqlReKWY6M3VYkQ
 QS2HKkA8z56zwb12mnbXWhiaP6Jhmke9nczDBoTQxst7DHDRZVR5Gn8PeLm9QUcTeixJCvOVY36
 xwOdIPiS5N/bML/YQ9A/FTVyMA9zXiDJOL6ZXmIdQoe7g9nZ+HapVmqExB4vyazYDuIC+UpKOYb
 nho4b4JcjxrG4dIw/w/KDpmWTeydZzYRD1ibs6kPkILNsAp7NFY2xpOQhklqmaiM20yEAB7hqfq
 KeEZAjfynOjCuakvCjPCOarumQ+SaLquA/gNdm4gt+5TsThhjCj0mLixA8TN2IbVrEgD4Vj3xHa
 nIChGq3tencO4q4wSyl8OSk6N0huxf+mmpqb78oBAhv+s45xSQ2yf8qJwxbTFwhbUspD/OA01RS
 ojrtVHKrd7h95FSQ5vNluVGd9ObXzH4RfCUO97b0efUnUTOvZPXSCQGIQYl0RcFh9C5uYP7unck
 6X63JoADVSDV9fRKebZq6adAN3AKNIQVCgCV9ZLW8PFLyjnDD5dRSgLo8Y3XqsAv9npvv3NwaeW
 uzSWgiQ==
X-Received: by 2002:a05:690e:4004:b0:64a:d479:bfbe with SMTP id
 956f58d0204a3-65df61ca569mr2108795d50.11.1778659261713; Wed, 13 May 2026
 01:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
 <0f23738b-b6cb-44f5-8b89-2f74760f1bf2@foss.st.com>
In-Reply-To: <0f23738b-b6cb-44f5-8b89-2f74760f1bf2@foss.st.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 11:00:25 +0300
X-Gm-Features: AVHnY4JCrPj9noh6o4V2feG93XVsyMWAzChQXHJfQqGWJv7l67L1Kqd48UhO7j8
Message-ID: <CAC_iWjLe9cv9C=uMjuMJVhLJ7P=RA020PO4GqZ8UjX8z0yfdyw@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] Support metadata-driven A/B boot for STM32MP25
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
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

Hi Patrice,

Can you please get an Ack from Sughosh before queuing these up? I'll
also ping him and see if has time to havea  look

Thanks
/Ilias


On Wed, 13 May 2026 at 08:48, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 4/30/26 10:06, Dario Binacchi wrote:
> > This series, the mainline version of [1], provides the necessary changes
> > in U-Boot to support the metadata-driven A/B update flow for STM32MP25
> > boards. It implements the logic required to dynamically select the boot
> > bank based on FWU metadata.
> >
> > These changes are designed to be backward compatible while providing
> > the necessary infrastructure for the A/B scheme.
> >
> > The series has been tested on the STM32MP257F-EV1 board.
> >
> > Additionally, some patches in the series propose changes with
> > general-purpose utility:
> >
> >  1/7 lib: uuid: add partition type GUID for extended bootloader
> >  4/7 cmd: part: support lookup by UUID in 'part number'
> >  6/7 fwu: add helper to get image GUID by type and bank index
> >
> > [1] https://github.com/STMicroelectronics/u-boot/pull/6
> >
> > Changes in v8:
> > - Skip the test in case the CONFIG_MCC is not enabled or the mmc
> >   device is not found.
> > - Add Reviewed-by of Patrice Chotard
> > - Skip cmd_test_part tests for configurations where MMC is not enabled
> >   or the device is missing
> >
> > Changes in v7:
> > - Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
> > fwu_mdata: add test for fwu_mdata_get_image_guid"
> >
> > Changes in v6:
> > - Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
> >   tests for part command"
> >
> > Changes in v5:
> > - Update doc/usage/cmd/part.rst to reflect the changes related to the
> >   part command.
> > - Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
> >   image GUID by type and bank index"
> >
> > Changes in v4:
> > - Place the part command tests in the cmd suite rather than the dm
> >   suite.
> > - Order the include files according the U-Boot coding style.
> > - Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
> >
> > Changes in v3:
> > - Wrap lines exceeding 80 columns in test/cmd/part.c file.
> > - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
> > - Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
> >   in fwu.h.
> > - Add log_warning() messages to fwu_platform_hook() to catch inconsistent
> >   FWU metadata (boot GUID found but root GUID missing or viceversa), as
> >   suggested by Simon Glass.
> >
> > Changes in v2:
> > - Add links to the XBOOTLDR specification in the commit message of patch
> >    1/7 lib: uuid: add partition type GUID for extended bootloader.
> > - Update help for 'part start', 'part size' to mention UUID.
> > - Add kerneldoc comment for fwu_mdata_get_image_guid().
> > - Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
> > - Add patches:
> >    5/7 test: cmd: part: add UUID lookup tests
> >    3/7 test: cmd: add unit tests for part command
> >    2/7 test: dm: part: add test for part_get_info_by_uuid
> >
> > Dario Binacchi (8):
> >   lib: uuid: add partition type GUID for extended bootloader
> >   test: dm: part: add test for part_get_info_by_uuid
> >   test: cmd: add unit tests for part command
> >   cmd: part: support lookup by UUID
> >   test: cmd: part: add UUID lookup tests
> >   fwu: add helper to get image GUID by type and bank index
> >   test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
> >   board: st: stm32mp25: support dynamic A/B bank bootup
> >
> >  board/st/stm32mp2/stm32mp2.c          |  32 ++++
> >  cmd/part.c                            |  12 +-
> >  doc/README.gpt                        |   2 +
> >  doc/usage/cmd/part.rst                |   6 +-
> >  include/configs/stm32mp25_st_common.h |  15 ++
> >  include/fwu.h                         |  11 ++
> >  include/part_efi.h                    |   3 +
> >  lib/fwu_updates/fwu.c                 |  33 ++++
> >  lib/uuid.c                            |   1 +
> >  test/cmd/Makefile                     |   1 +
> >  test/cmd/part.c                       | 227 ++++++++++++++++++++++++++
> >  test/dm/fwu_mdata.c                   |  48 ++++++
> >  test/dm/part.c                        |  53 ++++++
> >  13 files changed, 437 insertions(+), 7 deletions(-)
> >  create mode 100644 test/cmd/part.c
> >
> For the whole series
>
> Applied to u-boot-stm32/master
>
> Thanks
> Patrice
