Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4450DC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A853F835E0;
	Fri, 23 May 2025 18:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NK7LI9YT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF105831C3; Fri, 23 May 2025 11:27:27 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FB882E26
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 11:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7238a91f03=antonio.borneo@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N821QH005102;
 Fri, 23 May 2025 11:27:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 9GCqtJqLA4S98+rZvFfoS/uxi48A4QlMUYqXuyF3y2A=; b=NK7LI9YTzHAq/vjI
 obREHd0US1wjhYvXmXv0xs6KVsJ/VQdB5zf2s5DCNQHCebuOBrF8jzlaAA7zqz2d
 76psewZ0BZ8cgN6UnCay8cQDG7DKJliJ3aHzaNnhI+I9nsxdRFxM0QY0UlGrEcrU
 9ZKu/rccOoFA90CnMLbvaynCTnu5WaDxmou6brEeqjbtcXn5jVxzmNQlqTXNIn6x
 KRDsg8ID4E2C1W8qHYgPqBVByG/zEaRs3KwxhjrsAkTMfrQs8Fq+hKwGUsCqSN4H
 oIAinyY/Kj2yGBeHQCOwQOOflrPU35jcEZ5iGnNkcPxY94LvOLMVLsqUEkdJqzrw
 uA+xCA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46rwfad4k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 May 2025 11:27:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4652E40079;
 Fri, 23 May 2025 11:26:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F199ACFF63;
 Fri, 23 May 2025 11:26:05 +0200 (CEST)
Received: from [192.168.8.15] (10.48.86.132) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 11:26:04 +0200
Message-ID: <e3e67c90fce020b2d02a2fa98ca9587e1ef12f91.camel@foss.st.com>
Subject: Re: [PATCH 4/4] watchdog: don't autostart watchdog on STM32MP boards
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>,
 Stefan Roese <sr@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marex@denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, =?ISO-8859-1?Q?Cl=E9ment?= Le Goffic
 <clement.legoffic@foss.st.com>
Date: Fri, 23 May 2025 11:26:02 +0200
In-Reply-To: <a22cb1c0-bcee-4b12-bed8-2eb7e19e0939@foss.st.com>
References: <20250521122755.265760-1-antonio.borneo@foss.st.com>
 <20250521122755.265760-5-antonio.borneo@foss.st.com>
 <a22cb1c0-bcee-4b12-bed8-2eb7e19e0939@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Originating-IP: [10.48.86.132]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Mailman-Approved-At: Fri, 23 May 2025 18:55:43 +0200
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

On Thu, 2025-05-22 at 11:53 +0200, Patrick DELAUNAY wrote:
> Hi,
>=20
> On 5/21/25 14:27, Antonio Borneo wrote:
> > From: Patrice Chotard <patrice.chotard@foss.st.com>
> >=20
> > The STM32MP2 boards have watchdog started by a previous boot
>=20
> why only for STM32MP2...
>=20
> I think it is case for STM32MP1 also.
>=20
>=20
> and in the patch it is the case =3D> default n for ARCH_STM32MP
>=20
> =3D all STM32 MPU: STM32MP1(ARMv7) & STM32MP2(ARMv8)

My mistake. I will fix it in V2.

> > stage (e.g. bootrom or secure OS), WATCHDOG_AUTOSTART is useless.
> > Prefer to rely on DT properties "u-boot,autostart" or "u-boot,noautosta=
rt"
> > if needed.
> >=20
> > Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > ---
> > =C2=A0 drivers/watchdog/Kconfig | 1 +
> > =C2=A0 1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 1bb67f50352..510330be8a5 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -15,6 +15,7 @@ config WATCHDOG_AUTOSTART
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Automatically sta=
rt watchdog timer"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on WDT
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n if ARCH_SUNXI
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n if ARCH_STM32MP
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Automatically st=
art watchdog timer and start servicing it during
>=20
>=20
> With this patch you are change the behavior for ALL users of STM32MP arch=
...
>=20
> It is OK for any boot with TF-A/OP-TEE....
>=20
> so for stm32mp15_defconfig/stm32mp15_trusted_defconfig
>=20
>=20
> but what append for boot with SPL on ST boards ?
>=20
> stm32mp15_basic_defconfig
>=20
> and what appends for=C2=A0 customer defconfig=C2=A0 with SPL ?
>=20
> stm32mp15-microgea-stm32mp1-microdev2_defconfig
> stm32mp15-icore-stm32mp1-ctouch2_defconfig
> stm32mp15_dhcor_basic_defconfig
> stm32mp15_dhcom_basic_defconfig
> stm32mp15-microgea-stm32mp1-microdev2-of7_defconfig
> stm32mp15-icore-stm32mp1-edimm2.2_defconfig
>=20
> if you want have no impact on other boards, I think a defconfig=20
> modification is missing for all these defconfig without TF-A/OP-TEE suppo=
rt
>=20
> CONFIG_WATCHDOG_AUTOSTART=3Dy
>=20
> or you are expecting STM32MP15 board device tree modification=20
> ("u-boot,autostart") ?

You are right!
I will update the defconfig for the SPL based boards in V2.

Thanks for the review

Regards
Antonio

