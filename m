Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450F5CF9C71
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 01:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9603388CA0;
	Wed, 25 Sep 2024 03:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PLJHRQjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BE588A43; Wed, 25 Sep 2024 03:41:43 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB8888CBA
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 03:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plqrpg345/nWRJxFzG0+gG/SCn03rJWYcQN/IYU7Lq4SEg0I3ikBrLXtLxUjp05phH61lnRYwsbtYDDzp4G+q9SZqtkpBgddr4S8QEpuShSBEQ9kboG4oVYlh9kQiwCgweqG7pSh7gi29sccZxhx65gFHw6WbAXkhLa/KpdQ3IM8rXcAuwF/DlJOHTcfiqkVTgV3zEh8BsYvx3YBIANdvUr1rRw7jkACWk7OJy3SSc82RfE6qeXZvk8SB8D+Fvz26K7D6sDUPycMEgMU8hJQSc4VfrRG4Tr7WqFcJIRXoge7D1L3PQJtNgExhq59uoR0P2e4lWwaJ/y1Yp9OVFydvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAai+B3NX7mh8fnORRGFZEmiBJfbH9GLQrs9gP+sQhs=;
 b=W2AV9kNIM/CfYsr8EzYG7zdE6CrsfEft+5doZ219l+1G5AIKTGQjuNiqyyZypKjpqpPhzhlfpAyryGrux0YH9mVKYe12NkkR1/VHJvbDBb76/eTFP5klq7326RN9ns/M/snz45XUBAKkvcPU5gT+U7/foFhHk5jtboVQjTXMbbwLLye56AcsG6QFW2xF2AEFG+HsOCL5y199xcpMcYJpZeRwSrF8La33bQcepQeNXx776bfRWkZAHalh9qpQM5IIv9Gf189tBvCH+5nnRNfFyquVFPBWHFlo74D61ArBQaSsRIpIZ8v5Xl4yKlA2qsGW6LTTB7PxIXW2uHgxfxwBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAai+B3NX7mh8fnORRGFZEmiBJfbH9GLQrs9gP+sQhs=;
 b=PLJHRQjo9H3ExVyVkvaPLeZEi86dxQIHOvzD5gfghNc3Uoe6Pb01JY0MMOFPWPyjEoqL4wFamsbgtiW7/WJcwAmFiiOIMWYZbdHCYjlvJNORtq+q/ol0C6OgdG82p8ygwpbaW9WEwVqx4xP/zwgig5VttRbOtVVUfaxMHpHT1+DftMXp1RewkWlC89vZi06bXgMSDjKTs7V2UKoPUkL84AIBp5mmipkwDRXK3mVhquht82W3OiHP+zEC8ptGQ1z+Qi8E3TIJWXUF/pvqHKZqPvPcVtfP40mN1rJGnkcLlfn9Z+yUj7Exw5K3OFYL4tuYD9xpU5W0KSiX+k6l+IIiNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VE1PR08MB5645.eurprd08.prod.outlook.com (2603:10a6:800:1a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.16; Wed, 25 Sep
 2024 01:41:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 01:41:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v8 13/13] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Wed, 25 Sep 2024 04:40:58 +0300
