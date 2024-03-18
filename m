Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B7DC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 17:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4843986EB5;
	Mon, 18 Mar 2024 18:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LOpyp7Z6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164DC87F63; Mon, 18 Mar 2024 17:18:01 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02440875E9
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 17:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-430ccb3d65eso8854441cf.2
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710778677; x=1711383477; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKcLvcVLAjpC3Zt82jWlNDdIT9CIqwBkKECXcL6qAeg=;
 b=LOpyp7Z6Tk5JuSKYn3rm9NctR8sGOf4g5Lf0g/mu+3L3BiTjRZrPAGOjJZ+HipEA2z
 tNd6ylusNhrOwBKbxCJ45m0aZtjSPCxMytu5z3evPtdH7qLbwCky70tpe24E+WQiwqlN
 VgL/Bcnh2Z8uO7m8dBjy9xNqlKSUBq6lYq6q95YTxOBYjWpl7NyrrqgVIKXphYn/7IeH
 P7M/noFOLmGz7hh9I1T7Qxk6HzrCqGGMVOr7yz2Ep6tkh+aKSXZm7d+XKuFxrUBA9fTt
 iIHvjhpM9KTMbruElQhDaGMOGdV9G5gy9w+CL0c3Gaia8QdaW/ZS73KitBKXtvkVULJY
 jX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778677; x=1711383477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKcLvcVLAjpC3Zt82jWlNDdIT9CIqwBkKECXcL6qAeg=;
 b=GXdYTf2cJEX90CZiU2OzIZujgoXPS/7EUGBktjlDpyBkEIrrVfkF1b/qDYDsTm6nJQ
 QnPyQN4clYRPtmiKI9Y0FyA1WXvrPBxTVROocwEPIy88ju09pJffr3Wy7upkrBqd0h5e
 qn75a0IRkEI8/ADWPC4OFqoj4LZ73yhE1kWiNxOh+RxxoazkBPzH5pk5j12Sy6XcfNY7
 cfHcWOBPMCb7C5XXGXxBCoi622s3nWbzJwDKOhRoLHTtR8L/oKIJRzbQ+APU8fg2eO6x
 wctzPNxx91fVs/oHTX7VqLNs0JKrS47crtVa1FlSQ0XWNVSQoTRG+guH9gAaAeBJNsQw
 F28Q==
X-Gm-Message-State: AOJu0Yy2e5cRut+9585xu6/Yy8+RRaa6rf7bn+DSCv8SXIfFm9MSXF6B
 pYLlj0LgiOv1+EpXKLW+CmTIAk3IX1V1yI5Nje8Ky/4ncPQF4CVLac9ECpFTKm7fOWuc1Vbt7gw
 OID3wJnls+IF8gfPxvwrCd+rGfIk=
X-Google-Smtp-Source: AGHT+IGtrHanT91p/CA3FgNH8i01w24pw/DcxcuxWwan30u74qDkahWPB939XbjwdVQInS4LhoiYZPHWD9O5N4WG8Lw=
X-Received: by 2002:ac8:5d8c:0:b0:42e:80ca:34e3 with SMTP id
 d12-20020ac85d8c000000b0042e80ca34e3mr15585797qtx.66.1710778676707; Mon, 18
 Mar 2024 09:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240315192528.464849-1-james.hilliard1@gmail.com>
 <03cf43b0-e9bc-4174-b9bf-3c380e388203@amd.com>
 <CADvTj4qiTZOf4kDj=v+5p89+-6JPoZRKQ2Vh+0SODS4=mQ=HtA@mail.gmail.com>
 <3699bad9-846e-493a-bbbb-436753ccb300@amd.com>
In-Reply-To: <3699bad9-846e-493a-bbbb-436753ccb300@amd.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 18 Mar 2024 10:17:44 -0600
Message-ID: <CADvTj4rc0hrJXXtjiV+oZwHYYeU7StvNM6wH+131ECtMz9zwmw@mail.gmail.com>
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
X-Mailman-Approved-At: Mon, 18 Mar 2024 18:43:33 +0100
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

