Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89861CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 342F080DA2;
	Mon, 12 Oct 2026 12:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MY5Z7iQXMXvx; Mon, 12 Oct 2026 12:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44E9180D6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808612;
	b=ac4vJpPju5+gnBvorudKBYdOH2ehApS+x6B++QXB1HqzUqCCGsT66DIDLypC/Kx/i2hO
	 MFQlox+EgLUPCQp6Ua/lc2mCFUcA0BcuJTicinUtTmUXW2AeVzNwAQimcvf+ge2d/3yGI
	 HT9OCaB9ORreiZGxJJbSMq5XZrDOecJ3ZY++fuECusvxS6C/RVNtoN310lCOChMOxPMH/
	 kWO4IG0tDlse3z62NerKZF635EjVIInuz2iquEzEFFpSBHAqvAqS850rIm43bnEGHzCaV
	 X0yxHHdecmr8BaKUIxFdjNZV6wQu8EQ4jFyWlAS2N9Fraxqv3Ax2JiO9MmWWdhmsZog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SaBp2qo8pE6qalgIzwopZw50KZN4uPKoW3keE4UyZXY=;
	b=tOd/Ym0XjPPSBUYsFWN4xCjqE8fHaTjzYp84ErbPtdXousm7ham4wnkQAW1VpZDSIk3N
	 faXCm+xZJJOl+ZwRmjFumg8m2TX9QKXuNyePKmOvx3uHOI/cRrTVX4/zC2hqALpW1MN69
	 7qigyfwZf7lB0z5v9SNAgst/Fac+06JRT2Qxpw6/i6S5guGJ17m32VS3P87EGk1vCmjkR
	 IHuDONfi9fLcJptIKtjopYDWY+DJFzzSVHV4ncCpafAqhmA2NrUI1zIqY8G8FOHKHGOn5
	 gVGE08v72ZPmRsw3DoTUUAp9YYPVHNSrBcglJE2bVuxB8Tcy5VAEQ/U3AT1heLM2gGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808612;
	bh=SaBp2qo8pE6qalgIzwopZw50KZN4uPKoW3keE4UyZXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C5DpbAp3vOpswLNQXnBsreRkExW6Rrs7Iw6OzmEQlH32hw/ZV1Vpwnq44wGZs1Sec
	 fRcnmo/+1bOc2xFM3U/HcxQIu9uZGyjh8c5joXR/wG9UubYI89Qpym+Ygd166iDKXc
	 SOU8atq9WYW9ozU37sO9phONUhrv9RJJWisD7SwEkGz8KWFsiCTTdGN8ZzeChtfqoj
	 eqwUhHA/lMN4atrUh+iLjG554OnrATupskQZiyaQxlF0/f1Mqsrgcfw+psaWDrSF8m
	 lV2+WVy+9uPebF6D5DeBhEu9+zSHFsl8fKcLjD4CUFWgQW2XwiCA9wcEHkKv/tMHyh
	 UxBdcUY3S7R2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44E9180D6A;
	Mon, 12 Oct 2026 12:36:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F46275
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80879605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qrxBoxwHabsL for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CBC0B605EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791799861;
 b=lCODXKtAsxbKjNju+usBz7TmBBmisOfYqve00sj25+y9hB5YH/SV/Svkq8tq3aYZC1Co
 Iz2Vx09UaNA3PiyNbQmKFPy0PFAwD/35wF3OXJXFqXVBpOJt0nwBnObPqLazFMhsxypC7
 Gm00FxZZUGNyjqm/b+t4qThigSvvI6O18MHmnXhPl5WaLxJocDGepYDP3hwAJ9pubVgn1
 4509WJfPIL/PokhLb/F5wrVjoRKwA5qhP2mGL7XM4IFTW44FjuWInFx8lIB4jQgw2yNGw
 B+vJaUJht28XoAWaXrTbkejPbf3IJSWJPTaD00qPb7ndqNTxAfFMgxdOqYcaU2VbRBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791799861;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SaBp2qo8pE6qalgIzwopZw50KZN4uPKoW3keE4UyZXY=;
 b=PI028J6bkRpV5+JgzwX9OSvKVoTTJIocLmD8bAXErNk5h/HfYHoLTizAD7kMOlDrddUS
 WNsThvdEXC/E7JAAtrVGr2usY5PsWzyqD3xx3V6Rdn0yJgnMHP9byj6YYdpmMecVpaIZm
 8UvdDndpDc1OJq3aii3JV65PNetsPOInFlUhEH8VlI8VD1NzUnNo4o3zU4+foLF/oVnUs
 md6IkR4rZxpLYJsZP5HC0ARtjtQFUruG03V/FdosynKTFAaBE50YU7sW9hg6C+DJ4TYy2
 yOafQOxzwa+ZZm/jp63WJspthoX+/1rs5C50/H5ONS6YYQ0D6JckHD4rtJn5x3fgSxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=k9nxhPM5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=k9nxhPM5
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBC0B605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:00 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c02782159so989376f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 03:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1791799858; x=1792404658;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SaBp2qo8pE6qalgIzwopZw50KZN4uPKoW3keE4UyZXY=;
 b=k9nxhPM5D1JBRCaKvHM3HcKE3bkRf9NESuXSojxr5UmTaHbFs7wWa7pK//L89LU3zU
 xf+sjSJ9j/VEW7AOuctV9AiJBP9AZ6gcvblqqpwSXdUT569cIAwuZd9zG1oK/gSnCG8e
 XQYTi9NXNps0Qb0rJNY292gBAQWKyOkrxQ3N3Vihv4YOF9vMKNC61KhHQmqDuHn2mdUR
 gLmMyTh+0SIEhzGyn5T69bvoITRS1zRXtrwjRONaftYSwwKwB886dCSS382AXEI4EiD2
 r7JT5gkoHqyI3un2nqHBinA76P/Xri837fkisZzcGDrLiIduG2okrnS29lwzC3IXsVqo
 Ap2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791799858; x=1792404658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SaBp2qo8pE6qalgIzwopZw50KZN4uPKoW3keE4UyZXY=;
 b=OznXRJDs6FyvFD7aP+e2Ks/MMmoXm2Mk1RonVkCBrcc6ZV58wL3paOUOCTbo811/05
 EvZNcQiwTFbAmHljMSmPABi1v2XpASJDUyJspzi+a6peGdE9q+QdN4zVJ1CZ+6jwIihZ
 /odBPs7Thp6CXYaHDn1PlE/n75H/aQPcu9/43dNoxrE/XExJ9S+wv/GluU1yycCKK8kW
 T3l/1beRONEoVB24xEZeS2wCNRuc/FfpneMmJH9abCpzk+YYBsBqdV8k+kwzGtUe0Zwg
 0jbYfRVagUtgnTJKiSY/cs+MslGCoH7xol4bMgSpBuFXUtJgrbDb1ONK0cyqQxbKkRp3
 jdVQ==
