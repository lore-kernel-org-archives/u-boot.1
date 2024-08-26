Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30928C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 12:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B95884C3;
	Mon, 26 Aug 2024 14:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Tabkmh1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F2E9884C3; Mon, 26 Aug 2024 14:32:48 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1010188297
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 14:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZb6h4rMYxF9EblBFkku6Y0EUDCajAqGuWw9NzilVAIdNF+RdmiOqE/vhaHBq9kpA1D4SsN4Dgd6ntLukq6ZvaoeGNHT27T257OuKD0FiF0DcxtgYUKJ9PqkvstmcgRO7SQshZ15S0xhVWE48BX8tQaZNaUyQJ3RfXDzjexhPTX1qSC+GPG55nvtg9wjsIRDd2p9Y4rhsc6HNpWUwHIbJjxQZHaCiqquYXjF5fQtBF63DIKbdGRJ7kCY3L5x24Xcf6vG1pRzqUur7Akmt1krJzDbtoom3PGJWRuDI5Velq/WQw4sI0A13vANB/C7Sm5j7Dp4eBxmXb2vAMTBDOhZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KVXgAwNOr971k9i/Rz5MDqbD3fGoiAsjtpjhHIQfFc=;
 b=GZ7FsMQOBnDWrOitgIhXh2cWEekYE7yMdaIM6ym0AEH6Qp7Y8I+sszY8vnwv2olL9NJQg3rVc1oVJNa7rLZ2mj5Qx8Yn4AxL3USs8ovoIzZcpmp2zL99hheDNAYg6TNBt+zVRgllQEzmVObGOPdS68q33PX6DlWCWUSloNPzN/owte/55cJi6Vu+87pen0dhmjGpTNGEww5i4OsnLG4hUhbtt9BjZp4WfEIMXQhPMBwS/OwO8P8souLv27dKNnjK6NuX/L6tx+BYsSD1jEdm5ySddNugG7eswxUSSE+uXsNI5XkvyL8QZChitON0gZ34sMCmMY/FXqYRkOsrD5au5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KVXgAwNOr971k9i/Rz5MDqbD3fGoiAsjtpjhHIQfFc=;
 b=Tabkmh1siLcseGUivPdjYNZy/otKvKUwgkDFYiDkplzBbiue2ubTqJETeNXnM5awTXPuMoVEIIuHGAbYFRPnHV1zsDLW+WvtEk78qiiilSNXnis0cbdWhxfALm5VfR+nh5qtkNcq8EIt5BCegscFbT1lGMyT7SsaxuN5+ApI6IxagAe2gfplErT+ifjzIwXRuVN15fs8HJl1jk3DPLDoICXmScM3UiMO98WZYRNjHVhxqGugLTVThv+V46SyCUhqWco3d/hHE3Cd5gKBTwlZZvYfYsFx1G1jr7jZiPaHSgM/qc0e54Dcb7Y2FITQ15oGbUY7q91Jf8Qz7lFvnRmOFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 12:32:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 12:32:44 +0000
