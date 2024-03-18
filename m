Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517E6C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 10:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1679D87E86;
	Mon, 18 Mar 2024 11:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aXt90u1k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE630879AF; Mon, 18 Mar 2024 09:48:22 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC8787DDF
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-60a3c48e70fso44276367b3.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710751698; x=1711356498; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8rNld6+y+4f+SyM9wYSeoFgE6jEa5OnddhuPB90kJg=;
 b=aXt90u1kN1q7+LeCnYb06y1cjs8NzukqyMXvfE4/Vs+N1SusN8bdFuyjHWbjE2ABqj
 S0M8pSl7+B4xB66keQXglcENWtB5SEJRP0GzsUJkhiAxddjiT0IvqZpXwGZbAgnXxA5r
 +BxWpWi1BaQA3D/5equzBJpeIXDOCuf8yebNm5tQDx3X5WOJuiJUPJUXx3tm1HC9goD9
 3dsV2QOSGlqKdraAHodZJ884LTOqEDWdkmcrBRqJQuCTDstPCxBZirE4323pTvNp+Jpn
 O8qqfzBb/d5qsP+Jilsyulp6kbuNioMmF+szFn7fCSR4CczXrajfMlDP1pBmOyN8cJat
 uEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710751698; x=1711356498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8rNld6+y+4f+SyM9wYSeoFgE6jEa5OnddhuPB90kJg=;
 b=vjJgovnQQZeyaiN1gNCBtFDPcqAzL2fRCJ0coebkNK/g252tqsZgOs/ecErH0hW1Dg
 4Pb+lN0YNj/risRk6VY8M5QYeXj5OiS8ZTuOiZZooXqLaziJK20w4jdyEjsUYf2HfRIN
 Jz3Q2SjIFufkuZhi3xBSJv7U0MXxhRG9G2RR9keYuOVONwD68/NqnPPEqM5FqpKF6K9Z
 GaPvou34BlVyRkIDMPLccZib4Gp+RLQB2Jtk/JfoXgM2LI8TiflFrI4QFX7dXfz8PFWl
 ihtannwt9FU/8Bw6VcjtbThRIJL2GN6DkQE61aGsZtQtaE3jDJYhoTFlBhArKjNkfZl2
 HCpg==
X-Gm-Message-State: AOJu0Yz0p3gnkF7rIzMlT6PxDwR26GrY87lnEfPN6Axqcp2xAQvaJrVc
 su35VTxgqy3vPdj7g6nTc3goERrNzGQPibanqTENT/zW0sN5tvWI5EfupxstfRMtUlNFoXvT/fg
 XN/jV18eOQC/paqM8SGcRgJkqJrA=
X-Google-Smtp-Source: AGHT+IGL6AnTcjEiOjRT7nDhcNDfkh8702e+oKU971tKHQot7bZwdKHgJJ/ZNgq3cBt+0p+K/HxmTcq1CBE55VBZ11M=
X-Received: by 2002:a81:4744:0:b0:610:ce53:e238 with SMTP id
 u65-20020a814744000000b00610ce53e238mr1557090ywa.14.1710751698134; Mon, 18
 Mar 2024 01:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240315192528.464849-1-james.hilliard1@gmail.com>
 <03cf43b0-e9bc-4174-b9bf-3c380e388203@amd.com>
In-Reply-To: <03cf43b0-e9bc-4174-b9bf-3c380e388203@amd.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 18 Mar 2024 02:48:05 -0600
Message-ID: <CADvTj4qiTZOf4kDj=v+5p89+-6JPoZRKQ2Vh+0SODS4=mQ=HtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Stefan Roese <sr@denx.de>, "Polak,
 Leszek" <LPolak@arri.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 18 Mar 2024 11:50:00 +0100
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

