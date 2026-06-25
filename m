Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF897CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288C5846F4;
	Thu, 25 Jun 2026 14:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KgA9J1Lk";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bU1xWDCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A5084704; Thu, 25 Jun 2026 14:38:06 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510638460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PBFQNj3154586; Thu, 25 Jun 2026 07:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=S5qTWzRgattoGgC8NOXFtR9K4SSkEpxnfLM/MGp0C
 cM=; b=KgA9J1LkhJqiQLokIjF8GyRpEy/OoOHUbdIPIkDw/tqjmOAjb/MkPSCsk
 JlIqLJfIKVVf45q6+8KNY5bCFhPjvyjtwrvceNhcRP4oXfZR8JKc8KviWuyAWZI3
 uNJBXZIhwUYcqk8oclz4/d3tQwD4Ez9RZHpgeE6iY1JxE65CblLa4ECJEi1wY2Tn
 HyjGU+PoZqpwTgnNs8fm9P1mKrFXIeMsppc94Apemw5g+pKzFZmkM16lK/tlVucM
 NIuEkvXbHzha5UGw7k0hqNjAyA+UdZ5PAzFN6QbLOQDSLh1VgUHtm/wJFeLtZWgq
 jp7jOOYvbRTfbKbO4vXzGPibKA1jQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011029.outbound.protection.outlook.com
 [40.93.194.29])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f13a0rbsy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:38:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eg1npXxXfjdb+3xxHilHdWxpQZSCWpcsOS7awuJl43UrK8b5E97IgE5Mrn/b464CNK1Ri4Z7BQC94sRfJBA1mYYUCC8pl1yVzhoV4Ho9bgh4Ox4TADVeZfgnLGMduUU09xdtSVuIhAiB3JmUwbV3kyGGAozwKhB/fqKMYeSzgQ/95z4KuuTTI9hioCHWGKJ75ttimM2dBbuznOSnT3UyWRwh/O5MZ6SUsM2Sr31+Fc6+6OirjMCGBi5T9IzgO4PZmcFro289pyFlXpllPMUpPHOFbcIV5aH59vfOI437BVYn2N9CLnnWIcDtezWQOcFSwW8IufKxR8aD8BWUKfPSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5qTWzRgattoGgC8NOXFtR9K4SSkEpxnfLM/MGp0CcM=;
 b=DCbfnivioS+LcGtCFIUslLLgLgei50lYSmG2wPAeWLNBYu2o7MyXJWifIaBRmOT4IaNxXwJk1kF6qzO6zKWfOGj99QY8WItD0dYFUDvHmEovyj1WzahxUdldXp063810g5jHam7sCBcDSj8IoGol4kiiWRPnygG0jmozQsHoIquaXkuKTRwUn2FN154FpGIa6bb2FNiIOF+xZKUIZ9EODdUHnRx9R75bKOEmU6xXSk3sgE6wP4GbaYeMmZsEo1SvGl+x5Ki2lX+70fXGgBAgVXB/lKtxYXA78uudUNBSIf5+KzzbKskOBFqCGNv+BMX4IeD1g5h3h6ggq/TQy2Meow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5qTWzRgattoGgC8NOXFtR9K4SSkEpxnfLM/MGp0CcM=;
 b=bU1xWDCe75qw12DxGG/ie2SSdZMyCEMfWrDZM94P8sfSIB55GuFNvcgnv6aqQYAGI8VL0uRSedk1mC0UQz1SK393iYYEa/bFTYag796Td1ekfRCHl8RV5EdTFhbWqFRgKGrcXxvKnEUIQ3WJF97c8r6wXHOD4ATGihiQOphSdns=
