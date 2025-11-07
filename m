Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E24CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F073F83CE3;
	Fri,  7 Nov 2025 05:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kzRaqDX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB23683C60; Fri,  7 Nov 2025 03:20:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A241683C40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqdoJkd+JPUBVZ77KMbjB6+ZeQpdJ0L/Gk3psMGvI2FrIYiY2i+cf+9CIPlrVZ4qRSuAc1H9T5XjOFm/jtcGuO2z8wyXBqakoweHa3U+HQ2OHTR8/mkzRkWABZlxzKia+TQjtyPAbo5XF46vS+c+8RGSzs8cxwlPE4pm8/ky7VCM74Jk/eK+8htCeGb+AU68Q4qALp2UuWQakYnGKsCUjE+5uQX86IE5VQcbYLhpIzbDFB8oVgm5eNyw5vRlUcG4HXALdnv8lcpFJAXGJJqkq9IMP5mN/VOUQ3YyY7t6sYlQnihATnUNDLjLtmSffKsE2VECjELTub68YUJBGaLuew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Koq78Tj/v3HTkQ8L+Fn2a3sMK23A9m1+mMwbF5/7FIQ=;
 b=BEiW73lmK5ZXbij7zJCR0Ovw6ES63SS52sWrRNLedCrytxF+naThZ+1L3//Ohw/KCfeWfmMmk5P2NuCiliwnCI2IT8WbG2BlaQj+OAtTOiqeUrGCOXfVudx4NjKcjRceMssLJZICQ/85TSnX1zpFk/HEQdfV5gIh/Ri6XqfDQum2QjUnJASXB6IMXp+7Dttlus6aajqs4lmZ/AduZVUDV+ceVVYGm/eY2Iq3vXtCVrYYru6FpjQ4O/b+W+v148JUVXiFoJr5Hi6j/32ijk9/VPCQyWw/nqoysfReXJZ8pKzZzeYUX0M/2Z+LzqHGSU5QzD+VQ1087TfX0GHegtp1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Koq78Tj/v3HTkQ8L+Fn2a3sMK23A9m1+mMwbF5/7FIQ=;
 b=kzRaqDX3jrdVIWAxijKIawSQB5iaqw2au68jUq+CmnpGYjnuZJlnEJbtk9R7Qefwhqv7YeG15AAqwOYm71myJcz1r89CCiNcHR3XQR60WVgisPwrAtk2fOrwfbl9wucPxpNtz/xITe38iOCC8uBg0B8xLneyDjatwNl1615VnytMuV53g8sSE3RIVGCtuF2S/dvDE5pdoEA+XuMJdfOl3sM0ysgjKLXpOmANpODFhn8/tfv5IikLNvU6AfV1K4tpaRTgBz9GnL5pBNy4p2DpJMIxl2j1+g8rtk9ctDKkwrHvhD45EfuQQGwgW95Id3Xmc/jI+aGMJV1qIPj16utvUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11018.eurprd04.prod.outlook.com (2603:10a6:150:224::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:20:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:20:09 +0000
Date: Fri, 7 Nov 2025 11:32:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Maxim Kochetkov <fido_max@inbox.ru>, d-gole@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/2] clk: scmi: fix set_parent support when CCF is not
 being used
