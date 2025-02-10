Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE7AC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 07:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29F6F801F5;
	Mon, 10 Feb 2025 08:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Td/MFjhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2CBE803B5; Mon, 10 Feb 2025 08:41:02 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912D280050
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNPlSliuRtjc2tGZx2VJHCd8hmKgXIqlQH/jiSmMzUcVhvN0BCUGaoCqnyQyF++m7TgiKoUXq2LNaXik8844NBjPdaWNoYE8KRWBDANR29aZ0pkixqWN2wUmoGLKUIJkvjIDoTMCkcHuGkfY3CaICybrWDhTCi9NVzRKhqrx/5dpal132y3H6DWQYcSNx58beI0eSwyX3zPBaFT5Yg+RNlM/+ATG9KWIehIYhda82pVJ2+AREUMcN0yeTNaS9CzjOQMqacd3ULEC395rKHZWgagDU6w4rYnZUqobIdLXjTRslb5UQRyQXvT+dz3SaNsI/XJPwvF4F4o97aDY2YZw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwgXcsIPp7K9w3X21gvztx5ziOCRuWG0Q6yw7+2ygOU=;
 b=gPRSVIKZMQ9OaufSYyrLGnrLie85NNB4uUfQHv0yuCs4LdhVAcnDtpxDVflNW69HmzCSPf8o1mHpRQP+42cfJbDBcp4DjewpL4M1OxCfXUI42F15G2j4O++9UwDbsFeY98wAHo/F+uX2YWXQmToM2E7p3I+IKrskHdETbUKbigH/k42poAgeEt8pTCsbx0LDWKUsnjEvoARGjhZPkmF9mEzw6iJJ2Edh9wFMlUgi9HmM0EdUnseEUkC6Yc/GnMY6ofBlwkj+xrQN8Vs/xYL6wJToJFZj3VRXGgi3RftjUyR7nR/5sbK3cOO1QLsLcwW6TWZEAEeIXqSbaRdKTmYl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwgXcsIPp7K9w3X21gvztx5ziOCRuWG0Q6yw7+2ygOU=;
 b=Td/MFjheu5SVGqsdMO8+kQgaatSZ5Js1HVBGHD9sP++7jzzwZyNu5CBhCMBaJxmyQnz3bMlRHPw5/qBKI+R3BbRYkkvarEbknuKvoBB1KLgODq+ot7z45jKtx6wmZWPo/AmirPMIF9fe+sY9QMEFn2EBTH5nOxJEkmdXnPtQ8OqA0I1QHEPRWcCdamRtYKn9pxccOo0xnK8fPf/M6qBWTFa0SsHSWZofRvuqIO4waimbcAKd9yBV3UT7sdUl3t6MnhjNdqZG0Hwd+B+DJvlBbXf6HEVkma4EXUsnF0i9zY+60qMRRFLrlJVnvRLZz7sTWMfPPMRPjTD7AoDNqhRtnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by AM9P195MB1140.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 10 Feb
 2025 07:40:58 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%3]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 07:40:58 +0000
Message-ID: <eca48319-dfb6-4118-9639-ff8286ada2ef@phytec.de>
Date: Mon, 10 Feb 2025 08:40:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] board: phytec: common: k3: Introduce Configs to Sign
 Images
To: Andrew Davis <afd@ti.com>, w.egorov@phytec.de, trini@konsulko.com,
 ggiordano@phytec.com, u-boot@lists.denx.de
Cc: nm@ti.com, n-francis@ti.com, nmorrisson@phytec.com, d-gole@ti.com,
 m.otto@phytec.de, bb@ti.com, upstream@lists.phytec.de
