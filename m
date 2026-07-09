Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349F7C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 14:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B015D84A8F;
	Thu,  9 Jul 2026 16:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LinBS9A2";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xGnErYDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00B784ADD; Thu,  9 Jul 2026 16:40:26 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3481884A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 669DteHI189992;
 Thu, 9 Jul 2026 09:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=saqaHcd3ipqM5B63AzzgbpBbga1Y100tqqbuJvsoU
 do=; b=LinBS9A2smxmRTSMC1tD/CQnSQToGtGGsBwTPqhVhjt8b84YW883LU3AZ
 tCq7PKGDPqnih12u9mR/1eIqu884OTzBUNwJN1tBZ4+fOL6LVDQGRHzjkeZj+wju
 LMJztumxMKKZYU6DvF8NVZLYtdbgo4AA3CV7rLet4Yvs+v35tDZZThdgHrMgdQPC
 ZdtVqf0VFz9ANHQPSW6/5qUh48iMI73FkPqSX4CEhQm6oaLHUAldWo11SdnDWNDE
 1W4B7X43sYYTnsj4CmtD5mqCSMYl95lAXrYvz39YFGK1fsaX4sqnxf5QtvE6gOF0
 RPQenkrPmvWz6w5HnWyD3XsENNcCw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f9nft9jd0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 09:40:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/Y+X5WHDRAl+BJLAXVom9lA3Be3VEA8BVOghy8eOPz2/YDo7uagq6WPlkmgi4DSQvL7dEk21MthOqnnhwsFxWJxSzu2sn4IM4GKeHTy8jIqQSlGP/fxrZT1ruDFU0XgOYrAdlFd7QnqhAnmvmXM6uxjr7cVc5DP7I69HLRjXJ0ocBTs6F9lyZQgbhRZ76pbjlea4XecmTA2HTZ29Y/7pS3GMasw6kywfXZe+mcxnCzhOrS0AAQcBA8uFj14dZ/SULbmhargLNGYKTXjxzugMnOdnwirY20ssnSGKtbUyh60WpYerU3wU7PX8OALYfQD4KDRHA/+GK15kR9qhZNLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saqaHcd3ipqM5B63AzzgbpBbga1Y100tqqbuJvsoUdo=;
 b=JbymnkYfxTG8wPDIS20hiDDNZVYzc/ypVIafWq79kbqgSIo0sWBG/XoHp6JMHByzZwO1y2DSJXgVUfK8deAcAMwTJddFhKwUknU9eTOveUzid/2V4FGujF7jsQ/sXyie+vYNqxW6xSeTzUbKFpIJ8RPXGBF1fWHEQQCEeHDdrwDRDtd+ePZfm/wGGW6EinPPHiQJ0tKHxpOTGH/Q12bDXmXwoEaLsL08E8IQQRkN/zXQgT3A7JC+VIdJSc7iDBOnpOpC6H/ZvHO4bcPzzaV4/qCDq9vht60lOXnTHgLa0GQBrQBsY71zgp0Bf+0yXuRJSkWaQb86R2Oq9TmZ4XVQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saqaHcd3ipqM5B63AzzgbpBbga1Y100tqqbuJvsoUdo=;
 b=xGnErYDqbLhnsxTJOh2y9lpEXnLr/HEbu/8hgIsvK7ntv+gV3lAk/z6VPM9aIqXgi6Lsx3WcMZ6YK5AlcxZCTigWZnOZqeVCNRVRyl77eAgcAQRyBvHda8GBbJBGJg1r5DJ4MGvgO5idLoGJU462U/uYFNCzzm239ggXbzu/cjE=
