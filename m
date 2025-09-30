Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB03CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50410802C1;
	Tue, 30 Sep 2025 18:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LyimG4fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C6B81D6A; Tue, 30 Sep 2025 18:43:18 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D55F800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=236888059d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UGUQkm019258;
 Tue, 30 Sep 2025 18:43:15 +0200
Received: from db3pr0202cu003.outbound.protection.outlook.com
 (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49e6tevm0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 18:43:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So2sK7aDSU7xwjnlMmacpNdo5X6HLejHpIEL+RvPcHdoq2bDsBEPB1UEg5jxFxMosqHR7JeNAFtAfAeobtlouWSVTwLpMzS9oILkb/xuRkC34KPKQQMx4jrJyHpGuxQxBFTis+A627W1a23KD/zepnwukzzSX5IkWu8etjzJ6ppoRt0DVehT03UkJEt7xVBszslmx+PX28fVL/UUIUZovGOXE0R6dvOgYkMbk+n3QSOZuZVatnQt03GnyEpVKz+Grltg0K0pXzRpEmtpkPt3tERIztb3QqRjVE0mfVqM2mwIZUm7B8TDePx3fnOZwTIk7qIdH4q+zRww50ffZNuhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw64zyQWVfwboMKyI78UNTT745WbxfyAfMjubVQ/g0w=;
 b=X/YchI0NdOUNWIrGTRwLrPImLE9Ez21jUI14lyF5cVUfHT9zEVJ1014k2HgCgylUYJOoPTasK7dPE5xDWfO23lXHZZqAJsx+7Jh6hyF7FqzFOzXrofTs+gHynoXjGQWCgphIOy3jQ7gagUbBWH/7kMsskbzu5LW47UuAAumtU9eB0rtc2hEtW/5zD8BiSuD+3yjlg/xWJvZOjGgLdKnKVR1EU0t2I9EloQkXMoU5C1lqdrTLqXOZ0PNoOTudpgJtAWUFq4AG13Nm2dHcdUDqIZ531ozI/jIxeUIbrw9xChAVtupVficF+TwyigpSPCTi9L06lu3IMpzUug6iIpRNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw64zyQWVfwboMKyI78UNTT745WbxfyAfMjubVQ/g0w=;
 b=LyimG4fgOGbHB6PUsV7taFAktf4E9JJMdx80/fOhwiFd/4PFzAxwWPoHilrWp3w73PnRjqf5qjtMBfrbhWg/HW3kC+f0Aeh3WeSKQXkRynLflYTzbkBC1lzezkQLB3+Jw7sGJA0U/zv3cMU1L6d4Eq5kp3Q5tqQLglQ3w+yoiYnAw/1MS/PH7cqteQG2Ut+yC7Kex/lgJ7y0wx1GhZEzeR2bGHv5wXKVBhgN4MUycALoQrvCyV3qgkRexz1gdt2qXXRe9/EJel4gCThZ+KloI54Pzqyhm12G8RKCqtzngHRPVk5sUmxUlXNHrjsc9Ac+j+Pq307f292U/Qesqu3CuQ==
Received: from DUZPR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::7) by DB8PR10MB3594.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:138::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 16:43:12 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::7f) by DUZPR01CA0044.outlook.office365.com
 (2603:10a6:10:468::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 16:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 30 Sep 2025 16:43:11 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 18:40:53 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 18:43:10 +0200
Message-ID: <26087b6d-9b3c-4bee-9af9-a204577a39ee@foss.st.com>
Date: Tue, 30 Sep 2025 18:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Patrice Chotard <patrice.chotard@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2025.10 =
 u-boot-stm32-20250930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E3:EE_|DB8PR10MB3594:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d8240b-2e6c-4e70-5535-08de00407172
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0hjWjBqVUpXenBaa2xXTjQwcW51cFdDbUNacWh1bEhRYTJHQ3BVYVdBRnhS?=
 =?utf-8?B?bkNLM2NHVnIyWWlFYkFUV1Uzc0w0ZTRlVERHb2lpQ2tFdGdFdU9lTkJ6aUZa?=
 =?utf-8?B?aERISlJaVjVwOU01SndvREQ2Y0owY1l1bjN0YlVBck9aZXJTRWNqOXJQYnZl?=
 =?utf-8?B?Z2hqR3ZVQWVDQ1VWZDZCZ0UxQXRWKzYxREptb1ovVUhxMDlnZ21zcjl1c0dx?=
 =?utf-8?B?ZGFOQzAzeElmUlFuTExudGpVZys0RWlvc2RsSmlMZ211OEdyRzVCS0Y4WjJY?=
 =?utf-8?B?bTRYSGVGeUpLSU80YXdqK25mNGxGcnNVc1gvUHFWZHh0WTBvKzNBL3g2TFo3?=
 =?utf-8?B?SWNUSTNjOThtTjhtMHY5ZC80WG1mUUJMZk5mbjlzblcvUHV4cHlEb21jY2g1?=
 =?utf-8?B?ZHBpelpnSXdrc3IzSFJyWnFMTks0ZkJKRnRPNGZIa3VxUWp4MkVUczR2bUFx?=
 =?utf-8?B?bEx1OHBsR0hpWkMrTERqWFVteTNaa1JDeEhWZDJaOWZMS0pvdTV4WWhwWFVS?=
 =?utf-8?B?d2Z1MWd6eDNPMHczNHpKdE9BWkI0ZW03OTcveWo1aWxta29JS2FFRDFWM2pt?=
 =?utf-8?B?eHVjK0NtVGIxU2JyeWRFMjc4VUJGNTRZZThCY2J1K2hGaTlVTHV2UGJxZlpZ?=
 =?utf-8?B?YWxNN3RsZ1h4RUhBVExJZnluRnpraFhwY0VyUC9VQmROdE5pM1U1RjVPUzBE?=
 =?utf-8?B?b05vNlI0ZkNKVCtwazI2RXd4SWlBSkU4RUdYeTBqbEF0NzVZQzZCclc4Yk1W?=
 =?utf-8?B?Z2NRTHdVaHdNWmptUDZab1pQc3Y3anpoNFZSSzBscjM4QXpEQjNVR0JHUVgy?=
 =?utf-8?B?YjBBY1d6UGZxUEFnYUZ0eGMrVmRUQjFSQUNEajg1RTdDYnhPSm9JRjFhYklZ?=
 =?utf-8?B?eEFmeDF0RUd2YkdBRXJwaWZwVTRrWm04U0JGU0kvVE5FdmdxcENrem5FWEli?=
 =?utf-8?B?b2U2aG9XMTVwRnJWdCtFMWpiRFdjR3JhWFEvcFNlK1BRNmZJVVNsSTJvTGNP?=
 =?utf-8?B?eWR4VnIzLzY2bTdyNHhQN0xxYlhEa0d5bXhPKzdPaEZtQ2R3WXY0T3l5ek55?=
 =?utf-8?B?TEcwYnZMWEFkWHBkN3grTnNOZFRjN3VqSmZRbUdVeldRb0JWVThHOWJqWjFj?=
 =?utf-8?B?cVNFNU1kZWc1QlIzMktGcUk1N1RIMmlZYTZPRGFXZS80c0IrN3E2QTByWlAv?=
 =?utf-8?B?NnJZeGFQdzcxYnVvMW5uQmErMkowL1ZhZFkwUSszTnVZYkZCVzRBMitTRnkr?=
 =?utf-8?B?YWE5WUZkbFdWRWg1VzNFc3JEVWlXKy9CUzRQbXJUSlNuMm1nZDY4U1FwZC9W?=
 =?utf-8?B?TjE0OGswS1ZxQTFKaVZmeGlNU1ZkRGowbFVzSWZFSG5oMGU3TjJWcDh3SGFS?=
 =?utf-8?B?V3IyVWNTVnJ5Yk5xY0IybmJNSXBQSFVwalozZENsMmtyckt5Qjc5RGtVeW9q?=
 =?utf-8?B?S3lXRVNURnFLbXBKUjF4djZhSzRGVFZqRVljejVlS3UrbEVvQ0hHSVdaNGdW?=
 =?utf-8?B?WVhzQlVhTG5ORkF0Mm9VYVBnM0tEODkwVjhmTHdFUGUvTWZSQUNVb1hheEdV?=
 =?utf-8?B?RTVtM2lvUTVOcm4zMDF0VDluTVBQL2JlOFZORThjaG5iUkNnMVdDMy85WmNi?=
 =?utf-8?B?bm9hMENJcmpFcUFIb1N2ak9xbmw2anIzb3U4TWZRYUJGN2hoeTJaUTg1OVVK?=
 =?utf-8?B?QTlIYUNGUkR2VGw0dlRVOGszeFI3NCtSWm5keXVreDFsL3FmRzhiVCsveisx?=
 =?utf-8?B?UFJodUdPN3h5YjJLa2psalZ4QjZVNlpKenoydFdIc0Z4RkY3MjVvWmhSWUNX?=
 =?utf-8?B?NWRBb3VpY1Y1M1ZoZndYeGI0Q2J6ZDREbEo0UVl1VElIK2gwZ2NnWTV5Yjgx?=
 =?utf-8?B?aFVpYk5WWThsWEcyUDFKYWNXUlRIZTFTQ1FwSlFQVTdSR2x0QmdpalNXMG4v?=
 =?utf-8?B?MGVEVUtLK3phZUpGdEh1MU51aC9xTk9uWmp6bmJPVENjcUtjd0o3ZWo1eXl2?=
 =?utf-8?B?b3cyTXJIdVhNUklkWHVDSTcwZjJNckExQjhCWlpnREtFVFJGUmc5U1dudHJs?=
 =?utf-8?B?M1cxU2E1UC9LNVFnbHJzczlRV3F4MmNzc1EvNFlnakJWU3RMRm00TnI2WkY5?=
 =?utf-8?Q?84/A=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:43:11.3393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d8240b-2e6c-4e70-5535-08de00407172
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3594
X-Proofpoint-GUID: YTLld8--J0MsTIFTqRIivif1lbEPKKLe
X-Proofpoint-ORIG-GUID: YTLld8--J0MsTIFTqRIivif1lbEPKKLe
X-Authority-Analysis: v=2.4 cv=IY+KmGqa c=1 sm=1 tr=0 ts=68dc08a3 cx=c_pps
 a=1qKRAtnyhAzLZZNyb1hmZA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=YfCOm-DyAAAA:8
 a=e0Czdb1dIZ8VobWRCzgA:9 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfXyhiye/M3HmNa
 0Vm83cnmMRI04WEclUIHMX3u+oowZYszYIJdUWs40OpXDt2qUxS1Uk2ZK7rNafoI4k5T5e1nLbt
 BXa52j22h2QD6weGlwvhny2AdZKlImdGevgq5lHlZ82HqnAuFCrkSRn0Qlo2hgfjmvRyW+422s5
 ZNdxKz4d+9NMad33RVgvCWnA2e3oB/5x2p5bAR+uiCU0I3PTD9EiJW22Rpg+iNmWqUWvfthn4Zl
 Nk1XUfiRA4zCv43jv4d+b9hWQ6nCQV7yEGX5GWPYCLnAI3vo2/h8ubHmD2HduUgEF6s4Y4fdJpL
 beVH0xYMY3e045XQ1v/J38Te2GKwbaIBZ0+PsnoFfUitk+BhTxKxHcu9QToti9Ev4Ah+Oyk+HOM
 WVLSrgp3SYfnlcoAsK/taf/hEpExgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017
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

Hi Tom 

Last minute PR for v2025.10 release

Please pull the STM32 related patches for u-boot/master, v2025.10 = u-boot-stm32-20250930

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27776

Thanks
Patrice


The following changes since commit a239b0b0b6dbe6a168969b8cd6e600cf85db278d:

  Add symlink from gpl-2.0.txt to a COPYING file (2025-09-29 11:56:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250930

for you to fetch changes up to 8a2e75e6a1ca51bbd81eef36ffb26737adec316f:

  stm32mp2: update register used by BL31 for boot parameter (2025-09-30 17:37:10 +0200)

----------------------------------------------------------------
stm32mp1: Fix env_get_location()
stm32mp2: Update register used by BL31 for boot parameter

----------------------------------------------------------------
Kory Maincent (1):
      Revert "board: st: stm32mp1: Clean env_get_location()"

Patrick Delaunay (1):
      stm32mp2: update register used by BL31 for boot parameter

 arch/arm/mach-stm32mp/stm32mp2/cpu.c | 16 ++++++++++++----
 board/st/stm32mp1/stm32mp1.c         |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)




