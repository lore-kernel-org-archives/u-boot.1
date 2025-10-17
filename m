Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E260CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 16:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1B283849;
	Fri, 17 Oct 2025 18:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="PmWOFWJq";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="PmWOFWJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A878386D; Fri, 17 Oct 2025 18:59:03 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFBA83837
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 18:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KWWiyaiQhcK274XYrHzq+q0Hlo37T8UQYeqz7jPhHayPqCRXsVvdX0YDvO2mgRbTGplnh/vXxahySXKcVS2XKpBgKks6oWbCFHHlanU/bh9WvP4kyasZFweoLg3gtaXS8Jy+Rt4LZ5mmuaaJVnDEF8daqrHM7588diHM97MEkgaG4R4LOVmmW6X9YghxOkfIiPf4xhqilWEVm9Jav8JW90im2r3PmmKjE74zaJy7+Dss7Jnyn3nV1GVjlmZBgpy+ry1QJt8m9herTHcS8ihkKbjR/jvqetrrGRuSc/W8mC6FKNra5Fg/yDTN+qCN/6L7yCKmR3tZ/M4rtkd5J2NWlg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzWvPO6fXWd/MBz0AUnpTOqGojIT5DxwErWD9ES1wkU=;
 b=KCbN0pgNCTEOjnQE6SPHQ20jVAOgghFlYOwfrZczK6lPm5sQ2wjfrSjOC7k2pVuJpAHX2FwgkYD+Ff5YFQVsrTGTsvYU754FlcCGhGpzTGuw0m9MvJxU+s4Pu1Ut0OEee9DjLaaCkkh8P9+6y/t9BVuDNlVp2adXyoaZ59znlmYuf9ker7ap+mfmCwIdAGNy/cuffHVnjPifBVWbWrfi8aYEWq+Ize70qxsvoeq6pNvhWozO6UUmf8X+TXOjwIlHJz4nslIz6RO52FCYH4wzpW8NfVbTeVLh+FxAXoFdKJ8jEASAhdrDDVTjW7mXDfxiURrX0sJ+eIw6/7vlBKBE+w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=konsulko.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzWvPO6fXWd/MBz0AUnpTOqGojIT5DxwErWD9ES1wkU=;
 b=PmWOFWJqUdeuEU98UT/yM0/8kKssyDwUjH/+ID/7HcqIUGei6B3jMEMG+AAgolzd3jjMqBftHe6VYiFJea8WXWcLngFsOYFc5iqwQtOI7Vz19WT/ichYCwf1xpPaRhroD/vzP9qh4ZVU3Itvvl5qJK67Z7kP45hfF1MTKQyi6k/3zu/n1wh/Tc+c1KDwKSFyONYTVN3Tb34Cc6+jVeNY/PzzC8+dY4IEDWcFPAnyNowK4bSiRyCFwMmhh/GaKziSM92m2+x1EvA/gk1sesYyqwR6HomDH1i2oHTKMgmIJlz9GepPBm4maSUaFUpzkjqXbEelaJlr8m4ltdb/wIeqJg==
