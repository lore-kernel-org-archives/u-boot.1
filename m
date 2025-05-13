Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D55C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 10:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAA78129F;
	Tue, 13 May 2025 12:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hQ1LJP2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA0A81DD6; Tue, 13 May 2025 12:07:19 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28398091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn26ALfX3DyPLJvYGEV3HVgTKosIK2aw9hZSpvPT2xBAYkROAGi4J5EnJbWa/kgOzvcYR66SICFPp3YLZS3+F6xSnzws+Hkax+QXigZLnSdv8YnCXh7NIfWNfCA3COTG7qF/CREB8r7epwisYkWSm8jqBI+i4otxz52vT+q0MNUhaTDz2io8YwRVMiMmDiPsEb/ty6YW8vzlM76wW/KyuP/j2mWKOveJniEuAG5okuLeji1MyHrF7qJtaTXLKHvZ1+JdvrrWIOoLUJPFwkm91xqiDSUNS0hJzUcDnQ9zZhs6Ba9puH0/rhDmkbI5tRGzeHeEIjd8v23QfRxhrWaCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99pZswnr/H1buXCZYW015AUr3mLy6OsrpkHhWftYMRY=;
 b=E/pMYYYbzjtVrZqx5b2RkrtldbLaCoqObHxKnqqVWDkGTZgYTBoMbgzNW1SOArmf3BqJl6BHkSlUvH6636Sfzonm/38o2S3vTzgxlDGzNLGMaJV0i2er5s7Hd4Tntqab4yVQtJ5c/78sJNlWWrfX87wbdB9DK7PxkX5ZjoEKotkSJgbh6jgIHCvc3mReBu2BT5yxjZXQtqJyY4xbCI/nNAsv7dqRhC0l553EcXUD3W26zgxI0xLFlBlpWeP2aq+iKdaGvQMovXwOgi9s3T16qHQL+IxjTawZM+gcJpMFHb78Y/hqt3YhGd7HrXYBs68bu4VdfPSX4DfEAXslI6abfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99pZswnr/H1buXCZYW015AUr3mLy6OsrpkHhWftYMRY=;
 b=hQ1LJP2H8NPQHV1buqpAj5hepSGDIYsp63FZUS45li9KbKvSEXyDIJC8NJtiamDagyEz+1UAHQGz7VOUx2nTavCAQ7eFg7/nkNGmR1AnXFyq2SU2auEJgGxEA5VuYlzT8WO5s7QFZePR9NddnjROT48nxynIDIBratASf1Nj7V8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 10:07:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 10:07:15 +0000
