Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C734DC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F17CE88B06;
	Thu, 15 Aug 2024 22:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f+M7hgm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 774EF88B23; Thu, 15 Aug 2024 22:30:35 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF3888B37
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-709485aca4bso729917a34.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753827; x=1724358627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49JuGEGvctb5x6AhUB0etcvVIe8ymX2e23ssch8c/9Q=;
 b=f+M7hgm145D1sedbmad1lVCLcRk28Rh8HJDtM5GK6eAlt+oRed5ka4kwbE5O835u4i
 YojNmIXrQE5NAgccfR0HCybSDU8Kv8SQgepMdQFWNAFjIBWAjBlDe1xhdVyfzSiTf6UC
 K2OfZxS4FvrdKA559Iyn22d9+JET7bKBLYnUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753827; x=1724358627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=49JuGEGvctb5x6AhUB0etcvVIe8ymX2e23ssch8c/9Q=;
 b=JtF+nHEyha6PamN5RLWKT7fl9J0jH+6CR8ypbmpBCkTs+QZU3Zm76DirTOcgyNtd1G
 7c917Eel7tUoLcdt+4HD5dUg3aONcwunfGn5af5sWvfENy6G1SlgUQ1ypc6rwNL1gbQ1
 jsk89e0FBdAA3ETF68rJpog0nWa9Bg83j4yspXimbm7LiWdm7nfGZie6emoAuWGpN2Fn
 8t0bLcHunaLBQMhh+fHBAJmRP6VhOPT3qVJPvo0s6+j6vXR5lcWydUCLZzAey7jxszRn
 d1tOsiQV78PU3x67fl2JHeIm5fWvWJlxDSLB6367MoZHX2oZ4rLo0d9L1ruxFHp6MTfl
 CQCA==
X-Gm-Message-State: AOJu0YyTk97K/cpj/WheSjgZMLpCZXwxfgDISkwd9HxXlopHydGlek3H
 /fcHm7XQiNYT6I67zLQ7FjTt2i0w6IGF3yINIo7WZROF1dDHvqx29ZEcGvEI87D9f3ggXu5ts+a
 2xA==
X-Google-Smtp-Source: AGHT+IH2ApEv5hSgx+bb805hd3X7mEFozWpYei83aK5RZmKF9U+CziCbt5fqfjBMPVWhOYXlaCZryw==
X-Received: by 2002:a05:6830:7006:b0:704:b58d:377a with SMTP id
 46e09a7af769-70cac86f50dmr921282a34.19.1723753826943; 
 Thu, 15 Aug 2024 13:30:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ccd6f3db48sm711114173.106.2024.08.15.13.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:30:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v4 1/2] Revert "bootdev: avoid infinite probe loop"
Date: Thu, 15 Aug 2024 14:30:21 -0600
Message-Id: <20240815203022.771615-2-sjg@chromium.org>
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

This turns out to be insufficient to fix the problem, since when
bootdev_next_prio() exits, the caller has no idea that this really
is the end. Nor is it, since there may be other devices which should
be checked.

The caller iterates which calls iter_incr() which calls
bootdev_next_prio() again, which finds the same device and the loop
continues.

We never did create a test for this[1], which makes it hard to be
sure which problem was fixed.

The original code had the virtue of staying in the loop looking for a
bootdev, so let's go back to that and try to fix this another way.

A future patch will make bootdev_next_prio() continue after failure
which should provide same effect.

This reverts commit 9d92c418acfb7576e12e2bd53fed294bb9543724.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Update commit message to describe how the problem will be addressed
- Fix 'virtual' typo

 boot/bootdev-uclass.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 7c7bba088c9..15a8a3555c6 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -632,7 +632,7 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 
 int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 {
-	struct udevice *dev = *devp, *last_dev = NULL;
+	struct udevice *dev = *devp;
 	bool found;
 	int ret;
 
@@ -682,19 +682,9 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp)
 			}
 		} else {
 			ret = device_probe(dev);
-			if (!ret)
-				last_dev = dev;
 			if (ret) {
-				log_warning("Device '%s' failed to probe\n",
+				log_debug("Device '%s' failed to probe\n",
 					  dev->name);
-				if (last_dev == dev) {
-					/*
-					 * We have already tried this device
-					 * and it failed to probe. Give up.
-					 */
-					return log_msg_ret("probe", ret);
-				}
-				last_dev = dev;
 				dev = NULL;
 			}
 		}
-- 
2.34.1

