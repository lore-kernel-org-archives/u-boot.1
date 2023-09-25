Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6451CCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 11:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B8D86C2D;
	Mon, 25 Sep 2023 13:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="FUvVH0E1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A5086BD3; Mon, 25 Sep 2023 13:01:15 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967AE86C16
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 13:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXcNaPwhYZHSGZYog6eX+hbFI8JfvYJtfBZO3H5L4NlG96ebuCCjLc8Hl7sQAWt9b7+VOiiv+uZja+aqXPA6taOdVbZ6jJmis8FAV8FQq8woKgcRRPzBOcSrr6NgAwneuPLA2IEkBzbvzAToAEOvTmB9DIs8LwXGXpiKqV7ehrRVBHzlPF7MN88lWCNY7EpWkI2UkDwCkEZ9s8DMBkXzQBhRm1iWgZt0fS3769TrE8zcdUkAXybWjuxuabYnI9wFQXD3UkBU2vGo/5nYSh/uB9StHY8bqWr2edpb1lHLtWQacJTtSWflBQvxsCizlXb2orrJhj5CmITKbncHX/PD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3augZv74EXfsoaOs37aGki083mFRMXoJGL/NR7nm4r8=;
 b=HyZo8R9j5YPedvYbNNLCJ+gMMuKRci8UZ7RuZX8ecVU0FgH+QHD6m5v6BSrpxWRzul7hl5GsuL2adUIUTzxAK5GG/lKwj05gFiVPK7xDJsgjbrkTVeW97JeNI5YoiArsMj9yflGHMszoMzIFRSYJ1NFXjCZ5yD6EdYdbqP46o73yIwECZRXW04xpUp1914pku+xIv3CaKv6QoX0QVAqzvujYsIt7szGE8HLjb/0mC7DKRR8r1iwdxvA+BmrtJM0xSgMjQfIMcJFxVmXaylfvBxba75XyZNkMz6nivQgKdmgFnqV9BY0XO358n3qZnB05+dGzX/DBe59kQMpYmKvXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3augZv74EXfsoaOs37aGki083mFRMXoJGL/NR7nm4r8=;
 b=FUvVH0E1W8JNlqZAwhj5BBkJbJvA4UZfJqpghGnVRPS10p7pJfHQgsr59t2aSZVh40JQxnTO2YYbkmuaU5jDemYhUx/6AuOOGxMIdMBHm4X2qxOePlo6z01a6AXv4H2B1LUlYseW2k1oFK3soJ5Y8U2r4d5P2OUqkdSPWbHN/A4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB6060.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:01:10 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:01:10 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Michal Suchanek <msuchanek@suse.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 2/2] serial: introduce CONFIG_CONSOLE_FLUSH_ON_NEWLINE
