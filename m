Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A90CC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11E7760A93;
	Thu, 15 Oct 2026 13:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id naWBVC8dZOBT; Thu, 15 Oct 2026 13:15:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4724A60AD7
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070109;
	b=Xy/p+x96WgfGCwsRG9K7zRCb1utSakWZPntaRyEPsFNfILUGWJzJjyaeJPF8YJjmhwJ/
	 3HfZMUTCl7A3Sd2Y09J8cQUnj8PwAuHUo0IAemwrXvIHGsGy+miXXm0HB0RcBtrRsaUJB
	 8lJAUgOh3Y/e6YQp/b7U6M33RU2E1qck+UTjlHdsmR2CYMGmaRm44WboYMA9y9EHmlal6
	 IS8CCCgY+3De4d7pYhhqIJjPdnkjJlvuJZIfMC1lCVuv3CLnQfDP4xca58DJN2zUKPmfD
	 UBStQdlaIj4pdlVt4vwq4bSSQuvJWcW0NYyOpaXJ0SV/+iPGxFel0c2k67ECwzQ2SyQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070109;
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
	bh=6xSZdKDHq8gPq7B/8wI/HytnNkTTfzc2kcHznGAHkAM=;
	b=N+F6VDKUkffRw43E3O9uDlBtc62e71wK3w5ae2lTYxHe5kAYjX0bVda/IKoZ/SNRwvsX
	 Gqzhn0uUE+tkKA+y4B6LeMeJrRAyyyDcmjxzQsNQTqydil8d9V+j4QPMEWS7g/KipUDfC
	 PaCqAmm80swxk5PFdLAWf1tk9bNWcv6SIbe7pc4jEfUr2MDRrUj2MbN4z4mCfXQKlHAy8
	 KfprWXom9SPDSgYCAU/l8G96/8dn/P/Cpi5C49fkZKmK1IncE3qNqG+4ZsCl3UCySF6af
	 s6c+vmDBj7UGbNej8w86mcDvwklqe3olZJYLggul5OpHqliGvGwL5ZlXw83RT4gsOCg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070109;
	bh=6xSZdKDHq8gPq7B/8wI/HytnNkTTfzc2kcHznGAHkAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fVyMwBge0Jj3Q739H9kf4tH8u0v2TPXPvCqFDMdXkf28JUEo7dCphqRc6Fwz8SSDB
	 bY+ifhNVnRE7KqiRXfBMDYORG7kYxxXerck6tdhtFhyEVsXY2itVokN65Pzii7bR83
	 6TudenktUWOl2KNaw7U4KSTj27mF4MCDjQHyIoMjfXt34uMTb1iAB7iLRZEFj4L61X
	 q7lGfiv2aVBkVVOxGh8TbvlqNf4BUsBI4JuTPkAsM0ZOWDSzHYPkz8BnyDqGpnYDFL
	 v2ae6fiNKoLSQZvc3TRDdFnXFoAPP9aboCszs6na6BASR5Pisn7xSxhqeVpMFe8H6P
	 aJrShNIfVBA1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4724A60AD7;
	Thu, 15 Oct 2026 13:15:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C19D1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D53D4080D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7noGADeS6wvL for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5828E4080C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062837;
 b=S2b60X61VOZuMUtvjt30i5qcU6qwFSXOHuBP7pArz6V0qQerTTWiVC24cQx807W/lO7M
 +Ui4AwFNsp9cn8iZtjadH5rhqnY+ociunQ3xJStp9HplqR4ITS5Rb8Pb1uc4M/WtkCvNP
 F6wgFmcilyPr7PCrWrib2/2pD9rEdNtHFpSszQ6WElu0792XPTSk52ixUIWYrHRIkK0wI
 J9qr0roG7CKArySlu2D90t4xvwSB7ZnhFcXg6/o6ePGY7jadPva5NxbXUH9YA8n9zxgvM
 9bLqqcsikbzzhtW5HsXRH/SIBQx8N3rUK0FVENHDRhcXFauiXQcnQv4IwaaLfBmRaEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062837;
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
 bh=6xSZdKDHq8gPq7B/8wI/HytnNkTTfzc2kcHznGAHkAM=;
 b=s3dx5RXsQv6bNd3CwOWnPiC0tMc0qA3qNhyhD/AH0c2gl4we00TehTW+2NshFC0IQAd0
 qEZDqD6m3Ad/vV3WXJIPjqjlclakxG4LrnONps383qoB+oxixCTVRV0798PWjDA28R44k
 dHTGZ2QrMEKIp6SVEgD6cCPyhbZg4cUdBZLABBGucBWUuJ/K/L70AMPNWnoHcl9gPEKUx
 Nnr6UNIMJRsnTs6k2Dfjdv1ZxdFj9gtvqfn1psLe5kCtzmfgGdGZEHEll3BsimV/HRXaG
 wbF0Svyzw7AFuDbPXJPa3bri+/dmpZu4TFMEI4rZ+p7mS23thmj3w0wNJCWzVSviQSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=CZMmnvkE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=CZMmnvkE
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5828E4080C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/rIb6Prg/vfBxI9iWhg1EgN0GJJrfuof2hE9Xr7w0QW58mCAvJ+lmV6csL8+HoQDjv2oxowciVtPqum2NxGpDMntxW0+9nFjzPyqMtn6DLh99K7QBbTaWVkymhXbQgqZX3mwB1sAEm667svzkJpzUfhWHt/I5BNzB6C+gISoM83roPEK0bua4J4QUqqcIPPmeDJrq+8tSiH8g6BPVvNh6zXhfkFUv1DDOKDhuZv/W34JCNpYTnKFhTa16RENvrT1QUqLx55xjTAKHDZByBs6CDGW8u92u0o4+D96ia801EBMmtKJSCvOAebHcNVgBGK12hYmkAEL/oKpvG0U6ZLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xSZdKDHq8gPq7B/8wI/HytnNkTTfzc2kcHznGAHkAM=;
 b=WmqLkPTqS8HoRHbjSCby9qiitvMPzaLD1QXdmUGFkF/miPuZ6opdxEd4e5Q0Icz0vAA0SGka+H2CrTIqzp0S68dbNaq1ObatKXNJD0gerdrIe5IFFi+efepM015PtbrBSjOeuFyBtrO/XK7N5HwHnWR7B8Q31bjo+2lJZcBjRWYfBOTjyYLp0cr1bk7t6gVJAgzknL6W+/TQSwctqoRaRTaPE7tOWw7Bhu0COuQyJ54AHS+7wLZNbLoJde9guyliyJRZRuzTIbqSvKJuLJuuTi0L8c6YBtYMekNTQ57qeNJBg0qx6VarYTO57hAAbdVvhDrl4f3wREBlg+uflq/52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xSZdKDHq8gPq7B/8wI/HytnNkTTfzc2kcHznGAHkAM=;
 b=CZMmnvkEaxmtwuegkgyghxzq8bx+GJzNCPiPguhx1iik5UmEYwa5WHklJYxgFxNWQR+ad0YXs0Iqr0Z+zkCA15gPTzLwoE+iQ0xOXgn/yApS0vpx3HWWUBhp0qS+PWWi1dM4GwnfXCgxFZkfP6q6mYokvGXYlB0MR+wLXQTinVDViN4qZ1kB5swItKtqYZe4EfNhgBiG/+xgo1Ttahr/XmOH+JLfBBoX5IdqGvk7UCS/UImmiGwbBrC6V0i0FrxaGmh7RNfJLUGwvs+YTOfRgPPsuCXjCSB+adt0wffNJstK7XfnIla9KbcSirZHcS+0HAhv+NTv1N8g4P8eTGFKYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:13:52 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:13:52 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/8] virtio: pci: Fix modern private data lookup when deleting
 queues
