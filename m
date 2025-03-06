Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09B2C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5549681668;
	Thu,  6 Mar 2025 01:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aXo5VmWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D3DE819D9; Thu,  6 Mar 2025 01:28:16 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86F18175D
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-854a68f5aeeso2301239f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220851; x=1741825651; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GtHwqmdyIzJdXeO/Et2LHkjANQM1e5uk22IUlGHoDE=;
 b=aXo5VmWDHfEOWVHGwEyt5VZpS4VQ0olVCXpNBJ3ticNmGqfWXQGBRjHd2boV33XT7i
 ZWGVRsxvqFSXIweMbBtTXKK4x7CHBMESK/aqLA7rw1IJmVLHewVcjN4dho20iZThtHDT
 /FDF+eqEDDe7iriPUWC6TjbIU4sOE+Jzka8tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220851; x=1741825651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GtHwqmdyIzJdXeO/Et2LHkjANQM1e5uk22IUlGHoDE=;
 b=MEZQyRzZZGprr4e0DNfwYvjPgIlC/ehHh6AzvZe71Vtu2JcrGoQ0BWXwE71axL2Uq5
 pxd4ajTLjRPWBeTeNV49hp3PSo/5i/+/7Cjh4VZZHbNLeGygTy7iSuS6nJgKVhFTUQ+w
 RiE4h1KOOJK4HK6aGKSZsk0/yNcxL8u560MPI1UaykFseMeWtYK/tni8lszPIxKL1+wr
 V0wvdPBCSjD0TOCBgAg/SWBNrpJqTVaXZxNrx0DQVjhNJfKs89Q9nltSI15pLoRr+Eh3
 gfJBq3DGWq18QGfeE6TEpYCrDVvYHl3ZhUA7V+XvZx98eZegw8XJJlLJUn8qdOJVfMC6
 h1Ow==
X-Gm-Message-State: AOJu0YzK6sk+ZfJ5xYxy0B4hju/CQDcxQLjd4M4Cz2EZNK4ZYsNXxLax
 SyUu8kcC/WCn4HEATFfCJurqpwJKn9zIfDvvixTZdu+i4wtkSWQgEppIti5lt+PaZ+Hq7NvGCLI
 =
X-Gm-Gg: ASbGncuDX+YI7CN5LEsWhu2hhuWzuQRSpWtpGiXv4SCmF/2cEV7mHKueTGJWYNqWUBH
 tg1GtMSvvuSdc7zAiQeQ0I6jsiTuGypTbAdJaIGbjfuCLlQh1kc3u4MRIB9f8LOoedqE59mi3pI
 T9WNAquu7X3dqKUQAleczBtn8kfr7GpvxqAKE9+ns6i7JuBmpItPW1OGpOXkTxhJKYNHCxAzYsD
 gNd+Y8LTLdmd6MVMAnqmr6Z47l1xVnccGVeXAXtdcmkeccIm7x3nmfOoshTLI5qXS3WnQPvD2WL
 PAssiPKRPJ9jHee/X40f6KBrJcFUMeWPVyJraeh7ScMioAnHDBX7Rh1t8iAEbBBZy1gwJCY7SHY
 DvKt5Kw==
X-Google-Smtp-Source: AGHT+IH92oDMJdATQn+z1BxkaWaVh+pN9qtCmcZ88qGtAzPQcIzcVK3L6rpjfwrVyfk0UZrhRAEC7w==
X-Received: by 2002:a05:6602:2748:b0:855:c8e0:8b9a with SMTP id
 ca18e2360f4ac-85aff878c65mr540149739f.1.1741220851090; 
 Wed, 05 Mar 2025 16:27:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v5 24/29] net: Return the load address from parse_args()
Date: Wed,  5 Mar 2025 17:25:18 -0700
Message-ID: <20250306002533.2380866-25-sjg@chromium.org>
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
2.43.0

