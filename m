Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2B6E9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF6183F2A;
	Mon,  2 Mar 2026 14:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zv9DNXl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0ED483F14; Mon,  2 Mar 2026 07:40:25 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97AC83D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOrIPcPvlULSpjre2u4FXyE3w6U1ucRbG1y/ZDKf5RUBpTrjWaVRlRH1NGanIfH68PgLEGQrv0hE/Tkw1aX2vPXVhmvOFCqRMsa1N5naM4mIc4xvD9QX4KMj+HKkZDF5xBRn/69E53KIEN81bNArdyfTYTTUYKlQRPWQUsy9zHAtjP8f4dhBZv47TNXVwxHwIyc2ojzHZAC8L9nQ7kOWdQSYF/FnqIMmo+Xk/cZv++JECP7YbMBzHw0kIH/0SjFG/aAuVC9Lqkm05Roz9AhLvYDzp517g0KNw45duwjAlQbqE/IMpdPXQvh+YnOVR354Z2T4pyP2G7Q2RogvydcVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwkOgkFgtps3OfZ9eJinFZGW7LremGr2VosMEga1HiQ=;
 b=kafNUDpq2tT0EoUS/dB/ZG9H4mdskDHsKV2j5TVhlPSgr4VqpluaXkOw1m3RuYoPJ9eW2pLBVWomU3pm7DoWsrMAp9c3DfupoW7/ayfFj+mwjKw6UiXYmTUhS+R9CVJ7Tnef4Ebda8XPJ40cLIcR8Ipr1MOEIOPMZKvWsd+Uorcj8RJT4oRZjinZIt2HBdrbBGBP7LZ9Qup6/LGmiDJ9nWV1ZzsWShvRjl81qEeJnOlEqpvNxjwE9m7HaSVeSCiii9ir6x1oAnxyghyrRQ6aSZ9NYCxQDvHOCzakf/F+40V1sjMjwxWbk2ywVHHULE9VsBxJd7VshH8KPtP+ha4Sag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwkOgkFgtps3OfZ9eJinFZGW7LremGr2VosMEga1HiQ=;
 b=Zv9DNXl2PBTde0RkdDufb3ZCXj/b8q7U0REelhJKPsQ1UD41BnwZDF9/DA18v4wA6dz1cthpmZ09g29BFt1VSlpV7u11fSWXL4a0cwKY3BXsiiowahjyRPp1CiM34FXoLHbNOolxusQsh2u1r0YqP+AXCiV5z/2Dcr9EdJHmdeHecl+MQkm+xH5rTZ3ozLDSJ8G0K0yXVMnLeHfIQmuVoVquSijrFaeqddxXup4gGolyf38CePwCN1znpyLXCumzZ6vzbHlkcQntlXP9QPgmQc6fwnjRgjX98Dsk9ZykIKZyozdf7hRe6i+BCqEhhmh1GV/7Uuadv/9XtElp7673KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:40:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:40:19 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v3 00/13] imx: add i.MX952 support
