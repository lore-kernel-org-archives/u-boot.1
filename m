Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB57CCF9E9
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 09:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7415800B1;
	Wed, 29 Oct 2025 10:23:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="q8Ua7oD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3171B82A9E; Wed, 29 Oct 2025 10:23:41 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D6B8003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 10:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAs1M4arKsMRIdKLTLLY9KhS5/NDEW4kbOAhzstV6Y7p4tkzTLghK+6xnA+4pAVIWuykukxvqey13m6kxI8bkMfDWyRUw9CM6sDk2pBvRGzcbw/Frt/I5v+rqlvljqj12OzTiWwjILG+2yAAU5AzMwPlPQIgztswDuJo+TdlzhkTjFBRpA4sX1B7lgVnY9C8AMqDEoLdIcnRpFqjXfhFMsNxFOD8V5iWs+dAzoLB+1VMjo7aIalfV5E1yoEOmWn61gQ1HiTNnT/cF0GvKei2eG7EzGXp0wwnNVNTwINIb8YLgHA9SPi6EAp/CJDFwDiqJdBM/aS6WbplkvCNqrXI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUrYZdxY0esqVDNm6MpJLDYW5SPZb46iasiBAiTXbLs=;
 b=HslCeHsApCb0kBT5wuRcsUkUtPfzsMe7AdCWCJSJacFfG0sdE7fKTaTcVx6ZadsEBjz0pWNU6Ad1sq4ClMCWEYt8+bc5UkKTnLEMTC1Vrp95C71aGdm3LE1w4UgGzIxHK4w4gsCGsEQ8L9Cqekfpm8FCdOdsX5XDoyweKc/3oAFDNCvF1sNGRypR5BD3s22lOyhIJ4h+oz6/NqQhzQmYcCrkASvtX3/GWjxIGAKHH86vhtXbPAGgt9bxz1UuWdgFksVDCotScvV+RFE2Ec9F72HMR8Qau3d5dPwonw/dKc+KzkRc3ZpBHzQkohXil1WnLs9/O+a7ssIQmUv5T7MCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUrYZdxY0esqVDNm6MpJLDYW5SPZb46iasiBAiTXbLs=;
 b=q8Ua7oD0ixM/rmtI9DQK8+XrUNmfJ+7O2LozqXaoGpS1Atdxmo885twp0aAr/skhBB0u4FjhUqw2ql2bP6B/Nckse0/G31oqXyQKU+9M8NPoLjwcgewHCs7RFEmKX/8aenNzvT9mLS0hLwuihLSsZUIwpHArG8P3dKL1v9/wjoQ=
