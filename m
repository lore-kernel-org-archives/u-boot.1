Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FA9C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE5F88ACB;
	Tue,  6 Aug 2024 14:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nr5e3Grw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3B188B06; Tue,  6 Aug 2024 14:59:52 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E9B88A8F
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-81f9339e52cso21755939f.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949187; x=1723553987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzZSEdq27xsTACKG9U6R1IRZchzVcWl4fQRrNpNdfyQ=;
 b=nr5e3GrwCv8bVXmCxrCDV7EdPjPKf9PGxkKdCcU3h2XpIq+KbTL91IRkh1m7FGB+Mr
 Majy+IJMWSdxvE48SdtExhwflOGylOJZjlryPrXPdntYfb7V2CoszWRmJGp7H9hc2m/m
 lD6f7WPi3W1pG1+yHXVsXeAHF3zYWskTSHiM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949187; x=1723553987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzZSEdq27xsTACKG9U6R1IRZchzVcWl4fQRrNpNdfyQ=;
 b=IYx1Mv45E9Q/xBfcPHBvPM3Q2JDq2Xi7OmYTgpL3GfjkQSmjyN1wW/W8u3kfu0nk91
 UyPyhB428fWYiNd4/GMP5C7FRzJb0aWFsjHiY6oDmmYJp9AmjHVf5tsTwz5VDHVyuyhH
 XGauF2fJuVrzotuMDTZihygeZElRwYXC5cEWaGBuZuF5UReley9vztgGP6VJNLJDxsqB
 CYpRRU/f9n9hvpJPDuWq5+5syqWa2iFxG10ZWSvhgemvDpaEFY8DBWy0IhjHRR+5pMGE
 AQZVRFG0BoO843fzIA0J7Fa2uqRhHU9tlOkXhSrqPkBahpx2AxDT4yWLwj1GbPG8gAS8
 Lg8w==
X-Gm-Message-State: AOJu0YxFXqt8i3KXWMcrHgB6qbSugWf8Kl7V5FtGJf82HBwV+CwJN2qN
 zbwHAnle6VNEnUyVrKaO/Y72ffGKOHnLm36xyELwbO5DrKLoYNVAwHX4Gy4XRNemcT7R4fQXKVQ
 =
X-Google-Smtp-Source: AGHT+IGWI2z3fuSPA8HZCEa0VOvXk9IPwYPEGFIKGafG5rFyz3eNuf+uvH2iJiGCPn/ukWQnlPv5ZA==
X-Received: by 2002:a92:ccd0:0:b0:375:c443:9883 with SMTP id
 e9e14a558f8ab-39b1fc1a5d8mr131358825ab.21.1722949186579; 
 Tue, 06 Aug 2024 05:59:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 32/39] bootstd: Make bootdev_next_prio() continue after
 failure
Date: Tue,  6 Aug 2024 06:58:43 -0600
Message-Id: <20240806125850.2316956-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

