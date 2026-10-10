Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D73DCA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 07:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1A5560650;
	Sat, 10 Oct 2026 07:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H58hWriYPTC6; Sat, 10 Oct 2026 07:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B4946066F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791618941;
	b=AQySexSJk0nAOYOw/Hf2xtligXeDWGdDj8wb/OvRbTHxu0hUSSh4OEWGpBUyCPRz33DU
	 JuiJSZ2zt7GDq+feyFZ4pFXNkbvRiwVvNGX3aryaNGkwI9uV/Q386zusLFjgjCkb0btlx
	 e6H35syXKlmc0ddX3dmWZdHROLnYSeGFO7+e0mrzf1g+ka7usEnoklDT0He9Y6QdFF+ya
	 hWjG8F/CkIAbXOT+mqGunBcdhONXw6UpcZ5P9HHjidTAeAj8rSo5HRXOW6HPKsAskaAJ3
	 raR1Go0CE4DH68hLA5Q/aiObuVioF0iAEhCdAPp4j4ILy8fpcvm+2n68qEdJAvLjTXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791618941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OSh1xT0EZ4mu7MvBhwbZYO/lGz5WOjTI1FgbEQbZ+yo=;
	b=i3BEJN1SFPc8DY75zwwpeIy2jDGOYxKnlxBgnBnzXgUuQXQHyYVDTky2FN1xW8KNE9ks
	 HVQsRadVS/+JneW9GQu5x4S8psxlPqBExPV5k3Qk5F9S33zGUZNrw3LF9w704YVsJW3tt
	 hsk5qwbyWq1W5zA+T7sM9F0D4hKFNT3Bw+lNsChkx/UjWJ885zlCWSNjCtMPIde0gHOCX
	 3aM8fjyCWZzqPB/i+f9yu6hOkUqo2uQD8AUbdps8oku5sf9/6wwxpWlAXBhOEkXKu7ItH
	 GWwhZgzHmpP+3gHK5F2UpjlRVJeHRltKX1amYrnXJZ69rdjfJ+uX3dDorHGUnvhsnXA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791618941;
	bh=OSh1xT0EZ4mu7MvBhwbZYO/lGz5WOjTI1FgbEQbZ+yo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=joh39T2U+Y8D4mFx9WkpO3NANCXpX+9vgCJYB92prZCn6eEbU8leDiUqSS9qAUybD
	 V0LfwfK9j7GXs7T8QvSr5oPz/zMvmoDlOMn9OgcyCshZ+pQzfsh7yqnG49APk75nGt
	 vP+jOlKGJy4Lb7cSBTs5l6IdCXkRgHOvL8IQdDhxsfNXH29ZR9FnE4Kk4V4bi9vEQK
	 Ybt6yhXKkelnQE+iVoXdnkowGNFDmXI+L3Admpn6XLpAOQ1WYNrERPSQm8KdjUilAf
	 SDRVnd8VhORyUC33r/ClufK/oY6MeSm3/zG2Qer1KY/cie3PD0f3vFhcpMBx5i4nAq
	 8ulS0+DVdj/5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B4946066F;
	Sat, 10 Oct 2026 07:55:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 654D5380
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54C35400CC
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Siw1hqVXDBaD for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 07:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 611D84006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791618932;
 b=G+2Lg2Au0J1wPxYO9q9DtkMIc8x96+TsUhOZvu6KdyrwdKyyxNSURVczuPPTv8WINYKe
 8QrUwHaQVl6f2FBpB6MoSSN8RiE8dpq+Ih+t3KsEJtEU3AVSXENpuCfGX6Cbhejozrnll
 puyU77wAX2hoGzilcFivqFQv2lvupsbNPa+kmKxiN85lri97R91wfKeeyNiAHD9lXgaVj
 uGzGHV7mkb1kEwzRixLGrdmJ2G3oCjiPlgVSqJVH+wVKrb5vHg+sfusRJBW+hxlfxMcB8
 pG+4v3wMMpFOmNn6o4xrvaR5njfWRiDXNM7GBXweLIBJfkPODPlXx2JQwRR8hihb4/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791618932;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-LD-Processed:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=OSh1xT0EZ4mu7MvBhwbZYO/lGz5WOjTI1FgbEQbZ+yo=;
 b=pW6yqTTxQBamEBPRPXD76kH45b15M4+mW7fQhJHDjdqpfYBtHP5pAZ4+NVMqwhXX3YLl
 qNvx05bI4/nWtTfhr/VmucP974pPjoqZWlYDdumoEWRcSqKvWIIm8a0FITqNBMV1w9wWM
 Gu+HfCpKU5CS0AyVJJYbZKlyFgvUf3UlGDUnE+KkT8m3bag2fbjnBOteeFORm7EHjaGIx
 +RG83/KEFqaveyebAXwTXICapnP2RjY2NnkpgMALg7o9pgqvxC+dV0HD+jJBnqdy/SsqN
 uOfZiIoUA1KtcdsYiYXyvQTexhyE1Qmnyano3eNqFrZgB69zXK8Qj4vRhq75fV0pRyA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qbbLgCkk;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qbbLgCkk
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 611D84006F
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIQ2FQ8tDm+nfFnUHoXj3MczqNnpAYl81m9Rs+7uWpoYJjtqt23tZSJ3mlXEFWhrHCKdemzv587QkXxSZL1h3pBuyYT051i+uJ7Bkm2OKJumjI4EVMDBE21JutyTjVDPvSN1+A/8UcOPfFhjO7yLHDY4T0iLIxVVhZEYiLF1W1efC4hEBs/KEin3zzjeg65M7KgPZtkUZ8SvtKHYNEej9FWkf1TkCz2s1/AHo4kpLdUZM4BKL4bZJ5QCByOqLe1ni25pn21TdD6qCbL3DUElievR6YSVdrhCQVGTAKwb0AyYa/+b4D4XSTzLYOvvCrC4qlcZEJb8wDUe3Hr3k7gwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSh1xT0EZ4mu7MvBhwbZYO/lGz5WOjTI1FgbEQbZ+yo=;
 b=EgMIMcJzkHWyyaWgs6YM7hPijspDPU+c03QtQeDuIX0eoxtqYNPTJMYZjUKb4AWFK5LSaXMMsTMIcUUOeDiYzWtn9bU3rifeHF/wtMhiK+owoEPCVbSLFf58kHK94cWEVOs6Rbn2aD4v0SnAInokQinxOzW/yNquKYTbYidyMUlvBaeOiK3++4B0rryx+povlLP9ehaA+Vs2EgIPdNzjodeMS9o4/NWNVkJsCvltjrij8A6eFJtTIOjEBUwsswmZ0rvBaZe+ct84xRaFpTx4gtM/zo34uwvD5oPJLx7FaTAZeGo/ejxHvNBln8Wa1FwFe55PlOHOBEP+NjOdOhbZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSh1xT0EZ4mu7MvBhwbZYO/lGz5WOjTI1FgbEQbZ+yo=;
 b=qbbLgCkk4s9bxHCfPlWhhBKSWdbkYXgjDgR1hAU4EEN+/JQUlwHQA/WmSf9us3JVK7hCyo8wdjW+S3jhOQwgoGOZT0jb4w1F28K2VLiAykeiipOlrz4jIKDK/2PLykZnGOOgHfhCidHWUkoZamm/SKBcNMehN7Uxokl4zFhb22xP3eJKbN9CCSyJZzmEV4xLMg7uK4TDgXs9Ou3sTy4FyxBOGK4oO3KZWUmys458pRyncRZ4zW9nxlF2RUDI930glzAhIa+4jK5nd6JD8QWLu1G7sOD376DpTWk01JVesTXYbm8t/8rE1JFZVYMt5uAnSOn6z23MCTC6ofOebieKdQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AM9PR04MB8569.eurprd04.prod.outlook.com (2603:10a6:20b:434::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 07:55:26 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%3]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 07:55:26 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 1/2] imx9: scmi: Move u-boot early MMU table to top 2MB of
 first 64MB DDR