Date: Mon, 02 Mar 2026 13:20:01 +0800
Message-Id: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEepWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMj3czcCktTI11Ts1RzQ+PkRDOzVGMloOKCotS0zAqwQdFKZcZKsbW
 1AGAtyNxcAAAA
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: ce146781-e190-4acf-1cd0-08de78269234
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: SYZhUFrsstK2iA8NToT0/EkQY6qVeWINu5DGyml/BwYr0A1GJgNJBp9HQZcCXnqa1/DVLp4lYm4bN80Hhs3hwTc8RT77BkSGkLhq3x6BISAx9hss/PNfN9uUSKibvd2PgwLIVvTD8hGWATgrAaqhJYMKKPxEtaW3E+nk3T9RNCuxPAGc1fUTmxWljBxnZyAEjJ8YIbh0uSIwvuHUg6GzQwcLTs0sE3T18BbY/fkm4SdaeaKmlN3L7DnU3TkHYOw57BvaHDDtWKAYzRAfNbNtNrrALrP2d9WtoJ+JOtDCZUzR5oPYdntLZ21Xb/SMNFQsoPFiVckO/SMTZ82n/zzmsNoYNmEbrC6sdcW6kZp4B2RmoIlaK4ZtkFnw2kOxtJun2x/cnucZm1pH7Q8BR/xTpLTqbuhkrSM3S93YC5LMOHJln94kkQf2jcFIb1QDv/s0n0rdy8a7iU1Ace+c86KHXEyLVB1jHyk/atm6aGhhKC/d88eiCZpQeZoLTGaXGQzcTpnHkw1pVcDBLZpPxu2o5pGOko3wSrIQVZYn5MaKWZONwJ76QTLRDZdFugyhYteO/YOGQLcj/7zh9li7NSoyKeuMD/uwGH+Ff64vrCZbi79YJl4fwfRu+UApKU5ZlYKHJkxouvaPSd8ucUkp5Xuaen2sOTq+oj5Kfz1mvccuIcjRDr2Nx/+Xig0bTGGyCNWUMqQrRVW92WE3boOSEE0/Az8STHPl9mb87Xp/ab7SzB/IFaxxNpt0Jiwu+NX5u297td9DDdNCqFnLK7Oua9k6cMXROzarz3gOjVhEmuNP8aQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUlmY0tuZTdLZGRBQzg5ZTFOcjdtcHN6UW9NZW9RVi8zZUZoaTZ1YWFJa0kx?=
 =?utf-8?B?SUFjRzloRmlzaUdXRnpIOUFJaW1FMTdKZGh5bU81cEoxWGx2WnVjRDhkYXBU?=
 =?utf-8?B?MlQwL2k4bmMvR1ZOeVloQlVacisvUFc0U0hQUUIxTjNVUG9ldFpOQ0FYdTNr?=
 =?utf-8?B?UllFZlNuSFpKajRYQTRjNmVhL0hudWJKdjBuK3JUNTB3YXo0bXUyakNtbWJy?=
 =?utf-8?B?aUZ6eXBhRFBuRFdYcGYrRUNGWUQ0RTNwMEVFU0MvTlNvbWdlMUtEWnVWZ3Jm?=
 =?utf-8?B?c0IxbUt2ODZvcTZYU0dxYWtqdm1WMy8wKzlEdy9rVnloeFBtM1E5a0JVVVRh?=
 =?utf-8?B?RXJmaDJRZ1d0a1JFM0pVN2ZlbGdLL3hPMjRPSFp5NC95bjlwQWJpSEE2N01T?=
 =?utf-8?B?MWhQalR4UFhneUxEN0VieE11TkRKdjB2NXRrTmIrenk4SzhXOSs5UENReGNo?=
 =?utf-8?B?YWNWaFVUWWxONnZqMnVLRnRsSDFIU3RqdDB4VGlVSXRGME0rRzhuYURsQ0dq?=
 =?utf-8?B?MGlyMHlHcnRWUDU0SnBKNHZ5QVhuQWx5dXlucjMzMFJGSFJzNHdFU2lTWTNF?=
 =?utf-8?B?SWZXZzJVK1IvVGhzZUROdjZ6U3JxTGVjYXl0bUVpNzJDNXpuTXcvZVp0aTQr?=
 =?utf-8?B?a1RpdVN1NndPVWJadXFIbVpHeiszZ0JEaE9mR3NPd3JrWFdmbWV4OWRzeGxU?=
 =?utf-8?B?Wm8zRDlndyt4eWFmVzJsREpwcUljYUZzbmZlVTdYbGkyYldqM2o3TEhrMERV?=
 =?utf-8?B?MGoxaUxmZW5vSHpaQldGZUJVM1RhcU5iS29OOWRySW1iWHJ2S0ZmSGovckVU?=
 =?utf-8?B?L1ZjZ0JISkNNWTh4SjFMWFZsdHdYU1pnRUJKcVZsZElVU3FwVVIxVHNZYzls?=
 =?utf-8?B?WGJ2ZlIzQXJaQmYxSUgwUFYvZlJLV0tTc2tsNFhLS2pzVTR6THdXMnJLbnhD?=
 =?utf-8?B?MW42QitmNmo1cUE5YmxMd3p0UEE5Zm53dkpob1kxN3UxTVJ1M3BkUW1WOUpy?=
 =?utf-8?B?WldjTjBtSVV2UmQvMGFqRXFIajRTTGRzcjYrVXQ1T3JoZzdTV2ttVGVTQzV4?=
 =?utf-8?B?c1Y3OW5rbUVTcGFOWStMNDhTNEJxSjR5ZlNsNmZWa3ZKZjRGM0R3cFNJOExY?=
 =?utf-8?B?UEw5ZVI5SGljRHJPVkVGZUFra1pZVjYvTG9DRTJYUmlnUjMvdFpDcm1pZ1pu?=
 =?utf-8?B?ajMvRi84UEtBcGpuWWkwYlpoQVhZZnNlK0VkM3YvM3Zybzk2Y25CUEwzSFdp?=
 =?utf-8?B?TmhNQ1JMZHh4Z1VFZTlndGE2bFkxd0JsTmg3eTNyWmdnWlAzeTBZQ3ZwNXJt?=
 =?utf-8?B?SERNcVJMWWVRdzM3aWtLYTU3TktlYkVXUWIvZTFQRDFKQ0wrUGw1Y2liLyt0?=
 =?utf-8?B?S296OXFaYlRvMG1jM2VSUTRtdmZsbHc3dk93NnBEYzBaTjBpYTcxZ2RSQTdw?=
 =?utf-8?B?K3o2MlZ5TmdjajJjRjVLVVZTUExSSmJ4R3FOaXErdTNGWlVoRXEzeExuZnB1?=
 =?utf-8?B?VDVtSzUyOUs4K2QyaTRyd1VsdXFLa3VOSmxKZUR2SG9UZE9nRHV4cFNRYW1s?=
 =?utf-8?B?U2NRaWtUekpzT0pDNnFRNmwvaDBmNW5rNEY4bThZdEdKL3luYWlYQ1Y4TkU3?=
 =?utf-8?B?S3pieUVQNldhWmFCTUgwdkk5Q1V5aE15TVN5QVhrbDhVWEIrSmI3Ylg5SnpI?=
 =?utf-8?B?WlQybzFaRnl0OGdZcDR3amdwMm1ySlhZbkg1NmZ1TVJudXBXaytmVVNaYUZs?=
 =?utf-8?B?OGVkUTZMQzdjMkZtN1dUZ1RJM3RxZ3hMUHNqWkI2cU9HQTdHTUFzWFkwVUNT?=
 =?utf-8?B?N2U5WjVwYW9UdUF3OFJKNFdHSFUyNGlWRm5TY2t1Yjl2V1NqSU1idGZ1SWNl?=
 =?utf-8?B?YmpRWXY4MHZoOFgrUEJXK3Rza2JIR2huM3FYWThjbnJ3eDdhWVBEWURrVzhW?=
 =?utf-8?B?MlNyT0xuWGFzaCtaTVE2QU9PcVg5TUVsb1R6OTB4T1N2SW9Rb2VSZEJLWUtx?=
 =?utf-8?B?Z1RWZ2daN05oZjZjR3FwSFBPMHUxVjFKQ0d4dGtib0d4VXJLdTVpRGhOQkNM?=
 =?utf-8?B?T3Jwc1RCSkZRM3JqU2JKNDRDMEp4TjVKY096aURzSmhibi9SRVZVSXUveXo3?=
 =?utf-8?B?YmhpbE1yVjR0R3VKUlBlT1F0MW14SkFGRTUwOGp3ZEk4dU9xcXBacVdiYmxr?=
 =?utf-8?B?VDQ2U2RUZlcyeU9MMExaWnlWTGZmSnNTaS9YS2xzY1dtL3hZWUY1WkEzQ0hw?=
 =?utf-8?B?aFYrZUMwTC96MXNMaTFsVU81bFZZczdGQXJUZWJhK2toNFhvNzdPeXo4M3hF?=
 =?utf-8?B?c1lJakFIQm5kTXozdUIwVFcvb3FYdnhRUk9XK1VRdVZlRGFXUFh4Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce146781-e190-4acf-1cd0-08de78269234
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:40:19.4579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jdmi7OUX7E174WHHVbU/xglblvwbJrSQTcjXTmdkQ+61+JK7pMTNJQsFezb09GNgKfRGL2kMv/qz0AWHDKA9yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