Date: Mon, 25 Sep 2023 13:01:01 +0200
Message-Id: <20230925110101.376878-3-rasmus.villemoes@prevas.dk>
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
X-MS-Office365-Filtering-Correlation-Id: debb1161-2d8a-4f16-a64c-08dbbdb6b9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxH2pZBSIWQaPl/5bELDPJj02muwcTJZ8yHksw/ACsH3vVAk7D4DeEZj+lIADArdI841q6csNsBZiq+Y4mtXMHbfmcYWx7Z2f/zn02kwE822Jovf3G4L9y6OV8iwjreEPmZY9ATfZ5uHn1pKfrvI+2BvO+tLZhBHeBu1xppGU1ylZ5W5nZk4IygNWvFzrBcRzXSni7FqExRvC///BlGifmx/swoFbfd0fuTEkp4ax/+Kii1wnKZGzKHwhXt0SGJX7Pl4iymT/jFPrcEhiQdvlXK1Rxd+k8MrCQzFL8prkufaqpfIpPbpZF5da5bANK128em/0MCCvMaSSzN2KMFHvbfizz6C8zKYyjLYZ6cF4P31Yd4Rh0s8W6ehU0XyT5N1+HQsf0rE/EVmZnEbDxyzY7c6iDkVImbsnFE+Di45RjcX82hfF1wYHV2Vm6B3HhFICi/5M6Voz8ZKsJmrh+VxlJPh9ALzEplmKlhb71NXUAlvs46Af6PuKwGYL7+85hVZQjSEnNU+pcWjXEmo7BQMvSXHSXyjzeyoxkoCLXFgaEBDC+nWsFslxl4K+8RaL+sYIg94YqsKjgy1lbe+q40nxLBFGDKAZrr4MQPY1U06zy8HQBPI51Dp6xyo3zPOouDc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(2616005)(107886003)(1076003)(36756003)(86362001)(83380400001)(5660300002)(6486002)(52116002)(38350700002)(38100700002)(6506007)(6512007)(4326008)(2906002)(8936002)(8676002)(41300700001)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(8976002)(44832011);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CuX/nOsxkAWedG96jGrJS3Y2wqQl0qzmymz5kfJbLVfN0uabvwTNoVw9cPG1?=
 =?us-ascii?Q?Xy8Hg2R02yVfMoWCpc8Xzt+izydb7XmzfjC9l7/TRlhKkO2qvm2Qx9uvrnGy?=
 =?us-ascii?Q?e1vXYwL/Rk9DQot7eUqDpkqYuT4TaHU+l0uQBhEvBmGSP9BzxguERDJFM2xh?=
 =?us-ascii?Q?4SiJT9skCMgdLf4jOnSvq4Szd2yZ2c46OvHertceNMAy9LUFAXHMAvbo98kI?=
 =?us-ascii?Q?Xad3bDCKWK7NLcIBh5XooKMSobYYa+ofHw3MnpZFF/n6Q/T698k6UajRNDfd?=
 =?us-ascii?Q?N5p7fLNWTdr76GTy47j1iRuvBNp9I8S97yfkS3xtNkesTs0wKFmdqbE8cP/f?=
 =?us-ascii?Q?xOO+jUqYz1c3BsGHgopOv74F8ECBvgG2aGy/US0P9sfJEa00xBXjBEZK+JmR?=
 =?us-ascii?Q?uyv9qyRqFMyq8GX7oiECKX3he8q6gDDE7a+2/W3XMj3nvbuKTEiuBEfEMku2?=
 =?us-ascii?Q?ICCRY4caAUCPIWC8y0PAF3vJ8fOzg2v56I55wK6YqSN0YVJ0YZNSbEzZoJP9?=
 =?us-ascii?Q?dRbJUzHtD6fY7QrTXxiy7+/BMabjtkKG3rtBPaGCoXgwYvJKXEh8OssOKSDu?=
 =?us-ascii?Q?lY50PZgaIS2Pm7EPHMs57YZwjxOWAqEkTt+RPdHxg5nKWSKZjbM0CX3/o2w0?=
 =?us-ascii?Q?CLdY+dbRy2eyp8PhM4M1EKqBMY2Iam5F5igY5DT/uLbtYNm0NOVxdF1hehf0?=
 =?us-ascii?Q?XWBm+SMXIqSeOljmO/EENAlT5sjs4bxLvANd8ILj9Nwo+VDXmY5/ZjqLBLp9?=
 =?us-ascii?Q?oIZYBIeAf6iWnjTFRQYcYkrd/7lEu4joDQweMqpQptthkQJ6ASxSjWLmZRI5?=
 =?us-ascii?Q?IQKAN8EJvh+RtPUan3BtyrJHHEwRqWzo7bdaUlpiY7+jBD+k39SoojCLI0Xt?=
 =?us-ascii?Q?iF6nwWfXzc7eddt78fXnIZMFcElRPctaMjkTpeNJL8orfWXIZpkyAURuu3RQ?=
 =?us-ascii?Q?+GBUzibAWSPSq5nJvd6azlgq+BJ7lJafa/Vm3SpOuZSCJr+sPLD/kJ2TJ0om?=
 =?us-ascii?Q?fBu0JWnseq/Yk9px7ts7J4ASxPawx0BpFxJBizGTuKAoLBIuWpj96TG2yMWE?=
 =?us-ascii?Q?n80+m/7NNtpMcL0DCGjfmvI5YLPA6GVL98Sdv/bzkv2VoEYsrj4bKQNIhhvb?=
 =?us-ascii?Q?oRQxBZtuUb5se45CjwIhPx4F+jD6ZSdx5cNpjrz0HA0dfELRZ9e8yMQ+I476?=
 =?us-ascii?Q?bMaDCb4FKK4qG8nzMiBmczrwm7ihKRfH5KVcRxLQL40K/q06iwbkmkhKWXUL?=
 =?us-ascii?Q?rrlLGIxLI34b6z6UjsMQ3b4IlOZrjw3bwHGIATLE4Vuf1BfTXL/hpYOxZzkQ?=
 =?us-ascii?Q?yjfWpssIFvty2DBH2/lRdMkrnPwj3DdR/asNjxnCsPSFy6nk8MX0ZmO01era?=
 =?us-ascii?Q?etASq9KE/N1c6djvw44HH8ZpXcF8QkNkLljZwwlsyH55xUJ2tu83iJsbFRcT?=
 =?us-ascii?Q?3iyp5xR3LZtW57fO7tj86V95c+7eA04mZrejo1yu27yRCpIopYl/OykbzoSn?=
 =?us-ascii?Q?poMZaAVlwttFzphTl93UejCUyQKIdUU6H4j8O95fZtOwTFE1IpPW65yrn5Bk?=
 =?us-ascii?Q?iPCbImAq4mI+8jkBBD0jBq/aONsZWc/7qO2RTzoOO0JnKZXg7allBp+89Ww3?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: debb1161-2d8a-4f16-a64c-08dbbdb6b9ea
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 11:01:10.5150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEv30xJcrYax3tM66fUvI91d+CJTTcJ4Zg4ibaiffXv5+dLypcbV3/cEuYmOphjFGLIIH+sWHvazYQGEHpf9Z9I4JHCqRQpyhYQTSd4w0hQ=
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

