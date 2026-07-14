Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10E2C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 05:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A3684CCB;
	Tue, 14 Jul 2026 07:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="la86sI2A";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GzKDcjiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AFB084CD5; Tue, 14 Jul 2026 07:37:05 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E9E284AE6
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 07:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66E38wdg3901615;
 Tue, 14 Jul 2026 00:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=gFHGDrSYqVrwdAm1eGhN8+A3yD/oLi0OKwU9T8uXc
 /Y=; b=la86sI2AG0H5XLuYtymunSafypTUQFSigXkdPAesrgafgwl9PA8xvTfrU
 1ftK/FNbb5e4rFr0m+UI21z89WlPtsJ0+bduRpx79KGSXKg9kniALdDOa61QZJlk
 mJXtQIU57JstrWuTCmz2QsP/6+Fn3MLqSaD4EdpOINKRB93pFzUYJ0bTwjK4/bvy
 HQ38+KyMipWq2CYCVFUcpM/g7Onj86zmWtizlPWYtIXYr8wxADAKgzvmRHl46Zy/
 VjhbxA7x930RgasnIYk6+uh90ARJFiiVid3lznaLJgNtrYKvWwBGfQXElhQzvuub
 c6ikrBL0CdtS5CqQ1D+9NR8k7Qg7A==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fcxx6nsv5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 00:36:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lknGpXiF1pEgCxFfuX83YpuwcIZn2FtgDjIwnZ0lBf7LYtXJIIKc0d5yN/ImeOm81jbksUeQTDS8IntAoUy2I/kfMnpKWJCGSIvxC+q3Jd0Jpxnw5+Iig2YlGhxralFYLfYiTQZGOsBQMSjxnkMI0xWmpPfY8wHh7grDus5Ar1H7uG/bSrKNw+JT6679TX7J+17vcPazEwZ1C/qaFbigS5G8vTjLXkowUF9sTNBFufKAnFbin+gp1IJqRE3Yc0+sBdoXlPtYRsHoUUdpz+Z9aF1L/x7xB4GYWMwz6LBzl0Wl15s55YomBbF6FyCiEZAw3NJipRee2oSUo9JQ3jGsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFHGDrSYqVrwdAm1eGhN8+A3yD/oLi0OKwU9T8uXc/Y=;
 b=GZaRArIx1FcimSntM03quMkwlEpIRFVKikkxIAF1kQHby4em1VwP12YvtWmztw5F9PSJOACHJkrtzap6MwNYzD57ZOlPxHpmxiLeLOBx1JuJtp/DVMdQLJ0836ABQO1QsdcxFEi0hkqjTI6n02K7hiQB9pnEONC2mPTrxNngCIlR+V1hrQFqHqxXm3TvjTmmIRzA8APdjJJjjVcsxsEoIoWRzsyRCJfOynGQgoc2zNGkXOhkyp6Xa565qeAHfbWB0qvLNz/ufepR4lb4WOcHFxOPe2okic9njz/NhgLb1hrGF0e2PlwcSvzkEXe0lGz5+xzdgSRSQoVHbhulT/zb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFHGDrSYqVrwdAm1eGhN8+A3yD/oLi0OKwU9T8uXc/Y=;
 b=GzKDcjivIKVxUXH0TmOm/zw2aYVxZ0/QkrAS4LZS3JpLu02GrL+Cfj8ftWsi8XPM9hFTjprv4mpyRHyoec3AnxdkFhfQ4CBzn+61IsPSyQdcRgCN35F+uk1MXD0UaHF8raqC/ms0ei0DcRnQFZmfc7VSVdsnfgBQ4i3VoZZbbxw=
