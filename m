Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB71CD3EE67
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83FD83A1E;
	Thu, 22 Jan 2026 14:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ETH9mXu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA96A83A6A; Thu, 22 Jan 2026 14:49:53 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 282F4839DF
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJOdVbPuODaLb12LGNJ/KgYPt0plPMrtdKP54p6FHoAxxq3qdzmP6Yr5U06UZnwg6v+Xdv2zoVsHN/HMWjsfUY0kj/ro7pchrdqWQIYpMkt0Ds0HmjuHp8omZi3p6kXaXQvEK0IErZkMgQdiw4tw03lKJRCpvVRXfWbUtsNDQIStlNZuLz7aE2vV7aaVNAtLA5hIemJA+3EQ1a4blDIx7rQDXsTPfbMD9q5t2fwDJU8HXz3jf9kR6zQvntarfnaZhE7GK3P9tbBDhlGQgpEkJANltY0uiS/eKFRJIK/x5bNj2MVyKSu9sJWrHr+8bLiF0UftPrtRpQCBjATzTvJW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+D4N4qsEGbBpWPySb2TcHoqVpGR+sYvHNFFmjObK04=;
 b=T5NHDPrPbxCiAKNbl9uQuO3GYtUEePtzGfaH8MxYz2q0sCuqOcEKbl0JS48LCUDuGnztlTSSGLu0H1bS4g0R2TZFmJoUkXwkLrGSwyYiA4JOx7gdpxsvPYiw+PDvRIPVLMKIkU56qsWOW/mtGB/6H8ul+454vQhFuICUdNA+Y5G5FDCcwgNC0yfhazye38YjgoNgacsSM8FfL5jeTO+DUNynk8ejS9WoNvs5vpB2I6FFwwCl4zG9vjOP2BsHE5MGpPggv/OMAH14RBOZGmPd8k7/ex3qaPlIqaWR2T9zarZ0rCQFgffZ9xjRMywaCIp6Q3SPaPlttnL5ecquKylzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+D4N4qsEGbBpWPySb2TcHoqVpGR+sYvHNFFmjObK04=;
 b=ETH9mXu1cS3des3ogKBgO2jDLCjRZmkM7VnqIATNR01VKwluuja/X8qDCqSmR1HKgUUQ3X8dC7R1fIuYkZB4w94seteb5AZf2jcLNR7NaKCgKtr0S/N+5FBmVo1zDYClQxVq5X2fcnd2NQ2IHB3C1T0MUK83bSRRUjl1qfK5KBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5420.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 13:49:46 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 13:49:46 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] am335x: add support for loading u-boot from multiple
 offsets
In-Reply-To: <20260122131728.1551365-1-ravi@prevas.dk> (Rasmus Villemoes's
 message of "Thu, 22 Jan 2026 14:17:28 +0100")