X-Gm-Message-State: AFq9FYLLRqVRSDaaVIR6lNZ1MCewtTerzUPIxhX5t5RYJfdYTpsICORZ
 HWXoaozkyy7eIa1T9WJETBDBc15JRiXV9Bqwc2lz8ErIsIu2/UDrAMcaYK+PCl/Oyx/AovuY7P2
 T+Pw/Bhg2/w==
X-Gm-Gg: AYBFou1p4ie4reYgs4zFgCH2S1Em0WyyPH92d6OYCi20YPmbR4EF8M+ZJmCvn0ry3Wn
 +jm7cWBh8kC0Fv2ArPUFvwdQxakdsNnQokfcmz4fVUkY3hxIiCOE5KjdWv3lC2bUCrkCO4bT8fM
 kf+KwcGl9xNW9YA7Ww5asH/bWsv5IfODU9zQDZJGxYWYFrJqNG21fnJ6O+Y5/JcFKiTp5RfvlaU
 4ASpdi1zSvyW1JvTe5ZG4g1SfA6VqP8ggLxaTtGEzcCNLXfuwK4xwbEv6AQ/DwRiAEJQDmuAvs/
 Ntk0MZnSFGqC2jwWAltEZ/pO2SeD6Y0IfgTvPwsHdxgJtQ4SgpSwAeQ9gE1jMbqBVdkROjlO9RN
 PlmvcCjF7hCV+h/ZDIDxd3KmW+f1Qy2Mwdll6qkt7LuVPFSmcs3yEbmyWVft6BxwsTXCdZ1Vxja
 2T0BUMc3Fam/imeC9Dx3FGPLBw0/8quFdOIqYQHPR+5nntyhTL4Lit1tj0FD9vxSfKgbC9wkXwq
 53jt28Nmw==
