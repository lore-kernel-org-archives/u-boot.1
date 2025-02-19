Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE6CC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 20:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46CA580F7D;
	Wed, 19 Feb 2025 21:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="RllO9RPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B2A9801CF; Wed, 19 Feb 2025 20:08:49 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45D0800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 20:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpB9dWzEyY9TSnwKrXw2RsvNNF6TfmjQUYAL+6ZAIZt8NysvjgO+BEbnSvzr8F2RhozUSYNuUK1poaLeTbtk7NflzBgqp6jzBk+esjBwK1sc64ce3+eeQS7neSfXBcZpvZQKXY+W3pKrdgiEH9jkKzraymqCoDlELceB/z4p9B3ib/6lK2AonstWKqNw5hMp49R62rOeAjm7J4pou+PoN34LTRMGq26CDgnTbNdJGBFNuQRY+sAKTJVW61PF+kFHOZQAef0UO0DJweYV9YtUSBkZeSazFYHfKxfxXpjYHvMpLz43/RRgYoTifXLoHx/TQ0doBDIhF5EVCU9UDLX6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZSS1/4hiyZKO1DwzRdCYYKG308f6UmYPcQQuhtCSS8=;
 b=qSdcVxFgr9KYxyMaI3XB7lHh99vnW07GmZ00imiaw1m9i3afizFR6qCcwbf81SW1zcgQPzLH1HmhKPj7YNJE0TgtdBi9nXQyc/7UDKXQH6MXpRCuwzvYDjB7IvCofMzQpSsrjkdVM+uwu7g4efR653X7FpCnzKy8tXNbWjg2oxqfzPvU4eTu5wACC9sj3g2Vimdc0SP2zNx2fsYPXFwGMaaDR6itRJkNPcB3qWSuKYF5sZA3MAH1yr2DQxZvA/KvJvoU8xr/ShO0G3TLG0PGj8sMzGG7gpgtr07uE5e+0bfA1PYv3gMPT1shsGifFCoLFuoIrM/o6oSfl+eLRpmkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZSS1/4hiyZKO1DwzRdCYYKG308f6UmYPcQQuhtCSS8=;
 b=RllO9RPccUhLX3mHpEktDh2tXF3Z/7CyqU0RzM+Uroqs4/GPaJG5VZlCja5vhhLFxkdqAQUWEoB2dWwAzHQzyO+D/qi1G9mehyvL1MmA6zLjbtFhtLrjAhTytt/gsGniU/txuCeM814cUDoPsv2TyBTlFH49QsnwJDUV7brCxbJ94HDHy4sU7hMEYlxJ7D6xl2HltzzZN6zLANsJqWE3C+iOds0z02eVjTK12wMhGrZxLB9FQSp89hRtm5bpTGqTk4aQUmHznO03/kurfGy4En8a8mFkJ0JnkPWftVhtPu6YGOnFxKQW59czREO3s8nEnvFIR/AVZIldsgrhiCFRUg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VI0PR10MB8402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Wed, 19 Feb
 2025 19:08:44 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8466.008; Wed, 19 Feb 2025
 19:08:44 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "joao.goncalves@toradex.com" <joao.goncalves@toradex.com>,
 "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "c-vankar@ti.com"
 <c-vankar@ti.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "s-k6@ti.com" <s-k6@ti.com>,
 "afd@ti.com" <afd@ti.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>, 
 "mikhail.kshevetskiy@iopsys.eu" <mikhail.kshevetskiy@iopsys.eu>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "hnagalla@ti.com"
 <hnagalla@ti.com>, "m-chawdhry@ti.com" <m-chawdhry@ti.com>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "sughosh.ganu@linaro.org"
 <sughosh.ganu@linaro.org>, "w.egorov@phytec.de" <w.egorov@phytec.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "kishon@ti.com"
 <kishon@ti.com>, "bb@ti.com" <bb@ti.com>, "nm@ti.com" <nm@ti.com>,
 "matthias.schiffer@ew.tq-group.com" <matthias.schiffer@ew.tq-group.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "vigneshr@ti.com" <vigneshr@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 10/13] board: ti: am62px: evm: Enable cache for AM62p