Received: from CY5PR19CA0113.namprd19.prod.outlook.com (2603:10b6:930:64::9)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 05:36:48 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::1f) by CY5PR19CA0113.outlook.office365.com
 (2603:10b6:930:64::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 05:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 05:36:47 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 00:36:40 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 00:36:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 00:36:40 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66E5adjJ3381913;
 Tue, 14 Jul 2026 00:36:39 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Jul 2026 11:06:38 +0530
Message-ID: <DJY1UCTC7ECG.1BANI7JZP5A80@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 <francesco.dolcini@toradex.com>, <w.egorov@phytec.de>
Subject: Re: [PATCH 0/6] k3-binman ergonomics
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <g1ZugeI2t3GXZ4xFujgjTQBGM503GAuDUGRY2aBWTF_BAHnHY6kpC3gTKdcpsZMT3w_MYo98bOXeJBBQbcwOdA==@protonmail.internalid>
 <DJXFSHTRFW0L.O5673KW71NI8@ti.com> <87wluzrqx9.fsf@rasmusvillemoes.dk>
In-Reply-To: <87wluzrqx9.fsf@rasmusvillemoes.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1fdcd9-6a1f-4a01-f260-08dee169e595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|6133799003|4133799003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: jymcdJRYNeeaz2NRJX/NIGOpZgA5g5iSv1jwBc+ubNaL5ZmVnKYruWzS1T0+Y4CaeP5OS6EmeiPISv/IAma2Hum383/YQ6XSyh+bk5PP0oQoPVPCiG7cnuBSVx9nRdXiHUcrpHiIBZNZ43qwr6os1tACd8ojT4Oa82CvmeWT1T+IXDY0ccKXzuTq8ij06OikL3tdE1yZqGzS4OBYmdU/dHnZTGXsp0dC+tNiXppBB9AdY3WwtTN3m40qeNB1QUSq2eHpmU68ymFmbI4IakBWCGg11BevbbCv98sScwsmUnU6vY10q9sQ8cxDjMEAKrdJVISQXNvq+hdB3ioprtMH/9SAowvPnTihm6bqQgE1bxJ/4y/R3JP63nmwWQ6ZFTH0FahwbVBUWvmcsYD3TPrmr8joQALZinjmnkqwe3GF8uxpGbFYemAJg63TplNc+y6n24uAPo1tjAuaXT0yKiwWkp4RqiZg4IZzbkyT6pb/DhZoaSL+vnZ1moR7TqQqQfsM2NnNmnTNA2srK40MEw4PAqVTTWbNLrr1Xj//ltqr6qy4FkjxpGhIZGAJkMLk4usIJjWd2tNPxXVVXxJv/vxZARU9mGuP3kMtkNwAAshkzy+bHG7SDyLYZ6CirDdjUIiVxUWfhRZj0Yrd9jl6RoEfORsNumIl76VZLGcnDHRYTyjrr2Zm93wMQmQUSZXFr4DsEB4U0FrAwbMHAJbKnk7hig==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(4133799003)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P1gom3AOl+75Db3WLrGl4bLas/2DqR3HD/dZCEmmGR+SE0hIZthomwGxmWgj6h2HMWUDCVF5zVPRI+eSr6YVX6oGYzODzcqbe/p2qjabLFRecCJZn3GsZ131NF+XHwI5Q9T7IpmAc1uBMS9nMHYMZKb8ukUlfu2w8YR3fGha0cj2XrDIXCiXaZxIZMqqek7Yzy8ad5g1sWKbNei4JU2dJN7AeCVd/gvBUAMI5VQmCcZNjEIuUxTorbb0MkUysmfm4EZKFOMUYCEcWSolOvfvMdej2/aVBvZyUVTB5g2gaDyy4p/lJWLHGCHtfTFDIv7KSZN2TdcnOJY+HMUDJv3P67djuQ8UzgO4PUguWEN8yS6O+86IJ3IEorS6lWapF9aReBjgLU8D97GUCCz0NbhRHXguvY5FLow+3VL6M6dPzNomSEQ1So1tBR0BvPrLk1SK
X-Exchange-RoutingPolicyChecked: DuLE7eDOwQaxpS1teEli4yFpSKVS1T367Obt5CwtQKPvBiZ3ngRVjHcfnjAHsfLxyquqd4nxj9D7WVKeH4ih5xlh0OAb/99Pt51v3GPJQJ5f6Csfixnl5/EtlKs4vFvLTMMY/fjZBvxW8lRcFokb7T6HmWqM9y6ehzn/djJ8wkb/S1XIQi44Ux3A1Ow4FutCet48aMmmI0QdAO1GqYia5qrrj/BKhGb5VR3OECBPNhp7SQa6obJXgcmDy0Fe6jSaOJc9nZYxTYfSGLIFq/iYf12Uac0PdDpEbbleUZ18uwoqScIXjn1ilxYNWlPU0NqmSdhD5PJxW+srogbWs0iveA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 05:36:47.1888 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1fdcd9-6a1f-4a01-f260-08dee169e595
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-ORIG-GUID: Ycl6nJQw4GklAwiLk5qyz6NqXxx4K4de
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfX8mRnB7fBF2V6
 EaxOBjYLBDjSFHu7YQJzIk/1DgWeKrGI2tbuuTYwj5qPfNY4y3MQMz1PRjHuLPIGD1mKzAf8V6T
 Kk0kvUpI9c6FXNkVmSmSqPWx7x0QOKY=
X-Proofpoint-GUID: Ycl6nJQw4GklAwiLk5qyz6NqXxx4K4de
X-Authority-Analysis: v=2.4 cv=S7npBosP c=1 sm=1 tr=0 ts=6a55cafa cx=c_pps
 a=w38J/P5V5yn3hHxCpGhwCA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=KZKKAWG0eBAt09rogFQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA1NSBTYWx0ZWRfX7Uj//rplCLFG
 1J89VQTtHvPOG3nYQox6h6h0nUX1ZACZj0RrT8V1IS3Tg1PfLaYnlEbu633Ra3hnXGPo/RD7FN6
 WjywRB/J9bHOVkRcUtJ98BGVpfpkDwppc5rcj36IGCSQ9y4zlE/yzBQG9/d0henn3CRsTSHXpQ2
 DqGvHTNjDk4cYaFELWluYvFJzPJy5XOAEY0fy460+S7wfto4LNbihoG7PRkBNGLIpAjP3HPYX5h
 ozWsSopYxa863JiEqF2DA4Fuu5JXf9FHR1SRBST40iAaWYr2NVxMUinbXDv9F9+/C8Xu2jawdCV
 11QplvYndpKUEnoDbCQDXn8w8FwK44eGbkiEq08EJg1vKcM1qUpzUsu1u/PAQHrvgDYdSnw2l6H
 JqW8b5k5AL7mqlbY7PAXd18kwh0QqxjJ6CzzbyQLcigSumfYnfrO/Zgc9ObgtCOvs/E6Vt0slQj
 6YdqeD5b+DH/3Z5tigg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140055
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

On Mon Jul 13, 2026 at 6:24 PM IST, Rasmus Villemoes wrote:
> On Mon, Jul 13 2026, "Anshul Dalal" <anshuld@ti.com> wrote:
>
>> On Fri Jul 10, 2026 at 6:06 PM IST, Rasmus Villemoes wrote:
>>> When trying to hook up use of a customer's own signing infrastructure
>>> for some am62x devices, I found it was more difficult than it should
>>> be to point at the right key(s). One has to patch in the keyfile=3D
>>> property in way too many places, and if you miss just one, the build
>>> succeeds using the generic custMpk.pem for the one you missed, but of
>>> course the resulting artifacts are unbootable.
>>>
>>
>> The default value for keyfile i.e custMpk.pem is generated via binman
>> from the custMpk node in binman (defined in k3-binman.dtsi), modifying
>> the filepath to your custom key should work as a single line change as
>> is.
>>
>
> No, because I don't have and will not have the "key" as an actual
> file. And nobody who really cares about security should expose their
> signing keys to the build environment. So I cannot simply change how the
> custMpk.pem key in the (top-level) build-directory gets generated from
> the one in the source tree.
>
> I'm using a pkcs11:object=3D... uri as the keyfile property - that
> works just fine out-of-the-box with a suitable OPENSSL_CONF in the
> environment, so that openssl picks up the right pkcs11 provider module
> and gets a signature that way.
>
> So I really need a way for having a single place to set keyfile =3D
> "pkcs11:object=3D..." and have that be used in all relevant nodes. Yes, I
> see that I should have emphasized that use case more in the commit log
> for patch 4, using that as example instead of "/path/to/own/key.pem".
>
> [In my concrete case, the signing is done by a remote service, but it
> would really be the same issue if one were using a yubikey or some other
> local HSM].
>

I see the use case now, what we have here makes sense. To add to what
Simon said[1] a small section documenting the use of pkcss11:object
inside the node in the k3.rst doc would be good to see.

[1]: https://lore.kernel.org/u-boot/CAFLszTh=3D4fWg6L74vnaJz7O9kOxE68XP3BCJ=
EWVnBvc1aopHJg@mail.gmail.com/

>> Perhaps this could be made more clear by the use of a macro instead of
>> hardcoding the string "custMpk.pem" in all the places to make it more
>> obvious.
>
> Sure, we could introduce a macro and do
>
> #ifndef K3_KEYFILE
> #define K3_KEYFILE "custMpk.pem"
> #endif
>
> at the top of k3-binman.dtsi, but since binman already has the template
> mechanism, that seemed a lot more appropriate to use.

That's fair, we wouldn't need a macro if we replace all instances of
custMpk with the template. I can take that up once this is merged.

Thanks for the patch,
Anshul
