Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEC5C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE89F405FA;
	Mon, 24 Aug 2026 13:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lL6RBitkitTs; Mon, 24 Aug 2026 13:13:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577222;
	bh=VH14qsnHYbuyLNosPZDP+Ek5QnTe/oROZHjqUxX7RYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1GAAPxSUleLvDcjFosEyloDhWZngvVCtDpd9pWLXyHcOjyYfL3uWPjxQiA8T5dDEo
	 JhdannJUUgQ7w679z1YLHsH8+RJojypZgdNALhmJgl85UsxPQODerL68RtC1iP+f1c
	 txbRNl+t0TlFU5iykUw15u7rxz719+wM8mK9CQJOlQD7pyfIr4ljuBPobKWBzI0HBA
	 V7aO+udqhb/BN7ouZm0lCTA8qq5fydbVLwukfQVyBg81Xp/c/4ccPHpf6CtPICfThD
	 Zy6RYTcWnURLAof83LMMCQwPkMMAGZbdhc6Bm2BHiynX4KYolM/hp7j8ZL/AnWPf+l
	 9JPFORbmTrtbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 357EF406FA;
	Mon, 24 Aug 2026 13:13:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA437279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D14374007B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6tnSjWxnZcu for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=IISDXLYK
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE22940029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:38 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so1821993f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577217; x=1788182017;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VH14qsnHYbuyLNosPZDP+Ek5QnTe/oROZHjqUxX7RYs=;
 b=IISDXLYKnklmProQ8VCcYpe78xHn33cJbHoLLyiQ3tKgboyBVplNmc+coy1rMqg7vD
 c6GpuwuJWvCjxBfKI9QIGPiiQNCYb0t4Zx38JrqY5SYyFG5N1Jh+1J2IbXlQwafaxRX1
 TulRpNWGLCanuUhtHBa/QPa0hkMAA8pUaxkak6ghEKhehxmV9u9Jh4VCXXFKVDvg6WI8
 oEOCqKbs397ZQxTIH6M0w9+niCrc8dxYPErYTEL+aab2aqLYTVZxDfDnwNbJZRZwkJbf
 1GsmUCTbyWaTfybLJewB2hUr85tfgB7ZgcnR5agtJ/4pSFsY6shGnFUBaPLBXxqwNGDV
 sthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577217; x=1788182017;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VH14qsnHYbuyLNosPZDP+Ek5QnTe/oROZHjqUxX7RYs=;
 b=dKPUmuAYRAPL5VIjbNmEXOri/A3nMomne4plstvDO1vGynJxW0dF7F7hY0cU5v9n69
 JjgK+7IjdaoiZZsJqL47l3IT2svYi9mk//y46u6CB/IK+RL32IwhwwEz0NOpLrsv9Mjs
 SiOzo0pGPjwf9z8ABO14K4s7IPfQTQCg5r8KKagPpMOPKgfj9cx2HIbsR0ofzHboiYJn
 thDiAfzWnkELFXczxcTqFjNDrU9hNfwsa0RcwcVir+daUNItyc3yNPgKVOqkQiSKbIGv
 +aD7LGtepbql88jt5AuU5SElBbfblCuRFCEauNh2H2BRGTaKSjuk/+GGg9PbpUOStQ8K
 1mCg==
X-Gm-Message-State: AFuF++mTXPZLUO1hGV/e2Wmz4qh9Yk7mWU9D/L+5i/ybnU9r8juriqJc
 b6XqGOOwNY9ru/1ugTysXSu3KykKExcU9dFPmrwByCIpmCJO2HFHuQGDoIskTJA25dY=
X-Gm-Gg: AR+sD1322Ct03jcA4gT8aotyYoyykh7o8uewIPj1GaM28K9pzwCHKj0o3AcJ240qCIU
 mIl15Tr1fWUscmWc+YBGMRSZzgeo5iejKcw+BS+1zZ/lKuV5SKmVgIcrLpRqESjvmo2QXZYDI/u
 D7lRraNsr5V3F7ruoDPWcrNx5St7pRMP7jdU86wh9JKsJNSjvkm0k7ELUyZGeYPM0rBQzZ8y2Xx
 aKTbDaJyM/dHFrWK+LAUVy7g8km+176+Uq+54KG9zymtDNi5BvyxlLU1bJ4jggvmMHGA/IdJeXK
 y8m4e2eOEx7rtud5XTIzGopFnYmRCdOMsiwplKzInGhNrr9EbFMZMvgd5dyXPpHGxyZxVS/RmiO
 jqGIV72zy6oFwG4cz2/g25LNPn0LiYe6QBkE+wuA4n02XxuEfltBCbftdplz4qHvNXD+elbBUjh
 Q1K2vjqqUxDSvBh23kNYpsMOlyFKGtt8L+l6v4TIYdelOMh8UcuPcArQccl06k7u3owcr620H5z
 2oeGzHP9FSpOOZBap/bh03R94116QuCky5RgXCu0g==
