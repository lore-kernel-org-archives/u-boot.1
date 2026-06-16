Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF45CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 15:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D9D84869;
	Tue, 16 Jun 2026 17:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LofHw9xg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LofHw9xg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB7C84895; Tue, 16 Jun 2026 17:49:29 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E87AF8484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XceSiEjZ7EtuyNJEi1NJ+o+6ZPGhFBJrBU72d9p5ro7RLQ44O67i5jgd8SWLgRVWKeFgm91KD0WdjiwY9bufVUQlXK/RDrqMHDWZ0WTZ5YqRazCHaQRFeG+krYp1byV0STNwYga0f9aLAgR/9EdsCiLXqrZNloq6vpNnHW65/Ig3zsZ5bCMcIbMirTD+VvDlWB0R0IbC8hi1VnjAEP4X8BVWE+wgQyBMEGbCkyv8eLD3qzfnKFFmPI3/OKDTTTFowi5yJWeVosbQuxyS2uoNHsu4T8lmkI9kxHoAdMt64SusOpwnV4yN8PATkBORoSrcPYmYwBSRMgiy8MrOnZOF5A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDPQzrJwRMiLqbUGG5HmSttHzxjWYdqHpbLuGONO1VE=;
 b=gdgQ0quYab7w9dCeHM4uBe34AAkIp/wiGfEwHnmbfJLk2R9apZUnqFzfcGfjvkRQwfJa4rGkAOUWCZA5iytg+VV1hAmmG1zq2m2RYLgQPsP6SZWFVlCr0wMPQRZaGCwMnzYMDF74AC1BnVZD4pazcMr20/8uOiNmEGUd3ZcqTVoxO2dQ1gcpcI8Oj/PNlXoFAaLhDUYRqxsqNbetOBzI5sW6AO5oD38EG5fYC82XSq8gxQkRZCG7o+a38M7jHVaaZnoKVlGB+T0S1Q3pepCspc3ZBZHZcSRt23ce/LhNhXlTe7bo0k6caDY208SdGyoxGf9u7cuNRQ+M9oTxsobu/A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baylibre.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDPQzrJwRMiLqbUGG5HmSttHzxjWYdqHpbLuGONO1VE=;
 b=LofHw9xgw5zkQJFPi9ywMdVV8fh56TZ/LbSp6/mgY4AH/C6ixd5cWdeYRQo0kN0M3KJeAgy2G9s1y6a5oScNc9/1+kXFl6n86vz+X7MNlfWL+vv+1EiE1x8sKwyOWKhMvSkM2j90ydqMSrJ8bI9JQQm+/O69wNt01P+1ctfuILA=
