Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB1606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=powm3hIF;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TdMi0RSw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AF64608F9;
	Tue, 17 Nov 2026 17:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iliFAsL5NJyX; Tue, 17 Nov 2026 17:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 991216081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794937921;
	b=iIzl4Wl7MkDWA0iyXUDCC2gLJ4oYQc1BZoOBT5RDNwMpJIePYgZ1TDk1mvRS4mWo4dND
	 FPqiqYxA3xzU8FHKepId5tv+6cgZJBpE8TNbW17hLM6Tywt1s/rMPaJxb5IDkxX4LeHeJ
	 iVGIu5g2tBfpZWJDKxmOYzOmMn+Ve7/uRDqB5qIACgX6y40NUICVhkPTXewn9GLsbaSr4
	 SnWpNoEfXXWgCaDLTU2RHKGhWyyAlF3502VQK3zwFEgF9H5eK264uxDU+y93q8QybYSl3
	 DrYHBHKv66sC/9N2Sy6yfDNoxJ7ekF6y+AdYznmI77z+tKik18UlGzZ1aTYZA8gExJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794937921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TNcJQcaCVx4MRuoVIQ/QWzFbEeGmL5ODza2FwE0WdcE=;
	b=B7kUD+G1YrDh0FaxuxhDZhgQBPEx/QYHNLCmY9J486tn/Ka9+DRqXB83lGRHiGcbPuGR
	 7CDUSVsflW5Cwo5F5jrWHukNSG/Y99bzloAE+qez+M/gPs0jRjfvhE/o2IDGd+5CmDAGy
	 SHQNxnXH6LX0up5V1dz9bVmGXcLdgsg0hbsmzZirI8fyO+tbGeZ+ozs/bdDvi2YLcvqa9
	 UuL5GwjPbTr1/e98XaMz1gpPH45ba3/ByPdwgM6s2d1Ko47zfl96+rR2pLayJvSmz5eUp
	 NOr1o2sgHrLZLmjcyQzOi6N8xoDYtJ3DKpXcOuuEtipbhFSmCv0xapy72AMeBuOY+OA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TdMi0RSw;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794937921;
	bh=TNcJQcaCVx4MRuoVIQ/QWzFbEeGmL5ODza2FwE0WdcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=powm3hIFHHmvPlj7MToU4QxmNDwTsJfwetth/HOtsyDOzXTq7SoNXB6xGH1ltGIsS
	 W38hGGq8OGOK3hCM/B93FCrLqXuMJS3fULFkiM20zxuX2QDJZgkC1mcDG4a/SKri54
	 Kg4XjeXMyHEFPVujhk8eUwKayKiTbKHRmJScRJodaIsqJjYCbB63D2NR8nt4A40Khc
	 wgSZHJTz4ae3WogJw548wpjStbeaKGRqu/K3NqZzSmbUdLjjjS00btsmTbzqhB/f6Y
	 IG68uBoH4CSH20TBg0YiVJ/4Z00lMmWO8V1pqp3QP5S9gpOjLN7/jdhnHB6TxhuM4u
	 kqz+s+rq8BlwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 991216081A;
	Tue, 17 Nov 2026 17:52:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 830C449B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68EEA6081A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u01pI2blbKXZ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 17:51:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4050260761
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TdMi0RSw
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4050260761
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNcJQcaCVx4MRuoVIQ/QWzFbEeGmL5ODza2FwE0WdcE=;
 b=TdMi0RSwGtbEXKPrGL8rSYgDCpitJ36FajdpCMhWz2Npav0sIf+0j5wBIKDa9RCyfSrDcGLKQ5oRdt3NWXtjQJTsiajrfij1ShDvS5fXzUxu1nM9tZA+Zzhqk3rbqpxXfhit2lFqXkLw9BmNP+9obQ4FB82PVBj/EWJFhBsFKsY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:51:52 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 17:51:52 +0000
