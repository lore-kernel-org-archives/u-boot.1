Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB298109E532
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 00:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2DF838BB;
	Thu, 26 Mar 2026 01:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YmGvNaHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7361483A1B; Thu, 26 Mar 2026 01:34:49 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AF680517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 01:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhvFoMW43Vs0yQODFFQtSDSpFv0uUeN7Gpg5VTo0OgVNo7NMxcPztGYDF3ujJaG9iM6T99msS/ZVHWtvdK/f0G3Dx4I399mzM3GaI+Lud/iP2cNpk1RjPvH9mrSKKljHDaSya0/5Y5ueD4XooaSopcPiS9DGKM2Zx4VwxWzVQ4zibNtRVgQHoRJUmnvSfMOZNycx+O6VelG2fId36PUNHnQRd0s5AFhSmH65V5TqbAkmRmAAu3t8eZdBhFmO67E4/WIQf5nQMXQ1CODmz91PhNr6KQ5XAs0jEIOaH5NzFxbV8nfEkztzrpaFwFU4fM3rNQKvJ9lzPT9tHvNCvPAykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S+3Ims+RSpEEOHeeLlPxVpQ8XJD9Bm9rTKPwcGFCc8=;
 b=XkRt4og3bB2v/E/OkTY98adWmhBNs39fQqOp45U6Anf8VHY1NTJmcJBqOLVSFuOjCOKp6XwTxAFdnBSzxe1Kk9dP90xapsXDbA1Dc14Yh67vxWGlN6C5PxfyiFVH2Bx48XhikqcFEa678wFUUZY5zBusBsm2zONHVrRPHaas6CI6bDK4pFac1jInX8gQduqWlYD1Gckb+mxC6JN2NZoTHcCFKi+UYBA7EW+zLz1tOG8S8Eu3Q0WE5jZXbbx3SZgpM6QUrCGyy/+Dqiaqa+wN3D/67C9jQ91F3CtMd/PInmjbRCxitJ282whcMv9iVqdCSgiEKekUoF4MKLhkYcfMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S+3Ims+RSpEEOHeeLlPxVpQ8XJD9Bm9rTKPwcGFCc8=;
 b=YmGvNaHZLdY7SCFkAWmHw6zx/eczOdFstO/PXK0g6ISGBZxPuNkmBNQDgX71EjscnW3DZBrwu4yMSRu1TxcOGQHcK261wk8jIcvzOtt+TsVDxhUTPpE1CMg1sGtow26BDKQLnsm4WkieYUO1UUjUh3OlaywFtC+ETxXzvI/TP6s=
