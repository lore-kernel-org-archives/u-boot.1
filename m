Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B7606A326
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pmlo45fc;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Sn6TsgJs;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Sn6TsgJs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E01C4081B;
	Wed, 25 Nov 2026 17:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XZh9Tb9De2EM; Wed, 25 Nov 2026 17:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97700405A6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795627000;
	b=h/bJyQKcBJyQQpI5YbJ9MyGDD3vQzJSNRj9i6xU7OFdlctYzxOPlGTpw3XboHdZdYIaR
	 Ov32gi9wBlkFdU5yDbUgY1qvZCs29+iURe1OQEPP29dXYy6I/AFlfedPQCGTAvDunB57a
	 4r7J5Sdq3hncC5tgyM7xQdC1D1RCRisUpNmrqbptU96KWPAfTDE5Fub4ny5tAGdKPn9G/
	 m4XKfL8TS+Q9xtHjKBSGgjL4uO7OqYEDsUBe7nAfwSlNLXrdED7SHUW/4jrk6USTAJj9/
	 j4EDqMALFTXDXrtYkWLioyuQiQLet1vbC1XoOxFgJDEwt1jEhtnj/ncxwJpMukGKCNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795627000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=GuFlp9CplyZnG6vo2TnAXc1ZZFls+0AoCGzSjU35j/k=;
	b=h1eCpiMKB44Aa0XhFPZcexJ8SZcZBuFwAvDA7wpEHmAYYy79HqH8MrsYpTzr2boTSZbj
	 7of3X5FALYV/RmZw3GFUBwORADIU0GyFQanL0TVITQn/uHUnEgDWrdeu5hi36xhBNSL1e
	 pm2Atw3GImFLRNHrQ42dpOuzAOyV0mcHAVWres3kl4WUnZ2w7rDeHFfsnXeTq/iPOyr/R
	 WwyECrdBeqfxKJj1iFAwEkWbmgA8Cm/7FisoCa+oC5NMWvz25inknO7lrdkkHm6F4KmkN
	 ID2vqaFXrU0qySr9fGCBlw1BBJqtnrllFU/LGWKb7WLTTE5uYyZcmb7CbItonjO2BOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795627000;
	bh=GuFlp9CplyZnG6vo2TnAXc1ZZFls+0AoCGzSjU35j/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pmlo45fcCXAn5BJ7L3QrhvsCINeZoYfXRZm1NJ74UruDovUYqfBvmLYkseaIXdSx9
	 jE3JFOaUQGbIZTMHxNQXPEpyTGlAUB06ygzwM6hRVqoPniPT4KNzMHBKo31EXPk7Sb
	 AY2nxrAy+CPPp49Hsv0QEloJSdzZHX4oUcDTZ2R0uFhK9jRQFS99rddXbSR5C1Wb5v
	 hli7jXxZuQo8gZ+Bg65JJQQAOtOTLCB78ZFtJNYrZNsYKuXYqao1cz0towzpOqWtrT
	 cQVsr4UhRZScnRXEkaBEffC8NPodpfXp6F2nIDuCtBkszeEIBJS8yFKdVRx75fZC7d
	 /6qvujk7yLZRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97700405A6;
	Wed, 25 Nov 2026 17:16:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFD341C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1D4740050
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_oavH7Sd1NN for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:16:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C338C400CB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Sn6TsgJs; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Sn6TsgJs
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C338C400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuFlp9CplyZnG6vo2TnAXc1ZZFls+0AoCGzSjU35j/k=;
 b=Sn6TsgJsw6aHrCXL9NYpAQsmD4lWtboHg1bzVebonKW/yj56CDI4Xy7vb3g9KSpqfUtuwPVQRam/HwcppCYaR7owQ7x9T1AD6AaWiLSyrPQINUdhRa/LUaGcwFzDU3yvpgOKdCf0dQo9ooWudVpz+eEkxsYk5pLA7PZvLOHqzfM=
