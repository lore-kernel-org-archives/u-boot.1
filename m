Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5ADFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 09:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB4884709;
	Wed, 29 Apr 2026 11:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="de6QsiG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9527B84711; Wed, 29 Apr 2026 11:19:21 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61DC84705
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-794719afcd4so131380647b3.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 02:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777454358; cv=none;
 d=google.com; s=arc-20240605;
 b=QWyNnErAwkTINNpgGMeKmA81ocievOhBv9T4WtqEjbr7xB1jZ2rm0lGju+GeuAN5sw
 HsfVQmjVQd95opVTvGjvYVd8i4MdHRZRInJQdmVefjKbaHVsMR0ONHb+1yRAewsiwnu/
 nVxc4Nf8/d2hAO7Vgoye3Hs/FKQas26oL93h2HzEfCiYJfc8cHhQREo9bLMfPG/o1ghh
 2ly9wVM1HS+FWkd7NOV17160uYXKrc1e/WEfeNXkU9zQPBW40bE7/dkld+aWMq6Xcp3e
 cbDJPaZZJxLpvqGlpsfK2Mhy7LXe3wBJIVEKJbHMnZbxoIpqHLCJhsEmCIaeDXT4Lxof
 E0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FkAqQQ4dNMdpquLntpxzeb2eFOggpHlVY0F0S1HWNFg=;
 fh=GIgt1ITiuaqFQ8sDgTOkI1/bD/mkuz7UEsUGOpVXZPI=;
 b=k5Wggwy2hDaNgDX79hYoZvZiRvsFvZs4plM4cMoeK8BWaXqQjUFjb6C8d0FTau0rWc
 0QXPP2lcgvXCOqvbiJE4G74bP2I+tjgbwWDs/pExnhjS3uoW2qkXikFQ53Fz2rVNK3X9
 1QgOjg1e5P/UC4X0O7MwfSbAHa95thK1Mo3qd9TJk18jrrBq/jKzOrshIpEQA/JKOGiE
 NVqq6uMbJNTLsqVmHBXY+bYt0aJC17EsxAPjcNKI05YveAsY1SHTGimaRDokK+DX1yC4
 AeOeZNuw8ZSnQ2rGdTYX+QFNpMRBFbhLo2f8O+lvm9F8RjcxvYBUt+orhi94vhK69qQW
 pp1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777454358; x=1778059158;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FkAqQQ4dNMdpquLntpxzeb2eFOggpHlVY0F0S1HWNFg=;
 b=de6QsiG5+CcLF9R90lh6R4SFGxnziR3ZhYZbf+WmqstOM/wy3ebyvwOxlJb5CnHmOG
 5lAf1NdJd0NSyEyTlICwUjzeucN7/Q8vBMgb+jhC0z1c4derXz3X9dD1c51wO21y+rRm
 iVGY3itV01OFkzyKXRpjiRqg00o0fIqxVW0/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454358; x=1778059158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkAqQQ4dNMdpquLntpxzeb2eFOggpHlVY0F0S1HWNFg=;
 b=tSZxwlJ+i0XR5szvuVt6tdGcokxWWw79C9RfpCWgxGJCvGSwZC3HKAlJJkXeGzDko5
 6v9apbev81djr9tmXFHqBsXMJJkQtIiCRQPoU+FNI6RJ8xnP04eew37/4z3pZzU9RRqr
 Pp2vPSdND3x48Exq5Kj0SfSb1L+Mv7RBZjijzTPifh4JmBWwFe1unk2xbD9I1rQTyiYs
 NmQoLAJ1fqHVKYQviTOnyoia9ozt6s1uuQ1nOZtcrQpY70m7F9kkL1UwYu69JdeGxzcD
 z8sJj8d/oRIMMChanDRXEyCZoPoo/1qtsh+hemoBAioxNVOSNwkZf/n5JIcsmYkWnYTb
 ZuXQ==
X-Gm-Message-State: AOJu0Yxe1Bxer8Pj5VBNYQc/zE2qD/8/0Q+uJjpBvALuqld2LrGmsNLC
 +/I6JW6nhjd91QH3wqLQwFasDA/iYg+N9u9mfTsRY1l/RnfaYkNGGGdCp0G+S4xMyAWjq1BqeTz
 sVl0vUkNy4vkTrR6lq8iUFZmu78s7QZVWBcmK5JgePQ==