Received: from DU2PR04CA0340.eurprd04.prod.outlook.com (2603:10a6:10:2b4::12)
 by DU4PR08MB11005.eurprd08.prod.outlook.com (2603:10a6:10:576::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:49:23 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::46) by DU2PR04CA0340.outlook.office365.com
 (2603:10a6:10:2b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 15:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Tue, 16 Jun 2026 15:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DutLfKscbTD2UlXZTQYpHMv4uUP0dTju1ZCQiaqpaBh6uBjQ4NOimIM8bApmaQj6tGWRr/JdmACVSZqkihZ8a0ltErBma6hqZ/ra+7vMmqETkXqxhSFfJwZOdVvMNVdQ9XZU8iywuKCTMVStnjmwSCNBftGof0JwVA9IzehlbkvdWOdlYZhmi15GzYxzqpmBoGuIBKe3O2gmbt5CIUy0zxR4OHSrdIfet9DFuQqL68IqbRffuJw8rNyYllcztrzWXoHWOOuMJwRIT5OVRzlkTkeDPJ+iX/GUnsIdYU1gCnGH+qlGhUw8h9UdOVEev3h3/36yKrhQoyxcMWNiP/36mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDPQzrJwRMiLqbUGG5HmSttHzxjWYdqHpbLuGONO1VE=;
 b=oOYlTWQCrvuNKWsgBiUqla+2wPWQqi6ApWQxHnK5QgzT0r/HLyD7Y324225GIHX2srsKrpCQrW3mIXQM13IbdpDDfIM6aaHJ7tzWxBOHRy9Ths58J1auxZ4kbNizLDxwVRZ9JO2ZDV/wflI7sCY8FYorZmpaVre7Ml/UTZ/Wd78Ni7EpYMXn01YIa7gqv8s9cddocmCZnArMianZWj3S1SmhnwIVlzKV8ZM9jhvqO4WBQ9Z/t8GOyZ60YczgyB73CaXuGE7GXDFs8cAvsXUFyNrLXb0SEJvEnfHspjuIVincaFeY675A1U24ha/+WyF19QEXOiCMgBi/NAUVfUZEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDPQzrJwRMiLqbUGG5HmSttHzxjWYdqHpbLuGONO1VE=;
 b=LofHw9xgw5zkQJFPi9ywMdVV8fh56TZ/LbSp6/mgY4AH/C6ixd5cWdeYRQo0kN0M3KJeAgy2G9s1y6a5oScNc9/1+kXFl6n86vz+X7MNlfWL+vv+1EiE1x8sKwyOWKhMvSkM2j90ydqMSrJ8bI9JQQm+/O69wNt01P+1ctfuILA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM8PR08MB6500.eurprd08.prod.outlook.com
 (2603:10a6:20b:361::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:48:18 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:48:18 +0000
Message-ID: <e566debc-0c28-4b95-8a01-1fad9b9802f2@arm.com>
Date: Tue, 16 Jun 2026 17:48:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net: lwip: halt ethernet after network commands
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, nd@arm.com
References: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260611-net-lwip-add-stop-function-v3-0-8849948fd9c3@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0295.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::16) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM8PR08MB6500:EE_|DB1PEPF000509E4:EE_|DU4PR08MB11005:EE_
X-MS-Office365-Filtering-Correlation-Id: 56573094-8a7c-4191-6265-08decbbed65c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original: jJnAgSbgsJ3GcTK9uNeVv706/EePEnvQIFiNwgTJH+uFXbY5/7UX77yFjwu5YPvoXWNYJfl/aZUmv3f9uYFyRR6OKrzmKtluhRNDrrnk+hBey283bHO3eTGS4ehu00QEr+Jh+Q+MRBAmU4y83BKV1orAyEAlJc3+A1NuxVF0LODuOj1DdhMqyQGiKNy9SpLenh7sh7JbfWrjV7Xit2sfol184729aKtvy4rHMufUty2VB2E4f15jVdpQ8uq02R0mQ0O3g2qvBZ0oJoVZWYn7VrXcC55Ok6UQPDpM8zB1WW882Iyp+T5sKognLfUXZhEzLfukWAqw04krgdLoffj7dZYdpJpiBJqd0hoRniMfrT8PzhyTnN7PC/6Rgd7xQCCWAw6yKfTsEk6GckkK9bpNiiJn7bztEd4VWon49Vlst0RX79bQZ/M2+TAF2MYYf5zYfXT9cLOAHdX8OM/dJ7Y5ZbOBxcwu2NU55uDXr1fQcQQ/FZpGNTw+nX7+nIF+hVmgfGy72yZoz3kpmvHapzj+bUeR0HWmpWknf93sjpWmuiTWhfPvG0TaTtZJDpFbztRksFh/XdW8WaIWFhglsT1cLrLVQpFuVev4vWFdkZo2Y2hQfH8h6hpOWGCOWe/BbNI5tubphH4pkaqcvOyhM09lPQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ovagIbws5l2oa6tAzUeZLwxvJwQgfYgqXJ87h+wHg2Snhfozc6Y8bwbH9NwSPaVbzCuFbP9lBZDuq/n9N++XsdyMo4t5+wZQZmt6Yzj3AGi+eqt1Fx6t2MrzftKwmqG1EDWyCKOJOduTWGYtSoE9vsmhRC7ra3iwOgwO6THEXOE6Z5gNMR8faH8lqt0BzUDhLunOMZLrPvfQVZgqWSK0EPO9vb+0sAMLUEpH12trqjX3FiFqWHHpoBm6c5Ea8MhNEy4gYKNr99Riwgobs3IA45Vznogi3ri9athxvFRav27Zro2WTy1lLMzan/4zY5/QTW1Eku0aCKMMbdK2j3HSig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6500
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8df63656-f793-4573-f520-08decbbeafcf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|36860700016|376014|14060799003|82310400026|1800799024|56012099006|6133799003|11063799006|3023799007|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Nz+48t0ug1sl2sFVd2dU38fFvuzSZH/nJHfgsgFvVtpGmR1CU+DTfn4rlJnrA3bYaExStp+dZ7x752/2GmUL/TMfOLQrbXsf02TfAyTUUCgwBZJ3Yh+Xfb9txwD4gVeAuxDO4XovoZqPa+KRnsRAt7MOndSgoNbWCLX1CE5h1NpAQUXfpF1dcB0dwRbT0bLeAgjAa7LzofmyEbxEWHBWigmmwvQQAH627IZqL6DqYAKM4vvHxIjlLUNxgWoeG60Vq7keVDZCVO4aqnDZGMX5V+DcQCJwrpzhUT+Yr+UDnImbKMJuIPgt3tCY8NfgeYorT+UQLH2WzFGbisbqrwRWPyQQcmkWElp93KNiA9A+wiqMLLjB8DxHo/fTXg07qWuaXCDpGdKWOfDLG+5IfEFtNKeJyXuvv60Ug9uyiaZG/qgFsxPYeGIbQibjr0VyIdSeq7hasld5PnCSQA/xFX4Dac0tZkDs92R7Bg13nXurEo7iTD/rVDMVbLrtX1bEZh54vyMyvoR0OjSHN4OySgmgm6ydKlHjzfJgT1TR03ulV3XqT4Qi1ojbABry1LXPzUBXuWC73MLxWV46uLXSgAXKE6lvqUAjEoUvPk7VDvQO/hnnqrgtbqMfZpCI08H39WCBYFeE4LVP9KLauWb1XTleyqUf3OadJfQTVu/8lBvsfBUKZJNIfYEeEZRkCihq6WHT
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(36860700016)(376014)(14060799003)(82310400026)(1800799024)(56012099006)(6133799003)(11063799006)(3023799007)(13003099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q7HrNxc3/HK6Tv0xsQsG1qtJv7Yxe6NrN5I9YT/ChGy1KVxcYA6DeFlokJWHcou/Lfcus4bo7song1F2hi9KpYuwPvWWWgfMmA+7NDRcP63pEZM5kZB5kut52sC5O5vbAdCKHA5DpNbawOBsHOmMVzJJrCU55VtmLO/v6Ef22f6+/sN9igk3KNMNYDfvstmvnPQtDt19v0MudLJzsHEH3JteDvem7XLf0PzjY/r1CuByCKRlWBfntFpQzDOklEYs+13tQgjTHbawhg1NwPO9NVBlM1CELIiFyLWE7pWdfgeyW3dsRbuM4WjbLFjOvP2spT6Y7DslatR7CD5ppZtrlSdrTwwHoPJAwBZhW2zyjoXel1bhvjs407Qzy7nChtrrKv4hZBgwDYaMykoODmxm5MMP2sI8cnZpk3KZ/mHrLgMq1JAroHbTO/34wMchX8Rg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:49:23.2769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56573094-8a7c-4191-6265-08decbbed65c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11005
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

On 12/06/2026 01:36, David Lechner wrote:
> Background:
> 
> While testing [1], I found that it would take down my local network if
> I left the command prompt open for more than 30 seconds after running
> any network command. The network activity light on the board running
> U-Boot would go crazy and other network adapters on the network would
> start getting watchdog timeouts. So apparently, it is doing something
> quite low-level and I don't have any hardware to sniff that (Wireshark
> on another computer was no help since all network adapters on the
> network stopped working.) So I took a logical approach of looking at
> the code to see if I could find anything that would cause this. This
> seemed to only happen after I switched from the legacy network
> implementation to the lwIP implementation, so I looked for differences
> between the two implementations.
> 
> After some investigation, I found that the lwIP implementation was
> different from the legacy implementation in that it does not call
> eth_halt() after a network command. Since the problem happened only
> when at the command prompt with no command running, this seemed like a
> likely culprit. And indeed, it does seem to fix the issue for me.
> 
> For reference, the legacy implementation does something like this
> as documented in doc/develop/driver-model/ethernet.rst:
> 
> 	(some net operation (ping / tftp / whatever...))
> 	eth_init()
> 		ops->start()
> 	eth_send()
> 		ops->send()
> 	eth_rx()
> 		ops->recv()
> 		(process packet)
> 		if (ops->free_pkt)
> 			ops->free_pkt()
> 	eth_halt()
> 		ops->stop()
> 
> After this patch, the lwIP implementation will do the same thing for
> all ethernet commands.
> 
> [1]: https://lore.kernel.org/u-boot/20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com/
> 
> During review of v1, we noticed some existing bugs in wget_handle_request()
> so two new patches were added to fix those first before attempting the
> primary objective.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v3:
> - Fix a few minor issues in first commit message.
> - Use reference counting in the final patch.
> - Rework do_ping() implementation to work with reference counting.
> - Link to v2: https://patch.msgid.link/20260512-net-lwip-add-stop-function-v2-0-85146da317dd@baylibre.com
> 
> Changes in v2:
> - Added two new patches to address existing bugs in the code.
> - Don't remove eth_halt() before eth_init().
> - Link to v1: https://patch.msgid.link/20260509-net-lwip-add-stop-function-v1-1-62d854bfa66a@baylibre.com
> 
> To: Jerome Forissier <jerome.forissier@arm.com>
> To: Tom Rini <trini@konsulko.com>
> To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: u-boot@lists.denx.de
> 
> ---
> David Lechner (3):
>       net: lwip: wget: fix error handling in wget_do_request()
>       net: lwip: wget: return errno codes from wget_do_request()
>       net: lwip: introduce net_lwip_eth_stop() function
> 
>  cmd/lwip/ping.c     |  19 ++++++----
>  cmd/lwip/sntp.c     |  10 ++++-
>  include/net-lwip.h  |   1 +
>  net/lwip/dhcp.c     |  15 ++++++--
>  net/lwip/dns.c      |   7 +++-
>  net/lwip/net-lwip.c |  16 ++++++++
>  net/lwip/nfs.c      |   4 ++
>  net/lwip/tftp.c     |   4 ++
>  net/lwip/wget.c     | 107 ++++++++++++++++++++++++++++++----------------------
>  9 files changed, 122 insertions(+), 61 deletions(-)
> ---
> base-commit: 3cdce049f90d77c3f9221f1eb73922384c8972c3
> change-id: 20260509-net-lwip-add-stop-function-7f7794074844
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>


Series applied to my net queue for master, thanks!

-- 
Jerome


