Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF8BD12D68
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C58C83F9C;
	Wed,  3 Dec 2025 15:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="EGM93FR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB3483FAC; Wed,  3 Dec 2025 15:06:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD5F783F24
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 15:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4432a62892=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3Dt3Mr1916044; Wed, 3 Dec 2025 15:06:01 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com
 (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4asrmvxw44-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 15:06:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eecNoYBzuxjoD8NshwePuMg8q2NpLvwdVoIXwNSzt6Mo/FKza8VG1yh9ZngAn9iCO6fGpshGfrrqG13zxxqDB3QfH7XItFXJfnAfpmDpPer08UDrKge2IjGnRgcelbPfMRc0ZHnaClUbw/tKnZcz7TdDdXkHchVeTdXxk1MXrMQ3loML0gYIkNAjVmrYiDFR1R//kz0cKcrurX5i7vnpEVkYfoBF34Rnlv4SiF9tLsnt8lDuK22sneXTuyoczKNNuUDupzrOZjpLaRGfAT4c7S8h/MBOau2XY0fkidy2Uxuj0gZ0niSxBCjbwfWn7VeWhKz1RnZ8l/jjqpVRFr3DFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yji/PstSVP9Nl6O7ft+wU0tqgHm6xeiWPM1fdcMWcDI=;
 b=cDCVTXeWdyPD+P1Qpyvp70fa+91Xbx42EN2N+9CIjGm6o1/Zo5SC+JyNWlkQ0Km3b/yV2GCRiTERTvwKBtSXv96C0IcciK9K7Kcsp5m/4SsFBBMRoijzdONYP43o/79gAMhy0hYqRqAjZQDYcv8lyxiOf9EjVyCT9WxPEjUkARArjbzGBBeljnE6j/Ji3Wr1U2z75qVsmEgs2vRRdTpVP/eNxRph5SxEX9XwkK4/t87S0ZGr2UZNN6GbYQ/WrOUsaf54j1QTHqS3jrmMxuSE5DFjvOZ1vh0ZehlHsS4Ru+zUEFVPtoPWfU6xSF4vriAgbF+SJ5XrCm1cMKElJPCNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yji/PstSVP9Nl6O7ft+wU0tqgHm6xeiWPM1fdcMWcDI=;
 b=EGM93FR2G+/4GidTnbmHzTGrbPpCjXmDnjALF4WL2p7j7+AbG4+0Kd7+z57ahwEb0VGW5G8GlM24Py52gkNQvxXm1tZQGIDA843EVDfjJHx1LeScxb+WAHlHznqT5IEFUuNRjTqFpU9Pe/MJYjYXCI33CsX4J8vt2zkmkdpep4nOHOSWs+pvojhsi7zQScpymD8F1UXxUk3d6ct8aFulBXJkB5OiowOP/2Lxv0VMPqYIQcGv0KIgNo01exH26ZIBOk0WS6Rkt/FvmdOGUpZx1LX1LOD4O34Ul1JV4DxsD/N2rXDazNZo0qgCYbIZDFxZjE3NoT0CnjF+NAP51kGPKA==
Received: from DU2PR04CA0337.eurprd04.prod.outlook.com (2603:10a6:10:2b4::35)
 by DU4PR10MB8542.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:566::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 14:05:58 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::85) by DU2PR04CA0337.outlook.office365.com
 (2603:10a6:10:2b4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 14:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Wed, 3 Dec 2025 14:05:57 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 15:06:34 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 15:05:56 +0100
Message-ID: <4ecb9533-1def-44bb-9401-d1cc2cb52e7e@foss.st.com>
Date: Wed, 3 Dec 2025 15:05:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] clk: scmi: Force call of scmi_clk_get_attribute()
 during probe
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>, "Vinh
 Nguyen" <vinh.nguyen.xz@renesas.com>, Casey Connolly
 <casey.connolly@linaro.org>, Kamlesh Gurudasani <kamlesh@ti.com>,
 "Leo Yu-Chi Liang" <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <ziyao@disroot.org>,
 "u-boot@dh-electronics.com" <u-boot@dh-electronics.com>
