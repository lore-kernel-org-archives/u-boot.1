Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F0C25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05BB88176;
	Tue, 21 May 2024 10:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="mnzv645q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1834880F1; Tue, 21 May 2024 10:47:12 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C76788119
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOkeB3xHan/aiqiffK+PbPq5ruPIkAdjXUOIVUNNf4Ddyh04Rhq5ylrheC2JK3kH6gMg3nLy+c7bXfKZ3tGMzlYtC4507e0Byf3ZG9fsNpQbtjGqYycQyyU9xI8ozAhx52gdnWClnawnFfKMjcfhMBL7BWNzKv9zexWDDPeXsWWxHW4FjrLq5rBaQBVUm5kz0NDRZAkJVofnZ7s/hmySBUD7BPfyDC2lbj8R/px8t0/XnzUBFnUmPRHWU3lpMnW7wY3eR0oGVzerUOuI1CfTkU3efkgGIMIWKh3twHRYlH4J7T18CujPzzfa43dNF8MsUpk07TXohkRwcjI62YlKFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2nB+T4/zRGVvOJMKu042tyDRoQkadALfppjUa9tUfA=;
 b=Zgx2L5Qzd9GJ/h0th0SNEsa8IjDYPJ5MFjvbdEVMTZFzG3ng5t01yUZLI+uZP0fuAJA5+W+AmeOOt9VDROHGobdLz5Fe0MdnpK34zuWBObylGJcazN/UbCmziOKEt8flqNsgwp1ECDfuHY32/znUhTWwsn/yWEQCPrbFnXYVS3WWv5olriXRc4cRo58d1DWXvey7jyBdillqPS+CHdmGa0oVDD14z2xEfTHFJrlvbJBDyAfc9/AZitM7WfN5EzbumwWnJHqz8kS5f9gJQ2r2nzi82VxwiGzeYNa87NFo0rDtQrTbLNSa71FTn5QTSt3dQJt/aglv+RsyYwWqtq41/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2nB+T4/zRGVvOJMKu042tyDRoQkadALfppjUa9tUfA=;
 b=mnzv645qMFvrLez1bVQucwkxs+nQRqvx/FIgKpkNqvLPrvVmAmiJPSPtjXmg50QGje3ZCnB/Az7F559OcDow5aH7BvhUdMiceGj9HY7pOZ2qWokDKLbDdF2ORNx1I/7IYtkqZlKCwRaKNoRFer763mALaN8uD3Mf3Luq6LlmJnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:47:08 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:47:08 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v4 2/3] wdt-uclass: prevent multiple cyclic_register calls
