Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3B1C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147C087938;
	Thu,  4 Jan 2024 17:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ssx2dNYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37E087949; Thu,  4 Jan 2024 17:03:57 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85EA877D5
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 17:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so563405f8f.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 08:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704384235; x=1704989035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wcLivlcI9XenRvNzwqlQTpIXNUVY4cUU2pjbw+cqqhs=;
 b=Ssx2dNYGU4ajLNXe5oZKv0asSFxqk39eECL+aAMaSiZR48RNyQU+yoblQvwTIKqXiR
 U5vteGWY0j2SWaFwRd36b6RJtePLGxZeh1aFdMRnXbLUmKMhf4a/ifidM4S49oIxxlTb
 EuvV8Lm5LJM5cJufVAHOzEfPrvEH2seT7XN05sjhg2GNf9VR+UdlNl+z+/VJpOn4+znL
 UCaylZAscfs3C5hGy8CCoZ/tMNTf4TSo1wSfXkml4BkNlg28MawkEDBkpgJ1Ryh+bL52
 RalbdKBZFn5slFDxI+0q/5mmeRvvsVm/53mOxIvvqUwFmHJo4P3hEgtOC8ASdjvdmThu
 iOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704384235; x=1704989035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wcLivlcI9XenRvNzwqlQTpIXNUVY4cUU2pjbw+cqqhs=;
 b=auNcdlmI3w6AhBvYpwKZ4HhJWTBsBmDzIZN9U/m5/sCrRQDCInIivEtXUp0DLskRLi
 bwoa0fLm3t/kIyzNtmOjQB56AMdMdt7mUd0JOSpa/h4Cz2CWGe1gpm26PqY0k5QkfEzP
 uSq+q6Vad7mmFUDtPzB4TE57Bx0vJlYqjM2A242wj6qWlLrd6bFMKDOXs+y+wUcyBi9l
 QcFstSAYhL5d/k+dbSbpczNz4yeTSH8mbQg4xUkiaDSFpYuB+F+0xEiDrMckdeknPZ8K
 MmIpRwld94g9SazQMIzrE9l9Wa6mEyiUZSiX/obHGda5YZtNQ40PW3l62BC2fgvOtXEi
 fQkg==
X-Gm-Message-State: AOJu0YxAzmMBytGBk8KgnPJP2vUVAXB/fIW3zi1vVsGDhlIRZiKnvZEX
 lzTKCfVhdj4wV6rLtNtAgTK54YoyhjYtMg==
X-Google-Smtp-Source: AGHT+IGTv/WrDs5ORlsOguTI9qmlv1w1exkVfZA2r+5Iw5nbcz87QkjafJZanjt2uO/elX20onsUiA==
X-Received: by 2002:a05:600c:358b:b0:40e:3655:8fca with SMTP id
 p11-20020a05600c358b00b0040e36558fcamr4577wmq.94.1704384235276; 
 Thu, 04 Jan 2024 08:03:55 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-230.as13285.net.
 [92.17.96.230]) by smtp.gmail.com with ESMTPSA id
 r5-20020a05600c35c500b0040d88a69dccsm6116461wmq.16.2024.01.04.08.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 08:03:54 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [resend PATCH] bootdev: avoid infinite probe loop
Date: Thu,  4 Jan 2024 16:03:35 +0000
Message-ID: <20240104160346.285881-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.42.1
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

Sometimes, when only one bootdev is available, and it fails to probe, we
end up in an infinite loop calling probe() on the same device over and
over. With only debug level log output.

Break the loop if we fail to probe the same device twice in a row, and
promote the probe failure message to log_warning().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Resend, actually change log message to WARN loglevel.
---
 boot/bootdev-uclass.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index d01d603700d9..cd1c2bc06774 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -636,7 +636,7 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 
 int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 {
-	struct udevice *dev = *devp;
+	struct udevice *dev = *devp, *last_dev = NULL;
 	bool found;
 	int ret;
 
@@ -686,9 +686,19 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 			}
 		} else {
 			ret = device_probe(dev);
+			if (!ret)
+				last_dev = dev;
 			if (ret) {
-				log_debug("Device '%s' failed to probe\n",
+				log_warning("Device '%s' failed to probe\n",
 					  dev->name);
+				if (last_dev == dev) {
+					/*
+					 * We have already tried this device
+					 * and it failed to probe. Give up.
+					 */
+					return log_msg_ret("probe", ret);
+				}
+				last_dev = dev;
 				dev = NULL;
 			}
 		}
-- 
2.42.1

