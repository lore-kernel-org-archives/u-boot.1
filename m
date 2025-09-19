Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C2CCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 06:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE48982C84;
	Fri, 19 Sep 2025 08:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="YMNdr0h8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A78B8319C; Fri, 19 Sep 2025 08:36:26 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A263881E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 08:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1357fb2a94=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J5uJm3007513;
 Fri, 19 Sep 2025 08:36:22 +0200
Received: from du2pr03cu002.outbound.protection.outlook.com
 (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxhus5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 08:36:22 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkF1V+iQOqXvgu1gLEbnM3AfGlkKsCe/gzApp5CJTK+8ClfEZRBlmI5BmXVrX/Lvw4ypoD0kF3MZMc/RKMAWnDg8u0YTtXDEpe/p4Jm124MoAj8WY8FV0W/8gAkvL13zZVMWvyD4BM14lQZUx7wXcWwRw9DoDkdxPUu4bN2eSC6ZFjukmPp4uz3JXPophhnU6LrkqDCqvqmCqML2IAMAU5V/33kMHcwbbEx5Pm/yDWDfP1RaTV8gNHzAc77yKDpCa5ReH36/n+jxY/2fOmrzJ7hw3UR2xs/4vSO3dS46O4cGVZEewoc+Lk5rH+gL1XTd4h7gJZ3T93qXKdLMaiQmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucsOuxCFfQtiWeW7j6qsLJBeOR0g5Ot7CuCZD0PfTBo=;
 b=aaeZBfVU2EajLvZJG88hzDPBLUpn1u1xTG7kt1zE9Zs/o63+nYGOngsRyJMtxofCWhgqsO0TU2JIKyDEFsbc/6dA/7gGKeKYZHsLPKNWYVJ0O5jliPkFEvjRrWq7+3eCmJcH1ui7a18R/kisQd3E7B0kZ6PjGPYcogUHOjhOE0ceupC5+uh+DEz2HRiU8+PhK/qwHYlVPuJLj7bsZRL+GD8r6MX26fGfA8eaP+lp7RQWphRPCr7NBvzmo7E0PdJ+0Y1lVlx9ToQSyP37nnD7kaT5t97VnEuaruJny2X/Bua+8mnRd2redSHwm4MSWT47QxDyEm/nxIjWpE2HaPY4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucsOuxCFfQtiWeW7j6qsLJBeOR0g5Ot7CuCZD0PfTBo=;
 b=YMNdr0h8pUiz2pyI6vVd26mEj0KlD6Vmdq5p63p/QBwx/EYuE9Xhk9zxc/xAIoT8YzXpJWa+i4H9P8oVuii2fITOJMmn6aXQrTMJv5bhBMB63f//G9SKJD8QLAqoTyg3Tzo+CMsMeuVPrbYCChFDAJp/QgebB+dEBJufLrc4L5+iIhfgmsANtefWAW/7NDhMSc/swyCwig5K6rO9F8E0T037Fw2PMN1kJ4SZmOy8s3cu1OvKbj3IMNvisebAi2d8BP/J+52j/Z1f6umafZHtDAgH96bQu4b3VHPyzUNLnnbL66j65YXgCC0AH0M1iNPgrgs+4ZNTKOk7pMASYI2C8A==
Received: from DU2PR04CA0278.eurprd04.prod.outlook.com (2603:10a6:10:28c::13)
 by AM7PR10MB3317.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 06:36:20 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::a4) by DU2PR04CA0278.outlook.office365.com
 (2603:10a6:10:28c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 06:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 06:36:19 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 19 Sep
 2025 08:29:17 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 19 Sep
 2025 08:36:18 +0200
Message-ID: <e7ce25bf-c64c-47bf-be8a-158756058ead@foss.st.com>
Date: Fri, 19 Sep 2025 08:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Gatien CHEVALLIER
 <gatien.chevallier@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot next / v2026.01 = u-boot-stm32-20250919
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|AM7PR10MB3317:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c083a9-5c17-4281-0fed-08ddf746d7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVM0aUhVMmRORnM5TUFTRFJlSUxSYnlPRzVRSTBHa1IrcnV5R0E2ZjM0MlNO?=
 =?utf-8?B?SkpUQnBIaFRmUW12WlFqOW12bkNvejJscjRFQUt4K1pKS1NVa1VHZVRxdVhs?=
 =?utf-8?B?Y0hJTk8xVk54Q1lOZlNXU240MDlxRmJzaFoxaTZwUFNrTzhVMDRteUlDcHpN?=
 =?utf-8?B?RmVFTnVGaVR0KzB2M1dZWXVoUGRhSWZjbW9CYzVDMkkzSjBqT2pWc001bmhK?=
 =?utf-8?B?RHdNdmkwVmpVOFQxTVhFbkpnRzZ1bGpsSHY5U3lVYkQ5TXdXYTlGaEVUd0tT?=
 =?utf-8?B?MmlLQXZGdWIvNFRHNEQxT3NnMWNhcVIrWHZlcGN2WDBYQzYxTmdMQXljSlNY?=
 =?utf-8?B?N2Q1VWcvRGpTeUdvN21kaGNWYWxPRDRvbUZWQlZCOTlPdnNBWFJnanJFVG5W?=
 =?utf-8?B?Q1FsY2hpaXluRk5sL1luam12VWlIUjN5S1BiQjlwU29tc05TUUUvMzZVNmE4?=
 =?utf-8?B?WnhUc2o0eUVDQndKUXBwZnE3cHRoaEc4WXlzelhodHZzK3lTcWF0RmNGVWFX?=
 =?utf-8?B?ZGR2NTk4Mm1tWjlESldhY1lCeVZhT1VJTFpLYlM1Y0ZpMDBlTU5PdjZJdHRh?=
 =?utf-8?B?NzFRQ2RJUzg5UXB2Q3k5c0VTaDM0RXJ3M3N5WlpWNmY1R2NmVTlUczZJSEp4?=
 =?utf-8?B?Nk5zUUNPWjNlTzlPYjUyUEFRQjdyd3U1QTRqdjBETUhWZTEya0VPZHA5cTdS?=
 =?utf-8?B?Z3pzaHR5UW9ibnJGNGF3b21oNTQ3MVA2Z3FXOU9sNE55Um01M1BxbnkzYUhZ?=
 =?utf-8?B?N0pwa1plZjYraFowd2VBY2xqaGlhYk84K0xrcE1CWW5pb2NQS0l6WkJUUkVI?=
 =?utf-8?B?dkFyeXIzZEczZ29LVjIydHJQL1NZMlVoNTZXYm55S2xxK2JHMjRuZUFGYnhR?=
 =?utf-8?B?N3oyR2Z1c1RpWk8yMEF6c3gwcFM0Y3doOFZWQ0YvQ3dscXRTQjl1QmllS21z?=
 =?utf-8?B?eTJGRGdLTjY5VG05VVExblR6RVdBMU5qNVMweWhmMjJuSDdrYm43QnhDSlNW?=
 =?utf-8?B?ekZzL3E1TkxDVFVtY1duNkJMaVhldEsvOG53QWxxRXkvWTg0ZmdsTkQ1Y1p2?=
 =?utf-8?B?S3ZQNDVSYVVBRzk3ZXY1MzRsVVFMV3A5d2N2dXBpWk13V25sNWxtVVVMY1ZJ?=
 =?utf-8?B?ZmNHWlMzTFpuaitCY0pKYlhjU3BVYmhSVEgrc0o1ajZUNTR6N3psd2lvV0pQ?=
 =?utf-8?B?ZEdMallwd3B5VkJLYzRxc0tieHk3ZVlzbXRheGI0VXRtbkprTHpiVzEzUHVX?=
 =?utf-8?B?ZFo4eGdEWmV4UEY5bmtUeUM4THY2M2xCeHZnQ1ZnVUlkbUhOZWNwVTRCNEtM?=
 =?utf-8?B?QWw4NGU4RUM5MFZyYVJrNDN2aFJuS2Z2S1NuUHFWUzJ4eWhBR2czWU9OanAz?=
 =?utf-8?B?d2EzUkZ2dDJES0c0S2xXZnpVdFloejlvZjVXdlBWTnJHRzZ3Z1g1Z3BQUnN3?=
 =?utf-8?B?SmJNR0pMQitTY0hPSUVSWjEvaDJidldOVnNYS3JoWTlKN2txSW01dWlLa21z?=
 =?utf-8?B?WDZnR3lzelh1cURnc3RxNW1UMnJvY3VseGM1S1dxbHhZSUtRUzBXTExKelFE?=
 =?utf-8?B?K2dJOUprcEhiRzg0VktINUExZ3B2SGtHeDdrV21SZlJiMHJlK0YvRUw0eDY0?=
 =?utf-8?B?NGcxYUlkOXdNR0xjMHA5Y05PL2FNVGFzWWtxYlFBWkNiak1OVk1UMnNpS2FU?=
 =?utf-8?B?MWZVY1pvMmxydEpDZ0lXMWhDZXllalNuU0RVc0pmSGYrQjRGNExHaTBHd0U0?=
 =?utf-8?B?K3lWVlNvbkhSUitSWDFneDFhL0x6VVFlNS91YjAvb0hObnc0N1ZlQzh2UHBL?=
 =?utf-8?B?K3RmaGY5UFBvbG9Vc2lLZXZDSk90V21qSGtBd2cyZWgwZDh0Uk9jVnpiVlln?=
 =?utf-8?B?b1FmRjZVNk5DR1VRNWdXTXI4WmRkUGVxeklKMjQ1UEVSa054MlloVXlBQkFU?=
 =?utf-8?B?N2phSDZtYWxSdVAzUEpUNDlUSVZHSkJiNkNHODZjRU11L0VRdTNSYzFIQzlZ?=
 =?utf-8?B?RmFXc2YwR2JnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 06:36:19.7847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c083a9-5c17-4281-0fed-08ddf746d7f3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3317
X-Authority-Analysis: v=2.4 cv=K9MiHzWI c=1 sm=1 tr=0 ts=68ccf9e6 cx=c_pps
 a=LJBxCQyVg3xmomCYv/4OGw==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=YfCOm-DyAAAA:8
 a=HPMVuBc_cI1Ognop4FYA:9 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/ggJCLuXyO+r
 LhzjN9mCuZ4vZoBLfrdJiJF2NLaf2Sl6P08ccTJUWWCXAoB74xMTlzAjzHEdVTI0VnkUaMWlpqu
 4IFgF6hAhj111+BzNWsfgV8LJHYvw2ILQnayeiXoSIuYMbWZ/zEHEhSTEItdCAHOUWPMQMMaSLx
 /bFoIZS0e7KJihdyLt712qK5sdPJCXwzDgkVPTOFrrxAZN0g/JUWReOlKrR37v3khXKJ86MuI8+
 Dr2oC6+VIB376LQJJZcAVlTpQAMo77Z+4ggLYMxH4SpvHhTTVOktpm0Q9j9ELYsCf9jUf32rFFZ
 OkUV15oBfksv4iPcBHQBcfiwsOF8v6mhDurhe4XeoAeNFD9VgsveltGolWvyrlH3v1Nfxx+HIU5
 ysVFlefH
X-Proofpoint-ORIG-GUID: n_jZ5V7nfVYsN4C29Ep0M9RpI9gZVUyu
X-Proofpoint-GUID: n_jZ5V7nfVYsN4C29Ep0M9RpI9gZVUyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
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

Hi Tom, 

Please pull the STM32 related patches for u-boot/next, v2026.01 = u-boot-stm32-20250919

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27668

Thanks
Patrice


The following changes since commit a209627ed7921f40669f5c0795570d40e77e4cb7:

  Merge patch series "board: dhelectronics: Check pointer before access in dh_get_value_from_eeprom_buffer()" (2025-09-16 16:14:30 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250919

for you to fetch changes up to b8edd54d6022e09c5b2e9a87ede34fc0f019638d:

  ARM: dts: Add flash0 partitions for stm32mp257f-ev1-u-boot (2025-09-18 17:20:39 +0200)

----------------------------------------------------------------
STM32MP2:
  - Add SPI flashes support
  - Add RIFSC system bus driver fixes

----------------------------------------------------------------
Gatien Chevallier (2):
      ARM: stm32mp: fix RIFSC semaphores acquisition
      ARM: stm32mp: replace RIFSC check access APIs

Patrice Chotard (5):
      ioport: Add resource check helpers
      memory: Add STM32 Octo Memory Manager driver
      spi: Add STM32MP2 Octo-SPI driver support
      configs: stm32mp25: Enable configs flags related to SPI flashes.
      ARM: dts: Add flash0 partitions for stm32mp257f-ev1-u-boot

 MAINTAINERS                              |   2 +
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi |  41 ++++++++++++++
 arch/arm/mach-stm32mp/include/mach/rif.h |  48 +++++++++++++---
 arch/arm/mach-stm32mp/stm32mp2/rifsc.c   | 130 ++++++++++++++++++++++++++------------------
 configs/stm32mp25_defconfig              |  15 ++++-
 drivers/clk/stm32/clk-stm32mp25.c        |   2 +-
 drivers/memory/Kconfig                   |  17 ++++++
 drivers/memory/Makefile                  |   1 +
 drivers/memory/stm32_omm.c               | 421 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/Kconfig                      |   8 +++
 drivers/spi/Makefile                     |   1 +
 drivers/spi/stm32_ospi.c                 | 623 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioport.h                   |  16 ++++++
 13 files changed, 1262 insertions(+), 63 deletions(-)
 create mode 100644 drivers/memory/stm32_omm.c
 create mode 100644 drivers/spi/stm32_ospi.c
