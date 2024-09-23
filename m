Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7B6CF9C69
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 11:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACF288B79;
	Mon, 23 Sep 2024 13:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SeOesOIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA2E88A0E; Mon, 23 Sep 2024 13:10:11 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDBC788B79
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwdVsMTVVKYU7kgqDRpy7tdhnqf0P932SSPzP1n+aBXKMUwHeoJipLBc4fCYYZXMkL0I8ezl/5TvsR2m3+LCs1fbrgUuAJHVd2nulH0i+2gDQjo6cwXrwEt4Ee/08Z7v4uZQYdwQbuhA44viednE7S562IA/bUwLmX5T2BXJxajXOcY/h8Ft4gMKpdllB7n/ccEuf/vKVbTEB+IMeM/FWO+omXizBE7Z4dZKFZyiOc/nPHdOgZWrvNas0ZcqbGWAI/JETBXxMaX1eJrCPtPUxW8Ea5XHoI+Bx5Ddr15IkyvlNLS3EfWfxzzf+umJi/nMIx/nyrZMUS87SkYJJrTlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkZi2mAV1fM3CTpwVRIekO8klUEYIl0LROHy6x4OzEg=;
 b=tOu7MMne/u0ga9OJm2h1OU+MBD3b+41iRaLp29v2vqDw5zHT8YzNnofRe52UQaKQGoGoaw6CYCq+B/gKfl6bySz+/FJTaTt4F0KLBRD2jooRBH2tvYgF2uhPizpQS9R/ziMA6r9MWrMIY3rBPiMJvthneysUOEIca4fmcbrA6Hppc8J+saeAMzJl9iwSAKnvSruUpLJ0XeuVeAO9wtjcO4uEJyHBNOMpnKSK9pvgygr5sP8g7vwrxJrGbe//9scXx3j5EZXfxO6yWxyjjPCgv/lqxBpgheVvSY2b3Icrptgne7JYScmfnQEXPDKRbJDf/G/BFrTJA6TR3G1i4ozq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkZi2mAV1fM3CTpwVRIekO8klUEYIl0LROHy6x4OzEg=;
 b=SeOesOITTlLeCy42KjCE2iQ2YXclu1MVGPig6VpsgpP04ci6hYvrsxy3Jyse/KbYaCZBAL2GoBfXq9bSL7FAHEEvHJ3GUwxpRa1xrbRuD5O26qSoGI4eFxkEfqdhlerJ7QUksB7mJIBj+qbMTxfU3RMv4xE3bRBk0WAIa0DnEXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA1PR04MB10264.eurprd04.prod.outlook.com (2603:10a6:102:456::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Mon, 23 Sep
 2024 11:10:04 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 11:10:03 +0000
Message-ID: <6bc51c9e-3be1-4d1e-be56-074d02fab4e8@cherry.de>
Date: Mon, 23 Sep 2024 13:10:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] env: mmc: rework mmc_env_partition_by_guid() to work
 with two separate partitions
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Marek Vasut
 <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
 <20240912134141.4143855-4-rasmus.villemoes@prevas.dk>
 <72e37714-bdac-4334-a2a9-18d6ea954b73@cherry.de> <87y13oktyj.fsf@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87y13oktyj.fsf@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA1PR04MB10264:EE_
