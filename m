Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803DEC0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 18:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D936A805D7;
	Mon, 10 Feb 2025 19:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Uu3KVDpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF23805E7; Mon, 10 Feb 2025 19:08:21 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94EE8043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 19:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5Dos75futOg577cxiXvGQuR2jMOovr8vFXhC5GecBR4cYE4eR2HiEjlWcUGUw4Hw9SCdwOj5mRH6/wL3xg3zTPT1utOQ758cS9mMEG6KwNWQhX5sqTrAEMFdKvOpwm/C5BDXyKL8qcW+dbTsNPheFboczo9Tzw//6HnDbNTB1wik89t8drDqLqOTLtUG92KkWoTn65FsuhgrHMc14no8ixVUuqTDNxjhZ1JCIfCMr5EypNN4kah9X14zdc5CEof1uNqDbT4mvxpDdkLLE56r2h2cSPtdxZUu2jfApi/caJIaxu+BgvrUUn9iSH2O/AvZmZlgGDPGH1OY8hAhFgYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Igok0Y8fftrvB3RS2Wa9nfDyTUneIyazYrL3Vvd/T94=;
 b=wL4nN/Zg6PemSrUHIL/VRqpDmOi0sTBdnuKUji2DfWXNM/qozDQXWhodk96q6v4/xkCMyWqj5lHgOFIyZVLsDT+XoQAJ7V49SDc11mMgzL7IF9u359Y6S6qsYATftjr7rcgRL6mA3wbNH68MZX3FPasvkG176sMqLMhKRrlNzj+02CqMi0qwRflS9RfcOT2Nm4QsZdz/EXQlH4JTMoxxV2IpSr1QBxGiHK6IQkUAwW7kzBfiudekMdUdXWtZuTgHqbS+vL1SeWjJllC0D3M/YvpnylERjwk2/ZpLxLNR5vTUdVXlmcLnXq6wBb4jljmTwuM9uo0QzZWXf3ttijgZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Igok0Y8fftrvB3RS2Wa9nfDyTUneIyazYrL3Vvd/T94=;
 b=Uu3KVDpHoxYZQWnDrw9ROBrTxgEknZaxi3yXKsvJTwBWUdVzHz3QpfPOpua9wpBEAndf9cbIVQDFnVj48VasVVD236GLnQ8+DuJQ6Oc77aAes1Ey1KKv0eSPSJskzLVDae+i3tcWTBeJvQoOnXGosOABxpMnTgParrNkRBhSyNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10844.eurprd04.prod.outlook.com (2603:10a6:102:493::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 18:08:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 18:08:17 +0000
Message-ID: <f84100ec-4351-4208-a36f-15b3ccb0cf54@cherry.de>
Date: Mon, 10 Feb 2025 19:08:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] include/configs/rk3399_common.h: define
 CFG_EXTRA_ENV_SETTINGS in XPL build