Date: Tue, 21 May 2024 10:46:51 +0200
Message-Id: <20240521084652.1726460-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c13b05-688e-4258-3928-08dc79729933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CxsygFyPpVLr2TYNl94IW8ZUZ/tbKsAS79PdXGRet2x5cIOZZWBDIJYu8e5C?=
 =?us-ascii?Q?B55ibs9UgI/n5+rw45rsDe8vbdaQlJu0Bwod/ARsXbodELFRBRiB0uBd7EG7?=
 =?us-ascii?Q?ksyIfi7dYHGFJIc9BxzYTKsuWppeGR9Ry8Y/CBN2ZSjlF6HipehWPYHQxvqV?=
 =?us-ascii?Q?OUxJXPusoSb/xc3c1XUe4P+LQfxaEUBJV2saC0+JaTZZgXRYtSlJZO9eNe7j?=
 =?us-ascii?Q?nXC+V4FnjlrN4vHX8C138JPWe3Kt/OT//XA3xewzzj0jUjYjJhTG1E+kIVOz?=
 =?us-ascii?Q?QVB/Gvfo8m7SpPS0pX00sNcO0BUxk6x+qgd4QHUpMl+4P4CO1m1I0WwO16wq?=
 =?us-ascii?Q?ZGkN821YZozl5TQjp8qx751o0jv6aWK05xjp0hS5eZZ96KaeKosl1fHw7beF?=
 =?us-ascii?Q?OBdFLFJn3UspymBdlHrhbQsn+JLmfekeT3vf0SU3DFJbKY+1Ngxlm/aLXIz+?=
 =?us-ascii?Q?hXcp7W1GTxkogR5rdqr+HYuTl0D4I0ruabIltKHLrnTF20NLDy86lXuG4Hr2?=
 =?us-ascii?Q?Ts7dPGlh7oLDEJMRO5ayqwFPR7U+SQclYbmBK7MtrPHQaDa61ArhnerX80Ex?=
 =?us-ascii?Q?nFzGJL99ThRpVezn5S7uWOl44YcnFP0m8WWjf4WUk0PMEMvlAbw6N3BfjvxS?=
 =?us-ascii?Q?3jBXszsBJng42gPicsI6fzDFXU/zTGV80hdHCWRPXsLXmt7wSMO0CTTtWAF4?=
 =?us-ascii?Q?pDogzXjp3Bh7kmbPiD3oIrE4ILn//uO0dZzgOM8z8zHINfNWoTAJDAzyeT6A?=
 =?us-ascii?Q?0E2maizBkq6uTp9EqeJ73QcPXQLaKFtaQJ2rSimSOWaXQMPyKVeYCxQkUu+v?=
 =?us-ascii?Q?jA5IjcxpQ22PDBGur+d1dVq1WMLco1gcfw1dMt/JJY0+WJepVqIlko4L3A72?=
 =?us-ascii?Q?ZVmlLMNQqP2hy28NampwRo8KhG1XRJzvMLdr6YuG/GP6MMYwmSUbT+UItbVr?=
 =?us-ascii?Q?XYWNS5z5SGAEP/h5m0AST5bykncLScpuPksG2X79ycc6PCmEZbhL7vLPaMPb?=
 =?us-ascii?Q?idooWBp8klsRzML5Y4dBPtIzmoPrhqfLEf02OxBi+eSUJlQja+ZRy8hejov4?=
 =?us-ascii?Q?uug3ug94Zb++6o0bijGTo9qz63oBPXGQ/NIr/+DV02WHtQPpjcYX0p0FpCPx?=
 =?us-ascii?Q?YgE3jBtEX1YbnSPd10MN1uPdmpigsbC4U5GkdKWdkMMfexHfku0j75gPXlNR?=
 =?us-ascii?Q?5eMD8r0gkDPkOPKaSl3wBZSbNG3+5nSoeHxEDTMQHR73KIaTNr/ZKz+pYI5s?=
 =?us-ascii?Q?KRUKMEU/MFN4JAKJtqB+mjHpSU2YdKI0CaaveNgFCJeoB7SCKS1dPnKsQc3W?=
 =?us-ascii?Q?7Au6EAshwgsHOvKh7WrAfM1OJFQPRo9Awr5eMXbrmZl7Ww=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1b+mhC5n7yQzNOyhEKmlBHtDjqvvvlttC3GpCN8qccu2WZmGhTpB8bqp3BMD?=
 =?us-ascii?Q?7MAuRJBvgpNYLhCpWfqFfLPL+3Kxc2pw9r9Uukdd1UyyppgpjHrBB1OFSaiZ?=
 =?us-ascii?Q?kSqxh2DzSsuLI3KAvgSGB9pJ2pkHaDBVIUXMuXYxNnkbaDVjxicTa4ZfR3aS?=
 =?us-ascii?Q?IZLMMh9bw8WY5aUHSzCznjhWhrFumNdJ3SkmH27cu3HtvDE0YjX85/+QUCN8?=
 =?us-ascii?Q?Yyn3sCiZQm5GxknAv2BwE4VygH38WHqupm01n3BSa95MKGNPvjtpJKMjwH4g?=
 =?us-ascii?Q?mJGPwsy18S0UUFin0ncH8SPbTH40RDW0TEiKemeIqEY2WYljsVXuz97Ntjkt?=
 =?us-ascii?Q?QK1Iu+uy9FxDf4q0KthomnP4/xbXtYTGknlvaS8wGjmtwaExJxvL9h295/7r?=
 =?us-ascii?Q?2tN5Ltp75pKT5547ERyjTcXboitcSZfpyNjfsREMuhifmm9XSC+ttxtiLOqx?=
 =?us-ascii?Q?gfIxd3OQ9SXaA0FPSpBXnu2JcrXzmvepdyUL8c0c0L0kn2tgzuRNdMt3uTZN?=
 =?us-ascii?Q?qn9gNZxUQfnTvlpuPJqBoK339juv9gnduabXFXGRFr+JVAX9qo6m33iBxtKi?=
 =?us-ascii?Q?M8z8AXZAUo+gA4glI8vircJQt7LuEcP89huOl8xipmk/qnqHFQUX+bdAku/e?=
 =?us-ascii?Q?3j9IcvWFl3Qe20FbxzKDb9tsXBGIIby5vTGeU36IICowW6hACKiSpgGCHMSm?=
 =?us-ascii?Q?oo6FD0ssqKSsuk+yychP7a1oXAs9vHBbCxclKo2Z+11V8U+0AXWRac4eiqL6?=
 =?us-ascii?Q?kflRqiOUFhAhsyNGGkLM7Emr5fzvb1xAHx88cwRKTaXoA4UKhsRSUsT+yKon?=
 =?us-ascii?Q?mx8qew7snZ/Pu9yw3mwH7V1MoX3FXL+SjTTxFndg73ZaZoL9fwp+uZUi5zZG?=
 =?us-ascii?Q?cmlWPrZ1cldnLOqraSU2rXAphlUey+VwtKN9YtU/M0Aa7IncBsBQTpfjxetj?=
 =?us-ascii?Q?qd3vRBCHIZqDx4vygdC3ecA95waXYYXsg1zu6adiwSjTHJFDlZe7YyGPKRjd?=
 =?us-ascii?Q?wenNYGR6XoIu5Ngb+56rGRzyq1z52Z68jZ3S7l2peSA2+xLk+Ja4w+w04rA2?=
 =?us-ascii?Q?Esnnz2llK/PxyZfNib8Fxk2V+ei9akElQpe2nSPqlSmpXflBfmKn4kl7z+o1?=
 =?us-ascii?Q?b1CAa21haD3pM+ocYJNSAqtfjG5SNyGgzfqpEj6GNLC+VKBOfs4xLwdm/gSO?=
 =?us-ascii?Q?zTJH5QZXPHVOI2OxQOXgqru0d2OalMCuj48FKoNOEvPZHM/vMq3xVyIXvfrF?=
 =?us-ascii?Q?KbAyO7kLrnpeSxA8oBLPnH9jSoZIDZvsQAprpDD0WpkJflZZPsBfvXrfqta5?=
 =?us-ascii?Q?qHD8fFmemMp8ez5woOco8wU53NsSyxU2xXD8yMfaKnQoz7eRjxuN8dw4N1qv?=
 =?us-ascii?Q?OLjk82u9bas7qPBRAIXDd0MsRUOB2DuPkNfjGeRTRu3jomC6dZsrT5la0W7Q?=
 =?us-ascii?Q?a9AX7cRhkT95fyFGZITA9EtZGYlsllsf1mQ+rb9ig73slZD58ARwnEOjvZC0?=
 =?us-ascii?Q?YdxaGGLU+/VDYL7Zrij3cMZ8Ip9bga0PEn7poZxf/3veqAuiH0noPmHvfhCP?=
 =?us-ascii?Q?JxIzMkoGdwBeE4EoW33pFc6ZNFLBY/4bdQKLta6WfrzuPDrbHB8h/zBnnUhg?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c13b05-688e-4258-3928-08dc79729933
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:47:08.4389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbbqzdDf9HunoS7coHA7R49CAJ5g4DBZOwrWniawCIEQg87S6ewhfdhBNTVPpcRqXsACLBNqkqk4+/ZK9Kw1aMVi8jSGCFZuIxGNPOk8s48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8709
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

