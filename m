Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B9CC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C87BD83A30;
	Wed, 28 May 2025 10:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U5gxwVxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD2083A57; Wed, 28 May 2025 10:37:26 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D84383A2A
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so54769665e9.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748421443; x=1749026243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CA+2SowmwZkIhdaf6pwtr8vYHSm078oYOy7kGkCBtTk=;
 b=U5gxwVxRUbtsq4x6DZ/UX88ImLPVzggPjaoZmWvEm+Nx3ClRo15jd/Ms4DYeUex6XV
 rU7cw2epy79E3LfmEPjok1b6mdKUA5rqBNOXysEZy08deqn1uSh2aWHxr2EsRdjJkBlI
 o4XNHqpc1Hg3mNhL9UXMdGqkMtV6IJp88QRclmfZIujITTIfRPwt8pwNQ8jGyQDIbvea
 MgfY6jUNQDPe8cjmh39sh+aHlk/B3iJaRtkAT4ziFVCnF2nuV2dOcQ9sMpp6OIyKdv3D
 PQWHqQ4zPook08RHhvjbfRBpikZ94WpGt9SH19bsOib8rr++EECzDumy6RvAVCS3nxXX
 Fsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421443; x=1749026243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CA+2SowmwZkIhdaf6pwtr8vYHSm078oYOy7kGkCBtTk=;
 b=Rjk5Xn4tgIyVFBnYJqjcHUwxJcK97XLFTWYOV37aGRcs7t0XNXUo+bwrx8QDy9Qxg5
 eSIBpUU1w3chl1OiZ36xIjnvTSOaVOj2JBIdszfA/r1at0i5uJSEAYsWCPbzXdXBt9RT
 xcFTR65AhSSt8e8oCaq5ds3G10dumlgDEvCrOtwCkG2Yrtbr7ShL+zsKSXkLEs+pauso
 DIF3Xmb8JwV1IDh/zMm8wPxuVtmH7xrlYcb0Hir2F4IGWXsK2MfEuhewxBwvBi7BNKAJ
 c5vJswbza8J2/rFhFflwS8Vhpz3feiqcw1LxT4vgaHKC+hEFkYiG6ESIUVek1n4vLLzL
 rRdw==
X-Gm-Message-State: AOJu0Yyly1TWGIiyhJ8X/9vNeNBeAwtkH6m6qe9hV0aTk6j5j3wjKOLW
 t8olBKqaRwqqlEbGuEJeiutQOkjvBsNN/eHiQdtIZvLyH3w1JyxCa0TFHj0ixIWHvkE=
X-Gm-Gg: ASbGncsBwj1fjnYVTPx86cdylO+d/xKTwxvSZWqtUanpfFzoYgzksmgLU8pLY2ElraO
 uXxdwPIla6VbHNTqwB1dQlcAzzZkLC/KInhfp5FODBpmcd7ZJJ5D8CK5YisMFGuKtqPMJsbU5gB
 DoJnJGfnamhjHLYUawdBtrPzRofrtsaSBrw58D/1izlqORPWkWzUM2rEpaaoXjNsQqa8VGpcTJF
 TOB4TYjMLwCZ2Kwy71ZOof7JG2eSXN1nqgJF3N2snUJ1y0FdpH8HEvU0I3lLGpgNsgxGwEmTd69
 /B3sXYbcojCv6j1yzVjJ9cqZw8TTVpK0ibautGPVs/hFPb8doSt21tTQ4qSjCJCkN4Yx89LOxVp
 QZKoLCiiFpSIDqg0Q4K7nWEzjip0=
X-Google-Smtp-Source: AGHT+IHiTja3/zDNcvksMWKQKqdjRhJYhyWr5wFyVLLKyzErPJUDXTQBVcfNXNwur17oGguTVIIdAA==
X-Received: by 2002:a05:600c:1d96:b0:440:6a1a:d89f with SMTP id
 5b1f17b1804b1-44c916071a2mr161181865e9.4.1748421442547; 
 Wed, 28 May 2025 01:37:22 -0700 (PDT)
Received: from adriano.. (15.red-79-153-17.dynamicip.rima-tde.net.
 [79.153.17.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb45sm857130f8f.12.2025.05.28.01.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:37:22 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 6/9] net/eth-uclass: Add eth_get_ethaddr_from_dev
Date: Wed, 28 May 2025 04:38:18 -0400
Message-ID: <20250528083821.567514-7-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528083821.567514-1-adriano.cordova@canonical.com>
References: <20250528083821.567514-1-adriano.cordova@canonical.com>
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

Add eth_get_ethaddr_from_dev() to retrieve the MAC address
of a specific eth udevice. The function eth_get_ethaddr()
preserves its behavior of returning the MAC address of the
current eth udevice.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/net-common.h |  1 +
 net/eth-uclass.c     | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 7853612b237..b051dd1fdb5 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -292,6 +292,7 @@ struct eth_ops {
 
 struct udevice *eth_get_dev(void); /* get the current device */
 void eth_set_dev(struct udevice *dev); /* set a device */
+unsigned char *eth_get_ethaddr_from_dev(struct udevice *dev); /* get a device's MAC */
 unsigned char *eth_get_ethaddr(void); /* get the current device MAC */
 int eth_rx(void);                      /* Check for received packets */
 void eth_halt(void);			/* stop SCC */
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index a233912fd8e..6e440437887 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -175,18 +175,23 @@ struct udevice *eth_get_dev_by_name(const char *devname)
 	return NULL;
 }
 
-unsigned char *eth_get_ethaddr(void)
+unsigned char *eth_get_ethaddr_from_dev(struct udevice *dev)
 {
 	struct eth_pdata *pdata;
 
-	if (eth_get_dev()) {
-		pdata = dev_get_plat(eth_get_dev());
+	if (dev) {
+		pdata = dev_get_plat(dev);
 		return pdata->enetaddr;
 	}
 
 	return NULL;
 }
 
+unsigned char *eth_get_ethaddr(void)
+{
+	return eth_get_ethaddr_from_dev(eth_get_dev());
+}
+
 /* Set active state without calling start on the driver */
 int eth_init_state_only(void)
 {
-- 
2.48.1

