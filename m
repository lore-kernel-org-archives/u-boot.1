Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B3BE6B244
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 11:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E93288A37;
	Fri,  1 Nov 2024 12:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b5kuRLGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CD04892E1; Fri,  1 Nov 2024 12:50:39 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85AA189287
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 12:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9abe139088so276421866b.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730461835; x=1731066635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZ18EaOXpy0W8IGh8kdDbruqeoDv5J2OaiZAzMyp/tc=;
 b=b5kuRLGg9etHZBGwdWzEAECUIbdtqdmy4yptBdNSg4ec85ycd9F7PaDTjF0C09BB8t
 FOrtT1O/fwi3zrkrhA0cMN5WmZaVJxd3bPKjn3IysP4+uUyuBzqLSVmzNu/dW8HJ6Oq8
 UVtikLxoNCUl+UHEdVzTDNuJ4Plqwm7Yqwsos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730461835; x=1731066635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZ18EaOXpy0W8IGh8kdDbruqeoDv5J2OaiZAzMyp/tc=;
 b=TBBeg84RVK5FTQNipaZeDa2ksxqjkzruFmwouQm4HV4smoC8wavGc/m/gExdzjV7fy
 60WM1rRUscxtk5nnVTDhALI6wxOTmNiP0z7fAuCbYO9lZry6E/LKHxDrXsHjInI3fKfG
 6UdbjrohBHOd32vmtH/aj91BgBx2BkBBDwPa5CWFj3C6L5ESx8MBOnYPyx5bWrIf0WX+
 poCECrinpeWo9kNJ49iM1kTkW3yVzXLRlGljs8nN6g8epx67Z9IwpxDQhX7YUALFuyFU
 g8TddtoAHDKE4pqCBJ4AFV0WcnmqsFeYcgFrTAeZ07+Kv9wzG0lyAUtPNPHmuQ/krJV1
 qJLg==
X-Gm-Message-State: AOJu0Yz8mdF40XVZOFrwB8dQ7jtmEhMuZ7iUBSdji7y5rKdmwJ4PLGv5
 27HZyN07XFulxudQIgHVbp1MjzyFtH7QCuKxDj7K7fiN9dK93PdIlODz/rgyzxfomInUpYFFt3J
 7RA==
X-Google-Smtp-Source: AGHT+IFdAigggnSDEXDgYToE6CzMxJwvTeiyBci5YlBqS/VwzaY/F8XjnCZHCZfW8HY7vtemD8FvHA==
X-Received: by 2002:a17:907:7245:b0:a99:f8e2:edec with SMTP id
 a640c23a62f3a-a9de5d6f21cmr2336432866b.21.1730461835205; 
 Fri, 01 Nov 2024 04:50:35 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564cc430sm171616566b.88.2024.11.01.04.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 04:50:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] dm: core: Simplify dm_probe_devices()
Date: Fri,  1 Nov 2024 12:50:25 +0100
Message-ID: <20241101115028.214678-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101115028.214678-1-sjg@chromium.org>
References: <20241101115028.214678-1-sjg@chromium.org>
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

There is no point in checking the pre_reloc flag, since devices not
marked as pre-reloc will not have been bound, so won't exist yet.

There doesn't seem to be any point in checking if the device has a
valid devicetree node either, so drop that too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/root.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/core/root.c b/drivers/core/root.c
index 7a714f5478a..2d4f078f97f 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -281,26 +281,20 @@ void *dm_priv_to_rw(void *priv)
 }
 #endif
 
-static int dm_probe_devices(struct udevice *dev, bool pre_reloc_only)
+static int dm_probe_devices(struct udevice *dev)
 {
-	ofnode node = dev_ofnode(dev);
 	struct udevice *child;
-	int ret;
-
-	if (pre_reloc_only &&
-	    (!ofnode_valid(node) || !ofnode_pre_reloc(node)) &&
-	    !(dev->driver->flags & DM_FLAG_PRE_RELOC))
-		goto probe_children;
 
 	if (dev_get_flags(dev) & DM_FLAG_PROBE_AFTER_BIND) {
+		int ret;
+
 		ret = device_probe(dev);
 		if (ret)
 			return ret;
 	}
 
-probe_children:
 	list_for_each_entry(child, &dev->child_head, sibling_node)
-		dm_probe_devices(child, pre_reloc_only);
+		dm_probe_devices(child);
 
 	return 0;
 }
@@ -337,7 +331,7 @@ static int dm_scan(bool pre_reloc_only)
 	if (ret)
 		return ret;
 
-	return dm_probe_devices(gd->dm_root, pre_reloc_only);
+	return dm_probe_devices(gd->dm_root);
 }
 
 int dm_init_and_scan(bool pre_reloc_only)
-- 
2.43.0