Date: Thu, 15 Oct 2026 19:13:18 +0800
Message-ID: <20261015111328.1269775-4-bin.meng@processmission.com>
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
X-MS-Office365-Filtering-Correlation-Id: 47e8b0c0-57d6-4722-afee-08df2aad6530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eQ1gWKdw317ZB5RgEaeVP+leF9pn4+SgTA93EH3FItxPfJ9gaEzkvjKpmEIlfqMGzjvMcjPlOpO/Fd0tE4/pzeMQIkifx4dF9tkZoUTXaZxcOeMFcfRSou7A6JVsq5ptjwHgRR6CGGQedZRzzNWvwzTmRNjXCypZpKyfbVzVDJNE30tgIoY3G0VgOKHEfmbfgOWqGjKeiY+CXeoQGkNoTWz9SIYx7PVNSbWWUU0nYEOSnJW8PzAAlx6gdh2MqESPzN2f0Aa8DmM06Ret11Hwse/kLbv8dpOyNCXqzBttDT/EYmCUQv6xxSr56Xrf+Za0qQT6bkaRq5vP73+PRpoPxe+Ghx05mdRshSmmVby0HMWnfpuEwq//AskuIfn+bqe/9knTQ7Ucdu7JydUep7bZwHYFq8Bu5RwTRzUcQeBYC8pv3G8vvMpdhXbDZiNKs57xmPH5YSCoGKggXao49qr/u599HQBQao3wl/nWg09Y4g7dWSqHz/CF3uY4AhrlkjSstcDCoUQhGOTzfjMAzO/n4MFTx80lUhbK6BvfFNTWn82oM4WTkT7+fMMmTJwaRJYKMWB8vEbQyjPlz5uS+UOKQyrIXIanQdALWU48yWqBIWbd2CO2ehBDNSim0Ss9k9eiUCqMCx2L9f1ZPljccHhjNf+z6U7RzWAIQ7pcFfTL+lM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ars56/lQWSfogZY3MTWt8afQciCyG0AOsbfFBZ+I6/WcCoyQzQ54cP/HLz1S?=
 =?us-ascii?Q?ys3ZmLvifTGu/XdlNweFEInYz7QhD5sniW5PxSwOxVAeOwPA3rAMCA3q9hyq?=
 =?us-ascii?Q?kS8l3h327vtubAaGai8CKZYqX/18N8bIUAxoCwHHSje6nlkqaYKdlPZtx+ou?=
 =?us-ascii?Q?K5ES48tCHimkLoYSB0SfiGGIarJW63ApudvukS1S6b6rEi7jeO5tHGY7WXwi?=
 =?us-ascii?Q?tsKZOpGPxBr0ho/i1kr8bxyljdSyw/nrVMK8MKMfN4Pgd1Vy6FlUG/0x1lh0?=
 =?us-ascii?Q?PIeA0xKZ0YEn7xQnYKWaiTI8r0ODM4Q/xXJyFm8RHYdh7fAXUIJn2e3WNhgf?=
 =?us-ascii?Q?FgYs85DrLCc+kghcsF2ufIdkdKGLHD6aPVXKr/8eyihikzfaNfHyAe1daDet?=
 =?us-ascii?Q?AKLyl9/Gl18I47J6Z5wdGhL5H7fXWZjWhMHchNG1vOA4ai6hZwoIyh2Hw7SH?=
 =?us-ascii?Q?PKhDh5zhVYsgCH1+5FSKyWl1bLFXKGaN5Pat2JQ6o6K2nDb37VWnBDHe0qg0?=
 =?us-ascii?Q?9bsNm+2cSuYCWz0lyQ0UXb9wed2/nwODaPwXbkl7mX01LWZo3RBOIdMkI93c?=
 =?us-ascii?Q?+g+lMtHpFblh1GywBvfvqxE+/kMaQL4Q4XuryPStgjF4R9FRB4+ggjrTZl8y?=
 =?us-ascii?Q?+Yj0CnjrLMvtMMir/hqZdP23SPIG6tuynLbAW7B2GmnE0ma8Vami4dE+kyDt?=
 =?us-ascii?Q?MeO4Wdo3+jhq33k+Rpt1XB8Yj/xGPP5v3KEOZOWH4C+919bvCt5pthr1UTq3?=
 =?us-ascii?Q?tZQqLgmy6JMo5g1aVOAmhYiS/FlBkI7ZzLEzOX5YpQEsUMQgdXoOF24IU6lU?=
 =?us-ascii?Q?eCratGii4w88mhCCHZNbo0vEC2WjTpFnnHVulcZ4i1o9ZQ5IJRKG4jbbV4wf?=
 =?us-ascii?Q?B2/WG7M4tV14KA8lf5P5XW+RM+s8iUaJz06Eao/oLp6AEBZP8x75Q2gEfn16?=
 =?us-ascii?Q?HerUcluc64Pbsu/futPnx/I6Y162AX26unTDuH7A//p7FwucHY7KWYnFp6dC?=
 =?us-ascii?Q?xiJ/Rq5G+oVABxCR0OSjn2s6rEq9S4kNANHSLCt8MemBwNccngFjzqu8S/ku?=
 =?us-ascii?Q?MuCX++ykwTMpaQK+MPgjhcnNb2F/IRnOjxHNlEvsw4Qb8koIhni1NIgSlpM1?=
 =?us-ascii?Q?FzmzYDccbDydk0PgIGYo8o9TVbiFleo0449lkcoCuWE7RTB0Hol+jzjqedHk?=
 =?us-ascii?Q?DS2UsSJVNItq4XVvmTU9oQYKy0XjJ3HzRQ6wLqapVpEfXEJcA+Q8CSzNT5Ju?=
 =?us-ascii?Q?M1uap/9wxnMtFpI3MghQoRB1EaC5XnGEWCh6UCiJjJitGcfWQ84Xc6nLRx16?=
 =?us-ascii?Q?CJaVXiM+XtDy60FQen97MNwBp+67v/pEKYxiGL2F9ODSgqZNCN2tXDM+MLQG?=
 =?us-ascii?Q?E6OWNLm9WEy0PU6y/rWMQf3JYawMzm7pCn63o+kHDh/I1Tkg7VpaLvXPF1vB?=
 =?us-ascii?Q?jfeyOGbvGvV3+zS31L5gLGNL21vepWqBB0H53STqnYfPdve7TlOPmbweeHrj?=
 =?us-ascii?Q?avDKj7Sc2+5CrnxIEFQEilZM77MR2bUXvCTWWbYKGFAmq7ygDpE2mz/BPKuM?=
 =?us-ascii?Q?PVp+G8cRYX9OZHwSMKvi47i5WXYdSrBwzPFVh9jTSJ3IVIWwpf8BojYW1yaB?=
 =?us-ascii?Q?TMwPZ3MtxbHXbngdfuKPnGojRvfyuGmieAqoNBovAoZYOhqgwXrM3Ny6Cy3a?=
 =?us-ascii?Q?IVGZ+Z7iVoY45X+d5ggDpfpK9JhfznYO2DM39bBRFebKqd+E+xwN5e6R2KwP?=
 =?us-ascii?Q?D4CNUqHWMHKrXBQiptYQUASOhSvRPiE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e8b0c0-57d6-4722-afee-08df2aad6530
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:13:52.7098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44HqQ02C4xsRhySTYEBwHNVn81x8IGb+NgckkNYFkJuSzqh1tZxRZH8YaRRgjbLmBtd7dgKuYze5WPdz+yPxRPooyRkDwGKNcA3BZy/Bglk=
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

The virtqueue's vdev points to the functional device, while the PCI I/O
register mapping belongs to its parent transport. The current lookup
therefore treats the functional driver's private data as transport data
and uses a queue pointer as the register base.

Queue deletion can overwrite the queue's list links and crash when
unlinking it. Fetch the parent transport's private data instead.

Fixes: 550435edf810 ("virtio: pci: Support non-legacy PCI transport device")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5850e0c18c6..d309f9a9dc1 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -305,7 +305,7 @@ error_available:
 
 static void virtio_pci_del_vq(struct virtqueue *vq)
 {
-	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev);
+	struct virtio_pci_priv *priv = dev_get_priv(vq->vdev->parent);
 	unsigned int index = vq->index;
 
 	iowrite16(index, &priv->common->queue_select);
-- 
2.53.0

