Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E974C9830E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 23:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6DB3606B0;
	Sun, 27 Sep 2026 23:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Tvw1SOCKhVL; Sun, 27 Sep 2026 23:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CC9796069C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790553484;
	b=SogJjdpgvZJmqmSCCa/ucs21f/x9eD9QKb5boqidKFAmc+NlloYqXBBEWRlCbsH8LSaC
	 MDdZMZ5w4noRx+q6DaiqD7q6rjNRsEoBYTt/BVpXzlZYSevQL/pgigdvcdKtH9neafuFh
	 7uEsqpxPo67WQnmymgAWpxl40rDSrlzzdpwLd4RK4s9++bAJi7BWato0yV6f65/wCSQT3
	 NkWlet3CFW6FXhHoTDWSAXLflsfANlykXz7dhh4axjM0eX8Mh01IqgssJR79RJt6yH5uP
	 HI3PTRZKRMEGuMR8Ame8bX9ZCQq3X/EyF9pY2FmbJrbB/Qk5eoOt6pe9oQ7A2plcQ1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790553484;
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
	bh=fxlctoReEuJi1qWpw7Z6O2ZTJEwQL5tqXOKScYQVGoY=;
	b=K3zfnOSp2AlCv8leo7jsvCimG++1DLuk24cs1WQhBMinwfBqAPgivf2VbaadOlmVDcFa
	 tDnVVUCXNsoLbcBECGv8JcuZnKN1HjqfRUWXGM0pIsYNc/Y2lp0a5kVB6HMTocEQJllYV
	 AiC+grmlYEXt4wGy6WNnvksAY8fkNOXz/OlB9X5Qkaz2gLaBkkqttgHuaw8Udz3KZEqG3
	 kykkZ/79Dc3vmEK4jbPaHIrj3WRaix/XJ030BdWDZHt7wfQeeQlhdrV+bhM4s8Zaz8J1R
	 tld9jkEK8AIJo+Wr6mKkurcL8uG50+r52WT+jLH1vSJQp8VLrweKsIb6PRawCZbpluQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790553483;
	bh=fxlctoReEuJi1qWpw7Z6O2ZTJEwQL5tqXOKScYQVGoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulw0WLvHBh8VWqY1JZFbOThTuSVabsahVIJ3CxAfI6KlRSmIs0jECJ0YRwBatmxU6
	 Bjb4mHMuo2voUrENQAGYGMKLPXnZS6rkc8k2Ey0IsUuyoNfAtxkQlZUTEQItVvUlNl
	 w1yx7uy3cRxKlPPvOGKFLe3btfJZbmR0gy5aQ2sHeN3LUhkX0Uega98QgsRtlsLLOO
	 IOaURpAXh/MED/bgvQrGXrwz1ywSk7zyWh17BgT+nL4XtjAJl4tJ1jVz3iVwxOudtR
	 7JQgDyimRXwJGn9cNdecygJ/wT6wn0Pa/4RzayL5FEsUwyNQUqeW7m7a9oPEZvSsRh
	 FsGlMMkxsmmPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC9796069C;
	Sun, 27 Sep 2026 23:58:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C584B24E
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B771D80E34
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TXlFOa-biCwz for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 23:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C23B380DDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790553479;
 b=mGsn+1zoBuZgG4SNzRxlMtpy69QPZLCQFRHzK+rGoFQdyGopHLy1BfNhNW5D3QI4WlUJ
 6CyT6SS/xxvuvF8qfC+VLmWQxS4ekOzsF+U7wrwBawOY/axHbTu6U0XsO0fUMcV9GcbBy
 gxeBnjEvlXL3M/Jnr3iC9XuB4ujfy5XacVNjfYR2UjfEbfow7dPVawmG+lKCQoEHHyY2e
 PXqxriA9e/M3X/qxos00zFSXCwDJ/jRrZ5RvDE9TQVS1eyTphT1vpGQePZtQVvUlfRRMn
 uOhLPZE808GeryR/FYQjwwO+itt0BSV/wwA+jqkqAfH2fEmOJgEuVSI+Ny8W2VBgczg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790553479;
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
 bh=fxlctoReEuJi1qWpw7Z6O2ZTJEwQL5tqXOKScYQVGoY=;
 b=ndHEsR8jDXehEi6/JppQ9jGgtToCK9Qseej3vrQsy5o+Tw5J4GMaHlDUV5Yk/B75BuuH
 FQmcHXWbRT15T4ogZ+PJ8iNoOXS8tkPQuBAPOFC6fDvYZaHvq1jFJ8kP5eW21+oAKlgzG
 1BK8GVKbRFCZW+fFnV4f20eVrb8TTTVncwQZ13WMC1Sdf29LQ9pehrWbgDGCGXdX+FM5J
 RxJBTrdvUzQiSxLV6To0YG2liqO9n1Qfr6n+F7+SWKSaqA4rNW4prKGxRW3f/1zf/GSbV
 cVySkMBhwVDG54cS2zYq+MfjGYXnkU50WmgUBdKQa7wfsqBwqhuF/UhIpuf5BIWb6iA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=iopsys.eu; 
 dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=e2etW7xE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=e2etW7xE
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C23B380DDD
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9xVru+BT0RPczEBVOzYgmwXROSPMNuv5aCMPduhZXZKF577KYCR2T7owC9K2X0BEmoxJ+j5cjai5Qu7J8Dzq8CL32nfgscYRVBPRu6IUUYvItB5I+UfEZ5CkjBKhgnJMALbObjQX0Dne1islYCq7G/jw+r8rzcGeOEXw27KDqTf5kZaP+T/Xj6zYaXgp+M28KV29QvhdlqLcn5rzbI/JxX9om8FItnhUf9JB4D1SbICfDr49eR04C8fQGEUDJfztMPV/U96ZtE0jnUVZOwkvxMP+H1BjCbzxGqehHZi1XrcXgPFPXOWFj/VPeobKNYWe+58Uli6qm4vnZjGfAwh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxlctoReEuJi1qWpw7Z6O2ZTJEwQL5tqXOKScYQVGoY=;
 b=Hbl+L8RHB5ZiKVZaCYCSF+9b4XbElqOzEyIPGvSHHfaJbZle+Knw2b/G8k+6y0N1fv4C9N7W6NU1N3vLDCtGV5rksUmmbCi+FmLxdd4aoVGeVDDLax+GVnvNUqcJxIUeCZ+V0ieZolMlCWgKZeahcfNhBYnHVBZqlhJGPo7u3VW2Q7LFkcg7SR3hwEUUZBasP/Y9585yOdZSY3Ly67ulLdyIPGcrJ6cJiEZhtjDnXmJcAroOftc/8z23YASATI944yMmf6gS095Oyo36fAjAQMftUseDyYntnzX0zjS4zM9OGLfyjkfh4Rn0DQJU6Hp76e3HCr+QytuRPEwIYhYS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxlctoReEuJi1qWpw7Z6O2ZTJEwQL5tqXOKScYQVGoY=;
 b=e2etW7xE9MWR6lEFduMnvVcj6vZddksMepT0Oh5wTDOWSjNoQePrAS5qCpkyzE6DqEksuSVhTOP1U/mr1g5qoojU/K93G5zNcZ8Bv6agdYG53WYE2w3BAkyhirSQWKrvuD/pclpx6H7pzupTmkArM2R1m66uculVvWusD9rsR4yhCyzLmTVou187je7zgsFbfIpslS94eiCgQ4UMB5Oy5DBdd5I+f+SKg2t46IdG3fhXVlveBnshhSHmxcuzC659UOLIBqq/z5tbIbOWbVyl8OPrkMwWpub7rLZqzGaSX5lba0D6UuNaqldufHnDD4jVW0BjbfwrX1ogh/FQ5+NXSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8347.eurprd08.prod.outlook.com (2603:10a6:10:409::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 23:57:57 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0472.005; Sun, 27 Sep 2026
 23:57:57 +0000
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
Subject: [PATCH 4/5] spi: spi-mem: sync code and behavior with linux
Date: Mon, 28 Sep 2026 02:57:15 +0300
Message-ID: <20260927235716.1872707-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 68c9a743-e1bc-4054-6220-08df1cf32711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|18002099003|22082099003|56012099006|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 79DNNEy7ZSwwCWCAoVHk00ScvekNwNLNn+/0LVprYHo4pnrRXgSn/3QnbjUhCz4s5c4dESpADm65IzEqbLVF5bEa3HxRo64EwSSAZXlt24bFRt/pk74FJ22aE8jxaHhMIreRGY6Ihf2hsRGydKWB6dv2UCICCN2bCUyQUGpoPFcuOb/UbKevS73WJK89WR0HLFIwsbvj0yMiVkTMOnSTNUUgfRAlGCWbMJorQoCRoxB+J4mAVnjZsDW2V/T3ILbCPxhLikyFDjVQcZhRl4/nAcbuP7pKP8/HjMcZ4YcSNPZDPKgUW7DyPqAn7DGgnY62rhnhtvZ8yOkm7ussCtiJhtdD/LpqO1QT7vp5KcauaKRI114U76MBxdV6GGyknGCv123ZwDCSZLfU7uXP/S/waPpOrIEWCC9JlH7jwdo/ooTX3LRGMdW1hUSevqWj6ZaxtGM9fIJOuR5bcmPttVdfkRQxETkuwPCVyMTN4/vDyqlu76a174OYo6ZpGi9JumXRDunmjLilJl8uk8kWNxocJx5/gMRvYGTppoQGJ1nWRhSfqlvTLDOwZKyudWUoO69k1nH6mwZfEqDijlwXtaV4HEo5z8GtfMv+CU3Y05dfbUZDVYfnlGP9QYFUB0n0tiAgK96ZRjFC6U8KzphhOPOPxLVPs9wBOsSn8B3hOl6evbSb/0/fD9T3dF5IxJzkTzIoKhNo6f+1lgiQNbVsmEU2LiuWD+PEBEb9ra48ochNHxPzGxdbcA+4JTk1Zquu6eHC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(18002099003)(22082099003)(56012099006)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J1o9Ev7Ivor2lGP+LZuGXELvLQLM4kWLww5wE5S5dsqp0hjrCBcdXMF4hQ5S?=
 =?us-ascii?Q?B2GPpd8yNL4Be8L2HCOH2TuM9fHMtaEIjzGDw98B1nrVt17XpRl8ZANmX0tI?=
 =?us-ascii?Q?EbH7yLelTSEXuRHH6kQQQ2j7S2zlirhQh2vsv1baiGNQdMr1/uHSroYol2mT?=
 =?us-ascii?Q?le//iB3HQQfbMDmtnT/pcSepsPOCS9vVl4EelUbqI3kD1vo+7m07UHCPvozc?=
 =?us-ascii?Q?qFiSVV3U8TgJ19+4XAQUVusg8v9Rv+HPu+3zNGV+xYDbTiy91zrO4zQ1Wbhd?=
 =?us-ascii?Q?oHUmlIJkcr0JqlwvAQfFp1+yk9fyPuC2J1JzL6Vj5Ne0i2zmaI/CogXRmhwp?=
 =?us-ascii?Q?6BPqwKtGRRmX3w154DIV1hd8I0sEdbkmbzeL+TvIE9Rv4F8pcy5crsqGVDVn?=
 =?us-ascii?Q?9bMaA+6rdxob2UeeICG2ZUazPE+ZKI9ep4H7LG5619vMXSEylpktcACI9Wa8?=
 =?us-ascii?Q?RuJEGCzxVg4WIyi9fh4RKmWr88i4yCYXrccoIYU0JhWMzlasnFmHfAoOHgca?=
 =?us-ascii?Q?OWP2qCVLUQbzrP9edNQoX4KEcEq57QhU4LC26MTMOJCCMuRef7Gi1X/+YdDK?=
 =?us-ascii?Q?a75EBEiCzfN1Cx3TurQTwjnohpbpu7z+Scj/tdHIiDJGLuS4ijc0Tm6o/FS7?=
 =?us-ascii?Q?g/GzXHsU5T3yUbQLtxM8l0zvyv7DCfpbro6HBptyK4LLHcAEg9HaW4tsjU/U?=
 =?us-ascii?Q?Kn970mpApOqsxUEVY93RvQBusyl738sFlu9qeg2fdGwWT1LdZDLs4l9qJPj6?=
 =?us-ascii?Q?/fK9uBD88hxL2dI0pq+9nW28kEMbj/f3Rk1nnzMfNNZcyl/uTdZFgTLZ7/rk?=
 =?us-ascii?Q?3IRLU0tyFF2EqWcSk+tgDa6Osijdnid5NuGCYZ1TGN2+X+J+akfyfuTWWEJ/?=
 =?us-ascii?Q?bbySmttcmCW8eAf6MNt/RJhwggP23+hY5tyfziL9+w9MW20Y43kb4ml4u485?=
 =?us-ascii?Q?KMEO9oiF/iMJxQiOA4PEbfBVSuoH878euczFCXAMu+XAEU5cQ0FLyjGStCw2?=
 =?us-ascii?Q?uuWcCrbSm016j0TbMxh3fGjr7rG3hJzknri9LondgEjfGJeQCguC+xGpbbMb?=
 =?us-ascii?Q?aipIiSHEH1choZB7QRmtRZCCbqVSic+hA9wANgEHrUijWtXOelb2IdfpOcED?=
 =?us-ascii?Q?Cf2Z7HtmsvMTzp9qDMX5Pl6csps2KPLzYYLd65CfCc0epkFG5+cA9miQm7dp?=
 =?us-ascii?Q?ZS/gjx4yM1yJ1z9IPOpTWFZvhvar8+3N02Kg8yKgpfJ33tccSUITTDX5XANj?=
 =?us-ascii?Q?vCvd90GAd4vCI1g3qLB3Y+WJqyQGmZ+pliSUU3SnryACvKRh+iMINCVa9glr?=
 =?us-ascii?Q?pYwUUtZWqxHJHh/ynYlYdw7xVOgBHZu7Wg9N4BY58+AqbSzXYIU8L2OjZlfN?=
 =?us-ascii?Q?Exi+lPCC8PoMsJzsCAGwoxisqINMXIqRK5bbtZAqsQyQD2EBEcSzkHJ/AWNj?=
 =?us-ascii?Q?rkUt8OFVyZUObmTV2SP1pkSkEq0Nc+/fNOb86t/GJnpAIFuqPzma8H8hLdx1?=
 =?us-ascii?Q?PArIpPnGTCUDC3Atc4eni3okP+c+5qaIkRj6gmIeQxbd3gLL/1MXRRuawc63?=
 =?us-ascii?Q?zgLfsY3IC157iFBQM7yfHc8xPUgBwUez0Rl7SVe4uMAEzsIwjxh0/pYDqpp9?=
 =?us-ascii?Q?SFl8NzjXEevUAzf84Tl1YA1IXl3flFZfU5pl562zAhGkhihGWLQL9gAEMZo5?=
 =?us-ascii?Q?H68oKy2lSiygQX9OxYBFrl31YseuNONC1aBbTSAW20c0ftM+aBDS20Q5r5i8?=
 =?us-ascii?Q?K26f+8XboegaVyaXcKQu77oXW8XYDmQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c9a743-e1bc-4054-6220-08df1cf32711
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 23:57:57.0177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/rY4KbdFd/g4tXzsM5hZxZodnX1/4ACODT0I6peWNk4RuRNlnJqWg+k/bTve15wR+fnqqdDyxdyYbFjFfq+MJZ860BW++VaX/Hd4Yb0EsI=
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

Align code and behavior with linux-7.3.

Changes:
 * add comments
 * use the same error codes as used in linux
 * add more checks for spi_mem_op
 * add macros necessary for spinand dtr support
 * remove unused macros

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-mem.c | 65 +++++++++++++++++++++++++++++++++++--------
 include/spi-mem.h     | 26 +++++++++++++++--
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index ae393ca48bc..8ceebc2be7d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -22,8 +22,11 @@
 #include <dm/device_compat.h>
 #include <dm/devres.h>
 #include <linux/bug.h>
+#include <linux/bitops.h>
 #endif
 
+#define SPI_MEM_MAX_BUSWIDTH		8
+
 #ifndef __UBOOT__
 /**
  * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
@@ -213,6 +216,45 @@ bool spi_mem_default_supports_op(struct spi_slave *slave,
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 
+static bool spi_mem_buswidth_is_valid(u8 buswidth)
+{
+	if (hweight8(buswidth) > 1 || buswidth > SPI_MEM_MAX_BUSWIDTH)
+		return false;
+
+	return true;
+}
+
+static int spi_mem_check_op(const struct spi_mem_op *op)
+{
+	if (!op->cmd.buswidth || !op->cmd.nbytes)
+		return -EINVAL;
+
+	if ((op->addr.nbytes && !op->addr.buswidth) ||
+	    (op->dummy.nbytes && !op->dummy.buswidth) ||
+	    (op->data.nbytes && !op->data.buswidth))
+		return -EINVAL;
+
+	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->data.buswidth))
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool spi_mem_internal_supports_op(struct spi_slave *slave,
+					 const struct spi_mem_op *op)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct dm_spi_ops *ops = spi_get_ops(bus);
+
+	if (ops->mem_ops && ops->mem_ops->supports_op)
+		return ops->mem_ops->supports_op(slave, op);
+
+	return spi_mem_default_supports_op(slave, op);
+}
+
 /**
  * spi_mem_supports_op() - Check if a memory device and the controller it is
  *			   connected to support a specific memory operation
@@ -231,13 +273,10 @@ EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 bool spi_mem_supports_op(struct spi_slave *slave,
 			 const struct spi_mem_op *op)
 {
-	struct udevice *bus = slave->dev->parent;
-	struct dm_spi_ops *ops = spi_get_ops(bus);
-
-	if (ops->mem_ops && ops->mem_ops->supports_op)
-		return ops->mem_ops->supports_op(slave, op);
+	if (spi_mem_check_op(op))
+		return false;
 
-	return spi_mem_default_supports_op(slave, op);
+	return spi_mem_internal_supports_op(slave, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
@@ -265,8 +304,12 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 	int ret;
 	int i;
 
-	if (!spi_mem_supports_op(slave, op))
-		return -ENOTSUPP;
+	ret = spi_mem_check_op(op);
+	if (ret)
+		return ret;
+
+	if (!spi_mem_internal_supports_op(slave, op))
+		return -EOPNOTSUPP;
 
 	ret = spi_claim_bus(slave);
 	if (ret < 0)
@@ -629,7 +672,7 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 	struct udevice *bus = slave->dev->parent;
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 	struct spi_mem_dirmap_desc *desc;
-	int ret = -EOPNOTSUPP;
+	int ret = -ENOTSUPP;
 
 	/* Make sure the number of address cycles is between 1 and 8 bytes. */
 	if (!info->primary_op_tmpl.addr.nbytes || info->primary_op_tmpl.addr.nbytes > 8)
@@ -807,7 +850,7 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	else if (ops->mem_ops && ops->mem_ops->dirmap_read)
 		ret = ops->mem_ops->dirmap_read(desc, offs, len, buf);
 	else
-		ret = -EOPNOTSUPP;
+		ret = -ENOTSUPP;
 
 	return ret;
 }
