Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD0ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455D0868AE;
	Mon, 16 Oct 2023 10:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NWxFlm3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4849086CFE; Mon, 16 Oct 2023 10:36:15 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF488656E
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcP/yg+gAfq4JxFyCJ4mZ67aE3Z3lTQrZfn6bbIAoqCTaT8KDpH+C0UvUvaZuQdmrNXnvzKIk+xjTIgOZwcnO31RBBMcq8OUlIeBLJ32gxVSmH/UZ3w9ARwVlfscU7jQ/QdGrRqsNDk5LsGx0VqFllk18KP0lqDeqacEP/Y5JJbCAS+dJc3qyvE8oyQCdxSyUX2AABXHUPbW0N55UIoZN63YhneaCNVHlurqBNykYiAhV7dM5hSROPaFh6bYJ37FNniPDk4aKtmfRx0euo4OEV3RDrmcNOsOC9nAe8x6lSct3qscqM7UF/FhjKEcVybaB2YAdumb8up76T2R0/f5Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWVShrfGRA1bXHJSaoDXiRUCB4qGAQjAq8rek0p1uL8=;
 b=Zdf7MQ1m2pKrWO4NqoPIaE/PB+AT2MoGyhR8ff9fIcJYgfymD3+npTREb65Za2w4l44uJNNfx21PHtAp/LgMdgGYFuFyq26azVKRpW91XnaF6vbnQFfDfAtn0gC0qn8hrobLZ3/JEa1GbuGNOLobRXijCsAe2z0mLuHy+WzCJpabQx2kxbq9qnMy7NouEcgq9HPZY3sDOqHyzdagcrYr4crtqIbvBzDtiMUowjC8JqH8KSBxvp0Ln0m8iqUe7BqakXQqqQVKIlnP2XMMQl4SZ9REGmqSd6liEUONtwwIPaP4PtXkQ4KsprOhfro7m1LE6gPDvwu8lh+KnvKPumzq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWVShrfGRA1bXHJSaoDXiRUCB4qGAQjAq8rek0p1uL8=;
 b=NWxFlm3JzGwdNWNXTEXUWCfycPXib2R+IXGPaaitOwBYDp6rjLTizUAdZGndCG0YaHaMN8t30NeYic67f8EH8U5940F3X+fyQp4AH9It7s8QENkuZDkTJlWtFyWjr/o6vKAtTHPCdaCo/oDEiJzfBBMs1e5ahNNJI6Eg/oD2KqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:36:05 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:36:05 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michal Suchanek <msuchanek@suse.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 1/2] serial: serial-uclass.c: move definition of
 _serial_flush up a bit
