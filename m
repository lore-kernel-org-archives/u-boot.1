Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B253BC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 22:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E42849FB;
	Tue, 30 Jun 2026 00:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gymzttGn";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JS7BhgZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BAC84A29; Tue, 30 Jun 2026 00:31:59 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EA2849C5
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 00:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65TKei0D2863513;
 Mon, 29 Jun 2026 17:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=gsha2EmqD42a22mOK01MGHQZbK3Vu8X3h7F6yYbTa
 8A=; b=gymzttGn3KtCmnGUpxeFag64O8fJB2y+98GyzfZJKkoqIviRXp6ygoR2V
 gIimMCVdgB2Q6kRwHoqCtveJVfiAMRVaJPjmGj12LxPoQqy9UEt9vu1tOPHkpxkG
 TQxBsCBoIxnkvJoWl+uZE/OrrulVJxSNYFrgtSeE4dbyGPAfFTM53kWYW/nI0F20
 BLNAWPoGdguk8h0/q6pVVIkzdM/OYEboIeqqfwhpZA3oMHwm/GmxdpUUEoGAZ9/9
 1h+RDH/GJmJ/h0VtKV9gak9hVS71pbs/lzwTIhWg3+VE9F3VouV+A5OIT/0mU2kg
 iGPitJEXg6q1GTWPul+8GLhU1jWpA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f3yhss1je-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 17:29:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMcjbUS3sAS656ZCMym4JV88HfYZ4F4Ub/cxq8JAitFP/KDtVbqumvGaV5eqzLr6hLSOCFs+UhkBYVSWypzZYrPxf2pCnZLJb954UI65uwrTRlxsvTyw1Fpb9+JlSWq5Muyyzn+zTvNDxesgujeDKNdS9QnDTZQtRY99Yqep3H+0jy/WB+/VSqqqONpgZGtP2rcAoxRYNt2bfbmrz3xXQIazxivHxy/r4B5ZVl02HiU9BtjVr48ixXFACMhP0q3r0UrpyPJuUQPAD01IVMLrsE/RbJCYN+iGELnBCdOjnR/uMq/zzOoTZq/ExwVOds0KFiCmrZJrzGV87eZm3Hy5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsha2EmqD42a22mOK01MGHQZbK3Vu8X3h7F6yYbTa8A=;
 b=sILIdc//drB9HGNPXKTjLcvIl7/9vUQ2RGfsJSIlxmxg47vmifybSbVohAvLqiAn3StWYeMZYbt8DCMQHIIE4o+3BxN2eKjVi0A9cNwltyM6hMDkZ98DkfZAX/JR405hslUAf1ye5sDUvw9f/aa0SmBQT5+ujfbi6r+LUFWC5bHtkBHHrPdaJjNwDz8zolwQU2X2Z9JoAFxUOrxN/nHm0taCsKDnu7qcg+9AN9Mj95NL0hKSzuqRXdn9Ek9KPzgvg1wdq6QVY5lZ34G4g6AlZJvlx6Tln8Altp54i6BRoOIr+gwEQjDeONJvf8oyj6caAn5RoCcSUysMZvIl/rqMwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsha2EmqD42a22mOK01MGHQZbK3Vu8X3h7F6yYbTa8A=;
 b=JS7BhgZ+5rALkb3JmOM+G8dC7wokppZBYIbJ7+A4TAS7ntwAWaOKv7tQ/KpOeoOdkNDkU6JEegRhLWtf4+uoy77a5EnyKC8KSJSnH5oAjl9UDWWrS0WyVbL1QCwqb97F53QF7BjUE0llF+g0Fh8D3fyw397n0Z3DQ6IFRLts4JY=
