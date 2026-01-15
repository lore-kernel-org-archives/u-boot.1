Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB71D44C56
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB47580325;
	Thu, 15 Jan 2026 15:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Cum8R801";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Cum8R801";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DCB083623; Thu, 15 Jan 2026 15:46:00 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDEA80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=V2SPkSgmOehK1+8X08HDxE4E55j8x1EHGR+hMmdhdvWPm2MCmeSqo+kqmu4P2A0nt14mz/z/0zT7C2QhNTjlWfag7e1gJClc9f74OrVMC5GgyETHPGxnMX9TslkLiv9exc0r/bt33DPTjwyaP9OL/7N2CfuY9F4w4Yx9wHSmjKZdZi+1N4A1uHGUICHp9Z3x61/DygxDW8M3gI6F8yCxn3gwev00mEGShOQveZ+kE49HXFB7FydBYVjp4UuFtqPiKE3s1iWLVeejev5Fb2aZlN8MjAVvYxtb0kdduGi53HPOLW8rmZetDHMBSdKqrpQKY31nUsNyR5ZBAHqRLCdp8A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG+cdOnpHQJ3CdAf9/No45lmj4F5fp+gL7oMDRljpzs=;
 b=a6nK9rWNptEu/5putVCQgyhFmdhTI+85pwvZag++adUOxh9p61ZD5y2pT+yUl8S0AfB4xcgPBTM+xrrqyJDfLpGSyWZcnBjPfSoFY9vp3/9njf5JynLSIh/9bpUoKD7ipsy/ug3H+5+s8agIcZCrYLychMRvVOqBkgfPbpERm8Z1Nlg6Wmg197WQLPbRewCGfFxlnU5r/jD02q+jWRTZNb+N7ALY0tBsvGYJiKt4QGv+9P1YAJmpm2/f5wQbX918rvOJ7DGKPUAKrIkgzOJSopYsmAL7HVPNByPcE22JvacJETnt3z7s1WrIGdsWALcNTV1Vct7yf7fm30jVY2RAGA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG+cdOnpHQJ3CdAf9/No45lmj4F5fp+gL7oMDRljpzs=;
 b=Cum8R801MBBlwm5tq+zmffAhCnALbJSS9m/zZUirut9v+TPlbyhzi236cmAGrYNgejROWimwq3O0H1OiDQa6JFXwtkQoFcJivmhWKZQphZQ7gexDD3CJabnoZOAdfZDaqfM2ihzsQdUBCYp374Nn2HVYA+LZuoSxPVJY/vlSDvA=