Message-ID: <20240925014058.1679074-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VE1PR08MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: f342fb15-c760-4900-0a9e-08dcdd032b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+6OH6X4lmu50EJwP1l+pFKLflKr72i5CvyB3AcBK1R6hBmzyCHO16k5dEQou?=
 =?us-ascii?Q?YjDuCMnQoCHqjmtXlnyaTNuEHDBPaecR/NrZ4WXvXsTcrYRVKoKNu2KPClEy?=
 =?us-ascii?Q?4D8FcOR4kNvIIlACrSjsZMt28OcgH2BhQvGUkZ5AA7iSYM8t/K0Veetb0wVw?=
 =?us-ascii?Q?XrPKtjb5xalgrfk6or5fLmTs1kxWGYBtj0ldy7Z4YcHBVT7FwcQE0RSCOFLP?=
 =?us-ascii?Q?u15/Hx50r3NHOs4e91MD2zgpgIqMuwgJija5vW3YnGfp3KXhn8/qZi+wyEwa?=
 =?us-ascii?Q?MM7x9ukRtReO3fYyOVuWjy0koCfTzrNlsCfdBLkhHrTZYA2AhrEQH9+bWEq8?=
 =?us-ascii?Q?x7Y2F/dT1LDmaE+nPSyyx3QZRl1SemYNSJBqOSHMDOkoU2EPSFCCivZQ0dMb?=
 =?us-ascii?Q?HstjtCt0707L8ztZb8yCMlWfdh4INwRnPzKdqWSZqioLCEW6LizzKkpUA+iE?=
 =?us-ascii?Q?u9dghWSxnYVpXwFsQCFJsYp8rv0cFF98ZlfjZidEMmtesRymvMZUZMBVUuys?=
 =?us-ascii?Q?0/X7qImYOInfLh8glsVjPc4UcFDSvSclOVJBppe02r2rwCHtka1lqgJ5UMmt?=
 =?us-ascii?Q?Cg14B03UO+v6K3OqhZFZlyj2LJcThWR/Omrr8jGFHyh1zcVEuaS51DNLycsp?=
 =?us-ascii?Q?mZIE43kkdCD6F882mHnJVL1Uyt72lVeF417bIkLDQtGzg5CXf4RTvIgIToQM?=
 =?us-ascii?Q?+BgBgrTtucbYCAAeQwZ1gNFHJXuwo5jx77q0v37FZMGXWNcc1O4dW8R862+O?=
 =?us-ascii?Q?UAGcUPDb6lTzgCb5ENswtQI3DHK3h6y4AOKCw4OjdVsayfvIhKNxOegX8/xT?=
 =?us-ascii?Q?4OYO3Zgo2U22g13HwCgEKuN1NCZODLxj8tNzLvZf07A5uQLTE1W8dzo8n6F+?=
 =?us-ascii?Q?1LNnWSCKQUpHaYMNBX2551YDyJpCYSduBbMZLOk03vm+/BHJfKkC6PLgXKpf?=
 =?us-ascii?Q?A2bBZ/XfFxG0TtWawOI8CQyrZsoJeMiGtwNdkhX0elUznH3j3rHHyR6pacx6?=
 =?us-ascii?Q?4sZoDqFDFS8T9GtXOX4eIhaBkrDbBXoOcUoOf8LgHN+8y1ZnFNqRHAGhE7or?=
 =?us-ascii?Q?xlwpndFWmpwut8I7Gy6c9DU1HgRhx3U7jHhUpjKUuqwfOOtWCh1zyoe/zOUN?=
 =?us-ascii?Q?qhW87tavJcdzZlIcdt7F5vpGLjjSrIMSTUsdUnTt0qk2aqzMse2Voap9SG/0?=
 =?us-ascii?Q?hezAH56sxIahm89dkjAA5Q2f5bSfhTfYNQv7ToHVHOwU+zb/gkFkCHjF9xuI?=
 =?us-ascii?Q?f2II4tdFUhxad0CsnhgnB9zEE3MOI/ylv+iT3TK9sDo7rKdBemIdgR95bOyS?=
 =?us-ascii?Q?IBCXxoj+U9lMQTAKV8ouQDBqHJFgtzyrpVSnuZ4xIcEU2KK85u9wRH05+ifQ?=
 =?us-ascii?Q?gdV8SxGOh48K8SwQ5b+ZyfIJu1TX9hmFU9AeR+pOzkaitWaJa1azLG3b+TFd?=
 =?us-ascii?Q?3iv/LF8t+P0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3x2aXXtqbDdeoZ8b9B887U5li1Zx1hHwXR/GZFkczszSZbWuJXTxLlsLPgKD?=
 =?us-ascii?Q?yi+MwV2MKxJTkh2NbhTVQt+D90h4NnyXnY/CCrodMIqjxTc1QWP9BJtfCSKk?=
 =?us-ascii?Q?4EMBqM7AJHhoP3iyGibobDYSrGqBqbfXXhxmQiPVDziRRdsI2KgHbbvJjH1v?=
 =?us-ascii?Q?6PdPhCXtkyDC0OzDl6PVWSjILrF0gABeNfHtDvU/FL/6wvqsNPNlfs4k+Qi6?=
 =?us-ascii?Q?/La0jQKp6RMwuYq2zk2eXDsmASS7y1k8ky/owXW9YRxHEY6cZaOhNHRg4CDw?=
 =?us-ascii?Q?G7UOf8HyqFObq6F8hW0rQlTqohhibR1/fRcNo+5l/AGPt8EABn1WPXvCSQ3X?=
 =?us-ascii?Q?bZgu6cvnwdkTHVXP6ObeT2R5DcOWQGFSszs1gSooEY7gvUdgcsLGGlYabxqD?=
 =?us-ascii?Q?gWaOhhbFxN3okREjT5hM06JWKk2OgHDfAkJfDGDzGx/okwNOGZc6Y82sEO3P?=
 =?us-ascii?Q?DSQ0IylnF7eKgmQ3hAaX80CzKt4Vqd8TAof1sufiPi0fa6TPfxeohSk6CDEu?=
 =?us-ascii?Q?cSESHlxcQZqBDsxMva+BazBY6KdfmPOYBayJyu05rO8h5wyRY50VRCue9H2i?=
 =?us-ascii?Q?11+ekmKzCecAGH9h/BkTSk3g36n6Aa/LAFOBU6tFU3h3nJQj4h/pmwwZKUO/?=
 =?us-ascii?Q?82Qj/WUxFnzmVCon1o8UUC0ubX1YTqRoq+Bu7HuYp1rQgF2rYYVtc+/iI3t/?=
 =?us-ascii?Q?8OTYd2XmoE+790q1+WwjlRce+EdTkLk8OyLJnArwU589Nmxar4mU3WPjPXF9?=
 =?us-ascii?Q?AuWwEIA+euFAHV/x1uIRHq2aqGIw5Ubu6vd6mRYdUaEdSKoZyOwDfdjCGE1/?=
 =?us-ascii?Q?I/r7/Z6tCPu2vTtuTvKDqucoae07DHCV+5m3Ub1i84VbLS8W46mP+MGhB1RZ?=
 =?us-ascii?Q?20/KHvoM1hl9OlZUdSAqGtIxXA3KRwzqTGPNjBR/Yd4N15F0/5daej4M4EZ4?=
 =?us-ascii?Q?Yq2kxNf16/l5R+vLnV5Jr3wj9fW9hxW++1rhYvuaY66+XHBjN6MbiODj5wlx?=
 =?us-ascii?Q?Vbepuk6ysCLr4WE3DxJdKy3tfQAc86LqTMZrQSfRNC9zjprFP4/Dka4DkiWt?=
 =?us-ascii?Q?NEhj5+Eo2rpK4WQPIDAUJgHCHPbem6qcMLTvnNXkbc85inMPlkm1yvVgV8J2?=
 =?us-ascii?Q?qhhqkynDZuigHwEgqvyEUHnD0n5Izq/dcLQKJyjDw2oANtN/v5RueQuKnu+J?=
 =?us-ascii?Q?g636ftyBzSgvpLig0l9Jv2QZOKQAv0trOcr5s4DH7YlxTirSE7G5Vr/J+IRW?=
 =?us-ascii?Q?p5Pse+PIVAgDzyOwkBIPqqFWe+EG2RvahA13yPqIBkR6ebGCB+zef+cKknc9?=
 =?us-ascii?Q?fqCXfaQ9m26eTdzUndin0laQvATYv2SOYnVXdd8C0hE2b52Q/Tyu7XxuyQdH?=
 =?us-ascii?Q?okwljj9e4eJKu/2tD/LEQGw+rkp0N85on76Mjkk6h/EW7qWu23bxYBg+BS5c?=
 =?us-ascii?Q?36JT++YnHpvRaFSSp5vzenKhrg+0FBrf27ICq72HM/bho9+mUilTE2YGhxm2?=
 =?us-ascii?Q?Wq3WJV4okyBPHV9CEk3GhzKEWePGlyZxmHg9QpA/76sULCSZ4KQBkPG2kgPl?=
 =?us-ascii?Q?AMSEjqSU/xMUjitaJsqh33FNbXBvxAOWO2AG+7SyamzwzCMc2R8Ey+6oQb2Z?=
 =?us-ascii?Q?pdbWach60eGP1UXK4Ca36vc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f342fb15-c760-4900-0a9e-08dcdd032b09
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 01:41:25.7597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+0eT49bZl8C+UpRcsP12NAvHh/oLgfSFDa5PkgTxZb+k6ko1XNSq+F7+Lbu+MxNglnFcgpRaNle0ZN3oMzlpeaeoLZ5XBfewORXyONUcC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5645
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