Received: from BLAPR03CA0173.namprd03.prod.outlook.com (2603:10b6:208:32f::35)
 by DS5PR10MB997752.namprd10.prod.outlook.com (2603:10b6:8:340::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 12:37:55 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::4) by BLAPR03CA0173.outlook.office365.com
 (2603:10b6:208:32f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 12:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 12:37:55 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 07:37:54 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 07:37:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 25 Jun 2026 07:37:54 -0500
Received: from [10.24.52.241] (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65PCbpD32734009;
 Thu, 25 Jun 2026 07:37:52 -0500
Message-ID: <7ef8cc26-8b9e-4aae-b2e3-ee35058e0261@ti.com>
Date: Thu, 25 Jun 2026 18:07:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm: mack-k3: Kconfig: Add DM firmware reserved
 memory configs
To: Anshul Dalal <anshuld@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>, <afd@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <20260609181006.460401-4-p-bhagat@ti.com>
 <178219072992.1099376.11239988740203023626.b4-review@b4>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <178219072992.1099376.11239988740203023626.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS5PR10MB997752:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8279bd-178a-463a-16f5-08ded2b694ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|4143699003|18002099003|56012099006|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info: 4OgAv07U8sN1tFnlqPGqieTo/78+JZ4zcwC6LORUbjYnayvV/zF1YBhQSFCL3UWqT1m4VXjMMoKGiLoWDt5Jt03nJ1kXGvcoJUj/cZg0b+9DhpTmKoN5N34f7onp36TyE9bZ1h5rr0LHleUeaTCnLOr4FUK8YEUuAzhpRZ3W3Rk6pu2UgJ2mXM+fr+X6S1v4Vh0mPR20d3KcGV508elgy0ar/OFxdG4RUb8ngh7AhG4QQ7rNIQz6fhbv2DkG9MIvzVVPyu3/04SlpdbR3VHHZT2IK7/4S6TaEjMaYK+n8Bbj/8q3Zv5rYdiE47K9MDTyjzqaZHnsjamoMwb3EFQOLvLpcalzQW5c4lPcTOTakvRmvWzeUezYdDW4ELQHQiJLeczM3/F7LWWfU3B4qTQLUalC8Tb4LOAYtInSAZtEUHdngODUfQQhFhalFXec2Kr9MP/a24Fs9EQQngTfX6bImuOYadoALY2OaoDQRW/YPvo/KYSU0rV2Nxi8J89Cp1DIe2Vqbkr2wnoHrm8gJyiuHF23aUPi1TEGbyGlAB6YDkcftQaa1E0DtuWUvzpVMrsoywLmmP6kdqcMUl2wfD9BlTGFzR+6DA9HQrF1Uu7E3WSgprQT9ZONH24GYu60jA5cuH2pg2ltLQAk892dgqYMTUFeAMzYMu3nYP/EqvpUI0Z+7k00a5aqeLj7mrRtnCSXlp579K5yhY/E9aEUPqGHqQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(4143699003)(18002099003)(56012099006)(22082099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: etpRvt6k6js5xwIKSyVl0fCLuqPDl7p8MmX45IIuzna2mfvFfJtgqBOVkXJJPHLZVGXl1Fh1IM+6gGnPRBE1PzlazsMPLZ+xgOVBukUD81aXhIGKi2me8s+0jnxUgHIuMwXVUt6UJWlc+VvydV2cjrktXrxgxV2R5YnkctkGXlXdtbLDFhAO6l0Z2dcvVFlxelSFubxZ4VgJTDVewJemJ/l9CK9JKhv6s/kGxGAxeC4u5dEqNVvEdgMRtpISF4DHjKkIkj1tMeDa2/4+mdDIUgYkSKwjsvWRxb6ZWHe5glQdZPTi3jfpX1RyCuczZ6gVJx/NrsybPkF3gxDP8WhNE2VjhGfA3ZqB26zl5HG+/fxDwel39iNprUvAKHNI/eVTr4KTCJzCUsQTnx2EAgZuk4maM7OP0E74LXwHCKU7ydxPJW7IyGLTSKnlfsSCsD7k
X-Exchange-RoutingPolicyChecked: gzrQuGAhnO14OcUfBmwXxlcqKOSoD1YChYVN67/FBpKLPIf5wkHjf/ZCsDisQ83NwFY+dABq7T/1A6th+YSoF51i6HCJiJmj2d8kk142MEyq11EPhSaAv/2XvUSIJUyX4cO6n7BASlItSeTaJ91AG46UtIauxqgGo4WeMJEGCb8p9imRaoS4K51SH5Wlty/rdwvcNOlo/9o+gBM8UJQgVSrebcFKyTfy6mUu1t54L/gm2wd56ORgc9jp9rCrr9dEpgU/iCcS2QJxGuwYL/2RyQ8rL4D/HPvYzaJvdgBtKPHZtr5iWljOixAfTgyQMXZeCJMjBzmMvENaVlkiBUVnlg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:37:55.2095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8279bd-178a-463a-16f5-08ded2b694ab
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997752
X-Authority-Analysis: v=2.4 cv=WrAb99fv c=1 sm=1 tr=0 ts=6a3d2128 cx=c_pps
 a=Y+Of8T+w2jezINbWzwznEQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=LcKQJhJRqiMdAt5JkOoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Z4hYsv_KDSW6WUIOEFAEUOKKEd7eVTSV
X-Proofpoint-GUID: Z4hYsv_KDSW6WUIOEFAEUOKKEd7eVTSV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwOCBTYWx0ZWRfXz6EAadlQ63We
 j1FX54ZKF1pQrMG/HEOet6Qt/rOsC4PcX6Y4FPwYUDe/MsVGcwShwkG9VVy0ssOgZOofT2SyEe1
 wUgtTkgSzSr5TSMdZmKiv+emQO2Bffs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwOCBTYWx0ZWRfXwv75WGZIyH4F
 OhfOemeae+MkRZ5F8x7MndyhEkYAChJGY3YVnxrvQ/jH4RZF3/6V9t9bzwgaq5fy5AC9moivgjj
 wmIpymRo8xnAIQMJaGO9n8RGoxWqAD+kXpWchdKgbFlroXhHUqevbweurDkLeyzs4sFOStkkV8t
 R8C85oIo7s6JRXp2pUOwcn0s6ASGYFYZrppJoMhEmPYVd8FmiVGDgT4dqXE4vLJiFNLzRnmULCY
 LK+wtElLSYXgI8HS1P2TJXyrmsVjmOGYP856ZC/oqs55rxpDk0f1L2uYfpXOChUcflTGkYAKDFp
 dT6v+RLH26fye0d1Ri+R0VO3bBZq8lmUM+6RZ7v7HszHVswKfbrAZPII+3N7x2HpNNuLpxakb3M
 89j/gPBBNUlR5RiD1Zc3zkrdJijDaYpI+drb0Uzs8/k3uQRXbw61M6t37wV7vTi+Hzy4gPwCU/P
 KrqH7PhtGsSJGQMSZ5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250108
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

Hi Markus and Anshul,


On 23/06/26 10:28, Anshul Dalal wrote:
> On Tue, 09 Jun 2026 23:40:05 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index a32ed3a9683..ad16de9c7bf 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -165,6 +165,22 @@ config K3_DM_FW
>>   	  bootloader, it makes RM and PM services not being available
>>   	  during R5 SPL execution time.
>>   
>> +config K3_DM_FW_RESERVED_ADDR
>> +	hex "Start address of DM firmware reserved memory region"
>> +	depends on SOC_K3_AM62A7
> Why is this exclusive to AM62a? We could have this fixup work K3 wide with the
> values defaulting to the correct one depending on the SOC similar to how we
> handle the different load addresses for TFA with CONFIG_K3_ATF_LOAD_ADDR.
> This would avoid the need for #ifdef in the next patch too.
>
>     config K3_DM_FW_RESERVED_ADDR
>       hex "Start address of DM firmware reserved memory region"
>       default 0x9db00000 if SOC_K3_AM625
>       default 0x9c900000 if SOC_K3_AM62A7
>       ...
>
> and same for the size.
>

Yep makes sense I will add it for all K3 SoCs.

Markus if we are aligned, you could make changes on top of the next 
revision.
Sorry for the delay, I will send a patch in a day or two.
