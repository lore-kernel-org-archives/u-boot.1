Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF640C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 12:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C00D84AC0;
	Wed, 15 Jul 2026 14:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="psHpqZRS";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DgvOyvTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D10C84B06; Wed, 15 Jul 2026 14:47:35 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A035784A7B
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 14:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66FBZFmG822398;
 Wed, 15 Jul 2026 07:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=eheXi5AS+/H+Yus7Xuy6kTOPbRpVG5bCKLPEvCLCN
 oU=; b=psHpqZRS7fMYwT7zfGRXPaEIvV6k/F7TYnmhKdx+MoOfx2Lrg/Wwg1KqN
 ngdzYPq3TR1k9Cdy/i2npiV/ZTNu9XaSUxUIcjXre9yf2SkRBD+RHjONKGKI3E/D
 lCWyyDRLVl7gWZ0rRn0q5uhNiLxP29lI6aGBKICrLgBrLm54SmqcVxqwtUf7FOFx
 knH2kU3SYYsz85QITKw+1QT2F1br1S5bCfkPkeIMErCCxNI9GmRLigz3KVuIH5Z0
 rWCJdas9Q63gZgHxq9nRXfg/CqJw2BzWNYQrlT8ppz06Z4Cw5NFM0AdLBoj/1/Cv
 Rb+5qjshK3aIF13lDe48+L0Cg6/4A==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fe96hgjed-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 07:47:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctLKnJXH3vXUVhvJu+2+gSp6/tMCRgN/e/QzOyUqzlLPX0WUTiHkJEqEYvMyjFyVp2eCpbp3qjsbYeSQM8uuvIMWDaobPR6IgNXm++b8d0Hf0EM6pNsL6y10BFaSe/ceP35dFefGz0dtSq7TaGN4UtQhWNHPr5f69r+WPLe1TEy8f/Ph2xMAcwMbQNL3WRWljrmj8VzpAkWGDCrdI3dVOgLGTqU3qx5nYSKDwamGgh/x+LSkT6l2CHF9BanH/Cl5ys4j1fyjdjsqS/qFUJqjq2LDeUx21Y4/1/DLZPassPvbXsBerdegMJkQ0e6gU24HyXx1/QyKLcCzlwkqbjIKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eheXi5AS+/H+Yus7Xuy6kTOPbRpVG5bCKLPEvCLCNoU=;
 b=lLRIwR4ghcfYzbGT3MJEzwkCOyB2kuP8H79awzAWNfkrMjPwYZvuA+o1DV0oHRGljzPUa6i6Wq0XvRCNIj8ex6fk9OKmGQlUDaTgaIjdsUjPUXCuVBNR40XrOZRJ/AKPYRcHmFAV6+2RA6w6XGdPxGOwPgVpdJjfLVl4gVYKDohi7J98mEg+uXJ1jG1I69IUKI/g7SLSUR+mudau9KFOyqFIkI/PTw/gVVReVRwZqRLNJPhVLw26vWPZHWSsvz2tlYLFUzn2zwNGOYuqXs6ZdwYTJQi4hTsWYQHcrhT8vTjLmQkHR0/dlzh7z4PJGX7f3Nhd0QwpO4cw0Pg8vhmhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eheXi5AS+/H+Yus7Xuy6kTOPbRpVG5bCKLPEvCLCNoU=;
 b=DgvOyvTelbHcUVP6GIAIMe1PzpMr4oCxgvJE5eIf20DKxSZKfUuRmHSHaUCqXigDCMGREPkBBUhbLPG57AccLqEKfbpP5NEkoX5b/vXqaRcKs7lGQlq9rWzXVoAUp3yMmu0URwGMyyrvR6IWLU0B25YkwenztmCCgVpiMREjWhY=
