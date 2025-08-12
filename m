Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F46C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E6D8341A;
	Tue, 12 Aug 2025 14:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mqNELplv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0980834BC; Tue, 12 Aug 2025 14:43:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F4C834BC
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-458b49c98a7so34837535e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755002634; x=1755607434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmTICOtbxOLqMqNjTmAurXfrYwegSaEIJnaXp/ivb/M=;
 b=mqNELplv7+0sGiZ3VIKHjHK0+QzDkSh20fNvPGLFD4ALNFcvFRlokyIRKL92eFQ1g+
 onVoNwc+1QGffjGd8x15rQar/vMBbt6tWqVPgabyULjeurslJz0xvZgeTBI1tPHqXdeO
 Jxabk//IglNaSvjeCGvw6W7EDf0AGP/DC+BsgK/X3JknpqxvblrD5DUcq3ViF/wtow49
 T9RULjBeqiAOtcNrDu7wXXDnnQzUkgejtS2BHV1Iqw/i0RGmJHgqMLOBkPR395Q8oyCp
 WkE0Un4mt+WGHtfSwRrO+dL90lkzfVd4994lJQHSvI0OBU+YhDJtVYH+MTkfQUTPIbS9
 P+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755002634; x=1755607434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmTICOtbxOLqMqNjTmAurXfrYwegSaEIJnaXp/ivb/M=;
 b=KEUt0HRdpCjaCh2QDuA+jEpcaGiuFax8viw9GS5txIwuuQcR7FKLUZH42u4YT+EgV7
 C0PiaRpe4aYZuFwrPtyR2Z3/ZSE4tHj0dgXMfutqiGkNul2C6YCXQUj5OnQrBp+sMp/A
 w7aCULx0o2xkGSWKdfpYz+M8RonqGzy9vRNKdJSvuBxUjTWaibS3YTlQGySGhyo5fld4
 3bvy9pBAvBUFkFzGaLqbyXuT5T/R8+ur/LyvBtIfXg3YIP/eqaWZpW4dBO2djN9dIMn0
 ZbU1VcUtDDvzraYld6Bv5jL4Bn8q3zLtM5bQsQ5BqSZi9QLoCncW1PhmQcDTShSjxhIn
 itiw==
X-Gm-Message-State: AOJu0Yx45O7xxUEiGAv+7Z3NgUn+Pssrl30bNrnK2rvMpwOYhK6p802/
 D1J8o12Gg2KtsEw6kZx7ctBoV2jHCZdeavcQM7MKRzPNhzc4hGJ90Zaj6CoWYuB4pJxSk6OT2iX
 RkTjyReXamA==
X-Gm-Gg: ASbGnct1eFrxWs4njLNEKGUGGTQDCrIr7XZgpfBEgYGl57Kw8CKNNsUGkdsm7MI5m3+
 Ji1TYdUATZT8U1qorOpIpfHU2ild29WAZeKSPWooH8bQstH4Sb3ancKoo4iFuqdsZlCvid3mBGj
 3RxfAsshbRbCbG1qd7N8ZByZiL36sCmMDF6FdGpj92gS5ayzkLWR+j6g2wGx5bbe7HmnRPLWFrV
 HaaxPk55KZ1svjxvYvO7MbJbwkUuGkzUSnaePKjI/rc6TVYMcrlK5Q+xdLNY+XLemS1DrY3+ieV
 E8myBLPMUGBMl/XeKQGR3djfcxU4/T9qP8Dj7/wP/PqOeWoX7dKJJOCQyTm8YxQch1rStzjaSNi
 NxYQXPjKk0XJHvwqsO2LaC3nhGQfW/rk=
X-Google-Smtp-Source: AGHT+IHK9ploDm1BFHf34kEO7S2Ueyot1qsP3Vhsm/vMe0MiDPOckzUPJ8rDBNMbVH1q1I3TpdgjRA==
X-Received: by 2002:a05:600c:4f86:b0:459:da89:b06 with SMTP id
 5b1f17b1804b1-45a10bef8bfmr31331765e9.16.1755002633954; 
 Tue, 12 Aug 2025 05:43:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6b34:4d0b:774a:130d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585430csm297745475e9.11.2025.08.12.05.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 05:43:53 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] lwip: icmp: allow reporting ICMP destination
 unreachable
Date: Tue, 12 Aug 2025 14:43:18 +0200
Message-ID: <20250812124331.1464879-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812124331.1464879-1-jerome.forissier@linaro.org>
References: <20250812124331.1464879-1-jerome.forissier@linaro.org>
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

Changes in v2:
- Fix typo in subject (s/detination/destination)

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

