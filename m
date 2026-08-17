Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391FBC5CFC1
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 07:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C000080C9B;
	Mon, 17 Aug 2026 07:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oD7s-qwjR1ha; Mon, 17 Aug 2026 07:59:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 538F8809F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786953553;
	bh=B9COAeR9Uh7DRtjS9Ltc6Hprre49AyxehQkFrum3Uj8=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Cz8MYD/eUlSCEgbDhdzOSWXAfGGHEvBO8BTCzXhz+KX4zXB6E3jqV3J8xy+4UNCdF
	 pa/MyyG05jPZrzr52XRIHqxWZQcNVTY3NQs6ULBQvSbNUe8x7/zcMjnvBVdDDCHt8K
	 yihOsNyg0WE1iGizmdctA6WnMoTgkBQLjAPVMjlYG5Dlccc/S93vQQTj6M+ZMp2am7
	 +jwx+lIjBTJ0mbCKTiZJf/j4cEW+c7cQ3nMznG7qM5I+JCvC9VwUZI9nOmuEsJ7zsm
	 Ed7ZBIvZj0eXgjKgxYxq1kaxWfK0bddJd8WjtM7niX4+IBtOA+nE7YLd/5kBKNDopF
	 aDJDP4y9buVEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 538F8809F8;
	Mon, 17 Aug 2026 07:59:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82AE4336
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8030940707
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OK-JXLg_A-7v for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 07:59:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6D4F440706
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D4F440706
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6D4F440706
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 07:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PapXHu7XUkLzkBkYQKmhvyz4bPNydVJdDTTn45BPCjoHSWtaAL+eGs7QdptobJCk0fHiivWoDDoQGWGvnRHcT34xehrqjtWxJ2vzAaelHhm8OamAF1nxsKW9tFH3IqV5O9HCZpITT1J4QtOq7H7xBMvla0sFGy7S2Mx6wueGpnlnXHYqvIowgNLQJkqAklZTC9MX6ity9goK6XRDVgAiDdqFkbf4TFUy9b2DUJP2s58mxpiHMepHwDCLvRftWWHwJROf9KSuu2fEMS0uvqGnqzLaopCUNjAUHyObRN+pOTIxQe6H6GbNyPyJ1/78zpFn08v7NzRcS0TjJA3WuhQH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9COAeR9Uh7DRtjS9Ltc6Hprre49AyxehQkFrum3Uj8=;
 b=y/fAlTVO38jPVFD7SG1it/qVP6OeW8x9BYdXAiRQBSfz8MW07WtUnQO4p6UmBzlz7tpeq5Kb0C9ySrszlae0vohg2XF8Wvp9SCfAzUVCtW98W+T/SShnZn5XZfO33cT1FfsNeDx8RXogjk+AVRMstQT9CLe2k28S5simx4AeM/e+hdeDRuHadYbZ0I+D8uzojLX/EKoCkfpD3WB3fybJEHXmc7hn/owWHtGNJS24iC24Ty0zWhZvuSCtAdB9M9ZeqKVaNCtfo6c5pUbBmJJ8L2m6eCoNB5YOf/sqjdvWGXEDDzF3n9EF6Ys9TurysCvT6hYHhzcHhQfHKpAFLJgKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.85) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
Received: from AS4P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::10)
 by PAWPR07MB9577.eurprd07.prod.outlook.com (2603:10a6:102:360::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 17 Aug
 2026 07:59:05 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::51) by AS4P191CA0004.outlook.office365.com
 (2603:10a6:20b:5d5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 07:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.85)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.85; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.85) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Mon, 17 Aug 2026 07:59:04 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 3EB4E800008E;
 Mon, 17 Aug 2026 10:59:04 +0300 (EEST)
