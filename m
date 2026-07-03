Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6083FC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 06:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B0A84119;
	Fri,  3 Jul 2026 08:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MYifJ0Qn";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="X4syj6gN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F87841F2; Fri,  3 Jul 2026 08:26:48 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4138407E
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 08:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6635tY1F277572;
 Fri, 3 Jul 2026 01:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=AT0LtG575t7WkMT0TfPYOFv2sEq8idTozN5JkwqQU
 o0=; b=MYifJ0QnpdKSNNaSn4uLn4US8Opaw8fKdDJ+4D5SjrCRuAXpHAdQv70Dy
 mzDK7uiGt5tQ2JOLUlPtglLd8md1i7HH5pxyA1YRNdrws6gcZwwpsVxxCYSwQIVA
 so14cTa0Qb1smV/X/aWrCPDrqyBHYepCDTqmmWyf2SZ3jVDw0lXbWxZLVxRykwha
 zneTeJ0+uYNjP+VYtxmjmsVeIdBVPHmFRr24Tq67Efg7z3FbW4aMGNcvTgSc4duC
 luFIJCp7AwF6JBDE3a32KC49sX+LQ+WEbyGN9hCB6IIwM8IqfgsDnFQcYXTvqgT+
 mFS/Rw0L9wSA/OAt2ykLliHGHqqmg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f5mn5epn5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 01:26:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfoPtBLGdlQnpvV12ousMPkyrPiGRumHm6JSSy4tiXgpBL0Nzs8CSB2RfnIrFjn/rNhILNLjXCJf2UvDpFTgGXbbVN2PZoygBmgi2m+aUSnSgHuJn2o19XYMbLB+15jj9TA/blDFfSX4Vypar3J+42DAw3Pm6OVHnYzVF4vsNRwzES2YYmElO2QvcBwIXSLJ58aJyfPFC3c8yTuj1XtOi021olsB+y1Oq8VoRP9gw1uiI5hM4KKsnGbHZa8cTUHMSyhV7/JeJoTnxy3tvCw24iL70wJRZl6bqdQXhwxcUTQMVf5LoSK972zAKGrieL8lenQi4/Zz9rCphWX4vCE4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT0LtG575t7WkMT0TfPYOFv2sEq8idTozN5JkwqQUo0=;
 b=uijXAZJ0ZiCSzGK3q7eAwcm4uf85hg3yfraS4t9gnltW17pI2nHzBJDGiEfio4V+8RpxJwkBa+TB/K8/qyt4jWtvwh2WWcfqU9vPQsWGWUa7BWeY9FhFznyj13cIMiJ0zzA6+T7Ps6nsmFSYL5HfrnzvJeKR4TdH5fu6TDfc4dzMwZLmT4z14zcGxQfMGSZgwzQqeklTr3UwOYAA9lQE/P1lfJWDt+BDSaqh+ep9zCURrqFiZjISl30D3SUkDQbK1B0MrGd2ZiHfU5E7V/fJKWMGxAuiVN6yWo+Aio+yimma6p+DQYwffLJ/y5v0E2vzbK7tjvu2rM0+WJFA2n4Jlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT0LtG575t7WkMT0TfPYOFv2sEq8idTozN5JkwqQUo0=;
 b=X4syj6gN0yzBldW04x1g5YkSnXxcJ+tCy9+xb8l3rrXMg63KWX/wZef/UKfjMQrjrSEBDXnWv+lb4PbN0H9045p8lq0a6yH+XKpOFt0KzzDnsEwT89cTb+/qnklFkk4U0JwiNSRh9gOHwlSWRBarksZ2tzl7vHQOMAgOMOtyfCE=
