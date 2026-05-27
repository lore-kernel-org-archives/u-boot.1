Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09456CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11366848A1;
	Thu, 28 May 2026 01:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="FMZkmuub";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="c7H0/q/X";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="c7sjxyCH";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="AnTiZIaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BF38489D; Thu, 28 May 2026 01:13:28 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED451846E2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64RKif9H1297284
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:13:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=QVK
 FRbJCwwkP21euQJ+YXBGOyScBbK6j0i6lv4k6AhQ=; b=FMZkmuubeAsPjhSJQQo
 tnLPtfMmzpARDxNuoXcQDXZ8TPoNXnEAIrGkLCBLzRVvdn/VGPr1J6agU0CnyANs
 DF9iDSKzIl5JEqbVqU8QPCtT+Y4ucG/mc7rwHy2fpa+Mo7eR/KiIWUchug+mozRe
 ZFm1gxJ/DsgHs1Qbhq/1Md6NOwjDGrsV4jQXY917FgxGY0DrWwDoVsfCFOOMsvym
 jMijklp0BRl/bE6prXpkXFvO1VCuiaVNOmb8O/OyAkd2iUEZ7BUTRIvQXyCO+4HL
 RkbLnnwBq5MzLckR4zucFc9d5fWdMO8C7yIVAaD6MYVPzWTXpV53KtDMDwAYEgsP
 pjQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
 by m0482515.ppops.net (PPS) with ESMTPS id 4ee7wugup5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 16:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/hIpEKCrMfYiW+KiMUdvBv9L0nJZMB0IIFHCTx1B9WQU3+c1HiYG70wYHnb0Z+gafUcB5YaxGIhTwoj6Y2VfTJvOvpuotfbAB3LVMvvnhFFUy5x+T8pzLshENqmqZ9J73QBiVqZzmOjFwqfbwujKECqtfnqmcXlOLt8IftUAxita7jZx9FMvO73bYQAJ+9/RHWyp/Wb9KF5Z9IXEBK9gmpuMJj8/JfdKIbmUDiR+R71rUqb1QPuRn/ARF7LLUfngJT/UQSSih4F4xPIAYZTjqm2G3XJbOHKhPixyw2ywSiOf3f25PKCDiOrsRhji/ekP1x8eUPkqG3EmDiMn1bdog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVKFRbJCwwkP21euQJ+YXBGOyScBbK6j0i6lv4k6AhQ=;
 b=q+q4ggWmpXvUcd4WkECLm58MOJel0GCQieepGHnUPDp5ZDiAkdBsZ2d4G6lXjLhvMheXWaruibnZlUMGKS7lFYAfSXaPgcaNLr1lXMiZUe217BtKtSB9yOUQU2T/HcIwUG89AxTpLYaFVuy2bihylwBkuD2jS/iyYgd02pbBP949oPfSn7nqExRQwF3wen37f+0rr7GVsEKc8frijhwb/7pI2gMjrMXya+BPib8xrvGt5Iz5zbsaYymkOKZBhAx53L27JW+MFbIFyELpqkjww2b1gf2Y9FYSROofxHszLkJ4gbRSEYnChXbOhyoBxJG/7AqFKt8ajdGTaldk5WRDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVKFRbJCwwkP21euQJ+YXBGOyScBbK6j0i6lv4k6AhQ=;
 b=c7H0/q/XHNDR6nsclYNc87jXTzzgGVm+l8C4VeUHxSLbcJ+ueH80sCKU6OrrCZYslxuAkpduo5mtJW9se7OqQaGv3gkZwcVSElR8dkBze7PNYqUrG3WAX03dDhWmrdETmb5lIe7PUIH9GwZHp1lvSi6Y75Fx8rIVlPeBaTcZQjw=