To: Arnaud Patard <arnaud.patard@collabora.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
 <01020194f07b6209-3b8247dc-bfaa-460e-b2d3-9e3375b2609d-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <01020194f07b6209-3b8247dc-bfaa-460e-b2d3-9e3375b2609d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:803:1::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10844:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e1255f-99ce-4e94-4330-08dd49fde485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWdzcE9zaC9OYmNlM0FaYkVNTlRtbFhDVWJSWVF4U3pDZEFFOFJ1ZWVuZ29P?=
 =?utf-8?B?c1BxUEVaZTR6OGhlQnJ3Z2t2WkQ3c2wwTHo4TGl0Tm94cTV6VGo2aEVkRitC?=
 =?utf-8?B?M096THRHYnNCY21SbU9yZmNXTlc0Vld2Vk53Mm1ybGJJZkE1SE1na3VHYUlr?=
 =?utf-8?B?cVQ4VVhGSW1nUlVDNld0UG9kY1BSUW9YMVpLYlIvZmtWZG1UT0cwR1FkMzBE?=
 =?utf-8?B?NEI2SkJmQW40UE5XQ3lCUWl2czR0Z1UxaGZTVHRuWVREcEdVemlOUnNWdm1I?=
 =?utf-8?B?RWNidHZpcVRhbTVrNnpaSkRyYStaRmhIOVRLR1JaQldraTRGUEhYeFU5L3Ix?=
 =?utf-8?B?eUlXWVRkV3ZraExsbks5YmRFdHNWMmMydklHV1ppa3ZaZ01zakk3a3ZRc0RV?=
 =?utf-8?B?dk44QVBSMDlkSnllQnlIQ3NxbDQzVk5DVmx6YS9vb3dCQnRRd05VK3NhY2N2?=
 =?utf-8?B?Smd1Q0lyVk42UUxJOS9WUGIxcytHQjV5V2I3QjhxeGt6VklMZEgwNC9HQXY2?=
 =?utf-8?B?cnAzWnl5UEtPd3F3QnkwNkFjVXJOQnc3Nk42bkNPTWo0TFFqNlY0N3pYbmtw?=
 =?utf-8?B?RXB3WU5oNyt4eVJ1RVhOWUY1M1FKcWFkcHVIQ29ONDMwSjhYL1NtZHB5QTUr?=
 =?utf-8?B?ZkZ5RVJQUGRRQ2MvNGZHemxiam5SUEZaNWJLVVpkbGt2bmttbmZEb2FyT0Vo?=
 =?utf-8?B?c1ZaanJnQW5QZEF6SHFHaG5TcTVBRHE1VnFROWdwc0pyeVZIOUYxQkJoYUFz?=
 =?utf-8?B?K1FmODh5QzEweFhTUEgrRXRxajIzVHdGL1BJRU9qK0NuazhpUHF2azNTZ0RX?=
 =?utf-8?B?cDFXdVlmMUltSG9IdzFpbHRKaFRzSmxsbFdwWXpwbVR4ZjhUNEpWVUlrQlk5?=
 =?utf-8?B?SlhwcCs5M0UvcHF4VFU3QmtKckdaT0p5dW5WQkk3dzdHa3dBVThPbjd3bkxp?=
 =?utf-8?B?aWtTRG5wUUpQaWZUV053eFRyMjQzWm5hbnpYaHNQbTk3c3FnaGFFMGs0cFRr?=
 =?utf-8?B?Z2M2MWNZL0lIbE5FSko1bEFqY0ltUXg4dDIvMlhaM1lSQ1plbXlGZmtOYzcr?=
 =?utf-8?B?RlB5QUM5bjJBQ0ZXalpyUGR1Wnl1bFBjeHdrT0paNFNrMWlwMmhoc1dWZlhO?=
 =?utf-8?B?T3NRQ0s5dzNHL250ckZDWHZ6V1FxRXdBbnNKZ3dUSVV6WCtMUk1BV2kyM3pj?=
 =?utf-8?B?SFJiZkRUaWpKSDFRODFsc0M4YUxCMG1PZkFidWNuRHVlQ0tYK0pwam0xaHMz?=
 =?utf-8?B?Q2o3Z0taYnBvRm44STBXbG5IVHF2cjh5eDZRQ2lrSUlOVXEySUY2ZmtZaHo5?=
 =?utf-8?B?T1oxbWoxbmZWUWkxaS9va24yeGpDdG1WT3Yxa2tad2NVZG1WRFFWck0yOUcw?=
 =?utf-8?B?MXJBRXplSUZrcnlZc2VWU1Z3RVF2MjZnK3Ixb2ZGSzM2UFczdDNscUwvSk12?=
 =?utf-8?B?MG5ZTWV0YVYvRVRMUnRTdld2SWMyZ2xyRnZyVEFXR3NzMWwrdk55dGJoVlla?=
 =?utf-8?B?WlVOWTc1VEhEN2ZWTXhaNEZyS1R0Q0VINXBQbHZLaWEwckhzN3ZtUzFhejZW?=
 =?utf-8?B?YlNtbjZtcTkrckpNSm9YMTlDRjY4YUpZcEVhSmdvSzduRHA1LzB2SWVHUHV6?=
 =?utf-8?B?Q2dWSWRGa0JuY1ZxbGorUGJIUzFoUFk3bUpEbFRPbHA5RGpZc01rM3dtY3hl?=
 =?utf-8?B?L0ZVVFdObjVvMUxUL1FWYWxqQmhVU21nT0tBT2NKRDRxZXlFY205Qm1XUzBu?=
 =?utf-8?B?Y2pNbmgwMWNQcnJHeExpUUhDOEtLR2Zacm5wTlBqdjdHcVJtV0J4aWdFYlpq?=
 =?utf-8?B?dkVZOExNMEpQZTZLY3dhcXJWQ3hJK0NncUVVb3NJSGNHV3ZYdHpGYjBWRCtX?=
 =?utf-8?Q?+BcSrnAOWj/jr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWgzVmF5VHhCTXFvZTdmcWZZVUovQ1FFZmJnZ2FiSUFGTThFc0dzR0ZEK2Zr?=
 =?utf-8?B?TDc3STNLTTFGS1F2QWRSaXFGeUVHQjB6M2Q4MVpNeHdadVhkalFxeFpXcmE3?=
 =?utf-8?B?N1dRYlNiMHdkSTRIamFwTkxqcGkwRVQzeE83N0JUWGlSR1RTWHNlRXRNQ01p?=
 =?utf-8?B?eHljckpKb0lVZWg1M3NEMVNxOGhmUUNuOE00NGdhdHA0YUxrRjRZUDNJT0No?=
 =?utf-8?B?RHFGbTBtalZ4L3I2YzM0aTgzc1J1SjlHWkN4RFFJb2dGaVF0K2ovbjV3OFRi?=
 =?utf-8?B?QkZLc2FNM3pDeDBmRzlNQVFDNjJOT3BML3dPL2lBVzk0bUMyeHM1VkFIQjdK?=
 =?utf-8?B?RXVISVc0U0JuVmlYSEFjNHhsQzZ0aDh4Qml0WVhEMXlIMmpBT20ySzIvcDk1?=
 =?utf-8?B?YmI5QWNWVlpwSkVsbkFOeDY5NWp3V1BJMmJFZXBKaWNUeWlaaFpqb0tqaUVH?=
 =?utf-8?B?ZWw4U2ZDVy9iRUtDYU1tNkQ3a2RVTzM5Q3FMYk05SmpsdEx3ZkdFTWQ5dVFV?=
 =?utf-8?B?RE55Z3ZFNGVSbFlkMnd3V2dodnZ3MjBiNDg3SjdRZE9mVkdCOVRKT1drcHZs?=
 =?utf-8?B?dGlVYlU3MnZweEtCR2duUmR4ajEya20yKzh3azhTdHEzQkRYWDFFWWtyRE82?=
 =?utf-8?B?cytHWTNCSFdZdVM2a3l3cUZoUXNCRU82RksvK1M2bTJYQXlIRW1CVG40T2RD?=
 =?utf-8?B?L2NJb3JZSEJCWDJXcmgvVkYwRXh0MGpZTzAvUXpZL2RsMnVOZnhTN0Yvc1dj?=
 =?utf-8?B?ZWFnS2dmMm8yaXplK081Njd6RHBJUzVxb2FNZ2xlRFI0bDQ2eTJNcGJOWHJo?=
 =?utf-8?B?OUdoNjJSUUZxR1ByOTJodDQvM09zZnd4THplelVndE43YmE4VDc1Uy84WGgw?=
 =?utf-8?B?cUswN1NMNUVZK1hmdjUwMElwdmE0bEVZTzN2NXFhMEhob09aRDNSb2tsNHVW?=
 =?utf-8?B?cHhGeU1kUVppT3g3b2dDSzVwY0RGR0Nsa2tQTG9SSkVKdUxZOFI2Y21aZG5q?=
 =?utf-8?B?MDRFTzRUc1prOWJqUHBxdEs1WDJaQkJqTG1Fd3NXMVNmS1poYUI1cDBUc3ph?=
 =?utf-8?B?MCtMYnVyd2RvRFhRcENFL1p2Rmo0ZWlIMWt1aGZZOVJLRlFsRSt0Y1VkLzZL?=
 =?utf-8?B?Umg3eHA0RW1Oc3AxTWxZcU5jaWIxbm5ZbVBOb3hMWjBjYVcwOWpYRFF1Nm90?=
 =?utf-8?B?ZXMvbmNyTHp5U2s3TE5kSzN3d1BsRnJmU0dzbVdyMDZUVVRCdXZ6YnpsVll4?=
 =?utf-8?B?bUd3L2pNeDFJK2svdk1NVFlIb1BlS0tOSmdwSUdUZzZDTGt2VUFTdUlyZkFq?=
 =?utf-8?B?M3liWTh3US9Iek0yQzRZRDJwTWJLd3pHN2hsOTNvOS9raE1KTXVQMVFKMHN3?=
 =?utf-8?B?cEEySHRmbnRJVWx5dzczUUYvMWtNMG55Q2NUZWUweVl0OERUV05XRmExakJJ?=
 =?utf-8?B?UlF3bmxzKy84dmFQS3I4UkE4NDNxZkIyclBXVElBNDdFa3B3RG45amRITjB6?=
 =?utf-8?B?SUtxYlFmejFGWkVzaVJJdFdxQmdSYS9RUDUzdThuV1JYdzI5RnBuSHRLUnhT?=
 =?utf-8?B?QS8wV1pHS2YyOFczUUEzUkVpTGtXYUxpZU4xU3VaaXBVUEtHM0R5SDhmNUJX?=
 =?utf-8?B?LzVNZEkvOVR4Rk1wZDZKODErUzlqd3VhSFJ2UXFtdXFxRW12NVZFdzdqQXVJ?=
 =?utf-8?B?Zm1ndW1DdVFiaFc5V2ZIdlpHVXgvaEtrcEQ2SVdqd3ZhVjh1KzdUK2srOHEy?=
 =?utf-8?B?aHFOblhjaFlXRUtXUUdzRnlzZmlSWGlEeUxVbG9jM3FQSEdRTUFVa3h0dEdh?=
 =?utf-8?B?NHpoaUZUTXlxTktyM3ZocXZWVS9yaXlvQTRTdXhtZWxKUHJPTk5LUG94dk1Z?=
 =?utf-8?B?eHR6R3pWcS9GeE12NktCUnZmdDlsc25va05jM254UWJJb3prNCtFeSsyclZO?=
 =?utf-8?B?L2pucjkzYzM0WHQrdE40b2djM3IyRWx1Q0FHSWZiYk9paGM2WTZhNzhINzhR?=
 =?utf-8?B?bCt6K1VXaTVFNU5BMXQxNUdHZ1dObEZkOTE3QTJmTGdTMnBnRzRtVzUyTTZj?=
 =?utf-8?B?a1FOaHhyZGFPd0h3eEpjdVBhK2FwM20xOGZyVlRIQnJqUjZyeDNDMUg5S1lM?=
 =?utf-8?B?VzRYZ0VDRldIMWN4Y1o0b3o0dzhyRHlxdFhLS2xEcEtDSzBPRUZHK3krc1Nv?=
 =?utf-8?Q?mk3zx2LT+vSksZG7Rustza0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e1255f-99ce-4e94-4330-08dd49fde485
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:08:17.0330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBpegKZ+ymWnSH3Pi18tYg1PptB2kKWeS+ABYbdPc4s3d8xRJ6uyVFazstMU4ZhPQAZNeofayCtV8KXgprGBPEBuR5dvqWYYdJ/ZzWlgvH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10844
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

