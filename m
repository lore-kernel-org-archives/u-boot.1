Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D1AF55425
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F0D83D8A;
	Wed, 25 Feb 2026 01:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dFMbdYfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B3B83DEB; Wed, 25 Feb 2026 01:14:24 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DB783C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlrI33HjBcXO6uBWHKX4c6MJuy7VXUgBilqTRJJWDJeB3L9Lf+jjEwCujUs/ASaumWkY6XO3iSjMvsnKhvBU8hQ8PQVQ6i14iCLlJCON9VN5oNtm2kEidEqgcaUgF3NXN63OcPL5c+2aNfPYu0x0iKacyNP1KsTyObRNMpixwd5hsZ99RIWZNidgOvxyTgHkKl49L3ojnYZt4RhRAjJJ/PDYSLBS6vBqAzdtVKCjcfmOwcGU1QbG+9FUNJK9wHR2u4Xc/G85XDuvU8Rt8ht/TnBJBWljq3kGPNFmpQlo65/d95MoTP6q4IslM0DZoW4cgCEU9E3N5gpjaym5koVBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyiTBmBEsZ/6mtF6TvaO38F5aODz0CLg6HzH4vJsKTw=;
 b=pGUZEVDRh1YNn5og63oPfbIelzQE0G9wT9ExYq4HIX8Ej4dyXNOeQun4oLYpFdlBZwfL4Ke7SAtTFGCXbH39YCMEZYBXW9Ht4Qlzj1XhtbvzWWzecjA9akrCTiMGHVizcV2E26TfgT7kfoQmuQDE9FOGgC/Wz08ejP5ioqIaaJAvggPJRYeqmOi+JEs/gz++TErhUoOCeWFaxFLhPeHuH+QkAAivx9Bwd+xIi+fuYVrSL2TsrZd9UWh/wvRZo98OHWw0K1mOP053B0bUV3eyRI8S2HFlhaAg2Ab0zFjNe0L0HAfBXp3gVQj1P+fS2G3OEFsql2A2lMPGWd+0ITK3rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyiTBmBEsZ/6mtF6TvaO38F5aODz0CLg6HzH4vJsKTw=;
 b=dFMbdYfSVXtXcDc0wMmvCypCiGBMT+5Y4r3erHORWxTjSqTpzODfhf+i6Auzv/0aIXwC+WtAcB3xMSmOXxu7mQdTVLmkIHuDH+qdLX/BkR0ajBqzAJm7WIfcNlpPFI5eIbjMZspv6zzfXDR2E3NAz2utsUOoc2XNi6rbXOOesNpGnOhJGFsbW2Sb0ag7TveY83wEbwrnFgPdz5BaXuNZZ7ekY3PlvWXzHH66KnIk4JPJFfBGqTi3xVyoYb3R/W+oeZI3GDVr8aPjUvA+9ahUjABC01ibszjJnAl6I6zmMl9jRXGlTNSsf509un8v7LsBmcrPPpz8MaZeJ9za85Q5+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:18 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/10] pinctrl: Support print pinmux settings for i.MX8M/9
Date: Wed, 25 Feb 2026 09:29:26 +0800
Message-Id: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZQnmkC/x3MQQqAIBBA0avIrBNsCBddJVqYjjVQJhohiHdPW
 r7F/xUyJaYMs6iQ6OXMd+gYBwH2MGEnya4bUKFWiCj5KjJysE86JXkkrXFy2mzQi5jIc/lvy9r
 aB+JVQTJdAAAA