Received: from BN9PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:fb::18)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:26:37 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::91) by BN9PR03CA0043.outlook.office365.com
 (2603:10b6:408:fb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Fri, 3
 Jul 2026 06:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Fri, 3 Jul 2026 06:26:34 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 01:26:11 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 01:26:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 3 Jul 2026 01:26:10 -0500
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6636Q7of1957043;
 Fri, 3 Jul 2026 01:26:08 -0500
Message-ID: <3dc819d5-3c75-4dc5-8d3a-b67505fb5bd6@ti.com>
Date: Fri, 3 Jul 2026 11:56:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] configs: am62ax_evm_r5_ethboot: Enable config options
 required for Ethernet boot
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20260702081251.2691159-1-c-vankar@ti.com>
 <20260702081251.2691159-2-c-vankar@ti.com>
 <c5aee6bb-7212-4751-874b-6d3f5e35cb76@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <c5aee6bb-7212-4751-874b-6d3f5e35cb76@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH0PR10MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 68bc08dc-efea-452f-d5a1-08ded8cc079c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dudbFGdTfNleVALCMBrA4i9dCZ4tNt0SNmAvD+X51SM5WVxBNhyYzwB1S7b7EXko/xaCD2U+sDy1UFXeQCAHjXZmnihDRqfSz8eBwL1AyARzTQwic8co2PJElLtgsXf9mMbbT+NHl0/sYHth5vZEa5nUspTKg+3znU7GnUeYK5uB1VS+p/Rv98CrzbyQPLuq2m+yTsgi2n2kExLWb6tRGV5tOjdlAsoZx2OS7U6M4EgUr9Tfj7IcxNChPt668Iy9OfEtSmDMMefoHw0QgNM9R+aXHTCefaDI2fY1acg6CiYb8DZvuzRoN5EHXUANCDA5FtOc1+WfCe6JMFYZhIktFTR86hx27MgWoqhmQijv7gFZVccjb/4hmVsUx5O/l9jczX8RQjQfI301JrGMzNPx2z/tXRY/eEupyhqnf++zlU5cS/xRSP2Mo7d7M0XVZtcEKTu98dEmitXa0OvPqL5dz2mc/WbyREwEjrnfs3kDLKHTS6xEc31oG4RUQCavQ3mpLDCLRyAoPpWiAZRJfljHnDpERd72mjkZBSdbIb29/Bukgx5YFGrGXr3X7rk0ns3aAp9D/g0UYU9W2F/OqVdfJ8VzPc7NZEPcy1GPZ9YnmiBYB/JcakuIwlblZovWzy3cbH6kqBElkdUzBXK12PKb/EYq/7bZLnCHJ9OIl2s3iPzFyjxGxPwI0z1rT/ctSk2zApVkbD/tKx65qWsPbEPThA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XBPJql3unfVklwytfPMK7GuoyQ8Vc7Std5+dQEHwv3PdN+ybKT8h3x2m6Zf3625DrggjO3B5OM1oDPCKvLy24+mKxDy13QQJHfz0RcdcnS81x7HZBK5yO9ty0ToAJ5nCjmf2583T3vlUUx9Bppt5nAN2wgeY5kGxx0VGir33jhNzp0ZsahnwDFzW2tqoTD7L8YWxMIaMcux+R/OAW+hr3cV/hIFzgRSi4Vgtd2WxHqyVG7V8qjOXF0kOXKqGEQA8tPm5V42WyVAzwaJE+y/v1JjQr2TGzJdw0VJlx9VPl98s8cqIKzFS8R/0APsqRIwIZkj/dgPreHNoTdls9FStjFkrQ6QO1txl97CtDDo+e57uvofSN1zFRnIIevCyAqjPNySg0J/FLw+MMnsVON/QIq7Mfr8R+Tbz565/sidvUGUWlyZzuddjgTpEyZU+ckH1
X-Exchange-RoutingPolicyChecked: FZZYxdCJFMC75U9fKMqRq/AWNChsWuHDlwmLSYXNES79ShXTG76AD7VPouPQBK4lDcc+0epxOuSuE5kJud1T4a9xcoBmV3Uw2w3d/wPeSuIGsxL0JgfFw9dSLuyCO58jhwCkH+yMAlbQZlZq68HLvBr2UoJ74Kgmq7FbIBLPgyEN7XKoBenCb+PEFGAefXNV31gv0DAa19KOo49bTfpsbEH1yypGqDLj5sWuG6LT6Re0D40x5NWl+zJ3MiEhGk5aUzl9L57xN+fkYP1ktGbiC/Ooul/WXkQkgvckPw+PSwCS5RF91wKB2GAZBo4o0isN+MoHjOfoZMBBEOsLv1rjXg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:26:34.4587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68bc08dc-efea-452f-d5a1-08ded8cc079c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OSBTYWx0ZWRfX+s1IV4+LSGOo
 4KByZXGLoZQHYBk2oNps0RKePrFNpCemssjqV2ItF9y0hFlWs26uaLJ+xQdqUyo6T9IiUDvAOFE
 7aomlIeng0JCvUMnIWahPegyThTUOHzFGoROx/ZTTB7Wrb92LUUVbRi6Hjgel5QlY1sa3UvE0uy
 hvAytxAdQrojxm8fDElS4J6KQBz3AH6lIIw4R+8MtIxquLMcRXgj0IzI2VBVoiWvYbO4R1bH+BU
 JYM9QygbIdT6c2A9nyE+Nh+la+96G/Tejw89RPiQnCg5Tiexq+RBdecx1+/RUF2ujT1+7hvHyPc
 RKZfy1lyDLirujRxtjgvx6OnNBkncsVPWQ5sbJ62mTYc9bq5au8KxbjrU/q+RQwa+XZusQDrI+I
 3vTDgE9n/OUTOe5co6oRaGiBqXRwyvJuEnKqVZZN4wMbBubFLF5Vci60F3BOimvE6Z5TcDyQgin
 8M2GyLkV9DoLujo7NgA==
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a475621 cx=c_pps
 a=wV2zXAf6sYQQ4uINbIt3+g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=CBPxBEOyAMwqxL4asMIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OSBTYWx0ZWRfX+2roK0l13Hpw
 6t8rxaEQO3wPh8gNDIiQyyuXXbQPogwhDxgu5CZQqJYCa5bPy2C7PSB8eHpoTQoAgwEhVh5FRwD
 wO7zJlbSqo3lWh48Vuhjfo/CoaB9P0I=