Received: from BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59e::9)
 by IA4PR10MB8277.namprd10.prod.outlook.com (2603:10b6:208:566::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:29:46 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:59e:cafe::5) by BY1P220CA0047.outlook.office365.com
 (2603:10b6:a03:59e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 22:29:45 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 17:29:42 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 17:29:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 17:29:42 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65TMTgND1580676;
 Mon, 29 Jun 2026 17:29:42 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Jun 2026 17:29:42 -0500
Message-ID: <DJLVZU3XXPJ4.1450IFU56VBF@ti.com>
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
 <DJLT7S292PYE.380FF8KPK95CN@ti.com>
 <eedd8747-ffd6-4c61-a5f3-e748ed1831de@kwiboo.se>
In-Reply-To: <eedd8747-ffd6-4c61-a5f3-e748ed1831de@kwiboo.se>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA4PR10MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e423c7-adca-469e-0e15-08ded62debd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|18002099003|56012099006|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: ZCd/RiD1nuuLYejcGVpN0P8j9/fNgva87m/SUHu+bhO2yC3WAMhLUUM0n463NBGFySV5UNaZoDlqZfbmiHyEJmAn6YZsTmztgxG0leopoRe4s1Oe1crEJwMHXHLud137IfNh4YHCSGBzhx5w4wSM2SNwE+j0zPtQW0RGbywOFg31m3tnCPPQaRiFOJxGHmtsQQgWgL4xvn6xmqMrDrs7n+0X2E5fwJKC55N9YPRGvM8GdtN1TAQITcAoxVRDU8N3VuIGKa6tnGczvG28T9I9/NJw6hHV/4Tk6tuW4jrDS78/0u91Xu49BJPbMkXDSCC3xGaGpLqRnixP67Gd2810KzlcIl2BowXmkQu2biuJi8h3GVir37LlC3p/rtrC6YcFou9l1sZOchWLdFALqrzceVmZvS5SNIaEkH331vOGrVdSKmKB/oID30iYxYSd37PNxt50qr6y4ZYStYacS4g8bTN+S6Cp9wwlvoQzvEWcji+UsLv87n2UQ40UbYEyHBkJx87fo+OBcLmKlPbDeVvPYF6ObhRb6joasx9oP1xAOyO2Ymq4EnNm0s42N/pdnEjH3eZxmGKHDgaGsn+yvUiBMOV9R9Fh2kiFioEkjxIWl3oiuj1MTCmoTOGq5vi40VGYxc1nd5pAbAMrGBlEymsIYe2F80m1/Zp/XAGnCVasT7ZQAINxKVNIu9zWOqqfA51oPCeMUdjUTK/mCMaMZXM2GA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(18002099003)(56012099006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3owTGTGzR/X8ZzTIg3QAfCzWTULYmdEAxWyp4g3UNmjFEEjxy7RsFxz3G7Eu3M4ef3o8+pTss1NJ0ICmcST97KqN/Dg44nCOYMImJH/7OU+UcAuKJFIaZ9qLiZnEWiCyI2pkCFFkLDdsxr0l0i2p6Jt/YZ+7GW2WAzjLy0JRZgeoqouetATLWOtmcw3rFA0FkS0Uohn+RB48Tz4ho+oWhhByiOCSjbD6GDfzFPPClzN0QvmjY/wUvyXrwwdROqE9lTUYxyUpzTqG5/gRe19SAvGD441yy5iLUNpk33KRVL7INlA3EPbXmMq3M3P8XPXkqx2EKGtIEpLLgX+G65GGr4wUgGKEbvWYpJ7MF5NYf6cCS+3lv6nv5hgwqpz4qdlKCNecGD4AGkH+aVWDNLC1z9v9Fut80wKdvXaHuD16rZA3YHDfjn8O1j3VSwF8IMIO
X-Exchange-RoutingPolicyChecked: FNHfeCgy6HJ2KVk8IF2DyOsNd3hu16eQwmOyiylLgJLdytfZW02ztgFE/QGrY5PGu2lhOnqE9S4xsoWGt811Tb7f0utuSopjW4TUm3wuMpUMvUEjM2mzBhG/FR96YMeOOzZP3Tr4WINV83FbfxqMexMzAhj2P5EFiXfeMSw7neRWuA8jox2fFW8f43pxVpIr/WVmkVexBbMVba3aKFdGHjiWCHs5ZK6F3K0sXh4oSsou+CqFWVk8VgfCFzeqTTJCqronl8kJPG/vIBLx8ml+cnwE9qiURdSwZs3N/G0X5Ffx1blzJPWTMIVYM+1sZG5Bs3n3Q9jTQn0XG3Hi0P9Ezg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:29:45.0276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e423c7-adca-469e-0e15-08ded62debd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8277
X-Authority-Analysis: v=2.4 cv=Q+viJY2a c=1 sm=1 tr=0 ts=6a42f1e5 cx=c_pps
 a=A+iiJIZ7q7LOtbDGyL1ITQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=qoihv-URbusOuAPGV4cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uHgIdJrYDvQOl2n8NBMT9LTBYhhLTscE
X-Proofpoint-ORIG-GUID: uHgIdJrYDvQOl2n8NBMT9LTBYhhLTscE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE5MiBTYWx0ZWRfX6dvgjw+dTPT0
 G2pXD56o/yYjUPo9ioHkx3NtcdY1ev2PXNPzYzAVg38+unOVwQjPQctpztI01TumMCbjBwyyxma
 HeMz3/F5SyrKYAvF6dq9K0MslSQP6Wq0wXLRAfKbSqgK6ygA9Kd+hgbPiP/jfQV4l7xZRkIBL8B
 9+BY89aVrW5BdJtvy4ZOsScFrEY/T0wkia8ZV44EXFN5IlkyHOVOtaGHZh1S70ZXe6NKEybLYJc
 XyceI0/WBo20emY950/Xmhk9yNXVN4r66WNAiJsOgQC0PDI+j2MvCHX7JM1jcYKc9h10B7Mgk7Y
 Ug0F1i9fiX+wzT+BiWWDcpZJTpFjXFI0KtJYBRQP///2eGi8wF7M6mOQlfVS+Gd4cwJ5LtaB3kv
 UXeavdnldEExm+bvTHTHNJHvEt1s4LPUy+5uLm4qWL08TTQgXoSmaw5at7ox0GLAs91ssF33kM5
 c2pzKFxEJGPnq66tiag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE5MiBTYWx0ZWRfXxBkZ0HbWChIE
 nykQzTGjYaF3UQmiARedYDDZw3LKq9TGY/WNTcKbjrOGF/Qahn7c6S3R2diBDmnRan5NRdkR8em
 OPXhZOi5yyFFeoOp1R5l7oLoU8alrjc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290192
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

On Mon Jun 29, 2026 at 3:57 PM CDT, Jonas Karlman wrote:
> Hi Randolph,
>
> On 6/29/2026 10:19 PM, Randolph Sapp wrote:
>> On Mon Jun 29, 2026 at 2:08 PM CDT, Jonas Karlman wrote:
>>> Hi Randolph,
>>>
>>> On 6/29/2026 8:37 PM, Randolph Sapp wrote:
>>>> On Mon Jun 29, 2026 at 1:14 PM CDT, Jonas Karlman wrote:
>>>>> Hi Randolph,
>>>>>
>>>>> On 6/29/2026 7:33 PM, Randolph Sapp wrote:
>>>>>> Hey, glad people are testing this.=20
>>>>>>
>>>>>> On Sat Jun 27, 2026 at 3:48 PM CDT, Jonas Karlman wrote:
>>>>>>> The commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservation=
s")
>>>>>>> removed the suppression of ERROR messages when -EINVAL is returned =
due
>>>>>>> to the memory region not being part of the LMB memory map.
>>>>>>>
>>>>>>> This causes an irrelevant ERROR message during boot, e.g.:
>>>>>>>
>>>>>>>   Model: Radxa ROCK 3B
>>>>>>>   [...]
>>>>>>>   ERROR: reserving fdt memory region failed (addr=3D10f000 size=3D1=
00 flags=3D2): -22
>>>>>>>
>>>>>>> or
>>>>>>>
>>>>>>>   Model: Rockchip RK3288 Asus Tinker Board S
>>>>>>>   [...]
>>>>>>>   ERROR: reserving fdt memory region failed (addr=3Dfe000000 size=
=3D1000000 flags=3D4): -22
>>>>>>>
>>>>>>> FDT correctly contains reserved-memory for 10f000 or fe000000 and U=
-Boot
>>>>>>> correctly does not make these regions available in the LMB memory m=
ap:
>>>>>>>
>>>>>>>   memory[0]      [0x200000-0xefffffff], 0xefe00000 bytes, flags: no=
ne
>>>>>>>   memory[1]      [0x100000000-0x1ffffffff], 0x100000000 bytes, flag=
s: none
>>>>>>>
>>>>>>> or
>>>>>>>
>>>>>>>   memory[0]      [0x0-0x7fffffff], 0x80000000 bytes, flags: none
>>>>>>>
>>>>>>> Ignore -EINVAL errors to restore suppression of this irrelevant ERR=
OR
>>>>>>> message when memory region is not part of the LMB memory map.
>>>>>>>
>>>>>>> Fixes: 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
>>>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>>>> ---
>>>>>>>  boot/image-fdt.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>>>>>>> index 9e0e0f93edd3..603294215b89 100644
>>>>>>> --- a/boot/image-fdt.c
>>>>>>> +++ b/boot/image-fdt.c
>>>>>>> @@ -95,7 +95,7 @@ static void boot_fdt_handle_region(u64 addr, u64 =
size, u32 flags, bool free)
>>>>>>>  		debug("   %s fdt memory region: addr=3D%llx size=3D%llx flags=3D=
%x\n",
>>>>>>>  		      free ? "freed" : "reserved", (unsigned long long)addr,
>>>>>>>  		      (unsigned long long)size, flags);
>>>>>>> -	} else {
>>>>>>> +	} else if (free || ret !=3D -EINVAL) {
>>>>>>
>>>>>> Seems like you messed up the free error reporting here.
>>>>>
>>>>> Not sure what you mean, it is only lmb_alloc_mem() that documents:
>>>>>
>>>>>   -EINVAL if the requested memory region is not part of the LMB memor=
y map
>>>>>
>>>>> and seems to now help print an verbose ERROR message during normal bo=
ot.
>>>>>
>>>>> But maybe we should also ignore free errors?
>>>>>
>>>>>>
>>>>>>>  		printf("ERROR: %s fdt memory region failed (addr=3D%llx size=3D%=
llx flags=3D%x): %ld\n",
>>>>>>>  		       free ? "freeing" : "reserving", (unsigned long long)addr,
>>>>>>>  		       (unsigned long long)size, flags, ret);
>>>>>>
>>>>>> Got a few questions about this particular case though if you don't m=
ind:
>>>>>>
>>>>>> Why do you have reserved regions defined in areas that don't overlap=
 with DDR?
>>>>>
>>>>> E.g. fe000000-ffffffff or similar region is reserved for hw regs, on
>>>>> boards with e.g. 4 GiB DRAM this area is typically unreachable, on a
>>>>> 2 GiB DRAM board there is no overlap.
>>>>>
>>>>> The 10f000 is shmem used for SCMI, so should be defined in DT.
>>>>>
>>>>>> Shouldn't those areas be unused anyway? Why don't we just explicitly=
 ignore
>>>>>> those reservations instead of forwarding them to an allocator that d=
oesn't care?
>>>>>
>>>>> That is what the net effect was prior to the changes in 623f6c5b6ab7
>>>>> ("boot: image-fdt: free old dtb reservations"). Rockchip platform
>>>>> dynamically declare DRAM banks excluding the unusable ranges, and the
>>>>> LMB allocator ignores ranges outside the declared DRAM banks.
>>>>
>>>> Not quite. I mean, we should ignore the region explicitly. As in, we s=
hould
>>>> never even request to reserve regions outside of LMB.
>>>
>>> How would you suggest we do that?
>>>
>>> LMB memory map is internal to lmb and boot_fdt_handle_region() is the
>>> actual function that tries to reserve regions from FDT and would be
>>> where we test if a region is part of memory map or not, so why should i=
t
>>> not be able to do such test based on the error code returned from the
>>> function is would end up calling anyway?
>>>
>>> With above analysis I am even more convinced that this error message
>>> probably could be downgraded to a debug message ;-)
>>>
>>> In what scenarios do you expect this error message to be useful when FD=
T
>>> contains a reserved region that is not part of LMB memory map?
>>=20
>> What about when the FDT contains a reserved region that is part of the L=
MB
>> memory map, but failed to initialize the address pointer correctly?
>
> Please elaborate in what scenario this could happen, any possible
> consequence of such error and how this specific error message help
> end-users.
>

