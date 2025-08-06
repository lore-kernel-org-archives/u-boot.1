Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C185BC87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 09:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E9A835A2;
	Wed,  6 Aug 2025 11:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OI7vmWkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1CCC8346A; Wed,  6 Aug 2025 11:00:30 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC629835A2
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 11:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b79bd3b1f7so3547554f8f.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754470815; x=1755075615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXKLX2eXkR1sQrKHiGZXJVtqXCBDL40z/CuAquUIFNY=;
 b=OI7vmWkmbC11609s6WczBvYkngJBSgyRI7baYfl8RLvlig/0L65yB44A2DDHvyEI/G
 ImKru/UJwifFhs0jVHDytNdEUbgMTNXE0vKy4FyetN10AF77Ps/RVBCK/XU4ngVsaMuW
 cMfuZNiwmtVkjHytI158gJ1eEcDAF7epU3fRfFCaV6/cWlfwI8osN9MvRQpuKAo9Xx/v
 SzLu6/puBZzg6J/yxrgJA8xUbaKcb7jqDEQpQ6I/IjmYjBrHUmmWM6DgOz5GDc72mgtS
 oLAw7B7Cp/+vpQ605XMY7yJ0LtCSVQkIU3SNtk9haZTIsj4BrCZuOp+yfOZp4YkxQiVv
 O46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754470815; x=1755075615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXKLX2eXkR1sQrKHiGZXJVtqXCBDL40z/CuAquUIFNY=;
 b=hL5uTQVpNzv0EIKsPcmzi9Xau0qdgXZ1SerOPXYoHWsLaJCy2JeWum/UkHAl71H9Fn
 ice42+drXBqMn4biRoIctAHYouoSoo2GI6WkkGbtF8hc/trsLc7MW6hoiuNcMZDtZjXG
 0YoJaB68ej2aFFGduEIM/IgmjEhDHva6AOwZz7c2OWfpS6daKWCv6PRgHVTUPxO37sIQ
 +EgC+nuvowj2149+X1fnIhyLFrVkDmYHBPRbSS0h/tqhd6j9e5ymv1t1ghvtjDv+mq3L
 NY4EqQAFZzBELZRtxRikhQmstA4DrcX6Jg1BEhobLCXbDeFtfuuE7tBxaffyA5w7FITH
 7u+Q==
X-Gm-Message-State: AOJu0Yx6mYj/3ArjZNMxXOw35V8jQbstw9MT963PzUyuPDyYZ7X7DLYQ
 IcsM0vSjLQb2TinvhdoCYL6yDsTFAxRk5adz7Wx4XQaWbNWlGWH+iM7dh9o6stNmacshS/BQrxB
 LT53KTmtD+w==
X-Gm-Gg: ASbGncu5a/FcoxZy3ltoND+J9i0JOUleWjl4vy/ngXs0j2+dQaEnw/xryFvR7ZvR8vw
 dJCo0/D37Z9heKCgrSSWNHMVlA+GuL3OF8gGdD+MdySwseSPhoXan86b77F8+TVTCWHf30COOM9
 +q0hUqXmlpxyT9jZ1ANSbr3gWpQmGYEg9AF/iBODvBp0yiat1nIwjHKM/7SErZdS0OxdoaJEm79
 JZvpg8Irpny45+rzkpLVmIobCkhPgX5P9RmzJlNBgb2Q3xN9ZkXBMjTyOO8aR93GMJA5KW54CHZ
 DtM3Ew2jrbHMeZ02Nc0x5vm37UjSaCFupyALXTbyreXQX1J1qNbX7gdCatfxv+Ix3J+JIf8O8vM
 wEWrGGjVcfKkJ7jXIDLRHORoEXYOziQ==
X-Google-Smtp-Source: AGHT+IFta1vA3pAAJgfwNmy4OXlH6/P9GWD3K6yVMxCTdRB3oXO1S55DqlWaGvpnGM3BykHz8LEv1A==
X-Received: by 2002:a05:6000:2c0a:b0:3b8:d15e:ed35 with SMTP id
 ffacd0b85a97d-3b8f4198e56mr1727188f8f.23.1754470814970; 
 Wed, 06 Aug 2025 02:00:14 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6be:a792:5d93:499f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0683045sm12686057f8f.41.2025.08.06.02.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 02:00:14 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] lwip: icmp: allow reporting ICMP detination unreachable
Date: Wed,  6 Aug 2025 10:58:13 +0200
Message-ID: <20250806085959.2130339-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806085959.2130339-1-jerome.forissier@linaro.org>
References: <20250806085959.2130339-1-jerome.forissier@linaro.org>
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

Allow reporting ICMP destination unreachable messages via a user-defined
callback.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 lib/lwip/lwip/src/core/ipv4/icmp.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/lwip/lwip/src/core/ipv4/icmp.c b/lib/lwip/lwip/src/core/ipv4/icmp.c
index 9a82a67aa93..6d588349c4a 100644
--- a/lib/lwip/lwip/src/core/ipv4/icmp.c
+++ b/lib/lwip/lwip/src/core/ipv4/icmp.c
@@ -80,9 +80,9 @@ void
 icmp_input(struct pbuf *p, struct netif *inp)
 {
   u8_t type;
-#ifdef LWIP_DEBUG
+#if defined(LWIP_DEBUG) || defined(ICMP_DEST_UNREACH_CB)
   u8_t code;
-#endif /* LWIP_DEBUG */
+#endif
   struct icmp_echo_hdr *iecho;
   const struct ip_hdr *iphdr_in;
   u16_t hlen;
@@ -103,11 +103,11 @@ icmp_input(struct pbuf *p, struct netif *inp)
   }
 
   type = *((u8_t *)p->payload);
-#ifdef LWIP_DEBUG
+#if defined(LWIP_DEBUG) || defined(ICMP_DEST_UNREACH_CB)
   code = *(((u8_t *)p->payload) + 1);
   /* if debug is enabled but debug statement below is somehow disabled: */
   LWIP_UNUSED_ARG(code);
-#endif /* LWIP_DEBUG */
+#endif
   switch (type) {
     case ICMP_ER:
       /* This is OK, echo reply might have been parsed by a raw PCB
@@ -257,6 +257,15 @@ icmp_input(struct pbuf *p, struct netif *inp)
     default:
       if (type == ICMP_DUR) {
         MIB2_STATS_INC(mib2.icmpindestunreachs);
+#ifdef ICMP_DEST_UNREACH_CB
+        /*
+         * The callback receives the IP packet (not the ICMP message) so that
+         * it can extract the source address for example
+         */
+        pbuf_add_header(p, IP_HLEN);
+        ICMP_DEST_UNREACH_CB(code, p);
+        pbuf_remove_header(p, IP_HLEN);
+#endif
       } else if (type == ICMP_TE) {
         MIB2_STATS_INC(mib2.icmpintimeexcds);
       } else if (type == ICMP_PP) {
-- 
2.43.0

