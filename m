Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F073BCD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 07:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5778E84832;
	Fri, 22 May 2026 09:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FEorVyh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292F7847B0; Fri, 22 May 2026 09:53:09 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D90847B0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrKznmM2MQHtvRNVQjLERg37WdQ0TQWUQkeh5LugYphV2XHLVzJYkR4TvUXfA4qHzXuFPY+9zJWwvwDGlzz6FiApjFW8ljTeqlctxMIbrXtByYAT4MJ9UMK9pIKnAGwoxhVvSZnw0/WT+U6eFDgUt8qQtVXJ8Y9Xu1DOkOOf1qy2Ustexwy0ajmnY3/OkfTYwimu2QX9McQP2x5rBZOXXRoZEvoziTIwDb793m083uIKI09zjoxHR39M7c/KD5Sx2txHvkUreFGMU3DTZRSXwZFyRuUJIoOFVPJ+9r4B2AlzV6MIcmHB5eq9N63X5A7PxvgmPvAGVA6Gu7raH40LdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwvSqgrO6uq3syjN3KfsCjxRBrA6W2xzAUqVzRhVdIs=;
 b=HDYUO4tYKBOBBUH3ACo3CRkNPBZFoSwlcET46E5hM5vj/A/j4pLPPGfiYEVbEMXpm9iNm7bIBONfy25npFLyV+h+f9BBYikKMR+WMRkSx6RXry12JVhCQY/MvUlwkTUwSHr5jkRP8GjIVtxsFIbh10ztZaIwQwmCF9lImNx24iMIslzmUXcjnH8oqfmcxdNhOQw7edGEEtQCHY6SFWmB4GTMrHeDPacr2+PDky7r183jCfrtkfxFTGY11IlZ+MukXIvAKVzf/gShRjSjwLiKBXN8CcN5XAH30E6qGEWixNkImIqehJoZvPmQJYDXo5bal2f7LgjWi0FpMm6ysbx5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwvSqgrO6uq3syjN3KfsCjxRBrA6W2xzAUqVzRhVdIs=;
 b=FEorVyh55e9/n1HCWfDyuNga05qxK6aEXSoLHoqNl99C9eil0YBwd8dGFpNhNaL6BTaRvNKSp9v6BeI68rNglyq0KaJZrgsbKvQmDX3HQD7flzMgLJkNQ6JdA2/pz3IXNn3SJ5XYHzl2pDlp8qZBjUvV+pIsu5FZnL5O/a2mi/80xWQMxZEypglcLK81MBTjCH2mgeeiKM4pLtlJkyJ5x18u/qQc1amPaTss4vuiya7iVoo2BGTYQhL6wovzUF7r4xCSgUe34a5cuyAyu3OCfRbfwBXQfItHNtLLqml1ijDz9st42o0E9DHhpowD41arEssQCXzCfKwghqqQlEAhGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by PAXPR04MB8174.eurprd04.prod.outlook.com
 (2603:10a6:102:1c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:53:05 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 07:53:05 +0000
From: Ye Li <ye.li@nxp.com>
To: lukma@denx.de,
	mkorpershoek@kernel.org,
	u-boot@lists.denx.de
Cc: festevam@gmail.com, peng.fan@nxp.com, uboot-imx@nxp.com, ye.li@oss.nxp.com,
 xu.yang_2@nxp.com, jason.he_1@nxp.com
Subject: [PATCH 2/3] usb: ci_udc: Update usb request status
Date: Fri, 22 May 2026 15:55:11 +0800
Message-Id: <20260522075512.1291485-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260522075512.1291485-1-ye.li@nxp.com>
References: <20260522075512.1291485-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::15) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d81833-6d0b-4e65-a792-08deb7d72825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|42112799006|376014|52116014|22082099003|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: lpqcRzSsPXRoXhScKDwospJN4v8UmuKdAckfl8tu8N13o3YCbBfk9+iNqi0a7gsC+niLX7RmwItBicaYs7ke1AN4SaV7ss169gyORs20rOGUbw1erPgM0/1wESpOTjq+C+KXpZDtA/7gWHssnxNDo+swsX5vobxnWhHZPFkzUeDYSgFEdhBRdJltjuUuB3k0nAc/lhZJWMAGNgPpa/+7w9lL+Eq5X+KSmvrykoRl9E3pGc71aDZP/jrh68WwcN1+4GaSgfRwaat2M20Y1fBMkQMAQo0JGAVrZZmhj3DnLz0aEjPjHeruCETFZPBXbrqdxvTHMOUcQd2AUIq6Mlst2/vlyuMcMNwmci4zXj0DUz33hIcdnvJJT1WbdG4y3BaC157KA35qzuhEj8NI8JywcBWchSSdfG9T8KQAZ92RkEql8R/sZ/wwhe5sGQTH+XfezwMmTL97rDg+nhSoJILh3BeARRkk849p0vovysJxQypqp2avWJSOA3VoacTPMB0ev9je/7ajkvvk4ezsyLFsu9wRv7M0bbfdfH9rIrxpeorEk7+n7txneKCNzjaKYMCU/ikEUh0EgIAK+OWONZsVt1ovdKFpt0jOmVTWZwZs5AMUTu3sX8V+yH8vXem/7RPxoBSqX2kM+9SgNOEpkK543a/P7Geo9WRZyaFgoGfhNGzPawojU0xVEzDTrDFosMdE+SMwaQdp9ydJbwq+njUEj2sw41JCBn+owzpTTB4asYnvCHEafaDcFYLw2euXPZH+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(42112799006)(376014)(52116014)(22082099003)(56012099003)(18002099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+cHATCx+7fwt3Ryyb+0qKnfHwmjTFXbO+9yIk2voUUk8EYWcOK3tvy2mCo2w?=
 =?us-ascii?Q?R6GLz6ekx4Tl2hi+ppr/Gsn/4ndUNFxW8HugE0CKVpBOhfqHR6cXho853M8X?=
 =?us-ascii?Q?HG4iw2M5fzT/895iV7aZSn10mE3vL9gXwrjdeDJh1GDmbURCAVcL0oENe6vh?=
 =?us-ascii?Q?akMmHyjAU50xZRS7nq5xJh3qcJxv712GqW4BJppHZzTwlY+lQxaLUqvQNskH?=
 =?us-ascii?Q?ksNE9+t9hXRdPizBnxqKZ8LgSAZ8RSf/Vtl6CviraZx3m9yXkgtXVt77cQqE?=
 =?us-ascii?Q?arEyQgxzLF2yVRvNO6fsX7G8rJIrxh64WdTdyvqQbrRT0geMW34/X59iTFj2?=
 =?us-ascii?Q?I2prWBDc6hZA6Ql2/NL97IK6Ue0ZB4yTdgWgiXOJfPRP6ULfmhtxIM8qsBrg?=
 =?us-ascii?Q?adHlrlxOWHJuFIOzCrmOIRZRlBLtTDMazXw0pwOqMk1vYwxlmIu0ROPlHvEg?=
 =?us-ascii?Q?qknXpvXtbdOPSo7FF5PufqX35TqDLjWtshgsn2OL72thLRzdNDaCKVgUcKzd?=
 =?us-ascii?Q?0PchXzf6nUMzoi0SvLYNoCNMJ/qtquT5/qEm2GBXaRY5bzzFVkJsBVfwpGso?=
 =?us-ascii?Q?uTucrnJBzJ/QL3EuzLOoZoRGhqANvCL4fWzlnf2LldmY7JFie+PYq2n5spLL?=
 =?us-ascii?Q?ffTP+ccueNryR1UJxaspU5HDJgfYgfHVcs5EmkrEOzzjlVA1NdG14h9v3Y/S?=
 =?us-ascii?Q?1sbgZM8iu5ooTHVsNutEFw8MQr5Spxk6SamkSkXsX0KVIi7alGAiAfpWFHtH?=
 =?us-ascii?Q?zycdMeRU5gO8DzCU56S9x8iOucrBxoNoRiizZGyGPAav3z/oenCSVv+FhGJS?=
 =?us-ascii?Q?+qN/txEu7bKonRztilTkoTI01AbUJMIWz+ijnjuK13k9dcBNtiDhVbXP64nX?=
 =?us-ascii?Q?b0RdsAWpByFkxQrhZvc4eZzwm7iTUNG7+MdqZrvll2O3IYKRAwBsO3Efz1rF?=
 =?us-ascii?Q?Qsl4noeCoPXygw3qBuSf0NLL94n/Ng+tBabsdq660SWZj9koS2h9+fj+Hc0T?=
 =?us-ascii?Q?cLMHM9Rv0n0qdzV5yzWpIHF25+67D8L5+rw4XBGwBIH25+d/tflpNL3QvomL?=
 =?us-ascii?Q?D78jCrdmRa7GKNSf5Tg741N8rCYtPk5x2OR6u7hRkiHXFAhQTvGLYHwiP4It?=
 =?us-ascii?Q?q6Gkf04MNjKQegid/TmD3Jlzl+wMHTbjdpnCdC+J2Oj1TDUAkJ519UT/Eic2?=
 =?us-ascii?Q?MajmGdMpKwfPkCvFkOQ32Ugne2zuTSS38p5gSfWlHDZGux/of7JzkY37EE05?=
 =?us-ascii?Q?0ma96hkn0zIuXfLe+CAitJm9lF40YzxjjJRAuwWqmdUNGkWxcVWWDv8GCpoN?=
 =?us-ascii?Q?cJO2yChc1xQTcVy+IXVDzC5uYPALjWUy4M4B1eJxpVwXkXNxXDsSwCL6ajJv?=
 =?us-ascii?Q?bVk4KX0mtrVSqb+EWB7Gszagz4edaI0PP8E0F+T9/9MLZXYdJDj9lwj9cYHc?=
 =?us-ascii?Q?Jsc3odHe8gRIT6wNdTT358J8mGaouPMHZi4OBtcyMsYtw8RjHIXHWYMnn5j3?=
 =?us-ascii?Q?ItMYeCXepc+4wAzbg1y7qRsYVSQam/4FIBYMJ4Zn/GAqKHchhtEJqQvyUqRa?=
 =?us-ascii?Q?UjeagFabH+qvksrHEhDWcuLaFmQPO2U72CouGhPnj4ApCfvVsmXJns3sUHEn?=
 =?us-ascii?Q?VS7pCeEmeGN0vJ5p9BDVuQ35hLS0RhRWDFkUVMo4RpUKVTNo3rgYYd821tyV?=
 =?us-ascii?Q?AHLEYkbqroggvlqm6polRUV6FFWFYsSAsPBeXKP/nYhLYsfH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d81833-6d0b-4e65-a792-08deb7d72825
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:53:05.3421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB7X9BloIZEG9A5JyJCec4VOjY6H/WM52fOtCGXvjcUp3QtQEtmRbUaNUTVSrKbs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174
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

usb request status is not set in ci_udc driver. However
in ci_ep_dequeue, it checks the request status for executing
complete callback, so upper layer is not able to free these
enqueued requests when calling usb_ep_dequeue.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/usb/gadget/ci_udc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index a62e5ea5658..0baad83ef90 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -680,6 +680,8 @@ static int ci_ep_queue(struct usb_ep *ep,
 	if (ret)
 		return ret;
 
+	req->status = -EINPROGRESS;
+
 	DBG("ept%d %s pre-queue req %p, buffer %p\n",
 	    num, in ? "in" : "out", ci_req, ci_req->hw_buf);
 	list_add_tail(&ci_req->queue, &ci_ep->queue);
@@ -754,6 +756,7 @@ static void handle_ep_complete(struct ci_ep *ci_ep)
 		ci_ep_submit_next_request(ci_ep);
 
 	ci_req->req.actual = ci_req->req.length - len;
+	ci_req->req.status = 0;
 	ci_debounce(ci_req, in);
 
 	DBG("ept%d %s req %p, complete %x\n",
-- 
2.37.1