X-Proofpoint-GUID: Ei3K75GUGdj-Tt1rc7xRK9IvsOvXXQsE
X-Proofpoint-ORIG-GUID: Ei3K75GUGdj-Tt1rc7xRK9IvsOvXXQsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030059
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

Hello Andrew

On 02/07/26 20:27, Andrew Davis wrote:
> On 7/2/26 3:12 AM, Chintan Vankar wrote:
>> Enable config support to enable Ethernet boot on SK-AM62A-LP for R5 SPL
>> stage.
>>
>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>> ---
>>   configs/am62ax_evm_r5_ethboot_defconfig | 27 +++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>   create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig
>>
>> diff --git a/configs/am62ax_evm_r5_ethboot_defconfig b/configs/ 
>> am62ax_evm_r5_ethboot_defconfig
>> new file mode 100644
>> index 00000000000..215084d1490
>> --- /dev/null
>> +++ b/configs/am62ax_evm_r5_ethboot_defconfig
>> @@ -0,0 +1,27 @@
>> +#include <configs/am62ax_evm_r5_defconfig>
>> +
>> +CONFIG_ARM=y
>> +CONFIG_ARCH_K3=y
>> +CONFIG_SOC_K3_AM62A7=y
>> +CONFIG_TARGET_AM62A7_R5_EVM=y
>> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62a7-r5-sk"
> 
> The above 5 config items are already set in the included defconfig,
> they can be removed.
> 
> There used to be an issue with buildman that caused us to need to
> repeat these items so it could detect the arch/board, but that has
> been fixed for a while now. I know many other boards still have this
> redundancy, and cleaning that up so others stop copying it has been
> on my todo list for a while now.. If anyone else (hint Bryan/Anshul)
> wants some easy patches feel free.
> 

Yes, that was the reason I have added these duplicate config options in
this config file. Since these config options are not required anymore I
will remove them in the next version. Thanks for letting me know about
this change.

>> +# CONFIG_NO_NET is not set
>> +CONFIG_SPL_GPIO=y
>> +CONFIG_SPL_MMC=n
> 
> So why can't Ethernet boot be supported by the base defconfig? I'm
> guessing we don't have the SRAM space at the R5 stage and that is
> why we disable MMC boot here. Would be good to put that info in the
> commit message.
> 

Yes, that's the reason we need a different defconfig file for R5 SPL
stage. I will modify the commit message and add the required
information.


Regards,
Chintan.

> Andrew
> 
>> +CONFIG_SPL_BOARD_INIT=y
>> +CONFIG_SPL_STACK_R_ADDR=0x82000000
>> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
>> +CONFIG_SPL_DMA=y
>> +CONFIG_SPL_ENV_SUPPORT=y
>> +CONFIG_SPL_ETH=y
>> +CONFIG_SPL_I2C=y
>> +CONFIG_NET=y
>> +CONFIG_SPL_NET=y
>> +CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot R5 SPL"
>> +CONFIG_CMD_DHCP=y
>> +CONFIG_SPL_SYSCON=y
>> +CONFIG_DMA_CHANNELS=y
>> +CONFIG_TI_K3_NAVSS_UDMA=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_PHY_TI_DP83867=y
>> +CONFIG_TI_AM65_CPSW_NUSS=y
> 

