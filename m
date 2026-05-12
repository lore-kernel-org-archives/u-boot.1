Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F45CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F003836AC;
	Tue, 12 May 2026 21:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="rHlF3KOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE512838BB; Tue, 12 May 2026 21:19:06 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002F08341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so919007666b.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613543; cv=none;
 d=google.com; s=arc-20240605;
 b=fmQzxbX6GzmtqTkLGe3flQvl20vGDRcZM+QyXKcPlI/Zy2EKvcQuu1uObAjDSsCTjb
 zSTvOlYvb/9ApslcMuTAvsqXKRj4meNq+OV1QWISdzlwtrdzsUqeRpqZAoJR8LJalAFi
 fdNmV5ESNkw0Q+V0Gf9lsXnM22i5o6PC38rbnGoOhc4WC3WDx08hGf11pQClI0g7Yk1s
 SoMe/zgS2mPEmjD2b4egxfzd8Y4Y33tLJZZ4PpT5dJk68lcYR1Tswz7YkygGFoM6h+m6
 +t63OThqkmANRTynl3J66hkarTnu1C/Z8qBi1MMRsVwWRv5I0OsPCCHoZpCkTAON/Epr
 O7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JH3HM+/4ctbbHOlMze61Za9VicDlN8xT70RmEOvmpC4=;
 fh=rNuKogUt7IUMFnW1CZevYXh+KXev1DPEPh4F5ZwdyGc=;
 b=C1fX5q7KPD/6TWJmGo0MZncEIP2W45GthoNgpwcdr2qVKKjAHdAaC7HCOT13xlbPCR
 mJIO0ESDaujt9KlCUghjCO3gp8EcwWz3Ic0fuHxrFE069nZQZHNmNsUtf+Z98kbfYp8Y
 FitLe7RznA4/PvdK9AgZhPvMWNG1vM1XMc+9YddmAlNw3+aBPPqZJEDjmzMyWtWypQsO
 zesH4RR7xWaABt+ZsEzyxl+9XX8q6k1uP+H1BgGM+mpM/eRbSdf/HqQbQIf7hL3Zns5X
 QdvvtYch5/UEHXIkJjEvsC9sCJ7d1GDiZgaHrxL5bgPSIvuztGgKvfcgZEf7Q0KbAN3x
 M9jQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778613543; x=1779218343; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH3HM+/4ctbbHOlMze61Za9VicDlN8xT70RmEOvmpC4=;
 b=rHlF3KOSIA2EiZ6vpWPOnnwmm3OH7le++MbTPeRt9D7dfSK46n0YMO5menhH8d08rp
 middJUW/ikPlHKOdE+RberXQZSlWXrcLp40wSp8YMP7KQHamhnCefky+ppmF3HTvz/Tb
 DllE/wm3Gyn723oWbi0rHsJ9cH9HrMRuotcoHoNyFmiEg1Mq8c/bNL/7suHF89MleAF1
 6RSu2+lcILirkratLXhXHUHiiBlHL2+BM5dJWxyRhKxA9I1z5czBsX08uHkLsaNaJ18q
 9uGvg8RmYlaz/j11B+ZQhilZvgM2nkQpzYMxlmpoxNa9NgM1hTx9Ro5ZjCuZYsWDHDK8
 XClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613543; x=1779218343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JH3HM+/4ctbbHOlMze61Za9VicDlN8xT70RmEOvmpC4=;
 b=KPM2W/N0euEK5qAgzyWVCq3xRsOPUKnCoEKiikA6+b/7JrZL5KbshFuU91EkEkw6nb
 CBWoVdFazYU27MhKtGPqIiT4H9l2j6zhfpWJib54IkVUJjhwfBdqOKeDXmHnuzUbvfEs
 4YD2HhtwE+NbMNFsGnTKEAHvYjlrejvsyFYsU8Lz9qSXMuhNVekqxsF1o4xwebjMZuHy
 gdGI/OuACEU9fXJVT7HnpgoBtE5JgeFgOtEFWjrjBSq2nkpLLlCJsc8gSmgw8Au/vSEJ
 cgPcbZvSYPuCWiB7/fLlJM2POwMQjSjdecGChS7p58OW3iYJzTgf117HEes4zB21RI9f
 Ol5g==
X-Gm-Message-State: AOJu0Yw+DO+rA1CI8OAkaQSJBJu/bJYSXTFtAHaMRsbxR61AB8Ka/R4q
 7th+tql90Xk3m9I0mAR1I7x+G+Qj+408knOdKcIEp0tnyEsqyBj4YxUzz/2RjJZm/7Y92IMGo17
 SCFMbm2B7yahLGPlJGb7NrVA+vbcq4Stjp7T1A2N6/zKNpd/CbvVJruA=
