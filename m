Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD947C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01579849A3;
	Mon, 29 Jun 2026 14:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IBGTtd0J";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YwOaMwC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A00F849E5; Mon, 29 Jun 2026 14:02:21 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B108497A
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TBEH521948250; Mon, 29 Jun 2026 07:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=CSbOndLkIeGIR7Hm+/4ZhhuUmfpvrhIudg+MSq8qp
 oI=; b=IBGTtd0Jk0DXkqWeLLKUBhu/xWi/dQR+LhmtE45Lz8yhrgwvTePuZP776
 fl2BkeTKTZ7LRHUU9FTrsNc7mMP3HMBnArvvP9ZzerFPz1Bo5eCtKVz5miz5Z+VS
 643PuUGrjO2/KdxjaptQoIxjkiIuUJhJnTPYP2aDOlYL5ArGBDlXrU+a7U8ZUS3A
 jNfC5uIuLsa/2C0o2AkfbkjfK8vncSx/VMdRsvGJ2lCtSsv2sNfMsuSRHEelSy1t
 KAWfkVcFtaDAtMevfLdXtsSSGfBAmAcKLtJghnxGLZa8MDq2TAeXvaX2lfnDPQOe
 IEqBM5jAo1ck8Rp+OvOpAW+/ffetA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f3qngr9nd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 07:02:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApGsFIDM+raRY8vg377v72n/19B5Ki75LCjxfzwLXiWl2z2/1uI3UBZBYpCf/Pfn/ZYaiJnuCgmeCsplNP2D3b3Hwk9Q3LV5JB2crX7wIMKVd+D9Imw7TJ+tAsWL4VEGQS8Mxs5AELZHpOLH+Z0add6etkZ5rMFbc5ygkRRgC1HeSc6A4cViSHDfp4DsFtMUSVGLlfX4X6yfIE7jErKRIfn0HpS0El/D5cM7e3/IHiy1CuFCkxStTzgd+p4aamFvcEvMlSnpuTMH6RxDPDK38Uc5mb4yawjBmmVtPjSqiPCis67xEY4QQf5GaJUxYwL2KSbuPZeYAPpo6y8+SvROzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSbOndLkIeGIR7Hm+/4ZhhuUmfpvrhIudg+MSq8qpoI=;
 b=qXRmHAuLghAqo+UkiHCsIfs1Zd+vk/Ej5KUAUZU7hi8fVUc+tWvw9Dp5fVwbCMwM8bFA6bAoSOQRTVZjLrAAA53SSp4ih1iL20S6FlepjtVrC51DBTr1sVFIurL4h1YvAR980H+qbUeWkynFHYnv8k92BD/+/Uwf4M3pbn4yEp6vYywoFDZPMv8YOXxIWD2N1e5yPTUBVJJjI//Lp75ch9Wgj1+g/duU+uoRwed/h0iL+SVWTw1Oq0R00mOefxD/PUXJ60sjrkBtqEQXGqK3DCo7Gfx8hRovBffTG94afr8K+FYKI78QG3vev+YTwXB9GRtbWCrWRabkg7iMgvpo6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSbOndLkIeGIR7Hm+/4ZhhuUmfpvrhIudg+MSq8qpoI=;
 b=YwOaMwC9FoI8LD/GsZxlTDrkj4BX3zLgCO8KMFuEfx4E/xiv5u4hw6ujSXJEadW0UToqAHCMpcu9Uvtjo8D17df35Faq8hd8dW6W1oIIJCo8wEbcxciFXzIq69EGo69SXX9wWtvAoG5ECtzxTMvcjD2hyx0u5vdCSP2Fuwzz8tA=
