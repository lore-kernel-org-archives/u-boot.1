Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AA1CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 14:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411228323A;
	Wed, 22 Oct 2025 16:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="naK8tal1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD1A832BC; Wed, 22 Oct 2025 16:06:20 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFFA82B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 16:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohzuCs8iek4TjQFsvHBJvuN7QHle9vQV70RuMOJ6axEQleyDHvytqqHi/dTGnF4I/s9aWRiBwl2gjlPmH/MnrXwqvzgwYV1avJI6cMzwvMUoamVSiNCtcTXR7ltukz6Jq8IgO+ORAk02dRwatloKVd8Tton+xyUIRWcO0eFkCD3G7E7nrn8nH/CHdtsy1sZAZg9mAYiwSTp5ht2PYmGsN2zPkGZ/0S6yfRf8fafjiY+W2H+JNzqSwrBFFqG/eZPxEhxH2jdoaurzW9wRxaxqw+FazSBJp+jmocY7celeAaLVmSjpE48Lz15CIxDDEvTpzXN8NfVSSv6iB+Si9cRYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpEiouHboDNJNV1yJ8ARvJFS5urOo+0LQ5j08XLCGi4=;
 b=yap2CWo03gAMOg1jJmyoOCpECM96gkXaxG5r8gdUhHBpeX8aqzJO3Zb45D+sfmcgDxj2p7124Ck+J2fEg9tQ0ty/xZV9m509gdLW0wKHT5cHGokDsmqLHHup3sMRMgaEH7DP4r6UibrYEI00Uwgwag9BB8C5NRinuw9tHYgsCDhL5AyO/Y8hubcdpET4ONe8H8qFnxPO4WjYo+xRYkPaj8AtlX7vgI66yt2/gWyM6NN4gvNRicVOd+z7lPz4RaVEHbG4Dvs/TCU7FQox7b9rJtnEmCWJD9NS8vamOmEoFczxYoHo0IeK9lVieeNS1AhWVOdyA802Myj2cjLvkE4Yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpEiouHboDNJNV1yJ8ARvJFS5urOo+0LQ5j08XLCGi4=;
 b=naK8tal1vwq59QrPCvARBGSZSJOJBn9ROV0J6+WMRGXr0LZpZte/bZCxMIb0nhAmXw7BpOSKQX0/3Z1b24NwFddk9UEoDE6pTRN6X4iANECZxGJGwm3b+2iqp042+MQKKKbX3ELQ40OiBstLtvyo49m5XCTDvYYx+Zi98u9+zzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10644.eurprd04.prod.outlook.com (2603:10a6:800:276::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:06:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:06:10 +0000
Message-ID: <cc194cf3-ccca-4e66-b3f5-e60cce7da20a@cherry.de>
Date: Wed, 22 Oct 2025 16:06:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] doc: askenv: Reword and remove return value
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251021202820.1272414-1-trini@konsulko.com>
 <20251021202820.1272414-3-trini@konsulko.com>
 <0fb1e175-6e50-4f2a-a1e2-98ffe3108998@cherry.de>
 <20251022134929.GH6688@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251022134929.GH6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10644:EE_
