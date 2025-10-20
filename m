Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68813CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 12:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956E8836B4;
	Mon, 20 Oct 2025 14:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JAJXsi1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18006807B1; Mon, 20 Oct 2025 14:11:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D845982E34
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQj8y6nkxWgnbdZvs2VrwbjknnyJrti7vpncRmpp+ay5QSlgec7M28N00y86PZGOznv+LfLEUGLjwi/zLYApbQLpShxpOGvwryCl6WUsEBiSo8D5lRR8HPWzFUGMMpel1920WvZMv+t1UJAQB2GmH82lujSC8v4+X7QeyyZLBUOvKXn8y8f/93ezklEKpBtneV5wRvlnlyIOA1JgVHKUqVsXBn/kdV+cxP2jEK0wHhRE21Tlol3Ol/WMQGOdmXvIU8RvpdjccFbBX//W9E48EgLt8rso4+1J1irIIphX+7MlOVwfSddLJLAR4/7ZZ7nUIcvS/4Khxiem+0xf8bZyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1miFTlrsZleZtFZvuS8GYdTjiL8Tzw2YofnUCKFPJQ=;
 b=adlZvRgo7fCGHzs7FPXa2MM+hD61ijPriOGrJ9tjK3+G9J1WFoLqJpRRd6iD2iJkBq4InWLiZo3+GfuBCMcCdubD+yEfyoFFlRjaQtOiGG5/1MOrLMkZ+jsqcLrxFxJxjVT3GXLvf3gsBHALG6/Yr0TZ8UmjLCcBvzpy64sNULdXf5xnxdKhDNCrDiYzT6bhumIGJWi+JiGnq8wkq1+EZhCnrc9PHy/7M4FR3/Pu62ZmdzD0JExTB+gErXlNG2YTUVXNLntBDr5TcCAzTLLMFdh+jejKOLJ1IBUAmOnpuHs4I+ZnwEoISfN5f/Xz5A4oJAZuPlzpsoqHlRNZ8kmniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1miFTlrsZleZtFZvuS8GYdTjiL8Tzw2YofnUCKFPJQ=;
 b=JAJXsi1R2ZsL2mHqL0vnMNnUBZldAeA6Xi+JBzpjfeJqsqbmIzcMvvl8C7nDfOTXaKrU+Qmx3uuJyAHQnWYV3AbTUfz6DOEmWIU+h8V8hkCUY/2xYsYm1OwRoihL8EGez3KT4d1AxU1/Ip+aiD17YjyFbbVzkXww+R/Wrybs9gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:11:08 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:11:08 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 1/2] disk/part.c: ensure strings in struct disk_partition
 are valid after successful get_info