X-Gm-Gg: Acq92OES7r9OJ3BKbvo+kpdsUxaG40GKP7COd51QIyuR+0h+RIls8UzPT5IpNn4FGTz
 lGcg8RwlLSzomfxR6SSzx9fdda3qCiMdkgBrlazOciGX7Z7rJui+3qy1BU+gqVIvzpJ5FX3qvcO
 YXS33LNNSL8woZVc8++tXnCoRJZ47KWbldqMMn+e5aGRSfc6818mu3yB2VE2vDsij4SsJt082Xc
 YuwiJVXZtMmxQQx7J7SAZbRqwRrgdb2tIaDCw/znLAN2ZKel/XxJoL3zwXfFS4MS46jGwSAoMgL
 M6wIOiqDcYUTlBtyteAf4bqhpHGgjmIDob2fngVY
X-Received: by 2002:a17:907:930b:b0:bd3:a7df:d32f with SMTP id
 a640c23a62f3a-bd3c182e352mr5810866b.41.1778613542967; Tue, 12 May 2026
 12:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
In-Reply-To: <20260311-rk3576-ufs-v6-0-c7c353739242@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 12 May 2026 23:18:51 +0400
X-Gm-Features: AVHnY4JOJ27Pnhg9pVONSiSR-IPNQOnTtzuao2tj2jBlUwRMHkiMtvvk_sFY8N8
Message-ID: <CAKTNdwG1bWJb_d_7yzqFAHHhLPCFRaP3y6_Jw9HJ4ohWT9dyhQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Enable full UFS boot on Rockchip RK3576
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Dhruva Gole <d-gole@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@gmail.com>
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

On Wed, Mar 11, 2026 at 5:31=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> Rockchip RK3576 can load its bootloader from UFS among other options,
> so this series adds the necessary bits and pieces to enable an end-to-end
> boot from UFS (boot ROM -> SPL -> U-boot proper -> kernel).
>
> This series contains the Rockchip-specific code to enable UFS boot in SPL=
,
> and relies on the architecture-independent bits [1], [2] already applied
> by Neil Armstrong to the u-boot-ufs custodian tree.
>
> It also depends on the recent addition of Rockchip-specific code to allow
> DMA writes to PMU SRAM by Jonas Karlman [3] already applied by Kever Yang
> to the u-boot-rockchip custodian tree.
>
> To achieve the above, this series goes through the following:
>  - Patches 1-2 cherry-pick recent additions to the upstream DTS files
>    required to properly configure the pin mode for the UFS device reset
>    pin on RK3576, as well as enable the UFSHC node on the NanoPi M5 board
>  - Patch 3 adds an option to build the Rockchip reset driver for SPL
>  - Patch 4 ties it all together for Rockchip RK3576
>  - Patches 5-6 update defconfigs for two example boards to enable UFS boo=
t
>
> This has been tested on a FriendlyElec NanoPi M5 board with a Biwin
> BWU3AKC46C256G UFS module.
>
> Note that in my experience none of the RK3576 boards actually boot curren=
t
> mainline U-boot versions without a single-word SRAM write before jumping
> to DDR initialization, as done in Kwiboo's commit at [4]. Therefore, to
> test this series I additionally applied commits 117cd97627fd..04e6417226f=
5
> from Kwiboo's rk3576 branch [5] (including 117cd97627fd), so any testers
> might want to:
>
> git cherry-pick 117cd97627fd^..04e6417226f5
>
> from there before or after applying this series
>
> [1] https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/8ce3df3e=
be6b8c0022a0c79780a2e1ce3e1c792a
> [2] https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/42dd7a5a=
e1b166127766ce7e39f98badb311e56d
> [3] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/commit/401=
5faa32342fd9c494c318c21de106f98dd4674
> [4] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/04e=
6417226f50e4e3cb04272280922eb425c18ab
> [5] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk=
3576?ref_type=3Dheads
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v6:
> - Dropped patches already applied by Neil to the u-boot-ufs custodian tre=
e (thanks Neil)
> - Rebased to current next (thanks Jonas)
> - Fixed the dependency on SPL_CLK instead of CLK for the SPL reset driver=
 (thanks Jonas)
