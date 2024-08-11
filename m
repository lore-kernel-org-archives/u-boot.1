Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA22C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8843688C25;
	Sun, 11 Aug 2024 16:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MMTPS6Fh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C34288B9F; Sun, 11 Aug 2024 16:53:00 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888A588BCB
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39b3a4d2577so12272165ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387975; x=1723992775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Og7RzCRZ6P7JZ73xgqQ33OT1hycWQPRTf3lWUqFTQ7k=;
 b=MMTPS6FhVD2AyFV0k4fKM8hSOHhO2eRCO/F/r82PXZeCgR8zbjoTp8bzLCp4W1YB0/
 1g9u08eCotD9fq62f6l2WMxm8Zhd6/kyKml77PBXOE0NlP58+KJ/81aM6HydtKtldq+L
 efDVYhCce4exhTkrO9mz20ENKJ3e0FnW3CtbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387975; x=1723992775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Og7RzCRZ6P7JZ73xgqQ33OT1hycWQPRTf3lWUqFTQ7k=;
 b=wNQPVMy6xHKww81D2miXxVoNgVVW5LsZoW68ELfwDkPdrWhNCIwlIoUx/kQQvQ5vor
 m0uAX6ZLBzlkbb7QCNx5oeyFR0cvqC03cVFFkjOBrkPAJQN9hvQ+UAJ3PqQsOzZyTLG4
 zlMQG2KQqhJkTc2k14xRac9N6y5OMnVeAZ8oulNweceoJnEaR4cznTlOZi5/EzVSPAyf
 +zmVIBZsSBRLljm+DF5wnAuXx4IdZLZcHyI8W6ME9dLLmy4yf7ORzK/YABRavyzGidQQ
 V9ZtTs8wXLlHE2ALCl82LQlkgc+4z89nmHBVvxpgh+Qqs/IGRBeaoIzjuYa9Qjv86tBK
 hUtg==
X-Gm-Message-State: AOJu0YytFENrFs9BWLwzOMifO/EvUvq4rA4vSLuMRUs1ldRZJLpVjPM3
 f23b8qEIGUHz9d/nG2FEfle0xYO1K43dLsdzvXqg1rI0puCH5NbUf6nyVAnqGPeZRWf6aP8n5KQ
 =
X-Google-Smtp-Source: AGHT+IEtVIIj7Rqi/nbk4pCBr+eulC3Ft76BFYjJYjeZ9CTfT9wm+WJbsj0CNhPsoHyyLzUHypRfLA==
X-Received: by 2002:a05:6e02:2194:b0:376:410b:ae67 with SMTP id
 e9e14a558f8ab-39b7a4205demr109709135ab.16.1723387975161; 
 Sun, 11 Aug 2024 07:52:55 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 32/40] Revert "bootdev: avoid infinite probe loop"
Date: Sun, 11 Aug 2024 08:52:01 -0600
Message-Id: <20240811145209.4191404-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