Date: Mon, 20 Oct 2025 14:10:59 +0200
Message-ID: <20251020121100.1742812-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020121100.1742812-1-ravi@prevas.dk>
References: <20251020121100.1742812-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: e84c29be-6449-4cc0-a0ce-08de0fd1c047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bGz1Dlra1QHNreUMyRn0auBP36ISpaZF+CU93UyPPNc1A3iDDgHCv4YG70KV?=
 =?us-ascii?Q?Id79yRAHyuxD1klGtXCZJlRKo7lqWGDZKiWFHRicDIMxJDqtyaS2C4J2+tYo?=
 =?us-ascii?Q?Ce3amRi2zc/h3+ap9so84e8xulU9hevfZMz8DAC4dB0LxR+RdlmpFvB42TEb?=
 =?us-ascii?Q?pYQZ3doSjINgGcjTva4OglwJnWmU0l8CPr4DgPap0elTNQ9HwOmMNVhSoH5y?=
 =?us-ascii?Q?XzVn1P8XApEDlOmyh/LuXxJQb4/XAMjDallhL+YIeW2s4NUYVnrHNIkG46ST?=
 =?us-ascii?Q?/+918M7utYzprJ1MbcdfLoyVho20dcbhJbL8YrHB1kU11TnarMcs35S/OXG2?=
 =?us-ascii?Q?25JXVEcHz3beuGISwmHUOzH74BNgzXwHHbfW2L1P1qQwIcU/8sAWaHI4DMMb?=
 =?us-ascii?Q?l1qkvFbUIEJz50Oo85zo4Q/+8Ro8ojv+w8Q4SxY9egS82cFkcNqyb0nlCHsy?=
 =?us-ascii?Q?DJsJfpwvXZ3dUPwb3yeI7wGgN5rslpqAgU2ROt/ZT6PwLFHdN1fHUdrU+Ovg?=
 =?us-ascii?Q?D8Lp33BQCduv9zJ53cttF1C8+zdcJRTpYJM9SdIOlpnBgRNw01jEicpRAxFR?=
 =?us-ascii?Q?lapKO8Zy9DRh6NgMykeMp2jTaYvhiTjGJjvyZzltG/IX0QvSu06FH9WkNLbX?=
 =?us-ascii?Q?ztFBOsogrJwid8fSxfENYZVqD2/aW9b7lFmR4lizqDCW2obslsq+xTIo+0it?=
 =?us-ascii?Q?hkcwTtCXrQ+pJuiyReLaQyPLu2P2Hi7CWGR3ovM9yA47ztNdI7wZSGpXqLKw?=
 =?us-ascii?Q?/PH1YHtdWJAg2OO2g7wuzd6js5m4S8kvT7OkhDXLDnrwYXRxCPvVfmwKYqdb?=
 =?us-ascii?Q?3HQ+RUVvrLwN6KEJ7AVX21gset04snf1EfRdC+xscED1vUFLzZm26xeHJeOE?=
 =?us-ascii?Q?wT8ewcABw1HI4TIE/cplxAfPvKdIZgpbc827fIIMBFJH4TxaMvi/EoYnWNj6?=
 =?us-ascii?Q?6eX4OAnFsDlYy0DKHMLeogDDIPkmInBoD62tfa3QfntHTjSxTKxbCNlbD2XN?=
 =?us-ascii?Q?oBqQUZd/pIoPiW+F1IJGqp3V4kA/XEGyMU9Z0VuiDLf7hDdXnWJy8HYOCId2?=
 =?us-ascii?Q?9Q773Nb/Tp9RDC+sQpI4S8BffWA4q1zkCZACsDtHhnulPJ5UHtYL5T2L9mC5?=
 =?us-ascii?Q?AhJkPNS/QNpuUZC28RY/Ft9SHqLSQC6Us4d/3Y5z2cQz6BG+BQBy1H78CfsX?=
 =?us-ascii?Q?c+ryyAVHaygt9HMVs3CNRkvR95R/pJC29bBkzRZz9v8b5RnjxCQsC5OcE6EE?=
 =?us-ascii?Q?yZXQ2lsfzyIX9s0g4RpWImdRtkM86pn0d/ll2HhxO01fB4HSAA/oLVXRdXPA?=
 =?us-ascii?Q?ct7rQgJSRIPj/MFPHk61GJ8SZXqEswWGbl4WaU3/weKna32+fNCKy2tWOipp?=
 =?us-ascii?Q?55vrp5zO4+r1E0tsYI5ZZNsrUclpIMiQVouccS7JRVYCtFwgUi1I5J+0GugV?=
 =?us-ascii?Q?8VinnbYzosEtYf8hHrXLedBiMiWKd6fyXk/z+rFEQiZ01qJaDFn70XEkfRLu?=
 =?us-ascii?Q?sP9QxNKPKKKlT0vJ3auv1GrS95vtwOf6MloR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ts/uZl+/ssYr5k2NOT7lCEVOJ+KwoM80juSRDhdI7HCKGMY2vkB3d++oEful?=
 =?us-ascii?Q?t1oNTQgIndmW2P1XmNs++W2Khdptg3ABZshlI9U82jZ6K+7Li30LK2OVpj94?=
 =?us-ascii?Q?FhZwSChRRbi5Dvu9qs+pSH+5KuslMyJbVEv5q5ib6AiDHFSV72XjQqKVHU9I?=
 =?us-ascii?Q?D8HetuaEU7Fozmqri5JZ8L/FszO9lSeY1YDPkgnJ5orgFYbTrqRQLY1DHiPB?=
 =?us-ascii?Q?YLpsIqcRVnwceioEbj+wT27L5TqF7ZM1calnfHsSf0zKF7nKNZnxcb73eP5g?=
 =?us-ascii?Q?sKicpe7wmUppFcQC2jwhf2hdNfcJ93ABQV9oqPR9jjnF+dWHy4eY5ChDyAiG?=
 =?us-ascii?Q?0zOfmujmyi9pp7A/hbbx97V4BJA2JZL9jCX8nP/QRy3ox8ruS1JRDy2C++NJ?=
 =?us-ascii?Q?7yWOjfZa7ofOxV0X0gTJzzWdmoks4qSEgqVkiFJHJumKSZJa4u8JcG5iiK5j?=
 =?us-ascii?Q?KyIT6/lemoMgTpnrFFAtqLigBGz2hZkHqceuuzMX3AJfZnumKXRhfIPo2O+B?=
 =?us-ascii?Q?ukAXb8tSAPGYZpz3lrqfwgme7oMp2MjfUMgosp4uPpHyin9g3DVWGFMrN7Mt?=
 =?us-ascii?Q?OgTA/1cNyPA0mpzuQk5+2SfJ7+yDa42auHfvg899VCR/epHz3ZcS3ED1b/6J?=
 =?us-ascii?Q?kodmxV4NFLpqdYf2ZtFCKQ4DSHHyXgxrfObKJE5ulS1lHMqLlg1gMJFb+Gwe?=
 =?us-ascii?Q?wjxBWOvl0cUIVYgzMFFAfz7TlQV0NmVrV6o1KZeLYZjHbTn7lpgZtoL2JsJs?=
 =?us-ascii?Q?7x7lcth6SvZB51NWdC4NB8cyCo7LC7YXBCgK+vHzL2kPTxLfyJ6uPjsEI8bN?=
 =?us-ascii?Q?ujK39WwvVCtS5OiNOkS+8oitdXASGHRALFMfZdZj8FrjC45FltOn2cNCLPs3?=
 =?us-ascii?Q?np6Vwdh4W2B8oIBE+MdcC7P6nWEk3RTSMrgHU15ks/A/zzKxnUZpyxEsMUMy?=
 =?us-ascii?Q?iUHej6YBFADLfPaAJ/xM9ZZ+7tTVvQ92pUSmPiBCH7N/ayQSAgMlioMrHBfK?=
 =?us-ascii?Q?8OdeyhmlEBzkDUrHcbbbYqZ78soPP3gS6ZoHclAUWg0DTPCWZVJ29wYcNEtU?=
 =?us-ascii?Q?Bd0FSl0mVkI7GstceBk9k2QwE0Nsd8fUTcnk9KPMpcipn6CUxJ317L8IMNr/?=
 =?us-ascii?Q?uYbEbUqVSl54IG7u4r/EEq/TUxzKrUzvs38Eua/2PJ+EdJYNjJGfBIL+tYX4?=
 =?us-ascii?Q?+efdDrIRhpIEQ3umjOPNVxxwvEyYbW0Vzp+xpffiuabAhkfbhOvLPVhuE4cT?=
 =?us-ascii?Q?0niKZWj3OjNZweQhYxP/Qx66isUmEABD2pINGtWTyEMqfWGk9HnulLblm87Q?=
 =?us-ascii?Q?Fc4CNFVBzKOR49Cj3/wm9r45cPe+Hh2m6wgqyXU6EWbw0BeKhbMu0jN6FTju?=
 =?us-ascii?Q?/TcNZXdipjp0v7l93K5rRtIwMLY2qjU8ObBeIY2ArHNDmRrmtVv6Msj+MidW?=
 =?us-ascii?Q?lnBo9jcJILv6Tg3Pu1Ebp3/HFDPgzd9AKJWVFPxlkJBQNqlifVjXp5/CMgP2?=
 =?us-ascii?Q?MCgBtR9hn/b1ljUYrDLOvya90UCIUEn1qJnnyB962y/zkd4qdJ6Uw0M44w2g?=
 =?us-ascii?Q?jdnLjlU+Fu2DMmjGmCWlEEV1xqNxVkzKphe46bfGQfvOy43gifc/veL2NMsS?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e84c29be-6449-4cc0-a0ce-08de0fd1c047
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:08.3424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNGeai3rHlXGlREUsMtGUaGBAf4vV+uZrjGzeuQPCvPmb3/7aOLaJa1LgPaVjdPzxGpTqRcvNNOaZtGxW1A0LkumdVOw1TObfPCy5RzcodM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5924
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

