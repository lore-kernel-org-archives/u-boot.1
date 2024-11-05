Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6224D2C13D
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F5A8913F;
	Tue,  5 Nov 2024 16:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="V1zyGVMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5CC891AC; Tue,  5 Nov 2024 16:38:15 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C87A98913F
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFQdGsYBhr4LqxA5OHCCKqieUJLZriWuSRmlBEzj+VYwWR0NJuVjf8lqi0q0vg5wIoaWd5O+vD+U9MY7Q17+dybeCttdZiqYe7W/H1iovqLmAblXqbm8p0OTJSB9yEt0rg9XdiT74iWz3keqX82iOhQcSvlz+kcB8NnZM+B+lWVjYXYjmW99OcML/1LAk8uOqPBbUt2fp3KC6Mf4j76lqAExLkojoNBEtH24Z1td8u3ajqzU0GKjt/IfSwwz929vsSCfDIj7J6npF3mnC/I9fJE6LqVZWeNjqhEF4tP1h+ottFFpD6TIFNsRsP3zqch4Ff4lQ78heyV88JYBOmbvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2E7USOvyG0+UeTxaBfNscFEhU0cLOr3fI8pu/lhdNU=;
 b=el6b6mSRFBL3HIaChHWtv6zp8lw9zXkfzQBEcTT0yRkKeTcWAVWzt0u/nCB2QRhBxZHh41g2FQa84U2wkc3ir1ohzEVI/BAdFhBaTayGzz38p4JdnsNYd3lDEQN2Mv0eqBWT7bJP3AVGm6Xbx0sYZFvMSeYS34/aIrd8Avba7SAqKpHEUpwiq71huV+QOMFanZN1AgYkW45RhaUJX5qSiEV0SLVB36vhs7TcHHbXZ5zKdxNCy4uzLiuFT8oSJtpxgogcVrV13Wl0cuc5yJ043ZTi2QcpqNAFe5D63cSEBMnmpTQFBJA/gZXWMNaQiES8T8KILJc5jVzSBGc6WzQTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2E7USOvyG0+UeTxaBfNscFEhU0cLOr3fI8pu/lhdNU=;
 b=V1zyGVMgTP14YMjhR/EQQUXyYqaMqLt/TVN19l+40PY4uP8ISywhLqgQT+HqJk7OoLjHFsnAA+i+6/WErDWAErthjNjd70XMAF6bXnAvZmCjkb842QxDiH+C5OUGsxPXeiTOFItkcBTeTIjt9h6YOYpUrvJ0NfL5vcbGbyRPLXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8924.eurprd04.prod.outlook.com (2603:10a6:20b:40b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:38:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 15:38:09 +0000
Message-ID: <9c472107-7b05-4d77-8cb7-b5971b441e50@cherry.de>
Date: Tue, 5 Nov 2024 16:38:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] rockchip: rk3399-rockpro64: Hook sysreset gpio to
 enable full reset
To: Paul Kocialkowski <paulk@sys-base.io>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Chris Morgan <macromorgan@hotmail.com>,
 Tim Lunn <tim@feathertop.org>, Paul Kocialkowski <contact@paulk.fr>
