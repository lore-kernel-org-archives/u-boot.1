Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F29AC982D5
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF6AA60AFC;
	Thu, 17 Sep 2026 13:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSQyP-_3dibo; Thu, 17 Sep 2026 13:41:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A137160ADD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789652475;
	b=p/rnE9Ak+rhn6ppb3V4I5EVpJMfAvZHwZyhLu+Cl14fqUNqilcKnAuWQGE5hSLGucnQv
	 0Omd4GIKN9YKm/FwBsPeRbru1VFMGz2DtJsMVwnXrW8UkAAX4PuUtEbL+qhthjfC7DtD/
	 WgUdSqcG4YF7PU37NJOSqSIIFYNyd074GUXkKelxCE04utUZFWy2eDT6hsrcojMzR8JF8
	 UTk61UsmE+hYo9zTB7ALRdvfZQtPDWxejh3KWtBPAYdSrFGwKcwatwkXLl5aI+gK2x84y
	 ihcj1YvFmVmnklysqLyqX4GW7WNdrntYgjwqdpw8nsA43HyjJF7KWwhmx9g03wliNAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789652475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a5HCCLXXAiSm2m8UA4YHJrIo7KXaFeOsRHU8JRbdAEQ=;
	b=qwtcFlvpcdYLRPNF7GSpLwkpm78WAT427wGhUFeVaKNdRcVH64zw6MEdoYFdZDEJEzUd
	 p+lz9ICUib/0t8a2/nmuXrE30b+iRLXA52gCJe/KIOMOcPpjAVKvLywnhG9+E6r42F7Or
	 oHHjGNjejx+ePk97Sw/Q6Fnf7Cn9SXUGK1jAlBSd3dL3JSPiJ031cvsSwIRtgAX9wUCoE
	 curAxMo3e5LDQdfJpICuQiuIUgB5c81MZEspQHH5foQOEm4ORrwRPvf8n/Y9cNguq5A01
	 qOi3cWcae0fPFU/9vnfv7FXqbjsv3b+I8mfjRwtIVgKYwscVnLYY/D2sHVwZs7tSaYQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789652475;
	bh=a5HCCLXXAiSm2m8UA4YHJrIo7KXaFeOsRHU8JRbdAEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rz8N7T7+5PO1Qg99T0V6nY/Gr1srLtNkmsXpdPFQ4Zd+YC7QjEmedXpCuPOdG6/u4
	 whFWWbYm+O3pwAUJMwMzIEGTK48lz1Yxm5GzL0YNL/kvV40NLSf93/8Fj1rD0yvSzk
	 k/93ycTA2ej3uuXKH9slfItosQQP0BOBJxgNYcbaAm78SVLHPY4OQm6EZrl2gkBnrs
	 xRFtNHcBtsytZEKwArNenc9hD2xBxtGlonkUrWqrTLGPycrN+LxAN2vXvPkWhW0INl
	 vfxuApcMfQuM6cbkMC/EiqGYdaf+lkYbshqiPGPnuA0tslPqOjDKOL4rc/Qx0EEUUY
	 8cP9K+ydQxOuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A137160ADD;
	Thu, 17 Sep 2026 13:41:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04B2C422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEBB780A91
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJSEdhmDLcVY for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 06:56:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8963280C53
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789628219;
 b=nwLU4CXKMjgATfUSON0SwxuLdoME0u/QxXDaf56t1is3K/qADXWhHxGSvpK594Lcarzi
 DfgUEWP43ZCuF+mZBJi4eC/ATXr1c4/esCxdW8CNAiB04BXHVg5f7XaGR8Y25x9GgF6lD
 3zTeP1qQ9a4f/CFu6P1jQTM9N/5kX5SOBOL5dwrp0/gdD04jTk0nSSzVO6pyoIIiBjRq7
 O3334TIoOTBzdxHWfEQFeGkLnHRI1c83C+utS1buHj+LHekzrLHvkcmwg+GRUptdJT+JF
 jXYhd88yEnw9Sw//xszDIiaZRI+S8uYhRtoUOdY3ag+B9H4x9wX27i3TyYJ6s31s+rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789628219;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=a5HCCLXXAiSm2m8UA4YHJrIo7KXaFeOsRHU8JRbdAEQ=;
 b=RlBWTUS/+0IQmAa+b/kLuSGez/SHte9901rSy6XPgwqejNdN4x+Km/J4y1/huYjSHKbf
 sVzO8baVtBEUMBUhWbj71YaB7lTYOSvdRBVwIlC/lNZ6PzavsupJsHEWdq1O80twCZnBm
 eg2qECMMDsw4vATSblxnkF/cyWr4u37E5DW50jtpZIW4Kycao0YX3KAdJKdvA9pwWe5Hv
 0F/85kuIO+5yd1koZzu7eYVoUR1Sc2g+jG5hiELxpJ7chWEEfKKRgLZ+Jjk//+KhOimuU
 F6bUlYDeSVWdNOR57dbwDFJDuejbMt894GaNF0xyGJjXvdtLwL6KDos/P8DqXE5unKw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=sigma-star.at; 
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=BbGAE5KQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=BbGAE5KQ
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8963280C53
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:56:58 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so2415825e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1789628216; x=1790233016;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a5HCCLXXAiSm2m8UA4YHJrIo7KXaFeOsRHU8JRbdAEQ=;
 b=BbGAE5KQtozvT0gso29GeEsNc6af4/AIo8lQaVliMV+8PwjzwAEj8BWUndalqqO76Q
 g2GcY9QKy8CBLUSUfkCf3LpbLuH1F6EV+hzLoq583D7yc2BW03YE+sl6S1QhpcbuD5Dc
 3LpEhm+bx5TOAqLuaS8PbcbnMWR8wsDBy9vNyy+bAC0U/eLyZr43IG+kX+5uVFB7ijSU
 ySM/1iOxUbqH1pQcDkAEcKaHvt+601dC7zudtU0SnlG3jzWLeW+gChuFL0C8fE/zKJ5j
 E+X63URyEBKH6Vf8FBbdMQRT6HKRODXiuOdrUgO5A4E3JU6jnaMEL+A87WR1GfK/K/gh
 BCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628216; x=1790233016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a5HCCLXXAiSm2m8UA4YHJrIo7KXaFeOsRHU8JRbdAEQ=;
 b=td+0Zuqq5Pr7qGzSbLpvKAKmQu7JHUvUbiia5lqgzRSnGsjUJXuH5Ae5xzaTzEhztu
 KFZtJLNl00jjFQYU0t9RLmJZIP65Z3i+HQfTPaAzHQl7nZD24PlqczjMkn5NXt2lTTp0
 PQV47IVMoaE0bLz9h9O2hM/853w2aqIXaCD5DrGTcK3aSP0XWxdoXtx7AP6yf7GS1uB7
 YCXeN/aIhrpANFwOWPG5KPQWPz39bHDawft0RFrZsi5FvISaeCjp2/KGItZW0yhZ52K6
 1FAlLsh4TXl5XzTxe7OM7J3+aVzCEkMnLzGpSP2S1AAOmeLs7vy89nla+A8pNdhOPctp
 J26g==
