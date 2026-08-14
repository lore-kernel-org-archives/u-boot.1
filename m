Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897B5C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 08:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B276480F51;
	Fri, 14 Aug 2026 08:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4dWr9C2NQiv3; Fri, 14 Aug 2026 08:06:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E87180F23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786694793;
	bh=8XHVPRYtozZOhk1CtaWqj3Ipq+Uj2aqsa88x+pak7W4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y3z4REhjV1hiL2jEfS5bH5Fjp2lOaT0+8HjsJnSlTeQn7EYuharrPPXToiMP6340G
	 SBewrjnzCRF7URe+ZdBLspaxRCh/F/MTsBGP1yXvgvuFMlcJXsNdqmyu4keEZb1kzG
	 00zY3mc7VffcAB2CpmRdf85YC+aTMaszHTyXQDbsqwKBPTW8LgNXzsQVB9UM5fKM2r
	 sjpA31OJP2yHzaayRlSvrgNQxV0QgxdueDUDi+CHRJUfhpFh89dsXuBvBZFt3DKA8/
	 IppshVtzSsy43ZAXtXp4bt0Z25u93r0jTrFWxr5nTN79RpLjaH2LR6p+2HAYZxmF7G
	 kC9yj7teIoncw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E87180F23;
	Fri, 14 Aug 2026 08:06:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5AAB139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAEE240704
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rg8IDxwwkTDy for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:06:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 92B93406F7
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92B93406F7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=jJ3e7U5W; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=jJ3e7U5W
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92B93406F7
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:06:30 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gUH6PHC3KJhlNhgFQULv1cxSiUUVh7tqyOKvtDrI8a2AR9cqAF6tD5gK6dZ9uhMRzsiT/J86yR8AhNr4WIXDDA/aYV+o00o6seKOuMSM6D78kAxg3GAF4v2KBrzr/RvDphVLCPsHXYqFKtGlUVteDUGPAyGkBwaxERDqLXwTlEx4BwIyYsDyNWZmvaB1m+ICyA6j4P08Nm2IKTlZMtVqtJRm8zzwV9eiDeEEDopHpB2FwMJnYXy76qb3Eg8WyiPxILPoeulpKQAE73hUbXElxm5Y6WYdmHPH37SNMw807h5OxdMmd2tyOcKu0xM7waBrPdJZcBi3N6H/q3J8x3+Wdw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XHVPRYtozZOhk1CtaWqj3Ipq+Uj2aqsa88x+pak7W4=;
 b=mjCKDj50LaoU0fwMxxSKhNI0e1O20AMI6BckTAPCWN60XX6lvQ57cHNsnnYaDpZfKBbVft4ztoX1pX/J4rWVmZhTcM4cgIzxWYB2gP+xKN8ypMAgJcb3LMcmj4QFszk2TpPliW48aF8hr/TU7x5EntFuP+VDv7gt5fStvCRhHMQdC82xz9Ley09GT/GLh5gzagd1bfbAqYylku3RITSwCLxo9vKwMhdwNHipLD0uylu2JQCD5zrwByn3QBsYgjZhbf0Iw42+N3nNHP0d/B2zCsWOyzLRgeyY+bq9WojLO2AkkJo5IRhASdY3uF3HwVUqxJZJP6rBcRGncgByEddlgA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XHVPRYtozZOhk1CtaWqj3Ipq+Uj2aqsa88x+pak7W4=;
 b=jJ3e7U5WXmjQKeJM00dXNn35K/eK54J/+GpmY+vusks4eUqKoKYbOurtDofwWukVp/FxEP3Zozb6hk3WfG6PeH4njQmUmGErvKhMWh8Hc31bhJdBuSR3003cgEr+qyt3uIg5/fH3JLTwDxzupQJhZ3Jn918EcWkhVU4ct0+s/zA=
