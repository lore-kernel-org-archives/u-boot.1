Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95346C98315
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 15:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A2183015;
	Sat, 17 Jan 2026 16:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="uwVJ1DH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EA58367F; Sat, 17 Jan 2026 16:33:57 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8972982BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 16:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJBuVGxYMnCzq/VFTggQbqCwIxS+Y4hFjoQVKrQxfgr7xqXxGSVh823F52SZ/1NsKTd+outUvVp/bMDnHepp/nIxvlTtQyq78rziPVtJ+oW3rIBCBSUGrWrziTbPoX3u6u8zfaKtWf/B1trr+URezbrXe3RM56/6yGHPiOk8L3K8xyx6+5rSfvMmXIKaJ+7aWSRsEqA7dcuNS2G5oSV/oRf0H1cdQ7qpEKDaQdcjZ6RT69NzoE5Fiqv4QJ4+ugN7I0RRFHtuKFaPbCiuFs/zF/8+HEUNByKew3N90jzlRJX1ZzfvBZyPNhLVaMfXKO0QG0JP0iXKG2mb0VyWn5FY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV4EdxJhqquCknk4zSNeQJC9+TWketWAKZ6IbLgJx1Y=;
 b=Z0KIDbFDFOXJomfakdlseVyXfYm5mWPsIEUz2bV/empXmrgTKQ6WeSyG2wJLQfqjfT/Hs+ZOJ99rvJkFZyGkhux//Rj7JOq7pxDvGuW2KQqqKk8+kaznaaZ8g/4iefdwJRMzfstNnD5aKBjfMhqsRusdRY9s68V9XMWVgglQYT+xWBFltmsnJveefz1lCZPRqHXA7gK6euaW4gx5J5WjHgeZ5EG7wJbix2on0OIKoIuTfp3ofahzEOkONZOQRQ6K13RhUDy175/Nsz9zWZ0gTtFcHO8skgAo5w5HDqjx00WzrdMAxWhZ9HwBatknsIn7eeU1PaBzHnx6FeDywwZ0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV4EdxJhqquCknk4zSNeQJC9+TWketWAKZ6IbLgJx1Y=;
 b=uwVJ1DH66ZQ56cnK533ENKGCzTkTXGKSaSt5a2O9e8BtCGtep6ZA+uAy/i0jhv52kBjhzWlEGf1W4QRV2dvKpK7rRzbV2Wzyw6Wo1nFJbnx2Y6nFKRXtw1bzzXbYx58qWJso4h8vPqOE8mWTEr/RYVydtgRnANTKQ5S2Nh+129cTPsX79H3/mXudstA2qAHUEOL+1ZqrpOh83L0A73Z6T1cp62RvXM3NZIOJQoJeEzNR5hSR+VYnHBW2HVB37PycH9VpJd+V3MY5VhWXWJx/XbggIH872Y6iWzis6GWZXkiAboQ3VzjjcPP4QSFtouYf8aG3No8PlA+KdXPNz3atJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS4PR08MB7508.eurprd08.prod.outlook.com (2603:10a6:20b:4fa::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Sat, 17 Jan
 2026 15:33:51 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.003; Sat, 17 Jan 2026
 15:33:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: ansuelsmth@gmail.com, trini@konsulko.com, u-boot@lists.denx.de,
 Ray Liu <ray.xy.liu@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: Re: [PATCH] arm: dts: an7581: set r_smpl for MMC in U-Boot
Date: Sat, 17 Jan 2026 18:33:42 +0300
Message-ID: <20260117153342.483307-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102132500.5794-1-ray.xy.liu@gmail.com>
References: <20260102132500.5794-1-ray.xy.liu@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0038.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS4PR08MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: fd89a81d-b833-4a54-473e-08de55ddd0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7Quew8Mu0/et1bYZzu5tuoj/GNpE2kzwcDQ3y9vgF7XkhJ8bkcTAH5UX904c?=
 =?us-ascii?Q?FN0FOsGiyLRSVySUYHdzTRdUIs9As+lZ+H2mk/mi16o3vp2onSnO6W+pOkjs?=
 =?us-ascii?Q?ed72NGOYeORkcaQw4VPdOl4vhJlj4Mko4/PVgaorVCy6OyWMzOPMPLAM1NP1?=
 =?us-ascii?Q?nJy01n38HyhK7TRo3JyjY+KrgfZdT6tztYXxiJgmZ//EC13HZB2Zlav+IpSe?=
 =?us-ascii?Q?om2V5qVd2vvr6Oh4IAdi4aQhAGDSGQvct3JpAWQ+7HyDZBvACoODNo+XCyYF?=
 =?us-ascii?Q?AH4VEGfH/YYBAIQk2Vj/nE1UzCGrMpPSHxp1jacPo9miHmv4sSCfaSzw8nTd?=
 =?us-ascii?Q?RYJoBtbdlfD/7BHzdxEFDClMELF4zOEdQPYPZoYxrmclKWw0EODc2i8zkpsu?=
 =?us-ascii?Q?YD0AJPC3fp01viz85lftxzd4TwZAnI3P22H6zw0Yt1XsiOcInyGx+EJzBk/8?=
 =?us-ascii?Q?8iNWo5ir2l15a3XgPn0xzhyULpMlDdxhcReUl8byzxWEzYFwWKdJ1tsOtSOL?=
 =?us-ascii?Q?Cmm8pssk/Yri90a2ei6Q+LnBSqJnqTR3PBRoOEGe0LWzvPmZilsyXCZf1Lkh?=
 =?us-ascii?Q?llVGhxW+WgeXOyEr4kbDhaqGO6ee8go0dKwYXb4Oac/us0jpphxckIy+w7Hs?=
 =?us-ascii?Q?Z2SnUjA00pAfvk165jZHQC/PfwSI0Q+4i99/JULxtJHOzRgAUrgJ1qy5HoMT?=
 =?us-ascii?Q?AxEtWdIJhi/3x3wWbBm15JRH6V/IhpVYDxiiDu0E8EIzHgjD6f/kPkOxCfyt?=
 =?us-ascii?Q?VWdz5Wh1ooqvli9rw+TbcNuKu1Got2eBPbuMMXonvSc1ipGOJS4gaKOJTnLH?=
 =?us-ascii?Q?wH7awZYmympNK4EaRMmPSWELodAXWB3GAV+2Yvkdms5Oi48J59ZCCSi0MDEd?=
 =?us-ascii?Q?d+4BRnpSk5VYgpbqKbzlkWMh9+/Rd6vNdc5Sx1oYp5cz0YlGpGYXi5G27QIT?=
 =?us-ascii?Q?mw9dGr/IN9TJdIi4x9OoldrbvbJHvYPDmNGYn7+S8ESiJEvLo9DgtZP4XF4D?=
 =?us-ascii?Q?8HPjp9XpKraS4DfKn8qWFgOO7PdX5Q+2URIslS3meiCyEIa4Y1dYHcaB+6cj?=
 =?us-ascii?Q?544fGef8MG5mex46MPDbEVfukLbTRz8waQJSWrKbdPSr85ULI3HWvZ12q/Lu?=
 =?us-ascii?Q?w5ZX7h6u4ymA1z00olDT+J2O1gvvdP0oSXEFVDVA4HUZAGduX/bHZxvoXX6n?=
 =?us-ascii?Q?tPFUk+ryRn36lnkZV8Wfr4mcnHMrP5rcHi6JMKSSb0Z+V0eLgkQYCOok+LBn?=
 =?us-ascii?Q?bqtkfZB9XIjZWaS7e+IxzgJ7uqsj2HlmInM+pAHRd5GITUF/lVvhSIixHJdP?=
 =?us-ascii?Q?zRcWajlBWW0Faan+qjPYtDS4zyxA8loE936pbPfD7s4DrsBHe5srbF5WjPYd?=
 =?us-ascii?Q?Wbsx21x+J1MnmvG0tM+31KGUQoq7ehjk9vGuaIBr5gsTXll/6wzEHtK/AVtk?=
 =?us-ascii?Q?OYs3wfwrf9HHqxYsMuSFjOf1uAyqRDrZZJhnvbxljjhOSCEGTbKCxDNz5JsL?=
 =?us-ascii?Q?/KUKAw1fFL0T2XZKUQwxBTrm8QwRezFQaV9430m9UiDHPNYGBAlW8NxpXwWN?=
 =?us-ascii?Q?+kaXH9fwI3neJeQoV3R/oRslwDVY0hj4BWND4Oi1NTQxJkf4e574g/+wcU1w?=
 =?us-ascii?Q?cimXVUFNmXesH7+Nt25/FOk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCHdSDvwUb8uzB2BPXDDSCH/qAqC5IEuyxTilByOtwfl1b9NiSbqdh9PF5ES?=
 =?us-ascii?Q?CljN9PrpjQnOs0ir6m9tWQvgZKREtNgaiCKi6yC+KxPjMUvXJyDMzhkhI0TQ?=
 =?us-ascii?Q?WIkzS1ULwBmhDQDnGiU9MOc6LwIz0KxDQ2B/mjqInMoFWa4RozRQhMBClfnx?=
 =?us-ascii?Q?r0XVw9/GcttpXJBO/EOqkjEWVAoVwd3QrhPErbCuM2Yu1J8nmULTqzHDavjb?=
 =?us-ascii?Q?n5rnwv1vuj322hX6iRebr+6rqqBFkhfWJlpn8sGKRAQHz6JW1sIEUY1vMqYd?=
 =?us-ascii?Q?mmspqXGxmgpjkjk/CjKVIdWwCiHFocKAqOCb2K6bQMpP0tS28FHjfGhTTbmr?=
 =?us-ascii?Q?ZXJbLy0J9LbNL5R4wmHYntrf7gmK62TlCOhBtQCtlhgbIvE8619VFAeUuGcu?=
 =?us-ascii?Q?3YY1JTDKLL8q62m3pwfcasQ0q0Hsnd8nTscFwBN2Wc9UN4LHLVZ8J3kgMDCb?=
 =?us-ascii?Q?nb1Daden+vxej+aa7+vl658APRMXM/9kBDaO7Zo/uWLKkizicEVlgJbW7VRp?=
 =?us-ascii?Q?X8w1Qxiit4tu6GUHeHXnMlHU/1sykISji8cuSmfAXnaTAHVLxMW+7XHSAhXr?=
 =?us-ascii?Q?QN3//76hTP7Koj7rTiMVBJ78uJ9k8Tkfe1jwtjd4nsuqQkwblU0GeHLIYeSw?=
 =?us-ascii?Q?W1D5yqdlIND2Flwjo+Ieilm7zSqo4SFeiRG8bS0zXvA45K3afcG0AVCdNa30?=
 =?us-ascii?Q?CbVbAxHYPUqvrHqTjO6wkRvwHN9qHbZnNVmIH0q+PnatjK/w8O8LoZESakbt?=
 =?us-ascii?Q?xrnXVpO6OYp+aQ+d/eInJGnl1ZF3Y3BoRfaySv+dcnhTORGdepzMN5yyWF0N?=
 =?us-ascii?Q?McGoM83xWbaHJwknCBQeW0T2qQIjNAuGrFQ7wsU2yxlxQnDUfPe1FRlHJM0w?=
 =?us-ascii?Q?IDx0u/3avuHhdXpYceqTAkf/oQEx9nu9GbsWjfKMZAg/s7APmJ8P4uEQjbiq?=
 =?us-ascii?Q?bnNMtzq4RSX0H+gowCIcl+fFB3sP80prso/URF+DGuWq39EN87oL/n/OJEvz?=
 =?us-ascii?Q?FwTUXOeBWO5GHnsR2dRcEiS6DzpD20VIWJeAQALFo1yYTy2Vvxvpzh2s5io4?=
 =?us-ascii?Q?/UFNXxXCGtEUNeHzFUNusZNRiW7qpK0yW+aHAVaCf5rveDOv4GWC/1aBRY5C?=
 =?us-ascii?Q?HJdR4QRvh/V9h/NTOr3/VsvdIhfgdlW6k+5yuvfiBAVgO7qXSekTz0teYwfn?=
 =?us-ascii?Q?yqDRzS1ayNd+EvmNF5924PEhlBcSQ1xsVJTIgJaB2Kebot1SLaopmvIhhtCq?=
 =?us-ascii?Q?XRsTlOzTd4mm/C9lxsNEhYUHEtnhOhSzSrHNeV7sGqrwMNwFLpEj0nid9ZHM?=
 =?us-ascii?Q?XN0Ap/v7lZzmIjSMBjMjswTCwhc43kfwLpldUi1CT+jXpTPhCebZF1YFGZIR?=
 =?us-ascii?Q?83L4WgKIl8yRauR4aFElsgwHaBwm0d23F6tDUTeAcIt5QImrTCG3nIQwqfJG?=
 =?us-ascii?Q?dRiPzVRc6t34ScZnwFNR5P+s1KqgSSHJaA5CR9CZri/LpyIbicOuTGl4ydS4?=
 =?us-ascii?Q?imuP35/pJ3wC4QhXvxBeqK00K7vxtcCS/Ura6ezZWtRWxh0YQ6cfGkpneqHk?=
 =?us-ascii?Q?GecoLrHn8ne6zELAQvtrd4dXKqW+b+a7xobOJEFTFGwyBuieuIJ3S51Q+lIB?=
 =?us-ascii?Q?c04/IkdOebQnDqtl06AlkNeNg3BZrPVudOYAJge5wPpTPBYQgW3m6JHCWGIH?=
 =?us-ascii?Q?xP3KEDWVBZ+E2RhVEA9LVvVldfx4YYeGEO53x85dfiJv+90JDoHQLZPC9StV?=
 =?us-ascii?Q?Ew8B9X/3LbHMqzVqSOoog5IayaBgdjk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fd89a81d-b833-4a54-473e-08de55ddd0cb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 15:33:51.6177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tC/3SVuKx+cK4m8qWTO/cJdNju28nawuq+xHprp66Ecrkvz/UQvurpQ8hpSvQ5gw7GiECKPSdz+pfllI2tidyIDKl7ACunldHSGfWoAMTMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7508
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

> 			reg = <0x0 0x1fa0e000 0x0 0x1000>,
> 				<0x0 0x1fa0c000 0x0 0x60>;
> 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>+			r_smpl = <1>;
> 			clocks = <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
> 			clock-names = "source", "hclk";
> 			bus-width = <4>;

On my AN7581 board, the same change in the ATF-2.10 source code causes
instability in eMMC reading. After the patch, in about 9 of 10 cases, ATF
is unable to read the FIP image and load BL31 and U-Boot.

So, I am vote for reverting this change.

Regards,
Mikhail Kshevetskiy