Date: Sat, 10 Oct 2026 15:59:50 +0800
Message-Id: <20261010075951.3939861-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::15) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|AM9PR04MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: eae89f76-332a-4693-ee0e-08df26a3d85e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|261009223027099003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: XGi1DcSXxJCNyWo89BMmbnBShQ+Hx9Nv+YK68TdqUQy5yyVvdGBEC3W7ihsu8+dGNfH3gBL5T767yR5uC3nAxGckbsq1Pjs8iF9AIEwElLJfbtPkzWoVAOw34EhU8EI6A4kZGxVKUlUW4mQPHTQkLjosnpjRYLhnZhmmGevCBBw14N3JVfaI6eR4MyPVPMEnhuyRKEajRtFCCw4GsAvKkQLCKMX6XZNzfk9D5P/WeV8Ah6sKx/duOXNZU4Yq9IJPCEHfjIVn9EXir5JCPsoriweBXMtWsQwLXFlGYzPJWlH9RTjF9YiQfb22ii4Pu1OVMfk9IZrfvRX9JtPL7CnYzASM/V7wT8Fi7ECwevti/2QZS9/WhvSPreq75VCXuBSpNx+2o65/ScP74msFSbN3hfShf9vgDzESlVkSSvKUt20O9fP5Bt/xPZMXtADOnVT1xr3qoaLvrFc5a759MCQewQQ3b+M3Ekto+BsSR6lo0sloun3TQ01Euhv4oGywxWpbRXxVFMx6A+9BuLNq2v5M8X1G/ETXzTNLfIGGuVKHYr91+eWs2YPXEHbSr+r6eKNfFVkeRdt+t1a2EPUquHutYomHMus781iXgS8PFEpMxW9sgBF/RF+M+7HQlsp2nfg7aQYboLrb9BYEpqp/ohJC5LVUwXSap30dPB8xgKlTJ/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnWKlP1roObEqKPaTqL0QbgABytAb+0GTVTdt3hkoTvFLdm0RzrWuTnmj6H8?=
 =?us-ascii?Q?RgZKr/pmmXZ1SoSIc9OtLe3jd5VFU87JsvtvVMZSmbGM3PIQUOSa7CpJzLjt?=
 =?us-ascii?Q?vWa4xw5hJ617+0DLQYFjJjE1b77CpF0o6vqz1vO63EfybQX1ThNMhRcxs4Nx?=
 =?us-ascii?Q?1MgSz5AX9bRuhr8VtnRrR5CndWat29LaHfw3qZ7yA6aLl5lw7ne5pBhOCKf2?=
 =?us-ascii?Q?HNJmEtD/zyOo9GPnLBc6deSANncTk49Vumu9J/Zq+nKHK4IplrC7FFpNtkrt?=
 =?us-ascii?Q?tpDWGpKYtqYqnmceLu8jZy0at5ZaWbPFcUuJXoqihFTApGN4pjTySEe5igJE?=
 =?us-ascii?Q?y190qihmJfJPYTPU5INiwzAJPkccpNAM/uULncEMWcF96aWQu1AUgb6+ld9o?=
 =?us-ascii?Q?9M30fisYCDUv0Sw3TXirGPSMCScaPexfceKrXZzGWF1p/vQGcbouq7aTI0Ly?=
 =?us-ascii?Q?p2qJ9GsBNSNwz+Mgj7jBm0tHGNeDoBaa3NxDcgX2qRTE6JPQiVt2OQdUFqdv?=
 =?us-ascii?Q?EfDYVinK0EaAda8cbx49nj0gLAR6JpGWxzPIsO2r8AuGQtRqcvDS3FKXk19h?=
 =?us-ascii?Q?qyuOTXdew1kCDueaSjXNW6BjCtKSZwg2HnxDa43ZtwilMJVAfqEmXnRX9jWR?=
 =?us-ascii?Q?hp5izbqnsvW+Rd5rXEee9oXfTY2aWs2M96DmqGGJ9KbNsmJaRiI4u+1yTR/F?=
 =?us-ascii?Q?APmDd6graY1ejPSSbfaZdZXP5EAu1cl1DaDzgwckXaRn/h/LlKxmpN4nFjFc?=
 =?us-ascii?Q?zlV0L1ar6o05ROHpNn2q947L4bAIjpykJT303OA0LugvbD42Gfacdz5nTjTb?=
 =?us-ascii?Q?NcqwDn10WMVyrtbA4ihWIcZygYeAszQuLgdk6d47flMbLgeaEF0xSlb6VV+q?=
 =?us-ascii?Q?dlVWX2Eqp7PwbJmeioPfR1H4tPFBxZlrQH7mGXIFeq+izpBxK/D451eMgEsF?=
 =?us-ascii?Q?sriwnvGX7gU2HfC3hVCep5LfsnhDlSi5vpWB/p8+MCzLI3ejwvsnSGaNhtJg?=
 =?us-ascii?Q?n5t0ToxhuF1IS1MbSMXA/EzMVXzJ/wSyYzMrN0HbvBiHhXrOc4b0qsQe8WUK?=
 =?us-ascii?Q?dqfm5pgitbyfsKvBJgquNYiL6dpYdAdD2vfzm9klRIA6jSVs0LEXWTJk1U4W?=
 =?us-ascii?Q?lXG1f+D5K7BAhYWBo/bp6g5m3BbyV/oMfprxi/29PffVXpepsw7B/EXgOLrI?=
 =?us-ascii?Q?lxHePTGAJgnV190mY5w2T7XAAEQfj1tFELJeZc2e9ZT+GM6iCibBk0EwUQAg?=
 =?us-ascii?Q?mKsSWjGrAmy8rRKe9m4Qzufpvzvd1mY5Hz0hpedwWuwjOdTgtCtBdShG6ijz?=
 =?us-ascii?Q?SA8QjvSze1f/18KbvCfCMGIKK65fWI9QD92bmmWW0YQO1FaVXr17GzUncNpc?=
 =?us-ascii?Q?fDNlavbej361rawiC1/W4wlvHin5ZEFqsyWvqQQsJNEvoi6iAzeP0tkdF7s7?=
 =?us-ascii?Q?ZmzVvXf3AK3vs4Uss7LD3NYEbb1xZbzPrrbcVOZraZkPnOnIgXAjs/lAEGr7?=
 =?us-ascii?Q?cPN7BCdrukRXO2PuOO4atalLw9UiklEpn9vi80Z0kf2RF/ZFU3xodu/wuTp2?=
 =?us-ascii?Q?yDrbfbVV3KRpNJkPoKKvlgpNCUE9egQMgl3rKiQEkzDWSPFqSoRFV+++uCmO?=
 =?us-ascii?Q?ncsx0FCZ6BfWC1LLGSIpO9+GGidUMXF8qdljOxIpLeg0vWAEEfggmWo6wDvw?=
 =?us-ascii?Q?tN0qchPSYWHk5DG+knYh0chFOMujPfSBZXtynrB+yjtjI3B5DrVbEkW8FamM?=
 =?us-ascii?Q?WwenHlqZsV6eOsO6N4xXkY24mtALkcs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae89f76-332a-4693-ee0e-08df26a3d85e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 07:55:26.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKA3vJ+31zAfeoR7zy4ISY6CGFgtuF3xPeyAHAD2BD1jRVfxR59YhKE0J8nK/xwp80T1E8pQlqp52YVWBbyg0oegpq+w+7QdqlKFEuhYC3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8569
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Ye Li <ye.li@nxp.com>

The default u-boot early MMU table address is at CFG_SYS_SDRAM_BASE.
The same address is used as alias target on Toradex's iMX95 boards in
RAM-size probe. When a probe address aliases that location, the test
temporarily overwrites an entry in the active page tables.

To avoid such overlap, move u-boot early MMU table to top 2MB of first
64MB DDR.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 22f9c9d045b..fa6b9a0e53d 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -613,9 +613,12 @@ __weak unsigned long board_spl_mmu_tlb_base(void)
 #endif
 }
 
+/* Uboot early MMU only map first 64MB DDR before DM init.
+ * Set default early MMU table at top 2MB of first 64MB DDR
+ */
 __weak unsigned long board_early_mmu_tlb_base(void)
 {
-	return CFG_SYS_SDRAM_BASE;
+	return CFG_SYS_SDRAM_BASE + SZ_64M - SZ_2M;
 }
 
 /*
-- 
2.50.1

