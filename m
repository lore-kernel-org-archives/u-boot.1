Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D246FCCFA18
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 07:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C63683D77;
	Thu, 13 Nov 2025 08:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Bgw0tpms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7198583DA7; Thu, 13 Nov 2025 08:04:28 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E8B83C62
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 08:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=34122f89ed=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD6uAGT3059037; Thu, 13 Nov 2025 08:03:59 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com
 (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu3nnu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 08:03:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2KAWgrPw82IyXzpYnGPsoGsRIq7RsCtwioR+9R5LOPVZUOVDn9iHFn6Udi+7UiZepO5CCOPGhhWh7B4Yj5cBXKzrC0GfIGbm277XS3mcUHzKgoO5iuGsknqPiP7Sa6a3CkYTPO1pI9mCdfbYGf5whQ4cNZe50cbQNhvZeTsuCnicK9RYNo7/41HYkfn+oZ5G2kpGxr6ORKfODmiFH4UeK09qrPy4nprqR4kpIJoC99jXCgpesCoyY8OUjq2KYz9siyb10TyV5W2F6riQuSzTrHh+UHeLFIzYvZCWVSEoc0+4WqLSpQWOV36znix6AM1iVp6c0KRJS+kwxpRwjl8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R77zIw57hr0lASCGdTcfHfhcY1wHPcxXhWzfSZt/OrM=;
 b=gjJHVAiPPjD+7U8UxIAchaMcK1tY7UKWOrJ3Icxo34CosCc5AaY7dgTLDUDCru4BuqCzcHh5yDzZX2YLT0c67jy5HpUyvQ+RoqjlDymB6pOTbFyrcu0MRWzQEyQ3vK9zbS717rX+/nG7Y5e6vrX0S+S0HmKpWc25PsYgph8ciju66uwX+Z66G8q91W84EO9e/ExHh6Rl75a/bwM9ArTBS/Oyre6wjXd8XApPM8nDCbk9Hfo33yhw67hqdg5Kxmsb9/lCfMzTZNwh0kKPAb/ErGA4qLMenQyO9jIRllUciYrHQbmGPHDUAgpK4plHLy5y/ehmyUGGtrulyN+r6hYGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=0leil.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R77zIw57hr0lASCGdTcfHfhcY1wHPcxXhWzfSZt/OrM=;
 b=Bgw0tpmsfmt76E6Evw3QBdI4gxnAPl8dtI90Awoly8xeMDImAjg/mR/l1QG/wX9Om9mpsevaaghm7+5ZR8N5+plomwE2fdAfZixZ+ddwGeF1o2Yzjzto9SklxqDE+IeePlQK7gwoKBNLUWQTZtZMpXd0zSA9Lq/SnKuh5UUMh4jtr9cRPVrjEihr0R819b1woKbYRdUsEFzTBogLBye4TwWncXG/6mH0ycXuAM+4hVrxqNum3zGTCM8XNlHP49e0v9X9dmaWoAoev/EYuSv2BCIWWHn1EqX0Bf1cXuJnJBb5Nu+Ag0/rFcyho/gZJfekNN/8s3Ihb1qfEJpv+Jol5w==
Received: from DU2PR04CA0164.eurprd04.prod.outlook.com (2603:10a6:10:2b0::19)
 by PA2PR10MB8328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:419::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 07:03:55 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::85) by DU2PR04CA0164.outlook.office365.com
 (2603:10a6:10:2b0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 07:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 07:03:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 08:04:04 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 08:03:53 +0100
Message-ID: <9e1ac6f7-ba6a-42d3-b70c-c2eca078eecb@foss.st.com>
Date: Thu, 13 Nov 2025 08:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] led: remove u-boot, boot-led and u-boot, error-led +
 add cmd doc
