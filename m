Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9153D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:21:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CFE0895CF;
	Tue, 19 Nov 2024 14:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EJKjm9+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AD4D895A5; Tue, 19 Nov 2024 14:19:43 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EEA4895A5
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a77bd62fdeso1890415ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022379; x=1732627179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4YiqIOJMOAdJ6fjQ2s4ubWlTKW38SqPoiqvK2PYRwM=;
 b=EJKjm9+rL982+XsnLDM6aS4/rPe65HlJhuq3Y9UpgY07/lFRTkvMrq5MoxDtazDPRn
 BlUz5ZmQuCwZC/j1os1uR/qW3Nvb6s6sPTYMxtBFVEygI03atfCBSpuHrMkoQFoOCB3+
 oX+MUov7F6qt1R7qRcj0VRyBdGActNCqH8BGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022379; x=1732627179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I4YiqIOJMOAdJ6fjQ2s4ubWlTKW38SqPoiqvK2PYRwM=;
 b=QTpkr0UUu+frMDkAspMwUmZo6IbuR+caTnH3YJr0pPrlWHLlGMCHmvcW2zfMjteaKk
 YYSQJ21FhbZz/Gxpf2Y/sALU+gmrYNKBm0fasAUc+Y6azY1S1AVsVk5x9/lLwRwv3+uo
 BC9s33XHjRgS+hOI0fGx/lHi3Q6567pgxSLn0yg70qrtNqxAlaFGT3VKX7OQ5eS84TUo
 3CQFh3tiIKzrlQL/NEaVkYg3ufCrTq5zdPId6sS0bAyw261YPz0Lj1oA7VZe34z7D34M
 TsWo3MttbqItn1XlsXFS7Y+4mM9BTRfZbBQ0Fw7PGItvdCItOgldMF/1pgKAC7qjWmUZ
 y2ww==
X-Gm-Message-State: AOJu0YxyDNKbGvLpWfGOHDmcM1XHBOZKlGzXjaDGHWJmLlTz0YR5Xubd
 IQHSYEvHsoMDZzVVQsBgJwURL6hVQgYQlqy8+EbPeCT50Anm9omu1bH9/XfyKyfm91PaWPwDPnQ
 =
X-Google-Smtp-Source: AGHT+IHTn5oLGfelTqRfz8/u6CqvsMXWGxtoYCdHAQCj72Wv53e1G744BvP8xKsKWFoCJ9by6pMZfQ==
X-Received: by 2002:a05:6e02:1d0e:b0:3a7:7ee3:10ae with SMTP id
 e9e14a558f8ab-3a77ee314aemr13939635ab.16.1732022379338; 
 Tue, 19 Nov 2024 05:19:39 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 18/39] net: Return the load address from parse_args()
Date: Tue, 19 Nov 2024 06:18:23 -0700
Message-Id: <20241119131844.4078144-19-sjg@chromium.org>
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

Rather than updating the global, update the value of a parameter, so the
action of the function is simpler.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/net.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 7c7489efe4d..857daace78d 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -312,7 +312,6 @@ static int parse_addr_size(char * const argv[])
  * parse_args() - parse command line arguments
  *
  * Sets:
- * - image_load_addr if a load address was provided
  * - image_save_addr and image_save_size, if proto == TFTPPUT
  *
  * @proto:	command prototype
@@ -320,10 +319,12 @@ static int parse_addr_size(char * const argv[])
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
@@ -346,7 +347,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 		 */
 		addr = hextoul(argv[1], &end);
 		if (end == (argv[1] + strlen(argv[1])))
-			image_load_addr = addr;
+			*addrp = addr;
 		else
 			*fnamep = argv[1];
 		break;
@@ -356,7 +357,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
-			image_load_addr = hextoul(argv[1], NULL);
+			*addrp = hextoul(argv[1], NULL);
 			*fnamep = argv[2];
 		}
 		break;
@@ -402,7 +403,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv, &fname)) {
+	if (parse_args(proto, argc, argv, &fname, &image_load_addr)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
-- 
2.34.1