References: <20240926183111.1324284-1-paulk@sys-base.io>
 <20240926183111.1324284-2-paulk@sys-base.io>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240926183111.1324284-2-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: c8eee992-c991-4123-5d2f-08dcfdafd9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmp5N2xVd0dTOXhUNytTL1RvSm0vTm1HWk12Mk9rUG1nMUVQbk5mQXJkTFZS?=
 =?utf-8?B?UnNqK2lJQ2tqRkxoQjJZcjAwRThqbEtEdHBoMkhNN1Z6YVpyK0U5QjBUOXJC?=
 =?utf-8?B?SjRDU1F0ZXZzc0RDd2pPdjBTWDFyRXdDUHZwNnZSNkpKbkdkVk9KUnc5L2R3?=
 =?utf-8?B?Mk5Ec1Vudjd1Tnp2b1cxSDNkWnVsOVhNeVYvc2wyVjYrT0pnekNYS1d3OFNS?=
 =?utf-8?B?K0xQKzczVERHRzhlam1LVCtCaWwxSWx1UE1ETE93b1VqdXVNM3JEUEdYTTdy?=
 =?utf-8?B?RFcyNzVxQXBxNVBIR2RlWFJqeXkzeHJEdGdHbitodXZXdTUwN2ZLZ2tjZm1m?=
 =?utf-8?B?SFdEWVNmVXFQb0FHQkMvSVh4NmdKT1dmM0xGWlp2dE94S296ZUdycmcyV0xU?=
 =?utf-8?B?VjFMQkQ2bU5NeWlzemRCc01vWnl2bllYQTdsM0tsUDRRUEFqY0lGbDM3TkxK?=
 =?utf-8?B?U0JMYWZCWkwwL3dWSzZDSm9adUZJekdRMkJNRm5WcmlzaEd6RS9tSWhaTElW?=
 =?utf-8?B?Skx2ejlRNXVTSjlnNCtWM2R5YUw2RVZLNm5OUytZVlhTZlo4dWxvaDViRDVv?=
 =?utf-8?B?V3E4VnBVdVhoTmNlRmZWQStZanFMbkpUSmdXWkZqcjJwaUNCSWgvRU92NDd6?=
 =?utf-8?B?Mm81RG51bU9lR0Zzb2tyYzBCRUgvVHIrdkxZNlhQYm9xRkFXL3ZXQXYvNnNp?=
 =?utf-8?B?YXNEaGx1c1RIODk5ME5iUWFydnRYYjVyVk5kWXF2WE93M1ZML2dobnhxeEow?=
 =?utf-8?B?eDVzb1JIaVF2RjZCUnNQNXlyd2xBRi9EY3lkcXBjbjc3WU9GVlA0SGVjKzNL?=
 =?utf-8?B?TmFmVFJqdVAyc3dwUDArVDg2RHZOdDNVWjBkVURFaDZvcTF1Z0xsY0pNeC8r?=
 =?utf-8?B?djRGTjB1M0Y3cE9FbnFTcjBEUTBkVFp6Z2l5Ukl0b1A0V3NROFN0OTA2QmdO?=
 =?utf-8?B?ZklQZmlvenM4TEtMUGZTUVJSeC8xTFdHUXRiVUxTTFBwck43SEdMbW9WQWEw?=
 =?utf-8?B?NlVibC9sUXp5NThvY3dsdmora29ZQVZoZ1JmSTVkNG92QnN1allnbzRSbTZt?=
 =?utf-8?B?Vm5YdHRrMFgzaUdXWnpoVS8xQ0tvSkk4QjgrTXpiWHBtQXYzTi9KK2hTUzVp?=
 =?utf-8?B?SDFFTGJldFZGZUVwcWxUcU9GdUZGd2wyT1Y0a3luMzg4bUxsTFdHa3FUSmll?=
 =?utf-8?B?ZWhYQ2dDNlZ5L0tqakhFYVV5eWZpcnFUeko1K2Zmb3JoUUEwQmlRd3pwQnBL?=
 =?utf-8?B?ODJmWnhWL0JYSHNrcEN4bzdVQ3NrZlJ5TmZza1hPZnl4MXNBUENNRmJrOG5l?=
 =?utf-8?B?dFN0eko2QzdRa3ErV0VvcDBhMHpZZkFsSnp2Ym5NQ1dNUURHZFJudG53dXJP?=
 =?utf-8?B?aXNKQWIvV0xMODhCcTZNY25zeHlqQWdseFNtcHd5Qk1oRERqWmhYWWNjSXIx?=
 =?utf-8?B?NDJnNlNEQTFUZUZSN29BTG02V1pUbWRrN0ZHTVJZMnBEYVNlQjJjYjBidDhQ?=
 =?utf-8?B?b1NDZjFoR1oyTzg2ZDN4U242L1hwUldwZG55OURMR09lRFVBTDFKNitPTzZX?=
 =?utf-8?B?dUxobFVtOXJ1eVlDck9QdWEzbGI5WkJneWdRRU1uTk92U0pkWk5IcENyMStL?=
 =?utf-8?B?SmNJK2sxU1M1T0srK1pNKy9UVnNZUVo3QitUYzluc0J4bjB4amd6d1BDOWU5?=
 =?utf-8?Q?Lz1fjjIuXJBovQhEHhUS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENpeEZYWUFLdENSZk1PSGFidWFCUWNlUHd6dlUyS05HbG9EcjcvQlRDMUU2?=
 =?utf-8?B?emdNZG9FYXJDNDEvZEE2UzVoZzhsK05vZmxPSCs2Tk05bWhJY25ncS8zL2JZ?=
 =?utf-8?B?anFFZE94b09menhTV251WVE5cWlkNGh1QkFJRy93OVNtblFrSTV3ajg1QUt6?=
 =?utf-8?B?bVRJVWJVVUhzSGw5Tk9vc3FnT216RWxqMGxyZUtIOVpURVhqZkcyOTgyNUx4?=
 =?utf-8?B?Q2FnU2J2SlpOTFlMZ1ZJYk0yNy9rRDFNTTM3UFhnTE1xLzd6WnRhNU9wdU03?=
 =?utf-8?B?QUZVR2Q5SzBlU3R6RFJMb0lUSjR3RkczaHpRZjk4WDZMWnZtVWdUc216M3Z0?=
 =?utf-8?B?K3hXd0kzbGg0by9CZUcwSi8vb1czZllHRTNER1dHdk1pZmFhQTVidlFpaUt4?=
 =?utf-8?B?LzJmL2gvZVFnaytMYXYycDE5WHNTZDJlN3FiWUcwTjhnYW4yM3VrRGk4d096?=
 =?utf-8?B?cDdXQ2s0L2p2SzYybjRYODdFQllFaFhiZnBVSkltTjljeUNpRGVISk9sZG8w?=
 =?utf-8?B?MFFuamFxVmdJVEtOQ01FeGJtUkRXYWdLNWExRi9rSG0zRGVJWmlOencrT0FS?=
 =?utf-8?B?Zy9jYkhOcWRqUm9IWWZuditwNXFqcGdxSDFLTmhEaXkvM3QyTFhDSzAveHpr?=
 =?utf-8?B?aTN5Qi91Q001SjcrUWhXN2FFYTZyVUsyUWVkREJZb1V1TGFBMmhjV0o2WVNt?=
 =?utf-8?B?WFhQYVlzL05YVmxpR3UxeXJSdDFIUm9pdU5uN3BWMFBhTDVyT28zbDBlT3Ay?=
 =?utf-8?B?MzJQWGYzbHduSUJXNFFUTitHcElJOVJ4akVvSldJenRZaUxIUTA4SG8xQWZx?=
 =?utf-8?B?cDlacGdMQjFiUDJWRUR1V2lKN1lsVEpiWG1uRll0SUFxS01heTBwbG1wcFMz?=
 =?utf-8?B?Q2ZlQ2llZnkwdS9tVDZDdnJWeGRHTVA2Y2tVbzlyUk56REpnRzZwQUZMaEU4?=
 =?utf-8?B?R0VHajdMN1p4QkVFVEVXRnp1VFBCcnVSdnlnV09UR3JUZ2JqUFBrc0FRMnhq?=
 =?utf-8?B?bXhxZ0NWdmRPa1dJMWR1UkhXYlZNQWMyMnpMbytDZ0ZhRlQyVXR0dUJiOTQ4?=
 =?utf-8?B?SnBhTVhWTW9jZFlpbnNmTW1ubjFIOGNQaXhjRWZwY09DcWE3WjdFRXlWc2I5?=
 =?utf-8?B?MUgxYWRGcmVaNWd0SXZ2VkpXL1RQSVQvUmlEZ2wwSkpyUVNRTzhFcFg4UVNG?=
 =?utf-8?B?TnV3eFc4R3N2QlpaeHVIb0ZQdjNxQ0YyWW9OQlFYMHFaSkVwWkx4RWI4eXpE?=
 =?utf-8?B?ay9YRTlaSUpJa2hwOUpQSldRZjVweGZyNEJlTjFkTWFhTzlqUFJJRi9zZGUv?=
 =?utf-8?B?UG84Ly9xR1lNaDZmVzNsRWVIQ0pIM0tMOXRnWUZ2R2pRUGk4YytFMmNqSG92?=
 =?utf-8?B?VW1RRWJFbC9CNk9KeHYvMGxNSjVmQWRDTkVKV01xRDVRa1E0T2Jta2Z6NGNK?=
 =?utf-8?B?Uk4reTFTWVk0WWlhcWdYWGNDN0c3RkxBVHFzUkdjQU1HeUdQNmVVVFFDR1J3?=
 =?utf-8?B?M0Zza1o4cUpSMEV1WER2UFRPR054T3B5SXp2dFZwc1Nmb1RhL2RXRnJoeHB4?=
 =?utf-8?B?WlQ5RGxuYjVKWXZYOXpFQ3JwMHhkZE9oejdkdU9YQjNweU5RdUIyNXJKdW9n?=
 =?utf-8?B?czA0Nm0wZXMvSnVSSmZacHg0dVdmckx3c0dVMHpqNURnZUNuTjJpKy93bGZB?=
 =?utf-8?B?THBiNzFOWlh1dUZHM2NJOE4xbEJtRGhNMU9lU0xORGNNb2dEaWw1dU9XUHlS?=
 =?utf-8?B?NlE1L09IZmx4ODFOQ0UvSmVIYmYrTEFVcEhaZDNDVkV3am1IN0JHL1pKNHZ4?=
 =?utf-8?B?V05iWFF5TFltNEVZVjFwUktVRGoxMjU1NzQ4T21PcWpNOVBKRzZnUDRidnR2?=
 =?utf-8?B?RnpVOHl0NDZQWW9yRWtWVE1TTm1NamJIS2dPMTU0ejVMQlNMUmVaRm1DbFVu?=
 =?utf-8?B?RStxSE9zSjIrKzRBRlFGcFoyNUgyeDNEV2N3cWFOekY4KzllL2lSTUpkaE5L?=
 =?utf-8?B?N0Z5MGhieUdDaVgxUGlWVW05b0FOVkNjYm80bDQxZmtRckJJMXg1TUI1YzVB?=
 =?utf-8?B?NEhZT1BxYVVnekxhN09ZN3RscmdPUE9rWVZ2OXpwOEdQdlVsanFSSDg5WXNk?=
 =?utf-8?B?K3BxSU5OcC83b3p4a1RRblRWSnhrYmFtcWlPRjlvd21IOGRKWEp6aFB1ZHlK?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c8eee992-c991-4123-5d2f-08dcfdafd9c0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:38:09.6114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxTuyzz9kGOu1ZRKF9/cGSHl+1feBaSR76cc0Qg86pKtbZTjj60OMhQ2njjx4dZIj9/4YK+8U4Mf51xnbfao9DH070IBdzDDfMYsOAo378w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8924
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

Hi Paul,

On 9/26/24 8:31 PM, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
> 
> The reset mechanism used by Linux to reset the SoC is known to only
> partially reset the logic. A mechanism is implemented in
> rk3399_force_power_on_reset to use a GPIO connected to the PMIC's
> over-temperature (OTP) reset pin, which fully resets all logic.
> 
> Hook the associated GPIO where the function expects it to enable this
> reset mechanism and avoid any possible side-effect of partially-reset
> units.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Since patches 3 and 4 seems to be a bit controversial, maybe send 
patches 1 and 2 in a different patch series so those can be merged 
separately?

You may want to have a look at 
https://lore.kernel.org/u-boot/20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de/T/#t 
too BTW.

Cheers,
Quentin