Received: from AM0P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::30)
 by DB9PR08MB10379.eurprd08.prod.outlook.com (2603:10a6:10:3d9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 14:45:46 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::52) by AM0P190CA0020.outlook.office365.com
 (2603:10a6:208:190::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 14:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Thu, 15 Jan 2026 14:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCvH7kidHtKjh2HQq7xJ89xBtgGBKBULE0gQC7VYuUHcXN9igChA1q6r9WHoBxGOi/CGAyCgiz/FZP9Rvmc+uTlkH2Sw2KY8M4qDvFSoMU5lyZUijdMmz14hscILC6Ogc4urNd1pRxrYHlzzgtpsAsTfUgxvhbEl40UJ3iL2hG9AwyDnqgt+XCV1YbGQWoRPIfCmhxl7FXsBhFftt1yqo81z2grR9cgdp8fWU/rASs5ucFCflOcyR/qzmftHAXQrxZrr1+LrgRlk+YV+jsaQifZdFGd/kzzyxrx1sMn468lSTVZuzZ0PgL4GJIo/UzsIKz1JFEWz9+Sg+30pojUrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DG+cdOnpHQJ3CdAf9/No45lmj4F5fp+gL7oMDRljpzs=;
 b=qgqa7qBx4E4ksjub1/p5h9y58r19Uii2JpuEwhAJf4L64xEw2qw7mjnRfyQABvf0hDzeu5rZGdoFkj8pJ53i9DJRDPB9JeIHZyPCP78KSwxE/q3unLXbP9M+bys3icPFo4Guo9KGvrPJL2hkYamMVpxu1/SeCesTMblc2YlyljmXPMuOGGKCweZlE9pDBCrkR6LbVDuadsufM4pzwmvHIrkU4lh/gVQ3gQGOVhAlj3jOnoyG7FAmUnZLL5jdubU5B9X9eCH5WClX+C7uYcBogO3dMi6QrLmHFjs992i+4s02pEeYiNIjqJEjErOvaPgWSlhX6gTEynuShCOtQ+1vFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG+cdOnpHQJ3CdAf9/No45lmj4F5fp+gL7oMDRljpzs=;
 b=Cum8R801MBBlwm5tq+zmffAhCnALbJSS9m/zZUirut9v+TPlbyhzi236cmAGrYNgejROWimwq3O0H1OiDQa6JFXwtkQoFcJivmhWKZQphZQ7gexDD3CJabnoZOAdfZDaqfM2ihzsQdUBCYp374Nn2HVYA+LZuoSxPVJY/vlSDvA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB10313.eurprd08.prod.outlook.com
 (2603:10a6:20b:5c1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 14:44:33 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:44:33 +0000
Message-ID: <107fe414-35a8-419f-945f-07292284a57e@arm.com>
Date: Thu, 15 Jan 2026 15:44:20 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jerome Forissier <jerome@forissier.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260106203433.3133926-1-jonas@kwiboo.se>
 <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
 <7f9d6ad3-afd2-4364-8d33-8510e183642c@kwiboo.se>
 <a8a8dd8d-dfc2-4274-9203-a88d9bcb8a69@cherry.de>
 <c9664240-002a-418d-9301-e8307e3e0aea@kwiboo.se>
Content-Language: en-US
In-Reply-To: <c9664240-002a-418d-9301-e8307e3e0aea@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB10313:EE_|AMS0EPF000001A2:EE_|DB9PR08MB10379:EE_
X-MS-Office365-Filtering-Correlation-Id: 595719dc-c833-4ef6-99a4-08de5444c403
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?ZmZCYm1vSDNCODRvQyticmF3N0dhTTVLUWk1R1h1NEQyUzlPb0pTVGJsaWJV?=
 =?utf-8?B?a1JXbnU0NVh1SUUzTU02Q3VvMkxHNnJsVnhZUWZsTjlVT0ZvYXEzTFZKTlo4?=
 =?utf-8?B?aXFhTzV1ZVVDVXV4VGd3V2ZzZU1qUUlpcG9YbGRRTkkwTkFSQTF2aDFJR1lF?=
 =?utf-8?B?aHhmTitZZGtnRXpNbi9JaVQ0aStWNHkvQzRGUXZiQ1I3OGJYdGZ3dUtxdzRC?=
 =?utf-8?B?SHk2cFpRczhzUWQ0RVV3VXVrUVdSdGRPTkJsZEJvT05wd0w0eDVBMHd4U1I0?=
 =?utf-8?B?bkdSWkRzTUV5OTArT3UzamNqRTJDamRlYWlNRC9nczFUT2xFN1lRY1lBSC9v?=
 =?utf-8?B?TjZvY01zT3pMN3U0eHpIUVR2ZkwrU2tFOUF3eVpqbjEwVW1RSXNSbXA4MnJG?=
 =?utf-8?B?VVNTUkNDcmtZMk0rSjhnU2J0bU9idm9xT05OdUx2Nzg2a1U3bjd6QmZpRURv?=
 =?utf-8?B?MlhEYWJuVzNBWVhKZitnZjhyS3F3ODRLdk5QTnI4c1cwdnEwY29VU3NzNzlK?=
 =?utf-8?B?WUhrNUp0MDZMWWtPbVFvVmQ4VklOYTVrSjFPdGVSNEx1dDdoMFVQSzFBd1Q2?=
 =?utf-8?B?dmlYR3lRUTRZNEliWXBqTTBDd29zcTkwSEc0eXd6aGZXalNzQjhwMHlacFZH?=
 =?utf-8?B?b09zOEY3VSs1aTdRZE1MVCtLWjd0ZjdUME1QRWJucHpJT3pUVDdhOC9oNWl6?=
 =?utf-8?B?dm1UOW1lcSszSEtOMGEvN2J3RWRyNldjR0Z0RUI4ZGNTcjljU2NBakllaGs2?=
 =?utf-8?B?ZGJTaDVnL1hVeUhIVkpxWE5wVkNjL21qYXlvd0JVbFcvY1hqaDNybjZWNFMy?=
 =?utf-8?B?VnQyUVA1aTFWLy9VWmxIMjhYWnl1RnBQZUJRWlgyai9GVVI0clRRZVkyMEJ6?=
 =?utf-8?B?SW9QNUVzeXFhT0hUYTBnWG41R2g3aFZuZTUxeEpLRE1aT2hrUW1JV2tEWFNE?=
 =?utf-8?B?a1RSQlp0cHBpeVppdGdKOG5ZYjBESzBDWGczNU5URDBWZmdVbWxTbzlJVmNM?=
 =?utf-8?B?bmV1S0hlM1NnZlk0VHVGTFVsOGVkTjAzeWNBK2ZkbTMyd2I1TTRYY3dMZFlB?=
 =?utf-8?B?aUUzYVZMZ3dBTm1aT3dmMnJEbTI4Z2g5RHhNUDNkRjJIWStQYmExdFZYNzJR?=
 =?utf-8?B?dWFaeE1zYmlKM25HUWhPSEpJNG9yQ1VmNHlxRS9DdDF3Y1kyS0ZacGQ5Zzhu?=
 =?utf-8?B?eTFLQ1B3bUM4N0lpU3QvNUxOUHZqSUhsUit1VnJIR0J0K0pzUEdvb0tkRVNz?=
 =?utf-8?B?ZVBTblQ1VEZvVC9EaEpxTmM5dzdCYzZqaHlPMUZtTUFxU3pqNjNBSWt0dFV4?=
 =?utf-8?B?dDhzV2NUcGhNN1dvdkdGQ3ZsRk9JcmNZdmdFVHJVdnhyV0U4Rm9SLzkwSXUr?=
 =?utf-8?B?MmU3K2lFbmRPUG43MEhoSzFxaFdOc3JCOEg5YnZBNGpHK3VXelRQZjR3SkpM?=
 =?utf-8?B?Q3h6NDdibnlka0dENjhWc0E3MW82WWUyblpmbTB6MW9hZmtBamxHd0QyMnU1?=
 =?utf-8?B?bHJTUGc0dWY1enlkR3RIbWxrcGJnSjYyWHJUbW8vYmZOZEJKeVNYWkpMU1Fm?=
 =?utf-8?B?L3U1N2tvQTZmQndQRWNZbS82ZDJlamFzc2RKcERTeXR3VUZvbnFyUG8zd3Jr?=
 =?utf-8?B?RVFHLzlXQjd0cDJoeWhvS1ZmVzRQaGxJMWFKZUdjY3B4SFhDSndzRVU2UlB4?=
 =?utf-8?B?Z2JsZ2Y1Y1M5ckdDSUVqNnRrMjJneVNRR3pzNGdIcElzMHdETGNEd3k4MkRn?=
 =?utf-8?B?R0tDQWNkZ1J0SjFSQVdOd3VGeDJReGFSQTcwbXFuSndCU0c3dmsvT3JjNGFv?=
 =?utf-8?B?eHZQR2p4S3NGcGs2QTEvZ3EzSkg5QzNibW1vSHZpVzBXRFErMU01dTN4SHp3?=
 =?utf-8?B?cEdHY3BNMVI5ZFFvR29hRUdaZGs0NDhpcDRTWUhENnlRU2FvTDYxVHNpTXhx?=
 =?utf-8?B?cE9ZR3dHTFUySmUxRVVpRFA1Qzg0dmd2amd1Z2tGbER6VXFlNWREbmlWWC9S?=
 =?utf-8?B?OXJDRkEreWxST1RkRnliRWNqOThkdStQSll6bDJudVRQdE1Nbzc5M09zNEN6?=
 =?utf-8?Q?HzuQs1?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10313
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7614386-9bea-4a2f-ea61-08de54449906
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|14060799003|82310400026|35042699022|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVZSTnA4THF3d3FXcmdFdm01ZEpnNDlNS1dKNG9hdFV4djVXYVR3aUozMWhq?=
 =?utf-8?B?eGJQQTVIbXl0ZXNvNW9aY2xDN3ZxdkN1Z2tnbkRhYjFFWWFUbjcxb2c3d3Bw?=
 =?utf-8?B?QUNvLzI2SDd4Y3hiZDBXNXlQUDEwd0ZvbmNPSGszWEthT3k1VmNKaVVlNlpu?=
 =?utf-8?B?dTRCbWZ3eUtUWS9sMk0rYUFFbWhqTWwxT0JmMWlrMFRiZkRmMzhLVWRIcTZw?=
 =?utf-8?B?QVFTSjRPWmEwSXJ2aFFSNStLZERkMVNsUlhsWnpZYmNrcnU2QUU1YUpXL056?=
 =?utf-8?B?bTdkdkUxeFZzWEV5TXVNajFpQjdCTU00RXNDNXp3NFkwOVZoRWQraU1ac2xX?=
 =?utf-8?B?enQvV2p4VWJUeGNueDJLVytxRjc3YytRdjhiNFBRamdiM3hETmw5M3pJT1V2?=
 =?utf-8?B?VHk0SUJ0bnNkbTlsYzdLTGRWaW82NVF6UmxkL1YzTGVONjFHSldkZEtKMFpn?=
 =?utf-8?B?anJXWU9TL3B1a3JVOGoxUTNUNDdoT3krVVFSb0NJMzAwbDhWUlN2Um9kUFN1?=
 =?utf-8?B?Z0pNbHJ2aHpVM3BhTEJFaWVYU05OdVVGOWxaR2Q1a09sakxJd2xmVjNHb0Nr?=
 =?utf-8?B?aFFZZGR3eE1rdU9ZbjJLS3JrU3VraEtGSzNHZE9QR2prQTFLSzc1bC9oM1pK?=
 =?utf-8?B?bHR2NEpHQ3BsZ0N6ZjdtZ1VJZW9wWG93N3Z1TnpBd2xhZ2JDV25tRGFYOVdY?=
 =?utf-8?B?Y24yeTlDL3FvZVo5am5uWkdpN1pwKytDRHBWcmJCUUt6YmI0ZFdSaU4rUWcw?=
 =?utf-8?B?aFNoTWZRbTJSMkJXT3ZMb0tvQ0RvTzBPaDM3cTRqZkIrRFE1Z2tNeTZNS3lI?=
 =?utf-8?B?Wk82S2Y2N05XZUcydUdueXhJM3pHN2ZQMmVJMkJRSHRxa2h0T2RGRFkrOGRW?=
 =?utf-8?B?Zlp3WDJuTUZ1c3FWdWFnTzZJb2c2NnR3U3d1MEUxcEhEYnRLS2ROc29YUXps?=
 =?utf-8?B?UHpENTNudWRkRTZjb2hZUGlkWXB6UEVpK0tLTzZKeEJvNGljR0F2dWVvOFpP?=
 =?utf-8?B?NHpZeDhaVHZMdVZSb3d5bDBpblg4d3NVSTNCN1hIT1VNOFczTHdzSlRRYkd4?=
 =?utf-8?B?akZ1aE5Sa3N0amlsUHprZ2Z3VjQ3MFcvT2Uza1VUemRLZFJpZzZtaEhXcEE5?=
 =?utf-8?B?SHZZZzdoYmZ2UFg5WjFJRzMvRjE2ZkUraU5zaDU5WjIyMWQxWG1USGJKRDcx?=
 =?utf-8?B?KzV0UEpzeitCTCtlNnRNeVRmTi9yNVVuNko5aUl1dXYyMS9pSVlPVUVSYkly?=
 =?utf-8?B?bWF3WE9NTFA5T1BtZ1A3aDE0Z1B4Q3c0MUQ3aFlrT0x2dGR1bDJMVWdpVHBp?=
 =?utf-8?B?Y1RGWlBVR1FKMnlXZ2pYSGxJS2RoMFV2d0tLdHdXSUZPdFBSOXg3c3V1b29B?=
 =?utf-8?B?QXgwajBGeU5GbXFEZ3JqUGExWjZtY2thRWJoRVZFZ2FBUU5VZDlpT0M3QlZk?=
 =?utf-8?B?ZWVCWFpvdFg4QVpXYzhmekNmaVpzUzhOeVZzOFN4RmRVUEVUbUtONE1ERSsr?=
 =?utf-8?B?QnZSeFlxUy92dURKbFZIdEtCc3U3ZUhFTU5lN3Mwd2NJQmdLbmt6RVcwTXJ3?=
 =?utf-8?B?OFh1UVRlT3JCMXZPY3V2a1l3d0RNa0ZxUUF3UkpnQWVSQVJpQTkzeS9WVWxU?=
 =?utf-8?B?Wk9YTjJJS2NGeTZ6TkZNMjRYc01mMGRkRm5mcHJYMTVLdk1KQkJrM0F5N09D?=
 =?utf-8?B?MDYwTXY3emZKOW9wLzV0dUJiMmxvNEEwVmh5M2NEWWVYNldrOG1icTUwYWwx?=
 =?utf-8?B?bnhiTGxrNm96V0VqOGZkSXJuOXV4czZSa2FMblYxTEt3NGhlNVZjNjI5eHEy?=
 =?utf-8?B?MHJRaDNwQ2tqN1VYQWlNMlZpUEluT1l1cjJYcWVCWnkvVkNGV2p0Vjh4amZj?=
 =?utf-8?B?VitPSGxLdjhLM01ZZlJyTXZuaHZPYzhLR0J0andiZkk5M1ZwR2VVU1hFOHJK?=
 =?utf-8?B?czhGTGd4VnlqeXRMaHA3U003Z2haeVUwY1JRbituUC9rYVVvZ3R5aDJEalNq?=
 =?utf-8?B?RU1UUTNSTG9DYnJRK3VZbHVReEJVUzFtTUZaTDhSckl1SENVd01qS0FFNVFQ?=
 =?utf-8?B?SmhvcUlRR3FEWnRxbVBiQUtRMVpScXlwMGNNc3dwanVnZTg2SXBqdXJkQWtR?=
 =?utf-8?B?dEJ0QW1qdnJyTkppWllnZDNzU2I3N0tyd09xd2p4ZVVhRTkxT1huTy9wNG1E?=
 =?utf-8?B?akE9PQ==?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(14060799003)(82310400026)(35042699022)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:45:45.5396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595719dc-c833-4ef6-99a4-08de5444c403
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10379
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

Hi Quentin/Jonas,

On 14/01/2026 19:29, Jonas Karlman wrote:
> Hi Quentin,
>
> On 1/14/2026 6:08 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/14/26 4:37 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 1/14/2026 4:01 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 1/6/26 9:34 PM, Jonas Karlman wrote:
>>>>> With the legacy networking stack, it is possible to use USE_SERVERIP,
>>>>> SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
>>>>> specific TFTP server ip.
>>>>>
>>>>> Using the lwIP networking stack use of the 'tftpserverip' environment
>>>>> variable provide the closest equivalent functionality.
>>>>>
>>>>
>>>> It does read serverip environment variable if it's set, so this should
>>>> match the behavior with the legacy network stack no?
>>>
>>> This is what I first thought, however it seem that the lwip stack diffe=
r
>>> slightly from the legacy stack, in that the dhcp lookup always seem to
>>> reset the serverip env var.
>>>
>>>> As for BOOTP_PREFER_SERVERIP, this would need to be implemented in lwi=
p
>>>> and isn't covered by this new variable is it?
>>>
>>> For the lwip stack it looks like the BOOTP_PREFER_SERVERIP Kconfig
>>> option possible was replaced with use of a 'tftpserverip' env var.
>>>
>>> For legacy stack I had something like following in a .config fragment:
>>>
>>>    CONFIG_BOOTP_PREFER_SERVERIP=3Dy
>>>    CONFIG_SERVERIP=3D"192.168.2.50"
>>>    CONFIG_USE_SERVERIP=3Dy
>>>
>>
>> And this meant the serverip would not be overwritten by the dhcp command
>> for example (in the legacy stack)? When doing PXE/TFTP, I always do
>>
>> setenv autoload no; dhcp; setenv serverip X.Y.Z.A; pxe get; pxe boot
>
> I tried to keep it as simple as possible, as I have not used network
> boot before, and used something like following:
>
>   env set boot_targets pxe; bootflow scan -lbG
>
> and when I need to use a USB Ethernet dongle I use something like:
>
>   env delete -f ethaddr; env set boot_targets usb pxe; bootflow scan -lbG
>
>> When I control the DHCP server, I can actually set the TFTP server
>> directly and can skip setting the serverip as it'll be set by the dhcp
>> command correctly it seems?
>
> For my homelab I use UniFi and should be able to control DHCP options,
> however looking at U-Boot it looks like option 66 or 150 is just ignored,
> see [1].
>
>   case 66:    /* Ignore TFTP server name */
>
> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/net/bootp.c?ref_ty=
pe=3Dheads#L952
>
> From my very limited testing it looks like I am forced to set serverip
> in env and cannot use a DHCP option to set the TFTP server to use.
>
> And when I then also tried lwIP, and that seem to result in new or
> different issues, e.g.:
>
> - lwIP seem to be configured to allow very few packet fragments, trying
>   to use a reasonoble tftp blocksize, e.g. TFTP_BLOCKSIZE=3D4096 or more
>   seem to cause drop of packets.
>
> - lwIP is very very slow to timeout compared to legacy when serverip
>   point to an invalid TFTP server and pxelinux.cfg files is looked up.
>
> - sometimes got hit with random SError issues when second file was
>   loaded from TFTP, this issue was thankfully fixed with [2].
>
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20260114-tftp_fix-v2=
-1-8de8e6ecf4e8@linaro.org/
>
>>
>>  From my notes, for an OpenWRT DHCP server:
>>
>> Network =E2=86=92 DHCP and DNS =E2=86=92 PXE/TFTP tab =E2=86=92 Add butt=
on
>>      Filename: default
>>
>>      Server name: fileserver
>>
>>      Server address: <TFTP server IP address>
>>
>>      Force: checked (may not be necessary)
>>
>> Save & Apply button
>>
>> I'm assuming you need this for your labgrid farm so hopefully you have a
>> way to control the DHCP server :)
>
> Correct, I have been playing around with network boot in my labgrid farm
> and hit a few mines along the way :-)
>
> Should result in a few network related patches in next few days.
>
>>
>>> Adding NET_LWIP=3Dy made pxe booting stop working and 'serverip' always
>>> ended up as the dhpc server regardless if it was set to something else.
>>>
>>
>> Interesting. With tiger-rk3588_defconfig (legacy stack), I get:
>>
>> =3D> setenv serverip 192.192.192.192
>> =3D> setenv autoload no
>> =3D> dhcp
>> ethernet@fe1b0000 Waiting for PHY auto negotiation to complete........ d=
one
>> BOOTP broadcast 1
>> BOOTP broadcast 2
>> BOOTP broadcast 3
>> DHCP client bound to address 10.2.162.193 (1394 ms)
>> =3D> printenv serverip
>> serverip=3D10.2.0.122
>>
>>> Since lwip instead prioritize the 'tftpserverip' env over the 'serverip=
'
>>> env for tftp use, adding a similar env var Kconfig option was easy but
>>> may be wrong path?
>>>
>>
>> I don't mind the addition but I'm wondering if it's not a band-aid patch
>> for something else? Maybe lwip missing setting the BOOTP server from a
>> DHCP lease for example?

