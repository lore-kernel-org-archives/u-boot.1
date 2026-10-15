Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46272CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDD1C60AC3;
	Thu, 15 Oct 2026 13:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hc-JsG5Yw_iH; Thu, 15 Oct 2026 13:15:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CD57D60AB8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070104;
	b=Qrq7d62OAIRACFxohQGtInn9WYkcmKm5tTpW4DD8Wn7h0kH09tvautFlBQCH0FyVL9JQ
	 sAWPlEWcDTfeuK8PwaORzxU+BnBGH6Fs33dxP6NVTEoZYee5jS7jUAxq+iEO66nwi7fHL
	 TlvHgbfiht3LkPKcHojb+qoSAU7x/lpaD+5AyfslnEMptJ9QGy3ePwrHJJ4znCs6EDWAt
	 KjZvhxPGUEBx3Q1Lr8NFOjFPDw7prfDZyfaH2JqSDMmOjVzgUEuwKUvl8Ba+FOTasx9cN
	 1NPQqttLFEF2ZMm3dVgq1X8X641qzT2BN7O4kYHI0f141sVTIIuBz8+Ic8SdF5J9sRw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/nVkc+h5l1uOX76peFh6JLUAc14aTHyVk4c37Oegdf4=;
	b=HYoGWrgLMYWC94leEFNmXIet+IxDAcf/eCPqbZumaOncDBDn1oWOc8uJZtaP+WGfHand
	 gY5g4L1LTuQVDgj4HXRhlsQcb2nY5vEvxcOKer7Gh+B7a3hCvtxN2RMJ2mkJppo7m8+Hm
	 1G+chyue9vi8pGsvGZfWHaDZyJ6AJ5wc4FfX3KfTTQ3TaZ2SFCKUdYVu/gwdLb7nEwXyM
	 5QO53D67v61rCNDul8qgucXoO4i1OY31JvTQXxUZigmyDlcHQagmPjgEl5j0zpKMujwUe
	 v3bCiQZI2rBqW3WUfzPXwJm6KljzZcJLgEcv0IK2W/4G0C9i+4cJZnFKfPXvLCj+o1Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070104;
	bh=/nVkc+h5l1uOX76peFh6JLUAc14aTHyVk4c37Oegdf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBpOS9hAgJ0w0eUhBeP8el2eJqt3WG3FXrBPTFRPQa2AiD3Wct0nKPPBpU5S+wZiZ
	 c780TIsrfz45dqqo8fvzJm78l8vwV2HSi32tyP6hw8s0cBPBQ3A/irWqeQsoAJ6iJk
	 3SmqlXiPsWrMVA/GNRkBK6OrepXPK9PiUjnnVCZ6pxJ1mSvayWNNsFuWKrhosllbU0
	 aIiSCCqjvUI20/eJa7rxSOWLtXkvCYS2rG4j7DixOrURCRGkyI7Q3lwRCWMHawp7ka
	 1qL+FjG1WF6AfWZy8ZR0yWuOSUuRJT0i6NBIRTeDao3G8pNIuWkjhC5XrBg+LGel3O
	 8HtMRi5EAlJlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD57D60AB8;
	Thu, 15 Oct 2026 13:15:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EAE651DE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0FB54080D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_pg1NaDt1Cv for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D41024080C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062834;
 b=EhizwAfEtHKOggQ6esmd4SRbsbOa4/I3AYWPFX2oqmi98KieJbmNcHcWZbYayfBLIJGC
 WIUvtCZN/ECYByVqH7hyEEirs0fMe/MBSfnF0C0r4ciuk4/+vxCbaKNY64kZylqd9jiGj
 7Lrao4upTvnhpZS8XivpnCD+Fu6ljrZnvWku+8keI0jz4TmQV7YpxIWZi/a37eVq/kz10
 b9MZPpz6KLzCedp97n/cW6L6vmxIVvI2Hb3BxZd4IW/wlJEeYGbCKRUHfJ8D+2VrzhWZS
 POnJQ1KHZSyk6vwqMJb2wRHl0kLw4KBqGe6FI3sdjd+XVRwcGie7gk2zw5chw2uCFcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062834;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
 bh=/nVkc+h5l1uOX76peFh6JLUAc14aTHyVk4c37Oegdf4=;
 b=NlRrBJpPDaLGzOuZEc5hF3KdMAFLvp/exLFKBdbwXSHxmIPl/soZKp2TnPH2g4kvso3t
 7T+9M4ISXKQo9ULQd1M8ksXxfvw3hVLanAw8IOqz6WjmWH4bjH3G7h9cRLLDjWv1op7i/
 Bhdk0zSGc3+s9VxJcQ8dwvF7eud2eYBrlyNwrjoE3Q73S8LuxPYGaYVnZ87KIyBUbQw8A
 42ZW/O6WtUJz6DOrzUZkfG9IsHrWfLKj70ecA8o94dEmjez14RYLypzurGy/DVaLoc4ou
 2KcPDFZoPDvMonMA3EDg0gM/fBfj+YfrMc176Dc+8OgYeGzj+tCaPpi3zeGvseCVb/A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=phGBuFNx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=phGBuFNx
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D41024080C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFKi/PvrNTwanxLzXXCHM9PE5v2Y+tyhvrEBK3eRoMw3xiwKMeDZQXs6tqHwRvrFIttbO79b9k5oELZLO4yD9KswaunEopsJeAUhkoWWHP07c4V43qdgdDupXLxX14REgR0HLXh4A0/k325Uugp4vpGvYwle6lSr3t3S4kcwXbCSTRIf8o3cwkz7y0nGamEMxN32n2zautX+FGLz8W5VQ+bXbEQTllZhqrR7p3AxnUSlf2s6IwxRy9nuuwDxq0Iw5Szo88daZY5hQKxePizzvMWFLkVD29FHC6UAn2vjDE3TPSZbYtIj9hA184uvtXaesjb0viJdrksQ5oDneavfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nVkc+h5l1uOX76peFh6JLUAc14aTHyVk4c37Oegdf4=;
 b=NSknu2JUZ8bq7DiaEhWB0+PZeajS3/hXdQ9lST3UOijiZ7AVzvZYuHkNzFn0ZG33jTKJiKeIyxtZZ8AkA6bZWWJY67ADbPXZWeeC9MlrpESf67459MIwINJfvRYtwtJ2WkluGiYKU12sXHR5twE4Fm7NA8nvFSDz3x9f41gTRe4t1F5oMoY93Y/baE3L1HtL1NLL9SouPXg/KRWdZMOuLDVQPYIz/ewliqlpQ/GJNNsSptAsgqi/vwz+serUhuU6SABlvwMjCaeMdn0LJNc8azvydAcXyDR8eUFh5OsFwLWsi0MXBXuyLeJnDiWFRwaG0JXod974FnVmvf2Za8umYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nVkc+h5l1uOX76peFh6JLUAc14aTHyVk4c37Oegdf4=;
 b=phGBuFNxNKdIbayqWRURPttFOAP1W5kTKYZZdVs9fFQfv1OiPHkG9dhuj9IgnNUW+pMIqgMLGgdjU9s1DUcjrdYnmoGWM6dBoCZuSSfPynn2A94fMR7WSZ7nk3stv4GP11S36AjWWIe5SHUW3YNamH0X6fiYriu9Ez3G3/CyzMEGql/0WXiU3gdVpN/hOKmsz9XjKY18N85NpDqxojciGejX1rIMeW6Xf19pGJGyIAyN/I+VrLt3pp6kl9q9srqPLjcPA+3tMHYRCclHZrd6Hk0AS2dNSTO5VOXWOTSbW07fjrnsGVGP+fJRD5yNwbqgq9U8g/uvTL51Nwtk8kp7zw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:13:48 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:13:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] virtio: mmio: Fix private data lookup when deleting queues
