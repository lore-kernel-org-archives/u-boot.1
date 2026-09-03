Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156E0C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCDAF40A86;
	Thu,  3 Sep 2026 22:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACmSQgHD6YYA; Thu,  3 Sep 2026 22:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5CCFC40848
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788473610;
	b=mU5oRbJRp3Z+oYqac7M/c7qpE02fMufxAvopWgzpvDl6g8ahxMoqOyD+OI6IyaiuZaMg
	 YArpWruWMcbAP8PLXxS18flqX0bmBosBqVq80i0NymSqnZdR8WASLBOVVKWAZZGGurGUX
	 RvFdT2QVKyf6SgHKhNjCVpgoTasT+rJT3lsLB+43ZdCbuP9Md8MoU80l8vHCira9NK47N
	 YAuMG1fTZa+77yOJpBARbKAT+FiivnG9TagnbMjTW44OiGOBwR0sFn6MSwXoaRqJvJje3
	 NTojmTKO4417tiLDqhCTilA+vwp/9Gsb/yJuQjoifSq+LDKUzuyJpUBrBRGip/FEClw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yZqNP7MyigQb8VDnYT4syxOBe2rHOYZLRxjrYlIta7I=;
	b=EXsJMvNd+Bd+Dy2gxfvOUlTqUpVn2t1SQa60yfQdG1KhsTmoL1zXFb18SeHR5trdb+V/
	 dIF6pdyIKm2xrA7/875Qkcecyd6Tlmx8YSnRSADAPMFUDj9oYW+V6JYpEUzZEpXnjMuKX
	 LFQlP35oovZ0+xliMuvDka8swJa3V4ZoJpmqiTiyrRudoObqkZVeo42g6FZI9aIClnsbE
	 Iv0XoC1EkvBm/DrazWeZD6ojLjs4NkGTY3/CELBrLA/lS1AUvD7rhMD4H8YF4A5rynIQ5
	 4HIWzIMPUZJTlJzgLX70k7dn31PktPyvFw2ABpg5EXk2wfCszQIyUBuPAdNT9iAQ7Ng==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=prevas.dk;
	dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256 header.s=selector1 header.b=A6a8gZ40;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473610;
	bh=yZqNP7MyigQb8VDnYT4syxOBe2rHOYZLRxjrYlIta7I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k6ocnyTLcfd032/ZoeXE90P4Gw9fuQvCCc/PHEJZZqhkT2XhfIZ9d5kFxvqznG8+B
	 d+qHYUvQEtIrNTcKiYMETELnVXNUPv4KCmPHyIsOo9Ryl9Gr5oxLux/WlMDuI4IYrL
	 Cw5RusiZR7b61G4FNbD+vnCgjoViVEcm24wjFCugitT99GJBR1inSdkR+X2hk0vg63
	 VwqvrACtXySBwTwYYoyCbnIJSJLPbYhMXD0EclA772yjfx1ZjUF/EyBlA0RheIm1qu
	 F4hSz+syHdf4CuJFHGodBuslr4vNxnzVOZ5iySFd/pXYJbGcSxI/UW6qYaTBG7RV8r
	 g7OK7fPjA+nPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CCFC40848;
	Thu,  3 Sep 2026 22:13:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 00145422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA67840A3D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qp_lajXTL5IQ for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:22:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0F15940783
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788470547;
 b=ilDUQSvH5MLHy4JYRRGGTuTR7/LzwkAvVMia+afblOm7NrkcVW6bNCJvjSf1MX1OaG6B
 tyt+FAx7NvbSOcuaojHtQCz20Mt1aWYq1W5Wl9wws6tXoNHqYN6qPcfRu2sQ8Wg+0+YKg
 +I549+mNIQ0ois/tfvR42pQLxD3sECw9BJTSg8QZxIkR19uQTmTY43lY1krrGPtzY9CHm
 CrKWxxweExiAWdgWx8xpl89BGKPwICIaw6Tsq4l0inG5cCC7XtVy0FuCMBoyht+Iql6PS
 GGLjpDNs2m8kIwKFACQGmCUGFAVcGznU+GVCfXhXkRhUu3zm1groY+uCGDduG2cUTbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788470547;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=yZqNP7MyigQb8VDnYT4syxOBe2rHOYZLRxjrYlIta7I=;
 b=GcGYD+U+mOBS4ZHHaXXjUjbeXQTKVOgepHjR3vzOY9rXfLvcMPVZWbTswJINYfUf6PUP
 eSCOL7E67OauhT8tc7524bKIBxQDZNRJ9zzzaYtwxIc6Bb2ACSYZTie87BsbFnsWa5gvi
 IQ/qpuLjERSU6ZnzhvhaXNxrP89gcwslMPsdayao83cI9jMbjIQLwoC9gVbS332KlexKa
 zt52PkCSClzH+b2MrOyIcHfvhNGvbhPa+jiIPO/o0nNfANx3dANfbM5FOUfIi4wEiZcKg
 9j5I2T0ZTATpB9mG15sx9rEkAWO+F2hIoqwRBwrtfJTDK6L/igmAbZwN3nKjKZUE+zg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=A6a8gZ40; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=A6a8gZ40
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F15940783
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUBxqGCdPxvvWOVlp4ixbHtz3KDjA2rAvLRCEkh3wTkbbwXFevdg5ih29hMkwHPA9yKjAJwMxhQ8wXdPPv5i3tibUfj80G+YadHrsK9aKGga2XnVY4H9h1BWyt4c616Lcqs5wcNm0kFyvLGMNKMLDGfMi4hoLssOUjYojNFvYReCqS7atHPTeBamX/UEs2Eot4pvdjshafHVF3SiV3yYfmHMOcKSn7ai+NaEPI/4YL3Ew75dUMaEKR7Uau+LKc58+i9Xj8jpGQNi/KOg3yeBloN2ZgIsnCMbkPikwLCc9SXn0nsY0SgesU2fzzi61I6tWEknajylPFUoe4jcfj1/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZqNP7MyigQb8VDnYT4syxOBe2rHOYZLRxjrYlIta7I=;
 b=pMPOfPbJSshharCA/OoCaonGdeafp3kVYYCC9H+wXH9pmsmr8FY/oeDPKwWA3GQT7m2SN7wQIRchBObmtJKVkWDxCesQCPjgvg9vttLg7606eS5hgm8IgC03wU9tjusJkC2aAvxOXRIHay1H1xQzvJ7N5mnccF52OFFcbvGbEIn170j0RsimCfLuTwQip2x9drIegTyKoreReKTP1LGHl6fUw26yMiyqsLpluAJWm5rnjzICz3PdiRxarh3UGGh2smyM/1PiDwkpc0nnrCFPffvCTTzwjMZ94NdodZzxq3euUtel8EfMcMcjOK/RdZWVXNt4SiJ6Ii7TYB20rUsQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZqNP7MyigQb8VDnYT4syxOBe2rHOYZLRxjrYlIta7I=;
 b=A6a8gZ40nfjkfNaSFVmcGK7LMuErA9kLZF1sVyF/qzBVtzvSk3uCgMW5rK9gbFChHnboKZNvUFKtxPfN7gUmvHluQ64WILS883OfXUIsgQIOcgdjUO8hPviTQqBxW3WlkboxLEHN1MsZpcads1pIjvdXAqZKYJzVyaN5JRcfrMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 21:22:18 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:22:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/4] cmd: optee_rpmb: make it usable by scripts