Quite possibly (I did not check TBH). I think it would be nice to have.

>
> Possible, setting tftp from dhcp also seem to be missing from legacy
> stack, if I am not mistaken. I do think the separation of tftpserverip
> and serverip for lwIP stack at least is a step in right direction, I am
> new to network booting from U-Boot so what do I know :-)

I also find misleading the fact that the legacy net uses 'serverip' for
multiple things, depending on the context. It prevents setting things
globally and makes things a bit more obscure than necessary.

>
> Regards,
> Jonas
>
>>
>>>>
>>>> This patch is fine, I'm just challenging the justification in the comm=
it
>>>> log.

I am also fine with the patch.

Acked-by: Jerome Forissier <jerome.forissier@arm.com>

>>>>> Add USE_TFTPSERVERIP and TFTPSERVERIP Kconfig options that can be use=
d
>>>>> to add the 'tftpserverip' environment variable to force use of a
>>>>> specific TFTP server ip.
>>>>>
>>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>>> ---
>>>>>    include/env_default.h |  3 +++
>>>>>    net/lwip/Kconfig      | 12 ++++++++++++
>>>>>    2 files changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/include/env_default.h b/include/env_default.h
>>>>> index 7f8dc1c35a74..014873e304d8 100644
>>>>> --- a/include/env_default.h
>>>>> +++ b/include/env_default.h
>>>>> @@ -58,6 +58,9 @@ const char default_environment[] =3D {
>>>>>    #ifdef CONFIG_USE_SERVERIP
>>>>>           "serverip=3D"     CONFIG_SERVERIP                 "\0"
>>>>>    #endif
>>>>> +#ifdef   CONFIG_USE_TFTPSERVERIP
>>>>> + "tftpserverip=3D" CONFIG_TFTPSERVERIP             "\0"
>>>>> +#endif
>>>>>    #ifdef CONFIG_SYS_DISABLE_AUTOLOAD
>>>>>           "autoload=3D0\0"
>>>>>    #endif
>>>>> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
>>>>> index 5789766fe624..0cfd3eb2684f 100644
>>>>> --- a/net/lwip/Kconfig
>>>>> +++ b/net/lwip/Kconfig
>>>>> @@ -72,4 +72,16 @@ config LWIP_TCP_WND
>>>>>             but QEMU with "-net user" needs no more than a few KB or =
the
>>>>>             transfer will stall and eventually time out.
>>>>>
>>>>> +config USE_TFTPSERVERIP
>>>>> + bool "Set a default 'tftpserverip' value in the environment"
>>>>> + depends on CMD_TFTPBOOT
>>>>> + help
>>>>> +   Defines a default value for the IP address of a TFTP server to
>>>>> +   contact when using the "tftpboot" command.  (Environment variable
>>>>> +   "tftpserverip")
>>>>> +
>>>>
>>>> Does it support IPv4 *and*/or IPv6?
>>>
>>> Not sure, I have only tested IPv4, guess IPv6 probably should work, the
>>> 'tftpserverip' var should work with same formats that the 'serverip' va=
r
>>> currently support.
>>>
>>> This help text is mostly just a c/p from the USE_SERVERIP Kconfig optio=
n,
>>> let me know if you think this should be changed.
>>>
>>
>> If it only supports IPv4, I think it should be mentioned. I'm sure
>> Jerome will have some input on that when they have time to review :)

I haven't tested any IPv6 with lwIP, so at the moment it is considered
unsupported. That said, the lwIP stack itself *does* support IPv6.

Regards,
--
Jerome

>>
>> Cheers,
>> Quentin
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
