Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270E3CF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 14:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C9188E5D;
	Thu,  3 Oct 2024 16:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="lRTrOrZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E2188DD4; Thu,  3 Oct 2024 16:10:37 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D223D88DB8
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 16:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbFtXRkaF9NlbIbOT4g/LsAezh53hh+Zil6toht0swj0fZBjUJqv6m6rmrhDWGgSPxNptK2sHJojN1u6gUp5CxKKV36WdDH4K5xHR71lbCNTQCKwdX72owltd7Vkw2x0elx67zjbnGVpAoi6J4cYhey3qvzitRFVaDGgsKmoogh9gp9HCePFfmIyDotyibRapfljv2nk11WGQ7722zGN2UHebwYoVkiZ25MzoNpI4iySWhwJ8CyMmPCXHQSMNTDjLLMV8Ke4KBMfchy7iOPsaEv7vxujQnEfbemJx2lwzQ6SxtC6QxQN2bI3nbqgVJ2ptXbKirBazSkTupZLHoIydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66h24GVxCPCoJXwnOpsSshDgnxcvsmPsR7N7jwJMSbU=;
 b=vsuFefxXTHru8IyJrXK1VFDyWzeS2bJLS884lD+K1L3+wtT19DmQxoaI4QKSZAkondU8ZS0kjj7jFOITVXsGtNzFRejfKdCxPT8ozTymrVF30UcpnnEjvLuYylcig20b87n4YNNyqW9q+qcTcWhz9cOY9GoRW4fN9s29AHOph1Y9kvwtt/Lfh0ZeajheuO1M1zqnCefcHRq9y6m98ECnnJvZAN+OJkYvYtB42tX10fWsiQ96r4OrIrLHDQOESEJovCe5U0bJRUQbC46hhn225g4cEFFE1YYGSE+tIkyC7qNWHkKeLgJbJmcxGNIo+Mu9X/tCAA3AtVeg2lZ6y6KFbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66h24GVxCPCoJXwnOpsSshDgnxcvsmPsR7N7jwJMSbU=;
 b=lRTrOrZOTW+QrBuc/OVukiqwkQaTju1/wG+H8EjuIKrKq6+EAEuCsQspXff+FH124ma+q9C3ss0H2R7CBH6kIxjZbvkf/Dj9Ci+J5nqzkbo29Bit3MxKkBkROIduqet/wF0ef7U7JRL5yiYdvgyVfFenMVaTo6hAML49XGUUhJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB5341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 14:10:34 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 14:10:34 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 4/4] serial: embed the rx buffer in struct serial_dev_priv
