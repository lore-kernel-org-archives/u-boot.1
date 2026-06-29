Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DA0C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 20:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9D484A6D;
	Mon, 29 Jun 2026 22:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CPRxYaXp";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eJ/utd8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4F584A92; Mon, 29 Jun 2026 22:19:22 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8710184A29
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 22:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TGUaTM2586245; Mon, 29 Jun 2026 15:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=O4t/dqb/7dPw8TMDf9ZcR0FOuGSgD/KdN8KUDDXyW
 ws=; b=CPRxYaXpm9HyTEZG0kgi8Ll6K2tMD3QlEPh1QblPUydknR3FaKMacpEz4
 Fiq4MNWBlhMhK6ulyg06LpKMoKpVl6biWnNMyymrlmabRb5y634HLJXIrdcyopUp
 Q8vfhMiPRgLKkUDAKrPQSwZAfn5tWYkOUihPu94ZKdAlVis5iohevVQAoYi1MSOQ
 fLjiNDEKebVJEky1uwKYZUq5fAQu6Uh2GFivm+xRXvH3c+tZFR1jQEbB1PrVMK6K
 FOaInp00XnySWHUiFGbvHzT2ERgHbh8yEDBs6paniEKZMBqK5BvKjsPQINzBk1jX
 zXaWGpC4VS2AJOSaH8yVSGmAqOHKA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f3qngveb7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 15:19:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3b8RzEiVGDaA0XV+EEs22f21z8IFSHDHhHwZtV09opv00bBJ/oRhe58dN/BpQlsvfoq3Z6uaq3RNjCyUGqcdG+tiAuzhMmmik5NYAgq5Pyin6cAJcCxmGImLkQIinveufOEMr96hCaQRXMh+bo4TZjdYiLhR9XXZCbwJ9G5VrHIREL++vEJ/QRGLotiqIf8nOZvX9oKJcnYuYiBZxMkUR0W3Faq0weGiwNOrc0HgU9D3HU0nIzs8tmT4G6VuYYRmposubvT/Gbvu5GinBmms0EGNDPM9dRWbTXc+gqu4bgnTaYGbnbIW8A7GWT904foc1lVSmNOQW7qWt2Si2D/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4t/dqb/7dPw8TMDf9ZcR0FOuGSgD/KdN8KUDDXyWws=;
 b=ZdFUO5+U+wAI/yN8rMO0/yo/OuqNKQOnhTJOJGSu/9aWtEOlpfkRd6s6WQkr0yriSCj3AWZEBfkeP4B6ip8u5pwSlLLSPfHCTk17zGfr93hx2KsVvLFCT8GxIOusI8hjJvCV7G8XkZCGcCzNcQ8eEWd/tLu/bZM9s+41hUP0rgfZAoqyCCP988amkM/1ui1ulO/f21Lvqx0GKpLXK3TM8pMsF72HCzXa9j4V60I9jmHnxfFboFdmHUvs647cpOfskrN4P4dg3pWFZKH8FHeHykJVjlRaBJ+9ssFlwAqkvYvCXIc0DKVCBOSfw/chzJMZROnbV1Ijn0uG1vVcvFRbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4t/dqb/7dPw8TMDf9ZcR0FOuGSgD/KdN8KUDDXyWws=;
 b=eJ/utd8pZdgoEwwfxThwp/S63s32hIUiZdIi9WFPaHd06CgC/NoaOspYldgCtDKK5CWbxwiRBpxthuGKbTyqvMO3T1oCW4yb3UuJoGhWYCeG4d1q+DKL9rlXhXjMuqSsV192V7r0f8No1g0aIfu7lKRyqgNAbaVr5oS6VjXwxcA=
Received: from BN0PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:143::26)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:19:02 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::aa) by BN0PR10CA0017.outlook.office365.com
 (2603:10b6:408:143::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 20:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 20:19:01 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 15:19:01 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 15:19:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 15:19:01 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65TKJ15H799312;
 Mon, 29 Jun 2026 15:19:01 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Jun 2026 15:19:01 -0500
Message-ID: <DJLT7S292PYE.380FF8KPK95CN@ti.com>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] boot: image-fdt: Restore suppression of irrelevant
 ERROR message