Received: from MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::35)
 by SA2PR10MB4716.namprd10.prod.outlook.com (2603:10b6:806:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 12:47:25 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::98) by MW4P223CA0030.outlook.office365.com
 (2603:10b6:303:80::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 12:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 12:47:23 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 07:47:04 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 07:47:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 15 Jul 2026 07:47:04 -0500
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66FCl1oE3071738;
 Wed, 15 Jul 2026 07:47:02 -0500
Message-ID: <53061e29-9e74-41c2-911c-2b56ca869e7c@ti.com>
Date: Wed, 15 Jul 2026 18:17:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm: dts: k3-am62a7-sk-u-boot: Enable DM services
 for main_pktdma
To: Wadim Egorov <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>
CC: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
References: <20260710102229.2980029-1-c-vankar@ti.com>
 <20260710102229.2980029-4-c-vankar@ti.com>
 <178402710826.246195.6210593528035580821.b4-review@b4>
 <53d46b60-1529-44f4-95cd-be224ff66bf1@phytec.de>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <53d46b60-1529-44f4-95cd-be224ff66bf1@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SA2PR10MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: bff87681-99ed-4b2e-4092-08dee26f377d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MnDHTivmbPCv9sv5vNyYliqsgGZqydk1W9GpFLGv604kz0enIBXD8OPa+T/uKA++80A9aMiO7Fz4iOrlK1ja8pVNA5QsC3OeONv6ahYv0P6MMTUTrJm4M943GVhHrgQvkHUnJYi9/j5mJDWGe0PNPvHV4enVBoO2Mwo2htOSDMSvD1AvDMQtoXg/HdFs6PR6jipM0MHHFfIyev7BF0NG7U+xQJzBPCd1LNqmUGUWsTS6mbd1ioYh1+RPBxea3XuLIuzbj4Md/EDdRtqy6w/JFqJpZen0tWUla20STEjB+5ukU9ptIDN9YQjGUId/hrioncOBbQe132OCfkep2XMYeKsZgUS+nFQ6Zj+0sbKS/N1wrFT2KrZ4SHgoihS8q29oZRNyW9XfwHpSR3c2bFTSv5OXCxHDrwUGaqdR9XpQPeqUAsFLr8CMMWAxYn9B4h8wZgBb9cWXO/Vjxy/75cGQzn1ugODeB6ZTob6KxdKPR7Wbl6h2olnUJrjvKgedCB79+o9qn9bde8R+MKAdPnyVHHDE3Hj/Y5xyYHOkHf8oAaDSLFf/+wcd6kRazID9WWhzl0i1LoPlbJuFfLF4Cb0CzM9n1AxodChFZ8TNP7hYfTY24HxA92e8d7No89GiAvzjhItUAB/tf379U8KverWOVzTKEDfPkn6dw36Wzd2ztfolnUlrJ4fmaqaIwaZeVHDq/Jxz34e8O5Tuw1XfOHGU8w==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZTndXGqndSKV7ywfdJkg3CwTqwpiuHVGQKloyATrdUNrZ9oz2gze+SLxGHVX15SIG867+Rh+XWUZmKricQWD//UWLB99meceIDCW/ljCa/dawSBtsDzALSaA7suFJHg7Jqpw5LNVPOGGRVTsdmIVpglLfXI02PmS8eRiJ9Zvr6U5lItGKl95l56P3acYkThvLXtRF38MFJ6xemyterFrrDFcI0RIvhEoRjDmBtMSd6kZeofyVy9ao4bvEQzxgmurMUa20F9KTwXymUH0bIOB3FQJ+WUNaZ9LcTutI7Q2tB5deiXBY8THNWdK4XuU8Ztzl7gul1iEHZRrm8P2SzIysrpGHPVEKooVHGXobN/aNz61vz365pFdr6czDvsKJboHFiAbtBiS6k4mhu3TrsDNCbAgGRqvSWhynTxMXXCvyam8noXeT2lamHztyISOeEjM
X-Exchange-RoutingPolicyChecked: gPXvRK8S3iYiXOpqGZQ6qqMCAKkbrGBaDF+tmoew7pMWRzHWKcHWX1FeYsbgYg4btVfvzw1h3NhSCppLQpfmzpYXbzlQB4uqu6cS0lbN+X2DDNUp+wn50TUeklRbLzURb5MnW1NjypohUzqg2h25uG9yC1k80fvIvGRSwfrFDGeU+o/C2Gr2RIXElQ88g9eiR5v106dNK39BUEa6pShdFWHzSf2CsOsjaftns/38FxdiKNan3aMdXsxEI1Sou7seiM5zgdHrGzn1xYi/PkmYpLnlViGlJ+7zSKueagVTXhrheCHxtByjiObxtEP0LlHeemWZU4Iz3CjcRgecVfueEA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 12:47:23.2003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bff87681-99ed-4b2e-4092-08dee26f377d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4716
X-Proofpoint-ORIG-GUID: NpMkQfviHuzI1eAcH3BSir3c1sGIogH6
X-Authority-Analysis: v=2.4 cv=Zfwt8MVA c=1 sm=1 tr=0 ts=6a57815f cx=c_pps
 a=qMfGPIaByV4ZnHoTJsbowg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=mmNic-ua8brjQVaDVvEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NpMkQfviHuzI1eAcH3BSir3c1sGIogH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyNyBTYWx0ZWRfXyyK2RQOICkyv
 xVd8xAdPmlGnEGkdzybS0/6x0g7GoTmwI3hXKsXz7CSmjnvqmYVzqhTtHvW7YXclj1bT1J5RHet
 EvgOhZAPWrj5shyHoy81UfGo9GJR2H4YemyTL6ITNIk7AHhvpnJqV2EHwxSULIjT6zXzVDu0Fbn
 5Lb+Ho+w1nq2P4C9sV8YERiL37cPpZ8yDsb83xeEYzop6aE3m/TgqZSzh0/4NZuucRB1ZXSIkuq
 6pE18pmKXCcppsjK3r3LFFaPct46aBoxWzn1aZmrrloVTchV0OtXcUHg6CMzLE2XFcAxGBXjoEm
 9H6DNTTNNj4L6xTYSPcuZRDzKf3TTQaWnVhLoWrx3fT3aVRUnNvNSMyKsrxkEkq+ZWlAjRYTJcZ
 K5yuj76ucFM3HmHzLtUprEpD7JTZlZvNwbWrTxBSSf3BwFPuO46N3+T+vcb6MovnLKkad2Ats3R
 g+287omnIuHiwyHCu7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyNyBTYWx0ZWRfX9MNj5NZITohp
 5U6Bxqlml9odyUiiHjb8K+3sDhQ1qu+2CM4WX7Jszvi0BL79elsIfFbioWloIKmmUufNGVuRm2T
 2GDFk1UBR6MJ0H07v9P1vTG2gKnrq1g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150127
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

Hello Wadim, Anshul,

On 14/07/26 17:05, Wadim Egorov wrote:
> 
> 
> On 7/14/26 2:05 PM, Anshul Dalal wrote:
>> On Fri, 10 Jul 2026 15:52:29 +0530, Chintan Vankar <c-vankar@ti.com> wrote:
>>> diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
>>> index 4570ff6edbf7..9c2a6bf89a92 100644
>>> --- a/arch/arm/dts/k3-am62a7-r5-sk.dts
>>> +++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
>>> @@ -42,3 +42,8 @@
>>>   	status = "okay";
>>>   	bootph-pre-ram;
>>>   };
>>> +
>>> +&main_pktdma {
>>> +	ti,sci = <&dm_tifs>;
>>> +	bootph-all;
>>> +};
>>
>> We should have this as part of 'k3-am62a7-r5.dtsi' so that other boards can
>> also get OOB ethernet boot by just modifying their defconfig.
>>
> 
> You can set the boot phase tag in the Linux/upstream device tree. This is also what is done for other nodes required for booting.

I agree with you, I have enabled boot phase tag in a similar manner,
I added the "bootph-all" property along with the "ti,sci" property
there was no specific reason to add "bootph-all" property. I will go
with your approach.

Regards,
Chintan.
