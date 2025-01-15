Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592BFC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F19B80785;
	Wed, 15 Jan 2025 14:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tz98m+FB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2512480703; Wed, 15 Jan 2025 14:30:03 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9822A8075F
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrvsLKUK0Frly3cH7uV9RGGlpNawttn9wKCaslxNzta9yBqSslsSubhbu/7FxY4htmtlmlO7y85UuUQfuI8ZYu11nagt3DUQsgbI/bMkXuNFoqTJ/DedyckR/0PoNeRckouFoy93yp6kS/alaYvHkqwxQv0FUUH/jmCKJWbm/t5QkErdCgI1YcHmlWRAPTxCfd/0TIe8yBYBOJeev6JN1e6CAA97uQaOYE+iDeeIGF18XZ4/V4Wvl413UE18SdPYqHJr4Axs/74LiLY3cn2rKs5jtBVRydOBbhlTkHlwn5gDa1VIZZXS3m63teF4yKdRtSWJo3xxIjHfZjTb76DT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hLFCYKqPH7dKhBT6padU/fhbbZ/mWZ4U4t1q4e67yI=;
 b=O4P7WFiZi7V8vj0cVHBqpPJUpPX5m3wTmQ7n+i0cHAfIsnT4E6cc4Y4mYt0LUFIeQKVH5Me04d5d12ZwjA0NJvpWQDO4IHoB2j1E45C5fWue4KAzjPoN1Bz5KGZi6SBF/0paW5NjBjOpqHpB6M8GzI6QSXKiOFgJ++JQf28ZaqiX4n+x2JN70SpKy1WWqPziQum2CG3nICvTe0BCgJRzNzPz1xUz7LmjY22hZwzXD5e3aTVVllrhZ3PpkTrrr2ko4oGQ7y6HwvKeCJdxUuUrfEDZwu8BaW/Y6mKYhOxSQySZNrKuTN5ttBySfHm+XvW/qo8cUvhmWUou083+oFWBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hLFCYKqPH7dKhBT6padU/fhbbZ/mWZ4U4t1q4e67yI=;
 b=Tz98m+FBenzVLfhLWoJLmPS/d9cF5Goz/RLXjmt0CzdKe+jEgVLQokQlX75GtvbyekjL+GiW0gL+s6ehiiHBVzTBONpgxE9W4n6jRYkWNB4PAktipdHe7gdZjEncymgJBrAjCoKeBVGs4af48QV2s2Siuud8Li17PxcMrTVpTP5blhVSwEhZUeeEdsHp+0LzL+AlwQBRgSVAsc8LxpfH+f+l4zsPRyHmqA1r0KzfCqVv5u7o6xqvwZiZESbydW+ayCfqclEkeula0opNBsF35s0uTq+a8CQc2StPJhtexYsm7ghiN7E3sqiZpyM2Si4vTRgx7MGmCk9H2RmrzHYw6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:57 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:59 +0800
