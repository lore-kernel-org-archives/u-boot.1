Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD04EF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CC1683DAE;
	Tue, 24 Feb 2026 17:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mx451E+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFBBF83DCB; Tue, 24 Feb 2026 17:53:06 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA72A82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbOqft5XeUTuuEvAAVDhQfUaknzqtJgkcG0zoNxTTq2W3iLOyoRTfd1sC5+dTXDI8pshQcYIQZnB1XkjT/vJoq/DNxrTXit4+7I/ELwPHSkkHAaovyQd6aW1i+ICUAy/mLPiY5f4x8K1aufo35e+O7m2DvBhc/ELSUcCOIhom3fiSrWKDJsVFEt9vsGMJ1Mw/6fIrFhYGmbLOB7HJt0uDAmcdHZG1z2nNvFymhMdND6l1jrLWKwLHvOAFeJA4MCoK+j4apnp4TyrAb+H2cT8BfzMZrEhhdp3sy/1KAYnEkdHptzYsWN/nmxpe9y/Pcw8LhK3xlATLFGQTI3MWEBN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqKr1GSLHj+2TzRR25wxiubE9w6LZxxiBFz7yHFk4Oo=;
 b=Y4lGdzILdRPlDId3gWvdCpV3qbVAJrzgeaDYdSjUMRehNmxpBLQk7811pOMFEbtZjfMRUbPjYciHRq9SclEmpt53TAoYKyx9NJLDiG2w1qdawYnVSO/cA/F+BBiPrze3ICojAzjynf/3qs8qCsGvswK2zu3wlaywj4WTgsoP+JViURC57GCxYzJpD6wvRsY9aeaOgglMxvzdpWYOg1qdZLncpz9Qf+yTQ5tHo+GOV0NGvSb5kjcaWwtxv0aEgiREibQTC/5VvCTtD8Q7G7oaVOPtU4FxVsQHYRsILQCCR/0w0MohU8Ycqf/EhWw6Hzc+/T6vUDtAGOU5cit5bXO/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqKr1GSLHj+2TzRR25wxiubE9w6LZxxiBFz7yHFk4Oo=;
 b=mx451E+wcpk5VWGbv8kybB9u2rHX/xtV1q/BcTKZswLtHJbJJEhapKU7w6SWIvy56/DgP39I6/rs67Nk6l5OpEc05X41kbUMkAYOBQ0tlw1Frz0Vo8Pcaqw2HVVJRs17xP29pV6zseJfB0sCEfMKWiLQoZEUHHjjfM4kn/UEIfk/UIYCgVZ9GUip0bkGoDRTqrv0CYGoGnSTB3ulximEc6pCa3FunXFt6KjT/Xc0FCD34G/KUGwfsUGh9q5itwscxS1pDo+R6Syk3BigLAhUi7gB4hCj5uh5S+vauFKHZlg1NjWtvk48Y8jwgH7W5FXbSbdb+SB5f9X6EJhHoDzWfQ==
