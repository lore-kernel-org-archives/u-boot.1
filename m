Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAB8D711B8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D85E8932F;
	Wed, 20 Nov 2024 16:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dw087Cau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1BC8932F; Wed, 20 Nov 2024 16:37:03 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6E787042
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a78cf52207so1667055ab.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732117019; x=1732721819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYAGRNQ75wFzxkMmBeIDjymZ8Bs+FoPs28p5QYcVdS4=;
 b=Dw087CauURXOXQNd5E6/V+7x+Tqzia7YvHQsUqxsQzCQYGPQ96cf0KFMkywDdmQQBL
 30eVc1wh26yQfEmkNuYVLfgs688qS4nEfXxuhAyS47dIsKCaeqA2WBr0h+YVF1iis/w4
 FbK7NxRk4XBcVGMfA3iF3qTH6WzpFixRRzE8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117019; x=1732721819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYAGRNQ75wFzxkMmBeIDjymZ8Bs+FoPs28p5QYcVdS4=;
 b=JKt1qlF1BPqnqdWwjdHQrla+D2STvewHEI74rw9eCE7JRpuHB9pfPZvjtIvZLEzIky
 AIRHCZ26VtpR7zUonkpUEEOAbUy3s/RYmSRE8E/rxlvuYbYngj3SQIZvSJ+CwDKT3zkq
 WvMl2jnymimOGCjnDtrxjn/0EUL9k1Tvk5cDkGresod/aOUhGwMsn7ZC7s3kco3rz+qj
 CkJrdKo5vtG/Df/v7ELRkvD6wdecFaXWqIDMZxtxbbs0SS+cMpiG2JEkjK6kpzrK8z2f
 cpiTXkLvClTt0usDqZA8JtTpREhgBUtb+vMIH3TjmTyM2yJYN+e4zyw3Z/lAW16vlrz5
 iVUA==
X-Gm-Message-State: AOJu0YwDhdz/o/rAOnNK/y3e+3fzujB7eIcow4+rmmQgdtvzauxarscW
 o5yhuhz28hdRLqbRi+mxaUbFFHKazZ95qAU9CUDI5iwxHZV10xrBiM/gwyyXdX/9Vu5sMuJJEp8
 =
X-Google-Smtp-Source: AGHT+IGHlEeRPG31K/X5Vogas5BQ/q8SNBF/fJ3NCrE/4bhq0cG7f+JJaY6pD/5B9UhqcK3A+ELCKQ==
X-Received: by 2002:a05:6602:140c:b0:837:7e21:1688 with SMTP id
 ca18e2360f4ac-83eb609388amr284609339f.11.1732117019327; 
 Wed, 20 Nov 2024 07:36:59 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df8cccfsm288747139f.6.2024.11.20.07.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 07:36:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Svyatoslav <clamor95@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/3] dm: core: Simplify dm_probe_devices()
Date: Wed, 20 Nov 2024 08:36:40 -0700
Message-Id: <20241120153642.861633-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120153642.861633-1-sjg@chromium.org>
References: <20241120153642.861633-1-sjg@chromium.org>
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
2.34.1