X-Gm-Gg: AeBDiev3nWgsSLRC2ARmrS1Ke8JZCAme1YJLfLSgIKaT/RiEZjAMBdbYp9kfXeXo2Ss
 Y3b8TTK+SmS0HWYXMQWojxtn7Z9t4jlQQghSshAcVowXFsswn+iqNMFaqIL6rhrg/K+8hDmhN1K
 hA4wzWxpao2FnL+xpnfuWNu44YE+s6xpdQXlvB9vPdRD7giAUq9SA7vr01l5JZg3EBaattHwQPD
 I+pHiE61jkQzRAV+/NAL1EevifsnkEfPSg6nh9MoK0jmyLC819/qKPoioAGXx+RtmHdfDPuG70S
 n8pRWKGBFI7cgrAI9ZfCxEfS9RH3eGfn4I0+wmWqnFbLlsrv
X-Received: by 2002:a05:690c:a01c:b0:7b1:3579:2efd with SMTP id
 00721157ae682-7bcf5595d17mr51824247b3.39.1777454357656; Wed, 29 Apr 2026
 02:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
 <825d39e8-286d-4f83-a23e-0b798b1c9631@foss.st.com>
In-Reply-To: <825d39e8-286d-4f83-a23e-0b798b1c9631@foss.st.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Wed, 29 Apr 2026 11:19:06 +0200
X-Gm-Features: AVHnY4KAoqWGSWmMvqSskD6Cv_jVD_SJ9R-AB5SJeQ1qNllx7Iotv9VO2DIPXsM
Message-ID: <CABGWkvoJPMzHsh-_bZaVCMt3va5TpaWwK2e=yS7Nw0pcTrde+w@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Support metadata-driven A/B boot for STM32MP25
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Bin Meng <bmeng.cn@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jonathan GUILLOT <jonathan@joggee.fr>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hello Patrice,

Sorry, but I can't log in. My Custodian account has expired, and that might
be the reason. I need to ask Tom Rini to reactivate it.
In the meantime, can you please give me some information about the error?

Thanks and regards,
Dario

On Wed, Apr 29, 2026 at 11:14=E2=80=AFAM Patrice CHOTARD <
patrice.chotard@foss.st.com> wrote:

>
>
> On 4/26/26 17:46, Dario Binacchi wrote:
> > This series, the mainline version of [1], provides the necessary change=
s
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
> > Changes in v7:
> > - Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
> >   fwu_mdata: add test for fwu_mdata_get_image_guid".
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
> > - Add patch 7/8 test: dm: fwu_mdata: add test for
> fwu_mdata_get_image_guid
> >
> > Changes in v3:
> > - Wrap lines exceeding 80 columns in test/cmd/part.c file.
> > - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command=
(
> > - Add kerneldoc comment for fwu_mdata_get_image_guid() above its
> declaration
> >   in fwu.h.
> > - Add log_warning() messages to fwu_platform_hook() to catch inconsiste=
nt
> >   FWU metadata (boot GUID found but root GUID missing or viceversa), as
> >   suggested by Simon Glass.
> >
> > Changes in v2:
> > - Add links to the XBOOTLDR specification in the commit message of patc=
h
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
> >  test/cmd/part.c                       | 209 ++++++++++++++++++++++++++
> >  test/dm/fwu_mdata.c                   |  48 ++++++
> >  test/dm/part.c                        |  53 +++++++
> >  13 files changed, 419 insertions(+), 7 deletions(-)
> >  create mode 100644 test/cmd/part.c
> >
>
>
>
> Hi Dario
>
> I am preparing a pull request for STM32 including this series.
> Unfortunately, there is an error linked to tests test/cmd/part.c
>
> You can use my temporary pull request tag u-boot-stm32-20260429
>
> You will find the error logs here encountered with qemu test :
> https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/29932
>
> Thanks
> Patrice
>
>

--=20
*Dario Binacchi*
Senior Embedded Software Engineer
M. +39 328 0625246
dario.binacchi@amarulasolutions.com
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
Amarula Solutions SRL
 Via Felice Cavallotti 25D, 41012 Carpi, MO, IT
info@amarulasolutions.com
www.amarulasolutions.com