X-Change-ID: 20260222-imx-pinctrl-ef2e6624d6ab
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: c5893c5f-ff2d-440d-63c9-08de7402d126
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anRub0ozRnNvWkllOUVEYk9Hd0Z2SCtadzRrY2pkUVJncWg4K2ZnMTUvWVd3?=
 =?utf-8?B?ZG94Y1RIcWFsTTVNejBKZnRoT3JXWkl4RkhzTGJKUFdLcUNYV0pYMDVjeFM1?=
 =?utf-8?B?TW1EZFhRS3BJZUdPTDlPdjBuWlBqa0ZiQnVGekdmL01HeWJ6WHNydUt3QVVu?=
 =?utf-8?B?Z29YZ04wSklhZzRtMVpzWkdENmE4Wlo1UE9tQUEySUU4YStnTVJrT1Y0VENa?=
 =?utf-8?B?cEowSWVpbkNkdERTNXRUaVpQNk9qeWtWZ2RnSHZpRHo5Umx4KzlQYjBIN1M2?=
 =?utf-8?B?cWU5YUQ2RmhOMGwrT0Z4VkRGNzZOMU1FTk52YWUzMEkyb2tMdlladDc2M3hT?=
 =?utf-8?B?aFNkaGFKcG93RXNPa1BvYnJVdEkyN0RyOWVBa3BZbjJrdTJ4TXVmaTZwUUMr?=
 =?utf-8?B?Y1JZUkJ1K3JhNS9KSjJRaUYvUHBrOVpEQWg0ajM5azBiZVVnTEo4eVlPa3hm?=
 =?utf-8?B?aEdsK2ZQRGNMa3RjTkRjdjlyTXptajM3eWVzU21Xc3VpZmRaR3E1WXVLTk1P?=
 =?utf-8?B?ekhnVzdmVHcwbm9WZHg1TzhvbldRcXl3RUZ1ekRBRDdnbnM0R0FseGZ4OUx6?=
 =?utf-8?B?c3N0NXp6VXZ2UVN3RVNkRE1CcENKMFMvUkVLV0xsbkNod05EZmoxZjJick9F?=
 =?utf-8?B?dVFTT1dQUjVtVmtnM0U5aXJvS1dPMFN6aVJmTDRha1ErZkFCZVpxa0xmNEFt?=
 =?utf-8?B?M2pqNXFpUnpsQlZEbTdlMGJWTVFZaGtxR0xFY0dWR0F1MDkraEIyUXQwTk5j?=
 =?utf-8?B?WXg1VC8yWUoyV0dwN1lmUU51NndVK1AwQXdPS0RDUThZZ21zUFY5SVE3Q004?=
 =?utf-8?B?WGZRWTFtVWNZM0pLUlFBZXBob1lENzhxdjhSL0thWTkwWWZtcFUweFA4UWg3?=
 =?utf-8?B?eTBZSHh0NHNxMW5iRzFnYnNvdkpYeS9aWnh3N0lQRGdjU2JXQmxjUUZsZXB1?=
 =?utf-8?B?b0dCaFpmWHlVak40RHNHelFPOFU3SW5xZktESWRYaGFIWHdOMFJaTmx2RGJh?=
 =?utf-8?B?bklaNHlaQW1mNTB3ZFlqbU5iUjhzVm0wTDhFUCtzTUdtRTNjUnh5emV0RXl2?=
 =?utf-8?B?d3Fzck9QWlJRTFkyZHI0aWNjRjdMdDRsWnY2Vld5blBRdlRrNmVKSGZtbDNY?=
 =?utf-8?B?cEpUUExNcHlybDRmY1Z4dkxlMmF0K3RoY1kreFFibW1xWjhtWnFGeWlxRmtq?=
 =?utf-8?B?RDlYTVhTTFRXNlRPYVo5YURQZWF1TVEvQTRPYm4xTVBZVEVEa0x3QVZQUjN6?=
 =?utf-8?B?NkpnRjNaMk1VTWRzelVIQnBFVmdDQlhVeHM2YWp6UXF4RDNTZ1RKZUlma3NT?=
 =?utf-8?B?ZFpWWXB4MjlYSk1RRW1pUG5ZYTVQTFlVSWF4QnFQQVJwb3pXcWE1UHN1NlFa?=
 =?utf-8?B?enN5aHRMNHJmanVITXB4Nk1ZVURjQ1JCV3NKUnVYNk5tUWdpbTJtYkFxZ1Av?=
 =?utf-8?B?UGhuTVd6aDc0VnV1SkcvdWplUzhqUkFGYnFveFc4WGxUSnAzakFadUM5WW85?=
 =?utf-8?B?by94SGQyaFM0V0J5TFc1bERMaXhaeU9DaWI1OWNlTG9obEx1VEt0UzJBTDVy?=
 =?utf-8?B?K0NZSEhzQkM4R0hBSWpJbVJTWUdKdkpkTGo4Mkc0QVpZenY5TlJzYTBBQ2pH?=
 =?utf-8?B?NWVDLzJ1WFBrUUMwTmd1ZWpKOVdRbDBBSXNQUG9sRE9DbjJ6eVRGVHhPWWdT?=
 =?utf-8?B?V3FzVFFMSllmR1cyaVJlaDBTQlVtd040V0pPNmg2bGpVRzlKcXJ5eno1eW15?=
 =?utf-8?B?aTZKb3FVQmREMGlCK1FoaVNZRGZaU1RUUDZpL2M2QWh4dFpwWW1US1ZBRjY1?=
 =?utf-8?B?L3FZU3h2QnZJSkExQTR5MkdIM1dDakFWMWROWmRFOFRGVWJOYWR1RnN4UndG?=
 =?utf-8?B?RndJazdHKzA0V2RHemQvL1FCN01uVHZZRGhIbDlRRjZQZzJRbzRvaU5WcStO?=
 =?utf-8?B?dnZ3K2RXck5sZi9rWU96M090YSs1YXJjdGx3VjlmQVBtNHNLMTg5cnprTkhX?=
 =?utf-8?B?VEhXY1FGMURXcmg5akRDZzY1MjFrZTkwOGZqVlZTbURnWmZJNVlucTkvWkVa?=
 =?utf-8?B?NitSTDhuVEZUUkdwRVRFeTZlWmtJeG8vcit0azdYcDZINHhPd2tFZWNwaWV5?=
 =?utf-8?B?ZU5wR2E1ZHBOYW5qYVBkVzBMdE9JNFl1b0FMU3Jrb0pPUnFvc0p3aWtQQjRt?=
 =?utf-8?Q?rPDWHkFHlBSG/yzJlERDwMo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFZ4ekxrYWRYcXVxamtNYWVnRU1xTWdIY0VLeCtmSWtoTjU1WjJnNEdManFG?=
 =?utf-8?B?WTZ2bElCS3VwRVJoQ0pLRU1ZNE1WQ215NWdnYmZKWHNBeW83enBkV3Vramth?=
 =?utf-8?B?U3IwOTFxc2ErSm96V2pkYlJWb3NHNVlaZ1pLdzJkM0hWUXhVZjd0OEdSV200?=
 =?utf-8?B?bndYQjdieHZodHg4N0FqcStuczhaN3RlY2FwaHZ3eGhYR1BYbTRkVWNhK1hT?=
 =?utf-8?B?d2dhOVcwdzlqT1dvR2tNdlRYdDJHTEg0K1pTMm9CUWUrendjK2dvaGRRSmxC?=
 =?utf-8?B?cGw1bEZRem03eHNTQXEzOHV4Q0RPcEFaQ0xDVzJSSC9LN015WjVxdThyVTc3?=
 =?utf-8?B?OHAxRWRjUUFYek1jREZiUEJLOThxSjROQkw3UlVFZFZyOGc0WXJINFloYnFy?=
 =?utf-8?B?NThJVFY3eHFxWGtYdUtDL2tHUHpLWFBhdzJWblV1VVhya2N4UWxCSk5LNDRH?=
 =?utf-8?B?Q1IzWlR3QTNmMHFsU1oycGZZWnc0WEpXSXMrRHhqRHJTNDhxdkQvQmlrcXZS?=
 =?utf-8?B?TG14VmUrcWlXT2ZxUjBzRGtLck44cmlSMFBJYU82Y3ZRMGRkMW9sNk9qTDR4?=
 =?utf-8?B?WG4zZlg5RHVNT0VVb2lMSkk5Vk1GaWxtanhtbm0vUUp3QVRiM2ZISUNNd2pp?=
 =?utf-8?B?bE9sUnJnanBpSUQ1bmkycERqYkdISElpdEdXTDhsRnErMFM5VUJSVE1oREo5?=
 =?utf-8?B?OENxV0lNcGlGRTA5SmZYZkNUTnBSYjRvdHY1VmJSMGo1cE84Q3FsZmQ4aFlZ?=
 =?utf-8?B?VDJ1cy9POEVWTHVvZ1JHczloTERPU1NOcGpNc2Ric3hGSnlueUFGb1lMekdx?=
 =?utf-8?B?L1pxdFR3L3MxeEF2a2xkaWZ5T1UzUDJTQ3lxMEhFR2l1Q3ZMazU3MmEwdmw3?=
 =?utf-8?B?bnNzTGpWVHRybWJzQ3JIZnBZcHh3Z0VnWU9uVm1oR2tHRjJwdUJ0UmZxeCtY?=
 =?utf-8?B?WCsvTU5zUnJoSEZscUFqQXl0ME45SEFrVFZYK2N3UHo2dFZOY3ExOFRQZEJa?=
 =?utf-8?B?RkZBSDdUME1IVWd4eXJOOG9XSlBoTTVhOEhwR3A2ZlRXZFRzckNTd296c0xh?=
 =?utf-8?B?c2NxUWtEQ0VXTWtnRSt0K3Y1YkM3dHFLYUU3NHpUMDZhbGU0aHNXbytycmsw?=
 =?utf-8?B?R3RlYWZFei9XVWovZnZDaFZEOWpyY2l3eCt6L2I3c3Jwck9GWmFmOExCc3pG?=
 =?utf-8?B?MVZmYzJmNHJLclc1K2pFRVVlMjVaZU55TVNIVXpCKzFITTAxcTQxbC9wVkVW?=
 =?utf-8?B?MmtrRWcrYVhWQVpXeHRoS0dMNTkwd0diRFlJOE5ja0ZuYXJ0U1RhSGVHN3VN?=
 =?utf-8?B?bmdBSFpmU0VwMzZhQTVkNkdOdW44Q0dVMTZBWWUvRFVoTitLWXVjbStabmln?=
 =?utf-8?B?LzJQeldjWFlmTjNYYkQ5cW1OcWNuOGFuV2l1bTZXcmZBSmluaWNQWWZRMTNK?=
 =?utf-8?B?cFVMMnVDaXdJME9kVkMxVnJVOWxQQnZlclVkOGMrNEI2UDVQZWUxZlhwMkZZ?=
 =?utf-8?B?WnU5Y200QlFleGR6SWVMOG9JQzF4TU5yUGZmYlFBaGY0VEQ3MDJyeFZxcHVu?=
 =?utf-8?B?OGlublVFd2J0Smt3VmR3dWdyZWNTUlZKVGp2VjVFVjkzbklhR284R3VQUHZm?=
 =?utf-8?B?R0xGc2tVeW1Ta1JHZVBiL2pRV3RTeW9weGwvaDdmQUY5bkgxSldZT0tZUXNj?=
 =?utf-8?B?aTMxY0FzNnBVZ3NlWXhCUjh5dWZXSXNLOG9RQWR3a1Y5SnVsZkNoQnBLVlpm?=
 =?utf-8?B?bHlqOTZjTTNKSm04d3VyR2pKbkY4T2g3blR6YTlmWGowWVBNWXRlS21lODZ5?=
 =?utf-8?B?UUtRNFF2WUxGazJXSnhyT2t6WGxwZWpaWUhtNFA0Qit3Rm5FYWZiemYvVG5a?=
 =?utf-8?B?aWN4cjRBaGQ0NlY4aU9WeFEybU93eWlLRG1ELzhsM21DZXZuTUNTZ1RwSjR0?=
 =?utf-8?B?NmhQMHNFU1h1dllLVXFYMnQxRFdSRVhPaGc5Q2Uvei9leWdvVlJuaTF4THp4?=
 =?utf-8?B?ZEtXRkljRmdTYm5lcGhmdERSaXo4YUhwQ25PVlVGUk0rMm44ODhpaCswSnVp?=
 =?utf-8?B?WUVYYVN6SHJVeTVSR0hqcWE0ZFVHc2lIclZJYUJ1VkhYRGhjSFFuK08waHZh?=
 =?utf-8?B?dUN5NlFYcU52RTJJVElpeUNhREpaQ2Z5aENQT2tyVlYvUnNud2c4dkl5dmdZ?=
 =?utf-8?B?Q09vRUoveFI1NFhib0hvRzk3Qm14YjQ0NjlPTHErRFA4ZVFxNUhxanhQV3Bw?=
 =?utf-8?B?RHpBb3FxUVBROGk2YUF2WnhkbUE4bGh2Z3Y4MWZFWE9YNWxodEFyT3gwbTNL?=
 =?utf-8?B?U1BrY3YxRnR4YTV0SVNhRkx5KytaRnVZU1JSZGlOcXo5VVdEdVR6QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5893c5f-ff2d-440d-63c9-08de7402d126
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:18.2396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzm7hdq2grfhTz0YT2y+l9EK4a+/k/82ZJckEKa1J2f894UyC3ruk9i+Pc4IK15tNeiTrm0CwO92G0v7fzceNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