X-MS-Office365-Filtering-Correlation-Id: e331f06c-7434-4f00-cc48-08dcdbc04636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzlTaW5zT3paN1JZUXQzV3pZVUJMb0dqbjZnU2QzNi9EckdydERqL2orSFBU?=
 =?utf-8?B?cmp2NEllemR0L0VFK0M0endOWFFTRTExaitJdmZaYkJ5VUEwMVpWOFBUWmpi?=
 =?utf-8?B?MnFZeXFNaVd2QlNpQVNWMWhIRnAwUFVVTUVQY3hIdml2VW9XMVN3MlArZUxC?=
 =?utf-8?B?VGxrYSt4RytSell3QUYrcU5ldjNXTlNidDBoL1p6M0FwTmxqbHd5alNGSUNk?=
 =?utf-8?B?RlB0NnJKcy9Ldll5RXNtNlBzNnhmbVF3VGY5M0J1YVYySUQ0OVRzUEtnSk9o?=
 =?utf-8?B?MnVyUjFCZ1FmUDVpWUg4MU4xUU1DR1pJVFp0b04zTXVLYldmUDhKd0cycWZt?=
 =?utf-8?B?NzQwRGY3NE5zdTBIRERQbFJoRW96SlZCUFppQTdEa3VaR0J6RDIzMzFaNzhQ?=
 =?utf-8?B?QUpoNG1ONmhlV3BWbUZEZ0R3bnlpbGJrUjdoY2p4VU1qS2NjZkk5Ymo0M3Nj?=
 =?utf-8?B?ZlZrMnhERG9ZVkR6UFB2Y2ZMaHQxek1xMmhQcmRuaitIaGFLM2pBZUltYkxF?=
 =?utf-8?B?UmdqNzNoU05iRmpyb1NzZW9Rb25uSyszUldiTm9xY0dsSUduWWlZRVFUcTJZ?=
 =?utf-8?B?MTl3emhkdk9VZDVOdVQvSHhZUE5kUXgwUWlSeXIwSFREYVBLQTJtcDBUSnpW?=
 =?utf-8?B?bFYrd0UrbXJyVkplRU9WSDZlQ1dCeEFWM0Y0SlVDODRZTEY5ZVpoSTRDYTFM?=
 =?utf-8?B?UC9VRkI1THlNMWpoSk5MNVBIdXNoWjFFa1ZYcTMzY0FSaml2dStldjFnTU4z?=
 =?utf-8?B?VjZJWkNaeU44YXR5UjVjT1c0NCtLQ2lBVmV5SjlJSlZZSVBqSmpLdUtMTkZT?=
 =?utf-8?B?WVFOQlFuS3NSLzhXU0xac3dlcWpzRXFCbGJEMUVOV3Q3TUk1WCt1Yi9iTTBt?=
 =?utf-8?B?RXdVbm9TRlBHUkhtbFhtOE9pQWJpcHZhTEQrTGgwRmJzWkZFdmFCT1VMaTQr?=
 =?utf-8?B?SnlMN2hCVnoveGJYM1pUNTR2UmoyN2Y0VkY2MUE2OWE3M0JHdzMzTmJWVjdZ?=
 =?utf-8?B?eXVXUkd1ajVuNGQwcW5XaVVpOXY3S3Y4aFVXdUxMUzE2bW9TVG1MM3lsZmxa?=
 =?utf-8?B?elh0b3p6UEw1NFFuL0l2S25nMU1wTjBPQjI0OE92SFkzVFRlZExlTENoQWpT?=
 =?utf-8?B?dmw4R1p6YmY5QWNORGRwaTNWQ0tZQjBpTDl4V3JQQ1lzUnJadndUd2Ruby83?=
 =?utf-8?B?dlQ1Mm1ZTkR4WkFsejJBNHptc2hGVlYxOTFWc05ZSnU4dy9kbDlBcGM1bU96?=
 =?utf-8?B?Z2l3WjZWSlp4ZTkzRVM0UkkzK29FdVFzR3RrOWdJUm1JWFhVVWdCN0M0ZWwv?=
 =?utf-8?B?dzBuMGJOYmlwVVJwRkV2NEtldjRXa04wTk1wQ2JXR2ZQbDU2cDVoNysyV2Zq?=
 =?utf-8?B?TGJKWmwvRVllamNlRWcrNFVIdmZzajdUSWh1TURJZHdOd3ZOWFkvK3lnbEJu?=
 =?utf-8?B?cTdsd3dPSUxCdGYxbW1nK0lwVUdkcmVSMy9jOElwcFQ1dy9hZ1cxRDc5YzNX?=
 =?utf-8?B?NE9LWG9kN3VUZ2R6MXZ2UGRBdW9HUUNxTHY0UDMvWU9ZM1VXbmJPM3VKdFNM?=
 =?utf-8?B?S2laU3MyallzRFZwRnVLOURKZ2cvVkJuak1kM21sS2VzSEdkNGNHVTRLQ0Rt?=
 =?utf-8?B?eFZmTVVBQ2lXM2pYVi9maHJ6ZFJiaG00dzUrdm80dnhDNjkycWluTC9QekhG?=
 =?utf-8?B?dzg4clZ1T25qeURZWHd3YVF5WUdDbEpuRDg4WGdtZjBuQ2s4V2ZMOUVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9sR2FsQk1XQmpCSlFpVm96Wmtzdm1tRWFWUW5HR1ZOQ3NDOWlDbFJkclJI?=
 =?utf-8?B?ZXJxS3p5SnZQRGRUMjJZQVp0aWwyZGFvNytqRTdkUHdSZHgxN09PUjZkSmlu?=
 =?utf-8?B?QllFcGhucHNRekswWnVmVno1bmdOaFRpbkFwaHozVURCWkJ3K1luUGZNdUJC?=
 =?utf-8?B?SjJHQjU0cGQxbG00TEt5NWZ0RjVFbExkVlFhQWZNWkp4b3J5SncySVZhOW8v?=
 =?utf-8?B?OWRIS0hXSW11RDJTOWRsWmZFalozMlJyRVlPNmJOaG51anljRGNSWmgyeDhL?=
 =?utf-8?B?dzJYM3dWNDdlNzRDNXNxWEkyb1dpZkFtNTNnVGcyd2VsNDR4K3l4Y3hkTEtE?=
 =?utf-8?B?RTF2V1NIaHF3OWpHRDI3NWJjUW9WamVEOXFSbVVYenBzaWllaHQrYk1rUUJk?=
 =?utf-8?B?bUwxMDZWdFRaV0tCM2lnZU5BVHFvVjJOZE5BdXBTS3pZT1hKUm9IaDR4TnNB?=
 =?utf-8?B?UWNJMjJHWkVPUWtuM1BkUzFkQW5NRHJsTGhQdkc1Q2tjRm1hbHo5cVdQYUFL?=
 =?utf-8?B?Ti85M2VqN1JVTnRybmhmYXExRFhtcld4Q0RyWVJDRHl4a0w5TDRWbTNWQmZE?=
 =?utf-8?B?SkhtK3FXWjZMclZYZ3IyNXo5V3hVVXRWbXpET2x1MC8vL3NjdElxaHIwQUpJ?=
 =?utf-8?B?dkxkNklEZ3cwNnVsMGw5QVdMS0t6UGo3empUYWpDNkF3VEdoSWp2blB1MjVm?=
 =?utf-8?B?MHBWWTFDVGlBWVlFUmFpdGdGV1dEY0R0anBTSm05VldrMlc2dnBPL25tbldG?=
 =?utf-8?B?amwyUlJRa05MOVR2bldNRHVLYWxhdE5MTnhHMmpvU1Nab1Z2QW1WcjdCYURi?=
 =?utf-8?B?TVRCMGdnN3pGWVYrb2piWEJwRFZwOWJTK2svdFJXcm5sYkdmbHBWMFNQUGkz?=
 =?utf-8?B?YmppdjdtOGR1RTRlWElhUkttRlhtLzI0WDRBRC9oZXBDblprdndnYmtkQXZK?=
 =?utf-8?B?bXh6OUw1TFloQkx1cWhLdTQvQm02S0dxTS9TMHBzTFBlaGFOZnJSRDFvbjNp?=
 =?utf-8?B?cHIwYkRBMjhpKysvY1psSHVMcWFvTDVUOGdHYnZJcGRKNk5wTVJSVkF2VlBF?=
 =?utf-8?B?Z1hsRWordElsWTF2SGdkZXprZk5lRHdpVVlvdTJqY3NZOFhZOTMzdUZ6NTZZ?=
 =?utf-8?B?RTdnU0N3L1hINjlpNS9rZ1NUWktqTS9XSHVCcXZBTVMzbHFCeGZiK2Z2Y0Vo?=
 =?utf-8?B?a2luVHJSOFVzd3lmTVU1ZjRXNENLN3ZMaGZkSkN2SzBhUmdXS09EQWNtZStR?=
 =?utf-8?B?V015Rmp6Uzd6WTBlWkx1RkZSa2s3ZjF2elZnZTlYOW1TQVZ3c2k2aWpmelIy?=
 =?utf-8?B?dkVJVDZWWHFsdFl6SDdwMlh6cHRZWU9wKzJxWGVPRVg3R25XS2R6TCtJM3Yr?=
 =?utf-8?B?SEhRZU5yTTdHM0RJeitaa2xjOTZzVTJjQVMrR2FYV29qYzZDbXVUeW5DbmYw?=
 =?utf-8?B?MGs2c3lvZzhxaERNM3lId09TTHU3Wjl4SG43Zlh5V3pSeTZEdXRMN1IrcjE5?=
 =?utf-8?B?SDlCZXJwOUFpVis0bkpIZVgzbzBNNlBTbDBlRkxTdGt6RnpMUytTM2xYTlhJ?=
 =?utf-8?B?dXAzS0FvdVVhU1psUjlXTzFnc29Xd2pKKzFtQmtRVmpjeXRNbDlqNUlQbitZ?=
 =?utf-8?B?SVBaMmt4ajlNVVNYYVI3UjBON3lWeDM5NlNOczltaVNoTUJnR2xweWlrQkVz?=
 =?utf-8?B?R2dGMUhNSi9vR2tDSmZrL044MjBOaEZFZ3FNdlA1TGZvTkpBSDNxbFJncUl6?=
 =?utf-8?B?dEFHbWQzbVZlaXNOV2RZS2pYb2NVemtCd0ROQVNpUnZkTmI3cW1SMVJabGhy?=
 =?utf-8?B?ckJIYlZzUUxzWG5laFkwU0RZdGZRbWpmaWh6S0lEazNSK3ZmQVA0LzhHd0hG?=
 =?utf-8?B?Mm9qZHBEemFiSjREd3JneHZPQXNWM0VVNjRxNm1uUG5uMFpQaVQybWlqaXla?=
 =?utf-8?B?eTM3Nithb2hBMlpoTmpuY3ptL2xENHZzb2tUTWgvQUtLVkw4SWZ4VGt0cCtr?=
 =?utf-8?B?S1ViRTRQWDMwZkRQTm5aSnVRSWZBNno3V3lyUk9hWFdlT3BoZXlaVzFtWWpV?=
 =?utf-8?B?S0h3Y2pxOWcvWTdZelhYdXErSzBtQTRmcXVpSENWWHhsanNHM3k1Qk1YSWlM?=
 =?utf-8?B?d2UyOW8zUk04cDhTWWd2aDJzNENjZTZYL20xMk5YOURDYy90T0tDRzVEU3Vm?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e331f06c-7434-4f00-cc48-08dcdbc04636
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 11:10:03.9107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WOkPeta6AjC7ACmSifMqZw7kkf+5LD2Q0H/LQa49XDOVhkWO3jiQu4TVF4/rH1HnBj3WTgru25k0v3zNdCaVvyFD3xhDfqkgRS5Tjm8v/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10264
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

  Hi Rasmus,

