Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E2C47258
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 03:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FC78753E;
	Fri, 26 Jan 2024 04:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="S8tJMXcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9858785A; Fri, 26 Jan 2024 04:30:18 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5941F8746C
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 04:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpW8E8wWf7CiVaYwxlRnJbJCKLLknhCR4KMZlV1vIvjo47vCN3vJw/puG0vaslLHDjagulFqI1iFup+cy78h1VAwRRjMjBqzfcSCDQp0FoJnmtfKwL9qxRgEWVDYNG3CkvIdhnGUnRxS5fPk1ff4K4HTvnfU/X2yz7aHbv2hwLBDyBwvY4bfQA5rM2egQfx6uuMpxxhQDCTxfGb7McZSYhnYzMNMy73WgQNcH2xTODgiOJPzlSil3mouF9LCesW4Hyje9fPqo+hwdI/tqsQ5gDkOdGDBCA8PmzpcmtlSlnN6gHSUXpdYDMAvMHw1I5RMLOSElzyySjJPgLpS8znyvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tI709wN+nIEu4B7+dAhsnG6owfstPrJHT/eB0FleDk=;
 b=Oi90q8ezq5hwDHKs55f4SVzlobQqF1y3MBkGelVR8XuKvP2rBf8Oo4UuyDkLC94T51nb5ILOalWlj+M/Te3d9K2fk8fxYo4mgWWocsIPUJ28+EH3uLeCouv4GpUfwSUzFkmyhWePoRCmLaN4tO4ND76Y2C4uSw3ET3zZ/ZeXwbQ6e/W943hrsp8RrsBENs3oX+7Uom2SyWYYt0MsHxPljezn7cqRoQgqvFjllvc9hsMmhXOuKARIHGzMTwyNxI9t98u2L+CJrYHBEcINyhpICHXZ7SOZTaVUIBPl2j4MmdHDjBKJ3JxJ5Cp+vgui+ctPAdB+6kIBPfNKjvxKxs6wLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tI709wN+nIEu4B7+dAhsnG6owfstPrJHT/eB0FleDk=;
 b=S8tJMXcBeRCjR3sU1xh/JZAYx+IYKuNe3LmaEq9J01bP87NdBx9P3XWSLHGSTwSKW8zyeM5acB1dV8HgnFV+bzSqmqihUjdd7khvP2qHaOB2YNuNxsiCmrXagh2vHrs0m6FU1gXPjU5xLXk3lBaQUU0MiKhZyDfyxO/kAHs0HnsslAEQ+PleAOoDh2rNQiuHfi6kBKxblxvH6o4/IBbMBS1b1K/lPClbVvbxVDik2uZI9Vkj+CtGta/Xlj4vheiS25D9RUjiIoENozX6vuELtOUZAD5NHf+hfO2qP3Jblta546xUFuEBLl34Zl35cH6Mosute2VqQVwky7Sz2q7LIw==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TY0PR06MB5030.apcprd06.prod.outlook.com (2603:1096:400:1be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 03:30:11 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::22e1:47ec:6e00:4900]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::22e1:47ec:6e00:4900%4]) with mapi id 15.20.7202.028; Fri, 26 Jan 2024
 03:30:11 +0000
From: Yang Xiwen <forbidden405@outlook.com>
To: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Yang Xiwen <forbidden405@outlook.com>,
	u-boot@lists.denx.de
