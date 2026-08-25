Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE51C61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C39860746;
	Tue, 25 Aug 2026 16:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whh8Jnjl3Kv9; Tue, 25 Aug 2026 16:03:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787673827;
	bh=aI02TM/ypcwoNbjB4peMmohtAt623MQGSlNwG0A+VnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=co3c7ncN5F+AcRmOJ8rnwgx4RsmhnkNf2HyQtnG0UnW0yw2XbqTZqrfdZQLIC/tHu
	 TPo1nXHevvEypds0K+qTamjQwCSGQty/FjfXzW4u2iRr0sZMsxCuyw2Nst4tk+wrw7
	 9Y43E+NL720rsIhozDJJQdiICULds4otSjCZA1gCnyYeZVid2YcJDxxpiMk3WTGf+W
	 vOJJiuHyhO3OSFAfEzI7jx+sjvGQ3nEOckE4yjrStvZlta1ARD2zu43P19x7/iDJIp
	 5H0ziWgInYHQRF/rUom+67zQh/HENbCHKce9Y0u/5nIEkzKnJJ5q1rIm+qbOTNGCOO
	 oLCXhbSG+YivA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DB9F60735;
	Tue, 25 Aug 2026 16:03:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C49A21465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB55C40592
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0rMXjbGmzPm5 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:20:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QGQu0f/p
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73B5F40591
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:20:09 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47fecbbafdaso1519236f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787667607; x=1788272407;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aI02TM/ypcwoNbjB4peMmohtAt623MQGSlNwG0A+VnE=;
 b=QGQu0f/pNwABslYBkMH+HqY9E2QSqGNQZ0qvzR8yK3ltt6/uad/1R45jvvwYV3YNvB
 eF3oqkHUV4jYLG+dOIEgIa0j97gyB37sVmJFJVUlh8hcGciCXrvnAFlv3Uut9jMoZCIn
 dPrOTfvqlZ+QhGsbxk0IvLPm3DwVIHdnfqecx//ir/mWZxW9Jc6bCFl520P0sUxEAfVK
 SSFpXeq6sKPjsF3i/okm2pK8Xco5ekiHaKpnXHKDgV/RsW4I7zm5jObMRp4/xzg2ELp4
 24o4wY5WGuYQe1H4eeir0OHerCuVdAPARuXz/0ciELAaMU4h+uqQ/j7nJgHO9zIqpZWi
 xe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787667607; x=1788272407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aI02TM/ypcwoNbjB4peMmohtAt623MQGSlNwG0A+VnE=;
 b=n25VIZWbn3FK8mTIIsDn7lvgwMRkjYAL0bWsmpLlr27nxw30RzE3gpt/jYgNi3rDP/
 VWTaTxUaSNj2pwNfJAj1WXPmMnjZCQf3O9b5G1+6oAvibvUFmRhhlAR1jo0J+eDq6Icl
 lfIxgOVCsHrDRiXcnEiYjIrXFTJngIkgehGnAva+VxPfJBFy4pIpZNI7Hk5t6BShobxf
 9qjtv4tzexwG2C4mlMPA1WRxYISLWrpMmYDvI26Qorxc+9O4b3kYQc3pSU5gJ+0OmA7m
 leKHeUl7uFhg7WgOSIyMER8o2pa1dAfKbu0xegnAOJWHBtljG9zTVFg/T+JOymzU+1uJ
 h98A==
X-Gm-Message-State: AFuF++niWrTSGD+ZAI/M55/rKcPbAi/5Zv5mOs17Z57XXgj3Qby2Q+5U
 J6XHMXWVRIPC44kaYEgTNlO5MXyKotojIlreLPz8Z0tDA9uukHbPGqH2+h/s0rYdBjk=
