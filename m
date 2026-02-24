Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1A0E9B260
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3A483E88;
	Tue, 24 Feb 2026 14:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="newmT4tG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1922F83E85; Tue, 24 Feb 2026 14:23:20 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A39482BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAMkymkf3AZHq8f0+wkB4A9KHVlfuUf7VwqCC2vjRd0MC3Hd0fEMYxXB7Ve3BjNBwbg7DKI2p3U8hsdIkcsrQdJSHB9Xp3l7fHBR403dCzmfn7Wy5KAzuoAiwYCAzR3jQ4GeObSjA3fBJ1Hzt4zzBJVAloMpor01gA70ypRknw/HeGNq8KujjxAYS2LGcKsYcHd5qjvDXZbaccZB8ytx2atDYGTvg5OTDE0U0hRGR8Q1XmFjBDCtzjM7jaQahAht9b2ym98rPaQxIBgE0ZWeLm/ethATvVplafLHoClGAls9iwA27QwUiGyL32nwACHvmHF9KQd0IX7Ni87p7audVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZsl9zHi9w02+yR3dqA9ldEvhS59aHtFz2pmPB8/NN8=;
 b=u+MhJXabxZcpzsDHo6KjvxyuvfYQvSMn1YBmRIxEOgHQ3ic3/C/7uXNwWPcCJyFWSMS3sFoTWe9B2zafTSlgL5EKu7Z4e6MMfxIX1eZ6qml3NBKbmMcbAsstho0t1bRS+5q+nWERvpX5KW8wZdfiBqcJ6afM0B6wUapC1F2Gutggi1AohzkhhDVSd0GT/n4J3IDsp9q8gQ1L7SImPH1JaKHXdHGq4kVtW+WJf27sy+gF1njjRMOBrPRz8/LzjQ6aLaWwsCrAGdNEDdWx+Q2zGX3+uq/vgVBaJs6uPxFV8/OZc9EZekSJGYYqvOcGy4xDl8QzRI7AwpPPfpU0mcAgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZsl9zHi9w02+yR3dqA9ldEvhS59aHtFz2pmPB8/NN8=;
 b=newmT4tGmYku5HtLlobOvIkuwTc9+PlP5+Hr0UM/+PKMoF34yfs7XkLAoRyC5WCG8M8+BAKNxP3Jgmps3xqXLPlEUzvFusrhcg80/WVvc1IBECS7h+/vB2jBN3jbiq5pb3LM6ARF8tOhADsu/i8efFex/wyl/PGFlT01lNEI6623zMMYvDrHz6n4XniwbXKjL2vpVXXNR46pZlMf/OhncHmagInon5Ld2GLoBZOHYav9WXrqhBncimvllpQqf0ei1hqAPZlaDcKme8mqMut+5ppACJid1Dn6MopHFUK0Q26rLZWLobIh406iA/E29SejTod021NyHokHY5jHoRl3eg==