References: <20251114154259.4035206-1-patrice.chotard@foss.st.com>
 <20251114154259.4035206-3-patrice.chotard@foss.st.com>
 <4a71038b-ce5b-4119-9493-4e33642a8528@mailbox.org>
 <71047e69-164e-4c65-9eb7-587de4f147ff@foss.st.com>
 <d90e6eca-2b3d-4274-8738-b2eb49f1e722@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <d90e6eca-2b3d-4274-8738-b2eb49f1e722@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|DU4PR10MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: e885c725-aabc-462c-2e29-08de3275152c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T24zT0puRFVub1NhWFg5STJQeUpsanpuTTFJZGFReWgxY0VnV1Y4elVzZ1NM?=
 =?utf-8?B?REpXTXZwNk1BRmREVzYvNWkvanNpeUZEMStxVDZDcHA3cHRCek93V0pvMzFW?=
 =?utf-8?B?cXpLNDV6WWdyajFxL0dnUHR0Q2Z5cklaQkZwcTBnMEVxTXF1TU1LbnZwYXdh?=
 =?utf-8?B?clAxeGhMZENyMWNMamUxWXYwNmpZMXN2WFNTbXEvL2paNDA4WEo5YlRyR012?=
 =?utf-8?B?L1NNaE9VNVMzcDlEUEQrN2pzZUt2WFNkeGdTTTdhQnlyUE9YckdZSG9CazFl?=
 =?utf-8?B?S1kvSnZSZlljcyt4VHJGODZHdzNhaDNrditmd0NhVVJNc05FMzZnd092cVU4?=
 =?utf-8?B?V296RlRYUmdyN1ZCTjhZaE1Jamx3eWNnVEg1bkpFSTNuUDZzRzVzWTVSeDA2?=
 =?utf-8?B?TURQbVNXQjFpQzV5SndKajIzaVZvdnVzMzV0MFhzbHFBU1FBK2xpMDN2eW5j?=
 =?utf-8?B?emRCMEFyK1lWM1ZYVHVIb2FmK01vRFZWdDM5aUtzcmg4MWVkQ0FHWUNCQTRr?=
 =?utf-8?B?NEV3L1BzT2NNRnRNaHMrQ0tOYm5qWjhkaEljTDk3RDdqWFlDT3ZCWGtWV1BV?=
 =?utf-8?B?ZzRzNmRYSjQ5dkV4TFRjRnJ6a3YzVFdwa3J1aS9yalEyejRoSW1OK1lqbCsw?=
 =?utf-8?B?cit4RS9EOFlaOVg2TUZyeWRtMCtaWW1YbnkyRUxTTDIzVGlCV2dmS0xrSE9V?=
 =?utf-8?B?dnhuUEZjc0s1YlB3Qm4xT2M3V2w4aDJSUjZWSmd5QzJhRkZEK1pDWVR6UUJE?=
 =?utf-8?B?MzViRnZuQjkxSE96c3lhcFgrSlNnWEFndWtKVlh2aGJuSDBYUWtPemlhUnhI?=
 =?utf-8?B?Y3lRdlMyQi9ZMEh3dUtVZWxvd2d0amEweG9wa29MbXdUcis2NmplTklZMnJH?=
 =?utf-8?B?dksySHFtNVhPMGZteUt3V09XWDRhRVJFa0hqMWRPSUtza2VrWE5LS1pyeHA0?=
 =?utf-8?B?Ti82TXpreEJZUHo5MkdvYTR6b2ZhMVcxRWZPMjU1QmRWbDZxV1dVcWxjRGhD?=
 =?utf-8?B?c1dmdi9JSWtZTnNYZDJQZVhsZGZ0WlRyRmtnQTlEbDJOMmNna3ZSMlcyKzgv?=
 =?utf-8?B?S1BFZWNPWkVQVWRuQmF6VTVCMWhzS0RuTW1EQzdlSkE5Q0QxNXlmZzFURWhB?=
 =?utf-8?B?WXRVa1dYM3dkYytveUtOQzQzMWtXdElNNFUySmkxcDRSZ2NZcG1JbnFLRW83?=
 =?utf-8?B?SUs0MzBVMHY2YnltZWtMU1lLNkF3QXQvL3pKcENHTWF5OWN6dXFJZENpYnk0?=
 =?utf-8?B?SVpiYmNiVGwwNmpGK211bDZTeEl3bTVYWm1WWCtsV2hUWDRDM2F6TU5MNXhS?=
 =?utf-8?B?TVNYekY3V0t1OFdnaDVvZUYwcEprckxuVHoyWjQ1RHpsL2UzRHEvUmYwUndS?=
 =?utf-8?B?VHJLbmtnVEo3eXl4bjJveTFTb0tsRlRtS1VhL3BRdGpuL1NodXJwK0RsOU93?=
 =?utf-8?B?Mmg2TWJzWHRJcFlsT1NHd2QxK0RSMURMUFRrazVFd2J3Yndjck9TaE4vOVUr?=
 =?utf-8?B?WHdZTjhqaWtaQlJqaXIzbnM1T0dSemYzYXdVb0hNdDA0Q2Erais3UXY2OWdL?=
 =?utf-8?B?eTlaRHphOW1ncVgyN2lvQzJFOXBIRFF6cDUxblJSS2lydUhtUkZlc3dKd0RP?=
 =?utf-8?B?aWh1RS9reTVqYno5QzVncEdQZnZiQzd2K2lhZ2FHOGo0UVRZUXpMNU84ZDhU?=
 =?utf-8?B?ZFQ4bGRRQUVDZHBMWXN5M3Z6Qk9KYXVDY3BaSVMrRlcrZTJuMkNBbnZRSjBv?=
 =?utf-8?B?bnJXQVJRZ2IxQ3pvNzBtRG43aHVLL3FheTVBci9xZ0srWWdJY2lRbDZkbDlP?=
 =?utf-8?B?QjV3OGhXK0N1a21ObVVXWXNKTDFsU3JTNE9xZnMxbERMa3dtNXpYME9OY2Yw?=
 =?utf-8?B?amZ4TC9LUWRGWkhMeThZMGorV2p5d3B5R0F3WVBXa0MvaVpJNk5TUVE1N0hK?=
 =?utf-8?B?dXF5Nk1qa2ZkTFQrS1lOZG0zRWx2RjlrcUFndTBpT3dVNkYxb1RkTURYQ1du?=
 =?utf-8?B?NWc0eHRaalBmRlkrSWt6bGIwRlhVeTNtdldQMWhXQXVHcFZmOC9qQkxWNm5S?=
 =?utf-8?B?dzNPN3pGMHRmSTJhbXdDMFlwVjdkblFIK0NjZ3F5V2dwb1E4Sm9qMlJvTWdo?=
 =?utf-8?Q?KpYY=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:05:57.9797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e885c725-aabc-462c-2e29-08de3275152c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8542
