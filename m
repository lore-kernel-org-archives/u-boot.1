Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF96FCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 11:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9CC786C16;
	Mon, 25 Sep 2023 13:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BG0p7Wxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139C586BE6; Mon, 25 Sep 2023 13:01:15 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7652A86BD3
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm52xD6wUH5XBh9g2THnBl1M+moMcmljfbmZoNGCzlkeVpaf7ppRCOgR+mXSUCS7oXbUd1RKu3ogokUonM+0yOtO+UaCMZmHdQQAWcx1/CGfjq4BzSM6MNzpHviCUxxXe6BhrO1j7L3PqnAybJMncLd8c318xm6Km64dNyqBZTPmf+tDEPGHdOkE7pb/GMdXB63tRAFLk3mWvv89pZ3oROxDNrsrZzXEPC5fhSHLwfQlGOMLSmOwzroVvp73v3UfUuAx3O4RUK0iyT+eFbqdUHBWk0PCObwQPRkmVYLiG0t7pZT6DrrdrQakHZSv3IiTKWrkunwIEQxyB4d+reBeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nIAJ6UzG1YmMhmDkBgBOK4FPePEHqhNB6YHvhJ761I=;
 b=gxetNyjj087or6nXhWLIebBPId3rkgPg0SZ6cG/N/tN0afPFd9NtMGKfGMlqPUf0ViRrAdsNGfVL4IujXjugwMwKwQPpxNFnNNOImfHTjtauLh4AwLO7HxA4GIOnEeF7UJumBLZet2qib8n5/mrAjdlti27iQJuXhvywlg1cQhZj0VfAXslkQar+j1Iu864QaNB0pkQnQY17JelMJrFpi6BsMNAkepoeAszjEg+pFMvKC94yd56lYX89jMaiYSsFp3FN5dNTmYh0racpRb02LHgQERbPG7WVGllCagMDGM8+Zdc3OerkJGRuhii23ORrLyaQ/b3kiYmDYHGaQcbYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nIAJ6UzG1YmMhmDkBgBOK4FPePEHqhNB6YHvhJ761I=;
 b=BG0p7Wxvt+PE61URB1JGzR568PwWwuNPgNy45CExtLU2tYvFW29RARBWHEdLd/ilYX0PAR11PU4UPvifjKKTsHZ8/CeJh8/ARU06IEyLnzyn0peXu+QcEMqTIUgsCvqTXVS2CBPkgcLRuTFo7WZw8Q/zwBkhZh47/FXS7FqCaOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB6060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:01:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:01:09 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Suchanek <msuchanek@suse.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/2] serial: serial-uclass.c: move definition of _serial_flush
 up a bit
