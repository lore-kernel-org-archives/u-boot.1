Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17467606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jRvWKAzS;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g2n1rbm1;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g2n1rbm1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6657607EB;
	Tue, 24 Nov 2026 08:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKtk23JVHNTj; Tue, 24 Nov 2026 08:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A9AEC607CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795509502;
	b=SqiYJh8efuON9PxCn8XjPQ3YzKrNNBnFYq52QmkPEja64HMnXTx/7Z/gVbph+0UR2Jb5
	 pNHS/1G2NxUETPY1HrNhnLv8ZIAOYbzA/+bCJ48OlutFgCjG37KeRdF2Ubwwi3EzDpBvE
	 Oxf+/i0tTUJEdeI8fcsyeA32c9+Mzh1pPbD8U1O5mnKLCIK0h5usSB+K6hLFDjfSDGH3k
	 2v77N+Rw8mE/D9hjadXq38pPpSOobEbt6eoV+W9Qq3Jpg9J16ahun1xvVX6LojDJZMZjQ
	 ysHRU5QEI/D7mdEcUXiylviS+QN8plyGKV7Wf5Wfe/jm4RoDQTn+CNi92SNYtHHzpkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795509502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8NqRpx+HpJoQNNeEkR2SHVjvi4vu626qkh7pCu5VDvo=;
	b=A+rvO/IQswqcVj0ZVWBl0X7+qIi5iKyREDr0IBMIU5FwlT0pHJSyZaArYa4su8ezR1YV
	 aefraHFgu5SwPVUyv6e7egdnfonPXLBDiXRG0YdVh6Bic5OUjNxymF9fp5sSKnYUlrwT/
	 InljMMYlZTzg64YXjTvbfr7APLztnY7J7lTSbAE1NY+ddlOB2WUTW9j+9wGsZlsTKZf9K
	 K2DMsoeHrMDA6sJrROdhSAVW1NUjhzP6htKAsFmyaEYyU5spY37zZ+kNpmShZx2VQqGrw
	 8xQQhz07u6xZv7+7V29imLhsfxEEk8kfrw+DGd0wrQx5fNiiZ3U6X04HpKkG6kRnsqA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g2n1rbm1;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=g2n1rbm1;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795509502;
	bh=8NqRpx+HpJoQNNeEkR2SHVjvi4vu626qkh7pCu5VDvo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jRvWKAzSl1dD//Lntk7vyCbrGmhf18hnAFYDgZ5+IS9fJd/vrg+ldKDcfAq8UpYdU
	 zYU+xWxE4h6OJMtxRzrDiBhOAVgEFVb8fPugdMaGBkWIbctiyLP5KLjGNywAYbCyik
	 OI/DW8mVHrx+1vTuEmSe1uqD8c0cYcM7FfM32clkMtRRa/+05r2KtMNoE1GhjMhYJ6
	 Ljx9uAUGAgDnu6Ea5jaOPGW2MYU1JGJOKleCvEwwOFQoIwr+WVEnnjvnnj182Y1tCy
	 qSfPp7enJrjsOvP94dGwSSUN2ZOqecWV2/hd/5zoHVGDiNbCKJZTHTdVfAvRTat5im
	 5nZBT54CoM4rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9AEC607CF;
	Tue, 24 Nov 2026 08:38:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7001C3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 61EA2607CF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T8bmwXUDbDz7 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1D04607C3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=g2n1rbm1; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=g2n1rbm1
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1D04607C3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NqRpx+HpJoQNNeEkR2SHVjvi4vu626qkh7pCu5VDvo=;
 b=g2n1rbm1+OVZmXJe78CXWdrqLcLm//TQkgSowKjMmoDvW2if5hLt0V8i4AVMtL8f0Jmvh8ZvjY4znWnaVjLze5yi+qdq/WcVnKulMe0WBF5orz1ohV3l2G0K+d3r+FbDp6xn7N8qylF7WRbUbNUF6d2RxWwv8CU7iG5BjZEWxdM=
