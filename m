Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04176C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 23:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7570080E3D;
	Sun, 27 Sep 2026 23:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eoIhWiadZZEP; Sun, 27 Sep 2026 23:58:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 89D2880E2B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790553480;
	b=qZ3puLsMbj1klh1r6xwynBc0FDRSGSfa3C8lXa4v42v/Y985fi9Z/YpGk2Fekm4vh/m8
	 h3gz9dnFqcX+64m2yKVecKiaSHIruBxsgITkCBDT8WPa40y6MJnzKW4Zc3WHyWns6s6Yf
	 zZFvPh9vud/5EIWjXSJ+H5ySuUa71i2T0NOoHjA1gipMQ9Obojf/ERFz2KtjAlOFrCdZi
	 bxGWV0sFijYScJmPWRL5FyA7/+a4Cs+JMO/4du6dqElixjjLfTPDmROR7qZr4mszISyrm
	 wAc/er4jWJKY8RAZ0pRAy8r6HnIV9BAwKs4phdMwCxo0lgOar3+XHmWDXTULcUHBBEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790553480;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Pwr38HENPTq2eUYybRNytqDCNj9pvxtRwR8iBUzjrE8=;
	b=Whk6BJhu7sy9xQ88dh6QBcATpV3sHsppFCow7h0N9jZQi6mVm7Q3suQkEYRhXIyIAq9F
	 1slj2UM2Fn6c+g634xy/XDdfX4KEexQwuQNa85D/APPL/wCXqIFqiO11xbr2Prw7YXMcs
	 wDCx4MPYj9znjkFSm7LouAUJJh4v8FSil8R6RIJ24VKGgfO7M2+gkIdifOVXF0zoGMe4J
	 P5/rVDFmHyGfrNPctp8Ike0PU8L/m/iyrkXe3DoEv3bvObJqYWYDYqllji2DbL3xmFaRm
	 uCB8shcXxgQNZKifMQvsEbOpKtiT+q84+U0X34gs4K3vsqJrp0wZJc3LRgDQVISaVDA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=iopsys.eu;
	dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b="FU/aVGr/";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790553480;
	bh=Pwr38HENPTq2eUYybRNytqDCNj9pvxtRwR8iBUzjrE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fYtwJAO73F0DcRy4W+cj7Tms2pegZlU7jJFj2s1UQ+Q8HsPcISMiYVdFnoyaXY68d
	 xYsmpR6tPegFMpdI6dRb76NO8nQybXZzhNBxVK0Df6AmEgyeALQU4ONeHK0zjdP5gT
	 NxGqKbJ96ID6swYPvmiFe7d9tRxG+cahPDoEJGG4obG+GsZFVU4HZsfE2mR+SuMqrM
	 MQYdhkmlec90UpqqEZd3kFZ9hMQN4V/dB/3N7cyQt83fcD/zrMDP5/zmJeM2qkRaSH
	 mLGVaiZl/76OxJvSm2pwsq+qjY6IDv1kcJ2cDJetgWUlUsgCsWg4c43r21wgVVwpYj
	 fH4vuGJApNNEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89D2880E2B;
	Sun, 27 Sep 2026 23:58:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 39ADE335
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F2C780E38
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRohq9L4wZx0 for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 23:57:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1945F80E3B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790553478;
 b=WOvZ18vdtE2ohotPnBeyjehvPChGtEN7CsYGhod2m3dcXA0tw/duyGwmlMkJZsy7MXFM
 p9GCB3CXz/o10UBfWvMyoI9A4ioIoB11MzoB2L9UFB1AqSzyB24LNPLspPRvX6MhAhsLx
 xR2/F3sVoFxqUeMXV1TNKMVd4gnIhw6NsX8K7w3ncTP+auQ9Bfcp4keLFETpNk46Mbbbm
 Y2gjPgxcgbE3WJunXAc30GJhtlmHMJFrJuQj/p3GvRO8vjVwOuva1hQE+UjvSDkfQm1/U
 yaZfqfw63UXh5SPtuMp9KYNGajR0UQ6YNbe/MQAM7LTmv0/MhGcBvQ6LtasFbIpsEGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790553478;
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
 bh=Pwr38HENPTq2eUYybRNytqDCNj9pvxtRwR8iBUzjrE8=;
 b=rXqQwHN1mbj9KoakJ8sSKhU2hJV3HyYV2eNHpTqMXvz7kql59kYc3kBk3cAjTf5wR+vB
 njI6Sn6D38DPEXcTERoVCo93Ax/MHODOJ5ep2Gi1zLy+BecWoW5pDCdb5KJuZPINKM/IM
 8J7pVfLFfZl0vJ6fWc5LpesQ8J2kpuw3mktEueeDyOm4fpJ7EUYrIMkuqVXmYpNIO9qTK
 EAlWLmUEcO3ysrBb/tpSWRM3JFVNYmlvHEFg7H7bWoGJKIdEJOh33Nc0ER5H8cJkRkBsZ
 bL1hwtk0zGWtVC24GoYxTvPISVrt/OGNyYgQ+KIxFsMQlLSLrexZuC3U4lLXSPGOaaQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=iopsys.eu; 
 dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b="FU/aVGr/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=FU/aVGr/
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1945F80E3B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tllOdzeWEPZ/SrZJ/4twiKjrH8CJw3Q5RsUr+CkVk2UsGYs/CNG8BRt3ElptZ8VKiFFi7fancCrCniGlQGt54iDtE88sfmUkG4DYBsYWi2agQc11Td8O0ZOOk0aT4GhwnqlbTI+SoNtIWFvHvOsDeS2P79w6m4/81Q6aypRz1A/jIulbz/KrVg9jKMSJMye45HqqjUwUswILlc1J4ug6hqLrFteo2sjg6qKfUyYLm89Bl4wci1YsjkVBdfCQWBQdJNfXozWqn8m4v3XPUPt2OkDC5pNU/10oZl5kH8SDt2m13MsnoIk8xIx7+eBfwemyYHJ74RwkAHsUCLkAZzZ9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pwr38HENPTq2eUYybRNytqDCNj9pvxtRwR8iBUzjrE8=;
 b=oWnIc5uHD85lIjwmgyAN+SRDssxj5cZS+/qdBCj8ewiDwlubiik5gj4tp+uNAbW4WJbJlvWbLA4Ny54xsI+HGuToxCMyfa3e/5fGSG5ZjYX73P0uQ7WzUxSvWAwmcMXkEvtkNG2QjmMEldT48x+kdOdiCUnwUkcVxRhtPFDGUcRFrpRGN/Q/9Ro96XQXmgKGrkEg93Id7qOyW5B6XUMTDIUtr2LM1iilrNa77OiecKAKF1QWIOJ1U+rvlEdFPDILqB/7B2eRFwAOzSaL8TsW9nhQx58G5mmwPkSXpk7YeTLQ9F8e/7wUV+o8ulLhT/0TTKZz5FW/OXFs4FMZb0CuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwr38HENPTq2eUYybRNytqDCNj9pvxtRwR8iBUzjrE8=;
 b=FU/aVGr/7eKl+1/LoifM9dUGARgA7+kQDiJ0CX/q/8pVTJLCNZRT5KShVpu+yz73MGtgNeWFJmsG4Zum3X86J2lvt9I43OeUaQTC4+efEERy2EJg/rg26wp3zzj+KKoYZkB4qW6Pi1RRkyeQb+Ee8VojEFGQ0eAnfPp56P7whmwj0z59OmjTytgE5FVYFpFo6L5k68odUpZ9JJeRCZG1jHEQIitTpyR7ud8h4rGwZ70FZrpMwra9QNiUovu5hGV5bl2CfGBhuyNcX2ZLxVX0nL97tNq/jYxhHYSpS3tU6fSn2/Zg+Thex/UzBAvTr/+uuBaOihYqmSBBq8ks+oaldg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8347.eurprd08.prod.outlook.com (2603:10a6:10:409::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 23:57:51 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0472.005; Sun, 27 Sep 2026
 23:57:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 3/5] spi: spi-mem: Create a secondary read operation