Date: Mon, 25 Sep 2023 13:01:00 +0200
Message-Id: <20230925110101.376878-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230925110101.376878-1-rasmus.villemoes@prevas.dk>
References: <20230925110101.376878-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::13) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be5be39-99b1-43e8-cfa2-08dbbdb6b975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfhM9OYa4zdrmmWUvuuLHdRIr7rbwjLSO8xSkRfjRsh56u5CtHSKXfao66HwjZlbwF9IgQqqe+y1gz/oSqqPnAlwglXIWjfy9IcLaXYcnxHVu0e08yqBP7DYfdzJFcJq0mf4LQM6JyIEHHOAKdp8sUa1TlvQzU3YgPkbTinp7u4Onnk8ajcCvQ5WyVuWW3CKPJy8uJNZVFv+ZKsmgKDvi0cnMvNWJEExJK5yGEKSprWQNcJticWJUwPbDbvZs4OGdGKkH2y4UrqNxzckC5VCW/UKhs6GPZrvd6WANza0I+bPM+otei2ji3hlMML08YSZaiTemGdJKTKktPKoz26/e7KnFcNAh5rhjSN+TnPEsK4z/DaQXcJ55PfTXwmYok6bvK6umdea2syPjCkRE9AUNvIdaei18Mj6tx432i7rFi8CPQvlspq2e09EpFSdxJNv+Iu2or2yNvxNKREMFJ5iQewHQhJ4q+gNONtxky8SOELYr9roPa/44te2wAQ8FLlQEx2JOQNA1es6HxpqncLJNY5SSX867FiWcPTGbUw90eOKAiVXhJDQX5OmcdDa0KDitMwi4FeeDpc2ALtDvKNEHBWUzvp+/118/XJ4PoVGgCTFl9XNVcdwjL6KMFqG+gvk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(2616005)(107886003)(1076003)(36756003)(86362001)(83380400001)(5660300002)(6486002)(52116002)(38350700002)(38100700002)(6506007)(6512007)(4326008)(2906002)(8936002)(8676002)(41300700001)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(8976002)(44832011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2P51dqv/bYnhGV4CssLyc2PJmIRJzHrHQKzblLJvp9Mh6l23uoMds+jbpjN3?=
 =?us-ascii?Q?sOunCfaMLgixZu6zKB8WnKsfZ8+P2y/gzK1R4ZR3slt6WpmTHVA8P4ficJt8?=
 =?us-ascii?Q?Ic6RDDSgva/EXvxwXHYOaWeaE8SI18VotWnVGRileA/0jSYdkQxqS8yiwhWn?=
 =?us-ascii?Q?AfFhdTBICoh8m28r0gi91IPkXSMmGJ8qvdmtYhEaSHad3mimEDXEwzIc7k27?=
 =?us-ascii?Q?aAIQgcKZ3IDzRn0nypxd6g+9PbKqAFHIJUEM8YHeKAoeWl4GFV+w7fM7Lavd?=
 =?us-ascii?Q?21qFrqRcwdTOOXQvAtlOdnU7N+Rb0tvcFdkpbJ+owFQ4qHB14q56LZsuXn88?=
 =?us-ascii?Q?ExkcqHLRse86juQbRfwVt4+81/qt6vt0grvEkOCnD2qIufUsgINv0SsiQl4E?=
 =?us-ascii?Q?Gfd+IUSKRSowlYK7OwlzQOBftDqXN76bVGEoewY3SDDmVRl+tKpzdZpPimlU?=
 =?us-ascii?Q?r04Nf3+gRNHUY8SzUsefajMZ0TKJirrNFiLg5icIbtbi7B4PbVQGqt12qzMJ?=
 =?us-ascii?Q?1yaiGjBtC8KBq+dp6atlZDHsxjGqA5wxBDftaezucjsEH138Olth4Z+D6eR1?=
 =?us-ascii?Q?1yoh88WAnm5hQjOY5f34tP8qM/U8puvhxSXrkKN48dQZuHivkR2ymIIEinKg?=
 =?us-ascii?Q?P08nFekL3whjKE4p+4DETaHBfb1lE531AJGpbJ324sklhVSK0p6KKQ6cSlHA?=
 =?us-ascii?Q?ZtGAgEakMJk3ixzHNelxeHJo6AKK5FxOzlnF8QIm0h/145nhm98bYNxxdt23?=
 =?us-ascii?Q?90on27TjeCfRZDYHHhoTv6A2Wz2IUzoKgRapR2r5rsjAi5814Id8bc3V5bwi?=
 =?us-ascii?Q?jNG72F+uBzPR1JGfm+iYhm8/q21ZvZoZWifegWO+PTC0T1x1J+RqJ+kW+kzt?=
 =?us-ascii?Q?Vi5LxJhZ4wYBL7hdX0BziVAPVCPkJVD5aLs5TAbOMShlZ/d+rsjueyIlI4PP?=
 =?us-ascii?Q?ANEmVVCX5uoDIhLmvMApjIPAWSWWfNzOc3FZIOqaj+eMhIE3Ctxf5TCF6v94?=
 =?us-ascii?Q?+LAzuh9tECR1g/dDlXQ/JAgOdCvE4ft2cl59QP5yLinbrA+sbpTbRXHwhPm1?=
 =?us-ascii?Q?N7SB9yIfBZQrhVwWAZksTAZlQjgUP/gheU4+Xai6aYFG5CGhKYMr8bZor4+N?=
 =?us-ascii?Q?K8Sug8A11p9fNPmGPJf28wx7iU4Td43AkeahVGwLMs5I1WTni9CnwxSJMpql?=
 =?us-ascii?Q?LSIn9oZZx/4MYgnUfTZy/06fYrg1NqjTmi5qGEsEzMPB1hGaZPegWW9q+tD7?=
 =?us-ascii?Q?1D2XlraxxAIfL06YRkzukBaD6h58q+na7bTdrVJ461gpWhy1k+7qCJxIhJWj?=
 =?us-ascii?Q?Z3TJENDH74LwcM3X1ylmJv41yozMBFjoRNufYAHxg+6sbCEjvC5JNc1wR/JM?=
 =?us-ascii?Q?jqMiWM3ghifFXjAhrKhMwCRWkmor0zV3BB0UYlI2D3TkdJ/+sUU5yYhtOyYP?=
 =?us-ascii?Q?r7uTkBz8Y5AVQW+hjtjY3tGtd7o6ed0sy74A4BamNG/zUg5lT+I4HEAlzxDv?=
 =?us-ascii?Q?PH9TGVnwhmdcF6LruSzP0ni8vyNdNbDdD9QE+7F+SZ0Q6P8HcWX3RECDdPZ+?=
 =?us-ascii?Q?Z6l5LcgE4OaLVEaiPL3iDwoFkMWCmmf2Nd6tmITrEqfEKiF31RdC5BZBmwGw?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be5be39-99b1-43e8-cfa2-08dbbdb6b975
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:01:09.7556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+v9fQx1cvmvP6uebc5cmVpSqzYiBrM1169rn+Gm2EUu2Z2roU1wgz05sS9X/7hksmrx+l0WAd4GarA810MqeQ4DYhbypOO3wqVWHo5XCTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6060
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

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/serial/serial-uclass.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 067fae2614..2f75ff878c 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -181,6 +181,18 @@ int serial_initialize(void)
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
@@ -234,18 +246,6 @@ static void _serial_puts(struct udevice *dev, const char *str)
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
2.37.2