X-Gm-Message-State: AFuF++m9gIauhIMcQEZqlGavGO40BQh1cYH/zjH/En91RoUK7NfVMqdf
 D8hmRMElgz5Y8d+YykGw4gCNMGfSpXN1hy9iYcUhtGYFPxeidhDX9+MmdhuDJRsBoFPXgcW5n07
 qDzJf2xMN1A==
X-Gm-Gg: AYBFou2EpfK9vAfqmn3mmkTrBnvBAw6M5T8yDKwY/E/EkpeBOtTfD+rRcAAT3rD4kb7
 nQ10I4jugEWK1Gl+ALlz27/02sXtL0d18Pr61lsnVSkd1bQMNDJSscpQWb1+WWzgkmKZ7Inih/K
 53ZTcBhZSfoochT8vOYdJgYULpBb8Dx2exceqMje66JouiB7JajUyLtn9hDjcnj4tXFXd1kGt6U
 Hw9+rey86Prj0zP/A7ZuQ0GAE5k7TSYOzx2gELVKD73/Wsc3laP/fjTTP/Y+tdQbcwxFhBK29LI
 eA8TCI0GCyqKzdiwiDkNJt089Z8B/uJqUTIzcG7a7QJxes4uW8xKr9ZEN4cjkeM04mC7TOrZyP1
 3hU3s7jMG0T/UpygCHKtvFL2eAcQP6bAqNOJKEzmYBxOc2X+B4P7L14/lz82powKr9T/HCES/sC
 j93UXEZKlyymQtiGocOUYT8OJPp5xb9nst9ndyA4n4rjUgTZYcFvkgubQ1dkBGvsh9PcgggcD5V
 HkqkG55D20=