When debugging, one sometimes only gets partial output lines or
nothing at all from the last printf, because the uart has a largish
buffer, and the code after the printf() may cause the CPU to hang
before the uart IP has time to actually emit all the characters. That
can be very confusing, because one doesn't then know exactly where the
hang happens.

Introduce a config knob allowing one to wait for the uart fifo to
drain whenever a newline character is printed, roughly corresponding
to the effect of setvbuf(..., _IOLBF, ...) in ordinary C programs.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/Kconfig                 | 11 +++++++++++
 drivers/serial/serial-uclass.c |  8 ++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index cdb77a6a7d..49130f2a2b 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -224,6 +224,17 @@ config CONSOLE_FLUSH_SUPPORT
 	help
 	  This enables compilation of flush() function for console flush support.
 
+config CONSOLE_FLUSH_ON_NEWLINE
+	bool "Flush console buffer on every newline character"
+	depends on CONSOLE_FLUSH_SUPPORT
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
index 2f75ff878c..b41e3ebe7f 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -181,7 +181,6 @@ int serial_initialize(void)
 	return serial_init();
 }
 
-#ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
 static void _serial_flush(struct udevice *dev)
 {
 	struct dm_serial_ops *ops = serial_get_ops(dev);
@@ -191,7 +190,6 @@ static void _serial_flush(struct udevice *dev)
 	while (ops->pending(dev, false) > 0)
 		;
 }
-#endif
 
 static void _serial_putc(struct udevice *dev, char ch)
 {
@@ -204,6 +202,9 @@ static void _serial_putc(struct udevice *dev, char ch)
 	do {
 		err = ops->putc(dev, ch);
 	} while (err == -EAGAIN);
+
+	if (IS_ENABLED(CONSOLE_FLUSH_ON_NEWLINE) && ch == '\n')
+		_serial_flush(dev);
 }
 
 static int __serial_puts(struct udevice *dev, const char *str, size_t len)
@@ -242,6 +243,9 @@ static void _serial_puts(struct udevice *dev, const char *str)
 		if (*newline && __serial_puts(dev, "\r\n", 2))
 			return;
 
+		if (IS_ENABLED(CONSOLE_FLUSH_ON_NEWLINE) && *newline)
+			_serial_flush(dev);
+
 		str += len + !!*newline;
 	} while (*str);
 }
-- 
2.37.2