Received: from AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::20)
 by AS8PR08MB6101.eurprd08.prod.outlook.com (2603:10a6:20b:29a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:16:32 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:20b:150:cafe::91) by AM0PR10CA0040.outlook.office365.com
 (2603:10a6:20b:150::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:16:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 17:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuFlp9CplyZnG6vo2TnAXc1ZZFls+0AoCGzSjU35j/k=;
 b=Sn6TsgJsw6aHrCXL9NYpAQsmD4lWtboHg1bzVebonKW/yj56CDI4Xy7vb3g9KSpqfUtuwPVQRam/HwcppCYaR7owQ7x9T1AD6AaWiLSyrPQINUdhRa/LUaGcwFzDU3yvpgOKdCf0dQo9ooWudVpz+eEkxsYk5pLA7PZvLOHqzfM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB9667.eurprd08.prod.outlook.com
 (2603:10a6:20b:605::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:15:58 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:15:57 +0000
Message-ID: <cb77bbd3-1c6d-4948-88f6-c754ee0243dc@arm.com>
Date: Wed, 25 Nov 2026 18:15:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: wget: honor httpdstp for legacy arguments with lwIP
To: James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, nd <nd@arm.com>
References: <20261123-submit-lwip-wget-httpdstp-v1-v1-1-e1759174ab9a@gmail.com>
 <55dd0a77-5315-416f-bbe8-e952a03d874f@mailbox.org>
 <CADvTj4p9LJ+kwDSZ2fyw-P3fLEewbxN587dvF2OrpKQdY=k3Yg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CADvTj4p9LJ+kwDSZ2fyw-P3fLEewbxN587dvF2OrpKQdY=k3Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0146.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB9667:EE_|DB3PEPF00008860:EE_|AS8PR08MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: d790b67d-2302-4248-a719-08df4b17d9cd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|4143699003|261026135527099003|56012099006|11063799006|261021135927099003|261021123027099003|261026121527099003|261022105027099003|261028144727099003|261026130827099003|261022075727099003|261021121427099003|261022113327099003|261021130227099003|261026140227099003|261022115727099003|261021133027099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 8zNPQrEzQpw0UdG6seSClQfq4DDyYs1G/EpE/U7IkX5y5Kp++yR3z6cl4jZcnNk2zajg6joC6Fkmff6ntyR7mm7fIujo3iHVD8Q/V3K0ii5EaszAD1zD5QFca3KuYjQmfOSqlSwfmAjzRcaJn/cMnhWfwD0EvzJamqN/QShYsrrSZy0yqwfRT/vQjXU2uErhlMIOuiwK+eb04hWia+W1JCtDKP+87PKi2ZGp82PFgzrVj6abWZCFCF691f4CC83LrDML+e2icJoKGLn6Vntr8rVLO26u3FjdK0F2Gs9X/1fMvRX3W53BP+OaBh2hwrZVuNqsM7ftAON4hYaFZpYKZMvZddB2QCV0zuCgxDG4zDoAeFHEFP+UPS29UYw9g9RVsCXcOk5VAVyeLYp24Hf5PwLBxlPmeZsZ5nin6ClpVxY402wEzNMxgk/W7Ixfe3tet8U2EMe4tcxyrBcShb351EwIGxo13mzmh1dIsMUQ/eXiGhihHxPC0nM5pga/pErR29L9FSDZX6cdky886Cq4HCCMkJ8SOSNC5NHjpOPjLm8ayAfdahyw9WJQCS0sL7wv2SSmhUexLJRnYjBPMt8WPb7Rq7g6TGpLWf1w1F/nMGmoy4FaUC8eS0ZtC+mbVr6FeVwqQSKHEeLok18CNyFeuhvT1YXs5fexP1KLDIMvrGk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(261026135527099003)(56012099006)(11063799006)(261021135927099003)(261021123027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261026130827099003)(261022075727099003)(261021121427099003)(261022113327099003)(261021130227099003)(261026140227099003)(261022115727099003)(261021133027099003)(261102123227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: hulyPz6RK+KwhKzycl73uTp3+OeFxMb/kqu89+fm/BaX/fJqZp6FZ3pkigGOs1pucUtrnwpkWy5M3LKenRv6nqR/REKQUt9F/QNh3k5dB5t5NB79c159wWcy/ZDVgmCxp+cQhXXGQJSJWVQzron1J7j0SFjZW0NYJyi32EKnGuGkgUnpSAqchkU1qY3GB9QE2MfR6fBhl9BpFXlzCz1E+NnoFjE8Vr9EmdmNYMhsnTmCf9teToSf/00tZJQNqlbvcPbUbvt1hJRk44HfoafB6OuSbRup1ym6dfc5hntHGME+IZGnmObeQCgdC8S4j44AlVapHS9Q8pKC02374ugK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9667
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 31b3cb46-66ec-46cc-f1f3-08df4b17c563
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|376014|1800799024|35042699022|82310400026|23010399003|36860700016|261028144727099003|10067099003|4143699003|261021133027099003|261021130227099003|56012099006|11063799006|261102123227099003|261021121427099003|261026121527099003|261022115727099003|261021135927099003|261022113327099003|261022105027099003|261026140227099003|261026130827099003|261022075727099003|261026135527099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +1UenJ9HDltDW3b0cLECQ3EKtxEzaJCYToKvlt9qGo+yl0edcMDGM22RQ3gj9tSCu4RMQMSJVEnqletcAuHLwJ6ebwM/L/nP89271p+lrXspkir9BqUHROF1EvZAT7nbJWHd7cqvR2/g2FaZ+gx5D3UGqTp09DB8qfjy/x6oTtLh69x+ekv95FB/5zqKqhAMTkGQ0XH4LjWJyEhz48cMQFRWNM9bxId9+v9XSp7cUrC73Zle+/6hkLtw0MvZF7cARmIPjbogULCRYAVfff7pOLivldnW/hb5WuL21ndEOo8D8RwP3aDB42L0JwZ56559R3PgP0n4942ZCL+Ihf66Mh6RCS8gMK0SQdaq/8IPTepKyTj6lD+dbiCHa7WObpxvLxivJn0xQ8467TE65KZC8/gIDk0+uZtW1H+n/IB7VQzHTZQ80aaTiMB63Oe/zFDRas72GGtd+0GQtf6sviBYgRKb1e3vv5IQkDkOd3ZBkE5uWLw5OAZZ2jgAfe6D07PXjU2No8/sTynPtFDvN3SPZ3P6eOGZFeW6HYzpGjqByH2R+s0hY4B9GQkqUE79sckME8q59ouJ6Htjw6zk9DhoXfCixvjcblRjil7XBkKMcDSI4yNEkHcQjh9L/fMO2fVH2aNeBcy1O8aSHwThhZnAmHwoHi6lQL0D14eu0TA9paR4VqhDL4NOoXfxSLmq0ouafHmRngEaMWRRO43SacptKw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(376014)(1800799024)(35042699022)(82310400026)(23010399003)(36860700016)(261028144727099003)(10067099003)(4143699003)(261021133027099003)(261021130227099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261026121527099003)(261022115727099003)(261021135927099003)(261022113327099003)(261022105027099003)(261026140227099003)(261026130827099003)(261022075727099003)(261026135527099003)(261021123027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G19jmpPB7DsWSwcpTDdmeMveaQAa/5xWzT1zEscIb716iyTB7vK3YeTFdvCzx1f8WBF2NdRhjBS4K4q0KImkKLsK1A1ufyUL35Newjg6W/b/STUx2czzH9gsTkILnv0o38rBmYy5Zkez//HZi8u7MDuZ6PyKLkz8gpd/7uOXUay7sjSiOiiJOIvqiabMJPQ6nvFmvRr4T3nNHjLgKxEVs3qNzfhyB8Y3AXK4Mb8mAe5hg1R89P46jLDI3AasWTbwZoG/27POEEZAFOmKL3KP+n3whjkMwCthPH++EXYmEbwWxrma/pwNRs+LhqE229GRkUU8s1PeSfzHuKZhL2xHU/urFHSXQPya9Omz2JgyWDhi2his2oLDCo7jp/P+5Q7Mg2Is4cIErBgCOqHnD8Iai3bYrkKyfJZdMJ45OnbnSzkIz8Irw6r9XRWIJQXUDrcR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:16:31.9336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d790b67d-2302-4248-a719-08df4b17d9cd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6101
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi James/Marek,

On 24/11/2026 10:59, James Hilliard wrote:
> On Mon, Nov 23, 2026 at 4:37 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 11/23/26 11:13 PM, James Hilliard wrote:
>>> The ADI boot scripts set httpdstp to 8000 and use wget to fetch
>>> ${serverip}:/fitImage. With lwIP, wget still connects to port 80
>>> because it omits the configured port when building the URL.
>>>
>>> Use httpdstp as the default port for [host:]path. Preserve a port
>>> already present in the configured server address. Pass HTTP and HTTPS
>>> arguments unchanged to the URL parser so an unsupported spelling is not
>>> reinterpreted as an HTTP request to a different host.
>>>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> Do we actually want to keep perpetuating this legacy behavior or do we
>> want to leave this behind and not complicate new code ?
> 
> Not sure, I figure maybe try and get feature parity first and then clean
> up unnecessary code afterwards to simplify migration to lwip.

I generally agree with achieving feature parity first. In this case,
however, I would rather not make the lwIP implementation more complex to
support legacy behavior that already has a cleaner replacement (specifying
the port directly in the URL).

The ADI boot script, and any other downstream user relying on httpdstp, can
easily be updated to use the URL syntax when migrating the platform to lwIP.

Regards,
-- 
Jerome