X-Received: by 2002:a05:600c:1986:b0:49e:70b2:66ab with SMTP id
 5b1f17b1804b1-49eac40f67emr70464225e9.0.1789628216160; 
 Wed, 16 Sep 2026 23:56:56 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd256105sm47522705e9.14.2026.09.16.23.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 23:56:55 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH 2/3] binman: pre-load: Allow signing with an OpenSSL engine
Date: Thu, 17 Sep 2026 08:55:44 +0200
Message-ID: <20260917065545.1989088-3-lorenz@sigma-star.at>
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

The pre-load entry type imports a private key from a file and signs with
Cryptodome, so the key must be readable as a file. Keys held in an HSM
or on a smart card cannot be used. The FIT entry type is not affected as
it delegates signing to mkimage, which signs through the OpenSSL engine
API.

Add an optional 'engine' property. When set, sign with openssl using
that engine and interpret 'key-name' as the engine-specific key
identifier, instead of reading a key from 'pre-load-key-path'.

For the pkcs11 engine, expand a 'key-name' that is not already a PKCS#11
URI to:

    pkcs11:object=<key-name>;type=private

With an engine, binman never loads the key itself and so cannot check
its size before signing. Check the length of the resulting RSA signature
instead, which is the modulus size either way.

Behavior is otherwise unchanged when 'engine' is absent.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 tools/binman/btool/openssl.py  | 28 +++++++++++
 tools/binman/etype/pre_load.py | 87 +++++++++++++++++++++++++++++-----
 tools/binman/ftest.py          | 12 +++--
 3 files changed, 112 insertions(+), 15 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..20e4e16e537 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -36,6 +36,34 @@ class Bintoolopenssl(bintool.Bintool):
             name, 'openssl cryptography toolkit',
             version_regex=r'OpenSSL (.*) \(', version_args='version')
 
+    def sign(self, input_fname, output_fname, key, hash_name, padding_name,
+             engine=None):
+        """Sign a file
+
+        The key is a filename, or, when an engine is used, anything the engine
+        accepts as a key identifier, e.g. a PKCS#11 URI.
+
+        Args:
+            input_fname (str): Filename holding the data to sign
+            output_fname (str): Filename to write the signature to
+            key (str): Key filename, or key identifier for the engine
+            hash_name (str): Hash algorithm to use, e.g. 'sha256'
+            padding_name (str): Padding to use, 'pkcs-1.5' or 'pss'
+            engine (str): OpenSSL engine to use for signing, or None to sign
+                with a local key file
+
+        Returns:
+            str: Tool output
+        """
+        args = ['dgst', f'-{hash_name}', '-sign', key, '-out', output_fname]
+        if engine:
+            args += ['-engine', engine, '-keyform', 'engine']
+        if padding_name == 'pss':
+            args += ['-sigopt', 'rsa_padding_mode:pss',
+                     '-sigopt', 'rsa_pss_saltlen:max']
+        args.append(input_fname)
+        return self.run_cmd(*args)
+
     def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
                   config_fname):
         """Create a certificate
diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 0cf635ab23a..e6842732a59 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -42,13 +42,21 @@ class Entry_pre_load(Entry_collection):
         - content: List of phandles to entries to sign
         - algo-name: Hash and signature algo to use for the signature
         - padding-name: Name of the padding (pkcs-1.5 or pss)
-        - key-name: Filename of the private key to sign
+        - key-name: Filename of the private key to sign, or the key
+          identifier when 'engine' is used
         - header-size: Total size of the header
         - version: Version of the header
+        - engine: OpenSSL engine to sign with, instead of a key file
+          (optional)
 
     This entry creates a pre-load header that contains a global
     image signature.
 
+    If 'engine' is set, openssl signs with that engine, so the private key
+    does not have to be a file. With engine = "pkcs11" a key-name that is not
+    already a PKCS#11 URI becomes ``pkcs11:object=<key-name>;type=private``
+    and pre-load-key-path is unused.
+
     For example, this creates an image with a pre-load header and a binary::
 
         binman {
@@ -69,6 +77,18 @@ class Entry_pre_load(Entry_collection):
                 };
             };
         };
+
+    With an engine the key is named by an identifier rather than a file::
+
+        pre-load {
+            content = <&image>;
+            algo-name = "sha256,rsa2048";
+            padding-name = "pss";
+            key-name = "pkcs11:object=preload;type=private";
+            engine = "pkcs11";
+            header-size = <4096>;
+            version = <1>;
+        };
     """
 
     def __init__(self, section, etype, node):
