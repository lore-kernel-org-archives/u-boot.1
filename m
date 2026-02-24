Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3065DE9B258
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1ECB82BF2;
	Tue, 24 Feb 2026 14:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="D8r5Rw+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A416883DEA; Tue, 24 Feb 2026 14:38:52 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215E582A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUbxjLFbjYBTSBcx9fdCaEV0oDAG5zC1DsFMgDIrFnGzzYgd4C7jGAqY9c4B8bgxsJ2mSPm8phrcL1+v5QjuT0s5Bn0y3EWwiHdXjy9Vw4GNNMq1fhAjER57sp1FlZ6fcjrSoj8XLP1gia3FsyuTP5s5ZunPxE8I05d5qA/WBpyhNCeo06Tiy5VZNaGsvsx3NW/mktJxjF7cDr6LVNYEyYSyqzUrVpWV+axHfavT8odTY7bplAt0Jp0o4AP2sB+CuFp6EFlzrjVNYVwjApifU91rnjitnTLVdeaeJj0MEpuPGTNpM8x6lT4g782uoh61ELUqAmPZJYZsICj/3btgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ+aXph4v9Un7Nj5X0WZmuQmdqY1iigAeFqaiKhgLtY=;
 b=S3qWlNEJ8lUr31SYgYRvRCh3vOmuZ4BqW+ESHM3tojVdXfCTeM/BBdZfZ6JKlhFlZ7JEQs/aGCPGGNaECqIxOaR3MAtU5A8nlxobQX86F18RQrx0KKQoawTLbbQKAh7fReSWYcJ+hNwZR7MPV1/WQ2UZTfLhsFuvqzydmPZX/pMBmnLfeKXr6dVKTPlnj+A5BlDyy7hJGw3UbXiDCbO2gXnClBw4kv40YRgNjhf/BPc7iAPktH7e//7yaaQHCU3H3KhBqSop7tQfjVTXzLpCm8LJ6+CgzLa7uEfe2KIWzei691WkmlZrMy8MOC8dUvGmlkFz2vYu1XPegp3edp9QTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ+aXph4v9Un7Nj5X0WZmuQmdqY1iigAeFqaiKhgLtY=;
 b=D8r5Rw+a/r4q5r0sfU1H+2idjrKTBVYkUrWyhu+3gUB9lL76MkWu3PK21DhyCRAy5j+Ny35EpOuBHXKmx+Lybbs9pIhGl+OyPz2QHliQiegKR4pTXCPOpQoySKc7zYk4LEvGnAsUc11o8vPyMq5X4efHxz/br3CC8lu1oF3wg/jCGg2WpS0BBMKyOVI9bTSXY0F1M6LW3b6whiUHUpwxf63UcfQUbvMIchi5cngWZEXr1LmS78odfuS9gn9uWB/MrNTHDdrVZVwU1wiXlDnABGWZdUGzRZX7Ajq5+1+8vtkNz1ikhVSA1G/8SxgS6GjD6mzhqPuZepskjJGlY9POiA==
Received: from AS4P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::16)
 by DB9PR10MB8215.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:38:45 +0000
