Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C3E6F090
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 13:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A0984117;
	Tue, 23 Dec 2025 14:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gOhBimI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6BDF83EDF; Tue, 23 Dec 2025 09:17:49 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA65A83C28
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 09:17:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZdt1CKixrcvWmu3ZsMjF00VLTXmNWvLjwC54qJ38G4ox4DnYoJuZPeliIqU20YG8dNMArgbQlkH+qUtr659koJXGVpHpw6ItwV3bpxuJj0SHYQnHJUJRHLVH7DDjx3HqAPIkw1eWmJcdwCfKSAPAWe/hBj/4pUxyZ5GsiX4prgLgHlaq438nTT1I3bJ2PM14QGsvp8nZ0BpimS3B+U8mhIhxC9g0YV1UqyhdDQLK8HbSqCd7x0IK8oy0aQQmru9mn/TfkPFYPdNeGIR6SU2N320S1vEyL60ftJPl8tdjOxMKk/a65bMI+bhw7m1UpL4q8wc4O2K6QuG27S3/h1bRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhQ/CKexJXI7YLnTquc+jqDwaSH1d5a+dLWcl6/xa3I=;
 b=WW+5h4pfxqCLJ6LqCVWXF8NwmI3kmxsl8hFtJVemPY+VDCcKHalO+4pwgp2OZeZjmcOXHme3v0UMYgMQTK0bss9hyPrKAxDR1UUaAFJQ5yE5GowzYscKz04BWBHNhmdYVoftYv45kpW14LF73zRfUlmguBGEWF+Ts1egneEKT0DpdiUZFf2HOA+/MIchB61hczbQcbqj7UT/pG+h3z6zi8DZ4A6Sk4RCh8hhHoZXBXOI7DNuzt3vOTId1yWkneeqLR4Dgzs2B8rDuApnQXz2qfMYCq4rb8y5apgderPqHp7tS+F/ZckERBVL9TGcFuSmAiMRYW1YJAgKyXnOniDV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhQ/CKexJXI7YLnTquc+jqDwaSH1d5a+dLWcl6/xa3I=;
 b=gOhBimI6/slfZEt20yTkjva2FjHGOZ3Qyj5nsDnlkYctDmUyvX441tBzwBFxbuPQIA+jWHekLfKJ71s7cf/XUPvvLdQBLD83mE5+WskMQw//zxPQWxNLjgRqR8mylZhP/DHJeVEbmCAPXKGsjRynnq5T0FwlJ7YgHIn2rZsC30o=
