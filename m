Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06DECD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495A584875;
	Mon, 11 May 2026 12:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DtwK8w3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA1384878; Mon, 11 May 2026 12:56:28 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E5284876
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZeblYkEZcgo6dpbqL3xh2N7AukxnywoMxebjTSHlkjCP2lfCHGU7wHlfGMGyoMy3cSD9kN38bgnAGkQZma08YoW+s3gRXmVeN+hTUljHfm5g5yH3JJZNKztmnSXUOdcRXuwLEvU4xeTfXbH9jEFeRTutKC/ruLVrmy3+VApM8TRduO+mIpDLXnnsqnBlXSArAnpUVmodskl9PPA0R9Ck1XYDT0A6dlHU2RisAx8v3IW3jDgSem8IOnMcI/FV+n8ksuipt6VRf6NpiDNOIdfR4ZZx9xBc7cubmuvHuQldR+97v3gZRd7PAfHSU2T5WJwAoVgBAtBU/M780moSs3pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFM3SMQCAUn6gfiWk3Mr42gn6iUkoyHjpMkhx9iRxA8=;
 b=d5wSKZro+1K0NXzRpRqBxtBsW3RnZR9ZtOGFSUrNhTS6FY/45ONzesV+fAxDbfA3eURunAJlWJ68b6F7axW9MYoDaV9Z3mbs7YKOvX+Dyq0JqGNBFn1uSuvUdYOYgQWiIV6895Re8H7vofNqjOyKlnI6ijFUW8Mm6Ec1pCvao/rOvBUvTeaGv+nVsuTsYu6ERUda9xTq7OOPQk1aOepSYP67H6g1+XGcjFKNNGa/UzlvYv5oHRwUqbEoskeHXIbD9lvMgJf0XV477vWE2v6Bcjh9tJeVj3vtCSznFed7P5eSXes/2arZALu6h+fwFupakOTC5GUgLjVt7SEn7CvwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFM3SMQCAUn6gfiWk3Mr42gn6iUkoyHjpMkhx9iRxA8=;
 b=DtwK8w3H+SuPFJg0po5V99yvJ1OtUKRlHYAMLsjej0QYedJs2o3rIgbiDATG0Ae41Tv1s3Bj7VQKNEAVB44nmqkvEyA2k6BJwh22BEO47j+QB5ues+D5tDx89dbZEk4fO1YUlp2v3R2sYClijnycezRvjZnB9ZfP726I0T9fq58=
Received: from BN1PR14CA0012.namprd14.prod.outlook.com (2603:10b6:408:e3::17)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:56:23 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::de) by BN1PR14CA0012.outlook.office365.com
 (2603:10b6:408:e3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:56:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:56:22 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:56:21 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:56:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 05:56:18 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BAuDe23217750;
 Mon, 11 May 2026 05:56:14 -0500
Message-ID: <afbf5dbb-8d2f-45dc-b34f-d448e09353c4@ti.com>
Date: Mon, 11 May 2026 16:26:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] arm: dts: k3-j7200: Remove background firewall on
 DDR