Message-ID: <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
Date: Mon, 26 Aug 2024 14:32:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: d89bf18c-9606-4bfb-1944-08dcc5cb2f54
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXJPTXg5N3Ftb1NHZ29kQUtDUzdrMHU5NElGK050R3ZEZFFwNVVrNEV4OFov?=
 =?utf-8?B?Nm0xUXJkdFJqbCt1MjNGNC84NEhkTkdveGdqT2NOdkY3VFlGZFZXYmQ3NnBJ?=
 =?utf-8?B?UXUzaHpLTSs5QWlYMy9JVEZwcXRYSDBFK2hxWUthL21wRU42UWk1d1pGYUNY?=
 =?utf-8?B?TEIrSWhtOFJqY2FSaWltTG53Y2x3VHhpTllXakVPd3JlY21rajB4ejNZUzdv?=
 =?utf-8?B?L3Y1M0pVOXhrOGt4TWVXWGdCcHJQQ0kzMkdNWDd2eE1kWmpPekN4OTBMOFVM?=
 =?utf-8?B?WEZlUVRuN25FNisrK0M0bkIrR1NaQVdYNlJCWVE5UXFUMW43dEp4a3hZQld5?=
 =?utf-8?B?RHJlQXByelBjQmp3eUt1Vk02aVNKNkJLRWZHeE5IVmc0c0ZZYUlqS09DMGNK?=
 =?utf-8?B?U1JrdjF4UWdjdnV2SzlGNG1sUENVdEl1WFVoZVk0WXlqdTFuVUdpbWpVUnVU?=
 =?utf-8?B?YTlRY0RCaHlDUzhzaHFYQTBGWFRJdHgwdVBxTEhuODR0OEdoWXBZa1RweUd1?=
 =?utf-8?B?SW8wZ0U4SUxOd1VTb1V4cW1kOVF4K25jeFIyR0tBdWdOclJ6cm9nQ3p0VlI1?=
 =?utf-8?B?VFRWNXV4bXVPSTF0aUhqZEdvbTZDcVM2ZWg2VFBUeldISFo1ejg4NTBmeVRF?=
 =?utf-8?B?Uy9EUHNFRDZMMU9Sa2k5NjJQMk5yTnlpWmkyR28wM0toNmxPdndrYVJmSTRt?=
 =?utf-8?B?aGFmODlpbEZBWko0a1ZHaklYUXY5aW5NTEI5OHNNSmhLVjM1TjBERmwzRDBa?=
 =?utf-8?B?OWVoM2g0bTRQZFphdVZKNHQ3TkNoWEhpUzlQMmNWUWs5OUZrV0NzaU8zdSt6?=
 =?utf-8?B?L1JBejdqekU5ZG5NWUhBR01kbHdJeTlJZXJLdXRucGZRejFLSU82N1EyM1NO?=
 =?utf-8?B?MWxRU0RCMjhUUStYWmNTVVdTdHN2Y282djRLUncrVkVaU3ZYTkhlQUwxd3Yw?=
 =?utf-8?B?RGxUbzhkb3VEWU84QzhXckFrS0tDbUJTWGpkVzZGNjhYREEzSHg3QStpN3ZB?=
 =?utf-8?B?TkZ2NTB1S1ExOWlzV0tjbzdyWjl6U0k1TXlwbkpUbzZvdWFQRGFtZkMzN1ZF?=
 =?utf-8?B?eVJEbyt3WXZITXZxZkFtZitjcHlLRnB4VWphaXlrbFNmaVJLd25xZkU3MUhh?=
 =?utf-8?B?RUE5cHh1NXU3clJVTXNFOENtMG8ySmhjZ2c2b3JYK01kUlNJMUkvMEdJN1Bz?=
 =?utf-8?B?aGdKUEtHK0Q1dkt5U0hwYjA1WVB2eHk3NHh2dldod2M1eG12b0xhZUlQUzBz?=
 =?utf-8?B?ZnMzTi84ZEJyMWJPMTNNVm9nQ29XdkNBZythbGlXUUkrVUFrUjZtdTI0SUNi?=
 =?utf-8?B?Ty9GM001VDRaYUwzUUQ0L3JYUHpvaThVTTNNMkpPTVhsWWNZZzJMNmdBL0s2?=
 =?utf-8?B?VC9peW04ZjlwOFRnbEhtY3JpODNSM1NONWVhdjBDaGJ2Rk43Ym52TXpDdHUr?=
 =?utf-8?B?Q2tiazdEeDIzcnZGTHJselRPNUY4L01sTHJBS0NmaXhLdC9ZQXhDTlc0OXRX?=
 =?utf-8?B?WlRZNkRWbjRad1VFTkp2UFFHcEdQWnVTVzdxWVpRWkM2Z1JGOXpEcXFOd2Ur?=
 =?utf-8?B?SG8vcEg0VFdLbmFRUXdIOWxwdUx0V2hqSjg2Y0FZUGVIOWVpbDBsekRndTY4?=
 =?utf-8?B?cmpTZm5ZaTJqTHJIYjJKczl1amRMTzRNM2ZKeng5ZGlZY1pmVW5xYml4dDB6?=
 =?utf-8?B?c2s2bElzcVp5NDlGTWpCWFBPM2F5WjM3Z2JIRy9ibXpqRVZnS2o3MGNtSU0r?=
 =?utf-8?B?QXdLeTUvYWI3RVhtcWlCczFRWjM0cW1mTTBFN25CUmZXZ1RKK3ZrU0Fhc204?=
 =?utf-8?B?bzVQRjh3a0FzVTRlS28zUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNGaUpXZ2pxOU0rU3RIMHRBaUNibm1TbkJPYU12dThZandkSHlOR0d4WWlT?=
 =?utf-8?B?QVE3RFdxWlhxRi9hMmxoWDZ6NENvY20xUk1PdDVQUUtkbkpMNXdwTjBmN1hn?=
 =?utf-8?B?U0M5NTFJSEVUK0VsT3dvb28vQS9nUVAwa21jdCtBMFAwQXk2QUFlZUZBbzR5?=
 =?utf-8?B?SEQxU3J4NThOYWkxUEE5Y2FzbXRpZU0xRitPL1BvbDBWeVNzN01aZnQwVWpu?=
 =?utf-8?B?MTFYcmJyS0c1SHltWGxPYUhpWTJUeFc1dURidUFCRHNhekFmb1VWR0orSEow?=
 =?utf-8?B?djZhV3p5cjVDTW9yTEJYeFlHTnFzVytIL0ViWTR5ZFFmRTNQR3Q0bjhsQ25F?=
 =?utf-8?B?RXlyN1JYTFA5aXVYcTdQcFcvNENqL2ZDSTJ3dHB3Tm5OOSt0MVdtQnpIUnc0?=
 =?utf-8?B?V245MGYyRFcwMUZheHVIeGljMDBid0VXS3FSOG11aW5BZk5TaW5nVmdPM29w?=
 =?utf-8?B?d0VJVXJhSnZ4Sm5wNGxSSCtzalZjUW01RUR0WXUwRUd0S2prSzY1b0k3ci9m?=
 =?utf-8?B?RUh1L1NmOUJ1MW9hblAvSityd21JbWRuR0Z2NFZaRURvbzFPMnJ1T2pOTmpm?=
 =?utf-8?B?S3dKb2dLckdRL051bEw4YitpZzRTY0hnOXpSRExuVHZDcVBOQk15Tk1QUzRV?=
 =?utf-8?B?M0xoeCtDdVpSbFpZa0UyT2c3U0tPcjA4VWl6YjU0Wjh5djYvbllaKzJ1TUhx?=
 =?utf-8?B?UmlFYXpvWlVuREVlTjdRSjdRcUlXanVRMVJPZ2pHRG1oK2lUeFNid3J5aTVO?=
 =?utf-8?B?QXVMNm1Qdis4eU5jRUpTV2RucG1WektaR2U1YjFpdExOS1JtRHMvVDdRdFFF?=
 =?utf-8?B?emt6MjdvVTN6Qm5INWdRV1lOWDVBQUZmNitlSW1kem5nWWtEcWpuZFkrMTdF?=
 =?utf-8?B?Qk9LN0Z3d1pITTlKSTJNaW1uZEZYSnRNbWtSeXpKdDhrMFN2b1VlRkVHazIy?=
 =?utf-8?B?bVRSY2pxRWN0cnMvMzZyNUlRaFRSNjYvN3Rla3lMaWtLWDZZaVB2eFBWSGo3?=
 =?utf-8?B?N013ckxFODhqNmUrdi9WY211OFFmeHNVU0Job0hXOHVmelIyVzZPdUlEZUNu?=
 =?utf-8?B?Q0l5bkN0ZjhDVkcrN1gzT2VxVjlnTTJkd1NZWmp5QUVKT0dpVDNEWXVNSzRz?=
 =?utf-8?B?MHM5NkQxS2p5WWd4Mkl6NDNhaDNzYVFiR21wU21veWdoeDRtczllenQ2WTlH?=
 =?utf-8?B?Zk1EY3oySEE4a25lV0lwRG1kT29OQTQxT01EUnJuaGxnbjlvTGk5OTJpUHRL?=
 =?utf-8?B?U2czVTNGNFp6YUpXWkRaYXJvYVZaTEZzWTJvcVc0bnJ5d211WU91eEFGU1gz?=
 =?utf-8?B?Z3ZLazNtNVYyTzRLRGZtR3hwTjU4cCt3OXUrK25iNFppRW9kYXhkc2hzenpi?=
 =?utf-8?B?dC9MRy9waHVUdTlCY1FBWnFmaHF4U3h4SVptS1ZrRUpvMlZIMVJVd2U2aHBh?=
 =?utf-8?B?a2tCaFlvNnhkRWRyUkNaSlVkL1dQVHNlemRtMzJCMGxJMkdpZ1hYd2tndkZS?=
 =?utf-8?B?RitubU5RUXVsVEFHZjQ0RFZxYjdSRnlhSEpsT2xLVi8wSk5zTWc0MkF4OTlC?=
 =?utf-8?B?alRHcFRCWTlNQ1dudER4WENEUjBSTlR0ME8vNnFoVFZGM0JuN2ZxN1VzVlpa?=
 =?utf-8?B?dFZCcmd3WlNIUUZ3TzROdUk5NXhKRm5mNmwycEVqTHI3SFdpZkxoQ09xZDI5?=
 =?utf-8?B?bkpna2xCbTVBWHE0eFNqWHg4Rkh6T1QvbWgvVTFGZTFDOTB4T0tZcFlWSzg0?=
 =?utf-8?B?aE9HeTQxbllLWHJjNUxoZjdTMjQvc1ZjdFpjS01hYSsycDAvbVJQa1FWTUZx?=
 =?utf-8?B?elhVcXdZYVU5dFYzdmFCWDBWWHpOQzdxcmhkQjROQjNobjlRSDhYRXp3OGZP?=
 =?utf-8?B?bGZGQ1daOHhQVFI2dXNxclVOemM5dnZOeGZyNGV1QThtQ09WZmFiV3FEVVhn?=
 =?utf-8?B?VWFFOUxBeC9IelJZS29CRzVBaU5idUFEeEJQdlBWVVBuWUVXVG9peXBNN3cz?=
 =?utf-8?B?VTFYdXRKU24wb0swZGIxNnl4RkV6R3JkSHExWlBIS3hFL2ZPZk5keWsvTUZp?=
 =?utf-8?B?Q1JrNWVBVFhqREtTZEhxUzJuUFNEcTFHMjNIbm1IbjRISHVDVzh1ZzBXSnM1?=
 =?utf-8?B?SjQwVnZ0ckJ5ditQbUc1akMwYmxmZ0Q2Z2tQMmpCZnd4ajZQVGJuMmZvWFNM?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89bf18c-9606-4bfb-1944-08dcc5cb2f54
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 12:32:44.3800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rPAdRlWR8oqeEB3+LIauEdKFjvD6IRJ8I6JbdX+lVqqesvAuCOisYjEI+MSii1KnU4E48S1fCaA2F7i35TxVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8845
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

