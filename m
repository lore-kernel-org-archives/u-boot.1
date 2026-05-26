Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C52CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692F484702;
	Tue, 26 May 2026 14:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="UKdqCl7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44147846AE; Tue, 26 May 2026 11:37:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09D280433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 11:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzPFXajvTs3VkMCvXkhuuSeOLVkjLzHp+EOsEZYvfGtxmZci+3RpQOJuvenM+nQ7y/N3pqT4QfzofKFjqdVjzMWdisT4jmFffb4aeuhncEC+VzdF0eaivVno1GedZOlgF3+6ybDESUneg9aTJCr1f3b9ohR4ffCxesfu4P8L4tZ0jgWVrAIdG5dmVEZBGzuZQGTW/ukOcFpdMHvw4mEad/AkyfD4v/qtsWpVgulC4t5wr6LfASdTrKZVI3uHeLyPe2M25pVsJZSrwmN2GUxWIfaAh47YvjPw5Mo+4OkWBAQluM0EhoXogSARNAl4hrCsQwbqr01+PLHy9PUO3sBhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFWLfTbtB8m0aJNfbUmASq98wGd6AOdj6h9etkCL750=;
 b=jsgxAVBlJUjfM2671gg584CFjg2ndZXs7ZKQM65xMRS9pYFe9UeS3C4DqcCM9YMqJKNPv1+qNTCd/ChQtp8kkhRD9zCxuyfaJHshzDoJP/BNS5QljDQXrDbEK34cwvTC73NDJFaLmGpAgvTsacBooV8aisBXHEyG3Ra/B4puNOzm5zWKwu/o9x0DsKn0++xFDgSCW1FfH1DDznW2CPa5Mu+LvaBwiIF0oz8PbmzoMyrwXbsiTPt9iqO58W/Xxh3MAbY+RnxWJ+QGlc5soaaCHrHju6+t0rmJ82g4AI8SnYXkDIlufM+12M30huQQZxE9y/Q+K/miX4kNPPJN43ZtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFWLfTbtB8m0aJNfbUmASq98wGd6AOdj6h9etkCL750=;
 b=UKdqCl7f1ACDonXjFkGL+LnI3Q9F+M47mhOlNGNfHWWb4i4WarKFesafJNLg+joCkjG5m1IJeGnjeI51qowg9QTWfwnADYXmPn5ucbt6GWqewWFpjhQ5dNcLgeyaQVEM50NNC8FB4kZM4T1ZSYfSx6BHYNzBR9Qh8zPWTdeEgVPApjcCk5zEekJgns4uFkgMKnIPrZ3ckGKcU2pcyyGwp+XRuIDieUZdqGM7jidCG5OrWKY6ax9zX5KnxkuM5jmR4oxFyYEy1w2U5+JVeQA6V/3LsOFpt42G4ezzjgp9g15ERWT/2sVJDFQ5EriZNA+3sr+M9OW8Mt8p0wwUCfXcmQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by VI1PR09MB3677.eurprd09.prod.outlook.com (2603:10a6:803:13e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 09:37:14 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 09:37:14 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Liang
 <ycliang@andestech.com>, "rick@andestech.com" <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>, Conor Dooley <conor@kernel.org>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v7 00/07] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHc7PM8KdYHIzEjA0am3CblXktB+w==