To: Andrew Davis <afd@ti.com>, "Richard Genoud (TI)"
 <richard.genoud@bootlin.com>, Tom Rini <trini@konsulko.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Abhash Kumar
 <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-20-richard.genoud@bootlin.com>
 <f5e29a2c-70ec-4569-8204-333a0efb5eec@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <f5e29a2c-70ec-4569-8204-333a0efb5eec@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 91251b05-3dda-428e-ed18-08deaf4bf07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8uifyjaSCLe0djbShwSGCQZO2v8MtNQuiWf43NkbM/baG4yzFFgQJo114q+Bpx+9vmWl+vCOmdyv6FAgfRrvuHkRDbjSsITQlmDVkXj3v63cfILWpOxkYeiPTo669eoJcZrBfr/lbHa851NHTiKKOnf15W7yku9pPqkm0X4PUw7LRdYd864CcnLuvx12eiZeBIxZguOecNw1d82mbpNaNzWXMQ5GhwguwSqyjrAQd4YcO88NSYPrUiwchJHfVnwQ9pYv6DimBQI8jLmvCM8SetPAP8sBrrtX+lO1riBM1uvBr3GB/3MnlBgyah2Cgg+i+udartpVJblojoELkGMj6JbEwVUW5jopbSYCNgpuxhGMoXMvKkTG2JtSpcOpcnsDJB17u1Uci8AdlBA2PLTQyxkrv8Ro+3/TdEBDeDGwPZ/OE8U9AxIA68hSrsG1CW5rvCZjfQbetXIxvxNNo/o5fXtgJ16m4zUJy2oyVNGG9PtsUTsXxWzDjfBG0Asg1vTMbuFVrE3ZbprIOmVQ7YcMdC/fcUOJVfR38xoVEPgYErtSGerppWyfRS/Eqh++yGAQXqKIfcT53GFm496xwnIbj7Sxlxn30/G1X6or2lJtbBsYkPiSHaLnBUdQxi102QrD9mcT8FpPlWukp8wg5liJH/+K3au+9J++1tG3lg1PACXgcubwbfAhzLoHr9M7Tn0azJfvIlnmDwJR0gRjFYzt2cFt5Nr1Jx+bXlaYq/zcXKxEQ2/nS26N1YmENvSkPmFVlw25iy7fEwkQX3svqrPn5g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gv3EnJRjrv2tQ4shjz+Px+1oJ0b18Tuu7heGvCwdcWHy9jC/4lNS2DxMn6WmiNzhrcZbCRx5i/KdS1CiNveWHcXAD7s4LePfS8mUvlXmtZs+MaPioEIs27h/BVyQpl/UjuuDqXDXUULaXHx1KPNNSdWHMVXkCQgoBKNkQkVx1NdVdnDVfGkn1IkCsDiPpNbH4MrhKdv6qg2IyALaieiEf0M3pwM3lgIv0nk/bi/z19BXzHh0iZH4+bIHHFI3MrAxqYRjBlSn9Lp6gx5G8NK1gPKJjzS557l/StRHDax3P7I4u76K6RDQM8tyQubWU/M+d3D/uxk97nhSapm5UPf9TK0xiW66pa3X4kgsSvPg8c480++T3jckC1t0nO60xYvCotkWiZFS8mUdAPCUYtpvFkzGIRgvnSycHiQ7/mpaBXZwEFydF2Bowswjwc7DIrCl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:56:22.3961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91251b05-3dda-428e-ed18-08deaf4bf07a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
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



On 4/30/2026 11:00 PM, Andrew Davis wrote:
> On 4/30/26 3:44 AM, Richard Genoud (TI) wrote:
>> From: Prasanth Babu Mantena <p-mantena@ti.com>
>>
>> With updated TIFS version tag v11.02.06, the background firewall
>> for DDR firewalls are applied by the TIFS. This removes the
>> dependency of applying firewalls through binman.
>>
> 
> Does this then create a dependency on using a TIFS firmware
> equal or newer than v11.02.06 when using a new U-Boot?
> 
> Andrew
> 

I am not sure, how this will behave but we have to keep backward and
forward compatibility
>> Remove background firewall on the whole DDR, as this
>> background firewall is applied by the TIFS init for j7200
>> and j784s4. Modify for j7200 only, as there are no firewalls applied
>> for j784s4 from SPL.
>>
>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>> ---
>>   arch/arm/dts/k3-j7200-binman.dtsi | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-
>> j7200-binman.dtsi
>> index b4e0ce8bfcf2..c2b86339d593 100644
>> --- a/arch/arm/dts/k3-j7200-binman.dtsi
>> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
>> @@ -294,13 +294,6 @@
>>                               region = <2>;
>>                           };
>>   -                        firewall-4762-0 {
>> -                            /* nb_slv2__mem0 Background Firewall - 0 */
>> -                            insert-template = <&firewall_bg_3>;
>> -                            id = <4762>;
>> -                            region = <0>;
>> -                        };
>> -
>>                           firewall-4762-1 {
>>                               /* nb_slv2__mem0 Foreground Firewall */
>>                               insert-template =
>> <&firewall_armv8_optee_fg>;
>> @@ -308,13 +301,6 @@
>>                               region = <1>;
>>                           };
>>   -                        firewall-4763-0 {
>> -                            /* nb_slv3__mem0 Background Firewall - 0 */
>> -                            insert-template = <&firewall_bg_3>;
>> -                            id = <4763>;
>> -                            region = <0>;
>> -                        };
>> -
>>                           firewall-4763-1 {
>>                               /* nb_slv3__mem0 Foreground Firewall */
>>                               insert-template =
>> <&firewall_armv8_optee_fg>;
> 