Date: Thu,  3 Oct 2024 16:10:29 +0200
Message-ID: <20241003141029.920035-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003141029.920035-1-ravi@prevas.dk>
References: <20241003141029.920035-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0111.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: d42e9eb1-dfd6-4ea4-9b2f-08dce3b525e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GT+9La06mHuJgMv4fXK4Zwt4dmVdR/2nUpQZLyw5VjuMYISjgumQXgmDCPN+?=
 =?us-ascii?Q?kEmYCO+JdgYhg97LnOJMca2TzbyzEXCrHYvO8euDYyuY0SBF1HZJLPk+oGEE?=
 =?us-ascii?Q?FNMcTk/o9wy4dOs/QCY+xE6M10OsDxlfTmSyQOgOLSQL14bO6zBnNvpbTQby?=
 =?us-ascii?Q?ZUQlr7CaZXF/H0yw8f4V20MkiTjIncRyZ6I9h6SLMByhdKyDrhvkhmUOkF1E?=
 =?us-ascii?Q?8Fu5dss/Go//2XVLRvaa3uQFmDq8/Gtm07j+R7EIRlhsOrdrqjY0oiUvPF0X?=
 =?us-ascii?Q?sbXFhDXzf51cVnrIeyfPqp4VGMP0WOtnrup7KY6k3VLB7HtuSNZD01CERhMM?=
 =?us-ascii?Q?HpNHRkMXsr46JMQyMmNxMwVahM36YRbu+CsTEhcks0HxFNVqq+7iV+SPdNMf?=
 =?us-ascii?Q?7bnFLFuOqq2muYFhhweFo4vYCv13B9bwWh2x86Dd8qv4aN/v0e0ZXz6HtrFd?=
 =?us-ascii?Q?ImjBXhqnusdfKEFKNlQnhICw4mjtqDArvW+J/9OlUPIpLeCBgUDAFczynqke?=
 =?us-ascii?Q?gYOIZ9EcJbObcKOoAtLKecnT303sFnIpzCUYuZIU3MhWBviklsbZT9jYDr2F?=
 =?us-ascii?Q?mrzAlYJ8janXns4pzBehOlgaBOP/Pynaw1n675gpu7QgLyTRB+AQ3lnQoWF1?=
 =?us-ascii?Q?l2scLRILtEWMFY14f+K/Na4qW+HZZmU7vNtkem5Nu5/5Iw3XQBmkGgxFt4DU?=
 =?us-ascii?Q?Jz/96n3CeNFT4BTYmFw0jyzve6ptJiw6tzTgUeAdFbODRXjdfQjAc3CwtQuP?=
 =?us-ascii?Q?ax9Yq5HosIbPxTD7+6kofvD731d1GptpL3REC4GSRCamQh7JOJ40W527c1ex?=
 =?us-ascii?Q?u3pfzy3ffpKf1OpZ1Z9FhEuJeOGI6MV9509G4UpmKcNsOl07XcrcQMF9I1gj?=
 =?us-ascii?Q?bDcEPqX3KYIWYeV5CQjZjMl4ct6fYUjPxphlF994tzObI6nP0+pT5arKdES/?=
 =?us-ascii?Q?G6fQitp2m6fLGWUdb6ueqGu4KtYWEa/bhgK0Z3FK6O5fqhvfmEai7YLn07M4?=
 =?us-ascii?Q?oIosIjowMdtfpE0ahe85KtUDSD2ybREbfPHjBMl/GtW2mmRt7QMaXjpFofag?=
 =?us-ascii?Q?Yv5EBgJbiY0g+WX/t7C59rjinNvE6r9pe9Hpc3ZUGsQTTmjrIbNTPiJdlOVz?=
 =?us-ascii?Q?4y1Wc15zwq1iw/DQPI+YlflzItNXvvtodG7oI/Qj1KHP5Y+yDmZCJLrXJEeU?=
 =?us-ascii?Q?I931kCrozMoXLlkpJ9RumKbrtCoTpsN+lkRZO5UrXTykHT5Rm7udXX8XKxtw?=
 =?us-ascii?Q?x0WEHVrROagB5aUSqUKqK3aMDFA2TPJI2sOCo6MXHR0GST9T+v4NDzFhTq+N?=
 =?us-ascii?Q?Pvsn3wbIpiWEZp6T5NMo+WM3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gjgnXtNxHhd+QZ+mHNDLeMXLO7WsVF/NxeVtOD+sD2Otjvcu7QoxgM3h/GWM?=
 =?us-ascii?Q?nemDSIdCJQxwb118KgV86KOV6sQRS/M0iNUiamtR82EAG/YjMYMIFMHNIZ6N?=
 =?us-ascii?Q?g5zHbJeIqDw5JWfWP2J+hWRvwuD8X3YfNwMJJedaLvqYzxNoEt9VUmuwE1rH?=
 =?us-ascii?Q?ZdtytlGZGv1KvZxmMBtRrJZW2U8zUCKYMiioqGUJie7q+fE3Zd9ZJxOHG44/?=
 =?us-ascii?Q?ObEGNVC6PbyDzX09qgquEjZXgK8JFVQ8WGQr6QbOhYsyraJadY18Cwq3HMki?=
 =?us-ascii?Q?Xjc6dptBnsMZe2C3DzDhcYKmSaskaf7Yq/K+WRnH1nkg44MV7gEa0A/gqJrt?=
 =?us-ascii?Q?RKnLrEZ7VN1RIN9fIYDkvIr0unWQoa8cMEjKTrbz0wRjArFlHlvO/zT/o/Nm?=
 =?us-ascii?Q?fZfnXEbF3WTRr1pj7zS+cV3El0oA3exymJvfp0MITbkDe7a8NzlbnXqF8on7?=
 =?us-ascii?Q?WcazS7CWo7DT7RNQefbsb5QI5VUVSQMS5+/+/m6Myoha4ugehUvJTD98WAY5?=
 =?us-ascii?Q?BTgdS/1bm3Nm2WP6tIVcO1Dun6/+XlU+bFXVde2NvWFpXsNUDqw1cN61I+/M?=
 =?us-ascii?Q?gW7TCFjQIvXhtFD00L2ukK16cMXTkjwpWgaUk8SqPuyNJUAj7LnWQQDhdOYi?=
 =?us-ascii?Q?nZXiC4ZnVg39zNJntj+D1cAGnacj9DDRaNPJ+Ja/AaNYznC3RXbSb3aFiC4s?=
 =?us-ascii?Q?w1qPsaJdjFRfigtZf6Zs7OG8WXB7Cs/glgLjarpGfEdxYTFCKGl9hac3gBqr?=
 =?us-ascii?Q?O5F3p88mkErACCwb3b0sAZHGECE9h4SwbmUCoedJN3Gwnbr7zEsj0ojECVnM?=
 =?us-ascii?Q?wOH2HyHzSvEQQYPn439hRtuDU9q1t7xWCPAqbLJqX2ydy8jvhkN3/srAKo4z?=
 =?us-ascii?Q?bYQZ+nA02Nh+LdAI/Jv8GvSAzKtO0pizdayNEjL9NJB9A+kFUEy5BMnJBRaq?=
 =?us-ascii?Q?S0/WBK/pquss/K6nGoVJt1O4s9PnIcNGnitvvwjYCWiGCv2uOIYNNekX1RlG?=
 =?us-ascii?Q?1A3oSZFe4M3ePOgcwSNAh07Wndw1/zSc5cnICGBzonvsRsuTab7C/xiRa0PU?=
 =?us-ascii?Q?Var9GFl8Q84EFBueTZAqBvmLE+FZa5/Q9bFs5p+VnhLNTqJJbyx9FdxVttcf?=
 =?us-ascii?Q?m+jRJWvLps6NWM+o131EiQ3uAZTUe1R8NoK7JlbAHvrsbHRBKdBX26DbAiH1?=
 =?us-ascii?Q?f9B+kEFNLBm9IQmiqyLgLdnS9eUWa0965H85x2aDYFRQj2zcziTeb1DKzS+u?=
 =?us-ascii?Q?a265EDdpidYDTZnMYnVLstYkF7GV2ohWPnMuaO4R4kAT6kmZX5BYrV8dTVdD?=
 =?us-ascii?Q?EDHo4by0+RKBLKLMSjwOqaEhCxKvFk7EPvNbvyAqSRz+h/yBGkAXQdzEdLcW?=
 =?us-ascii?Q?3JQ8wD4AFp+zZG/njt/liECVNQxv+uPr7dsEmmnLatDmh3b5Q4t0YI8QXwb9?=
 =?us-ascii?Q?nNBhhA/s3/obSSpqrT4/rzvlJ1qNNEz6HIvYdRf3cD5ulqV22XN5N2o4B3Sm?=
 =?us-ascii?Q?7qsTHxNSWXz7BTQA1OUvbbJ+kZepK19qA062Dz15c/FccnABvhNb2a7IBFhx?=
 =?us-ascii?Q?AXbPMSRFgWLSsJMkZUMcUqQfC642y0PyJh3t27Ee9+f1RWdW7aURTasMcVsb?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d42e9eb1-dfd6-4ea4-9b2f-08dce3b525e4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:10:34.5588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+rt7YgPwyrgq8WIiV54hxOryuCdZJjPZlFrbnOTPNwRoiahQxYzN3oODF1rP85qP8pYNyFA4+MCn3YY5lgrrP/n2JA7pnJcoyX/P8oU7YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5341
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