Received: from BN9PR03CA0314.namprd03.prod.outlook.com (2603:10b6:408:112::19)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 00:34:43 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:112:cafe::be) by BN9PR03CA0314.outlook.office365.com
 (2603:10b6:408:112::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 00:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 00:34:41 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 19:34:37 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 19:34:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 19:34:37 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62Q0YbR01205159;
 Wed, 25 Mar 2026 19:34:37 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Mar 2026 19:34:37 -0500
Message-ID: <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
CC: Anshul Dalal <anshuld@ti.com>, <bb@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
From: Randolph Sapp <rs@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Randolph Sapp <rs@ti.com>, "Erik
 Welsh" <Erik.Welsh@octavosystems.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com> <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
In-Reply-To: <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 0177fe3f-0d5f-4a92-7308-08de8acf7864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mHfGlWFeVkSOk/lP0+T1mPWldVXWE0FCvA6kVAEbO+jFv6VtvpHfl79w6gR0hxMMub7iq1tuNhAUK4ugSn8E1JOjR1x9tf7FfQlq3Bc1mDCQptO1hA6l+6GLiWcraGnyMTWzhRaEccXtz2Ny6+XWxGCi/1rY3dnVK3cZm3iItS9bTqwjjfWhdpDYGXXz+eR6w57mqbKDJ/Jy2OIRG6sxOevkKPlcijV4Ujmh8Z3qhnasqpsu6ah3OUBdvMFb3l3OJiWmRU4hUXT21lPy0nf4iLvYEfw/ctMaNXAhLzWS+/pSMV2jFKca2jdeVQ1ozI7iMFTCuMbhTjLzSWIQkfGJR4B0+FJSaT1SEpBZRwIURKKgCCjK/XuQFgLXk4UWUwnhayPcJcy84aEYBs8WxZ66pO/U+1fZBT/Xak4P85PzGRof/c8RGhxfRCM6D35SweQ4wMdrKpn31mxyDlALC7VmYiafZMvK0giwjYTIEeDcC8pajo81rTsPL4j5TS9Xj5y0bdpN3ufrPUFBQ7hQzXV1iESfPSSHPbuKPlTMs4n7fnfTxpHgbCXJzjSqSixt+DP/+Z2KVsgu9jpipxwMMC9Bxdb562RlJ9SFoSBU7UW2VFc6w3BrZTEbjiZxCByfCnFAED/jjQ/ScEWIQrmdZBRLAtHtUk0YY7sgjJtvjLBJ3D7E0xoKaYBb0cPklvPsi4fAvmpFydsIvNjFgAdJ89ljUEbjP+dz5y3ksZFx7dyg5DU=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 24XMARTd75WsM0d0ionuXHlKkd6qFmMjIjgVQC9inpHaK4bCijDekhIlRWyDRY39xOco28kxkto2z72HGjrwLGbUb4j6fAUUaBG8Zp5+xE+/7QhApxfGxQOWc5cVF+De9MmZXAdJG4gPV/ITwfM0lim/Ld8l20rOjWdkX+joOalWDdKNtcum7VxWflBcDVBOiBJ61W3qCitF73KbYx7KcS8eDLLIghoiaHx+AJVB+TC96ms2cmzMtgXxKqp8aPNNelVGm1mppHDZwYE4AiGBotHmOCzSlJ4USSCSjI8iwcXu5T08Dx3yJ++CLo6mH3hezu7o5TEzaUSVdMg7RiczSbp+DYb1wwRNLjdEsaI8ankQHIAZjG9CHBekYXrBx4z8aVGGHwNyXbzV/ZPXV0YOXjZ9yi5E5e4O6sAZPaToiuetDH5nx6NeL9xaTbxsbH2z
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 00:34:41.4666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0177fe3f-0d5f-4a92-7308-08de8acf7864
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423
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

On Mon Mar 23, 2026 at 2:46 PM CDT, Robert Nelson wrote:
> On Mon, Mar 23, 2026 at 2:37=E2=80=AFPM Randolph Sapp <rs@ti.com> wrote:
>> On Fri Mar 20, 2026 at 10:32 AM CDT, Robert Nelson wrote:
>> >> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
>> >> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
>> >> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
>> >> >  CONFIG_NR_DRAM_BANKS=3D1
>> >> >  CONFIG_SOC_K3_AM625=3Dy
[snip]
>> >> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=3Dy
>> >> >  CONFIG_EXT4_WRITE=3Dy
>> >> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
>> >> >  CONFIG_LZO=3Dy
>> >> > -CONFIG_EFI_SET_TIME=3Dy
>> >> > +CONFIG_SYS_MEM_TOP_HIDE=3D0x4000000
>> >>
>> >> Any reason why we are using TOP_HIDE here instead of just moving OPTE=
E
>> >> lower in DDR like we do on the 512MiB AM6254atl EVM?
>> >
>> > Sorry, that is now a legacy setting before OPTEE finally got moved in
>> > v2026.01, as this had been developed thru v2025 u-boot releases..
>> >
>>
>> Well, it's worth noting that this change was not done in the usual way, =
and
>> involves user interaction during the build beyond selecting a defconfig.
>>
>> https://texasinstruments.github.io/processor-sdk-doc/processor-sdk-linux=
-AM62X/esd/docs/master/linux/Foundational_Components_ATF.html
>> https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/mach=
ine/am62xxsip-evm.conf
>>
>> Robert, are you alright with me making the requested changes?
>
> I guess as long as we document it. I know the Octavo OSD62-sip @Erik
> Welsh  will also be building on both am62xxsip and pocketbeagle2 based
> on the 512MB and then larger memory sizes (1G, 2G, etc.).
>
> Regards,

Oh boy, adjusting the memory maps kept getting me out of memory errors in t=
he
EFI flow that I knew should not be true. Found something fun: LMB reserved
memory regions do not match EFI reserved memory regions. EFI's
efi_carve_out_dt_rsv is setting regions to be more strict that LMB's base
requirements. When this occurs and an allocation runs into this discrepancy=
,
that allocation and all future allocation requests in the EFI flow will beg=
in to
fail as they are repeatedly given the same LMB start address in the unappro=
ved
region.

Randolph