X-Gm-Gg: AR+sD10WDjHSp8kP+F16hebzVrs+uXH8om9hRcA3c0TQ40ouwjDT6WAq3iY7VAOIFuH
 MAr7BPncQ2m6jV6tLj3ceLcmGfNhKI1ofLXrA/+0KIXuhrOinF67kAgvzjdPrVbtQez0mTkob8w
 CBfmLWBNbO6G58U8X+DxrKOi3IWwR1Ju7dZ/1hsqy79I9k3bnCXprUCBC0MKQLrIhnOo/aa3BmJ
 qMRRqHteWs9pbXHjI6wyTZMF6l/fk7Jm+0grdBByH4GsJMUTuRT0d3sXWCH/6BHX1al9ab1r6J5
 6clY7rZvjf4Q5fMUigzk50H5Aw9Wxy3Ot3PFMQ1KivLI2jbrOzCfyRzF3LdMelWbSHOIxQBDN1q
 l7Bu9TqJHa8oQLlIVs9hPc07aWEXa7JL3wf4vuKtKoUYSzjarPznz9FuvQQO74v3MGPcvR7EiPP
 54NFUmPHHzqovRHCPQtQvI0u9smziNe1wtFfys5CoQgn9urjmnNRhU96Q9cMQVap9NTNT5qUspx
 2b8i+lPL8UOxt0RXgjzcahzkubOMCT0HNlbZ4LZudfDZrxHpST1P8ftyGQhUZLtKRDVnP/2gArY
 WFWYwb2wMg+ag6d5cL+XK5nSkJtIoXMPqzZzJ7srPvRmyGs=
X-Received: by 2002:a05:6000:3104:b0:482:a909:53d3 with SMTP id
 ffacd0b85a97d-482c8107843mr31627657f8f.2.1787667606909; 
 Tue, 25 Aug 2026 07:20:06 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69d7dsm11745871f8f.4.2026.08.25.07.20.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Aug 2026 07:20:06 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, philippe.reynes@softathome.com,
 Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v2 4/5] include: u-boot: aes: make disabled cipher stubs
 static inline
Date: Tue, 25 Aug 2026 15:19:52 +0100
Message-ID: <20260825141953.9534-5-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260825141953.9534-1-pranavkasthuri@gmail.com>
References: <20260815220754.11724-1-pranavkasthuri@gmail.com>
 <20260825141953.9534-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 16:03:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

image_aes_encrypt(), image_aes_add_cipher_data() and image_aes_decrypt()
are defined directly in this header, with full bodies rather than just
prototypes, whenever the corresponding IMAGE_ENABLE_ENCRYPT/DECRYPT
feature macro is 0. On target that is always the encrypt side, since
ciphering is host-tool only.

Those definitions have external linkage, so a second translation unit
including this header under the same disabled configuration collides
with the first at link time. Only boot/image-cipher.c currently
includes the header on target, so this has not been reachable before,
but it stops any other file - such as a unit test - from including it
too.

Make the disabled-path stubs static inline, as is conventional for
header-defined no-op fallbacks, so the header can be included from more
than one translation unit.

Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
v2:
- New in v2. Needed by patch 5: the new fit_cipher test suite is a
  second translation unit including this header under the same
  disabled configuration, which failed to link before this change.

 include/u-boot/aes.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/u-boot/aes.h b/include/u-boot/aes.h
index acbc50b9e6f..d72322c1013 100644
--- a/include/u-boot/aes.h
+++ b/include/u-boot/aes.h
@@ -16,15 +16,16 @@ int image_aes_encrypt(struct image_cipher_info *info,
 int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
 			      void *fit, int node_noffset);
 #else
-int image_aes_encrypt(struct image_cipher_info *info,
-		      const unsigned char *data, int size,
-		      unsigned char **cipher, int *cipher_len)
+static inline int image_aes_encrypt(struct image_cipher_info *info,
+				    const unsigned char *data, int size,
+				    unsigned char **cipher, int *cipher_len)
 {
 	return -ENXIO;
 }
 
-int image_aes_add_cipher_data(struct image_cipher_info *info, void *keydest,
-			      void *fit, int node_noffset)
+static inline int image_aes_add_cipher_data(struct image_cipher_info *info,
+					    void *keydest, void *fit,
+					    int node_noffset)
 {
 	return -ENXIO;
 }
@@ -35,9 +36,9 @@ int image_aes_decrypt(struct image_cipher_info *info,
 		      const void *cipher, size_t cipher_len,
 		      void **data, size_t *size);
 #else
-int image_aes_decrypt(struct image_cipher_info *info,
-		      const void *cipher, size_t cipher_len,
-		      void **data, size_t *size)
+static inline int image_aes_decrypt(struct image_cipher_info *info,
+				    const void *cipher, size_t cipher_len,
+				    void **data, size_t *size)
 {
 	return -ENXIO;
 }
-- 
2.50.1 (Apple Git-155)

