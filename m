Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB181CE8D5C
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B2C83EE8;
	Fri, 14 Nov 2025 17:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="DEvUoBlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF93684198; Fri, 14 Nov 2025 17:55:08 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B83808AF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEFmtl42638289; Fri, 14 Nov 2025 17:55:01 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com
 (mail-westeuropeazon11010071.outbound.protection.outlook.com [52.101.69.71])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7m3unu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:55:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWSvD+582BCSzypWgtB10vTOz6ZOjNhPQR9uK9wZ3ZuVOqYpI36dFUQDSh8scBByWofBKq8wHu1KJPJXVfsYwduJTnRNnHvQyVds2BCjKr91Gg87cSROmNhef7beTlBAe2Qbb1jG2b5hQXaBiiy7MFecory3rt4s30PmbZk1zletQoRAjd9HMa2SMVFC8/4r6nABZiXMZmZdCaSyRDko9pAemQ85juuj9LsZta9aSBPRaQlpeB/oN88ynPATQBJn22EFAgUqmK1laAfd2j8Kl7UYBDD5K9zkqZU2u5pCkJRVYZZepQUZ8Co9YamFMcKlNFaZ1cAGWzH3B0FQJJSRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKo1Yl/dI1aUPe2IyNoTzq8I05D566yP/0fsO6Qmakw=;
 b=aoNJGXEzjmPuGSVY7/OtvfeZr2paD6aTOLAtQexvodXKua7l6M7kaZSRQ/9nBOzbzbGckCOIVovMGVbLIdGJrAgDc2FRHl7PrDG151Z7ILpFmZwYvFT7s5nUsgRer45plvHYz/BXtjSSG4xzFttAGunGskivN2Eu7Vs6LuTrS9x5EGizpsV8v0gcIjCqrhB04BmI+qDsJBT+1AK/N3Fw0LGXYb25NJjZei5Mn/ob8zDmcNaOQr+VDgnrliRLWvXeASIbbLL5k5Fz/r/aPfk1qAwqilp5dMmeFfr0FiFpzUy4/AMG2X7k4PXxJKIUHXuNjAH+y4z+2ImeV/UpdRDvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKo1Yl/dI1aUPe2IyNoTzq8I05D566yP/0fsO6Qmakw=;
 b=DEvUoBlt5Jmj/6DJTbrRnMbedpxJfg+DTP4UkLHX6opy+OeX+q7+llY541WjuYv1OKEzygiK0dkl7WtyzodBS6fgg4A8J3ZQTzmDtnytzOb7I6/6EDLAmEOXS8Qcf3QBTKlHmI/PqTX6EKkJdkgxbyKkVRKZxMro1mjlIqKug5YelPFOEuJoXk8C+8lEve9WuRd1/SzqNeJ+RlQWKeiqF0wAp0iv6rHSCnlC1wm1JP6e7xAerOBvYe89tAnKRX1QN0n/AbwnvD7XEOQAkEIavV8nY0wtJQi7HoU5GgPb7flVhRHdYv5Tg7u5Pu6xlJcqrNV+rYxNyeUIiO2OY6rwqw==
