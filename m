Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A57D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4C783C19;
	Tue,  9 Dec 2025 16:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XD32R9z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944F583C4B; Tue,  9 Dec 2025 16:49:36 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245A083BFE
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4438b7a3ae=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B9FjDCu4094983; Tue, 9 Dec 2025 16:49:29 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com
 (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4axn6crd6g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 09 Dec 2025 16:49:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bauYlMv1PbukpohlCZBMgfSeMT3tVYnwIT0o3W4bdkymRPGmBZJ6uYEfLLaDi3c44H8JvUg5nVqHgFntPtVdo6oTevz7/ry+72DzHuJRSaf/Rp/vwfjLIYeKaje+ZqGs4yizFfwR3Nbi/6OKWklvg1Potdd2L2XGcvFnMY2uNOLmut5GV5ibqQ9OZPjfNnK3t09H4PsrpjZEoT/nXG/Rf3RG8KPezTNrextsZS00v/ylW9qWhfL7lFwMDovOKzGrX2QGJY6cmLtkXL170kjNHBQI8Es4dtfP4477E0ZvCTipvD9pTRNWSfzLd82PHK5NBfv68Xhilcio4mzZ7fvI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdstMifATjK0EySVPbnn2kRxqbx9cSKWtV1ENVJmIQ0=;
 b=tS3H8s+smEzjq82uYvISkWlNvqsNCDwQ0ZpNu2CPV9WhpybvmlkQC5MGiewRz9wuqTW9TGhZuibGl7UFmn+gTtKcaG+DaBgTxChLaR3mZMHJRVvIIFiOpkpkU+Dd2x+hoboASqd896P562OUEzPzSA+FG5nN+U98MuHctu8JrqiqLIvhOfGv8E7Gmim5icyilQD+V9Nv2Kze2/uDr5l1ZUSrMr8kwhiIH4K7DNr9jOzUSUspCa8Xnv2BhYjzI73Zr/XHdn0SZ92oiYeqiyStwLM2OdvjWBHxWv76MyGQCibFwO/irII/FPmL0UFB6vHSzfMaDXzBoxBEeyq6ROpMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdstMifATjK0EySVPbnn2kRxqbx9cSKWtV1ENVJmIQ0=;
 b=XD32R9z8h4tF1RgwGb+diXEnJ7w/vN0smZ3iPu95kouAWz5DtXDZm9mltsGCv9v6fH0tTktykYSBElntaLce8Ju8kp9FUZtbJ6uKyHzpGQ7UFDS/uI8AEhbnqk1EtvPjWf7f/4L7SoocElaS/tEDLR4+3WYIQMIJPRpKdoa/gVv2cdbKM+jAoSXWONeJ36ap2M+3agQir3+Df2bx0Dd3tVfHSZZ1znYSDZKOGRSEYDWsLZznJ9p0xeoyn4N5xOjcVFRzi9UE7fKCcrAxgxHMeafZV4OepLbc9M6HBJ9Kv2DPMGLQRHN3koyd5WJaL3BdWQw52BT1oc38IYeR2+1ooA==
Received: from DUZPR01CA0339.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::17) by VI1PR10MB8279.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:119::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 15:49:24 +0000
Received: from DU6PEPF0000B61D.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::4f) by DUZPR01CA0339.outlook.office365.com
 (2603:10a6:10:4b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 15:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU6PEPF0000B61D.mail.protection.outlook.com (10.167.8.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 15:49:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 16:50:04 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 16:49:23 +0100
Message-ID: <aa296cee-a99e-454c-bbe9-f2fbef9c37a9@foss.st.com>
Date: Tue, 9 Dec 2025 16:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Pull request for u-boot next / v2026.04 =
 u-boot-stm32-20251205
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
CC: marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
References: <24fc65d7-befb-4e8a-9bd6-46edbf87cfa0@foss.st.com>
 <cb9bcc7b-a59b-4800-8378-d664f82f50b2@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <cb9bcc7b-a59b-4800-8378-d664f82f50b2@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61D:EE_|VI1PR10MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fd6694-e322-4716-03fa-08de373a8702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlA5S2tXRnltMVMzYjJqcnlGMkpwVG1XdEpsZlY5NEtSSGRwT2RJV3RhUXRQ?=
 =?utf-8?B?WWhsMm1ZeWNoMFZBRjJ2K3ZldXR5NzJSS3I5T3dOZVE1ZVhZTS91WEU0VGJi?=
 =?utf-8?B?bXBTNzJpaXlVa3dJM0U1endzbkJlTHdleGVtRDNSanR5bGpaVlM2aU1kSjdN?=
 =?utf-8?B?VFgvL2xQY0I3enVNYmx3cDU3K09xUmJxN3Y5YzNkdHBRdXhreUdvNC80RUZC?=
 =?utf-8?B?aUVmbkxRajFaVG56dUQvQXUyczZMaTZSaGdZa1c1ckkxZlRkQSs4eUw1Q3Q3?=
 =?utf-8?B?WURyZC9nVGtQTkpVVFRpblA0S25wUFI3WDlmb2JwbjBJUncwZDlNNnRYUG54?=
 =?utf-8?B?TnpHTlJyNlpyRndGa0E5ZlhEdXN3YXJLeFhnUGNtbnByY0FvTHo3blVhVWNY?=
 =?utf-8?B?MmR0SXpETUttVzRIWWJmbDkrT0FzdWZDeWJTeFNRUGtMU3IvbzFwaENGQXBR?=
 =?utf-8?B?d2gxRjlQalJSbHl3empQQlF1d2x0OG03SllkMWh5UlNUOUhmNXVGMGYwYWVT?=
 =?utf-8?B?c3BlQ2twSjl0QUpjU1IvejlkdXpGVEUrN2t0ZmZ4cnRUVllmWm1SQm5XYmtS?=
 =?utf-8?B?NElrVTEyUlZrY3NJQlhVRTdlVDg4YlV6L1pUeGR5WXBxVTdMZXFSSUZYTE9O?=
 =?utf-8?B?Lzl3ZlRBOWR4S3F6OUo3M1hsaXRGckcya1VHQWh6TWhPMFo2YnMxSmNVVjM2?=
 =?utf-8?B?SXFFemwyQnJTUC9GMFhpWjh1OWRLdDJHN2E4aE9FbVJ4OXVGOFNYMEc2MFlW?=
 =?utf-8?B?eHZQaHF3d0RLSVp1SGpUVk9CbUFRbXR5Sld5U3UxNXdua0M2RU8xOEVaeFJn?=
 =?utf-8?B?NVdacFE5akJZRFhPOUEvc1MwY0xZYmR6cGpPWGp4eFFNRXNNQ1NTZTd2VTJ0?=
 =?utf-8?B?SSs0cTlNVTJqKzZjR1pHVGtSYXYvb0ZBZXhrU2t5YUxlNU1DeFZiL1U0Ylg4?=
 =?utf-8?B?dWxIdm9uZUl5K09ZVTBFWmhzVDZsbnYva3oxUFpIMVdZaEQyY2M5dE1iZHFh?=
 =?utf-8?B?YlhUNlZMRXJIVDlLUUFpRG9GZ01vVmVDWXdpbm9jTllKSzRDVCtHb0FrQVc5?=
 =?utf-8?B?MnZPbnRCWEs3Uks2R1NMcks4ZllFNzN4VFd1WDd0V2ZoSit1b0s1N21aTmJV?=
 =?utf-8?B?VGdSZmMxR2Q1aDdqY2pJYmQrT00xUnZnMHJKdkVJN05HbzVSY2h3Qmhsbi9k?=
 =?utf-8?B?ZWNzUlQrWVFheUVaNDVXc0RwOGdTckxZM1B0amhPNlBZWUlaMGxVMEFQWWc4?=
 =?utf-8?B?b2djWFFMd2syRVJJQUJhMnR3WkY3b1Z0bTd2a0p0R0t0cDdpbnBNM0VQQ1pP?=
 =?utf-8?B?SWRPVFdqQ0h3Q1AxelVnN3ltVkNvRzI3ZUkwcEE2WURKc2lPMHZ4K091QUFw?=
 =?utf-8?B?MXM0ejJJWVNoRjc2ejJla2NWNTR5bVVlNkVvUVlvT21LaFlrS1dFbzRBV3dh?=
 =?utf-8?B?WTI5Y3l0WHp4Q01lRnBlSW1paEFGOVhGZEM2aWV5NjNUOEkybU16a05ra0FO?=
 =?utf-8?B?ayt1RWt0OWlkTXhEQjdOWjNUalRaK21LYyt0WUIrVlhIdmd4NlExYktiZERu?=
 =?utf-8?B?cUVKeGs2WHlXV1FvWEIvZmp3UnlKQjZIVE93aXR6d1VwZEhxL0ViRTZ3dDNQ?=
 =?utf-8?B?czUxcEEycTVJMHY3RWRncVEra0hlb3VNRnhzTzhKMXp1bzZWMUZPbkN6em5E?=
 =?utf-8?B?akowZ1ZjYXFyTzVxanJXUEpsU2VGOHFSZFNyU21HL09YQy9pdkZldW9LSGZO?=
 =?utf-8?B?TmlxT2lZWWR0L0NabWI5d1A4Q0cyMDRUZFVabWgzMlBEZDlkcjUxSzlaRGNC?=
 =?utf-8?B?VllRaGcyUFNJTUU2RERuK1dIbUEraElmYmdyb0pRS2YvRkdReE9hS2ZXR1c4?=
 =?utf-8?B?cUdhTmh6bTlaVHR5NGlqb1dyN0cvdHNENjNpYVVrQ2owQ0hQSllBVWd2RkVn?=
 =?utf-8?B?QVJ6T1ZaM3M1UUZaaVIwYkFOc1A1S2R2b0F2QW8xc1FxNitzZ2MyM2poM2V0?=
 =?utf-8?B?c1NhN1ZucUdzYjRzc1hmTHlWNFdaa2xYVjBoTlB2WGhQTC8vOFUveXBnWUNR?=
 =?utf-8?B?blE3K2JSNVdJQzBreVZudWVJL01iNi9yOFV6V2FVZE1rSFh0b2NTV3dCYVBI?=
 =?utf-8?Q?ZJ/M=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 15:49:24.4782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fd6694-e322-4716-03fa-08de373a8702
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8279
X-Authority-Analysis: v=2.4 cv=I/5ohdgg c=1 sm=1 tr=0 ts=69384509 cx=c_pps
 a=ifQ69DzEKxb7Z0tYL2Tudw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_SNxb0KMrYk_get_KGUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d61mv9CqvR7R_cQgq0l6Iz3slxYitOTi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDExOCBTYWx0ZWRfXw1bKMt/FBx18
 UsQ0xNhj4Ep+QzJOn7SaXddhDOaIZwzcfI8QG06dQWlrgcjMV3qxkoXiyG6MbFih1gGN04zN7Kg
 nnfB25PawhHI+SOKx0uqELVLr+6p9PvMknspu+RLmQCXGqQAHaCEdKPxHYVQKmanMvdJkBP8ybS
 CaaglPPYyYvn7WlZwoQXVnR5ci/F0KGiHTBeeZ4ROKLEEK8pfGNhLejKmtU9At0JUv/QQR8MPMZ
 TLs9f3uNMh14NUBNqRVry9rypoCEitKZmykha4Fda9hEN66/q5xx6p6lz9vDA12+puyIQpw9qz9
 zmMSyVkb63eK/oH4iYkk/Al8/6WbRfA5VVx7VzZ14agp/yEjUAw6tGrofqQlihQw19GiifrRWqc
 5QTAIknAE6n/DA3fvJInP55xmD6gGg==
X-Proofpoint-GUID: d61mv9CqvR7R_cQgq0l6Iz3slxYitOTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090118
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



On 12/7/25 09:21, Marek Vasut wrote:
> On 12/5/25 2:24 PM, Patrice CHOTARD wrote:
> 
> Hi,
> 
>>        stm32mp: Fix handling of OPTEE in the middle of DRAM
>>        ARM: dts: stm32: Fix 512 MiB DRAM settings for DH STM32MP13xx DHCOR SoM
>>        ARM: dts: stm32: Add 1 GiB DRAM settings for DH STM32MP13xx DHCOR SoM
>>        ARM: stm32: Add missing build of debug UART init code on DH STM32MP1 DHSOM
> Three of these patches are fixes, they should go into master. The 1 GiB support can also go into master.

Hi Marek

Ok,i will submit a pull request for master with these 4 patches.

Patrice
