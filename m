Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204B91125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 841EC840DE;
	Wed, 11 Mar 2026 15:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eKVQSvEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BCE84109; Wed, 11 Mar 2026 15:46:21 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C24A840BE
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgHHcweNctryUGba+yHx4ihuDGI6dWTP9XWI4i00sSLr4J4eAQtNUMqL/jIvI9IuLIdhLHaLXD+YiiajoIr1TRfCi10FJZveB0asPzeMZvs4bsVpxxqSiA881NbJWyrgGSo4SjFSXICo/BWEQsB3B0EOPpYYLL5NzFE5S1/SyHJPBMTeyWA6cupsRpQDNsY0up8+3k2p72rqFD5lmj6wsYNheWqZCYO1e4tCvux2JLWLZBTcpP6k18zskUKajCUjV5b3hAHzUc8Zrw+fo/cUNv+BzC4fN8aiM1igDUFcbYxCrjg4gV2z7aUIpPzC4Ob0C+mG50ltuUm0+n9np0VT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPLCK1l9ZtJooyG32eG2GuN8PfOvdZnVWDbFmKYUulU=;
 b=SjJzX/mgZ/sBjIY8p++k8VSHvKPhXegZLtTdhivd8MY+U6PIYhOdkVsdDyhJRtduZIey+HE+r8/jjt5im86h9VubrL5tYBZiAFsWO9pfM3Rqjolam3RF5u6LY28IqKbT7pQ0e27OJLn6/6X/76U+5pHjvtUJZp5dxVQ9Psmd+yGnPThSUX0qOvZ8VUjCJc+jnuMhouNg8h4FhZ9JuGAZCHH9RMpfEdt+XzAzmJHeE+5/Kf41Qv9pxXl7FjxkboJgaMR7V0kh3J7w/EH2wMyCB21JML4nMhSbBXBVQ2WHuYUwO/Z3vx6y0TRpYYSgdL8tmGeqqhsMUHM6GqV1LepN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPLCK1l9ZtJooyG32eG2GuN8PfOvdZnVWDbFmKYUulU=;
 b=eKVQSvEr+iyekqbcgJs98v6Nq8Cv7KwzGFiaaMFmOmXBnVDZHSEAHejSDYi5wC0L1LEtccVdVA6I7T21LforwtgenO/SoeyWo7gFI4j+aBr8tr8O2yM8/rsrMzVxrPcAICkPJ3aq06hKiXic68Uw13sdP0vny68fiMYgJ3XFTbr/tpC96/mBmwhcv1wmrqS0K6HA3EYBqPxsuAKyM+Iga6pN5UE/KszDWbbV9nko4mr5JcfDgtfAmSgPCGzFDxDCoWWnCi4hZCGvNnSjz88ih3pM0iwySrSywWxn8ImWNO1+YuXIKpMyUmG4yhD7cmjI8zJL42Ds6jW4YkNhDdu9dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by VI0PR04MB10390.eurprd04.prod.outlook.com (2603:10a6:800:219::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 14:46:12 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 14:46:13 +0000
Date: Wed, 11 Mar 2026 16:58:09 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, uboot-imx@nxp.com, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, 
 peng.fan@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com, 
 viorel.suman@nxp.com, marex@nabladev.com, ravi@prevas.dk, fedor.ross@ifm.com, 
 sebastien.szymanski@armadeus.com, joao.goncalves@toradex.com, ji.luo@nxp.com, 
 semen.protsenko@linaro.org, sjg@chromium.org, tharvey@gateworks.com,
 ping.bai@nxp.com, qijian.guo@nxp.com
Subject: Re: [PATCH 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
Message-ID: <e6dsdd7wnmhkaw2lvudroymkrhdjhkh7skwxdj5m2lx2423czv@bhlqa3ob6zej>
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
 <34d4475a-8353-47c9-86fe-36e67ceecb69@gmail.com>
 <llrc46dn7akdpro5bim3egfuuktyvwbrmb4odenspiz7tnwdme@3hc5leohkgzr>
 <20260311091419.GA6525@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311091419.GA6525@francesco-nb>
X-ClientProxiedBy: AM8P189CA0002.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::7) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|VI0PR04MB10390:EE_
X-MS-Office365-Filtering-Correlation-Id: 70448a61-1fb3-4e7e-f2fb-08de7f7cf12d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZQChJbKd7vdrnnwVs+N/cSOaNpyqSkjk+pNgt1llKAWd6G4sIlclDDYo1CNYW2Wy7wzIjMxiKFcgFcNd16ImaMU6AGWfdCkFyDBMJC1PYTeKaz5j/kJEd+xssL9yycpZzaJ0Gw8XGD7hew7P3bjJe9a891ENUOzvsj3UkBCFEIRHOTKrySknKq0sOGu8gQtg4KDr9C2WV5bF0rTncb2Zsn1KK7s4SbM7NzsCxHVhXey4u7Wzxi37eQrNddRGD8sl1WMW5jWa/MRhwt5OVOzdVle4p34SFBuq7YEEolvDw38zOO/LkdKYKtVgOygkkbKtGsZHh7FKBSIOcpuhargxX9lXLwRqeUAkZGnZcdwr77FIhOqWWluV7kcYwwGkZ2TRjpFFRRUJIwspNj6Gxgh+aFSXyMKtp/znob3HW7dFqVwCfrr+tEnkUf1Fk+ydYMri6RiJCSg8p3t1VOKfZjBY2RwnnEQ8dTXbSccKSADEsyODNmucbPoW/ud8oE7pxiandOUaeSQzdBd3IBXV9Ok1m7pMXPm8cMHIWEuuLWatTngISKc3+Yo/fIQg+Uj39AmgoAq5GCmkIIc85U2I6rK4CRZHMIDd/a+QGC8jfMCz9aNmfONWKgPzaPhnjVvss0F54jKMjZHkwk0qLFbaf0+fTYoNW6bH9Bah3kbH+b4ypuUBS6nQ+3/V1Ve8MNaIquTw0bx9VvvjabWIXPvb6z5QtfVe3Ujxq90JclBLgOTP0WU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1gqXh7zZZfFC3xSiar+Sf7kymaPTbyWTZUEMFHD1VCrc2NG6aJ+y3SZT9Hd7?=
 =?us-ascii?Q?RSZ6g4Zi3p7mM6UMG5IUyrn2gaF9cHewzPyuLYYn3ZmPnuLsNcRLq/yYl39d?=
 =?us-ascii?Q?Iom8FVfDjAatRNjbK8ecwWP89ZQuJvZqW6kbqhKH+jiTjrc6mIEEK0rFODq6?=
 =?us-ascii?Q?YMnqeHQfoQGl/YjnJ8GWGXQQSi02/OuhBs4X/8r5xPMFwoBYM4j+wsiNQbtL?=
 =?us-ascii?Q?WHPpBCRFRITdX2/nTJhUaWB75HLfrCKtkuyCuqET1+pxvr2wZrAjNerWdKWQ?=
 =?us-ascii?Q?8v1CfpfJOC42ytzBP9chM0sq8TRAxtTBSgImWuIvIaEsKawqFIy1DxwUSWUo?=
 =?us-ascii?Q?3oxBealX56fIdSi2+BdVdgdWRBTWZotTJ2IwkdSmuWE+xZdKwCi7JYmT6ojH?=
 =?us-ascii?Q?S1NUZXBoI3zVesPrB8qqyWKOz2BlRCs/uropmgJS2anzp331nADoqBxHLclM?=
 =?us-ascii?Q?10GeE92ozTCgjgdjjAk4Su1xMfkkki/7PzNowGc6mMgKyanCKTibF97/2Hkz?=
 =?us-ascii?Q?wA5mKQa57xBeI65CYt5Mn764UbPDsMblK2XWKB1LkjPeJHDzn5IBJo53WeKr?=
 =?us-ascii?Q?BFJ3Ym+COeuC2lWAgIvkjRWs5Bw8CY+p3q5bX690cIXczlCwxOat2fPcBHNw?=
 =?us-ascii?Q?BT7qrk4h0IM+XkNlkRDWKX0roanm0jphWzrEixolAum0e2yXMvsad8Dn4WgW?=
 =?us-ascii?Q?FEhRJfObFrRER6/6i1a1tdbLwhvTQ6piZeT72Kk6QCklGP8mle2n3uy3Euvu?=
 =?us-ascii?Q?pB3ns0u6UV2UDpkFNceO65opjSiC1GbSkeDseyTTikikTZunomD8aEt0opcb?=
 =?us-ascii?Q?Fo9OBnwDJJVdvqsZl8gGFgD8m3e3ClZdkhQjGjZLJ9dF9Xm8JJMX/Q4qIQKf?=
 =?us-ascii?Q?E2qd/vNOnXBpAm7VwFKcM4KOWBs22J03DEGAJ6WOJDXksdUf6f8Fh3qmoFCS?=
 =?us-ascii?Q?VwchSxaInTPY2Gt3h9SEno5mMmg1ii6EpvBswso9k5YWUczeVz2Z1Bv43Xe/?=
 =?us-ascii?Q?y9qJTVEuzvp6ltCbGVVK8+5xnciJD82VBa7nDcmAwF66jQseyJVJi4h6c7W+?=
 =?us-ascii?Q?7qXeIzA15K2zF1FC2Wm8gUEO+8jHe3xdsvurds1xHcJ8VqNDG/F86G5ApFD2?=
 =?us-ascii?Q?zunA3p1artNCJdiFi7Z29z0l2O62Xa/tiWDGw3en2el1mjfZ8321Bvs4lrQV?=
 =?us-ascii?Q?9xx1962z1YiQ3LTiDWUrUGr++mx3SRc7nfRfKby5CqwDRs0ooJOnXmGsalYR?=
 =?us-ascii?Q?Y9eCDQ5iKXmy3DGd7TPTKGkXWAFIZ/uoCFYFblZ57qZDRABaxwB8I+U+7Fdw?=
 =?us-ascii?Q?iUup/1f/6YKsuMncBPhE1EhwjgeDnZabpu/N2fFX9GxupZHCDsQ1+ArTp6/9?=
 =?us-ascii?Q?4lCla14PWHfkkDraBBHoDi6IvQ/fFqRpG9zAAzHltMK5VXHqLDLOJ45hcXEP?=
 =?us-ascii?Q?Hap2c+4Lr11cxIfWcw5kfXn2MgL6+PS0xJW4g4bodpYttncmrHbYqXsj54cY?=
 =?us-ascii?Q?NgT0e71bcUk+GFb4rd1P++S/WM2fYsp7P1ESZhmEQurjyjqiDzI76O0LSdtO?=
 =?us-ascii?Q?M/vfkh5WiP4OmuqVVQ7x4QorcV+k9X+btZszWK8+PzYestqAVvsQ1ImfzQBk?=
 =?us-ascii?Q?prWg164pT0pgCx+d1Qca1vJl2jE/bYyLmTOsMyWoVDaAKhKtfno4R1oM1uP6?=
 =?us-ascii?Q?70KZiSQ3We/5KLRFwQjYcudWZnqN/aV6iqzbyop3FFTigKD9wZvE0ZingwFI?=
 =?us-ascii?Q?rPhOo6sfqQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70448a61-1fb3-4e7e-f2fb-08de7f7cf12d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:46:13.4505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9AShBAsIaN9XtWyasC+yFuP3gT/5Z0yTbITQvcrG7Uzyd1QvoFjj7w+L7pnlH0qhrX1nGcYjOq3dkfKAZkhAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10390
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

Hi Francesco,

On Wed, Mar 11, 2026 at 10:14:19AM +0100, Francesco Dolcini wrote:
> On Tue, Mar 10, 2026 at 05:27:45PM +0200, Simona Toaca wrote:
> > On Tue, Mar 10, 2026 at 04:04:19PM +0100, Emanuele Ghidoli wrote:
> > > On 3/10/26 12:54, Simona Toaca (OSS) wrote:
> > > > From: Simona Toaca <simona.toaca@nxp.com>
> > > > 
> > > > Call qb save automatically in the board-specific
> > > > spl_board_init(), if SPL_QB option is enabled. This
> > > > makes sure qb_save is called before any image loading
> > > > is done by the SPL.
> > > > 
> > > > Signed-off-by: Simona Toaca <simona.toaca@nxp.com>
> 
> ...
> 
> > > > diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
> > > > index cc5b7f9ef0f..1d25795eb17 100644
> > > > --- a/board/nxp/imx94_evk/spl.c
> > > > +++ b/board/nxp/imx94_evk/spl.c
> > > > @@ -44,6 +45,9 @@ void spl_board_init(void)
> > > >  	ret = ele_start_rng();
> > > >  	if (ret)
> > > >  		printf("Fail to start RNG: %d\n", ret);
> > > > +
> > > > +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> > > > +		spl_qb_save();
> > > Does it write to MMC/NOR/SD at every boot? Is that necessary if a quick boot
> > > was performed and the data has not changed?
> > > >  }
> > No, the qb() method calls qb_check, which returns true only if OEI
> > saved valid data to volatile memory (meaning it has run Training flow).
> > So, if Quickboot flow is run, the data in volatile memory is not valid,
> > qb_check fails -> qb returns and does not write anything to the NVM.
> > 
> > Also, another thing to keep in mind is that after a successfull
> > qb save, the data in volatile memory is invalidated -> qb check will
> > fail as well even if OEI doesn't run (so on a warm reboot).
> 
> Do you think that this is something that should be generally enabled on
> any i.MX95 boards? Emanuele?
> 
> Francesco
> 

I think it depends on the usecase.

Enabling QB in SPL is useful for:
- automating the save
- being able to skip U-Boot proper

Enabling CMD_IMX_QB:
- lets the user save the data during flashing
- lets the user save the data to a different
boot device.

If SPL QB is enabled, the qb save command is only
useful in the uuu script.

I will add these comments to the documentation as well.

Another thing is that if SPL_IMX_QB is enabled, other config
options also have to be enabled depending on the boot device
(for example, as I have also written in the documentation,
SPL_MMC_WRITE for MMC boot devices).

I should mention that this functionality is tested
on latest iMX95 rev: B0 (if talking about 95) and
has to be in sync with OEI.

Best regards,
Simona