Date: Mon, 16 Oct 2023 10:35:21 +0200
Message-Id: <20231016083522.945453-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231016083522.945453-1-rasmus.villemoes@prevas.dk>
References: <20231016083522.945453-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3236:EE_
X-MS-Office365-Filtering-Correlation-Id: 673aea5d-2e7d-43c2-8137-08dbce22efe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +rNh2+3Xk4AjdnBcIrbzbbrAReYq1TBCfeJFYGJlwzn2bbGpM+WtZTUWHAenDZlNMSIfeMh9b9N6kCMHfc8ylhypb/8tjuj8VZ1jdZTGAYv0ErfU7YaNBldZU6nFhatfTRKLkjVs+eYfANxuX9d2u2TzU3djxoQotPYz/uHIQZqhnusSpAvQ/ojfpFETDFAtZ2gE/rm9tuMBAMB6qN010D3LO3iFIuvV6/NX+0NqYQMrnYzYqz8/SR3w7bkI4VufDI5hnjmh7iYrCNyadDXxtgHD5SOpRydJTR7QMduN2BPixXfyiVQ5yUuC/GWfMduoIbT1fNA1+gyuefAyNd5kM7jqv/oJDU8Hgk1bMJpRMlayzuZ/SKMdeCww7N3vxlnZiH+wL4xK2aNebOP2+kA2lvbF/+rKRYVz9piKW1pkdJD5b0BcHZEjXuhdGEgR0Ss7gPCihl0C9Qaah0ukLKu6BWB8kpYyajYycokqxY5M6B3NIIVdGG6MJCWBElQgUPpQhSuKjcMfyXP5a194xjd1QvZsp0k5KbxyTrgFEINuhOP0BLqo7FEjbfp5QDGlbfiia8CjzSUB23Qo2UWrIX84WSQn/G73uzmGBXeLTeVtcP365nPmXsH+DaxFIL+PZKiH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39850400004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38350700005)(36756003)(6486002)(2906002)(478600001)(6666004)(41300700001)(44832011)(5660300002)(6506007)(52116002)(38100700002)(107886003)(2616005)(1076003)(26005)(66946007)(66556008)(66476007)(54906003)(8976002)(6916009)(316002)(8936002)(8676002)(4326008)(83380400001)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Z6ZDnIssu3k0ozclpuzt9QPQIOzMH2X5oIpD63nz86Xg3676NH//FibUCdV?=
 =?us-ascii?Q?nO49oz0kiY1qOow245cIpzxvmJgdybBhq0C1vUyBlH7zIH2MLqMAzo6G13Yd?=
 =?us-ascii?Q?f16W9CCcYvI2pqVOFHnX7KHk8BJcjIAC6BQF02+YTXBLStVnONnskVKilSYt?=
 =?us-ascii?Q?/P73U61o9TzTEhLXfyw/ZKWSbvnv6M4lK56ZLLYVPjLBOmUQZQZhJ2ZXpHzg?=
 =?us-ascii?Q?lAkzz0Qk/nwCLJqO9rU8YNRw1PYZrEybFYOBI+GFtMhXsDmZ5DhpO0PHg4LH?=
 =?us-ascii?Q?zZaRxD9TL1PgWzexf92dNqxjPVOocwdShdLVgFSq4N5JZFA2msz0uGuO8gDS?=
 =?us-ascii?Q?84VsfZ0EC79YVAn6afuguMpjq1nExFIQh3RmqJbbwz65rxvHS5lPCSitHwx9?=
 =?us-ascii?Q?VDQTymraPHzw61q7WCkBGtVEoo0DpcxboGRL7MwXM5q08l+oTbT2Fxb153+F?=
 =?us-ascii?Q?8TbAQj7iUfqqJ6MoClN3ntUAMynUy4Bwqma4ufTcEQBnxZb7TGjOpcIpY336?=
 =?us-ascii?Q?M7wUOgx+TZboNvHh1gdA9K2slxVFQlhNTbmIrV5Vj/mrDTdbHBMxF1NdIddF?=
 =?us-ascii?Q?UcP4atYFY8NXUzNxTW6g866lrY1bZeE534kvQADt19nradaXSXSSiDh6pafB?=
 =?us-ascii?Q?y+dP1NIWvgm5xqNHqUcqwVlfHEodlUbU8aQ3L3B6YDlSbymJl7rZm1GbfSmn?=
 =?us-ascii?Q?tOn2jn3hY3Uix5lgNks5fXNLfoceV5DXK5H5kvm1AYUPI0SbAUYu2i5ZmeCB?=
 =?us-ascii?Q?lUwvadPxF9wgziYcsHMnEuzaIz7SQrpHi7NfeYW+cVBLA5/cNIT7LO/fUk0Q?=
 =?us-ascii?Q?6xCUyTIElEjQLD5G0IMYOOfxJ37Q0OokSggQxsy1DSIazMLAPKaAPFx7OEJw?=
 =?us-ascii?Q?DwHBOocvU7K+TEEAYsXXqnCqazbyfNF5ARiSOXANn8RVOO3cCLbFjrazH8JR?=
 =?us-ascii?Q?VelQkF5QT7k1+UHl3qXURDcJKffzFtdkM2J9UGBy9fw1jYZwi3ZzRN5J/i8/?=
 =?us-ascii?Q?QlykgZ3M9jIcuBqroH+djf6f4Tl3uR2KKWkIBhtrimAmlZ1FxS1ZAg0ffd3h?=
 =?us-ascii?Q?Kd9VDMHnm3NqVQqCgMSaV2KsNCF/3Eq9IOGvEVMFujlqwDbb24wxu/3WO/it?=
 =?us-ascii?Q?gVCYj04GmrgMTjQ2HcGEkY+fvcyxRXqvMiAnM54xAuQcoNe8+t1+Qxf7uSOS?=
 =?us-ascii?Q?1o5uBt0mIf3JZwK+BiwilWBGwHkaDpaOZgBFfodcSO5x5uHdZ/tL2ISdJDwd?=
 =?us-ascii?Q?NVmLEIFHlV+COYCMCIeoXn1ZjMwjJlcmchVOMR9pa+vm+y0+HgdeqSLx/ehM?=
 =?us-ascii?Q?29xZwjCpn7DA0eHuogKXOpDuPQRBuxCOvH0PsamHwAPCL1jG5h4BjpsCy3g5?=
 =?us-ascii?Q?jfRNB2HaB/cw65X0qjwQtSx2cosLbOTLORE3YkXkAHidlXNa1j2faQ2UkHEw?=
 =?us-ascii?Q?Sb5hxlt7N9KJw7TwmIe9Ze0HfV21z7FK/K7Drr1Gp6zsoOmoL7w8zUQ4i7S/?=
 =?us-ascii?Q?KCMnJTDspCJuMe7FRAYCdE3Wiu9DU+buHxQ2mVlxIONCD5ASPxnHgRC0i5oi?=
 =?us-ascii?Q?bvMuO+OtU3ttyI3hD9GWhArk2wMiY35cWp4WZ6nAlAzO7h9HVxQTD5hcyZti?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 673aea5d-2e7d-43c2-8137-08dbce22efe5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 08:36:05.4947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzJxnox++jCm3bnQwY6rrDgp6u+Xy1UD9tKRP+im4lVJ7dMAesnY16xh5jTt0IwW/EOlgjyc2wBtC6CpYXDjunIqPWyxW2JQpno7icnUTJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3236
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

Preparation for next patch.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/serial/serial-uclass.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 4a2da7a331..8bdcdd1eaa 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -182,6 +182,18 @@ int serial_initialize(void)
 	return serial_init();
 }
 
+#ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
+static void _serial_flush(struct udevice *dev)
+{
+	struct dm_serial_ops *ops = serial_get_ops(dev);
+
+	if (!ops->pending)
+		return;
+	while (ops->pending(dev, false) > 0)
+		;
+}
+#endif
+
 static void _serial_putc(struct udevice *dev, char ch)
 {
 	struct dm_serial_ops *ops = serial_get_ops(dev);
@@ -235,18 +247,6 @@ static void _serial_puts(struct udevice *dev, const char *str)
 	} while (*str);
 }
 
-#ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
-static void _serial_flush(struct udevice *dev)
-{
-	struct dm_serial_ops *ops = serial_get_ops(dev);
-
-	if (!ops->pending)
-		return;
-	while (ops->pending(dev, false) > 0)
-		;
-}
-#endif
-
 static int __serial_getc(struct udevice *dev)
 {
 	struct dm_serial_ops *ops = serial_get_ops(dev);
-- 
2.40.1.1.g1c60b9335d