> - Included newly required DT nodes into bootph-* filters for the u-boot-s=
pl.dtb (thanks Jonas)
> - Cherry-picked the relevant DTS additions from devicetree-rebasing (than=
ks Jonas)
> - Added a preprocessor conditional around the GPIO4 bootph-* node to avoi=
d its inclusion
>   without CONFIG_SPL_UFS_SUPPORT (thanks Jonas)
> - Added relevant defconfig changes for Rock 4D and NanoPi M5 (thanks Jona=
s)
> - Link to v5: https://lore.kernel.org/r/20260120-rk3576-ufs-v5-0-0edb61b3=
01b7@gmail.com
>
> Changes in v5:
> - Reverse X-mas tree in spl_ufs:spl_ufs_load_image (thanks Quentin)
> - Explicit "depends on UFS" from CONFIG_SPL_UFS_SUPPORT (thanks Quentin).
>   This also pulls in SCSI to avoid compilation errors.
> - Split out the patch enabling the Rockchip reset driver for SPL builds
>   (thanks Quentin)
> - Reworded the error message when requesting the UFS reset GPIO fails
>   (thanks Quentin)
> - Added a note in the commit message about reset-gpios being required by
>   the DT binding (thanks Quentin)
> - Dropped the redundant check of GPIO validity in the reset function
>   (thanks Quentin)
> - Added a note about GPIO4_D0 being the only GPIO usable for UFS reset
>   on RK3576 (thanks Shawn)
> - Dropped "imply" symbols from the arch Kconfig, now that both GPIO
>   and RESET drivers are explicitly depended on from the UFS driver
>   (thanks Quentinq)
> - Link to v4: https://lore.kernel.org/r/20260108-rk3576-ufs-v4-0-e8e67649=
f3f8@gmail.com
>
> Changes in v4:
> - Added a dependency in b4 metadata on Jonas' new series enabling DMA
>   writes to PMU SRAM (thanks Jonas)
> - Dropped the bounce buffer quirk altogether, as it now works as-is
> - Link to v3: https://lore.kernel.org/r/20260106-rk3576-ufs-v3-0-bfe259fd=
6d17@gmail.com
>
> Changes in v3:
> - Added a UFSHC quirk to use the SCSI bounce buffer for addresses outside
>   SDRAM, and enabled it on Rockchip (thanks Neil and Tom)
> - Dropped the open-coded bounce buffer from spl_ufs.c, now unneeded
> - Link to v2: https://lore.kernel.org/r/20260105-rk3576-ufs-v2-0-caba979a=
0d6b@gmail.com
>
> Changes in v2:
> - Rename the SPL UFS read helper function more self-descriptively (thanks=
 Neil)
> - Add an option to configure the UFS LUN used to look for the U-boot imag=
e
>   in raw offset mode - or rather the SCSI device number, which most of th=
e
>   time coincides with the UFS LUN as long as the UFS device is the only
>   SCSI block device the SPL sees (thanks Neil)
> - Add an option to use a bounce buffer in RAM while loading U-boot from U=
FS,
>   which helps avoid changes to common spl_fit.c code which in v1 achieved=
 a
>   similar result at a performance cost to unrelated platforms (thanks Jon=
as)
> - Link to v1: https://lore.kernel.org/r/20251210-rk3576-ufs-v1-0-a3f9e76e=
b66e@gmail.com
>
> ---
> Alexey Charkov (5):
>       arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
>       arm64: dts: rockchip: enable UFS controller on FriendlyElec NanoPi =
M5
>       reset: rockchip: make device resets available in SPL
>       rockchip: spl: Add support for booting from UFS
>       rockchip: rk3576-nanopi-m5: Enable UFS support
>
> Jonas Karlman (1):
>       rockchip: rk3576-rock-4d: Enable UFS support
>
>  arch/arm/dts/rk3576-u-boot.dtsi                    | 33 ++++++++++++++++=
+++++-
>  arch/arm/include/asm/arch-rockchip/bootrom.h       |  1 +
>  arch/arm/mach-rockchip/rk3576/rk3576.c             |  1 +
>  arch/arm/mach-rockchip/spl-boot-order.c            | 14 +++++++++
>  configs/nanopi-m5-rk3576_defconfig                 |  7 +++++
>  configs/rock-4d-rk3576_defconfig                   |  7 +++++
>  drivers/reset/Kconfig                              |  9 ++++++
>  drivers/reset/Makefile                             |  2 +-
>  .../src/arm64/rockchip/rk3576-nanopi-m5.dts        | 24 ++++++++++++++++
>  .../src/arm64/rockchip/rk3576-pinctrl.dtsi         |  7 +++++
>  dts/upstream/src/arm64/rockchip/rk3576.dtsi        |  2 +-
>  11 files changed, 104 insertions(+), 3 deletions(-)

Hi Kever,

Gentle ping regarding this series. Would you mind applying it? Shall I
rebase and resend?

Best regards,
Alexey