Received: from AS9PR05CA0269.eurprd05.prod.outlook.com (2603:10a6:20b:493::15)
 by DU0PR08MB7414.eurprd08.prod.outlook.com (2603:10a6:10:352::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 08:06:18 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:20b:493:cafe::22) by AS9PR05CA0269.outlook.office365.com
 (2603:10a6:20b:493::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 08:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 08:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsJPe3kbX6eX1UmwhI4+yBeHlmQ6LmLgPDUKDvH+OjFgs1xFPDygoKn0R7ELLaFRO8S/0d4hC3MQM16SixDVuipMNB+5PwT27zh26lVmByi7reTdb4IQRwEXx7j7DP8iRnDpIycIO4l1n2AHUGxi6qm39bDCa+/GKqDHagJTin61jTPveKow9R/GbNWM5Sa5qNv4pgbDHMI7qb51DJtOGxpYwKop1+acCiyfLA7k63G+5/39iFeqbCL3Ff6RNtnBhMxJj1bVquVhDuZbS+ezS0DeLfnxSWOmVDKA0bltq1gsUSziSww4/cgEeghhy+OGhYE9ILyBRtKpu2/5voeGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XHVPRYtozZOhk1CtaWqj3Ipq+Uj2aqsa88x+pak7W4=;
 b=gyzKAkKYLnOMp4+FOqfRpkd61BzQBj1H/0mPllnA3ioXCHgvilBIuUYs/XrEV8tySoFcM3Qc4hqW1lIqF3a+DcINVnWi6p3sKZ8fZSIqg4J8kl7ZtEjhhp42YKTFyCNwreUY643zZXIE0mURSQP6bbAGhMJ9tuxrm5DgOTcPYkCLYMFlhalEBoR2gmHmRwoWealA5AC2Di+FBCDcAB5H+SuuXUozHsIbZZ3Py1uKgwZZSVEbEFAqQDTsDanqf9EpcPnq1jXvMY8dGloC0DAlE2wqlQz7hxdBw75OTP3gYzihayGtcxh/PSL0/+ba0yBoVltVG3zXU6tjaBA9a0vsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XHVPRYtozZOhk1CtaWqj3Ipq+Uj2aqsa88x+pak7W4=;
 b=jJ3e7U5WXmjQKeJM00dXNn35K/eK54J/+GpmY+vusks4eUqKoKYbOurtDofwWukVp/FxEP3Zozb6hk3WfG6PeH4njQmUmGErvKhMWh8Hc31bhJdBuSR3003cgEr+qyt3uIg5/fH3JLTwDxzupQJhZ3Jn918EcWkhVU4ct0+s/zA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB5944.eurprd08.prod.outlook.com
 (2603:10a6:20b:297::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Fri, 14 Aug
 2026 08:05:45 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 08:05:45 +0000
Message-ID: <1716cb7c-39cd-4ff7-9772-1138b6152743@arm.com>
Date: Fri, 14 Aug 2026 10:05:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: net6: validate IPv6 payload and UDP length on receive
To: "estebancalba@gmail.com" <estebancalba@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 nd <nd@arm.com>
References: <20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB5944:EE_|AMS1EPF00000092:EE_|DU0PR08MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 382f217e-ed07-40ef-6412-08def9daeb55
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|10067099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: 5hl49fxfIBaA00hvp6Xpir/vWUuhm32QfnwM4njuXR3F6I7xpceeVhO7tbe4KDzFR17E5psZFXmixlkd/Yf7nszexcdWF+xHdyTzLpAhuHGykuSpMUcN69a/zQsTLWDFBtv7RFEe8zP5ycZK25A266xKTdqaPiIgYReybB7CQ4Uuv1cMWWP0e4lE6V/G2HHE9daPfhhV626RYcsDMdeFVJPWpvdUFRuRW2a155+BLUjpggQCXD8v/wSmVCHU8k8RY2vtafa/rXzU3ZzWI/KBZ8fpw7jGhYdbgbw9MbM/mqLIhvKsvFhUYFTe+MQTPId87N/LCke1Lmasl0Iy3tHpbVTWNYRl47OdFPr0gNEgNBf9v729xlK77kn5uc6h+OjGOMxUbl4ZwOXIucMzeKrKIJZS7yOsrUL0XLSLpvAUlQxy7TnlQmZ8Sjzd1fup5L1zgoBZmQ7xckAnVu6nfawwEsnI+FnuZKCJgOvjgjKeLHNw83hN4+/gWEeOoOxh8MVkpm6/0nCvLIqErZQDFF32++XAs8vh6F8KpHq1a1Ku8fZuRkHvzhLahwu5lCLovTNh6Z0w+sT79qF/BzuwlMKpnDgLjdClATV270kBJ1WoBUs0AGyQGXnqZsxbJb3QANvOTnq0JnVlHl16oWdSZr4+K5+ou3Bp/c4oe2vZZxI5vHo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: H9XFXzBRTiZWfQ83UPqbIYpqaAy+nEIx/ytp1YR98s6RhcSREXWldOcouXbwjt7IKlxMsUGTvU/Y9HErMudjjvgih45FjJtWKB4vzx5NgNyKOLy2Or/qDcg7xD8bULVCdg+cRYGYMRuA6fBkBhYlqiQNOvVniYloW3xnqxhAeEZTEkyr0JYBS4Li31KgvDpdGEHGchc5NK5u/0zRKvqQgZcV11gAGVkpEJ17/X2YTIcepG1LUtsNK3JYWbMcjlYLWZ7r1MxwcccHqhHgZ33oOm/ilz6ld/okKxDR0fiBO0Botg7rz1qagdTI/ZT/TgkRx9jCxFlr5jxFd7MFkg3+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5944
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1cd3fc22-8745-4c66-a6bf-08def9dad7a4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|23010399003|82310400026|36860700016|1800799024|376014|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jqzmUX5pF1uRmVC3KwhAGV9MAbW4x2BXLOlYRIYagLg6mw4erxUrdYXusXzKTrmjLz4by+bfBco//wSRoOxpgV5jNhhBOVRXUQQiFYmuSovQhWU7+aj4rxWmKjCb8280GiJxbAPGgKICJtkriTtYVqQVKYmLMfNHheAjtXaVZs+Rf5+veDKVJVkS/AmFDasVCx616RU0cRLqc4PZghPy2A4DfH/zETiO4HnBm4OJAct4eaEMmzAtFGziQu9ekZOAxaYila4gz4ZIEtKLZuBo4dX2SjRMB2yb8ZtzAFYOm22L2jKHsELqQlnluSC3x3kFzFA91KEQAsnS1b66bRABzqBuHg+HhptbpnrFKWrUGP0EZoZ4AlJuZlQ2xF5HlmtkKkDDoMOM3nGr1cEYxQ7AKu2d1h82C/uu+u++QPGfjtiUAT78llaA4znNkTxJECsiPWPUjs3MP8AyN/wGPYz25Bx6QOnnf2mC2SmkojefemSkUIr7lZwk1BNEsIuGMQ0cMnKW2j2X5/Nfp/lwto2JpGNAHd4U6+8B1u/KcX4CmBo9iTQ2tiuDJlp41XLvk60o6aQnaXPUdwLyA4TMAkSoi3xK4+8AufpH3+yqSXIejKutlaPoN5CkipM71siFyYGbaKB+hJYZdnnJZrgEoQtUQA3HJDasq4bwXu4qvUT2s3GnFckVljJYu0Sb9VZJZb6wnT9rQBgXjGY1N5WeP2eBAQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: imFLuwvKr/740DatFNNcJEFae1I1B38DWYzGxPX3OhJZF+jkW63+/KzkF+6Zu2uOB8GvLFPsZwNbN+uB2Z+HjL0H/2C4e7J8vgNWDWhQf8XwYOzfNLFmuk+d74Qu9rH62+dqgTUWhvOv9K7Det/H6wwXL+j9B+bbTAPXqWleBRPN8dqT39f/+Sg8oipGSTj8pHfxzHbcyFrJ6Q7AQ7hs8OgvWhre+bYEMk9N9ICI96FfssmIIrXoPcULEAy7Sed7JxkUz9ji/4Wy//ekZewmEYdgMcaWD9meshg5pgQNZssCcbIiunp+UlckV60Xu6q6U+OTGic0z2ZrkUnFGAC05xgnwuH+BtX1tY9lOMDgze5Dzn/vK9r9oNLUFNrUEqIbwXvPqyBKAwfwKK9Sht6ELfTgs2+tazcF4MJHVHBRoKrxEAkveoBoRImS3xiu8oLx
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 08:06:17.8672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382f217e-ed07-40ef-6412-08def9daeb55
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7414
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Esteban,

On 08/08/2026 04:09, Esteban Alba via B4 Relay wrote:
> From: Esteban Alba <estebancalba@gmail.com>
> 
> net_ip6_handler() checks the received length only against IP6_HDR_SIZE
> and then uses two length fields from the packet without checking them.
> The checksum is computed over payload_len, but the length passed to the
> UDP handler comes from udp_len. A sender can keep payload_len correct so
> the checksum still validates and set udp_len larger than the frame. A
> handler that trusts that length then reads or writes past the receive
> buffer. The DHCPv6 client copies the declared number of bytes and can be
> made to write past the packet buffer from a single link-local ADVERTISE.
> 
> The IPv4 path already reconciles these lengths in
> net_process_received_packet(). Do the same here: reject a payload_len
> that exceeds the received length and trim len to it, then reject a
> udp_len smaller than the UDP header or larger than the payload before
> calling the handler.
> 
> Fixes: 1feb697830ce ("net: ipv6: Add implementation of main IPv6 functions")
> Signed-off-by: Esteban Alba <estebancalba@gmail.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  net/net6.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/net6.c b/net/net6.c
> index 4cff98df15..af2f484fad 100644
> --- a/net/net6.c
> +++ b/net/net6.c
> @@ -392,6 +392,11 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
>  	if (ip6->version != 6)
>  		return -EINVAL;
>  
> +	/* Trim to the length declared in the header, as the IPv4 path does */
> +	if (len < IP6_HDR_SIZE + ntohs(ip6->payload_len))
> +		return -EINVAL;
> +	len = IP6_HDR_SIZE + ntohs(ip6->payload_len);
> +
>  	switch (ip6->nexthdr) {
>  	case PROT_ICMPV6:
>  		icmp = (struct icmp6hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
> @@ -433,6 +438,10 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
>  		if (csum != udp->udp_xsum)
>  			return -EINVAL;
>  
> +		if (ntohs(udp->udp_len) < UDP_HDR_SIZE ||
> +		    ntohs(udp->udp_len) > len - IP6_HDR_SIZE)
> +			return -EINVAL;
> +
>  		/* IP header OK. Pass the packet to the current handler. */
>  		net_get_udp_handler()((uchar *)ip6 + IP6_HDR_SIZE +
>  					UDP_HDR_SIZE,
> 

I still see a couple of issues in this code. In the UDP path, udp->udp_xsum
is accessed before checking that payload_len >= UDP_HDR_SIZE, so a short IPv6
payload can still cause an out-of-bounds access. The ICMPv6 path has the
same issue when accessing struct icmp6hdr.

The transport header size therefore needs to be validated before either
header is dereferenced. The UDP length checks should also be done before
accessing the UDP checksum field.

Something along the following lines:

--- a/net/net6.c
+++ b/net/net6.c
@@ -370,11 +370,19 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
 	if (ip6->version != 6)
 		return -EINVAL;
 
+	hlen = ntohs(ip6->payload_len);
+
+	/* Trim to the length declared in the header, as the IPv4 path does */
+	if (len < IP6_HDR_SIZE + hlen)
+		return -EINVAL;
+	len = IP6_HDR_SIZE + hlen;
+
 	switch (ip6->nexthdr) {
 	case PROT_ICMPV6:
+		if (hlen < sizeof(struct icmp6hdr))
+			return -EINVAL;
+
 		icmp = (struct icmp6hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
 		csum = icmp->icmp6_cksum;
-		hlen = ntohs(ip6->payload_len);
 		icmp->icmp6_cksum = 0;
 		/* checksum */
 		csum_p = csum_partial((u8 *)icmp, hlen, 0);
@@ -398,9 +406,15 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
 		}
 		break;
 	case IPPROTO_UDP:
+		if (hlen < UDP_HDR_SIZE)
+			return -EINVAL;
+
 		udp = (struct udp_hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
+		if (ntohs(udp->udp_len) < UDP_HDR_SIZE ||
+		    ntohs(udp->udp_len) > hlen)
+			return -EINVAL;
+
 		csum = udp->udp_xsum;
-		hlen = ntohs(ip6->payload_len);
 		udp->udp_xsum = 0;
 		/* checksum */
 		csum_p = csum_partial((u8 *)udp, hlen, 0);


Thanks,
-- 
Jerome

> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20260807-net6-len-validation-cd71efd96a7f
> 
> Best regards,
> --  
> Esteban Alba <estebancalba@gmail.com>
> 
> 

