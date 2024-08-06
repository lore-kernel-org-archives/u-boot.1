Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D259AC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CCD988A1E;
	Tue,  6 Aug 2024 14:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gLhJAVa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73C188A1E; Tue,  6 Aug 2024 14:59:25 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC5687EED
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39b27935379so2105215ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949160; x=1723553960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=gLhJAVa5maBV/nFWR8hygDctAqGnlhPRq3bDmhiNaD/Fh+cdTuQg8zR4K3iv+yqnfz
 gvytffs+t/SOsRlq77/oadHMKuIuudyo7aM0EQwWS0okf5WXMJjn0asN9ll0W/jYVU8y
 UTCG+thNPOCYYNvlOdztREvCIlF12jxrAch4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949160; x=1723553960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fn6taKCgx/ZA4Wh9YCprniYz6cyu/bRt9qJKUSb8eus=;
 b=B0xqZwZ3mYfev4mwGDTQyvlB78XaQPpa1fuwcUtel47Wcy3MYZq3kqi/gTOxQLWd5d
 1GlX/1y5C0PuNrVNaRZCrZQC6bkNBkRVy2I3S6whdRC6MrP4/2tkBsPU4Hu/cjzbvGcC
 vKhVTIccshAY1KELMl3F0f9BlxOGHeLC96MJ7oJ2mPG3ZM/6Lddbj/7bx2tGhTocd7cP
 +TKPsBfy+r7djh1MPT00INkdWym+8I6mUq8eKxudvvG8WChaVdwjhUH8g36pwdjroOM6
 C7f3PH+Hin20YVIgYpLk9h5dymwm9q3gg4yeIbhpo0jCIl6TqK+OVXCkPCA7cwRwQUnD
 WTUA==
X-Gm-Message-State: AOJu0YyoKyNYHzoSaAtf1GSTfQOqDNZfhKLQyOhB43piT3RZViHqocm0
 DoUUnP7DT4I2yQ0fUfFrZhUMgqteCcA/wRpFecSd9FwG2rBZiAfZ3i2ELf5BnmPhx3QZkI2ZbG0
 =
X-Google-Smtp-Source: AGHT+IFXLOHOO+cBH/dPzjtBR9cK88UtPQzL6bvMqD1AuXKiXOSsSUtzZkB4ciMeGaXVaYyyi4M5dw==
X-Received: by 2002:a92:6610:0:b0:39a:ea4c:2982 with SMTP id
 e9e14a558f8ab-39b1fb79b4amr161164615ab.10.1722949159661; 
 Tue, 06 Aug 2024 05:59:19 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH v2 01/39] nvmxip: Drop the message on probe
Date: Tue,  6 Aug 2024 06:58:12 -0600
Message-Id: <20240806125850.2316956-2-sjg@chromium.org>
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

We should not need to announce this device. Drop the message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/mtd/nvmxip/nvmxip-uclass.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nvmxip/nvmxip-uclass.c b/drivers/mtd/nvmxip/nvmxip-uclass.c
index 254f04e0b99..58e8c3fb74b 100644
--- a/drivers/mtd/nvmxip/nvmxip-uclass.c
+++ b/drivers/mtd/nvmxip/nvmxip-uclass.c
@@ -47,7 +47,8 @@ int nvmxip_probe(struct udevice *udev)
 		return ret;
 	}
 
-	log_info("[%s]: the block device %s ready for use\n", udev->name, bdev_name);
+	log_debug("[%s]: the block device %s ready for use\n", udev->name,
+		  bdev_name);
 
 	return 0;
 }
-- 
2.34.1