To: Quentin Schulz <foss+uboot@0leil.net>, Ziping Chen
 <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, Johan Jonker
 <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Klaus Goger <klaus.goger@cherry.de>,
 "Eugen Hristev" <eugen.hristev@linaro.org>, Durai Manickam KR
 <durai.manickamkr@microchip.com>, Stefan Roese <sr@denx.de>, Zixun LI
 <admin@hifiphile.com>, Yegor Yefremov <yegorslists@googlemail.com>,
 "Quentin Schulz" <quentin.schulz@cherry.de>,
 Alexander Dahl <ada@thorsis.com>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|PA2PR10MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b08f060-e334-48b6-d3d4-08de2282cf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTJ3MWk5cnRPK0dvenhJZmlUeTBYTk9YL3BoWjFZK0hIZzY0SGFnVldRdEVj?=
 =?utf-8?B?QlA3WTNDcnVaSDVKVlhuOTlBQW51cnFEMGN5OUY1TEVtQk9oeWVvbEdWaEVr?=
 =?utf-8?B?QkN4QzdCbHNqbXkxclR0Q3lDR2hrVjNLT1djTUlHSmFPVVZXTVlZZllRVjdK?=
 =?utf-8?B?T2ladFVFY2x0bDM4NkJaa0xpdVhQNnNQa0dmZ1Q1ZTZpUWVHYUNaSXR5ekc2?=
 =?utf-8?B?MHZ5RlNGbGZUdyt0SGM2dVhmYmhVSTRrN0FCdFRuMk9DYWZIRG5WTkhJWldw?=
 =?utf-8?B?VVdwN3VNNHBFT3BsRFBXd1Q0VWxpN0Nta1kvUm4vR1BHZFNvdG9CZkpsc2ts?=
 =?utf-8?B?dVpJMnlMK1N4NHVVUCtiVkx5bzE0U05pVjJCRkZJNzVoRHNkajBFQ1NVL3hK?=
 =?utf-8?B?bXVPREZaNnVQeTZEOWlkYWNKNlZOZkE4R2RxanQ0R3Vlb2lDV2Jyd1JieENS?=
 =?utf-8?B?ZFpnVktWekdtS0ViRm5aT3ducVFxekJtRzE5YnoxWnBWS1NkZUlMYmMydzRv?=
 =?utf-8?B?Z1ZoKzBRbHlTandzeVFjcVRiNW9wYUQ1dWVUcUxvaEtkU21WK0ptTUViTG9l?=
 =?utf-8?B?dU9ZUGhEOW1QWXpxblBzRy8vTFltVnBGUXlPZkkwWWpvU0JOeWdUa012eS9B?=
 =?utf-8?B?d2VBeG9UZWt3eHYrTG5MbnpyR3EweTFCZ3dDT0dhY21ZZmloVEVzelNDSnJO?=
 =?utf-8?B?U1BMSFpXdlFib0FOL2l4RGwrQWFTNEVqRWVOd21yMWt2WDJ2MTlaK0JHTFVD?=
 =?utf-8?B?blRVSW9zRFhzTHJmV3JURm5sd1kyV01wRWl2czFzaW9ieDErS1dUS21ZRnl0?=
 =?utf-8?B?U0pKMkpsZHp0bVBEWkJ4d2R0RUV4RnIwRE0yYVlzTG5ORFRRa0QrVUNmZHNi?=
 =?utf-8?B?M0kyY25tYjR4UDV0MHhNYUlQVWdkcWk1SGRxOUFiSDRqWkFjMnAxRWd0a1NS?=
 =?utf-8?B?TklZREcvaEVIREliZmFwSUFrb213QVNsTFVtSWZYSFZHTTZLSDZRUEtxaWEr?=
 =?utf-8?B?RVFQSVdlbFNCSVJ6KzYrTkRaVVJUU1JXcS9jaFNKRWVmTklWbUNReWxPQ1h1?=
 =?utf-8?B?c0VYRzQya3U4Y1hKa1UweGQzcys3eUZLcTdrNkk3T096ak84TlhWeUYwN3Z3?=
 =?utf-8?B?SjZQQnBmak9BVFQ5YkxvcUoyRmxhRzNxRFQwZTNrejhRb0tuRFZvZFlZSzl1?=
 =?utf-8?B?QzZIL0hROThWVzRoaC8zK3JuYzRSa0xIYU5RYStMM0Z3dXg0RExCZDNaOHlt?=
 =?utf-8?B?WE5wTXJnTDBHSkdLdEZQU0JPSEQ5S0syOE9NcnlHUHgxK3M1VmQxTXh2MXBC?=
 =?utf-8?B?TktDUlVjbThDdXY5NlpxVUtockZycFVXbUdUQXVHR3BoM2d6RVQ4UmF6UFFh?=
 =?utf-8?B?TWh4TDJqNlZwSkpiMG83dzJ3bi9zYVBjODdLWnViWHVLU05jbUwxS0VQZmY4?=
 =?utf-8?B?NGRFTzRvL2V6TFpETGR0UE1tOWJOaFpjQzhvaWlPazBGV3FLOS9MemZSNTIv?=
 =?utf-8?B?aGN5b3c2NEZ4RHU0a0xwSHRSMHVuTHZ2d3NtTFE5S0RiLzdyWVp6N0VUR0pp?=
 =?utf-8?B?R2h1VHpnK2ljOXZ6V3l0aWdjMC94d0UyazBtVkNDeUFYOG9oeGVmVGk1aDg0?=
 =?utf-8?B?aVN3ZkFBOEZrNW4rekNVVnZrdWlhUGV3VnFHZnJDdFpvK1VPbExGWjF4Z0ha?=
 =?utf-8?B?U2ZTYnhMSEpJeVFUZC82N1ZmUCtkdERrbktlbTRXSStrenJDejVmUkl1bDhk?=
 =?utf-8?B?ZER3NUhrSmFWdm5vSTFZUlM0WFFhM2RFZjhReDMwS25RN3VkR3ZpalVOemtk?=
 =?utf-8?B?TmlKc2kzZ09XZ0ZoS2lVcjdtNVk3L1U3WmdBZDN0dWNscFFZZGtVQ2tGN3cw?=
 =?utf-8?B?a3c3U0g2bVFod1hXcEdqM3ZQQmoySjZvQUw5V2hDdFAxWU4zaDhSei9CT2M4?=
 =?utf-8?B?V3JTdFJNcG5LL2t2anh6MFVTUzRIZDlpcFFoMzUxNmpPM2pBQVhWZ2Vza09i?=
 =?utf-8?B?a0Z0YTlGQTg0Q3F0WFlzZkx3OGs3KzJqaTROOXNpWVowbTVSZGdGZkR2Vytr?=
 =?utf-8?Q?hXJb6e?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:03:55.0404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b08f060-e334-48b6-d3d4-08de2282cf40
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8328
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA0OCBTYWx0ZWRfX1AINOcGu4TBh
 B2jN6yZ7gcuvXHxHIEFGlGpe82gTrGBFGteZJW2boNfypLhqomVWcHjckxnV2IBuMIS3gDG2ojF
 nNFz4pX5M9/UGyaSD6/RW9gaYpu2AyHHFJdWzPA/ilTEGaSDuCsAtqk0WLXkqXD+UrptWFmTrb5
 tZG0IjZAT1sow6WeU/8jXDM6JE+7TFyVXa1taSf4BXnji069om+D/dSTKbILGjxlc16s6DTojsR
 3F2aX2fEbwYXRzpuT4LYEU+RFoN151yw1apBg+Rmq/a8YlIrJvOvpRMN70E41tbhFbwNEV3LNjX
 DuhgWQS5W5pAqwTovAP/9YaqRjwANwQfX3ubJBJsn3LFLM+dn3SwjskKyqt71yp7oVXsUKCfukS
 mAIdB+/R5y7ckQnMbZRYQmqcboksrw==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=691582de cx=c_pps
 a=TPI4aLKDjCd1EbHbt8/hbw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=YG64nluAAAAA:20
 a=mK_AVkanAAAA:8 a=N90x5TpfRo0ZKSvJ48YA:9 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22 a=3gWm3jAn84ENXaBijsEo:22 a=bA3UWDv6hWIuX7UZL3qL:22
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=yULaImgL6KKpOYXvFmjq:22 a=pHzHmUro8NiASowvMSCR:22
 a=6VlIyEUom7LUIeUMNQJH:22