Hi Arnaud,

On 2/10/25 4:30 PM, Arnaud Patard wrote:
> [You don't often get email from arnaud.patard@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> To use SPL DFU, some environment variables are needed so define
> CFG_EXTRA_ENV_SETTINGS for XPL builds.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
> ---
>   include/configs/rk3399_common.h | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
> index 76f40e7cd5f..e5f0206ba53 100644
> --- a/include/configs/rk3399_common.h
> +++ b/include/configs/rk3399_common.h
> @@ -5,7 +5,7 @@
> 
>   #ifndef __CONFIG_RK3399_COMMON_H
>   #define __CONFIG_RK3399_COMMON_H
> -
> +#include <linux/stringify.h>
>   #include "rockchip-common.h"
> 
>   #define CFG_IRAM_BASE                  0xff8c0000
> @@ -13,7 +13,6 @@
>   #define CFG_SYS_SDRAM_BASE             0
>   #define SDRAM_MAX_SIZE                 0xf8000000
> 
> -#ifndef CONFIG_XPL_BUILD
> 
>   #ifndef ROCKCHIP_DEVICE_SETTINGS
>   #define ROCKCHIP_DEVICE_SETTINGS
> @@ -31,6 +30,8 @@
>          "ramdisk_addr_r=0x12180000\0"   \
>          "kernel_comp_size=0x8000000\0"
> 
> +#ifndef CONFIG_XPL_BUILD
> +
>   #define CFG_EXTRA_ENV_SETTINGS         \
>          "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
>          "partitions=" PARTS_DEFAULT     \
> @@ -38,6 +39,19 @@
>          ROCKCHIP_DEVICE_SETTINGS        \
>          "boot_targets=" BOOT_TARGETS "\0"
> 
> +
> +#else
> +
> +#define CFG_EXTRA_ENV_SETTINGS         \
> +       "fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
> +       ENV_MEM_LAYOUT_SETTINGS         \
> +       ROCKCHIP_DEVICE_SETTINGS        \
> +       "dfu_alt_info=ram ram0=ram ram " \
> +               __stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " " \
> +               __stringify(CONFIG_SYS_DFU_DATA_BUF_SIZE) "\0"  \
> +       "dfu_alt_info_ram=u-boot.itb ram " \
> +               __stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " " \
> +               __stringify(CONFIG_SYS_DFU_DATA_BUF_SIZE)

Is it bad if we have dfu_alt_info and dfu_alt_info_ram defined even in 
proper?

If yes, just do the same trick as ENV_MEM_LAYOUT_SETTINGS, define a 
variable that will be empty in proper and defined in xPL? Does this 
work? This way we would avoid duplication of variables, which is 
difficult to maintain over time.

Cheers,
Quentin