From: Randolph Sapp <rs@ti.com>
To: Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260627204851.1151419-1-jonas@kwiboo.se>
 <DJLPP0RNHT5S.2K7TOQJSA7VLV@ti.com>
 <1080aff7-c678-424e-9b33-a56f7b0d7be4@kwiboo.se>
 <DJLR1SYPDTS4.2ZVE5UPMD7COE@ti.com>
 <c8c24197-17ae-486f-82e9-04968a6292b6@kwiboo.se>
In-Reply-To: <c8c24197-17ae-486f-82e9-04968a6292b6@kwiboo.se>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: c810c5a8-4273-42de-d1b6-08ded61ba8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Z9J4YEa6Vy8QbefCTGpoCZB1VTtfAVy6mnGGNjjtaedmXcnRqnnRJcl1CdVnTmCkR1VXrtD1tv2q0BnaQr5ugN6U7ePufwAa1mpuXOkKVwUTFYgLtYSOOtPgcXu4Q4VgM6xPkJl0SLzv9+AUNGmaL5RDHut3FJ4ZoOHrXCFw2QS2QMirgOqCp+kG4UG+x5NhsnsrDhOySzOS2ZPVTvYrczyTDfQmMjoHn8lE6dOV4MyK0zD6Fc3DD1oxIvO6YTQ8k0lBlV3ueOaG2qoZjvmMq1slDc+cn9EQNFH23gEWVGjvUdEPmmz7vShG1cpT95AAPyanFSm0qbPtLvsdu94iwUXu0FS4Xspj8BBoB0aue2VlUCrsg/vfg6LxpcEymii/rPqW/AijbnnLzp0P+aQcu9/UuU6d0zFo8/QZlRTg7NS3tYo94p49P8zZT8N/p3OSaKmtVHkM9byaSt+7vgSN84RqJl7m+CWlNoqHTUHQ2nzIaJk38cUkC1UF/i0nXEKmfRLIOa5nr/XwnvNTYuGoYDcD7lPCyMRqZhPV7DAyZ1EcjIBCgJl5EgswfWT/wO2h3LAQ7lOAsKpUu0noNMoOCG/RFKi/y9CBN9xtU3Acbt9odXJFBMSCVXjpZptlBDqoiKLSMO+wWTwTC1u8pgpG74flXFUpPrOnCibNE6AsKKSqMO/q3x20rhRxiW/3+HJI7BbSa6gnGqz/ows2gBWtJQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kAYBbMxcHzv9lHFRIeuL7pYBlB7b7/x4PvZf3HnBbxgpgCUa569Avqad2y5RP+MhLAZ0W4aV9mSI0FiZzkWAW2vs3ZMW3O5OihMAMdw4JqbiQNBuNt/Ck79HvU3BtM5dPBKpwOduoA3UKUR6jWZCOvMZbtJb2Ro3SaIZHVDKUICVB7w0mytcJpWmFsJeuHMd12FMSDFzGKOgnQTpN1cjlMw77tG2C7y8Pc6SwztnKOdETK3orlNCZ7rasOLoVEpQPGVM3TO8lbjQ4UJIk0lnHsRAKEWSRy2LTTAwfytSFdRBm5ynAgEEuclz0LRV9qDRX7GYWJFjt02fOgsRHrh9ASvHRM9og/6YPeptmuEJGCSGluAlDYUe6ZAiMzNdkm+qRzd0RIP4i3RE8cG1/23vHuGNkcvRF8NdtRXCovXuOlXpRjjatCRLUBUh1cjlcu2A
X-Exchange-RoutingPolicyChecked: exkIMnDA/sf9LlD7XAljNh0AireIoVWeSEiWUbnw9vM9xqcvBOjhGnlxiHMA0b0uivNwdnDQ+FI6pGQHW+DBciYUhGwtp58+IJapUrglBNnRxNzGMzVI3mWad5BlHJgou8VAVlwazWtYL7tEtZEj2kQM6lvL9e2WkTHXQKwh98tK51YMVT+u3lFdXjdlOuO/Nm+zeSvznRLJY55BmLYCYpjOsoAuB4Lu1T55IabMNi75tcsJaUJC0of0JiSDdQQnRk1wTcD/iGriuFVv+s6Q1zhz83mqEXoE1bKZ6XbuQA11dfaTNSi85iwCDu8zj5HW0ztbiimDW23ghtxvwRNpLA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:19:01.9071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c810c5a8-4273-42de-d1b6-08ded61ba8f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Authority-Analysis: v=2.4 cv=Yow/gYYX c=1 sm=1 tr=0 ts=6a42d33b cx=c_pps
 a=huIvVN+S9WGU6koxVvae6w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=3fe44SFn7j6GwM8j6WMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0BN17idtlAF4g0kfrW9_Zor-zH5Yt8Ln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE3MSBTYWx0ZWRfXwKchQLd4KoIU
 XASmqRb7Zg98+173roIjCGZalroKSEXUcKQZxK7Ik2p7RAvis5QBAeuvHj48hB9dvphmERsXF4k
 Ou0ys/L8dgZlDkCAN1ntbd4rShJ/dhzVYYiFL/1QA9FUaaLkuXJKx0vpGoVOe/j571kmnOtLq6w
 c/mm5RAmw4ZkaZ7A/zT6cN4PFZVsCyhSdgGTB1t5XCiNXupmH5nGFt45ZxK9GERXpZ91yZZXmlL
 IGvn4KFukQV7tvF02Nn0oX9eX2oRD8/ALYz4OVma+zwQkUvxgbadP4Tw1/49sRAjpEtzXjc6+Fw
 fK/Pmp/M1XQUyxQC62eU2by9HvAroNJrCV3nrSlDv0HbLrwlwPFU0i30CLAh9wplJ4+s3YqUWwH
 Wzm4bwT3294fBC8O/WZQYMvZ9crJB02E2ntlj7xIo3O5yQ4Pf+qxLSPTqt0o/33rf/Wx8Ecxzih
 aP9xIkyS7dSDxbkrcIQ==
