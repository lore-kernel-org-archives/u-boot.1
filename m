Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C8FC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4998198F;
	Thu,  6 Mar 2025 01:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BVWVUlmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED1F81273; Thu,  6 Mar 2025 01:28:10 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7622C81668
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85ada0cf40fso2615739f.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220856; x=1741825656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ6LyDt1I6RspVW9P4aXJPRHhkKQi6s5JwOukJCaHJU=;
 b=BVWVUlmt+xSKXFXXc0U+mLznZ6E6XKtQM6aYC/qiEpwmohm6POmFvjLcLQ72G71/Gb
 9sOrRwHUWeyvO5CwAJ2feuN+XxCs1HTayhQnDOSnPMbJ02BWwRbm8oQbiyiA2EWk8tGL
 OKl5i/RtzYhuZmvwxcHueCyTTBuk4n5v9Nti0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220856; x=1741825656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZ6LyDt1I6RspVW9P4aXJPRHhkKQi6s5JwOukJCaHJU=;
 b=HZTq2OPMm3PZJQL/bb02t5h5fTpslg/YOYWMVXoiRcRdn6DKJXGQFR38LdlkM/xMHZ
 fR2h0cesE2fbulbQxlo9591LAA/KuGpH7+uK8jmuS18jDQkRTf1UdNKVAKXUoPcYQt58
 hSU7l+EnjN+k2+Z1sMLCSO6NTKt4jSupcTq5IShnGbQXwV7sGYEWlGX19X6FoUpdc2BE
 j2ZBnveb9EkO8LymG0AqW7cbGLkEKUHXblVqQSYlShCs7wYHuzdzhm0HEOKVu4O2qRdW
 3Ok/gH6RYdvJzoRL2J/87/hbLPVl2Ow5jycK+z+oNdRodbQU6U59wLBq2uqHRo4P00I6
 VrIg==
X-Gm-Message-State: AOJu0YzyAk5XItWVlGB3MeZVrd97rIJz0Oby7f2ipaoY5cEy/tF4XwgR
 L/RF1IxBt699WWVn5ROr6X9z52hKfisASqjx/SBhRuwRg+W4hMk4Z6qUpp78CFtxK6aUifLtaJs
 =
X-Gm-Gg: ASbGncsmMR7W+xIzRv3JqPhwZmLrq8dLx2BAW31d0wfPeu6J3a6d3GZnAWSU/tI8ZiA
 vSeIsuqRbNwWUWRR1ZgxxWGNkOt0s7hg070j4+pZo7SK79a/5RceufrkNMlWCq7CXEWSueig8hK
 aGfnISK+G7rMf5BlGEP9bTu1u+oGKGYDj0Fhy4eZ+AmbY4z9gD7PYE3KN5Vrda8WB4aDWlNAjwM
 HzvE5U9jJKr4+szuAbKRoB+jTprXWCc26uMNdFhK5o64XFiASzXS0y2WH2wkMHiFjTwcCm2lUJU
 qYan24nr60/2wrJFWX6dFq2gffBB58cwgHsyJre9BQE9cFXAmduD66FDQmBF9cF7Ddo/hlkJkjH
 2lBic7w==
X-Google-Smtp-Source: AGHT+IGhwk3mVHaImSmzd4J36BoNsS1MeCEZPrOlIgftYVZiIbQbOXlc3iS0ntJjnP+6AixhcNN75w==
X-Received: by 2002:a05:6602:b8a:b0:855:9c88:788f with SMTP id
 ca18e2360f4ac-85affaebd8fmr627737539f.8.1741220856470; 
 Wed, 05 Mar 2025 16:27:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 26/29] net: Return the size from parse_args()
Date: Wed,  5 Mar 2025 17:25:20 -0700
Message-ID: <20250306002533.2380866-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rather than setting global variables, return the size, if provided. For
tftput, use the addr argument to store the save address, to avoid adding
yet another parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index cc968e9460f..572fa75a72f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -323,12 +323,14 @@ static int parse_addr_size(char * const argv[], ulong *addrp, ulong *sizep)
  *		parsed
  * @argv:	command line arguments, with argv[0] being the command
  * @fnamep:	set to the filename, if provided, else NULL
- * @addrp:	returns the load address, if any is provided, else it is left
+ * @addrp:	returns the load/save address, if any is provided, else it is
+ *		left unchanged
+ * @sizep:	returns the save size, if any is provided, else it is left
  *		unchanged
  * Return:	0 on success
  */
 static int parse_args(enum proto_t proto, int argc, char *const argv[],
-		      const char **fnamep, ulong *addrp)
+		      const char **fnamep, ulong *addrp, ulong *sizep)
 {
 	ulong addr;
 	char *end;
@@ -358,8 +360,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 	case 3:
 		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
-			if (parse_addr_size(argv, &image_save_addr,
-					    &image_save_size))
+			if (parse_addr_size(argv, addrp, sizep))
 				return 1;
 		} else {
 			*addrp = hextoul(argv[1], NULL);
@@ -369,7 +370,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 #ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv, &image_save_addr, &image_save_size))
+		if (parse_addr_size(argv, addrp, sizep))
 			return 1;
 		*fnamep = argv[3];
 		break;
@@ -385,6 +386,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
 	const char *fname;
+	ulong addr;
 	char *s;
 	int   rcode = 0;
 	int   size;
@@ -392,10 +394,10 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 	net_boot_file_name_explicit = false;
 	*net_boot_file_name = '\0';
 
-	/* pre-set image_load_addr */
+	/* pre-set addr */
 	s = env_get("loadaddr");
 	if (s != NULL)
-		image_load_addr = hextoul(s, NULL);
+		addr = hextoul(s, NULL);
 
 	if (IS_ENABLED(CONFIG_IPV6)) {
 		use_ip6 = false;
@@ -408,10 +410,14 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv, &fname, &image_load_addr)) {
+	if (parse_args(proto, argc, argv, &fname, &addr, &image_save_size)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
+	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		image_save_addr = addr;
+	else
+		image_load_addr = addr;
 
 	if (fname) {
 		net_boot_file_name_explicit = true;
-- 
2.43.0