Received: from SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8)
 by PH3PPF8C8C3D129.namprd10.prod.outlook.com (2603:10b6:518:1::7b6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 09:23:35 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::be) by SJ0PR03CA0213.outlook.office365.com
 (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 09:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 09:23:35 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 04:23:34 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 04:23:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 04:23:34 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T9NXf03803023;
 Wed, 29 Oct 2025 04:23:33 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Oct 2025 14:53:32 +0530
Message-ID: <DDUP3J37VKJU.3G90BDVOTBJSI@ti.com>
CC: Alice Guo <alice.guo@nxp.com>, Etienne Carriere
 <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>, <kamlesh@ti.com>, <bb@ti.com>, <d-gole@ti.com>
Subject: Re: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
From: Anshul Dalal <anshuld@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84593511CF2B43470CDD8ABD88FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <68e5af37-1511-4720-9172-751d5b788c39@mailbox.org>
 <2a3421c8-b7af-4c6e-91c5-cbd08c9f3dd5@mailbox.org>
In-Reply-To: <2a3421c8-b7af-4c6e-91c5-cbd08c9f3dd5@mailbox.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH3PPF8C8C3D129:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b109f7-5156-450a-43e3-08de16ccd647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFRpU1ByWUZUMUNsaVkxMy9PMExndjdkc2FuRHVyWmk2YVNQZnlLTTBKVkNC?=
 =?utf-8?B?TWhXbTRGc3p2aTJxUk1tZmxVWm16c0JCU3d3M2MwMkNiRnRqK3Q2TDZSWWVD?=
 =?utf-8?B?R3ZjMUxlODJyZnlWMzNzKzZIdG1DMXRhK0cycFA4b1VjUkFwSGFzMzFFRlRR?=
 =?utf-8?B?WUpuSWVoSit6cng3bXdTMWxDSUc3b2x5U010SXJNVlo2UVBIUU9WYlZrUnFz?=
 =?utf-8?B?YkdSTmRiU2tIVTlRRUJBYVVzU0xrbEgvaFRJb1U5MDBQUDJ1bHdSLzI2Ujds?=
 =?utf-8?B?c3hrWnlnSHcrcUI0OTJocUZVb09DaVVUOWU3WVFPSDd3K1RQMTlMSlFmeXNu?=
 =?utf-8?B?WFdwMVB5TDZrREYwUFU0bzBXYzZobEcxOWQ4WmJpQUJYZ0RzK1p3TDBFMEFv?=
 =?utf-8?B?bC93Q0trNlhPWE0xVU1LUFo3QVBEVDF2cERCZCt6aXRNMitoOHRieUhjQ1Nh?=
 =?utf-8?B?Z05Da3JaWWc3bEZWb1FFdCtmMFVvTjIzK2huZFQxNWhjOUNnbGkzN2s3SWZN?=
 =?utf-8?B?UTZ4YkhKRndLSk5lRzZ6SGsxYTlYSVZWOUsrS25vV3RSNFExanRTK1pUbzAy?=
 =?utf-8?B?MVNMU3JBQ0FuR0ZsMmxmckJrd25sVFpLZ1dJczYrNmZYcTNVeTMwNVVDMXNK?=
 =?utf-8?B?WVEzK1RZbHBhWXRDcXZ0M3QwcWgyenQvVm4zVDA1OFUybEhRdTRTZEI3bENn?=
 =?utf-8?B?ZGgxcTVLQ3FYa0lVUDM2M29tbXlnQ0lVRFB5cVVZWHhPVklvRUljNG0yNjhO?=
 =?utf-8?B?RFh6bEYxQldVZGFTNmdJT1VxTDk4OC9QckhaTlVFTDlRYTVRalZjOGFqbzNu?=
 =?utf-8?B?UEVmc1RMYW1qTEhjTzFXY0hRcUhQbURzZE9EWnZrM1VDd3BSOWNDNG5ZK3Br?=
 =?utf-8?B?c2hibG5URTdmSjc4bm9lc01zV1ZiV1Fnd0I5N0FzZk9kQzg4WHN0YlBVcGty?=
 =?utf-8?B?bkl0dFF0dGxleEtoZ0h5ei9MUTJjOXVzZXFubVh5Y3JIVDE3SUppZjZPZGtZ?=
 =?utf-8?B?L0JOK3JRalhESWhtdjU1bTdlaW8zQy9UZVB1Y2x6OXF1ajVCVzBZR1U2aUo4?=
 =?utf-8?B?SDdKZlAvRVdzWURuY25ieE50ZFVZT2gyNUhHU1lQYlllTUlRQ25BV1FPUWQw?=
 =?utf-8?B?Z3cxTVFYWElQckFWLzZZVXBOeE1XU3RyR0hZQmphOWJDT0grdnA2aHFWYWFx?=
 =?utf-8?B?SXNqQ0x3SU1kZTFlNFJ6MWpUcmp2cXovRUVja2RwdmZPUElnS2ZRdGlPZzlC?=
 =?utf-8?B?THBreHhoVy9PUVl2azZabWRKKzVBOE9pRGs5L1hhOHN5dEJ4S0ljbGtXdkF1?=
 =?utf-8?B?OXdodDNXRjZUbHMyNGYySGFpRXQ2Uzhla0hDNGpDRUZ4RXhlTW12bnEvUjN1?=
 =?utf-8?B?ajAxb25pTEt0aWJMTUlGWHFvUko0YVJTcUtvR0VxRVBwSS8yZUZrN1d1QjhT?=
 =?utf-8?B?NXAvYm02ZXozL3lCSlVZc0E0UGcvQ20wZGF6dWJHVFV1QVUvdkRtNHNPcitR?=
 =?utf-8?B?YmROVVpQZGs3eDhGYUVCaXJsNUI5TUhUUitoeFZ1Rk5vMHd5T1FZdDI2T2lq?=
 =?utf-8?B?c0c3TUQrVVFMSWwrR0VxZEhjNCtvU2xyenB4dVZtQWd6Skhac2JOb3p6VlN2?=
 =?utf-8?B?ZHc4TXNNTVAwL1FGVXdoNUprYmRFT3VrTFpWcTBOTGF2S3k0dTJGUTFqN1d6?=
 =?utf-8?B?K2pZNUxEd0ZqV3ArdmVIbllxZ2k4ZTR6R1ZPcjc4eTRIUE9BSUYzYkRobmw0?=
 =?utf-8?B?cEJFWFA3Q3l1YVdWWW82WlVoMGR0aEc5eGhPVjVTTUxmRG41RGdqc2orM0s5?=
 =?utf-8?B?TXVjQjI0WWNuMU5LUFVGZnJaV2hOaUVQcDJaSVhuU21ZendoVzY2eUdBZ0JS?=
 =?utf-8?B?N2g2UDNNNk55c3RORXBiWXE1Wk5iWXZNdnlHRUxVTFUwL1BJcWNMM1ZGblJj?=
 =?utf-8?B?VmxiUmNsNGc3eHRQMDVNa05YaFBBb0xFdmRtRGxJTjdUNlhpQkJKUkoweG1l?=
 =?utf-8?B?cDJJSWF6VUxZcG1WZ3lHcE1CTnBDRWF3T2dBZWUrc3RXc3J3QStKMEp0cXZq?=
 =?utf-8?B?Zzh4VmpiVGZOMW1NeDVDelZ0VE9rRGRCTVcyemdIQkllTWdCS3RjcWpkSURV?=
 =?utf-8?Q?C88Y=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:23:35.6089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b109f7-5156-450a-43e3-08de16ccd647
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8C8C3D129
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

On Tue Oct 28, 2025 at 8:46 PM IST, Marek Vasut wrote:
> On 10/28/25 3:37 PM, Marek Vasut wrote:
>> On 10/28/25 9:25 AM, Peng Fan wrote:
>>=20
>> Hello Peng,
>>=20
>>>> Subject: [PATCH] firmware: scmi: Drop
>>>> mmu_set_region_dcache_behaviour() misuse
>>>>
>>>> MMU region cache behavior configuration for SCMI/SMT mailboxes is
>>>> platform specific. Even on ARM systems, the mailbox memory may not
>>>> even be located in any cacheable MMU region and may instead reside
>>>> in some SRAM. Remove this non-generic cache behavior configuration
>>>> code from generic code path.
>>>>
>>>> It is unlikely that any platform is affected by this change if it did
>>>> configure its MMU regions correctly on start up. Platforms which might
>>>> be affected are i.MX94/95 and STM32MP.
>>>>
>>>
>>> If the memory is mapped before running SCMI stuff, it is ok.
>>> But if memory is dynamic mapped at run time, there might be issue.
>>=20
>> I wonder ... should ARM/ARM64 define CONFIG_HAVE_ARCH_IOREMAP and=20
>> implement actual ioremap() function which changes these cacheable=20
>> properties accordingly ?
>>=20
>>> I saw TI platforms has some changes to use dynamic mappings,
>>> I have not read the details, TBH.
>>=20
>> Can we put the TI people on CC here ?
>
> +CC Anshul

This change shouldn't affect any current TI platforms since we don't
make use of SCMI on K3 devices.

I'll CC folks working on upcoming devices in case they have any
thoughts.

+CC Dhruva, Bryan, Kamlesh

Regards,
Anshul

