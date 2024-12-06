Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78962E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D7C895DE;
	Fri,  6 Dec 2024 03:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R58gKkpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EDC1895DE; Fri,  6 Dec 2024 03:37:34 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5F28918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-841a9366b08so47542939f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452650; x=1734057450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WGopKjGf+ZI5qRJVXEab18RrPazU4gYc+ZJYFhUg1g=;
 b=R58gKkpvCmlWiB6S1y6UOl9TzAwPk4At9L7j7uaOARCNSY+WQ87bAN9/A1IvPZNZeR
 gMrb0bgQ5/WmoOkFfTpIKur8dvqceURJJfhgpHQv2n9CVwCT7pReCtwB6nnDv4XrN2nX
 rli0RsBCbRk9y7Kw6JPFppFk8FXdJwijsMT5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452650; x=1734057450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WGopKjGf+ZI5qRJVXEab18RrPazU4gYc+ZJYFhUg1g=;
 b=aRhPTMsEp+EmwQRz5MySgjg9pamzkJPQ67GEYeUP8kAa4KiwRn0FHrmn/vvuKVPJpF
 knzwC8sD6FpOnY4N4gLSIfNPNF4PbiBKkBw4YMlRupD42ntuk4et9xw5YAMSuxxEl/6h
 jL4SkDtsa4kDet1mkZS5nv917Lm6n2TnwdnsVKLG96FlrkukjjxiLctg5TZjufJTWtQ8
 qKqdUuEqa7LvbioZu8e65Q9kFoMqCLnJyTPS9l1jo0iR7dJLWIjyjnX/9LnFsz/B/k4V
 e7LieAR7ZI836f+4M06DVS5OPNp+eafOLrIxlf2EVEeNAU6WDMHZ820tTcVA/isuP+eB
 8vHg==
X-Gm-Message-State: AOJu0YwsZ1hKRI/1IoOr+V9Znfl5/Az/fP48wGJYpJPtsAcdX/XQKA3T
 U+IiV68U/JYNe87Bxz9Nax4DPJSITqWL4E85J4h+YtB9sRtrDqak4FxFxsCBbLoxOGLkZijpx6M
 =
X-Gm-Gg: ASbGncvlQve6kEX2dXT8AfELb/iV4fiAeGK9xxqfJ9qhXMPlT1NlIOVXOmqWtFHeWQl
 UyXz+8LG5a8ZuTxE6nWVe0sX8S2RwkCxpk1CSwP388oNJV1ktsQEu/Fwj5NNafp+V+74OGC9AnT
 Folb9XHcw4IXrbPzdN6NH16K9l/fKT4xebzYCqt9H5yhL4N/Jz2VlkcNwqrCmUdNNwcFuOxLl6y
 O6AWnRiIu7dWNZ03PcyR6Y9y591hDgtxHFGEtVQM/Qsct1q8rHPtuqeFITC6tlEYjAoIuOF29Q4
 Z337eIDaCcA=
X-Google-Smtp-Source: AGHT+IGBphKGyOMgKv4yTHGrhLZ4EMntxsuXJ2ZvJolBPg6Q0YWwPp2w6CvJcu10zuU9lOGsGkb2aQ==
X-Received: by 2002:a05:6602:3422:b0:841:a73b:a978 with SMTP id
 ca18e2360f4ac-8447e23ded3mr207461639f.7.1733452650322; 
 Thu, 05 Dec 2024 18:37:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 22/46] net: Tidy up the comments to parse_args()
Date: Thu,  5 Dec 2024 19:36:01 -0700
Message-Id: <20241206023626.2456858-23-sjg@chromium.org>
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