Subject: [PATCH v4 12/20] imx9: scmi: add i.MX95 SoC and clock related code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-12-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=32307;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=umHSMcnCkJGgXnRea4lwk2/sIe/jU+UewbMkQA9ZMoQ=;
 b=go6qFhbcBxftN5pYXo7wsKnTnGpguBS1VG2102li+ZvwVyKvPwQuD/2y0OyFCpwue4bnL+MfP
 236l1Wiu+OyBsHvmpXTXqOxjf7iJsZ4SwDmXZ/ZRcUk/f19llrMxdwC
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 210f4d59-710e-4c09-7c79-08dd3568b447
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGk1cVQ0ZlB0YUVaZ0RPUWtxRjZDVEVLWElPU0hOMDNKZ2lFTXlwT1BBaWpz?=
 =?utf-8?B?WnphRWJTTWlORFM3U3VmdEJML0VKU0VFdDZ6K2s1akZDTndLaTh0N21SZkFD?=
 =?utf-8?B?YUp2OXQ0M01uM2FtekZhQmZJZlVsK2RSTUZMc2FtUG5QQ09jK01mMndJcldQ?=
 =?utf-8?B?T3JiSVErZStIdlhBTXIwK2k3V25zNjlJQ2YyenExWmNkMmp3c1F5QzIrTGRv?=
 =?utf-8?B?UDJhMGxZenRqaDBEU1Y4TjlWUWt4TitsZVRDckFkZ0lDOGIrTkNJcjI3WWVx?=
 =?utf-8?B?Q1NUV2JKT2RZSDM0bWpKay9tbTdxSStXUXJvZThNSHpRemM2c3IwSTlUZ1VU?=
 =?utf-8?B?NGNrZzRSZGVNUHA5ZFdVTUk2blRxQkVIYy9PbFBJbkg1bVZudklkeFpvSFkr?=
 =?utf-8?B?SGc4S0g4cm1pcitMeEFwNDlaSUpla0FSMEtyT3ZtV1daRE5uVGY4QUdIcGFh?=
 =?utf-8?B?SFpUYWM5bXNnOWQvMWRLUEh0T0pCbWI2a215VnliUEE2L2tBRFYyZlBtbTdp?=
 =?utf-8?B?cWJUdkhaWkxZZjcvZGNmM1JvUG9seldOSXFSWnk5RW4xMGwvallNbXgybjJ5?=
 =?utf-8?B?bFpvM1F4b3E0Yks5K28vSmprQklVUTNvby94Y2Mrb1RUSGVJbXJFT2tzWGov?=
 =?utf-8?B?RjNMVm14MWlBWk1HeUpBVm1MY2xVRkJXV2gyWHd2TThhR21uRzJwNzI4QzJn?=
 =?utf-8?B?UGp4ZGFOTmlSNWVvZ3FnTTZGUy9RTVJIdmJ3RlNrTVdiYmV2RUZHazhNWWhp?=
 =?utf-8?B?ZU1hNDVmYTBEcHhjRE51RXV5ZDMyWGVTWEtDYVVzNlplNzZUdXhDZTRuVW9p?=
 =?utf-8?B?M1N2NjU1THplcGVwWnUwVlRWdTU4Mnc0Zmo0REFrQ2w0SlFxcU5mTW1iV1k0?=
 =?utf-8?B?VTJDMElxWHlaNWQ0QlJqbG9YaWVhMHNXWHJOd1BrV0UyN3ZqRERCSHRKaTZt?=
 =?utf-8?B?anl5MWRzWU1TbnhiVXNMRHBEcFRwM3dlOTZJb3h3Y3BPUk1ISUpYTEErS0pt?=
 =?utf-8?B?K2NCU1FrcVN1cGlBWWpEQ1hwMmE0Vk9jQ3RHU3g1ZEN6cVVPelFNa3pkWkxQ?=
 =?utf-8?B?dkZqZnpOeFo5VkNQM3ZRR1lyVUxJMldsOHhIUnRuUXJBRE1GT0NBWTNQeGpn?=
 =?utf-8?B?eUZnRTZQQUpnUklRSDlzcGVadFRHYjZuY2w1cGdyOVRBTVNDOFVVZlQ0Qzg4?=
 =?utf-8?B?TW9VYkVYNGZnL0pGa3pJSlRiamJDMkRYUk9KUmZwNzJ5eXdiMDVDVGR4RnRM?=
 =?utf-8?B?ajJVdmtuSzRrc096dFlHR3lEUG0rNDQ1VWRTZmZxZnpRSnF3ckpUeFdzL3Ft?=
 =?utf-8?B?aWNacGZyUzVma2VhajlabUZCV09qQXQycmRTUzlLNWJaODJaSzlFWHVSTG5l?=
 =?utf-8?B?b0xhU2djZmcrVjY5YVdQZzBZN0NqUzF3RmRYaWVoZHhZUStSN1ZFN2Z5U1Ja?=
 =?utf-8?B?KzluMUxHS1dacjZRNk1uRVRIejY1ZEplVXJnU1Y0MkdGREpyY0tTMzRMYUFx?=
 =?utf-8?B?REV0elZITkp2Yjl0R09xZyszY3VIeTk0QlozNHJTMU8rdy9ZZ1BzT25sRVhn?=
 =?utf-8?B?UHNXQXlNMnJJT2V4aGZhUVZQNkd1TWk0ZEU2WEw5MDR5b3V5N3NHaXU0RWU1?=
 =?utf-8?B?d2JtYjhNOVdnY1F1ZTdyeG5uREs2TUZMZUJNdlNJYWtJUzgrQ0YrS2xuMFRj?=
 =?utf-8?B?UzZPVlBpN2IzUkJtdi9JYWNZb1dnSlp0aUtlK1Z6UEZRVlUwWlVZZFdVdWpk?=
 =?utf-8?B?elNyYU5vVzFmMEdCV0U4aG8vTXNEVXJGWVRnVlNRY0t3YzhHbDZEVmxpbWUr?=
 =?utf-8?B?aEdvREZBSmhEZmE4ZlA1RW12NlJRS0hJamUzcjRLVllHZzNVVm1tbU5IYjQ3?=
 =?utf-8?B?TVlhd1pGTFBlVXZ5aEtHUi91cTBBQWNmZDl0Ry94YnJoOE0rUWRsQnIxeXhp?=
 =?utf-8?Q?+lJq4OMGcug9l+Ry9CWgiw1QoYwnbAcJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRHaFJ2OEYySjAyVmVSOFMvMGlQRGNhcERiaFhnQ0JJMWk4YUhqb1hUR3hO?=
 =?utf-8?B?YlVHZnUvRTcxNjZjWE94NE1ZM0hWbld6TVBUZzFBZW4xMmZNNGxNTGJsRHZy?=
 =?utf-8?B?clFXc01mcVgxNmJxM05RNHJFZjJjMjRXVHFCWmlnbGFnaUowSGxxMHpFYUtV?=
 =?utf-8?B?V0FtVzVrdXJuWkFhRTlqS2xQanJRMXN1VlU1NTJCUTIwSzEyYlJmVit5ejN6?=
 =?utf-8?B?dXRQdCtjWUZjdzArZTdjM24rZFhuN1RQbkRqL0VrK0RHNElTOWJNOGNYcXB0?=
 =?utf-8?B?Vlk5ZzVhVy9xZ09Ub2hhN2IrcWc3TWpMTERzcmo1UllkcXBuOE9KMG1jb1Vt?=
 =?utf-8?B?bUF4Skg5aW9mMnRGRTQ4UEl3a081MlU3dXdQMXJ0MVdmc2ZQcytscy83aE1E?=
 =?utf-8?B?WmlEUlg5QnVoSnhHaGFjSURLMDg5SHdQcWhqMFNSdlJRVllqdXR4dHk2WVlV?=
 =?utf-8?B?alZuNU1jdUVEcVh4bjVBVVJOK1MrNG52Y0hFVG5jUXRTbHB1VGhrU28rZWhJ?=
 =?utf-8?B?WTNrMnZENk45alpwYVZHUCtBKy9MTHcrVFZwUDR1MFFFcFlwd2cxMkJRb2JD?=
 =?utf-8?B?RFkzbzdZcjJUdCtDK0N4ZEExQnNBN25UdG1ialVHNHowK2pLd3M0WVQzSGk4?=
 =?utf-8?B?K0Mzdi81VVZ1QjlUdUtaL0ltNDgwbThGeWlFTktYSU9vZG90b2pRcDI4WjVT?=
 =?utf-8?B?Qlh4VHBrRElRc3RLZTZ0RC9GY3JrNDJ4bktaV0puUUVneWZudVVDcE4xYmwx?=
 =?utf-8?B?dndRZ09NOE1MTkwxSWh3dnFudnBuYkZwNGNtTXkrTk52aERrbHdjRVZFc3Jk?=
 =?utf-8?B?SGp5TGw4QWFXbXZyWlRkZWJZaEpnbHlLQ0VIYjNzVk9kZUxRck0wVTllOG9r?=
 =?utf-8?B?WGliVE9RaHI2dm5Qb1ZxWkJ5RVl3VHVjYkR0aEhFNE0rRXhXaHVXV0F6MWx1?=
 =?utf-8?B?V0hmcFdRcFBEcW9iT0xaVTlzb0Z1OVRnR0FtMDRLZGsxUnM4SEFpbm9TY0FJ?=
 =?utf-8?B?Wkh3TGppQjVDU3JmenBNQXIvMGhmSnBTMnp4Nk1BOFBNY3V0TThiY010WXVz?=
 =?utf-8?B?SHgvRi9uSTJ3cEVZMU1oektrL3cvZXRibk95L0lEMEVoRlpMUUFibTNnK0xu?=
 =?utf-8?B?MWNoY1lNQU5tK25yTVFMVGxIUWNvS253TUhjMFpDU2xBSUhsT3ZzaTZSZHZB?=
 =?utf-8?B?Y3U3UjZGM29VdHNvMzNMTkJweklVRHdxQkh4QVhZMXNDV2cyTDE5L1RYSG1L?=
 =?utf-8?B?dDExT1d0RVh4V3BWaTZ1dXBJQUVxY2M1bHR0eFAxdGo3VUd3TmRpUG8yOWwy?=
 =?utf-8?B?WktTWEJBZ2lSTi84K1A3NENoUHZTZE5McytlbE5QaUNwTHEvRlVPdEhEUkVK?=
 =?utf-8?B?Tlo4NnF2YUNCaWxTQ3prTUN4REk5Tklsd250Y1JYVVVPNGNnODN1SWZzQ2hp?=
 =?utf-8?B?QXBsV2hrdzNEUTNreWN4eW5VMTBiTkVBOUZ6alhTejh1VHhMUjVKY2xXMEVF?=
 =?utf-8?B?b3c2U3BPdUtpbGE2STFXL1lSYnU1ckg3ejBUR0xLMW04blpXMU83c3BGT25F?=
 =?utf-8?B?RlUwMHowaUdpUkJicmI0cStKdkxCMGNuRWZHWnNseFdtNlpXTHVpL2gra2RR?=
 =?utf-8?B?eTc2YXNmSWtPRkxyeTBZUFNna01FRUdETlBXY2ZQT0kvV09MMmdpR3d2K2lU?=
 =?utf-8?B?dk5WdUtsVms5dXA5TE9YV00wcGdOVDRpK0w3ckFWcEk1N0dxbDhaOUZSRVhN?=
 =?utf-8?B?VVQxMWpMRzJGUTYrdUMxSU5UampOa2IrODNkMTgvdG1rYnpuWHVIVnlqUE5I?=
 =?utf-8?B?R2lNTC9vSlYzbVlVLzA5eXpXSVYyS25jbFJDdVJnRXVIcVA0MS9HUDdTeFpC?=
 =?utf-8?B?Njg4REQvN3NPNWp6cHFsWDgvTUhKMGhNdENRVWk4d2J1VTNYK1lFNEdURkxU?=
 =?utf-8?B?MXM1dmhBYlF4WFdqbzFYaGhhWERZT01RUWR5ZUtpR3AxV0QxWTFaejZydGZj?=
 =?utf-8?B?ZDdWYVVITm9DM0I1UDRrOUV2LzBtTjlnM0xtakkzRnA1VTdGN29vdjFNcW1v?=
 =?utf-8?B?Q2NKeUxxNjJuY294UVhRNHR3enBKYXNqSkJNVy9LN2sxNnR1eFVRL3FZc1B1?=
 =?utf-8?Q?a9c9FdS4HoLqxuI4ckbLBN3cr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210f4d59-710e-4c09-7c79-08dd3568b447
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:57.6505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWFmKtyjTOF8PLSqKmznp1zS1+4PH+0HdoQDFdzxX/lUjix9htoLRfIP60bdSZECxxq586TmNfHfIgHCUOjmgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

