Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F290CE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2B489740;
	Fri,  6 Dec 2024 03:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kx0fKMUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4619189749; Fri,  6 Dec 2024 03:37:42 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BFB38918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-843e3b49501so49215139f.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452658; x=1734057458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TASgF64mELNe+oUxBSLXMSx1uLGUSsbkbeCaOKlmuAo=;
 b=Kx0fKMUWyhZLKoNMUTHNhy+Xr7xhEdOYgHo3zcsl61TLWXiflomAii2467RoqLrV+q
 gI+L37NN0/dgrDP8em6WruoZwQ+OG8otGOPJKhUHxU9lrBFgZxT0WN2HBIUvC4uDlGE+
 fworPfcojJ3Ami9czZemV1dGg3kipJdg+obBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452658; x=1734057458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TASgF64mELNe+oUxBSLXMSx1uLGUSsbkbeCaOKlmuAo=;
 b=s/ALUacQrOYqGga8fRW77Aa0iZjPpnmtTYBV1kHShxFL2lFJMKhowEXiTLYBhzIz/p
 Gy/u25Z/BG8fDiiqt3bF7ak7nzi9ypsX4HK2Vy4mgwcGbY2FoP2LVxVaiQuSAJpWdTaP
 KQNdgVeT8WB8nv2qEPli1S9BabBGQxWQi21U2TsYm5lSEApIGKnfmIArHPKpN09d/kuq
 IXyyfNBV0fUwl6dFwkklqxAySI9hhGB5PX7s2qVUrVRapbHm7Pr/klIkF2Zioi86sseN
 9XtRRAI3rG9W0pdN8YV52kfDO6v63xHs66DVmSh2AjMpsDcpvbLmUmEaeKW5YqyVW5UK
 /wLQ==
X-Gm-Message-State: AOJu0Yw7pyA7G06tpDTSoVhpQdRqNtO6wxYXyiXEACrh/Hu0jdfP/4qA
 Kg0NpyxVbhvBXHbBVRpClyBKdPjigyoFNZ3l4BJ1x9vUuJFYRkfwgPUyFbV5zqqEci2bIcuutAY
 =
X-Gm-Gg: ASbGncvLzk9bla81Q8j+H2QS8QBsPc4fmKizePPk/8Vg97SNLO+BfyXLRYMQ5okXSV+
 Mk31JgsB18j5UrOHYNrZxFsfXgtRfiQbxjmzcnRNRuuqW0Xav7FwDySheeX9Ss0PUingseWAeyq
 jnP3mXPvAWE0JapfXXVumVSBkTbm7/PxGjh1snpbLprhrlPTcsS83rXgz5LrbksDHGJoXaqQO0g
 OYnVC5etEWnYGWd6iQfRzBxzUA3A2PYmgvJ25eyt78Fz+YbF4BF9RALI9Q1edKb9Fz3SYnju7aG
 O0fxz7T3xqs=
X-Google-Smtp-Source: AGHT+IHMxsJ1yjUpcXsGPott6WaN/8uI6TPUOVIfhkEhE8UqMF08e+Gg/KW8wQmc/O0+zo35JYakrw==
X-Received: by 2002:a05:6602:48e:b0:843:e667:f198 with SMTP id
 ca18e2360f4ac-8447e20004emr248070239f.2.1733452658247; 
 Thu, 05 Dec 2024 18:37:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 25/46] net: Return the address and size from
 parse_addr_size()
Date: Thu,  5 Dec 2024 19:36:04 -0700
Message-Id: <20241206023626.2456858-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Rather than updating the global, update the value of some parameters,
so the action of the function is simpler.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index d15d344cb54..cc968e9460f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -297,13 +297,15 @@ static void netboot_update_env(void)
 /**
  * parse_addr_size() - parse address and size arguments for tftpput
  *
- * @argv:	command line arguments
+ * @argv:	command line arguments (argv[1] and argv[2] must be valid)
+ * @addrp:	returns the address, on success
+ * @sizep:	returns the size, on success
  * Return:	0 on success
  */
-static int parse_addr_size(char * const argv[])
+static int parse_addr_size(char * const argv[], ulong *addrp, ulong *sizep)
 {
-	if (strict_strtoul(argv[1], 16, &image_save_addr) < 0 ||
-	    strict_strtoul(argv[2], 16, &image_save_size) < 0) {
+	if (strict_strtoul(argv[1], 16, addrp) < 0 ||
+	    strict_strtoul(argv[2], 16, sizep) < 0) {
 		printf("Invalid address/size\n");
 		return CMD_RET_USAGE;
 	}
@@ -356,7 +358,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 	case 3:
 		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
-			if (parse_addr_size(argv))
+			if (parse_addr_size(argv, &image_save_addr,
+					    &image_save_size))
 				return 1;
 		} else {
 			*addrp = hextoul(argv[1], NULL);
@@ -366,7 +369,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 #ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv))
+		if (parse_addr_size(argv, &image_save_addr, &image_save_size))
 			return 1;
 		*fnamep = argv[3];
 		break;
-- 
2.34.1