X-Authority-Analysis: v=2.4 cv=e8YLiKp/ c=1 sm=1 tr=0 ts=693043c9 cx=c_pps
 a=QwrbhXh03MhuZ2mRWfjA2w==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wZF5xgHrhGkYw9plCIAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0OlS7QaojibFqLQ1vxM5tng_dJr_XiYq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDExMiBTYWx0ZWRfX8Fb1XHFq+EcB
 ox4dQt7zhMoLrjWvLnqO4keH3CmTfsB59jeWT5xv0Bh1uSJWffE468KWd6oawMSs5IHmhv4vLNd
 CqTrb/CNcePXl/DtxOBMT1dPcEcXCuueNv9+fPDFPSRofEwX54VOUpYbmWTXs8qk4dXTeIAvjtf
 W92fl1xRWL2xbt5FT0utA+VAjo/u/n2qSFhn7WKouQPkYBnp8K461LxceYEFIzCalh6yGcWhLbV
 PQcGVFIhWna+s0KG5DfrXdtxcZwQKWv/Tgv4exFvzJNQERsXdjctIW9Cz29rRtWdT+jdySUQ47G
 7ynhyV0/i7A+cI4Yj/NDrb5tT8qDWR/Q9YRJkaENCgTM5oEjYt6ua3uA5R1gN5SRtYBH/mCVl8X
 66qH7eeiEumEtOjDQ58tY/20FrzmkA==
