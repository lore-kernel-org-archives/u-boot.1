Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ACBCE8D52
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF8B8420C;
	Fri, 14 Nov 2025 17:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mLe8+DHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD7A841E0; Fri, 14 Nov 2025 17:45:28 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51FFB84205
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEGgk2F2746508; Fri, 14 Nov 2025 17:45:25 +0100
Received: from osppr02cu001.outbound.protection.outlook.com
 (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7j3tte-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:45:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjw6hAKZz4hvnvUZ+sf2DnVphVERzwLxGOwODHyNjhxJWM6UikiaDa0MlipqKubjUjVpPjFqKrIqvf4ZIwtlGFF0yxh3+xDMw3pbLYys9dM+GcFXeQzvay+TCip6wIA5RUOv4wa9Rd82Ij4n8fsNCOgByl6T2DSiomr5pAo+GE08a4zczN2LIhy7S0Y6UajANAT/rvPEHvs9Wpc54PxDOZgQVhKplhkRfufjW2z3OL6HO/ToCFFcoPHXuoMPBa9fEUnfABldavjHIVYPPV1iLDT08+LZ5HYaKXp0OoQJ5IJfNKnaIRf9c1yxpDsKd1BQWEaBrHOfneGR+DMujAQOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jypX6regZnFcDxpg0Lfb0XhjoO43A7ZfPgeAg6LcaIs=;
 b=W/Gw8kaWZ9TM0TS4n36/5jdGMg5G2VqAv1toc74g6v0JuxILY15XslpCIIDrOVUOZnSe5mUBh4+/PEG7TpD3sNSSXoarLQ9pp6y/OoQVcSux6bRSuCyO1qrn3pV4yfgs4CjCL2FqFX1SXRyQsuui7SWOAuUm7R0cnntSH0pDHwEjgn3vIJJ0nXJWIFDLm1jO4Ba0yk8Lc03R5vaI9uJvT4Y+p14HLvHSlqPWn+WN8Y+x6eQfq1ElyxmCHtlMjjZFGEQqExBaZxuySG1neJtO6+Knfv3/U0Z4rM82DFGfN17Z5rvMuppMuHiCiuhjLKFyPgO6VXqRIetgDTl2Et4yVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jypX6regZnFcDxpg0Lfb0XhjoO43A7ZfPgeAg6LcaIs=;
 b=mLe8+DHwMLx+2BbIgDhN3Cy8FiJTSAzedkYah5Wl6SD/Q8Q69CLggXF3yOpwp7H3p5qbNw7kIQoYEoCSRc8PMEkF9pLb1aA3AfTkqbIw6uYW3KWyjrx1vbUpjVU6x5yyDEF1miLqNjvg8l2Zor6xi+L3rsC2lfwX9zWXNN5t37FGJY7PcDNngGagz3P8hwjnFC14RZcVdCqZBIg4bZHa24Uznh+1wfMVklvO8kr+1RJt8kv7nnZAuvt0/lUBexXal4f5yVlpWCy9evZBlwnM4+JBNcO0oFN7+WmmfUrXlGFMykPoO0XWSijZ11HcU/Fl9YeVJd58O0zPLlax0fIfqw==
Received: from DB9PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:1d9::16)
 by GVXPR10MB8986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 16:45:22 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::7d) by DB9PR02CA0011.outlook.office365.com
 (2603:10a6:10:1d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 16:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:45:22 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:45:32 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:45:21 +0100
Message-ID: <0de91e08-7501-4458-a75e-8fe0bd2f37fb@foss.st.com>
Date: Fri, 14 Nov 2025 17:45:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ARM: dts: Fix "arm,smc-id" value for
 stm32mp25-u-boot.dtsi
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20251017121852.109561-1-patrice.chotard@foss.st.com>
 <20251017121852.109561-4-patrice.chotard@foss.st.com>
 <5376b470-3115-45c5-8851-e8572d33935c@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <5376b470-3115-45c5-8851-e8572d33935c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|GVXPR10MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: e521a36a-ba86-41fd-4911-08de239d340c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDZram5SNGJNcXE5VlpUUlBsM0JzbTlibjhyWUFnVTN1dUt5OWZ5eFdNTVlu?=
 =?utf-8?B?M21Jbnh0Ty9xMUhNYXgyb3R0Q0ZhQXZ1WEYvU05vbCtKTjUzeGxFMlhrS1RO?=
 =?utf-8?B?MTBFSkg2dmZ1RFlmUnpZd2J6SVBsbkFTaWFITVJUb1VWbjdiWU9ueC9TaTg2?=
 =?utf-8?B?eEJmMHVhMDhQQkFGOG84QmJvU3JwMzd5cm9jOUxXSHhGK0JORFlPMEN0anh5?=
 =?utf-8?B?MDhvQnhMUmFjdmdoMkMxWnNSQ1creXJrc1kwNTI1b1NJSDRkNHIvTXFYdS96?=
 =?utf-8?B?UlFmVzFhdE0vWjBhUXprRkVkRC81Vm0zYlpVY0I0UzIrMG9BejRoYml0b28r?=
 =?utf-8?B?UDFBd2dpZUEvMjUxbzRuTlNwd1ZDOVk3dk96d3NOOHk1ZFlHMm55anJ1Rmtq?=
 =?utf-8?B?aytHTE5jTnduT3I4cnRyOUNWNDUvd0RBZnRTbFFWcS9ac2RvNDU2bTRidUgv?=
 =?utf-8?B?U3laSG95aW1XS2dRckY5ckdudGRrMjB1UGJTQXI2TWEzQ3hKeXNDRDk0Y2xk?=
 =?utf-8?B?bEVOSTlIT05HUXptVDRxemV6bkwrNlN5ZGVyVyt0SzFvT21EajN3Z0JrYzNI?=
 =?utf-8?B?eG1jZGNCT05Jd1BxZWhCbDNyRUxhSTdFWVdkQjFZUHdWTVllRGhiSGM2WmI2?=
 =?utf-8?B?bVRXMVRtdE9KOXZIb3hzOEpXRVBwa0NlelR0MVZwSTdjSWNZT1UrRVRNczRO?=
 =?utf-8?B?TGFYVittZ1ZsNTdvei9BL2lVeGhCa3BLRDB1V3ZuUkJoUnZrRW5JdnM5L2dS?=
 =?utf-8?B?a21PY01GcXRUTElZMVBsTUlYUExtQ3NFODlKMXB5QjVOZ1llMnppQjNZZm9N?=
 =?utf-8?B?WnZabjR6OTBYOE12V3ZsYzBYeDlSblB3bldRbi8vQ2tLUnRXQmliTnpjZXIv?=
 =?utf-8?B?ZkdmV2pncVZQYTRXSnR5emdPTForVVJDNGZKbUxpUnZCRUpMeW50QjdxVlJm?=
 =?utf-8?B?QXN4R0ZwOGxJdEJ0R1F5S0V6eEVSeEJwVzBEQ2c4b0JmUHNUNkxKcUJHV0g1?=
 =?utf-8?B?VFlYOVVNV1dtL0JYeFlheGRvdC94K09WUWkzK2dGMjA2elJmamlmRkk0dWR3?=
 =?utf-8?B?QSttWGpVZFZjdzVHOEg2b0s3OUhsRDR4MjdsRENnS2c1UnEwTS8vVU0yQUR1?=
 =?utf-8?B?SCs5WXdDSGFxc0szcFMrbWZyV2ZzOXB1dWl2NFlRb0s5aVRPTWVLRXdvVGtn?=
 =?utf-8?B?bmpVWkdBTnVxeVRqeERDcENMMTdwMWNEYmhtYmNOeG5nNjJpK1hDUS9tSkt1?=
 =?utf-8?B?TWtpajJwVHBVcFpEQ05hNWtjNVZGVmpKekRqK0tFMHNtNkJxUFhCbXVEY0w0?=
 =?utf-8?B?cTlncy9yTHU0WVExZlp0UjNOUHVVaGZUczZpQVcvSjhDOWViQ1RZZ3hxbU9u?=
 =?utf-8?B?Q1RwZ2paWCtJKytpT1FNODQzWHF6anhRQmZDQUVyQ3VRSlJYMnc0VnlkYkpK?=
 =?utf-8?B?UGxTck9PdzdEVVRXeXJMQ1hkcjVZcHZEUmpPeHZBdmYxWnpqMllDZXFLQTE0?=
 =?utf-8?B?VkZibTEwSkVCRjhMYy9CU1phcmtOanhENU0reUxTaTNOVm9YcFVqaW84SVpx?=
 =?utf-8?B?MUJzTkpucHM2dHJPZG9LdXVobzhJMmVCcjRydEVpWFA4eUVYTTBTNXFCeVI1?=
 =?utf-8?B?OHFpQ0dMSTMyTmlZTW5mK043ZkdycEFiZ25MQ2k3ZlBMR2JzZXhaTGE4RXJw?=
 =?utf-8?B?clh4NWhoN1dvbjFhbmFWQkJIZVMreTlDVlV5M3VpR05LS2YzMkpLZUxQTFlJ?=
 =?utf-8?B?SzN0a3kzUkc5ZnNjMFpuaWgrZVNjMFJMdk42cDNoNWYzMEdpU0JaQVptVnF5?=
 =?utf-8?B?c3NQbGVWV1g1bXlPeE1mUVRSWElsS2hBbmNZeWRUdENMdEtIVVUwWEw0U0I1?=
 =?utf-8?B?QmdWRTZPamVmOEtRUFpvNkhJLzRaTnJyeXdVRWwvdjM2NmRFN2RjV1RVdTJn?=
 =?utf-8?B?ZXBFUHlmbU92Vm1pK3RCQ2grWGZ6bGIwUGwrZVNUcXRYeEtSKzdtN3Z0V0N3?=
 =?utf-8?B?ZHJkTlhLbnRUTTBzZW5IRTZPQjRteFVGNjhBK1VUQ1FlSjU5dWZBdDludEZ6?=
 =?utf-8?B?OVRncW4yYTFnM2tDRUhSU1hJeWhqNXBSVWpoSjliRTZ0MDlZUlB6bm54RndH?=
 =?utf-8?Q?byoU=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:45:22.2175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e521a36a-ba86-41fd-4911-08de239d340c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8986
X-Proofpoint-ORIG-GUID: xUK5hn2BQx3sgxSVBVqBuOA6bQcdOQmU
X-Authority-Analysis: v=2.4 cv=DPqCIiNb c=1 sm=1 tr=0 ts=69175ca5 cx=c_pps
 a=kjmD25oco6ZTzZ+b+45Jlg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=spcqjml88TDtDxUO_NwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzNCBTYWx0ZWRfX0V9/J1miRR4E
 6aq92/lg7Xf311TaMOptJXLHudzcCIkMzhVi833vX3/MUTxCk/cK5NaKPBqTamUrhDEnOC7VPJR
 E88dJQM3g8AUPMGRZ/E0a7C0idzcbxi2J2Kc/YY9W//B4VuApuXQflG3THBaNtdCvH2ef6nio5/
 sALdD23yK211GWMzCy4hXMMm9fv5nTHXkKT23Bvz6+LRZVum8EEU5vCmLIq6RT83Bg3Isano/6O
 10Hoa2vNMlEezcQseEUgYVe4oarH/l6Yl+dN2W0HtXhpDcZcwQpWiPkug7R5YLiVdEzCfMc5bk3
 ysnF+8DncvjpoGIRVsi2LaRcJz49JQByR2BttW93dUlZdfsD0LZBKXgdiii86buKg3aD+sdykGv
 FDARH7aTuCbcrc3ojPQv844gi3vDhg==
X-Proofpoint-GUID: xUK5hn2BQx3sgxSVBVqBuOA6bQcdOQmU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140134
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



On 11/13/25 18:40, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/17/25 14:18, Patrice Chotard wrote:
>> OP-TEE "arm,smc-id" is equal to 0xbc000000 but kernel DT has been
>> upstream with an incorrect value.
>> Fix it temporarily until kernel DT is fixed.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/dts/stm32mp25-u-boot.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp25-u-boot.dtsi b/arch/arm/dts/stm32mp25-u-boot.dtsi
>> index d9aeeb6d510..ee82a0289e2 100644
>> --- a/arch/arm/dts/stm32mp25-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp25-u-boot.dtsi
>> @@ -39,6 +39,11 @@
>>       soc@0 {
>>           bootph-all;
>>       };
>> +
>> +    /* temporary until kernel DT update */
>> +    watchdog {
>> +        arm,smc-id = <0xbc000000>;
>> +    };
>>   };
>>     &bsec {
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