On Mon, Mar 18, 2024 at 5:07=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 3/18/24 09:48, James Hilliard wrote:
> > On Mon, Mar 18, 2024 at 2:26=E2=80=AFAM Michal Simek <michal.simek@amd.=
com> wrote:
> >>
> >>
> >>
> >> On 3/15/24 20:25, James Hilliard wrote:
> >>> There are situations where we may want to let U-Boot modify the FDT
> >>
> >> please use imperative mood.
> >>
> >>> nand partitions for the kernel, such as when supporting multiple
> >>> sizes of NAND chips.
> >>>
> >>> Lets also refactor xilinx common board support to have a
> >>> ft_common_board_setup which gets called by the ft_board_setup for eac=
h
> >>> specific board so that we can add non-common functionality to each
> >>> ft_board_setup like FDT_FIXUP_PARTITIONS as needed.
> >>>
> >>> This pattern is modeled after the one used by tdx-common.c.
> >>>
> >>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >>> ---
> >>>    board/xilinx/common/board.c     |  2 +-
> >>>    board/xilinx/common/board.h     |  2 ++
> >>>    board/xilinx/mbv/board.c        |  9 +++++++++
> >>>    board/xilinx/versal-net/board.c |  7 +++++++
> >>>    board/xilinx/versal/board.c     |  7 +++++++
> >>>    board/xilinx/zynq/board.c       | 17 +++++++++++++++++
> >>>    board/xilinx/zynqmp/zynqmp.c    |  7 +++++++
> >>>    board/xilinx/zynqmp_r5/board.c  |  8 ++++++++
> >>>    8 files changed, 58 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.=
c
> >>> index 9641ed307b..629ba2b902 100644
> >>> --- a/board/xilinx/common/board.c
> >>> +++ b/board/xilinx/common/board.c
> >>> @@ -686,7 +686,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t =
total_size)
> >>>
> >>>    #ifdef CONFIG_OF_BOARD_SETUP
> >>>    #define MAX_RAND_SIZE 8
> >>> -int ft_board_setup(void *blob, struct bd_info *bd)
> >>> +int ft_common_board_setup(void *blob, struct bd_info *bd)
> >>>    {
> >>>        size_t n =3D MAX_RAND_SIZE;
> >>>        struct udevice *dev;
> >>> diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.=
h
> >>> index 64d657673e..73f576952a 100644
> >>> --- a/board/xilinx/common/board.h
> >>> +++ b/board/xilinx/common/board.h
> >>> @@ -18,4 +18,6 @@ bool board_detection(void);
> >>>    char *soc_name_decode(void);
> >>>
> >>>    bool soc_detection(void);
> >>> +
> >>> +int ft_common_board_setup(void *blob, struct bd_info *bd);
> >>>    #endif /* BOARD_XILINX_COMMON_BOARD_H */
> >>> diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
> >>> index ccf4395d6a..d8af1eaa90 100644
> >>> --- a/board/xilinx/mbv/board.c
> >>> +++ b/board/xilinx/mbv/board.c
> >>> @@ -5,7 +5,16 @@
> >>>     * Michal Simek <michal.simek@amd.com>
> >>>     */
> >>>
> >>> +#include "../common/board.h"
> >>> +
> >>>    int board_init(void)
> >>>    {
> >>>        return 0;
> >>>    }
> >>> +
> >>> +#ifdef CONFIG_OF_BOARD_SETUP
> >>> +int ft_board_setup(void *blob, struct bd_info *bd)
> >>> +{
> >>> +     return ft_common_board_setup(blob, bd);
> >>> +}
> >>> +#endif
> >>
> >> Any reason not to put directly to board/xilinx/common/board.c?
> >> All xilinx boards are kept in sync from user perspective that's why ge=
neric
> >> pieces should be added to common location.
> >
> > I assumed the device tree node "arm,pl353-nand-r2p1" was specific to bo=
ards
> > using xilinx/zynq/board.c since it seemed only those were the only ones=
 to use
> > that node. Have any idea if that assumption is accurate?
>
> Configuration around xilinx boards are quite generic. Normally nand contr=
oller
> is by default connected on Zynq SOC. But because chips are highly configu=
rable
> you can connect it also from Microblaze or Risc-V but
>
> I think you can simply do changes in common location and put there proper=
 ifs
> and it should be fine.
> Also keep in mind that you should avoid using #ifdef as much as possible =
and use
> if (IS_ENABLED(...)) instead.

Is there a way to do that with the static const struct node_info nodes[] pa=
rt?

>
> M
>