This patch adds i.MX95 SoC and clock related code. Because they are
based on SCMI, put them in the scmi subfolder.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h        |   2 +
 arch/arm/include/asm/arch-imx9/clock.h     |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |   5 +
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h  |  39 ++
 arch/arm/mach-imx/imx9/scmi/Makefile       |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c        | 105 ++++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c   | 135 +++++
 arch/arm/mach-imx/imx9/scmi/soc.c          | 809 +++++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h       |   2 +-
 10 files changed, 1113 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 0d7a573461690046b27498c7174459110a73689c..1f669c72d00833f07ca7a2563ae24536af9dc418 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -76,6 +76,8 @@
 #define MXC_CPU_IMX9111		0xCD /* dummy ID */
 #define MXC_CPU_IMX9101		0xCE /* dummy ID */
 
+#define MXC_CPU_IMX95		0x1C1 /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 60d48b13b11f274c9e4c8caf20954de0431d9d6a..ffaf6b5f7d81d73af1702dff64cf9b15ea521ad9 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -255,5 +255,15 @@ int ccm_shared_gpr_tz_access(u32 gpr, bool non_secure, bool user_mode, bool lock
 void enable_usboh3_clk(unsigned char enable);
 int set_clk_enet(enum enet_freq type);
 int set_clk_eqos(enum enet_freq type);
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable);
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate);
+ulong imx_clk_scmi_get_rate(u32 clock_id);
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id);
 void set_arm_clk(ulong freq);
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable);
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate);
+ulong imx_clk_scmi_get_rate(u32 clock_id);
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id);
 #endif
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index ef9538bd42e8b2972d7e6829a402bc4f661e3cbb..f7f9c706e13e63df7ff0a90b3964e04bc15959bf 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -20,6 +20,11 @@
 #define WDG4_BASE_ADDR      0x424a0000UL
 #define WDG5_BASE_ADDR      0x424b0000UL
 
