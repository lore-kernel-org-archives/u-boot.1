Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679B606A329
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DnW99O9U;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=PKXPJL2C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B9AB4068F;
	Tue, 17 Nov 2026 07:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsxktxu75Kyq; Tue, 17 Nov 2026 07:47:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E4434069A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794901656;
	b=swhWC4rX0lETg8qW/cxC9QnZNt89J8Sltnlh0gdhc2z3rYAeMGAZsLqbd+4psPADfGvj
	 aqz4RuwNC/lZZod3v9A8PVAOOEzgmkRduayeG+BdVPvJFjvChQbGUmcOAvEhJkdSkuQP1
	 pTfW751gmXuk3B/dRTbR7ZDANosMZjS64/o/iRB2H2oYDuF3sturrYU1oXoLy8snzo2AQ
	 49SxLZqcycFnJHDWxm8WROfsGKaIMmyZ7LTRElEKcGHRbD26zHWKrfHvxElMHP1L5oh0s
	 KQx5MPSobTvAiJ8iijT/9cRGj/KcJXjbxY3gDHX6ev8vGGJfse3My4PWAH7gwN1bWZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794901656;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=8S8NfZrH15FNWvfrBbtMoefbFmpRjdRi0QhXOUGWOw4=;
	b=RR9X+EGTSB83DHuSNhZB33iLpO01vGX1+yq33hBTmwLFCk4zPQIKK5/39osmInB7yi0s
	 49idJSbRbDPPhJ7kI6QFLSFuKLsARo2yjNrdAqGYHuNjoeISIVbtI1C423yviLJRFLn8t
	 +KtI8qvcdK9SJwBZ3np86lEAS/cpa65cOcGD2jUx9HzQuLJ/uzV+ScVuSkZGM0TZcoJTW
	 ZbUmHK3+jzQ1IwdUc1FVyrykSZjjAU1a5CAAk8QhuPOvpqPAiLtX3sOfwfApA7RVIlQPK
	 JOG43wS4fcWJsZyW0ZkR93JhETsZ84JR3LQPphwY0awHyWHcB4sttjT9xxUU27RAYOA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794901656;
	bh=8S8NfZrH15FNWvfrBbtMoefbFmpRjdRi0QhXOUGWOw4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DnW99O9UjkajDXDJ0Q3PzRzPr0eCoOiMsVTLPi6hqt9NfbjfcFqOSuFCpN73xN8Ho
	 J8v2+Xz+w48kdxlixMACO0dU79iPGvevzS6/berz5flJWn0RvcQqj9K6NkEIyiGDew
	 xVQP6Jt5IWlEFSzDvDoGLYnGfBRhkYhhK3X71fwgr/y7+iIqO0ipEVyQd04OCL661M
	 ofh2CtFLoHSjKHLzZalAas9g9iyZBUUAH/HSSaa1BykggyRbbt+d5+u/5tstcTyGjt
	 hsWnB2LRRDCuctWE9fNVdx5S824feod1G8WGmSz4WHGw7OUERO8PeM+kKNbOYW1kiJ
	 RuHSv46tEwu1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E4434069A;
	Tue, 17 Nov 2026 07:47:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EAC6A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B39760828
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53Uqt-GbK7IM for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 07:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 383EE60739
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=PKXPJL2C
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 383EE60739
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8S8NfZrH15FNWvfrBbtMoefbFmpRjdRi0QhXOUGWOw4=;
 b=PKXPJL2CD8RMDfjazpLZXiQVlPN3RIhQf8ClOtz+v5yj360xIBjYduluRGsJ0es2P2DpSnxdbZ2SPo4NE7Pu0fXFIglaw5QooX5+Qot5sDlCBerZRKA4AMYyfHJmAsAD3lC0MyKDSRqUbm+qQSMez0JzDXS/1bOXflrqBgffs55x+ca+cwG0gPhin2KW5UiwS/b9cOy9VQ/nRsmuKdVtND92R/pP7R683HSLugVGhf0A8xDIZld8hSrHaWyVCDOuXQWQnbagVW0gSQ/g+DDPfLAlHFl5Y7K6Rffl4las7l1LASUKMYx8KvFnK/9k2aV0ttDwn6hgsMNeXkGM1Q1Ngw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:47:27 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:47:27 +0000
