Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B080AC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDEA4403D3;
	Thu, 17 Sep 2026 13:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCZrRT8fOiYS; Thu, 17 Sep 2026 13:41:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D29F94071C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789652474;
	b=OxYSEzI+H455qsilXB6DWvvm/fQXdAxKi+Xm1iWkOfGXG4er1IArDFpFqXLSgn/Amw2J
	 wVjwxsU1K9a4u7Oknn6TDYS/pb1l5sprG8dLoWEZZRp6haxAq/OUKH6LI6/CGRQRhCi8z
	 fuGaIVUw5inwZykzHtBjwH3RXu2b3f3lqwghAajQsg3kUFDQKMC9xBhsp29zN1VlYhRJb
	 cCJnm0rErBbDtqcfJugcQbpu7qWR/55geZjOtqT3WskshFnsvysEYA3vqqNDBbHZ2Oh1A
	 Yw7FjrjRXdBRmgxf5eW+z0mgUl8olRsWx37eYrNU2xkUeSpG075L+2DLI7NbnAxCiSw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789652474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wQ46DwkWL5fdK9M6Boc8R5mDLjAW4K+TKdkilJJbaXM=;
	b=pU5WDDkLYUQFUgGARjs0zWL40Y29u9HaQ49Yi2v7HNgFxkZjRnhtkXI7kuLtd1qBNFUs
	 m20Wb/2XMPvVPqFNoLkS7fJ0+VweXZCFRZ82B1GHgzrxearo/AVFSab9vH0Yh9yGamOXj
	 A8iOCptiRn0lPrlKr2VbkISuOymYPZZe/WbkhV0YLuHfgcXmj1oEw66ycs69NKap0IP+9
	 uwzXQdeSE4zjBIQhb1493jZDmyrmnGOiBnRKuWaifSCEQB44vwVUnehV3N2prbNj5gVB/
	 mUoopyFoNBTXYkEWGtBMpHGrU1ngwV5Gd1SuXgtblTLjnbQkrNMAFXG1/2Dn93mlMCQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789652474;
	bh=wQ46DwkWL5fdK9M6Boc8R5mDLjAW4K+TKdkilJJbaXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O8X14bPJ58P+Pmvk4CFibbpz7QhIGJoqEnMHvRMxsKo7sdH73lhyKjOiQSQBP9+Y7
	 +dVkhx0tfth4JuXXdW4Kqtfv2AMKQieI6dCkEXnJMXzWKAPIEyXVWQabK7C7Cjwtyu
	 GXQvEsl2n/mG7iRrWdQ7TbTm15LXDGQozPDideGhr9j6nHbST+dteEQCbofOPYEh/r
	 Zk3YQbYLYXnIQKThp5m92X4HICJQICrLt9B29sesC+aVBvwkawYHCup6Sd/wZhsUVP
	 Omln1JNVmtolx3ld4IwGUAdH6T2HuTXvJAw1l0pMEbV4KMXwxymb8pgMX0w8NaYAVm
	 1XJauU0jKY4Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D29F94071C;
	Thu, 17 Sep 2026 13:41:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC0B042D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD93980DE1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nbgCKVmNqPcv for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E40DD80A91
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628218;
 b=nuUZebWHFCmIcw0TPh4kVLV10yGyLB5Fb8FPesFZoF6pJw7CtPIsEx1qd8bgTdrCGds4
 2kaCvRrtOTj6DTygopbJWmrTj+DsAH6tRGoduC0ZfdG/HYJAVnhUiiz8b/Uq1LJqyOycz
 vco1kQS47kpKjhzKeCMrBgTWQny1N0c6jffiTm4PoDTOqMdQ+4hO00tlUJNG7sx2AwKOa
 25qK7Pf1NRNe93c25dlwmOtet+bZxnGQ1wwYgIF9tuPS3JBi1Vb3LRaQCACBiFPTHvwv0
 aMWa76xT5c2+V6PnudVR1TrgGlXaZsTw2VF3PUTG7bskc8aebBHu8Szh+dWaytAJvEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628218;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wQ46DwkWL5fdK9M6Boc8R5mDLjAW4K+TKdkilJJbaXM=;
 b=o9T2h8JC3NWI6a1Rq5hpjz7FXR+guhB9G2tp76MS/KiC+ODclinKpBldeH7sKrb6m896
 zO4GNDvGQe6/9H11AWTZ4P3DLNqK1oHNGYLIIhg8esf4iVDjRkGhAlERWqhLDjoIsmqTV
 pyajdgB0yK8vNmB8DTkPeymmIl9UT3THLZcxNVkelDF8iNdCIAAc8xbfY6h614SEC2L6S
 /0+efHKeQzfFhK27s9/eKvnV8WsI2s4oeSe5iJBAWdkXBRzG653Iehk9en+uKKQcQ63uQ
 MTWdgmkp6sK3K5EwEL4fb1wwx9AP9oTaSQ9SYW2qYon+ctCD3g66vJUtZbwxWBwjcMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=sigma-star.at; 
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b="T/Kjnew8"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=T/Kjnew8
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E40DD80A91
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:57 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6356256so136807f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 23:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1789628215; x=1790233015;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wQ46DwkWL5fdK9M6Boc8R5mDLjAW4K+TKdkilJJbaXM=;
 b=T/Kjnew8mj0QAZ55Y5BpyFVsePlQHd7T9taZCDtKQPYgWdAKykFuAeSYruqZEPyZM0
 g5wY2WOMVPnaiOtBOB4JXdFDvgzCE2Aa93AQ4wsCIOW2TL45oIRE+WuwwYjhADWs+eYh
 tiKVfDZUzf93yRLPNcyU8EloHSVXHidu9J6osO7ouQCRguS231wg7T8xxmKOjpehVno7
 7R2FkQZ+Tqcq5QYq6Eo+t2kv3PqiSpHEh6Mo5FT5EPpHBOWo1Yvx9Jb6VDSahViASrKs
 9/0YVnPVWhnDT0K4CLA9NbqzRANRehLjTlGyaeHGQXohDNGNjwk6ZCItAMvVZuy8BKYL
 B8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628215; x=1790233015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wQ46DwkWL5fdK9M6Boc8R5mDLjAW4K+TKdkilJJbaXM=;
 b=FM4eikH8r8n3ImFcHVihYntfZJYwleWfdldDwwDhKreVb7kJ1Fa6FMMApZNaN0sYD2
 0/ousjNUmnv8ex4RQn/XX7m0HVZ/JHKJq7SeWXGbC7KXAPsp9d5h+MKp89iYQgBlKylh
 8thrq1oP3OC49lVz/Wn+gJd23+DP7c93TgFABIQE8hObU8s4ZY3CJdiYIXf3FtpKH8Jr
 54Ubq/zNj6FLUOR+upnwIPD4r7SthI6hoEjy2sj2ifP0FBJ4TY6qcA4MEH5oQacC5ZIn
 FyQYJtoTLzWtrCjoZFyYrn8GSubmXH7KhMzKhChBleaKm2Qo7sioVYwciRUCoSrSBVK7
 XWnQ==
