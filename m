Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14112C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 02:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0550583AEE;
	Tue,  5 Aug 2025 04:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IF+363l3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F3E3840BD; Tue,  5 Aug 2025 04:50:15 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DA983A81
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 04:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1a4CbArZOYtI2p1Xj5wOs8JTXyCzIxakE7RHuStZOZ57il7H2I01YoiOoM83v+IXslhulzWcGfje2UncXmq18mgn8LlWQG53hZVQsVyXHlfCYhXZDu8OxGvGesR2sI7uU+Sv5T8Qzc8lpY2XucxIkTDjyZuhkM6BwvK5jJ8V22HOvFB2gHIHRP3TW7AxuL7ZyCpuPVYROD4HPOWq88/aaYa74FXdl6Ks44Pv0X/94ag/CY1Gum9NRpAtmr3NWvKRiKoszhcO3XljuwVfwk/BL3Tr1fha5LUIN3Cx2NM/Npb+aR7iyNlHghZj3NEzdTGowD2MtxKz/5Lb8MnW2j3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLypURdbLxditEFIq9HOY0LNi7IudMeHIlF4hDa47No=;
 b=Mv40k1V+qsk0pxeVLC7cujL6nmsNHnaShYcIn8AM5RJyHefud1uSGNrYJtDzGWqKQ+qT4s4QqFfEkiZZDNd7rdbKG6bFhfFuRAr3n0bLBChh07dGR7ELXW9mdQLyjYKbZAa/UqvjHUvSkdsAaPSVdTB7UQkEkN4gIvt/1NPSxp+nTIJnZtSG636CqqcAQYHMhTq/hhOrc9/amDpx65FszmoKE4GBP4uR9bsLe830sZydLKjdPsJ5m65UVJiNthlQZ9xEHLCEnHxZ98DFujT+GOwZXmcdFzJPWEhGHQoSE5eL+CRS2J7VBmpeMbOoSQFtCOA6YFqdofqBTTMGeE0YQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLypURdbLxditEFIq9HOY0LNi7IudMeHIlF4hDa47No=;
 b=IF+363l3LZzLLEXNJ91VwISvHPqMtbtUhzhH4Yv+RnLpIlSePdYj5YPUWxP5fjAppeoVV2Iglqb8eZUcwl109DX8LC7YM2EVBoSQdic8Kw2OpvQHNJirXg1EGkNm3y679UMv/h8G54pnCiEMDOnBdbe9R6Z6Cm15PMaMPfbSVKNJRCPR0c6aZNpzS+MGNGfzi4cgQXZjQUI/PHctYKFl8EV7ykCzDykkf6VDNHCQAURwGgehIy/AtuuDjx66pfvkz7R+PhsVBmQOHicJdCtqCncEqxPmYRtK0HVM820dIgV/aZoU6EJ6wwtqlCTwu2vqC/9HnMgX7QF5fDFnN1h6LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 02:50:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 02:50:11 +0000
Date: Tue, 5 Aug 2025 12:00:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: rockchip_sdhci: Do not test unsigned for being less
 than 0
