Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEACEF06E2
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 13:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684A083C14;
	Sun,  8 Feb 2026 14:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bMWmxCs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A1978341A; Sun,  8 Feb 2026 14:20:01 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B1FC8366F
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 14:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5Fh2uYYc+K8MenL+aoC+LS1pJ1dmq/TUQv0WmqH9ica8b8ZWUTX1fORUCjyzKCQiot6+c0TXY4jlqy89y22u7MZKFXyi6iUjg/WlS/jUtlCM7iGc4bEa2gtfgch1n3kxM/KvJbxX41Gc8lfvhYxq1zpJ5Pj8qEDH+/+d6XC5erHFkeYbTqjtqkrH7PNQfnqo+NKwfejUEBOyD0yV3tqoJGw4HDxqjysdWz0oTz3zsDEB/eH8mqUXxhdFeOWuq6KbqecQ/tkEsXyg/hob3lo2is9qU1DfjS6RJaGS3yr312Popq4yyk65E48mPc0yhtbPwZXJWwfGl/JweTYSX02Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr+A2mzF+gpNDTgd8mab1w7H8PZWnSu41cyanuARwoU=;
 b=wAUGJ/ddsz0m8BaStIvadTH6vDJ+h8Sl8ugOWet/D+gXJ8kg86sjTmWrmbIH3Oyu9nwYaXruwjxvHPDDirxdYg79KZ0XwJe+CCJPDE+OYKc3AunP41hBQs/Jzm75WWy1jAjJU6+p9M5v9ibxxx4D1+cxjAb6osdFSwKf8JyDJld6CxVuPWzjFpxo4x8oi3NJNULiaO244f6ICY3fROzwxlGYV/7xd5C2euuoqmj5pVJAk9qwALzQarqVPULe/IoRIED+sFIHjrCHEByM2hbsaGfRlftsB5IXta16jGtmjZb+zrQ2xFIUvUfQ5Usl1j/Ujt8x463z9NspaB0Q9fMeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rr+A2mzF+gpNDTgd8mab1w7H8PZWnSu41cyanuARwoU=;
 b=bMWmxCs0iquVjnfLHCwBP21W2TEm8CuB59vAimbXNaoQxz+jd/ChDoAkGb/wAYYbxt7OyTXSEoceA7HG2SKH6K7RpT6ATS7CRvf8c66AvJqYAofZZVrjOWZOZD6jZn9mc9s8Uko6oPmtyjSUqCFv461y/BIUHqLMxGyMpvFD3eLdGvwUBtJWVSHPIph6Fo6XAoeSzmrsK/T+97dn2VDQkbR7+3zIiNaXFpeK+Fg0VB6xrUxqNAXrPRpNvf3yebmm9oSOyEstw6TvhauxTkIUv7xT3G0q7Mp0Z0AodGjeJUvxffzRKbuzKZ6DjmMB5DW0k5JfR6nOQnjlNxwronLv+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:19:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:19:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 08 Feb 2026 22:34:40 +0800
