Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2348FCA0EE8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 07:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953368334F;
	Wed, 17 Sep 2025 09:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TeS98JP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B1F834E1; Wed, 17 Sep 2025 09:26:14 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 817E18334F
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 09:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=13552feb49=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H6ij9n002680;
 Wed, 17 Sep 2025 09:26:11 +0200
Received: from am0pr02cu008.outbound.protection.outlook.com
 (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxkt3bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 09:26:11 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b680/TmByhJGYqLG/yPnqkuDYxFVdTuIT8b8ZCf0hTAd6kqnrHj9rUgAftKNebTmNGI58e8amb3zrVSQ4j+PzXSnm2/F3Ecdrc13F0Yo8PZ4uISlSVAbx8tpohyHvxhK96VM1A4TDnj4k7n6jNQs1KTpGLhD2A3mCAu5lfz/tMEtIUdnqp4KGQDDkIKfFIZC03D4IJ5FqT0pMZ70eQHxXtgykaXD9KBNP9l+7vr2Ym9uOaAxjAGM419k6Rtvlu5hxcll2le0YxGhdEI5E+/OIucVXy6563/iUCQIH3oL3rCM/yysGg8SgNafBdnH3XqL3Q9yIGWeLA8BFm5ZsGzM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vj/YwQM1wnjGiLpLzW2bjn+bAici/LTaHPDifWCElZ4=;
 b=nXEGPb3ECmTj2OMpkcJJGZfpjpKoju8LPLSyMrJc4JEbBNc0mGvYmyKErZ8R1JErXQF05kXzarb9R6QnvD75tQlo3IUrC9VmUCZZXj5/a6YAnbL5Bo1gj5Wbng22vY8QiTSMJOCV6rM8EuxqOCVpCFlIKvYdIJxWSnpTjxIThkLc4J6Lv/4V8a3YrWEk3DWDtU0Qxf7AsQhkjFCyPC49Kcco1q6FFGmSlAjohhlpuM/r6ZBXgeMatbGtb+85JZRDBs/YR6N23arttTsGl9t2EOCqNKqquy83T/XGtsYEF/1ufMeYvUGJAZH4GUQtg7w+q18KMkXU4eMOa8xV1ToUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj/YwQM1wnjGiLpLzW2bjn+bAici/LTaHPDifWCElZ4=;
 b=TeS98JP+diE3XokZm8x5vpAapr06xn5tN9GpUuX9494xqI9UNv6O/jpUcfZpIl/guCDdifcHhgg5vpBQePKB9CZSxEDN9gx2ru6fG+VwKeuN/5C4C2es14Z6ujMgm7nOWmGcVi6nY8cpeO8/kqPzRzn+EslXLkOlFMxOsHVos8SuJnsMqjzdzdTlxtvp+dYcGBHRgNi8+P0rL2VXgD7ahf83KDxR41H3Bdcnbim8EiNo33ycfzkzVAwNi9Fpv6v7vqExEi85WTB5c2CHk8wWsHkNMqpQcw1p0ALbunG57fxoRQRYz0O/xUnPa2hMOC9bRrlJw1lRRP6Xs8GbIQgNCA==
Received: from DU7PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::10) by AS8PR10MB7303.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:615::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 07:26:09 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::66) by DU7PR01CA0022.outlook.office365.com
 (2603:10a6:10:50f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 07:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 07:26:09 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 09:19:04 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 09:26:08 +0200
Message-ID: <769ad782-b4a9-4089-ad14-a05bc9c41772@foss.st.com>
Date: Wed, 17 Sep 2025 09:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dwc_eth_qos: Fix support for stm32mp2 platform
To: Christophe ROULLIER <christophe.roullier@foss.st.com>, Marek Vasut
 <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Joe Hershberger <joe.hershberger@ni.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250915005331.222677-1-marek.vasut@mailbox.org>
 <7355aea1-17af-477d-84b3-9f47ccbb35ee@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <7355aea1-17af-477d-84b3-9f47ccbb35ee@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|AS8PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdbf1f4-8240-450b-b60b-08ddf5bb78e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnFDOFZweUJjVmFkNGg5Q0Y4WjB0dDdNUjJEYithZlhMa3h0RlMvMXA3N2hX?=
 =?utf-8?B?SEZuampPRXFkQ2t1K0JSZDF3RktzRzFqbDN1Si9GZ3FEckMwQkcydE1pVGF1?=
 =?utf-8?B?UllOOW5BNjhXQUdoYlEvY3JtUDc4OThubGtHWHArZzVmQ2Y4TGF0aXF6clNv?=
 =?utf-8?B?ZEd0S1lhc2kzKytUdzF6NUhKSU4xd1ExTGZpbEdMOVFhT29CMnRTTUMvU1hT?=
 =?utf-8?B?QkUwSVNmQlkxT3Ztd1lDbjMxelg4eE5CMmVjRXp0ZllrUGw2SGZQZmphRTE1?=
 =?utf-8?B?VHJBQlo3SWZGbXJtMTFrMG15L05oYVlxRWtwdHkyZFlMYmo4VHdHdkp0S2pP?=
 =?utf-8?B?MVVjbElLN1pNbTJ1Um5SaWduNk5NTW45MnIvREMvc1U2enYrSWxrUzZQZ2VF?=
 =?utf-8?B?ZXh0UHFyM0t2MkdrWW1pY3FtNUZqVTRnSjZicWdHSlVQbENDeitWWkRjUnp4?=
 =?utf-8?B?V012bDNUS280Zm0xTVNsY2hJUFozQWtCMWFybEYxQXdBNnZVV3o0Y3pXNVFJ?=
 =?utf-8?B?Yzc2WkZ3UUtUTFFZWHdFVDRRUldScWpoTlhBNy9xZDNRV200ME1hS09PZWNm?=
 =?utf-8?B?NkhINUpDR1dTYXVSRG5ILzFZbjdqeEZwM1ZwSFFaSEpFZXk0VjFURnozY1Fv?=
 =?utf-8?B?eTdZMzJKK1pCQmdhS3FOMnYya0w0R1dvUEZWRDgzTjBZSGhYV2tvdUpDTENW?=
 =?utf-8?B?QmlPbGluU3BhRk1XcEtGTDRNKy9kSU5jNmxaaktwa0pBaVZKeHROd0MyaFRI?=
 =?utf-8?B?K1lOYnpyUTZuNHIrM01GMzJTQU1NWkx6Nk5KOThTTUZRYW5oaXBHdXhiZTZk?=
 =?utf-8?B?WmVhUDJZd202dFNwK0VSTXhtUU9rRjZBM2UzQWZLaUZvRVc3dWtTRWhrREhT?=
 =?utf-8?B?VWRBcEUxMU1aTHBudmhwWE5udUZ4Z0tBSk1ITHVwL0piR3FkcWNTSHBwN2ZR?=
 =?utf-8?B?Z1BTU2F0RXJWR0pmV3NZMFZHUHR3Z3RsZDVhTDk5a283azFHY1lQc3hnZWJE?=
 =?utf-8?B?eXBUamQySVBGSFVRVktzYUZyOW9UZE95NlZqekVBa3NLN1pHRnZrN05KWlR4?=
 =?utf-8?B?UkdHYzlNRDJTMzNhT0UrcnFHdmJvSkcrMExBSlNjMW5FWHg0amlGdXYwTElt?=
 =?utf-8?B?SWNyRk5NMmNxc2dHT1dhK0FRbEpmbWFOaDdZUUpWZGlJTVNRZUQySmlndFkr?=
 =?utf-8?B?ZUYwK0J5bGFFMHAzbldTQmFXNXY2Yk5qbVg4TkthTlpySTdYR1VnWWhkTDJn?=
 =?utf-8?B?ajR1YVJFbUdMbVQ0ODJ3RXV4T2duNS9uN3pjS0NlOVVhOVcwYlZnNFJ2NWlE?=
 =?utf-8?B?V1IwclFhSjlRVG5xWlJ0ZFBkaVBYa1FoMU42M25EcVNXaFh3bTZGMThzZ1Za?=
 =?utf-8?B?YlhFNEV4WnhyRUxGenFleWdvUUt4ZzRHdk5WRjA3M0RUdUZqeHhEd0paN2tK?=
 =?utf-8?B?SWJyZnc2aytaNXZCU3RpM2JCaGJlTGlMeUZuMXVLVkNZekdmUVliekJ0aUkx?=
 =?utf-8?B?QTVnNFNOZll2NWFvSEtqRGxTTzV2U3YwN0s4YjkyY2llWU94ZTlJOHdkR0ds?=
 =?utf-8?B?UjhJUTlVWitacW9zcHRrdkZ2YmVlVk5iM0NLcS9ESFdDNlJ3WkwyY2tXV3FP?=
 =?utf-8?B?VHh3ajdBdmwrRnljblN2RVc5bVY4S0ZiR2RrQU8vV1lONzR0SFdUL0ZsWGdY?=
 =?utf-8?B?RCtsblczMTNoeTJnOFhMWlBiTXVvQ291N1BVMUxIb3RtaFhQSGpjaWlKcitN?=
 =?utf-8?B?OG5xNWMzQXk0NVVRT0JJR3NyUTg4czg5MlhmV1Z2KzZHNjZSemx0L0JSRmk4?=
 =?utf-8?B?L1h1cW80dzE1S1M1YmkybDIwRmxGeDk4azlUNzdxSHROU2R1MGZWb28wcW5K?=
 =?utf-8?B?VER6WkhPVXpTVUN0c1k1eTNXcW5hRmFDM3ZpL3phWS9sTDJOWFljbFRVZHVO?=
 =?utf-8?B?bllZQzhtY1F4VWhINmJtb1psdDZlSllSKzc2d29ZUzBsOENpR2RCb1g5aURx?=
 =?utf-8?B?a2hPZkdzSC9NV3lTcTZOVzhzemE1T1I3S2VnTGdWWUxGN1oraDNKVmNRZXpJ?=
 =?utf-8?Q?4ke8ft?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:26:09.0993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdbf1f4-8240-450b-b60b-08ddf5bb78e1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7303
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX20BjGMN7m/dr
 CeDBU9lGktDy+rCtmilT79I9T+e40OgZVqZyQJD0WHT5f9UabzBZNY0Ob4eeE5DV5E0bCL4NLWl
 prqiL1sQAeRZTEBIDrzIdpK1xrJh/TOk71mcjCc/v45ivMaujH2nPAV9UqaohB7/9rMxJRZwsuV
 NNMBauVq0uMAiO4yc22mrVKjhCRNMvXH92y5YlqDdnfYCRQhF+0LLicOD3b7EF7Gbo4TFPPXclg
 7w2QsGPbgsG/UAaMqeCjPvsr6BFAtgP9oQNFzR0rnV/I8dKoOn6G9xATz6b/1wMr3Oe2vIBTInI
 +YWjmvZqI0++oh9zodw2U6qwwxq3OxkO+S3USW++T4DEIbWuRF2c0xB7xFH0BtsrWg0dI87jWkb
 srp7m+uB
X-Authority-Analysis: v=2.4 cv=JYq8rVKV c=1 sm=1 tr=0 ts=68ca6293 cx=c_pps
 a=nL4jJU91y3sJb0QYIFFgig==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=b3CbU_ItAAAA:8
 a=8b9GpE9nAAAA:8 a=gVGD3344AAAA:8 a=pGLkceISAAAA:8 a=k-42gJp3AAAA:8
 a=phlkwaE_AAAA:8 a=UnK4DUoAdcr_t0pkvwoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Rv2g8BkzVjQTVhhssdqe:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=xQEvYfgLW3QvObN0DhJi:22 a=uCSXFHLys93vLW5PjgO_:22
 a=uKTQOUHymn4LaG7oTSIC:22
X-Proofpoint-ORIG-GUID: w5ueDor912RIMhxIY0fu9py_2msCJHYd
X-Proofpoint-GUID: w5ueDor912RIMhxIY0fu9py_2msCJHYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
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



On 9/16/25 08:53, Christophe ROULLIER wrote:
> On 9/15/25 02:53, Marek Vasut wrote:
> 
>> The layout of SYSCFG_ETHnCR on STM32MP25xx is slightly different yet again.
>> Add missing swizzling to program the correct register with the correct content.
>>
>> Fixes: 20afca89ed53 ("net: dwc_eth_qos: add support of stm32mp2 platform")
>> Signed-off-by: Marek Vasut<marek.vasut@mailbox.org>
>> ---
>> Cc: Christophe Roullier<christophe.roullier@foss.st.com>
>> Cc: Joe Hershberger<joe.hershberger@ni.com>
>> Cc: Patrice Chotard<patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay<patrick.delaunay@foss.st.com>
>> Cc: Ramon Fried<rfried.dev@gmail.com>
>> Cc: Tom Rini<trini@konsulko.com>
>> Cc:u-boot@lists.denx.de
>> Cc:uboot-stm32@st-md-mailman.stormreply.com
>> ---
>> V2: Gate off SELMII bit on both MP13 and MP2
>> ---
>>   drivers/net/dwc_eth_qos_stm32.c | 44 ++++++++++++++++++++++++++-------
>>   1 file changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
>> index 7a28f2a3e83..57ac528ebf5 100644
>> --- a/drivers/net/dwc_eth_qos_stm32.c
>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>> @@ -137,13 +137,15 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>       const bool eth_ref_clk_sel = dev_read_bool(dev, "st,eth-ref-clk-sel");
>>       /* SoC is STM32MP13xx with two ethernet MACs */
>>       const bool is_mp13 = device_is_compatible(dev, "st,stm32mp13-dwmac");
>> +    /* SoC is STM32MP25xx with two ethernet MACs */
>> +    const bool is_mp2 = device_is_compatible(dev, "st,stm32mp25-dwmac");
>>       /* Gigabit Ethernet 125MHz clock selection. */
>>       const bool eth_clk_sel = dev_read_bool(dev, "st,eth-clk-sel");
>>       /* Ethernet clock source is RCC. */
>>       const bool ext_phyclk = dev_read_bool(dev, "st,ext-phyclk");
>>       struct regmap *regmap;
>>       u32 regmap_mask;
>> -    u32 value;
>> +    u32 reg, value;
>>         regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscon");
>>       if (IS_ERR(regmap))
>> @@ -163,7 +165,7 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>            * acts as a selector between 0:GMII and 1:MII. As STM32MP13xx
>>            * supports only MII, ETH_SELMII is not present.
>>            */
>> -        if (!is_mp13)    /* Select MII mode on STM32MP15xx */
>> +        if (!is_mp13 && !is_mp2) /* Select MII mode on STM32MP15xx */
>>               value |= SYSCFG_PMCSETR_ETH_SELMII;
>>           break;
>>       case PHY_INTERFACE_MODE_GMII:    /* STM32MP15xx only */
>> @@ -213,15 +215,39 @@ static int eqos_probe_syscfg_stm32(struct udevice *dev,
>>           return -EINVAL;
>>       }
>>   -    /* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
>> -    value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
>> +    if (is_mp2) {
>> +        /*
>> +         * STM32MP25xx SYSCFG EthernetN control register
>> +         * has ETHn_CLK_SEL and ETHn_REF_CLK_SEL bits
>> +         * swapped, swizzle them back in place. Bitfield
>> +         * ETHn_SEL is shifted by 1 right, fix this up.
>> +         */
>> +        value = ((value & SYSCFG_PMCSETR_ETH_SEL_MASK) >> 1) |
>> +            ((value & SYSCFG_PMCSETR_ETH_CLK_SEL) << 1) |
>> +            ((value & SYSCFG_PMCSETR_ETH_REF_CLK_SEL) >> 1);
>> +
>> +        /*
>> +         * STM32MP25xx SYSCFG EthernetN control register
>> +         * bits always start at bit shift 0 and there is
>> +         * one register for each MAC, shift the register
>> +         * content in place.
>> +         */
>> +        value >>= ffs(SYSCFG_PMCSETR_ETH1_MASK) - 1;
>> +
>> +        reg = dev_read_u32_index_default(dev, "st,syscon", 1, 0);
>>   -    /* Update PMCCLRR (clear register) */
>> -    regmap_write(regmap, is_mp13 ?
>> -                 SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
>> -                 regmap_mask);
>> +        return regmap_write(regmap, reg, value);
>> +    } else {
>> +        /* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
>> +        value <<= ffs(regmap_mask) - ffs(SYSCFG_PMCSETR_ETH1_MASK);
>>   -    return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask, value);
>> +        /* Update PMCCLRR (clear register) */
>> +        regmap_write(regmap, is_mp13 ?
>> +                     SYSCFG_PMCCLRR_MP13 : SYSCFG_PMCCLRR_MP15,
>> +                     regmap_mask);
>> +
>> +        return regmap_update_bits(regmap, SYSCFG_PMCSETR, regmap_mask, value);
>> +    }
>>   }
>>     static int eqos_probe_resources_stm32(struct udevice *dev)
> 
> Reviewed-by: Christophe ROULLIER<christophe.roullier@foss.st.com>
> 
Applied to u-boot-stm32/master

Thanks
Patrice
