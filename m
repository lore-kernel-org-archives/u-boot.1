Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F52FC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9418088B23;
	Thu, 15 Aug 2024 22:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UlH0CfyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15A188AB6; Thu, 15 Aug 2024 22:30:33 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB3788B31
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-70930f8eabbso556232a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753828; x=1724358628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgNcqtb1+hEj2Byb38ece2IJ9ao8rU8L8xJt43mDS5s=;
 b=UlH0CfyW7BvrUuB5cFF9tGweOl7h0VQpSDbu2MkFleBQcI3vIjZFOJP1A8nPzhRAcn
 gqOGxdocx8k3BRYPn54H1A+61qOJjmYmp5paKIj/Yxszia4c/Wz+E9GD9udvsUxkju//
 NvG4yDxtNAyCRsnzxLEtbu1UcB0QcJZjjMAow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753828; x=1724358628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgNcqtb1+hEj2Byb38ece2IJ9ao8rU8L8xJt43mDS5s=;
 b=EeU2ZbK/gka/NWrQyE793IcfkqnfEY0tZRgkMBbnrozfKOrUSc1Z9PW2qRXw+U+rHf
 TB7qqRKtBdCVRH9qx7ITaIJLDivEhd72QnQ2ZK6k+YBrfHY0gc4ZpZGWhS49w57V8d6a
 pl6Yz3NkD5L+oIw41pm8BNqmpngyLIkY5sjMokCqELBX6XtTnkMbF+W2cUGtE/uHo4QC
 yc77Zxs4s9dmQ5doS6LK59vpNU0/oooOBKzhjyxu1g7ZEw3OmYDUbL+TTCtQEBDYmM0g
 SV9B2UHej5bIyh+0aJXeh6P7Q6WbbsitC9MukMny6PWP5aB7s8UzkJLZxfYxXqRdxt9D
 HKVA==
X-Gm-Message-State: AOJu0Yzlh+QW4jL4lfBNls+FNfwzjTYb1xsfxL5v8pa8HiN+XD4XikBM
 NSyKYHc2qB5wtgqn6AUs/bhwxcg/PVmI22BzBZX8OI2wX6A153Gw9vQZvBsfON2UbN/7uDtdPGP
 +0Q==
X-Google-Smtp-Source: AGHT+IFlic7a7UeeenH5q0R/MEPK919hncDsY1NC88sRUHY4xRgpEQ2ZuiC6MgstNZYHULCRM7pCmQ==
X-Received: by 2002:a05:6830:6303:b0:70a:988a:b5fd with SMTP id
 46e09a7af769-70cac897eb0mr887435a34.24.1723753827797; 
 Thu, 15 Aug 2024 13:30:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6f3db48sm711114173.106.2024.08.15.13.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:30:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v4 2/2] bootstd: Make bootdev_next_prio() continue after
 failure
Date: Thu, 15 Aug 2024 14:30:22 -0600
Message-Id: <20240815203022.771615-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815203022.771615-1-sjg@chromium.org>
References: <20240815203022.771615-1-sjg@chromium.org>
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

When a device fails to probe, the next device should be tried, until
either we find a suitable device or run out of devices. A device
should never be tried twice.

When we run out of devices of a particular priority, the hunter should
be used to generate devices of the next priority. Only if all attempts
fail should this function return an error.

Update the function to use the latent 'found' boolean to determine
whether another loop iteration is warranted, rather than setting 'dev'
to NULL, which creates confusion, suggesting that no devices have been
scanned and the whole process is starting from the beginning.

Note that the upcoming bootflow_efi() test is used to test this
behaviour.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/17
---

Changes in v4:
- Split bootstd patches into a separate series

Changes in v2:
 - Add many new patches to resolve all the outstanding test issues

 boot/bootdev-uclass.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 15a8a3555c6..807f8dfb064 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -640,6 +640,7 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 	*devp = NULL;
 	log_debug("next prio %d: dev=%p/%s\n", iter->cur_prio, dev,
 		  dev ? dev->name : "none");
+	found = false;
 	do {
 		/*
 		 * Don't probe devices here since they may not be of the
@@ -682,13 +683,13 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 			}
 		} else {
 			ret = device_probe(dev);
-			if (ret) {
+			if (ret)
 				log_debug("Device '%s' failed to probe\n",
 					  dev->name);
-				dev = NULL;
-			}
+			else
+				found = true;
 		}
-	} while (!dev);
+	} while (!found);
 
 	*devp = dev;
 
-- 
2.34.1

