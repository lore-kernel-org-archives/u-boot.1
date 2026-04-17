Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2254F436B4
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 16:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31128422D;
	Fri, 17 Apr 2026 18:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SmL3iqSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280738425F; Fri, 17 Apr 2026 18:51:39 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD4CA84223
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 18:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwDdfUnxjO7wd0XNMQt1u5fiIEc9AsojBTH0P7E7ykHexWta2gopsy4eIjVDPJyNyPQ2gAHduFNiwfxh0LipP4m7br2yTj61q2hYBMJ0JGPtm+1SWXeblSBx8Z2qCFwMWIwhQX0Jnqu3xUMT8R4mdcPUfI+uSnozLLO+tsJWlcAdNpuz/odt5XRLDgbTO4+KaG4Izy/eJw00AEgrLbKgZsFEjNEBBBXy6HAUfqGEaoJjpvBzMciRkig3L5Iq9wMB9aPNCNMIZ+svPfepSqV71z4gsm4nuNDJlzbkEzkWSUDU8IVzFfB7AnOlEneRoYMXRXX6M18jGB8qo0YIHb2mOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d3fNcFt9JuV8GJKyqj6WemFDlxRwlINUyyTNzrmcD8=;
 b=hLrpubZNg0P0KKLn1nr2aWiyAZcr6nPqrdDbGuNq/YWQudpniP/IF6D3BNC3cnQ5/TyDjGyKRN6cGkZDfOebHx4xm6r4Q7BzDhezi/cFMA+/1rnlgao7KvzFr+6r1RpHCSPUYt/KY1QcmFT8PXFbIbTjJ0p97P/kWurXJ2SfGsoJdffhSCu2CaFyLe+FPhSfr+OHNBIzdwZ68rYHxN8NjMnjTz18eP7PzQWkHwQzew8oF7Ad8DOuZRUwKa9PprSoGBLxWRBej87RC/5SXfFTCyCh223cQcjpXmqu3BhRzKtiBC+tsGQWm/GjqRJ10iaO1QJXEk18WM+CGtowaRU57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d3fNcFt9JuV8GJKyqj6WemFDlxRwlINUyyTNzrmcD8=;
 b=SmL3iqSOZEkAOwKm4YXQUnhRFQDEFRVrNBgoioviJnP6TeVxWlCcwQvUUy6icOxjYBoP4bhzP4R09czg6BAYYpUZc91V8cUtQXhJT+yK4vs1CmdherrS3URQnYlDpGfE1ykeQvHABEos6SHWYW5QsidQdS1yJ62bCyVH0iGqdxE=
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by IA0PR10MB7304.namprd10.prod.outlook.com (2603:10b6:208:40e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 16:51:32 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::88) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 16:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 16:51:28 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 11:51:26 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Apr
 2026 11:51:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Apr 2026 11:51:26 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63HGpQ0D2075492;
 Fri, 17 Apr 2026 11:51:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Apr 2026 11:51:26 -0500
Message-ID: <DHVL32OQW0ON.F5MYYVTYU1JE@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 4/6] efi_selftest_memory: check for duplicates first
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-5-rs@ti.com>
 <CAC_iWjJOzdFwAppsCKwFMf_uJ0TGi3JpSzcj+9iWegLryha5-A@mail.gmail.com>
 <DHUV0ZQ8Y0KC.1HCMIW6TK4K9A@ti.com>
 <CAC_iWjKtRMz1Vr7VXyw56cij=zhcSRfOdGO=XGui3uYGcp1x7Q@mail.gmail.com>