X-MS-Office365-Filtering-Correlation-Id: c553c1a5-18c7-4471-8ed6-08de117426fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWJlT3Q1MVFUc3lpL1RzbHZvaHdYTVREeGhtd2QwdDcyU1pJd3A1TUNaMktj?=
 =?utf-8?B?QTNHcHV0bkNuOXdSRnZwY1B0VEJtYmROWGE1QzVWUVFQSlFPQlpieHU3QWQ5?=
 =?utf-8?B?cXNGTlByeW9HcVNDaEl3Q0h5TTBkdVY1Z3l1cUplWGNyTG51QzdCVEhpMWNS?=
 =?utf-8?B?K3ViWURmNUpkeXpJcGtITFdaeS9mTUF5cWhDWWVTK01RQmV5Qlh1MEVxdmhl?=
 =?utf-8?B?d0lOdFFENXhERVU3WG5nMTEvOSsvWXpxV2RUL1N6QmdDWjBla3luOUVKcXUx?=
 =?utf-8?B?b1hZTks3aHdpcysyb3ZsUVhKZTI5emtRT25BbHR6Y0FrZUhuZGIxcWNYSWdC?=
 =?utf-8?B?UjZyNFZvei9uWjlydFBOL2M0aEpqUGF4SHFld0ZuSC9nckU1L2xrQS9XRDc4?=
 =?utf-8?B?Y3FhZENOMkNTMnZ4TUZqQ245MGV0dFNBSzFCNGZ2RjVIY2I0L1ZLaGg2cXZz?=
 =?utf-8?B?aXpIRSs2SzY4UnB6ZWUrUklsTzJxRVBvMHhRVktDNlNhem9rVm9tVUEydHF4?=
 =?utf-8?B?ajNXMFNWZDFESnZ6WEZIL3dPNjlRdmZIeW1NdEFaS2ZDeE8zNmVHRGQ2eTdw?=
 =?utf-8?B?U0N3Qlc0TjB5d2pRb3VUMzdFVXY5ODFrcTMrcnpha1h5VHNPQUs1WnJod2tv?=
 =?utf-8?B?U3lISFFMMTZ0Y2VzYmVmQkVDTUF3QWw3L1B5aENUNWdLczJTZmFiYnlxNXpw?=
 =?utf-8?B?K3lRTmY0dTFha29IRm5OY3U2dmdSTkIwYzZnRnNCVmJpKzlnV2gzVW1Kc3Jn?=
 =?utf-8?B?c3czRlNYZmc2TEtxOVZxeFZBYnZrNHlqT2tYU25TMnlkTnJtYUtJdnNaRy9r?=
 =?utf-8?B?bUFoOFVLY0lheFhub0NwSmZTcCtTK2R6dGZEUnFKSFUzclliWUI1aytCVVNL?=
 =?utf-8?B?VmFYdGdMSmZJUHlXRDdnY01GUlJjODltNWNESmt1aDBxZkpXekZxZk1DVlox?=
 =?utf-8?B?OUtpcTNsMWVmdm0wTUVwUnFCMVZ4VHUvb1o0Q3ZRRE8yU1hYZzBxaHFHbm8w?=
 =?utf-8?B?MU56aVZaeHloL0NEVXlpMFlLS2RLRysybkd0Q0ZPRktYaGhWSU5kOXUyOVdI?=
 =?utf-8?B?Q1RicXZlQnl2OFAzSnErc01Vc3VuZE5NalJXVHRFc05BVG44YkhHSTJoV3hr?=
 =?utf-8?B?UXBMYStTdHpwNTUzRDRJQXVDaExmT0ZIKzB6Mi9ud05lV05WdGZFUE1Ycmd4?=
 =?utf-8?B?bHBUSGlIT0RJejdONjV2QjRjaTJBakxVYlBudnR4NWhJRW9SdWhvQThvTVJk?=
 =?utf-8?B?T2F5VUxsOE5GeDlsU3pkU3ZWQlZUT1BEZjFpNlV4N0s1VVpLQnZnSU00WGhj?=
 =?utf-8?B?THQzM0RzKzBjazYzci9WTG5qSGU2QzZTNG5kQ0VvZHh2d2NEL0htanZEQTYz?=
 =?utf-8?B?bTZpd0dPQWhTalI4WVRBQjA4ZFJGYzdpa2tUNk51TGNxdGpwWVIycUM5Y3Zh?=
 =?utf-8?B?Nk9vR2dOV1gxbFVwNnc1cW1LQkJaYnBOUDcyTzBNdUlQZktmc3lHQVNlN1ll?=
 =?utf-8?B?czJIeXhUdEUyMkowUlBGQlJuTUpDeDBOeVoxakhOV1J3TFpnTmRad0lmOU9z?=
 =?utf-8?B?TG1JaW5EMzhkR0RLWGtyeDM0cmFralkxcnUxTWE5SjdZNHJqZEUrbHpodFNY?=
 =?utf-8?B?ZW9OejVCeGF4U3ZRczRNcFVpVFFkeGRSaWRTNXhSRU1jWmYvcUluWE5jV1hO?=
 =?utf-8?B?UC9yVGgwTDJReDVneE5lbVVuOCszcEZDbHZ0YkJScUZTaUR3dkNYa24wYU93?=
 =?utf-8?B?NGNISk84Njk2TTRFS3NiZEJ3WWhMZjF0dFMvUU42aUxvRi9nbFhLVXV3cG0z?=
 =?utf-8?B?Qkt5R3hvRVFFa2VIUmRPcU9WcEZBRitmeGhyU1V0S1VadUpHYmhnMDRjQmxO?=
 =?utf-8?B?QjV5dm1oNWNiMC9STDcyUXFFdFZrdXVmSitwbHNIdWZNdkJlcnF0THUydmxG?=
 =?utf-8?Q?ATPfN7XF0ZpJGysOBki5U8IW/VVTkrfi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U09xdG5RcE1tM1huZXo4Vm5BaW80b3YxTG1DMllubS9icWJNNFdCRzFrbU54?=
 =?utf-8?B?QmNaWTB0N0Nyc09QdzNqR0x5cHFVSXQzK3hjclFpemw4cFhNdC9HbVRtNHF6?=
 =?utf-8?B?TW9NcXI2MlhjeEZMS3oyd0ErWU1wRklIYUNZb09ISjR5T2ZNM2tteWVjZ3Y3?=
 =?utf-8?B?MEVsRFBnUDBaNE5DaDlKTHFWa0ljSVNoSU1GbWFPajJlS0VXRTlOZkNIVmFi?=
 =?utf-8?B?eWN2dkUrZE5LbCtIRXFUQVIrbkt2RC9vSEF5T3RNWGllaHRsOUxnU0d2U3dM?=
 =?utf-8?B?WitaWHk4U3pDMFpqRHhFTm5DSVlsZEQ4WWpBaG1xOVpnSEtobDJMclAzSW1K?=
 =?utf-8?B?blhvUlB3a2VtMDhDQkZqYWZWSUF0d3JNSW5pOXhGb2pkWmZnaDg0aTFXOExl?=
 =?utf-8?B?dSsvK3JWZGxucG15Smg2ZDhHSTVuTE9rL2lxS2lGZURjenBhUjJsV25tbGt0?=
 =?utf-8?B?ZTdoeTdYWnRaQlJOTlk5dkFiZmkxY05Ld2JFV2NHTDc4RlBNMnU0QUc2MkE1?=
 =?utf-8?B?R21kNFdBQTZDcmV1VFNsWWk5YmRIYUtNMWdySFJ1U3E3WE1NeGs4TVdVUVZ6?=
 =?utf-8?B?SlJUWVRXUVMyREFpdUplbVhzeElCL3hjMzUxRVlFSDN4dElGdWpZaStmS005?=
 =?utf-8?B?cjlhNjFtWW40LzY5Ni9wUmRPY2lKYmpUOUZObHh5dDF0REFrUTJHeDFpN0RV?=
 =?utf-8?B?czFpaGxLa1J6QWVFczVHVnpxQ0VuNExvTCszTXMxa09vNFFJOUJtZVBGRGhO?=
 =?utf-8?B?Nk9LR3EzQVdCOTVqRDMvTytjTVdqdzdYbkdpSmlpSjZqS1RYVzc2RzZVUnhH?=
 =?utf-8?B?L0VzMkc4bW9MRHg1QmMyY2pKU09TSU02Q0hqMEtPYzgrWGFvQ29xVGNrSnV2?=
 =?utf-8?B?MmkzUHdnd0J2OVM2dnZObktRNGdIV1NJSDQ0VzdvcmdtT1FWV0ZiVlIvWkNS?=
 =?utf-8?B?c3B0dExyZFFYa2xJYmd6TDk2VEt2OFRtNDdWTldxQ1hDT2E0eDNFTmdkVGx2?=
 =?utf-8?B?R2RlUWp5NDc4NUh1eWtvaHVnaVB0RGxjckFZdE9aRXBqV0JHdURnY0FKNjMy?=
 =?utf-8?B?UDNhN1hMektVblRjdjlNanVNS2lIcjJoTTFwRGFDWTFCU25FSXM4SC9HZmF2?=
 =?utf-8?B?cFJDRll4T3FIMkxHbVNHRlI3d1FtUnZKT0hYckVKc3pNZWJrUWJiS2R3eFpj?=
 =?utf-8?B?YWl1RkFaMG10ZGd2b0x6bDZva3ZtVkdheC8yajZDSjR5bkNTOENnQitQNU93?=
 =?utf-8?B?VUV1R0RJK3BiWC9ENGw2YnBBRHFLOTVRS1k3NEg0bmtwa0I0UWRBSTMwSFVr?=
 =?utf-8?B?M3NYK1BBLzRJbVVJMk9TK2I5c3lXTGVZUWI0S1hscS9Cd1BkelEzK1pHWVBp?=
 =?utf-8?B?RUl1bFFEUzF6ajhzdmRRdExMcnhnRmJQbzNIVldiUUhFdC9nWWgrQzh3d0FS?=
 =?utf-8?B?b25UeitqZGQvc293aThGVXg0dXdhZ003bEoxR3EvZktqZ0lub2t4eHpoWXp0?=
 =?utf-8?B?TnRkQjg4SWEvUHJMU1FBai9ock9TNTFzSk5OQ2lPYWZncjAzZFduUHRSM2tM?=
 =?utf-8?B?OGFOT3o5cVREY2w3VWlsRjRpLzJ4WUMvNmttMXNBQXkyQ3NLWWUzSC9WMEo0?=
 =?utf-8?B?YTF2VXZTcC9HSTJ0aTRlbit0ZVZ4V2pIRGNXME53b3lGckQ3emJkRTRncmtp?=
 =?utf-8?B?N2JsVTFDU0F0cGljNjM2MUVUSkVSYnpjSjZtM3Z6ZzNndGdLaC82cXJLSlpU?=
 =?utf-8?B?S2NpWjQ5dGFtZ0VjR2pDcnZZWjN2Z2VkbXEyWG5KYjlIWCtHSjNjV0kySG9y?=
 =?utf-8?B?ZGYyT2MyNStHK2srd0d2VDVPejA5UVFmYVRySmhUYWRUTmdQWm4xbDdqNTZS?=
 =?utf-8?B?WHZTTTdsb2NxWW5hTHc1emFJazFuYlA3UnBROG9JS3p2N0FKbjhubkIxY3RD?=
 =?utf-8?B?T1A0Y3lyU3RiNjV6akhBVjdqUUJOa29ZK0xTOEZOeHNpSkIxMFk3TzRzSk8x?=
 =?utf-8?B?ZzMrS3pJT2psZHlLYVEwOE5yT1crQ3F2SEJacXlBdWNOWkNMUGFMV0ZGV2pp?=
 =?utf-8?B?bnRTR1RuVjNzWUQxTHdkeXVYLzQwRzRaVE1Rem05SDcvRWtna1BzU2pkY1E3?=
 =?utf-8?B?cXJ4bnJXTjBick1wNmJjcVEyY1Z0NmpYWFYrMnNFRzdZa3JiM25OYjRqYmRx?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c553c1a5-18c7-4471-8ed6-08de117426fa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:06:10.4988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWFyrBvRi0o4PfvfuTRaeh8tR+32hFoH17ZAeFaW7Cmta2sI+jvA395Z1zl2UnFFRr5Z+De+5x1sOny9q0h8BwhHxLrzqqTkFXrB6MhnB/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10644
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

