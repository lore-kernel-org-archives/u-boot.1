Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88357CF9C73
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 02:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B4D88CAE;
	Tue, 24 Sep 2024 04:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="Gk0VXOxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E128860D; Mon, 23 Sep 2024 19:42:43 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12olkn2081e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c17::81e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E3B8814D
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 19:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/7qUYncPY/rAlPJedR0KytirtwBf6UzhUhBhZb41zFGp/pJqRbi34/s5N/npp6dB46csr+MIwH5viq9vbn4Bv8FFqrTD+WpnAN43c32HDFuVzwrX9v3FdxnMVO/pISl7dToRa1pDbrzalGHdroFMDAw0dZbWz9HLRRk3qmU17wMF7Fnqkmvzbah81apwqDhm5MxfB7IGFRIlJkXCDvPfR1ez5S243EQWXqXWl4Do19W3ldfTjq6g1SJ1epwIBueTmCBW/7R4LQEQQiFYJKZSBd3Qd+dpv6Fxux5Jo7+RqcZ6luPeQsE+K3X2vz4nrmd5JDVN9AZcNGUbgLXy+aGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NqKSb864+A+B5+SxnD0vTAOUZt6AvuhJtFQBQWYiSc=;
 b=x34Pk/luywj3ShwqYXY4sD/fc8qilO397NcNOf9c9XQV+ra3GoydbvO4d9ghcytllkWHq/7BhzEQ0brvwxC+pXk4FI+6m2qKmi4s9bAl8lHmC1aC77MgngDlwD/7EUl9ZLSH1UjhRTOmAJZXTGeEgRrScPI5VVP28X54Y2Wbdg3lQSCEk/nHINV/CPkAeS+EH+EdLe9We3O+aI5XoHOAeTmI76nyyppDHKasLPxLVF6KTjegDpr539vlcdBHpoDZ3kQ+1MAIOsFZt5LR2EQD6WqTlZU8Ct7nv9VWb3KPKUtPTzSeBQ87aSyZ7XOT83IrJSosQM/YBgeijPQsojNUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NqKSb864+A+B5+SxnD0vTAOUZt6AvuhJtFQBQWYiSc=;
 b=Gk0VXOxEjAjokNo8yZPBXUbSJvbfW2QxEAEFBpI0A1Bt3QlkUaWuv2m+3OZh+Vnyc24P3yv/Sm+oMm+/XgFXwZYlIm4DKLCx1FzHrvJfvrqjAo36wx7uufcj4xSVYs+AICOS16O/szV1+MV5HWfIymqrtX4SHIA0rXERQrzQH//F3JlRAvjybw1jdOY9oGNideh6V/mwxm5VbotebVlY2At21SiSHmFfYG/P6trOQKaxOdFRxVWxX+EjFxkX/hsxRp7vgK3CYUNkr35lESLpkbnmBTf/rFodw0YdRGNNzSEn30j/HF0JSPEZ5m3E8X62zWZVMiYRAvGkQxfkZaqyUw==