Date: Tue, 26 May 2026 09:37:14 +0000
Message-ID: <e3146393-f4b3-4ccc-b85b-2ed6aa49810e@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|VI1PR09MB3677:EE_
x-ms-office365-filtering-correlation-id: 7fc4652e-0c36-4fda-fb04-08debb0a5e86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: WM8K+RWZ3pE1T4cTGkddAQNdbTxf7HSEEdGUm5YnHBxYqSXnmNt1fZgAwwOfNJijsIvbKHY8HhyXRB3CGWY585FlfSUnLzWM6kuA8r9LrS0aj/dFJGAqCMqltv4WXJxtcHMHvvcNVKQlSyX28cj98FZLI+k2409ToDBO3vq2gX371ikkv02HfXT+vb3Fy4SI+qgPfEQUKMmQ4Zcy/PRt1tr+40T717WQ/K+qNRfk3j7OZcCfzxLJMXQYV7+0laZFppalGUyz+B+vnM3B09g85Q19dDmg2DSzRQ8NlR+TKviwYReHHJybYjCWcjBBitvDJ06/6sasfg+dFhn2DkSr6UFVh0MSwK2BhEmzH6/1MOezktbYw2tNMHStIZ1153n0pYVXS+b2rHWTj11wK5o0V/JRrFLMXOpB8DBOZgpxFJqTzP+5yd3A5cMt8wgJgDlRs+YqyoaGgAcRSgn3SOi1AB3/uuqbpKXOqFEpHJQjR+wi6C+HExI9AvnrbTBAcHeEqD0n4IA+O8Zsfeyk1cZ3ecvVvCmH5kyv1huYh8QtQtDtiAIIm3apoAXTGosO9Be/qKpZ4zjCp+jxEGkrHDVKuLbt3B22Z3Uu4LHKqyfOIi+T1med42EsPFR6tbKRwsjNZMygvtxQcpeqcOJvS7R1ZMxB0F09WFmkcNmh4FU79BsYYfSQtzlePs7svzI5+jmOxoX5gw1TCQGILlRX3iDbHmCFT3WS/Mxgvkic4wEdlQ5vMTk2JDfUhg6gp7n6M1E1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2FhcVlobHNhOUNkSlN1S0d5NHRpaWJIS3JGeDZnQXI5dEJveVVodTVOVmxS?=
 =?utf-8?B?VWtIbFpxOVRWWlVqYVdSMzdKWXBEdUJLYTAyKzVBeVhjeUdCOGc4MmJLcktQ?=
 =?utf-8?B?dWhWSFNsWk5lVmh1M1R3U1NiRlVoLzIveWhady95anQ3Z0VrS2V5Zkh4NHB4?=
 =?utf-8?B?TDN4OEJTOCtvTVZLNEwzTm9uaHJNUjVtTmJQSmxsVnJmTzNqOUMzZDlPSU5u?=
 =?utf-8?B?ZHZqQVlKNzlKbGNMRHJEc1Q4V0JFdXlXNnJnMmsrdVc1ZE5zb2k1SGswck1j?=
 =?utf-8?B?VVgyMUJldFpDd1E5U2l3VHVJbDljbzRLbDhCZ1Fya1NqZzFXdGszakVmL1ZR?=
 =?utf-8?B?dVJ0Skl3QzdhdXNSWEVQY2FabGh5enhLUVVPQnVKR0s4YmtVcXhLd1p4ME9r?=
 =?utf-8?B?bU5XOGdTUERXL3p2N3BGMkhTNVREL3pyamVtY24xeStWa1lSNWw2VGIxYzFm?=
 =?utf-8?B?eTJxcVJZZHlXOWVleVlPWkNYdk44MktCVEVQSWkrNk90TFBxTHhYKzV4Y0ZM?=
 =?utf-8?B?L2ZrMWpTMFdJeUQvUXhkdVBLNWl3UnlMUkI2WmJxdXJIQVQybDB3OFN0aCt6?=
 =?utf-8?B?Qi9sMjR4TnVSNFpiVFZaZ3FBQUVRczNQSUdZOW1TR04zeklMNHV5NHgwS1Fa?=
 =?utf-8?B?OVJvVVRSSWVRMnJHbGdMVkhndFdyZm56dTRBVGJMbWcwak0xYkFiZldXdVRx?=
 =?utf-8?B?WkoxZHNLY21DT0xubkdUa0tuU2lUREtVeEd6ZDNSOUg1RVlWaC8zZGVvcUZG?=
 =?utf-8?B?NTVZTGFjV1JmRGFGZ05CbFpXdlV2WGZIS1lDdUpwZEVwbEhsSTMxK0d6SnAv?=
 =?utf-8?B?cms1Wit4SjQ1dXZDTXdhRUpndTVhd1hXd2t3MGlPQlM4SmY3TUJaYXdJRWZu?=
 =?utf-8?B?V0Y1Z0YyV0NFQ3YyYmNsQVJwdDdqcVQyMTdhdFdpMU9nRkp2NktKQ00wMDBP?=
 =?utf-8?B?K3pXaUcyOHU2dEE5c005QWJMQ1F6aU43QkZqMkFxUWN1dTlhMTUvQ3NmT0hD?=
 =?utf-8?B?ZWhjYnYrQmovR2NzMW84dUZzMWkwTTc1WUxQVUtyL2t2a2pvcWR3dTdTVk5U?=
 =?utf-8?B?RyszSzc5NmZFUnB5RHJ4aUYxWWpYQzhzakY1TCsrOU56Qnd0RktJVStXK3ZX?=
 =?utf-8?B?SURxaGU3UDltazJLbUk3L0k4TVFxWmlScDR4ektQdHBLOGFWbnZpbXIzMG8z?=
 =?utf-8?B?cEV6a2hKeHFPdVhpQ0J1eTk2aGg2dkFoZm4zaWVUUFNPSlNWandpT3BqY3dq?=
 =?utf-8?B?aDhVNkx2NDZaYzdpUFBvbnpkQzlVcTBvMFBBdTJJQ3J1a2d0SzY5cTErWkcx?=
 =?utf-8?B?cHcyYklQVytrOTZJVjRxdkN0cUlwTWZrNC9ZYUN1Ym9qZ0E2bGt6bCt1K0Rs?=
 =?utf-8?B?YzVRTnNmampHYTloVlNEWGJrVVRmRFZCN2xEZUllUE83NWJiQ3RWTXNsZ3VQ?=
 =?utf-8?B?bEpENldSWmxoSDRBWTZ0UnVib0tDcjFncWtJd255a2VWdzlHUkV6VmdRRDQ4?=
 =?utf-8?B?UG1kdEplWHcvQ2U1NEc0LzVNVE95ekt2YUxLWWRiNlhGdXdXdWJLYkdNYjcv?=
 =?utf-8?B?cmUvZlFuZ3dhV1R0MnJUcEJPU2dhZW5ZN3lNNVlGM01lVUovNXdqbkIySm1H?=
 =?utf-8?B?TWhLaGFqSFFjNXh6ODg2V0hEeHNKWXk2RXErZlFsM2dOS2hHUDBEcjcrRW5m?=
 =?utf-8?B?alBHNm9ZazE2WnJBdlVyaUFkYWxhcjZxNWNoU3ZzOFRWYlpvUDRFYi9RQ3ha?=
 =?utf-8?B?YWJXNGh2NEFjUUo3L1BPSll6Siswamg0MnNKVjBCL0JVVlYvQjdOY1lWSGNr?=
 =?utf-8?B?Qng5WE9ndWdOS0RuMWxVSGFYMDBtbTRNTXlyTU9CeEwxNTJCV1FKMXh5ZE1r?=
 =?utf-8?B?N0VXMzdIWmxSKzVGQzBEOWc4MHQrTU1oeGRMM3ArMXJJZE10MW1CZ21iNGhU?=
 =?utf-8?B?d0VHSU5rcStCeUV4Vk0zYmcyREttR2N4QlFoVWxjSlFKeTN1VDlPMXJ0cStr?=
 =?utf-8?B?UGsvTUVreFVLaFZIVU9OR0ZzdWp0YmpyblI5TUNmZWtxK0hpZkE0WmQzeHJ6?=
 =?utf-8?B?ajRNNFRMNVhvelB4Vkc2b2F1WHZuSGdKTmM0ZjFIdldKYXcvaWkxS0NaS1NK?=
 =?utf-8?B?b2l0N012MDJ2V1BJNWhrRUh4ZkxaMlYwSkNadmQzNFhkL1Nhajc4aHllU3NJ?=
 =?utf-8?B?Q2JiOVkyblBobjdZay9QMndoam5uUEJLajloWjl1QlcxWFdTeEhneXh5Z2Nj?=
 =?utf-8?B?Y0ZvUlFaQUcvKy8waWZocHZIVDFKQ0hxYXRESmluOWk1dFAvK2U4enNjd2pL?=
 =?utf-8?B?VjlpZ29CSWg3K0dUNzJZaGNyOUlYS25UanZIeWdxVmp6dXpseEVSSlQyTGJm?=
 =?utf-8?Q?GrK8cVu0VtQHSh44=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C4C59DC5BFCCF4BABF0BC12E55913FF@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc4652e-0c36-4fda-fb04-08debb0a5e86
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 09:37:14.2817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alVdLcIJyVZcaR1yrNS8oMBXDC0ykFJ+y/9NTJW/7OKd5HS2hQFs1R3tMzVRnOn6vluqbJNSiUhG66a+uxIyGi6fe9blsJxeSUR52avaDa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB3677
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
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

SGVsbG8sDQoNCkkgYW0gZm9sbG93aW5nIHVwIG9uY2UgbW9yZSBvbiB0aGUgcGF0Y2ggc2VyaWVz
IGJlbG93LiBJIHdvdWxkIHJlYWxseQ0KbGlrZSB0byBtYWtlIHByb2dyZXNzIG9uIHRoaXMgcGF0
Y2ggc2VyaWVzIGFuZCBtb3ZlIGl0IGZvcndhcmQuIENvdWxkDQp5b3UgcGxlYXNlIHNoYXJlIGFu
eSBmZWVkYmFjayB5b3UgbWlnaHQgaGF2ZT8NCg0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L3Vib290L2xpc3QvP3Nlcmllcz01MDAzMjkNCg0KVGhhbmtzIGluIGFkdmFuY2Ug
Zm9yIHlvdXIgdGltZSENCg0KQmVzdCByZWdhcmRzLA0KVXJvcw==