Date: Mon, 28 Sep 2026 02:57:14 +0300
Message-ID: <20260927235716.1872707-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: a0559232-194c-4fe2-b4c7-08df1cf32377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|3023799007|6133799003|18002099003|22082099003|56012099006|38350700014|921020;
X-Microsoft-Antispam-Message-Info: R/Cd90ovF2OmuGMlfG/o5ljy9gAiV1wGFMTKagiEF/lyZwkeJFDYle8r5oiHku0/6IpBG+z0PqSFYd3T9uOOXqfCRKXLTqfHGzcyeVObcB1YpKDj5iQGp9xewonAom/ByKoHM3rTWp+kYUpmLrhs6oup0KXcKD1KT2lU0FUsEe1xPW9XJQhONYrGnHa9s+hd8K6htndQ5FVRkOyXvU6kE46Vq6sAr65KjinG4lQaJGkKgndpQ82VzUoF7Xxe19AIXMknsrNmNtVWMlJeuaSuO/x+VT8vn+t4zzVr/UZLjjNekCdy0JC4BQrBDHilxJ21NkZWdW5E8nO49QqGSJ6RSDOiY+JRI418ZvlHfdz4p8RUudjMzqEFDzOjeB3Gmul2tOXk45UCCut+UIrmKfS9SdbbctQbmEJDm1Ud/bGEn/rh3vext7vgiA1U9X733lIr4fcVs+iWCUinm1SfVhtwyLHoD+ghn+O9XSToQ8b0cCZLroNt/aEXH9Mr46WRoc+lYo9HSOBnh1a2c+4CCRQqvBTmgf7CobnfutB3mhLxL00GfFco0n2aKiPDxMF3XyxpoLw69SIKQYvTbU62BpwmybFw7y5mxUWm5SbYarz1oxlKnZ/kkD0YB32UeD5dqtUhK4d3EEbcIrvhgaQYmMuZgjRry5g/owWuVy/MqfEOtNTH8e682laU4F/c9IVSwjkF8zvvV8ssGL12qrFIRc416d3p+PJY+fNb9YxjExMFRHpnOsPVCtzyZMaq+F2B70cD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVpDMnz8YHriUJ4u7xsZ95OU6j3MksFL9D/cKfrXIHyfzj88n15wRcSaMP8n?=
 =?us-ascii?Q?pMWoHC+E9t59Sz0BZHpHpJsUZtLXxHmoHRYzADMSS2BLi3eIDwlp79b2tSAZ?=
 =?us-ascii?Q?SN0+qy+hwiTEjMuF47K5NJk0FB/WI/A/0RYMDDgyXQ3QqysPzw3YTr0klSxt?=
 =?us-ascii?Q?wxOiFvMFqoqc26DskK+AJ5H3+FHZ4oSqucoOTziHBTfGiarBm5HaeedHo/7C?=
 =?us-ascii?Q?0FmlxjNV77GHhPqnUgmghUtjbf8sBCCbcr9F/PHBt72FiFfBWarAGVHcP1OC?=
 =?us-ascii?Q?nXOn+pvv/K1161x9smSXWq66zLpB8oX9Uy1dtHCflkI05vn1aVF+2Hz+gCrf?=
 =?us-ascii?Q?/MRZtqEa9sxwrmrt9nTJzDCxXKL3zWz2DaN7Bu7zghPCDnLEOtssNZyq7QcE?=
 =?us-ascii?Q?pcXg+VSFsiEMy3vJmdUDOW0st5/NLXB/CC+PEHspQQ3DD1wVndxFjzLZ7DlO?=
 =?us-ascii?Q?FF3TA3dejnbYpXD7ZUFSfw+WCFX8MmXZEsAvt4DdwXeRmN7iFkVsxd0VusKR?=
 =?us-ascii?Q?nlxGDHkmg43DgK9gYUpCTH64pC/IKUoMFQWrFayLy6rby4/+6cXf1Gi/xeYF?=
 =?us-ascii?Q?sbrrU4u/dzbKgPBv3LkINnEf89H8GTWSUAI4ApfELAZUhBdekOyEX2xc6S2F?=
 =?us-ascii?Q?wVg/qtp4q1gXsk8FrvHJI1XqH1v6FVqi9qqtiOJupfVEZvbNektlJO+a9jj1?=
 =?us-ascii?Q?bfuSm3h+4JOg8GlKpoppeRKk6mQKe0UAsX7+QlwW8kZtgwnllxRMZw0IMcMf?=
 =?us-ascii?Q?NUM80YfayoIOZGE/p7paiyKN36N0mayYFjW/7sl4pfNoSGvFqWe6qWzTQzWh?=
 =?us-ascii?Q?RHLNuU9cCFVU06XLyoll3NKHqVq+AZN/FO5+nUJcF8cy9DJ3ALQ/Brw/n0Tw?=
 =?us-ascii?Q?1DfzufjY64GOUYtqyM3dBB1roCNuisULjQqMOpjNOCdwYTOwWGyvBUaZgay/?=
 =?us-ascii?Q?7picwz4XUSopU0t8U6cHrkYvb90YIt8wyibIHU1NRK3QDrZ9DrVqSiESu6dk?=
 =?us-ascii?Q?NmBgYJ+9JjtSNZewy90FovI2/q42WgkuOWIZMiyJQP0MNdJ18d3kS6wyrqbf?=
 =?us-ascii?Q?3kYT1M4v0S2BHxlbN6WLbRVmRw3oBTISMJRdZDPgofbr4VFo2gVpgkkxpz75?=
 =?us-ascii?Q?OjzCzpRWaZ0ilr+r9CIekBYB7z0NLLJJHcavDTjcYAq0eseLG5I2mgxYH0yF?=
 =?us-ascii?Q?gCut0FmjizIY40ebL6rF0HuTT7KxbS0lht8Eii14FtTv+H/LV4pGs378/fyh?=
 =?us-ascii?Q?vSiq3oU2bbE1aWD6I1Ss32uNtSlGmkeQDA+lmE26aQ4Lbhqp6q/IVDT/iWcv?=
 =?us-ascii?Q?4ga8POLWaJ2rD4NfqL8nVRy6ZwW5tO0e2MPSMZb0+Ye/F1mG1KFcvQaoQBDN?=
 =?us-ascii?Q?MnpRylMSdLuzP4b04imnwsLD7THeIEsCwPQC9UGiAQ+H+EXg3gEZxP2oUeKs?=
 =?us-ascii?Q?/S14pEad+d8hudXs6iQmsxp+B1jdZxfWVnq4N2k5Oxt9+dB2kXMGJ75k44UU?=
 =?us-ascii?Q?UJCgs8+2k0P7iizFKAzRAPRrq/pnKPgu03RRXSgk25YFGQOnvZEFpyfppndT?=
 =?us-ascii?Q?P1pc9E9TV6NV0PlWcVjbUdXqpQu9YB8EbtwemrlJthNo/b/JE6a3L8RY788q?=
 =?us-ascii?Q?y/8PyVRx6qTS6CF5l330ewyH2DvRWSJBWp/GIxlzCdbHe+xSq0I+Le9xf9i3?=
 =?us-ascii?Q?OUY2+yJXMRbm1JRPhz5TvnGsyon5MCOodj/LZpQ38B3LIBWuUApZi69QjhAL?=
 =?us-ascii?Q?X4mVoN2kpwV/ciohSkMTljhWSkaFsoM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a0559232-194c-4fe2-b4c7-08df1cf32377
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 23:57:51.0652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Olh5r0H+r6x973V6RLm0KuZpXuqHTMFsPrY3+2ibVQcxk6VxeMn+bPGTZ4ojVqMQ+oFnxwqGnrPWw8Uqn0m7TiNO4iMI8GOlXTPMgVLWyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8347
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

