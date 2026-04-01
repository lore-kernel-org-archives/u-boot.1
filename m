Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB257D3517D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 13:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16DD083CF5;
	Wed,  1 Apr 2026 15:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="K1tNW0jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1015983D8A; Wed,  1 Apr 2026 15:45:28 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D3683CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 15:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLt7GQRC1oF/Mgev2NcxF5msQS9HvwSnCD4auGr5GRZzabjN4FMEVs6hu5spqoHjZTpLHEwAN4cFxpqqNAezVj2cdE04nqyGIIGkpK4pJM8nGuxJblHzD7bCnFrqgk7ZZuus31exhaUbnlX7Y9tUyi/vPcUfIl3eN3W7U7N5mfMgWn6ROi+L9ogNphsZzZj8wtltBTQ2hOMaxPLZcykE7O6kuDlPytzyZvfgGYgamurfvOcHYgg+bUlo9dVl+ze4IWXnuGUQCAhW6RvR9YE9WN2GLm+oW4UqgwpAKGbmzcVe/vhVV/blGKXkRhDGPVkgLlxH5LHJ2Oxj8HPp4G0nCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E12hm+FkUVwNUhq/w1Lsazo0192Umt/eFwyotFsmoI4=;
 b=KelH51OgEe6IsUVcXUtFlBIhg5SFG9DLXvkRlxg+oT1BqL+pHU6MITydfeR7AK7xZnZK4TC5v9fDCFxXDLOyo510462fCKNChmejSyNfJWqDtfXuja/W/7HesDr0/BKkqVO22qjC1pV31cONpjZEhvQlp6PeoysPFcgIIz8kk9+hV1nriesX42J90lAAOzbkrWBTkFFkfNsGMtjBFOY1uLzuKdslbGQILDFLiMJUbQ9qLyS85AWELTUhfG3j1DpCU8LbydAcaZUUDPgt+7BbDXpjHjE968fmPlG0F63SpBJ8KKX7Fi09b5Z6JK1SnUZC2/0uRFd/+jUHuUqxs9nm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E12hm+FkUVwNUhq/w1Lsazo0192Umt/eFwyotFsmoI4=;
 b=K1tNW0jvhe/W364IULvUeg3omKJ+b5NxLTunS9BGhRVjM6/WHvlcRgc20aCYKxHS7FFW4qVbhekwucE6YPluQqqCSLpJ8ISKsU65u2kMn5y3V8Vq9xsqEUNLgXk1kfekY9XkNmwAfNMeFyzcQ0rYhz821mkSHHlg4eujn9n9h40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM6PR04MB11267.eurprd04.prod.outlook.com (2603:10a6:20b:6d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 13:45:23 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9745.027; Wed, 1 Apr 2026
 13:45:23 +0000
Message-ID: <39d33eb0-d6fd-4fe1-b1e6-361a2d4009da@cherry.de>
Date: Wed, 1 Apr 2026 15:45:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] console: add console_flush_stdin()
To: Gregor Herburger <gregor.herburger@linutronix.de>, u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 David Zang <davidzangcs@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260401124128.178799-2-gregor.herburger@linutronix.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260401124128.178799-2-gregor.herburger@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM6PR04MB11267:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc624b6-ac5e-4f8b-7a15-08de8ff4ec4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7rnL+sKADJKrFJq8ylaYHCaN4u7DXPL7V/JL0Z2Y+rtWX9nPM180ZXc3LsDbsay+EqBEUdSkyIPkASEKmrJzBB3NZ/aeLLxG28pAOrIXg/IqBTctJ9mFBU31gFQkbOU9vc7gOsl80mD55/41uwJHZBzxepm5gsRJ3FrIuhqTSrNlM9CxhIaNnxncjok6h+Km/ztBT3Y0UydzldMtZd6WQZAI+g0VC5ZkicpzII8DVroEW2oOq6H4YDQu54ebFazseMdEhio5ZnMSxTeVHxtjAZeYTUvWktXp7ffjWtHssb71CW1Yc2IGXmpOUzVvXIMMhe+sXC8pRDwXIbeXYLvLBJr/pCCP4oLPLTTmUm1GsEbmdVc4SsTnZkQzWDq6/lzlko56KQ0XLJfUoea+xkAb/U8k8m/LOXxElJjXEwO8ElaMZMgVm4/bEXN3ykpJ8nfswwfO66p7dupCJHGoPwJ0kzXbGl4LRgUFJGj9sIHzwt08UbbZkt440BfuSDkr52gGryerNZV/qMAYkWDP4d7B2O1A9BOPiDJQGtJTr/QHT4w8y4i4q2gRbupMfcDokq2jSjYANpQ+uqZftneGiZt4+vB7LJVJ+mVJQcLIlwdekboeDJ2mWcmFee2/qFrUb8yrP85karMUB2alDOpOMM77LguschgpXNk0etgxqNLQsIYB5K83BXFzy8EvvGTQ0boqf61i+CIT5+0vIEGhqGiEw9PYxe2b+MxIFDNO4+XDqj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VERjeFlUb3J2SDFjd3NLMDNMenFxRit5bS8zZFhvRC9Ta1RSS1AvL3I0ZzFF?=
 =?utf-8?B?ZVVkeDRLUW5YczVScTBYS1dpbllMR0RUV0lkRi9hVE11V1B3QUZac3lydkd3?=
 =?utf-8?B?TWNDMTF4bXNlSEVSdFRxTU5xNHFSSVRkdW1ETFlVRUtmTVl6UXZ3aXB5Ky9s?=
 =?utf-8?B?Y0VLSTBRNHU1bGVjOU1JNitwSTdJbkEzZmdVLzBYNlB3OFhVd0N1ZklQa2tp?=
 =?utf-8?B?cHdJSDRaNnhVcC9SSFZ5K0E3blJNV1ZaTXRqL1J3RDJadXBhSVk5L3NXSGVN?=
 =?utf-8?B?NldhMThJRFRKSWk5ckRwNXB5TmRyam5RTEluOVpwZUZUUExyK09ZSU9ncEpa?=
 =?utf-8?B?dDhkdDYvN3ZxOEVnZjJlVFhoWVd2SjQwWGg3K1ZiUUp6S214M2xpVEV6NEF2?=
 =?utf-8?B?a0FTUWhoUkd1Zmw4aXFoS0c3UXdVUUZUc2dITEdmVEVFSUZ2eVB5bml2MUJN?=
 =?utf-8?B?aXRneW9VV3l4QWhWa2U5S3FrLzhlYkRaYjh4NnU2M0RJZ0RoNDFCY015Vi9P?=
 =?utf-8?B?MkswMEFjRDBOYkV3WUx0bG9IUzYxMzJoNW9ma3NJR0JmMExZOXZ5ZXlvaTVC?=
 =?utf-8?B?K2p1a0dFM3A2Vlk3cVd4R1l1eXpvbC9hd1h6L3NJOHl5V1U5RW02cGhTRGRZ?=
 =?utf-8?B?VGZzdVlpWEdIRFh6aWswVlRxTjdhZWo1RUR3T2ZuTVlxbFc2cGczYjBkZHA1?=
 =?utf-8?B?SXN2V3AvYkkrRWZ0ZU5TclJwVlRVUVYvMlJHRzVQYlMyMFNvTk5XenZBVDdh?=
 =?utf-8?B?Wk9maUplNWhQbWlHZERDeS9rckNJNW1nM3dheWJlY0Z4V1dhV0JiK2txempX?=
 =?utf-8?B?N0VMYWZiMDN2REhnRkpTaEUrVkN6ZVJqbkVnd2wvbjhiU0xPeVZ4eWJNOTRi?=
 =?utf-8?B?M25LazYvVFpLTVpubXdSUnA5RHhrc3lNSnI2N3RkWHdRZVduNE9PeEdEQU82?=
 =?utf-8?B?YUg4MzIxcVFhSFFDcU43M0pmdDhRclhIb2QydUFWTXJaNVg5YVdlVEYwOXE1?=
 =?utf-8?B?RzVucVplak8welBxaEJydFVQaFpjTm55OE5SSWd1MTYvajNrZS9sN0tPS045?=
 =?utf-8?B?bkZ1blJoM0Njd0p6ZkpIS2FyRWZnOTJ6TCt4cjFidFBETHJ1aDhMTzhwUE1r?=
 =?utf-8?B?a283VS9vUnpwV1dBSklOMXJDMFdHR2dzdktRZ3hENytWSXVWbWplVGRpb0g4?=
 =?utf-8?B?dW56TlE3VkZEbTJyQjZWUTVaaTdEbU54QXZ1RlpYNUJxN1FBbXg1RGtzRlpO?=
 =?utf-8?B?M0hoNkJ1SDlNY2crc2ZXM1NlSzBTS0czcWZGMThHN1lUTE5hNXp4b2NtSFhi?=
 =?utf-8?B?SUNyY0RqQ1lzR0VOWTNOV0M3dFRRa01IT1kzUFBwTzRtbndZUm9hUC84Kzlh?=
 =?utf-8?B?cWxVRUNxZTI2eURGUm9Dc0w4bWlsa3VMODlTalZOSEwvaStVSzhNUWJpajVV?=
 =?utf-8?B?azBacXhIbTczUXZUK0FHVm8za0tHcTJ6VEJpaHE2bnQzd1R0UGU3RmZFK1FS?=
 =?utf-8?B?SW1KbFZibmI2amgzSngveGZySHNHd2tBc2R0RmFsSURYMlE1aHNic25XM1d6?=
 =?utf-8?B?UlRGSUZLbkxQaEcxYjRWc2l3Z0lIM0thOGxkaGNmNjdsNnNwWHpWSGlqNUpU?=
 =?utf-8?B?K21VUmRXV2ZTMHJoVUxiMWVTalVJOExoem1wQU9EMnVOSjlCZDhMVFJvRHl1?=
 =?utf-8?B?SERNVnVaMXpuV2I5a054dEI1b3gvMWpiZ1lHbW5RRCtvSGhuZ2tLTVZVT1JT?=
 =?utf-8?B?S256SlJSWUJjUTR2c0R0WWFlaWtGTkJwYmpOdVlGMmtqcWNFcGM1N1NPNUs1?=
 =?utf-8?B?cGRLOE9sMTJzTlR3RjMvWUJRa2xIWldvbmhBOVg3cU1BRDBzaTdVUGRuQzZ1?=
 =?utf-8?B?bTB5aXhIS1pHT29FSGVta1czV2pHUXFkNjhtQnR0eXZITDA1U3YxU21jMGFK?=
 =?utf-8?B?ZHVKQkkvRnpNVWtsamhQRzB4dEpsMHI5dkduYWNsQllUR3gvd1dGUm1ab3BM?=
 =?utf-8?B?MS9nSGZIa2xZcXRWVkZJa2pQYjM5MWo3cURRdVZEaS8xUFpuOE9iN2hScytt?=
 =?utf-8?B?bkZQWURHNFFLN0VBVDQrRlM3SDNKVWsvejZnaWdLNlJvOEJiK3Z2N0pIVExq?=
 =?utf-8?B?SlJvOFk4VUNwa01RY01oTm5ieGM3SHpBd21xWkhYUmprU3ZWUE13ek1RSnJl?=
 =?utf-8?B?cHkwUU9qc3ZreGMxWWhaZlA3TGJkOUxkcTJKQkxIaFVkeDAxbUpsazZTL2lK?=
 =?utf-8?B?T2dBREtvZzkvVzNyUDg5d2s4TSswdmsrUUNvZ1Q2K3FGYW9tejhtdDFxc2tG?=
 =?utf-8?B?OWdDTXFSZzNKVXY4UytwRDJNQkI0ZmVyT3NUcmk4Y3pTbU5XWmJrdlFiNFR4?=
 =?utf-8?Q?JBYc0UrdQT/SO8wnJaV1R4oSwJGNfLmg9GuZQ?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc624b6-ac5e-4f8b-7a15-08de8ff4ec4a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:45:23.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sgmb33pSyWwvvwQl/wit7eC0jk8+zScS9dVfYqdE1RubT1XJfIBbsuMekL0Gh1bkxXX28rt+naKhgfPk9bKoMyM74cbo5xjYCCUVzZTIO+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB11267
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

Hi Gregor,

On 4/1/26 2:40 PM, Gregor Herburger wrote:
> Add a common helper console_flush_stdin() to drain all pending
> characters from stdin. This consolidates the open-coded
> while (tstc()) getchar() pattern that appeared in multiple places
> across the tree.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