Message-ID: <20250805040059.GE29103@nxa18884-linux.ap.freescale.net>
References: <20250731-mmc_rockchip-v1-1-74baef656cca@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-mmc_rockchip-v1-1-74baef656cca@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0178.apcprd04.prod.outlook.com
 (2603:1096:4:14::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb081d3-b381-46e5-d525-08ddd3cacbf6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z3/aDHlSUutFTZviqt3iwYV9b1w67vReimcmO0ACXzwfXrEekWUJUsF4YPri?=
 =?us-ascii?Q?hcZPXYkWusJzxH1/irXN4SY1QA4hTl7zHQvYa3ONTmq+B8tXEoWAxeLXMAyC?=
 =?us-ascii?Q?Y4lLyBSh1IltQzuU/GGkxg3OT0+SFHvOSltJrTX98QNZTbjRQSM29qvdWyVh?=
 =?us-ascii?Q?7AlqLa9ffYvo+AB/HJVHIYPOJOFZhPhdv/AEJnwP8h92DhtuvHMed4EmkLZV?=
 =?us-ascii?Q?VJ1OTdqeHQldYmaz/J8D9ykv5rajSqhKm+aDWNamOAzq5Q/L0F3vOPKQgxe0?=
 =?us-ascii?Q?26SpRgQ2ZHM70HSNgSMXUuPbhFeC5YojIck71db24R1rAqiLojEwE5qAcdM5?=
 =?us-ascii?Q?F3nG/lpyyFriLUAp/4QDBuXEduimV76tBPkAOkgoNZYGFldaDrGbFTlNqD0j?=
 =?us-ascii?Q?RWwNhSyy8cOs3hBgMPlfWGsOKmUT+pDxfAf7CojogryaCeZOldcSk28QLByB?=
 =?us-ascii?Q?BuFroTpjx6f+qc8NGZKpBWlg4gXQjl11xa+ZhCoL8oopMYTHrR3iAknw1wUf?=
 =?us-ascii?Q?7fY0Jl/DaiTpuNYpwho6nwOlVTRQlcQdUSKHwFNT5RdO7Qw1swazhkAucP3y?=
 =?us-ascii?Q?nANSAewqhDoj07kTHJOZKNyGnJwag9KwueAJNAEcGEXGbbTVZiMY3fZHuPrH?=
 =?us-ascii?Q?oURw6xCqX1jOLACJTIo2xEXiWfWeg2pZGyy8j7ptfyKjdkP/uiYGprxuDhgw?=
 =?us-ascii?Q?RfiJPp72fonqosVrOhra8SjwRtt+LdjzvGPNI1doEgcsSkXkyh8yq7KCCnkL?=
 =?us-ascii?Q?4zwGdzD3xdiFvp9JEzi4J5vKsEmjNQohORKIWhrnbfqob31l4FqjhVaktR6a?=
 =?us-ascii?Q?NYFhqtNMmzCdP360vc8aV1lE3NZt6QM1+1aWh8fr2GFYJedflWNmPETQTP92?=
 =?us-ascii?Q?L0vNZQxtWq0GkoUU8KiHpQVQhFWx7bnlzqPobU7s5xIdh3y/238ZoUcnKUvz?=
 =?us-ascii?Q?p2S//tfca5SJHBOBxOs7/FPNuCIaWdP+j5XxksuRW9s3+N+hbl6a6ngQq3fu?=
 =?us-ascii?Q?tvAVB7N1h26WpnUZ1s6bptexOkz/Nu84cErLqLlepny2W9JnZwDwYwzEbysb?=
 =?us-ascii?Q?uepT6sz6DYHeE6kp236spx11csMbGxXPaStfoOuAlpufxjtpvNfroCXrsZGG?=
 =?us-ascii?Q?W9sdliOPMybsUNWQj8GA17REbU+g45aoT38J6meELkxmE2XEmZbAOvpYJ3E1?=
 =?us-ascii?Q?sjGWWjwYEI1loTHvY3nHeO2czDtm6G3ZRIfBOr4pDaJuxRKwxQ8X34Fi/98D?=
 =?us-ascii?Q?NEQVVkq8Y2/NCrBQdqRrMLpOq57hwCGIJS8XNNfVKyL+ctlw1d0FRfR/fNDQ?=
 =?us-ascii?Q?8dnB0ee1RHIpucphsG+So6rBC8FOWiC09F6dgTx6KvpU7EMV1rFLj8XSmEss?=
 =?us-ascii?Q?plgZqu3UEnF8pH1D3HEw2610szNjjEKZyXemA7t1pmocnZhUu+IaH+mtO9bk?=
 =?us-ascii?Q?h61dxBtd4vw8mEqKTqlVKS/B94K63ZQA6KCGex7YOuVEz74LCI6a9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kgYeqJXhfAd5tERG4xLZiEygo6AUzs+7JBkPv08zz83awUwekbLkF0HjRlAj?=
 =?us-ascii?Q?I97rRiM+UiOgAvQhpQy6ei9lx09F1BTHy1OdAsBcv2O6rc57SVmEmIrusD9G?=
 =?us-ascii?Q?DbZgO/mm4s1cDC/rzIEpUImOOC9xIPQfOhIdKMNiDp8y8gJ4fwWlVCbKYV5r?=
 =?us-ascii?Q?bOz9uOtHTYuqMAtF0eNbpRMEnKM4BkVLmTvroksujqeIzMRHY6e7afB84JMa?=
 =?us-ascii?Q?HSV8RZU454Xh5X8DD1FCtKQNlrN9Y4Go6DM0Nzox9G52IW7mR/S2SPVocsjC?=
 =?us-ascii?Q?fuElasceOPygehouGaGuTN27qS7eLqLwqkTdYQKkOHGi79JXV9OGvuf350Fb?=
 =?us-ascii?Q?/NTydmT1YjAtWQXbHOJzkXGirks9DG72FOQpEI30UXKaqERObRLap3rivljj?=
 =?us-ascii?Q?WRJepP9mNZ+4vOpNFyD76r+7m9CF+INDPv6MtSx7bIcF2BEXte4elFhTgVAN?=
 =?us-ascii?Q?+FpxJwZEA4NTm/6SxH0PKQDYHEzEGFRzeqrldt+FZS5CaSopsDwxRtkNXIag?=
 =?us-ascii?Q?wskLXbAf/5J2Tey06C2XqJ+KrekZ10PMPgN9js9+fcvWRUfDr7kNg9HICqVB?=
 =?us-ascii?Q?zfzVuOzANwNKErJEbBjqPM+Ye+9w7LLi+e4aE7zgvC0GKAixBPCbTTNUsmJT?=
 =?us-ascii?Q?CtOZqpZByEnURbCpqykcVyN3kXYs3jUqlB4wf9DxakOyETG3XIawMVA04aK0?=
 =?us-ascii?Q?RMWKwefNvnG31QhAn8N3XQiyb9XZKG3Zok54aSh2t+QN+pTucJQodNPsh/ev?=
 =?us-ascii?Q?xsp1O8JHA7Ce+x6NFtH2W5Hk1GPQv2tTlIZQpNqGooi+KkBEALJ2qUTNGtMS?=
 =?us-ascii?Q?3O4QJM8ddaTccv2aiRot5R8A4poX2SeAs/eVEn5ichrRAbJt2QLvDlLNll4O?=
 =?us-ascii?Q?hFnYQ1hvK0AoQzMMRIncF1mJuDqgaqFhA2bPOYHj4esrzDcMMJT+2kGNTXwd?=
 =?us-ascii?Q?vWYVgre44bOqX0ltF8J3r3m9Y1KOda2fnBNW0F4J/tMPgQxJl6q27ni1qBYK?=
 =?us-ascii?Q?3OUR4kgtGJB+gi7/rjSoI2Uz7BPGTpT/fvSJsCW1lCgntfsX3/+RuVY1dhEz?=
 =?us-ascii?Q?zEWt9DJrYi+9N7UppfXmQKdiOzuXnbg15eSeSOETlVQTUXhW02zJEJPqwNr1?=
 =?us-ascii?Q?IZwAlzduUKQC8wXY2wPFGTWwlMyDA23AetqzpofXIMW4CRk+rj7Zg5DKWIjD?=
 =?us-ascii?Q?xztKK16a9mRuJEKJOyXpei3WS6N4T7t1IMPDviHJ/AZTLpfCTCsetShs6PIx?=
 =?us-ascii?Q?q7XyjeAlKICe1XYKNfdYGffdaBYaBZ7NQskSOkT6nqEdAjAceuJFH9gHp7kS?=
 =?us-ascii?Q?LlmFdHx+oafYXNjE25MxvGvIrSBIj3kwwZ3g8J5byr/Cdx87PKvwwr8oLAXZ?=
 =?us-ascii?Q?IScbXQcamhRcBqLFFsZ+JAFkI/6U4O7HwbY84KXUzeeyCK4lqFxA5TURkwcj?=
 =?us-ascii?Q?F/NEby18zA4un1vHe3A7AEWd2aj+uLWfT1iX9xE8fnHkX1E3Pob4bZvCb+Kq?=
 =?us-ascii?Q?VV0XhkLz08DISDpvTghqGJ0ckANu8MBQDwOO/6d3nUCMcmwKgrD1oZwnoeTB?=
 =?us-ascii?Q?pD97EAoeAEmHuAOPgdMa9yequj6V/Bs1cqsF82mZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb081d3-b381-46e5-d525-08ddd3cacbf6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:50:11.7048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVFd3orj5ghfGLfZTpnsQ6jCYAQecxjwrwIJZSSY8jyTLDXyrD0gxM5QUcBwWyLVo/3wBmKrtIh/q4yjX0STrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
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

On Thu, Jul 31, 2025 at 12:46:10PM +0100, Andrew Goodbody wrote:
>In rockchip_sdhci_execute_tuning the variable tuning_loop_counter is
>tested for being less than 0. Ensure that it is a signed type by
>declaring it as s8 instead of char.
>
>This issue was found by Smatch.
>
>Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
