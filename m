Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EB2CD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 19:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2003C84931;
	Mon, 22 Jun 2026 21:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mL1q28J3";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fTMb96Io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82FD849BA; Mon, 22 Jun 2026 21:15:22 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517DE848EB
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65MFWFLF3196290;
 Mon, 22 Jun 2026 14:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=gsjz7ClENqG6VgOmM+EVOfvl3aHELLSrPY5CmybzZ
 Pg=; b=mL1q28J3Rbh/3EPeIbYOJgmYBHMjpnA4CI62G2SXsEtGBVXwdqHCh+FvL
 jCiAXhkiq7EIeYU2l8PjDoiV2G7G+yWACM8puhpR9jyWuxAcAkuCSfFxpRSdRQeO
 EKttWB56hWkvFWXIlA7ODoTe9ZKjvp7wq7iYetKTB92kHHWo/IHafV1sBVcRgHYM
 /rOZV0VjkAZ4ZaIFk0c1wefYq4p9v14Py8wdFOnYZhBzop1oQU/aE/1r7d4AhPkM
 CPGPMOjvJCArAeRGbI/4rduEFxAhUnceh54qfz5dDUfHj53HcE8Skssq1qgEHDEe
 zoxh9lxoxhveF2iMBkb4e8Y7WLkhA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ey04ebxaf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:15:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmAcYLybrXI1ew8GVuiJjg3kx84gFjhadAmn1zq70e0P8B97COV52uCBFNWGwaKkYlxCkOP1Hs5It14Eum4Bog6MJcKcIzOtw8Alg6vdhtHj/kcvV6GEOa7kFhLxLuCUfIN1s4Gp8BFeRt0upPQE37GEoUwmoCasjOSolJUSp9Te/XvD0hTJjVgaxdkA06bTJy79yzIsz7VV9pdJVO0dT5AGlqLUK86ZQM3D+2HMJeDesaTXPSdL5nuBXfy2SBkhsZRMth3waCL0inauH8//avZDnp+UlPH5l2TuXJA+sP895TDBAWhW1A88xAi0K/Cr0nuUepSdXS9K5gSefsWwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsjz7ClENqG6VgOmM+EVOfvl3aHELLSrPY5CmybzZPg=;
 b=SstsxFH+2Y+YySEwyNkrzMYENLRFsXAtpUAZBe7cOd05JgZA8fbNBNDIWiMWu3cBQCKnONBnpY94zAJG618ShxYJlYB7HffCkZl2gAPyfw32zqRvBbCmzq4zz//8KNX6YiaheYRPxqZyoZNlMA8pRViAJEmfo0lDSLjoHmYsv5hMGlwZ02tsGzGUl0/dUXUpB4PM2pRs+T/vDtC9O8sN4CCPvZ4Z5l2yRcSChkqIfj2iPYdNiJOkQ0ijdCR01OjyaF6HLb5OVjChroGPql6oWkBs9R0RLLGuJtkICZMvSW62uApgaHDVJ6L/TMwZI7liLZAbN/ATN/3D+vM2XjldKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsjz7ClENqG6VgOmM+EVOfvl3aHELLSrPY5CmybzZPg=;
 b=fTMb96IovRfXfgaebHrtAoRl9NmODRd7A6DtWgZR+eC42ybjP5mMY7oAIyw1TT21utr36WQaCVRm/P/9s6TBgQ89Yqjmi0GvgNOW/Y83+UHdaThgWzLvdFJJ6EEmqR4YiY5lWmu1sO58+e/1Q4Cab+ThYUPRqobnziqvwdYXaGo=
Received: from PH7P221CA0083.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::8)
 by IA4PR10MB8424.namprd10.prod.outlook.com (2603:10b6:208:56d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 19:15:05 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::57) by PH7P221CA0083.outlook.office365.com
 (2603:10b6:510:328::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 19:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 19:15:03 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 14:15:02 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 14:15:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 22 Jun 2026 14:15:01 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65MJF10P578699;
 Mon, 22 Jun 2026 14:15:01 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Jun 2026 14:15:01 -0500
Message-ID: <DJFTGZ0I5LGG.218A8NZ1QBD6G@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCHv2 1/5] board_f: add a board_setup_dest_addr function
From: Randolph Sapp <rs@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <rs@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260619231719.3823195-1-rs@ti.com>
 <20260619231719.3823195-2-rs@ti.com>
 <CAC_iWjLszH6_c4DXFV2qqQoyhEC9R7emeOKoBO4WvEn5Zza2SA@mail.gmail.com>