Message-ID: <159ee406-e78f-4ae9-a1cc-0a0e7b7c72b2@cherry.de>
Date: Tue, 17 Nov 2026 18:51:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
 <auy1K4oe9E2Fr9xu@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
 <83adafeb-674b-4e2f-96c9-b8eb7694dc0a@cherry.de>
 <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <avT2W0RNmRp9tSat@ekovsky-thinkpadx1carbongen9.rmtusco.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI6PEPF00000233.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ef) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b43b5db-9fe0-491e-d032-08df44d375ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|3023799007|4133799003|13003099007|5023799004|11063799006|4143699003|56012099006|261022075727099003|261022115727099003|261026135527099003|261026121527099003|261022113327099003|261028144727099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261009223027099003|261102130727099003|261021130227099003|261102123227099003|261021135927099003|261021133027099003|261026130827099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: oITzIPSc027CxdgZmC7h+60DvCMd+F5vbnb3mi5p2gd8Sa7GK3vh+G6M6vAZMMjKG2QNFPWT9eeE/eK68YSeQ6WfNJfEFTBt5FwxxxJHX2vhUoimy5jkcYyMYwXKHZwL6+LsRv1zgFRB/czSfrdWjDe3JtEVvz4vJP1tmUY32LmxCSlPkCNuB6ZA8oblyNAvAxGizV6sbNeypZPEXuxs0z+39xeO6K9o+wV4LBvugf0GCggBq5RuiDB2QgD3Bd7EKY3RylEnRBLqS8ORclK9VefFmX9+Y9wmA2XtuVh3u1YOCEAGWnNivfrN9wX/XTZCrWZOxdMJxJaUsQu16PgdMaUzbyJYqaZHH2/U2f72bp8gq415FZJJ5cMXdwRTVEsPAmlTuJ6MCbRwm2xpOlxRD3S4GAqDaoG1NSGTviwDcJVxHBwerCGkwC0NFK6NdrzsGSx4qOPtJwAQbbCOtsc9eGowDUeewHWAGhSXSFkilXvOfDaWflelS9umtNRZZx2b5VosfKZ3SFCu4axl7BK/JrKffA+EDCZJXbwrOT1ppgkCO1H5Nr2SE4DrzPEFILFhSnadmLCECYtYBgJnd+7aRFIXt1FsnELtzFieIkNfdRA9A3E4R0AuuaOWD2TydAGb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(4133799003)(13003099007)(5023799004)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022115727099003)(261026135527099003)(261026121527099003)(261022113327099003)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261009223027099003)(261102130727099003)(261021130227099003)(261102123227099003)(261021135927099003)(261021133027099003)(261026130827099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlqbnZ6RW5WbXlHTjN6RytYcW1DajlPVmFVZHZ3cUxNaWlzUXhZTzdab00r?=
 =?utf-8?B?dysyS0Nqb0oycktJd21sdlBWRlMyTDg5NzJPR3duaHAwOG44dWlPRXZaYVVm?=
 =?utf-8?B?aXNEZ2dFZ2ZMaEY0aURKYUdIZ2p5K3dIZllzTkhCcllHM1N4ZS9zK2Z1Z3Bz?=
 =?utf-8?B?MGc3TGlxN3pNWURCcnhyNnUvc3ZRN3NXRFp0dXFKMElhcWJML0Uzc0VlY24w?=
 =?utf-8?B?d0VJMTRSR3E4bUoyR1k0Yy9jU3huSnBuVXcyeTd0NE9BdWpJbUw1TlRsMVVR?=
 =?utf-8?B?WGJxZ2w3OU0yOTF6M1hJOXpRdk1DQzQ1VDFkdGtMakJLTy9qSzhZUXZMdnRh?=
 =?utf-8?B?aFdKakxHNDNhRkQ1MEtzaDhRRksyMURJOVJpZ0VQN2RKb2IrVXZIWlR1eVVD?=
 =?utf-8?B?bnFHdWEwVXdEZ09iUnZDMGhtTVdGd2kyblhGMnNDR29hUHJ5Y2JNcXhSaEw0?=
 =?utf-8?B?dmUxMHczWmRVYVQ3dFNEY0xwd0ltL2c3R0lHam9iL2Q0NnJYdzBDSEZHOGt0?=
 =?utf-8?B?SmNTTEcvMTF3UVlmYWJ2N0d2bUc4WWRyM2hRSU5nODFoVEpYZDlOVy83a1F1?=
 =?utf-8?B?K1B2OWoyMG9abzhFWVZpdE5xMzdPSmN1b0ZtcE9RT3pvUzNWZVBzMnNlaGhG?=
 =?utf-8?B?c0ZrUkM3THFHV0xFN2RiRlgzU290Um5mTkZubU5MNGV1Y3lEa3FTd25iNTgz?=
 =?utf-8?B?RkpXajNIa0xTZi9KeW5SU3NGcC8wWkh5U0hza3AvcDI3UnFYNVhHbTdoc1RQ?=
 =?utf-8?B?RVY4NUszMmhFbXFmU1dEdEtUb1N5Um1TMklkOVdXTUc5R0ppSmZ1WG5VR2JD?=
 =?utf-8?B?RFFGYm1sUWpaMG5odXpLYXd1bTRzWjNPZk1UUjI2MDJSd1pmWktqT1RSWHlF?=
 =?utf-8?B?eE43RWJndmh4Mm5NczQ4UFVHaWkveTJFUWZFZWxMU3M1VUszV3NoWWNIRWI4?=
 =?utf-8?B?dkRCSHhJVHJiT2hLdFg0a25ETXc5Y2RkMlFROUlFTUl4bmZ1ZXE0a21lQ1hN?=
 =?utf-8?B?RU1ZZ2J0NVJNODlKM1ljamVmcmJuVlRjRVJ2Y21PNFVqcjJCWDlDTktCaVEy?=
 =?utf-8?B?b0hiSDJraEYwL0NSSVkvMWhVM0FxcnRXSzVOVm1PVU02OXk0K1NsSHJqN1ZJ?=
 =?utf-8?B?ZGhWaVc2aVcxQUkvei9ZRTJVem9OcGxybFgwZzJLaHFHSC9HeGRKa3orMFlp?=
 =?utf-8?B?LzZNNkdiSHdyZXBtaVFBMVJ0TGNxZ2lxWlpUWXgxU0tMS1MzYTJGN0hmS1Z1?=
 =?utf-8?B?NnRTTHNjZXZ0Rk1aOHp3MHFGdmcvT3FtNVM1NDYrelAwd0RtcFhiazdtZGpW?=
 =?utf-8?B?NFhmTkFsLzc0SHV1NWZpSUthbXNteFNPZTk3TlhKdUhpNUlOUFBVeVBwRHB0?=
 =?utf-8?B?WTFzZG9KNXhiMUZCdVMrVWFRQXEzZmNEZG14VHR3UUFRUGpiOFJmQXpVcGsx?=
 =?utf-8?B?aDI4b05VMzg1SkdKcmtZQzZpU25xQy9KZkVwSXlHK2FxSEcrdkNNT3MvYm0z?=
 =?utf-8?B?bVNkQzRqOUExakRvQzVmSzFGWXZmNDBnU0VicE1CZDFHY2FvUnlTblJCUFJl?=
 =?utf-8?B?RTBvOWR2cm1WdWRiM24wTzFPOE0wKzVqMlBZdlFrTnpuNnVpWjMyQk9pOEtw?=
 =?utf-8?B?NEo1Z2NNUXdXbC94VjV3M1VHY2ZhR0dJOHA1MGZ5cG5WV05vb2sxSWRQMzd1?=
 =?utf-8?B?ZkxwY2o5THRMQnlFVjdrVFZ0dHBxc3QzTVMyTW1ocXppZENQcnhYdFJieTJv?=
 =?utf-8?B?SUVGZmY1UGY0OFBTNUJUQ1RFV1IyQlYvVTRkQ2x3Q00wOXZ3MTRVNVBZQ1g5?=
 =?utf-8?B?RmVkOXFLNmJiYjQ4YTlQTmdFbFlvdjNxOHMza0Y5bml1Wmd1cWduak8yWmZy?=
 =?utf-8?B?ZHFJa1pWUVVadERDVkJ2ZnEyVGdVVmYvQlF6ZENFZ21SaFltYmo1cEdMKzZo?=
 =?utf-8?B?c3YyVUhoa1NNd0IraXc2WWF0cnVvZ2p5MEsrMG93em5vc29JTnJEY0cxcnA1?=
 =?utf-8?B?dTBmOVROM1kyQ3pRMWNxcXBEQy9pR3JsRXg1bjh2R052c2JBOGUvS0c0WHBm?=
 =?utf-8?B?cHV6Qm11eUNYUTR0SHViZ2tiZHJ5UVVHMnBBRkh0aU1aekVlV25JSXZpYXhn?=
 =?utf-8?B?WlM1bDlxL3JxaGRIN0ErdnQrUTJrcEZKSDgxTHFwbnhJMkQraCtGWjhmVEpj?=
 =?utf-8?B?bnprcFdMTzJXUTJTTDdibVJWYXdiZC9vNW5MdlVhVXVUUFlFZXBaMC8vK0d6?=
 =?utf-8?B?d0x4d1RvSGk2NTMzQ0owUVZISjdFY3dpcWRJbFp6aW83NU5MSGVveUd1NmQ5?=
 =?utf-8?B?TlJYUDdFQy83ZDlMOWlVOUdlS2JXekZyUGJBZHMvS0lzeTcwd0Jydz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b43b5db-9fe0-491e-d032-08df44d375ee
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:51:52.0186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwCKzbFGkryqEttg5NDgdVP4yBHIr2cgokGENKb4nI1o6Yh45UNzZFd6JFL4zwoG10F+FVGvKuRGZTh+eBMQ1L2ny1SlTDjZv0NhpQaLpYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

On 11/12/26 12:12 AM, Eddie Kovsky wrote:
> On 11/11/26, Quentin Schulz wrote:
>> Hi Eddie,
>>
>> On 11/5/26 5:56 PM, Eddie Kovsky wrote:
>>> On 10/30/26, Quentin Schulz wrote:
>>>> Hi Eddie,
>>>>
>>>> On 10/29/26 9:13 PM, Eddie Kovsky wrote:
>>>>> The Engine API has been deprecated since the release of OpenSSL 3.0. End
>>>>> users have been advised to migrate to the new Provider interface.
>>>>> Several distributions have already removed support for engines, which is
>>>>> preventing U-Boot from being compiled in those environments.
>>>>>
>>>>> This series adds support for the OpenSSL Provider API while continuing
>>>>> to support the existing Engine API on distros shipping older releases of
>>>>> OpenSSL. Build dependencies for local development and CI are also
>>>>> updated, while the final patch adds support for using hardware tokens
>>>>> with the Provider API.
>>>>>
>>>>> The changes have been tested with the FIT signature verification vboot
>>>>> tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
>>>>> tests pass with both the legacy Engine library installed and with the
>>>>> Provider API.
>>>>>
>>>>
>>>> I'm NACKing this series quickly because we are having pressure from multiple
>>>> projects and Tom would like to see this fixed ASAP, and this version here
>>>> should not be merged. From a cursory look a lot of feedback was ignored,
>>>> possibly because I did too many rounds of reviews and it got difficult to
>>>> follow. I'll therefore spend time next week to collect the reviews I made on
>>>> v4 and that sill apply and post them condensed on this thread.
>>>>
>>>> Please, we just need to fix the build issue for 2027.01. We don't need
>>>> providers in 2027.01, just the ability to build on OpenSSL 4 and on distros
>>>> with OpenSSL3 with engines disabled, without breaking OpenSSL engine support
>>>> for other cases. If you get a patch to fix this, please send it whenever you
>>>> can, I'll still collect the reviews from v4 and post it here. If you're not
>>>> interested in doing that, lemme know and I'll take over this part and you
>>>> can always test the patch(es) if you want to.
>>>>
>>>> Cheers,
>>>> Quentin
>>>>
>>>
>>> Hi Quentin
>>>
>>> I designed this change from the very beginning to maintain the existing
>>> code base and preserve backward compatibility for users of older OpenSSL
>>> releases who are still using the Engine API. We cannot add support for
>>> OpenSSL 3 or later without moving to the Provider API because of the way
>>> the OpenSSL project has changed their interface.
>>>
>>
>> That's not true, as already said in v4[1]. We currently support OpenSSL 3
>> and engines, and we actually test this in CI. You can test locally by
>> running the following commands from your U-Boot git repo:
>>
>> podman run -it --rm --security-opt label=disable
>> --userns=keep-id:uid=1001,gid=1001 -w $PWD -v $PWD:$PWD
>> docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
>> python3 -m venv /tmp/venv;
>> . /tmp/venv/bin/activate;
>> pip install -r test/py/requirements.txt -r tools/binman/requirements.txt -r
>> tools/buildman/requirements.txt -r tools/u_boot_pylib/requirements.txt -r
>> scripts/dtc/pylibfdt/requirements.txt;
>> export UBOOT_TRAVIS_BUILD_DIR=/tmp/tools-only;
>> export PYTHONPATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc/pylibfdt";
>> export PATH="${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}";
>> ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board
>> tools-only;
>> export TOOLPATH="--toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools --toolpath
>> /opt/coreboot";
>> ./tools/binman/binman ${TOOLPATH} tool -f missing;
>> for test in testFitSignEngineSimple testFitSignPKCS11Simple
>> testFitSignPKCS11Object; do ./tools/binman/binman ${TOOLPATH} test $test;
>> done
>>
>> You'll see all engine tests pass.
>>
> 
> I assume you are referring to my second sentence "We cannot add support for
> OpenSSL 3 or later without moving to the Provider API ..." I can see how
> that wording could be confusing.
> 
> OpenSSL 3 deprecated the Engine API but did not remove it. The Engine
> code is still present but not callable in v3 because the header files
> were removed to help prepare users to migrate to the new Provider API.

The above is incorrect but has been discussed by Peter in a different 
thread so I won't reiterate here.

> And OpenSSL 4, which is gaining more adoption, removes the Engine API
> code entirely and only makes the Provider interface available.
> 
> Some distros, like Fedora, added an optional package to put the header
> files back alongside OpenSSL 3 so that projects (like U-Boot) which
> hadn't migrated to the new API would still build using Engines. I don't
> know what the base image of your container is or what release of OpenSSL
> it's using, but it's likely doing something similar to keep the symbols

Once you know where to look, it's easy (I discovered this a few years 
ago and I'm not sure many people know about it): 
https://hub.docker.com/layers/trini/u-boot-gitlab-ci-runner/noble-20260113-23Jan2026/images/sha256-d5a14e5c0350a602e7730c9b3d85369b01dc940cd906900074e706c6d2018f91 
lists the image layers and you can see 24.04 is used. You can also get 
this information locally with:

podman inspect 
docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026

Fortunately, you don't even need to go that far, you can simply look how 
Tom builds it, by looking at tools/docker/Dockerfile where you can see 
the FROM points to ubuntu:noble-20251013 (aka Ubuntu 24.04).

Running the container will happily tell you which version of OpenSSL is 
in there:

$ podman run -it --rm --security-opt label=disable 
--userns=keep-id:uid=1001,gid=1001 -w $PWD -v $PWD:$PWD 
docker.io/trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026 openssl 
version
OpenSSL 3.0.13 30 Jan 2024 (Library: OpenSSL 3.0.13 30 Jan 2024)

> available. But as it stands right now, U-Boot will not compile in
> any environment that does not provide a bridge back to the Engine API.
> 

That's not true, CI passes fine with the binman tests to check you can 
sign FIT images with mkimage. See the logs I provided in my previous mail.

> I've found that the fastest test of which API is available in a
> particular environment is to (optionally) sprinkle some printfs
> throughout the lib/rsa/rsa-sign.c and then build the tools target. The build
> will succeed if the headers are available, but quickly fail otherwise:
> 
>      ❯ make tools
>      --->8
>      In file included from tools/generated/lib/rsa/rsa-sign.c:1:
>      ./tools/../lib/rsa/rsa-sign.c: In function ‘rsa_engine_get_pub_key’:
>      ./tools/../lib/rsa/rsa-sign.c:115:9: warning: ‘ENGINE_get_id’ is deprecated: ENGINE_get_id API symbol is removed. Define OPENSSL_ENGINE_STUBS to mask linker errors. [-Wdeprecated-declarations]
>      115 |         engine_id = ENGINE_get_id(engine);
>          |         ^~~~~~~~~
> 
>      --->8
>      /usr/bin/ld.bfd: tools/generated/lib/rsa/rsa-sign.o: in function `rsa_engine_init.constprop.0':
>      rsa-sign.c:(.text+0x15): undefined reference to `ENGINE_load_builtin_engines'
> 
> To fix this build problem in an environment where the Engine API is not
> available (even if OpenSSL 3 is) we need to call the Provider API to
> replace the equivalent functionality. There is not another fix to the

The equivalent functionality would be to use the Provider API to call 
OpenSSL engines via org.openssl.engine: prefix, otherwise you need to 
use a Provider, and that is not equivalent functionality. We do not want 
to support OpenSSL engines via the Provider API so the Provider API 
should only be used for supporting providers, which we don't need to fix 
the build issue against OpenSSL 4.x and OpenSSL 3.x on some distros (at 
least Fedora 44).

> build failure unless you want to make a declaration that U-Boot is
> pinned to the Engine API as a build dependency.
> 

These are the possible scenarios.

- OpenSSL 1.x without actual engine support. Typically, LibreSSL 
support. I'm assuming this works but I have not tested it. I believe 
they (LibreSSL) have stubs that do nothing (or fail) when calling the 
engine API but I'm not sure. Considering OpenSSL 1.0.2 documentation 
mentions engine, I'm betting the whole of OpenSSL 1.x supports engines.
- OpenSSL 1.x supports the Engine API. Engine support currently works. 
Must still work after your patch.
- Vanilla OpenSSL 3.x without the hack Fedora 44 is doing. Engine 
support currently works. Must still work after your patch.
- Fedora's OpenSSL 3.x hack. Engine support removed (and I'll note again 
that technically it is *NOT* removed but rather hidden or made 
cumbersome if you wil: they have just removed the ability to build 
engines locally by default, but you can very well use packaged engines 
in Fedora 44 without openssl-devel-engine). Build failure. Must build 
after your patch. Loss of ability to sign with a hardware token is fine, 
as it's already the current state. There's no need to support providers 
as that's totally unrelated to the build issue.
- OpenSSL 4.x. Build failure. Must build after your patch. Inability to 
sign with a hardware token is fine, as it's never been supported with 
that version of OpenSSL. There's no need to support providers as that's 
totally unrelated to the build issue.