Received: from SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::22)
 by DS4PR16MB6875.namprd16.prod.outlook.com (2603:10b6:8:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 23:13:19 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::80) by SA1P222CA0163.outlook.office365.com
 (2603:10b6:806:3c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Wed, 27
 May 2026 23:13:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 23:13:19 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjTTt3452365
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=QVKFRbJCwwkP21euQJ+YXBGOyScBbK6j0i6lv4k6AhQ=; b=
 c7sjxyCHPlJejCECYezfs/sWS1Iv4XL3C/L6gL2a0u87/r2ETv6hyXio5ksVuDw6
 EEQ8atbgAde0m0MxdW8hgddSb9AkB8Nb4wmxMzrCUP4x490X0bQgJ1L9jIXbFdtK
 xth4OGR2NsegO5/VpANsjKad6E/jG89DzlI92r9NmhJxudU+DwAoMMkuHB0Rpjeg
 lgFOXSMThmgRSEQYGLw8DszrZTiwmLkAgr3wGMD/qRWgPJwMdUwIr5QGgl4WQ52p
 n8MbT6708lWFDSXEA8x8rM8Don2ZDKoEBg1s5rSE+T7g2P9l34q0l6uHtyuQI/CM
 wb4PEkgfU/RGSoJZ0ty2MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=QVKFRbJ
 CwwkP21euQJ+YXBGOyScBbK6j0i6lv4k6AhQ=; b=AnTiZIaMVGub5i/xp8E+oPo
 NjSByYg6G+03Xgp5Px1LU6PASwLPny+Smnrvpzy0uSX/95YRE1U6IMaH+Ck+rf1x
 iJz/668oLlmugt4X0/jHcKOLrRY401Asxi+4w/M2VDhD7dNy4xre7X0j8yCf1Kfg
 YSOYNyzgVrpV5uy1v/dKH7SHoRJExCKst/BizCbf0cePvIDc4RNu+oJl+wVQjXsr
 Kd2sgL2aUMAYBbZnxPr4BVyC4sSqbKQyDI42Q5kiNo5NJRHQTB3sG16xLxyCih59
 OCnvAjh5COmiG5yD4WxSxPK/Gs0T6RgsMp8D0N1VVbas4ipIdqOYqgKbLN+PS0g=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x8845b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:18 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SNR7wfbJtevQgSNR7wwi44; Wed, 27 May 2026 23:13:18 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SNR7wfbJtevQgSNR7wwi44
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 4/6] reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
Date: Wed, 27 May 2026 16:13:04 -0700
Message-ID: <20260527231306.1714741-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527231306.1714741-1-dmukhin@ford.com>
References: <20260527231306.1714741-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270231
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS4PR16MB6875:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a1b2a5f-5930-4118-e893-08debc458a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zD5JlVuzJL3RCJGFteaA3IA8to/xdpuUXf++hllu+VLTl7+CBWxe2G+uGjP5mNGGjOf/rBCkf922dOxnu2gdrCu8Q4JC3eKWH1FMCcTmeSIysX6UkUkuAvYSs2BeYUzD/+lv/A5YAYGZNERnbRbNrOubYYgRKnuy5xYzw4Yxfn4kMU6tie/upywBm7+VLwu8IukFkvfr8bb3B5tni2zrcpUqztRG1XBAMDIfwFziVaL7lOr5ZEGBe9wwi7vfLuNokAJXQX+YbBhJMtM2bWPzWXVJ/FmF5IQtYvKyHj09kLQAbfYWulrmjsjFk43kRQm4eL+UIejjrk4qGGmq36d8181J46vf0tg9t83Eu4EFhx4oavHwnLL4/ia/pn2E5bTFYY7h6Y7lCPpDrLS5KmMdgHkzfUtkYEu+1kaS26ZdRG0cc1AoztwmdATMVEmSu0OIzFtIxv+EIW1SSJqkkm4kSbNBHflzTyfcBPVcdtZkD4lCyeuHHpnFQFDi9m7YyOr7f7hDllC+LMitTpbixk2LatAhyWcV5uhV14F8WwKiEH2ZP+vgJEX16A6aoFfFJN6Q97aaHB7njcqxcWVAf6kka66zHxuc6cn+HK0fIbtT+/H68285eoWyEJLN27FP6q96MG+DhXvwFTm8jP8HCecY/b2qEdr15efJ2O1L9zd/t7qDUnpcRLgyZ7obe9tNK0xG5a+oX8R7EUf9TaZj5zsspeJxsWotDjhbiiowbn0lxHk=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VASuZNlfhQOvAVEUZ6v7fGt45yTqqLmwgl6tZ2qCgK4KFmBH9I4oVpoBzQMf2tj+TtDLr3BOTnnkYDWJApa//1YKTNBlAhtK7I/Yo9foMqVa5HBRxW5s0OHeubQgt5jRoyCXrUMTeaWrNwLFuzkvVaQyVDYBmy2gx+GYCL4iZMJPoj9Y8X7WQmnZbt5GS2t3dmWBWEBACElPDkcnTlKplUfTkO5sgKePy+aDGP0TOMADgww5oNha+lpUyZNgk5FJ0OL6V2yOVtA2fzcoWu5YG6M3D6P+FM3/jARzMDsXYSq9PoQMTQkhhUTW6BZ+9YUT7vohUAQ00tAWMjaLgVBygEhCI87YL+LJK2GhavtcGRC/JyIAMu9hTAHjxcw1qOrY+PrVTs2TquF0veiQeDSpifaATXttjtUyaT36r4rl3oqTOWKG3UFcobYEzQqpp1d1
X-Exchange-RoutingPolicyChecked: VjJA0Kpocxjho4KG2nfcQ5bER86maL139HcMUxGEiUizrcWBQGCUkh3ZHEA6Xrn4b1BNtcFaaQ6t/HKsasEqZAg2i6CcvDt6kcSXb3bozLa+UvTvCQh+rjUvy5NutikN3OpCg5RIyuhA3hxKv4hTMrDlO7Q5Vm8h4nIOEy9Fy8EUne0fG2wb8Ywm6n2378spj3VoFBp8vpKj/GvGXXGIQvVuAUp2+xYnXx/ISmi/fmbD2wQBsZBX37+voFyUL93eJswmefKPbl/4jDGfYDj+TqO1poXJkYlW/QGxUR/JkKYA/nSW9wiB8gItB1ntG63wQT8WZVehUMx/loRdy4IeWg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QEPcysFyeAAAhFM/hKb3nEg+3Y9owQsdMEUTC6TKqt3/cU+T1yvgN8OWgpshNk2rDN0AOzAfEOPJNAlwnf5pGAeAmODWTfMliosfUS5eSKFLgYOZTYaa6VdbcV5riNF2IcxpAjZRgPzQ+b9ZlAjQx8Xj4nFFKujDB/sRUbdctdKtJklI1l3V856zjnXB5c6Cpt0HsH1Y4UQFbhRus4Vcg9BCXJIu/S6wkGgzSl+PKb+34New/D9mRw/d57efiwkfxN4OSEK2DUXzLpuY8ZqvMkG8cR+82noyWeuBPedVLJ70Oo94SuIR9RbKwU0xN4zD3F/g9sWHqE/0YP4O3HDOsHDr1eO/c/XO2s5x/l6cJ2ZGmhtnHMcd5bM6ktQLcDwJ9IxQ3lSIvMTMWVl3B02Uu7Ao0hiv7lw8XpK6Z1B9s5GFdZP4jXreZ/uE8TiYf3yBNgLHOb7x7wL2jZbKKZ1jkW6hGqblsECbHy1Rp1zF53d9ZhyQQJq8d2xh6UuS/PYDPSj8zV7nJ02cH4LjFsxlugFTB8Is10U39Inoe8+tf/2sj2umJifOb9jIqFa1uMNAZHhlCRQ6LyeSDRPld9kIkwQEXw5WiWtWzInfKmXpOOtMHtI+Z0fge+dScbzkWnnIDn3unBF1C3vrrxaKpWrhmg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:13:19.4958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1b2a5f-5930-4118-e893-08debc458a88
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR16MB6875
X-Proofpoint-ORIG-GUID: UPCOcOnnVx--Z8NUgGYXY0DAC48RO7HF
X-Proofpoint-GUID: UPCOcOnnVx--Z8NUgGYXY0DAC48RO7HF
X-Authority-Analysis: v=2.4 cv=L8QtheT8 c=1 sm=1 tr=0 ts=6a177a94 cx=c_pps
 a=23BBZRleo/1KOgyGqX6yRw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22 a=cbNQJ9GKAAAA:8
 a=vSM5nWOnqLUKsW1qPdsA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIzMiBTYWx0ZWRfX7NHrLZElpD+c
 3bpvoVxdyzm8zd/jr+2D2MPU+iy+AxTYCJx8++LoTZ76Ke1FMfZccGY/6TpvnbWAPMdqYGJsAXQ
 vLKvMrWBvISIHETaP8F7+FA0kvmjiCGHUcKizjdYmdaJ28YTxuTqOLvcjIM952oL8mVGPecO77d
 LSSnT4FW1O4NqLQYDUdvDL87dSR/PsNzbUhGWZQePTizg1WtFufJuIDKEeFoVKzEyk7qTlfOPvq
 Y1G7UzJEhyyHzRZ8vJgs0/DIoRrnEXp5H4zJnRRLfoz6uIaEOglhfdvs7g5mPbXd8Elnzq86I9+
 e9//U2+Jwp12aL/08dUJs7LzXUTlwsMZfI/mPuEYxPXkdcYMiKGRPP90smYz6skcxg9xyhI5zpw
 o3jCkPzf/+3YPvsUjdFw5IRjIJbI4gbFWh5YnpvjPts5r192fRvHbVN7fJwcqXoap/lqcbZWtye
 8sgsmki7EWJQ5UwSKJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0
 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270232
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

From: Denis Mukhin <dmukhin@ford.com> 

Use cpu_hlt() instead of open-coded "hlt" in pch_sysreset_power_off().

Also, replace the open-coded busy loop in efi_reset_system() and use
cpu_hlt().

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- dropped unneeded #include
- corrected the commit message
---
 drivers/sysreset/sysreset_x86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index c2f28c65280f..afb77d9c5c21 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -65,7 +65,7 @@ int pch_sysreset_power_off(struct udevice *dev)
 	outl(reg32, pm.base + pm.pm1_cnt_ofs);
 
 	for (;;)
-		asm("hlt");
+		cpu_hlt();
 }
 
 static int x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
@@ -120,7 +120,8 @@ void __efi_runtime EFIAPI efi_reset_system(
 
 	/* TODO EFI_RESET_SHUTDOWN */
 
-	while (1) { }
+	for (;;)
+		cpu_hlt();
 }
 #endif
 
-- 
2.54.0