In-Reply-To: <CAC_iWjLszH6_c4DXFV2qqQoyhEC9R7emeOKoBO4WvEn5Zza2SA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|IA4PR10MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e14a392-775b-494e-3bd5-08ded0928fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|22082099003|18002099003|56012099006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: fsT/alnK4RKlOrsb9xSbJNPL19gYslWIllusPlB4Glro5caN4BwHXZdGBuf0BKMRoOv8Pzoio/LeZfIUVyahipsPPP7Nas/Gm8ba4X/xs9GOGjnieRVX2Hdrg2rcNQz/zokROuEXAF90fP6W7S464lpR4uYc4QZR6IT2HknUhXao2e/vkhcV+5xebtiWz4YdUcX3rGPYDrsa4cMrUjQpwPKMmxl/Z0rRr3KdlVyllvWGXGT3IoXGZ6lkBe6/4ctdWFHWPtz1DKN+UAMBItPQdANzQNSQx+Tk4FGHRQ/Z4hzX9SbwGgbC9Ft/w/gv6zCkL6wn1zR6YZyYhqTP8tY4VZxWQTBCNT3ztPZh0t05motZmhdMIQXeDHi5QbVw5/BHoTXJVXE0WHfcVhJR6gUUzPEW4rv87iCL4QIBZyL/usx2UMJDcgOYG8G8n3XwxYUmxbpINb5TSSED+imTDUkBoj+7ALnn19HZzKD9cDDq7P7IcXlRhjtWC+Et5KLDYpVPvjVCVT2S3pLpCWsg64ojv5aqzKijRE7Htc1P4lp1ObvpormH4CeK7Zf42nkS9LYI/OuPNnDpKMEhok46ESTdjdCdHUqLT0ZCs4+hwBBh2EocEGEA5Btvi0KxumQko257c9GQcjVPv8UB/pFLP2J2GIQapRGuqt+UX5x5rTDXVZJen1CxLS6VfrTogpiKa0pUibp034wf19uEWzhoQAeR/g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J3QbOPbh95T2BZhs73njqD/5uE/1d0Xj6ZzCntfKhu1t+q9zxCWHjkw8x0ktKfD5/wCp92PGJIb4r8BaUvyPCXs/j98lheAb7+TFKp1lPSHJeHwfwARpq0/FV6xwv+Owr6Pw5FjdNq91ZTVGsTVw0abtirpY1umJbYTvMw+prxPbaJqCWCB+DxWg5XjL6lI8zevZ/ncVYiiZjixghNDjQqz4xBhJOXf8kRSN4SbeTuQplUJWdDXIjdZCxpmfk4ooPQVTQBV7PDTcC50FpcQxpUwAwI+FSK4e4wQwkYxPYBCwo33KkdPK3+0t0IP4L191k0NgispUakO2xCIrMbmLeXVxWotfjQeTCg4IYtfiAS6LlvSspbsj78fbyKQY86HuGGXgAq/BJlMR2mwb/q6BTCEM9RhFXAtojBZno3fMC0EKlHpNLL31aKk72mZ4+riO
X-Exchange-RoutingPolicyChecked: OGXRB9cbJSBgOXf/YCGhdyjT8qe313ynJQBqU7Ju3lG+z2W4CUoOse5ZHLII5x93gYZAVGgEJvq6eyvyfSw6LG09uuZJt74Qvpxj5KzMpDVn+o6iVGPfPpUNUYf4LEN/U6+/BDb+ZJKWABhNe/eQMD9cwQxvhLGP4sJaZ5++cKaAQCFYKnKEWF8eLmeDklq+dNiZaMtKU/HI3TdLnejvsokScc3pgFbeT4YBS5Fw60Lktshvz7Yg4Df/zco/KYEjKCyTQ7MIlO6DForaf4n7NXej+kZBF519mboftP2D1Ln2kinsMxC/7HKRT354Vbvq1faOuti7sZgGDuUxZ1KLDw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 19:15:03.2041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e14a392-775b-494e-3bd5-08ded0928fff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8424
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4NyBTYWx0ZWRfX5pK1r4PwDDHH
 0ycfSP0DqHdpuXY0/OkeuAQD4U1KD6dENFUx5Dtmz/JkyG4m6JS1hOV3JI7BFFrKZgqlYQkj5sC
 jm2XR12h/nAMaJZLLWVGCPwAM/M5YT8=