On 10/22/25 3:49 PM, Tom Rini wrote:
> On Wed, Oct 22, 2025 at 11:28:15AM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 10/21/25 10:25 PM, Tom Rini wrote:
>>> With the addition of general text about how the return value is handled,
>>> remove the examples from the askenv documentation as they are all normal
>>> expected results.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> ---
>>>    doc/usage/cmd/askenv.rst | 27 +++------------------------
>>>    1 file changed, 3 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
>>> index e2b3c5379aea..a8867ce4d266 100644
>>> --- a/doc/usage/cmd/askenv.rst
>>> +++ b/doc/usage/cmd/askenv.rst
>> [...]
>>> -Return Value of askenv command, when used without any other arguments:
>>> -
>>> -::
>>> -
>>> -    => askenv;echo $?
>>> -    askenv - get environment variables from stdin
>>> -
>>> -    Usage:
>>> -    askenv name [message] [size]
>>> -        - display 'message' and get environment variable 'name' from stdin (max 'size' chars)
>>> -    1
>>
>> Shouldn't that be -1 here to match the expected return value when the syntax
>> is incorrect?
>>
>> If it is 1, then it's a difference to the expected return value and thus
>> should be documented below?
> 
> This was included seemingly to include the built-in help message
> in-text. If desired, we should figure out how to do that automatically
> and for all commands.
> 

Agreed, it'd be awesome to extract the _usage part of U_BOOT_CMDs as 
summary for doc/usage/cmd/*.rst and _help part as the synopsis part so 
that they don't need to be kept in sync (at least that part).

> This is separate from what I see this morning right now of any invalid
> usage returning "1" and not "-1".
> 
> This is from sandbox build yesterday on top of tree:
> => loadm y y y y y y
> loadm - load binary blob from source address to destination address
> 
> Usage:
> loadm [src_addr] [dst_addr] [size]
>       - load a binary blob from one memory location to other from src_addr to dst_addr by size bytes
> => echo $?
> 1
> 

Then patch 1 is wrong? Or rather, what is moved in patch 1 is wrong?

"""
values are 0 on success, -1 on a usage related errors, i. e. invalid 
syntax and 1 on any other error.
"""

loadm y y y y y y would be an invalid syntax, meaning the return value 
is expected to be -1 according to the definition above.