To: sjg@chromium.org
Cc: aaro.koskinen@nokia.com, antonio.borneo@foss.st.com, juuso.rinta@nokia.com,
 me@ziyao.cc, patrice.chotard@foss.st.com, peng.fan@nxp.com,
 stefan.roese@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH RESEND v2 1/5] watchdog: wdt-uclass: report effective
 timeout in start print
Date: Mon, 17 Aug 2026 10:58:58 +0300
Message-Id: <20260817075858.2219899-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAFLszTiE735wxfGe=nu8rFJn1a3tYOJYa6vjOUeDazuKLCKyPA@mail.gmail.com>
References: <CAFLszTiE735wxfGe=nu8rFJn1a3tYOJYa6vjOUeDazuKLCKyPA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AF:EE_|PAWPR07MB9577:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dfa31009-c5b4-44ef-e243-08defc356860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 80iVQANZUddn2tzLqzC4r/2EI/sIKyU8SKcFj3tb+14KATLXWGk1u+x2CUNkGvzz+ZExS84DE58xbowZo6ywCe441ETrx/OJWhLsFmlos9rIgmZqjtd0rYViHqjBPQBhkCE7M2z4idGp02fkMToituPV1EilrHYf1pc8vhCDdBZ/5ckrfMBUc5ECfuwq70MXApDasb4U9NQ6Pnjyh9ZYUTrdpD6FO5vvR4R7ba0DnCAKLY+P/OBJJXLXEINWffQLqM5XiYN4UDO9/8kNmE9jiM9DuIwlcK+jQlOcAe9uHQ7uhNZWciaH/hae5xlzWg1c7ZmDs0FaE5+PdH1+eqM9YDqG7b4VNxYYz7fOojmwYZIpXJ+1mb6HAU+YwR0M71Z7gJ2rO1TiqhsxgFHRse9/ynf3RhtVZL4H+2Ef9/EXCTTBhVF1oxN98jDK6v2/8HCZojChchbmPTNkPqGwLsf3S3mEFcFN2luf/1b99znctK+qjIFwjF7x19IdGdWECI01qHE0MQwJ88wIkNE8iJiLlS8yXlsLeXHErFqE4aNhZHolTlWvEGgBNIQusY4nyyG4EhZZBOnXexAhgueq5GviBQGpv43hvCZMWIMWHOPuBYeyEOBSBbbRusE1TCcEv9u4VLqWCHzGMroxOFK+eLWYX37heSpaDLgD2Z1x0RfvEFfEjS4YUBijlQCuI5+ivhK4NgJmcFatI3v0fkVOdTfsVQ==
X-Forefront-Antispam-Report: CIP:131.228.2.85; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe02smtplvp01.emea.nsn-net.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YJN2IyZH5eu1DtJXEtEjnETswSlCIzP85xJpgdywgtscmQJUjxrjhVj7QleNS2qw1CI+FisPakHROvRElMYGFY5sorEoC+jupe+n/KNUg8r/0ihdv7mNeIrEgYij075ePMqGezVfYbhXT/Vx/zVBl5cCumF5CEkT5ptVkruDGUXNaTzx9E/TLvKOwnlHmx6V4s83TimLE+JjkQ1nFnvOIeQKlGqAJih4mezCxwJoAOKglSUbJQTpFE43eP6UOgfUrn1FMSkVoPXClI8523E18sYolbTy/yyztUdbHUzKIbWfb9kHg/afpiR2wNFSPoSXP9k2KullMQYW9Rwpi5prJ+eGawRkilYqYqQus0dot1N+YGVaFtdKeCBTzPSE0SECQ33PC1fFKAyuH/ALvY9OQHj1MfKaCbrMFMdAc7mI/Y799gCT8v7gMVV4Ck9OeaWd
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:59:04.6877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa31009-c5b4-44ef-e243-08defc356860
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.85];
 Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9577
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
From: Juuso Rinta via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: juuso.rinta@nokia.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

> Normally a cleanup like that would be best in a separate patch, BTW.
Thanks, split into its own patch in v3.

Best,
Juuso