Message-ID: <e7bb5ed1-735d-4438-b052-f3ca31d30f1f@cherry.de>
Date: Tue, 13 May 2025 12:07:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools: binman: ftest.py: Add testcase for bootph-*
 propagation
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com
References: <20250512115028.1783305-1-m-shah@ti.com>
 <20250512115028.1783305-3-m-shah@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250512115028.1783305-3-m-shah@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 9711815f-1b9c-48f5-e562-08dd9205ef8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czkrTFIyK3N5dlg0clp5Yk9Baml4aVBNNzdZUElIRzJRUFluMis1LzRvMlNT?=
 =?utf-8?B?dzVJMENlb0ZGMjZ4OFZQM2oxM1Zjd2ZDN09YK2pibGMyTTZ6Z0gwZXQyTkNR?=
 =?utf-8?B?RVhKenNtaG5lb1VEWWpGSVA3RldrRk9TUG80N0luUWV6RDJBZm1Wb2R4VWZS?=
 =?utf-8?B?SnVWM1ZSNDlHeS9kM25pY3BiZk1RRTBDeUNnYjNZTVRINGhMRDNuYjNrdUxt?=
 =?utf-8?B?US8wU29yYi9CZGNOb2NhZjFSVllWcFVnMFlQbXh3VDdOby9uZUVieGdQVnV0?=
 =?utf-8?B?VCt0QW9WYm5xV3ByQkV6S3ZSOG1IWEN2UXBLd29nN1ZGSVRYcUlSQzEvZ01q?=
 =?utf-8?B?Y3htMmJBOGV5cVczMnJtV3o2RWtJNktLazlKbThXM0loMno3czlCMno5Qm5M?=
 =?utf-8?B?S2ZiTE8yQmpuUkhvVWJGcVZvamJidHlUaUNpc2g3cVZycStlODFqUHhvVEU5?=
 =?utf-8?B?cTFFd0twMlczNXF2M05nSGdMWkRvNmM5WjhWUFJqUmRJN1AwbUhnQzVzemRl?=
 =?utf-8?B?bGpTRTY2YzFCY3p3dHMySzNMamlpN2JoN1ZGZVNYT0dNZEdpb1NSSE5NeDVI?=
 =?utf-8?B?cis4RVZCdUJWd2VSQUo3NU03M1U2NlVSUTMvUGdWV3lOSEtpc1RWS0ZMUU5U?=
 =?utf-8?B?ajRDQS81bklwUjdnNytwTlRUbmxTK1RzWVFxNUVxT0d5S0FKRElIaXhRWlNW?=
 =?utf-8?B?ekhOcjZnazluZ0VtUDc0ckFycVVCTVZoeU9pZzMwM213clFpSU9jU3dQOHNp?=
 =?utf-8?B?T2o4bEt3WDQxQnhSV3R5bXVTNWZvV2hxRFRaT01TZHp0ZENzSTBsd25PNHR1?=
 =?utf-8?B?Sk5NZzNxSW5FaUsrQWxEQ1dLYnk4NnJ0ZUtpQlpUdS9wU3JjZmNNTW4zcUg3?=
 =?utf-8?B?ZzdKU1h6ZmhrTkhUZmhlbEhiblc1eTZCRUFsa0ZjUGk4dHRXTi9DMFlrbS9J?=
 =?utf-8?B?V2pqNTI0aGw5NnZ5bW1Na3hxTWQ4MzN5QzBNcmJOZ2lnaFdOTHRKVzcwRmhP?=
 =?utf-8?B?SUs1VTFZUzJtZHpObTluOU5wWE5kNFhkS2xkb1U5UTNuZU1Kc0NHSlBRMmZT?=
 =?utf-8?B?MUNtY1FMZGxKQmtIbldFbHZYczlLYTRqZkVGOWJUc3d6RFAyQWYyVzI1LzR6?=
 =?utf-8?B?TFh4aUppMVdQRE83bXQ4ajJxOUo0cUtXazE2SEljb1B1NjRtbnFTSWxCNWxL?=
 =?utf-8?B?cmFnRE9wZGJ5MmJsaFpGMUdyb0RFWXJIMHVqNE5GeW56bjdndVpQWTl1WUYw?=
 =?utf-8?B?MXdHaUlnQ2tvbDFjMG1VVGtBUE1zUzNJWkhqbG8rb04zQ2g1QnE2cGwwdUZ4?=
 =?utf-8?B?VzdBdmxPQmdEVFdXWm1HSW1BM0grUVhkL1pkNmsvTmFQaTNtOVBiUXJBYllB?=
 =?utf-8?B?R3JCK0NlcE9KdWhXdFVSSUNrRkpPK2lDbFhrdDA0UHRYbXpsc0NyV2x1TVNU?=
 =?utf-8?B?RzUvTTF4WWkxNUU3eVZhMHlZN1IvMzU3dFVBMXNWa1p2S3JOSjgySVhYS25Q?=
 =?utf-8?B?V2M0bW45c1lQRXlmOFZCYXo4bFhoUHBsUzZBd1hCVXBhVzl3NlhlUGxZM2JZ?=
 =?utf-8?B?cG5pZWpnVFFvYW1DR3pzTDczanhMWUtDQUdYQXdNMXYxekR0bEQ1VmlNa3Bw?=
 =?utf-8?B?OXh4ZCs0Y3lmbG9tR2Z4TVk3b2QxUDFtejMxdFczRXRDTW94NUZlNmdZK1lt?=
 =?utf-8?B?SnJSWmFiTm5FMDRycWxmd1l2T09GdWJnNjFjZ0hUU2w1Q3orcnJVYzFJU3lN?=
 =?utf-8?B?dWtGZGhtV1UxM2dMMk1WLzcwOXFHUG5wQWhHZFFuZXNSYTFGbTloY2Y3Tld4?=
 =?utf-8?B?Wk50bHlZTnFyeisvSEdrTmphSnZQR3kzVkFHRExIU1JZL0l3VnQ4VUY1bTdB?=
 =?utf-8?B?N2ZESUVsdG04MzI2WmJVSGhCUEIwYS9FMFF2QmpydlI1OU1GdThoUE9EeE1J?=
 =?utf-8?Q?gsG593KNNaY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlPeDY2NEJINEZvU21OSnVXdklENS9iaGdNRDAvQTBDMzcwa0lvY1BaZ1BQ?=
 =?utf-8?B?eTZtR3N1WWVLWk90dDd0KzJyVE8rRU1KaVpLVXp2eHJaekJDdDE3QjhScDZB?=
 =?utf-8?B?OGt5REhtTlRkSFFZaWJiV0RXRmMrTzhxZUtmc1JEdzZkTDJZM0FTZis2c2hm?=
 =?utf-8?B?anZRUGNHUmtacVNEQllXMGtqWW5qUDE5NFo5WWJ6SE1Hc3VZaWJnOFJTMkNR?=
 =?utf-8?B?UjNoT29hY3hHWUFHcUFpRnhmcURqUWViRlJINWFrR29vOTN6eHRjS0FFdHAy?=
 =?utf-8?B?aWpvNmwwZlZhVWR5dzB1RHJmMm9GcFVOYXVLb083azZnaEtLdTJldFBES0lW?=
 =?utf-8?B?Ky9aSTBBa3ZWbU5QUFF1cW1vU1JpVHNVcFJIUXVqOVpxb2pLMXJBaVRzcHRP?=
 =?utf-8?B?Vlk1enl4NVluYnQwSFJnSzFLdTB2SFRuMnFEdWhlRFVyNFFsQUQ3UVkraXFP?=
 =?utf-8?B?YldJNitRRFJTNGxQdHlTbldvdFcvZVV3YWlMNTBZUk9xanR1OXZBb0xXUWNQ?=
 =?utf-8?B?eGZJUStlQ2N4NndDVFVwenRPRjhYZGFkakxrcyt4S3Bia1hFU2s5Q2NHdEhV?=
 =?utf-8?B?cU1mQ2RzTTBoYUtKS2lEMlBHVFgvRTlKZ3d1TlZLcGo2T0F3b1lWT1ZZZ3gr?=
 =?utf-8?B?VE1EVFl6ZGNjclJzWlhmSi9OTlZSc2xqeGRBZVBzdCtOMS9vbFBLRDErOWlF?=
 =?utf-8?B?UnZMdEFoYkxoM0FNRFJ5Njdhelg2dE9sUGNjK2QyVlB2dTNXMnJsWkYzcXlC?=
 =?utf-8?B?VkRQWjd0bE1TdWpiY25oOEdqMzN2aWw0dmJSWnB0RzVPT1lJZUJ2MTlvQ3Jq?=
 =?utf-8?B?NE1MRVhldmt6TTljMmJBRkpTOXJIUXJIWnRFVlpZbm5jYlFQa1pkaHkyUVVO?=
 =?utf-8?B?bVl0aEtuUWRoNXhPenNXeDkzbjhmMUtpTmhIeFg5T2FxUDM1cXZlbFZkMy9B?=
 =?utf-8?B?WGczVlVESGROYjZ6UGF6M0QvTzh3UGFWYzBhVThrQ3ZEbG8wT2RjU2VvOXpy?=
 =?utf-8?B?azBvNllMajJrTEJjUzVjZkdHVXB1Nk44VHgrZnF4cExJRjRiQVp1cE9Lbm5D?=
 =?utf-8?B?UEVuclNDZTRRN1RqS3ZrQkdqQUYzSkhWdWVyZlJiWWpXNjIxVk1aNG1JVWVC?=
 =?utf-8?B?QlZlcmJoa2ZHS2xTMnp6NXY3WHlnL3h5MU56MDZFaDZJc2FxK2o2U2ZJb3hX?=
 =?utf-8?B?TTNmdXZsQWVBcEh4YWl0MHNibEFEbi9QbXZLMkVxVVdmdHFJZXRvK0Y0Z0Ux?=
 =?utf-8?B?RWlKeG9iZHVlQVJEaU1GL0N2Rks4bU14NXpnenN4MUIyZFhncEhBK05WN3B0?=
 =?utf-8?B?QnRYZkJZZE1iUWtFT3BvUWlsSkJVZVYxZ1VxS1FmV1BjU08zeG5vYUI5anJl?=
 =?utf-8?B?OWJ6Z1JNc0tjUXYrbXVPeEhyQ1l1NWtXekJGSGg0R3dNMU1xU2lDZ3NqRkRV?=
 =?utf-8?B?dU1JY2d2QkxlRG92QWhBMU1JNGNyY3puc0tzYXY0ekNlSUpNMEJIbFNURjla?=
 =?utf-8?B?RDhOSW15cit1ZGQ5VnAyeXYxYUlvUFVvWEZqcmpINzJCUUtaUW1oT0NJS0Uw?=
 =?utf-8?B?RWIvZEs2NXMzVlRRbzJqSlZ0Umg2ZEtoQ0R1MHRxU3Q5NEtoOTc0ck15OHRO?=
 =?utf-8?B?Wko5eVZPN3pnK1hOaGt4OHFyUytEaFo4bEMraHRNbStmNnhROVpTbnd3dUdj?=
 =?utf-8?B?R1NXMVBKSmtvZGFVOGFReXowT1Q3azFzN3AvOHp5VGN6NTVSVy8zZlVBR2JE?=
 =?utf-8?B?QWxkRGlIUXpJRS82TW9UakUzbDVZQkc4QTdsRW95Z2xMTFZMajVIalhLdk9x?=
 =?utf-8?B?VTh3WXpFSHRneWJ5OHRXaFI1aCswc0NQU1liWDV0aFdIdENWWDFnMVVSeWg0?=
 =?utf-8?B?czdVd0JZK1poQXo0cktxTXRveHJkSlRtYzZjVVBXMFZETmp2eTlVMTMxMDh6?=
 =?utf-8?B?ekdBOG15MFNaeVI2QWJUcE1rU1pDc1VaZzB0OVBaN3NGa1JuN2Q3MXRkWndu?=
 =?utf-8?B?RGoxM1liUjJiQlM1RFIrTDh1NTRCMFB5ZkUrdGRCL3FqeUl5ZTI5cHU3UGt3?=
 =?utf-8?B?TWlIZy9XbFRUM051SUVON3Z5MDg4TkZEOXNvUFVsMEh6Q0FuSXZPYy9Fd1hi?=
 =?utf-8?B?dmtReGVuUi8xSWdCblBKVTZUcldFcVhmMXVWd0ZIM2RZQnRQQ2VNNkgySXIv?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9711815f-1b9c-48f5-e562-08dd9205ef8b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:07:15.0090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TVEPg1ST7kvs63rLyQBF/OPXrm95tZf9rBey5oLMjXtBbK3vhi3XE5si9TUcleW3J9u6e+hRU+matRRAQXIYvesNNKSy9kp4gufB1p8MkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364
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