+#define GPIO2_BASE_ADDR	    0x43810000UL
+#define GPIO3_BASE_ADDR	    0x43820000UL
+#define GPIO4_BASE_ADDR	    0x43840000UL
+#define GPIO5_BASE_ADDR	    0x43850000UL
+
 #define FSB_BASE_ADDR       0x47510000UL
 
 #define ANATOP_BASE_ADDR    0x44480000UL
diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index e4bf6a63424f7c54c1dcdf6b882a908940e5fdb1..df2148a53c7e43fcacad0798090df23e24347dbe 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -12,6 +12,7 @@ enum imx9_soc_voltage_mode {
 	VOLT_LOW_DRIVE = 0,
 	VOLT_NOMINAL_DRIVE,
 	VOLT_OVER_DRIVE,
+	VOLT_SUPER_OVER_DRIVE,
 };
 
 void soc_power_init(void);
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 109a806852ab42d018ce45a4e96af5b57adb6a9c..0780f99b49a7768d77ed688157e3287195c857b1 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -97,6 +97,8 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
+
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
 #define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))
 #define is_imx9101() (is_cpu_type(MXC_CPU_IMX9101))
@@ -216,6 +218,43 @@ ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev);
 u32 rom_api_download_image(u8 *dest, u32 offset, u32 size);
 u32 rom_api_query_boot_infor(u32 info_type, u32 *info);
 
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+typedef struct rom_passover {
+	u16 tag;                   // Tag
+	u8  len;                   // Fixed value of 0x80
+	u8  ver;                   // Version
+	u32 boot_mode;             // Boot mode
+	u32 card_addr_mode;        // SD card address mode
+	u32 bad_blks_of_img_set0;  // NAND bad block count skipped 1
+	u32 ap_mu_id;              // AP MU ID
+	u32 bad_blks_of_img_set1;  // NAND bad block count skipped 1
+	u8  boot_stage;            // Boot stage
+	u8  img_set_sel;           // Image set booted from
+	u8  rsv0[2];               // Reserved
+	u32 img_set_end;           // Offset of Image End
+	u32 rom_version;           // ROM version
+	u8  boot_dev_state;        // Boot device state
+	u8  boot_dev_inst;         // Boot device type
+	u8  boot_dev_type;         // Boot device instance
+	u8  rsv1;                  // Reserved
+	u32 dev_page_size;         // Boot device page size
+	u32 cnt_header_ofs;        // Container header offset
+	u32 img_ofs;               // Image offset
+}  __packed rom_passover_t;
+
+/**
+ * struct scmi_rom_passover_out - Response payload for ROM_PASSOVER_GET command
+ * @status:	SCMI clock ID
+ * @attributes:	Attributes of the targets clock state
+ */
+struct scmi_rom_passover_get_out {
+	u32 status;
+	u32 numPassover;
+	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
+};
+
+#endif
+
 /* For i.MX ULP */
 #define BT0CFG_LPBOOT_MASK	0x1
 #define BT0CFG_DUALBOOT_MASK	0x2
