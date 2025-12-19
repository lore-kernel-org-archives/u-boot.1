Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6893D7879F
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 16:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E6580077;
	Fri, 19 Dec 2025 17:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="EGjZ0ND2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9CD803F5; Fri, 19 Dec 2025 17:27:12 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4DC80050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 17:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNq0OOdXRKg0nTt6Y/e9/8aiOl7Z+fNoyd2DJs//480zeEbgp0CCQSY6TOAnNzkCm0VLTOKQ9PeGQ5r37ttlRcUacIXKZNF3ONGEdZrhlUpI42KmWM35bVXzICBJLlMMYD+hGWPy8GytvlhnJx7zx3TtsBcI7XRc3I4FOMbH7MtavSc852z4/4UDatRQxURCePCKT6b3ZvfWlZdzOVezbrJl4zWzfSXPJbhm2gIaaCV0esR1EFMspnlyoQ0wNLv+lfnFLcLu7R9SYy26JG0otDDklxbxPhkJVBS9hCtCEHJApdjtkF5V6gQ2WSck8f/10Z4cGZS+7YoBibbZxbmZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCJ5c3v8NNpL3ObBfQPIQd15g7UN6UKNtqgqLwmJCow=;
 b=nj947bjwQH25SIn9SGuvU5XVhL1166lOUndpkNVShRHs7KQEnBhr+csVXV3hmmkxHaARWcuiQTm/eDYnGVj2Ycj98pgdtFmpDtaUWM8DiMe45U8lVrmkNadxdWu1gPXbDEaiMKWyeiAen2JAB22ZF73/mZRJ5MhvsIIcAsyZxVfrZMlSyOBT5+YIza0FQEGYbnC2RZrk0wr3JCEXThzVENnT+Ra0ai7ZoN5XgoroiGDJrYowmDgzlxokvtaXSsJW4w66o6esye2fUM+ajHM40fobspCIeYFbYrjCe4OVh+i2uwEHsj2S9EstO59mkYokYfXvfoZbhtkwQGNafSQJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCJ5c3v8NNpL3ObBfQPIQd15g7UN6UKNtqgqLwmJCow=;
 b=EGjZ0ND28e/b4j14NGQqcLvLJ2zViSpgDkruDkHlQaqweMY7n+b4fF97Q2tAMr0lCsGUvhPelf9nxI9tB2QkWJk0cQ4Pz0qrt1+9lg25qJ6PqzSGjMIqndWFKJtpvdn00RS9DNKKffVSfA4rysZ2O9PfW7nM7B/co4/yrit0AXOlUQMHPq2h3lDz1H9puwDDUiuOo1RdvRotTdaLCWIJIS4IAN8z54sPLFv5oLwT4+Xn4BlaJcnX2ZSO4OZG8CwqPMjaMWVjgaxGmypxgP88qVv705pF1apaTQ43D5X+ciQF2HS653Tclr6aacCMT/ZKx5q1RzftBg4mnmmQffbeaA==