Received: from BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24)
 by PH5PR10MB997734.namprd10.prod.outlook.com (2603:10b6:510:34c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 08:17:44 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:32c:cafe::87) by BLAP220CA0019.outlook.office365.com
 (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 08:17:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 08:17:42 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 02:17:40 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Dec
 2025 02:17:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Dec 2025 02:17:38 -0600
Received: from [172.24.31.151] (lt5cd2489kgj.dhcp.ti.com [172.24.31.151])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BN8HS352806066;
 Tue, 23 Dec 2025 02:17:29 -0600
Message-ID: <82cf9987-f068-4a54-b456-b3b87cc4b96a@ti.com>
Date: Tue, 23 Dec 2025 13:47:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/13] am62: IO+DDR resume support
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>, Moteen Shah
 <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, Nathan Morrisson
 <nmorrisson@phytec.com>, Garrett Giordano <ggiordano@phytec.com>, "Judith
 Mendez" <jm@ti.com>, Aparna Patra <a-patra@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow
 <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Jerome Forissier <jerome.forissier@linaro.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, <u-kumar1@ti.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH5PR10MB997734:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a21bb38-f4e1-42fb-fdcf-08de41fbbe89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0Z3S28wa1kxN0d6Y2c4NUFBaUNmd2tPcWlXdUtBeHRWRWdUSGY0UG5HYXZz?=
 =?utf-8?B?UHlsa0tHcTRRMTEzeVZ6RWVDUjh5QnJ1eXhycVVDUGFQcHhud2lQTVJIZlVH?=
 =?utf-8?B?NVkyVWxZR1U4STkrYXFZYTdpaFlzbFFNYldOanBoUjQvUXhWcWxNMVRybUJZ?=
 =?utf-8?B?WWIwLzN1SURodHFpcmpBR0R6RHRzU1RDQ3lJMVNlenJvRGtMZkxlQTRvZ29K?=
 =?utf-8?B?ZjdOcGVRWUM2Szh6T1gxRU1Yaks4YlZxQ1grODFod2prcnhrSjRUVXZOYTFF?=
 =?utf-8?B?bjQ0ZWtzSEFDRW1qNlJ5bWtDSWZNS2VaZURDaUllclZBbnUwUXhXL0gwWVV1?=
 =?utf-8?B?ejdQSUpYcjRqR0VjUzZEZzIyMTVjYmlsbTA3cFlxL0ZpeVY0cmtxblVOaUR1?=
 =?utf-8?B?Qlo4enhOQmJWa3U3dUlISzJqb0lYWTVZUlB0dXJDMU9xUWVzejdYRStsaWZG?=
 =?utf-8?B?QzN3R2R0SmRLUmFKVFR0VEZQQ2Y2K0VyaU9xbit5dDlaRDlQeGpmRnBXQ2Rn?=
 =?utf-8?B?dUxsYnRZVUhpWklmcXQrcDUxY3dXS0w5dWNNYTdHcmNHVXRSOUd1djJLcVZN?=
 =?utf-8?B?bzZ5UzZ0Um0vS3krdjdXUEZoOXN5b2VXcnVGeUFseXZvT1RVSFY0RlI3SW95?=
 =?utf-8?B?RDN2cyttWWtNVlMzUU9UUFBCbENZVzY5WE05cDRDa0thRmRlcndUbWlMVDVn?=
 =?utf-8?B?MnNxMU54ZlBTaDVJWnY2NWxoSE4xTWEzYmxQOFYyTm5LUlZzanRiaWlTc0lR?=
 =?utf-8?B?YUY0RUFHMmxsZlZMeS80RElTRVRiYWxJV0VCNkZ4U0RoN0hBVnZWOFlES2xy?=
 =?utf-8?B?ZVZEUXB2TnhhMEtrMkszaEh6N3M4M0sxZ3YzRWFzY01BR3IzS2JxdXpaY2Va?=
 =?utf-8?B?VzdVckxnbzZGQ0VqZnI3K2VKS0IyUlF1RGswMm1uSFM3ZktsZXBJOUJnTEZh?=
 =?utf-8?B?a3lEc3JaRW9WL0ZDckcwQXlXQ0NybEN0OGNhNkNKNzZmL2QrNi91V01WZUJt?=
 =?utf-8?B?WVJPcy9SQTY2Mk9SWnJFek9rZy90SjdlSkhJS2N2L2JTcVg3MXF2aEVYYWFt?=
 =?utf-8?B?ZmR6ejU2WWpUUDFPWGNHNUJtMVJFZzNEZHpSanQyZHpUVitya2RISDRUQjIy?=
 =?utf-8?B?TkVEVnBmckFDQlZubWt3WUtQT0hkVTgvN1RsWWc5UE5XaG4rVzVKdE43TWZU?=
 =?utf-8?B?dEUxb2V0Z21EQjd5OG51NG9iNXRTNmo4MVB3UEdhS2FhOThnWExHUVljM1NY?=
 =?utf-8?B?ZzZTRWJJd2JkVjJxamo2U1FBcjArNUkycFUzK3dxY0ZBZThSN0R6VWFYWkxr?=
 =?utf-8?B?ejl5emgyS042dk4wVmtzQXV6Uk9NWnFNQUg1cUxwUWJ3cGt5QUQ1Sk9uMGJY?=
 =?utf-8?B?aEFLd2U3ajhCTlBtQ3dKclh3bXErL25ReU5xOXRVOVhHcHZDTERzakxtcUtN?=
 =?utf-8?B?ZUVUWEpLRS9ob3o5dDlSRFlCWkZLM2RmRDRaeURNVkFuYmFrSDdXdHAxcUxQ?=
 =?utf-8?B?Z1VxUUduMFRjazVoN2d2bFBSekE0bjBnVDRpU2Q5ODJYY2paTnZaa21NMGZo?=
 =?utf-8?B?cXZ0RDF2dmFaZmJNdWNTYnRpT2JyMUtzRnRBQ0JBSG1EdmRkT3NkOXFXQVJ2?=
 =?utf-8?B?RXE0Z2lMNzd3c0xzb0d0TEpwdlNxQ1N1RGxDY1FpTm53REJienhBNmpOeUN6?=
 =?utf-8?B?ZVVqeFNMcmUrR0N6MEYwYzVRaWozakMrQVBWVEJ3Lzd1QTRkT0dwS2lwMHJq?=
 =?utf-8?B?UzduQmZOQVVieDJmalpSUkdHTnNNaXhMekRQZ3hBVTZHbjFlWHQ5R1E4N3M3?=
 =?utf-8?B?SURMV0tvUW1tTmVDNzJlVTROeWFLam80ZkpRb0hOaDRVdVYzblhpSi9BbSs3?=
 =?utf-8?B?QzFqZGpOSWRZa1RPNEZVV1F1aE13Sy81T0pUZ2dsaFhKRGRVd24zRmRuTWVu?=
 =?utf-8?B?cGp6N2U0SE9ZajdMRzFCMk9VeTJxakVLTzNVUlV3OWd3MERRdWg3WUl3VTNP?=
 =?utf-8?B?ckRQdlJXYm5BZ0hCWERCbEZVclI2NGlOang3UWxDazYzVVpEK253Z2FvVmxR?=
 =?utf-8?B?dVRBakVyb3ZVUi9PcFN1a2N0MGFTOVB1a09DbXRZSGYzdUkvbnVoaVZJeE5h?=
 =?utf-8?Q?eHHg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 08:17:42.1463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a21bb38-f4e1-42fb-fdcf-08de41fbbe89
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997734
X-Mailman-Approved-At: Tue, 23 Dec 2025 14:36:20 +0100
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