In some situations, direct mappings may need to use different
operation templates.

For instance, when enabling continuous reads, Winbond SPI NANDs no
longer expect address cycles because they would be ignoring them
otherwise. Hence, right after the command opcode, they start counting
dummy cycles, followed by the data cycles as usual.

This breaks the assumptions of "reads from cache" always being done
identically once the best variant has been picked up, across the
lifetime of the system.

In order to support this feature, we must give direct mapping more than
a single operation template to use, in order to switch to using
secondary operations upon request by the upper layer.

Create the concept of optional secondary operation template, which may
or may not be fulfilled by the SPI NAND and SPI NOR cores. If the
underlying SPI controller does not leverage any kind of direct mapping
acceleration, the feature has no impact and can be freely
used. Otherwise, the controller driver needs to opt-in for using this
feature, if supported.

The condition checked to know whether a secondary operation has been
provided or not is to look for a non zero opcode to limit the creation
of extra variables. In practice, the opcode 0x00 exist, but is not
related to any cache related operation.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[Linux commit: 6f96f2fa152518d93ffeedbea781db50aef7f7dc]
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-mem.c | 17 +++++++++++++++++
 include/spi-mem.h     |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 351ca725524..ae393ca48bc 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -639,6 +639,23 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
 		return ERR_PTR(-EINVAL);
 
