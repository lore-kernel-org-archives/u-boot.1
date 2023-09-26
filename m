Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE2DE7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE2686E29;
	Tue, 26 Sep 2023 16:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CQg0Qb1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70C686E9F; Tue, 26 Sep 2023 16:16:09 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56ED786E57
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79fd60f40ebso88897339f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737758; x=1696342558; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gjqr+IHoH+2TTmmlT8IdF9+k9qLmuk1S8WHSzj9sWko=;
 b=CQg0Qb1DSQCNh9G6X4Cmcd+/12uu0h3OjrN8VnZMzOHboj1jpJC5QIVZ7N6R125i7Q
 2gRE3Z6c54VbDArgJp96c9zgBNDG8BHea1O4JgGDldEHAiLXVVoyEejUy6pfJeWVnESu
 GkYaWgroX9CoP3BhKsqZkcOTn2HGUzFwxbcoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737758; x=1696342558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gjqr+IHoH+2TTmmlT8IdF9+k9qLmuk1S8WHSzj9sWko=;
 b=VM9V+Ir+RxPBFZL2F2F2b1iAH2dp+fpchM9V2wyV3aG8U4p81hfCfYxIPmpcWijMy+
 eOwxoyfkPV3zaMD+isvlZihf3EcdtdhqyxMsK3S/bbqUGjL3r74b4N1wvh0YFRtWRY/6
 liE6rSX4v7udQRNkGp70rjlu31TcUN9BWaA2Fiq5kzUKSWGN3zPKJaULp2qMtEHB70qH
 biLoh0DnXcq7OnZTwQyp1rU7rIoytEGeduaE7StxNDi2KpvrpYZNYPDtTMZxjSaQlzG9
 39X4AujIOij9LhJZ//h3auwGh8ErufEoWyETscLe1xEi6F3i3Bow0nGKMURn2RGPAERG
 FCBw==
X-Gm-Message-State: AOJu0Yy3ybO6+jI8gErf914cQ24ZsfjEkg7Qf3LeNnm3a//GHGs9ngSD
 v1X9ZzH1Shhpx67Zi7ke3rQNJmZKNAOeXPGTXCk=
X-Google-Smtp-Source: AGHT+IFy+RqlmDbf/c4tWUoU9y8VFzQDlb6xOH9/bqBWnYcwXGmmgt3uuu3AINWRcfgn/XpwWaKXGg==
X-Received: by 2002:a05:6602:2a46:b0:79d:1b4e:fb8a with SMTP id
 k6-20020a0566022a4600b0079d1b4efb8amr3370003iov.9.1695737757943; 
 Tue, 26 Sep 2023 07:15:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 34/44] sandbox: Init the EC properly even if no state file
 is available
Date: Tue, 26 Sep 2023 08:14:48 -0600
Message-ID: <20230926141514.2101787-35-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

(no changes since v1)

 drivers/misc/cros_ec_sandbox.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cros_ec_sandbox.c b/drivers/misc/cros_ec_sandbox.c
index 8dbe0b188a48..1201535f4af4 100644
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
2.42.0.515.g380fc7ccd1-goog