Date: Thu,  3 Sep 2026 23:22:11 +0200
Message-ID: <20260903212215.2331118-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0007.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a1f0a8-b4a9-4718-b88b-08df0a016ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: eFier6qFaoUHJWzOVgbSRg4N4AnX6q9IkJAuX+y6R/rykXiOdnyE0vGcWOSHXwl7XmTdo4J7fEzLV82nNVL76hQYg2ElEBhyQh1AyTr8KS77E1oMvbzTgYkJea/Uzj7joWuSlQk9woEWaB0egJ4rnglnhUkoIyAnGhqaSLl/vSPXBZHD6tgt8mNTlpHczoHrG/XXTdM0uZjSOIHAlk04doTbmlhmDUEztlkT9tP0rC3UDHAS+yh7aE9CJ72+Erx0yWnlEwxDJnWEp8evuMt39fv9Uuqu4ht0iHMkdsJtRi6q9UQB7lEUvZ0z4hZqGc7mSMT2oYAea4GBd2PiCxdBSZAGfvM9xEMKPcolfWYOAhqCqS8F4ToAhs8ByeykObSYswn01T9M+uoXokt6QnblFF5xF8D4y7ahuP+yXPl5HQl6Mu2IWORReFtOa1VACWHcubPPuHH2yDjkcUJaAUD5fWZEUGS6OQXjwmZT43dSBqLUSrjbfzRQFuvst/Pf7PvCtoVENueAhImphetvXD/mumShS215M5PJTI9dydBHK105p84qYIaJ8K+Yg1IbWg71odOwxMaJxXb3KSkOgLI13CJXeYg87KKtPYuR05vBkuozhfZ2KzbUvjP8ZZ6NATdO3u8CEnPypzTMPdUG3Ul2IcwpX4qhvOkKLLw/J0O3dbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(6133799003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3uyVSPIGNfc25vWJk2A+ynbfHUDPGTBKUiCaYg91BltcPIU4TLW5WyHhdVj?=
 =?us-ascii?Q?Hn0l0oCDUN5r/7IIvLoUHLSoSG1JCGqGmUIUTleT3FL90lyi+NCIrV0xQkbH?=
 =?us-ascii?Q?ZCdxuBHaHizpQE//ALZXeZNTttaa/khZkvJUC0oyh0QMnena2m5+qv6o146L?=
 =?us-ascii?Q?oqzjENNvLw71OBA6YyrBiy2vMo5NRSXgtmITP62ECphfAQsqlN+iou5dU3u0?=
 =?us-ascii?Q?dzxCQnShUapMgxJZbwd8UAvcwHvkbmGhyl90I1w1G3s/5c64JLMCiGxyjP7j?=
 =?us-ascii?Q?AORyp9eh5Hi0aPvf0X/Gvd3hRfi++ndfZEPvzi8mR/elpw5GgZkM1lKgeguv?=
 =?us-ascii?Q?rqDRJazi1tcX7qQAayh9JWg0ENBlVbpoS8W/TeXOQQOkfhhtQdr/k+InvC5Z?=
 =?us-ascii?Q?9Kqyj37yp758sJWTPS+Riy7XQ9R02rNwkJn0LGWs0FC+zG2JpOih/rjCmj1+?=
 =?us-ascii?Q?Xd7lfbUeWlruT3ywEAsVKIxvRkSWKvmGGUfbEjGuiXOwD3pFSW/VDwRATCYN?=
 =?us-ascii?Q?qbDIwjRpNNeQzw3d/7T73y3HUX3V5q34U1OMilRm0aFyjNu/4DzE/2UM0wep?=
 =?us-ascii?Q?r1HCaTq0WmVanVCfdifEqx5oyHgk+fSEaMMYLpxKLMvRDAhRPBOGR+4Ma80/?=
 =?us-ascii?Q?Nq6JCzEcLT5Cqdc7bxjRfwfaWNJ1s2TA/RMwwhYWqAyG/SJvSI4kT6qNxKf2?=
 =?us-ascii?Q?CPzbCl8BvrVa7J3SAoIzhbEto6PyXY32aKQr/l0AAxtyEdGmrAnC94L1Sr+g?=
 =?us-ascii?Q?ro1DkXGy7kMfNcQzpmiWF2DwZF5rCRxpWz/UfGa4BPDn8a8mG33dtXWX6n5Y?=
 =?us-ascii?Q?Pfp6mrJy80kU9Pnnvy5qiSiGbSQe04Mzo1IW0OBmUtovYgsA/XU67wb51DuD?=
 =?us-ascii?Q?CPjnCgUOui2amsupF9jv/gGQTy0HgjflOwJ7wRnUFYSSMfHFkkdq9nPfUKfv?=
 =?us-ascii?Q?5Z6NBKcHf65+43TtdX8q1bnBRei1YIeu4wBGCV5ou4+M5ev7CuhA+bJb4kX7?=
 =?us-ascii?Q?FZym+wEGgw0VZ2ccv3FcO9onGDk6U2VhrqTikcYZfN1tp1SO97VuFJqJld5H?=
 =?us-ascii?Q?e15xSIWEy409smtVwj8DLVKurXshs0XXLmcysa9saBZdnxBar897MWq1pBAf?=
 =?us-ascii?Q?Nsk/JqUAOBN7Mee/oi8LG6NU9gpp8yK9REAc+KArWLWDO8M4xJMz6MqZC58z?=
 =?us-ascii?Q?FOmIjz3fXmazDtjFtef5c6z7pm+e3r4TC6/gEXd3DrZbCiQR3aC9e3ILfi8S?=
 =?us-ascii?Q?RvU/W6sIg0alAyWQXfThTKX/FhXC1emc/Q0OSTOp80oQVQeQmRLOTz4zaPTK?=
 =?us-ascii?Q?mNh+CIwKoWqv1SrPw2a6ZzK9/LHLzVU/3IGl3sa8RrpA7IG5+LWplt+gsQNg?=
 =?us-ascii?Q?mGbtcTI6qxY3RqZ80M20nI5fhbdx4eIVruyhCxCdhk5zrwc84V0Lf2js/xlz?=
 =?us-ascii?Q?Y9CR26TBsXp2Gy11XKucBCdzbNzbRPYI7RH83MbEtjkBguMBG0va4FqDB2NI?=
 =?us-ascii?Q?WsshENZig+iF/q9AYZG3a7ndmLWSPZ+CrQYPHJP1sQNal88PSkprC/MqxQTe?=
 =?us-ascii?Q?WAg32oS+TuM+97kFd9fI6L4GDNXU0ZGhf92GAeKokRmwMbigStx4uD31qD7D?=
 =?us-ascii?Q?weHDLzZr1SUQD4XAVm72ATDJKNxqeokmul7EF+9f8jC44N6JbF/7yPgitODK?=
 =?us-ascii?Q?7k40Bl0GfGd+JSG1Eztdu2/zFCG/jQ526TlZY3kuhrA4MltYDJRqVmhpeIdk?=
 =?us-ascii?Q?z30aguenoe/zQ83pDvCkpLs6/keXaNo=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a1f0a8-b4a9-4718-b88b-08df0a016ea3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:22:17.8986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/MLHgMUkIyjC1reJp6aQS4lu2Afz8WE7tv0p3B8UQ6K9UHE/emdcxk5QrwytEBD1qRVX/ohNjozXW2I/pyOz18EpIN8n0S9ldv7mxviHFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:19 +0000
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

This all started by wanting to be able to fetch a "persistent value"
from RPMB and use that in boot logic. I noticed that the "optee_rpmb
read_pvalue" subcommand had two flaws in that regard: No way to
actually store the result in e.g. an environment variable, and having
to know and provide a "large enough" size of the value.

For the former, it's just a matter of letting the caller provide the
name of an environment variable to store the result to in lieu of
printing it.

For the latter, the tee side should have provided a way to know if a
too small buffer was passed, but that was never actually implemented,
and instead a silently truncated value would be returned. That has
been fixed by adding a new variant of the
TA_AVB_CMD_READ_PERSIST_VALUE method which does yield an error along
with the proper size to allocate:
https://github.com/OP-TEE/optee_os/pull/7959 . That is not yet merged,
but I assume it will be soonish; these patches should not be applied
until it is.

v2:

- Drop the part touching common/avb_verify.c, now that the old
  TA_AVB_CMD_READ_PERSIST_VALUE method is not changed. That doesn't
  mean it shouldn't be updated at some point (the header file promises
  behaviour which is not actually implemented), but it is out of scope
  for what I intend to do currently.

- Do make use of the new method in optee_rpmb read_pvalue, and
  implement the "store result to env var".

v1: https://lore.kernel.org/u-boot/20260828105005.200338-1-ravi@prevas.dk/

Rasmus Villemoes (4):
  cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
  optee_ta_avb.h: add TA_AVB_CMD_READ_PERSIST_VALUE2 define
  cmd: optee_rpmb: allocate large enough buffer when reading persistent
    value
  cmd: optee_rpmb: make it usable by scripts

 cmd/optee_rpmb.c           | 70 ++++++++++++++++++++++++++------------
 include/tee/optee_ta_avb.h | 12 +++++++
 2 files changed, 61 insertions(+), 21 deletions(-)

-- 
2.55.0