The initialization of upriv->buf doesn't check for a NULL return. But
there's actually no point in doing a separate, unconditional malloc()
in post_probe; we can just make serial_dev_priv contain the rx buffer
itself, and let the (larger) allocation be handled by the driver core
when it allocates the ->per_device_auto. The total run-time memory
used is mostly the same, we reduce the code size a little, and as a
bonus, struct serial_dev_priv does not contain the unused members when
!SERIAL_RX_BUFFER.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/serial/serial-uclass.c | 5 -----
 include/serial.h               | 4 +++-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
index 484f0f7d3e8..d737e25223d 100644
--- a/drivers/serial/serial-uclass.c
+++ b/drivers/serial/serial-uclass.c
@@ -588,11 +588,6 @@ static int serial_post_probe(struct udevice *dev)
 	sdev.getc = serial_stub_getc;
 	sdev.tstc = serial_stub_tstc;
 
-#if CONFIG_IS_ENABLED(SERIAL_RX_BUFFER)
-	/* Allocate the RX buffer */
-	upriv->buf = malloc(CONFIG_SERIAL_RX_BUFFER_SIZE);
-#endif
-
 	stdio_register_dev(&sdev, &upriv->sdev);
 #endif
 	return 0;
diff --git a/include/serial.h b/include/serial.h
index 14563239b7d..eabc49f820f 100644
--- a/include/serial.h
+++ b/include/serial.h
@@ -298,9 +298,11 @@ struct dm_serial_ops {
 struct serial_dev_priv {
 	struct stdio_dev *sdev;
 
-	char *buf;
+#if CONFIG_IS_ENABLED(SERIAL_RX_BUFFER)
+	char buf[CONFIG_SERIAL_RX_BUFFER_SIZE];
 	uint rd_ptr;
 	uint wr_ptr;
+#endif
 };
 
 /* Access the serial operations for a device */
-- 
2.46.2

