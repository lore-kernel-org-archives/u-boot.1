Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507AFCD493F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:01:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F77386DFA;
	Thu, 21 Sep 2023 03:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SgbR+ehj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD4E86DFA; Thu, 21 Sep 2023 03:58:23 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA4F86D9E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-452832dbb5dso264722137.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261491; x=1695866291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gjqr+IHoH+2TTmmlT8IdF9+k9qLmuk1S8WHSzj9sWko=;
 b=SgbR+ehjXZ8aUr80dRs2XCGUonPBL+fd6NrAssK3D3RBfNhBNp6+rGED86I+FSz7F/
 a9h+n3EsmzbW4VOiaxs8fGe53Qot650AlE0KcFOPtPOF3kUFILMGQBXTx1D5njMplYj9
 xGG0wFVQcGVd/cUchnGkFH8nmpqWm8E7vhVvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261491; x=1695866291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gjqr+IHoH+2TTmmlT8IdF9+k9qLmuk1S8WHSzj9sWko=;
 b=poA2Y4+oCS0Z68XbxQD6NDdLd+x5IcdpuEz0OgjMQyb1o8FyLYBiK7tmFSLTRnghqe
 xGIjXZTtjdE/F8DSfn2oCF9ahW+w/F+lVjMAQo2/ucN3hSAMwWKD0rBapMQOQZ0f7xPC
 0rSJKo4Mas5pk4IbMd9ene/yMFhhvYmICF72MIYMcT9fWwdY+Nzp0Q+HQPPVlLwgTQeT
 rB658FOh6urpD4nfXiV0fg3y3l53T2uugm99XNYHDDVQXmWd/UZQHBqpqjqBElKwkhD7
 7R7zCIsxASPHOFrvsmzfB9Gm4UTtalSU3pkiKo//hDm8VUSrHv2ziq5nNQBRvsaGYbFZ
 UJaw==
X-Gm-Message-State: AOJu0Yyiq1usV9J5GwF/xGyoPFkWExAYFOKQRg75EwDdqLz/y3BeAJuo
 z64W9Zd0d1DOf9IMZcr1kKnS59xFB43+ENY8WzA=
X-Google-Smtp-Source: AGHT+IFcmESLRN1FLbyO7ccruiZJbTa7BrexDNmLiq5VCKHkftt5Kvs4n6OXm183xrJoQcKmny/lXg==
X-Received: by 2002:a67:ffd2:0:b0:452:819b:f7f5 with SMTP id
 w18-20020a67ffd2000000b00452819bf7f5mr4885355vsq.25.1695261491512; 
 Wed, 20 Sep 2023 18:58:11 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 26/32] sandbox: Init the EC properly even if no state file
 is available
Date: Wed, 20 Sep 2023 19:57:15 -0600
Message-ID: <20230921015730.1511373-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

