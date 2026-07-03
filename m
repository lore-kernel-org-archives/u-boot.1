Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0243DC44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6554D847C8;
	Fri,  3 Jul 2026 11:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pwFmJae/";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Srpl/IDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D61D28484C; Fri,  3 Jul 2026 11:19:49 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572D0846A4
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635tljt292829; Fri, 3 Jul 2026 04:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ik3lSx5w6+A7mfzjeYtGiolYwr7dW7w6QRlvJmJSc
 b4=; b=pwFmJae/Nk6FlXTGf2GyHbIuSTtlCD5u5DfUS2tzLT8rB21mpdR8GXT9A
 mGYEqBGCZmJJt33YBL4CQW0qRSA4qKANsiu/MpGr766Z0Bt+U3P9X9aZm9kybjSf
 EpQ8bD/VS1Pz9hYrl6alkxfKyR8ApZ1C7xFXqEK/c8Iczd4E52kHiBTCU+vSqTgL
 +VDT+rmtUIZXvU8QcZ3bTjseQw4JiQVK61dfOc8R1JIqGylGc2kCOOB1gp6L0s+4
 eZzuHaSzStQzUcBRr0xCxsmj/TNQDQvn53lR2/cO1af2ezF37W7kJZvv4qhMNbht
 8z6lDwauN3RoF7vTr00vRMGiBCVyQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f63a72ajs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 04:19:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSA3nDtI9mMWOlk3Wx/CQZnbQdalVWRgaE/fvAos4yEq7/BaBKN/0ujnxB45kKz1KBYhEuAzEPpj/gB10x7ugs/SX0sZQCnd+CEQs6mc49X6Xnf2uNAyX8pipKaMslj9/nA/XaT0JLk36wryna3cHT/4VfCgt2iVOz9ZIyheCRz8+7mn7VsiM/QpYGK0jmIMA8hEN7II9xuvjgYtehaBpYnFsprYu7lvDigYBn9hHeKnAjtaO237ZX2mLP3mBc54BJb9Wx+PAqh/3k3u1pDAXtKCdY60ZTToXYBIbx1EWpNgqOc8BtEkCd6+F42kIYIGuciLGMacIJfrgiYoaJA7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik3lSx5w6+A7mfzjeYtGiolYwr7dW7w6QRlvJmJScb4=;
 b=yJxsVWJ2Mp2M6hBZ33tqRT71wVI0t2VCtz9ionLgPFfGsnVAi3SMa3wsEkHPi3SehrLRgiYiZPVpOchpozSSuBrtKbWmhNatJPzPYo9iFrbXjGUQpzrRpGSxLVesnSKg4byGLDX/3V0n4/O6T5eD0PR0lHoH0zLy58S32kBJcPRy9/vpFkrR/0laArLZjRlhf0M+gGw5QUpvyGY1sYIB5YPmMA3jPYGu5ym/Y7byP5X1TvxSfMDRbfQoz9Q5Rpvtudv3UBYfYUxDFmW3vqR6kePHf8zmbRvUsRjFJE4rsUW8WU/AJMvk+F0SN5ujrbb70SspXjs0KrwpKmZfaVukRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik3lSx5w6+A7mfzjeYtGiolYwr7dW7w6QRlvJmJScb4=;
 b=Srpl/IDfymvPbQOkxepSHJ4gN22cxR0QNq9qb9cSgIjts2Q6wMfMg0/QZYRxaDWunsD4reT+Iwyjbap8dMKxO0ncPR1++AcgxOmwBAnzwp960dmzOSZIgpghFEGeYuohqKdmUbot8VnWE1NQ/2SLx3QiO38IDw5GR7TMnkb0Oqc=
