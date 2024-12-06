Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036F1E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE51789754;
	Fri,  6 Dec 2024 03:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aEKf4LDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1571589752; Fri,  6 Dec 2024 03:37:40 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6E0489740
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a7d690479eso6944345ab.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452656; x=1734057456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+310A69RNHaeLpwQcsGXHqFegngMu3nd8c1Ch+d3To4=;
 b=aEKf4LDESCnj6Q6PtpGf+hxMgEozkDlfoOhkjctuzLPWqvd5ifHarNcDhsZ+fk0IzD
 smVzBjvhuKSFqCzwaz6seKSP/nIb7Jr4rOP+OKVtJ1rdIRlBE+a8gLZeus+gr3HH48Lk
 sK7DBTy5BaAOKT918eQKQXp1GChvahwnR0A5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452656; x=1734057456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+310A69RNHaeLpwQcsGXHqFegngMu3nd8c1Ch+d3To4=;
 b=FDvsVR+N1J6UeofEBD6+8HkKhEdzAHnbDsRIe+/Jz8bMgzswfrqQlAgfAU5V7lUKwN
 acEm1iYZ43br/ynMkTwTcDdpnHEtjN4dZ4e54vo9NTfZMbMdRdsJaabF7icn1/R9To2R
 qoA8jaAUwTImJLuUQ9HCmqXwnmevZyM5Kyb4uBPDK73+hb7qYLQznwUb4D10949AAyX1
 5ETormosKdPSvwdbqyb9v0Nse2AXxgWGDIr2BOZCB9ur7LX2GRiodCZvDmksW28X5aR8
 ZdIH5eTIWyRyYK0RkTq4DEJzirmvhJrdY8yeNpawBsbgXBCqH8g9xKuiHWIkfLO3y9Um
 H31g==
X-Gm-Message-State: AOJu0YxwZbOXLz8GM90SWcR0kTURJ+9qnwp/8aAIgjXGCcIwA88zMBxb
 mkjXkU/zDO2gISXarlNUdKtz3JdEohSH56RDVzP6AFqi7au/LSSfXEP0254Mhh0vp4fjYX2sc3M
 =
X-Gm-Gg: ASbGncv+wBD4vsRFbFtruUJxAEZGxujvAFjUY3e4SLaCxwEPkUXAfAgCQaaiJYtJ7ok
 Wq+qqvY2TyPQMr8YjdusTvRYnQXhve4767F1mpKQ3tkaBL+0j3oXxW+N/n/Up4ECN4/hHNOYTf4
 g1tIqCe3c4JTDDYJnbuv4wZY28AuatIl6cRSKAvUcmNb9u4cwyeOdSUvhou8eH4sPhfy7hdwjt3
 1Lu9GFJnZnvBJi1pFlKvtV0RlvGp4HXHLAdBApKNnfBqCh1HYf+FghUdbN6PIcAjbHncd01l9wK
 Rs/AJN7cEOQ=
X-Google-Smtp-Source: AGHT+IHWTRQtLYaqwYr/D6wg0fCfFFWw8jB39eCLVzgFuCGqaoy8ccowCgXwNvhVmLa9gaTEZa7Zcw==
X-Received: by 2002:a05:6e02:12c2:b0:3a7:e047:733f with SMTP id
 e9e14a558f8ab-3a811c7a445mr22883055ab.1.1733452656151; 
 Thu, 05 Dec 2024 18:37:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 24/46] net: Return the load address from parse_args()
Date: Thu,  5 Dec 2024 19:36:03 -0700
Message-Id: <20241206023626.2456858-25-sjg@chromium.org>
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

Rather than updating the global, update the value of a parameter, so the
action of the function is simpler.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index cc7d14eb082..d15d344cb54 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -314,7 +314,6 @@ static int parse_addr_size(char * const argv[])
  * parse_args() - parse command line arguments
  *
  * Sets:
- * - image_load_addr if a load address was provided
  * - image_save_addr and image_save_size, if proto == TFTPPUT
  *
  * @proto:	command prototype
@@ -322,10 +321,12 @@ static int parse_addr_size(char * const argv[])
  *		parsed
  * @argv:	command line arguments, with argv[0] being the command
  * @fnamep:	set to the filename, if provided, else NULL
+ * @addrp:	returns the load address, if any is provided, else it is left
+ *		unchanged
  * Return:	0 on success
  */
 static int parse_args(enum proto_t proto, int argc, char *const argv[],
-		      const char **fnamep)
+		      const char **fnamep, ulong *addrp)
 {
 	ulong addr;
 	char *end;
@@ -348,7 +349,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 		 */
 		addr = hextoul(argv[1], &end);
 		if (end == (argv[1] + strlen(argv[1])))
-			image_load_addr = addr;
+			*addrp = addr;
 		else
 			*fnamep = argv[1];
 		break;
@@ -358,7 +359,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
-			image_load_addr = hextoul(argv[1], NULL);
+			*addrp = hextoul(argv[1], NULL);
 			*fnamep = argv[2];
 		}
 		break;
@@ -404,7 +405,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv, &fname)) {
+	if (parse_args(proto, argc, argv, &fname, &image_load_addr)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
-- 
2.34.1

