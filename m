Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42030CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 08:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D23B83B0A;
	Mon, 17 Nov 2025 09:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="E2nIMXLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC54A83B0B; Mon, 17 Nov 2025 09:33:17 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C277F83AEF
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3416482c8e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AH8X2px779907; Mon, 17 Nov 2025 09:33:09 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com
 (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aejg5np35-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 09:33:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+NrqnkQraiI9ckLmQvhw/yVehxWztW/3Si7DAHmP1gaey4Y7/0minJj/FkIFwJxJQ5GdCBlWljlIuofXIzf6mj8yKkbWGtjR9sucxOHLWENUN8yfsqb7ThZjCtnsXIJfMmlf6KxiG+ujnQGi2kh/JU0t2kUSxUFyzRJKfXTkamiX6WEhl7Y9vattKFP/o3p6qW1nqtGlImuufmf56PtQWHB0q+FmCQQ3EOcBGChju0Slz2F2bnaiyRG4YCE5Qnmfkgmt7TqO5BXAOmoioC0n2fkdZ47TxjMCIMtp6Tg1t9f6FAYupg7ZM52guVXt+zP5iE8dYGt1jKEUjFpPFeUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ50CWsiBcmi0Z9xtiRRZmQBPyJITdPTjIPrvsPRfWs=;
 b=bKxoBMjQfhuqEr8ybJuX0xSu6BZ9ChOVlUyjL+qkhiZtzG/gdrjx+srRiHBx/gqJelUqUpT/ZgWmWIuokrpi7vAw3Rv7hTYzKZuUBo4TPouBoIVlFJpHRyu7ZtIL1quEJrxSLGjhMrxAKe0Di0GA0GAnHehB55ngOpG/MHif/J28H98Ti9dUSfTP1VyQ2lb7WolO06TYCNF6P1gN3RamZQRkogmy02hCF7BlqyjjgkxcKd4SraT4IB/zXu0QU3I5GkpJM6LUZnxjPnRIkLVokUrC6ktWaTscxi76h6Bw3pfA3L6U9DmuxFG5wwCvifZyqU+SLMwUZaVnin8xK35lgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ50CWsiBcmi0Z9xtiRRZmQBPyJITdPTjIPrvsPRfWs=;
 b=E2nIMXLfcNQKXiCat+Lv/GN9QwTu1r6pWhIhW6O4xvytTjUr341k4QoB05kKq1B3fEP8XAEQhq+jPmTiM5T/L72LRxNvOWJTQ0yCic7lcqMGIsx1/e3mRIOttQuZdYM2TK2ihqHRecUPJ3w9jJ0L6rzUAwHdJe5gJr/fh8Y9fkT2XzxmDUETT2dOYJcOp3LEsTmG4O/gszyvt+54fUdD8O/+nynVzPPKpeSvjrptWksChDQLIP6QXy2GoqNNEOQLfwmAXBkVayoMpGasKtaMJ5eGvhH5UXVZz2k7Arx/h7llaJT6q1N1DTC5mDI1VE9bApX7ol3NBm7hrn8H2ObYLw==
Received: from DUZPR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::6) by AS8PR10MB6698.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:564::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 08:33:06 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::5f) by DUZPR01CA0013.outlook.office365.com
 (2603:10a6:10:3c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 08:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 08:33:06 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 09:33:19 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 09:33:05 +0100
Message-ID: <dfa99b38-b75c-42da-b631-a158699b3f0b@foss.st.com>
Date: Mon, 17 Nov 2025 09:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.01 =
 u-boot-stm32-20251117
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Asadeds <md.asadullah@eds-india.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <raphael.gallais-pou@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|AS8PR10MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 3695baf3-5c5a-43c6-26da-08de25b3eec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STh3eWJQTy9VNzhjeXgraGt5bGV3ckxQSzNyZVpYNnpRUnRmSVc0VDg2Wnli?=
 =?utf-8?B?cWVncnRsZXVtQlcxeXFjS2NSbzJBTWloK2dITUY2SVZQN1VqWHBjRlNnM2FW?=
 =?utf-8?B?enJYYS80TnA4Y3A3d1pwMEt4bG5pS0Qwd2NTYTJvMFNLNkVGQnBUNWttaXZj?=
 =?utf-8?B?K3VWdThnQWpXdk1OMlZzZ2YwSVRKMmpJS2s0MFRKUFc0elkzNzNBeFUwTnh2?=
 =?utf-8?B?V0tiSnlTQzQ3ZkJ2V2NqeEhwaERXWGR0dy9jdURRb294MHAvOW9ESXQzeFNJ?=
 =?utf-8?B?MTFFOFo2a3lLTXlLWE9iNmZDa0dMQTJQUHM5dnZKd1VLODl6U2VFTEZUcy9I?=
 =?utf-8?B?eFI3QWYrYk1JTlQwMlBPOUUzaFVoajlKdVgwakEvc1FrQUo2YTVpUm1uOTdU?=
 =?utf-8?B?U3U5UTJIbGVxMCswMnJYOHRPUk5FVU92dTlobEZnSkxWd3VOZUtmNVhwVHZr?=
 =?utf-8?B?Z1BMd3Zjd1RFRzlwRHVBdWlZZHl1WE9uWWlQOHlzMFlnVkdYVWZBcnBHZEJC?=
 =?utf-8?B?NGREYzFKdWw2OExIQ1ROcVdDcEd2RmVIblZSYjhmcXdCOGc2a1MrNDJ5emMy?=
 =?utf-8?B?MTVwbzRVM2NWckg4eWRHTmZ1NmhrVXRZZCtpNGNuU3F5UXYrWjVuU0I3bGEz?=
 =?utf-8?B?cnk4WDlNdzZWOFZhL3d6cFlCdyt1QVNncnMzZGN1UWZPVnZZMTBpaTJoOWpF?=
 =?utf-8?B?bWtQeERDRGdCRlVJbVZFVE4vM2JaQTBhQlVMc3dpWHhEVThrS1N0akE1cUht?=
 =?utf-8?B?cWpHNWx0R1NFT2xja0xCeXB3emV5N0NlRmh0U0c4bmpSQkF5VmFKVWZKa0cy?=
 =?utf-8?B?Vzc5ZU5NRFZaaWxkMUpyZW95SVg4VGNkRjljMWw1a0ZmVXV4YXhxbWc3U3ZF?=
 =?utf-8?B?c0ZXb1RYMjh1Z3o1cThUYy9sQy9RQWFhUmtKRjlUUUwrZUdDN3J1TnRSYWYy?=
 =?utf-8?B?V3NORTVtaE1tcjdXVDdHcVd6a3h1MW1id2FWNVVLdi9PQmhxUk9rOEo3TkVx?=
 =?utf-8?B?TnpXWUpOeTRBUk5DdzczWmQzbHFNN3Bob1FJKzBsWXRSclV6L25OZVEwU2cv?=
 =?utf-8?B?cW1xTEluWHBXZWNoNCt1WkJmL3czQmlna3pXdWUzMlZ3Z0JNeGd4T1ZBbGFi?=
 =?utf-8?B?SUh3VUZpRm1veU5XTVBXK04vclpYTk9Sdlc0LzR2dXl6YVhZMXYyYUdFcUNX?=
 =?utf-8?B?ekxqMSs1Qjh2RlRQNDJuOC9oTTVCbXVraDhLS09Oa2N1eitmNThQbXhkTG5k?=
 =?utf-8?B?Q3hwcndlcGZDN09KTWFod3BiQTVqKzZBUFVHRzRTWWdMVnJuR0tPL0t0R0RM?=
 =?utf-8?B?UG00TWY4R0l1WTg0VXRSS0pQMDZQL1FId1VrajhZNFRSU2cxbHBYNkhybWto?=
 =?utf-8?B?b3g4Z3cyM2k5ZHF4d1I2RkZGUGhJdkRaQ3B4bnp4aEN2WnB6QXhqTEwvbEhH?=
 =?utf-8?B?QlptdEt0Nk1EZHRhdk04dWZ4NERtVEduUEcvb1dMOGFvMmQ2RlpicU9od1Mz?=
 =?utf-8?B?NjUxMzY3WjNGTHVPYkVMUDBCS2E1VEdlVWxGMHJxYlExOS81YlBrWjczbE1t?=
 =?utf-8?B?UXk1VWFXdldzZ3hyOG0wTktSNVlqY0tIVDJhZWx6Y3dmQUYzSVRneDBTMEJx?=
 =?utf-8?B?cG0yOUpFN0xOUUtlY0tBeW9RTVJURHkyUFdXZWxRMjN6T1ZLOWdXU3VCQVJ0?=
 =?utf-8?B?VGYweVFFR1BXVnhJbG5UY2dKNlJwc2duYlpSbEoxUFYvZ296NXV2Z0RHaldB?=
 =?utf-8?B?bU1nSjNGK3hSRlI4RmkyRjVPZUI5TWJtdEFFMnFFdExTR3k2Q0xwOTVRZmVh?=
 =?utf-8?B?eTNNb0EwS2xRSVh4UHdqWFZkTy9CWVdFbUJHWUZGcDcwODdsaElyRjY1SGN6?=
 =?utf-8?B?b2NLL1hjTm51N2hOejZxVG9menV0M0FENU5wMkRERFdBR2NlUklZQmNDSlFS?=
 =?utf-8?B?amY4d2VWZG1LdFVmdWk4VGo0STlaL2pwZ0drMk1DSXUvbDloQyswQjl6VFpa?=
 =?utf-8?B?a2pKdDQ2SWJBbzFtTEVHMU84TnNGbWJBTXN0YmlPQUp5UjdLUmNJWEZLdE9O?=
 =?utf-8?B?NHVjS3B3S1YxMkZ4dTc3djZzSXhlVHphVGRjcUhOWVhVVWtUZ1UzZkhMcDVy?=
 =?utf-8?Q?Gfng=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:33:06.7498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3695baf3-5c5a-43c6-26da-08de25b3eec7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6698
X-Proofpoint-ORIG-GUID: N1VjG26TlJPrYsnq6G6U5KRZJ5nMw67z
X-Authority-Analysis: v=2.4 cv=ItcTsb/g c=1 sm=1 tr=0 ts=691addc5 cx=c_pps
 a=xll3xbV7JMl3Gf1MSjFUYw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YfCOm-DyAAAA:8 a=wRm2HhVlGiIUVzyrR_cA:9
 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-GUID: N1VjG26TlJPrYsnq6G6U5KRZJ5nMw67z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA3MSBTYWx0ZWRfXyYFkt/A9ENKp
 eafJFp8oa9xIed80ZwJOLQAfH1hQ00b9lHwNuWCqcJonxJvMOUp5+YKAIaubR0XyheES3ijP5Nc
 zTB14DHOT4vSA31DtKfGqtHn7ccgwnPscqUM4QOy4r0OHVWa7yHFiuh5y9DsH1EUmUO+21cDJWi
 xY3z65h6PUfaqtpN2kbkt6pvxly6aF2jqW4n7CCGY6Umb1vlNJCGonubmjMInI7+v6I/KoALI8K
 h3NZxo+Eaj0XT2Gos/3IixM+AhrNHa8yHhhAraTwXdZNh6IF0+0HEi5THTcFAOo3CX9D8u1nQmd
 kDdiV4KqHBUrVfIJDDnVOvP8/6ZO4EUJt0jNZaLBIu97LFoVjYGwoV7XTSIJNuHo4MoqCbFRGfA
 vYs5fMhM5RgLFaABWG7r0/IDObS+XA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170071
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

Please pull the STM32 related patches for u-boot/master, v2026.01 = u-boot-stm32-20251117

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/28392

Thanks
Patrice

The following changes since commit 365a7079fb918643da0f0709660a7d8ea76dd6f3:

  Prepare v2026.01-rc2 (2025-11-10 11:30:56 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20251117

for you to fetch changes up to 66e2e941cd44db9c642b64618bd16ef132fca83e:

  ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHSOM (2025-11-17 08:09:23 +0100)

----------------------------------------------------------------
dhelectronics:
  - Move dh_add_item_number_and_serial_to_env() to common code
  - Read values from M24256 write-lockable page on STM32MP13xx DHCOR
  - Add MAC address readout from fuses on DH STM32MP1 DHSOM
  - Keep the reg11 and reg18 regulators always enabled on STM32MP13xx DHCOR.
  - Fix boot for stm32mp15xx-dhsom.
  - Fix build of ST DFU virt code on DH STM32MP1 DHSOM
  - Introduce DH STM32MP13x target.

STM32MP2:
  - Add support for stm32mp257-dk board.
  - Fix arm, smc-id value for stm32mp23/25.
  - Fix stm32mp235f-dk boot (add syscon compatible, add txbyteclk).
  - Add display support:
    - Introduce LVDS driver.
    - Add LTDC support.
  -  Add Ethernet support for stm32mp255.

STM32MP13:
  - Add ADC support.
  - Add power check for stm32mp135f-dk board.

----------------------------------------------------------------
Asadeds (1):
      arm: stm32mp25: add ethernet support for stm32mp255 series

Marek Vasut (7):
      ARM: dts: stm32: Fix STM32MP15xx DHSOM boot breakage due to ETZPC
      ARM: dts: stm32: Keep the reg11 and reg18 regulators always enabled on STM32MP13xx DHCOR
      ARM: dts: stm32: Introduce DH STM32MP13x target
      ARM: stm32: Add missing build of ST DFU virt code on DH STM32MP1 DHSOM
      board: dhelectronics: Move dh_add_item_number_and_serial_to_env() to common code
      ARM: stm32: Read values from M24256 write-lockable page on STM32MP13xx DHCOR
      ARM: stm32: Add MAC address readout from fuses on DH STM32MP1 DHSOM

Olivier Moysan (1):
      adc: stm32mp13: add support of adc to stm32mp13

Patrice Chotard (7):
      ARM: dts: Add stm32mp257f-dk-u-boot.dtsi
      ARM: dts: Fix "arm, smc-id" value for stm32mp23-u-boot.dtsi
      ARM: dts: Fix "arm, smc-id" value for stm32mp25-u-boot.dtsi
      ARM: dts: Add txbyteclk clock in stm32mp235f-dk-u-boot.dtsi
      stm32mp: Add stm32mp23 support for syscon driver
      configs: stm32: Enable ADC support for stm32mp13_defconfig
      ARM: dts: Add st, adc_usb_pd property for stm32mp135-dk-u-boot

Raphael Gallais-Pou (6):
      ofnode: support panel-timings in ofnode_decode_display_timing
      video: simple_panel: add support for "panel-lvds" display
      video: stm32: STM32 driver support for LVDS
      video: stm32: ltdc: support new hardware version for STM32MP25 SoC
      video: stm32: ltdc: properly search the first available panel
      configs: stm32mp25: enable LVDS display support

 MAINTAINERS                                       |   1 +
 arch/arm/dts/stm32mp135f-dk-u-boot.dtsi           |   1 +
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi        |   9 +++
 arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi        |   4 ++
 arch/arm/dts/stm32mp23-u-boot.dtsi                |   5 ++
 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi           |   8 +++
 arch/arm/dts/stm32mp25-u-boot.dtsi                |   5 ++
 arch/arm/dts/stm32mp257f-dk-u-boot.dtsi           |  26 +++++++++
 arch/arm/mach-stm32mp/Kconfig.13x                 |  12 ++++
 arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c       |   8 +++
 arch/arm/mach-stm32mp/syscon.c                    |   1 +
 board/dhelectronics/common/dh_common.c            |  37 ++++++++++++
 board/dhelectronics/common/dh_common.h            |   9 +++
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c |  37 ------------
 board/dhelectronics/dh_stm32mp1/Kconfig           |  23 ++++++++
 board/dhelectronics/dh_stm32mp1/Makefile          |   4 +-
 board/dhelectronics/dh_stm32mp1/board.c           | 108 +++++++++++++++++++++++++++++++---
 configs/stm32mp13_defconfig                       |   2 +
 configs/stm32mp13_dhcor_defconfig                 |   2 +-
 configs/stm32mp25_defconfig                       |   3 +
 doc/board/st/st-dt.rst                            |   1 +
 drivers/adc/stm32-adc-core.c                      |   1 +
 drivers/adc/stm32-adc.c                           |  88 +++++++++++++++++++++++-----
 drivers/core/ofnode.c                             |  17 +++---
 drivers/video/simple_panel.c                      |   1 +
 drivers/video/stm32/Kconfig                       |   9 +++
 drivers/video/stm32/Makefile                      |   1 +
 drivers/video/stm32/stm32_ltdc.c                  | 158 +++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/video/stm32/stm32_lvds.c                  | 693 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 29 files changed, 1192 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
 create mode 100644 drivers/video/stm32/stm32_lvds.c