X-Proofpoint-ORIG-GUID: Zmk_7Hirr9x68M8IpQ-S1k4XqcUDnSGk
X-Proofpoint-GUID: Zmk_7Hirr9x68M8IpQ-S1k4XqcUDnSGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130048
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



On 11/12/25 18:48, Quentin Schulz wrote:
> u-boot,boot-led and u-boot,error-led aren't actually handled by some
> generic code but rather by board or architecture specific code. They
> also aren't properties that are part of the official dt-binding so they
> cannot be upstreamed. For u-boot,boot-led, there's actually a proper
> replacement which is /options/u-boot/boot-led[1] (+ CONFIG_LED_BOOT=y).
> 
> For Rockchip boards, either nothing (for RK3066, PX30 and RK3399) was
> using that property or (for RK3188) the code handling it was guarded by
> symbols that were not enabled in the defconfig. For those, the property
> and guarded code are removed.
> 
> For the Sam9x60 Curiosity, it seems that even though the LED is
> controlled whenever CONFIG_LED is enabled, it isn't enabled by default
> in the defconfig (but the code was added without modifying the
> defconfig, explicitly leaving a choice to the user). I decided to keep
> that feature by simply migrating it to the new API, though I cannot test
> it as I do not own the device.
> 
> The STM32 boards will be migrated in the near future once their upstream
> (kernel) Device Trees gain the new way to specify this (via
> /options/u-boot/boot-led). I'll let Patrice handle this, see
> https://lore.kernel.org/u-boot/94ed1988-13e8-4fe3-bdff-ba2c9973c556@foss.st.com/
> and
> https://lore.kernel.org/u-boot/2a3aa43a-ce19-41e1-ab56-556629ce5cf9@foss.st.com/
> 

