Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F2DE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E62896DC;
	Wed,  4 Dec 2024 00:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B4J7+jUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74719896D2; Wed,  4 Dec 2024 00:47:06 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44E7C896D3
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-84183532291so257514039f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269622; x=1733874422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WGopKjGf+ZI5qRJVXEab18RrPazU4gYc+ZJYFhUg1g=;
 b=B4J7+jUvKc7yRSQOpyYbPB+D2P1/pt8LL1AhhFnLNjDFKZIamaKl+3wTDqh3+2/POB
 gi3p6rOCeBR1AdrH3hTvsM5WXXexzuTfWfFHnD8ZYsGu991q1F8u0QxpcuZ6q8PEIZ0g
 YjITObtMyj0ruEeitzQltjVmVk2ztl6+VSV50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269622; x=1733874422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WGopKjGf+ZI5qRJVXEab18RrPazU4gYc+ZJYFhUg1g=;
 b=lwAKT9MmUFduEO1A2equ5PX3Kw+tds8sfDPaAgY8NNF6AcpYPdamTLrRqdHHmEII+2
 z8UC+305s5l7QyQBZ5rJqljfpIT+E3MM3XUybsoD/b5PuHZjLhX7Wf0TkZtzcmgit9Ou
 FbXD4dT3JspvSCEWZD6CVhD6P5E1XFYOQkc81Wj2zQz+o+Y5lZ0tgmFdQItAeNPOFvOB
 pi85dsOdgBndIQZoOSMXG78Toy9ElBSwnON6cgkX9gcKpinbNuoq6/160GI6D/7G9z6X
 F/r9ECH5FR19CbvAwwMGEPCLME/r7t8r4mfR6LUhKa/0w3J7yGceMsUWp/2ad8egt2uL
 +DFg==
X-Gm-Message-State: AOJu0YxQD9G3zosjH13c/pfKOJpHtuQ5P5ksbANL5h8YaiAD+5aLNYSg
 7p/2rguSSYsFWXyS0CLN2FacT/wRILrAEnkNfckSzw4kS+csipJnoUXD1mGrmfDIhUhmQ15SshU
 =
X-Gm-Gg: ASbGncvOg+gSlf61IoIRnMXnGqBE+y9GUCylRE9zSKBi79jMmH6nrA1BwB+ROBNL+eB
 TvW1jpesHU+D8E3H7XqwzkYzZN1BM9ihqF87lqT4cpRFeCNUvNuV5WAjrgbDiQPRWRstvbZ/Uzl
 NdQPjwhb5y6DY1N10tyN8bcIbu1zOL27vv09TjF94QgL68UrcYi1n3RH6grF3R222h2ZC3qnP77
 3RVXVMg4gQ/KcVfpwuDSRaW56fMNaoujuGa+PEpbc2dOn2K3RcrkzCWV7jEd1RmzCGEo1mZEMFh
 y3FBNyS/EfE=
X-Google-Smtp-Source: AGHT+IGDw+/Pp+iLynfR3XZyjojpR7d5uz4raYZABqeWflsIDrV+PoFwVw5SfHA3eNgJ66+S3phslg==
X-Received: by 2002:a05:6602:6b19:b0:843:e9c0:8290 with SMTP id
 ca18e2360f4ac-8445b5585a1mr542977739f.6.1733269622156; 
 Tue, 03 Dec 2024 15:47:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 18/41] net: Tidy up the comments to parse_args()
Date: Tue,  3 Dec 2024 16:45:36 -0700
Message-Id: <20241203234559.2938192-19-sjg@chromium.org>
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

This function is a bit vague as to what it does. Expand the comment a
little, to specify which args are provided and which variables are
updated.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 cmd/net.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index deebd5b710f..89a4d9b38d4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -313,9 +313,18 @@ static int parse_addr_size(char * const argv[])
 /**
  * parse_args() - parse command line arguments
  *
+ * Sets:
+ *
+ * - net_boot_file_name_explicit to true if a filename was specified
+ * - net_boot_file_name to that filename, if specified, else the value of the
+ *	'bootfile' environment variable
+ * - image_load_addr if a load address was provided
+ * - image_save_addr and image_save_size, if proto == TFTPPUT
+ *
  * @proto:	command prototype
- * @argc:	number of arguments
- * @argv:	command line arguments
+ * @argc:	number of arguments, include the command, which has already been
+ *		parsed
+ * @argv:	command line arguments, with argv[0] being the command
  * Return:	0 on success
  */
 static int parse_args(enum proto_t proto, int argc, char *const argv[])
-- 
2.34.1