References: <20250207065122.2495923-1-d.schultz@phytec.de>
 <20250207065122.2495923-2-d.schultz@phytec.de>
 <b97fa179-8293-480e-8757-f8cc15c39828@ti.com>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <b97fa179-8293-480e-8757-f8cc15c39828@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::18) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|AM9P195MB1140:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc1cf8e-a712-452d-9b3f-08dd49a6405b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0VLZ0pIMzdQZlE2Wk9FUEtKNlZFQmVkc29pdnFlbUUzbm9GK2tUUlB2Ukla?=
 =?utf-8?B?aXBKM0pZNlVyV3lpNWFUL290cVYwVnJTVkFlOW0zMGEzS1diU2x1ZWJDN250?=
 =?utf-8?B?ZGxRUHFxQXdyemRnaHN6VDhUR1U3OXViSVJWSFN6ZXhjaTdKTUFjRG5DM29v?=
 =?utf-8?B?N3NuZEYwUWtGaHJ5VnVqK2FxZ0xHQXN5SVI5bldCL0ZIV3cxSC9SK2dZa0xI?=
 =?utf-8?B?TXhJNnFxejMzNWFtMmZPcEQraGdLMXFUdk9SR3VmMkZ5K3BXclF4eUxtTDJN?=
 =?utf-8?B?MDB6S2VTSXBEVzlxUjBkZU4xMEUyWHF0MDl5TDJTalZLYWhNS2o0dlY4MkVp?=
 =?utf-8?B?UE45OWs4RUpvSmp5V2lRK3lwd2hGRlc3ODNYTDFkbUFQNzh6N3JWNzY3K0dC?=
 =?utf-8?B?T3o5RUFIZ0FpeDRyYmhLdGs5S0pvbG5LTmxmbkZxdytMWjNQUGtQWFVrZ05h?=
 =?utf-8?B?VkgxdmRvdTl5dHRXL3dnY3l6aTFzOXVlNlhhc3lIbFljUHk4VVh3WlRtaUlB?=
 =?utf-8?B?SFBpSmo1eWNjSHBTYmhTMjVwQWxZM0Z3eW1IblF0UVdQckJMQUo2OVlhdE5F?=
 =?utf-8?B?cHMzNGZidEhlcm4xbHo1bE5iRUp4eHhPb1pGc3R0d2hlc1pSUGxaczVocHVX?=
 =?utf-8?B?SGF0S3VkVFNMa212R3ZHa0l0cW14TjRCa1ZFbHNDZmJrek1lWHJJeXpXZ0FZ?=
 =?utf-8?B?NVdIT05qVGUyQ1gzdzhuTm8wUlh2d0pINmRIbXkrUHBuck1QVHRCMGhZZHRI?=
 =?utf-8?B?YXBvaXlXcFgrc0k4U2dxUkdQUGZoT2xvVDZBaVJIOGVpMkR5YjAvd2dzZC9N?=
 =?utf-8?B?TTBBakZhREV2QVgxQWlnTi9ocFlUUkNjbmdkbWtURzlLb2czWU5iRUI1TWxT?=
 =?utf-8?B?S0xVZFpCMzcrMSs5Wm5QQllCditrdW5FSjZ4WmxJaDQ2WUZKUU53Z3Z4UnFM?=
 =?utf-8?B?SzJMS3pmQ2FHcmZzcmZVRkFJdGpwQlZ1M2FZMGNlR3drSjhJazd3T0NGSUox?=
 =?utf-8?B?MkNuYWllT1lWSGVRdVV1VzBxaXJ4Umt6TURxZlEwRFluamxqVTJYcTBqUG9Z?=
 =?utf-8?B?UnVkTXpGOWVyN3A4MjdIVFZqcGMyRHY3akYrM2REQWY2c2l5UnpuTEhRcmk1?=
 =?utf-8?B?cnI4eHBucXZYTDU0NXZoUTJRekhNMmZzNFlDUUc4RkRZTkllWm51aGY3ME4v?=
 =?utf-8?B?amVBc3hWelFUQi9TbnJPcVBPZk1zeXBLelNMcFptekdKQ2dxby9peVozVy9a?=
 =?utf-8?B?OW8wYloxM3h6RThEYUNKdkRKeVYwTnY4UndCeW1VNTVnMG42TFpxb3pXbzlZ?=
 =?utf-8?B?TGIrL3R4NDV2Zm1pREpaR1I2WVh1ZXZRYytxeWZZL2dMZlBrd3lwRk9heUYv?=
 =?utf-8?B?NkF5dFh4N0lXRHlTMEhNcGN2cW01Nkl2bU9NekY1R2ttaFhTeWlwYTJJc1Qv?=
 =?utf-8?B?Qmo4L0dlYkowSlVla3Z2QUJjbUxLRnZ3b0dMN092VHhxWGhIaitKNVFDUnJE?=
 =?utf-8?B?YTFRaWVOOU5DU0ZJSXM0cE5zOHp5RDFzTEd5QUE2UzFaU0RaR1pTQU1TdnUy?=
 =?utf-8?B?RDlkRUcwa2I2Ykw1Q1JBZngwU1ozY2dFeUpFSHk0b3hTVkhBbG1KeTBqSmpH?=
 =?utf-8?B?YzZSWE9IcTBYeUwrVXY5a0VMUGc5MkU3ZzY1NVpsMXhoWEtzZjFSamphSFA4?=
 =?utf-8?B?cE9mS3A4TXFiMktnTWVqTjlzQmF1NzBqWnh5WldDWlYvSDZGZW1ONE1YY1ow?=
 =?utf-8?B?SWxYN3JaYVFVZ29JTGpEa3hjSjB5Y0dHSHBKZXVDeWRsT0lZZnY5M2NJV2N4?=
 =?utf-8?B?bVI5MVd2VXdwejlTMExESVlvY3gyVzJPRDlqaU9Dc3B0b0krZjUyZTdvSUtj?=
 =?utf-8?Q?CfdW2lU0M+sbQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1g4dE1NSEJkZDdmSXZGY2NZVWVKUXVueWUzK1lHS0M1UUZDazZ5ejdJL2lO?=
 =?utf-8?B?c2VUVnFwMzVEZ3IxcnlQWC9TUVVnUFp2WlE3R3RBYjlyQVhBeWhkUlMwU0h1?=
 =?utf-8?B?cXRkL0ZMdmtJR0JHR25BSUk1TXh2SDE5c3RwNDRVMVpmcWpTSXZVTllGdENS?=
 =?utf-8?B?L0NJTndvUTVXRUd0elpZY3R4WXdFb3lYTjNFTzJjUk9aVTk2QUtMQVVsTGt1?=
 =?utf-8?B?ZkNqOXdPck9IWlo5VjUzeFVxejNDenM0ZFFUR2RWd0hTVU5xNTJKSEVnMTY0?=
 =?utf-8?B?UE9wVk5HZHl5emJhWFgweDdMOVdRdG5WcTgzaEQ2S1NtRUswejV1VDY0V2cv?=
 =?utf-8?B?d1o0VWtJOXM4aGJMWUZmYW5GSlFRRGVMbitVRXpRSTVoeGxkSUFubDNoZVdT?=
 =?utf-8?B?ZkFwRnlhZStuOVo2b0VyRlZwSXNZSHo5ZCt6eUUwd1lQNnZMamdJeTloZTNp?=
 =?utf-8?B?OXlibXoySWdEVHVWanYycjd2M1orY0lqd0dGWEpRYys3WlFHVm02bE9sQ3Vo?=
 =?utf-8?B?Tmw2KzhpcFdmZFdWT3hJK2hBQTVoc1F1UDZYVnhOUmdYNVYyak5hUVovUHdX?=
 =?utf-8?B?dVRkN29FWFg0NzZmV3Z0UzBWc2djWnFXNEJwVUtWL3NKNTB1dkxtWUIvQmw4?=
 =?utf-8?B?a0ludmlVdE4yM0F2bFExcmpwVG5iSkhCSGtoWlg4OUhnN1dMM1JBeEFKbDBa?=
 =?utf-8?B?L3hMK3R2K1pNa29KejNpY0kxYXBMWlZPVlUyZ3NlUnZ4Nmpwbmt3ekcyd1Ba?=
 =?utf-8?B?NS96RHpOMmh3T1VFUU9MVzdZMXEwNWgvNTkvOS84bXZYMytCcExmaEp6TmI3?=
 =?utf-8?B?NnpwUVQvZmJ5NHZIcGlNMHQ3czlSb0t1S3V2TFpvZitPVWJ3VDVyM2gvbXdP?=
 =?utf-8?B?aHZsRDRxYnR2QlloNThRd0ptN2xuM0VNeHdOUmM4b09ZS0IzNjRLMHd0cnQ3?=
 =?utf-8?B?TzV3MDdXallxaHhpWjhrUmoyOUJTWWtiZkNQTG50MGJ3dXVmQ3pvM3FpdGIz?=
 =?utf-8?B?RlI1T1ZlcVFrc2Fhbk53MllqY1NhOFJFeG15ajZSS1FKL295cDB4UFlib1Nt?=
 =?utf-8?B?amRXb2ptUDlXNytidHdwb3NZNVFRTTE1UmR5clVaOFVPbk1kZlpHQWlMNzJD?=
 =?utf-8?B?UVM2YmdQSnpWY3pzVVJKdHZlT0FGdkt5RVdiTjV5R09FSDBTMHdnVkRFNktS?=
 =?utf-8?B?Nm1tVjFkMGdNRzA4Q2gzNlJSQVUxSCtRQ1l3Szdmd3dPMnRsSEhVTUppa05B?=
 =?utf-8?B?TldIQXlCM21PcTRaazdReW00NEJxK2gyeWUvUmJGZVZISUVvSnFacDZmV1BL?=
 =?utf-8?B?bmEvRmFIbnZMVVdxaDdydnlXZ0RQcnJPYytDSVV3Wlk4TFFKUFNxdDlxemM3?=
 =?utf-8?B?RFE1anhaa0w0ME1TdW1aMXIxSEkwZy9udjlTZmdEU0xZTmsxbGVrU0taTE8r?=
 =?utf-8?B?akVHd1FCTmtsaEhpbVNXYkYxczJTS3pCaFIzSHdYQlc1cmxQWW1sbkNCZERv?=
 =?utf-8?B?WmJCMC90SU9IOGJvS3lTQ0lMaVVucE5wUXdwMWJ3aGNLaE5rdTV1QVptK3Mr?=
 =?utf-8?B?RFJPY3oyNUxucUpTQVZTVDhlNVA4bXdFeThocHRJbkdXeVc3MkI4TTNVcTNM?=
 =?utf-8?B?aDArblpRd1BTQXJvMzk3TlYxcXRDNXl4WmV1Yld5WG9Samd3T2xDNnNMTnVW?=
 =?utf-8?B?SlpIU0FjU2k5elVjYUJ6QzI0dVFkVmtCQkJwRFg4YnBQRzdBWmxPQXdIMmZQ?=
 =?utf-8?B?UUdzbXNiVUQyT01tM3lVbEUxTUhJTlhHelF0R0FEbmdlZnJ5VFN4ZGNwT1h2?=
 =?utf-8?B?U1FjemZGU1pZNEhsa1RYcGxBNEdrdWsrazVFK1ZuaDFBc01sKzBJMTRQK1ZG?=
 =?utf-8?B?SlIvejdjVm1jajkvZEdWTkE0MGNuZFRYaXd5cU5ocUZmWWd2N1pPcXh0WDRP?=
 =?utf-8?B?VlFCNWMvdHRqSm9kZ05zc2dxc3E0RkhJdmloZkJ5Rnk1NmlHQllvUTlxRzI2?=
 =?utf-8?B?QmtoSkswVmNMSmRHc0diam0wYUNXQUw5K0hUZVZhWlNPMFFzRzRQWDFsN2FP?=
 =?utf-8?B?UzdtNGlVWVJzdWNtNUkrcGZNV3lKZ2gvTDliOFpuY3luS1Rwa1pqYXBCZDZX?=
 =?utf-8?B?NG1IVEJuaXRSSDJnZkg2VlpseFA4bHpCYm1Ec0VCNHRlNFVIdXVxeXVMS0hI?=
 =?utf-8?Q?zbFXEze+oTIZrIlFWDww1XslxklhRckc6x72oArSRhzs?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc1cf8e-a712-452d-9b3f-08dd49a6405b
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:40:58.4884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51m5STuu+Yvxhvmz141TNr1meGovJAXyNn5TVvhA/yCtTKFXH8W9oSR9IUPleSf/gmZymZE1k8zQLfvldbYvzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1140
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