diff --git a/arch/arm/mach-imx/imx9/scmi/Makefile b/arch/arm/mach-imx/imx9/scmi/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..4534db08d287899af5bb26283e4d20b942b421e4
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+obj-y += soc.o
+obj-y += clock_scmi.o clock.o
diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
new file mode 100644
index 0000000000000000000000000000000000000000..9ebd38097615351304dcc39a93652ab2ce046e93
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <dm/uclass.h>
+#include <scmi_agent.h>
+#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+
+u32 get_arm_core_clk(void)
+{
+	u32 val;
+
+	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
+	if (val)
+		return val;
+	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
+}
+
+void set_arm_core_max_clk(void)
+{
+	int ret;
+	u32 arm_domain_id = 8;
+
+	struct scmi_perf_in in = {
+		.domain_id = arm_domain_id,
+		.perf_level = 3,
+	};
+	struct scmi_perf_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PERF, SCMI_PERF_LEVEL_SET, in, out);
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+}
+
+int clock_init_early(void)
+{
+	return 0;
+}
+
+/* Set bus and A55 core clock per voltage mode */
+int clock_init_late(void)
+{
+	set_arm_core_max_clk();
+
+	return 0;
+}
+
+void init_uart_clk(u32 index)
+{
+	u32 clock_id;
+
+	switch (index) {
+	case 0:
+		clock_id = IMX95_CLK_LPUART1;
+		break;
+	case 1:
+		clock_id = IMX95_CLK_LPUART2;
+		break;
+	case 2:
+		clock_id = IMX95_CLK_LPUART3;
+		break;
+	default:
+		return;
+	}
+
+	/* 24MHz */
+	imx_clk_scmi_enable(clock_id, false);
+	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_rate(clock_id, 24000000);
+	imx_clk_scmi_enable(clock_id, true);
+}
+
+unsigned int mxc_get_clock(enum mxc_clock clk)
+{
+	switch (clk) {
+	case MXC_ARM_CLK:
+		return get_arm_core_clk();
+	case MXC_IPG_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
+	case MXC_CSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
+	case MXC_ESDHC_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
+	case MXC_ESDHC2_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
+	case MXC_ESDHC3_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
+	case MXC_UART_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+	case MXC_FLEXSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
+	default:
+		return -1;
+	};
+
+	return -1;
+};
diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..23ffe0eed695b67977d441f7ee8830af9c4aabfe
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <dm/uclass.h>
+#include <scmi_agent.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable)
+{
+	struct scmi_clk_state_in in = {
+		.clock_id = clock_id,
+		.attributes = (enable) ? 1 : 0,
+	};
+	struct scmi_clk_state_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_CONFIG_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate)
+{
+	struct scmi_clk_rate_set_in in = {
+		.clock_id = clock_id,
+		.flags = SCMI_CLK_RATE_ROUND_CLOSEST,
+		.rate_lsb = (u32)rate,
+		.rate_msb = (u32)((u64)rate >> 32),
+	};
+	struct scmi_clk_rate_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	struct scmi_clk_rate_get_in in_rate = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out_rate;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK, SCMI_CLOCK_RATE_GET, in_rate, out_rate);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out_rate.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out_rate.rate_msb << 32) | out_rate.rate_lsb);
+}
+
+ulong imx_clk_scmi_get_rate(u32 clock_id)
+{
+	struct scmi_clk_rate_get_in in = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_GET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
+}
+
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clock_id,
+		.parent_clk = parent_id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0 && ret != -EACCES)
+		printf("%s: %d, clock_id %u\n", __func__, ret, clock_id);
+
+	return ret;
+}
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
new file mode 100644
index 0000000000000000000000000000000000000000..f1683b0484b84bf18b8612abc4daacf2f69d5e0b
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -0,0 +1,809 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/armv8/mmu.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/setup.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <env_internal.h>
+#include <fuse.h>
+#include <imx_thermal.h>
+#include <scmi_agent.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static rom_passover_t rom_passover_data = {0};
+
+uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
+{
+	/* Read ROM passover data */
+	struct scmi_rom_passover_get_out out;
+	struct scmi_msg msg = SCMI_MSG(SCMI_PROTOCOL_ID_IMX_MISC, SCMI_MISC_ROM_PASSOVER_GET, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret == 0 && out.status == 0) {
+		memcpy(rom_data, (struct rom_passover_t *)out.passover, sizeof(rom_passover_t));
+	} else {
+		printf("Failed to get ROM passover data, scmi_err = %d, size_of(out) = %ld\n",
+		       out.status, sizeof(out));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
+__weak int board_mmc_get_env_dev(int devno)
+{
+	return devno;
+}
+
+int mmc_get_env_dev(void)
+{
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+
+	volatile gd_t *pgd = gd;
+	rom_passover_t *rdata;
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (!pgd->reloc_off)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return CONFIG_SYS_MMC_ENV_DEV;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+	set_gd(pgd);
+
+	debug("boot_type %d, instance %d\n", boot_type, boot_instance);
+
+	/* If not boot from sd/mmc, use default value */
+	if (boot_type != BOOT_TYPE_SD && boot_type != BOOT_TYPE_MMC)
+		return env_get_ulong("mmcdev", 10, CONFIG_SYS_MMC_ENV_DEV);
+
+	return board_mmc_get_env_dev(boot_instance);
+}
+#endif
+
+u32 get_cpu_speed_grade_hz(void)
+{
+	u32 speed, max_speed;
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 14;
+
+	ret = fuse_read(word / 8, word % 8, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0xf;
+
+	max_speed = 2300000000;
+	speed = max_speed - val * 100000000;
+
+	if (is_imx95())
+		max_speed = 2000000000;
+
+	/* In case the fuse of speed grade not programmed */
+	if (speed > max_speed)
+		speed = max_speed;
+
+	return speed;
+}
+
+u32 get_cpu_temp_grade(int *minc, int *maxc)
+{
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 12;
+
+	ret = fuse_read(word / 8, word % 8, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0x3;
+
+	if (minc && maxc) {
+		if (val == TEMP_AUTOMOTIVE) {
+			*minc = -40;
+			*maxc = 125;
+		} else if (val == TEMP_INDUSTRIAL) {
+			*minc = -40;
+			*maxc = 105;
+		} else if (val == TEMP_EXTCOMMERCIAL) {
+			*minc = -20;
+			*maxc = 105;
+		} else {
+			*minc = 0;
+			*maxc = 95;
+		}
+	}
+	return val;
+}
+
+static void set_cpu_info(struct ele_get_info_data *info)
+{
+	gd->arch.soc_rev = info->soc;
+	gd->arch.lifecycle = info->lc;
+	memcpy((void *)&gd->arch.uid, &info->uid, 4 * sizeof(u32));
+}
+
+u32 get_cpu_rev(void)
+{
+	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
+
+	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
+}
+
+#define UNLOCK_WORD 0xD928C520 /* unlock word */
+#define REFRESH_WORD 0xB480A602 /* refresh word */
+
+static void disable_wdog(void __iomem *wdog_base)
+{
+	u32 val_cs = readl(wdog_base + 0x00);
+
+	if (!(val_cs & 0x80))
+		return;
+
+	/* default is 32bits cmd */
+	writel(REFRESH_WORD, (wdog_base + 0x04)); /* Refresh the CNT */
+
+	if (!(val_cs & 0x800)) {
+		writel(UNLOCK_WORD, (wdog_base + 0x04));
+		while (!(readl(wdog_base + 0x00) & 0x800))
+			;
+	}
+	writel(0x0, (wdog_base + 0x0C)); /* Set WIN to 0 */
+	writel(0x400, (wdog_base + 0x08)); /* Set timeout to default 0x400 */
+	writel(0x2120, (wdog_base + 0x00)); /* Disable it and set update */
+
+	while (!(readl(wdog_base + 0x00) & 0x400))
+		;
+}
+
+static struct mm_region imx9_mem_map[] = {
+	{
+		/* ROM */
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 0x100000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* TCM */
+		.virt = 0x201c0000UL,
+		.phys = 0x201c0000UL,
+		.size = 0x80000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* OCRAM */
+		.virt = 0x20480000UL,
+		.phys = 0x20480000UL,
+		.size = 0xA0000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* AIPS */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Flexible Serial Peripheral Interface */
+		.virt = 0x28000000UL,
+		.phys = 0x28000000UL,
+		.size = 0x8000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* DRAM1 */
+		.virt = PHYS_SDRAM,
+		.phys = PHYS_SDRAM,
+		.size = PHYS_SDRAM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				 PTE_BLOCK_OUTER_SHARE
+	}, {
+#ifdef PHYS_SDRAM_2_SIZE
+		/* DRAM2 */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = PHYS_SDRAM_2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+#endif
+		/* empty entry to split table entry 5 if needed when TEEs are used */
+		0,
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = imx9_mem_map;
+
+static unsigned int imx9_find_dram_entry_in_mem_map(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx9_mem_map); i++)
+		if (imx9_mem_map[i].phys == CFG_SYS_SDRAM_BASE)
+			return i;
+
+	hang();	/* Entry not found, this must never happen. */
+}
+
+void enable_caches(void)
+{
+	/* If OPTEE runs, remove OPTEE memory from MMU table to avoid speculative prefetch
+	 * If OPTEE does not run, still update the MMU table according to dram banks structure
+	 * to set correct dram size from board_phys_sdram_size
+	 */
+	int i = 0;
+	/*
+	 * please make sure that entry initial value matches
+	 * imx9_mem_map for DRAM1
+	 */
+	int entry = imx9_find_dram_entry_in_mem_map();
+	u64 attrs = imx9_mem_map[entry].attrs;
+
+	while (i < CONFIG_NR_DRAM_BANKS &&
+	       entry < ARRAY_SIZE(imx9_mem_map)) {
+		if (gd->bd->bi_dram[i].start == 0)
+			break;
+		imx9_mem_map[entry].phys = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].virt = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].size = gd->bd->bi_dram[i].size;
+		imx9_mem_map[entry].attrs = attrs;
+		debug("Added memory mapping (%d): %llx %llx\n", entry,
+		      imx9_mem_map[entry].phys, imx9_mem_map[entry].size);
+		i++; entry++;
+	}
+
+	icache_enable();
+	dcache_enable();
+}
+
+__weak int board_phys_sdram_size(phys_size_t *size)
+{
+	phys_size_t start, end;
+	phys_size_t val;
+
+	if (!size)
+		return -EINVAL;
+
+	val = readl(REG_DDR_CS0_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size = end - start;
+
+	val = readl(REG_DDR_CS1_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size += end - start;
+
+	return 0;
+}
+
+int dram_init(void)
+{
+	phys_size_t sdram_size;
+	int ret;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* rom_pointer[1] contains the size of TEE occupies */
+	if (rom_pointer[1])
+		gd->ram_size = sdram_size - rom_pointer[1];
+	else
+		gd->ram_size = sdram_size;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	int bank = 0;
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size, sdram_b2_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* Bank 1 can't cross over 4GB space */
+	if (sdram_size > 0x80000000) {
+		sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		sdram_b2_size = sdram_size - sdram_b1_size;
+	} else {
+		sdram_b1_size = sdram_size;
+		sdram_b2_size = 0;
+	}
+
+	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	if (rom_pointer[1]) {
+		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
+		phys_size_t optee_size = (size_t)rom_pointer[1];
+
+		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_b1_size)) {
+			if (++bank >= CONFIG_NR_DRAM_BANKS) {
+				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
+				return -1;
+			}
+
+			gd->bd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_b1_size - gd->bd->bi_dram[bank].start;
+		}
+	} else {
+		gd->bd->bi_dram[bank].size = sdram_b1_size;
+	}
+
+	if (sdram_b2_size) {
+		if (++bank >= CONFIG_NR_DRAM_BANKS) {
+			puts("CONFIG_NR_DRAM_BANKS is not enough for SDRAM_2\n");
+			return -1;
+		}
+		gd->bd->bi_dram[bank].start = 0x100000000UL;
+		gd->bd->bi_dram[bank].size = sdram_b2_size;
+	}
+
+	return 0;
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (!ret) {
+		/* Bank 1 can't cross over 4GB space */
+		if (sdram_size > 0x80000000) {
+			sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		} else {
+			sdram_b1_size = sdram_size;
+		}
+
+		if (rom_pointer[1]) {
+			/* We will relocate u-boot to Top of dram1. Tee position has two cases:
+			 * 1. At the top of dram1,  Then return the size removed optee size.
+			 * 2. In the middle of dram1, return the size of dram1.
+			 */
+			if ((rom_pointer[0] + rom_pointer[1]) == (PHYS_SDRAM + sdram_b1_size))
+				return ((phys_addr_t)rom_pointer[0] - PHYS_SDRAM);
+		}
+
+		return sdram_b1_size;
+	} else {
+		return PHYS_SDRAM_SIZE;
+	}
+}
+
+void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
+{
+	u32 val[2] = {};
+	int ret;
+
+	if (dev_id == 0) {
+		ret = fuse_read(39, 3, &val[0]);
+		if (ret)
+			goto err;
+
+		ret = fuse_read(39, 4, &val[1]);
+		if (ret)
+			goto err;
+
+		mac[0] = val[1] >> 8;
+		mac[1] = val[1];
+		mac[2] = val[0] >> 24;
+		mac[3] = val[0] >> 16;
+		mac[4] = val[0] >> 8;
+		mac[5] = val[0];
+
+	} else {
+		ret = fuse_read(39, 5, &val[0]);
+		if (ret)
+			goto err;
+
+		ret = fuse_read(39, 4, &val[1]);
+		if (ret)
+			goto err;
+
+		if (is_soc_rev(CHIP_REV_1_0)) {
+			mac[0] = val[1] >> 24;
+			mac[1] = val[1] >> 16;
+			mac[2] = val[0] >> 24;
+			mac[3] = val[0] >> 16;
+			mac[4] = val[0] >> 8;
+			mac[5] = val[0];
+		} else {
+			mac[0] = val[0] >> 24;
+			mac[1] = val[0] >> 16;
+			mac[2] = val[0] >> 8;
+			mac[3] = val[0];
+			mac[4] = val[1] >> 24;
+			mac[5] = val[1] >> 16;
+		}
+	}
+
+	debug("%s: MAC%d: %02x.%02x.%02x.%02x.%02x.%02x\n",
+	      __func__, dev_id, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
+	return;
+err:
+	memset(mac, 0, 6);
+	printf("%s: fuse read err: %d\n", __func__, ret);
+}
+
+const char *get_imx_type(u32 imxtype)
+{
+	switch (imxtype) {
+	case MXC_CPU_IMX95:
+		return "95";/* iMX95 FULL */
+	default:
+		return "??";
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 cpurev, max_freq;
+	int minc, maxc;
+
+	cpurev = get_cpu_rev();
+
+	printf("CPU:   i.MX%s rev%d.%d",
+		get_imx_type((cpurev & 0x1FF000) >> 12),
+		(cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
+
+	max_freq = get_cpu_speed_grade_hz();
+	if (!max_freq || max_freq == mxc_get_clock(MXC_ARM_CLK)) {
+		printf(" at %dMHz\n", mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	} else {
+		printf(" %d MHz (running at %d MHz)\n", max_freq / 1000000,
+		       mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	}
+
+	puts("CPU:   ");
+	switch (get_cpu_temp_grade(&minc, &maxc)) {
+	case TEMP_AUTOMOTIVE:
+		puts("Automotive temperature grade ");
+		break;
+	case TEMP_INDUSTRIAL:
+		puts("Industrial temperature grade ");
+		break;
+	case TEMP_EXTCOMMERCIAL:
+		if (is_imx93())
+			puts("Extended Industrial temperature grade ");
+		else
+			puts("Extended Consumer temperature grade ");
+		break;
+	default:
+		puts("Consumer temperature grade ");
+		break;
+	}
+	printf("(%dC to %dC)", minc, maxc);
+
+#if defined(CONFIG_DM_THERMAL)
+	struct udevice *udev;
+	int ret, temp;
+
+	if (IS_ENABLED(CONFIG_IMX_TMU))
+		ret = uclass_get_device_by_name(UCLASS_THERMAL, "cpu-thermal", &udev);
+	else
+		ret = uclass_get_device(UCLASS_THERMAL, 0, &udev);
+	if (!ret) {
+		ret = thermal_get_temp(udev, &temp);
+
+		if (!ret)
+			printf(" at %dC", temp);
+		else
+			debug(" - invalid sensor data\n");
+	} else {
+		debug(" - invalid sensor device\n");
+	}
+#endif
+	puts("\n");
+
+	return 0;
+}
+
+void build_info(void)
+{
+	u32 fw_version, sha1, res, status;
+	int ret;
+
+	printf("\nBuildInfo:\n");
+
+	ret = ele_get_fw_status(&status, &res);
+	if (ret) {
+		printf("  - ELE firmware status failed %d, 0x%x\n", ret, res);
+	} else if ((status & 0xff) == 1) {
+		ret = ele_get_fw_version(&fw_version, &sha1, &res);
+		if (ret) {
+			printf("  - ELE firmware version failed %d, 0x%x\n", ret, res);
+		} else {
+			printf("  - ELE firmware version %u.%u.%u-%x",
+			       (fw_version & (0x00ff0000)) >> 16,
+			       (fw_version & (0x0000ff00)) >> 8,
+			       (fw_version & (0x000000ff)), sha1);
+			((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
+		}
+	} else {
+		printf("  - ELE firmware not included\n");
+	}
+	puts("\n");
+}
+
+int arch_misc_init(void)
+{
+	build_info();
+	return 0;
+}
+
+#ifdef CONFIG_OF_BOARD_FIXUP
+#ifndef CONFIG_SPL_BUILD
+int board_fix_fdt(void *fdt)
+{
+	return 0;
+}
+#endif
+#endif
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+
+#if defined(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
+void get_board_serial(struct tag_serialnr *serialnr)
+{
+	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
+	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
+
+	serialnr->low = gd->arch.uid[0];
+	serialnr->high = gd->arch.uid[3];
+}
+#endif
+
+static void gpio_reset(ulong gpio_base)
+{
+	writel(0, gpio_base + 0x10);
+	writel(0, gpio_base + 0x14);
+	writel(0, gpio_base + 0x18);
+	writel(0, gpio_base + 0x1c);
+}
+
+int arch_cpu_init(void)
+{
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
+		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+
+		clock_init_early();
+
+		gpio_reset(GPIO2_BASE_ADDR);
+		gpio_reset(GPIO3_BASE_ADDR);
+		gpio_reset(GPIO4_BASE_ADDR);
+		gpio_reset(GPIO5_BASE_ADDR);
+	}
+
+	return 0;
+}
+
+int imx9_probe_mu(void)
+{
+	struct udevice *dev;
+	int node, ret;
+	u32 res;
+	struct ele_get_info_data info;
+
+	ret = uclass_get_device_by_driver(UCLASS_SCMI_AGENT, DM_DRIVER_GET(scmi_mbox), &dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19", &dev);
+	if (ret)
+		return ret;
+
+	node = fdt_node_offset_by_compatible(gd->fdt_blob, -1, "fsl,imx93-mu-s4");
+
+	ret = uclass_get_device_by_of_offset(UCLASS_MISC, node, &dev);
+	if (ret)
+		return ret;
+
+	if (gd->flags & GD_FLG_RELOC)
+		return 0;
+
+	ret = ele_get_info(&info, &res);
+	if (ret)
+		return ret;
+
+	set_cpu_info(&info);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx9_probe_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx9_probe_mu);
+
+int timer_init(void)
+{
+	gd->arch.tbl = 0;
+	gd->arch.tbu = 0;
+
+#ifdef CONFIG_SPL_BUILD
+	unsigned long freq = 24000000;
+
+	asm volatile("msr cntfrq_el0, %0" : : "r" (freq) : "memory");
+#endif
+
+	return 0;
+}
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	enum boot_device dev = get_boot_device();
+	enum env_location env_loc = ENVL_UNKNOWN;
+
+	if (prio)
+		return env_loc;
+
+	switch (dev) {
+#if defined(CONFIG_ENV_IS_IN_SPI_FLASH)
+	case QSPI_BOOT:
+		env_loc = ENVL_SPI_FLASH;
+		break;
+#endif
+#if defined(CONFIG_ENV_IS_IN_MMC)
+	case SD1_BOOT:
+	case SD2_BOOT:
+	case SD3_BOOT:
+	case MMC1_BOOT:
+	case MMC2_BOOT:
+	case MMC3_BOOT:
+		env_loc =  ENVL_MMC;
+		break;
+#endif
+	default:
+#if defined(CONFIG_ENV_IS_NOWHERE)
+		env_loc = ENVL_NOWHERE;
+#endif
+		break;
+	}
+
+	return env_loc;
+}
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
+{
+	u32 speed = get_cpu_speed_grade_hz();
+	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
+
+	if (is_imx95()) {
+		if (speed == 2000000000)
+			voltage = VOLT_SUPER_OVER_DRIVE;
+		else if (speed == 1800000000)
+			voltage = VOLT_OVER_DRIVE;
+		else if (speed == 1400000000)
+			voltage = VOLT_NOMINAL_DRIVE;
+		else /* boot not support low drive mode according to AS */
+			printf("Unexpected A55 freq %u, default to OD\n", speed);
+	}
+
+	return voltage;
+}
+
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+enum boot_device get_boot_device(void)
+{
+	volatile gd_t *pgd = gd;
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+	enum boot_device boot_dev = 0;
+	rom_passover_t *rdata;
+
+#ifdef CONFIG_SPL_BUILD
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (pgd->reloc_off == 0)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return -1;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+
+	set_gd(pgd);
+
+	switch (boot_type) {
+	case BT_DEV_TYPE_SD:
+		boot_dev = boot_instance + SD1_BOOT;
+		break;
+	case BT_DEV_TYPE_MMC:
+		boot_dev = boot_instance + MMC1_BOOT;
+		break;
+	case BT_DEV_TYPE_NAND:
+		boot_dev = NAND_BOOT;
+		break;
+	case BT_DEV_TYPE_FLEXSPINOR:
+		boot_dev = QSPI_BOOT;
+		break;
+	case BT_DEV_TYPE_USB:
+		boot_dev = boot_instance + USB_BOOT;
+#ifdef CONFIG_IMX95
+		boot_dev -= 3; //iMX95 usb instance start at 3
+#endif
+		break;
+	default:
+		break;
+	}
+
+	return boot_dev;
+}
+#endif
diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index b30e536a35771ec3e1439c1e64fd09de3728dc50..c9717118bcb90e7f26285ead30cff8612ed42956 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -110,7 +110,7 @@ struct sandbox_scmi_devices {
 	size_t regul_count;
 };
 
-#ifdef CONFIG_SCMI_FIRMWARE
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
 /**
  * sandbox_scmi_channel_id - Get the channel id
  * @dev:	Reference to the SCMI protocol device

-- 
2.34.1