This patchset is to add support for printing pinmux settings when using
"pinmux status [x]" in U-Boot with CONFIG_CMD_PINMUX enabled.

So these items are included in this patchset.
- imx_pinctrl_pin_desc structure and PINCTRL_PIN()/IMX_PINCTRL_PIN()
  helpers for defining pin descriptors.
- A full pin descriptor table for i.MX8MP pads.
- Implementation of get_pins_count(), get_pin_name(), and
  get_pin_muxing() in the i.MX8M pinctrl driver.
- Guard pinctrl match table

CI: https://dev.azure.com/pengfan/uboot-ci/_build/results?buildId=27

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (10):
      pinctrl: nxp: Kconfig: Typo fix
      pinctrl: nxp: imx8mp: Support print pin muxing
      pinctrl: nxp: imx8mn: Support print pin muxing
      pinctrl: nxp: imx8mm: Support print pin muxing
      pinctrl: nxp: imx8mq: Support print pin muxing
      pinctrl: nxp: imx8m: Guard pinctrl match table with CONFIG_IMX8M[X]
      pinctrl: nxp: imx93: Rename to imx9
      pinctrl: nxp: imx93: Support print pin muxing
      pinctrl: nxp: imx91: Support print pin muxing
      pinctrl: nxp: imx9: Guard pinctrl match table with CONFIG_IMX9[X]

 drivers/pinctrl/nxp/Kconfig          |   6 +-
 drivers/pinctrl/nxp/Makefile         |   2 +-
 drivers/pinctrl/nxp/pinctrl-imx.h    |   8 +
 drivers/pinctrl/nxp/pinctrl-imx8m.c  |  62 +++++++
 drivers/pinctrl/nxp/pinctrl-imx8mm.c | 310 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx8mn.c | 310 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx8mp.c | 309 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx8mq.c | 310 +++++++++++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx9.c   |  89 ++++++++++
 drivers/pinctrl/nxp/pinctrl-imx91.c  | 228 ++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx93.c  | 244 ++++++++++++++++++++++++---
 11 files changed, 1849 insertions(+), 29 deletions(-)
---
base-commit: ee2c4f999c633c3d175aadbb77d08be5a91b354e
change-id: 20260222-imx-pinctrl-ef2e6624d6ab

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

