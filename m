Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7484CE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7630E89691;
	Wed,  4 Dec 2024 00:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EJtGlFzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519508967C; Wed,  4 Dec 2024 00:47:17 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171458964A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-8418f849466so206934039f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269633; x=1733874433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yv39WvHDrKZ7gT7q3Ct6k+vlbpMf/MblKm3sDcXH3hw=;
 b=EJtGlFzhxqbQs9z47vJneOFlNAtPTvNZwmqXihgUaD+Rou0hnyp4jMuTsHDJwVHyMx
 feuTmmkErKngaMHxJG6SWh7FCf109Z3egTntqY7EWNEbNfIdFtM/tpHBya0w0s4QanBb
 EpFSFhYpa04DZsikrMc1PFoZvxXFogNU+vlZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269633; x=1733874433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yv39WvHDrKZ7gT7q3Ct6k+vlbpMf/MblKm3sDcXH3hw=;
 b=rkG8MHhtXutjo4QwduOEDcbJMXYBJh1ovogN49I6dePo2FDxhe0Ul8AZNexyUTjBt4
 3b996kO49bENDjl5q3wIBm9ZrWTLsHC7glldvHWsERFUsKvRTyu9tWjWBkeqcHgcilpT
 Z2VFADWfOrU0t4H7GQhgaxAEAYL92nvLwBZV7o+YgCkb0RrXbjBICGii7vnAisEz6Nnj
 75OmejS5VhhN4MfrWSmv+n7xsV+vdRHSs31MBUGhTxxBgkWyJcIRJx9127n+DlJ4kcw/
 qTtHkd9qQUtL0VXeuFP53iUpKykf60fuTnKLM+cdREByHSWMFDBuluYQ+aqgiFGfG1U+
 kuMg==
X-Gm-Message-State: AOJu0YyfFXJpO/muVgLXwLHyXoTPo9GLOKwj8aI6YNRnFqv9ssgXFQ0k
 LBayCiP1F3Mu1lUlX4h67micI7nvihaWBtNkX49q/f7JvLByAqVvP8BHoHyzoFOc8XP7We0K06A
 =
X-Gm-Gg: ASbGncsH0RNt5G25Ej7+ILd2ds0kvr70zvJ/HExW7TLN2zxXXjmrNfTnpwirWM65drQ
 uDOoczCcp5HfrtwJ30z71QR7TlIu3RaNFgMeJwnG/GtccROhNVeJoxaEwfaacwSvIzahaNDfaqZ
 WWfDlctCrPwS2zua4EkpEmhshTp6w1Ds7gCR3yr03MNwHMxcot5WSyilwkBBkZwWcyUXazq4KAB
 GnZWjfuBNLcpSHMMe6h0DRUcx5ySxc9tQGdgdU0xuCQkvncXcrIep1a3aKWE+fCz6RFWozC1Qwo
 MNOhIsr0X3Y=
X-Google-Smtp-Source: AGHT+IGjTu4eyAYkwnvWphV4kz0dOFoaguwpEUEW8y3IezzvxP4ThgqaIB79z2jcX9WaevnaiFxXow==
X-Received: by 2002:a05:6602:6015:b0:843:f30f:7d77 with SMTP id
 ca18e2360f4ac-8445b5721a2mr579495739f.9.1733269633327; 
 Tue, 03 Dec 2024 15:47:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 22/41] net: Return the size from parse_args()
Date: Tue,  3 Dec 2024 16:45:40 -0700
Message-Id: <20241203234559.2938192-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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
2.34.1