@@ -78,6 +98,7 @@ class Entry_pre_load(Entry_collection):
         self.key_name = fdt_util.GetString(self._node, 'key-name')
         self.header_size = fdt_util.GetInt(self._node, 'header-size')
         self.version = fdt_util.GetInt(self._node, 'version')
+        self.engine = fdt_util.GetString(self._node, 'engine')
 
     def ReadNode(self):
         super().ReadNode()
@@ -86,18 +107,49 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
-    def _sign(self, data, key, hash_name, padding_name):
-        """Sign data with a key
+    def _sign_engine(self, data, hash_name, padding_name):
+        """Sign data with an OpenSSL engine
 
         Args:
             data (bytes): Data to sign
-            key (RsaKey): Key to sign with
+            hash_name (str): Hash algorithm to use
+            padding_name (str): Padding to use
+
+        Returns:
+            bytes: Signature, or zeroes if openssl is missing
+        """
+        key_id = self.key_name
+        if self.engine == 'pkcs11' and not key_id.startswith('pkcs11:'):
+            key_id = f'pkcs11:object={key_id};type=private'
+
+        uniq = self.GetUniqueName()
+        input_fname = tools.get_output_filename(f'pre-load.in.{uniq}')
+        sig_fname = tools.get_output_filename(f'pre-load.sig.{uniq}')
+        tools.write_file(input_fname, data)
+
+        if self.openssl.sign(input_fname, sig_fname, key_id, hash_name,
+                             padding_name, self.engine) is None:
+            self.record_missing_bintool(self.openssl)
+            sign_name = self.algo_name.split(',')[1]
+            return tools.get_bytes(0, int(RSAS[sign_name]))
+
+        return tools.read_file(sig_fname)
+
+    def _sign(self, data, key, hash_name, padding_name):
+        """Sign data with an engine or with a key file
+
+        Args:
+            data (bytes): Data to sign
+            key (RsaKey): Key to sign with, None when an engine is used
             hash_name (str): Hash algorithm to use
             padding_name (str): Padding to use
 
         Returns:
             bytes: Signature
         """
+        if self.engine:
+            return self._sign_engine(data, hash_name, padding_name)
+
         hash_data = SHAS[hash_name].new()
         hash_data.update(data)
 
@@ -115,7 +167,7 @@ class Entry_pre_load(Entry_collection):
         """Create a pre load header"""
         hash_name, sign_name = self.algo_name.split(',')
         padding_name = self.padding_name
-        key_name = os.path.join(self.key_path, self.key_name)
+        key = None
 
         # Check hash and signature name/type
         if hash_name not in SHAS:
@@ -123,21 +175,28 @@ class Entry_pre_load(Entry_collection):
         if sign_name not in RSAS:
             self.Raise(sign_name + " is not supported")
 
-        # Read the key
-        key = RSA.import_key(tools.read_file(key_name))
-
-        # Check if the key has the expected size
-        if key.size_in_bytes() != RSAS[sign_name]:
-            self.Raise("The key " + self.key_name + " don't have the expected size")
-
         if padding_name is None:
             padding_name = "pkcs-1.5"
         if padding_name not in ("pss", "pkcs-1.5"):
             self.Raise(padding_name + " is not supported")
 
+        # Read the key, unless an engine holds it
+        if not self.engine:
+            key_name = os.path.join(self.key_path, self.key_name)
+            key = RSA.import_key(tools.read_file(key_name))
+
+            # Check file-backed keys before attempting a signing operation
+            if key.size_in_bytes() != RSAS[sign_name]:
+                self.Raise("The key " + self.key_name +
+                           " don't have the expected size")
+
         # Compute the signature
         sig = self._sign(self.image, key, hash_name, padding_name)
 
+        # An engine does not expose its key, so infer its size from the signature
+        if self.engine and len(sig) != RSAS[sign_name]:
+            self.Raise("The key " + self.key_name + " don't have the expected size")
+
         hash_sig = SHA256.new()
         hash_sig.update(sig)
 
@@ -171,3 +230,7 @@ class Entry_pre_load(Entry_collection):
         self.image = self.GetContents(True)
         data = self._CreateHeader()
         return self.ProcessContentsUpdate(data)
+
+    def AddBintools(self, btools):
+        super().AddBintools(btools)
+        self.openssl = self.AddBintool(btools, 'openssl')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a0e8bde7901..63fbf50089f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5888,12 +5888,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
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