X-Received: by 2002:a05:6000:400a:b0:481:56ec:b422 with SMTP id
 ffacd0b85a97d-482c8111df2mr20219440f8f.9.1787577216641; 
 Mon, 24 Aug 2026 06:13:36 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:36 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:06 +0400
Subject: [PATCH 09/17] pylibfdt: Support boolean properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-9-a42be6fa4872@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; i=alchark@flipper.net;
 h=from:subject:message-id; bh=zqiZjn99LbP5N6dQiKPi8lCbug6S1vHqpNtZuczMoZE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGdVOFbWbpjCEZ+g4GZ5vnAj+4Lrp+SeCcbkC50Ur
 on92nK1YyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKnex8HI8E69uNQ91+fS9rtMjs1LDB8+YWX963r40pzy5eaMjm+KOhkZdlQzi7X
 Nfs2aVdGmP+Gj+bEJt3XyPmQtSWm5NPX7wbWLeAA=
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

From: Simon Glass <sjg@chromium.org>

Boolean properties are unusual in that their presense or absence
indicates the value of the property. This makes them a little painful to
support using the existing getprop() support.

Add new methods to deal with booleans specifically.

This is a backport of dtc commit 52157f13ef3d ("pylibfdt: Support boolean
properties"), without the dtc-side tests, which have no counterpart in
U-Boot's test suite.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapt to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 6a900265459d..dd568fc74935 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -423,6 +423,35 @@ class FdtRo(object):
             return pdata
         return Property(prop_name, bytearray(pdata[0]))
 
+    def hasprop(self, nodeoffset, prop_name, quiet=()):
+        """Check if a node has a property
+
+        This can be used to check boolean properties
+
+        Args:
+            nodeoffset: Node offset containing property to check
+            prop_name: Name of property to check
+            quiet: Errors to ignore (empty to raise on all errors). Note that
+                NOTFOUND is added internally by this function so need not be
+                provided
+
+        Returns:
+            True if the property exists in the node, else False. If an error
+                other than -NOTFOUND is returned by fdt_getprop() then the error
+                is return (-ve integer)
+
+        Raises:
+            FdtError if any error occurs other than NOTFOUND (e.g. the
+                nodeoffset is invalid)
+        """
+        pdata = check_err_null(fdt_getprop(self._fdt, nodeoffset, prop_name),
+                               quiet + (NOTFOUND,))
+        if isinstance(pdata, (int)):
+            if pdata == -NOTFOUND:
+                return False
+            return pdata
+        return True
+
     def get_phandle(self, nodeoffset):
         """Get the phandle of a node
 
@@ -609,6 +638,32 @@ class Fdt(FdtRo):
         return check_err(fdt_setprop(self._fdt, nodeoffset, prop_name, val,
                                      len(val)), quiet)
 
+    def setprop_bool(self, nodeoffset, prop_name, val, quiet=()):
+        """Set the boolean value of a property
+
+        Either:
+            adds the property if not already present; or
+            deletes the property if present
+
+        Args:
+            nodeoffset: Node offset containing the property to create/delete
+            prop_name: Name of property
+            val: Boolean value to write (i.e. True or False)
+            quiet: Errors to ignore (empty to raise on all errors)
+
+        Returns:
+            Error code, or 0 if OK
+
+        Raises:
+            FdtException if no parent found or other error occurs
+        """
+        exists = self.hasprop(nodeoffset, prop_name, quiet)
+        if val != exists:
+            if val:
+                return self.setprop(nodeoffset, prop_name, b'', quiet=quiet)
+            else:
+                return self.delprop(nodeoffset, prop_name, quiet=quiet)
+
     def setprop_u32(self, nodeoffset, prop_name, val, quiet=()):
         """Set the value of a property
 

-- 
2.54.0

