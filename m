Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD11D15DB5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D650B88EA7;
	Mon, 21 Oct 2024 17:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E3ZzT+AB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437C488EA7; Mon, 21 Oct 2024 17:51:52 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6165488EBB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so5869903a12.2
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729525909; x=1730130709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7TCvE/+13I4B5F8d6QxfP5A4AxtJiZM+8RnfcyglG4=;
 b=E3ZzT+AB4fFRvtTbpmiNdhIzFQ2qL2rPM4eb4/I9DZbWSfv/86WFDxLtrsgsEWBY2Z
 ABU8Bs/Vje6Qh4h49321gCRBIHTgqYWe+1g7CZ1jaMEFRYC+lM0tQm+EWpx9ni2MYE/h
 IdbF0ukEQk7CgO+RtBoefF4k7S0sBc0S1QFi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525909; x=1730130709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7TCvE/+13I4B5F8d6QxfP5A4AxtJiZM+8RnfcyglG4=;
 b=k8Hbo0CQSY+pz0Q/PwoW/Bk8xWrYtoCYUEruJkzM90A76BWYne+4LIsTy7zd8bWbub
 a6k1O+2cpoXTmbgWZ9K1pXJ3mRlizu7UQkurjiTNovYpYXR/jdd1oRx4CBZr+t9HiN6S
 19pvwOS/ml1ITkEsuHidJgJ7/JdpxZH9y5Xqd51OgHm81szKwmwWQ0/dnp1Un4ZRICOW
 QTQzyIrNvRkkh/wH8rvR1P8oF/ErF/sgiHV26yscsYgA8JSXKT9OBRh/7aWMTqvnzJUx
 54I+RwtBnnhc5NugQazroCriJgkU01gEiFFd24HRJgsA2ZUJP/l3cpGJKiSo9YjmAN0O
 BkBw==
X-Gm-Message-State: AOJu0YzeoKztR1p72Fyw30BNW5lvQ0YQ1izk3KhyD+ii3wfVTjvk/mmP
 WUP7q7ANucUvbMapLmGdfbX6pqIG4MERsfyKfZ4IUKRzAZyYDN1v/KNUVytEFjwb752KP5dyphZ
 LpfDs
X-Google-Smtp-Source: AGHT+IFoy1JslTNRjxIG/V6xMFvk4yc0P38FBoYKbZ7q7pY6TRzxye/9hZM5QHLNqycl2VsQqqq7GQ==
X-Received: by 2002:a05:6402:3481:b0:5cb:728d:23ee with SMTP id
 4fb4d7f45d1cf-5cb728d2470mr1958236a12.33.1729525909119; 
 Mon, 21 Oct 2024 08:51:49 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a6d798sm2143886a12.50.2024.10.21.08.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 08:51:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Svyatoslav <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] dm: core: Simplify dm_probe_devices()
Date: Mon, 21 Oct 2024 17:51:30 +0200
Message-ID: <20241021155133.29557-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021155133.29557-1-sjg@chromium.org>
References: <20241021155133.29557-1-sjg@chromium.org>
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