Received: from MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::27) by
 DU2PR08MB9991.eurprd08.prod.outlook.com (2603:10a6:10:493::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 08:38:08 +0000
Received: from CPH1EPF00000528.eurprd05.prod.outlook.com
 (2603:10a6:190:8:cafe::82) by MM0P280CA0063.outlook.office365.com
 (2603:10a6:190:8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 08:38:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000528.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 08:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NqRpx+HpJoQNNeEkR2SHVjvi4vu626qkh7pCu5VDvo=;
 b=g2n1rbm1+OVZmXJe78CXWdrqLcLm//TQkgSowKjMmoDvW2if5hLt0V8i4AVMtL8f0Jmvh8ZvjY4znWnaVjLze5yi+qdq/WcVnKulMe0WBF5orz1ohV3l2G0K+d3r+FbDp6xn7N8qylF7WRbUbNUF6d2RxWwv8CU7iG5BjZEWxdM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB12001.eurprd08.prod.outlook.com
 (2603:10a6:150:369::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 08:37:32 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:37:32 +0000
Message-ID: <e365520d-eec2-48a2-b750-f01f1571e15a@arm.com>
Date: Tue, 24 Nov 2026 09:37:31 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 00/19] net: lwip: enable IPv6 networking and boot clients
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Igor Velkov <iav@iav.lv>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Murtaza Munaim <murtaza@saramena.us>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Drew Kluemke <ankluemk@microsoft.com>, nd@arm.com
References: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
Content-Language: en-US
In-Reply-To: <20261111-submit-lwip-ipv6-v1-v1-0-eb0ee8f8da1a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0028.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB12001:EE_|CPH1EPF00000528:EE_|DU2PR08MB9991:EE_
X-MS-Office365-Filtering-Correlation-Id: 82485fb7-76d9-4824-77e3-08df4a06438b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|261022113327099003|11063799006|56012099006|261021130227099003|261021121427099003|261021133027099003|261021135927099003|261021123027099003|261022105027099003|261026130827099003|261026140227099003|261026121527099003|261022115727099003|261022075727099003|261009223027099003|261028144727099003|261102123227099003|261026135527099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: PBxscYDVZaSG1OD3PPI3GigBtznfNg36ovj36Yr4DvFC6hpMqxoaRuyHpcxcNUvyhe6dgU9WvHAtE55t3l6npDrXrkm2EbWdOsB0dagDSiHZKC0ehZm/apgao1Hf1y6wzXOXlGWnD/1OC3UXqioz9/gcBBPrL+2Z5fyBxjvEf5MWV964mYXzyhJwWISH8/bG2OST3Okfd6vZf27Aq51G/BwgMssVPA1qoo/Zfajgjnj0j3q1MkJ9WbBySkocZ3pDsqtTJbuhrl1t9rZzmOEq4Mq4FBZlPFGMSQA67FJIMpXGn8T5T3WdM+nt3y4N1IEppwtqatSZSrzqI70cg/DteHA3AWH43NE3GRhdUBsoHCxNUzeg2JeBlLIAyDOyosb4b3oxxK3v2o/DjAiYGCiZKGpOD4e4BDxQ/I98eOkdGMPSP4mfFJJfVaFtoepT7avSsIYECXnrK0mQk2GHjw76DsowhUvbdZrUm2/3L5o0JKtyunQJMr/XqXJP0g0pJuzSMNCpt+Ba24qYOyaiASj/Bp/UFBY/awesbDK7CKyC5sWTnH4be2PZflSN9NO80e7JA/rqk43A8vb8ZFku46m4EAAelZzw4R4v44mb4MYCjJuvM7Brjn3LAobOJKinjtZf
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(261022113327099003)(11063799006)(56012099006)(261021130227099003)(261021121427099003)(261021133027099003)(261021135927099003)(261021123027099003)(261022105027099003)(261026130827099003)(261026140227099003)(261026121527099003)(261022115727099003)(261022075727099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026135527099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: hKRkM3AhVPSp7SHf0bU8FgFETlCygxVcvIlwndEtmdZCjCoBh2g1/wpiMSj/jtcelq2BsPmgMdT4sGiW89ChQ4Fr5euUbGBkY63/umS7Qzav8xsA5A90hnK6EmxMXPqRmilkvyadzx3dzbM/C8wQtbqA5WZg420urf3jlMfCXifbEVjLM2/Ir5fuEFdFu66x+QDvHa+SfWVdYOxkF2YQrY/WUz69NghR5oKNVH1RXRYkI7yH2GFlewKCUOhX84NhUVPy4u3OpcX4wGRwR4TzjODa+KFVpjJd7GTRYfCpeWTa0CwQosLNSWgHO9q9kSqMSiRAVfIGAf2LfP0KN5n5jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB12001
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000528.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3bc1acfa-1084-490c-8998-08df4a062ee5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|35042699022|36860700016|14060799003|23010399003|1800799024|18002099003|22082099003|6133799003|3023799007|56012099006|11063799006|261021133027099003|261102123227099003|261028144727099003|261009223027099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261021135927099003|261021130227099003|261026135527099003|261022115727099003|261026130827099003|261022113327099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: Akrnq77Dgp54c1CNgZJmjOgz9sJWV+wPmsgoMdLcXWc3p+Lli8AiioLtFWqMVd2OSUSvN5BIZOM1BJILRFBKJCtAMSA5XAR5JNu2fXoD4xcGNmnf52HOaln6wx9rLJUN+GAfwMZY48ffWlk600uh6YpvEemV4W/KUrpFYxncbj6SAu1Z6zUiZM6p5q4mtKSEus6kQOqvBGVRMOAO05XeLYDNR2B1XdlddYtVWIgKUTgvYxMk2sW6FsMz/33t3cZn42N7VPeBbcsumeJ2eGwWojtkC6kO8sDdMwURaB/h90sXWlxx5Gi3XTL6NBxiMIhuMq8yGhugTDdWKxjuQFHTmHIs83wJQJ7ZFgWH9RWB1oq44NcN63u03gaAdTGP1kzrGEPTgr03ROoDaT2DbFJ3JilEVkicT2XZzruXmYpdwxTaOclWHGebolNGKDy3XsGMUMZ5fHnfVA6MLmUhyQFjR2WEJPrTa9/Fmn1nA5xbRhFM+ZMpKXoYWCitVG4SGjtsmpdC9mhGoxfJ+ATLxVmvXfSWeS/daBHHkD+EL2HpwDKYhii5tSPKDJu3Ma2LSfa+AeDBuHTMIiz7SAfzi+Aoe10EaHcppZ/0IcVkjg7H9CuFaK47Qv9z7wBBGjuTwBGbwU/cAdY8YSzIanbbpUifmwdzV/4LZ89y8P+k/DGwVZA=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(35042699022)(36860700016)(14060799003)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(11063799006)(261021133027099003)(261102123227099003)(261028144727099003)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021135927099003)(261021130227099003)(261026135527099003)(261022115727099003)(261026130827099003)(261022113327099003)(261026121527099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bcJwhbT4zAAyVdeZuhteeN65oAZ9QB6ORvqu7IV5NBuVHdx6SqlHxyIDatyLZhII7+bkcoPX+MG2n9VYHZ5zRuQeaYbMS+U0k0bjI5tBYudDiv9CNBhggtUXfeZQkETvLIvP5buwAyuUdxcWsAmWHOy6mA4Ucp0jDPNyGpFWIsM6l5ivO0c5EuH1MqFUVxbA8ynJNXoj84eKhmqWj2JD+ErvjkmFaqlG32M7DYvW1BeuBYcgqLjM9jJ1bXi9Yvd276gA9nINZn7ez3CHQ3fHDp2KsVma0FVunuvR2T6CbCeOfCYFETn6rKxOLE12S3BUlHp/rdPtwJ1iGxu6ORwB0jet4Or8NhRSfzoEqxdyAbngZDuTRpuWMmZzHvKteA53IjkdTLF95YvBzP0VV++HLIRUbqnf9ym++xdSfSpogN+MHVr19CcajAjAzfdeuk42
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:38:07.1742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82485fb7-76d9-4824-77e3-08df4a06438b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000528.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9991
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Enable IPv6 alongside IPv4 in the lwIP network stack. Configure link-local
> or static addresses on the selected Ethernet interface, perform duplicate
> address detection, and learn prefixes and routes through router discovery
> and SLAAC. Static addresses support explicit prefix lengths. DHCPv6
> supplies addresses, DNS and TFTP or HTTP(S) boot URLs, and renews or
> rebinds leases while networking is active.
>
> Extend ping, TFTP clients and server, HTTP/HTTPS, NFS, SNTP and netconsole
> to IPv6. Resolve hostnames in the active network context, including AAAA
> lookups over IPv6 and DNS servers advertised by routers. Preserve the
> original hostname for HTTP requests and TLS certificate verification.
>
> Clients share the network runtime with IPv4 and persistent users. Transfers
> wait for a usable source address and route; lwIP resolves neighbors as
> packets are sent. Teardown releases learned addresses, routes and DNS
> state. Finite learned lifetimes include gaps in network polling. DHCPv6
> retains lease age across commands and rejects expired or withdrawn
> addresses. IPv6 NFS discovers UDP services through RPCBIND.
>
> Preparatory changes make address users dual-stack-safe, keep sandbox raw
> traffic on the selected interface, map CA certificate buffers, preserve
> the scheme and authority of wget URLs, and handle TFTP headers split
> across receive buffers after IPv6 reassembly. The series also propagates
> IPv6 port-unreachable errors to active TFTP transfers and adds sandbox
> protocol tests.
>
> Based on U-Boot main at 8ea02c99391d.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> ---
> James Hilliard (19):
>       net: lwip: handle TFTP headers spanning receive buffers
>       net: sandbox: bind raw packets to the selected interface
>       cmd: wget: map CA certificate buffers before copying
>       net: lwip: recognize wget URL schemes only at the beginning
>       net: lwip: prepare address users for dual-stack builds
>       net: lwip: configure IPv6 on the shared network interface
>       net: lwip: add the ping6 command
>       net: lwip: support IPv6 TFTP clients
>       net: lwip: resolve hostnames on IPv6 networks
>       net: lwip: support IPv6 TFTP listeners and server names
>       net: lwip: report IPv6 TFTP port-unreachable errors
>       net: lwip: support IPv6 NFS and SNTP servers
>       net: lwip: support IPv6 HTTP and HTTPS transfers
>       net: lwip: support IPv6 netconsole peers
>       net: lwip: acquire and maintain DHCPv6 boot configuration
>       net: lwip: load DHCPv6 HTTP and HTTPS boot URLs
>       test: net: exercise lwIP IPv6 addressing and DNS
>       test: net: exercise lwIP IPv6 application transfers
>       test: net: exercise lwIP DHCPv6 lease and boot lifecycles
>
>  arch/sandbox/cpu/eth-raw-os.c                     |   12 +-
>  cmd/Kconfig                                       |   25 +-
>  cmd/lwip/Makefile                                 |    4 +-
>  cmd/lwip/dns.c                                    |    4 +-
>  cmd/lwip/nfs.c                                    |    5 +-
>  cmd/lwip/ping.c                                   |  127 +-
>  cmd/lwip/sntp.c                                   |   38 +-
>  cmd/lwip/tftp.c                                   |    8 +-
>  cmd/lwip/tftpput.c                                |    8 +-
>  cmd/lwip/tftpsrv.c                                |    4 +-
>  cmd/lwip/wget.c                                   |   17 +-
>  drivers/net/netconsole-lwip.c                     |   86 +-
>  drivers/net/netconsole.c                          |   18 +-
>  drivers/net/netconsole.h                          |    8 +
>  include/net-lwip.h                                |   28 +-
>  lib/lwip/lwip/src/apps/http/http_client.c         |   27 +-
>  lib/lwip/lwip/src/apps/tftp/tftp.c                |   12 +-
>  lib/lwip/lwip/src/core/dns.c                      |   28 +-
>  lib/lwip/lwip/src/core/ipv6/icmp6.c               |    9 +
>  lib/lwip/lwip/src/core/ipv6/ip6.c                 |   14 +-
>  lib/lwip/lwip/src/core/ipv6/nd6.c                 |  339 ++-
>  lib/lwip/lwip/src/include/lwip/apps/http_client.h |    3 +
>  lib/lwip/lwip/src/include/lwip/ip6_addr.h         |    2 +-
>  lib/lwip/lwip/src/include/lwip/nd6.h              |    4 +
>  lib/lwip/u-boot/lwip-hooks.h                      |   41 +
>  lib/lwip/u-boot/lwipopts.h                        |   12 +-
>  net/Kconfig                                       |    4 +-
>  net/lwip/Makefile                                 |    1 +
>  net/lwip/dhcp6.c                                  |  999 +++++++
>  net/lwip/dns.c                                    |  245 +-
>  net/lwip/icmp_unreach.c                           |   33 +
>  net/lwip/net-lwip.c                               |  487 +++-
>  net/lwip/nfs.c                                    |   48 +-
>  net/lwip/tftp.c                                   |  167 +-
>  net/lwip/wget.c                                   |   84 +-
>  net/nfs-common.c                                  |   73 +-
>  net/nfs-common.h                                  |    2 +
>  test/dm/Makefile                                  |    3 +
>  test/dm/eth.c                                     |    4 +-
>  test/dm/lwip.c                                    |   49 +
>  test/dm/lwip_dhcp_policy.c                        |    2 +-
>  test/dm/lwip_ipv6.c                               | 3098 +++++++++++++++++++++
>  42 files changed, 5690 insertions(+), 492 deletions(-)
> ---
> base-commit: 8ea02c99391d2d922810065206721ead2863f075
> change-id: 20261109-submit-lwip-ipv6-v1-22dd73c3b448
>
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>

Applied to u-boot-net branch for-next [1] with local modifications, thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-next

[1/19] net: lwip: handle TFTP headers spanning receive buffers
      commit: 240e055c56cf43951322fd9f79917a8973ff5f4c

[2/19] net: sandbox: bind raw packets to the selected interface
      commit: 09de86137571800a9c3d3ea80c69354430e69b2d

[3/19] cmd: wget: map CA certificate buffers before copying
      commit: aab55c414ca817eb99ddc2a591dc76cd90bfbe84

[4/19] net: lwip: recognize wget URL schemes only at the beginning
      commit: 22f984624a9fa12fe77493032af40012d5a5946d

[5/19] net: lwip: prepare address users for dual-stack builds
      commit: f786c3ff090fdd73739c7dbab1c6e907d9fe66a0

[6/19] net: lwip: configure IPv6 on the shared network interface
      commit: 490bff404029f0f564339a0180c8a8b4d7cfec3f
      Note: Applied with local modifications.
      [jf: resolve trivial merge conflict]

[7/19] net: lwip: add the ping6 command
      commit: f012fcc19d36d0bfed92fb9e956eb1e7c05b1a05

[8/19] net: lwip: support IPv6 TFTP clients
      commit: 1b3ca749faabbc39584ff1e60f230ac82372f69e

[9/19] net: lwip: resolve hostnames on IPv6 networks
      commit: e86ac5b465b41af5c90850a9297fee6fa52e64b6

[10/19] net: lwip: support IPv6 TFTP listeners and server names
      commit: f9f7ede5bf75c1f1637c0fe4f45fec7e9e8fceb1

[11/19] net: lwip: report IPv6 TFTP port-unreachable errors
      commit: 2d75b12aa39f1b58e0c899bc8b22792897e8304c

[12/19] net: lwip: support IPv6 NFS and SNTP servers
      commit: 770ef78185500d4a22eee9f34ecccbe5bb7237a0

[13/19] net: lwip: support IPv6 HTTP and HTTPS transfers
      commit: c681d28e0c2d450b8e0d536fdcfd9a1d84ff314b
      Note: Applied with local modifications.
      [jf: resolve trivial merge conflict]

[14/19] net: lwip: support IPv6 netconsole peers
      commit: d44ad525d6092470af0dfb90f59032639fc0703d

[15/19] net: lwip: acquire and maintain DHCPv6 boot configuration
      commit: c55528ddd21afe66e272028fd62b9e7774dc90aa

[16/19] net: lwip: load DHCPv6 HTTP and HTTPS boot URLs
      commit: 3ad96df729add78bba959d1bbf5d2545e008b982

[17/19] test: net: exercise lwIP IPv6 addressing and DNS
      commit: 6310b6b1078da426f0790c14afd018be9410fa13

[18/19] test: net: exercise lwIP IPv6 application transfers
      commit: 7739b92840eca5117a1dc398fb1fbbf61251272a
      Note: Applied with local modifications.
      [jf: reuse one IPv6 context in numeric TFTP test to avoid repeated DAD]

[19/19] test: net: exercise lwIP DHCPv6 lease and boot lifecycles
      commit: d778970a189b977c14f93961d7009f404d895b5b

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