On 07.02.25 18:07, Andrew Davis wrote:
> On 2/7/25 12:51 AM, Daniel Schultz wrote:
>> Private keys to sign bootloader images shouldn't be commit or part
>> of this repository. Add config entries to use keys located outside
>> of U-Boot to sign images.
>>
>
> The custMpk.pem was always a placeholder, we fill it with the TI Dummy
> key as an example. The idea was you replace it with your key using
> something like a symlink. So custMpk.pem is replaced with a pointing
> to your real key when building on the production HSM. Why do you
> need to have a Kconfig to point to your real key?

Thanks for pointing that out! We were not aware of that process and 
added these Kconfigs. I just sent new patches to add the missing keyfile 
entries in our binman to use symlinks.

- Daniel

>
> If you really want a full path to be settable from Kconfig for some
> reason that I am not seeing, then others will want to too. So you
> should make this option generic for all K3, nothing specific to this
> one board family.
>
> Andrew
>
>> Signed-off-by: Maik Otto <m.otto@phytec.de>
>> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   board/phytec/common/k3/Kconfig | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/board/phytec/common/k3/Kconfig 
>> b/board/phytec/common/k3/Kconfig
>> index 282f4b79742..19fe927b22e 100644
>> --- a/board/phytec/common/k3/Kconfig
>> +++ b/board/phytec/common/k3/Kconfig
>> @@ -3,3 +3,37 @@ config PHYTEC_K3_DDR_PATCH
>>       help
>>          Allow to override default DDR timings prior to
>>          DDRSS driver probing.
>> +
>> +config PHYTEC_K3_KEY_BLOB_COPY
>> +    bool "Copy the MPK key and the degenerate TI key to the build path"
>> +    default y
>> +    help
>> +       Select how to manage the MPK and degenerate TI keys.
>> +       If PHYTEC_K3_KEY_BLOB_COPY is enabled, the keys will be 
>> copied into
>> +       the U-Boot directory for compatibility with the TI dummy keys
>> +       stored there.
>> +       If PHYTEC_K3_KEY_BLOB_COPY is disabled, the build will use the
>> +       original key directly. It is recommended to use the original 
>> key to
>> +       avoid unnecessary duplication.
>> +
>> +config PHYTEC_K3_MPK_KEY
>> +    string "Path to customer specific MPK key"
>> +    default "custMpk.pem" if PHYTEC_K3_KEY_BLOB_COPY
>> +    default "arch/arm/mach-k3/keys/custMpk.pem" if 
>> !PHYTEC_K3_KEY_BLOB_COPY
>> +    help
>> +       Specifies the path to the MPK signing key:
>> +       If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to 
>> the blob
>> +       copy of the original key.
>> +       If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
>> +       original key.
>> +
>> +config PHYTEC_K3_DEGENERATE_KEY
>> +    string "Path to the degenerate TI key"
>> +    default "ti-degenerate-key.pem" if PHYTEC_K3_KEY_BLOB_COPY
>> +    default "arch/arm/mach-k3/keys/ti-degenerate-key.pem" if 
>> !PHYTEC_K3_KEY_BLOB_COPY
>> +    help
>> +       Specifies the  path to the degenerate key:
>> +       If PHYTEC_K3_KEY_BLOB_COPY is enabled, provide the path to 
>> the blob
>> +       copy of the original key.
>> +       If PHYTEC_K3_KEY_BLOB_COPY is disabled, provide the path to the
>> +       original key.
