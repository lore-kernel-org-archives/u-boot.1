Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1A0C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 346E582B19;
	Fri, 16 May 2025 10:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kS1vC4+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1C8803DF; Fri, 16 May 2025 10:17:58 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E1882AF6
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a1d8c09683so1211883f8f.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383476; x=1747988276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UFWzZpd0iuA674objHXqhDoyae5/D5GjGYnqMBd1CCc=;
 b=kS1vC4+ZfMyIwlwIlsoXAm7vrfbu3c5AWco0KpdHa3wduQG90ZZOM/7cAd+hPRdkJz
 5PSDoOs/8mf8xKLdErNFDPXUxPRjlMSImk0bzgk9K5cDdUH8BYxdlOpY6ovsw5BxHAfL
 UToy3vNbHPDqro/q18+K9VB8/AQUi0M1uwMh+lOlSebwR+eMCLmijkFRS808KuDYo9WE
 HBR5YHbvOXVKGKst3AwI+qya1liKUsK7U4Kj/vkvEbISkfhceKeNVFyu1mtfzPw9mJbA
 o5MPzOBmX+yP0HItyK+/lN/z8+TpPJvkyzdbZw1suzsWhjpgG+igqe8113En1qsF5wVw
 e8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383476; x=1747988276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UFWzZpd0iuA674objHXqhDoyae5/D5GjGYnqMBd1CCc=;
 b=eb1F8TmlLZ1lvn9lVQL7rbBzJP73E0g3nMeVEWsQVZVq05a0H9Q3cZfEvEaaiMUDGE
 3L3VBtT5/GrAyjMjqYOT5VHdPDFJQ1C+50Ty3K7iPvIjkK0+szKCIntG58U/5jPeZvYy
 Vb20O6OCQnwOPH0yHaxB+NqnTDxLxQFzl1OeLY1uii2npVOJtB8gNg7nDCbA61Z0ySgM
 Ch3PpOIWBOF0R2474bUZThu50N/oxzPP1B+El3embYBdPI4gpkFfrmUrmc0hS50B1y2k
 fDxRrC4vpS9WE/gOCRG5LIN5UUb2MQhTmb2krrq9V3Ett6YL9dYFkxJONNqFvnZPPuCb
 zRwQ==
X-Gm-Message-State: AOJu0YzriidPm/zYgneFNn3b75mXXVPtzizZX+QP++eKFdjsQ28yrlYa
 5nm87K7LzRNHBMbM5AkngbJzaxU7JkwH/lCi6aAagWf1DSclEkkPHIv0WA7+uDcLk7Y=
X-Gm-Gg: ASbGncus7hsyud93eJVKnIxdLMgZ9z2JrWW4iB2QngjIbqFrTkuP7jIbtWgZ0gS1bWA
 XBEYVNzICJQPD1DvLclAYK2IpP5McZ4Lo6EtGqjOFTzC/PNlbn2bATnPQ+JIWYjF0+RLxmjDJRQ
 1/xuy1r3AG4JxnrY/4h4RHU3LFef0Au3XjfmkDlL+o6z35yAyQo6gBdrg+R5QrH7CC3Z7ZtfUAd
 YmW6ORrmNJHZzC8efsJdqDcXtq6f23a8peYfqbIwngWvx0YTGUspNONJCawrK+SbrNREcM02zMM
 Y8Iuwzc+zG+v4F4rAxt0qRue13NkZ/YidLkWuDZpdIudYTCAQKYX8ha3S+LuRA==
X-Google-Smtp-Source: AGHT+IHdrNxLXv3r5ueXqxo+bL3JP5vNB16PsZoujCZqQwprmYCbNQYLVIxNHwI20ItFYPz9mV3urQ==
X-Received: by 2002:a05:6000:290e:b0:3a3:4ba4:e87b with SMTP id
 ffacd0b85a97d-3a35c857ffcmr2596894f8f.55.1747383475976; 
 Fri, 16 May 2025 01:17:55 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:55 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 6/9] net/eth-uclass: Add eth_get_ethaddr_from_dev
Date: Fri, 16 May 2025 04:18:36 -0400
Message-ID: <20250516081839.28587-7-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516081839.28587-1-adriano.cordova@canonical.com>
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
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
index e536968a92b..c429d77d7c3 100644
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
index 5555f82f23e..984d888e2fc 100644
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