Received: from AMS1EPF00000091.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::5c) by AS4P250CA0028.outlook.office365.com
 (2603:10a6:20b:5e3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:38:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000091.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:38:45 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:40:52 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:38:44 +0100
Message-ID: <5ef95638-894c-4919-8ad5-750a1c35c4fd@foss.st.com>
Date: Tue, 24 Feb 2026 14:38:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ARM: stm32mp: Add STM32MP21 support
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Valentin
 Caron" <valentin.caron@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Thomas Bourgoin <thomas.bourgoin@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>, Yann Gautier
 <yann.gautier@foss.st.com>, Simeon Marijon <simeon.marijon@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
References: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
 <20260203-upstream_add_stm32mp21_support-v1-5-48ca3409cce1@foss.st.com>
 <3c678260-1859-42cc-8f84-0e0682f64b59@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <3c678260-1859-42cc-8f84-0e0682f64b59@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000091:EE_|DB9PR10MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: f150e9a2-1dc5-4341-6c4e-08de73aa085c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUhlWFkvcVFzMHVXNEhiWDhTSVVKYWE2NWxRd0V1TWNHenV1ak9zd3pKVlpC?=
 =?utf-8?B?MjErRG8rbzFlSnZjdWVtVmtJRzgwbWl5Z01ZTzNUbVZpR2krZ29vakZmWXgw?=
 =?utf-8?B?R0gxTFlGN3haZ2RyWmN4REN3aXpNS3FEeEVJSmZ2VXdtQWUzeC9vREJSWEkv?=
 =?utf-8?B?R1d5UHR6d2FXNzNqUklKZTNrSXRmS3dsU0lHaXo3UjRvb3VqKzk2N0RRelBq?=
 =?utf-8?B?b0xBSFB6bXB1blNzdk8xd2ZZK2lmeG9lVGlOWGpIQ3lEMUZtWndGYW1TaGJl?=
 =?utf-8?B?Zi9pVi9lc01aeWNvTkhXSWtQL093MmpLa0l5Q285bEsyQ2Nvc2FNUUt5Wk04?=
 =?utf-8?B?YnZnaEN2K1A2VGpWUjVSanY1SkJreGxYaGZkazIvSDNMNW5DNjRNcFhubGJV?=
 =?utf-8?B?RlJ2Ymd1eEp2S3MxeG4zeWt6b0l2Q3dWTUwvZzhHSDQ4MVQ2YlJiODNPU3VX?=
 =?utf-8?B?aUU4YXhBSkg1ZlRSMjJPem95d0NFQkpOM1Z4SkY4RUZTMU1MLzJGWnh6eE15?=
 =?utf-8?B?L003UzlOb0plcmtOcFk4Y1RERng0N1F4cWhtaFZEWEd5WngrSitMaTdsN0hp?=
 =?utf-8?B?QStRaEF5NU5rZklGZkpiRjl4NXZKeTZFdEJkZ0lMVmQ1YlhseGJWcGx1K2hX?=
 =?utf-8?B?RDV3YkZ5WmZ1Z01xaVU2YWRHOWJjSmI2S3hOVmpLN2ROOW1QRmZqRXh5VWRY?=
 =?utf-8?B?NDNHV0Q1OThwdHhLcGVtMy9vYTBaMFJDVTlZWWZBNDRSUWk5QUFrMkxhVGtt?=
 =?utf-8?B?d25PWitzVFB3WjJ1N1F0Si9kVGwxVFg3dXNOR2YwTU0xUUM1MUZmZ2ZWaVJL?=
 =?utf-8?B?T1ZjNXVUaERXdjJ1YUl1YmZPMnI1NXhXVmRjcWNwMk9GbitsMXZoZm92TUND?=
 =?utf-8?B?WVdmd3FnWi9sVGhHWGpZcTg0cmxuYXVscVN5YXZqY1RpMlgxL0dYa2JmVkRQ?=
 =?utf-8?B?TG96OU1jTGdvcW5zcWtxTTBRT01lRGRnbXhRRkExdVYyTlFtWktHcXJHM0k0?=
 =?utf-8?B?eXpSNjlhVHg5a1ptanpqZTQzRjJrMmkxQm1CWVplb2VJeFR4c2pUeWlEYXJY?=
 =?utf-8?B?NWNmMzFwRS8xOHFZUmVHTWlleWhSLysrMTNBVjZhWGRXaDBXUGxzNml3Ynls?=
 =?utf-8?B?WlJLVXgvOHBSMndONG9tdk54eVlpaDFGWEtiM2MvMDR0cVMzT3Z1azN2NUJa?=
 =?utf-8?B?VDRlZlRzUVVDZ3pRTVFXamN3T3QrcEN4QllOOGxland0UnZFTE5BSXJEWDJD?=
 =?utf-8?B?dDNDYTV0ZzdRdldKeGh4Y0V1bE9HVXRmeUswRFUrYmFXSHVJWjBPaU5RU1ZU?=
 =?utf-8?B?eWhESG5ybFRpYW5POVpMSmpQWXBIdDlBTWJkYm00aW5xbHhjbXRBQnV5MGVv?=
 =?utf-8?B?Y2dEV1krUndtQm9FaU5lTmQvQlhVSmFnVzlLeldQKzFheWNZWE9IQzFJSitn?=
 =?utf-8?B?Y3AzYmFzUGRCNXlmbittYzZNQTEyTlhVN1l3Z3R4N2hnQTBzbmQzMTlMRFlq?=
 =?utf-8?B?azhEb21ldDhRcW1RZWQ4K3B6NldvdWhEcXNRQ1NvZVh1UVJDUXgrOXJ3Ukwy?=
 =?utf-8?B?UE9ZZkpxajNWNEJmLzkzMUQxbHVCNFVzTGZvTTNJVlZrazlnK0haRHJ1bFN5?=
 =?utf-8?B?VDVRa1h6anptZjk0QlFNRzZEZkdqeUVxL3RXenhBdVFFNXphcG40TFY4UVVR?=
 =?utf-8?B?WU9kclJ5amliVzhJck9FcDVMUU5USXBFcUNhbEZjY0srcGpGYUk5ZldoQThm?=
 =?utf-8?B?bWZ3WXUrdVdocFo3QXg1M0craGh1UnZWT255SS8rVjlveFVCR043ZDNhdy9D?=
 =?utf-8?B?dGlKdkZjRHdXcENQOWVLeFphWTBuc2gvblQvOERSNG0wYVllNW5odU4ySERx?=
 =?utf-8?B?eTYvaDg1Q1ZlWHNWQkVBc0pJOFg3U3RBOGZUU0twbUE0SjlrUzA3ODllWkha?=
 =?utf-8?B?WWRIQ2hYL0V5bi9TSVNoaVhXSmFmZkdoT0paZkdLNEM0Q2Z5WWpieEh4UEg2?=
 =?utf-8?B?dTE3dVhrZS9MRWQ2UFNSVDRwWXJneUxiRUJlb1BxVlhpNSt2Snk3cVd3V2JV?=
 =?utf-8?B?anVrNUJGYjRFOG01dVZUNG9Ea2NncENmYnJJcmNOQUFjbTUwK2pNb1d2dDB6?=
 =?utf-8?B?NE43dTkrWmtlc053TVUyYVMwZGt4WlhXaVA3NlFucVpzZmJyUXB6Y1M0NTlR?=
 =?utf-8?B?MDdEbDBnYzVmSHBSSzU3aXk2cHE4TEQ3UUJ6bnVXWUw5K1JXMndUc1hqUFF3?=
 =?utf-8?B?Wi9YbzU0WXR5OWIwMkIxS01raVBBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wFCzZ+9Tl5j0vZ5s0BwK1Y5Jpx3eQtHnB2E9DmseG0V0usTL+hadsmW5xTdVP0+KbVbtELIcWsS/dTK4lxW0voZF7Ojj0aLSYUpYDL9G/NGiXmEKzoKqa4MdC+OlASGXOcl/aRLk8PtpL0m6YGbc/njCR03+VZrY9pcxnmRoQ7DnY/Fe1moRDWuZ6/lqPxg532fX1Pcc/vvC9cL0UGolbAuY5aKtIhDvXTBl/11aM2tHMu4C8vzy1AQ/gL1OqSvW+rCq3BqkbooMaDBmKjkjhs1eZtVQL9GpSe4JvazULpfFH9u/l98hyu4tD+ow+HejPNY5+Nhuw7kk/B/xV+96BEdF7D13QmGzfL6+IhcqZ1mNGttOOrF9NEqmyqqR4hwCEroL5I2J7Uum4ZKlJSS6kL9fJZHwtPyySK8PJC4zV7iNiS5tbasaB9ml2euTE0PB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:38:45.4232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f150e9a2-1dc5-4341-6c4e-08de73aa085c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000091.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8215
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



On 2/24/26 14:30, Patrick DELAUNAY wrote:
> Hi,
> 
> one error for CPU_STM32MP215Fxx value....
> 
> On 2/3/26 17:49, Patrice Chotard wrote:
>> STM32MP21 application processors (STM32 MPUs) based on a single
>> Arm Cortex®-A35 core running up to 1.5 GHz and Cortex®-M33 core
>> running at 300 MHz.
>>
>> It is pin-compatible with the STM32MP2 series in the VFBGA361
>> 10×10 mm package: the STM32MP21 uses a subset of the STM32MP23
>> pinout, which itself is a subset of the STM32MP25.
>>
>> More details available here :
>> https://www.st.com/en/microcontrollers-microprocessors/stm32mp2-series.html
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/Kconfig                  |  27 ++++
>>   arch/arm/mach-stm32mp/Kconfig.21x              |  37 +++++
>>   arch/arm/mach-stm32mp/Makefile                 |   3 +-
>>   arch/arm/mach-stm32mp/include/mach/stm32.h     |  12 +-
>>   arch/arm/mach-stm32mp/include/mach/sys_proto.h |  22 +++
>>   arch/arm/mach-stm32mp/stm32mp2/Makefile        |   1 +
>>   arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c     |   2 +
>>   arch/arm/mach-stm32mp/stm32mp2/cpu.c           |   2 +
>>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c         |   1 +
>>   arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c    | 192 +++++++++++++++++++++++++
>>   board/st/common/Kconfig                        |   2 +-
>>   board/st/stm32mp2/Kconfig                      |  14 ++
>>   configs/stm32mp21_defconfig                    |  78 ++++++++++
>>   include/configs/stm32mp21_common.h             | 126 ++++++++++++++++
>>   include/configs/stm32mp21_st_common.h          |  51 +++++++
>>   15 files changed, 564 insertions(+), 6 deletions(-)
>>
> 
> ....
> 
> 
>>   diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> index 90f06a052d3..7f349f3b68d 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> @@ -165,16 +165,20 @@ enum forced_boot_mode {
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* CONFIG_STM32MP15X || CONFIG_STM32MP13X */
>>   -#if defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
>> +#if defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
>>   #define STM32_USART2_BASE        0x400E0000
>>   #define STM32_USART3_BASE        0x400F0000
>>   #define STM32_UART4_BASE        0x40100000
>>   #define STM32_UART5_BASE        0x40110000
>>   #define STM32_USART6_BASE        0x40220000
>> +#ifdef CONFIG_STM32MP25X
>>   #define STM32_UART9_BASE        0x402C0000
>> +#endif
>>   #define STM32_USART1_BASE        0x40330000
>>   #define STM32_UART7_BASE        0x40370000
>> +#ifdef CONFIG_STM32MP25X
>>   #define STM32_UART8_BASE        0x40380000
>> +#endif
>>   #define STM32_RCC_BASE            0x44200000
>>   #define STM32_TAMP_BASE            0x46010000
>>   #define STM32_SDMMC1_BASE        0x48220000
>> @@ -194,7 +198,7 @@ enum forced_boot_mode {
>>     #define TAMP_FWU_BOOT_IDX_MASK        GENMASK(3, 0)
>>   #define TAMP_FWU_BOOT_IDX_OFFSET    0
>> -#endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>> +#endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>>     /* offset used for BSEC driver: misc_read and misc_write */
>>   #define STM32_BSEC_SHADOW_OFFSET    0x0
>> @@ -218,14 +222,14 @@ enum forced_boot_mode {
>>   #define BSEC_OTP_MAC    57
>>   #define BSEC_OTP_BOARD    60
>>   #endif
>> -#if defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
>> +#if defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
>>   #define BSEC_OTP_SERIAL    5
>>   #define BSEC_OTP_RPN    9
>>   #define BSEC_OTP_REVID    102
>>   #define BSEC_OTP_PKG    122
>>   #define BSEC_OTP_BOARD    246
>>   #define BSEC_OTP_MAC    247
>> -#endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>> +#endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>>     #ifndef __ASSEMBLY__
>>   #include <asm/types.h>
>> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> index 2a4837184fc..47a6db79bca 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
>> @@ -30,6 +30,20 @@
>>   #define CPU_STM32MP131Fxx    0x05010EC8
>>   #define CPU_STM32MP131Dxx    0x05010EC9
>>   +/* ID for STM32MP21x = Device Part Number (RPN) (bit31:0) */
>> +#define CPU_STM32MP211Axx    0x40073E7D
>> +#define CPU_STM32MP211Cxx    0x0007307D
>> +#define CPU_STM32MP211Dxx    0xC0073E7D
>> +#define CPU_STM32MP211Fxx    0x8007307D
>> +#define CPU_STM32MP213Axx    0x40073E1D
>> +#define CPU_STM32MP213Cxx    0x0007301D
>> +#define CPU_STM32MP213Dxx    0xC0073E1D
>> +#define CPU_STM32MP213Fxx    0x8007301D
>> +#define CPU_STM32MP215Axx    0x40033E0D
>> +#define CPU_STM32MP215Cxx    0x0003300D
>> +#define CPU_STM32MP215Dxx    0xC0033E0D
>> +#define CPU_STM32MP215Fxx    0x80
> 
> 
> Strange value this part number, I assume:
> 
> #define CPU_STM32MP215Fxx    0x8003300D

Yes, i will fix it with the correct value when merging

Thanks

> 
> 
>> +CPU_STM32MP215Fxx
>>
>>   /* ID for STM32MP23x = Device Part Number (RPN) (bit31:0) */
>>   #define CPU_STM32MP235Cxx    0x00082182
>>   #define CPU_STM32MP233Cxx    0x000B318E
>> @@ -67,6 +81,7 @@ u32 get_cpu_type(void);
>>     #define CPU_DEV_STM32MP15    0x500
>>   #define CPU_DEV_STM32MP13    0x501
>> +#define CPU_DEV_STM32MP21    0x503
>>   #define CPU_DEV_STM32MP23    0x505
>>   #define CPU_DEV_STM32MP25    0x505
>>   @@ -102,6 +117,13 @@ u32 get_cpu_package(void);
>>   #define STM32MP15_PKG_AD_TFBGA257    1
>>   #define STM32MP15_PKG_UNKNOWN        0
>>   +/* package used for STM32MP21x */
>> +#define STM32MP21_PKG_CUSTOM        0
>> +#define STM32MP21_PKG_AL_VFBGA361    1
>> +#define STM32MP21_PKG_AN_VFBGA273    3
>> +#define STM32MP21_PKG_AO_VFBGA225    4
>> +#define STM32MP21_PKG_AM_TFBGA289    5
>> +
>>   /* package used for STM32MP23x */
>>   #define STM32MP23_PKG_CUSTOM        0
>>   #define STM32MP23_PKG_AL_VFBGA361    1
> 
> 
> with the proposal for the define CPU_STM32MP215Fxx
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