Received: from DS7PR03CA0249.namprd03.prod.outlook.com (2603:10b6:5:3b3::14)
 by IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 09:19:28 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::59) by DS7PR03CA0249.outlook.office365.com
 (2603:10b6:5:3b3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Fri, 3
 Jul 2026 09:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 09:19:27 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 04:19:27 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 04:19:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 3 Jul 2026 04:19:27 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6639JP4E1758656;
 Fri, 3 Jul 2026 04:19:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 3 Jul 2026 14:49:25 +0530
Message-ID: <DJOTOXMP2MQO.3SCAPYA6XBRBJ@ti.com>
Subject: Re: [PATCH] fdt: fix phandles not copying when using templates
From: Anshul Dalal <anshuld@ti.com>
To: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com>
 <CAFLszTggZ57jZw2r10COgm42SgPZUpKXoe_1uEzaX48KtGVYig@mail.gmail.com>
In-Reply-To: <CAFLszTggZ57jZw2r10COgm42SgPZUpKXoe_1uEzaX48KtGVYig@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|IA1PR10MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: d42c9f32-6923-4775-d0e0-08ded8e42e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|4143699003|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: n9xWZgNIJZo52craiGStF8R5oKBDbpe8EjZvtq9PEo6m2cpk/diG1zJQvssWD/HWKUwrHiP2Bgy0f0uMz/Kqp3KXuU6jnU06SdRldmV2AMlbHGuqQNRxVvgOHNeqg/t7Vinzht8LDrj96siIMuBhRA8PiU8B7/ko26ZlOJh+fc9M0L0eEKjomoBj3L09ARE/T9v5NCN2u9Dyka0rVX+36TbL1qJnmsiJIbNOYN9kvjf3TwhNaUTZfv2yk0kB/GduiVJeOIvaLGB5itpj1ppcKJW9SoL77wLg+oQ5iv/irHvZgA3oiEoUE7I2tuAeaEKQnLTT54TCP/q9303fkbzIg77ko7C1mwUR/Ai0BAuHNt6XpvCEb8EyiI9AsdOcNMWjcxa9dogDQ1Ba6eON/0nEfPOjF8ZszkIBFWfYahnrYGMN2OVe572i/Bm5ybJX6EIbCf17VkSrUf7TfspHegPHQEAcraMqvFRSyKGxuq7Pmv0lFY1XUmwtJGp+A67EUI7eKJ5vwPJQ4h5+rbW7HyixLg/RSeodi1wUGYQQvm5jsETx2qCi9eJRKcLtmAcSW8vE5cfIJRApMWhdxZLtWDj6WWm1BJUBaP6h4F/Q9ZVjl0RF0FbmD4w6xPwDrHQPtutbx8MrVVS3g1vqMbinL4pX4QAb0OVb+ulzmlA+w7vuhPe3PtpMubKFxA1h+bSVvH+gM9nIm6uV3YNLZS91ivxgEA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(4143699003)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZI2gEZD6zGmMyd4TM9ZocVwueGSAp7Z7PWrQ0kTB/VM3+3r3XWGktAX0KJrUdTVL1jZGuzSoKNPkCH97MgdI/yGYMJvV6VBKdWIy/OXZpC9A5et9Cd1jCSowI8wlhUnNBoFDOaGRCf+TMBxiXGC0qNk9hBDJXtXS7lcoUWX3TLD1hZ8l48imax0ewQYCv7yvihY8DqDU8hi26R4pJ8Y5Eh7lwZHCuYBL69jZ3DsH1Jg+LrG2dLZ8jLRhCOdPxtX/PSwTIrYYbZ7Mg0HBjbWqtIIhMaWdUOfku5SEomzz/cobh/jjx6bB0sax+aMutum0TgAAbygTK4qbGxj4Hq3b/FoYE+yAGPJY9VwTzx+zWjgWodRvEVoldCjWlqC2C16FlqwdSNDHgrZqdfT3B+baCHFfwAEJXbm6hu0sQLxYCCP7gci5JraMcm0kSlsss5Ng
X-Exchange-RoutingPolicyChecked: ky0QHuyOodscuak5tGE2FL8iacQ7CEU7qHGWlQLOIdCiMv1COBt9JO3BYLrLMMPReD7VhKz+DG8ssukzkTr+CnyerkgRBPqkHqweWky9d+3+QIkuOu2nuxQB4DrUc5ftW16l/DXIoyi7M++OntOEVl/bYWjR2WmbeNcqkDX2/UYdVUTFswNB/h+lo57YjhhMzXHpAiLgII5gAHc5b+NGjb2/uEvp2R2Y4XGCNscWp36qrLRWGqKAO7WbPemPixcL0tQGdsgtbwc8LHR2lOtcdGPS/Djk69VXonHExz+5pqKzv5NCf2eTz4gYXZjvI8ApNMMDpxOjizC8kwIBmAM5aQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:19:27.6247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42c9f32-6923-4775-d0e0-08ded8e42e7b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7240
X-Authority-Analysis: v=2.4 cv=BMGDalQG c=1 sm=1 tr=0 ts=6a477ea6 cx=c_pps
 a=037dmpTZGv+Xy+TtntRLUg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=_d-bOhb-nCkKrFof05MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yWxXy0ZY2NUJm44AH3BS1d3WLiYcTVbN
X-Proofpoint-ORIG-GUID: yWxXy0ZY2NUJm44AH3BS1d3WLiYcTVbN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX9ZiuF+w4H4GL
 CGEUGVu6gmKHgLyzaVDQPlFhrWKF7HZnAVhTF38roSCdAToeGCwuk5lT4CAFoHD1dxqXW6Pgxwy
 jm+N8sbAIEEqFSENECo4CXb1qaq6Qyc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4OCBTYWx0ZWRfX96tdNWxUtJgJ
 i/8Em0/1Eqn6sykduWZPgcmo39tzg8WO9XWkfRuDRy7s6fo1oAeym5uEC+x9g8JVKL+g25/6GXV
 46+2dRiLelgpKZjZtuAyVZcEzyTKWhS52esIqyKwb44VujUVeRVrRMaX7bbwFyAvou2tcYIS+K7
 PxCQEN1IotCTkWMKci7oLUYd5G3J7jks+1QRSPACtiU5X4LkafXLYgdcvNC96JNeANke8LbLHpa
 EPSYT+/qv4iseWmOn4eYjLPwn6FoPse7SCPXoR5gs9kXS99gPXRGqmEhYv8l6pY/FmQXVyDtRGG
 QW02GuAK5ifUwstW6KHtdnHNW9hKLAl5Kh7YuZwUpnGXXI/q8Eluv9XvvqlAR5FGUCj4Jv8qia/
 qyQaeDaHFRJmVSNFFb82oM1Ct33W9t5/DP8ZIdu/XLqVpbOY+PTZnV2ztUXzlKDXuvfWK48FtnT
 G/kkrW6bKIbka3FL9UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030088
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

On Wed Jul 1, 2026 at 5:37 PM IST, Simon Glass wrote:
> Hi Anshul,
>
> On Mon, 29 Jun 2026 at 11:49, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> The phandles used inside a template were not being copied to the node
>> inserting the template, leading to a missing phandle error.
>>
>> The following example can be used to reproduce the issue:
>>
>> &binman {
>>   some_template: template-0 {
>>     ti-secure-rom {
>>       content =3D <&some_data>;
>>       keyfile =3D "some_key";
>>     };
>>     some_data: blob-ext {
>>       optional;
>>     };
>>   };
>>   output-bin {
>>     insert-template =3D <&some_template>;
>>   };
>> };
>>
>> With the error 'binman: Node '/binman/output-bin/ti-secure-rom': Cannot
>> find node for phandle 103' observed.
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  tools/dtoc/fdt.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
>> index 991a36b98796..6c3449095194 100644
>> --- a/tools/dtoc/fdt.py
>> +++ b/tools/dtoc/fdt.py
>> @@ -780,7 +780,7 @@ class Node:
>>              parent =3D self.GetFdt().LookupPhandle(phandle)
>>              tout.debug(f'adding template {parent.path} to node {self.pa=
th}')
>>              for node in parent.subnodes.__reversed__():
>> -                dst =3D self.copy_node(node)
>> +                dst =3D self.copy_node(node, True)
>
> I believe this is the one you pinged about on irc?
>

No, the issue of bootph property only being propagated to the parent
nodes in u-boot.dtb.out and not in u-boot.dtb is a different one.

I'm still working through that issue, will CC you on a fix once ready.

> Please can you add a test for this new behaviour.

Sure, will send a v2 with a test.

Anshul