Received: from AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::14)
 by DB9PR10MB7242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:454::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 16:27:08 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::6b) by AM0PR10CA0034.outlook.office365.com
 (2603:10a6:20b:150::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Fri,
 19 Dec 2025 16:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 16:27:07 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 17:27:56 +0100
Received: from [10.252.21.85] (10.252.21.85) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Dec
 2025 17:27:05 +0100
Message-ID: <ab081cda-c539-4b1f-8758-c0ab76916bed@foss.st.com>
Date: Fri, 19 Dec 2025 17:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Restore boot for STM32MP13/STM32MP2 board family
To: Marek Vasut <marek.vasut@mailbox.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: Lukasz Majewski <lukma@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>
References: <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com>
 <1cbe447d-dac1-4dcb-9a96-51c4ee0bcf3e@foss.st.com>
 <7f8eb7fd-c503-41ce-9beb-9b247e91671b@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <7f8eb7fd-c503-41ce-9beb-9b247e91671b@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.21.85]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|DB9PR10MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3a0bb3-ee4a-4788-f05d-08de3f1b7409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3lNem5hT1Uva202b1dDbHVyYzNxY1Flak5RL1JUUFNxWWtHV05PNUgrNWVn?=
 =?utf-8?B?WGI4Y2RJam5qYUpzUzRZcmVqVEFRWG44OHBRQ0FTVTA3cStPZFhHZ1kydFpv?=
 =?utf-8?B?dVQrTzJubENPM3EzNXRES3N3Q2tpWGJDbGQweE1jNmo4TGdVazZNWEJrbjVj?=
 =?utf-8?B?ZnBWYjUvZTQ0TUZpcml4QnhlMHEvSkFUU0NELzNveFNtN04xQ1doa3pXa2Nu?=
 =?utf-8?B?YXpKQTNSMEZjc2J4dzd5d1RvQVRqSWx1WE9yWldHcFRNZ1BkVHlHekZuTUpr?=
 =?utf-8?B?YkdKZ3MxaGEyMTd3NFVIaHgwZEVxU2tNTnoyajNJR1F3RWhjeXhQSU9NR2po?=
 =?utf-8?B?RHNDbm5kbGlzY2lKNG0yZ0ltRVJXSEZCR05FQVRzemVDNkRWcC92dGNPNjkz?=
 =?utf-8?B?NE12RHh1TFptQUw1SVhZMTRxcWZveEwrb1VxWkUvakFwQWQxa0V3ZUF5ZjVE?=
 =?utf-8?B?Uk4xaTMyWjM2UnZUemxGR0JIZ2JQeHg3UDc2dnk4cmVGcGpMc1NVY29RYWJs?=
 =?utf-8?B?b3huZnAwUllrclY2Q2Nxc1N0a2tBV254bGoxaHRzUklFOGhhbFh1R0NNOEtZ?=
 =?utf-8?B?NFRKRXJNZ1BQNmRRR1U2R1FzYnMybVZWd29ycFVZWi94S2xJOTlGK3BYRmNV?=
 =?utf-8?B?R2hhak1tTVA3YWJJTzhKb3N6ekNON3RCN21mVktLd0ZabVh4c0tUbjRmeTZY?=
 =?utf-8?B?UFJUbGRiYzQ0OVRsa3BQcVRTYjZVanJtQkJ3TnpNWFU3ZjMzNUxadTFCOFlN?=
 =?utf-8?B?RFJ3NFAwaXU1RFN6K3kwL0FRbzR3ekhzL0hHWExNTW1IOHlWS04wRU9PdHdr?=
 =?utf-8?B?RXJRMzV6RytMcWozMHVjS0RUUW44Q3NKb085dUxYMTNSSlE2QWM1c2luck5h?=
 =?utf-8?B?V2l6bHY5anpHOG9pRWRBallmQm0wSzF4ZjlDbllVb1FEOVBvL1VlN2toa3JU?=
 =?utf-8?B?eFhoTTA4RllWZFMzRVFKKy85NkxUSkw2UkdwMGFSNHgyV29HMTZOSDNIaDFn?=
 =?utf-8?B?ODBLUzVUMTVjNXRqdTB6R1JXWlRLNWRUTGxwZmJJTkJFbEgvTFp6SENwaXVW?=
 =?utf-8?B?ZUd5b0dQeHB5WDU4cWJENmkwZjlpNjJFeXIzdkRWUVVGWitmanJyUGpNaTUx?=
 =?utf-8?B?RE0yL0NDeDZJSC9mR1lWY1Z3a0YvSUowQ0NmMFU1TFZxbFhSSkwxSk4ya2Rs?=
 =?utf-8?B?RVdrVm96NlpYYTB0ZFFCblBXWm1XenBaR1p6ZjFQeVo0Z0xabWVlVnptMWZo?=
 =?utf-8?B?WUltSlJmN0JtblRyTlRIQklrRWU1UVF6R0VxYTh0SCtSYzI3dzZuSHplRTQy?=
 =?utf-8?B?c1VaNXdxeUJ0TjI0cnduKzBEOHZWdnlzYU52VkJRMGxhZEZmbWpwTHJkUUtW?=
 =?utf-8?B?OW1KUHNCYllJL2xGMFFCNk9ZRlZCMktnSjBjaktVakt1R29mcWYxOFVxR0x6?=
 =?utf-8?B?OXFRNENPenYzTjNSQ1BYUnhiK09yUEJtWWV4dTgxdXM1cXl0aHJyb2J0Q3pP?=
 =?utf-8?B?VUlLdktCZXNsOEJoZHpKK2ZOQlh0c1hIcjBIMzVCQVNweTZMTHZTQ2dpZENh?=
 =?utf-8?B?eHNZaWQzQXZTZExieFVBaDZ0dkYrYWhUc09sM3RsclI1Rmgxc3MwdnJTWHFa?=
 =?utf-8?B?RG85Um9kQ0ZFVytaZUxQVUhWZ0p3Q0ppVHFibjljWkNNOEllVjhXNU51NHRM?=
 =?utf-8?B?aEQyZ0tMZnQ4VmpZUW5UaXZWKzF4Mjc5bDFUYTdPak9tTVRRU3M4TUllMHBI?=
 =?utf-8?B?a2krck9RZ2tKTFp5UmNudVlOSFg0UjEwVkRMWm8wWVhtNExJSHlFblQxRGJP?=
 =?utf-8?B?SDJHWUJIZG8rNnYxeU9NdVdYdWVHcVVJZkRTc0VyWmNvL2hRVU5yK2lEdXlT?=
 =?utf-8?B?NzIxMGcxa2lnK1NxRWppNDVDU1ZiYzIybzJqb2V6Tmt2TERXSzArNGxmeDhW?=
 =?utf-8?B?SXJTWlViTi9TbmJhMmtzaU1SRHZISGpObWJEQUwrazQxSEd3SEQwT1J1Y1c3?=
 =?utf-8?B?dlZRS3IvTXoyOWdEeDh3dVRaQ2tUMjRFMkNza3BEVnJxL21JUFh1ZG1xQXVU?=
 =?utf-8?B?czhzTUlkZHZ2NkplR2xlSHpnMTJGQWY0QVArTU9vbXpadlFMcm5qMzNaNFEx?=
 =?utf-8?Q?TKvM=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F4PHYbzxxqutBp4obbbrOQvHujpmFRXhjdiXNY0zzBwNhnf4BQvq2/zUiDj2UFmhID5imHr3s0+vYuq4lDZ04HfUTtOo4iS4sClefEdJkRZ2zSK2G154doyklRXTjsgyHJx8dE70ONEredwXfVqBMVQgRNG6+psirRMZB2PQoFwAtbCIayUhjwZByViS1qJ+M4HtSBDKI1qDT0cLlys1GYMir/EHZKlcA1X6513TDh5G2j3BhoQ2p11S0dxnbWn9aFB2IlDe2blVywJVaWAb1uTb3klt7Pinre1r2jVbXr9tYAY0BAjAUaIdD4ipBS3L4d7PO7La1ZWoratcjr6tMEHjWDV1boRqvrnVxICeY+ty8mneYZUyIgxBrUU41Kp0AMirnpQ1pc6YiSWr7P5+qIdgcqejJ+AQQkCgOn2xXq0AwYxFAEB5s2+mao5pKP+q0aKPM0QUUorh0J03hZEle+l+lBBsvfP+ASJfZY4xQhV6/Zctzn4XdqALQblnTqRE/6igfxVKAA+hGZYafnxx3oxnTJJ/L8piecF5bUCAkiHs+SX1cpDmu7VqDbK0LN4IO9+loNcrZX54Mq8T9eXZ5rhRwqcAUYyxo+8XvLG4hHnRQviespYFyGmoovGLn4O5Q1dH+m5Paozrqr8XnqI2L5ppvQ9aur6Q5d+SspJddlNV+apFMYFQGGOf5MyYVB0SUhldVBlmJ4jCrebIPpm1zw==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 16:27:07.5769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3a0bb3-ee4a-4788-f05d-08de3f1b7409
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7242
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



On 12/19/25 17:03, Marek Vasut wrote:
> On 12/19/25 2:42 PM, Patrice CHOTARD wrote:
>> Hi Marek
> 
> Hello Patrice,
> 
>> Can you give this patchset a try on STM32MP13 DHCOR board in SPL ?
> I have it on my list of things to do.

Great.
I will be on vacation during the next 2 weeks, but i will keep a eye on the U-Boot mailing list
in order to make this patchset be part of master to restore boot on STM32MP boards for v2026.01.

Thanks
Patrice