X-Received: by 2002:a5d:56c3:0:b0:486:f97b:6412 with SMTP id
 ffacd0b85a97d-48dbaceb3c2mr12635645f8f.46.1791799858193; 
 Mon, 12 Oct 2026 03:10:58 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd57fsm18064559f8f.37.2026.10.12.03.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:10:57 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH v2 1/4] binman: pre-load: Move signing into its own function
Date: Mon, 12 Oct 2026 12:10:51 +0200
Message-ID: <20261012101054.2104707-2-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012101054.2104707-1-lorenz@sigma-star.at>
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
 <20261012101054.2104707-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 12:36:48 +0000
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
header, with the same key and padding. Move the signing into a _sign()
helper rather than repeating it.

This is a preparation for signing with an OpenSSL engine, which needs a
second implementation of _sign().

Adjust testPreLoadInvalidKey() test to verify that signing is never
attempted for a key with the wrong size.

Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
Changes in v2:
- Move the invalid-key test change into this patch to verify
  that signing is not attempted for a key with the wrong size.

 tools/binman/etype/pre_load.py | 49 +++++++++++++++++++++-------------
 tools/binman/ftest.py          | 12 ++++++---
 2 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 0d953cb258e..0cf635ab23a 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -86,6 +86,31 @@ def ReadNode(self):
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
@@ -105,26 +130,13 @@ def _CreateHeader(self):
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
@@ -142,9 +154,8 @@ def _CreateHeader(self):
                                    ofs_img_sig, flags, reserved0,
                                    reserved1, hash_sig.digest())
 
-        hash_first_header = SHAS[hash_name].new()
-        hash_first_header.update(first_header)
-        sig_first_header = padding.new(key, **padding_args).sign(hash_first_header)
+        sig_first_header = self._sign(first_header, key, hash_name,
+                                      padding_name)
 
         data = first_header + sig_first_header + sig
         pad  = bytearray(self.header_size - len(data))
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 2fb452b4e46..4002f6837f4 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5903,12 +5903,18 @@ def testPreLoadInvalidAlgo(self):
 
     def testPreLoadInvalidKey(self):
         """Test an image with a pre-load header with an invalid key"""
+        from binman.etype import pre_load
+
         entry_args = {
             'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
         }
-        with self.assertRaises(ValueError) as e:
-            data = self._DoReadFileDtb('security/pre_load_invalid_key.dts',
-                                       entry_args=entry_args)
+        with unittest.mock.patch.object(
+                pre_load.Entry_pre_load, '_sign',
+                side_effect=AssertionError('signing should not be attempted')):
+            with self.assertRaisesRegex(ValueError,
+                                        "don't have the expected size"):
+                self._DoReadFileDtb('security/pre_load_invalid_key.dts',
+                                    entry_args=entry_args)
 
     def testPreLoadEncryptedFit(self):
         """Test an encrypted FIT image with a pre-load header"""
-- 
2.55.0