Thread-Topic: [PATCH v2 10/13] board: ti: am62px: evm: Enable cache for AM62p
Thread-Index: AQHbgrvpmmDClJ9xQEqkLpo1eYXIVbNO/eqA
Date: Wed, 19 Feb 2025 19:08:44 +0000
Message-ID: <47556dbc417b6ae9d5073a56b81fef90e56ff495.camel@siemens.com>
References: <20250219104831.2315464-1-c-vankar@ti.com>
 <20250219104831.2315464-11-c-vankar@ti.com>
In-Reply-To: <20250219104831.2315464-11-c-vankar@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.4 (3.52.4-2.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VI0PR10MB8402:EE_
x-ms-office365-filtering-correlation-id: efff737e-15c7-4049-7f1c-08dd5118d4dd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OWUrVnEwZFprK1dVQ2JRcTdUOUF4anlnZG54aG5sdlZ3TXdYem4vZU5yRGtv?=
 =?utf-8?B?cHRhSFhGMHBLSVlHclFDZCtzby9XWURyUmtMdTNrZkZVcHRmaG96aFl1dGtH?=
 =?utf-8?B?NytWakhtdVg0YjVuSEd4b2ZCcG0xdGlLK2xnZkdSam5hNkdaKys1UmhaYkt2?=
 =?utf-8?B?UEZMYVcxOGlLaUREY09mRlZvK2YwTWxOSlJxdnhtTXVReDBpbWZhdm5iclNr?=
 =?utf-8?B?WXE1Z2pjK2YrYzFVME1XZllPdTNTdzAyWHRmTW5rYzdGSklsbm1GWXh2K2hi?=
 =?utf-8?B?N3VVd2tQUTQvdXI3Zkg5eGdGaFMzaFY3bGRhL0c0SGw4Vm04bjRzcWRDS1B1?=
 =?utf-8?B?MHBiamVCdXY0UkdZVVA2VkRyUmREYTlkT3B4UDErMXVoYnlTWmdDV1FPVit2?=
 =?utf-8?B?eTFWRXlvcVYvTDhjMkFiZmtQOE42MHJ2SXBJVERIa1VUYkg2VjVHTkRhNTZ4?=
 =?utf-8?B?T3lTSXhKK3l3a05Hcy9nUkJyc1REZ1BhSlVOT1JyTFhCMnB6NlAyZzZuS0Uw?=
 =?utf-8?B?S1lyTXJ1ZlJqN2Nab0g4OFBNZzQ0VHJWUlYzNHdLWnkrQmRONXp6bXBDZjlh?=
 =?utf-8?B?V2dIRU9FRW1jSlBacklNb3MwNmxJOFpFdjVuK050SHl2ZFVkMmpTaG84ZlJF?=
 =?utf-8?B?VDVlZjBGdi8weVJOR2UwOWdaQmhvTEU5QjRKS09PcENuVDdUWCtBS3RYa0xG?=
 =?utf-8?B?bVhSNkdETVVvKzlyM0kzQlVOUjYvQS9aNEVGR3FjRFA2eCtMWHRTT3V2UWd6?=
 =?utf-8?B?K2hvNk04Tnk5NzBiV090YnAzQzllc2R3clcrRTIxOGVFajlDTVloejJQMkgx?=
 =?utf-8?B?OUhlU1pYMkVPdzVxTm5VTk9FQys1RlNYQlRzS3d6YkxZZC82UUhnSTJNVnVO?=
 =?utf-8?B?QzR0bExJSFdjbXVFZXljdi8yMEd2QzVBNjhleEs2Q3FydWdxSzltSEVqSGlo?=
 =?utf-8?B?NW5VVThVdy8wZnV4enhucHYvdGxncVlLT21oWEVJV0JuVFlYL2E3TWtQWDdU?=
 =?utf-8?B?K01Oa2F1am9KUFdhSVh2U1VwQTFlY2crZ2FtaXVyTWxkT3RVeDQzQ3pHc2do?=
 =?utf-8?B?SDRKaHZqanZXUmtuNlJHeXFOMnVnaE9BeUlSMUlaV2VseEh0dWpmM3hHNytH?=
 =?utf-8?B?WGI5dnBOSU5XT2FMT2VNaDFHRVFnczdEcWhZdkFtbXZ5RUVuVXB5OVBGVm8y?=
 =?utf-8?B?aUkxSTRBSEhzczB2YUU2K1ZoSWdiSHlXNDN3MmFBVWVXMFZDRGJMRGZSNzgx?=
 =?utf-8?B?aWFObzRmR0xOWmlrNFV6NDh5UXNoVm16WG9Zb3JjdjBNZCsrNXRQeE51RG5C?=
 =?utf-8?B?bjNPV3lXSm9zbzRmMXlOZVdoQUZyQkNCYm9uUUJ2Q3JTL3lyTXBNWFJzaVBE?=
 =?utf-8?B?YWJ0eTdHeHNQN2R5Y1NQeE1KVmhUd2dFdkdxZWRYOUpHaDVFaDNaNjZ0RTBN?=
 =?utf-8?B?andjaEFSVzZ2Z1BPQTh6bDAyT2N6cTdpSmZ2ZlJSQ1I1dGJHamI1NnhnbDBV?=
 =?utf-8?B?UTJVcUhocmtpL1IrR0FnR2NPYmpkN1VvVjRxNEYycTUycTVDRHY2YldwN3pp?=
 =?utf-8?B?QXA1UDJiam5CUlJrRVRpVGVhdnZrK3V1VWhqQlQxOTY3cHJEcnFPdmpTeXFy?=
 =?utf-8?B?OHRCZmo3NlVab1VKR1lLOGR0bkxZdlRibWUvWDNlYk5mbEFnTU0zZmp5ZkJr?=
 =?utf-8?B?SGJpeWVTdFhUcjN0L1gxL1NiRXNDZU1qejlDcGZQUm9tVHFWbU96enQvQmNS?=
 =?utf-8?B?bUhWS28rK2lQWW04MGg5TGhacEFPSnErSUg1ajRHU3pNaUppVW4wWmRic2xG?=
 =?utf-8?B?QWhXM2Z1QXJiMk9aVFNrTmY3d29PY3h0VG5GTEp0V3lsZDlPQmtzNnBRdHdr?=
 =?utf-8?B?dG53N0tCY3RINnhJYmlmbVM3R3JzRDlzdVBJVlJXbUsybkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXlVOVZKVWdLKzhFdTJYaDZGZVp2NzNYMzVDbGNHUlhHZDN5Q0M5a1F2MndC?=
 =?utf-8?B?VTAyREpVdHovcUFGelJ0TTNOVWhtajRHMGpscElCK2EzZWo3NU5VWCttK0J4?=
 =?utf-8?B?Y2doRVRtODFhYU1FZEpzUy8rS3dBeUV2VWdqZS81djFhRG9rWVJoVXdDR3VL?=
 =?utf-8?B?L0JId1NXNXpyWGxSbGY2QTBxcVpGcUNzM0lsUks0Nkt3SVdKQVg3QU5UcFB3?=
 =?utf-8?B?TWt3MmR3NXkyTzR0c1hCV3NLR3c4UXI0VGdtTWMyWG5iTjU5TU96aVl4b3Y4?=
 =?utf-8?B?bnZkSDVSU0tITWhyRDRXbjZDMXc3Ulc5b0FaNWcxS2hLUE9DcURVcHVoZzRa?=
 =?utf-8?B?T2hiS0RvZEp4VEpOeStUYU5GUTNNbTlYUHZjQ3dickpqMEYxK1B4RG1ONkNK?=
 =?utf-8?B?YWhzOTd6NTVUNUZSOVdRTFl5d2J4VzdMTGRzWm5LSi8vRVJxVFdOTzlGcVQ5?=
 =?utf-8?B?QzQ3d2ZUNDRQaDR4eWIxT3dibzBDMXBEb0RCZUtLc3dzZDE0QncxV1F0a2h3?=
 =?utf-8?B?MUo4bVNkdHljcC9jMWQ0K3lhUEhTVWZWak9JZmZsRFlHY0dSeEh0VzVoOGRn?=
 =?utf-8?B?aXJBQzVXeE9mMW0zTnFpcjV6UHJMY0FXS1lEcEJzLzB2NDh0eTlNRExtd2Nv?=
 =?utf-8?B?TjN6eGxidE1pbE1SeUhibmRyREoweFlwQVRsV1gxQXNGUlZuc0V5M3QzOEF6?=
 =?utf-8?B?T2t3T25RZGVsU2d4RFhPYkN6MXNSbUhZRmZ6M09wYUJhditKSy9PbXh2RWhX?=
 =?utf-8?B?T2lZQzhrTUhlT2tzblBnN2RFaVVsek90bDk4bmJ2THJBbTF3eW5XVkNJclZC?=
 =?utf-8?B?MXRmRDlFYkdwMXZhdzk5TG9Sb3dlbGpNOHJ0R3kvWmwvNjF2UEwwd082b29s?=
 =?utf-8?B?VWRkbUo3SUNJZENLaFIweWFyc2xJdSsyeVFnTkxIblpYeFJUUWhRZUU1bmxH?=
 =?utf-8?B?aHRKTDV0Q24vaFp5dGxrLytiblhQZjQwVm12Z3o2VHlEaUlnTE5HTTNwZXli?=
 =?utf-8?B?ZEJQaXc5VHUvNmhYUFRHMGZyTUc1K0VQeEJObGRkSEZkNGFDQ3pNcHpGUDdq?=
 =?utf-8?B?TktlQjN0dTNaZURKa3NzQW9HRUE1OFlLenJ4UEpRdGp2bDJ4cVc2OTh6czM5?=
 =?utf-8?B?ZVJkVzhVck5JU1YwMTh6N0xKZlp4Mlp3dWkxVXlQK0oxNmt2YklkcHBGb3BZ?=
 =?utf-8?B?aFBFTVJiSVdZS1FqZ0NmcHROWEZUZnNxRkdQMStmamFqMms3WEtMMWltaU8v?=
 =?utf-8?B?L0pxYTNabGlUem5aRnBRVkF4YnBBak5JZHJ4bVRWUWtYalBBdVhDTktCQkdS?=
 =?utf-8?B?V2JaSGhXSUJHMU5iOFRRcHRnMUJyVlhxK1FEeW9zNEQwUERQcjRFaDZHa09l?=
 =?utf-8?B?ZmhUNlFLWW1UVUNsNFQ3NG5pMFlFUm1xT3FIcXo0TkJHMnRtcDFXVk5Udk9n?=
 =?utf-8?B?R3k1WTVtRldxVFlmbFdwT015Qms0eGZGWm11a21zN2tUQ2tzQkpMcVVSbHJK?=
 =?utf-8?B?V1d1MWE0d1R6RVZWbVhFNlZmMUJqeEw5K1BVdFFPRFRnRVBRSm9CR04rQlFj?=
 =?utf-8?B?NjgzS2QybTFBb0hlQTBzVDJicnBTSFBuL2NlRjJ4Zk5tQ1lnSFc5QzRaa2w5?=
 =?utf-8?B?cVd2ZHpiL2R4UTRhQWpWZlJHVCtOWmxMY2llc3JJNHBuSzJKalVuSlpKcmRI?=
 =?utf-8?B?QmZLUGNRUC83S2Q3T29HZmtjbkJJcmp2QUZtTEcxSW81QWI1V3FxY2I1ckhr?=
 =?utf-8?B?UGM5UkxMOStNL2ZzUW9VUFVBSGFjVGVhWTNIZkhWdWtRZVo2aWE0TDZkUnBE?=
 =?utf-8?B?UUs1V2R2UFZCWjFQbVRTVkJwamMwMXBzUWplOU1KVmM1TDNyWmZFQVZJQjNT?=
 =?utf-8?B?d1RnUlhEenB2N1BQQ0h0UGRoVFlmN1BYWnBjSkdqNVQ0NmtxOU50OEMvR0cw?=
 =?utf-8?B?Q3JuR250OHppdVlYUndaNmFyblExNDdPTzVZTFpXUGthUFQ1a2ZISmpQcEhW?=
 =?utf-8?B?RGU4Q2FORUtPMFFxMnVHa0kvM2lNd2hqZjNJUkluYUE0UWV0R0ZrUTh5VUxW?=
 =?utf-8?B?Z3Rmb3R2Z3R0V05nekVnWXBzU0VQRHZzNGpqeUdTcittMXJaYVgvNG0yM1hi?=
 =?utf-8?B?VG5YVzdOSnJwdnY0akRDV0xiYmZjSWVocSttZ21vUm9wK1lSdDZzRDQ5TnFD?=
 =?utf-8?Q?PE07Bi+DPQ1k0Wet6sjoprg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90C15C5B317BD94A9C2A5DE899383D37@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: efff737e-15c7-4049-7f1c-08dd5118d4dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 19:08:44.8609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dV7xsH8a7wrU9c75PuwSYn6HjDTbtQd4da4wV+ERSzO3jn/3PpkZiJOWHyfKfd4QQvcsRaGXX8DaRLdqrXJZp23N4vnSURUQ9M6J7uV/RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8402
X-Mailman-Approved-At: Wed, 19 Feb 2025 21:04:12 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE2OjE4ICswNTMwLCBDaGludGFuIFZhbmthciB3cm90ZToN
Cj4gRnJvbTogQW5kcmVhcyBEYW5uZW5iZXJnIDxkYW5uZW5iZXJnQHRpLmNvbT4NCj4gDQo+IEVu
YWJsZSBjYWNoZSBmb3IgQU02MnAgdG8gb3B0aW1pemUgcGVyZm9ybWFuY2Ugb2YgQ1BVIHRvIGFj
Y2VzcyBkYXRhIGZyb20NCj4gbWVtb3J5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBE
YW5uZW5iZXJnIDxkYW5uZW5iZXJnQHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hpbnRhbiBW
YW5rYXIgPGMtdmFua2FyQHRpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxp
biA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0KPiANCj4gTGluayB0
byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDEwNzA5Mzg0MC4yMjExMzgx
LTExLWMtdmFua2FyQHRpLmNvbS8NCj4gDQo+IENoYW5nZXMgZnJvbSB2MSB0byB2MjoNCj4gLSBV
cGRhdGVkIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4gwqBib2FyZC90aS9hbTYycHgvZXZtLmMgfCA4
ICsrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2JvYXJkL3RpL2FtNjJweC9ldm0uYyBiL2JvYXJkL3RpL2FtNjJweC9ldm0uYw0K
PiBpbmRleCA3NTM1OWZhMTYxNC4uMGJlOTgxNzA2NGIgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3Rp
L2FtNjJweC9ldm0uYw0KPiArKysgYi9ib2FyZC90aS9hbTYycHgvZXZtLmMNCj4gQEAgLTksNiAr
OSw3IEBADQo+IMKgI2luY2x1ZGUgPGVmaV9sb2FkZXIuaD4NCj4gwqAjaW5jbHVkZSA8YXNtL2Fy
Y2gvaGFyZHdhcmUuaD4NCj4gwqAjaW5jbHVkZSA8YXNtL2lvLmg+DQo+ICsjaW5jbHVkZSA8Y3B1
X2Z1bmMuaD4NCj4gwqAjaW5jbHVkZSA8ZG0vdWNsYXNzLmg+DQo+IMKgI2luY2x1ZGUgPGVudi5o
Pg0KPiDCoCNpbmNsdWRlIDxmZHRfc3VwcG9ydC5oPg0KPiBAQCAtNTQsNiArNTUsMTMgQEAgaW50
IGJvYXJkX2luaXQodm9pZCkNCj4gwqAJcmV0dXJuIDA7DQo+IMKgfQ0KPiDCoA0KPiArI2lmIElT
X0VOQUJMRUQoQ09ORklHX1NQTF9CVUlMRCkNCj4gK3ZvaWQgc3BsX2JvYXJkX2luaXQodm9pZCkN
Cj4gK3sNCj4gKwllbmFibGVfY2FjaGVzKCk7DQo+ICt9DQo+ICsjZW5kaWYNCj4gKw0KPiDCoCNp
ZiBkZWZpbmVkKENPTkZJR19YUExfQlVJTEQpDQo+IMKgdm9pZCBzcGxfcGVyZm9ybV9maXh1cHMo
c3RydWN0IHNwbF9pbWFnZV9pbmZvICpzcGxfaW1hZ2UpDQo+IMKgew0KDQotLSANCkFsZXhhbmRl
ciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
