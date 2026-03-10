Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8C7FD2D71
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 12:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E20783F2A;
	Tue, 10 Mar 2026 13:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNsYnrQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B53583FC1; Tue, 10 Mar 2026 13:56:14 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D038A83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50917e02472so25154271cf.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 05:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773147367; cv=none;
 d=google.com; s=arc-20240605;
 b=XycJc8zPw38Br4Zq4DxH3RFRNu/75q0o8dn+x3/McC2LdhuW1rTnn4Wl0Z0p9pnkvG
 HO8YRPdQJvoNfo7KCGmYJYJ1ERrCakfiyckcCd6TUDLszqngLapmCB50Mu+cAl7mgNJZ
 wjgttuGJkRC6lS7VnpHW+8Kj3oPnaZZS7Zwo/ps1BanQUVT6vtIiISYc7hX32GOHXLbO
 uVFyEz91RRIHQKOf976lVZG+zA1VqysGnus70BJINyTUTaviwdfO5YmFa82LIEodMhde
 IJqb5fXUkDaf533C4E86omerbYW/KZ1FiFXICC4dMlFxD0CUALjxCU48/u6pbcLY8Bt6
 Pu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G0GSikhkEIAR1Lh1IpE3SsQaZ+RXwhu0NH1+QkXBYrs=;
 fh=Ssk0TPcabL2SWHJqERTg4slOwjaUGbQildHEHdDBtfM=;
 b=axDM9JcjeOfUOCY5TuvP01jHAp95YcCngKED+Nu5K1YbuxY10CFqcEEpE3WmaKINoh
 RXVTiqQej5LhIGKgMphBtY1253qOSqO3GI2RvXhC0nJ/UsooVGeYO7tpSbGV/YWKV0RD
 FfeRhxOmGac6bRm8dx+mpXWicQc2jPvTwFk2SqXgamw3ld3Vzl/8lMqypNRXNJZ8ReW/
 AigM9QPc+TgrtiYnA9XIGYQwQ1FIZEJUNw3ToP2VJ9d31lzXxRUWn+MSb+hWmt99VWQQ
 g5yecKCH/oAtxqNPN7NY+7rUOWVZJYaYVGXTmKQ/xPCU2cDykSqM0NNvXt5Fyagox/7S
 454g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773147366; x=1773752166; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0GSikhkEIAR1Lh1IpE3SsQaZ+RXwhu0NH1+QkXBYrs=;
 b=TNsYnrQ7g7UXKO9L9wD9yakG0ppXClBKArWlbwhaAu6wxsaTK1JN7HZ8N+2jVmQumP
 13QtU036Tz5zq/7oEO8gr7VO14teAMIkZkf4lvqkc+zwe8MsAuq7WiwZT9STWvViJQsF
 tyoDt37+hiWd1DL8KM3GTBZJDJv4kW4IrHg0fSRCC6d/zYJzh8/8AB5GYCsTWMZz/SjK
 qkdlMtnJRSV0rt+rKDKYSOgDrWPsum3o9+GWPOlYZz9BlYDTK7h9K4QkiJSJYZa3F4/e
 4VPwbAOID4n9yj/TqStTNlpFCiz0L1mBEmggBNSwTfkjfszTIQVLBVd9DfGAT6lEKlxg
 rvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773147366; x=1773752166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G0GSikhkEIAR1Lh1IpE3SsQaZ+RXwhu0NH1+QkXBYrs=;
 b=XjACqVfzpVGlWyZYcD1UOfjrI+G/VD4nK4R/UJR907UmU2ogkI7hoQMior/VP6Naqx
 6OJ+EPm3sUbTYxO870hB1+V1V7JFQ9eSJyyolbYO6+97o8jhI0XoU+syqgCMJGWgyr1Z
 1JBNeRbsUztWnxDhVG+BRVpbhVULjKMNIQQ92xRU74NXmsimJDSTqsu3pwIngbJFAJfT
 dMEwM1k2aQvrvJ3lpgtG42Llr5YBdQEqS/5/pgLwfv1+qV9wjFBN45KxrYmfPHC/Qhni
 +M0ILtDDEJuvoLTDeGqg9zBtxFJOHlXEiploybi8DIePq9ZKk9/cGknVf+t3bp87joz+
 5rIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbIAWwbXAU+k2eccWXchAa2XfiGw3iC7n97JT/3C+cYxvA/O5h9RurAsIiBjhirUG2y1MSBqk=@lists.denx.de
X-Gm-Message-State: AOJu0YzbaxdvFJqYc9xb1bDkalTyqRKXkLQe3LGC/VFeYibNRRSAGAfd
 NNG26PYNTzKE8gZslwFPRHMwHYDmV+NqVJfkU09N9wRNuoKsJGHJuJZFhGLy22L86D050E1iYvY
 2XP2Q1FC7OyEkZzijaFtbiMZ/u2PzDjC2MELoOlo=
