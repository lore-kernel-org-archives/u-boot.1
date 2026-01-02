Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5ABFA3739
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 12:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB80839D7;
	Fri,  2 Jan 2026 13:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="nMJJ8IGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C7B83A64; Fri,  2 Jan 2026 13:00:44 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A024A83981
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 13:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue9HKM0EJMH8C2W35ksqaeBa4IvU0bruvg5S8r8uMvKdJ1GNk6J2PQBFWPkIlmIgPCG1BryosbMarTc01aENM6M6IhHVtphoGOtoMakBcwjpxQCgMl3czpVqGOx9AzuJUanarG7lb0GMwmEeUBlVW67wiPrFpKcv2M+spG7rf63QVAafamxP8oxXoDlp8Xg89xUQLV6TAqmMVFSDdQgVO/zOiN9HsZYwsZKxUFUXa0c8+5larfnkzx9EIuu7LJdd7Uxki1YKjRgHIfhPMcyZBv2tEiXQFSQ0shCDDqoO7pWjqZDoLAWaJjMpEoprFcSILCK1P3AAoapPQOk64xLN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7MuQr3WvXGLn37H02aMKFS7qcwmeq4Tdeesi7k0Sgs=;
 b=x/s4pGyNbrW7F2geA5W6a3W4bGSOKKwZjE15LTxYLM3Bwlf+A/oXciiwTtKEwxdzcl6BBC1PDvTFFyjDBOuOvUmw39KF6t5uOZ9n/+F92OfX8fFER9QDl7LwyYdTd17V35ltnE9QOLtmGZ0aXF9YbaAgNXeOTGxGtUTv7i0C47qNWCaLoq/VHrqWGr9ftorZ0vG9couprL1YcMqXNmqoBW6NihBZN8NfRgb/76s+ey2JOwe5tpdWdJt2OwlIWmUlVDjIihvPi2NX1Ydves4vSoMt2rUZfmM5hSt+asYzMXcFQ8XD+05/ztCv3frlCwF9SvI9OxPDKwCnmWyclvLxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7MuQr3WvXGLn37H02aMKFS7qcwmeq4Tdeesi7k0Sgs=;
 b=nMJJ8IGL5Pfq8/Byhsx4mh4qJwYo+kZEZQ4+NjRugYTc/TlcCpL057yZyWP2q0U3XLbC62ESUEAmqJsGEW9FQEwqHRQZ4hKUrAtwgtuCr7w/V5enHrLXRVM/OL2R0xtpnMGasdT7BL50XVALfj3vdLgpmKn+4s9CzmY25CoLD3pM1FElluCBx0CEaIFBVy7+7PuN6+rtNczhMOogeCGZwlctq04L+OlEnahalIziOrr8mqpPUmywjU0Au0mg83x+08nMF/cJVb//OZBY26aXHXFkLE0lYilFg3litQ9zem7jXAKOuNe0RRGpprw6E8o/3RfqFwOz8CVvRzSajMC2ww==
Received: from AS4P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::6)
 by AM7PR10MB3924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:171::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 12:00:38 +0000
Received: from AM1PEPF000252DD.eurprd07.prod.outlook.com
 (2603:10a6:20b:657:cafe::39) by AS4P191CA0046.outlook.office365.com
 (2603:10a6:20b:657::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 12:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000252DD.mail.protection.outlook.com (10.167.16.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Fri, 2 Jan 2026 12:00:38 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 2 Jan
 2026 13:01:49 +0100
Received: from [10.252.11.251] (10.252.11.251) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 2 Jan
 2026 13:00:37 +0100
Message-ID: <020df345-65df-4d5b-945c-36db65428587@foss.st.com>
Date: Fri, 2 Jan 2026 13:00:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] clk: stm32: Update clock management for
 STM32MP13/25
To: Marek Vasut <marek.vasut@mailbox.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>
CC: Lukasz Majewski <lukma@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>
References: <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com>
 <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-3-d055da246e55@foss.st.com>
 <869f8843-8d43-4c1f-b6ae-0116fcf64ac4@foss.st.com>
 <f6140b6b-2dba-4bfe-bdf8-11a9793916ee@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <f6140b6b-2dba-4bfe-bdf8-11a9793916ee@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.11.251]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DD:EE_|AM7PR10MB3924:EE_