In-Reply-To: <CAC_iWjKtRMz1Vr7VXyw56cij=zhcSRfOdGO=XGui3uYGcp1x7Q@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA0PR10MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 9833621b-4d9b-4259-e448-08de9ca19230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: iBHZg62+4ycUVNiZzF8ijTyfCBGKhSYRDs1BA4jIqr+TyIyaN2lmiPLQAF0s3WWTK1SPjR0hZSlokOsOQTbffrmBwPc+X96AeFMclK2RBqZG8T9/8jcdBcDDvKZCqgFquMrjtUCfyVys9VjY44528c7BJdRFI5TRCEWw0oFxoQfTvsd5N8I9paNwrarjWJF61Hd0Qklow8aCLzTyPasp5vCD45i2mQ+vKv1R8wbMzlLo3dcE6dmIXse9USoalen1mFLLTNzvBPy80MiCoTviZVYKBEsvxqM/feuldsieD/rUA2wT0xdXPs7gvCpXxOLo5pguFLVo1/1SlfJhg9MO90B81Xk7rSPkI3PKSvT0+gPq5yIL5QUvOa4TPyW0KRIEr32jIE5vuxJaUcHSkjs5ksukrIx8HXrXMb1okyW2mdDsqvSQ+sGkj8TEY4/6F0j/cAX5lCztEeLoO/RPxUsadpC7O/JS81lwc0xAVpxRqwXRM1wj96E3Ex6uGhLIvMzrCDftCumoEizhUwBdz5fwWK8CmVkit3Yughl9kNl/xpeZkVRqpYLTgV6YqDb67hE2Sqo6cUJ9+bgUkPRMk7IOnSoCgvE7sUoZSYKEvm77ZPe2iaNev0bvxr8GJEK6XztUgBlU8/GsvDSzKsZ2TvBXnEypVIXFT9V6X6frXLvT2IOWOr1SMY1A3oxS5EPaL01FuHnAVH0e2004dFJmt/kfoV/jX0z00iMCoKwsijhcrxTD5WUH5xapN835ubNdhD5pzIGiC2+Gv7tAMVeKBsod4w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TmV+PUJCYJbhggwFz6qFkNVNJTAYncS6FSYjzlnfmqhBIEr+c74PjpgAzM7RzzMS3qjtsntZBRLERBhgghq+s3EXFmvvS72kg1Gr4/jzSNg0rbcgiLhEo3mAJ9OguXIw6ZEXTN74lQhcs790xI6C9YPkaQSpF6vLsZAg/51ThiCeJ6Mos1jOfus20kd1pVQYTrHeM85uhiPhUVMuRnHFm2g0mAAuRXNGN1tw0uQpoQNTVGpq+o630LAN0g4cXjDnY7qefcHWqyXLrA7r1q75A/yYqffTVG+CbHQwBxFvwDWw7f4ulUalr2TqUxSm6eSZmDynLswyG0xwCYDVBULnmfmZOEJWx+eF9wXFekD48bNkCGwsmzQZdpZUYZUwnlFktfDnxxp+qz+A8hpRtytPkv5PZblpj+wlEBpEpbdZYRZOtuBXwM020QLuxStX87YJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 16:51:28.8131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9833621b-4d9b-4259-e448-08de9ca19230
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7304
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

On Fri Apr 17, 2026 at 3:17 AM CDT, Ilias Apalodimas wrote:
> On Thu, 16 Apr 2026 at 23:26, Randolph Sapp <rs@ti.com> wrote:
>>
>> On Thu Apr 16, 2026 at 3:55 AM CDT, Ilias Apalodimas wrote:
>> > On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>> >>
>> >> From: Randolph Sapp <rs@ti.com>
>> >>
>> >> Check for duplicate memory mappings before reporting any incorrect
>> >> attributes. Could be that second allocation has the correct type whil=
e
>> >> the first doesn't. Knowing there is a duplicate in this scenario is
>> >> more helpful than just reporting the first mismatch.
>> >>
>> >> Signed-off-by: Randolph Sapp <rs@ti.com>
>> >
>> > [...]
>> >
>> >>                         }
>> >> -                       found =3D true;
>> >> -                       if (memory_type !=3D entry->type) {
>> >> -                               efi_st_error
>> >> -                                       ("Wrong memory type %d, expec=
ted %d\n",
>> >> -                                        entry->type, memory_type);
>> >> -                               return EFI_ST_FAILURE;
>> >> -                       }
>> >> +                       match =3D entry;
>> >>                 }
>> >>         }
>> >> -       if (!found) {
>> >> +       if (!match) {
>> >>                 efi_st_error("Missing memory map entry\n");
>> >>                 return EFI_ST_FAILURE;
>> >>         }
>> >> +       if (memory_type !=3D match->type) {
>> >> +               efi_st_error("Wrong memory type %d, expected %d\n", m=
atch->type,
>> >> +                            memory_type);
>> >> +               return EFI_ST_FAILURE;
>> >
>> > This check is now outside the loop and only checks for the last entry.
>> > If you wan't to split the fucntionality, don't we need a loop over all
>> > memory areas and the type?
>> >
>> > Thanks
>> > /Ilias
>>
>> Not necessarily. At the end of the day we can only really raise one exce=
ption
>> anyway. I just think informing the user about a duplicate should take pr=
iority
>> above mismatched attributes. It hints at a bigger issue.
>
> I dont mind about the priority. We can swap that over. But with this
> patch we will check for less problems than we currently do.
>
> Thanks
> /Ilias

In what regards? We're still checking for mismatched attributes, we just ch=
eck
for duplicates first. If there's a dupe it doesn't really matter what the
attributes are on either allocation, good or bad something horrible has
occurred.

The prior version of this would never report if there was a duplicate unles=
s the
first allocation it saw had the correct attributes.

>>
>> >> +       }
>> >>         return EFI_ST_SUCCESS;
>> >>  }
>> >>
>> >> --
>> >> 2.53.0
>> >>
>>