Subject: [PATCH] mmc: dw_mmc: Don't return error if data busy timeout
Date: Fri, 26 Jan 2024 11:29:54 +0800
Message-ID: <SEZPR06MB6959712A2AFE3C6C9B49FC2296792@SEZPR06MB6959.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QFhaQ3sGQo7XSmnwoxbI9hecy/1X8Rn5/AaSjKeEAko=]
X-ClientProxiedBy: TY2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:404:56::23) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <20240126032956.22634-1-forbidden405@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TY0PR06MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 62712ef7-5b4f-439f-a0b3-08dc1e1f19e0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhxnsloXmbq/gqlYpCe2aKiVH9BB0H0KuhzwnguoI7j5LzmJ+H8phA0FLHB/hkE38Bq01OGgjSKszuq4BdX0/roeyHOGbVFWCaEiB7k6ESB3ZKDBPY11+hQWrMdDY1fGf4acN/yP7T80T58Sy7Sc7x0HFOCvbzvirpIKgX2yl1De7rDjvbz1ZScvz8xLg/ZzNJRt/thqsjhG5OnuPPfYfG9psO8IKSYTy6FlKDIvttsb+dTdrYjYkeq31JLcjg/xf5oosn8ysJ2KT6/mLA6fAjoGWaZGzzO4u9QjRg5VYDkg+Nqa/HhLmh/TGv2f978RJpL7Q5miitqi0LeJe+KzCPXjUNWeYlvGOvznMfQG5P9POOqLRq2b5VNAf6E7E/erhrRePpdcRigkxMmwuad9G1kntvMabe2yJzJmsGRRy61ZlRjJVza/n2YeouwvC5XHXtN+bIcNa1ncz9Kso8haahZVB/+Fpb3upeQCbh2qCF6qAO/uwSY0Pr2fSMF3bMJpBrGNa6vds2FOVIQ68RmECwRSJ3uzzHZdQbGXdJNupsSAG8NCCnIlIY1gFBAme3jo7BYLk+bBD//o7YBBLisDyuvaJZnQ+e4o6nEnKk23WFM8vtlkvp5jiD0NsTFo7rIW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5hRTzaJU8kwV/owCAc8ABfRLsGrf89isnqb1+vnXdemPKXxcc2zrIJjRdBUK?=
 =?us-ascii?Q?GXylUdMG+/M8kXas5DGW+7N/jputAjoS2SbnmmBLZ3GaFf5a5lrguApqwpMr?=
 =?us-ascii?Q?aMzGySQPvqKzMyeX451OVNIGHcmbrKCSVAkFkYNv+i7FWHIUA4a1Y7W/Q/ge?=
 =?us-ascii?Q?5t5U3U7mY0qjWmZGz649DL1QCt1s4VTPcBEtT4WmFM+oD0m+AQ9yuGtpFYzW?=
 =?us-ascii?Q?VE0/d+R4L1x6SUjTgxnFGkd3nqq6dHgY83Ad8rwwQoMAhPdUf5bsLDt9PCe9?=
 =?us-ascii?Q?7njNjCERln1cNw1PyMd93Fn9SObjpw/rlm3bc8cYlHOgBD49Zt3go8QuwEvI?=
 =?us-ascii?Q?Dht0zzhioKqFttwxeBXBWah1XB/tJkGW8WVDjQLnXHBIMjXnAFQsEuZGecAX?=
 =?us-ascii?Q?mY0wAeNky9+eIE3kHTqMyxXmG20nuJHc4/v9netc/sZDfUSIOkBJd4hdO/Wg?=
 =?us-ascii?Q?BL70mBh+PEhme8MU4dj6CzwLNAkca5lHyHv0c53XwRrzm0m1FV2WEcAiXSNy?=
 =?us-ascii?Q?mvD7dWWS42E/yGiajnVX56xpbpjgPVfKGWVSgf3+z5pw0wuCVlnSB0lcTQu6?=
 =?us-ascii?Q?E11SDhoA2oIr4nNMhwpjZYZiI06jcIVWWhoAtLsgIeUgXVhK/3oalyzebsSL?=
 =?us-ascii?Q?mySIbgxMpp+NyP6WEFSJw1AYmc8pDnlG0ot5NbSWZshOAxH6i70zF+5cwQTZ?=
 =?us-ascii?Q?xyGwFPaqHryXtgiVSHoqGrmhirf+D72PHMtuYlvIaNGcqnewWCuw4hd/QO7X?=
 =?us-ascii?Q?ezF/KP1vylYuaHyVYMu2335Ie8egW7Fgr80cN1kGy21Rop9PtK3z853Idgl+?=
 =?us-ascii?Q?rty7Q9Id7kx7L1cV+PAXr79UDQnMuMSswlBNBTFKL6aETDkes8KWQrtugIMi?=
 =?us-ascii?Q?XousqipRfJThjgFvS9kjeDClKj7n9cC9jNKkV/ANAeT1WDbrihZMcoJy0QUX?=
 =?us-ascii?Q?eHKGiE8XwxAkDQTb+P2hBCODbFj2JIJVzyI9RaSfwlv2H51oIGtv01UO9268?=
 =?us-ascii?Q?zqxPBbHoOHlnVYfzZVjEzvc8jsAFB0AD6dhom0i1d5z/JUKygufP8LaNdBsn?=
 =?us-ascii?Q?yQF+RXKYnhOaX7ZM9kufiI38Ybmzub/573gkcPOLBr6U6dl90xK/eCYGVAh8?=
 =?us-ascii?Q?Zl8/vipD2C/hLY/LGjuM2mlhT8RlaPs8xM+4QI6XbgecdzIZJ6PL8L1IwlKp?=
 =?us-ascii?Q?9zmHt84Urw0mOAR31saUina+z+UWxkv0ThYMLG8cSwUwrxedYqi62wwF6l0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62712ef7-5b4f-439f-a0b3-08dc1e1f19e0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 03:30:10.9824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5030
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

As described in [1], some poor hardware or cards would fail to release
the bus and keep driving data lines low. Ignore it and send the next cmd
directly seems okay for most cases.

[1]: https://patchwork.kernel.org/project/linux-mmc/patch/1424458179-5456-1-git-send-email-dianders@chromium.org/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/mmc/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 400066fa99..e103664145 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -262,8 +262,8 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
 
 	while (dwmci_readl(host, DWMCI_STATUS) & DWMCI_BUSY) {
 		if (get_timer(start) > timeout) {
-			debug("%s: Timeout on data busy\n", __func__);
-			return -ETIMEDOUT;
+			debug("%s: Timeout on data busy, continue anyway\n", __func__);
+			break;
 		}
 	}
 
-- 
2.43.0