Hi Quentin

As mentioned, the 2 above U-Boot series about STM32 led update will be soon superseeded 
by a new series.

On kernel side i submitted a DTS update for STMicroelectronics boards: 

https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=1022526
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=1022570

We will heritate of this update when U-Boot DT will be synchronized with kernel DT
(probably linux v6.19 i guess).

> After this, only one user of u-boot,boot-led will be left, based on
> STM32: board/dhelectronics/dh_stm32mp1/board.c. @Patrice, maybe that's
> something you want to have a look at as well, this seems to be some
> evaluation kit?

I will let Marek to take care of dhelectronics board.

Thanks

> 
> The only users of u-boot,error-led are STM32 boards, so I'll leave this
> to Patrice as well, I do not know what's the way to go for that one.
> 
> In any case, I would like to not encourage people to use out-of-spec DT
> properties when there is another option (u-boot,boot-led), so I remove
> the properties from the dt-binding document from U-Boot.
> 
> The help text for the blink subcommand of the led command was misleading
> so this is now fixed.
> 
> This also moves the content of doc/README.LED into the doc/api/led.rst,
> while clearly stating one shouldn't be using this anymore.
> 
> This also gets rid of dt-binding that we already have in dts/upstream.
> 
> Finally, this adds documentation for the led shell command.
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/v2025.08/dtschema/schemas/options/u-boot.yaml#L113-L116
> 
> Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (11):
>       cmd: led: fix help text for blink subcommand
>       doc: move legacy API documented in README.LED to doc/api/led.rst
>       doc: cmd: document the led shell command
>       doc: dt-bindings: remove duplicates with dts/upstream
>       arm: dts: rockchip: rk3188-radxarock: remove unused u-boot,boot-led
>       rockchip: rk3188: remove setup_led from xPL
>       arm: dts: rockchip: rk3399-puma: remove u-boot,boot-led
>       arm: dts: rockchip: px30-ringneck: remove u-boot,boot-led
>       arm: dts: rockchip: rk3066a-mk808: remove unused u-boot,boot-led
>       sam9x60-curiosity: migrate Boot LED setup to use /options/u-boot/boot-led
>       doc: remove u-boot,boot-led and u-boot,error-led from "binding"
> 
>  arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi   |   9 +-
>  arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi     |   1 -
>  arch/arm/dts/rk3066a-mk808-u-boot.dtsi            |   6 -
>  arch/arm/dts/rk3188-radxarock-u-boot.dtsi         |   5 -
>  arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi       |   1 -
>  arch/arm/mach-rockchip/Kconfig                    |   1 -
>  arch/arm/mach-rockchip/rk3188/rk3188.c            |  36 ------
>  board/atmel/sam9x60_curiosity/sam9x60_curiosity.c |  16 +--
>  cmd/led.c                                         |  11 +-
>  doc/README.LED                                    |  77 ------------
>  doc/api/led.rst                                   |  89 +++++++++++++-
>  doc/device-tree-bindings/config.txt               |   5 -
>  doc/device-tree-bindings/leds/leds-bcm6328.txt    | 106 ----------------
>  doc/device-tree-bindings/leds/leds-bcm6358.txt    | 141 ----------------------
>  doc/device-tree-bindings/leds/leds-gpio.txt       |  52 --------
>  doc/device-tree-bindings/leds/leds-lp5562.txt     |  63 ----------
>  doc/usage/cmd/led.rst                             |  95 +++++++++++++++
>  17 files changed, 194 insertions(+), 520 deletions(-)
> ---
> base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
> change-id: 20251112-led-old-dt-dc24605ddc88
> 
> Best regards,