Message-ID: <d8917fa3-7694-4eeb-be53-aa0a65268723@iopsys.eu>
Date: Tue, 17 Nov 2026 10:47:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] spi: spi-mem: sync code and behavior with linux
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-5-mikhail.kshevetskiy@iopsys.eu>
 <c528bdd7-8f87-45cf-9ff9-dcef2109e99b@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <c528bdd7-8f87-45cf-9ff9-dcef2109e99b@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f2257c-6de5-4018-5876-08df447f06e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|10067099003|11063799006|4143699003|56012099006|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SZyq7ch1wJ77n3LAYI/ztC+SdtwpK2UB+POIqjQO+nq5oniqWscflk+lZ9BhnS4fegA3BzKRHUH5zaH0d036zK1ms9nKhTkUpf40fVuhy4kTgZXMq7s8PY2tS/LCkwZqqEKmAr9C80YVL0MdEbH36krRZsxjgpaFUtchItu6FHWDOSh7+WQFmSx4OZXkRYwsGeohb0GahprQjlxlyug0aVMdjmH9H+4NXxQYYxVevTIDuMncFWyROqJEwYzbS0YB2Pf6Cu86YYRwWQQySNTI30qw8Cj5/2D8j3YY2MFS43NEflLTD7KbyfmW7pXcYwZ+wSzJgbh1hd5ESqFFbXIDam7qE1PJw4thHRuWYGrmEfcLJNwzSSmZVPIfAbXqT5DmP5QO6yIW8XgnQL/BxMIanooBZSnl3EJOFF/5kzd9XQN6hJCj1UL4qZpt4pTVLwhqgY2S7NqKjC7w7hqALu75W58oPXSkZQBGe9theTxPDSWW2k+o3ksOVWP61coMCtQBN3RmE4KgZ5dR8z7skJ9jtOHqT4qMTcNPmZggjPXgO5Z3WridKhESz/wzexpdZnE3GKD9EUpPmtQ937SXG5fg7iCNyam3XDZbeF87A46rYgd2fXkgMp7azm3R0zxavThKX2WH6tbTU/h430vt7W2xlPV+Lh1l+Qx03YL0FsgqShzw3itF8wZHFVCqE5Rp6cOxQyhjBDZwLN3/pxAyXP/mqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(10067099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNaRHR1NENicVFaalJyY1JIekhxSFpYRUZXRTVCbDZUTXpRMVgrTmVUeVhL?=
 =?utf-8?B?R1IrdzVBY3ErNWZ4YnQ3TkcrRnE3bUIzbmpqTlhCZm56NFZZUVlCa244VUs0?=
 =?utf-8?B?TjhvS3hMRDU0eWZRVk9IeDdFL3FXWUhRWWptTWhXMmd5emRpVGhJQ1plTjlY?=
 =?utf-8?B?cHJST2JSTzZ2bktZdHNwUmVOK3JOMytPb2xCUmVyeExhck50Q0xZTnYxV3Yz?=
 =?utf-8?B?Y2RuRzRJengyRXZqckE2cWN6K2s0QzQ5bHNzaFF3S1dVbzJZbEdvZTd4dmhH?=
 =?utf-8?B?QlhGK3cwQ3MzWG82ZlZ0QVB4NEJtdU1WR20xN21UNjc3dnM5T1kra21TMUpM?=
 =?utf-8?B?OGF4bHdtQzY3VHlRZ3hKNUdobFpLcmxHRjRHUVNna29mWGlRZHhRb1RmWVRI?=
 =?utf-8?B?a2l6YTNqU011SmUrSzEzUm1FQ3pHSGhwRytYVzdCMGE5UmlMNFo0ZVVodzBQ?=
 =?utf-8?B?cDV2Q1d3THlSM1pydEhHbVlPVlFlbHQzSDYzUlNzR1FVZGdSc0JxT3JjaDJN?=
 =?utf-8?B?ZkdEYVVyblpPS1RJNVFtcmxmNkIwZ2YxZThRTGx1eVJ2bS9UZGQ4bjJ0Z3pu?=
 =?utf-8?B?N0RJbk5zdEsxZDVUZGw0dVpUWVVvbzZBazR6USthcE9zYmp3ZzVodGRBdkZI?=
 =?utf-8?B?Z0FNVXhKbU95R0dYWlNUZE5tLzF2NWJzMXJJeXdqNGRXcDdERFRHNGlLakJV?=
 =?utf-8?B?aHd1ekJRUnVrTlRoV1RhYnBzY05Cekw5Sk8wK0tEVUFVT2xFdDR2ZGNPRndY?=
 =?utf-8?B?L00vRGEvREZXRXF0Tm5pVmZDRVRNZHdLWmsrT0FMc1loRzFkWFpZdy8yRG1o?=
 =?utf-8?B?ZyticDN3TUthQlZRSTcrRTlEQWZQeSt6QWNwSXlob2V3d3NFdklVTnRCUFBK?=
 =?utf-8?B?WWtVQXJESlphMTQzQ0ZqMlVQOVJqZDUwWXQ3UVovanpwT1ltUGpaNWhOVVJU?=
 =?utf-8?B?QzYzY25PcDJiekM3K2tFamVyOEdtcWxMT3Rxd2lHQXkxT3Y1cXdkZTljSEt6?=
 =?utf-8?B?Y1ZZbDNOR1pZdC9mMmZMVWV5bzBFUUFnN0kzMG5wTUtVL212dGo4cEFhV0tG?=
 =?utf-8?B?NWpvY3NhWEhqbmZ0eG5TaWNFbWtZL3FQQ09pZHpvNEtnTmhONlN5c2wxcitk?=
 =?utf-8?B?UlBnK1l4VlRMNTVHTGh5L0J2bENuMkRlVlZ2Q2ErdkFKNExmRENQbEZ6am5U?=
 =?utf-8?B?bWQ3MkFEYTczRW45UmNvc3BOOWErR2FHWHVreHRCZmxzSURRWHlpWHBsVXpU?=
 =?utf-8?B?SS9hN1VCVms2OVF4NkRMUTdEN05kbGNlcXZveENDOFgzMkozRllxZ282TWRt?=
 =?utf-8?B?VE9qc0w2TU9WSExrekpuZFNmbWVnbkRNeUVFWFlNL29iaTdCb1FUZ05CZU1o?=
 =?utf-8?B?dnJNR0JaaEpTVThFY2E3UUZ0T29VUXQvN0dtSklIRFRvemVaYk55OHBPTjls?=
 =?utf-8?B?c0N4cXhyb3JQdVlJeEcwY2tZc200MjlySUVrTEcxWFI3Smw2WFRFVDFDczBw?=
 =?utf-8?B?T2gvMHJ2a1RWdnI1S1YwenNQOWliekE5ZndFOVhibnJFYW9PVmoremxza0ta?=
 =?utf-8?B?NnFDSksveFZiMk5hTHlBK1dhaFBTLzBEOHdzbnQ4UUd5dDVrUUhoWFVab3N0?=
 =?utf-8?B?QmNOUW9mQ3JGN3BIRnArUWNtSk5kTGZ3K2JvN1lWcDY3elZZYzBrYzREclVS?=
 =?utf-8?B?VFpiVStpZ0NockVJVnpPUms5Q0ZUelpvL2EvMXoxQzYxeW1Td0tqYVBvWUhu?=
 =?utf-8?B?dldsRFhjQzZHSllNWVhScXlKbnhRQi92bHRUNUcraXZWSjBHL0N3RmFEdGxn?=
 =?utf-8?B?YU5kZ3hFVkE0Vmw5aGpWdDdzU0dJekVPL0M5WUJaZlA0aDR2bEdoYy9PM3B4?=
 =?utf-8?B?bkNGSEhWUHE0cmlPQWt5QmsvTDR2SHV0ajdzcUl3R2RGR0FQTTJCLzdCcW1S?=
 =?utf-8?B?aEE0ZkpobkcxWUVML3NzVGRSamxaUHZ3aXN3MXFza0pTK1A5b2VDUWFpQjlS?=
 =?utf-8?B?OEtDRVdEQkFpUmUzSkE3MVNDelNIWVNLcjM2NDJ6VlFXTGQ3bFZ1Vm1XalZr?=
 =?utf-8?B?anVqc3hrR2VxcjAxZ1EyQnQ5aUZQNnp0MTlScmZYajliT0hyQkZPNVRqUVdS?=
 =?utf-8?B?S25LZndZVzBjVUZrODd3Rk43L3pyRHBhRTArNUg0QzNHZXoxVmhpMUpKQjZ5?=
 =?utf-8?B?TXQwbXNTeXRRUGhWRk5tTkxmYVdjdUMwVXJLeVJWUkdkWitFak8vQkZybVc0?=
 =?utf-8?B?T1dENDNjYTd2dTlvTDJBQlpFREhETEU5dkNJaVZoYVEzdXRNbE5sVzFIa1Vw?=
 =?utf-8?B?bi9VZEt0VVRPL05RWitUVDg4Y09BKy9JK0tFNDlZOVlSZ1dCRFBDczlFalhz?=
 =?utf-8?Q?vtQsjQsfFZNZOWrw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f2257c-6de5-4018-5876-08df447f06e2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:47:27.8053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNwkkRwQHt1ioMpXhDYCEmrWlcbRIla6YlwYg/B6+xpj1LicP3kDpG4tHqelt97tvGpS8yImAEyrHpcUoDjs1cY8+G2d0+0oh4zOAdPFr18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/7/26 10:57, Frieder Schrempf wrote:
> On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
>> Align code and behavior with linux-7.3.
> Better mention the exact release (Linux v7.3-rc6), and if possible
> mention the upstream commits or pick them directly.

I could try, but this is just a sync. In the time of publication it
matched Linux v7.3-rc6 with additional changes planned for 7.3 release.
Now it matches Linux v7.3 release.


>
>> Changes:
>>  * add comments
>>  * use the same error codes as used in linux
>>  * add more checks for spi_mem_op
>>  * add macros necessary for spinand dtr support
>>  * remove unused macros
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/spi/spi-mem.c | 65 +++++++++++++++++++++++++++++++++++--------
>>  include/spi-mem.h     | 26 +++++++++++++++--
>>  2 files changed, 77 insertions(+), 14 deletions(-)
>>
> [...]
>
