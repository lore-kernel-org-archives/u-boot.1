Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAE4D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82D7D895DB;
	Tue, 19 Nov 2024 14:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hsvC3gqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 478E68954F; Tue, 19 Nov 2024 14:19:45 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 228ED89592
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a778cc0e5cso3022955ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022381; x=1732627181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sV88fgYoBJ0w3vnHzgvmUJKm2N4nxpw1x046+S23dkM=;
 b=hsvC3gqF01Dq6b7kA1Nbu6blcNqPolYfGQWYypYop8iHaFByg/RTS16IcUGXpEP3R2
 S37Z+PhfCXtQdlPW9MwlFJHXNRmxqw5D3NNeSIsLt9+KVYz7TkiUO/LI2CFe/vnc0atu
 MTSci/oMGYBYG9v30dkOyaW8r8w+RpiwnQ6dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022381; x=1732627181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sV88fgYoBJ0w3vnHzgvmUJKm2N4nxpw1x046+S23dkM=;
 b=sOSiaeVPQkCl1tVDH9vjrG79GpkDyYvhQClFWjmERmx5n7FZMy8zR0xIrJJghtgTFb
 9nmjXKkXQ/aNYHRtE3BiBb78OBAh6soZbO6Y+AJlkXCYTPIEomhPx2nIA6+cQ6eNFYVW
 5WabJnI31iy/0jSrS3AB4zw1W0feVXPagciBnTk4P7VoOeGzdvsmDBJu8f04ycL93H8t
 ZzIoVFe2sKzDInnynWL/bF+EuH5YTBfc871EwVHoKcUrSdKpw9wUuiMRy36Hz4syUhsc
 I29Ehpm1FbR4s6Dw1kbIff5Mg9kgU//dwhpp8lB1De6mWAlrfzPvLrUNQRASF1Y3iy2O
 Gckg==
X-Gm-Message-State: AOJu0Ywah7C6t6MftIiirR+vdCOyl0qbZOFy9xhOYpThJrHDtAdhRN8x
 vEg4EAy2Mbj541kplCwLtWtn4/dR8A4DKzr0GkMn9BqW9yTRGVtjv7H1YGoFOT+QUkUG3Z/n3VE
 =
X-Google-Smtp-Source: AGHT+IHM4vbB2ZiWSNQaUkDi9lFLEDwtBroEZsb+W0vA+7gBN1Mu13SS0D5kk6aA9hiXdzGuk7ucPA==
X-Received: by 2002:a05:6e02:1a02:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a74800eedamr160807675ab.7.1732022381418; 
 Tue, 19 Nov 2024 05:19:41 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 19/39] net: Return the address and size from parse_addr_size()
Date: Tue, 19 Nov 2024 06:18:24 -0700
Message-Id: <20241119131844.4078144-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

 cmd/net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 857daace78d..920d9918ff6 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -295,13 +295,15 @@ static void netboot_update_env(void)
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
@@ -354,7 +356,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 	case 3:
 		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
-			if (parse_addr_size(argv))
+			if (parse_addr_size(argv, &image_save_addr,
+					    &image_save_size))
 				return 1;
 		} else {
 			*addrp = hextoul(argv[1], NULL);
@@ -364,7 +367,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 
 #ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv))
+		if (parse_addr_size(argv, &image_save_addr, &image_save_size))
 			return 1;
 		*fnamep = argv[3];
 		break;
-- 
2.34.1