Date: Thu, 15 Oct 2026 19:13:16 +0800
Message-ID: <20261015111328.1269775-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015111328.1269775-1-bin.meng@processmission.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdbb16a-b6ef-44d8-c4c5-08df2aad6291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ebTaO8jTYfV0meaWp9iXdoqxQ1iw+lEpXO7lFEVg4UyaSf2KEuu0qt77lFxxjLL8xLKv+84rR4Vc0xgWLt2W2ukwKeSoPsI5/+OZUk7TpTYqSGYkqR8AnLSkv1VOFGmDV49O/Rl0DqIZArhxlhnqZsfnTf3k1RJrxe7MKv74FeTHIm/9N2SY9O3+A/Yi4Fi+sgh218Nw5hylL63WiCP9yNt+IYte89clXQ+2Fm8i95KNPsM1Hg9dCdyBfpfdcHxsG6/O0lwTnQTl7Rri3cRy99I5rZm3NHSjaTKY8ZsL0Vpj2E/hkrBElSLQ5nWst5bHcIV9pUOk34rOHS235g7NdfX65Egp138YOPMq2Xj2lxSB9S+LSLrLdztgiQw6zBTHYZOaLNxZedoQdGlKRQMNrgfHSo2BeguAs/pdhYKDMPuWZdUvBaEfmS3I/WbM9XO7GdBCcYd4tm7ovPkvaWi6vKNWa8/WpKKBqSCV/ulyIiW57d4CuRzxEf1Bg85r4gWMGyrcl/0ccu1p1DzdqjuGx4R7DITysOFEobHajhb2MACYjgNbA89TLOczAPSeO9pDK0jE9OPWvapufTAge/zFEF7pgx9FFZgbpqYCGeYT4GBDE/DUzfAxBZsffCH0sg4YwJjT8xsAJVZkwa7i+bT1uAfm7tP75xKfoL6RAfE6Nhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?78Cw//uMtetLUUl6ao9qdcuSZ2fj1q8xK9I5ClRflA6MZdaJKD6uZvfhL1xT?=
 =?us-ascii?Q?D5Bsu/jdb/9nb9q71zYqAgtkGVT0gf4FAXXWBngSTKVrEIXQoVcBn7CTP9/V?=
 =?us-ascii?Q?7IOm9ALU9JUrBm3WJluSAfOVWcyzCZTjVgTOk/d6tX527mwuTBAZycWmMYDg?=
 =?us-ascii?Q?Go0qa37I05XNkltgUQ8dq+XGIeAvw7GNSReNKCWvxAS7tye8aVG+xZWwakNn?=
 =?us-ascii?Q?m2EmT/+YhxE6gYJftS+kJHlWGWjoGVTMW1J5mDMHi3b3B/47/Svou/jYsK6n?=
 =?us-ascii?Q?+cwd1FwFSNjk4VdisHI2x745GeTraGE9j7y5rsibIAYpKB/yqsKi2XwC2XXH?=
 =?us-ascii?Q?csEN7yHcDnDd7BK3SENG0UJi6E6u3sXFBmRSFr/Gq0OWil5h7Oq8kAi/ahZh?=
 =?us-ascii?Q?Ptnq3Xv3GI502L+28f7VvZIFEKprva/6lyitj6rWhOuaKPZYk7Lo2r+jXNaY?=
 =?us-ascii?Q?h74caMeqMzvCrqxdJ/FejZ1zl57m6ZhYQ/2F0mN8ogbPvLndmlo93g+Gh74w?=
 =?us-ascii?Q?jF3P5eR3zhCE3se1wNbdDxXmcDZzzvE6F6RMrSVrecJU11csERAburiLP7Yr?=
 =?us-ascii?Q?AljYhhf57HvoffQuOlK4x+CdcSrb135MYp6QXlSxSjt9azhmgeQeZNv9tRdf?=
 =?us-ascii?Q?k8YKEse1BGi9WQfE3FXKh0Hqr24CXk3jFhdr+3qdLpjLe8POYXrT312qK0Cs?=
 =?us-ascii?Q?qAPC8EWPXAMNHskLNKoJjIcHm92HoegKbwpduSuLq8HzSlClsEbgCedR0/Np?=
 =?us-ascii?Q?x8TdMz3bQI0sIPuiLPntnIiAwkRHkWeaV/gjVqmVGKZHIOPQwPMeWd1SxcnG?=
 =?us-ascii?Q?AVEw80HoLK3FEULRiz3pvemfLyOvtetCztyreSIIwnOomxKmhihhhbuavzoX?=
 =?us-ascii?Q?sTPu/9Ac3Mi0+etsUOLjMHDhZMsg9b2Orf0mzEesGixHySFQSVWGRYUGDJY/?=
 =?us-ascii?Q?jKVZg5IQTRyW1uPWevjqmdMHLZhm4otlDmrvQVKK4N1lpFrynfH4mp5UcSG0?=
 =?us-ascii?Q?hDwZ6cPpQQFdyog11/TSiuU2xYcPwcgcJHVLDzjQXkF9U5lOcKr/qqNJCyt2?=
 =?us-ascii?Q?NY37Tkqb79/WzQ0lAWS+8tRMdB6brh9mkgZ2JzYcHZtBXJBnjC6U6warJSDp?=
 =?us-ascii?Q?FCP1yTRdsPTm4FgNskNtgYAF1ZP1qBf898UDqH3ridzTfhCT5m715c4HWpdR?=
 =?us-ascii?Q?NTXvBhOMUquusqF1eUxRrZQxWakrxV1Ic9AES7GgLMpViQYUAtlqDlUebRyX?=
 =?us-ascii?Q?kEWwjoRLKJFk1iKONQ/FI06qMRto1mi0eQruxifYsjIYxjhjd04edjuuQGd6?=
 =?us-ascii?Q?LY/e49NL7SqO4xion0RTlMYfeIf3IAyfU6P+h8+kT9C8ayKRrq+3eZiHrw+L?=
 =?us-ascii?Q?iCXT9EPtvoWkAucvWc2S7ajrAbsu3s2G+jiURBRjY2aaLzXQLkHCJizvtiaM?=
 =?us-ascii?Q?A4UJ69/2zREtkpjXTo3jl3TXVvkEYQD+tqNTlTxatLrtYUocgAe9zPIt2+SQ?=
 =?us-ascii?Q?FkoZ92HROObXgpSwzYSF/qD5x69+e2cI+K5tCSMIBjKwR4xTqgANv56h/57A?=
 =?us-ascii?Q?WmRj182j9jKGPzxsn6mQ58mr5HKEYZRuOFvJTDQErXqj1jOVn87aoJ9pgIYZ?=
 =?us-ascii?Q?A9gU9e3K7STgYw8nfUgf0Uo9KmsaPE3zQQhkp1Q21qHk8GDwM9xzdzMUcbaE?=
 =?us-ascii?Q?xzrPO9tvzRJwHUu6W/iyICQivjSSjx4on3Y6jeMbiZvorXNX8Og/T733UW2Q?=
 =?us-ascii?Q?28tHg5OKAuKBVNOsrQGMv7Pfgyulrbo=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdbb16a-b6ef-44d8-c4c5-08df2aad6291
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:13:48.3269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2wGbawmOTCLq1Gzd94vPKVR/tKV9RU6/613jbH/zofSuI0+SZTaz4L4xsrI9mp+KoG8QL/GtgoweucbXam32YWy8yi5oIflVtSMow8YMNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6237
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
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

The virtqueue's vdev points to the functional device, while the MMIO
register base and version are stored in its parent transport device.
Using the child's private data can make queue deletion write to queue
memory instead of MMIO registers.

Get the parent device's private data in virtio_mmio_del_vq().

Fixes: fdc4aca89ecb ("virtio: Add virtio over mmio transport driver")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 drivers/virtio/virtio_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 975f98cd9e5..4b478639fb7 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -279,7 +279,7 @@ error_available:
 
 static void virtio_mmio_del_vq(struct virtqueue *vq)
 {
-	struct virtio_mmio_priv *priv = dev_get_priv(vq->vdev);
+	struct virtio_mmio_priv *priv = dev_get_priv(vq->vdev->parent);
 	unsigned int index = vq->index;
 
 	/* Select and deactivate the queue */
-- 
2.53.0

