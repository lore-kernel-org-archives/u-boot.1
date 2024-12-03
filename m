Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC42CE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1D8896D2;
	Wed,  4 Dec 2024 00:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fa93xjdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4741A896DD; Wed,  4 Dec 2024 00:47:12 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055AC8969F
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-841a9366b08so199595739f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269628; x=1733874428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+310A69RNHaeLpwQcsGXHqFegngMu3nd8c1Ch+d3To4=;
 b=Fa93xjdMfijoTZYX3A83S1hUET8tAWvIgBuRyLG2bKT/VqbDJ8LuTa726CimotDv26
 4N5pw1n1BvUQaHvejs9Ceja2LfvOZh4wIj8YiEQbWK4Brcd8pTbRLi+8egW20+i4BIBJ
 +oBEce7jIvMkx4JKvfT+aS86ICCAUnrWlTcf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269628; x=1733874428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+310A69RNHaeLpwQcsGXHqFegngMu3nd8c1Ch+d3To4=;
 b=ZNk4T4bPC0mjvmZcN5TAsyPT/d3bpUAyudL6wkOGiufQCfkof1QnJRXltRDWAh75nJ
 /9KPcSCZciGrdr8mmLyJf5J9nq8+GhCqYzpHMhjc8STsD4gKP3WcpnH4hwjJ4RkTmdrj
 C8KmMBQPfEYCHHIIehvwQXJXcbyuDUM0kfRziwOVkR3LYVlVg76O9leaRgFD5inlSe90
 9itQUeFUmLhSLvDQcXTmz6r7ml177kQiaHI6tpVR9TzQ2382jP6rdCE9z2zQZA8G7dNc
 1nbQGlt1u1xg4dwXsGLjh2ZgQH1t9yh9TsBnzxyAGHrR4o/F/yPCMnwE+5/v2Us72Y6Z
 KM4Q==
X-Gm-Message-State: AOJu0YzqS3uKS2JmghZv8nIf6EL6mzcBagnHjANnKihhLy7gjS1tA2Fr
 gYSxyvXi1Hqd8SHU48OPY/vaHyA1ElrVfLVZwhfgLQdMPGLitEWdaT8yNktUJ/qVz76+mkfklU4
 =
X-Gm-Gg: ASbGnct7IFd7nO9JVFY/HfSX30LgR8m1eW5t9vvixIQULPxKZh/u66Or7YGFB5jLKSa
 AcRvKYg5jI9NWO2lZtJPeBlbxUXEHAh+Yrg7vWHwhh24VILqggmgL8Yaxp3HZOC0WFJjBUy8jfg
 Ll0dClptBmgh8Ra+8sArgxqjiaEVLngxzRxr/M8gz3z8efDixoIbWXEWZzfyHSSD50mKxBp8UK+
 4DgDb3S75I5vL6OJIIOuXjhzYWpDK0kuLV9fBAwsWYNPyK41V/rU8fq88K2Bc0tpA5TtYu8qWJU
 KQ8mFaIfXF0=
X-Google-Smtp-Source: AGHT+IF2RPLSrCbFkf6SmyQSqm4RhhWatEjA9/v8uE0iX+HH3ZUjZLuH2hzRoCEIdy1prcQCQTB1Mw==
X-Received: by 2002:a05:6602:1694:b0:83a:aa8e:5f72 with SMTP id
 ca18e2360f4ac-8445b55af77mr618269339f.4.1733269628223; 
 Tue, 03 Dec 2024 15:47:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 20/41] net: Return the load address from parse_args()
Date: Tue,  3 Dec 2024 16:45:38 -0700
Message-Id: <20241203234559.2938192-21-sjg@chromium.org>
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

