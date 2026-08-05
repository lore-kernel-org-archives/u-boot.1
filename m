Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFD7C55822
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 05:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A4D0607A8;
	Wed,  5 Aug 2026 05:50:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6p9mCoanfaVs; Wed,  5 Aug 2026 05:50:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D9F0606FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785909053;
	bh=7Bdo1up5HPtqHK4vqX31KiGlsQYtcjLHQkr4lbAjzsA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mpipREIIu6ow2D6X5TWejmgzfSf90bZR0qQbXulC8gDMiHguQJvCRoMkzgIXvia/4
	 YyRgfNb0qtjAgNRfPWdd6ihfI306Pl6wyPLan7TGO0HECGdR7FuGxPZM+6I2kT5s+d
	 /KiuZTCVexKcvMbKVgFsrFI2LD3m9unW/fhFEeVmGpuGYWt8Jo8HwrBQjYzcNjXjbJ
	 qBYlweq7tiqa3OHQPAZyDTKZZIIs+gw9hOs+dPWSSLF8uqWY+LKSqcLGAKrVHevKfc
	 qoX1hIYClHEBqOt4p4X69PCQXOSCtSHclh2xdl3bOs3WFBJPbiJ6RZjoP0PuUkNgsw
	 550AV/1RIjQnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D9F0606FF;
	Wed,  5 Aug 2026 05:50:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F09C144
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 05:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 410B6606FF
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 05:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYbIZzbLmvcj for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 05:50:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.102;
 helo=mail-244102.protonmail.ch; envelope-from=sean@geanix.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B216D606FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B216D606FD
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B216D606FD
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 05:50:46 +0000 (UTC)
Date: Wed, 05 Aug 2026 05:50:30 +0000
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
From: Sean Nyekjaer <sean@geanix.com>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "patrick.delaunay@foss.st.com" <patrick.delaunay@foss.st.com>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] stm32mp1: spl: support loading U-Boot proper from eMMC
 hardware partitions
Message-ID: <Jzny_6oiskgk1COrRgIO9-7yU03pscZqE31eAaI6jzIgCELNkJrJSz40g48d4s1jIIP8wrk0dxa1l5qdO-xVXTGA5Mxcsch485FzWkid3TY=@geanix.com>
In-Reply-To: <93ceb2ea-7e83-4b8d-8af2-5afae304da5d@foss.st.com>
References: <20260618092855.3702905-1-sean@geanix.com>
 <a0c2d561-a2e3-4c66-a9a1-e810009f262b@foss.st.com>
 <04e0480a-2e4f-479a-801e-54699d854875@foss.st.com>
 <AVOkeKKkQAoWpdG0kyASXbfyu96CsaHLok9_DQCEG5xW6hVGSaAk3tb6g4UZXdDa_uByOjgb2qA8Wq6cIy63baubWNMpGb8i_pZahNST4jw=@geanix.com>
 <93ceb2ea-7e83-4b8d-8af2-5afae304da5d@foss.st.com>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: ce8f50c9b44fc3e7ace9b15a5508d78b28476fa9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=geanix.com; 
 s=protonmail3; t=1785909034; x=1786168234;
 bh=7Bdo1up5HPtqHK4vqX31KiGlsQYtcjLHQkr4lbAjzsA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=mdo2Y1kmRbcwAbGKrfUVBTPRzBLo83a/lprV4EGCo5/roleIP+E55NROAd+p+T16D
 ui0f7nuUhxA3zZt/2oRGKeXqK9QbO/9B9SWh1Gwrxwu6E++fw+xSGLkHueZvlRlO1k
 Ruzaw71K0zHkWmRl914n2mrEwDKgy5XfIQG4CcdbvcAupr0IBHZdnVgtFabfS2u7Dr
 TUUoL2oBGKpMAad8EcFbuoM+L3JE0wQotmkjtqr6I/mIn2d0AKhISdPGuTMEpfUguU
 oO9B5lHch+1W8vh3QqRKAjp5EgXo/dKCD7o7RDvklM3DE7v7xhGHmGZLhMe9VjTi7S
 u069MCknBqwog==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=geanix.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256
 header.s=protonmail3 header.b=mdo2Y1km
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Oh, I accidentality dropped the CC to the list :/



On Tuesday, 4 August 2026 at 15:28, Patrice CHOTARD <patrice.chotard@foss.s=
t.com> wrote:

>=20
>=20
> On 7/15/26 12:57, Sean Nyekjaer wrote:
> > Hi Patrice,
> >
> >
> >
> > On Monday, 29 June 2026 at 08:50, Patrice CHOTARD <patrice.chotard@foss=
.st.com> wrote:
> >
> >>
> >>
> >> On 6/25/26 08:14, Patrice CHOTARD wrote:
> >>>
> >>>
> >>> On 6/18/26 11:28, Sean Nyekjaer wrote:
> >>>> When CONFIG_SUPPORT_EMMC_BOOT is enabled, make spl_mmc_boot_mode()
> >>>> return MMCSD_MODE_EMMCBOOT instead of MMCSD_MODE_RAW.
> >>>>
> >>>> This allows the SPL MMC loader to honor the standard configuration
> >>>> options CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION and
> >>>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR when locating U-Boot proper,
> >>>> whether it is stored in a GPT partition or in an eMMC hardware boot
> >>>> partition.
> >>>>
> >>>> As a result, both U-Boot SPL and U-Boot proper can be placed in the
> >>>> eMMC hardware boot partitions.
> >>>>
> >>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >>>> ---
> >>>>  arch/arm/mach-stm32mp/stm32mp1/spl.c | 5 -----
> >>>>  1 file changed, 5 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-st=
m32mp/stm32mp1/spl.c
> >>>> index d2e41b8e65f..d2af705a5d1 100644
> >>>> --- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
> >>>> +++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
> >>>> @@ -56,11 +56,6 @@ u32 spl_boot_device(void)
> >>>>  =09return BOOT_DEVICE_MMC1;
> >>>>  }
> >>>>
> >>>> -u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> >>>> -{
> >>>> -=09return MMCSD_MODE_RAW;
> >>>> -}
> >>>> -
> >>>>  #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> >>>>  int spl_mmc_boot_partition(const u32 boot_device)
> >>>>  {
> >>>
> >>> Hi Sean
> >>>
> >>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >>>
> >>> Thanks
> >>> Patrice
> >>
> >> Hi Sean
> >>
> >> After a discussion with Patrick, it should be safer to keep spl_mmc_bo=
ot_mode()
> >> implemented as following:
> >>
> >> u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> >> {
> >> =09return IS_SD(mmc) ? MMCSD_MODE_RAW : MMCSD_MODE_EMMCBOOT;
> >> }
> >
>=20
> Hi Sean
>=20
> > So like the arch/arm/mach-mvebu/spl.c ?
>=20
> Yes
>=20
> > But it's still a compile time option to choose where the U-boot proper =
is located.
> > When just removing the ST special here, we also gain support for loadin=
g U-boot proper from a filesystem.
>=20
> In our defconfig, we always got MMCSD_MODE_EMMCBOOT enabled, but we suppo=
rt boot from eMMC or SD-card.
> It allows to distinguish the boot device at runtime.
>=20

You will still need to have:
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
or
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR

So still a compile time option.

/Sean