On 9/19/24 9:01 AM, Rasmus Villemoes wrote:
> Quentin Schulz <quentin.schulz@cherry.de> writes:
> 
>> Hi Rasmus,
>>
>> For this patch and the previous one, should we have test(s) to make
>> sure we don't regress?
>>
> 
> That's obviously a good idea. But I don't have any idea how I'd go about
> writing such tests. AFAICT, there is no existing tests of the "find env
> partition by GUID" logic that I could amend, or any tests of any of the
> "find the mmc partition containing the env" for that matter. Pointers
> appreciated.
> 

I have never written tests for U-Boot so wouldn't be able to provide 
pointers there, sorry :/

> FWIW, on my end, I think I'll enable CONFIG_PARTITION_TYPE_GUID on all
> our configs and stop defining the real values of the ENV_OFFSET, so that
> our boards will start depending on the guid logic to find the env
> partitions. Which will then at least eventually find a regression, but
> unfortunately we usually lag some months behind on upgrading, and very
> rarely have resources for checking -rcX, so we would only find it after
> a release.
> 

Relying on manual tests is better than none, but still bad :)

Could it be something that could be automated with labgrid somehow? 
Simon has posted some support for labgrid recently for testing U-Boot on 
real boards, maybe that's something you'd be interested in?

Cheers,
Quentin
