Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33874CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF30386BC8;
	Mon, 16 Oct 2023 10:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Zip52fQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217DD86BB4; Mon, 16 Oct 2023 10:36:17 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D5986BEC
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:36:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMQ2ZzmfJhxqpTc6IVIoSfBnVBQEzjD681Vhn8Uci+VX9vt4/WDchVYnnVGa1VJCGnfkS3/fsjNsGYn9rnBWPPgjlRYN9VN90d23f6x0njtnzKGCAAdVR4K5dLE3a4vuFustPHE3dVKJNiI79TqDQP5oPdHH8rFHTLLSLjrXhX3fnW3pY6W9zRNieCgka0zVkadSuGbx2w2kx2tVBMtBmhVPZvH1Lp6WEPRJzLVfqf557cQ5f62x4vFisHKa28E59qOM7JINQ2C8+DD11r2ix79/oZNxVx8OSm7jFePh3LbvIVZa+dMyxE8/+ivwj0/fqbSX5nlWHLFV+X41oE3ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJjn0FKORMk8NphPMZ2Fwaf+K7ZQKbREBpbhGybQIXk=;
 b=EnaTj+vHla05vTPyS3fWN2XmKCxRDP+XwsheCAzibmXnYRAwEd4AsktTttMv9pgkq105cXkixtqP2A+n7OhvaJD5KXRrzzQGg4dm4bcQ8xIJtwi1/SLISCOEt27vnuvYgOp6qRn7xfVUMLTUfaBmaCogfKetKj6BBupIhSnnyK+/gGl8/vPJREOSlff3ACWHrTQOkoFxruk1zT1qk2zV/LMkg2LrO91H9lBkwcCyT2DzcRln7AfksISl94We/mvbtXZBieT+d+O7YPY9A4+By7z/2MyoJz+G7ILi7vzgx5iiP7iqGIXbNMwlhWrHDJME2dk7F27jlN7tm5BOxz9zvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJjn0FKORMk8NphPMZ2Fwaf+K7ZQKbREBpbhGybQIXk=;
 b=Zip52fQXi93qxqlNiG5ehHZvsexuVE7JkauGbaEiiBxbGFpUeD74g4fbg5lSsW91rn3fu5VT2ynQqVHhg/oLpBFp6D0yKLyo2nOM1Xkiu60ZYNWspbvLgu4tf5QrTIBt6nFhwEpNJmP8g6O5BlMI9uRavK2Fm6WViayMrhVllCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3236.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:184::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 08:36:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 08:36:07 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Michal Suchanek <msuchanek@suse.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 2/2] serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE
