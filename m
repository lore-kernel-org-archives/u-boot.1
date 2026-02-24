Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354CAEF5862
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D531083DAE;
	Tue, 24 Feb 2026 17:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="acGqA3m4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7757D83DCB; Tue, 24 Feb 2026 17:53:36 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AD182BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kauzd86TLjv/EEq/TZQL9guMuxdGCyBimcU4ZtcH+iTFWaKbJeV7zTrzwVhYtVO/U6cPPQwQD7R0U0NJLgQ9kmUITkb/zScv8siZiKRy43WWBb1tWSpbBuOhfDsLI7CZL3FpPyvRD2089L92qvDgfQUNTCYELfJGAkx4iw+jwIFIyB+xzobw7m6aTdz4QJY8Y7l2m51PuVbEDo6cspgkC/KH+SZefoIgDsUEM966kT0geMwJzlTVkcwPu7MneLsS/JTGtvk39sckCmaoSBNnqZSyAE0Adky2aVhAQU0NCQr3+yMxtvjRKBCnuiods9xDKsffYdTr2kJFswbmIk1Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGQ8Mx3hJn5m8Hkltu5dqwiFqMdB2eaXzCsHmuaE3JY=;
 b=PK+yUAm0UD9SXgGlQXrEATszWXmRVG7SnEdyjl/kq21kpBvbRsi4pNwqVjLdvzSRlSSBeM/6tpvIZv5NE7OglhXnN3o5A2b8zkGtaa7mTDRFwTZZdC5dAKhapMcNIc9jYUtzay1q8KHmrzHXN1KTjGNH8vxmu98W3LtdLv8SB8B9WvuWkmkkR78gvpsPEcdfmBEXdS1a2bitwFeqFybjs5uz7KkhVtaA5jFNZLhM1Zagp6s6WN+RgSjQGzSasi+TGlHlIJGu/Ym4VjfZuBEzHAfSZ0I+O24wVcKdE4kMI4BCkcdYSIjpvi1gio09SeLDgFM8v9FlAW7A2cjKoj3tyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGQ8Mx3hJn5m8Hkltu5dqwiFqMdB2eaXzCsHmuaE3JY=;
 b=acGqA3m4OsgpcpLw05T4/o/XHvZhbymdAstB9LJEf3lFKlT6+MEEv2c3CoGaYrC1s1KZDigca49or2z94EAxcRFYHv02KITd7PcmW8ZpCgZV35L7oFW3PHxWDpq2Mm6ENk+cJ6w+fkIGoUTEjcUEGJCoTi77EFqD8WlUlJfWoUB1nZ362RErVh47nlZEhMQ/xt+CvltrqtEgO/+eEy9BlFPLYLIROhehJHkN39GjLCOY+TonnyRHXCP8ZIR0BIBPgm8+kKQsllzM4taOzAp7ZwzWx7TCJ1JiBxi5/xZNCJhYYrdvm+IWoGcQz9wAWMgZIW06O8cOKDfZ5AlawQO3Bw==
