Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E979C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 07:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3878818A;
	Fri, 22 Mar 2024 08:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="D0luM4zc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BF88818A; Fri, 22 Mar 2024 08:58:46 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79A3880F8
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V1F7y6t0cz9smk;
 Fri, 22 Mar 2024 08:58:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1711094319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60aIjA1Sm5UGUTuHoN+/0RmYmO4s7fVEqpba2emEPHw=;
 b=D0luM4zcQ8lWOae7B+eLCE2kVjmoqQfoFGH0Y14lXZWikUvRqMWD1A1ic7WRPOdq+s83Qh
 MW4BWOSpf5pBnidytLgTusfdWFxGXjJYxmfCgaqo05CRzSeNc4UPiHwQjy7IC9Twkh2hVn
 Qyle4ql5Yf1bwG1pgW8sbdMyPO0MCF04F5ZDMEaWusNY7UHdbPYfSf9cRSGxXncAadfpCm
 TpA1M8Tc1zZgRoUJyaBZJuyNE12xny2T7mLQ3KB/WUPOuM4Svp5kuAgK2H91Hbj4dfbEKz
 oYwzW3EBtHmuKLazUw/9ghVi/uSPmdL8VryHyj5yb6BX5jQGlHZ3mh5L/yxOdw==
Message-ID: <3198bc42918d1d25acaf1889489b5879653f25c8.camel@steffen.cc>
Subject: Re: [PATCH 2/5] mmc: zynq-sdhci: refactor tapdelay settings
From: Steffen Dirkwinkel <lists@steffen.cc>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "Kumar, Love"
 <love.kumar@amd.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker
 <jbx6244@gmail.com>,  "Simek, Michal" <michal.simek@amd.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Date: Fri, 22 Mar 2024 08:58:25 +0100
In-Reply-To: <SA1PR12MB86972BBDF8A3A93B6A6475A698282@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240223140613.1240570-1-lists@steffen.cc>
 <20240223140613.1240570-2-lists@steffen.cc>
 <6dfdaf59-156e-40db-9130-4d62e6e5e8e3@amd.com>
 <9301f4ea37a01b3090bd786e1954cdba42a6d20e.camel@dirkwinkel.cc>
 <SA1PR12MB86972BBDF8A3A93B6A6475A698282@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4V1F7y6t0cz9smk
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

Hi Venkatesh,

we're not using the firmware when running in el3, so that should still
work. The sdhci driver needs to know which controller it's operating on
and uses the power-domain node for that. I can't add the power domain
node without a firmware node (i think?), but the firmware node without
a compatible shouldn't be used by anything?

Alternatively we could exit without an error from these functions if
our node id doesn't match sd0 or sd1. That wouldn't apply any settings,
but that's the current behaviour already.

Thanks
Steffen