Date: Mon, 16 Oct 2023 10:35:22 +0200
Message-Id: <20231016083522.945453-3-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: ebf436c0-66eb-4921-1a6f-08dbce22f0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vw8rXd0as9df0hfD68D75N4oyPdZimnxZZQv3OdNevmXuxlj+kTF5xzaS8FiObnmqNaCPsMab6+yz5qvw4db27+nGn5oA3+Y8dPI9lc/91cWboI2nETE4wpIHRwTjP7gRakFRt+a6acHd9nTXp5hz8c4FbV+ElWeUT6Dwtw+OyAZFUoylFlWYCdwMV0up3WmFAwT5xdON0p+jH2xngJHsYaX06XhcFscXBlfN9OieIpAqymHKlVnU6ktcUOsxDsgQb63gLyN1P5DlNhWpm1z+gI8krIStzHE46oG4E9GqRlXhUnexkyBRRgwh6g5+C1o1a+nR6nnia5T0kHYlSX9HXufdFtnD8GCMDj90bLkHoYYshR5YHe2Xg/pipE8U7HknwvM16YJuQvrRTNLU6ZAtig3SV+/UxiZPsJlCWCXTaFOByo1Gik1TSRUVaI0TeqP9LAcs9rIr/lD9k0nBfUe3m5X1kPi+IrgkUoM8iO+WTprxrZX0OSIIOwl32usS7Zn46ClUs6VzQot+6s51cqahSIp/pogREz+kyHRPXe7ELXvDYFryQVwW6KwVmcYyksQd+ZRZEXI4gibLpguC2zkAPaP8Ti6Z0m6AEsz8k5LZeZSCY4cTGO8MUjuKWWmYzm0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(39850400004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38350700005)(36756003)(6486002)(2906002)(478600001)(6666004)(41300700001)(44832011)(5660300002)(6506007)(52116002)(38100700002)(107886003)(2616005)(1076003)(26005)(66946007)(66556008)(66476007)(54906003)(8976002)(6916009)(316002)(8936002)(8676002)(4326008)(83380400001)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A25HueyAsBnptf7R1RP6kvzhYbWDX1aDNyfbdPLNrFEgbzuUcZM0z4NlzOUB?=
 =?us-ascii?Q?ZY1e3pmGDZcTq+fAyU3LTJcuoBywhl7YTWcA8py9oBHmm3Pym4n/pAGzeyV8?=
 =?us-ascii?Q?Udwy7FuCyLUMbwoIoXfEDQrMjN31VWHnrnWOgrukXQGSHblt4W4H4cLsk2Oi?=
 =?us-ascii?Q?PQqQVWRiyL9fG9QHH6F/AKj0iwN0BXCQ6j/JiP5bqA9WCVFESrt7xKgoum9b?=
 =?us-ascii?Q?lZ4O6vBOyMoD9NSoGT49uXbGaWf/HjyRO6y7hQNzwjyW9ZW5sGNh0h6+E56g?=
 =?us-ascii?Q?0JOFpL5x3nKCUfxoaLh/G1eqmSUc7gy7CEMzWfhGhS9PbABvRbzl6y39hlIE?=
 =?us-ascii?Q?xa7Dh7e1P70dP65RYXb4OEat0Oq6CMuCK9ruH7+Gr0SDbYQSFE9HmU8kPyTV?=
 =?us-ascii?Q?6PnSVaIKSLPyOtNION8R3o4Im3P/9EnW7q/1dhbZjB+wKLfZhlw6j07/KPcF?=
 =?us-ascii?Q?J9yp2GaP2yxSVmPhx3wBngWkThwDXe/b39esrAGwY6GxFlaW3nt76h8nnuiy?=
 =?us-ascii?Q?9ZyxL07TfzMbt4bxwKigAh0Gde40n3FV3KOaZyTo61nE6uUwsVOj+BVaQ98X?=
 =?us-ascii?Q?dJULBalSPpuLEaBQoKtymR9GtLM3zU0az0OJxryrLwKP9v32EdHfQ+4PgidN?=
 =?us-ascii?Q?Hav9OZKCYd5F+TBADRp/IX0DkUgtMBj7yyt12zx+5s1A3tV86+q85zNiWDNR?=
 =?us-ascii?Q?zH5TT6QNTSlwYbppXlXtFKiHXwmXUWZafcMUj0jGD0dsUw+ehyJQXhxHq92g?=
 =?us-ascii?Q?REsMHt3Jh8wws0dd8E5d4nLdLjKlF4Yh8DJCAnCv8R0qgAei0QuXo20Fc7wu?=
 =?us-ascii?Q?5DRWXDHqK/iV3kp0QR+/0dFHy7KgeOcKXpB4URfeN7l1qISBTEZUGooC6VDX?=
 =?us-ascii?Q?+nhvKiwjT/0Ou/KrOZ+KUYuFoP8w8opcgpDayGeJu8cZ9g7gzLLzV9gU6kgq?=
 =?us-ascii?Q?B0VAAVLYjCfY9b38oU9FG9a3qHIR2hD4qE9nTJkPXLIYi2M2xrHQKDSGOMKS?=
 =?us-ascii?Q?vX2WAAaYPZRZC79T5BXu2GdiqICPPHIgAVRFhe33eHi+B+OScoeK2tFaUlRI?=
 =?us-ascii?Q?9bWFYrg6b7OzpT2/DT/pTGk1L38xSIG7Wno+9lV24bo6XjG4dJkX1wmZxCQf?=
 =?us-ascii?Q?22y/PKYAwFEn0shVwj1DXmffkyQWU4ZXN0OUzNecBapyVfvzHoOB+LzRjvxu?=
 =?us-ascii?Q?2xcAyET/YqZzP+q4kGZ1bGEWq0gmMcVV0RlQj2115GPfvDMk67y1AnpZkqrU?=
 =?us-ascii?Q?XIvN+IufGRXOIMFvOKFEFK7s2/7qzsmeCGmbDsdE3f6VipGLalVR+BRYi1jW?=
 =?us-ascii?Q?9TJmfoEGp9EOymiOMmB9FkqwGNCTA2hH2uPXgmMy4UA94qsdbCJsvsQNY0bo?=
 =?us-ascii?Q?cJLTX6OBdNsyT7BhrS9QUp+6AEYA9pmiuv5/c1VFRC+qNq8hk44QzqaZW62R?=
 =?us-ascii?Q?sQQGF0W1uILB9CbLYj2GsLsgVvmczGWupxb90o4oG0k0yqAnYl82FfAQJZoB?=
 =?us-ascii?Q?xOUfuayOhiRxQs/XuuQkRSbvsdmOCifXtO/+duqZuySY1xgpp8ecto0m/te8?=
 =?us-ascii?Q?hnsYNHhHjQr9mQm7lIKgaBTO6XC4Nq8CORqnC0XPsNH1sNMa2TLhYC0uw50s?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf436c0-66eb-4921-1a6f-08dbce22f0bc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 08:36:07.0551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mc9vIcB5g44KqMVp8xJP0ORT+uCp8nwsl1acIZHv9VQeLqcHGXbCJzUdkP2yc34qt5kykV0IzTUNlHp9144axXANQ87ajFk2T4zvPKDPRDw=
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