Received: from BN0PR07CA0008.namprd07.prod.outlook.com (2603:10b6:408:141::35)
 by CO1PR10MB4514.namprd10.prod.outlook.com (2603:10b6:303:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 14:40:16 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::4e) by BN0PR07CA0008.outlook.office365.com
 (2603:10b6:408:141::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 14:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:40:16 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 09:40:14 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 09:40:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 9 Jul 2026 09:40:14 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 669EeEHf1473221;
 Thu, 9 Jul 2026 09:40:14 -0500
Message-ID: <f9ad959b-ea6f-4265-b1aa-1fc1ffd30cee@ti.com>
Date: Thu, 9 Jul 2026 09:40:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: am62ax_evm_a53_ethboot: Enable config
 options required to enable Ethernet boot
To: Chintan Vankar <c-vankar@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>
References: <20260702081251.2691159-1-c-vankar@ti.com>
 <20260702081251.2691159-3-c-vankar@ti.com>
 <1c0c513f-a8ce-4ddd-9af4-b79cdd31b89b@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <1c0c513f-a8ce-4ddd-9af4-b79cdd31b89b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|CO1PR10MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e9526c-0889-4485-b0d3-08deddc7fde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: wFw7kYRsexSF4LGJOvcOnCWuzhIKS6jtTVqDtgiimnDrJtyV8gPnscTS7/3caxNvLCa/sP6ErxVztS7QCbeRrAxLOQ5LcVLhnVqn2MSs8OVbyuPlhOj7P7vhuPdl7tJSgfX82UtY7E26W3/epciqTY4JkygCqtSoL9smA2QDlH3pwtJwX+VWQv/g6U06fXoj6dIdTuVatSW+ibuvY7VPWfl+UqD6yikLUW7UZp5AsjC+Yk58w2ch5Q9YLJiR+g7VCvrROGeLNnYsKmegbBsFSZFDT+aW6B7GVuXlYlGc0qAj+dMaWcndV56KMaLRhN8DcfO59eMADt/2TwaBcWgQqwFAZ7LNhPVcQe3QfOIx22rLm0Eo+2uFYgEsHL0Ey1PH91fGKV+nQC+GFzlaTOq/UyLJcpqXV+EcvdG13y2WCnEt8rHTUkFyXm7aNtw070zRPGxKzFu74Tbk+HOzPhR3jRXxBUp4bZiyW7QxiSJ5gHqJwfugs/KcxNItp5k2Sf6XwAoj1+7fLGdbDYRHDm+GcTBboKTYKrVKgI4M82Omy2wGjCowQssigvgUFxOSIsRZw1ps7q/YeUvlnMFTC6Oe4vN9C3pI8Lb6i0sUidyEYdGGdbiii10CWnfodG+aOuSuGqjL6eQYO4adwyt5jbHRYIakEksUzPp98t8j2tPPFZ9+XX35kbvA3yAuvCGmfyja
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8BLCnWI76S/2AwU3ufeDc5SIO4zH56zOrU1UNyeu8ZRdho21B5IH51D5Ej6u02LAJK3Rja3zSluOGCJXcctz+4PFQ3T8CcMlJuPBIHa7Sas0NcM1daVsBv1ajDWqhVElLGzbEXEbGKfc1LWx0H4DSZqj0HHEc0P846px7IApMvcfG/zDVXfs0uobTrjfpkiljcoIgCoeZ/mC+jseDNeVv+12GNNyXZvbK3eEKKRLLO34K7pfvlwD3ettx+3KqUUOW+aYsi0e28kUFD7O6qZdDzjwpmy9a1kg+oc0YTmNao/Ag6188y6gaSpp3F95ZfORDI8EExiEvft5w/Q773SeyDKdV8aU4tUw3SHPcgh97ISK57qIJKgMhLoeylZc9vDX7O0Wd1+0mz7tbEOp3Rd5ssdMQXe225CFiPLuK0mUbWdH7LP3yOY8vlok85LtquY6
X-Exchange-RoutingPolicyChecked: gWFJDSpgBF3Vd39RfvEtCwkHF6AADWCZm0NLrxmuvaNjjxXp8aSKk5Qxp5kCj+R6i0cYZFrJ/pb6o1LehmZLZyEhWb/SWo80YOfXJf0IsuvgdYAP87fMlwqCp610S68L/KaTR/0s4lngjVZvTQxVTU3HIXrZFBP4bBb+PBul+UyGeyqrkWWq9kBvOIhmtX84jEArZIhVWMzxKVRu5ev+IJtJBHOQT48iufjjIgarX7SqO+/Hl/h/26XC5XPdle0qFFie3r83w0AsuenFThInWI9W+OV89QmaCnoRGUWdXRdIoQeKvaS9qpriK4/7V+jhDUV0zJGKbDVhBxNwVq9cZg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:40:16.0160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e9526c-0889-4485-b0d3-08deddc7fde8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4514
X-Authority-Analysis: v=2.4 cv=AaOB2XXG c=1 sm=1 tr=0 ts=6a4fb2d4 cx=c_pps
 a=w8e6fJRD9yN2bKWo9pBaJQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=FWg_4I0tFtDwJXBqr1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NQQgUiorJHXbJpeRr8LPts5w7oI_OqUN
X-Proofpoint-ORIG-GUID: NQQgUiorJHXbJpeRr8LPts5w7oI_OqUN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NSBTYWx0ZWRfX/nN2RpAMQq/v
 5vW/jSMgIZQk5Bx9NW4EOq76jyAenUwhVSLvKICFaO932CV0dRcYttAscuC37GQQEYw9jShV9ve
 EukCmmehj6nnR2EqxAxmQvrZnWAN+rs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NSBTYWx0ZWRfX3P+g4VdOUEaZ
 M1LW3BGAdzdg1a2y0ubPHWED25pf7YQQ6VyXhNzkRGleBaDhMz6dRfmnhbtRA7YMrAec5vWAUPh
 BdkBPkXYpByAUfYUG5FbTOKPvvoqALH8YlLAMYbyYUiyYT0KkG8mY8BAmAnpuRQ4g28IJeRvNeL
 BLpzOzoAt5BOGPJNY2rScuz0bdV13FwWETEX/8Nyb9JFQ30uJBIgRhBepkcPDW8AHb47kY7NWRl
 NKLOUCo/gDO5CkVOm9gY4TMWJatUlakLjYVrVYKrOzxpUlJPJV38X37Yoepm/RsKf4l/Fv8x0s3
 NMN7/iFcwfF0Fwb2gPQdTTeb9jFb9kBZXB/DMKUtPB6BR3mmworcK1W573dP0FTKfmcevBE8WVv
 gU/kwaS++uMfVE2Ptu/eRxXxdtpejD83qDZAQ1BXizpoyVxDInwKyTIExgp/zb1ssborzVn6Ojx
 LSbyp8HgdBRJ/t1EpeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090145
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

On 7/9/26 5:17 AM, Chintan Vankar wrote:
> Hello Andrew, Vignesh,
> 
> Let me know if I can enable config options required for A53 stage in the
> base file since A53 SPL size is more than R5 SPL stage.
> 

Having matching configs for R5 and A53, even if the A53 changes could
have been folded into the main one, helps prevent confusion when one
wants to enable ethboot but would only see the R5 _ethboot_ config.

So I'm fine with this either way, as-is works,

Acked-by: Andrew Davis <afd@ti.com>

> Regards,
> Chintan.
> 
> On 02/07/26 13:42, Chintan Vankar wrote:
>> Enable config options required to enable Ethernet boot on SK-AM62A-LP.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>   configs/am62ax_evm_a53_ethboot_defconfig | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>   create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig
>>
>> diff --git a/configs/am62ax_evm_a53_ethboot_defconfig b/configs/am62ax_evm_a53_ethboot_defconfig
>> new file mode 100644
>> index 00000000000..a64542315fe
>> --- /dev/null
>> +++ b/configs/am62ax_evm_a53_ethboot_defconfig
>> @@ -0,0 +1,16 @@
>> +#include <configs/am62ax_evm_a53_defconfig>
>> +
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_K3=y
>> +CONFIG_SOC_K3_AM62A7=y
>> +CONFIG_TARGET_AM62A7_A53_EVM=y
>> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62a7-sk"
>> +CONFIG_SPL_STACK_R_ADDR=0x82000000
>> +CONFIG_SPL_DRIVERS_MISC=y
>> +CONFIG_SPL_BOARD_INIT=y
>> +CONFIG_SPL_DMA=y
>> +CONFIG_SPL_ENV_SUPPORT=y
>> +CONFIG_SPL_ETH=y
>> +CONFIG_SPL_NET=y
>> +CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot A53 SPL"
>> +CONFIG_SPL_SYSCON=y
> 