Received: from AS4P189CA0055.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::22)
 by FRWPR10MB9291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:184::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:23:15 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:659:cafe::11) by AS4P189CA0055.outlook.office365.com
 (2603:10a6:20b:659::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:23:15 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:25:03 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:22:46 +0100
Message-ID: <ed28af54-f9e3-4127-a686-0c728ea83c03@foss.st.com>
Date: Tue, 24 Feb 2026 14:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: st: common: Add support of stm32mp21xx-dk board
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
References: <20260211-upstream_update_cmd_stboard-v1-0-63fd9b767bcc@foss.st.com>
 <20260211-upstream_update_cmd_stboard-v1-1-63fd9b767bcc@foss.st.com>
 <8890c780-53d8-4e43-a267-8215998f8b9b@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <8890c780-53d8-4e43-a267-8215998f8b9b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|FRWPR10MB9291:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b80bca-5256-4760-5566-08de73a7ddfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlcwU2t4RHQ5UWczNUlVSXlLcmljZXZFN012by9tMmVCSjZlRlNOWW01bUth?=
 =?utf-8?B?MjRGV3M0Z2dNOGV2VktUK2N0bmY2L1hZS1ArRFRkYUNkcHZ6TmVuUzB2RDll?=
 =?utf-8?B?V0dGNXhQdUsrd1RnSXZqekVSVFAwQk55b2FYMEd0MTRkb1pDK1lvU3h3TU1J?=
 =?utf-8?B?Y0pGTXhQL3V6VnlxTkl1azhDcXpkdTZUWmVYNTV4YnQwTElQOG5YV2pnZWp0?=
 =?utf-8?B?blZkQWxyam4zVjZEZzVrQlZwU25qS1B6RVF5Ym11QWF0R2YveEZvTjBIL1Rl?=
 =?utf-8?B?NlVxYnhpcDZqdDhrZWVUQUdZNlNPRGtBTGkxRm10NXRBVTNFU2dSd00xSE9s?=
 =?utf-8?B?Mzd4N20vNVE1VXNmbkNDcnI0MTdFVzVpSXZ0NkNMSGxVWFowTUVZWGN3QTM0?=
 =?utf-8?B?WGd2MXhuL3hXY0RIaS9WcFBnVWFRMHJjUUdtWEI0U3JBVHhzUGpNVEtnbWJJ?=
 =?utf-8?B?djNIZXVLMU1iSWNIK0YwNlNXMUZxa0hZUjEwZE5QbG9jY2FxT0ZoalhCWVpN?=
 =?utf-8?B?VEt1UEdtTzlWSktMRy84bFZIVXF3ZVVCcjNwZEdlSnp0L1NRNEtQQXlRbWlW?=
 =?utf-8?B?djBuVVNkRWJTY3FTT3BtNTQvcjBMQ241cmxHeUVqMmFuNmw1RDI2UFBvazB6?=
 =?utf-8?B?K0RVdDVkRzEvOTFzMVRCMDk1d2Q3dWFlZVJ5RHpHUWROa1dzaUN1OVZwa05s?=
 =?utf-8?B?a2FxRDBOeWNaRzh5V3R4OVZWZ3d0K0poaTN0SUszY2l0M0dXSkpjdmJ3L2pK?=
 =?utf-8?B?TVoxYjFtK3NheFJNQWRjSmVoZmJZang1dWtuRHZieSswYVFFVncrcWY2NkR0?=
 =?utf-8?B?WFFiV1dOa2tUVytvTGRCcTBFMzB1QkkrZGZLN0xaYnY2elpOSURieVdIamxH?=
 =?utf-8?B?Z1V2Mm9DSVIzRnYrZ1BFZ093MTFFQlFRL2lhVWFVQkRUaHo0d1lzVDhqRjYy?=
 =?utf-8?B?RzZRcWZHeTM5RlFnMUJpK0NwUldiYVkzWFV5R29UK2Z0cndyYlBrRjZ4V1E3?=
 =?utf-8?B?bmlneXZQU3NmY0hwQm5LSy83S0hnaDNZNktJZnZZL2g4WnFWTXV4ZnNlSlN2?=
 =?utf-8?B?ellhNkZ4eFlqY3ZDMHE4OXVJMTl4QTNNSUIwSWIxMDBCWEhWWTEzaXlRWDNJ?=
 =?utf-8?B?OWZpLzVCOEVLYmhmSjNvVCsxQTlpcUp2NGRqUUJJZlgyblkyQ29kZXF5aEt6?=
 =?utf-8?B?bTFTQ2FNNlR2RERwMU1pNkV1OFNCeHVCWlVJbzVvK1kwdUJNRkxUeDZSWXl5?=
 =?utf-8?B?REVMeWFySkJWMXdINWRFK2FyNzV4Kzc3SDlXaGRjSXBrYUxTVlpWWkVoRHR5?=
 =?utf-8?B?V2lFMGdiQUZia0NxdG4yUFZ4NmF5NEJkL1pCbThIRGJyTkhCNEVlekVlYisy?=
 =?utf-8?B?K3RXMlNpTVI0NEpSR1hnVGNIWHpRMHZ2dm9yYkw5eVZmdzR1VzZUVjlVdTRo?=
 =?utf-8?B?TjBYaXhwM1ZHTUVmbTFsN3R1K1dJczE0cG4xc3VJcTdSV3JDVG1qTGhzNGw1?=
 =?utf-8?B?ak1TT0xjWE1nb0JwUTRHQWRNelJVZVNmR1JFMzFQODMxZG9UUWtveng5RDRU?=
 =?utf-8?B?Zkl3a1ppR1RDNG1XUk13Mno4T21JUFNrTVhDeXRFNkplaUVmY2RuajNZREdX?=
 =?utf-8?B?NFdYSTR5ekk0ZktoQk5zdUlYVDYvSkNzQzg4SDdsT1dLOG9ndFAyWTJpVi9E?=
 =?utf-8?B?aGRoL2tvTld5djNCRitRNVVENlZCTEkrWUNsRGlVZjU0NVpLclJHM3pQZksw?=
 =?utf-8?B?RFUvN1JXOTVyaCtNOTNtaFNoNUdyL1FlRmt6QjZMblo5THd2bzFLaTFRT2Va?=
 =?utf-8?B?dkFwTE1UTDJyQXQwUlA4c1RyamY1Wko4bzJydHdlVnlhZmpOckRnOFNXT0lw?=
 =?utf-8?B?ZFpaTUVwR0plKzZoV2hXTjFaTk8wdTJpelZnUmpkOG9LNmV5c2RQN04ra1dU?=
 =?utf-8?B?N3BMankwTUFLZDR5VmJYNWpGWnpZRFNQTldzWGhmN1JVdUR5NGw2L1ZYTU9R?=
 =?utf-8?B?aGNUemZYbUZlMFpINWpZempLTElrSVVvUkdxYWRTMXRkYTJzcTZzVWRFNGJZ?=
 =?utf-8?B?eWsrbW1uZlBjMXV3dWd5eEFJSmJ6ZU5JQmsySHpUdUp2TTJkTWhoSFBHbWdF?=
 =?utf-8?B?MGw1cjd5Q2tKVHM2R0o2V2RvSVp2MFJSWFA4NTl4NCtDU3FVZUF3Y3R3Yi9Z?=
 =?utf-8?B?Qnh4b1pUbFU5R3NkUFlqaHUyQ2xBUzVzaVF5c3dZdHhHZ0NkRGVTZm9vRWJ3?=
 =?utf-8?B?MlhUVlVqWWtieElpMW5ja3o4MFd3PT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZgG1OL8f/82m3NZ2sMm8La7kc4/ah3GdMw/DTkdhIs1VvGy4d963L9nANCkEiwHOJwMV4guAtvh8guLbi+AXjiIrK7JjgsnqIwVh2qzD+t+A+VsE4zDnvxSg6IeTHYKOwCzVhgURXiZk2/3ODN7taD+yASxtDesSXOMyJDTVLKoF/8Ny9pRfTGD90woJC7PxYTpwD/3rUx7jcvNA5uWFZ02uwu47gztCXmwsmCQdFzMdbdO/9DaoDPy90QwYUX9KhfQrzyel2eKlupPhN1gB1lJ33qKqihPVROUFpPfwZ+oxtjAK3Y2CKMWsZvyCy0ER6g4Ng7jR54uq/TbHalfNcC0gnfjW7snArtNpFcPqLREeW0+7RAlDbLsszGr6SyEUp2Niir8FUNcwvybsB5quhafCu6cWFmupTZB4XXCqNnc84amtJg76tTK6pD8rQzFU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:23:15.3210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b80bca-5256-4760-5566-08de73a7ddfa
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9291
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



On 2/24/26 11:34, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/11/26 15:32, Patrice Chotard wrote:
>> Add board identifier for STM32MP21 discovery board = MB2059.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   board/st/common/cmd_stboard.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
>> index b9d0abdba7d..d77046499a0 100644
>> --- a/board/st/common/cmd_stboard.c
>> +++ b/board/st/common/cmd_stboard.c
>> @@ -51,6 +51,7 @@ static bool check_stboard(u16 board)
>>           0x1605, /* stm32mp25xx-dk */
>>           0x1635,
>>           0x1936, /* stm32mp25xx-ev1 */
>> +        0x2059, /* stm32mp21xx-dk */
>>       };
>>         for (i = 0; i < ARRAY_SIZE(st_board_id); i++)
>>
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