Subject: [PATCH 1/3] nxp: imx8mp_evk: Enable SPL_CLK_IMX8MP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-imx8m-uart-spl-v1-1-c3e81cadd160@nxp.com>
References: <20260208-imx8m-uart-spl-v1-0-c3e81cadd160@nxp.com>
In-Reply-To: <20260208-imx8m-uart-spl-v1-0-c3e81cadd160@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: 3972d339-a358-4134-9f70-08de6714c16c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjVTa29hU0QrdjAvejliYXRtNTIwbDZnOEJCeXBSbWtOcGFDSGVuaWp4VE1B?=
 =?utf-8?B?djBLNzBIMytnNHcyU1kydWF2RTB6d25aQXZUR1g5RmNwVmdjOUVObGFEK0pj?=
 =?utf-8?B?SlNrY21VeXBQc1VWTzdRV29HTkU5U3lLeTBsVFdQTjUwcmM1SjExMFhuMFJW?=
 =?utf-8?B?T0FJaCs4UlBjamtKZk1yZ3ZmMTlKTDByMG5vR0pXbDVTS1RGTzNYcEN2RE8y?=
 =?utf-8?B?SkVtWld1bG1OczMrUXp1N3I2NUpjZ29TWFo3Q3NLWkc4S2lEVE1paUNGNnJs?=
 =?utf-8?B?VSt6OHB6dVQrSTIzamZaR0ZKQ2U1U0RGQkFpeDA2REhvZ1FEYUkrajhkS2RI?=
 =?utf-8?B?NzRFRkVoQmJGRnUzMmtDa216cnBVYUw1a3dFWTBUaTFNeThwWkI4TS9UZHdG?=
 =?utf-8?B?V2M3MjJjb3orZHNMUnNOQ0NRbERKd3I1MiszZTBPZ2pBRjlHbWJtK3R2Lzk1?=
 =?utf-8?B?ZFFBVjlyKy8weUsxVFdGdjdpakdZbVJZK2NwQWJ2TUlNcngvdkdaWEpMWVpP?=
 =?utf-8?B?dFJxSm1LMjk4WjUvMmNxa1Q2aCtaZGJocFhhbEJXYnJjdkNzM2xkeWhUQjRH?=
 =?utf-8?B?bWMxcmVIMmVTUDBaZ1hZNGVVYnBnSjBoVHB4NFQveDF0WHFmaWE3M1lsVEoy?=
 =?utf-8?B?ak9ENHI3TkhpcFF0c3dpVDRaeVlHQ014eGQyMUtWOWhaWDJoTzd6NXJzeHp4?=
 =?utf-8?B?WjlORGpSNGxOU3E3b1pLeVQ4bHpNaVNMcnF3WWg1OWpVMElJMHE2N0JydDZv?=
 =?utf-8?B?QlFjdEZ4MU4xckZ1dVFIa0hxUlpZcFNwWlNsMVY2QWRCSUVrSjd1dGlkU0Fn?=
 =?utf-8?B?OHJZdEpwRzROeFRWbEhKaHZueUkrOWlJTVRtUklncG11OVlSS1pBK1BrazdN?=
 =?utf-8?B?SGJGdGVBcHB1ZE1Idnk2WVltV3h5eExNYUhkMHZtd2hwTmpxNFlha09FaVhu?=
 =?utf-8?B?alZHQnRpOXE1MFYvUGpGS0w5UUEyQ3VNaEExcHBzNHVqejNYVlFtZnBhZVlG?=
 =?utf-8?B?L05SQVpGY3JDb1k1RVZERUFJd2RqclJmRGd6bUpHZXVrdUlzd0hJL0huZ1g2?=
 =?utf-8?B?QThCWFJOaDh2MzYrcWdlZXBIMWlqVDlNN0syS3VOOGVQVmQ4bUFNcC81U0M1?=
 =?utf-8?B?aU1wdVRvRHJ1NHdHVmtrUTduWUVoZEJpQmlUZnZWNGIrRnArditYamluYzMv?=
 =?utf-8?B?Ykl3OWYrbkpCTllvSk1wSHlmK09lY0xITWZURDV2VVBMTjYzSTN2ZEV3L0g3?=
 =?utf-8?B?QTVXb0Y2dnJaYjc1TjRFaXcxYXVQd1g0NW9xbGV5czQwU1RQRmo1L242QVhO?=
 =?utf-8?B?a1JSaXpacVU3WnREL1dxRDkzV3VwUXJyTGhLdVV5cGFIQlFNSUtSUCtwTkZy?=
 =?utf-8?B?Nis2YzJmalNQUllRM0JVR2ZBdXUvdUFucXJxM3J2MWMyMHZIYzBVdFVRaldS?=
 =?utf-8?B?ZGx5N3RCeDIwUkQvZzd1eUsxY050VmpXWFBQOTVyNHJnTVhwNFhWNUVmOEVx?=
 =?utf-8?B?b3BxVjNTeURkMHBueUZGTmkrb3duNmZmK1h0STBNMG5kczdWcy9YQTExVlRm?=
 =?utf-8?B?dFZRak5DNTBuZ0FVWUlIMEp2bjZpNlhabmtuVUM2ZGZMMlRyQVJTYVdHWXlj?=
 =?utf-8?B?RXhEVDVoK2xaTjFFZWdQa01WOGZBdCtUWUwrdVZua1IzdWlrdnozT2RGZGpq?=
 =?utf-8?B?THBTR0R4czNGTmxtdFJ5UUgzNTVaUEE0RHloaVNTOWxwb1p4WWZvWWdXQXBh?=
 =?utf-8?B?eVd3L2NTakFVNFVvTENDU3BiK3hXdjdLNXg0RER1L3NWMDhQWHJSTVVDV3Mz?=
 =?utf-8?B?WmJyU1JhZHNHbkFqTWhZV3JOaHZ2ajZmRUtWR0gySzdYY2hLK05QZWUvRURn?=
 =?utf-8?B?dnR6Uy9aTFJUM3o0VFhYM0h0dGtuOUFaS2NHQkR4OHF4TXFXQWozQUJKMktN?=
 =?utf-8?B?SXFZeENUd0pJOG4rRFFCY01BbGdlQy8yRlpROXV5RVhrYlNwNXpsd3Fka242?=
 =?utf-8?B?NkdNU284dGlaNjBWQVhFdE1tUzFGSS95dkpibGJHdFJjWlQvMWo1WVRWeXBK?=
 =?utf-8?B?MVVMWkY1aVp4SGtVbXpXRm1SdHpFb0JNcllSUXRvcU0yUXV1UkRuR0t3NVpC?=
 =?utf-8?B?elZoNTlaQzJSTlpwRTJUb01pNFFZZEJKVHlYNllSaXpuUU44ZGFybURVZm8y?=
 =?utf-8?Q?5ICLZABPskBrIxaEuJk7FwA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVhFM0U1dzBDdGNmM1dKQUh3OTdHZXBvMW9NSVh2ZC8xNmNlbkVWdHFwSjh4?=
 =?utf-8?B?akc4bkpUOVE2T2FOenZKSkR5Wm0vZWw3WTF2aFZiVTBSaXpZaUxMYUJIRFI4?=
 =?utf-8?B?TURxYUZ5endKejZTMlJVcUpJdFlzWVFxQWZtbVh5c3lGRW4zWmJyakF3UjlZ?=
 =?utf-8?B?S2FzeGFZWlZDdTYzUW5jVEVoRGd4RW1SYXYrSm9aM21yVkFreEVyUEJBS0pI?=
 =?utf-8?B?aEo3SkJ2M2NNUlFlbHNPUlRnM1BUVnErbmdLUU44N1dnT2ZaTUtFZXFYZ0ox?=
 =?utf-8?B?eDNTYmN6OTdUamQ5Sjd3ck5pbWRBUFkrZmYrTThVK0ZlSFBCUFNFUTRjZUVI?=
 =?utf-8?B?WnZ3TGZxZHY4OUM3OFVPSGJ6ZDVoaitLRGVJRGVTZWQweFZDQzRLNDNkUU84?=
 =?utf-8?B?VGViRm9KNFdUNzZ4VEplSjBmWU5oeXBzNENxMkZaSCtWYzN4V1RncjAyb3hr?=
 =?utf-8?B?ZHhMTFF4bFpYMEgxRUJJNDlsSGMyQldycHlLTUdZbTVqOUhBWEZiM2NadzBS?=
 =?utf-8?B?VStCWituS3UvODNvS0hGL2gzNjNhcWZKNnBWY3VCU3ZsVmQ1RDl3UGMrM1Uw?=
 =?utf-8?B?MUtMTmt4N1RMVlQxYzZRNHY2NzZhMlJJbWZzRVNIUTMxalp2bnUxdndGNVA3?=
 =?utf-8?B?YUIrVGVRZjh2T2FFQUMweXhWYStwWEw4NU43VHVrOWp1RTBXQWlnSWhsZ2dD?=
 =?utf-8?B?TUZIaUp3THBGZmRSTFgxNkw0NUIvbUQ5YjczTWVveXRLVW01L3NDNmdNVHpT?=
 =?utf-8?B?TEovbTkxVlVxSk5pV3VwbHZwKzB2ckVNdER6ZWg0YXNBWU5vNEREMzBOSjhC?=
 =?utf-8?B?MjA2dnNYcnNqWXpwdFJ6M2VNV1hpdStSbFdmRnFDcHRVQ2s2UU01YjBFWUwz?=
 =?utf-8?B?RDlvVFRGL3dNMGJRWVBsdXloWFdKZDJJblZUbWd3bFB1Y1M5d3ptR1BTMmI1?=
 =?utf-8?B?Zm1yV3RFN0R5TWRNWUkvOThzUUdFRVllQ3E2NEliMVI4ZDRqQ3VPSk1URzBM?=
 =?utf-8?B?bit4MEdubnMvdUpQTG9EQzZpUi9zWmZJbmI3MTN6N2ZlK3E3Z0ZraC93dHhJ?=
 =?utf-8?B?ZzVoWElINGl3NmVvc1ZGMXdOS1lKRU1LWmZjNUliY1J5UWJHSjFVMnB4Smxm?=
 =?utf-8?B?OGdEb1Z4Smd1NXpZamU0dzVjR2x5alE1THZKa2ZaUThnUG5aeXU1VThPdHpR?=
 =?utf-8?B?d3hqdTVhVEVDYXFNbEx0TXNuaHpYRThTY3dZaXl1MkJCZUZUY1lZYmoxN3lS?=
 =?utf-8?B?MndSWXdubEZ0aHFHYlAyd3oyQVdvUHNlUWdNRWxuWjJsNmJVb0hWREE2dFU0?=
 =?utf-8?B?TEFNM0h1clcxbVFyOXJhVXRyRUIvZWxFL1hhWlpQaENHK1FsK0V4YWU0RGRE?=
 =?utf-8?B?aXdNV2VVQ3NaQmlrRFlSRU04RVZUZUtvVElETHdUbXZIMStJWS9CUmJvTmRu?=
 =?utf-8?B?WlNmYlE1bVMwQmdDeUplcUVwN2RFZ2RqSFhiSnJRelZPT3preDk2QVJWVEhy?=
 =?utf-8?B?cVlDQUYvRHkxbzJjc1pWdWNuZGlkZWNUaWxicXBVN3BnNVc1VXUrR25ZNTIy?=
 =?utf-8?B?RWYzdm1tWllXVXRrazlxaCt2L2tGZ2RiUDM2M2lvS0tjT0Q4QVZESW9QQXdO?=
 =?utf-8?B?NXU3NVBLSDJNVHFhMkNIM29DVHFLckozVm13ZmlKNElONU5DZXFhYUpXNDM1?=
 =?utf-8?B?MFRVY1cyTXM4SnBKRi95YVg0WjQ1UGM5aTB4d0orSFg3S3JGcGhUT0pJeTlT?=
 =?utf-8?B?dG1UUE5zc0tBOTVxaEs5TFdlNmtZVG5WWVc4UUxTczFyVTByWGJycVh6Sklj?=
 =?utf-8?B?M3haTUt6bGVoMVpaUVRkaGh0QlpNaXZlS05RR0RZa2xmVVU2bStaOEE5MzRO?=
 =?utf-8?B?UkQyK1ZYWkhXL1BTYU5GOHh3TkdrV2lnQWl5VlpnbERMWDZFTzlidng2WjFT?=
 =?utf-8?B?WjVONVZRTzNlN290Y2ovKzY3OUR4YzNqakwxcjZ5Y2JIY1ZhQnkzZDZMS0hS?=
 =?utf-8?B?M0RkTFIzc0ZFRjc0UndTR1F2YUVsZ28rMVpsRG8yb0d5T25abzRPQ3poeXIw?=
 =?utf-8?B?UzZoQndydU5QdkhxUWlvOEhkY2FVd3loR1NJMGh0QWtNN3RNdGgwOWxhb3hB?=
 =?utf-8?B?c1JZNVM4R051a1U1ZStIcG9KS0pUT090UGhPcTQyZ1NtcXMwV1hlV1grQXJR?=
 =?utf-8?B?cDdPTWhaYnhvcEkrcElKUmVrcm5LeGw1cVFSOWcxbFNlUk1VTEkxSlFiWUNq?=
 =?utf-8?B?ek9JYW5SSk9SMkNXREoyeVU3TFhzOGpXMmYvazNmRTVIWlFYclNZVXU3QUZV?=
 =?utf-8?B?WTdPNFBmZFgvN0g5Rm9yLzhrWGEyajVMSzhIMHk2UU84MUlZT1lQUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3972d339-a358-4134-9f70-08de6714c16c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:19:57.7790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGvfVdtZ7wV14gkovd+MQR0V+uiuQx1jGVIZohkuUZqstB57KtAF5ZfRTLeVJBB2RpEIYFK4ptqiQ+9GgXnozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813
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

From: Peng Fan <peng.fan@nxp.com>

Enable SPL_CLK_IMX8M to make sure clk_enable could work proper in SPL
phase by using clock framework driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx8mp_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 5c3c8a2ca57..d5b01939f2d 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -87,6 +87,7 @@ CONFIG_ETHPRIME="eth1"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
 CONFIG_DFU_MMC=y
 CONFIG_USB_FUNCTION_FASTBOOT=y

-- 
2.51.0

