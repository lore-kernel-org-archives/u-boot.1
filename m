Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A723BCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17988836D1;
	Mon, 27 Oct 2025 17:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="P9Xtcic4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E39483837; Mon, 27 Oct 2025 17:36:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E6682E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=23951467bf=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59RGTVIn2196384; Mon, 27 Oct 2025 17:36:11 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a260b1p5u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Oct 2025 17:36:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C891tHg8ekUA02Y8R7LlMb/4e/gkCi24oLzqQ66RGrSZeqHbv8/L+R6ddpxmYCsVuJry1TXSB1ghxk2DREh3yD7MJij6D3APkSLpktNi7DMbK8e+vm0DfOOCURJHW6gWnaK2MwzxTLuFpbh6WqjWkQvgAtILPHO6ngtd7QOdDm/LPlf6ZU5xrZ6U4UK6123Q7aLjwEUaq8bvu3gVW4AWFQOAuWqcJ2D0IzlhypzYpciapz1J/Z4YmDfX/IcfMm9A8t1m1xUnE3cd2wnUa1/819y8PlYXSi5+IBohBL8B9ibpVZymSXvypGUcqMbTSXLP7+iG4jTEuxs/BLjcL2xqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfm5L37uKZbFw4aFoHaK2s5Own3kQOvJdNbykbukJtA=;
 b=E5AdM7quwcHOuLJ+Es2eVromelg/uSzGuqXlnTreYUGl4jxj7qanawqGPItC8kT+qfrjnQlC1kdjPbMSWSjsD+87EOAcgG1DuMqKrdlRIH14hG4Ese6nPtWCxGbGv8HGYv8pSDvTkG0Coxr48kjOlBRwRM+2tQ0AT3w+FPRzCoxNcZ851tYMmYUegsJYQWDWvUVOENjkcvnuHUGNXJStLZhs92iaSiVzBf6GtYvye71BCLwSSMdRgmC4GsB6Pl4TGFLvk4S7OEJd52CqojSfitpk6RTR6/2Y28O4bq8wfn+f3M6fsjkmq2gDAfC6HAMFqzlCgniYBd/Ak9CrkEx/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=eds-india.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfm5L37uKZbFw4aFoHaK2s5Own3kQOvJdNbykbukJtA=;
 b=P9Xtcic4a9/SdIIT5PDKNtOYeUJTeEYmLL/FIGPjDVIBX2UMD9PU8N28R6F52rfkmYmG0F+y4nObliVmIDAP2tUJOtujYpQgi9eADEX19eSP6P0G8aNOZKhSGUReJID51AOTo1OkTxfOhBZuMgwXCYwAH5KMAa+2y5ktg6WL0FDAlLnkdfrPWd7YGDDYPzkOETo7ez9oMyIEdyigF0QpelbKh5eRPQ48SsYktv8h9yHz7Mw0e4QJNSdQHkYeG6uAg3ZDe5EZRZg5F3A5BrXM/74awEzKTqe2vhI4PwcCtMxTPB0TlqYpCBxGIJbL7ZOvQO2GO+Bk2nsTC09a4Xt/bQ==
