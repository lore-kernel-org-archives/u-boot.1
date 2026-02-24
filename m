Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7853E9B260
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 392B483D17;
	Tue, 24 Feb 2026 14:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kyE9/6vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5933B83DEA; Tue, 24 Feb 2026 14:01:06 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE7083C8C
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnT4AfwsagQWLpx3EOQVSh57mmT5YWbZT+DCgqHQUK9OTm0ihV85QyIESbBLr53Zte7f8+Op2k4He9/2/RdjHbg/UdK03b2QgUWWsZecY5XmBjIs4eycX81JWlnnqKXVUa2FSVKhie9F89BNOamsocyFYiZQ6rZQk5ITqiAXDBwCuBN0yEcARLmIufLGLahS2C8qqg2l7JO17oPyGY43tWTe/6fW4EYs6kUWOlAm/Xz/l6rgnNhxUxvlXAVyK/ra2DksllbPCpS5y4Jfqhv5J8Ki2Ck/zI6DCx/Hu1zsx+TWsTgGjvY0+a+VPT6vIwRci0P8cuLoV3aT4Ociwu7IIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0iM4uN/DLdrqS+tJi4cVIPfV6sCk/IBFNMEAyMuH7Q=;
 b=G2W0xtUmfpmTlH+Xf/XBvt1Ol9KyCCRei6JdSP5NBlWfhcpCgCRXbiMphB/QgBou1ck6PC4+LTeEp7qanouOacB4ylL6oKmhsLe4lJ/DC+jcXzKF4zz5VrZ+vbuVHcodCcQHSpNl5i3K9sEcn3v1nEBDskbAQdsyiDn1Z6174p2pq/R4hrbhchgSKWkMYChhf2321gzCyAtwyfaq4GWq5tvtMiYewQk0RdAdS4Wd0xqy23FVBbdjh1zcBJCWJ9nV7VXT8ClvnuDZhG5nkRol84tDH1P+p/Pt5+FptwVbLECN4i1CkCq7GynHJXqcWnTyj6Y/IQ6SWRIydgQBrRvX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0iM4uN/DLdrqS+tJi4cVIPfV6sCk/IBFNMEAyMuH7Q=;
 b=kyE9/6viEpZZgi8+IDREkoF2jX5MM/xk8euODUIOL8V0OaCnV8rAK4rrhF7m2B/opj3kPcnufxf1T/1QMj7yJu9yyNswGXk3abCHHUxi3WV1/cRl9UXOFn+XOsJ5gTkHOjI17Wle3YbrjpiTpfsSreG+y3w7uHP9eaoKQMSVBG84mTVjinut4e9bOGjYngCryjaAanlP1zctutx/I6fftrEnIw+IhtA+Txm1BXTPRMrDRrmxGHHdf5I91pm7sT9XYGaQjHxUIJurB4V3phTSNZYiOjNLCHt0I+Zx2ij2SOG3DeO6HCtBWjEfOXi2EtAohMqupk1XwPw/NNEEbbyFtA==
Received: from AS4P189CA0057.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::6)
 by GV2PR10MB9613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:01:00 +0000
