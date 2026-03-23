Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B43D58CBE
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 03:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DCD684099;
	Mon, 23 Mar 2026 04:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UI2kEPw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04F2A840AE; Mon, 23 Mar 2026 04:20:37 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0C98408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 04:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5/yZpZ5suIs16/0X3mhs3uOhyKmLThk+f++QF9SE2MccfpCwQMc9wn5KbiOal+t0aMqbSmuKWxSvBVmfZZ/jR9FO/cq77tbps66NZ3mUTBkFvgkpK/k428Lsb9XIwGYJROZN1/r3h/XBck8ZUgpLP/f8m/pEzGpzFMiT71XG5rIsbTGjIHL3/QPfcZAKOpVXcM3TmFhyFNvjTBXN3hpiJWHSRl5zD4RNN0iS+TmVmmocRXvM1/sEOKTe/xUt63TZn4ktPwb/L02qFbU02hiOuoskC0OCdNzRuWHnXa8C9y+UbeZKvA95BHA+praxbhMDiWodcUswxU+cBx+c6XDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjsehNVMl3d+vdWeJNBsmzRJ0Hq4s+RG9wEyNGfddPw=;
 b=UIZRnskFbYYpQlMZiVb5xbHFU/0y9d/jFv5t7P2+2VNOaZBvzhgJXj3QiEQ5GupIzpgAKNdNj6C7l1lR0kNx9YPf2dZ8z1HaKjlsDdkqnxd4E5TeTVG890azGp0p76HhqKsyXCO0ZqyQPiaJ22rNzSnvCAOnitoIpX+WTjEnQlqjSvGrrRYuLm8hbP2C9Rs3G2hxLf/mdv2Jw7IUyt4QuOLpXf6T+yYRbPjs5i8Jdkn2MeC2aVkgKq1dC9zex3pvdG889Fy4W4nWOEpGH7qps79o1D5jOINsBn+cleDXrhPlWYlZxb7a4NeMkRZZN3+xsOYf2VOxu06GwwSplc64xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjsehNVMl3d+vdWeJNBsmzRJ0Hq4s+RG9wEyNGfddPw=;
 b=UI2kEPw896itP9YfZ0rqqPLjBMmoEks/iB4EAy+XXd/sIV0n8WmKugVY1stWPlNXEQ26d2xWDHo38uQv3aqglhWgGPytTOAU0iiUNUBCW+N88edSgz8aSL+9x8hJ3MUvL9CAJq4ng9X0CKTfOJuBq611duf8ydFkNOGosGOM1VKYnGQRd6shy1IXbbnJphjxLtgOgukirw0CSWVz0Ixdxb6jqIvFMD3VhNE/Tte8fYl1BKlsKjEFgXoELggG/UcT1HzwF7WcLYW3YNZr3sWPCbcwJO1XcxrI70z+o4IH0dpet9Aj9M6YF14Ecl+7uuh5fk6ksd9cwt3FdcWNCfYpbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8456.eurprd04.prod.outlook.com (2603:10a6:20b:3df::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 03:20:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:20:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Han Xu <han.xu@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: Add support for eMMC 5.1B specification
Date: Mon, 23 Mar 2026 12:36:02 +0800
Message-ID: <177424051904.2364563.14330681912708686610.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225211332.1896252-1-han.xu@nxp.com>
References: <20260225211332.1896252-1-han.xu@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bdef28-8a57-42cb-62c1-08de888b19b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YEs1Gg+Er+V17gkecQH828n8G4Gz6jCR2gwXuGWpaVt3sTUw1iACbfa08eIHUOKoMg/b5ije7CJCZj+2xnXbsAGtx1T30c29jxpZXvsNuahWB7VXSSYeHZOQWOtStk28AjXn/LUB2Vjwjf89uM5ppfOmotxyyX+7+bPaZiIvzwZH6p0MPwP0gr60y7CCi0Vq6FIWuQImFeyciu9MpAngkCW+6KlraHSYf17RH9ByvdQ28GPVW3SfF7q1uuG44Ki+PCkdiHJpTJfZ65ZmhwQBKEEyF5x6jl7QXgY60ULoQYvUXCabyg4SFt9JQF5bSV8PxE5lmBniFwEy9YmNd9HHm3Q0qbvbr7mk7H9W2yzbscTFZAAea3w4BL7HnhRKep6CiQXFTBBcQTrhEnMix2s3ZDtudS/MgYxYQQznI8A98oGoEY8f/SHVK6WFqDh4kSL3DqsOHDz8+R0g6UI49t2VhU/wEaesEZs3uegGktxJNhxhbf0pyYUtY38MEngGBDE//1T1iFQvNtR6KUAksJ9kveFt3I/y+gR/+Cu86iUWztumyEvqVOI7R4v3KW5E0t57LecXDcWZlLHPvwwQbgW5J6aeqp5UJGSb9caRJDR5rXoYMrZNwZE5yDe/PEXksD5mZ4rODaNzJOFZWZ8QbbNL1oVd5o9qFYgU2udd5PGJgYnwJQ7qv5uS6OC259gEMs9+h0WiP2lb6rjsX6KSu0WiuGaGEilekOgBQMtGzlSy2J4eXd1h+mvuwE9ExEhMaUusvtW9u26OyOWt8CZDRq/Abk705sf6+S8qfahpOdZd2A4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnNZN2JvV29Id2w2ejJQNE5JUUpJYXhqM0hJb24rb1FPUVdwdzFDRnkzOEpS?=
 =?utf-8?B?SUZUaEtibW5jbGVvQXJoU1Z2VzVKMVZaUGN3YkVTWGVlVEs2a2VsNFQ0TitF?=
 =?utf-8?B?NFBIUlI0ZmlURTJWN1BhWUFYdGhzZHhscXVNeFIzdzhMS0hLVWthZG83L2gx?=
 =?utf-8?B?RHhZYTc0K1NlQWYzUkIxNHZzSFJqZmtTbEZRclVRZ0VxWmpJR2pVeTZtMzJ4?=
 =?utf-8?B?Y0VqZ05FeGlxMlhpSmp0OTFhOGF5SXJUdXFFdVR4bjRudEZrakNpMndLTTBT?=
 =?utf-8?B?bXpZQmszS2xnOEpwc2tBZnJPUkJiY21VVm9QY1RGeUs5TWhqOFI2WWk3YVJp?=
 =?utf-8?B?Si9hTzkxUlorZ2N6V05SMHU5dHJFa0Y4R0VPd2NqVll5OHNMSGNtUitZM2NU?=
 =?utf-8?B?VzBIeitmTVRjVHZwTHV1QmJyQVl1VUlNaUFsMlE0STY4SXhCNlFpcy9rS1lj?=
 =?utf-8?B?d05ySU1VWlhxczFnNHhPc3NUUGcxK0J5dFFrbGlyWkZhcGZ2b2FHR3o4MWxS?=
 =?utf-8?B?Z3p4VG13ME5sOUM5eVNZei9RRWdvME95QWFtMlpJTnhCeURDTE1hcys5Q25N?=
 =?utf-8?B?UWxENDUvejBKT0dET3J2Ym5pWTJTb0RGWUNZWlhGcU1jelpvMFUvR2dUNnc1?=
 =?utf-8?B?dXVEUWJmbG81VGN0V3dNb0YvUy9udWxGYXptVDZIYzdHdVVUbVgyU2FZdU4v?=
 =?utf-8?B?ZFJFQjlFdlJpQjdrTGdqUEdHMFlYWVpnVThUVmVlRzBoTXFTNUZMYlFhSmtY?=
 =?utf-8?B?ZElLL0MvRXZud21qdTFiYi9OSUZnOXBzUXNHVjZWK2lNZUpGalVtMDBpRDU0?=
 =?utf-8?B?NWt2NDhpdnI3aGZWSnJmWlBUTm55bG8yWktCa3VDV3duTHVzcWhyWFJ4NFIv?=
 =?utf-8?B?MVlES241eUFvSGFFSXZFV05lU0ZqUEd2ay9MZFlhcUpLQXVHSVJVRVlXNWhP?=
 =?utf-8?B?TVp0N1c0WUdqSkh5TzZPRTZpNmE5ZjlYcXlrcFcweVhYTldMMUg2ejZGSFY1?=
 =?utf-8?B?a1ExY0toRkZhaHBzaGxLZUpybS9QamFzYkpkYWxqQkFBeGF2dFdOZkZxeTJn?=
 =?utf-8?B?eEYrN3FMQ2tua0NMaUIxbjcyMUVNRGgrZzdhb3Vvem15ZkdVZmdMaTZRb0l6?=
 =?utf-8?B?dXptaU05K3FwcjlaTis3NVRVdzZvRkswSm0zcVJaQVdQTmJwOW03Z1VWNS9Z?=
 =?utf-8?B?NVZFTUVaWFozbFJUSmtyTzZDQ3FTTzRPVE1ST3lNMTMrcXdVM2xrY2JQbnpR?=
 =?utf-8?B?T2lmOFlkSytndzlxUS9BRVZaTUx2OVI1RXU2cjVEV0tDV283MkttVk5ONXpN?=
 =?utf-8?B?amg3Q080Si9VL0NCK05QL1c4SWdQUFNqaUYwcGVPVWs2Z1IwdTVmY1JnUTFV?=
 =?utf-8?B?QjR1ay92NUx0WHRTVmhYOFV1Y1FZRUx4QWlBbFJlUDVacmhpMnVTT0ZrZlVy?=
 =?utf-8?B?bnhycDU2WnhUZWYycS9Wb3pEWEZjY21KMzRKR3BlNUdXSk11YndPZzBIcmhp?=
 =?utf-8?B?RUVmZklHanZ5Zmp1b2o4WjBLWWdGR1NhcW9XMnU5Ri94a01TZ2dmVkxNeWht?=
 =?utf-8?B?WWZ1V3dXMXY3T3FPUWlLb2ZhVVNtQUcwQzBiYVpYZytkUTQzdUs2anZrcFlM?=
 =?utf-8?B?a3pOQ1lOanBZYTE3R1ZkZS9Td09JYkNXaVQ1ME1lcnpHcGdoQVhLb1FQaTQ4?=
 =?utf-8?B?RlNhTDc4MXpSQnU5czVpRU11VWROeXFGL3p0d2N4MmlFVVZBM2k5MmJXOXdX?=
 =?utf-8?B?V1dmZ1M1blFXNmhVeEpHRFhueUJkY2hmYkhsY25zMkxBbTFIclN1TzhaOHdL?=
 =?utf-8?B?YzIrcld0cmNRR09TYjdkSStRNm5tamhJSHUwOHRRaUtFckVjNitubTlIeE51?=
 =?utf-8?B?VzN6Q1VNRnlNRWtoUTJvZldvdUh4bnFZV3ArRHdhVWp4V1JNbFQ0dWwzaDZD?=
 =?utf-8?B?ejVNOG5ZaHBRWU04eW84ZFpRaE1PTDlVUG9NVlhoSXV3VmVmWjhZd0VKR1VI?=
 =?utf-8?B?Rk15ejlnbFR3SnBlKy9FNnlRTXpxUWIyNUFnUnVRcWNxR2dvYUUxalhqL2Za?=
 =?utf-8?B?NFF6SW1SaHVFVmpmNVV0cXZlRHdEWmtsekw2ZFV5WGhTQXdEb25BUHVYeUFt?=
 =?utf-8?B?UVV6b25QRUMwMHdlUXNzSzhGZmh2dEJKWFlhWHovSzZ6OTdzUk13Z0h2R091?=
 =?utf-8?B?aTd3OXBtZmhyZmpXWlhVYnI3YjhKUG90UGx4UGJCWjhJeTBvblFvbTZwS2FJ?=
 =?utf-8?B?YXg2MVdNTXFSbGFVd0VhZFQvNE81a291WTA4YUNJV25PR0lOSGlmSi8zUHRE?=
 =?utf-8?B?ZEtiMllUUS9ueUYxVForaDBjMmhuaG9PSWM5MHNSRTJ4bUVGb2lvZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bdef28-8a57-42cb-62c1-08de888b19b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:20:15.1236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1T7ZjpXu0yhkG5uhGVg6wsNK/ISEUZ3lY70t9z7k6Qro7MN5wAfIkEqqmxH5DybTQ6PN3guJDtHAt0r1CJLrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456
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


On Wed, 25 Feb 2026 15:13:32 -0600, Han Xu wrote:
> Add support for eMMC specification version 5.1B by defining
> MMC_VERSION_5_1B and including it in the version array.
> 
> eMMC 5.1B (JESD84-B51B) is a minor revision of the 5.1 specification
> that primarily addresses MDT (Manufacturing Date) adjustment for dates
> beyond 2025. This aligns with the Linux kernel commit 9996707822f82
> ("mmc: core: Adjust MDT beyond 2025").
> 
> [...]

Applied to mmc-next-2026-03-23, thanks!

[1/1] mmc: Add support for eMMC 5.1B specification
      commit: 67fc505228558efa19380542d801807fa9eee054

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