Received: from DU7P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::14)
 by PA2PR10MB8549.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 16:36:06 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::48) by DU7P251CA0001.outlook.office365.com
 (2603:10a6:10:551::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 16:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 16:36:06 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 27 Oct
 2025 17:33:51 +0100
Received: from [10.48.87.93] (10.48.87.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 27 Oct
 2025 17:36:05 +0100
Message-ID: <94b5922b-6f8b-4138-9d97-178c88bebad2@foss.st.com>
Date: Mon, 27 Oct 2025 17:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: stm32mp25: add ethernet support for stm32mp255 series
To: Asadeds <md.asadullah@eds-india.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <linux-stm32@st-md-mailman.stormreply.com>
References: <20251008063623.1233604-1-md.asadullah@eds-india.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251008063623.1233604-1-md.asadullah@eds-india.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|PA2PR10MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 86778bdd-50fb-4c82-f3bc-08de1576ed68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3pSN0ZMV2UwOENCQTdra0Y2RWJ4WWh4WW40WHhSWmdGdHRrZHh0OW5sVW5N?=
 =?utf-8?B?bEJGN0g2ZUhnZXpkdXNvNG16WHVXNHZ2eW5rcHpmUy9YTkNvQWZhc3c1aFNh?=
 =?utf-8?B?ZXhZY0VIN2MvS3hSa0oydVhMMlA1VUd6WXMwaHdOMHc1YVBXaG5UUk10NER0?=
 =?utf-8?B?SEJJd0d5N0ZWWlJRcWFOYnZwaTRnM0FRdmZ5cXFybXdqYlBDeVZETHNtTFRR?=
 =?utf-8?B?YWRXdXFFbXBrQVczNUM4ZHZKR1pGb1NqM1hWMDZkVVB5U3RvKzVHdzQrMnVH?=
 =?utf-8?B?K2tMakFuSXFBUENJOUtoSEFoVmU3SUJRaGFsditpQUJQSXFxclNrUFh3Ny9I?=
 =?utf-8?B?ZmRyVjM1RGhrcEhTODF5K1E5ODJJblNyK3JvSUl3MEVVU1BrM054MHhmRE5k?=
 =?utf-8?B?QmJCWndUcWNrSTFlMUVhK3FXYkRKVTlCRGhBbm1ld2FPK3lKa2RXSjQwYm1v?=
 =?utf-8?B?d2JUOWNiWTN1a2svNkFPTTE5SFplcjVzcklHb1NkUUR1dW5vQnNQMzlraDBj?=
 =?utf-8?B?SE14emVFU29tSFJPRGMxdEJuekNONllsaU9uU2wwUjdFdXhyMXpDTmZsd1Fo?=
 =?utf-8?B?dlVaZVFSK3JQUi91SzNQaGtUSHVyVlJOMFNmaFhnUDNhWDB6eFl4TURFOS90?=
 =?utf-8?B?a3BYSzJMVDE0N2pPV1lYSE9wR0xCVWttbWtaSEVDTXIxZVZzeis4YnEzTXZC?=
 =?utf-8?B?aDlhcExtM1RlQ2l0cm0rMDA3SDd1U3pkQnNKcEgzRTVXRFM3UnFxbWJPN0VP?=
 =?utf-8?B?Z1YvWnNUSjdUaHZNWWlwdUJodDkwTlhwWmNuUnFmenlMYzRPbUZKWFA5SWJ4?=
 =?utf-8?B?SmFzd3hTaWxiS090NmM1UVY5b1MwYktkQjdzZWZPSTk2RXk1QXV2QjZaZDJP?=
 =?utf-8?B?Mk9xN05CMU5CYXpVeVJxUk5STytqS3FXRE1ZWVRSZE9ZMTF3emJIZWNzVHFX?=
 =?utf-8?B?VDNzTW9ENURmQks3SVJSLzdhMFBpbkliTDhzNUdRaHdiaXlOSUttTDVYNVRQ?=
 =?utf-8?B?SjloNlNMWUtrS0IxN2hEUnF4bVhQWTM4S2xXbGNKajd1Y0xxYzUxRTdISk4r?=
 =?utf-8?B?TlE0RDhyeGRBT3JCV0x6L2JFNHVQclYzOEttSzQxcEd0d2F5OFJMVkZyWTd6?=
 =?utf-8?B?VUJrOFlRUFpOZm9DOXA1ZVIwOGxkYUJ0NE83T2g0VzloV3JpdmtVQmk3TlRU?=
 =?utf-8?B?UGEybS8xRXZjU29ydEsrNXZEYmtwcEdHNkxMKzdYR05Db2FyaXZpL09DT0Jz?=
 =?utf-8?B?K3ZMQmNvaGx5ZkM3aWk5ZkpCc1hHdCtoMXF3TW1qVGo5aW9NRkJhZ2JCZHBX?=
 =?utf-8?B?dXJ5MXFyVG5JRUlkWGRjaWZxQWMyMlZPSCt5cnJ3Nit2U2dVQU5xZk5ic3Bt?=
 =?utf-8?B?YklWanJST0ZQK2c1K3drV2FuOTNZZkFwWVZwNCtueFNLWUZ6ZmJidTU5enR6?=
 =?utf-8?B?dUwwTjRnZTJ0OVcyZzNiYlMrM0ZIWjRRdXAxNjdzUnd1QmdONzZCb3FjUC91?=
 =?utf-8?B?RHduZU5xYXZveUVaZmNHWjF4TEYwOHYxV1NOWnJxM3IyUHcyeHRYUUs3aHI4?=
 =?utf-8?B?NFFxRm1EZURTTGlYZStjS04yK1pFaWZDeHh5dVRsREVjNFFpV1lkcS9KMFRN?=
 =?utf-8?B?UGVpR3dCVGVrTnJacVhCUTJ4ZXUyZDZyeHhxckEzYWRhQlArekdoNXI2eFRo?=
 =?utf-8?B?N2Zyd2NVVGxKNmJPT1pmSElpMllSeGNGb0pkcXZFRUFzUkUzaENGeFJuc3ly?=
 =?utf-8?B?dmlpWThUWStGZzFFeitWTlVjOEZnbEt2MlNKMHdsRC91NEo5WWNJSkY1WU8x?=
 =?utf-8?B?K2oveFZZeHRoQ0hSTDFFN203c0pXRlNJMzdqOVZBbmVaOFJKTklzYzdjVE90?=
 =?utf-8?B?UDVNZTRLbUJheWs2MGF5UGY4UGZEQkxEeWd2QzVMd3BaZkNOM3M2eGR1QzhX?=
 =?utf-8?B?YWE5Q2EyNDZHcnNXYzNLNkorTFVDTE9oVFVpdlZHekZZK01TM0VnTmV5VGNS?=
 =?utf-8?B?aFhQdk1DcFM1QmtkR3pRc09STWd1bzk5WHIzeC9HUitQUHF4ckVPMWtsdlF0?=
 =?utf-8?B?YjdlNmVzQzViSFBvNFNCQldIUjBVbVFNWlpKVWJoSVJOQmRMNkZ4ZllQdVE1?=
 =?utf-8?Q?W0Mk=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 16:36:06.5225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86778bdd-50fb-4c82-f3bc-08de1576ed68
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8549
X-Authority-Analysis: v=2.4 cv=P+E3RyAu c=1 sm=1 tr=0 ts=68ff9f7a cx=c_pps
 a=nInhneuqoZ8BjlDhjnE/YQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2w8NBIiDAAAA:8 a=phlkwaE_AAAA:8 a=8b9GpE9nAAAA:8
 a=N_hvqaV3cylnDdaUKoIA:9 a=QEXdDO2ut3YA:10 a=FR9XvEe225z0xfbndyrf:22
 a=uKTQOUHymn4LaG7oTSIC:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: sG0LWDs22FaKfV6pszQUXwJh5pbogyuM
X-Proofpoint-ORIG-GUID: sG0LWDs22FaKfV6pszQUXwJh5pbogyuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE1NCBTYWx0ZWRfX+UrM8sarZYhD
 caJ9Aw8A+7+zD38v/UmzJJNJUxa5cjRctANdG334rqvV0D5LUVlfz0BSr073D2lQTRABdK9ovzB
 VZmXB2f1XFIqq/fiuiFI01m4H790r+YPI74ZQ6WdwSXmMvxxP9TgWoPgoCuN+ChX4x85ykoQR3k
 e4FE97jA/l3PVLO4BH1xnjnAa3F6AE30lda+xzFaqD2wTeAKWv+e1/hdVQcR3yTBtOcE2eIOsOh
 3UIAEOt1yC/Zlzrjxid5+djUPD5w/AgcHa9onWSAksyJ6HTV80ugexfPtvKXaO0NwIOfBb7+rXV
 OxUeykuk3UAVMvv/VJL1wTlXi/sdVXV9Ho/ljNp4uyPh03iD6tT6NZ5OYFe4xvh7y2F3omtejuU
 pNcMOuLkhxxkg9RwVZNjXGXag0goJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270154
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



On 10/8/25 08:36, Asadeds wrote:
> Add missing CPU_STM32MP255* cases in get_eth_nb() so that U-Boot
> correctly reports 2 Ethernet interfaces on stm32mp255 devices.
> This fixes the "ethernet not found" error during boot.
> 
> Signed-off-by: Md Asadullah <md.asadullah@eds-india.com>
> ---
>  arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> index 0d199f6f903..48b452f01b1 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp25x.c
> @@ -78,6 +78,16 @@ int get_eth_nb(void)
>  	case CPU_STM32MP257Axx:
>  		nb_eth = 5; /* dual ETH with TSN support */
>  		break;
> +	case CPU_STM32MP255Dxx:
> +		fallthrough;
> +	case CPU_STM32MP255Axx:
> +		fallthrough;
> +	case CPU_STM32MP255Cxx:
> +		fallthrough;
> +	case CPU_STM32MP255Fxx:
> +		fallthrough;
> +		nb_eth = 2;
> +		break;
>  	case CPU_STM32MP253Fxx:
>  		fallthrough;
>  	case CPU_STM32MP253Dxx:


I forgot, remove linux-stm32@st-md-mailman.stormreply.com from Cc as it's an U-Boot 
patch and add patrick.delaunay@foss.st.com and myself instead.

Thanks
