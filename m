Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04D3CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 19:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71318811D;
	Tue,  2 Apr 2024 21:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJgBCXYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C998F87E78; Tue,  2 Apr 2024 17:37:28 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B910C86FCE
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 17:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-22e6b61d652so412619fac.0
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712072245; x=1712677045; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W61kMoUmlqZVQOoxDivdpiNrtX02H5Llif6zoOx1i/o=;
 b=KJgBCXYuqquoTmRpQFHMguV1NXnRSjp9Uo0GCnhuJ86cIgdencsBaqgV6eF0Ygye2y
 7Memjr670ixZDy85yIAbp3cMGFXJfR90Nyi/zXokuvzVAOey7SFDNEL/59+gzG4MQev+
 hiHLrmtq6kC2qi5JYXp26uQWCHctw+PjnCHlEH+Gw8oLCkHm74EQOd41Pt+Or9sfFTuZ
 mnuZSY8W21AIshZY/F/6b1KX+ZwJKTAAYG8xfnOSb7z8VmmwImNa0A0o0c3EbnaaEZCe
 iA+EC4168dTKAgKZrDqEai8tbgv4LpvkLYGgB41kov64zoFZ1BWwMGoMTuvJeJO7KA+W
 xOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712072245; x=1712677045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W61kMoUmlqZVQOoxDivdpiNrtX02H5Llif6zoOx1i/o=;
 b=sTzsApblC+zOsuBNoQ8ghpMJ02FWZzFOb184E2Z4h608l0sSjh6KxpO3VFt5b1tmK7
 wGmm0FTi08ZhmIFCm7mOkdZYmcyMhEXa78Q9vfyjA2UtDb/t7iMAwMwbpqHVMm+bZaKM
 yKftIJ5x0AkBAKgWSdt3xDCkQpYXrsIrbXkitiTc9bg5aiQa8Xo/7OaAwKEwmB5U0Uy3
 Hon409qaPS649agxdsQb6vmWUiyp0L4Ldc2jV8LoUp8TH87ONrUkt3dDjKeBJD1It9vs
 1iVC5yklaD7zXPVtQ56CRB9Vj1PPXERmYkXNnm7OQZC6vCeBu1FfaTWuYN7K2MhnmhXJ
 pa1Q==
X-Gm-Message-State: AOJu0YyfVEvfxynjVDHM2KjwJl6/eItNi4C3RraWqnWv110aSJ9KJXHQ
 IbKtXr5ST6upCC+CkxtwqOzSFtGicS6odi4mPgmFg+L8VCJUK/jS+MvOpJv5I30VJEecSSdE0+/
 ketE+znNe2L/K5nyNuPsaz3co49M=
X-Google-Smtp-Source: AGHT+IEJepo07xl/BZQrXsI9yIVl8yYKWRh+HZorO5ErWRQ5o69ljoPBbY7m7Jz3ZapBq2q6SVKHs84arcVi8B8ML1A=
X-Received: by 2002:a05:6871:68b:b0:22e:8a63:8f99 with SMTP id
 l11-20020a056871068b00b0022e8a638f99mr593131oao.53.1712072245428; Tue, 02 Apr
 2024 08:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240331232859.727769-1-james.hilliard1@gmail.com>
 <7fe20558-6af1-46cb-bbfe-af308e3ce279@amd.com>
In-Reply-To: <7fe20558-6af1-46cb-bbfe-af308e3ce279@amd.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 2 Apr 2024 09:37:13 -0600
Message-ID: <CADvTj4r+0hO841ZYbW+Mg9nS70fRpmVGVbh-Q8yoGYE5mj_1AA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 02 Apr 2024 21:37:03 +0200
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

On Tue, Apr 2, 2024 at 6:41=E2=80=AFAM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 4/1/24 01:28, James Hilliard wrote:
> > There are situations where we may want to let U-Boot modify the FDT
> > nand partitions for the kernel, such as when supporting multiple
> > sizes of NAND chips.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v1 -> v2:
> >    - move partition fixups to board/xilinx/common/board.c
> > ---
> >   board/xilinx/common/board.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > index 9641ed307b..20a6f00e45 100644
> > --- a/board/xilinx/common/board.c
> > +++ b/board/xilinx/common/board.c
> > @@ -12,6 +12,7 @@
> >   #include <env.h>
> >   #include <image.h>
> >   #include <init.h>
> > +#include <jffs2/load_kernel.h>
>
> What is this header used for?

It's needed for MTD_DEV_TYPE_NAND.

>
> >   #include <lmb.h>
> >   #include <log.h>
> >   #include <asm/global_data.h>
> > @@ -20,6 +21,7 @@
> >   #include <i2c.h>
> >   #include <linux/sizes.h>
> >   #include <malloc.h>
> > +#include <mtd_node.h>
> >   #include "board.h"
> >   #include <dm.h>
> >   #include <i2c_eeprom.h>
> > @@ -693,6 +695,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
> >       u8 buf[MAX_RAND_SIZE];
> >       int nodeoffset, ret;
> >
> > +     static const struct node_info nodes[] =3D {
> > +             { "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
> > +     };
> > +
> > +     if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_=
NAND_ZYNQ))
> > +             fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
> > +
> >       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> >               debug("No RNG device\n");
> >               return 0;
>
> M