On Fri, 2024-03-15 at 09:52 +0000, Abbarapu, Venkatesh wrote:
> Hi Steffen,
> For mini u-boot cases ZYNQMP_FIRMWARE config is disabled as there
> won't be any ATF(TF-A) present.
>=20
> Thanks
> Venkatesh
>=20
> > -----Original Message-----
> > From: Steffen Dirkwinkel <lists@steffen.cc>
> > Sent: Thursday, March 14, 2024 1:23 PM
> > To: Kumar, Love <love.kumar@amd.com>; u-boot@lists.denx.de
> > Cc: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>; Ashok
> > Reddy Soma <ashok.reddy.soma@amd.com>; Jaehoon Chung
> > <jh80.chung@samsung.com>; Johan Jonker <jbx6244@gmail.com>; Simek,
> > Michal <michal.simek@amd.com>; Peng Fan <peng.fan@nxp.com>; Tom
> > Rini
> > <trini@konsulko.com>; Abbarapu, Venkatesh
> > <venkatesh.abbarapu@amd.com>
> > Subject: Re: [PATCH 2/5] mmc: zynq-sdhci: refactor tapdelay
> > settings
> >=20
> > Hi Love,
> >=20
> > On Thu, 2024-03-14 at 12:15 +0530, Love Kumar wrote:
> > > Hi,
> > >=20
> > > When we run in el3 for zynqmp board, we are seeing below issue
> > > with
> > > this
> > > patch:
> > >=20
> > >=20
> > > Model: ZynqMP MINI EMMC0
> > > Board: Xilinx ZynqMP
> > > DRAM:=C2=A0 512 MiB
> > > EL Level:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EL3
> > > Secure Boot:=C2=A0=C2=A0 not authenticated, not encrypted
> > > Multiboot:=C2=A0=C2=A0=C2=A0=C2=A0 0
> > > Core:=C2=A0 10 devices, 9 uclasses, devicetree: embed
> > > MMC:=C2=A0=C2=A0 sdhci@ff160000: 0
> > > Loading Environment from <NULL>... OK
> > > In:=C2=A0=C2=A0=C2=A0 dcc
> > > Out:=C2=A0=C2=A0 dcc
> > > Err:=C2=A0=C2=A0 dcc
> > > ZynqMP> mmc list
> > > sdhci@ff160000: 0
> > > ZynqMP> mmc dev 0 0
> > > arasan_sdhci sdhci@ff160000: Error setting Input Tap Delay
> > > sdhci_set_clock: Error while setting tap delay
> > > sdhci_send_command: Timeout for status update: 00000000 00000001
> > > ZynqMP>
> >=20
> > Thank you for testing this.
> > It looks like the zynqmp-mini-emmc0 device lacks the power-domain
> > node
> > and doesn't have a sd node id. The code before my change would have
> > ignored the unknown node id, applied settings for sdhci1 instead of
> > sdhci0
> > and returned without an error. Maybe there's a different way to
> > find out
> > which sdhci we want to operate on?
> >=20
> > Can you try setting the node id in device tree?
> > Something like this:
> >=20
> > diff --git a/arch/arm/dts/zynqmp-mini-emmc0.dts
> > b/arch/arm/dts/zynqmp-
> > mini-emmc0.dts
> > index 02e80bd85e1..87c4a1b6ad0 100644
> > --- a/arch/arm/dts/zynqmp-mini-emmc0.dts
> > +++ b/arch/arm/dts/zynqmp-mini-emmc0.dts
> > @@ -7,6 +7,8 @@
> > =C2=A0 * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com=
>
> > =C2=A0 */
> >=20
> > +#include <dt-bindings/power/xlnx-zynqmp-power.h>
> > +
> > =C2=A0/dts-v1/;
> >=20
> > =C2=A0/ {
> > @@ -41,6 +43,12 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 clock-frequency =3D <200000000>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 zynqmp_firmware: zynqmp-firmware {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #power-doma=
in-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amba: amba {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 compatible =3D "simple-bus";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
> > @@ -56,6 +64,7 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =
=3D <0x0 0xff160000 0x0 0x1000>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock=
-names =3D "clk_xin", "clk_ahb";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock=
s =3D <&clk_xin &clk_xin>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power-domai=
ns =3D <&zynqmp_firmware PD_SD_0>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > =C2=A0};
> >=20
> > Thanks,
> > Steffen
> >=20
> > >=20
> > > Regards,
> > > Love Kumar
> > >=20
> > > On 23/02/24 7:36 pm, Steffen Dirkwinkel wrote:
> > > > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > >=20
> > > > Previously we were setting in tapdelay for SD1 every time even
> > > > if
> > > > SD0 was requested.
> > > > The SD tapdelay settings are shifted by 16 bits between SD0 and
> > > > SD1.
> > > > We can use that to make our tapdelay setup simpler. This is
> > > > also how
> > > > it currently works in arm-trusted-firmware.
> > > >=20
> > > > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > > ---
> > > >=20
> > > > =C2=A0 drivers/mmc/zynq_sdhci.c | 65
> > > > +++++++++++++++++-----------------------
> > > > =C2=A0 1 file changed, 28 insertions(+), 37 deletions(-)
> > > >=20
> > > > diff --git a/drivers/mmc/zynq_sdhci.c
> > > > b/drivers/mmc/zynq_sdhci.c
> > > > index 935540d1719..d4845245b2a 100644
> > > > --- a/drivers/mmc/zynq_sdhci.c
> > > > +++ b/drivers/mmc/zynq_sdhci.c
> > > > @@ -42,14 +42,11 @@
> > > > =C2=A0 #define SD_OTAP_DLY			0xFF180318
> > > > =C2=A0 #define SD0_DLL_RST			BIT(2)
> > > > =C2=A0 #define SD1_DLL_RST			BIT(18)
> > > > +#define SD1_TAP_OFFSET			16
> > > > =C2=A0 #define SD0_ITAPCHGWIN			BIT(9)
> > > > -#define SD1_ITAPCHGWIN			BIT(25)
> > > > =C2=A0 #define SD0_ITAPDLYENA			BIT(8)
> > > > -#define SD1_ITAPDLYENA			BIT(24)
> > > > =C2=A0 #define SD0_ITAPDLYSEL_MASK		GENMASK(7, 0)
> > > > -#define SD1_ITAPDLYSEL_MASK		GENMASK(23, 16)
> > > > =C2=A0 #define SD0_OTAPDLYSEL_MASK		GENMASK(5, 0)
> > > > -#define SD1_OTAPDLYSEL_MASK		GENMASK(21, 16)
> > > >=20
> > > > =C2=A0 #define MIN_PHY_CLK_HZ			50000000
> > > >=20
> > > > @@ -275,44 +272,32 @@ static int arasan_sdhci_config_dll(struct
> > > > sdhci_host *host, unsigned int clock,
> > > > =C2=A0 static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id,
> > > > u32
> > > > itap_delay)
> > > > =C2=A0 {
> > > > =C2=A0=C2=A0	int ret;
> > > > +	u32 shift;
> > > >=20
> > > > -	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() =3D=3D 3)
> > > > {
> > > > -		if (node_id =3D=3D NODE_SD_0) {
> > > > -			ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > SD0_ITAPCHGWIN,
> > > > -
> > > > 						SD0_ITAPCHGWIN);
> > > > -			if (ret)
> > > > -				return ret;
> > > > -
> > > > -			ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > SD0_ITAPDLYENA,
> > > > -
> > > > 						SD0_ITAPDLYENA);
> > > > -			if (ret)
> > > > -				return ret;
> > > > -
> > > > -			ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > SD0_ITAPDLYSEL_MASK,
> > > > -						itap_delay);
> > > > -			if (ret)
> > > > -				return ret;
> > > > +	if (node_id =3D=3D NODE_SD_0)
> > > > +		shift =3D 0;
> > > > +	else if (node_id =3D=3D NODE_SD_1)
> > > > +		shift =3D SD1_TAP_OFFSET;
> > > > +	else
> > > > +		return -EINVAL;
> > > >=20
> > > > -			ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > SD0_ITAPCHGWIN, 0);
> > > > -			if (ret)
> > > > -				return ret;
> > > > -		}
> > > > -		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > > > SD1_ITAPCHGWIN,
> > > > -					SD1_ITAPCHGWIN);
> > > > +	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() =3D=3D 3)
> > > > {
> > > > +		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > > > SD0_ITAPCHGWIN
> > << shift,
> > > > +					SD0_ITAPCHGWIN <<
> > > > shift);
> > > > =C2=A0=C2=A0		if (ret)
> > > > =C2=A0=C2=A0			return ret;
> > > >=20
> > > > -		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > > > SD1_ITAPDLYENA,
> > > > -					SD1_ITAPDLYENA);
> > > > +		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > > > SD0_ITAPDLYENA <<
> > shift,
> > > > +					SD0_ITAPDLYENA <<
> > > > shift);
> > > > =C2=A0=C2=A0		if (ret)
> > > > =C2=A0=C2=A0			return ret;
> > > >=20
> > > > -		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > SD1_ITAPDLYSEL_MASK,
> > > > -					(itap_delay << 16));
> > > > +		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > SD0_ITAPDLYSEL_MASK << shift,
> > > > +					itap_delay << shift);
> > > > =C2=A0=C2=A0		if (ret)
> > > > =C2=A0=C2=A0			return ret;
> > > >=20
> > > > -		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > > > SD1_ITAPCHGWIN,
> > 0);
> > > > +		ret =3D zynqmp_mmio_write(SD_ITAP_DLY,
> > > > SD0_ITAPCHGWIN
> > << shift, 0);
> > > > =C2=A0=C2=A0		if (ret)
> > > > =C2=A0=C2=A0			return ret;
> > > > =C2=A0=C2=A0	} else {
> > > > @@ -326,14 +311,20 @@ static inline int
> > > > arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
> > > >=20
> > > > =C2=A0 static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id=
,
> > > > u32
> > > > otap_delay)
> > > > =C2=A0 {
> > > > +	u32 shift;
> > > > +
> > > > +	if (node_id =3D=3D NODE_SD_0)
> > > > +		shift =3D 0;
> > > > +	else if (node_id =3D=3D NODE_SD_1)
> > > > +		shift =3D SD1_TAP_OFFSET;
> > > > +	else
> > > > +		return -EINVAL;
> > > > +
> > > > =C2=A0=C2=A0	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() =3D=
=3D 3)
> > > > {
> > > > -		if (node_id =3D=3D NODE_SD_0)
> > > > -			return zynqmp_mmio_write(SD_OTAP_DLY,
> > > > -					=09
> > > > SD0_OTAPDLYSEL_MASK,
> > > > -						 otap_delay);
> > > > +		return zynqmp_mmio_write(SD_OTAP_DLY,
> > > > +						SD0_OTAPDLYSEL
> > > > _MASK <<
> > shift,
> > > > +						otap_delay <<
> > > > shift);
> > > >=20
> > > > -		return zynqmp_mmio_write(SD_OTAP_DLY,
> > SD1_OTAPDLYSEL_MASK,
> > > > -					 (otap_delay << 16));
> > > > =C2=A0=C2=A0	} else {
> > > > =C2=A0=C2=A0		return xilinx_pm_request(PM_IOCTL, node_id,
> > > > =C2=A0=C2=A0				=09
> > > > IOCTL_SET_SD_TAPDELAY,
>=20