References: <20260122131728.1551365-1-ravi@prevas.dk>
Date: Thu, 22 Jan 2026 14:49:44 +0100
Message-ID: <87ecnhrc3r.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::22) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a60942d-c2af-4288-ab96-08de59bd1a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?emfaxf1X6umXIat7pvwmZCkUNua0YeGA9GmHyNh8PEIvbwGPC6UhQ8KJu09E?=
 =?us-ascii?Q?1tjjr4C91ZfgIVny4VoOFZvUKi5WMXjEcQqmvMIacdqbvuiH6Fd4spk094yO?=
 =?us-ascii?Q?rXzOoblAvNMM5uDdPeLXhccue4dW/U+FT1N1v3km9sN3/TeZF2PEtA+rr6C8?=
 =?us-ascii?Q?A7Cp/PkeurqTBx0xm5ff9AlbQiab//bDtzeGS7rtV8NSA8bSFirormi42s6R?=
 =?us-ascii?Q?FwFNwDVr4rv2/IUcKFzkwCy1PeST2RQbZfGAXPyvLjGHpVo/9M/gFjuhthbv?=
 =?us-ascii?Q?zrs7dtNJB5HydywnzAsVX+uzUFvXgxZNI7aLtvj8jWlxB+Q/5py6wDrfaZCN?=
 =?us-ascii?Q?wHtV3KciPNaZWEL9cY+c8WVaV+rBGAIQoFUBOaS7dbQwX8q1M5nK7Icexsxq?=
 =?us-ascii?Q?4TdVCTaZOEjaczvgrWKgDkGgVO/cMCaTrFBUrmbsBaYuC7yxqO8ZKgTHGDhn?=
 =?us-ascii?Q?mLR7vfOUunkLFuj+jB9Et8hBS3XjiPcr7nLOyDrSy5ONpMFY28HtAltMrv4n?=
 =?us-ascii?Q?dPgfojz5OX0ucjPfxco8+NAOF90LH91HX4jG7WsVvLm6QWRT66tmIEDbTLp8?=
 =?us-ascii?Q?17MBPd4idAKNIv2k/DKa3PA+8pOU2Iophou+bTj9WEEgwYrsmdBM2igHluUu?=
 =?us-ascii?Q?9LzQyysUw2T1n4G9BRG0bUrIz0xCpeqDsSp2MUKnrFKaoyakmS409WAMSrUe?=
 =?us-ascii?Q?yVGLg/VS4arJDv3o8GBHlpdXIIx743UkegCBphWHbAKzMYP9oa0ilHJVkwB0?=
 =?us-ascii?Q?lKBPo0E/D2Mbs9GUrNZCAOLAZEVu5ibG93A4aGO4NHoV81Z89wo86bXjRGPz?=
 =?us-ascii?Q?A2qPQULz2TqdiDFOlEc/50TsicN0s8FqAe0nLQfBuis8knAcwTgalwN7VREt?=
 =?us-ascii?Q?SOzF9E6eiLgqb5DCA18UlBljvUWv93GXE12jYtJwIgsekWTdmsIbjqVvhSWR?=
 =?us-ascii?Q?omIKXE2z8nHtDYYohpODD23mvUCusCxf94n+7LY9SSJxKb3uwJkosYOWZ0oh?=
 =?us-ascii?Q?0G7IllG2Ldj272EnhuEIji9jJWw8q2Zzy44OtcX/z6JXile4ooDvDvKTR5cK?=
 =?us-ascii?Q?KeAm9hLyVxLFXPEaTkqQ4menpKPXysrIxpLyD5gBkBlVVLyGZDPTFc/6QI6Z?=
 =?us-ascii?Q?+BF+XiSGXIFOXQHVapHcOsPmYZyv2mf3yh4iVYjpAWQqBu+8gRecUItIqU7p?=
 =?us-ascii?Q?RRf/4XRau9DDoEjPtoZSkPhaUD0WSWCjliSBGSQTMoOc9/iDEhFRDRJchkq0?=
 =?us-ascii?Q?5ad3UxC2FzsKmyj7a0M+JO7Qr7OnUCwqphEUJhkIB7zifLL8utTaTbHR6RXw?=
 =?us-ascii?Q?yq5u9fK+8mVqAKAf/+5pEfav9+b+jT4poK+YV5aprMho/vJu8vxMR+oWLn6j?=
 =?us-ascii?Q?hS5ypfs2FEzrI5mkFiEvkP3pMLwtTJohmrXQWjf5K9jcJK8QWkCeBF/nN9XA?=
 =?us-ascii?Q?c43wd6Kn9OSPnjCzcpGmLbNX6FTrOeSMNDolKb+4Prs1Tk+DSXO5KtqzRv2n?=
 =?us-ascii?Q?7Qr8nWRcvuda69m11gQY3jrN0ubPiSWdm716L7LJ/vmckoX4D90NhPkzbE71?=
 =?us-ascii?Q?ng6PpiGicS34tlByzlYFB7i6EuLkvH3snhxf5WRurv1VUfLeeCBGB19F7iJY?=
 =?us-ascii?Q?ScsnIZo2MY+dOeCjiAthY/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Pw8qN/2CpxmDqzcpmei9XKpb2Z/rOpquZ4Vggvq3QmFTkEjLTCbbtoHpcSW?=
 =?us-ascii?Q?x7rm6eTMWUQZvT3CVOs9h0o5HTm+KyU+MBmXhahhcy9QLRRFEfkJnT5RfzHj?=
 =?us-ascii?Q?wtArWcY0q9q9ZTwBclTEYDmmF+4GeprGitgVsLJmQZMhz6c5Bj3RImtLcDcZ?=
 =?us-ascii?Q?Ez5t5yg0ewhqAYjngqVfZH+LyCahmfUgk4xbSoQdwPAygftQdf08FnPyyc0o?=
 =?us-ascii?Q?wyIyPiMmDTYUd3gb/JjA1DTreKGtO6JzmPTGv+ISMSD6xgVLNimUgPo4imqd?=
 =?us-ascii?Q?CTrMShmg24jUIqKxqIEi39GOL/qnQJIjrTs7n0AlrAzQ1wbhTWJGsmM99lhU?=
 =?us-ascii?Q?hudyv7pexCN8GmYYp7ZGLCkKdejLe1/024dSqja+6NdOY7dJp304G3qMO1Dt?=
 =?us-ascii?Q?S3z7q4FBmyp/EIelsoooFQM9bWWXfawrb9qtnHNFkyQCV3BCJSfoEdEkuftw?=
 =?us-ascii?Q?SuKBjnhDy+cEiJ9MO/MfjWWATO0p1XQ5R3p0cIyLIG7GlcG8NOSs4pKjiRRk?=
 =?us-ascii?Q?OiCwKZE5EWK8IMoVip6LEDPL899hP9rlZS6NaQLfZEhObcnK7aZum2PIPLYg?=
 =?us-ascii?Q?4NENHTcB8ltaTw9xm4SBG80rdu3JC5zKYD3vARazyBvyyUnI2CUjoYPcJsal?=
 =?us-ascii?Q?ykBsMWb6GxPvbttnSwYUiI41I+EgwxjYWo4r8q79lzH3ikj6oqm/bQoSlfvk?=
 =?us-ascii?Q?X28O0TxDay/Wcs8JMKZyYNNWn3MlJdGLg6xoRMjjKsgJTPTAOHl7T9CAs1hT?=
 =?us-ascii?Q?cXTLgWqA4SVhsQWEVfRE12WVj4VWLHfSmb4LAiadftHaIyg9n7Qlm0TcHxNv?=
 =?us-ascii?Q?9StJs/HSmYVH9Bd3fDLiQr9WLBxuBCRw/iVWZ1bL1UkzcFJYLEds6gwRBWIP?=
 =?us-ascii?Q?ZYp3sWhApxA9IHC5306vUrOSIEEVPXujEKhCjnXdrEatUHNIkVF0To6/xOCs?=
 =?us-ascii?Q?n15a842DJXvaqu9IGyTduf+jftaey9fMHhzWI6DJFOsWnmtf6shTNiWTgbBI?=
 =?us-ascii?Q?JJmMGEtAXktNrrfb1XlOBU73kdFT9+8mpktsHN40XC2bt9NrrAanLLTomPyx?=
 =?us-ascii?Q?5L6PKVvCzWnTcEUEetE2HCTj95aB/pRWXhI1jBy4cCRChItGp8/yDq6xCEcF?=
 =?us-ascii?Q?GWCAyiRaO0iwLuSZXkZkpSor8mYA6lJF1ufOT8xe0Z5FibByuC6/0uTaL4o6?=
 =?us-ascii?Q?hYJMhLBnjE6ZZ/wRbfnmv+9WLNA4fWt8OAa/stocPuIzgRqoletedo8sEQ9T?=
 =?us-ascii?Q?Ir9TMAKNKmbj5JonvTzgS3CEwIcrHmXW6PXmZ/NLFBE/p5RZRDxg4ckSG/VA?=
 =?us-ascii?Q?/II7qXvyaoTDUYSlUuwWfT3vXFjxUEFrDL5W+0Gn2A6xf/l+nPGS44Rx/D/z?=
 =?us-ascii?Q?34nHMbD3ukdKkYOCbuTrD6wJele5bjEkZYV4oCoUsJ5cxlRBv/mmyZ/sX0Xk?=
 =?us-ascii?Q?EiIcBi2we0Q5Q/V474L+Emvgu1WKKdF/Fy542wly6F0bm5VP6x4GSue9A5ZZ?=
 =?us-ascii?Q?G4nn/3eCzp1X21uyjcEJvNKZLz8og2OE4x6EN4tCW1B7M14B2xA/IFk7nZmD?=
 =?us-ascii?Q?0CTQgnp3kN3RUZ3LQrVeEcJKm2mChb5921hRhSknbZ8Rs0qGQMpajZPCgPBC?=
 =?us-ascii?Q?a4P5ZKsRnFjOm9R6o+zLITwqxjjGKW1k3Ns5nbSSr5vIhau8rhqCDSoM1bGv?=
 =?us-ascii?Q?aD5hijconi/PhIJlPTWNiFtXC28YkZIVdTMHjmiymHuTsKY+MtkPjjIpzXJe?=
 =?us-ascii?Q?F/oiN3laCJtd9LD8Zckbp2Xfqkba/FA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a60942d-c2af-4288-ab96-08de59bd1a72
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:49:46.1650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 108QlSwPcvCJdH8QLLYZMuvUoVp07wI9GUFAzz9f5/WxmWRMbasozNC30x8wd4NXfSdox8HkR8PshCewWcrHrZV7nlJxrj1mKwdoCp2ZHmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5420
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

On Thu, Jan 22 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:

> The am335x knows nothing about eMMC boot partitions, so in order to
> implement an update procedure of the bootloader which is robust
> against power failure or other interruptions, one must make use of the
> fact that ROM code on the am335x looks for a valid first stage
> bootloader at several different offsets.

Additional info I had written under the --- separator, but for some
reason didn't make it into the mail:

I finally got around to follow up on https://lore.kernel.org/u-boot/871prgzuui.fsf@prevas.dk/ .

I'm not at all sure about the naming of the config option(s), they can of course be changed.

The order the trial bits gets set is somewhat odd, but is clearly what
happens, and somebody else trying to reverse engineer the ROM code has
observed the same thing: See the TracingVectors.ods in
https://github.com/sjgallagher2/am335xbootrom .

Rasmus
