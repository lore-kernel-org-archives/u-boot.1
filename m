Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8A0C282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B10E812BF;
	Thu,  6 Mar 2025 01:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c9bNTBtU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5818121A; Thu,  6 Mar 2025 01:28:20 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C35E8193A
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85ae1c53da7so10576639f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220853; x=1741825653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O69SvIE/6QL9AcFSl8ap2q3RmknLN/Go7wd2WOx1hU8=;
 b=c9bNTBtU9BTh2yvi3BKmt4ITHtxWG1UdN6uHioNlzw3Wyccb1bLUEnEVcYXJZfn/Ch
 390PLutFCYrTq4Scqxf0vRdizDii4Ln4VCgkoTtJPH9mu/wCzRJRuttar07RXpHQaRfT
 048q4iGZ0qr6WqdkO2IhURQQdwAvjiaj7V0T8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220853; x=1741825653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O69SvIE/6QL9AcFSl8ap2q3RmknLN/Go7wd2WOx1hU8=;
 b=HnGzWiwTXWbX5mSVjLO44oV1aXpgXiQ3Fe8P+DkQ/ddm/2mMF/HiAope5VSVrHB31k
 cge6v9wJ62sPUpXpR/nSW9UL3fjJLxEZRDXheorrkaLgNtq0knqLHYs2Jusj9nTLKUQj
 spffIiFA/x8+GzB5tk4k4pM6THeKPkGHGJ8IC1aLqCBuleZ9MiRiWsChn8MfIQFBsgGg
 GrXhHPqLnwogJqBdN6wssEl2l8Io+36akJq9TIhTdHRCIiGvSdwvm4GqhqqGlP1NE38H
 aDPUEKPmIS+jBRQZUd5IXkj9uPtXK5lj+U9FM2Wjydcz9QhBpW1rA9i799unKYS2KbmC
 ZAoQ==
X-Gm-Message-State: AOJu0YxUdi+MYO8gDknqV0ylHoGI9bxVPsZdSHXXKmeWLTD4C4w38nJF
 2/Ugqwhw51hw6DiyW7PmHf8KhWrTZTPbSQux17/+SYZ/7/xPmybwRQXWswU7a1a1n+Sh55dTu10
 =
X-Gm-Gg: ASbGncvNRm1RIiuQ6ZDzWImFFMHLAaITADSsOwyxi7GX3H+abQPpaLi8B4t/2efGMGc
 3XBx/c+9gg4WaBdwQES1U2ZYVimuL9vYYyqaZALQMIxo3i0onS1B2ul8pl8lioJLGc+u3FbGAhV
 yUMd+30PI+mJAYG/bQcx0DB3wJHoDVLcDKQsFQd9XJeqMVBN+roStudQ0drdBPRKS8aHa10s2wz
 iPBO4jeAbAPzzl9y4nc36XacuyMsiAI974W+UOCSZj5Ydc2mRI7EJgFOS3Q6Hj/I2SEzOxsMhiO
 4yJl1soBYe7seMi7NK9Z4W7Qg4BcVhOA08ZJ326MkOQ/Fqj8E2oCvFGTYFFlqsBiffkZsYNu1n7
 hb/GGGQ==
X-Google-Smtp-Source: AGHT+IGBj969Np5bjlxZMXIkVfugbE9wC05ylnlOEbYdapehu8PA3pie6Q7BwAEH/FSbHI4EwrIY3A==
X-Received: by 2002:a05:6602:3606:b0:85a:e51d:ccd1 with SMTP id
 ca18e2360f4ac-85affb87884mr617719839f.10.1741220853405; 
 Wed, 05 Mar 2025 16:27:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 25/29] net: Return the address and size from
 parse_addr_size()
Date: Wed,  5 Mar 2025 17:25:19 -0700
Message-ID: <20250306002533.2380866-26-sjg@chromium.org>
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
2.43.0

