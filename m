Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E07CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 04:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E75483A03;
	Mon, 17 Nov 2025 05:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="einsFOdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B1783A64; Mon, 17 Nov 2025 05:56:59 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31AE3839B1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 05:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yhq4jcuiLY2GIwoEgIlTiJVrrWe4PXeQVk+6QR+xq5kYXe1/NoXTD61gkP5yowKX07j006fNQXEZ7BiJQN8d4JMLmUFkceLjWFMkaZ5j9uTuzxrCR2TE3lagGIGo8vDD/bBJ1XVieUL89V9+XWrR6TQVum/pzwqtY0BpYMbex36jO9wZDoVGdaEc2+efSBOPcb4psnvaOsuzaR2WpEMJ7Rd5EMjHqg9zSZBkvqMSci6iuMZawR0tA1v3aMM46rUlkp4e1njWshBZWpot/8aWGNbzeFoYZAO25Qj8oykUbf0q1HOFHmZlPFjUOWs7o9f9bEYswCShUxNxxYVptqR91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwVT+0Lh3gt10JxPweyyn6XyouhmeCvQgER66pvoCs8=;
 b=MkGMq9hsDHtf3NHmESwK7z2BW3ekQynshzJnBb2WBTT45Ksoo4dLzycbuVtkaW1DvKDwogEzIYksNDok8QogiRI59lt2sBVusYGSY1UTsYqsUuOddR7CvSE0gu7TEHMPUODgfKvBlmEoXnuyCvDxTxdHopZ1BkJzOz43Iwz5GWvLq1N3X2HW/SLy72zFrpRFvLaH9s8ZgyJJxjG5yr2xMjfFbsF26m+k8+bcE3zB0JHIpW4yraKwYdZvy52LB610t+Ax7qB6ibOZV9D4AGYjAHhDDXCMLX6hDOjjHses6JbMb05cNCYkv8+ZsVu4LTx8JbTmqO95anBI883laaI9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwVT+0Lh3gt10JxPweyyn6XyouhmeCvQgER66pvoCs8=;
 b=einsFOdH2uXh4b2f0eI7XxXLmNRRCVEjjKBfgc3p7J4FothAAEoFagMjGmS8lMzFUjVcnyfzVMhkFbzD4xRFivTmC0IUzKL/KRtZuYykakXV9pOOIH4bVpr31RXMBnTxgt1kXca7BopwOGZgOXlwQcKis9O723YVF/J9YrVTTYc=
