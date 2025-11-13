Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E80CCD5BD1
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 18:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA4B83FC6;
	Thu, 13 Nov 2025 19:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="FYapvFzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6E483FD4; Thu, 13 Nov 2025 19:00:04 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D8683B8A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 19:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3412314e69=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ADHiRxT085314; Thu, 13 Nov 2025 18:59:59 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com
 (mail-francecentralazon11013039.outbound.protection.outlook.com
 [40.107.162.39])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu6aef-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Nov 2025 18:59:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WbVKsM1CHik6n9rf7JqOKWVqHI8HOyOlCWJpgTbpQVf5dXdg4CGq6ior+R2YbFYLwjd+6BbbLTz51PecaHuE7eeeywxldVqf9FLh9deb7XCwRaSFal9Sh8OuAKvrzr3JCkTmhf18KOCVJY/M7fwB6reuv0wn3xqn8OzkhmjBsB7LfixeLhxepxgCYCeasc4M3O9xkaCwLhKcJPw+R1Bx5CcJ2qQIOUTkB6vN8ZeQ2siohkcbRE6CFQ/2u8VSBA2w++L9PxaEAlrKPxrYLB0pNdnMeMzsrYE89oHyDqVQvNGI6Z9w3NmC9/UPNQRJmSbh8Q9CjujnIgtF48S/Q6xtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOX32X4sR6YipVYb1WUIGETYifZJktkfp/+5MYgtVxM=;
 b=WAjl1x4U8fXzF4BV92PJWHQ6pqfmLT2g+i1Aiaojub8/BMm3JbjlRdbWFsz7qqmfwjdcaTOTiKNEITfV2X62aFWQUgbVrK4xWo/a2pvVilkH4JqRpG3/CSBT38JfKa9+UW0Pdk2ogUJkaDUA8EUQFItZ066GFkzpy+NEfofpCIk24nkU0LW3+vk94KC5xJ+WfE8LutWwwnSQCV+1sKmMprmoRKZthYcYDKhb/VNUq0W9LA93sLTivGG0R6nzTHloSEoXH1YUL2/l1YTuzgxubAnFIefCWvektTU0rCfjA763ZaSWrq9cQZ4IIrwcmPtF7kprUu9ZwnEwtT8415axKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOX32X4sR6YipVYb1WUIGETYifZJktkfp/+5MYgtVxM=;
 b=FYapvFzwt2TbbHyh7fJz71GZLciHvFle0BG+ry0dmBl0ol1xhJH+uheU2MGSaozBTDfdoHYNwZ/qPNbN0OMg/YYb00oWeYqqtt+L50BO97zjKa2LgPsntdGryLx5dXP/PxyhN3UScy7fFmdpVQgZosT1ggdivnRs8XksgSkCWDdyt86hJcKX8SkgF7Cr+xUiNWBSZBJTDzTHh9cJq5wWQbuYbpU845RmY4DjMQNd5L0nsTrumY/Gn6YAviWNTjKOOgJxRmh+8RNR4z2p1hHZ62REkIp3gnq/TCU21c7kY+xzxbH9mQyl2Nk8J0oN0RsI1a1xTcB1XS2redp7jFWOAg==