You only need to remove engine support for the last two scenarios, 
simply because it's broken. We are not losing features or functionality, 
it never worked in the first place! However, you need to keep engine 
support for the two before that (and I don't know the state about the 
first one but people would have complained already if that was an issue 
since it's been a long long time (many more years than when Fedora 44 
shipped their hack :) )). Provider API will be used for provider 
support, but we don't need this now.

Your patch is breaking scenario 3.

> I also want to emphasize that I have been careful to keep the existing
> Engine code as it is. The new code is there to support the Provider
> path. We collected at least one Tested-By trailer from a LibreSSL user
> early in review, and I recently found a way to test for regressions with
> OpenSSL 1.
> 

You can be careful and still make mistakes. Your patch is still removing 
engine support on OpenSSL 3.x, where it is actually supported and 
currently working (except on Fedora 44, which you're trying to fix).

> 
>> Additionally, from my branch at https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commits/openssl-providers,
>> I have tests for both OpenSSL engines and providers *at the same time*.
>> Here[2] is the log where you can see none of the OpenSSL engine tests are
>> skipped and only the PKCS11 provider tests are skipped. They are skipped
>> because we don't have the proper package installed inside the container but
>> I tested this locally months ago and they pass if the package is installed.
>> If either the engines or providers weren't supported, you would get a skip
>> with a given reason, see [3][4]. [5] shows that you can build both engine
>> and provider support in lib/rsa/rsa-sign.c.
>>
>> If what you said was true, we would have had a build issue when every distro
>> moved to OpenSSL 3 when it was first released 5 years ago, which didn't
>> happen.
>>
> 
> That's correct, because as stated above OpenSSL 3 only deprecated the
> Engine API without removing it, and some distributions still made the
> headers available.
> 

That is... correct. So I'm now getting very confused as to where the 
misunderstanding is.

> My second patch, along with the CI work Tom did earlier this year,
> addresses the missing package in the CI container.
> 

It is not missing. You are adding support for providers, then of course 
you need a package for testing providers. We don't need providers to fix 
the build issue with engines.

>> [1] https://lore.kernel.org/u-boot/8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de/
>> [2] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/jobs/79119/raw
>> [3] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8339
>> [4] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/tools/binman/ftest.py#L8719
>> [5] https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/blob/openssl-providers/lib/rsa/rsa-sign.c#L22-L33
>>
>>> Both I and other reviewers have tested the proposed changes on different
>>> distributions using different OpenSSL releases. The build failure is
>>> resolved on OpenSSL >= 3, while building with the Engine API still works
>>> as expected. (The only obstacle we found was that signing with a
>>
>> Run the list of commands above with your patch series applied and you'll see
>> it doesn't work.
>>
> 
> What commands? You said the podman local test runner does succeed. If

Apologies for the misunderstanding, when I wrote "run the following 
commands from your U-Boot git repo" I didn't mean with your patches 
applied, but rather from where the command should be run (see the $PWD 
in the command, which expects you to be mounting the root directory of 
the U-Boot git repository).
It works on main. It works in my branch. It doesn't work with your patch 
applied.

> you have an example of a specific failure please include the complete
> output along with the commands and environment that reproduced it.
> 

I gave you the commands to run as well as logs from the CI and proofs of 
why the tests work in my branch where I have both OpenSSL engines AND 
OpenSSL providers supported at the same time. The OpenSSL engine support 
is *still* going through the engine API and not the provider API. Having 
OpenSSL engine support go through the provider API would require the 
org.openssl.engine: prefix, which you won't find in my branch.

I can work on a branch where there's no provider support at all, and 
which will build, use and test OpenSSL engines when possible (including 
with OpenSSL 3.x, except on Fedora 44 without openssl-devel-engine 
installed in which case the build will succeed and tests will be skipped 
as expected) if you don't believe me.

>>> hardware token key using Providers didn't work, partly because the
>>> existing code doesn't make the pkcs11 uri parsing available on all
>>> paths. But Johannes already proposed a solution that resolves that
>>> issue.)
>>>
>>
>> I'll discuss the provider part later on, I would like us to focus on the
>> OpenSSL engine build failure for distros where OpenSSL doesn't support it
>> anymore (Fedora 44 without the ability to compile code using engines anymore
>> unless openssl-devel-engine is installed, and every distro with OpenSSL 4)
>> while still keeping OpenSSL engine support working when it is possible to
>> support it (all other cases, including Fedora 44 with openssl-devel-engine
>> installed).
>>
> 
> See my previous explanation.
> 
>>> What are your specific concerns about the code in this version of the
>>> patch series?
>>>
>>
>> See review on patch 1 (posted a few minutes after you sent this mail here,
>> unfortunate timing). But essentially, this breaks OpenSSL engine support on
>> OpenSSL 3, which is something that is supported by OpenSSL and which we want
>> to keep supporting.
>>
> 
> As mentioned in my commit messages and earlier in my reply, I have been
> careful to preserve backward compatibility for users who may still be
> building U-Boot with the existing Engine code path. Your other email
> states my patch "will break" distros like Debian and Arch. I've been
> testing on Debian stable and not seen any problems. How did you

Did you test the OpenSSL *engine* in Debian stable or the hardware 
signing with mkimage using OpenSSL? I suspect you did the latter and 
were using the OpenSSL provider and not engine, in which case you're 
testing something we currently don't care about.

> determine that Engine support is broken?
> 

With the commands I provided in my previous mail, please give them a try.

Cheers,
Quentin
