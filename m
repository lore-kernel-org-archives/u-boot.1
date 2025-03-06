Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB68C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:31:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AB381A02;
	Thu,  6 Mar 2025 01:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dQMOXnG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50FF81930; Thu,  6 Mar 2025 01:28:11 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F2D81276
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-854a68f5a9cso10035539f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220848; x=1741825648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cYhanlGj6/X5TJgoCWbmaOurZY337EZux/Yk30FNKA=;
 b=dQMOXnG4gI/nIzT0yqqKxWcm5c+zsowta5xGaPAnZjlmg/Sfx/1ebXCk7y6cMTZcA+
 nz2gpN5wODepSxQRbqQnywO/OynvasX/8uY68CO5x0G/yngX/zS0Ejg7Qrc2/DI9HZ8L
 8DIxTzW7yMp1XGr9kAjP3HKoHkqAaBHyg+WCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220848; x=1741825648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cYhanlGj6/X5TJgoCWbmaOurZY337EZux/Yk30FNKA=;
 b=rGq7AZd4N0uqm/klGKUS39s/4u+Iwdxv97JGh6P3ofyZm9M4BYHLd4EZ0mE/Wu1aUY
 hahLH3vdDm2LTjpoBq3PZacXBtX67hVvrABQ9KCmArsipGCUtwHw5iaX9lMg39ADXt1l
 Vw18M2rcL2ousDJD6kBFTLYidvzE0Fe/QEfHHeGrqfiNeWNx1+hVFENaGpy2ocb/80o0
 MBVJpD1QTLs882ey1kMREQhSWnjglNu9GNC3ixu6ndZm1S03uMeVtR9uyNhohytl3BlS
 gJaPofmiOg8awnwPAuEiaoQfNC7Kv5WQjBsh5coxSFUE0akpkJ/ePK1m6F2Hwzp/bCJc
 khQQ==
X-Gm-Message-State: AOJu0Yzpmr2LWjIU5IVl35fC2au5ySetU5zKMUvC5/lyzJ/6z4sA3fVg
 D6l0LO82gVo5bN/rFUMVEudyF+q/ktf/rWJlNAFhuNkbtLgyyouBaxzYNtN8Kf0T4wO0YJdAOOY
 =
X-Gm-Gg: ASbGncu0kusc8mAWnuWXAryOFaSxN/TEkGWejxXb88s1EY9WtxDkvq4iYyEarcK84PK
 H2sWlzEiEygoaGFcckH7xJoaLbaYWKD08iOpFhA3vd3z4mOD69MfXdu+Zf4cLGgBj8cGvrecdAc
 25jArkfm2fXJUGm9BIeu6muUpeXFZU+jfMJA8Zxb1QAOKwe1Pp55gQprXjhT9rQipsGDKRwnnZd
 nFu1fsTczu25gdtBlirarnVekwToYMhW26s+U/2pGQkwwaGz8Hoc497XyA0c1uiGGNoxH3fmJK+
 icZARLjc7gRm0WFachZTSJZOeOliVexayrPwMQl8RLURxlx+M1CVrXeZTwCgIYD7MqAdmceUaY+
 dqS110w==
X-Google-Smtp-Source: AGHT+IHmbFXi5sSaS7NVoKVdrPlUYtigA1JyP450NLsgVARf5RuKMRpFcrxdhewuDCPnliRcqklxoA==
X-Received: by 2002:a05:6602:4141:b0:85a:f617:37d9 with SMTP id
 ca18e2360f4ac-85affaeedaemr660201039f.8.1741220848002; 
 Wed, 05 Mar 2025 16:27:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 23/29] net: Simplify parse_args()
Date: Wed,  5 Mar 2025 17:25:17 -0700
Message-ID: <20250306002533.2380866-24-sjg@chromium.org>
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

This function repeats the same code in a few places, namely setting
net_boot_file_name_explicit and copying of the filename to
net_boot_file_name

Move these two operations to the caller, with just the filename (or
NULL) returned by parse_args()

This makes things a little easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 89a4d9b38d4..cc7d14eb082 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -314,10 +314,6 @@ static int parse_addr_size(char * const argv[])
  * parse_args() - parse command line arguments
  *
  * Sets:
- *
- * - net_boot_file_name_explicit to true if a filename was specified
- * - net_boot_file_name to that filename, if specified, else the value of the
- *	'bootfile' environment variable
  * - image_load_addr if a load address was provided
  * - image_save_addr and image_save_size, if proto == TFTPPUT
  *
@@ -325,21 +321,20 @@ static int parse_addr_size(char * const argv[])
  * @argc:	number of arguments, include the command, which has already been
  *		parsed
  * @argv:	command line arguments, with argv[0] being the command
+ * @fnamep:	set to the filename, if provided, else NULL
  * Return:	0 on success
  */
-static int parse_args(enum proto_t proto, int argc, char *const argv[])
+static int parse_args(enum proto_t proto, int argc, char *const argv[],
+		      const char **fnamep)
 {
 	ulong addr;
 	char *end;
 
+	*fnamep = NULL;
 	switch (argc) {
 	case 1:
 		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
 			return 1;
-
-		/* refresh bootfile name from env */
-		copy_filename(net_boot_file_name, env_get("bootfile"),
-			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
@@ -352,16 +347,10 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		 * mis-interpreted as a valid number.
 		 */
 		addr = hextoul(argv[1], &end);
-		if (end == (argv[1] + strlen(argv[1]))) {
+		if (end == (argv[1] + strlen(argv[1])))
 			image_load_addr = addr;
-			/* refresh bootfile name from env */
-			copy_filename(net_boot_file_name, env_get("bootfile"),
-				      sizeof(net_boot_file_name));
-		} else {
-			net_boot_file_name_explicit = true;
-			copy_filename(net_boot_file_name, argv[1],
-				      sizeof(net_boot_file_name));
-		}
+		else
+			*fnamep = argv[1];
 		break;
 
 	case 3:
@@ -370,9 +359,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 				return 1;
 		} else {
 			image_load_addr = hextoul(argv[1], NULL);
-			net_boot_file_name_explicit = true;
-			copy_filename(net_boot_file_name, argv[2],
-				      sizeof(net_boot_file_name));
+			*fnamep = argv[2];
 		}
 		break;
 
@@ -380,20 +367,20 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
-		net_boot_file_name_explicit = true;
-		copy_filename(net_boot_file_name, argv[3],
-			      sizeof(net_boot_file_name));
+		*fnamep = argv[3];
 		break;
 #endif
 	default:
 		return 1;
 	}
+
 	return 0;
 }
 
 static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
+	const char *fname;
 	char *s;
 	int   rcode = 0;
 	int   size;
@@ -417,11 +404,19 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv)) {
+	if (parse_args(proto, argc, argv, &fname)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
 
+	if (fname) {
+		net_boot_file_name_explicit = true;
+	} else {
+		net_boot_file_name_explicit = false;
+		fname = env_get("bootfile");
+	}
+	copy_filename(net_boot_file_name, fname, sizeof(net_boot_file_name));
+
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
 		size_t len;
-- 
2.43.0