This is an example web-server implementation. It can be used for files
uploading to u-boot using a web-browser. It acts much like tftpget, but no
special servers needs to be installed by the user.

This code can be used as a base for other implementations like firmware
upgrade web-server used by some vendors.

Usage:
  u-boot: start the we-server using the "httpd_upload" command
  PC:     open the "http://your_uboot_ip" link in the browser

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig                |  25 ++++++
 cmd/net.c                  |  20 +++++
 include/net/httpd-upload.h |  12 +++
 net/Makefile               |   1 +
 net/httpd-upload.c         | 170 +++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 net/httpd-upload.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cfdc53e494a..b7749525ae3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2017,6 +2017,31 @@ config CMD_NETCAT
 	  will be lost or reordered. Any netcat implementation should work,
 	  but openbsd one was tested only.
 
+config CMD_HTTPD_UPLOAD
+	bool "an example HTTP server for file uploading"
+	depends on HTTPD_COMMON
+	help
+	  An example HTTP/1.1 compatible web-server implementation for file
+	  uploading. It acts much like tftpboot command: put user data to a
+	  specified memory location, but no special tools needs to be installed
+	  on the user side. The only required tool is browser.
+
+	  Start 'httpd_upload' command, open a browser, connect to the board IP,
+	  select file to upload and press 'Upload' button. This is enougth.
+
+	  There is no big profit from this code, but it can be used as a
+	  reference for other web-server implementations (ex: web-based
+	  firmware upgrade/recovery used by some router vendors)
+
+config CMD_HTTPD_UPLOAD_MAX_SIZE
+	int "Maximum uploading size"
+	depends on CMD_HTTPD_UPLOAD
+	default 209715200
+	help
+	  This option sets the resriction on the size of any uploaded file.
+	  Please reserve 2--4 Kb more space due to additional space required
+	  for storing of multipart/form-data header and footer. 
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 79bb126dbd4..f2df1eed2ef 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -21,6 +21,9 @@
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+#include <net/httpd-upload.h>
+#endif
 
 static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
 
