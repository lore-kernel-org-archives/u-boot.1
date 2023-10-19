Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F961CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF4B871D7;
	Thu, 19 Oct 2023 11:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="G1fqdNZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F99871CD; Thu, 19 Oct 2023 11:58:50 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07BE871A5
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDn7WOUDj0+2AyNySu5Hf52TkV8LPmtmKGAL3QPTBDTE73DOMySFM0OHW7eWONCwdiPjwgOU+XICKn06N9iEOtZE4sEjAqmfo+K1g2sH5C/iGUdsExOxfGnidZ9XeO5EpfMP1iD++UQtth7LrlnwhZ4ZvUL7wPT6U9+gUZQY/r9w9qep6J6Otoo5kXYbBDNXpUOlIsOg7m4Sy1Rif/EEOYNd1MSAN3OBHWtG8zneGk+WC3R98g1k2jR4mEUsqdKOco/D8lNB5H8DFVd+QPAYylPdJCr3+JKDA8BTg8H0/uI5Mssr1MKptT/TdqJeZovS87DX9wPOP2BjOPz7QdGIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UatLsFRT5zfMs1bSpZpyTZ9aCmTl+yLnKQw7cvNwr2U=;
 b=lkrqe+WbrzgiHZA7nthbl+UJP5yEh7hCtHEArT7AhrBsug82jJ55ZOMAG/Z7xjoV0EkSSBFdKszi1QLt/3dxU+0tTRfn+zlZG+5GCgmyggvDyFO5X/B5oIdk9cws/u3dzo/EN/PI2/Gt4Dv3xIQpnv+/f8OEss0SNZqWZnfTiTmGMbWFyU99ecPp+iM2lCtbf64B5TLWWS3NBXeiAmuHiqtrgLPbzi73Jl5x+/8ke6PtorF1Jq5fKq0kIV3f1e7grawRnm+DSgKoTM1f7aT7Ofme/e+s5FzV+tBFGp1EQmbAZnH16qhY59MiLwXWyHwOg3ytdlB92gvFfEnMP1alhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UatLsFRT5zfMs1bSpZpyTZ9aCmTl+yLnKQw7cvNwr2U=;
 b=G1fqdNZme68unFOFssebdcDedovB/qG4x6DqwUDo/AJzD0ALyrOo0kTr6BumhjFNCzhCN7Rtre/X5//PAaPMIlAn8ELxWA86bU8Zmq1DWEP3QuxylenB2YJc68xJn6YGweefA9ylZGLapDlDBrB8V/U7RlxFyMXXFJUtPKpKD7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:58:46 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:58:46 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/6] led-uclass: do not create fallback label for top-level
 node