Received: from AM6PR10CA0067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::44)
 by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 17:59:55 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:209:80:cafe::b9) by AM6PR10CA0067.outlook.office365.com
 (2603:10a6:209:80::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 17:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 17:59:53 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 19:00:04 +0100
Received: from [10.48.87.108] (10.48.87.108) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 18:59:52 +0100
Message-ID: <10609ea2-d2ee-4e0c-bf9c-1178e67a5776@foss.st.com>
Date: Thu, 13 Nov 2025 18:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] adc: stm32mp13: add support of adc to stm32mp13
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Tom Rini <trini@konsulko.com>
References: <20251009152610.300154-1-patrice.chotard@foss.st.com>
 <20251009152610.300154-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20251009152610.300154-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.108]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|AS4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b26082-bfad-4b06-33f6-08de22de7279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmxtbmZSNGZKR3FXSThzS1lUbDdONkdQbXRkNml0em9zd21DSDBRVGpPTHAv?=
 =?utf-8?B?czdvQlRxVzNxNTlpSWoybStEbzY4ZVU1bjRGdWlVVldSN1cvTHdxSng1dVlm?=
 =?utf-8?B?bWdNVUJKb3dGeTh2ckY3L3ZMV0xRakpnWHJaUE9lZ1c1UHhmTnZUV3JUbXBm?=
 =?utf-8?B?QUxTdmgrR2xVYmZxWUpFSlpBSEV6cTBMQWpQcWdMVWdienlFclFPeCtyak5Z?=
 =?utf-8?B?eFMxUVh2WGlHQzFjMEozZ0VuOGpXcnNUYVRPblhMVlB5aFUwellFR3pqeVNE?=
 =?utf-8?B?Slh6b29VOHB1U3dPT2RrVG9pclk3bmhodWpQZG85cGdESUZKVXUzNmF3SVlP?=
 =?utf-8?B?ZWN1VmE5OGhhcnp4RlFnSTd2c2NsWXVFTDlPN1VUTDEwb0VZWHM5NUFwUSt1?=
 =?utf-8?B?YnVYM3BTaUtMTXZ5bnN2Z3N4WGM3aFl6TlhzOFkvbUh5YnNJQlBkeXB1YVds?=
 =?utf-8?B?ZGNRR09WMDZHSXpJbndEbDQ3N2FkNG9jWEUxanNuQjBlQjZJVXBkNkprWTBC?=
 =?utf-8?B?K3paR2JVeFFEeDhTOUtjdUVBZ0IwNE5zR2RoR3VqVi9NUHFHTWhvdGdaZEF2?=
 =?utf-8?B?cm1IOWFWMERjd1owcGh3NmU1YTM3a1lQT2ViVWVlanZIUWp5Nm5VNC9TWHlW?=
 =?utf-8?B?UnBjbHFpVEYreUEzWjlSQlVCaEFKdkEyWDdNcTZiM3JYR1pyWHpYMmhvR3Nu?=
 =?utf-8?B?YWgwVWxHMk5ucFZJUGtGeFZmRC9nZGJ3NG5SYmE3ZkU4M0lFNlA5UlF1K093?=
 =?utf-8?B?RDdyS2dwTjJmbGcvNnY0Tm5GZFphRjEzbmIwbGFOckI0NXJxQ2UrY1haMXJQ?=
 =?utf-8?B?b1V0b3R4czZJSllPcUpqUE1EV2RZeUZNVmpCM2xpMHplS2hkNll3Y0I3Tlcw?=
 =?utf-8?B?VjZzRG00Vk16SHlxdnZwQzFOa01oRE5DbFlUcG5UVXVRcFZPb05GTC82N2Zu?=
 =?utf-8?B?YUs1dnZSOWI1S0QrbEpWM0w2RTZ2R0luQVFIdUhicWZUQmM0VDRPYTJ6NmtT?=
 =?utf-8?B?RzV2Zy9iendZMlpDb3JnMnJ4NjIxcG5SR2hjWTRET3lDWi9kalFWM2czT3VC?=
 =?utf-8?B?eC9RZDhjV25HeEtuWmw0OVhUZ2tFMXI1SThYUWVjUjkzTzZQQXZKU1Z1ZXU0?=
 =?utf-8?B?Y0NZSktScWswOVV4ais3QTNOdFJYSXNIWFFPNTJyOUpRZDFqRVNGVG5hdm0z?=
 =?utf-8?B?RllGVG42TlpEelFVUkZWVUQyZTRJQ3VOV1g5NnVBNWRwL2dkREhYWXVnWGp4?=
 =?utf-8?B?K0RiOXdYOFhOeFBVcHNPODNCbWlkVVZGSmtMSGxjbFZadzRpM3E1K0UxM1NN?=
 =?utf-8?B?VTYySFVkbmVvZFJnbThQaXlTNEE0eW5QU2JMNHRERDBTWTQvNVBrMEhYYXFM?=
 =?utf-8?B?UGdEREZpalluTWUvMTMvT1QyU1hCZVhOUUU4Sm1OUy9BdUN5ZkdrZmphSm95?=
 =?utf-8?B?dk5yWUNhQW5CcnNMU2RQcUlEaE5QaUZJOXMrYW9JdFFscTZWK3BIbStEeVVS?=
 =?utf-8?B?N2YvOFlZaDlXYTczUmdpV1A0RTVlbmdkb2drVnlGa1V1TkpPWFVpUThaaUc0?=
 =?utf-8?B?OHJScnp2UTdRUXV0UUhLUVMzZ3pub1ZXQ0t3cGZZam9LYTV0UUtZSnZ5YjJa?=
 =?utf-8?B?UFRjQkVqK2pNSzVRVVlpaUNVWW5qeC9HVE9XNVJJcUJ1MzFrRUg4V25KQ3NR?=
 =?utf-8?B?UDJzNTRLR295djY4dXJIZkpXcTkxTE5vK3VGSndocTlWejltT2JtUGhCM3hF?=
 =?utf-8?B?LzBJaWVrQzMra0hOK2FiY0N2UFJaNXhLWWRnRE5lcFY2L3R5cVRiODBpZ3cx?=
 =?utf-8?B?cmtLSGNVell2aHdJTXh3NlhKWmpnaWM2eWhmM0hhNmVLeHRzemh4cHFJV1Nq?=
 =?utf-8?B?Qk5wM1EycTUvY2ltTG9UOHpQdGhDNGMyVmJ4RXFjMVNQdjBZS2pkZDB1Wkpq?=
 =?utf-8?B?YlN5TmJMRjBsRjI1WW42WjY5d3YybU1NbDI4Wkkva2F4VlV2YlV4anppUXFi?=
 =?utf-8?B?aHRpTGJ2QlB1WVBaRW1zRjhzb1NyR0xhck5rRkdTUEIvbm00MCsyYldPUWhk?=
 =?utf-8?B?L1VNbWNIb091c0xmaHl6R1hYMUFYSWk1R3R3MlNvWkcxdTZEQk1GaGdLcnNB?=
 =?utf-8?Q?8sHI=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:59:53.1084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b26082-bfad-4b06-33f6-08de22de7279
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6181
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE0MCBTYWx0ZWRfX5ZLvYMx6cR8w
 FamRIYZFLjy+9HqNzHf7H8YmNOJJ6jWe6xvJk0z0f/bX+UUbOykZC07Z65fjqwZhhbdc5o8KDYd
 50sOWLRrjnMVaSt7YvHFtAakj/Y4sJb93aBiBZU/J+t/55u+TQJqv0nAXhvUOPTqMP68f56b8y6
 zu8DUcFTj8ISQEmAT+SjbAIWQEFXpaypbcvveqBTfiqTBe5ffM3kRsvTPN3VDL437GLkXjlQ1fG
 UkqrX1Nr4qQ4k/6+mOLjv6JvdoE5jZcMkXzTm3mJzDjnjpCjlYn51KP77xKxzp/x3bjO/cmtzbB
 Yr+XC9+2cy6u4a7PwEVaLjTMFMguW21xvxnd+yXbCHdH3xLRRbOZ+U0UojG/DOL1zgcUl5GDQMN
 EOkDpigr6telxsFyL1VvmUa3z8TkgA==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=69161c9e cx=c_pps
 a=6PCtUV3SjW4dSF/fw/j/Nw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=q6CKDgr7omsA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8b9GpE9nAAAA:8 a=PUsbfvoI6Aq4JJ9LE7IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: A-k06rSz5Z_vGS3qOLbZgW08e03JoiD3