X-Proofpoint-GUID: 0BN17idtlAF4g0kfrW9_Zor-zH5Yt8Ln
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE3MSBTYWx0ZWRfX+YVQnM83OhSs
 mmtHRMttKqEg5IsN2wOLPT/WDexEkUmmbC5jSPuzu+7wynW5qGb3zObsv/uWnIGMiBza886EvtI
 weDn59LhEXqxVFEg1wqTw1Pq9/5chhE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290171
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

On Mon Jun 29, 2026 at 2:08 PM CDT, Jonas Karlman wrote:
> Hi Randolph,
>
> On 6/29/2026 8:37 PM, Randolph Sapp wrote:
>> On Mon Jun 29, 2026 at 1:14 PM CDT, Jonas Karlman wrote:
>>> Hi Randolph,
>>>
>>> On 6/29/2026 7:33 PM, Randolph Sapp wrote:
>>>> Hey, glad people are testing this.=20
>>>>
>>>> On Sat Jun 27, 2026 at 3:48 PM CDT, Jonas Karlman wrote:
>>>>> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations"=
)
>>>>> removed the suppression of ERROR messages when -EINVAL is returned du=
e
>>>>> to the memory region not being part of the LMB memory map.
>>>>>
>>>>> This causes an irrelevant ERROR message during boot, e.g.:
>>>>>
>>>>>   Model: Radxa ROCK 3B
>>>>>   [...]
>>>>>   ERROR: reserving fdt memory region failed (addr=3D10f000 size=3D100=
 flags=3D2): -22
>>>>>
>>>>> or
>>>>>
>>>>>   Model: Rockchip RK3288 Asus Tinker Board S
>>>>>   [...]
>>>>>   ERROR: reserving fdt memory region failed (addr=3Dfe000000 size=3D1=
000000 flags=3D4): -22
>>>>>
>>>>> FDT correctly contains reserved-memory for 10f000 or fe000000 and U-B=
oot
>>>>> correctly does not make these regions available in the LMB memory map=
:
>>>>>
>>>>>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: none
>>>>>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flags:=
 none