Received: from DU2PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:10:232::15)
 by AM0PR10MB3508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 14 Nov
 2025 16:54:59 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::d3) by DU2PR04CA0070.outlook.office365.com
 (2603:10a6:10:232::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 16:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:54:58 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:55:10 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:54:57 +0100
Message-ID: <b7c77a8d-0fd2-4de0-97ea-a4f1dbdb80f2@foss.st.com>
Date: Fri, 14 Nov 2025 17:54:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ARM: dts: stm32: use LTDC and LVDS nodes before
 relocation in stm32mp25-u-boot
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Yannick FERTRE <yannick.fertre@foss.st.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-6-b42847884974@foss.st.com>
 <7b886fcf-3f2a-48a3-b496-3793d381b6ef@foss.st.com>
 <4f85a946-bb6e-4f4b-afa1-f22054cdc1b0@foss.st.com>
Content-Language: en-US
In-Reply-To: <4f85a946-bb6e-4f4b-afa1-f22054cdc1b0@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AM0PR10MB3508:EE_
X-MS-Office365-Filtering-Correlation-Id: 3986c2ea-8c74-4c58-8090-08de239e8bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1Q1b282YXNkWXQ4Sk9Za1FqYVhTb2w2cE5jRXNoY2lFblc0S3lQSTd6OG5E?=
 =?utf-8?B?Qms2Sm9XdmxzOUVVSTVQcmlGVXpHMTA4djE4MDFadkRuUUtWQmtFMHQxMXo3?=
 =?utf-8?B?dlA5OU8yaG1GSUp5Q0x2OE5uUXplTHFEZUU1YlYvUkpzTVRnNzBEbDZIMSs3?=
 =?utf-8?B?aFdTTlJ3UThBN1V3NGlJc3RObUZrdTd1azErS1ZKeFBHd3VKRU0wL2Roam5V?=
 =?utf-8?B?M29nRXFReU5kajRmcE5NWU1zSWhHZERqcUpGUXcxS2RuaUM5SUl6Z3c4U0pw?=
 =?utf-8?B?d0E2U2ttSWxybngybTk1L2Y0ZUpsNy9mb0k3RTZXK0xocTVMa09EYUxUcjJt?=
 =?utf-8?B?M0c5QVRzY3YvRHB1bUwxeDBEckZzYVh2bWdyVlVocFFPY2phYlQxdEk3cXBy?=
 =?utf-8?B?dktPTzZQZGdrZDJLK1JROUxsckpCdVo0TU1GclB1Vkk0NUgwNkVuQTE4c1ZD?=
 =?utf-8?B?ckJIZEt5SnhWS0EzdWs1VmZCQ1FrTWxEaHBrbDhKdk4rVFRqWlh0MFVqZDg2?=
 =?utf-8?B?ZVdaMzZZV0NNcjlKK0NtWGpYR1FvV2FLVlhtbU0reHJQSUNPbHVXd3lHbGZo?=
 =?utf-8?B?L1Z5WE04ZzhNSjZsS1c3aU5XbmF0cGN5NWU5aW9GVTM1ajBZbjBaeDFkSXJk?=
 =?utf-8?B?L3MzOWtQVUhsT1hzS0lYclg4bHRJMTd0bUhyOEtwR0ZOL2pRcFNXVzN1cTBw?=
 =?utf-8?B?azU2bmdqWEgvUXJXMmJiVloxenZTdXFmSEovdUlnN0RkN2tJQXE3dUZ1U3A5?=
 =?utf-8?B?ZGZuNDBuS0wzSkZUb1VkeGtmNTZXcmhMMndYcGR6QmN6SWh0MWN0VXZmRjVV?=
 =?utf-8?B?UXpFdXFJbWIwRWZvaG5wUExTUFpzam5XcFdJd0RjeHU5WlJ3T04zT0pLNVdH?=
 =?utf-8?B?VnQzU2ZjNDZLQ3YwQVIrYXpWNDhoS0pDQ2wxVXV4NXdGS2JnNVdDN2hodnU2?=
 =?utf-8?B?NGRiQmhoSFpBb2RTVmpObkd2d1Q0aEh2UVB3LzdtZFhUSlVsZFk1THpIWStF?=
 =?utf-8?B?MCtNaW1USjBpRnlEQTZ1alY4Y0Ftc2lXRFh3VGF3OFlmWlVpdFJkYkpabWNp?=
 =?utf-8?B?MnRMMmRkZEpuNVI5U25CZ00vYkh6aUswUjdrcnkwZlBBM3RKVFJnSjkyZE5t?=
 =?utf-8?B?d3JxekIwRnExci9KYlNvVjV2d0xFUHZkZ3dJY2h6bXBJemFDaHQwekY2anhv?=
 =?utf-8?B?cnNFNmhqVzdPbERSeTdlMFR5UHBmZHdFQkp0R2E4Z0k2dy9la0NEaGY0cWFI?=
 =?utf-8?B?NUk0N2U5bkljMWIzZ2lzejhMV0lkZkM0NzVZMTlsRTMrenNtK1NVMk10VHV1?=
 =?utf-8?B?SUtwTjdFcUY2RWRQVGp3SGdqUUo0MUZqTURvQkpMK0w3RzE5NDQxYmZSRytT?=
 =?utf-8?B?TWNIdW9kbVAzYWRDeTB3aXpHTUNsUmcxb0czeEpLSFNHbWN4UUgzcEF0bHF3?=
 =?utf-8?B?S3FwVnUvZEp0Ni94T0ZUdzJxSHVnbWJxODY5UjUrYXB4dXliNjI4cE50UnZw?=
 =?utf-8?B?aElMYWorZUVxREZCZUpwQjIwZWdPNkY3NzhvQWxwZXE2dzNRQnRESWk1WUEx?=
 =?utf-8?B?VmpCOEVuQU9aMlNkVVVaaDh4UDJ2Y3pqL3psYUtKR0U0aWJ5NWs5SVBQWUN3?=
 =?utf-8?B?ajN5QVNGeEh1M2FndUNaRitpSEgzM2RhSGlvNlpQMFVPVXlmMFI2eDlMOFRk?=
 =?utf-8?B?QWRSZjhiNWxmZllvVDRQTUpoeWZFS3I0QnhDdHgzd092dTlaaFgvVmtmY28w?=
 =?utf-8?B?WjdvRHRUYTh5dnAwdkdIUkIrM1ZuN0NTU3ZBQ1cwVXEvMU5Ec1Z2SWZCdHRo?=
 =?utf-8?B?OWpYZ01WcTdnNUhYSVk5eW0zVjMyaER2Uy9tSG5qdVZFNEFkY01RaUJsUmZ4?=
 =?utf-8?B?V3FqMmhUdHpNSkQxeWlmSzhRR28vRkdJeis4L0ZlZTMrL0hKQ0d0bVNWaGZ4?=
 =?utf-8?B?RFM4emU4eUVQUEFxcHFRR29CVlpjeTZ2bEtUcElEQnBuOTY2NW82UnpsT1hI?=
 =?utf-8?B?MGlNRWJ5Vis3QzdDaE1QMGVwQUhuVC81dHFlOXlKRDVlajEzMXB6aVEzZkRD?=
 =?utf-8?B?THBySzlnY3IvdW5pQnJ1K1d1Y3V3SHlJVzdmRUN3NnNxVWFrRm84RkdGWXF4?=
 =?utf-8?Q?TopOd0oNwXVL2/uQ0fvlcfNa1?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:54:58.8043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3986c2ea-8c74-4c58-8090-08de239e8bb9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3508
X-Authority-Analysis: v=2.4 cv=AZK83nXG c=1 sm=1 tr=0 ts=69175ee5 cx=c_pps
 a=rpDra4TIJV0i4HlMjvoxBg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8gWurrt5doJ8cydnsj8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Kbn5YvGbiytrl5ur-6GNjWE12Dm3b755
X-Proofpoint-GUID: Kbn5YvGbiytrl5ur-6GNjWE12Dm3b755
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzNiBTYWx0ZWRfX33nXrqz5CNFz
 zQLA2+gKGSr2Pm3M+BWGVClWueaTq7+9CVj0qfQ2L8ykgdYmg6l3bk6Nzok6JEVJyp3X3zXEYNa
 zJ0NoMd8WEi2sRpMT9AKw0B2T4uZ4CWeyhXSDHCYuEnJ07EP/xKNwl8XfTmKMLQiCe5vsoaUeIm
 gOOFVXj46u31SfYe6vxik1GAvgqpq1VXwLGFYm2TJ01484SQsTdLeAbV4oihrCKzDriiYmDCP06
 3B3c34GPPIyTJbVVEe+SGqqXAPdmVFdbkyrod1xBh6x6A6DZ6xzXAUi6WXmRuMpGBd0YfCxQi41
 Tq4df5VeO8lCeXBZkz9d+47iCXnCDgMWY4eWQbu96zsDYpPZknXkN/WljGkfAkGpYH+LMChKrS7
 qHwV1idtYORft4M7WUedc/MsseP3YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140136
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



On 11/14/25 17:49, Patrice CHOTARD wrote:
> 
> 
> On 10/30/25 08:43, Yannick FERTRE wrote:
>> Hi Raphael,
>>
>> Thanks for the patch.
>>
>> Acked-by: Yannick Fertre<yannick.fertre@foss.st.com>
>>
>> Le 04/09/2025 à 14:53, Raphael Gallais-Pou a écrit :
>>> Use LTDC and LVDS nodes in all boot phases.  This is specially useful
>>> before U-Boot relocation.
>>>
>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
>>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>>> ---
>>>   arch/arm/dts/stm32mp25-u-boot.dtsi | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/stm32mp25-u-boot.dtsi b/arch/arm/dts/stm32mp25-u-boot.dtsi
>>> index d9aeeb6d510df9dea9700148cf8a8ad5efcfd4f9..3ac35c4a6bc27c72eeeb532742fd4412b7aa1b85 100644
>>> --- a/arch/arm/dts/stm32mp25-u-boot.dtsi
>>> +++ b/arch/arm/dts/stm32mp25-u-boot.dtsi
>>> @@ -93,6 +93,14 @@
>>>       bootph-all;
>>>   };
>>>   +&ltdc {
>>> +    bootph-all;
>>> +};
>>> +
>>> +&lvds {
>>> +    bootph-all;
>>> +};
>>> +
>>>   &pinctrl {
>>>       bootph-all;
>>>   };
>>>
> Applied to u-boot-stm32/master
> 
> Thanks
> Patrice

This patch will be dropped and submitted in kernel DT side instead.

Thanks
Patrice