Hi Moteen,

On 5/12/25 1:50 PM, Moteen Shah wrote:
> Add a testcase to ensure that scan_and_prop_bootph() actually
> propagates bootph-* properties to supernodes.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>   tools/binman/ftest.py                 | 22 ++++++++++++++++++++++
>   tools/binman/test/347_bootph_prop.dts | 19 +++++++++++++++++++
>   2 files changed, 41 insertions(+)
>   create mode 100644 tools/binman/test/347_bootph_prop.dts
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index fa174900014..5c3138b271a 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -8011,5 +8011,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>           self._DoTestFile('346_remove_template.dts',
>                            force_missing_bintools='openssl',)
>   
> +    def testBootphPropagation(self):
> +        """Test that bootph-* properties are propagated correctly to supernodes"""
> +        _, _, _, out_dtb_fname = self._DoReadFileDtb(
> +                '347_bootph_prop.dts', use_real_dtb=True, update_dtb=True)
> +        dtb = fdt.Fdt(out_dtb_fname)
> +        dtb.Scan()
> +        root = dtb.GetRoot()
> +        parent_node = root.FindNode('dummy-parent')
> +        subnode1 = parent_node.FindNode('subnode-1')
> +        subnode2 = parent_node.FindNode('subnode-2')
> +        subnode3 = parent_node.FindNode('subnode-3')
> +
> +        self.assertIn('bootph-some-ram', subnode1.props,
> +                      "Child node is missing 'bootph-some-ram' property")
> +        self.assertIn('bootph-all', subnode1.props,
> +                      "Child node is missing 'bootph-all' property")
> +        self.assertIn('bootph-some-ram', parent_node.props,
> +                      "Parent node is missing 'bootph-some-ram' property")
> +        self.assertIn('bootph-all', parent_node.props,
> +                      "Parent node is missing 'bootph-all' property")
> +
> +
>   if __name__ == "__main__":
>       unittest.main()
> diff --git a/tools/binman/test/347_bootph_prop.dts b/tools/binman/test/347_bootph_prop.dts
> new file mode 100644
> index 00000000000..2bcc116cb4d
> --- /dev/null
> +++ b/tools/binman/test/347_bootph_prop.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/dts-v1/;
> +/ {
> +	dummy-parent {
> +		subnode-1 {
> +			subnode-2 {
> +				bootph-all;
> +			};
> +			subnode-3 {
> +				bootph-some-ram;

add a subnode-4 here as a subnode of subnode-3 and without a bootph- 
property, then test that the node doesn't get it. Just for the sake of 
completeness.

Cheers,
Quentin