Received: from CH5P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::19)
 by SJ5PPF7A7588508.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7aa) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:02:11 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::81) by CH5P222CA0007.outlook.office365.com
 (2603:10b6:610:1ee::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 12:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 12:02:09 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 07:01:21 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 07:01:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 07:01:21 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65TC1JaG413945;
 Mon, 29 Jun 2026 07:01:19 -0500
Message-ID: <e05e82d4-8c70-4b84-930c-c43eaa2513f3@ti.com>
Date: Mon, 29 Jun 2026 17:31:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdt: fix phandles not copying when using templates
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
References: <20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SJ5PPF7A7588508:EE_
X-MS-Office365-Filtering-Correlation-Id: 98eb6ea5-df40-4f9d-3a6c-08ded5d63f3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: oDeQ3t5xVhgZiY9dSuFKb7ucrRvbeSYBH5FuvIKVS/784EfeK1b5Z9ESJNeNS0I8G5qapeQDz0b/kqTi/BIRnsVN/IEBIfxJN5rdN/aJ0FWuowlAfkQPC74MMZcOu7+o7dW5W/rEduyHr2Mv5sBMT71ZGGbkPZIeaex9WTIm2kKX2b4ivqZXqS0WvL+cZnerrPJbxA2Y4rR+HD+akrl9PFbTAxq/kJS34Ws1y4lrcA+e4VGvKfH+Pg7GWUOaoJEnm8UC8nCS6eZAa92Ywz1Q/r1W/n38A4952YPbk4rGJFUP66yrS4+XxQptybsJLF7cCet6N1BIJfqTcQ3vkcYynMlyDsZtKRViRfNGQykGF3Cz2dkR8y6ngFCsHfKszBExu27srrkJistYl1hBNz86X0W68L+ugH5hlloORb3/ZV3+0v7ZbEaf3Cgq5x48eIN90/g+Sym1uTjUQIUI94e7npzBql8deAQ51kZB24qdqbWw7QmlqTz9d5JoD6Zrvra3cV2miWChT2qad0pJWmJ5eaUTO0wF4UJcERXlC9Brjdu3Y+DgjImWB4RDxJeq/qmV736ABGMdryc9KlQNW7RxDgGnIcmezW0sxq8KowUklQDZ5hXKk5YPiZ/j2vLAyd9w1upg8J704iq+heQnVeeuLftS3dsIE4gw41u6PhbKQrT9eD7YFcmqtJ2lJYHrWXzHnLn1ZURkhJrJWMewepKpNw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m65MMxl/9AhENA+BWs+C/iOIvzX2S4KxaXphxYZwGUZ16AEydjqZWTbfbI+Sc4PrDkvH2R5K1Y6sGovYTyS2C760soONKgsHc79ImLM9fhnCMd8Gb7t3ZTR2H1QI3/BIV59SjT8SdbD1z+CoeZawo6jSR2HE9VbDTzTGBfYExuycnJmiA0rQnPSE2SKQsfpoSHgrzYctRm13UujJJFuWSmSMpVgcb+xFgWh8pnO7DtvBsaewiS2eRekWOurtCpitUpWqO2Pj/U17NgWY/OhQ9hZLp/DdBbJKthk2ScWHvMKIcBvgLuYUup+u0QvIQUb0qFqj02nt9UaJV5RtZYf1b1JmQwfEgnnGurzXyVKktk24D67FXBeBqd0WhsJWBpiPnRgcKnRuEIlEV4PXrdLHdZcWCz+TdYX4+mQPEBgfBD21JPP7azJsZlav1Kt9Nei9
X-Exchange-RoutingPolicyChecked: L76AvwqbPnTt3N1piJ/w8Ii7Ynu/1GoQEFTnHphFmXC+dZaQvwg5CUEhSwdYyrVQkWQQkLShYCjWur0y4htwP/73JUMXWtDnJiavKERTICyvRQaI8IAxFTZNEwmU0XUsouM3KOU+ryrjcD/OewTZL2kAI5BHSS6RB4ZIQGZqrLyJFCV4zS6xkaJkSOG5kNTzs5HqLAk5x9gsi96yzcUhw1cFHvAzoXx5pJmZYyWMbaYvQ/DKxYZOtktMBmmrosWkVP8VcHda3AyoyExvWBsu0s+GpHLRlkbArQM42NQOZRaOTzMIK9mCfn4rT8vzSfjHnZ4u+wEUZJ/sT9zhff91GQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:02:09.3011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eb6ea5-df40-4f9d-3a6c-08ded5d63f3e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7A7588508
X-Authority-Analysis: v=2.4 cv=Yow/gYYX c=1 sm=1 tr=0 ts=6a425ec5 cx=c_pps
 a=dFgZiZMTwE2p932uIRmjvg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=LwB6S4G2i6ajZqGxpmgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YPgZd0fKOnJXeBnjKCsOaaFzxvHeZY70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5OSBTYWx0ZWRfX+IFU2mYrzOXa
 dAiOiXBBNo6MeCeNDO2hswgcXmx/mPw4ivpWSHlWuHgD2KDsqEXV7g17/SJIhreViyfywzfpkdg
 FrSD9qtZnTYpa0D6EarU8rVTW3R08hio+F5sCGV30VGa0l/QGOYN0Lk6bUFtz75ZPsVlZf40TlM
 VkpTj/Cpt6ygLMvfqpJLGegom2d2ElSwH/Mr2lsS+5eIkdtGnDDB9wUHWAoNv2YfzP+H8OduMxD
 pSC5ZXIV25ReN9m/ClMcNuU3TV+LD4gal4PT9s080uWvMJDSCQvBOvlquVDJFw4cx6Twj0dfLcw
 HfPB1F6QAgeXXsoQeY7QsQy9cZIWwWKkE14yewu1LHAEsZhF2geUx1l5jbEMnGcTIc3frRmXmiN
 TYXtS3kKEB0lUWw+WCO1jqWTz1GRwgijIO6gZfA9cVDm5JzlbkhVDBsu37DlYh6/7/7tSXNB3+v
 ZFxVoDJKbV8x1qIGZoA==
X-Proofpoint-GUID: YPgZd0fKOnJXeBnjKCsOaaFzxvHeZY70
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5OSBTYWx0ZWRfXwAs+1jwoo1+U
 C9RrgSr6dl4RTn+suBAzUVMLIMz6/SJXcjNSDY9pQlLYWjsJ4Un61SA0eC7JF8qeh+71OmVHpcl
 xGQpN0/pYSnIjEt4GDBYATPgUcNS5m4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290099
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


On 29/06/26 16:19, Anshul Dalal wrote:
> The phandles used inside a template were not being copied to the node
> inserting the template, leading to a missing phandle error.
>
> The following example can be used to reproduce the issue:
>
> &binman {
>    some_template: template-0 {
>      ti-secure-rom {
>        content = <&some_data>;
>        keyfile = "some_key";
>      };
>      some_data: blob-ext {
>        optional;
>      };
>    };
>    output-bin {
>      insert-template = <&some_template>;
>    };
> };
>
> With the error 'binman: Node '/binman/output-bin/ti-secure-rom': Cannot
> find node for phandle 103' observed.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   tools/dtoc/fdt.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
> index 991a36b98796..6c3449095194 100644
> --- a/tools/dtoc/fdt.py
> +++ b/tools/dtoc/fdt.py
> @@ -780,7 +780,7 @@ class Node:
>               parent = self.GetFdt().LookupPhandle(phandle)
>               tout.debug(f'adding template {parent.path} to node {self.path}')
>               for node in parent.subnodes.__reversed__():
> -                dst = self.copy_node(node)
> +                dst = self.copy_node(node, True)
>   
>               tout.debug(f'merge props from {parent.path} to {self.path}')
>               self.merge_props(parent, False)
>
> ---
> base-commit: 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0
> change-id: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6
>
> Best regards,
> --
> Anshul Dalal <anshuld@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