Received: from AM2PEPF0001C712.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::b3) by AS4P189CA0057.outlook.office365.com
 (2603:10a6:20b:659::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C712.mail.protection.outlook.com (10.167.16.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:00:59 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:03:05 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 14:00:58 +0100
Message-ID: <73c32748-8a1e-4d04-9fba-f8cca5e89ae4@foss.st.com>
Date: Tue, 24 Feb 2026 14:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] stm32mp: cmd_stm32key: add support of STM32MP21x SoC
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Thomas Bourgoin
 <thomas.bourgoin@foss.st.com>, Gwenael Treuveur
 <gwenael.treuveur@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yannick Fertre
 <yannick.fertre@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20260204-upstream_update_stm32_cmdkey-c-v1-0-d95374395840@foss.st.com>
 <20260204-upstream_update_stm32_cmdkey-c-v1-1-d95374395840@foss.st.com>
 <6f9cd5cc-550b-49b3-a38e-339050447f8d@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <6f9cd5cc-550b-49b3-a38e-339050447f8d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C712:EE_|GV2PR10MB9613:EE_
X-MS-Office365-Filtering-Correlation-Id: 21777a7a-7c8a-4030-e7d6-08de73a4c202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WCt0cHE0OXNmc1YyZ1YvTURJL2J5U2pDeVFlZHdNTmNIdVZ1VzFiWFFOM3FL?=
 =?utf-8?B?SWRqSytHK3ZDNzhnZmVwbGVoU3FOWHFKdnNDRi9qb2V3STkwdnVHcGxRWGtW?=
 =?utf-8?B?YXltL3JwSG95empRemF6Kzh2M0pmNi9LT0ROSUZueGZnVzNuV2pISkZLTE1S?=
 =?utf-8?B?V1U3VnF3SHF3S3c0Z1FHVnU1R3F6TG04QWt6QlBsOWxQemQzaDBMWWFaVFVW?=
 =?utf-8?B?c0NxSkJ3RU92YlgzblRKUXVlLzVmWmc1NzNRVVNFYWF5K0ZsbGc4d1NKVmNy?=
 =?utf-8?B?NG84Sk03NDlvU0FxSWxUcnlKQmMreVFqbEQ5NTVnMS90UDMySmdxbldTeWVv?=
 =?utf-8?B?bmd5eDQ3TmtodlZQRWRlOVJFZUxpZTdjd2lmeGpPREpaQjhaQWNHQ01ZUmQ5?=
 =?utf-8?B?Wi95QWg1UFkyQVNnK1g3Q25hMXUvQ3hKRFg2cTVPaTVzSnhJbUtSWlZRSlNs?=
 =?utf-8?B?V0c0Wi9qTjFDeUFzM25tSkZkMUx6VWZiblVKdmhDeGpuRmgwU1dIZEhRak10?=
 =?utf-8?B?VkpjejQ3OFMvZHpLZXJHTS9PM3NLcTU2TmhTQnpsWjdIeDd1SmVZMHdGeFR5?=
 =?utf-8?B?Q3NET1o3aTJCcFg0VkVhUFNpa2dPenJxS1BpYm5IQVByV1RiMXQ1K3dtcDdr?=
 =?utf-8?B?Y1BJZ0JRM3ZLWjdYNFZtRnF0Qzd6QjZrWXN3MTBSbXVINElZWjJab09kT09F?=
 =?utf-8?B?ay90YW5GMWpSM2dsOVVvL3MzK3dlVWJtdVRFcDMrTzZpL0lJaXM0TkJJVko4?=
 =?utf-8?B?akVIY0Vab0w3ZXN1dlNZR2FjSXV0bWVmcUQvVG5nekt0MjYxVHJGQlhlcGVZ?=
 =?utf-8?B?RDBBS2Q1bGpscWdtS2Q0SUp1bkltSm01ODc4QXovcGYvS2pKajl4Mm1ZYWxI?=
 =?utf-8?B?VkZ3SWhyZEdicnRDR3JkTGxyMFFNVEJmZTVPVEtIWUI1elYwUzBOTTZrMlZG?=
 =?utf-8?B?bjBobmt6MnJCRkd4bXlxckM0ejFlM0Z4TmlnT3VPRG8rYzlwN2Y5Y1JlSXRn?=
 =?utf-8?B?WmpMVjB4eUkrdjJzVDNnREhEc0pxaTF5VXdwYnl6aVF3alpOblV3MEFHL1ZO?=
 =?utf-8?B?WUx5YmJmcWhxN05qdCtISndPNnVGN25GcUE1eXpjNHBvNEtVNFJLb0hVZFFO?=
 =?utf-8?B?NDdXNUdhSG5hRVlZa21JTGlIZ3puWHA0QVZNdU1oeEtkWUwxNnNqMHhxc3J6?=
 =?utf-8?B?YTkvN0g5bjd2U3Rlekc2ZXIvaFZJWFJCY0Z1ZWxLUlpHd3FXeWppNnZhTjR0?=
 =?utf-8?B?NjVkSHhScWJIeFJISVlJVzVqSjQ3ZkFzdE5VM3diYTNPMEl3U2thSDUvbjBz?=
 =?utf-8?B?K3VmcTJQdHg3TzJrV0Y4SDRnRlNjdHBxOVEvYTBZNVZrSDZHRUFWcGlHdi9L?=
 =?utf-8?B?YW1mWkJVMHZUWEgwYk1BdTRmNk04SVo5YmpVTHF4MTF3NkNpSmt1S2poUEpU?=
 =?utf-8?B?bzZlLzZSMHlDK1BaM2lwWWtDTlZmT0xzcHpaNUdPUTNXVTcrd0gwcjRzSXdm?=
 =?utf-8?B?Um9MSWVObkdHV2V0aXY1TEVjWElaL25kbmJJMWYrOGpwcjJnOWJNaFJGa2N1?=
 =?utf-8?B?K05McXIzUDNBNjA4aUcrSVNHdklvM0JlMzhzd0xhYU9SRzdjWWZzd2dDRE5p?=
 =?utf-8?B?NzBzNDZKdjZ2TmlVVDBOK3hXVkxhR0xzRjZ2ajd2WDB4T0Y2UlhIc2laN2Fa?=
 =?utf-8?B?QUZ3TFRmdTl2WXc3S3RxK1dQejlrRGdWSjQvSEdVSGx5R3F6Y1BvV21GS3dV?=
 =?utf-8?B?TzEzYmNJMHYrYnh1cFNlQ1JHaXFlZGFzMUMrbHlzL2Qra3hFNS9yVW9ZOGdJ?=
 =?utf-8?B?dEZpNG92bTJ1MVQ4ZWVNTWo5cXowQWpUckVzYk02aWwxdW5JOFF4SnR1bWYv?=
 =?utf-8?B?VkJFdXMrVVVSbWN4Ny94ZmpBbk51eGNyREVRMDRBS3oyeUFPMXc2clB0K2lt?=
 =?utf-8?B?Qnl0RU9lS0U0UWNub0t3OEN6K0dDYUVmMENoRkg1dFplQzd2Z3VrMzFMNkZs?=
 =?utf-8?B?cUFKN0x5ZEVSOFpuTHNDbmwxTU1JQ3lTQUNwNHpBTHZQSmIrb0NGMTgza3Uv?=
 =?utf-8?B?OWV4VWdCNkJ0UHZWa1hHRXlRbStZRm44K2tmTjl2Z0ZYTWgwVHg3UXNFemNI?=
 =?utf-8?B?NjZqVElHcjhaU0txOEVvSVRRd0o3Q2pJWjNiZTI0dDJmM2hMWGFRTzYzYmJo?=
 =?utf-8?B?cVJteXczc0lDNzBDWTFxT01lZG04dE4zWHdUcDNoUE96WEpOSlVhUFJmZFZq?=
 =?utf-8?B?aUJXTlJUSXFXZVRNTzdxd3VxMExBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TNgpnJDmC0n6sIzU8MeZq9JlqK7YpdbgbB1i6Er3Rz+G7glweGJ+k/fzdey9vTuew9PEDRurKARdOgdGxtRXOvq4053tsIb8kPi3DHKOEXU47qt5DTczZQWGuWk/u635aFVO6SIulVKV8uRhhSxaQgIPq841KKqG9B4CRey0pPXLCE0NSg44GDF4yrECrPH1U31AR/mO1Ue6145ff20AhWmwo0P00lBSZRgyP5NM1gtWDYRYQlhMfzfem0NS9kLKdgm6pY22C/ugpHLThWxLxKsPKWdX1Yo264QJIbCsgpEknCYCaDTWQfMB+qKjYAh0Z8WhNWtKdNwOxRc5w6+OKaPZIfkjB0GxlXd1dukd7Mj9czi8/VVu5aknfkZnaQVikF8a4ZhiXqBHQrbNj7Z5kKJFkm2MY643ZJjeDkcd0jlAJ4u6uKptyYfF6RfgtZ5y
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:00:59.9118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21777a7a-7c8a-4030-e7d6-08de73a4c202
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C712.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9613
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



On 2/24/26 10:03, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/4/26 11:20, Patrice Chotard wrote:
>> From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>>
>> Update stm32key to support stm32mp21 OTP mapping.
>> Create a new list of key to support the following differences :
>>    - STM32MP21x SoC support 128b and 25b FSBL encryption keys.
>>    - OEM-KEY1 and OEM-KEY2 used for authentication are in different OTP
>>      from MP25 and MP23.
> minor "from STM32MP25 and STM32MP23"

Ok, i will update it when merging this patch

>>
>> stm32key is compatible with platform STM32MP2 (aarch64)
>> Hence, use unsigned long to handle argument addr of function
>> read_key_value() instead of u32.
>>
>> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/cmd_stm32key.c | 97 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 88 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/mach-stm32mp/cmd_stm32key.c b/arch/arm/mach-stm32mp/cmd_stm32key.c
>> index f1e0a3e817c..1ceb640e6b2 100644
>> --- a/arch/arm/mach-stm32mp/cmd_stm32key.c
>> +++ b/arch/arm/mach-stm32mp/cmd_stm32key.c
>> @@ -40,7 +40,7 @@ struct stm32key {
>>       char *desc;
>>       u16 start;
>>       u8 size;
>> -    int (*post_process)(struct udevice *dev);
>> +    int (*post_process)(struct udevice *dev, const struct stm32key *key);
>>   };
>>     const struct stm32key stm32mp13_list[] = {
>> @@ -67,7 +67,56 @@ const struct stm32key stm32mp15_list[] = {
>>       }
>>   };
>>   -static int post_process_oem_key2(struct udevice *dev);
>> +static int post_process_oem_key2(struct udevice *dev, const struct stm32key *key);
>> +static int post_process_edmk_128b(struct udevice *dev, const struct stm32key *key);
>> +
>> +const struct stm32key stm32mp21_list[] = {
>> +    [STM32KEY_PKH] = {
>> +        .name = "OEM-KEY1",
>> +        .desc = "Hash of the 8 ECC Public Keys Hashes Table (ECDSA is the authentication algorithm) for FSBLA or M",
>> +        .start = 152,
>> +        .size = 8,
>> +    },
>> +    {
>> +        .name = "OEM-KEY2",
>> +        .desc = "Hash of the 8 ECC Public Keys Hashes Table (ECDSA is the authentication algorithm) for FSBLM",
>> +        .start = 160,
>> +        .size = 8,
>> +        .post_process = post_process_oem_key2,
>> +    },
>> +    {
>> +        .name = "FIP-EDMK",
>> +        .desc = "Encryption/Decryption Master Key for FIP",
>> +        .start = 260,
>> +        .size = 8,
>> +    },
>> +    {
>> +        .name = "EDMK1-128b",
>> +        .desc = "Encryption/Decryption Master 128b Key for FSBLA or M",
>> +        .start = 356,
>> +        .size = 4,
>> +        .post_process = post_process_edmk_128b,
>> +    },
>> +    {
>> +        .name = "EDMK1-256b",
>> +        .desc = "Encryption/Decryption Master 256b Key for FSBLA or M",
>> +        .start = 356,
>> +        .size = 8,
>> +    },
>> +    {
>> +        .name = "EDMK2-128b",
>> +        .desc = "Encryption/Decryption Master 128b Key for FSBLM",
>> +        .start = 348,
>> +        .size = 4,
>> +        .post_process = post_process_edmk_128b,
>> +    },
>> +    {
>> +        .name = "EDMK2-256b",
>> +        .desc = "Encryption/Decryption Master 256b Key for FSBLM",
>> +        .start = 348,
>> +        .size = 8,
>> +    },
>> +};
>>     const struct stm32key stm32mp2x_list[] = {
>>       [STM32KEY_PKH] = {
>> @@ -171,8 +220,10 @@ static u8 get_key_nb(void)
>>       if (IS_ENABLED(CONFIG_STM32MP15X))
>>           return ARRAY_SIZE(stm32mp15_list);
>>   -    if (IS_ENABLED(CONFIG_STM32MP21X) || IS_ENABLED(CONFIG_STM32MP23X) ||
>> -        IS_ENABLED(CONFIG_STM32MP25X))
>> +    if (IS_ENABLED(CONFIG_STM32MP21X))
>> +        return ARRAY_SIZE(stm32mp21_list);
>> +
>> +    if (IS_ENABLED(CONFIG_STM32MP23X) || IS_ENABLED(CONFIG_STM32MP25X))
>>           return ARRAY_SIZE(stm32mp2x_list);
>>   }
>>   @@ -184,8 +235,10 @@ static const struct stm32key *get_key(u8 index)
>>       if (IS_ENABLED(CONFIG_STM32MP15X))
>>           return &stm32mp15_list[index];
>>   -    if (IS_ENABLED(CONFIG_STM32MP21X) || IS_ENABLED(CONFIG_STM32MP23X) ||
>> -        IS_ENABLED(CONFIG_STM32MP25X))
>> +    if (IS_ENABLED(CONFIG_STM32MP21X))
>> +        return &stm32mp21_list[index];
>> +
>> +    if (IS_ENABLED(CONFIG_STM32MP23X) || IS_ENABLED(CONFIG_STM32MP25X))
>>           return &stm32mp2x_list[index];
>>   }
>>   @@ -237,7 +290,8 @@ static void read_key_value(const struct stm32key *key, unsigned long addr)
>>       }
>>   }
>>   -static int read_key_otp(struct udevice *dev, const struct stm32key *key, bool print, bool *locked)
>> +static int read_key_otp(struct udevice *dev, const struct stm32key *key,
>> +            bool print, bool *locked)
> 
> minor: needed change ?

