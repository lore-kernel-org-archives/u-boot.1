Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC639E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2A5896DA;
	Wed,  4 Dec 2024 00:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gyn84mlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C818964A; Wed,  4 Dec 2024 00:47:14 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3861F896E2
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-841d8dec299so246367839f.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269630; x=1733874430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TASgF64mELNe+oUxBSLXMSx1uLGUSsbkbeCaOKlmuAo=;
 b=Gyn84mlvximvMWseg0bVRjVOKoK49eJoS99Zrcd7AcKy0+AvksG9J8/aIKxJXl1bos
 WnPTpVM27Nbr/JuQnnD61rbl6lTfiUGkn0/mbvIKAyL5Rr/dnjaiTJLcW6XkRi3CPmcd
 Ukc2moZbJhJhMm4lZ9VRNKOmW82/kObnv7Ffc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269630; x=1733874430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TASgF64mELNe+oUxBSLXMSx1uLGUSsbkbeCaOKlmuAo=;
 b=SKyyyrLTmZ3KDtlRnNlNVJ0/eOLRxH1UhUMeuPZJxyEuTHTR6UNNpT8py6Ha5etTC+
 DXTWIXE5R8Gir+4i87S8bAUNRItyN9JK5v2zMjeQhLJ62VXuT12d5llDAwqo9VqHMr8C
 a/oBPQUv5ShCnIIevgdKNN7w6c4yms1lKrFLj0ZBJQ69qRF/43XQBM8797bWGZtcyFuJ
 Iwn2zN2YrISwIjvWogOtViNTtfeHY2vtEEA12I5egLzq+TllvHrQyumAjaf0Y/C2T16+
 rbAwfKDoKldDOfzO9Bx0fDgdRckB4e4A460O3z9YqTeO8bY1b9O+HNBKhI/s8dj671W5
 kvKA==
X-Gm-Message-State: AOJu0Yx4ucZvBp2NXs7nCxG5emdG2sXZitgaIkeMGWweaLi8Jf+5PLy5
 pUqSLkcbQRVhabvO8ozxlqUJCMSFImPN2RQ2zkDelzNiINoLbZ30CJ2c8GW9Kn8QnFn/+nouKkI
 =
X-Gm-Gg: ASbGncuH6SsSFU/TpG9XIAABDEHAmOxbTVstlCof5Apy72UyyrMe22Iz4QWyDhLMxVm
 MNFxPkenK0NuA+iKzFVO55WGOJVjtml01HTRSd8RV8Lx0QOXPU6wE5yjN4QUTMvhrQvO/XI+93w
 wyVOtp3oVsOid9tJ1W/B04juZrY5PZoziUrz2nrCZOp9VXj1dIZEoxOR9qq1p7GYOaDCfSD94FR
 sKTzDPX2+LqShIQEAoyytoOAC0kdCraMBB/cXZO2gd09lZgX9UHaoBDhdEl3jLNDyiHoT5bhPf4
 oQnJWCi/d10=
X-Google-Smtp-Source: AGHT+IEl48S9LH5bYruyuG+G6R7b75gN0vEWfO9MgEmtd/iz9WAHWgucFpJbk+UNx1YbuzirBdyYcw==
X-Received: by 2002:a05:6602:1615:b0:83a:b52b:5cbb with SMTP id
 ca18e2360f4ac-8445b557a44mr572665239f.5.1733269630439; 
 Tue, 03 Dec 2024 15:47:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 21/41] net: Return the address and size from
 parse_addr_size()
Date: Tue,  3 Dec 2024 16:45:39 -0700
Message-Id: <20241203234559.2938192-22-sjg@chromium.org>
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