X-Gm-Message-State: AFuF++kw91+ATgQgCj3tuLYEwzvd3AKmog9DKB4wIn/JZXCCTKzHszEw
 xt1is4ZPIwC3pmcxFUb0RSvErA4sPFl1HrIvJgtb9h8Re4yxJmZ0p7AGSpqQsVnFphFeo8C5mSv
 o4xe6LI0gpA==
X-Gm-Gg: AYBFou0qM/MckN8tEO09rsjPda2B0ik6PiJt6U6493NkZcehMKasNdNmtWULcg2Jo6g
 bTb5Mm6VACXSXneOWFNbji2KiMx8N8AK00WCiPb0PpjjnKd6Xzg1hxRYAuyIneonC1TqCqUFCaJ
 cngsSPaEshxHVnA+VpiOuiTiFvpJ42e2hkNGzV9l8nRLp33tzxxW3YxxPRlb1dJruzdWrv8zuK9
 s5OitcCFaSqBgEWOGtSC8q/Pv8+J8WYhiEOtYPNfdhPPZ2GSztNmTLeGgVUu0d4CPJJjuaKCAle
 weX9XGvczc0dAV7uWD8i9ea/egWEI9Q/3f4Bw59S/GwtFA9a37ORl98/krVs/8vvjhUl2uMbgeY
 /SrwoeJdZCTc99nmLrkMHlFPx6c2OXWBzggjv63Vyd1VElX31agDJSjS84EQiJS1amF01Ylp4LB
 gS3S2eYw9tP7ZDJY0mgvDsdbwayHY/I/sjLZ+LFSdFxba4Qp/GpCDwANRhAYdbSlZS14mjL/Sdz
 pJWQwZ8GNG0