X-Gm-Gg: ATEYQzwfX3D2PKblGFXd3d6Hsh3LTzzYCbIHNYRnsXfyAXlTeof3ulXGDJ2L8OupxMH
 pYG4yuD72TlHNuWNVzHNZx9cjuN1KRSaccDtRfqMIiliiV3/D8uAr8XQkG2bbzsaTkv/uyZEnBJ
 LrVVDJNx++/8e1hLPjlFnIQLHxjmLqHkEa4QSPyiROVyEhVL+z4cP9OOjn//bywOF6X5pSySgRz
 e/sX37xk42P+1bYjv6V3F/f/BmtIDV4RusPNRKJTXdXmLu46kDh6IPnpTSoJAdeMnoAjR4PH44c
 nZoOdUI=
X-Received: by 2002:ac8:7dc1:0:b0:4ef:db28:1f3b with SMTP id
 d75a77b69052e-508f46e1644mr188258271cf.16.1773147366423; Tue, 10 Mar 2026
 05:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260120-rk3576-ufs-v5-0-0edb61b301b7@gmail.com>
 <CABjd4Yz6J_uQG5WknghbhEWcxzL1G4BirLG37QMT1-OTdjzWRg@mail.gmail.com>
 <6ae16959-38ef-4fd6-82e0-20d278bc7745@kwiboo.se>
In-Reply-To: <6ae16959-38ef-4fd6-82e0-20d278bc7745@kwiboo.se>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 10 Mar 2026 16:55:55 +0400
X-Gm-Features: AaiRm52eMv-1EI63YCCirEk2ircjyNMm1GcRh9jGivwAkODCKiWVK5pdk9DmX60
Message-ID: <CABjd4Yx6gp0zJMJJ82cqT=p=0+eBSaagePguS0OR_XW1PSSroQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Enable full UFS boot on Rockchip RK3576
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 10, 2026 at 4:23=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 3/10/2026 9:44 AM, Alexey Charkov wrote:
> > On Tue, Jan 20, 2026 at 10:09=E2=80=AFPM Alexey Charkov <alchark@gmail.=
com> wrote:
> >>
> >> Rockchip RK3576 can load its bootloader from UFS among other options,
> >> so this series adds the necessary bits and pieces to enable an end-to-=
end
> >> boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).
> >>
> >> To achieve the above, this series goes through the following:
> >>  - Patch 1 introduces arch-independent code to enable SPL images to us=
e
> >>    UFS devices, including build system tweaks and a function to locate
> >>    a U-boot image at a fixed UFS offset and LUN (SCSI device number)
> >>  - Patch 2 adds an option to build the Rockchip reset driver for SPL
> >>  - Patch 3 adds device-reset functionality to the Rockchip UFS glue co=
de,
> >>    which is required for (at least some) UFS modules to respond to
> >>    controller commands upon initial enumeration
> >>  - Patch 4 ties it all together for Rockchip RK3576
> >>
> >> This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
> >> BWU3AKC46C256G UFS module. Note that booting directly from UFS masks t=
he
> >> issue which patch 3 aims to address, because the boot ROM initializes =
the
> >> UFS module before handing over to U-boot. If, however, one boots SPL f=
rom
> >> FSPI1 with the same driver code, the module fails to respond unless pa=
tch
> >> 3 is applied.
> >>
> >> This depends on Jonas' recent series [3] enabling DMA writes to PMU SR=
AM,
> >> without which the UFS controller will fail to load ATF and end up in a=
n
> >> unrecoverable error state requiring a hard reset.
> >>
> >> Note that in my experience none of the RK3576 boards actually boot cur=
rent
> >> mainline U-boot versions without a single-word SRAM write before jumpi=
ng
> >> to DDR initialization, as done in Kwiboo's commit at [1]. Therefore, t=
o
> >> test this series I additionally applied commits 6b152999908b..d43031c4=
045e
> >> from Kwiboo's rk3576 branch [2] (including 6b152999908b), so any teste=
rs
> >> might want to:
> >>
> >> git cherry-pick 6b152999908b^..d43031c4045e
> >>
> >> from there before or after applying this series
> >>
> >> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/=
d43031c4045ef8aaf29c467b910207e721dabce0
> >> [2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits=
/rk3576?ref_type=3Dheads
> >> [3] https://lore.kernel.org/all/20260108133234.4001390-1-jonas@kwiboo.=
se/
> >>
> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> ---
> >> Changes in v5:
> >> - Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
> >> - Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quenti=
n).
> >>   This also pulls in SCSI to avoid compilation errors.
> >> - Split out the patch enabling the Rockchip reset driver for SPL build=
s
> >>   (thanks Quentin)
> >> - Reworded the error message when requesting the UFS reset GPIO fails
> >>   (thanks Quentin)
> >> - Added a note in the commit message about reset-gpios being required =
by
> >>   the DT binding (thanks Quentin)
> >> - Dropped the redundant check of GPIO validity in the reset function
> >>   (thanks Quentin)
> >> - Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
> >>   on RK3576 (thanks Shawn)
> >> - Dropped "imply" symbols from the arch Kconfig, now that both GPIO
> >>   and RESET drivers are explicitly depended on from the UFS driver
> >>   (thanks Quentinq)
> >> - Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67=
649f3f8@gmail.com
> >>
> >> Changes in v4:
> >> - Added a dependency in b4 metadata on Jonas' new series enabling DMA
> >>   writes to PMU SRAM (thanks Jonas)
> >> - Dropped the bounce buffer quirk altogether, as it now works as-is
> >> - Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe25=
9fd6d17@gmail.com
> >>
> >> Changes in v3:
> >> - Added a UFSHC quirk to use the SCSI bounce buffer for addresses outs=
ide
> >>   SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
> >> - Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
> >> - Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba9=
79a0d6b@gmail.com
> >>
> >> Changes in v2:
> >> - Rename the SPL UFS read helper function more self-descriptively (tha=
nks Neil)
> >> - Add an option to configure the UFS LUN used to look for the U-boot i=
mage
> >>   in raw offset mode - or rather the SCSI device number, which most of=
 the