Received: from MN2PR16MB2941.namprd16.prod.outlook.com (2603:10b6:208:e1::15)
 by DM6PR16MB3751.namprd16.prod.outlook.com (2603:10b6:5:2b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 17:42:37 +0000
Received: from MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490]) by MN2PR16MB2941.namprd16.prod.outlook.com
 ([fe80::9d62:95ae:c373:c490%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 17:42:36 +0000
Date: Mon, 23 Sep 2024 12:42:33 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de
Subject: Re: [PATCH V2 0/4] Anbernic RGxx3 Bootloader Fixes
Message-ID: <MN2PR16MB29418BBFDFA0BBF7AF32D0B9A56F2@MN2PR16MB2941.namprd16.prod.outlook.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
 <CALeDE9Oz==j74RngXeHsCp5FWsGO14hP2RSbnFLB=a2bz6h1tw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9Oz==j74RngXeHsCp5FWsGO14hP2RSbnFLB=a2bz6h1tw@mail.gmail.com>
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To MN2PR16MB2941.namprd16.prod.outlook.com
 (2603:10b6:208:e1::15)
X-Microsoft-Original-Message-ID: <ZvGoiQAm0nXShxmU@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR16MB2941:EE_|DM6PR16MB3751:EE_
X-MS-Office365-Filtering-Correlation-Id: 4352a049-df1e-4f9e-6b8e-08dcdbf71cbb
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799006|7092599003|8060799006|5072599009|461199028|19110799003|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 6NqMBJd1wOP+ojs8CvwEzR1rPihoDG9KwQeiupd+i6j4EbNQOAaFfDC2Psf4CiRURFuVsdLiWCjh13cCACCseDm2/IGRwZA+t4AJebrSDH9RLgFsEfa9uZMIJQB9Dbx477tq8BzxcITD4R966qYpvLitip8PdOWcz1aR6f2HXVnr9AhX46aKI6jYM9HGl2NbLCwiIHjJ8WmoyPV2dchS3GyveK/52SGadhdQBK8TzOPl4wbXCbDFSkd0CgwlIzivB5jGW47AsxA1modb7+osAjsaEj2ZQiIHuFmehgGpeR+7Q0TS30Gw0btQVLDIXPxnciCBtkgLAPyr9+eWwTlAiVQ0D2bwU712K6OOdKQbqPL1YBzCqbSIbtYZnuI9HhbiTro9nVptzPQd9U7DGVLtEwCoFhXzqrJzFDfk8ucpOYW3tjx+lTHVyj7N6vvtQKYnID5DY33ok6UBZFAUpfLXDTyuvK+xcUMIvMezrCyMDXC4YOv7ZjUcMY56awfJ9hL4/4J2dIdUgXID8jWr+wdblqD021D39UgjvfGrRQ6gXmgRul6QpuwVxFgZ2CQY14J1ANbc6G2bAcsMRpAjbOCZT7Kk2XIGVhwPSNEweuNG6n6v3hdzZ2oHlnUibz5g6qkTeTFX3l7BPrMSnHhmxaKz8gxjalTDMmkE8AueSdsDzBDSbKRzwQKaNOTyMUH1AzhCc8IbhvO8OH5Ta7e3rq5P/UUV1lj6Mi/WWnLeTpp8mUbxbx/0l8OtLtYxhJ5/zlW3AsLG6hU3u1Es4tewksjWlw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U2BqWDtNS6vi62FAH7vu5EKLoWygQO+40/1LtahJZAJ9bpmFbSM9eIBslBDU?=
 =?us-ascii?Q?ief6PtJPmVkR4dwGLz0v+LlfsD5ovxLG6jGbHr202P1wnSw4Wk1eBfXR2Ttz?=
 =?us-ascii?Q?/zuO1v/h58Mq4RSfifhy25deA/zWHx53rxtXm/OQPUjuY1rVh+WLeOMT2oTg?=
 =?us-ascii?Q?R+BLzw106HYoRvWQYbWSX99hJUpbX0olXP5tPUPhx0CSkDa7nYCKo2iSF68u?=
 =?us-ascii?Q?T7Xg3j5DEdlThy1kAZizxpZ+45+gVIo+nt6xiETbUVfEBl0U2/3bRWzWHpfd?=
 =?us-ascii?Q?xIrdFLLklGejAmYIYlyexdACXSnwfYHCLwGxfzWdVcjGjVvAqdFbwY+p0Y+/?=
 =?us-ascii?Q?xEKwyCwMSXgDq6BNI3SAQnHDnEG1e0Yj54sh3on/0L7xoalSRv6I3CNew8mM?=
 =?us-ascii?Q?Yt1oZmNv5GcQEGiaJT9asH3EI8SVDbVo+hW1P1AyLWgiiuwZZx0l12q5ev+7?=
 =?us-ascii?Q?KkDbPkClsAACl0zuboGAKCoAt+kpJeTTtCLuire+byvy+h4zF72CbDafYxfz?=
 =?us-ascii?Q?raycGMCZTDR/Z336aby9flwPmEotGmor6INOAfCGW1enkSdrqt8UwLwckNxL?=
 =?us-ascii?Q?Zek6Vt3rh2i5F2SGvCue3ewW6AMD+LYVu5CuYnq7zV03NUrsU3CVX+Rz/6lk?=
 =?us-ascii?Q?Iga/aJvbHrveaa7dds+ZCi/xku8p6xHcScbesF/eG33odjyHKV9TgO7YYS2O?=
 =?us-ascii?Q?0WhGUFeMh2WiA4jxKOEgiBplJUjKkcmG5qwf5yev1Dz+wYWT6GNT1qCih31q?=
 =?us-ascii?Q?H90ZaBOtjHeWeHbjmadJnXxPUV6/eYYt+NXoBhZUIRjFidZyywhhU4KL/GL5?=
 =?us-ascii?Q?QCzn6AUx6XgMyI0gJfOEtgK/YP2WtXMeWywxujglzxS0EUTLW1sHWUUmEXms?=
 =?us-ascii?Q?oibgbRZkuzhXTwNOZg6O7rMlzONTpBwgMXFGPePG869nf7Zr80an3kr/AIZ/?=
 =?us-ascii?Q?krsjpIw0dijDtI1vNiMDpbXAE2VjjXGN1J6g6MzW1FLFureyAQHMmniTOUps?=
 =?us-ascii?Q?26pDodl+sHEgml3tH0CJ6k7H+mbUf6lxXMEhIYHzyX5PsxAb8fVHTaq77wrj?=
 =?us-ascii?Q?tsegd6aTD8UT1ratJR0KICaVGXqBdVhITsP2amGqQfrMRV7IaWuyY5INHQWS?=
 =?us-ascii?Q?0Wwq3I5N/0fA1+uyIRDqjitCozu6huV9j9zk07h/pEfJmdMxy83bZL17K7jv?=
 =?us-ascii?Q?khxkkIn7lTtYgGFvGiE5Yn7A1VHUQ+S6PVWuqiG5xPlu6aDfItDaZs/HTetf?=
 =?us-ascii?Q?48h3sZahLJwhnjzQCBK7da3Z80YBbGmaozMRTAApuA=3D=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-559fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4352a049-df1e-4f9e-6b8e-08dcdbf71cbb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2941.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 17:42:36.8658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3751
X-Mailman-Approved-At: Tue, 24 Sep 2024 04:13:40 +0200
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

On Sun, Sep 22, 2024 at 02:43:11PM +0100, Peter Robinson wrote:
> Hi Chris,
> 
> > Update the Anbernic RGxx3 "device" to use upstream device-trees,
> > add logic to detect a different vdd_cpu regulator, and implement a
> > fix to allow the panel auto-detection to run when using mainline
> > A-TF.
> >
> > Note that *Linux* still cannot use mainline A-TF because of the missing
> > SCMI clock and reset functionality, but this patch series at least
> > ensures that this board can boot once Linux is ready.
> 
> Have you got a link to this upstream in the kernel lists? Is there
> patches posted? I think I have seen a similar issue when playing with
> mainline TF-A the other day on the Quartz64.
> 
> Peter

I don't. I just remember when I was testing A-TF previously (I've been
following the RK3568 A-TF status since it was first submitted) that
it would fail because of missing cpu clocking. Basically the cpu device
tree node has a defined link to the SCMI clock that's provided by A-TF.
Except that mainline A-TF doesn't do this, so it would get stuck in
deferred probe hell. The *real* solution I think is to get SCMI clk
and reset support in mainline A-TF, but unfortunately I don't know how
to do that at the moment.

Chris

> 
> > Chris Morgan (4):
> >   board: rockchip: Convert Anbernic RGxx3 to OF_UPSTREAM
> >   board: rockchip: Add vdd_cpu reg fixup for RGXX3 Series
> >   board: rockchip: Remove ARM SCMI Support from RGxx3
> >   board: rockchip: Enable PD_VO before driver access
> >
> >  .../dts/rk3566-anbernic-rg353p-u-boot.dtsi    |  34 ++
> >  .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  52 ---
> >  arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  28 --
> >  arch/arm/mach-rockchip/rk3568/rk3568.c        |   6 +
> >  board/anbernic/rgxx3_rk3566/MAINTAINERS       |   4 +-
> >  board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 359 +++++++++++++++---
> >  configs/anbernic-rgxx3-rk3566_defconfig       |  12 +-
> >  7 files changed, 347 insertions(+), 148 deletions(-)
> >  create mode 100644 arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
> >  delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
> >  delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dts
> >
> > --
> > 2.34.1
> >