>>>>>
>>>>> or
>>>>>
>>>>>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>>>>>
>>>>> Ignore -EINVAL errors to restore suppression of this irrelevant ERROR
>>>>> message when memory region is not part of the LMB memory map.
>>>>>
>>>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> ---
>>>>>  boot/image-fdt.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>>>> index 9e0e0f93edd3..603294215b89 100644
>>>>> --- a/boot/image-fdt.c
>>>>> +++ b/boot/image-fdt.c
>>>>> @@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 si=
ze, u32 flags, bool free)
>>>>>  		debug("   %s fdt memory region: addr=3D%llx size=3D%llx flags=3D%x=
\n",
>>>>>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>>>>>  		      (unsigned long long)size, flags);
>>>>> -	} else {
>>>>> +	} else if (free || ret !=3D -EINVAL) {
>>>>
>>>> Seems like you messed up the free error reporting here.
>>>
>>> Not sure what you mean, it is only lmb_alloc_mem() that documents:
>>>
>>>   -EINVAL if the requested memory region is not part of the LMB memory =
map
>>>
>>> and seems to now help print an verbose ERROR message during normal boot=
.
>>>
>>> But maybe we should also ignore free errors?
>>>
>>>>
>>>>>  		printf("ERROR: %s fdt memory region failed (addr=3D%llx size=3D%ll=
x flags=3D%x): %ld\n",
>>>>>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>>>>>  		       (unsigned long long)size, flags, ret);
>>>>
>>>> Got a few questions about this particular case though if you don't min=
d:
>>>>
>>>> Why do you have reserved regions defined in areas that don't overlap w=
ith DDR?
>>>
>>> E.g. fe000000-ffffffff or similar region is reserved for hw regs, on
>>> boards with e.g. 4 GiB DRAM this area is typically unreachable, on a
>>> 2 GiB DRAM board there is no overlap.
>>>
>>> The 10f000 is shmem used for SCMI, so should be defined in DT.
>>>
>>>> Shouldn't those areas be unused anyway? Why don't we just explicitly i=
gnore
>>>> those reservations instead of forwarding them to an allocator that doe=
sn't care?
>>>
>>> That is what the net effect was prior to the changes in 623f6c5b6ab7
>>> ("boot: image-fdt: free old dtb reservations"). Rockchip platform
>>> dynamically declare DRAM banks excluding the unusable ranges, and the
>>> LMB allocator ignores ranges outside the declared DRAM banks.
>>=20
>> Not quite. I mean, we should ignore the region explicitly. As in, we sho=
uld
>> never even request to reserve regions outside of LMB.
>
> How would you suggest we do that?
>
> LMB memory map is internal to lmb and boot_fdt_handle_region() is the
> actual function that tries to reserve regions from FDT and would be
> where we test if a region is part of memory map or not, so why should it
> not be able to do such test based on the error code returned from the
> function is would end up calling anyway?
>
> With above analysis I am even more convinced that this error message
> probably could be downgraded to a debug message ;-)
>
> In what scenarios do you expect this error message to be useful when FDT
> contains a reserved region that is not part of LMB memory map?

What about when the FDT contains a reserved region that is part of the LMB
memory map, but failed to initialize the address pointer correctly?

My point is this error code is not specifically reserved for the case you a=
re
describing and may adopt additional functionality in the future. It already=
 has
one additional case tied to it *today*.

>>=20
>>>> Why mask a bunch of potentially valid error cases for this explicit ca=
se?
>>>
>>> That is what the code have been doing up until now, a different option
>>> could be to change the error message to a debug message? Here I just
>>> tried to do a limited revert to the old behavior.
>>>
>>> Why should we print verbose ERROR messages for something that is not
>>> always considered an error?
>>=20
>> Because under normal circumstances it should always be an error. Occasio=
nally
>> asking for a reservation you know is going to fail and assuming all fail=
ures of
>> that type are OK is a little odd.
>>=20
>>>>
>>>> Why do none of the examples listed above have a memory node in dts? I'=
ve seen
>>>> platforms that expect memory length to be defined by the bootloader, b=
ut they
>>>> normally still place a dummy node in the tree at the correct starting =
address.
>>>
>>> Rockchip platform dynamically check size of DRAM at runtime and declare
>>> DRAM banks for the usable areas. Possible a fixup adds a memory node as
>>> part of boot into OS.
>>>
>>> Regards,
>>> Jonas
>>=20
>> Ah, thanks for the information.