Message-ID: <aQ1oW1S-pKvaYwKc@nxa18884-linux>
References: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
 <20251104-b4-scmi-v1-v4-1-51f101a6f8c3@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-b4-scmi-v1-v4-1-51f101a6f8c3@ti.com>
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b934aa6-0d0d-4086-fe72-08de1da42c80
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OutxYmSOB/650DcLc52ox4Sq+79itVXy/tvdogSBmgQERwH6cA4asst796sL?=
 =?us-ascii?Q?fUYVH1ACl09S2fZcIrazBUjnM7u1vEQsItOX+P2ckryHU8h39ncB+l8Tpf//?=
 =?us-ascii?Q?hv2zl612oI+89ZzDgMiswgr7d5b2F6ap6btrkSdmUDU5GGpJXERufyn8LMza?=
 =?us-ascii?Q?xLBj6SoXw5m2eINVGz81YzfeAtyupYP3lvrx/jQ5p++4DNG1UAUhbrnnMOer?=
 =?us-ascii?Q?joNdiQHG7yYf64ex6CU/paRvJxWKKDUDFVtEMjAFcVpYFinKFgigirLOlW3B?=
 =?us-ascii?Q?oyN6kU7S6FrzE2lFFD3srHcqOBtFrgixPkzsqAVWuKrGAxIjzB1Wakkw0Our?=
 =?us-ascii?Q?V6C+IkKD03zAWG2NJbICyD6mvuR9G2cmJ+Wct5t3GcGslD0KVUHfrW4fvWLq?=
 =?us-ascii?Q?5afuDIlxRuNi77RQpd99M8uqgKD09ba+XTkgPfrwJRsgA4zSEs0wodV2WpE9?=
 =?us-ascii?Q?mSOcQRhW4w+cOLu6X49BkPG9DQJ3bf1DTm9ZT8u5tJpjZaX+f3YgCkBKCcVN?=
 =?us-ascii?Q?qFo43j1yIiBaZarM1stwLcahuqIsggXkJeBCeIU+dlmq46pIiRs4SGlxyPX8?=
 =?us-ascii?Q?cnTHVMwPeltdJFb2YO7rfIh8ADHTIdZ0Oi15cPA0NYz0GRmeYcBYhGO+LNz8?=
 =?us-ascii?Q?RdBgvFChhbMPXZJXpx6tEUBbLlXqTh5IvyCs6DXqPAFNpe0vY/0riS1Ip74e?=
 =?us-ascii?Q?wRpv8TbnFukDwnQOQwx+Ttw9zVdxeEy7VoPcHzELSBR8iFSzLacDQYJ1Y60S?=
 =?us-ascii?Q?B3WbdZuKLCPYOxQL7DPsZAJcMAHNK20uZkeQN3FZCBLZpbK+gxPmqtD4UnSz?=
 =?us-ascii?Q?ey3QofzIZKWs2oP/sHnu4B8rcNEVjicZnFaTo7BdnotdmpSApjg9qCh6D8X0?=
 =?us-ascii?Q?EEPnwB8TbPy6206yKngfPxGC38+ohtKHnPQLq6S7Hn08G7eoHpFOjFo5x7VQ?=
 =?us-ascii?Q?YbKmS6rkuBxtmXe38y76lz+Q6dDkzV/oeybpez2Xei1kGX2PF8KYv/XVWj1o?=
 =?us-ascii?Q?Xq+6NQmTIBYRnd6BSGu9SjiWXN0uxJGGBp0QfDaJ2hg/G/LNgoSMD83hB9d5?=
 =?us-ascii?Q?GhAGTmx0Ovjh31dZHhWm0i3xuSrEDmINewMZ91m1rNeCx0ohCnLypbJFFgnO?=
 =?us-ascii?Q?Z0R+2J60atzS7joPWavB40sooGNwy7C+y/kRoUcCFQ0Gz3DcL/VE694HwttU?=
 =?us-ascii?Q?GpJfDY2FAOG0g0AqHBigz8M7+FEB6+ODhf2J3iMBFIfgyzkxRzKVVkiCIpdc?=
 =?us-ascii?Q?Z9G90sR+Hzazft0YD8yLWcuT5AIFtCpDrIwVNgV1mLestTv57g+eqrtjzXxV?=
 =?us-ascii?Q?wEnScC/sL85bup+6Xt/sO39Zmxq9VkUibRywxV8Tvx/C9uumbEqTyjac20XB?=
 =?us-ascii?Q?5HDXWbr9kERNfUQei5GCVkrjwx/onwxElr4n1XrhYYLmEYOAYeEEEokSSDEU?=
 =?us-ascii?Q?zhGvbyvK3sZ5uz79y4SeV06ta57CgNofm6x5lYcUioqRclHO38dKLSGcF+N/?=
 =?us-ascii?Q?7Hi1skQOEl1ek882P09cbV/E3JgiCh7ckaMi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5sgZKRHdWNrSZEV1uTLHHGyHbef+TYHqiRcTLPuJY0osWxQRMfiHXF/5HgPt?=
 =?us-ascii?Q?HoxjL7EdJvGO8WMAkm6wPFgFW3sB0LlD1aTXId5cM5agmUaIJIV0kFIOci5I?=
 =?us-ascii?Q?DyTrFH2gQoG970fa0uIcL1mW7NRN0N1VT/2ktNz2VvP3wKShj53x9PpgZG7G?=
 =?us-ascii?Q?QY43yx+uHuRszpS+nXANaF4kmdbXSZZEZCrAP5fEIe5uCRe1FAZMyM3NIQMm?=
 =?us-ascii?Q?/80bL840hu+9IrF7WYAHwq6MbHUDWcxpenQHTdiJ7/H9CdnhUNLlLVaFTwSZ?=
 =?us-ascii?Q?EZdpzFRvmYd3aUp7M6c0z9tmihWxN4FUd0bfe7MRYYL0vpzvikYL1oh1Xosy?=
 =?us-ascii?Q?BgRaeegvD8TYy02uEWQ29mqHsfUUL6FJZ5+/R6IF5ptQ0JVCkHnbx74jmKhE?=
 =?us-ascii?Q?HgG+rxCPu0JUFLARVsCWySaBWmVK41XAYBlBg14zzVwImphwOrTLaO6CbuoQ?=
 =?us-ascii?Q?7uS8yDWBtIsrSTbf5frRbfhr0Yh9eRObll68u+GLtd03OIZ/Cpr47F2DmJNn?=
 =?us-ascii?Q?igdyJ5ThbozuwM3HlZjqS19LMdgvemdP34lHecSanmAfX/rrWenawr1MrYji?=
 =?us-ascii?Q?DWKMbr70p9jveHn/Up4O03FrfOWjZ7LjEk4myCEaIYh+VnRCYzgZ4q+43TxH?=
 =?us-ascii?Q?D0fmWNmx8bQEAGE4c7Vzz8oPJBF/TkZAPfA9tD/g2g8sbvV3oxVAP3Ts4MFi?=
 =?us-ascii?Q?1txpEssf6yk26OkhXu7oiuCm6yR7olVcpNweDoM3G29LxiyiKJNk1yCJ7ozc?=
 =?us-ascii?Q?FR6T6T1u75K3AQqiqRsvC7Vu8fyAiv2bzrLe6cd7dpeg45v5VdoO57J0C1Qq?=
 =?us-ascii?Q?WeAhxLgVXqWzlhHBXT+daIBJP+83hpxQSW4MansVuv1kZJskd2qVnEKa9eue?=
 =?us-ascii?Q?hJ3IShsEIb6SbM9j1l2wBqAsAR+H9khIO6LvbED6rXFMevv/vDgLqrqmSQUE?=
 =?us-ascii?Q?hJLMZb5Ek6UdZXenSWmBZ6zwFqlQb00fWErO/YFKDrbtgq2WgW8lNI2kvcMp?=
 =?us-ascii?Q?gG7Zh90pQYQAGLB6yTWa1+dgdybd03PmPsD8B4g/gJ6QtWVTWWsqWo7PrYuB?=
 =?us-ascii?Q?xhhiA24QmO31v6XOdt9Rc6skqRn4OqiTeGuj0JGFxUwJ7g6Bpl8DrvJU2oTB?=
 =?us-ascii?Q?l29zJ9QUsALHdxcs9qsiK6lroJmbztNARyF43EITDwZ1Q0gwgRD2WLVlnGoy?=
 =?us-ascii?Q?mRSFt+hB7YJ+AXDlBHJG+eRQEWdkyXAXYrOxU3b2SIfJLXNIpC21/QdQymBG?=
 =?us-ascii?Q?dL4EAOIj95S5+VNqb+mvY3ajGyHHjW4dJgcRvtbChSEB5soYcgMG1ednD1+D?=
 =?us-ascii?Q?stZ4ClBr+hTgmecNL1orW0mRoWvo+LTnXqbgBm06gLlxxCFZkpH+kGjP/lhM?=
 =?us-ascii?Q?GYvvOW2I+eiMZiyQ6MDjCoROjHqxmUEabypcQEm2IsGlAEsunoE5RS+4+Qtf?=
 =?us-ascii?Q?elD+An2BMmkBJJQlvnLmRJNYtEFYIlcW57breiAd83rwt+X6hmPTwVsoNQWs?=
 =?us-ascii?Q?UPXsgqveYwPMUv75uLWz9nQzYZFv4N8gKttFLVLwp0saWqrSLzeodAexbyUG?=
 =?us-ascii?Q?Dfq9UbS7dTujhN/unn6PCbmTzefn77McMhm1bNN7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b934aa6-0d0d-4086-fe72-08de1da42c80
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:20:09.4473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d4P/h9+nQd9Y1Z7f4mNNbtblqb2ToIWkvJkun2lS0K9WFWTPqWMmZrqSDUQ/GTKjveZ6UqJBOk6ThBROLhfQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11018
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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

On Tue, Nov 04, 2025 at 04:49:30PM +0530, Kamlesh Gurudasani wrote:
>When not using Common clock framework(CCF), calls to
>scmi_clk_set_parent returns -ENOTSUPP, which should not be the case.
>Fix that.
>
>Fixes: 15fdfef6642c ("clk: scmi: check the clock state/parent/rate
>control permissions)
>
>Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