On 26.08.24 09:10, Sumit Garg wrote:
> On Mon, 26 Aug 2024 at 12:19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 26.08.24 08:44, Sumit Garg wrote:
>>> Hi,
>>>
>>> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 14.08.24 11:41, Jan Kiszka wrote:
>>>>> On 13.08.24 14:52, Nishanth Menon wrote:
>>>>>> On 11:16-20240813, Jan Kiszka wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>>>>>>> facing issues because I need to still build the u-boot-only overlays. It
>>>>>>> is also a bit weird (but works) having to specify
>>>>>>>
>>>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>>>>>>
>>>>>
>>>>> Actually, this does NOT work: I just had a long morning debugging SPL
>>>>> which no longer started because it picked the non-filtered dtb. The
>>>>> filtered one ended up in a folder outside of the u-boot sources because
>>>>> of all those ../ and hard-wiring to dts/upstream.
>>>>>
>>>>>>> for our spl dtb.
>>>>>>>
>>>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>>>>>>> I'm a bit lost in the Makefile forest.
>>>>>>>
>>>>>>
>>>>>> Sumit: Any suggestions?
>>>>>>
>>>
>>> Apologies for the delayed reply. I was a bit busy with other high
>>> priority stuff.
>>>
>>>>>
>>>>> I would really like to hear some better proposals than my local
>>>>> workarounds to far. They don't converge although I already patched some
>>>>> core Makefile (overlays are building now).
>>>>>
>>>>
>>>> OK, I side-stepped the spl issue by using one of our variant DTBs for
>>>> spl as well - happens to work.
>>>
>>> That's good to know.
>>>
>>>>
>>>> For the overlays, I need to add
>>>>
>>>> --- a/scripts/Makefile.dts
>>>> +++ b/scripts/Makefile.dts
>>>> @@ -1,5 +1,7 @@
>>>>  # SPDX-License-Identifier: GPL-2.0+
>>>>
>>>> +include $(srctree)/config.mk
>>>> +
>>>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>>>>
>>>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>>>
>>>>
>>>> in order to then be able to do
>>>>
>>>> --- a/board/siemens/iot2050/config.mk
>>>> +++ b/board/siemens/iot2050/config.mk
>>>> @@ -5,4 +5,12 @@
>>>>  # Authors:
>>>>  #   Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> +ifneq ($(CONFIG_SPL_BUILD),y)
>>>> +dtbo-list = \
>>>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
>>>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
>>>> +
>>>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
>>>> +endif
>>>> +
>>>>  flash.bin: all
>>>>
>>>>
>>>> Does that make sense?
>>>
>>> A switch to OF_UPSTREAM means that we build all the DT artifacts from
>>> dts/upstream/src/ directory with the only exception that we include
>>> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
>>> case of overlays, is there any reason for IOT2050 board overlays not
>>> being pushed into Linux kernel repo? AFAIU, overlays are also
>>> describing puggable hardware so they shouldn't be referred to as
>>> "u-boot-only" overlays.
>>
>> We are using the overlay to massage the DT presented to the OS based on
>> firmware configuration.
> 
> Agree and more than that I prefer the firmware to own the overall DT
> and present that to the OS.
> 
>> So, those two belong to the firmware logically,
>> but - with some disclaimers, we could also try to upstream them.
> 
> For historical reasons, Linux kernel source tree has become the
> defacto upstream repo for DT sources. So it's better to contribute
> there and sync back in U-Boot.

Will do ASAP, hope to hit at least 6.12 then.

Still, this will delay our next patches for U-Boot by many months. Also
for that reason, a plan B for U-Boot local DTs should remain, no
left-or-right policy.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