Received: from AS4P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::8)
 by PA3PR03MB11009.eurprd03.prod.outlook.com (2603:10a6:102:4ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 16:58:48 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::37) by AS4P189CA0003.outlook.office365.com
 (2603:10a6:20b:5d7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Fri,
 17 Oct 2025 16:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.7
 via Frontend Transport; Fri, 17 Oct 2025 16:58:48 +0000
Received: from outmta (unknown [192.168.82.137])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 055F420081603; Fri, 17 Oct 2025 16:58:48 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown
 [40.107.159.121])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 8CD8A20081246; 
 Fri, 17 Oct 2025 16:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcFL+H/LX/SIK1ZFahBEkix8KkxwXHoH3oFseTTHxBG0y9pcQR/LuK/XkGXa/iSTueaQAoIcKhJnEMLi8rrcX1K3tk7VyUqZcvzcr2cs/ADShVVSg9mhoA4WDJn+jY4mgBohq5v6HEUjYUJvVAVBXVMzb58Avxz62zDxZqlp15eosdwms1P9GkwQ/vrgo4h4ZqrjcdA13EvcFGm7MqZ+vZBRvAHfMe2yR0/V+1n2YKt7SKOysw/hSNEgTeNSTtf1ahovThgsXgTjx4WL+CSEGUZCvqVGnHnJL9cx3hwXrgBLQFG3mX0986qXhlJ1Wjzu9wTChBpRNiopgkXlwuHt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzWvPO6fXWd/MBz0AUnpTOqGojIT5DxwErWD9ES1wkU=;
 b=gyvsEK+5qjcVbErKQv8dqaOopR8A840wZcH6Kl0dGrqE4B4jDOwlG04fiuIGOzpqZkObbrHTumXa3L86r5Fhlqyz4DqC0JfMsv2ehoKof92FNjE6/YwBfs//j4l4FHECBB5OGk8w3TaQ8J6hAyuB0cJdbZcPEFDFZyndlVGvcHFkyeaDJFankBmSUiNtaT3hdvkAJ/+Tp9u045o9HtUI2Vcq7zvZC22ffrlJI4rGoehh2IVof7Udl4yQyrisCF0tkHq3pmERM5UCw35+/Mf5egT9FZXGVAo7eeLPPaW2KcCvOL4gq3Q7mwzRK3T1rwwEqdq+ZPkEqyiVVxsNXb5e6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzWvPO6fXWd/MBz0AUnpTOqGojIT5DxwErWD9ES1wkU=;
 b=PmWOFWJqUdeuEU98UT/yM0/8kKssyDwUjH/+ID/7HcqIUGei6B3jMEMG+AAgolzd3jjMqBftHe6VYiFJea8WXWcLngFsOYFc5iqwQtOI7Vz19WT/ichYCwf1xpPaRhroD/vzP9qh4ZVU3Itvvl5qJK67Z7kP45hfF1MTKQyi6k/3zu/n1wh/Tc+c1KDwKSFyONYTVN3Tb34Cc6+jVeNY/PzzC8+dY4IEDWcFPAnyNowK4bSiRyCFwMmhh/GaKziSM92m2+x1EvA/gk1sesYyqwR6HomDH1i2oHTKMgmIJlz9GepPBm4maSUaFUpzkjqXbEelaJlr8m4ltdb/wIeqJg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by GVXPR03MB8379.eurprd03.prod.outlook.com (2603:10a6:150:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 16:58:42 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 16:58:42 +0000
Message-ID: <5ae75a6e-83f1-4343-b9a8-324892405bc0@seco.com>
Date: Fri, 17 Oct 2025 12:58:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|GVXPR03MB8379:EE_|AMS1EPF00000043:EE_|PA3PR03MB11009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f282483-c911-4a62-e6e9-08de0d9e70cd
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Z0R4UktLQlRwL3ArZWJaeFFGN0lyc3JxUnhWbzNOZWFTK01zbjZWTVV1UHVS?=
 =?utf-8?B?SXR1RmlsWjM5T041QUlRRE1PdkJlMGkzdnNIOGtuNkFGVk1HTHNVN0FJU2V5?=
 =?utf-8?B?Mm16Vmk5cEFmUGpMTGl0ZW5Cdkpua20yYTNick1yaTdycHJJdmdxWkJRUU0y?=
 =?utf-8?B?MGlPaVgzM2QvMTNMVlNQREtpM0tkV3JZNkVPK1R4TVdRd1lGcDhiRzBVaEUz?=
 =?utf-8?B?L3pmcDE4SkZWcE5va1F1MFQ3UnBYemplblp1OURmNkx6TEZKdnpEZ2ZiM0E1?=
 =?utf-8?B?T0tmS0RiZG9NQWRMVkpZRkgrQmJLbU5LR0ZvYkxMR0Q4b2p3Tmc0dzNuSmFu?=
 =?utf-8?B?cVMzL3JaeG1WU044ZTBLdG5zSlBLYWJkOVdQQjRDSmV3Ti85QkRXeGh1QVdS?=
 =?utf-8?B?UXUvUDZSaEphUFZNcTdDb3JuUk1YT0thY1JqSHA2L0Q0bDRsUzk1bDUxOHJC?=
 =?utf-8?B?U3pFMktyNERYb1JLUmpCN2FqSFEvRUpKaENkODFSYlgzdUgwMGRGVHYvN1hR?=
 =?utf-8?B?SHZBL2s1SklHTWgySDA3UzY0dlFxS0h0L2xCOVpDc1doQUpUYVI4ZkNxYkN6?=
 =?utf-8?B?dVpkdDdPUVlzZXd2cWljd1VCOUtPeVBnaU1zdVI3Ti9CbHpHeWc5aVlMdEJY?=
 =?utf-8?B?dWYwRVhjZTNyWkR5RFNWQkdaWVlyL0Exd2VDaVNXaXI2V3pjalcwR2FJYmo4?=
 =?utf-8?B?bFpZYzdRTkRKb3NleUMvcWlGWUpaclViT1h3N1NmaXdwU0NkdWtMdDFRY1Zl?=
 =?utf-8?B?MkNNMU1rL2g0Z2c3TmNET1gzYlRHU0M1eFUzYkoxU2YvSEduazJXQ0F1UGx1?=
 =?utf-8?B?OHJCRFo0aWpIamNUVU9BY3lqK1NycHlxK1MraHhiWGxOditHdGE0ZElqTHNL?=
 =?utf-8?B?US9mSUFJcVMxZWhUMGpyeG1keHhWRHg3MnFIeGZ5NHRnVlBBOWlLQmxHOXU5?=
 =?utf-8?B?WmJBU3R2ODRqVWlvTkFyZFc5aWV5aWV2dVByQklvOWFzNXB2UHl5b04wR1FN?=
 =?utf-8?B?TGc0U0h3MVFCZ1hqNUhnV2N6R1ZGSkZTY3NBcmk4R2ZiMUhpMWlSNlFlWiti?=
 =?utf-8?B?MzVXdis2a0IveFVTakpZaEVSTjBoaW9iUEplUzJLRXo1NDRqV1d3Ni9Udk02?=
 =?utf-8?B?elZ1V3RZVllhVHZPVHUwTjNieDROakVHR2ZLNWh0YTg4cHc3K1FiK1RsWmhp?=
 =?utf-8?B?Q2xUM2VTRUY2VjYrYUtWRnFqZ3BTY1gxNmd1bGRFLzJ5TEY2VFY2YktWbU4x?=
 =?utf-8?B?eG9FcUNPck11TGhrL095Y0JaM0tEaFdSYm1oS0xxdm12OXNEelhNYWVMR1d0?=
 =?utf-8?B?SVR3N0w3V0ZHVmhWSTdjQTNIb1RoV0hHUTIwM1U5OGc2UytzUTBCckJxRnB1?=
 =?utf-8?B?UGtiWmUyNjFKQ1J3YlBUZEF3Y0grTm8vaVkvT0JveHpjNFJOSFlkRlNzdTRa?=
 =?utf-8?B?VUJ3VEFmMmRGem5ZYUlWT0JVUmlMQ2RoVk9YRDRLRHl0Qk9MK0NCZmJzMTcr?=
 =?utf-8?B?ZG5PdCtaeUpaZzJzdGRNaytQcUloYndhSmhBNmRHOWxCWitnbmtyNENKM3pL?=
 =?utf-8?B?d2p0R0g3SEsrcjZXZ2VLaUU3MWtaZEoxM28rQjFGSTI1M3MzSVpSd1JxNVoy?=
 =?utf-8?B?Q0RoamhaZWdXRndhMU1yQUtLUXdOZStSeWRubjY5WERObzd1UnZMK3FPN0s2?=
 =?utf-8?B?TUtzdk1DakxkNjNhWGZldXlDSEYvRGtpK0ErUmFScHhhYXVKblNnMTBCb0hr?=
 =?utf-8?B?ZjRmY1JxMDRHOENjeDBMbzV4MUFhRmRVT1oyRExtekF6MnpsbHN6TGVLd1Rh?=
 =?utf-8?B?MWczdklGZ1lDaDNpam84L0w1dlk3L3U2N0U2YUNBa2d0bkJlN2VhWTVlbmEy?=
 =?utf-8?B?Q3JyM3E5MGcxQU5qMmF3Y002OVp3M1MxK3R1aklQa095d1dhSTdhM25mVUlq?=
 =?utf-8?Q?HoaANquw6xJA+BG/KtzBl9RO+DI/HSWB?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8379
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e88784be-de23-4491-a90d-08de0d9e6d34
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|14060799003|35042699022|36860700013|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anB4UmRxU0U1cVFtUU9JYjk4RWRxVjR1bThGdTVJY3A5aEJVSVBtZ3hGUU5R?=
 =?utf-8?B?MzhKQSszUHY5VzloRkpZM2RZMzYzTjRSYWxMdTE0WEp6a3dBZGU0ZTIwSm8r?=
 =?utf-8?B?ZUpEMElWWVZRbjdacnRySFR6dTlsbHlUdWtVbVF3N2ttNEFabkpQL1BtK0FM?=
 =?utf-8?B?ZjVZRW9UWnB6WmRVZG1LMDlWRzBkSXZCNmZlQTNaVDAzMllFcExMZnJoMFY0?=
 =?utf-8?B?YlJCV1NmRnZoemRMWnZxZmdMQjdoOXVTU1JkUmN1SFlTZmpub1M4dERpb0Zz?=
 =?utf-8?B?aWJHT1RzRkt1OTYvbzVoQXpNeWhKbEd1cWhadXdUTUJ5aGtCOStwRm5VOUlN?=
 =?utf-8?B?bWVsRHVTbzgzbHJGQWhLNGRRUEhsdFZsRkU1NkZMRW1WTlJVaTgxWmlCTkg1?=
 =?utf-8?B?N2ZNV0xwajRaeW01SmZGMldSTERaSFluVCtwcmNxbWxiQkFMZU0xcGpIUzRh?=
 =?utf-8?B?WmhDRGI3MXJGZnFuQ1R4dXJFRWtkWnViS2d2U2JWQVU5VUgxNWZlaDZUMmx1?=
 =?utf-8?B?TXdEQXcxbWxSYkJsYkdZbzY0emVBRFRzQXZZeVk0V2xnb3RmOWJoZFphZ0JN?=
 =?utf-8?B?bTRaVHlFbi9ieHBTSjExYVhXMCtLd3oxMFhaNkczVGlFOHRwSnJCUjlOVWhI?=
 =?utf-8?B?Z001VkZGOHJROFBlOXJCcmRLMWZ4ZmNOeTFWWXhZQVkxa1BTUldtRUhDSXAv?=
 =?utf-8?B?Q3Z5S21yTEhCNTc1RlpjenlJd1AydEtyL0NGbUFsYVhDT1g4VzQ3aHFiZVMx?=
 =?utf-8?B?QWZzOTVnZW5LMFk0R3phR0ZHTXMxNWo3WVRZN1ZKcWhXSjREL3F2bFhHN0o2?=
 =?utf-8?B?UkphQXRFZkZjV25ONmZNdHJlY0FtdEEzWTU1Z3grYWFtL0EycEJUcVZVK3ZB?=
 =?utf-8?B?VHNaQlgxcVFYZGZNRWpoYm80R0ZqT2h4WUVYQmZOY2w2QmpicXd6dnRjVWM2?=
 =?utf-8?B?S1B3RDEwZlk1VXlrejR1WWdraTF0T3dPTjhHM1VRVjRVeGRnbHVUSC9yMHU4?=
 =?utf-8?B?K0xCM1VhZEVSd2E0a1NxNm50eEQwdGRYUVZlK0hjejJGOTBDMFExeUszUzdz?=
 =?utf-8?B?NkhVUS9rLzByMlRqR255R3VkYzRoS3c1aGx0MnRJRVVNbXdpSHhORWlkbS80?=
 =?utf-8?B?SEV3V1d0dHNGNm91SFNlS3hLRmVIZGtZMk1IV203UGNuRVkraENHSlFjSHh0?=
 =?utf-8?B?VFJvRDRuRDF0dEZKT2pybkpzUnJxRGZ4aytLSTA3MHFDQlNlcjY2aWJlNml3?=
 =?utf-8?B?WUFJYlpCNWVGK3l3YldpREt0am53dGwvdXF3QUhVb2tpU1JHbWEyWHBWM1ds?=
 =?utf-8?B?RWMva0hVdElpRFNsOEpEZEZzbERFMnJpdHRlQUUzSlNnWXJLa0xPZHJlQzhw?=
 =?utf-8?B?dzZkUUp5S05XcTBxcnQ1dXlzdTZJRXpXTVRVNlUvbUR0dUxQZlUzeURSWXlq?=
 =?utf-8?B?NHNoSmdCd3prbWYzWlE0QzdRcEl0OW85NVB5YW9lNlFLMk1STFZmZllPMDlz?=
 =?utf-8?B?L1E2akdQckkvMFNPTEFEK3lodGFZVVVBZkFjbDF6VDRCT3BaYXZXZFJ6bVFk?=
 =?utf-8?B?M3JQOEVNcUhEd0lxdWNYR3RlS3E0SGJ4Nm1xZHBLMUltUm8wTFFWTmFBQ0Fp?=
 =?utf-8?B?VWdLdENEeU9wVDJDKytPQTl6S0o4VktJRGVKQkkyeVZkUGE5VVlSR2dYOWJj?=
 =?utf-8?B?eWZReG1VYzcyVUZNaEFiMjBaRTF5d2kySnppdHhMSTd0WjgzUjZneWN5SURU?=
 =?utf-8?B?TVNSdDJLMjNweVlhSVl1QWxNVkJlN2VPMSs3QllKY3RoZmlLaW9FbllpMnFE?=
 =?utf-8?B?NWdnMEI5RTQwb0UxOVQwTm4ydjNaK29kZG4rWmsyZ0VZcXFiZGpGVE5yVFUw?=
 =?utf-8?B?SG5paHBVTHI2V3hOSGNyazBCRVBkMmVBcHNUa2h6bnh4dEdaMDAzcXRrcm9s?=
 =?utf-8?B?SW9iYzFVRm5DNkRNcE13aHB5MVVYNjlwNTVQYkhlS1cyNjd4TFpJcU1rZVlL?=
 =?utf-8?B?RGNGVHNrVFpmYm9GYkxuM2J2TjlIbXdPLzNsUkxta2ovZ0gxUkMyTVM3aEJu?=
 =?utf-8?B?MlFzTHU4N0hHZjJDUlhKcXJzeHJmSWd3MFl5aEsyUjRPb2NPSGdjS01HWUdk?=
 =?utf-8?Q?JZko=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:58:48.1268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f282483-c911-4a62-e6e9-08de0d9e70cd
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR03MB11009
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

On 10/2/25 05:39, Andrew Goodbody wrote:
> After calling a function that can return an error, the test to detect
> that error should use the return value not a different variable. Fix it.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  fs/semihostingfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>  	}
>  	if (!maxsize) {
>  		size = smh_flen(fd);
> -		if (ret < 0) {
> +		if (size < 0) {
>  			smh_close(fd);
>  			return size;
>  		}
> 
> ---
> base-commit: da47ddebd16a7e1047da8537fbf01558d2a89fcf
> change-id: 20251002-fs_semihosting-85d697fbfcad
> 
> Best regards,

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
