Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0248C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60AFA888AB;
	Sun, 11 Aug 2024 16:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oh1sVEJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B8388898; Sun, 11 Aug 2024 16:53:04 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DF088C16
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39b38295008so10986245ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387976; x=1723992776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzZSEdq27xsTACKG9U6R1IRZchzVcWl4fQRrNpNdfyQ=;
 b=Oh1sVEJCA9Yb5ou6aoeiY72oGbYevQpkKqx/Jgxs5YgDJB3LhC1R8BtJbXBGLBe/OW
 Ew1+3BUmkGP3GJ/OrOxOvvjWOGm7sa30VU3yaTUQAuGTAcN5crl8KQscUjcEIaDn4Hun
 lR+co6hA72q2M+KUGkOX3q6r9nHqysncMEKTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387976; x=1723992776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzZSEdq27xsTACKG9U6R1IRZchzVcWl4fQRrNpNdfyQ=;
 b=vQeFFkZZWzgB/MdiQ3RZp9PHcu+isFsLu3vXuqtJ5gS3PUn0YNqw23ZE0oQvjVaPBY
 TB7cjryyFHHrJqOUCzyKPxwNWnSX8SURzbFBWcW6emb0CLlMBZtATxDmcjrJT1OwxG3r
 h5hPnq2NqXDcul27gnGB0LSidRpiOm7TgTc0Z/rC0n1kcugXbqhsMh9v39RXfAIwq8AI
 K3IK/JrpogCNsfLOHbpjmnmQiIN+TP6w+npA9kQcdInOTWBp2EGsTtiBcrIxx0CR9RDS
 KDD0C6jT6oi4StP8t4jy6Noy/ffkbr3VstCdraiu8t5yy93bZfSQAjj/JDma5h30vzjb
 wySA==
X-Gm-Message-State: AOJu0YwMIBmbvg+os/7qPv5pAieab4PNVPQqw1TdPN8ZkJdSZeVWsIDF
 GlwUx7WGpyRXJe8YRwZmFwVw8156cH5/5MzegpQlMORKIXyapKn4/5dGLlt19R/PC9Y+kyZhl2I
 =
X-Google-Smtp-Source: AGHT+IEM4+BQJoxsZYBF2cIs6xsBdqDD1d+BaV5dGPCUHR3Im7EwI0dg73V3kYvdcRrFM3J2L4sisA==
X-Received: by 2002:a05:6e02:1525:b0:374:ac3a:e32c with SMTP id
 e9e14a558f8ab-39b78492e8emr86299605ab.16.1723387975815; 
 Sun, 11 Aug 2024 07:52:55 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 33/40] bootstd: Make bootdev_next_prio() continue after
 failure
Date: Sun, 11 Aug 2024 08:52:02 -0600
Message-Id: <20240811145209.4191404-34-sjg@chromium.org>
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

(no changes since v1)

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

