Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A17ACD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 16:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624B08483F;
	Thu, 21 May 2026 18:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XLZDE37q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDA84844CF; Thu, 21 May 2026 18:51:24 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059FE846CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id CB142266E7;
 Thu, 21 May 2026 18:51:22 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-bxiVYZoRUH; Thu, 21 May 2026 18:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779382282; bh=ZOCcELG6xYfnLXe8ex62eKyXT7DZXhqPfuh0njtnp8E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XLZDE37qfRhgTUjnAVJ13Q8K3XG6/xd4iPtvZiyND0Da8yOszf6byPohfM/BD5Roq
 LwDiCgCjhRAz5JslDzRY4Ga6TbghEscnLJmxwu0jecREfPPbxCDs5YhTsexkNzIovV
 Ep3yLPJOuIlsnMkEuQ9qm0H69Hmv/mJOiRuYi2JerIS7voc2vVilwDZRHtKyOz4vss
 QKKlVR/ah9m+yj96rjazMCkY3TD3dcnmVJca0H8Ok1QK5jbnI5YHE2oTi57nddwqpw
 2diQYocirV2oUd679qd5Rf80WA6b0Ne4sybVgBs8LgJEB/1BbM1ba7hPCo3L2W9+S1
 XSrc4STviMfzw==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, trini@konsulko.com,
 Josh Law <josh2@disroot.org>
Subject: [PATCH 1/1] libavb: fix avb_replace() OOM handling
Date: Thu, 21 May 2026 16:51:22 +0000
Message-ID: <20260521165122.17475-2-josh2@disroot.org>
In-Reply-To: <20260521165122.17475-1-josh2@disroot.org>
References: <20260521165122.17475-1-josh2@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 18:58:03 +0200
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

avb_replace() promises NULL on OOM. Once it had built the first
replacement, a later allocation failure returned that partial buffer.
Callers treat any result as success, so AVB could keep booting with
truncated bootargs.

Free the partial result and return NULL. The existing callers can then
take their OOM path.

Signed-off-by: Josh Law <josh2@disroot.org>
---
 lib/libavb/avb_util.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/libavb/avb_util.c b/lib/libavb/avb_util.c
index 8719ede15a7..9e2e6ea3495 100644
--- a/lib/libavb/avb_util.c
+++ b/lib/libavb/avb_util.c
@@ -272,7 +272,7 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
       num_new = num_before + replace_len + 1;
       ret = avb_malloc(num_new);
       if (ret == NULL) {
-        goto out;
+        goto fail;
       }
       avb_memcpy(ret, str, num_before);
       avb_memcpy(ret + num_before, replace, replace_len);
@@ -283,7 +283,7 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
       num_new = ret_len + num_before + replace_len + 1;
       new_str = avb_malloc(num_new);
       if (new_str == NULL) {
-        goto out;
+        goto fail;
       }
       avb_memcpy(new_str, ret, ret_len);
       avb_memcpy(new_str + ret_len, str, num_before);
@@ -308,7 +308,7 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
     size_t num_new = ret_len + num_remaining + 1;
     char* new_str = avb_malloc(num_new);
     if (new_str == NULL) {
-      goto out;
+      goto fail;
     }
     avb_memcpy(new_str, ret, ret_len);
     avb_memcpy(new_str + ret_len, str_after_last_replace, num_remaining);
@@ -320,6 +320,10 @@ char* avb_replace(const char* str, const char* search, const char* replace) {
 
 out:
   return ret;
+
+fail:
+  avb_free(ret);
+  return NULL;
 }
 
 /* We only support a limited amount of strings in avb_strdupv(). */
-- 
2.47.3