Currently, the cyclic_register() done in wdt_start() is not undone in
wdt_stop(). Moreover, calling wdt_start multiple times (which is
perfectly allowed on an already started device, e.g. to change the
timeout value) will result in another struct cyclic_info being
registered, referring to the same watchdog device.

This can easily be seen on e.g. a wandboard:

=> cyclic list
function: watchdog@20bc000, cpu-time: 22 us, frequency: 1.01 times/s
=> wdt list
watchdog@20bc000 (imx_wdt)
=> wdt dev watchdog@20bc000
=> wdt start 50000
WDT:   Started watchdog@20bc000 with servicing every 1000ms (50s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 37 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 241 us, frequency: 1.01 times/s
=> wdt start 12345
WDT:   Started watchdog@20bc000 with servicing every 1000ms (12s timeout)
=> cyclic list
function: watchdog@20bc000, cpu-time: 36 us, frequency: 1.03 times/s
function: watchdog@20bc000, cpu-time: 100 us, frequency: 1.04 times/s
function: watchdog@20bc000, cpu-time: 299 us, frequency: 1.00 times/s

So properly unregister the watchdog device from the cyclic framework
in wdt_stop(). In wdt_start(), we cannot just skip the registration,
as the (new) timeout value may mean that we have to ask the cyclic
framework to call us more often. So if we're already running,
first unregister the old cyclic instance.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/wdt-uclass.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index c88312ec721..12850016c93 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -121,10 +121,11 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 		char str[16];
 
-		priv->running = true;
-
 		memset(str, 0, 16);
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
+			if (priv->running)
+				cyclic_unregister(priv->cyclic);
+
 			/* Register the watchdog driver as a cyclic function */
 			priv->cyclic = cyclic_register(wdt_cyclic,
 						       priv->reset_period * 1000,
@@ -139,6 +140,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 			}
 		}
 
+		priv->running = true;
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
 		       str, (u32)lldiv(timeout_ms, 1000));
@@ -159,6 +161,9 @@ int wdt_stop(struct udevice *dev)
 	if (ret == 0) {
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
+		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
+			cyclic_unregister(priv->cyclic);
+
 		priv->running = false;
 	}
 
-- 
2.40.1.1.g1c60b9335d