Changes for v2:
- Add comments to explain the fields of scmi_ddr_info_out structure.
- memset(out, 0, sizeof(*out)) in scmi_misc_ddrinfo() is done by the
  caller.
- Refine the commit log for patch 1.
- Delete the watchdog base address definition, as i.MX952 doesn't reset
  the via watchdog.
- Use /tools/update-subtree.sh to sync i.MX952 device tree files from
  Linux.
- Cleanup patch 12.

Changes for v3:
- Modify the commit log of patch 1.
- Update the commit log of patch 9 to clarify the patch.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (7):
      arm: imx: Add i.MX952 CPU type support
      imx: ele_ahab: Add i.MX952 support to display_life_cycle()
      imx: container: Add i.MX952 support to get_imageset_end()
      arm: imx9: Add i.MX952 SoC support
      cpu: imx952: Add i.MX952 support
      arm: imx9: Keep WDG3/WDG4 untouched for i.MX952
      arm: dts: Add U-Boot device tree for i.MX952 EVK

Peng Fan (3):
      arm64: dts: freescale: Add initial device tree for i.MX952
      arm64: dts: freescale: Add i.MX952 EVK basic device tree
      board: nxp: imx952_evk: Add i.MX952 15x15 lpddr4x board support

Ye Li (3):
      imx9: scmi: Get DDR size through SM SCMI API
      imx95/imx94: Remove board_phys_sdram_size from each board
      pinctrl: nxp: Add i.MX952 support

 arch/arm/dts/imx952-evk-u-boot.dtsi               |   10 +
 arch/arm/dts/imx952-u-boot.dtsi                   |  290 +++++
 arch/arm/include/asm/arch-imx/cpu.h               |    1 +
 arch/arm/include/asm/mach-imx/sys_proto.h         |   38 +
 arch/arm/mach-imx/Makefile                        |    2 +-
 arch/arm/mach-imx/ele_ahab.c                      |    2 +-
 arch/arm/mach-imx/image-container.c               |    4 +-
 arch/arm/mach-imx/imx9/Kconfig                    |   21 +
 arch/arm/mach-imx/imx9/scmi/common.h              |   10 +
 arch/arm/mach-imx/imx9/scmi/soc.c                 |   81 +-
 board/nxp/imx94_evk/imx94_evk.c                   |    7 -
 board/nxp/imx952_evk/Kconfig                      |   12 +
 board/nxp/imx952_evk/MAINTAINERS                  |    6 +
 board/nxp/imx952_evk/Makefile                     |   14 +
 board/nxp/imx952_evk/imx952_evk.c                 |   26 +
 board/nxp/imx952_evk/imx952_evk.env               |  137 +++
 board/nxp/imx952_evk/spl.c                        |  113 ++
 board/nxp/imx95_evk/imx95_evk.c                   |    7 -
 configs/imx952_evk_defconfig                      |  175 +++
 doc/board/nxp/imx952_evk.rst                      |  112 ++
 doc/board/nxp/index.rst                           |    1 +
 drivers/cpu/imx8_cpu.c                            |    2 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c            |    6 +-
 dts/upstream/src/arm64/freescale/imx952-clock.h   |  215 ++++
 dts/upstream/src/arm64/freescale/imx952-evk.dts   |  217 ++++
 dts/upstream/src/arm64/freescale/imx952-pinfunc.h |  867 ++++++++++++++
 dts/upstream/src/arm64/freescale/imx952-power.h   |   44 +
 dts/upstream/src/arm64/freescale/imx952.dtsi      | 1248 +++++++++++++++++++++
 include/configs/imx952_evk.h                      |   25 +
 include/scmi_protocols.h                          |    3 +-
 30 files changed, 3661 insertions(+), 35 deletions(-)
---
base-commit: 437ea9f8be5afaebe2d8cbab6242f1182857f21e
change-id: 20260302-imx952-56e713ca66e3

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