On Mon, Mar 18, 2024 at 2:26=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 3/15/24 20:25, James Hilliard wrote:
> > There are situations where we may want to let U-Boot modify the FDT
>
> please use imperative mood.
>
> > nand partitions for the kernel, such as when supporting multiple
> > sizes of NAND chips.
> >
> > Lets also refactor xilinx common board support to have a
> > ft_common_board_setup which gets called by the ft_board_setup for each
> > specific board so that we can add non-common functionality to each
> > ft_board_setup like FDT_FIXUP_PARTITIONS as needed.
> >
> > This pattern is modeled after the one used by tdx-common.c.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >   board/xilinx/common/board.c     |  2 +-
> >   board/xilinx/common/board.h     |  2 ++
> >   board/xilinx/mbv/board.c        |  9 +++++++++
> >   board/xilinx/versal-net/board.c |  7 +++++++
> >   board/xilinx/versal/board.c     |  7 +++++++
> >   board/xilinx/zynq/board.c       | 17 +++++++++++++++++
> >   board/xilinx/zynqmp/zynqmp.c    |  7 +++++++
> >   board/xilinx/zynqmp_r5/board.c  |  8 ++++++++
> >   8 files changed, 58 insertions(+), 1 deletion(-)
> >
> > diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> > index 9641ed307b..629ba2b902 100644
> > --- a/board/xilinx/common/board.c
> > +++ b/board/xilinx/common/board.c
> > @@ -686,7 +686,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t to=
tal_size)
> >
> >   #ifdef CONFIG_OF_BOARD_SETUP
> >   #define MAX_RAND_SIZE 8
> > -int ft_board_setup(void *blob, struct bd_info *bd)
> > +int ft_common_board_setup(void *blob, struct bd_info *bd)
> >   {
> >       size_t n =3D MAX_RAND_SIZE;
> >       struct udevice *dev;
> > diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
> > index 64d657673e..73f576952a 100644
> > --- a/board/xilinx/common/board.h
> > +++ b/board/xilinx/common/board.h
> > @@ -18,4 +18,6 @@ bool board_detection(void);
> >   char *soc_name_decode(void);
> >
> >   bool soc_detection(void);
> > +
> > +int ft_common_board_setup(void *blob, struct bd_info *bd);
> >   #endif /* BOARD_XILINX_COMMON_BOARD_H */
> > diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
> > index ccf4395d6a..d8af1eaa90 100644
> > --- a/board/xilinx/mbv/board.c
> > +++ b/board/xilinx/mbv/board.c
> > @@ -5,7 +5,16 @@
> >    * Michal Simek <michal.simek@amd.com>
> >    */
> >
> > +#include "../common/board.h"
> > +
> >   int board_init(void)
> >   {
> >       return 0;
> >   }
> > +
> > +#ifdef CONFIG_OF_BOARD_SETUP
> > +int ft_board_setup(void *blob, struct bd_info *bd)
> > +{
> > +     return ft_common_board_setup(blob, bd);
> > +}
> > +#endif
>
> Any reason not to put directly to board/xilinx/common/board.c?
> All xilinx boards are kept in sync from user perspective that's why gener=
ic
> pieces should be added to common location.

I assumed the device tree node "arm,pl353-nand-r2p1" was specific to boards
using xilinx/zynq/board.c since it seemed only those were the only ones to =
use
that node. Have any idea if that assumption is accurate?

>
>
> > diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/=
board.c
> > index 990ca1650a..bd674e6739 100644
> > --- a/board/xilinx/versal-net/board.c
> > +++ b/board/xilinx/versal-net/board.c
> > @@ -371,3 +371,10 @@ int dram_init(void)
> >   void reset_cpu(void)
> >   {
> >   }
> > +
> > +#ifdef CONFIG_OF_BOARD_SETUP
> > +int ft_board_setup(void *blob, struct bd_info *bd)
> > +{
> > +     return ft_common_board_setup(blob, bd);
> > +}
> > +#endif
> > diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> > index 8c2e614ad8..944ef2d822 100644
> > --- a/board/xilinx/versal/board.c
> > +++ b/board/xilinx/versal/board.c
> > @@ -320,3 +320,10 @@ enum env_location env_get_location(enum env_operat=
ion op, int prio)
> >               return ENVL_NOWHERE;
> >       }
> >   }
> > +
> > +#ifdef CONFIG_OF_BOARD_SETUP
> > +int ft_board_setup(void *blob, struct bd_info *bd)
> > +{
> > +     return ft_common_board_setup(blob, bd);
> > +}
> > +#endif
> > diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> > index 6c36591001..1ca1984c49 100644
> > --- a/board/xilinx/zynq/board.c
> > +++ b/board/xilinx/zynq/board.c
> > @@ -13,10 +13,12 @@
> >   #include <env.h>
> >   #include <env_internal.h>
> >   #include <fdtdec.h>
> > +#include <fdt_support.h>
> >   #include <fpga.h>
> >   #include <malloc.h>
> >   #include <memalign.h>
> >   #include <mmc.h>
> > +#include <mtd_node.h>
> >   #include <watchdog.h>
> >   #include <wdt.h>
> >   #include <zynqpl.h>
> > @@ -201,3 +203,18 @@ void set_dfu_alt_info(char *interface, char *devst=
r)
> >       puts("DFU alt info setting: done\n");
> >   }
> >   #endif
> > +
> > +#ifdef CONFIG_OF_BOARD_SETUP
> > +int ft_board_setup(void *blob, struct bd_info *bd)
> > +{
> > +#ifdef CONFIG_FDT_FIXUP_PARTITIONS
> > +     static const struct node_info nodes[] =3D {
> > +             { "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
>
> Very likely also depends on CONFIG_NAND_ZYNQ. It means pretty much you ca=
n move
> this code directly to common/board.c because only Zynq uses this symbol.
>
> Thanks,
> Michal