X-Authority-Analysis: v=2.4 cv=X/Fi7mTe c=1 sm=1 tr=0 ts=6a3989bd cx=c_pps
 a=9kClBOisnrQnHM/oUG6sgA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=avX7pZ9RvaPbP4zhlxMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4NyBTYWx0ZWRfX9wVYgjYLTbUg
 AjkX4otd9NnWWWy1IYSpnzTWa0GkG0R4TPXl78thtCgNyz0pmb8yanC0Ac5DWsjCu/gCkNnCZ3x
 H0VYMaN4GtHwmEOsMyKKkW2l0woLGLGXe2OJddsa5iYdTpmd7kRCnnRfV79RkdIjPo5XwMZ985Q
 sGvZIxDuhEk+GivPWpEEVrwaHlZ3zPQ1R/afHGCUf9nnr5wraXTzCjuSWHzrjyg/xd0LFF9EXtb
 w/z0qiL303AcwOE/p3rSZhw6MdSww5vmwnlNenrQ1HQy+xCrMANl301ikO7jOAYvRWmWSeBgHtS
 TRWzHS0pR0CLssamt+7FrpHJzvdfel0mFIbeHBNLEARbAFsnA0zzMb8tP2rSFtNSJ/XdtUL4F6l
 ZxhY3Ham72xlI8jC9HisuXZC/smmM4oHwZpphIuK78z1lJnBbUPhuh+E0gQfvtqOqMiBBX+eX4i
 MWtr0U7t+XUEUu4sNIw==
X-Proofpoint-ORIG-GUID: FK6Xwrpxlpb4OPTZLUJ5UmN__5c6S9wD
X-Proofpoint-GUID: FK6Xwrpxlpb4OPTZLUJ5UmN__5c6S9wD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220187
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

On Mon Jun 22, 2026 at 3:12 AM CDT, Ilias Apalodimas wrote:
> Hi Randolph
>
> On Sat, 20 Jun 2026 at 02:17, <rs@ti.com> wrote:
>>
>> From: Randolph Sapp <rs@ti.com>
>>
>> Add a weak definition for board_setup_dest_addr, as a way for specific
>> boards to override the gd->relocaddr address before the relocation
>> actually occurs.
>>
>> Signed-off-by: Randolph Sapp <rs@ti.com>
>> ---
>
> board_get_usable_ram_top() can be used instead.
>
> Cheers
> /Ilias

It *could*. Just felt a little weird to artificially restrict the usable me=
mory
because the stack just barely runs into one of our reserved regions long en=
ough
to break a dt reserved-memory allocation.

Initially this was proposed because there are multiple runtimes with their =
own
allocation techniques that could potentially take advantage of that space. =
If
it's still preferable to use board_get_usable_ram_top though I will change =
it.

>>  common/board_f.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/common/board_f.c b/common/board_f.c
>> index fdb3577fec09..d9d09ac94bf2 100644
>> --- a/common/board_f.c
>> +++ b/common/board_f.c
>> @@ -328,6 +328,11 @@ __weak int arch_setup_dest_addr(void)
>>         return 0;
>>  }
>>
>> +__weak int board_setup_dest_addr(void)
>> +{
>> +       return 0;
>> +}
>> +
>>  static int setup_dest_addr(void)
>>  {
>>         int ret;
>> @@ -362,6 +367,10 @@ static int setup_dest_addr(void)
>>         if (ret)
>>                 return ret;
>>
>> +       ret =3D board_setup_dest_addr();
>> +       if (ret)
>> +               return ret;
>> +
>>         gd->initial_relocaddr =3D gd->relocaddr;
>>         return 0;
>>  }
>> --
>> 2.54.0
>>