Date: Thu, 19 Oct 2023 11:58:32 +0200
Message-Id: <20231019095837.2084458-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db3a1a7-bafd-44e9-48e8-08dbd089fc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0j74fCCTGG1sWxu0msZDpaif3+sTDcFi4oKRCQIw+yqACQ+QObMr6lXoXlCyRFVhYOiHtNRxSqAzwRJFijL6FRoVYzXjWYj+wh1Ago/T3MIZyyKF/m8cZVvIyA7ORO9ucu4gqRNQtY8KXcHNKdqSXZZ3K3iFRrLZuPX3zYNGNScKuPJTPEptUk+tyMDhv1wu+p8FSLfJ+ik4NqmqbRW8n03JxiKXKMeLKEvDN0jqxJevS5R9H14RB3vSLJhSgbGDF9F/Ycxsc7WGsu+6A+zx9gF+mNo5eLb9J2L0NQCp6J/3pKUSjULfUCu40VG0IhMpJ+qg876BMFHXDE4NTTE/ATloHM37Sw5P0MAxzdjmhc/yc2vF9KWs+uy4H5M9q8nbhE6J9WQYbs0e25X8pm/BDNSXUukDBJm2STaXkwZvpxsX+btAFGfDXNXvPVXBDb9WPlnc6qXFPoU03P0WZj9dqpB4cegPdrT2okRnKHspfafCOg0AZ7NFg+uHNhptyDtCccsz6KveHR2CpCLWbYCYFi5yF3wZyeiiHgeUCznVA74LZPIWi6dGQCqvOCpP34JjuFBXDZOQQ/qGraKQm7JFHzrubOJ2XARlegAEBmv+GkidfWGjhmL9Vp/nDmrKrU44
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38350700005)(2906002)(38100700002)(44832011)(41300700001)(36756003)(86362001)(83380400001)(26005)(6512007)(1076003)(52116002)(6506007)(2616005)(107886003)(5660300002)(4326008)(6666004)(478600001)(8676002)(6486002)(66476007)(54906003)(66946007)(6916009)(8976002)(316002)(8936002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6nmmogyJNaX9dUhmW+q+XKyez08yfZWlDb/5SXRS9DTeWr3hs9BG5uE1jBW+?=
 =?us-ascii?Q?l2AsK4OkvZpO6nVg880hZaDfp0LnPHGcosV7LmvSXZT1pMZtyLAI8HfzVNXh?=
 =?us-ascii?Q?vlWbFwRTG+p7JjciOXhcgD5CxEk4kRBVRAJ3coyFcaUf2TNfZw1ACPIkvb1r?=
 =?us-ascii?Q?/sIabH69Vwto+2jh6CJlNdxM97BOvdrgqgbT8Cf27ATD/THkFloaFXooEzu5?=
 =?us-ascii?Q?ODwwyg0D2/cWbloqoWw46T3JtrScdU5CBcXeEDqOilcFQrmuuIjzf7TCkQJH?=
 =?us-ascii?Q?BZV9BZNvTTGiSCffEdiuwXwecV3qVrOVZSAqsZHoTBUzR2dh8yx92QBgjv/h?=
 =?us-ascii?Q?6SXUOH6cFgUgbf9BWr9YFcWM/KW2kIPRrNgDNydutQbjAAgQaVKna4m7+eLK?=
 =?us-ascii?Q?M1w7cmlD3w8wHj1Iizy4fEWn1B/XSwj/d6apxRWKDpYo53rq/RVv83eFlafQ?=
 =?us-ascii?Q?nyFp0quNqirK3Ykp+cYPpWbazH6ShYDdAg0P5FCNHngzvG+wsCxMC6P5keZ9?=
 =?us-ascii?Q?av8AdnPLPLiGsm1y4MC78usl5k8OS+U4Na6CviJPM4WhC9Ox5uETzOYX3qq6?=
 =?us-ascii?Q?dT867/jbePLd9iFTnoFWdlR3NUmo+IeHVCQYhpQZGLuR8nOk2wJePYxXqeeg?=
 =?us-ascii?Q?7z2RNzsvZzAA2egLTvr2d9ionY/5f99IfVwhg2qMTkQX7KdznmE5UwVOxlFy?=
 =?us-ascii?Q?c6G2S1d7OAzGHOTWOnq/QmmLkquG7zJDBfxaUI70aNjBX0qz1oxoVryUJlhz?=
 =?us-ascii?Q?6jd9ZUSvOy18fsgOr/WuE5c3YrPMuQWFpLt4Q4SIcfiZw+bBOW5H7YInpzY4?=
 =?us-ascii?Q?uEKIje5H4XTw2hzKlVzwZ/lrV41PkR6Nl0O7dC9iSDBKn4FcPmwdAOWEJPg2?=
 =?us-ascii?Q?bvRlLuG9CLotwjV3EN8zNVdY4MJL3vINLm1buZuQiJ7rfmkVNxQ05njdkxam?=
 =?us-ascii?Q?qzxEweRrDhSKA7dM2KIhdHFsg0IOglhm2iXP+lNaSJQz0r53uyrQfEGHfAaL?=
 =?us-ascii?Q?OY4Od30vpsPdTPSzCg+OR7c4ZqyxThAoAd8SMba9fjNu5M4I00Iw9/hfeevr?=
 =?us-ascii?Q?Yjn58Eza/ZkAg/I7fIT7lWXuEUbT64yZGPgcojdNzj406xKWMJOqGAX91SwW?=
 =?us-ascii?Q?2gwyGwwBLyQ64cVlAPbrbEkTOvXBIoRWD4wYcCdnum59DyFmeqfUtAmaiC4e?=
 =?us-ascii?Q?tHMUzFgV0rqn1E2aNSLYyWA/dPYsnMO+ETI8/DIiY2dd4OLfc0yO/Cp4Z8XW?=
 =?us-ascii?Q?beU2NrUvWkl/yPX3Ht7+lBfNvke/O7BnqtaiAUy3wzqnlTp8Gkmkbv37TfzS?=
 =?us-ascii?Q?3azgF1wIzvMhVqXAAFZEh2LawSICTYoLN/hj3mIycJ00VMhsF+I4m/+uOWd/?=
 =?us-ascii?Q?tm3Mr9eyGUFAcW8cnHTnmUEQAVpYYy5eaaFYaELMtNCMolxaZqnOgfP5sbB8?=
 =?us-ascii?Q?WV0X9hlMZRWScO1EhsDaNdDitWl74/ywM0Q0rWAz247dH/AEbZSxrOuKQAIJ?=
 =?us-ascii?Q?6Zv8fZTnmAZiimFDTIIqBncDY+aZm1pPsuNbW8mHDId7RNqSHN8BCiJcRkZM?=
 =?us-ascii?Q?k6n58E3YYbN7Kl2mwxc55jbgIgTzoQ2gxQsYtVjQAapkDqTIRdFi7E24W6wc?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db3a1a7-bafd-44e9-48e8-08dbd089fc29
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:58:46.3816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPk+aiel93WEmUVSerpyNJcyMP5zYHfRchy3B8e6mqq4xvat8Z4k41jup2efXpjspuTRZXESRAqiAE95J3+S8M3JxJYsExvTnOy+3e3WPoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7481
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

Many existing drivers, and led-uclass itself, rely on uc_plat->label
being NULL for the device representing the top node, as opposed to the
child nodes representing individual LEDs. This means that the drivers
whose .probe methods rely on this were broken by 83c63f0d1185 ("led:
Move OF "label" property parsing to core"), and also that the top node
wrongly shows up with 'led list'. Some drivers have since been fixed
up individually, e.g.

e3aa76644c2a "led: gpio: Check device compatible string to determine the top level node"
01074697801b "led: gpio: Use NOP uclass driver for top-level node"
910b01c27c04 "drivers: led: bcm6753: do not use null label to find the top"

Binding the same driver to the top node as to the individual child
nodes is arguably wrong, and the approach of using a UCLASS_NOP driver
for the top node is probably better.

But as a temporary work-around, we can use a heuristic that only sets
the label to the fallback value derived from the node name if the node
does not have a "compatible" property - i.e., if it has been bound to
the LED driver explicitly via device_bind_driver_to_node() [similar to
what e3aa76644c2a did, but that then vanished with the next commit.]

Fixes: 83c63f0d1185 ("led: Move OF "label" property parsing to core")
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 68ca3c2970..5a5d07b9a7 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -72,7 +72,7 @@ static int led_post_bind(struct udevice *dev)
 	const char *default_state;
 
 	uc_plat->label = dev_read_string(dev, "label");
-	if (!uc_plat->label)
+	if (!uc_plat->label && !dev_read_string(dev, "compatible"))
 		uc_plat->label = ofnode_get_name(dev_ofnode(dev));
 
 	uc_plat->default_state = LEDST_COUNT;
-- 
2.40.1.1.g1c60b9335d