When debugging, one sometimes only gets partial output lines or
nothing at all from the last printf, because the uart has a largish
buffer, and the code after the printf() may cause the CPU to hang
before the uart IP has time to actually emit all the characters. That
can be very confusing, because one doesn't then know exactly where the
hang happens.

Introduce a config knob allowing one to wait for the uart fifo to
drain whenever a newline character is printed, roughly corresponding
to the effect of setvbuf(..., _IOLBF, ...) in ordinary C programs.

Since this uses IS_ENABLED() instead of cpp ifdef, we can remove the
ifdef around the _serial_flush() definition - if neither
CONSOLE_FLUSH_SUPPORT or CONSOLE_FLUSH_ON_NEWLINE are enabled, the
compiler elides _serial_flush(), but it won't warn about it being
unused.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/Kconfig                 | 10 ++++++++++
 drivers/serial/serial-uclass.c |  8 ++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 93c96f23b0..43701fe9e8 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -224,6 +224,16 @@ config CONSOLE_FLUSH_SUPPORT
 	help
 	  This enables compilation of flush() function for console flush support.
 
+config CONSOLE_FLUSH_ON_NEWLINE
+	bool "Flush console buffer on every newline character"
+	depends on DM_SERIAL
+	help
+	  This makes the serial core code flush the console device
+	  whenever a newline (\n) character has been emitted. This can
+	  be especially useful when "printf debugging", as otherwise
+	  lots of output could still be in the UART's FIFO by the time
+	  one hits the code which causes the CPU to hang or reset.
+
 config CONSOLE_MUX
 	bool "Enable console multiplexing"
 	default y if VIDEO || LCD
diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 8bdcdd1eaa..df6a387284 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -182,7 +182,6 @@ int serial_initialize(void)
 	return serial_init();
 }
 
-#ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
 static void _serial_flush(struct udevice *dev)
 {
 	struct dm_serial_ops *ops = serial_get_ops(dev);
@@ -192,7 +191,6 @@ static void _serial_flush(struct udevice *dev)
 	while (ops->pending(dev, false) > 0)
 		;
 }
-#endif
 
 static void _serial_putc(struct udevice *dev, char ch)
 {
@@ -205,6 +203,9 @@ static void _serial_putc(struct udevice *dev, char ch)
 	do {
 		err = ops->putc(dev, ch);
 	} while (err == -EAGAIN);
+
+	if (IS_ENABLED(CONFIG_CONSOLE_FLUSH_ON_NEWLINE) && ch == '\n')
+		_serial_flush(dev);
 }
 
 static int __serial_puts(struct udevice *dev, const char *str, size_t len)
@@ -243,6 +244,9 @@ static void _serial_puts(struct udevice *dev, const char *str)
 		if (*newline && __serial_puts(dev, "\r\n", 2))
 			return;
 
+		if (IS_ENABLED(CONFIG_CONSOLE_FLUSH_ON_NEWLINE) && *newline)
+			_serial_flush(dev);
+
 		str += len + !!*newline;
 	} while (*str);
 }
-- 
2.40.1.1.g1c60b9335d