X-Proofpoint-GUID: A-k06rSz5Z_vGS3qOLbZgW08e03JoiD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130140
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

Hi,

On 10/9/25 17:25, Patrice Chotard wrote:
> From: Olivier Moysan <olivier.moysan@foss.st.com>
>
> Add support of STM32 ADCs to STM32MP13x. This patch introduces
> stm32_adc_regspec structure, as this is already done in kernel
> driver, to manage smartly the differences in register set
> between STMP32MP15 and STM32MP13 ADCs.
>
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   drivers/adc/stm32-adc-core.c |  1 +
>   drivers/adc/stm32-adc.c      | 79 +++++++++++++++++++++++++++++++-----
>   2 files changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/adc/stm32-adc-core.c b/drivers/adc/stm32-adc-core.c
> index af340b8b273..3446e34fa46 100644
> --- a/drivers/adc/stm32-adc-core.c
> +++ b/drivers/adc/stm32-adc-core.c
> @@ -200,6 +200,7 @@ err_aclk_disable:
>   static const struct udevice_id stm32_adc_core_ids[] = {
>   	{ .compatible = "st,stm32h7-adc-core" },
>   	{ .compatible = "st,stm32mp1-adc-core" },
> +	{ .compatible = "st,stm32mp13-adc-core" },
>   	{}
>   };
>   
> diff --git a/drivers/adc/stm32-adc.c b/drivers/adc/stm32-adc.c
> index d50f00f1233..808c3c610f8 100644
> --- a/drivers/adc/stm32-adc.c
> +++ b/drivers/adc/stm32-adc.c
> @@ -49,16 +49,35 @@
>   /* STM32H7_ADC_SQR1 - bit fields */
>   #define STM32H7_SQ1_SHIFT		6
>   
> +/* STM32H7_ADC_DIFSEL - bit fields */
> +#define STM32H7_DIFSEL_SHIFT	0
> +#define STM32H7_DIFSEL_MASK		GENMASK(19, 0)
> +
>   /* BOOST bit must be set on STM32H7 when ADC clock is above 20MHz */
>   #define STM32H7_BOOST_CLKRATE		20000000UL
>   
> +/* STM32MP13 - Registers for each ADC instance */
> +#define STM32MP13_ADC_DIFSEL	0xB0
> +
> +/* STM32MP13_ADC_CFGR specific bit fields */
> +#define STM32MP13_DMAEN			BIT(0)
> +#define STM32MP13_DMACFG		BIT(1)
> +
> +/* STM32MP13_ADC_DIFSEL - bit fields */
> +#define STM32MP13_DIFSEL_SHIFT	0
> +#define STM32MP13_DIFSEL_MASK	GENMASK(18, 0)
> +
>   #define STM32_ADC_CH_MAX		20	/* max number of channels */
>   #define STM32_ADC_TIMEOUT_US		100000
>   
>   struct stm32_adc_cfg {
> +	const struct stm32_adc_regspec	*regs;

minor replace tab by space before "*regs"

and it is strange to use "struct stm32_adc_regspec" before to define it
that can cause some warning with compiler ?

>   	unsigned int max_channels;
>   	unsigned int num_bits;
>   	bool has_vregready;
> +	bool has_boostmode;
> +	bool has_linearcal;
> +	bool has_presel;
>   };
>   
>   struct stm32_adc {
> @@ -67,11 +86,30 @@ struct stm32_adc {
>   	const struct stm32_adc_cfg *cfg;
>   };
>   
> +struct stm32_adc_regs {
> +	int reg;
> +	int mask;
> +	int shift;
> +};
> +
> +struct stm32_adc_regspec {
> +	const struct stm32_adc_regs difsel;
> +};
> +
> +static const struct stm32_adc_regspec stm32h7_adc_regspec = {
> +	.difsel = { STM32H7_ADC_DIFSEL, STM32H7_DIFSEL_MASK },
> +};
> +
> +static const struct stm32_adc_regspec stm32mp13_adc_regspec = {
> +	.difsel = { STM32MP13_ADC_DIFSEL, STM32MP13_DIFSEL_MASK },
> +};

minor all this block can move before "struct stm32_adc_cfg" (when used)


>   static void stm32_adc_enter_pwr_down(struct udevice *dev)
>   {
>   	struct stm32_adc *adc = dev_get_priv(dev);
>   
> -	clrbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_BOOST);
> +	if (adc->cfg->has_boostmode)
> +		clrbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_BOOST);
> +
>   	/* Setting DEEPPWD disables ADC vreg and clears ADVREGEN */
>   	setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_DEEPPWD);
>   }
> @@ -90,8 +128,7 @@ static int stm32_adc_exit_pwr_down(struct udevice *dev)
>   	/* Exit deep power down, then enable ADC voltage regulator */
>   	clrbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_DEEPPWD);
>   	setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADVREGEN);
> -
> -	if (common->rate > STM32H7_BOOST_CLKRATE)
> +	if (adc->cfg->has_boostmode && common->rate > STM32H7_BOOST_CLKRATE)
>   		setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_BOOST);
>   
>   	/* Wait for startup time */
> @@ -134,7 +171,7 @@ static int stm32_adc_start_channel(struct udevice *dev, int channel)
>   		return ret;
>   
>   	/* Only use single ended channels */
> -	writel(0, adc->regs + STM32H7_ADC_DIFSEL);
> +	clrbits_le32(adc->regs + adc->cfg->regs->difsel.reg, adc->cfg->regs->difsel.mask);
>   
>   	/* Enable ADC, Poll for ADRDY to be set (after adc startup time) */
>   	setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADEN);
> @@ -147,7 +184,8 @@ static int stm32_adc_start_channel(struct udevice *dev, int channel)
>   	}
>   
>   	/* Preselect channels */
> -	writel(uc_pdata->channel_mask, adc->regs + STM32H7_ADC_PCSEL);
> +	if (adc->cfg->has_presel)
> +		writel(uc_pdata->channel_mask, adc->regs + STM32H7_ADC_PCSEL);
>   
>   	/* Set sampling time to max value by default */
>   	writel(0xffffffff, adc->regs + STM32H7_ADC_SMPR1);
> @@ -156,9 +194,11 @@ static int stm32_adc_start_channel(struct udevice *dev, int channel)
>   	/* Program regular sequence: chan in SQ1 & len = 0 for one channel */
>   	writel(channel << STM32H7_SQ1_SHIFT, adc->regs + STM32H7_ADC_SQR1);
>   
> -	/* Trigger detection disabled (conversion can be launched in SW) */
> -	clrbits_le32(adc->regs + STM32H7_ADC_CFGR, STM32H7_EXTEN |
> -		     STM32H7_DMNGT);
> +	/*
> +	 * Trigger detection disabled (conversion can be launched in SW)
> +	 * STM32H7_DMNGT is equivalent to STM32MP13_DMAEN & STM32MP13_DMACFG
> +	 */
> +	clrbits_le32(adc->regs + STM32H7_ADC_CFGR, STM32H7_EXTEN | STM32H7_DMNGT);
>   	adc->active_channel = channel;
>   
>   	return 0;
> @@ -206,7 +246,7 @@ static int stm32_adc_selfcalib(struct udevice *dev)
>   {
>   	struct stm32_adc *adc = dev_get_priv(dev);
>   	int ret;
> -	u32 val;
> +	u32 val, mask;
>   
>   	/*
>   	 * Select calibration mode:
> @@ -231,7 +271,10 @@ static int stm32_adc_selfcalib(struct udevice *dev)
>   	 * - Linearity calibration (needs to be done only once for single/diff)
>   	 *   will run simultaneously with offset calibration.
>   	 */
> -	setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADCALDIF | STM32H7_ADCALLIN);
> +	mask = STM32H7_ADCALDIF;
> +	if (adc->cfg->has_linearcal)
> +		mask |= STM32H7_ADCALLIN;
> +	setbits_le32(adc->regs + STM32H7_ADC_CR, mask);
>   
>   	/* Start calibration, then wait for completion */
>   	setbits_le32(adc->regs + STM32H7_ADC_CR, STM32H7_ADCAL);
> @@ -394,14 +437,28 @@ static const struct adc_ops stm32_adc_ops = {
>   };
>   
>   static const struct stm32_adc_cfg stm32h7_adc_cfg = {
> +	.regs = &stm32h7_adc_regspec,
>   	.num_bits = 16,
>   	.max_channels = STM32_ADC_CH_MAX,
> +	.has_boostmode = true,
> +	.has_linearcal = true,
> +	.has_presel = true,
>   };
>   
>   static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
> +	.regs = &stm32h7_adc_regspec,
>   	.num_bits = 16,
>   	.max_channels = STM32_ADC_CH_MAX,
>   	.has_vregready = true,
> +	.has_boostmode = true,
> +	.has_linearcal = true,
> +	.has_presel = true,
> +};
> +
> +static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
> +	.regs = &stm32mp13_adc_regspec,
> +	.num_bits = 12,
> +	.max_channels = STM32_ADC_CH_MAX - 1,
>   };
>   
>   static const struct udevice_id stm32_adc_ids[] = {
> @@ -409,6 +466,8 @@ static const struct udevice_id stm32_adc_ids[] = {
>   	  .data = (ulong)&stm32h7_adc_cfg },
>   	{ .compatible = "st,stm32mp1-adc",
>   	  .data = (ulong)&stm32mp1_adc_cfg },
> +	{ .compatible = "st,stm32mp13-adc",
> +	  .data = (ulong)&stm32mp13_adc_cfg },
>   	{}
>   };
>   


only minor  remarks


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