Received: from PAZP264CA0060.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::16)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:53:31 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fd:cafe::4b) by PAZP264CA0060.outlook.office365.com
 (2603:10a6:102:1fd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 24 Feb 2026 16:53:31 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:55:47 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 17:53:30 +0100
Message-ID: <30fc7500-ff36-48a4-b381-f8ba04645f87@foss.st.com>
Date: Tue, 24 Feb 2026 17:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: stm32mp: Fix CID and semaphore check
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
References: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
 <20260210-upstream_rifsc_update-v1-3-74c813fa4862@foss.st.com>
 <eda61827-deb2-47e1-8a22-8ef7ed2e0011@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <eda61827-deb2-47e1-8a22-8ef7ed2e0011@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d97619-eef2-47d3-4ea5-08de73c53da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEdQblF5N05QMytVQlE0bkdTMzZDSEpNYVhyRFBoMUo2NTFMOHRMSko3RlhP?=
 =?utf-8?B?WmtKZWRVZ2ZYUDRqT0JlWXFHTzh6M05NeGVJcUVOMkVoWCtSZlFVd21icEx4?=
 =?utf-8?B?ZGY1ZVpYWEt5Qi9uZmZYK1pFaWJ1YW1XRDhnVHBpMjNhdUNCb3N3VHp5clZI?=
 =?utf-8?B?cnM0ak1hRHFkZ29ZVUF5QVM1c1c5akowZzJ0aU9SeWFjN2Mrbm1PRWVoL0Zy?=
 =?utf-8?B?dTU2dnQ0aHZ4ekpXdnpLV0V6bVlDY21oREM5NGJ5N0tFd2dkWDNpVHZZcHNX?=
 =?utf-8?B?Z3BtRHpPMGhjam9JWWhnSVFMRzlJbnNtU1lIUG82dDc5TUFxNnAwRENhRUY0?=
 =?utf-8?B?UGd5ZzJiOE5MUVhIcmlJWkRMT1BTY1BVZnFkZjlRTithRUllWFpOUXdtbmNz?=
 =?utf-8?B?dFJrRnA3QmJXUk0vbDQwVmpab0lXWThnVmJDN1AvUXFhYjJHVVhYcFl2WVNm?=
 =?utf-8?B?T3RhZ3dsc3N3b3lMVi9nanNycExpRk1SNFlPbGtMenlkUUpnbG5UcUgycXcy?=
 =?utf-8?B?SU41bHpYTzc1bXNxbGFIMWlRU3Bjb1MzUkUrZk80MllvUEdGUjcxYy9XUlkr?=
 =?utf-8?B?ZGlyaGlKRE40QktxRG5EdEI5dmN3dTBGaytZc3orZjRYZ2VBS29zZHRLd2NZ?=
 =?utf-8?B?eE5DT2xEMkg1ZzdxSEZOT25ZM1RHc2xobFZSMnhVUVFnTVZiRm5waUIvclho?=
 =?utf-8?B?RVVuL016ZmdLQlBtdmxvQkwzSGNIY2hXQTlQazRnNVJEMHo2dkhlLy9JZVBZ?=
 =?utf-8?B?eHNyMW1vS2syZzB3ZERkVllTMVpHWnFIZjluUEVISFNzY3J3c2pyTnRuUFcy?=
 =?utf-8?B?OVJhbXcwME4wVXpYdVBKYWFUUFZrMnRWZ2dRL2p4eUJ1alBjSnFKWkkxTDFH?=
 =?utf-8?B?VXVuaDhEd3RLWkYvdkJGNytZU0kvUHZBSHNDV3NNQU15b3B6L0JsK2Urbmp6?=
 =?utf-8?B?azJRSGFyMjAxWHVnUG01cHJrcVZLMjZPS2ppUFkxeTV3V1oya2JaNXBuZmlR?=
 =?utf-8?B?OUQ1UGxock5TSFNBeGNrOTFEOFJkZVZ6Y1BEL3QwUE92c2dUeUpYTXJjOW5W?=
 =?utf-8?B?cXduYTkwb0JsQzlXSXRRUitmZ0VweXJ3QnBlR1FieWdxdFRRN2RsZDV2dTU1?=
 =?utf-8?B?WWhYbk5kdnQyZDNCTWNTaUhIbThqdUtZZHFHY3RTMi95Y0h2R0lsVkEvdUVR?=
 =?utf-8?B?Mk5jZldyMXh2Z0ttMVBYSGx3bU1JYVNXcU5JYUJDTVJGWUNuVllFK2VDdFh4?=
 =?utf-8?B?R293MTRXVi9hc3Y3WFAvSjR4emhwMGpEYTZXNnFoTThja2J2WVpwZ3NjeGNq?=
 =?utf-8?B?czV3ak9RSXJtTVd6akJJdmdHaUhyRTg3Q3RTYU5RMWx0cDBralJqM1I0Q2ox?=
 =?utf-8?B?cDBqYnM4TGp6NFcxWlBCdTRrYjIrQ3BtbWp0dVAzYlpYb2Y3N2hrTUFGRENo?=
 =?utf-8?B?clNqMWo5NmgrSGMwRHBRMTRPMUhlZDYvaitOTUYzMjgzbm81UVA2alBLL3Rp?=
 =?utf-8?B?VlNwUVUzczQyc213SThNdGJEVXlxZ0lmaHJhNkNIaFVlc0huWk03L281V3hD?=
 =?utf-8?B?YVNwSkJUaUJEMlk1aXFNYkZ0czEvNEZuQTYxQmVEVDdKbG8xTCtFaVZ3VjF6?=
 =?utf-8?B?cGFHM0lwR0hsYjA5TEtlUDMxdFBHK0ZEemFoNGhOcVNzZ0k0UndITURtVWxt?=
 =?utf-8?B?SHlzSGU5V1d3cnVwNHJBMVNmcjMzUlUzYzhldWVtNXZldVkxR1N5VndkR2JN?=
 =?utf-8?B?TnVkekNOd1hWNEFkMXN2Z3dHV3paK1RVcnorbEdwZkZuTzE2L3ZiZDg0enBV?=
 =?utf-8?B?V1I0SmdCb1FOTUZsWGFoZDNZSnFDMFhNMGVGRHJsczhjTEZYQm5lV0VCTXVR?=
 =?utf-8?B?S1RMUTU3RVV3RlJVSitUUWhqaUhmRTNUNjNwTHlPNWVvRjMyY01LWEtreHFX?=
 =?utf-8?B?VnQvSnMxUmFNRWgrTC9FMDhQekEvVHRiOGFXK3RCVnN0a25wbWFCMEM0UFcw?=
 =?utf-8?B?U3c2YVdaa1YwclRMS2tnVVN4ajZUQzMrY0VZTUk2ZlZyQnJrK3FjNXBPR0Iw?=
 =?utf-8?B?alN2MGlVQ3ByVVB6a3Jha1llRkFIVmM3ZVN0cUlCSmVKZW96VWNCckZuV0Z4?=
 =?utf-8?B?NVpOT2lJUCtua3RQRVJjbWRCeUFUVWlaVFRHVGJmU1JFQkdFbTAyaUR4MjZB?=
 =?utf-8?B?TlJFSnNqenNNdmlXWW14WjA2Y21YYWN3N1RyMXlycHZCYlNtaXRtYzV3YXNT?=
 =?utf-8?B?dWFDTzE2aGlNdysxZmo5OGFiNUd3PT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pPxO+IdLja/awwFU4nygrKHXGypglHp2n7fkLQ9CRxKmUHopYtetTH/ZioEqYmqkczpxcOsHQDBb0m38NiEpwWlU218v2fz81QHvOuRSIJyNdpe8hzzyCXP9JTdIK6owCG4C9Ljz+2cELHqmL37A5oK+NGAYmuHCn84rCuMMQme4D36Jm0TXRvXRq2GiW+5AI8J4iLFa13IEfk7ZR63qziBsG2XBKyFmpqx+BeIPSIX/xWFBRjJh8DrQMwX4M3rj7QqY3D2Gt8ArBfMUqBUv931EZllnhFxkfE1eSTgCxxyWlJY4kx9aJuubAvUJB5acNC5/BsKghXEzFd9qqsEtB7CaHuzLv6sYM5nMCwSnq5kKNoviv0o6CTviGh8XfkL3S+7Pe+k8e9jERSk9x7lOFSLvngs2pdjR/99H5M+xdWiIliVoGinMVD6tL4sZAJ3H
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:53:31.2284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d97619-eef2-47d3-4ea5-08de73c53da4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611
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



On 2/24/26 11:33, Patrick DELAUNAY wrote:
> Hi,
> 
> On 2/10/26 11:26, Patrice Chotard wrote:
>> From: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>
>> Peripheral holding CID0 cannot be accessed, remove this completely
>> incorrect check. While there, fix and simplify the semaphore checking
>> that should be performed when the CID filtering is enabled.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 24 +++++-------------------
>>   1 file changed, 5 insertions(+), 19 deletions(-)
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

Applied to u-boot-stm32/master

Thanks
Patrice