+	/* Apply similar constraints to the secondary template */
+	if (info->secondary_op_tmpl.cmd.opcode) {
+		if (!info->secondary_op_tmpl.addr.nbytes ||
+		    info->secondary_op_tmpl.addr.nbytes > 8)
+			return ERR_PTR(-EINVAL);
+
+		if (info->secondary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
+			return ERR_PTR(-EINVAL);
+
+		if (!spi_mem_supports_op(desc->slave, &info->secondary_op_tmpl))
+			return ERR_PTR(-EOPNOTSUPP);
+
+		if (ops->mem_ops && ops->mem_ops->dirmap_create &&
+		    !spi_mem_controller_is_capable(ops, secondary_op_tmpl))
+			return ERR_PTR(-EOPNOTSUPP);
+	}
+
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 	if (!desc)
 		return ERR_PTR(-ENOMEM);
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 81166492da2..08d854b1e52 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -201,6 +201,8 @@ struct spi_mem_op {
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
  *	     the memory device is accessed
+ * @secondary_op_tmpl: secondary template, may be used as an alternative to the
+ *                     primary template (decided by the upper layer)
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
@@ -213,6 +215,7 @@ struct spi_mem_op {
 struct spi_mem_dirmap_info {
 	struct spi_mem_op *op_tmpl;
 	struct spi_mem_op primary_op_tmpl;
+	struct spi_mem_op secondary_op_tmpl;
 	u64 offset;
 	u64 length;
 };
@@ -338,11 +341,13 @@ struct spi_controller_mem_ops {
  * @ecc: Supports operations with error correction
  * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
  *          Octal DTR
+ * @secondary_op_tmpl: Supports leveraging a secondary memory operation template
  */
 struct spi_controller_mem_caps {
 	bool dtr;
 	bool ecc;
 	bool swap16;
+	bool secondary_op_tmpl;
 };
 
 #define spi_mem_controller_is_capable(spi_ops, cap)	\
-- 
2.53.0