X-Received: by 2002:a05:600c:1d25:b0:49d:1916:2133 with SMTP id
 5b1f17b1804b1-49fbd1ccc32mr37876975e9.8.1789628215416; 
 Wed, 16 Sep 2026 23:56:55 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd256105sm47522705e9.14.2026.09.16.23.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:56:55 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH 1/3] binman: pre-load: Move signing into its own function
Date: Thu, 17 Sep 2026 08:55:43 +0200
Message-ID: <20260917065545.1989088-2-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917065545.1989088-1-lorenz@sigma-star.at>
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 13:41:10 +0000
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

_CreateHeader() signs twice, once for the image and once for the first
header, with the same key and the same padding. Move the signing into a
_sign() helper rather than repeating it.

This is a preparation for signing with an OpenSSL engine, which needs a
second implementation of _sign(). No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 tools/binman/etype/pre_load.py | 49 +++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 0d953cb258e..0cf635ab23a 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -86,6 +86,31 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
+    def _sign(self, data, key, hash_name, padding_name):
+        """Sign data with a key
+
+        Args:
+            data (bytes): Data to sign
+            key (RsaKey): Key to sign with
+            hash_name (str): Hash algorithm to use
+            padding_name (str): Padding to use
+
+        Returns:
+            bytes: Signature
+        """
+        hash_data = SHAS[hash_name].new()
+        hash_data.update(data)
+
+        if padding_name == "pss":
+            salt_len = key.size_in_bytes() - hash_data.digest_size - 2
+            padding = pss
+            padding_args = {'salt_bytes': salt_len}
+        else:
+            padding = pkcs1_15
+            padding_args = {}
+
+        return padding.new(key, **padding_args).sign(hash_data)
+
     def _CreateHeader(self):
         """Create a pre load header"""
         hash_name, sign_name = self.algo_name.split(',')
@@ -105,26 +130,13 @@ class Entry_pre_load(Entry_collection):
         if key.size_in_bytes() != RSAS[sign_name]:
             self.Raise("The key " + self.key_name + " don't have the expected size")
 
-        # Compute the hash
-        hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
-
-        # Compute the signature
         if padding_name is None:
             padding_name = "pkcs-1.5"
-        padding = None
-        padding_args = None
-        if padding_name == "pss":
-            salt_len = key.size_in_bytes() - hash_image.digest_size - 2
-            padding = pss
-            padding_args = {'salt_bytes': salt_len}
-        elif padding_name == "pkcs-1.5":
-            padding = pkcs1_15
-            padding_args = {}
-        else:
+        if padding_name not in ("pss", "pkcs-1.5"):
             self.Raise(padding_name + " is not supported")
 
-        sig = padding.new(key, **padding_args).sign(hash_image)
+        # Compute the signature
+        sig = self._sign(self.image, key, hash_name, padding_name)
 
         hash_sig = SHA256.new()
         hash_sig.update(sig)
@@ -142,9 +154,8 @@ class Entry_pre_load(Entry_collection):
                                    ofs_img_sig, flags, reserved0,
                                    reserved1, hash_sig.digest())
 
-        hash_first_header = SHAS[hash_name].new()
-        hash_first_header.update(first_header)
-        sig_first_header = padding.new(key, **padding_args).sign(hash_first_header)
+        sig_first_header = self._sign(first_header, key, hash_name,
+                                      padding_name)
 
         data = first_header + sig_first_header + sig
         pad  = bytearray(self.header_size - len(data))
-- 
2.55.0