There's not one in this path without something catastrophic happening. That=
's
ignoring my comment directly below though.

>>=20
>> My point is this error code is not specifically reserved for the case yo=
u are
>> describing and may adopt additional functionality in the future. It alre=
ady has
>> one additional case tied to it *today*.
>
> I do not understand, lmb_alloc_mem() is documented as:
>
>   When the allocation is of type @LMB_MEM_ALLOC_ADDR, the return value ca=
n
>   be -EINVAL if the requested memory region is not part of the LMB memory
>   map, and -EEXIST if the requested region is already allocated.
>
> The old behavior prior to the offending commit correctly ignored this
> return value to not produce a verbose ERROR message for regions not part
> of the memory map.
>
> The change in this patch restores logging to such expected behavior.
> Do you prefer a full revert of the offending commit instead of reverting
> logging to old behavior, a downgrade from printf() to debug() or some
> other way to remove this erroneous verbose ERROR message?
>
> Regards,
> Jonas

If -EINVAL is documented as being reserved for the functionality you descri=
bed,
and that is respected, then I'm fine with your initial change.

It's that goofy return path in lmb_alloc_mem for an invalid pointer and the=
 fact
that -EINVAL is so generic that makes me suspect otherwise.

Maybe I'm being paranoid, but it's the lack of warnings that sent me on a w=
ild
goose chase a month ago. Just want to make sure the same thing doesn't happ=
en to
customers or downstream users if it can be avoided.

