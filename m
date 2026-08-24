Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993C7C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 576B040692;
	Mon, 24 Aug 2026 13:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aEOr_R6vRNEA; Mon, 24 Aug 2026 13:13:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577220;
	bh=Xu2MxCH60SGCy57TdYUoUVo50bSmPqsAKypkJL3s4lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g8yYC1Z9d/lbyoaOMDxVftHFpE9EFxX6o44n6idSG3SFBy3PHL93sDChIhT461eMW
	 3o1bxGsj/CkHcGOIFUpVrDiiZj2xRoOZTiIX6fm4BujaBH66kiG4GZjbGp2VTwPYnl
	 J5+7xm2O9vIesdpycyMiFSdqttSVAuIJoAoxp+yxPXyV76nAAw97aZtAgCaVzQLFWi
	 4C1LtxBuv9cdhVIfSVLaNvzHOCl2lIYGfcBxKJL3H1xyqp/PvL7JKGIBJkydLrynop
	 57eojB+dNDUu/6h+gtzNP0YrhAAClS0eauTXI7HcoZak31RUntHZxcx5D2BVSnXgyA
	 Dk50K6x7Cfz1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 264EA406EB;
	Mon, 24 Aug 2026 13:13:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 54447396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A5FC605AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J3mtV_lu3PK1 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=d0tECjYi
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2074E605F0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:36 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-499b0eefa61so19168885e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577214; x=1788182014;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xu2MxCH60SGCy57TdYUoUVo50bSmPqsAKypkJL3s4lo=;
 b=d0tECjYixMarBn12F8TKIlzvtLYK7D6YC0d5JJTgG8rHpJDbFdaaQs4nsPN0DABJ1A
 XsMTfhorTFfYyCUGUvZsY+awNvKgMYEg7bLM7q/xolGS6gXtajFbNkzNXXI8A64DFfv9
 aAJNHGU7mFSG3flDIiVymRGKEaH+rOW55px4nQkANssa5v6Kv0amBCCki7V38Jx7xbB8
 rr6NnkgCMtM+UNCIUEZSuCl2w5K8X7i7qKX9RQmv0HXjW+DdA6ihHm8LwW5vM70HZL5Z
 pJtFYX7QOHOwKABtx9JmhT4mx+Qrkx7DxP1z30eDxw3D7Mr2lJ+tJzP4yuHEhkvnxWol
 XfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577214; x=1788182014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xu2MxCH60SGCy57TdYUoUVo50bSmPqsAKypkJL3s4lo=;
 b=tJsTmpm54LzEe2U9G0CizoEijuP+x8OEEs00wZb4TRm5O0Q6fSXYquDe0b00g9cnsg
 jBw1f6LL2iFXP5tdpWFP98O7qGcatj4jfGOuSpz/Yy9JLbSyZ3xPnb61IzCQxBtNmbAj
 o/GzOfsgEqhKuhxmcGCsBf4wqTOovFlXLaSG3ilAziwom/WJlTKH4B8SAwNZA19MYOPn
 G3iXwXHSnwN8krN7zVt60O3ERLGqVTT1JAvVXB7omtnXwQ/pn/g6dfpNrOjwJBkaS2HK
 wJb8hOn6aLcqXyTpMIo7aVzXUY3ISpn5zLQV4iDru0wEOleanQsFAQ+PoJE1D216mE7f
 JS3Q==
X-Gm-Message-State: AFuF++lgDhGcZtKFtqbRt8dwIg7Jeptgej9ZQwKguOrswbQ9Qak+ee7D
 kmf5K2E54JvEjJQ01kDuQQPwLdUtoL57bob2ZUB0C88LBO2x7W+BrRyT9dLsb9LvAzQ=
X-Gm-Gg: AR+sD13SJIB7NF5QfWAOXLlmBIUeOSC8UISnhsfMcfeelO4/EZHaIzXjCjvXdurRLAf
 d23y8rfsjWdFpy638F4b7+ocytuVWP6DdkKTXxT9bJgq4S6nq3DKR5TNjHeYhh769k2qKRKfsgU
 iPUPNl38jG1Yzn8BmTxnnZ9ggpSBERL+aBGG3NITbHgE/D51cUklVTh0/nKv0qosPTZj2SnMGYk
 LuCqR3kDWcYtUhwuID3SWJJhxLq1kj+e1y1esj64/yEspbkhzsAyCe02CesHGnO2ldTKcGSjcyw
 PM3L3ktViXLwYC5Bj2a65TUQYk3QLhhpeBXdeuJKckVDthjvctv9z7AtPEbcV6ohy8pFMzX7XV5
 Q3APSFwWt+QtsUmtcZGarUX2R6w8xzdFKFqIjElazMpvktWI/EPqHASbg8Crfp8eh10rsbWGvl5
 vLu7fBuN1VjpRJqLylsKe/6vXwpilVdQ2mqaE9IweZkEtR1k+8cvPpA5BPYu4v+3lLXbgL/NGPM
 1vKjI3ntlmYa+/VQbbYd/8yi5cfv6pHl7tHH+cweg==
X-Received: by 2002:a05:600c:1389:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-499c19a90femr191828745e9.7.1787577214421; 
 Mon, 24 Aug 2026 06:13:34 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:05 +0400
Subject: [PATCH 08/17] pylibfdt: Add size_hint parameter for get_path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-8-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=alchark@flipper.net;
 h=from:subject:message-id; bh=J43FOWNpgmsVVv51Tu+PfZBQhUeXi2jBsdhCdRJ5LNM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGftPf474Pi5k2XBKR9XrpDQvuW9+1qx+q4bW1akL
 9/akmJv2zGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBU373J8D9UXpYnJG3j/dmbdka4d14ziZTeymjVZS5y2/wE491ayzRGhhOSemk
 d8z/LTFjx4tv3ZclBSsqlLKJqz30/cX9re7+mgQsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

From: Luca Weiss <luca@z3ntu.xyz>

Let the caller pick the initial buffer size, which also makes the
-NOSPACE retry path reachable from a test by passing a tiny hint.

This is a backport of dtc commit 3f29d6d85c24 ("pylibfdt: add size_hint
parameter for get_path").

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapt to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 2a7fdfb2af40..6a900265459d 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -447,11 +447,12 @@ class FdtRo(object):
         """
         return fdt_get_alias(self._fdt, name)
 
-    def get_path(self, nodeoffset, quiet=()):
+    def get_path(self, nodeoffset, size_hint=1024, quiet=()):
         """Get the full path of a node
 
         Args:
             nodeoffset: Node offset to check
+            size_hint: Hint for size of returned string
 
         Returns:
             Full path to the node
@@ -459,11 +460,10 @@ class FdtRo(object):
         Raises:
             FdtException if an error occurs
         """
-        size = 1024
         while True:
-            ret, path = fdt_get_path(self._fdt, nodeoffset, size)
+            ret, path = fdt_get_path(self._fdt, nodeoffset, size_hint)
             if ret == -NOSPACE:
-                size = size * 2
+                size_hint *= 2
                 continue
             err = check_err(ret, quiet)
             if err:

-- 
2.54.0