Hi Markus,

On 12/23/2025 1:31 AM, Markus Schneider-Pargmann (TI.com) wrote:
> Hi,
>
> this series introduces support to resume from IO+DDR. IO+DDR is a low
> power mode of am62a and am62p in which nearly everything is powered off
> except DDR which is in self-refresh and a few pins which detect
> activity and can wakeup the system again.
>
> On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
> it is, the DDR initialization sequence in k3-ddrss differs slightly as
> it has to get the DDR out of the self-refresh.
>
> Afterward a specific address determined from DT is used to get the
> metadata that stores relevant context addresses. The context is restored
> using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
> further initializations are skipped and uboot SPL directly jumps into
> the DM resume address which takes care of the rest.
>
> k3-ddrss is using absolute register accesses at the moment. I am trying
> to submit syscon DT patches upstream to access these through syscon,
> unfortunately there is ongoing discussion regarding syscon.
>
> I tested this on am62a.
>
> Best,
> Markus
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
> Changes in v8:
> - Create and use am62xx-lpm-common for am62xx lpm common functions
> - Create platform dependent functions in k3-ddrss in k3_ddrss_data
> - Align am62a and am62p initialization regarding caches and QoS
> - Link to v7: https://lore.kernel.org/r/20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com


Thanks for clean up ,

Apart from qos comments on patch 8/13 and 9/13, overall series looks 
good to me.


>
> Changes in v7:
> - Removed parent nodes bootph-pre-ram properties as not necessary
>    anymore.
> - Added missing new line in
>      arm: mach-k3: common: Helper for LPM meta data address from DT
> - Split off LPM specific ddr code into its own file k3-ddrss-lpm
> - Rename lpm_ops->restore_context to lpm_ops->min_context_restore
> - Pulled patch to add wakeup check helpers before the IO isolation
>    removal to remove later cleanup of
>    wkup_ctrl_remove_can_io_isolation_if_set()
> - Some reviewed-bys and tested-bys removed due to changes in the
>    patches
> - Link to v6: https://lore.kernel.org/r/20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com
> [..]