Now that there is an example of something that needed this functionality, I
think it's a good time to discuss return values. There may be a better valu=
e to
use for allocations outside of LMB controlled regions. Maybe -EFAULT (Bad
Address)? I dunno.

>>=20
>>>>
>>>>>> Why mask a bunch of potentially valid error cases for this explicit =
case?
>>>>>
>>>>> That is what the code have been doing up until now, a different optio=
n
>>>>> could be to change the error message to a debug message? Here I just
>>>>> tried to do a limited revert to the old behavior.
>>>>>
>>>>> Why should we print verbose ERROR messages for something that is not
>>>>> always considered an error?
>>>>
>>>> Because under normal circumstances it should always be an error. Occas=
ionally
>>>> asking for a reservation you know is going to fail and assuming all fa=
ilures of
>>>> that type are OK is a little odd.
>>>>
>>>>>>
>>>>>> Why do none of the examples listed above have a memory node in dts? =
I've seen
>>>>>> platforms that expect memory length to be defined by the bootloader,=
 but they
>>>>>> normally still place a dummy node in the tree at the correct startin=
g address.
>>>>>
>>>>> Rockchip platform dynamically check size of DRAM at runtime and decla=
re
>>>>> DRAM banks for the usable areas. Possible a fixup adds a memory node =
as
>>>>> part of boot into OS.
>>>>>
>>>>> Regards,
>>>>> Jonas
>>>>
>>>> Ah, thanks for the information.
>>=20