Received: from MN2PR10CA0007.namprd10.prod.outlook.com (2603:10b6:208:120::20)
 by SA1PR10MB6567.namprd10.prod.outlook.com (2603:10b6:806:2bc::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 04:56:51 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:120:cafe::7) by MN2PR10CA0007.outlook.office365.com
 (2603:10b6:208:120::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 04:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 04:56:50 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 22:56:50 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 22:56:48 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 16 Nov 2025 22:56:48 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AH4ujmp1847927;
 Sun, 16 Nov 2025 22:56:46 -0600
Message-ID: <f3e922393a4dd8f9688c8e61e7b05c7bad820b37.camel@ti.com>
Subject: Re: [PATCH v2] power: domain: ti: fix ti_pd_get() to return after
 verifying transition
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <jh80.chung@samsung.com>, <peng.fan@nxp.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <m-chawdhry@ti.com>, <t-kristo@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Mon, 17 Nov 2025 10:27:02 +0530
In-Reply-To: <20251114150243.96429-1-s-vadapalli@ti.com>
References: <20251114150243.96429-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA1PR10MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dc905a-61db-4bd9-be23-08de2595b87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHZQdlFuMHJMNWVmVXVlQUFsOEdLSzNEV1VzUGIzSVYrMDFvanpydDZnMHpK?=
 =?utf-8?B?RW1SS0IrbWZrYWhYdHhWYWwvYmZOUHh1ODFoekNLSndBbGlpdkJMRU1mWTFK?=
 =?utf-8?B?QlJZK3ArQ1dhbjd4SmpRTXJXWHlpb0J6TkFyMys3cGV6Mkh1UWdDUVRKeHcw?=
 =?utf-8?B?U1pJY0JPL1ZIRU1Ea0lJRnBQZ2VKNlE3T0ltMTVzTXBYZ3c0ZVlSZFRiTk4z?=
 =?utf-8?B?NUs3SHR2cC9KTmJYeW4zZWlsSEdWUjM5cFp6UThGd0NHQlB6NlJ5bWp1dnpT?=
 =?utf-8?B?MTlPT3FpOVJHZXl6TkpSbzBIVGs3MzNhS3BNTHpTclFibEJyYk56d1BzTHFF?=
 =?utf-8?B?K2RkbDNKL1pzeWVGWEFjbXp4dk1oZjB2aE5wckRKNzF2cVd0NnRiS1p1OWln?=
 =?utf-8?B?OXY3c01Qa0MwSVRJZEVuSHVieHVZQW1ENUM3UTYzNDVnTFFxb05obG0vbGFY?=
 =?utf-8?B?em9UL0hCMDJpNUVZeEUzSktkNkZZVnN5WmRoc3o0NFZpT2MxbEN0L1JVWWxO?=
 =?utf-8?B?MkhLODFGNGNHQURzSWt4bVA4cklLb1dMa21IbHUyc2UzT1dNMjlFWUpXL2NR?=
 =?utf-8?B?d244UUFieDRTYk1YRjBkQUp5ZjhuWThObnNBZXRQaVpBY0dHWmszRTNOSjNS?=
 =?utf-8?B?MkQrQnlrdlVMRDBOWUpUd2FxN2dsc3R3RmxjdXBtV1RuN1ZnWXg2UTN6ZDha?=
 =?utf-8?B?NS9aV0dZTkdDRW9LUkhPMDRkNHdOQ1hrUUxMcGoyMmdPbG1DWlVyb2t1MHBE?=
 =?utf-8?B?bnlHOGozd1M4YXRFU0JvQ3BaRWdWZEVwOEpUM0I5VE1ibVRMV1NuVFpSY1Fo?=
 =?utf-8?B?UEd0MDFXSkdsWlM2NVFMOWp2QUpjWlhsNUR5dkh5Z21KWEJJb3Avbk1aazgx?=
 =?utf-8?B?K3Y1RFhIMHVER1dMQXBqaGNTcjZUYXZ1dW1teUtxRE1US1lMOVE0ZFJiZUlD?=
 =?utf-8?B?SEFmb1NUNU5QdkE2U2lnYTdkY2huQVRlQ1RoSnBMRktmQzlMTXlBMlpjaWxv?=
 =?utf-8?B?VmJDZHdlMGR1bzZSOGZSdk5IUDN3NzY1OXordEEzWUlFVURtTDluOExaejRV?=
 =?utf-8?B?a2dJMU56S1pVQlNDSE1TaDZwcW1Hd0MrWTd4Y3VFWHJIM2VlK1l3MkFmS0Nk?=
 =?utf-8?B?VEdmaFZCUTVOMzAvdVVidTNyWTB4cFpQd1pib1FWbm1LUVJFMUJKam1pZ2Uw?=
 =?utf-8?B?OXhoc3FYY2QyQ1UyUTV3dk14ZTBFY3RQRXNuNmx6UWpDZEl3cjhmVW5zdlR5?=
 =?utf-8?B?KzFpTVRMcGwxdkxJU3IvTUo3TGJpMlJnNHU4NkV0Wm1LUnY3NzNXMHZ5Umht?=
 =?utf-8?B?MGJyVUNnRGlqQ3lib2V1eW52MTV0dEZGck5ncGdGSlQyV2dCVUpQK0wvZWV1?=
 =?utf-8?B?dEtMVjMvRFFqMy9rKzBRb0FaTzRyM3FjN0NpNHlEWUJVOERnY0tqQlY4b2tq?=
 =?utf-8?B?b2lFaGxtTldmSmxKRElidUZUZzhzVGU4MUQzcUZUcVE0WnlMbHVTR01abldq?=
 =?utf-8?B?aTlrZnFPL3RuQnNtU2U1OWdHa1l5Zmo5dzRtekJFWFFBc3BsMXZ5RTZZM2tU?=
 =?utf-8?B?TEZnVFdFVHJraE5TR1I3M1hMUmloK015bmxqYjM5VXpYdWpqcUhoSTZlelB4?=
 =?utf-8?B?WlRtT1BJMUNRRDBqK0JvRWNTZ2xNdGlHZTB4d3BOZ3RiVVJYR0FqOUIrWk8v?=
 =?utf-8?B?enJIb29Cak1WSzZ5R3duRXhvVUkwNlYrMjR0a1h2T0ZPTlFma0RiWWcvZFdQ?=
 =?utf-8?B?djlUMzRRSFltRjlPWDhucGVQbUtoMEhId3RXVXNqVS9keHZvNGI0ZGFsZlI1?=
 =?utf-8?B?cjVHcDRXeUF0ZnhiNW1BTWVTa1RreGxQeVhXOW1DODNUSS9UTjRSVFpMS2dp?=
 =?utf-8?B?ME1NVVN1UWppRzgwdHBGa3BMeTRoT25zSlJOSDZzQ3F5cGZKai92SFhNK0NI?=
 =?utf-8?B?cHpQWDNYR0VqbHJTcnZCWjR0YTF5UjZXZWFEM1ZuZlN6ZmU1MHhFL1laQlp5?=
 =?utf-8?B?R3dLRmVBczEwM2kwVXJHandidXlPcFVMYUZ3WGc1NzA1MUgrQUxiYU5MSGt3?=
 =?utf-8?B?aXNWN25FR2RaRWwzNGRFZ2xtait5Sm1BQWtnUGJuM0dEeWxJaThDVjJlcHVY?=
 =?utf-8?Q?/Rj0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 04:56:50.7690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dc905a-61db-4bd9-be23-08de2595b87f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6567
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

On Fri, 2025-11-14 at 20:32 +0530, Siddharth Vadapalli wrote:

Kindly ignore this patch. I will post the v3 patch including the test logs
on the platforms implementing PCIe Boot (this patch is required for such
platforms to avoid waiting for 1 millisecond after a power-on request).

Regards,
Siddharth.

> The helper function "ti_pd_get()" is responsible for powering on a
> domain if it is powered off. In the current implementation, if a power
> domain is determined to be powered off - no prior users and the PDCTL
> register indicates that the user desired state is OFF, then powering on
> the domain constitutes setting 'PDCTL_STATE_ON' field of the PDCTL
> register.
>=20
> While the current implementation indeed requests the power domain to be
> transition to the ON state, the helper function "ti_pd_get()" doesn't
> verify that the power domain has 'transitioned' to the ON state before
> returning to its caller. As a result, it is possible that the device(s)
> belonging to the power domain may be accessed before it is truly powered
> on, leading to a bus abort.
>=20
> Fix this by waiting for the power domain to transition to the ON state
> by using "ti_pd_wait()" before returning from "ti_pd_get()".
>=20
> Fixes: 144464bd2c67 ("power: domain: Introduce driver for raw TI K3 PDs")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>=20
> Hello,
>=20
> This patch is based on commit
> 6c2f2d9aa63 Merge branch 'master' of git://source.denx.de/u-boot-usb
> of the master branch of Mainline U-Boot.
>=20
> v1 of this patch is at:
> https://lore.kernel.org/r/20251114114611.57032-1-s-vadapalli@ti.com/
> Changes since v1:
> - Replaced the following:
> 	+	ret =3D ti_pd_wait(psc_pd);
> 	+	if (ret)
> 	+		return ret;
> 	+
> 		return 0;
>   with:
>   	return ti_pd_wait(psc_pd);
> - Updated the last paragraph of commit message by mentioning
>   "ti_pd_wait()".
>=20
> Regards,
> Siddharth.
>=20
>  drivers/power/domain/ti-power-domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domai=
n/ti-power-domain.c
> index c3519307340..09d9e1b3159 100644
> --- a/drivers/power/domain/ti-power-domain.c
> +++ b/drivers/power/domain/ti-power-domain.c
> @@ -227,7 +227,7 @@ static int ti_pd_get(struct ti_pd *pd)
> =20
>  	pd_write(pdctl, pd, PSC_PDCTL);
> =20
> -	return 0;
> +	return ti_pd_wait(psc_pd);
>  }
> =20
>  static int ti_pd_put(struct ti_pd *pd)