Received: from DB9PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::7) by AM0PR10MB3124.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:18d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Tue, 24 Feb
 2026 16:53:01 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::da) by DB9PR01CA0002.outlook.office365.com
 (2603:10a6:10:1d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 16:53:01 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:55:07 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:53:00 +0100
Message-ID: <d219d2f9-b912-44d3-910f-5b3eb9ac1661@foss.st.com>
Date: Tue, 24 Feb 2026 17:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ARM: stm32mp: Do not acquire RIFSC semaphore if CID
 filtering is disabled
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
References: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
 <20260210-upstream_rifsc_update-v1-2-74c813fa4862@foss.st.com>
 <334ef06e-3449-4c7e-8950-b9ca5c4cde96@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <334ef06e-3449-4c7e-8950-b9ca5c4cde96@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|AM0PR10MB3124:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a9ad1d-c45d-4308-a560-08de73c52be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnBkODUwdmJzTGZzbkFqUFUvanFVUzdKKzFmSlNDbklIZm9UbmU3NHEyRWRn?=
 =?utf-8?B?NjFXYmFTbkR0UmdNQlN3NmlqR0YzZTE3dSsvbGJtNzdyZFdaNnU3TXVXdURC?=
 =?utf-8?B?eEFKWVB3Z05IRHBtZU9yM2xMYUFmbXcrNDJsR3JxS3cvYXBlYWUzVlJwcUk5?=
 =?utf-8?B?VEpsWmFFVmlBZlo4dTh3aVVIYlVWUGtBRitUei92VXc2OUdRdDlZT0xENmwy?=
 =?utf-8?B?cW9iS2xUYjB6SGx4SnpEbFVXdjdWN0F0dHZTLzJoOGhXYUpldVdZK1lrSzdQ?=
 =?utf-8?B?WGZZVmFPc21ka05jUXBHYUtnL2I0ZFdzS0NNLzhReU03dk1BclNML3cxUVFV?=
 =?utf-8?B?RnY0aTJZbVJKaHV6R3hCVU9rRE1YUXJvcUNURkhLcVF3NEhiNUJyNnNpNk1a?=
 =?utf-8?B?dHBHaXVxWS9FVUlES1JqdnZHa3gvcW9odTNBWnQ0ZnJwYmJiSVFRSUdacHRi?=
 =?utf-8?B?aVdaNGt5cUJscFhtVVpmRjQzWnNpcXYvR1hiL2V3dklZWEYyVlBhcjF3Z0kv?=
 =?utf-8?B?Mm1TSGJ4a0VTenR2TGdCYk02VUdkYWtraE5qdVhtOVpxTlM0bWMxTkFzc1pF?=
 =?utf-8?B?R1llaVh2NEZZYmxnYzJzcVdnaklPL2huRXkwWVFYd1BNUkx6R3pOU21pY2x2?=
 =?utf-8?B?VU1jaUVTRWNkR3NYL0FYVlVMVHpDTFFhYXZod0RDS1h3My8zQXdOYVlNNlJ0?=
 =?utf-8?B?N24zbFRUKzN1dE41RGhUVmFGZkNtSHVQK3RRWnFZTU13MjcrWjBIRUNjOFJM?=
 =?utf-8?B?b3M3cVJUZ2txVVRmMXRRWVBQUFFPZldXWlZzWTBvZ2QvTVJ1RG16MEpMZXp4?=
 =?utf-8?B?K05qdjErNUdYbG9OK2pSWWJtN1NUU0RDa3JtN0MxREYzQW95Q0ZGS1gvUjg1?=
 =?utf-8?B?SDQ5eURTR1FXUVZBbHRocHFHMTF0QnVvQ1RHUnBTUkJwNnI2MnVoRlVtYkNi?=
 =?utf-8?B?Z01OUlJrR2RYTVZId0lpMWZLOUg2dklvanRrU1BMalEwWmpTY3NiZjlxTlll?=
 =?utf-8?B?SkNpRkthNy85RE1ENFdMdkIvcVBkeXB1aGljY3ZlaEhEbHBiY0RJa3RwRFow?=
 =?utf-8?B?RVc2Uy9OMmxKMVYrVjlXaFFBaTNscG5iVFlKVVZYZHFnTDRlRGxFaUJTS0ZO?=
 =?utf-8?B?U3FUZWROS1hHdHcyTEcraXZVb21XZUdkZzlIUCtVdm5kbFRjM3VsMlF1anJn?=
 =?utf-8?B?UFhzQW0yV3diTDFCWEFoQldmaEpqeE0xVjNZZCtoSjF0TXgzaXpydENIWUhk?=
 =?utf-8?B?YUlERWphbmtHWFU5U0t6dDVab09DdmFYUERvYlNTVncyUEU5Sm5sT3luOTE3?=
 =?utf-8?B?akVGUmZ3S2t1ZVVmUDRjZU52UDR1WklQK0Zialo5bkhHY1MwYmlibFdodi9a?=
 =?utf-8?B?Q3lYaEN4cVk1SWFTWGM4MEpOOHc1YWdraFhOcGRBTG1CNklnVEN1RUdyOTVj?=
 =?utf-8?B?NEd0d09Xay8xb2dPM0ZMVVVxNlZxbHozQmwwZGFWNldtbmRwUU0vNFlsYVMr?=
 =?utf-8?B?czRRMjdtUkNOTnhIVTFsODRVNnNDenBicExFUk9rbk84Vy8zYWFCNWVJUG9E?=
 =?utf-8?B?N3FsRUEvai95cURFTWFJY1M3WkhwbHVXdHFwaXR3QjFvSlhYMGVhUnMvb1NW?=
 =?utf-8?B?ME5tRTVCa2J6ZGxpbEdBUlVyd2dNcWlXcytyQit3bEpWMG81cFcyQ1h3YVFl?=
 =?utf-8?B?ZzZ4ZjhTaFNuWEIyTFhwQjY2ZDYwekU1bFFjT2s3d1RiQU11Z0xzWldqaDFJ?=
 =?utf-8?B?d2k3OVNjNVZDTyt3Q2hITmY0TVQ2bkxxY3d1UmNDMTgrdFFOcFQ0ZGc1dzZ3?=
 =?utf-8?B?OWJjdXVvYnRVaGp0czlVbWQyWWliOXYyY1R4d2dLQVkxeHJNMkp6Nkh4QkY0?=
 =?utf-8?B?cDZWenAvOE9PR01QWnJrNzhsaFJucGZVSGhaUUpTcU52dWQ0OWs5c0Y2NUNM?=
 =?utf-8?B?eENORldhc0NWWnZOU21aSGRuOHFEcWRxZWhaQTRsSzNyWUY4TWY4R2EzdUhs?=
 =?utf-8?B?TVlwVGJXZkRnSUwzdzdBR3c2WXhMaFUybHBROW1OdEJoN1IxYStvS3Y0M2Zz?=
 =?utf-8?B?WkxrZHNyQW1Bd0toWUJTTzhoUWFJa2FHdUhVdWdqaVBSa0RIaVQ2N01ZVFE1?=
 =?utf-8?B?Y0EyNXZEcU9aMHdXZ3hZS3Jqdm9mSEhKN25MOTNKalhjdjdZcnBDSnBQOXlz?=
 =?utf-8?B?ODRBOWh6RE5Cd3o5OUxaTHhGNk1ENTJLT1ovR3VZLzFhRDFsdGRydjNPREdD?=
 =?utf-8?B?UExUdVJ1NTd3a3AzcSttejdLTlRnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xYbDqDoQCRef2d3KqqwF2ctlG2s5WjWtedybwq6kxGWQsW7VLmIlzESOjW1WFEsfQKmRO4x7Lz3CBf52mCPf1KB/GIyYWf6IEqXuRS/o73AokFZWp69mKD7ACuSHxHt7BhWJifyFN043U0XTs1DtSw0OA+JJMhb64f1u1pnG4lbx6xXwcDcvir/fKco1DqQBPd8eEkNIW80F/e0TOdqjrjIZ87VLqmref/ZznBhGBWoLjK+shHT++xGmOGKhBmQVjkhRwNvU+bdhzl98IvtE92xHhWxNdJRI1BQiqhanxqIBbAAPs56w15m5drEoq9MQNPWcpkjyDkyabZaRFFCjKeGllAx3ru7kzeQv7BxZh8bTNI7DpN0bOxlukZ2hH635RNM1terYR4Mn79jhTZ1t6qD8/sGHI3QrXEk/W0tb4+XB4apvfCA/I1ZOPHa9yO7i
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:53:01.4183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a9ad1d-c45d-4308-a560-08de73c52be4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3124
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



On 2/24/26 11:31, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/10/26 11:26, Patrice Chotard wrote:
>> From: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>
>> If the CID filtering is enabled, the semaphore mode is disabled as well.
>> To avoid an incorrect behavior and error trace, add a check of CID
>> filtering state before acquiring the semaphore.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 

Applied to u-boot-stm32/master

Thanks
Patrice