X-MS-Office365-Filtering-Correlation-Id: 44743e72-1508-437f-8bf8-08de49f68b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0ZyL2J6TGRtcmRNK2pteDBWci9JS3FCYUQvN29NNytPcE95MTh6dUswdzZj?=
 =?utf-8?B?ZnQ2enMvOVhpM0dDSEE0UGVVSGtSZmFrVThsR3k4dE94bEdyT2hiTU83aENt?=
 =?utf-8?B?VW1YRlhNeHc3dW5iTGxPOWozcjVWeXJXb2ZYMHBiQmowZEE4d0p5WUVBd05O?=
 =?utf-8?B?Zmlldit5WE1ST0wzV0U2MVBRZHZqM2RkRE9YeWZSbVJLdkFramo1ZHlkUEZa?=
 =?utf-8?B?Z3BBR3BRZWlQOVY3OFNwSG50eDU0ZU9nNGdFVFVZSFg0Y0JjbTIrVGlXNTJa?=
 =?utf-8?B?SGRwRFdSL255N3dPV1FnbythTU1VUXVHMEtiRkI0aXNuQ2hGSGRsL2xjWUJ4?=
 =?utf-8?B?eW5wUHRhR3MzTEZOc1Q2VkdZSzhoeXgvTy9Xc1dycjZFYStDenVla2FsSjN4?=
 =?utf-8?B?RDhUeFhrbEw5MzQzUUI1MUpMTklFRWV2dXY5S1NLdGhUTkY3MGNNUU9URUxU?=
 =?utf-8?B?b3BsWGlEdWZGa1VRWUkvUHRaRXhLM05rSTJ3V3IzUWJRY01zOHIzMFoxM3dV?=
 =?utf-8?B?M1k4SXZsaEk1aSs0WXQ2SkVxVnREdkMxeGR3eG4zTTRHMGEwVFlraXdIai8y?=
 =?utf-8?B?d09BNkJZdmJXVlFxek9RUUtKajVSNEpLamVDT0ZZWnJMV0FjZDlhZ2NxNk03?=
 =?utf-8?B?dXgzdzZTdUIzdjBPUVdWOTJpZHVIRjg1QWU5RFB4bVZHRlJOUGg0QkdXNnE4?=
 =?utf-8?B?ZVduQkk4RlczOWNsYTNIUGZCdWIxNGE2dHFWTHo4REJVdGswVkEwOXVDZjZy?=
 =?utf-8?B?RWNCcnozVlk0YTIrejlva1ZFQmIwQk5NSGEwaTEzbWRPaVczYXdTUFpHRnly?=
 =?utf-8?B?anE0VElEaCthZEhjN1pxNEdCc09xREYyTTRITlNRT2hEcHUwQ0hzRUplTjM2?=
 =?utf-8?B?eFV5aHZVZDgyL1BUWm5PTmJtTG9CRG5HZkRWci9HSHVRRFRDTWFnV3VObGsr?=
 =?utf-8?B?eUhtZGt6ZjlkTTJlUlUvdWpDeFd3UlJDbjJPdnJzV0lLYmVHWk85L2xSMjRQ?=
 =?utf-8?B?TGowa3h2Z0lQbndaeDN5ZjNDUlhpTWUzZTdUaFJDUzNwcmQ5a1FNVkFiY0dW?=
 =?utf-8?B?VElhUjRrU2FLRWtrRDBkenJLVThpZU9qVThpaE40ZHB2T0swdlBBSS91WEd0?=
 =?utf-8?B?eC91WVR6Y3pBY1I1UXptSWxaS044L2ZnSEtTR2VnMWcvaDUwbGxPTVVBN2lP?=
 =?utf-8?B?QUxTYVcyZnJyeEFIc1ZEbXNZajVROEJnUFJ3UEYyenlMQU8yNFo0K08vL1pZ?=
 =?utf-8?B?QlZjRElndERsMVpTRWlMaHNFODhSdjJTRzNxTVU2aVRtejFVK3B0d3RENzZo?=
 =?utf-8?B?dm03ZTJjM1BieFN0MXFCMllRWUpmNDNwZHRtak96QU9sM0lFb3BJRE5nOXdV?=
 =?utf-8?B?MFYwVXp1M3hBazVqcUFkbnNhOWdybkxsRlJwcUxrckVYaUdyZmNLTDc4a1lx?=
 =?utf-8?B?M01JS2pHY3YvWGNnK1kyR1hvZStqcHovZjEwRzcyQWorbWF5cmVBSlFBTTRn?=
 =?utf-8?B?YkhMNjRjYWpmRFM2UjZUMStpaHhRYVRObVlWMFZ3Vk53VFN0U24rNlBqQ1pR?=
 =?utf-8?B?ck1udkNwZUxJd205cExhR3VYV3ZaNHZYM3k1Y0FucEY4bmtnQlUvcytsdkI1?=
 =?utf-8?B?OU1KZXJ5bTRJOGhKTDZwdGMreS9na3ppL1NselFFMm5xNWM5WHlQaE5MNGlm?=
 =?utf-8?B?d2xEeTRQbHU5emJXZ1ZZbmVpTklUMGxjSTdTeGZGdElRZGNTNkxpRkFvMC9O?=
 =?utf-8?B?Q2FRKzh6aWZla3NWTVNRLysrTDdma0cyTHZ2NURvOVBiUnNKTHROQUd3aW0r?=
 =?utf-8?B?aG9OSGtJR2NORVUwSmRNYi9scmF1K2hHaEg0YnBreWZWckZTZ3NjMEl4bW0x?=
 =?utf-8?B?ejZNUm9KWGN1L0FqcXhwV3U1V0xLZjBhb1VhZUp4bDFaeWk5cnBnR0VnWVdH?=
 =?utf-8?B?cTZmWTgxUmdua0IzUmdYTmxiSHNiM1BEN0NYTkJWSS9Qemcwcm1zSXlYc1JD?=
 =?utf-8?B?OElkbjRNcVRtMVJHNFI0dE51VWhjTEIzanplakorREdlQi9YcWltUE5aVXJB?=
 =?utf-8?B?NTY0L0wyT3Y2aHlMT2Q1UVJMVGFqVjRqelk1ODdZZnFlbE1tbkhxZU5PU0FR?=
 =?utf-8?Q?ZFL8=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GSTINy/4Ut6tt/iu302lL2IsW/DCgD3haNxaDfpA6/IrKXSS04bV3PbxDuuBs/JUye7uWH9sdUbKIxgIWfy8UsqBIeoWQ4d0aipSv+dTwNA17lxtMHCJk3y62zyeWp8BxFOUped4rvkLfbPYPrnSCXgsKXs6guRciZsi9F6BclURKAhXhH9wyl7JWiQf/wha/mrcuEmc5SOvaYPY1E79XERB5pKjeAOIzdXWrfipdi7zDc0/qFtSyKVrf3smPaWo+w5hYcgkv0KN7datxfLr/h0+wZGNWtZoL7bjVM/1CXUzMRmPxBwyPoR6lp0710pBQmfC+5hgCqr1Gokl3uggP8n3mIaaV+XUkhzVrqU/xUYx+pVuMyWO/FjDpzl1j7NYgD8KNTsOgcYPjTGbZxW399chJ9N0jlhEX6QIpfouNiM2Hd0eI4rjAbUYucYA5wNoChEJThYZByPEN4wMX3Sl7AJjgpkSH+2lDfvQTbK5BQjQt988kJOrWFZ21flwihtRbCbUiRTMLR8lejAMb67+2Rx8xHqO8oeRY+6HSweWd/oEhi7sPo7HC7lQrVmONEC0NGZIuEe4w5KLoI8rnQLJLaIY+gCS+KYpVZIjGKhXVA4P+syFlsoS1kGKDQ8zzWSR6CRv19QCfw8Vq2rHAMrZXrTPTONASAIaXoySgejtBcf/LAFDNEvV5i6iRxn+Yp1j
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 12:00:38.5171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44743e72-1508-437f-8bf8-08de49f68b97
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DD.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3924
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



On 12/31/25 16:53, Marek Vasut wrote:
> On 12/16/25 4:35 PM, Patrice CHOTARD wrote:
> 
> Hello Patrice,
> 
> sorry for the late reply.
> 
>>>       /* WWDG */
>>> -    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", "ck_icn_apb3", 0, GATE_WWDG1,
>>> +    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", IDX_ICN_APB3, 0, GATE_WWDG1,
>>>              SEC_RIFSC(103)),
>>> -    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", "ck_icn_ls_mcu", 0, GATE_WWDG2,
>>> +    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", IDX_ICN_LS_MCU, 0, GATE_WWDG2,
>>>              SEC_RIFSC(104)),
>>>   };
>>>  
>> Hi Marek
>>
>> Can you give this patchset a try on DHCOR board in SPL ?
> I have bad news, the SPL does not even start with this, no output on UART even. The problem seems to be in 3/3 , if I apply only 1/3 and 2/3 the board does boot just fine.

Hi Marek

Thanks for your feedback, i will try to have a look at this today.

Patrice
