Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E788EFD460A
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 03:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E5183E83;
	Thu, 26 Feb 2026 04:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n0lH3q9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33E6A83E61; Thu, 26 Feb 2026 04:10:51 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013040.outbound.protection.outlook.com
 [52.101.83.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F0183E81
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 04:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFWEqUOFAsMfYxKrm23YlFCDM/4s82akr5uyTM6en72tnDunJiCmb/ol2pOjhC3Ozt0ONl5vezUvQi885IdOqN2wxNBTQjRT37PUZPwRzf+oo3p+U5fREajKKiH1eFqFg5TvjehC3IJ4UB0QqXO4uMaUZbGPquKh+0YN7QgiPzQxgXJK2rhREkd2fU7VMt+ToHDzbEqA0BL3apPNfllOOoe1QcvfMMyk7baH4P1jjXD6QIkMcmY2jxd2+XZzSIBuOqSeIuE8zuivYEzsCVC/y/45LnFjkMxAht1XWTqpIyDpcEXzuxVLH9E4FjwQEX+Z6rDyrUwT1dk6spekoqdlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0WSWjPExzKKeqfV+tMgHeJQPLnnNGl70slumnhD2qg=;
 b=DVMWZEwGwbyKzmU8KuJMhfuwSP1xdGJmj6iETAQfFcibSx64atE2XjmTFf6mYiT+zKnYtnxKqffRUmdTvhz2fmvunwckJ6LyziPqwyjUIbgLi6f6gTFFh2OcB0rHbSbkVxj+WzJpoMW9DwpsINUKEtlBFi1KvXo0NM3Z5HaMn3hCJEn8+lD7DErSG+ko6MUp3gB7KNQf2l1RuSIDPtAecyaocx8B1zo60D4CdzBhqbdueFCkC02oGOA7JOcbccVw56d1ToNlv+cz4YL9tDOLhAreXQl3aihiUusHUeRPy04HKQJc2rAAUwWRbCKx2zahrz5jGDcmufqLiVX4QYsdWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0WSWjPExzKKeqfV+tMgHeJQPLnnNGl70slumnhD2qg=;
 b=n0lH3q9KEHZPQ48A3h522xM/tK6pgJdIG1LCrQBflIh5jO24KlYy9qGPxYo2ypf3SggEi9tgYUMuZp1ypfLBmms2Q/tmMW/FlA2+Tog0fnImF2LdF+q6FQJaZwDm3irIdWaqYx/Vkw1X+RpSH9x7gyqqs9oqUFi6KJYn88OyJuOGM+2gRLgq+JI7kxKGVNsxrLnVMdnCXVeX2aPVrAYGwKYPOINf/Sfgp/9BuQz8fmgXYPD9nLg7ZQvvH+zLQs1SJXCwnvh7Q6EKpaxJk0ZpZyoTv8j28FxYBCiS4x2Zz05X+9LLTC0YH/PWmYhTB2/gAw/0He6vLALkCBUCoDr8bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB11013.eurprd04.prod.outlook.com (2603:10a6:150:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 03:10:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:10:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] cmd: mmc: Drop trailing space in Name: before newline
Date: Thu, 26 Feb 2026 12:25:29 +0800
Message-ID: <177207977388.1460793.12909238310217678316.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260208145142.10341-1-marek.vasut+renesas@mailbox.org>
References: <20260208145142.10341-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB11013:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdd5f72-8eb1-4bd0-18e9-08de74e49d0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: Y8jj73wzsdrVNa/ONgsI36DrJCzDZIx3dbxfOL4H/fxwcB/gG4lQQh2lB9S+gEcV/S5PokNbLxKuC5CdETkU7wuz8tNuf1A6nXPfc2yZjSqfVgR/5CJkFWoxRRcrrLhYFNK5EU2gVFEHa8krXYrO08c1W1BjSzI9bgMPXBXCk88IECH3T0PqsG9nMXFUnoS0i5H+uFlEb8/D/9d7CI0ACM4ZYU4XpCxbXA1KFwKxamryGO+nO3zMRucIB+rdI/1rdJMhnmO5lJhpPodIHJ3LQa9XCxtcMhio6f2T51g+m0rwR47NotVyhcveFLzgZJ2/I3Ihe2VPz4gXaLrZlMPFJE8sptPI1rX2pnXSREV6FpuRy29lEv5US6r1Ek1Rog1NJByvF1gl8OuhteHUxQah5Y+SnKn0/JRLA2PIlN7DvHcZLUAW+6Facl4dz3iQXVy7yyDVUXUX2+jLIhDHCWaaXXoKNHMfMYjFtH6urVgV9zl8gL7Snxfnk56XdJLTbkSuArsUz/n0tjVNZj7hVHpRBbi7YTj2eVgtuUZPxzJdSEoE51OZ7RNZMu98tFpg3ZCQOwtS4Egpxrj1Kshiu7gP83BQV2Rs6CRauFPYWXCeT2aZG3PWfc84kk9ZLcJx0uo7pXlIz8OycPSXbPIFNJWjEWhOeaJV0G22Y8etmyUL9dpROQWh0AweUrwNv1B7ErB09R8wMmkumD+SfhSEbzL01vUjUN6kKYtZlKxwrfSLYNwhd39KILYNhy1ms0u6BaI0BFJfT1qh+AZxVQcv5mR8JAzcZ4+eG3JagM78vQdZL1E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZseEtSdXA1TGpiWC85aHlSb20wNm9Od1FFOXpzSkNtdTd1V0M5Y3ppaXFT?=
 =?utf-8?B?Q1FpYlNQVGI3STVGb0ZWcWJRNlZiWEJIbHJEUTF2a0NHdFZxcUNTMk8vT1ZE?=
 =?utf-8?B?Z0FyVldhMGdhVEsyK0s3T0lxOG1CaWxmd0pIdWtkV1RiWU9BeDlxNTZjQkE3?=
 =?utf-8?B?UVRNK3g1MUFyK0wzMk41ZCtJV2xyVkczaksrVUV3aDBFM2xmYzBPV1BqbC9m?=
 =?utf-8?B?N3ZBZVd2M3VLWVdMWFhyY1V0dTFnVkQ2MGowYkVlSjN5YUx4QklXM3pxZlRz?=
 =?utf-8?B?eWVWamVyVy9kcW13U21pTnQ0MUVhck8wazc4Z01UekVBakNwSklJeE03ZG9X?=
 =?utf-8?B?WUZrRk1WeGMvQ3pmT0NYR1k5b2xkTnBaSHlwd0ZnUUdwMm5RcnR2WEZjWEF5?=
 =?utf-8?B?SXVES2tzTmkvVFpUdkNJVXI5WXZidlhhNU9oRFRSb01GbjgzMnorWm05QUJE?=
 =?utf-8?B?c2o4clNYKy83Z1AzTmZsZEdEamZLeFVVeDBvUE9IU3AvSnI4WHB0Tm8wV0Uy?=
 =?utf-8?B?bThzcEsxRC9nUmFUUDhnelhPL1Mzc0Uxb1ZnUWRXdWpvQTd1dkhoTElXUUlO?=
 =?utf-8?B?ay9GY0dneVZSUkp2SVZGcGRBdTAyNzY1WEJhdlhUNHZURmlWSFh5bDY2dkxB?=
 =?utf-8?B?eFBDWmZhVEtRTjdqYzdGS0tzRWk5RVYwU2JiSVkzNjNTb21sMVVPRGtwUlhE?=
 =?utf-8?B?clJ4TkV6a014d2JFcXBlRURVbXRUcHhydW1mR3d0K3ZZTnJHMzhHY2NzdzBT?=
 =?utf-8?B?RjVLOXp5WUMxdVRuZkJXVitsS0kzQUpLWWF0UlAvcnY0My9hN21MRWtxbURy?=
 =?utf-8?B?UmkxanBLc3U1bDZZN2E5N0lXU1dqUWR3T256TndQeDFhcit2R0ttQUlOUkNp?=
 =?utf-8?B?M3BKM0JnaGNrd2xBYVpIRjVaZU1RQ1NrYjBTUWk5RGRKUVE0dXBuLy9JVm81?=
 =?utf-8?B?dW9YYlJ3cFBycmpzQURoS1dQc1V1NHlLazV0ZkFpb0dZcDYzMHFCZGw2M1pr?=
 =?utf-8?B?d1JrK2tES2c1a2Z0SnZ1TTBIMlNqZlNIcnBpZC9HWXRwc1dKdTlxUmYxT2g0?=
 =?utf-8?B?NVh5Yjk3Q3hEZG8yN1JTQkRDcFc0Zm9qKzFlemVYVThYb2w2ZW9CMjlDZkhy?=
 =?utf-8?B?bXJRb1F4M3VBb3hMRDNnMStqbzJRdUJORW0wdllPcGtzTlVYSjlZb3g3dlZv?=
 =?utf-8?B?MDljN1hKbXVodHoxV1RIMUtHdmhKZ29zWU1uQ3Z3Z2pLbTZSaVZHYTVDcUlE?=
 =?utf-8?B?aTl5V0VvL0RtaUEzZjFBVDFtNktDMGYvRmJzbjhmbVB6WTdHdzlQeEJjeWdT?=
 =?utf-8?B?WkNCdkFkdTQ2ZVdrZUswRStTWmcyTVFkUk5SbHp6MDZiZG5GejBDc3hDN1F4?=
 =?utf-8?B?N3FaTUZZc2F5clVOM2lZdHk2UjdoakRTd2RTNUtTQVFtRWljU1NuYlpIM01w?=
 =?utf-8?B?eHB2Vm43Q0tCbWtiWXdrdE5RS0QvczVDdk9PbzBNKzYzRVRWYk92elk4VDVx?=
 =?utf-8?B?Zk03b0tLSlYvbUIzc1k5ajcvdjdPSnY3c0kyc25DRVVyeTA3dE1tcHArSUVa?=
 =?utf-8?B?UUFVUkpCVDZIYk1QeUhtR2NRUXA1TE1BYStkTTZzZlZLUWlneDczMEJ4eTR2?=
 =?utf-8?B?WkdsVXozOEFGVy9VMWRnaSsrMFFuK0JwS2pIOHBlcVhpYUU3VjdmdVhrckdz?=
 =?utf-8?B?Um9yNm80aDY2ZjhGM0xleld3QTIzWTFXdlJYUVRCY2hsK1owRXF2SFpaL0hY?=
 =?utf-8?B?OGFYN2Z2WVNUbmkydStKbm1CeU9oNWpWY2MwNHBWbzZFZHFDMUpWNHlMcVR5?=
 =?utf-8?B?Skp4TGEvSmZQeTBPbHhjZC9WZzNpTWVGOVNYb2NTeVFyaktmNkh5ZGUySC9z?=
 =?utf-8?B?R2hNemlST0xyMFMyMFFVdlNsMFNqd3JOWnBMSHMwYTBxdTlUckQ1OFNFeUg4?=
 =?utf-8?B?VzlKYlJGOXZkQ2dPN0ZLd0FPMjR2cE4rTjBVK3FjSVkyVHRuM1ZFL3hlemlO?=
 =?utf-8?B?OUdIZEw1SjZuMWhrTW5kc1BkYXRUN3Y4RWRNUmorQmpVYTAyRkYwd3hEQzNS?=
 =?utf-8?B?eHJCM2Y0dkM2b3ozY1lLTjF2NTRKMys2SGsrMnJUaWhxZUtuS3lIdjhMZy8y?=
 =?utf-8?B?U2lxemVyYjhtdXdKMnlBWWp0Qlp6RUJwdkE5RXdXRDRWOGtLaUlJRXJ2QjA1?=
 =?utf-8?B?ejY5WGZMbnJyQ0VVMUdRRW9Cbk9iNGdLN1E1UjJybk0yN09QM0R6aWlrSitu?=
 =?utf-8?B?Mmo3ZWVQRjdubTBiTWdEQ0JrQUd3aDhyNGJJK3ZKM3JoSFNnK1pjbmhObWVj?=
 =?utf-8?B?ZSt3NTdiellzQWFraTYxN284dmpuWjFqRjNSQ3BZcHZnOCsycG5PQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdd5f72-8eb1-4bd0-18e9-08de74e49d0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:10:37.3064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBmIIXHbeyEh9s4ly+fG/cnIpDl/hKeCO+PAkvFlwG+hgD7kKcuoCzmaIH6ZR7P9vetz74DCJvsAdyOdYLfcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11013
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


On Sun, 08 Feb 2026 15:51:03 +0100, Marek Vasut wrote:
> The Name: line of 'mmc info' command prints a trailing space before
> newline. This is not useful and shows up as trailing space e.g. when
> the output is checked into documentation. Remove the trailing space.
> 
> 

Applied to mmc-next-2026-02-26, thanks!

[1/1] cmd: mmc: Drop trailing space in Name: before newline
      commit: 6f7d976317c59aad1af0b8bb169adca9b5802ca0

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