X-Proofpoint-GUID: 0OlS7QaojibFqLQ1vxM5tng_dJr_XiYq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030112
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



On 11/20/25 21:38, Marek Vasut wrote:
> On 11/17/25 5:36 PM, Patrice CHOTARD wrote:
> 
> Hello Patrice,
> 
>> On 11/15/25 00:08, Marek Vasut wrote:
>>> On 11/14/25 4:41 PM, Patrice Chotard wrote:
>>>> Since commit fdb1bffe2827 ("clk: scmi: Postpone clock name resolution"),
>>>> all clocks which are parent clocks are name "scmi-%zu" which
>>>> leads to error during their children clocks registration.
>>>>
>>>> In order to not cancel boot time optimization done in
>>>> commit 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
>>>> choice has been done to re-introduce scmi_clk_get_attribute() call
>>>> during scmi_clk_probe() under new CLK_SCMI_FORCE_ATTRIBUTE flag.
>>>>
>>>> This restores boot on stm32mp13 and stm32mp2 family boards.
>>>>
>>>> Fixes: fdb1bffe2827 ("clk: scmi: Postpone clock name resolution")
>>> SCMI spec says that clock IDs have to be monotonic and incrementing, without gaps . This driver registers all SCMI clock for you exactly this way. What exactly is the problem on STM32 ? Are you maybe missing some reparenting somewhere else ? Maybe the clock parent resolution should happen when the clock are first used, just like attributes are now resolved when the clock are first used ?
>>
>> Hi Marek
>>
>> Initially, on STM32 we first registered SCMI clocks with their real names and then we registered all RCC clocks
>> in stm32_rcc_init(). For most of these latter clocks, their parent are SCMI clocks.
>>
>> After commit fdb1bffe2827 ("clk: scmi: Postpone clock name resolution"), the name of these SCMI "parent" clocks
>> becames "scmi-%zu" which makes clk_register() failed as we still try to register RCC clocks using their parent's "real names".
>>
>> For example: for STM32MP13, clock "ck_hse" becames "scmi-0", so all clocks which are "ck_hse"'s child can't be registered.
> 
> I don't think any clock driver can depend on SCMI clock shortnames for clock look up, because the SCMI clock shortnames are an optional hint.
> 
> Instead, if some clock registered in this RCC driver have SCMI parent clock, those SCMI parent clock have to be referred to by SCMI clock udevice and matching clock identifier (in this case, I assume that would be SCMI clock ID).
> 
> The relationship between this RCC clock and SCMI parent clock can likely be described in DT using 'clocks = <&scmi_clk N>' , which you already have in stm32mp131.dtsi:
> 
>  788                         clock-names = "hse", "hsi", "csi", "lse", "lsi";
>  789                         clocks = <&scmi_clk CK_SCMI_HSE>,
>  790                                  <&scmi_clk CK_SCMI_HSI>,
>  791                                  <&scmi_clk CK_SCMI_CSI>,
>  792                                  <&scmi_clk CK_SCMI_LSE>,
>  793                                  <&scmi_clk CK_SCMI_LSI>;
> 
> Can you use that for the parent lookup and simply ignore the shortnames?

Hi Marek

I reworked drivers/clk/clk-stm32-core.c, clk-stm32mp13.c and clk-stm32mp25.c and found 
one additional issue in drivers/clk/clk_scmi.c.

The serie will be soon submitted on mailing list.

Thanks
Patrice