From what i remember, it was a warning about the length of this line.

Thanks


> 
> 
>>   {
>>       int i, word, ret;
>>       int nb_invalid = 0, nb_zero = 0, nb_lock = 0, nb_lock_err = 0;
>> @@ -351,7 +405,7 @@ static int write_close_status(struct udevice *dev)
>>       return 0;
>>   }
>>   -static int post_process_oem_key2(struct udevice *dev)
>> +static int post_process_oem_key2(struct udevice *dev, const struct stm32key *key)
>>   {
>>       int ret;
>>       u32 val;
>> @@ -372,6 +426,31 @@ static int post_process_oem_key2(struct udevice *dev)
>>       return 0;
>>   }
>>   +static int post_process_edmk_128b(struct udevice *dev, const struct stm32key *key)
>> +{
>> +    int ret, word, start_otp;
>> +    u32 val;
>> +
>> +    start_otp = key->start + key->size;
>> +
>> +    /* On MP21, when using a 128bit key, program 0xffffffff and lock the unused OTPs. */
>> +    for (word = start_otp; word < (start_otp + 4); word++) {
>> +        val = GENMASK(31, 0);
>> +        ret = misc_write(dev, STM32_BSEC_OTP(word), &val, 4);
>> +        if (ret != 4)
>> +            log_warning("Fuse %s OTP padding %i failed, continue\n", key->name, word);
>> +
>> +        val = BSEC_LOCK_PERM;
>> +        ret = misc_write(dev, STM32_BSEC_LOCK(word), &val, 4);
>> +        if (ret != 4) {
>> +            log_err("Failed to lock unused OTP : %d\n", word);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int fuse_key_value(struct udevice *dev, const struct stm32key *key, unsigned long addr,
>>                 bool print)
>>   {
>> @@ -550,7 +629,7 @@ static int do_stm32key_fuse(struct cmd_tbl *cmdtp, int flag, int argc, char *con
>>           return CMD_RET_FAILURE;
>>         if (key->post_process) {
>> -        if (key->post_process(dev)) {
>> +        if (key->post_process(dev, key)) {
>>               printf("Error: %s for post process\n", key->name);
>>               return CMD_RET_FAILURE;
>>           }
>>
> 
> even with 2 minor remarks
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

