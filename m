Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8423EC47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E921B87DE4;
	Tue, 30 Jan 2024 14:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="nz44n+Ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A1887D74; Tue, 30 Jan 2024 14:06:41 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C30B87DBB
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v5Azji4frY+cjxhYAFdnB8oztIIY2g5HS9QEA5PKacY=; b=nz44n+Ca3pynY7aq4AENm6b0ck
 lug2HmHAly8b8QC4z4IJDvPbnhS+yPPfVM2YwK/W393sFpvEF27B1I3GkJsqhIbgKCdMU2fnFwaPt
 hWdDCjU3QkSP3eK6p8Y+CGIyYMqSSPv6aowKBhOOiFhVdEo8aQsui1YA/kr0C8wPf0RTnXO/R9bUy
 OOeZEiKV8hF6PYbKhcdMud9OKF4YRwKDGeyO7KOmaYoWEtR8p8w5oohfhVFXf7TO2RyMinoaab0Ku
 KJImG1d5KsucEXpNCxEeWWNVLhG7m3VUoNk2J8v41wwYIYIBSJT01Rx/3Vjq0RF5MW6zHY/0C115S
 Ks1K8N+g==;
Received: from [89.212.21.243] (port=38836 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1rUnox-00AC7s-2N;
 Tue, 30 Jan 2024 14:06:35 +0100
Message-ID: <21b0d615-e5fd-4f44-aea3-ee4236ff9a0c@norik.com>
Date: Tue, 30 Jan 2024 14:06:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
Content-Language: en-US
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>, Yannic Moog <Y.Moog@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com> <878r472m2n.fsf@gmail.com>
 <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com> <874jev2dgp.fsf@gmail.com>
From: Primoz Fiser <primoz.fiser@norik.com>
Organization: Norik systems d.o.o.
In-Reply-To: <874jev2dgp.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Hi Mathieu,

On 30. 01. 24 13:49, Mathieu Othacehe wrote:
>=20
> Hey,
>=20
>> Can you re-check, please?
>>
>> Maybe check your include/generated/environment.h?
>=20
> Thanks for checking. It is strange that you do not reproduce that one.
>=20
> My include/generated/environment.h looks like:
>=20
> --8<---------------cut here---------------start------------->8---
> #define CONFIG_EXTRA_ENV_TEXT "bootenv=3Dbootenv.txt\0bootenv_addr=3D0x=
83500000\0console=3DttyLP0\0fdt_addr=3D0x83000000\0fdt_file=3D\"oftree\"\=
0fdto_addr=3D0x830c0000\0image=3DImage\0ip_dyn=3Dyes\0loadfdt=3Dfatload m=
mc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0loadimage=3Dfatload mmc =
${mmcdev}:${mmcpart} ${loadaddr} ${image}\0mmc_apply_overlays=3Dfdt addre=
ss ${fdt_addr}; for overlay in ${overlays}; do; if run mmc_load_overlay; =
then fdt resize ${filesize}; fdt apply ${fdto_addr}; fi; done;\0mmc_load_=
bootenv=3Dfatload mmc ${mmcdev}:${mmcpart} ${bootenv_addr} ${bootenv}\0mm=
c_load_overlay=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdto_addr} ${overlay}=
\0mmcargs=3Dsetenv bootargs console=3D${console},${baudrate} earlycon roo=
t=3D/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw\0mmcautodetec=
t=3Dyes\0mmcboot=3Decho Booting from mmc ...; if run mmc_load_bootenv; th=
en env import -t ${bootenv_addr} ${filesize}; fi; run mmcargs; if run loa=
dfdt; then run mmc_apply_overlays; booti ${loadaddr} - ${fdt_addr}; else =
echo WARN: Cannot load the DT; fi;\0mmcdev=3D1\0mmcpart=3D1\0mmcroot=3D2\=
0net_apply_overlays=3Dfdt address ${fdt_addr}; for overlay in ${overlays}=
; do; if run net_load_overlay; then fdt resize ${filesize}; fdt apply ${f=
dto_addr}; fi; done;\0net_load_bootenv=3D${get_cmd} ${bootenv_addr} ${boo=
tenv}\0net_load_overlay=3D${get_cmd} ${fdto_addr} ${overlay}\0netargs=3Ds=
etenv bootargs console=3D${console},${baudrate} earlycon root=3D/dev/nfs =
ip=3D${nfsip} nfsroot=3D${serverip}:${nfsroot},v3,tcp\0netboot=3Decho Boo=
ting from net ...; run netargs; if test ${ip_dyn} =3D yes; then setenv ge=
t_cmd dhcp; else setenv get_cmd tftp; fi; if run net_load_bootenv; then e=
nv import -t ${bootenv_addr} ${filesize}; fi; ${get_cmd} ${loadaddr} ${im=
age}; if ${get_cmd} ${fdt_addr} ${fdt_file}; then run net_apply_overlays;=
 booti ${loadaddr} - ${fdt_addr}; else echo WARN: Cannot load the DT; fi;=
\0nfsroot=3D/nfs\0"
> --8<---------------cut here---------------end--------------->8---
>=20
> Note that fdt_file=3D\"oftree\" which explains the issue on my side. Do=

> you have a similar environment.h?

I have the same.

>=20
> What u-boot commit are you based on?

I am based on latest master 6faba41927bd (tag: v2024.04-rc1)

>=20
> Mathieu


To Tom:

> And what awk do you both have? environment.h is generated via
> scripts/env2string.awk

Using Ubuntu 20.04 LTS

$ awk --version
GNU Awk 5.0.1, API: 2.0 (GNU MPFR 4.0.2, GNU MP 6.2.0)
Copyright (C) 1989, 1991-2019 Free Software Foundation.

BR,
Primoz
