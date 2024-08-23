Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF0AC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 15:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F33889B4;
	Fri, 23 Aug 2024 17:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="hlLG7ILR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7E4888EB; Fri, 23 Aug 2024 17:06:34 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E28E88915
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 17:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk5b6bLNEvDgdaZvUnC8vnbFPHjxciqXc3jvpCNwY2zbncezPBaelYATOJtSLSVkWeososnmHNt9rbgQ9TpELtOuwZzQr73iIjJUmor3hRzInGZLJPgmp2z+Qxm1WiPQGBxW3p8IIky9HtU7AA3DjrDyp7oYPbw2U5JyTL+XsLyMwqaoUpfthCrJL2etg8EjPF44b013P7YJdOcQUQxtCjfgYMYSpQXehTm3xJa76xtF5yHMndm1WHK0I7lkfbGRHUHBx8BzZdhNV5Z+O0zoUMRdVVM3Dk+xiExdwBX00hJt3tVO3rfDBVPoO84Ffo3kHT0lBA0dihvit9Ic7ZbuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls6OMJAzq0iGFCwWFuA7YNiiQv5Dt0xsKJuQ0rTJT6s=;
 b=CjRd9mcgZe0B3+ft0NqXxjQ5SowDr2QWld6cZYKVDa6gwn0sL1jPIvA95pI1pHbz5eYisbrNn4fANUqzSgcatQoje2lodqoM9/q5B+twGRRt8BVVukzYA99cWc3pzoZS9t6Wa7vgPVG7b/kCmE0kcyP149ZEaa31q77hq5LwdSEHpAGZrQIJZoXif3uvkh8DQY5ZRHeUI1wWP8RX4V5vAWSuE2dAaTH3QiD7KdvhTiyqFjIXHA23kfMu+q430k5rKGG+lCFvnDR8N9tgt6oVnGRS6ddSBR/S2m2ENJ0lZtC4Jih44twVncf3bOLrkOQblOPiIJ3M969aOBCPeLecrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls6OMJAzq0iGFCwWFuA7YNiiQv5Dt0xsKJuQ0rTJT6s=;
 b=hlLG7ILRtECYiOkVNv9jmHHfmqSrZ3T2LAl8876Bub9ntaO2EFdIrqnv+HkVxz13rSmjxVszg0RqfjNsz+sCzXC7A7meVWd/toW5Xn7XNM7XKSCRhLgTNC2zCyj34oe0qYY1fM+blrZG5MhN8mP0/0TQKIebyPlFjad29b4wOyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7760.eurprd08.prod.outlook.com (2603:10a6:20b:517::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 15:06:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 15:06:30 +0000
Message-ID: <67229df0-7776-4426-a4ba-567cb1e5b6c2@genexis.eu>
Date: Fri, 23 Aug 2024 18:06:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 6/9] net/tcp: improve tcp framework, use better
 state machine
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-7-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTiVnw4P=-OaoStaLHHwKrkZhfJ4rEn-r9S2JtWuytVS9g@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTiVnw4P=-OaoStaLHHwKrkZhfJ4rEn-r9S2JtWuytVS9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0003.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbfe207-a4e8-4254-33a0-08dcc3852b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qkt4MkEwbTdOK09jakViRUZGVkt1VGp3Qks3QnU3U25iYXM4ajE1VWxsNWUz?=
 =?utf-8?B?dVBJRUFQbHNORWIxNVdqbnhadHprNTQ5TlM4RDRGUDNRYjhpUFBJZnJLNkhP?=
 =?utf-8?B?cGxiMVI0eDVTWWdBSlBVc2VoZGlBb1RBZDAzdnFyeGUrdTFwd1hmS2hVd0x0?=
 =?utf-8?B?MER2dW01dytJZHhFcTNXL0xKMStwQittdzQ4ZHVJZ3dsYUREeG1uVHhZejRu?=
 =?utf-8?B?NmE4Y3BYWHhxNktMTW1HRExGczRBZjdVdDlKNXRDR3E0Ti83MWFYcGVmTXZj?=
 =?utf-8?B?TGVXUU0zM1Nub0dHQWZONFBlZVdJbWs3VUZuVG9SZFNwSUo2bU9WZGJnc1Rm?=
 =?utf-8?B?UXdZLzg3eGZveDN6bnVrakM0WnZoYkJhaG9KZjduZXYvbjlPN0dPSjE0MDIr?=
 =?utf-8?B?OERlUkpoYngwOXBJL211R0Nzc0NHRjVMNmZYSlVPL0JPZGtZWVc0dkhqdGN6?=
 =?utf-8?B?Zjc5NHN4M25LUmZyT00rSmJ0MHZFc3Z6UEFGTjg0U21HTE9sVGEwcWNBQ01J?=
 =?utf-8?B?RUNFNCs1RitYeXp6cmFpbUJuRTFlSG5HSkxHWmFHWlBRQi9kYXFsWFQ0VjZ4?=
 =?utf-8?B?azl5OEFZYVpYbjhleEVuWHIvVXE4dGNISVA3bFVSa2J4a2hJdDlNdXdKcHFm?=
 =?utf-8?B?dzVVNldsaXNTYUM5ZG9WV05wanBrY2dqLyt0Zks3bnIxb0FHQlN3bnJLVjgv?=
 =?utf-8?B?cHM0cmNmdVpDaEhUR2xPYkRXL2QxTjV4RzhMZ3BNVEVrY0U5blJ3eFB2OXI5?=
 =?utf-8?B?WGRSNGF0ZG4yVmZ2emIyOVV0encxRkVlREFkS2l2bVBKdWhDbDI1K3dweUMw?=
 =?utf-8?B?TWdnNXgyaFUxUjZSOWFBTXVpV1llS1lPRXc5WEdTdEM0OWcvQ3dubnZqd0xv?=
 =?utf-8?B?Q3BKUUsyS05NeHpGT3hSb1VTUU5zMDd2VFVGTmJ0MVZoWTlLS3NnRlc3dnkz?=
 =?utf-8?B?NVlsTXM4WGNhZEg0RjYwcnZuYUhDckNxaGtEOVZZV0lOeE9aTzAwbnlnWmZC?=
 =?utf-8?B?N2FUQUI1eHYyV0hCMnBxZnR3dDd6R0hZaDQrMzhXVEdMNkxLZk5hdXBEOXFx?=
 =?utf-8?B?bzVxNFVXemI3NTdRY1VrQ2NYZXVSWlVmWFhPMEJrK3lpVk1sWGFXVzQrUWVl?=
 =?utf-8?B?RjNWRjNZK0wweThIejkrcG15b1pmM010M2hudlJzY2hZblV6VkRDcktpVExT?=
 =?utf-8?B?anBRL0E3cFNVVTg5d1ZkTFAyV0pLaXVPc3NUQ2FCUDJqR0ZNZUE3cDh1R1NT?=
 =?utf-8?B?K21kcHBlKzM2dnMwUHdkcGRGT3BkdWg2ZU05TGdCc29vVUloaUxFY2V5OElX?=
 =?utf-8?B?SmlyODd2b1hJQlcySzBaOTFFeWVka1VKeHpxdGpibWNnMTRjeThIbTlKMlNL?=
 =?utf-8?B?MUtaVldFTjhmR3VoRXgzQ2pxRU1xOXRZeUxtMWdUVjZReGNuc0prY0t6dGds?=
 =?utf-8?B?b29MRzBPd05xWFZmb0tCZm1TdFJiejNrN0pvSkpCVTMyVkpnRGZOTHhkS0hm?=
 =?utf-8?B?ZVJQY01wTFNwazFsQnFUbk1rUnppditSSkhGb0dHcmVZbEtJeTU5K2RSa0c3?=
 =?utf-8?B?ZVdTT1NuUkxpT3pwWnRsN3o1SUVsbUY2OGRoTUJXZ1ZzOWhXMnFSc3lWMEgy?=
 =?utf-8?B?SUQwamNpeGVlOXBTVk1rdXVQQTNFM0VCMFltalZibzd4OWp0QThwTG1sYzJz?=
 =?utf-8?B?dk1WMGNST1pPL1Exckl0UnZ5TGxObWlMWkJ5K25sYUxXV1VuMDREYVJxS3VH?=
 =?utf-8?B?UE9GalhodWdneWphVTdoajZBbVdNcG5SejRnNStYd0dKUERzZHRhb2pPTG1R?=
 =?utf-8?B?SFFvNitVQnFFTks0ekRJZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVhTd1lwQTZJT1QxWVZvQnAyUWkwcE54TmFJUFJuVE94SkZBSnRjbk55VDho?=
 =?utf-8?B?WU82RkIxcFFnSWgxbEUyenJiVmxXN3N1TTVnSm0zaDVZYWRVUmszVi9qYitZ?=
 =?utf-8?B?WGxpZnRNQWwrWGd4QUtScm9KWUkvUis2MHAyRUs4bDBFK1NZbDlybVF0NVFx?=
 =?utf-8?B?cDhlaVUrZkFabktMYlhTSUhjNU9UTExPQm5aQUM3UG54ZG1HTEVpU0l6TkNZ?=
 =?utf-8?B?L1o3SXh5aWpUMENEYmNoOHVZS0g3YlBvNkE2VlY1UjZQMWFkRHVFcU4rdklt?=
 =?utf-8?B?WWJKVXd4QmFHcmlLcTZXcm5hYmlUU2ZNTEVyenplRU9pTWhqQVZFZVd3SlBw?=
 =?utf-8?B?SnNZYitieThmak92d3MxZllaVmxUb2VQaGd2ZjZYV2FZemRhQ21jd1duaUVn?=
 =?utf-8?B?ZVdta2QvTEpDVHFOWGVwRUlUZGphZHhIcFVYY1RFVTI0aGovVXdCYXB3WEVi?=
 =?utf-8?B?cHhPVjhHSm51SWFMYVJVVCtVNjFPODFSdE1DV1JieGNSRUs4dWpaYVkwYU9E?=
 =?utf-8?B?WUx2TStZOUN3R0dpOGEzTTVseXZBWU10Ti9zRWNPbHZVWkdpR0s1WlBKZXZr?=
 =?utf-8?B?WGhPRnpBQVJZYzVEcFFneEJaZVFwd1NQTm5uZG0vL2NGbFNyZ3lnSVRqSGU3?=
 =?utf-8?B?WDFIWWFBYnVVLzFlWkxyRmZxVE1oS3g1cUIzK3JPYkZ3VTFXVFVoY0w1VmhN?=
 =?utf-8?B?UlpiYWNFQnlqV3lEcEp0UHJTOWFUajM5NTl0eWkyU3VqZUpkYXU2VWUxdWZG?=
 =?utf-8?B?Sm1CMXU5MWVTMWpoVUVYbXJSbTRPUTFVMVF5ZjVJQjVNR1M2dDNpVnZvcUxm?=
 =?utf-8?B?VEdDOTFDbVNCVEZVN1k4WUVVWWo5YnkzOU8xS1lYeGRxb2FhWkJQeDNjOXRz?=
 =?utf-8?B?dGxEZ0QzbXdZMGw0T2liRTZnRFFUY20xRThTaWUzeGM4ZTFmUFI3aFpua3pp?=
 =?utf-8?B?REEyRjk3eDkzUlNZR2NUWEFBa1NZbVNlZDA0NVFQNy9HUmZTUXlKMExaaEQ1?=
 =?utf-8?B?QWw1Rmk4b3MyeWhnTHhhRVFLZVp6L1JtYzQ2ZVZRS0YwM2ZKdVRrM0hNeEhV?=
 =?utf-8?B?cVJ4aUIzSjdpNDk3MFZRVVgwVS8wbU51VGJmTDRRRDJSZ1NvaTVuS3BmZ1NU?=
 =?utf-8?B?eStpaW03Sk1rNDdLclJaWGJIK0xzWk92MUdpNXk5V0RHUkdJRExST2NNa3Nl?=
 =?utf-8?B?K2VpV3llR1RyUDJyLzhKZ21NeGxPak56SFRtNXJmSWRoRkdhQ1lHQ1RWMGpG?=
 =?utf-8?B?bDR1aEFBb1pWVktBS2dnTUtjVy9sL2JQTXRIMnl3bzU4TkkyNjFFQTRzd3dL?=
 =?utf-8?B?dHU2dFc0SjlCVWpUcVlWQThnKzlxR3R1b2NNbzdIdm1DdEhlb2ZTak03YkR2?=
 =?utf-8?B?RkJuemo0OFlOOGhQUmNxZ0tqK2dXZ01BRndhMmxnUWc4TmRjT0VMNzI3KzFa?=
 =?utf-8?B?ZkZPUzF5RmRtUE1rMkY1MFVqZ0FYY0hvblQyL3pqbE1CVWhYV2x0UXAvd2Vz?=
 =?utf-8?B?azZQdVVHcStvRlRSSlZ1VEVmVTZ2TGppRjltaDlHaVJpUUI0amoxOU1LdFNk?=
 =?utf-8?B?Yms2Z05hVTdwVGl4QUt3TmVIU00rZ1BNSmJlV3c2T2dkWEhJdTZUeVIwMktW?=
 =?utf-8?B?NDg2ZHdmWXZXS0NUb21EN2h6NmxPdnA2QWMyVFM2WWF4Z01uZ0hnWGx1VDdx?=
 =?utf-8?B?dGJSbXlwYTYya1dnQzVKRlpKaWw1WklIWXMvRm5HTDRjTlZGNm1IdkZUQ0Ix?=
 =?utf-8?B?WWtmdnAzTHViK2ludkhjSzIrd2Uzc3V3aEx2aDJiNmM5MU9La3pNOTRpZ3pJ?=
 =?utf-8?B?Z3BkZEJjSmpGMncrb2JDQURDQnlXSUpSbSthTFFpUnh6ajkzUTV0RVJhc2VY?=
 =?utf-8?B?U1hrdjVnNDA3bnZ6NGpBS281V2lUV2NvcDBHU0MrVGhzdW9PTW1TUkpVeXRG?=
 =?utf-8?B?Ui85U1dPaXMwcThMN29hWUluaVVmcTQ3OElwL2pSNGNacUxlN3BZWmhBVFQ3?=
 =?utf-8?B?WS9NTjF6anhJMktMR2VmSnpRZ1ozamZWbi94MEZIRnlZc1ZHMVlsV2JkOE9Q?=
 =?utf-8?B?SVJGb3pnRHlYenVqWEZFSkEyNzlkdXI0ZStXVGFQV05xTCt2RVVudTB0dy9D?=
 =?utf-8?B?dXlhbzRpUmhvOFhuM2REWDgvbzZvVHhMemZsclZpcENZK1VjZWNoZlVXWGYr?=
 =?utf-8?Q?zyLESdn61vICf4H/exFfBpY=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbfe207-a4e8-4254-33a0-08dcc3852b12
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:06:30.1819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G92VCJWQqpW3Sl33Y0rSXF2xdY9WAq787mDcljIANXK2tuyzuAFk7wj8/rnX2qWcN/Dk+Z04JS7aVkynoGkylZHeT+pfteUDQk60wzaqTiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7760
X-Mailman-Approved-At: Fri, 23 Aug 2024 17:24:35 +0200
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

Unfortunately no. This patch change the tcp state machine and
corresponding logic.

 I tried to split "initial send value is always zero" fix to a separate
patch but failed.
See the patch description in v4 (when it will be sent).
On 17.08.2024 18:58, Simon Glass wrote:

> Hi Mikhail,
>
> On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> Changes:
>>  * Fix initial send sequence always zero issue
>>  * Use state machine close to RFC 9293. This should make TCP
>>    transfers more reliable (now we can upload a huge array
>>    of data from the board to external server)
>>  * Improve TCP framework a lot. This should make tcp client
>>    code much more simple.
>>  * rewrite wget with new tcp stack
>>  * rewrite fastboot_tcp with new tcp stack
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  include/net/tcp.h  | 171 +++++++--
>>  include/net/wget.h |   8 -
>>  net/fastboot_tcp.c | 190 +++++-----
>>  net/net.c          |   4 +
>>  net/tcp.c          | 837 ++++++++++++++++++++++++++++++++++-----------
>>  net/wget.c         | 460 +++++++------------------
>>  6 files changed, 992 insertions(+), 678 deletions(-)
> Is it possible to split this patch up a bit?
>
> Regards,
> Simon