> >>   time coincides with the UFS LUN as long as the UFS device is the onl=
y
> >>   SCSI block device the SPL sees (thanks Neil)
> >> - Add an option to use a bounce buffer in RAM while loading U-boot fro=
m UFS,
> >>   which helps avoid changes to common spl_fit.c code which in v1 achie=
ved a
> >>   similar result at a performance cost to unrelated platforms (thanks =
Jonas)
> >> - Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e=
76eb66e@gmail.com
> >>
> >> ---
> >> Alexey Charkov (4):
> >>       spl: Make UFS available for SPL builds
> >>       reset: rockchip: make device resets available in SPL
> >>       ufs: rockchip: Add device reset support
> >>       rockchip: spl: Add support for booting from UFS
> >>
> >>  MAINTAINERS                                  |  1 +
> >>  arch/arm/dts/rk3576-u-boot.dtsi              | 16 ++++++++-
> >>  arch/arm/include/asm/arch-rockchip/bootrom.h |  1 +
> >>  arch/arm/include/asm/spl.h                   |  1 +
> >>  arch/arm/mach-rockchip/rk3576/rk3576.c       |  1 +
> >>  arch/arm/mach-rockchip/spl-boot-order.c      | 14 ++++++++
> >>  common/spl/Kconfig                           | 30 +++++++++++++++++
> >>  common/spl/Makefile                          |  1 +
> >>  common/spl/spl_ufs.c                         | 49 +++++++++++++++++++=
+++++++++
> >>  drivers/Makefile                             |  1 +
> >>  drivers/reset/Kconfig                        |  9 +++++
> >>  drivers/reset/Makefile                       |  2 +-
> >>  drivers/scsi/Makefile                        |  3 ++
> >>  drivers/ufs/Kconfig                          |  4 +++
> >>  drivers/ufs/ufs-rockchip.c                   | 22 +++++++++++++
> >>  drivers/ufs/ufs-rockchip.h                   |  1 +
> >>  lib/Makefile                                 |  1 +
> >>  17 files changed, 155 insertions(+), 2 deletions(-)
> >> ---
> >> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> >> change-id: 20251210-rk3576-ufs-ac3bf4e87156
> >> prerequisite-message-id: 20260108133234.4001390-1-jonas@kwiboo.se
> >> prerequisite-patch-id: 3748e3880ac841dc25628911608140ebb4d4382f
> >> prerequisite-patch-id: 671586e63ec9021b624d6cdc3b75aef53ed84972
> >
> > Hi Neil, Kever,
> >
> > Now that Kever has applied the patch from Jonas [1] which lets this
> > one work without bounce buffers on Rockchip RK3576, would you mind
> > giving this series another look?
> >
> > Please let me know if I should rebase / resubmit / adjust in any way.
> > Would be great to have it merged.
>
> I will test and review this later today, I think we may need to include
> the gpio/pinctrl fix in u-boot.dtsi until it has fully landed i
> dts/upstream, or possible add a bootph props in soc u-boot.dtsi.

Thanks Jonas!

The pinctrl fix is already in Linus' tree [1], so I think we can just
cherry-pick it via ./tools/update-subtree.sh? Then overwrite it
seamlessly at the next rebase of dts/upstream.

It isn't strictly required to make it boot though, because the boot
ROM will leave the UFS controller in a magically-working state if it
uses UFS to load the TPL+SPL. It's only needed if you load TPL+SPL
from e.g. FSPI and then want to jump to U-boot proper from UFS (which
is a more niche use case).

> Maybe it would make sense to also enable UFS booting on a board as
> part of this series? E.g. on the NanoPi M5 and/or ROCK 4D?

Any board which enables &ufshc in its DTS should only need a config
change to make use of this stuff. Happy to add it to defconfigs. The
required bits are (based on my local changes to the NanoPi M5
defconfig):

+CONFIG_SPL_GPIO=3Dy
+CONFIG_SPL_DM_RESET=3Dy
+CONFIG_SPL_UFS_SUPPORT=3Dy
+CONFIG_CMD_UFS=3Dy
+CONFIG_SCSI=3Dy
+CONFIG_UFS=3Dy
+CONFIG_UFS_ROCKCHIP=3Dy

Best regards,
Alexey

[1] https://github.com/torvalds/linux/commit/79a3286e61829fc43abdd6e3beb31b=
24930c7af6