@@ -229,6 +232,23 @@ U_BOOT_CMD_WITH_SUBCMDS(netcat,
 	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
 #endif
 
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+static int do_httpd_upload(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	httpd_upload_prepare();
+	return netboot_common(HTTPD, cmdtp, argc, argv);
+}
+
+U_BOOT_CMD(
+	httpd_upload,   2,      1,      do_httpd_upload,
+	"starts httpd server for file uploading",
+	"[loadAddress]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
diff --git a/include/net/httpd-upload.h b/include/net/httpd-upload.h
new file mode 100644
index 00000000000..a80df214668
--- /dev/null
+++ b/include/net/httpd-upload.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * httpd-upload include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_HTTPD_UPLOAD_TCP_H__
+#define __NET_HTTPD_UPLOAD_TCP_H__
+
+void httpd_upload_prepare(void);
+
+#endif /* __NET_HTTPD_UPLOAD_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index c1f491fad02..c1b41240aab 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
 obj-$(CONFIG_HTTPD_COMMON) += httpd.o
+obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/httpd-upload.c b/net/httpd-upload.c
new file mode 100644
index 00000000000..8e43860fa74
--- /dev/null
+++ b/net/httpd-upload.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd-upload support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <net.h>
+#include <net/httpd.h>
+#include <net/httpd-upload.h>
+
+#define MAX_FILE_SIZE	CONFIG_CMD_HTTPD_UPLOAD_MAX_SIZE
+
+static enum net_loop_state  httpd_on_stop(void);
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post);
+static struct http_reply    *httpd_get(void *req_id, const char *url);
+static struct http_reply    *httpd_post(void *req_id, const char *url,
+					struct httpd_post_data *post);
+static void		     httpd_on_req_end(void *req_id);
+
+static unsigned char error_400_html[] =
+	"<html>\n"
+	"  <head><title>Bad request</title></head>\n"
+	"  <body>\n"
+	"    <h1>400 - Bad Request</h1>\n"
+	"    <p>The request you are trying to do is wrong!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char error_404_html[] =
+	"<html>\n"
+	"  <head><title>Page not found</title></head>\n"
+	"  <body>\n"
+	"    <h1>404 - Page not found</h1>\n"
+	"    <p>The page you were looking for doesn't exist!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char index_html[] =
+	"<html>\n"
+	"  <head><title>Upload File</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload File.</h1>\n"
+	"    <p>\n"
+	"      This will write the uploaded file to the memory area pointed\n"
+	"      by ${loadaddr}.\n"
+	"      <form method=\"post\"\n"
+	"            enctype=\"multipart/form-data\"\n"
+	"            action=\"file_upload\">\n"
+	"        File to upload:\n"
+	"        <input type=\"file\" name=\"fileID\" size=\"500\" />\n"
+	"        <p>\n"
+	"          &nbsp;&nbsp;<input type=\"submit\" value=\"upload\" />\n"
+	"        </p>\n"
+	"        <p>\n"
+	"          It takes no more than a second after the file has been\n"
+	"          uploaded until status OK is shown.\n"
+	"        </p>\n"
+	"      </form>\n"
+	"    </p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char upload_ok_html[] =
+	"<html>\n"
+	"  <head><title>OK</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload OK</h1>\n"
+	"    <p>The file was uploaded.</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static struct http_reply error_400 = {
+	.code      = 400,
+	.code_msg  = "Bad Request",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_400_html,
+	.len       = sizeof(error_400_html)
+};
+
+static struct http_reply error_404 = {
+	.code      = 404,
+	.code_msg  = "Not Found",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_404_html,
+	.len       = sizeof(error_404_html)
+};
+
+static struct http_reply index = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = index_html,
+	.len       = sizeof(index_html)
+};
+
+static struct http_reply upload_ok = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = upload_ok_html,
+	.len       = sizeof(upload_ok_html)
+};
+
+static struct httpd_config cfg = {
+	.on_stop    = httpd_on_stop,
+	.on_req_end = httpd_on_req_end,
+	.get        = httpd_get,
+	.post       = httpd_post,
+	.pre_post   = httpd_pre_post,
+	.error_400  = &error_400,
+	.error_404  = &error_404,
+};
+
+static enum net_loop_state	httpd_loop_state;
+static void			*post_req_id;
+
+void httpd_upload_prepare(void)
+{
+	httpd_setup(&cfg);
+	httpd_loop_state = NETLOOP_FAIL;
+}
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post)
+{
+	if (post->size > MAX_FILE_SIZE) {
+		printf("HTTPD: reset connection, upload file is too large\n");
+		return HTTPD_CLNT_RST;
+	}
+
+	post_req_id = req_id;
+	return HTTPD_REQ_OK;
+}
+
+static struct http_reply *httpd_post(void *req_id, const char *url,
+				     struct httpd_post_data *post)
+{
+	if (strcmp(url, "/file_upload"))
+		return &error_404;
+
+	httpd_loop_state = NETLOOP_SUCCESS;
+	printf("HTTPD: upload OK\n");
+	return &upload_ok;
+}
+
+static struct http_reply *httpd_get(void *req_id, const char *url)
+{
+	if (!strcmp(url, "/"))
+		return &index;
+	if (!strcmp(url, "/index.html"))
+		return &index;
+	return &error_404;
+}
+
+static void httpd_on_req_end(void *req_id)
+{
+	if (req_id == post_req_id) {
+		post_req_id = NULL;
+		httpd_stop();
+	}
+}
+
+static enum net_loop_state httpd_on_stop(void)
+{
+	return httpd_loop_state;
+}
-- 
2.45.2

