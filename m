Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC05C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2851E88532;
	Tue, 23 Apr 2024 11:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="bmyr8euE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D59C88532; Tue, 23 Apr 2024 11:32:00 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2B988530
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/clcU+8BqVahcWkrKCPB+sRf5xpvBrR27ZT5Porh5mglWKIiWt/YqZWhX4ZK5ROsTQI4ocl+MS51SBTUfA85N7auR6/elWEk6hxWhu9X/sc+3SeprEv4dAcV+4X7U3KaSk97gDM4Q9AxJLt3QlF2Yz/N47T9+2GAV/bPuRon2bib1WVz2IK5sYxDKhwyGg4hv80LSW4A0Fo4WY/Mha9XHIo+GVxJMDl8w7MgHeNQhtP+zng27siJqF6DCGqz3ZsUHZZNxEx8hqaBmYNRMe6h6NY6oTZskU4SHvXrvL7aj+BgbZPtCiw4CtOcNKp9uHgl7pZdElHe5tnJmWvOdYFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38FmPwE2xeBJ463x6phZxpslNxPsMAgd45jmnp1tu7Y=;
 b=I7zAUt67q1WHb/OkL6a5ua3kuF17q/rqnJL7X9Ef4qADLwxDQhF7RYul4x400GQxH6rJcwczamT5uXp6GAW4PJTnh79IH6IVWe7q9YzNUJJLheM01QAfVNWiYTndkw4kh60ktH/AIgE08v7OiWd9gyGlxoCvW32YhEqOdJHEuqbma8LOjg0KRCBjD//hpAK4XDgsXQhpQG5M8qDRr5W9pPlHG2V5gtHFxFoOnHodJP40WbOXNuVGl1rLsW2R9X8uY2w66HwDsDGF6DTbyJznXfFXKElmTsCQASxlAmM6tj8l3acezVQq+IpnDO10CQPKAz3aBDQq6pLOD6yaQdca3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38FmPwE2xeBJ463x6phZxpslNxPsMAgd45jmnp1tu7Y=;
 b=bmyr8euEavTZf8UQCX3LdFuaV9N1trmYJuaKMurqv/WDhJ4OjkGdMwyWoIzJvGJIzcpH+cYg/pO+b7wZTS0ZXrSfKEUTSsBo1n4Hal82XiC6TcKKp02571wKTLJ/hR0x5WK3REh0ms7Ios2U6yABE+W8If5zyasDai/YZwSyME9+C5OUJo2g9hvjDbM0q2IkJ3u8IJNgWkq0UEpYWC3IfeUvpTIpEKs6HgflgbOUZWfJlnaOhw1SVwDNjNbnrtfEkrweUk44dj+/z1I6Hjghi5tQxQ/fly/cr0ytnbdNUteU571lMVbY7wcsDQso4lhUUi5Hcy2PrmW5U5CytiaxmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com (2603:10a6:208:c2::30)
 by PAXPR04MB8390.eurprd04.prod.outlook.com (2603:10a6:102:1c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:31:53 +0000
Received: from AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785]) by AM0PR04MB4833.eurprd04.prod.outlook.com
 ([fe80::70be:f731:f7e6:a785%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:31:53 +0000
Message-ID: <1e6e1991-a54b-4c9c-9541-fa5554b557ec@theobroma-systems.com>
Date: Tue, 23 Apr 2024 11:31:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk3588: add support for UART2 M1 and M2 in
 SPL
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
 <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
 <e8a60f99-4012-4ef6-a210-436ac41bd1ae@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <e8a60f99-4012-4ef6-a210-436ac41bd1ae@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::12) To AM0PR04MB4833.eurprd04.prod.outlook.com
 (2603:10a6:208:c2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4833:EE_|PAXPR04MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f44ba09-c0be-4a61-2381-08dc6378360d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qmc5SFArWUhQRForcUI1T2JlaHhpQ21qK0NZSHI4dVB3YkJzY0JGOE9hOGR3?=
 =?utf-8?B?NzlsMVhOWFNXWDdJNjFxQ05sTE5aVEtENHpuYW45UGtEdjhFRUVSR2J4cjRS?=
 =?utf-8?B?NEFJZTQxN3BualJ5UE5LejFMOXF2USt0SzRmVXhzT012ZTRxT0ZUeldNTUFS?=
 =?utf-8?B?WkpKMkZVT1B5Z3pWL0FiUmxNSlAvL2E1Y051MEdRVVo3a3MxVEMxZ2tOKzND?=
 =?utf-8?B?dXZNeHEyaDNyaGhIQm5lZDNWeGhsT0JDQWZxdTB3LzhSSWh2NUlkOWZ4SHBT?=
 =?utf-8?B?a2Z6OFBvZERBN2U1U25lSFNRcGZ6aTkvNnRvUC9PRU1UbUNEeW1rdEdKM05j?=
 =?utf-8?B?aFhpR0dGU2laM2FxVnlpSjl4djRQNkVTK2R6aTloZng3RnhiNnNxcjF3VVFU?=
 =?utf-8?B?QVRKQ05GcDFKbEJOekJFaU9zT01hanhmb2VseDVUY1dlT3JPUHR1RS9zMDJt?=
 =?utf-8?B?ZFoxcjJaSEhrdVIvV1NoQzVmZDN3MFpQSzhZYThGMkZUYW5aWEFYQ205MFFa?=
 =?utf-8?B?SHJ2cytTclRnL3dnV0dCVHVNV1RrUjdpd2dmU1ZPdU00WDVERDA0SEY3ekoz?=
 =?utf-8?B?eFVsMkJOblJDeFFOaXlUNXVBR1U1cGNodjBOMk1odHBqY05WQitQbTRydVVE?=
 =?utf-8?B?SXdRQXYyN09LY2psZXlRU3FqUkxhRlEyLzFsSE9JQXp6VU9vOG1TQ2RYbkZN?=
 =?utf-8?B?T21sWmwxN3dVR09Qczd0UWhNcHVDRTZlemI3Y0hjckduT3EvQTFQdkMyREZs?=
 =?utf-8?B?V2xDS0xGbjQ3TDBNTklzaGEvc1RWWWpjOSswVnN6UFF2enlvWVpNdWd3ZkNP?=
 =?utf-8?B?VHlKQjgzK2tzNFBNUlhnMXZDc3pETllRc3FoL0k0Sk5QTDNpTDFxWEh3MVpl?=
 =?utf-8?B?TC91VFFJeVpBQnJ0TFByM3Q2c0N1VHFyMUNrbEtmVC9TeEFpWjN4cUg3UHpm?=
 =?utf-8?B?TWZoTVExVjJWME8vdGxaYVNHNTVwdzNXcjc0QS8vUjdBRDlWVmpzTFpsNVZT?=
 =?utf-8?B?RjdmNkRQWC8rUFZjemdjcFMweENsd29NekFra2owNE1TVDdBYVBzNnVpOVZu?=
 =?utf-8?B?UElBUytOV2tGV29zeC9MWUR2cnUwN2lTRVdiZWRMOFdhTXpFVUMvUzVhT1p2?=
 =?utf-8?B?NFZSS3NxbW52aGRHb1hLckc3RHNyZjc5YU56UzhFR0tacjUyVFp2SU5sSHdZ?=
 =?utf-8?B?NFJqV2EzRTdWalFtajJVTVU5WkhaVVNrSW45ZUMyREpsRkI1SVRES1VTK2Vz?=
 =?utf-8?B?dnlaeXlXUXF4ekR4dkZ2RUI2NThFbkw3VnNtSGFZTVRJMzNCOHFPM2JRWUhk?=
 =?utf-8?B?QUtXd2ZEV3ZMOVlOY2ZBY1JJZ3Y4T0dXVkt1Rm9YMGlhYzcyRERqc2ovTUZX?=
 =?utf-8?B?eVZhaXJKREdaaXVqL25vbFErSzlsOS82WExpQjRDayt5dmJtaUlvNG1uSVl6?=
 =?utf-8?B?amY0dzh1L0VnNUY1M2JaRWNxUGVJRit3U0VWMkphbERZc0w5S2JWaDEvQU5D?=
 =?utf-8?B?L1lneHg3THk5K2lpL285eFNpbkNpdldRWWdzeUsvOXVnMm9IOVJ1dUNWQ1Zv?=
 =?utf-8?B?M05IaXdvaE05UWFnaUdaSTlKN1B3UkdqQlp3MFdWSmM5R2tJT1Y2ZDJYS1lX?=
 =?utf-8?B?R3NLUFhSSWRDVFNVV1F0WjhZaXpzdWErVXJhNis0QUR1WmJuQXZIbG1Zd0Za?=
 =?utf-8?B?OUdUVkFsdWNwWEhzVU1qcTUxd1dnNWNWMWlQY2Vqall6NUphQ2RtM1ZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4833.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVFXL3gwV1N1Zi9HbytIZjZoNFNucVVCT3hFZEVEVXVLb2dkbmZibHgyb3Vi?=
 =?utf-8?B?QUM5aktjL21sODN1V20rZDVkMkZRQ2k5azBsd0psYUhkaXZnRUhCaExSdThX?=
 =?utf-8?B?RlZYSHo0YVV0VGhMRTBzOVhzWVhjcXlhQjJLZlp6dTJwTHBPRndKZUxEaFM1?=
 =?utf-8?B?NEhYa3lvZzc2UEd0d3p4eWlzcnJveTBpSHR1WisxZGc4cnBLTHdQU3Y5dm40?=
 =?utf-8?B?eGVqQXpFS1ZKdEhlemFYQ3EzS3kzRlB6VUFyUUFuM2w1Q2pFK1Jma0Y1MHEv?=
 =?utf-8?B?Y2htOEtpUDljU2NHWVRRSE9JNktuS2x0WjcwQW9kNklXQnhWWFdSYzE3U0lQ?=
 =?utf-8?B?K1hFa1ViMjlVeVZYRU5XWW90b2FlbW5ObkJyaHRjZm9Sck43ZkFvMFROaTFq?=
 =?utf-8?B?R0FsK2k2UEhvK1ZZK3dOWmtha0FwKzZRbDdSRmlCcjB4VmxlVW9zUUZoU1pq?=
 =?utf-8?B?eWJlbENQRnZ1V3d3Ym82aENDWG5xdDNKMWZHaHZ0eDZqdUcyOTBkNkhkQmwz?=
 =?utf-8?B?bXdXajFTQ09Qa0NtWXpYK3Y3ME4xL2hvSkxlL1FCREczc1lzb1lRRmtwTUds?=
 =?utf-8?B?a3ZPa1NxSmUxcTUxa0J1cFBrclJIMS9rS2x5UE5DclRRY0VTd1pnbGNyMzlS?=
 =?utf-8?B?UnVlVUFQSnBuU1B1SS94VTF2c2N2a3orY1UwRi80a1p4OVlkTmJXb0pFN2RM?=
 =?utf-8?B?YytSN1NrZ0VObEI2bFJPV1hOUEkzbE9MQnI5ZkRtU0p6VG5uN1ZGTnduM0tE?=
 =?utf-8?B?YjNxOUIvaHZRSXhqTHZOck05b1BOQ01iUENscHJ2SEpyMmZ6OUdoVkVUK00y?=
 =?utf-8?B?ekgvZWYxY3lIR1hjYjRVbFN2dVFrVE02WmpVRkdBT2EybHRXK2tiblV5bWhi?=
 =?utf-8?B?dzdlSjNGSWJwNGxzd21nQW5IQ3FTNll4V3lYZ3k4VTJKWkgzQlgydUU0LzZw?=
 =?utf-8?B?K3Z6eGt4N05CSXc4anRwUTVQd3BEQTBEeHlDVHhUUThUdndtNWdmSjg3Vndn?=
 =?utf-8?B?WFFPOWY0OTVyRHByYVFBQWFZQnpYdVpNNU5GY1NNTGRESjE2VFBwNWVRWjN5?=
 =?utf-8?B?NEJUL1FwODJKS0Y4VnZBc3lOWXNML3VZMDBIN2J3ckxrVFZyR0hxdXI3NDU0?=
 =?utf-8?B?aElaZEs0RC9RT1crbXVPTzNRNjY4Vi9TYSt6N2FrY1huTkNhcklZSFRrVUdj?=
 =?utf-8?B?S2NGVnFMaXJxMXRER3RYa3dCc3VBWG53dWRXa3RaU3RRSUQzT1NyRnJySDcr?=
 =?utf-8?B?OEVWQjE4L3JrSkczL1Uwbi9BZFFoL2FsZitjNkM3VjZOYTc0TkEzdUsrRDY3?=
 =?utf-8?B?a1FrbGlVbzFoSkwwWTJxQk96WFYvdGFDT2hxMmRDaENSWHpNckxYVGpRR25D?=
 =?utf-8?B?VEx5Rk1BZ0ppQlZWZnZIcFJkWEttWkhMZ1phSkRjWGZtcFM4c0pHL3NjNlZ6?=
 =?utf-8?B?Wk41NzJFOVgxNWhMWjVid21sbUNSK1BBb24zdE9sSktjcjRWeEZVWHVBbUlv?=
 =?utf-8?B?NWpUWkRQWndpa3cwVTFzWjk3WUJEcFlxSGYxbUJ5VGxEcVIzamdzSlcyc1l2?=
 =?utf-8?B?UmRsSTdnMEFyMFNrbmNmWUJGU09ySk9MQURJS0Yzbmp0bnlMS0xZNWRrMzBa?=
 =?utf-8?B?bkVrVUNiMHhvNDQzYWhPaEgyNTZ3YWp4YnRrTUpHRStPQnoyVkdOblRNN2VQ?=
 =?utf-8?B?SUZxVmxBRkVQVEtPdHBneEVJSXY1WDZLMElxdkdqOXNKV1FmT2dHaWdZYlFE?=
 =?utf-8?B?Rk5kSlRNKy9WNFZ0T3UwQk9vemR2OWRWZnRBV0FhNnhOSUZvdGllR1J2RjZF?=
 =?utf-8?B?cEVjR3Z2MGpPZHB0bHFBZUVLWmZwTXF5QWthZzhNdm1Gc1QvbVJ2Q2E0R1V4?=
 =?utf-8?B?MnRnNWZjZFpYZllieW4zNHdqQjZMeDRIM3hNSEJxMGR3T2lpZG9lT0tqUXZj?=
 =?utf-8?B?V2djN3hlYkZBVlA3V05oV3NPbXRCR3ZFS1k0V2VqaVlyZ1IveUFxbXFqeFNW?=
 =?utf-8?B?WnJ3cnhaSnhQK1RvM0xSUjVPUEpjbm9OUVdZTklxVWVpbTN2dmdtU2tjVVFu?=
 =?utf-8?B?a0hhQndUb1hCVUVqS29YMlZUQUkzUE10bi9TL3JIUWp3MVk1VnRUZTdCMW9k?=
 =?utf-8?B?RGFWU042dTFtQS9aNTNNZS9yVmtNWnB2Z1lJOHJOOUZCTEp1YTFVeEl3cWph?=
 =?utf-8?Q?bUTExap6NqzEKz9tw1XM1ak=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f44ba09-c0be-4a61-2381-08dc6378360d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:31:53.4922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2v4pmSjJKMWkfIL/ymqNJuvxitftS1mwC06B0R3oFwcABVQcWrru4UpYn+dSkBqs+J5thuLCCX8BQq+w+mm2IH0tsBtnKP0ITR71Ac/Rb7++qOe+qSwerGkLIsKUlEf3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8390
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

Hi Kever,

On 4/23/24 03:09, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/4/23 00:41, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> UART2 controller is the controller in the reference design for debug
>> console. The default mux is M0 in that reference design. Until now, all
>> boards seemed to be using UART2M0 but RK3588 Tiger for example will be
>> using UART2M2 instead.
> This feature already been supported, please use CONFIG_DEBUG_UART_BASE and
> CONFIG_ROCKCHIP_UART_MUX_SEL_M to select your output channel.
> 

CONFIG_ROCKCHIP_UART_MUX_SEL_M is only available in Rockchip's 
downstream U-Boot.

git log -p -S ROCKCHIP_UART_MUX_SEL_M

returns nothing upstream, neither does git grep.

I used the same mechanism as for PX30.

This patch will be removed though as it's not needed until we have an 
open-source DRAM init. Until then we have to rely on the DDR bin to 
setup the UART.

Cheers,
Quentin