@@ -847,7 +890,7 @@ ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	else if (ops->mem_ops && ops->mem_ops->dirmap_write)
 		ret = ops->mem_ops->dirmap_write(desc, offs, len, buf);
 	else
-		ret = -EOPNOTSUPP;
+		ret = -ENOTSUPP;
 
 	return ret;
 }
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 08d854b1e52..a69fd0d0948 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -22,10 +22,18 @@ struct udevice;
 		.opcode = __opcode,				\
 	}
 
-#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+#define SPI_MEM_DTR_OP_RPT_CMD(__opcode, __buswidth)		\
 	{							\
-		.nbytes = 1,					\
-		.opcode = __opcode,				\
+		.nbytes = 2,					\
+		.opcode = __opcode | __opcode << 8,		\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
+#define SPI_MEM_DTR_OP_PACKED_CMD(__opcode, __addr, __buswidth)	\
+	{							\
+		.nbytes = 2,					\
+		.opcode = __opcode << 8 | __addr,		\
 		.buswidth = __buswidth,				\
 		.dtr = true,					\
 	}
@@ -45,6 +53,14 @@ struct udevice;
 		.dtr = true,					\
 	}
 
+#define SPI_MEM_DTR_OP_RPT_ADDR(__val, __buswidth)		\
+	{							\
+		.nbytes = 2,					\
+		.val = __val | __val << 8,			\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_ADDR	{ }
 
 #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
@@ -116,11 +132,13 @@ enum spi_mem_data_dir {
 
 /**
  * struct spi_mem_op - describes a SPI memory operation
+ * @cmd: the complete command
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
  *		sent MSB-first.
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
  * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
+ * @addr: the address attributes
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
@@ -129,10 +147,12 @@ enum spi_mem_data_dir {
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
+ * @dummy: data for dummy operation
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
+ * @data: the data attributes
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
  * @data.ecc: whether error correction is required or not
-- 
2.53.0

