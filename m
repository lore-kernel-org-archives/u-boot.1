Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E08EC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D054A871A2;
	Sun, 12 Nov 2023 01:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sy/EkJRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0D987654; Sun, 12 Nov 2023 01:10:16 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA44C8709A
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7affff20d38so82495339f.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747784; x=1700352584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grN2G0fdNjhLpAtoP6/FZTEQlFHobaV8AnyHULFPTM0=;
 b=Sy/EkJRGD7hric7reaiNwtpSXSps65N3OEs8ru4UFZYsaRbXPswPK9TMHKq8KVWEzV
 kriPz0rl+j+C1HP7L4OK1IpQkOJXj/Jz51OrBUnzjeF3vRI7ui5oUFM1IH2znWzG9wMN
 KgOB3RuLFPOD89ejHvGKsfP3LPIRAa8wt0Tbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747784; x=1700352584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grN2G0fdNjhLpAtoP6/FZTEQlFHobaV8AnyHULFPTM0=;
 b=uDpXPIo4+G6ERUbB1Rn6FvgeljYF8gdS9iSy+62mMfYq6XJjmingiE/wPiG3gTt3A6
 0etR4J46V8S4cLbM4ylYfIFp2QGDd3P7eEekTqIN4yU2GOpPmpXwj0TP3Gyfo0sFW7dD
 jap2YGYu6Mh3o0TTqr+tC2DUJmUkP4geZLQxDmpvB2+xypjha618LqSN01L6N3hBMpnB
 Y7L4LL7p5grKZ97mp/sjqTMM5lGNyfczrIOh/p1914fTEGzjcHdxxtSrWEAxIbwun9EY
 J+RBHPBWvbilxbrdOLHnDqpFLcW1LXRWsZI79+SWA9Cz3mE/zRylEQZE/CpDvT0KL8lI
 ehmw==
X-Gm-Message-State: AOJu0Yy0pmYtXdz7vnqfq1vkZfLprwdHASvyaqDdpUP3cG/Zfu5Nnv9s
 Tn4/d4FEYZhHG9shloNq3tDlBOJKawy7R9i4liYAFQ==
X-Google-Smtp-Source: AGHT+IGfrKrS1rsATcEw4zEfclWXKV8FcaGHl7XUn4tn6vWKkJ8XsY5LAWLu1TIsp1E8mo21KcFWeA==
X-Received: by 2002:a05:6e02:194d:b0:35a:b2e7:5698 with SMTP id
 x13-20020a056e02194d00b0035ab2e75698mr2181104ilu.18.1699747784144; 
 Sat, 11 Nov 2023 16:09:44 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 15/29] bootm: Move error printing out of boot_get_kernel()
Date: Sat, 11 Nov 2023 17:09:00 -0700
Message-ID: <20231112000923.73568-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

The same error message is printed in two places. Move it out to the
caller so we can avoid passing in the command name. Leave the bootstage
handling where it is.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index a64c253069f9..ec43d4e7e8ba 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -104,7 +104,6 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
 /**
  * boot_get_kernel() - find kernel image
  *
- * @cmd_name: Name of the command calling this function, e.g. "bootm"
  * @addr_fit: first argument to bootm: address, fit configuration, etc.
  * @os_data: pointer to a ulong variable, will hold os data start address
  * @os_len: pointer to a ulong variable, will hold os data length
@@ -115,13 +114,11 @@ static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
  * boot_get_kernel() tries to find a kernel image, verifies its integrity
  * and locates kernel data.
  *
- * returns:
- *     pointer to image header if valid image was found, plus kernel start
- *     address and length, otherwise NULL
+ * Return: 0 on success, -ve on error. -EPROTOTYPE means that the image is in
+ * a wrong or unsupported format
  */
-static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
-			   struct bootm_headers *images, ulong *os_data,
-			   ulong *os_len, const void **kernp)
+static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
+			   ulong *os_data, ulong *os_len, const void **kernp)
 {
 #if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
 	struct legacy_img_hdr	*hdr;
@@ -173,8 +170,6 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 			*os_len = image_get_data_size(hdr);
 			break;
 		default:
-			printf("Wrong Image Type for %s command\n",
-			       cmd_name);
 			bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
 			return -EPROTOTYPE;
 		}
@@ -232,9 +227,8 @@ static int boot_get_kernel(const char *cmd_name, const char *addr_fit,
 	}
 #endif
 	default:
-		printf("Wrong Image Format for %s command\n", cmd_name);
 		bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
-		return -EBADF;
+		return -EPROTOTYPE;
 	}
 
 	debug("   kernel data at 0x%08lx, len = 0x%08lx (%ld)\n",
@@ -322,9 +316,12 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	ret = boot_get_kernel("bootm", argv[0], &images, &images.os.image_start,
+	ret = boot_get_kernel(argv[0], &images, &images.os.image_start,
 			      &images.os.image_len, &os_hdr);
 	if (ret) {
+		if (ret == -EPROTOTYPE)
+			printf("Wrong Image Type for bootm command\n");
+
 		printf("ERROR %dE: can't get kernel image!\n", ret);
 		return 1;
 	}
-- 
2.42.0.869.gea05f2083d-goog