Not all ->get_info implementations necessarily populate all the string
members of struct disk_partition.

Currently, only part_get_info_by_type() (and thereby part_get_info)
ensure that the uuid strings are initialized; part_get_info_by_type()
and part_get_info_by_uuid() do not. In fact, the latter could lead to
a false positive match - if the ->get_info backend does not populate
info->uuid, stale contents in info could cause the strncasecmp() to
succeed.

None of the functions currently ensure that the ->name and ->type
strings are initialized.

Instead of forcing all callers of any of these functions to
pre-initialize info, or all implementations of the ->get_info method
to ensure there are valid C strings in all four fields, create a small
helper function and factor all invocations of ->get_info through that.

This also consolidates the -ENOSYS check and standardizes on using
log_debug() for reporting absence, instead of the current mix of
PRINTF and log_debug(). It does mean we have to special-case -ENOSYS
in the error cases inside the loops in the _by_uuid() and _by_name()
functions, but it's still a net win in #LOC.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
v2: new patch in v2.

 cmd/gpt.c      |  4 ++--
 disk/part.c    | 62 ++++++++++++++++++++++++++++----------------------
 include/part.h | 16 +++++++++++++
 3 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/cmd/gpt.c b/cmd/gpt.c
index e18e5036a06..84221881c39 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -724,7 +724,7 @@ static int gpt_enumerate(struct blk_desc *desc)
 			continue;
 
 		for (i = 1; i < part_drv->max_entries; i++) {
-			ret = part_drv->get_info(desc, i, &pinfo);
+			ret = part_driver_get_info(part_drv, desc, i, &pinfo);
 			if (ret)
 				continue;
 
@@ -820,7 +820,7 @@ static int gpt_setenv(struct blk_desc *desc, const char *name)
 		int i;
 
 		for (i = 1; i < part_drv->max_entries; i++) {
-			ret = part_drv->get_info(desc, i, &pinfo);
+			ret = part_driver_get_info(part_drv, desc, i, &pinfo);
 			if (ret)
 				continue;
 
diff --git a/disk/part.c b/disk/part.c
index be2b45d5a29..194eccadb7b 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -72,6 +72,28 @@ struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
 	return NULL;
 }
 
+static void disk_partition_clr(struct disk_partition *info)
+{
+	/* The common case is no UUID support */
+	disk_partition_clr_uuid(info);
+	disk_partition_clr_type_guid(info);
+	info->name[0] = '\0';
+	info->type[0] = '\0';
+}
+
+int part_driver_get_info(struct part_driver *drv, struct blk_desc *desc, int part,
+			 struct disk_partition *info)
+{
+	if (!drv->get_info) {
+		log_debug("## Driver %s does not have the get_info() method\n",
+			  drv->name);
+		return -ENOSYS;
+	}
+
+	disk_partition_clr(info);
+	return drv->get_info(desc, part, info);
+}
+
 int part_get_type_by_name(const char *name)
 {
 	struct part_driver *drv =
@@ -322,12 +344,9 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			  struct disk_partition *info)
 {
 	struct part_driver *drv;
+	int ret = -ENOENT;
 
 	if (blk_enabled()) {
-		/* The common case is no UUID support */
-		disk_partition_clr_uuid(info);
-		disk_partition_clr_type_guid(info);
-
 		if (part_type == PART_TYPE_UNKNOWN) {
 			drv = part_driver_lookup_type(desc);
 		} else {
@@ -339,18 +358,13 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			      desc->part_type);
 			return -EPROTONOSUPPORT;
 		}
-		if (!drv->get_info) {
-			PRINTF("## Driver %s does not have the get_info() method\n",
-			       drv->name);
-			return -ENOSYS;
-		}
-		if (drv->get_info(desc, part, info) == 0) {
+
+		ret = part_driver_get_info(drv, desc, part, info);
+		if (!ret)
 			PRINTF("## Valid %s partition found ##\n", drv->name);
-			return 0;
-		}
 	}
 
-	return -ENOENT;
+	return ret;
 }
 
 int part_get_info(struct blk_desc *desc, int part,
@@ -657,15 +671,12 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
 	if (!part_drv)
 		return -1;
 
-	if (!part_drv->get_info) {
-		log_debug("## Driver %s does not have the get_info() method\n",
-			  part_drv->name);
-		return -ENOSYS;
-	}
-
 	for (i = 1; i < part_drv->max_entries; i++) {
-		ret = part_drv->get_info(desc, i, info);
+		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
+			/* -ENOSYS means no ->get_info method. */
+			if (ret == -ENOSYS)
+				return ret;
 			/*
 			 * Partition with this index can't be obtained, but
 			 * further partitions might be, so keep checking.
@@ -695,15 +706,12 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
 	if (!part_drv)
 		return -1;
 
-	if (!part_drv->get_info) {
-		log_debug("## Driver %s does not have the get_info() method\n",
-			  part_drv->name);
-		return -ENOSYS;
-	}
-
 	for (i = 1; i < part_drv->max_entries; i++) {
-		ret = part_drv->get_info(desc, i, info);
+		ret = part_driver_get_info(part_drv, desc, i, info);
 		if (ret != 0) {
+			/* -ENOSYS means no ->get_info method. */
+			if (ret == -ENOSYS)
+				return ret;
 			/*
 			 * Partition with this index can't be obtained, but
 			 * further partitions might be, so keep checking.
diff --git a/include/part.h b/include/part.h
index 6caaa6526aa..d940f8b5d0e 100644
--- a/include/part.h
+++ b/include/part.h
@@ -509,6 +509,22 @@ struct part_driver {
 	int (*test)(struct blk_desc *desc);
 };
 
+/**
+ * part_driver_get_info() - Call the part_driver's get_info method
+ *
+ * On success, string members of info are guaranteed to be properly
+ * initialized, though they may be empty.
+ *
+ * @drv:	Partition driver
+ * @desc:	Block device descriptor
+ * @part:	Partition number to read
+ * @info:	Returned partition information
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int part_driver_get_info(struct part_driver *drv, struct blk_desc *desc, int part,
+			 struct disk_partition *info);
+
 /* Declare a new U-Boot partition 'driver' */
 #define U_BOOT_PART_TYPE(__name)					\
 	ll_entry_declare(struct part_driver, __name, part_driver)
-- 
2.51.0

