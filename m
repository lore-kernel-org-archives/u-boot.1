Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB38C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:09:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDF486538;
	Wed, 30 Aug 2023 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GUZLtfx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD99865AA; Wed, 30 Aug 2023 20:06:21 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE38C86567
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34961362f67so3049035ab.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418760; x=1694023560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmDctaLcpZapJEEueKcKyf6rsz484Ss83+gTrVM5CH4=;
 b=GUZLtfx8w2unsfpFjv4qxEZOc9U25+znTSVR5TPJA/8+p3gRMweYA1Q8yB0RqbmsE6
 kSq+Bqlg/Yr0xRN2ycWtMomgirs/wd6+ouO6RV8jJ/cr4RUupYmF/x9UToEg1nVZ3A5Q
 L3ZKuVxppeiP6Z1v9dungsil9Avfy+DMdk23k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418760; x=1694023560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmDctaLcpZapJEEueKcKyf6rsz484Ss83+gTrVM5CH4=;
 b=Tbti4K5BJjhkrJfkaEWi5c5VGcDkOUS2+5ioz8vceQ0dEnvWtdTS0UwCmGrMlHYvcH
 Pl+MDNelr82Ya6UylVyehZtC2hR1CFJI29IobMWj7oJ5LyHr9+/lhXXXJMuU3vJsONwd
 pJnCydSHIu9JvSdrNroMvZ8nlhe+tl7JrreE4Qrfr7m02zRuczrMKEyPFL1JmMz3P22R
 LwlrW3KNEG6tyJaGr3l/CsBcRB/zwpwjClZ6+28EJGfUhw6RkAXKAPYLTqfEBuVuDzPU
 qCjE4/IyLePU1FHzZo2DWUjeIKIJwWjwkDUvM/74+NRS+Vx/gWM/7aLGy4B2g9oH2mic
 yTwg==
X-Gm-Message-State: AOJu0YwGSyTqNnhtPz7VFVr4TgOnQBg1t4nfnOcWe8y7u+O+chSJgwZN
 UR/48gilgBjq3ZVhiyyuc1i/6KJUyDCsr/GsA+0=
X-Google-Smtp-Source: AGHT+IFM/iSUcIt0XfFz6k1HVHP6tHca9HJXOw5VG3TCVXehZLXBW/d/aGibAVR+PDmXmk3EpswVbw==
X-Received: by 2002:a05:6e02:cb2:b0:34c:e630:e99 with SMTP id
 18-20020a056e020cb200b0034ce6300e99mr270336ilg.11.1693418760547; 
 Wed, 30 Aug 2023 11:06:00 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:06:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 26/32] sandbox: Init the EC properly even if no state file is
 available
Date: Wed, 30 Aug 2023 12:04:57 -0600
Message-ID: <20230830180524.315916-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

This currently relies on sandbox attempting to read a state file. At
present it always does, even when there is no state file, in which case it
fails, but still inits the EC.

That is a bug, so update this driver to set the current image always, even
if no state is read.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/misc/cros_ec_sandbox.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
index 8dbe0b188a4..1201535f4af 100644
--- a/drivers/misc/cros_ec_sandbox.c
+++ b/drivers/misc/cros_ec_sandbox.c
@@ -81,6 +81,7 @@ struct ec_pwm_channel {
 /**
  * struct ec_state - Information about the EC state
  *
+ * @valid: true if this struct contains valid state data
  * @vbnv_context: Vboot context data stored by EC
  * @ec_config: FDT config information about the EC (e.g. flashmap)
  * @flash_data: Contents of flash memory
@@ -95,6 +96,7 @@ struct ec_pwm_channel {
  * @pwm: Information per PWM channel
  */
 struct ec_state {
+	bool valid;
 	u8 vbnv_context[EC_VBNV_BLOCK_SIZE_V2];
 	struct fdt_cros_ec ec_config;
 	uint8_t *flash_data;
@@ -145,6 +147,7 @@ static int cros_ec_read_state(const void *blob, int node)
 		memcpy(ec->flash_data, prop, len);
 		debug("%s: Loaded EC flash data size %#x\n", __func__, len);
 	}
+	ec->valid = true;
 
 	return 0;
 }
@@ -589,6 +592,7 @@ static int process_cmd(struct ec_state *ec,
 		printf("   ** Unknown EC command %#02x\n", req_hdr->command);
 		return -1;
 	}
+	debug(" - EC command %#0x, result %d\n", req_hdr->command, len);
 
 	return len;
 }
@@ -675,7 +679,10 @@ int cros_ec_probe(struct udevice *dev)
 	ofnode node;
 	int err;
 
-	memcpy(ec, &s_state, sizeof(*ec));
+	if (s_state.valid)
+		memcpy(ec, &s_state, sizeof(*ec));
+	else
+		ec->current_image = EC_IMAGE_RO;
 	err = cros_ec_decode_ec_flash(dev, &ec->ec_config);
 	if (err) {
 		debug("%s: Cannot device EC flash\n", __func__);
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

