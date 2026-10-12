Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007CCCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 12:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EED380DBC;
	Mon, 12 Oct 2026 12:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vgHqJ_c0AAjc; Mon, 12 Oct 2026 12:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0366D80D6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791808614;
	b=lmQqFGy57b7nbYK0gT5G2h61GITt8WwPt4yUFFjCKKfSXe+CAm0dZhjbQWMOXFgAhbGH
	 pHRmo+JDGCNt0ojWeyqskgQLLtwqjNsaOv0M5LEuDUiyKh3AE3jThvWKpcnd8Brv/M+kM
	 x7GXGU79MzS6uawUaeKmZAUbU1M6MGCZXURtHoFNZC2IXG5DnOgGF+nX1qYHKoZygRW1Y
	 fV5J6Z/5fwWW6vbkfDOTRIPPlCWjqcmMAOCi3YaopBVaVyaJYt87gd23TqxWNUH1edF+A
	 cBJ+Ya99urfukqej3LJfKIFgkZKd7xv56AHZo2/PRsnJFuWzOote6nWLLidaLPQLwkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791808614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jt5gkF7AfI5+QAeefbr6Yek0ZVjRuL+v5vIr1O7DBBI=;
	b=sAfXZPlHnFivzYjB4/1JBtSW3lfv0ZZRfqtFzXg6mx9fh+RcpwiGMnWn3xkpgzoZMNc0
	 6fc3ckyYCbDbJMQ5Xaa2lLT5UC/ZNC0FPmgr90b9sWWtaYXfnynsSBRh4AeBZ/9TAbjaj
	 HCiNeyfevehwEiw72kRv30LfQWW6dHV1y3kAAD2nEhUwpuG+P9lrda9yn+C61ez7rzJEr
	 B21XuciMlul1C9OTQ1xjebGuMZryC667fxR0K8p1KG/aoxBNknnSUUE0/T336io7QF42+
	 rZujB442UiWj4WkPPfn54YYLKU9DPERY5c2KdE3bTGZw8fttt/iQIt5duqyKfBJj8bQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=sigma-star.at;
	dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=OlQ37bTQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791808614;
	bh=jt5gkF7AfI5+QAeefbr6Yek0ZVjRuL+v5vIr1O7DBBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NDir509SFi3ZssjeBrhyWGuQLONskZazTwLC74A60wIUwWDLydl5KGLfsU951eyTi
	 wtGhukrjufDi/iWPrWpKtwfhekn6/G1ag34uTOlfgrJnofYAj8WMdiL3LXm1kZBeAj
	 wg0cDfaK84hac3TV+WtmUASGubB2UuEccML0zZyDIQ3ggg11uvWQX6E1TekYa15n9y
	 u0aYIOBWjbX6UcZWUO5eWOPNNsEMbV+Gm1+O5YYx1cPi0jFlTZHbFxqT737g2M+qKG
	 +CVJc7TAP4C4MYDEXPCdZmXm5LD9BjUEvbata+87CbS5n2XVON/I9ITFDWVHG6SZin
	 gVfrNsgu8X7ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0366D80D6A;
	Mon, 12 Oct 2026 12:36:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 760A6194
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73EBE80CB1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5WOX8bEH75W for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 10:11:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A16F380C9C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791799862;
 b=BDvVYLy+naN7BFphGPy8WtyQr0ASnEtJ697jMHPnixjxFPYu8b/kYVe+FFHyT6PdacKC
 p1vxwhYbg3GGZNl3hlcRXXUt0AXnf5mrncPtgznJ/FAJwHZu6nP4HKe5f1Rp6kGkZe9+v
 El7RlXFebhGaeaLrP/0sqo7weVx0y/VZN7YykoM/HGnMAApKRpSyfFU8jf96YjsUH5AZi
 Ir6W0quKIEL9biCdZIxAFQSP/SPiWmlM+HrKrIFgn+fkmPymV4T8B+KKjv5+lZzddutOU
 7QJrd0GP8IQPFwrw/KmPArrRrfWlBQKBeNYJvXo6gGvS9i7vMizOlr69FlVSsB+EQQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791799862;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=jt5gkF7AfI5+QAeefbr6Yek0ZVjRuL+v5vIr1O7DBBI=;
 b=c+rUyXHyLGAQvXGQUawJo8jEz9AVzEnHZke9yAzzd1/zd4gUtXKqM0Aq+xpjP++1IfQq
 SW8DQddaDeYgnltgzHsPv1Bwt1yS3Z9gMLVizXsMcFlZZQImhvlun5yfpGcyTLyND1FP0
 PkQomJWwsbmzwBsLoUJI2spqxqB+WBSA5ESk6qLNT2mzoYFmERc3KqY0GpOF+5AxYngD/
 mXN+SaOALNex03vsAZ33qafn4rkkzFcJ/zcxn7SyHWxCcWipCHFkvzHPfx2pcHfqxdEKM
 qofV/YXKDVP+sR/VUMwHIbBqWlgMVYKq1F6s7/gh41VTDX8l5uAp/CEpeb6XcDgBj7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=OlQ37bTQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=lorenz@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=OlQ37bTQ
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A16F380C9C
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:11:01 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so801722f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1791799859; x=1792404659;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jt5gkF7AfI5+QAeefbr6Yek0ZVjRuL+v5vIr1O7DBBI=;
 b=OlQ37bTQtf/KYfx0VdVLNR/wApLfyhlIOz/wWgjHi/fxZVx+KGSOaALxj6v7qYGfoJ
 nlcIQZShLISHMEicASKPalUf9C1Vsqzbe4Na1OGhPfUB/gBmjVs+QGlnjymdFjtVvKPk
 9SylVrL4GUOmYa24LN7h4aClVKpLauDKqvVquWiCQMCmCx7j8BQMOTJoVB7X3yy3LFw7
 92SlR4bGem4s4sechABwQQlZlQbbj4i56JyNYab6YWaxdu1klMTee3gdOmwmEhZA+cKz
 aO7IrhQxEX6ItLEqCOjjgYz0Cv8zrQP7hqYS1iPT3Oz2Dabx42kRv1bGeUrjTkQDt+mR
 ZfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791799859; x=1792404659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jt5gkF7AfI5+QAeefbr6Yek0ZVjRuL+v5vIr1O7DBBI=;
 b=VMK8U01kqnYaZ0bA5ol08r9UBudgvpPB4ImfPpv7cPlSeAAtFma1wcWqkFdwFdycei
 if++oj36sDoX0ZvJ9JreDl7A91sGQ1IeGEgbNk5lvsoyESn/7lYY2WHlENaq+pF8Yt0z
 auhzvqiGRnJU/DUbDkC1ZrtWKxJMUV9f7I8gFYg61STHPunIKwtmuxjBbbPLuxWZH0/8
 T9U/AsbZsHBA2z8GaIY28Dxa3sDGdymXLFZhtWrhBGe6qi5hemOJeZmP+nXPFZfl3Rkj
 qqUeTWleu8uA8bPVXyafv2bUzqDZzqH1cjTCxQS+sYmu+B53srZTGiM74+okmqEfCduA
 XwPw==
X-Gm-Message-State: AFq9FYJEp5w90M2JNWOQCJMuVYdhEU7NTKDwI0jD6yTz4PcriiILtydG
 175ecQVo5xdPx7D0diiQ06jcWcKN6Vtc7Op5aS57uZYO/Fh/1rjYu8kvFvGYR/gwjOuv4YMbnhz
 IkBx0hSuTgg==
X-Gm-Gg: AYBFou0+BFo2rDDMVzESGaDpLydSrVWRs/RJ8Zs8HXAeNr/fB8b3yC9OaHbKPYXA6Y8
 vRBXno4PeGxnWmF0dULPdUjazIMbiDepxz5FbvYor3NHrhvc+CFm1W+htFjligHBXwHxvnCtTZt
 q9u38LpXHaIoWPH6KeW1qgdqgqHGBdQdt0F2g/tsK6+Beuba/4FP5n17kLEd3nT2qdJ1GWhCEA/
 QLqGi22Dt6t1juXWX6wLq3CjL2iV5Xqp/ZrPuixPM//tnS7Evzw+mOPjq2C9d9nUgXBHccRn36D
 ej3iKF+mYJmNIA0ztWi7b36ejCYgotiaEQuCiD8vUIr31ymqfZ9/ksex7doGVn241IAMOv+8+zX
 0AylA8OBjCf5mtrCgRZk3rlvSgkeB5nrGAQWCmWX5PRcD4kjQjFF9SJ4yot23O6SaEaqS/PAOHN
 +hT40d1Pmq5LpwJjscwzj801HZ48MXqrRyh4aScPQGbnUS4kBwVzf5tfmGiEKnPoywntTqth8Zr
 s9KN/YG6xPRjf/qtz/o
X-Received: by 2002:a05:6000:3102:b0:48d:ca32:e90f with SMTP id
 ffacd0b85a97d-48dca32e9b5mr9487288f8f.55.1791799859014; 
 Mon, 12 Oct 2026 03:10:59 -0700 (PDT)
Received: from losig.fritz.box ([2a04:9546:1c54:8601:c375:8df8:9c4c:d013])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abd57fsm18064559f8f.37.2026.10.12.03.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:10:58 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 upstream+uboot@sigma-star.at, Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH v2 2/4] binman: pre-load: Allow signing with an OpenSSL engine
Date: Mon, 12 Oct 2026 12:10:52 +0200
Message-ID: <20261012101054.2104707-3-lorenz@sigma-star.at>
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

The pre-load entry type imports a private key from a file and signs with
Cryptodome, so the key must be readable as a file. Keys held in an HSM
or on a smart card cannot be used.

Add an optional 'engine' property. When set, sign with openssl using
that engine and interpret 'key-name' as the engine-specific key
identifier, instead of reading a key from 'pre-load-key-path'.

With an engine, binman never loads the key itself and so cannot check
its size before signing. Check the length of the resulting RSA signature
instead, which is the modulus size either way.

Behavior is otherwise unchanged when 'engine' is absent.

Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
Changes in v2:
- Reject a missing engine key-name before attempting to sign.
- Remove automatic PKCS#11 URI construction. Pass the engine key
  identifiers unchanged.
- Explain that, when OpenSSL is missing, _sign_engine() returns
  exactly RSAS[sign_name] zero-filled bytes so binman can report
  the missing tool without failing the signature-size check.
- Move the change to the testPreLoadInvalidKey() test to patch 1.

 tools/binman/btool/openssl.py  | 28 +++++++++++
 tools/binman/etype/pre_load.py | 88 +++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 12 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index b26f087c447..20e4e16e537 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -36,6 +36,34 @@ def __init__(self, name):
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
index 0cf635ab23a..d3687ebebc9 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -42,13 +42,20 @@ class Entry_pre_load(Entry_collection):
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
+    does not have to be a file and pre-load-key-path is unused. With
+    engine = "pkcs11", supply a full PKCS#11 URI as key-name.
+
     For example, this creates an image with a pre-load header and a binary::
 
         binman {
@@ -69,6 +76,18 @@ class Entry_pre_load(Entry_collection):
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
@@ -78,6 +97,7 @@ def __init__(self, section, etype, node):
         self.key_name = fdt_util.GetString(self._node, 'key-name')
         self.header_size = fdt_util.GetInt(self._node, 'header-size')
         self.version = fdt_util.GetInt(self._node, 'version')
+        self.engine = fdt_util.GetString(self._node, 'engine')
 
     def ReadNode(self):
         super().ReadNode()
@@ -86,18 +106,45 @@ def ReadNode(self):
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
+        uniq = self.GetUniqueName()
+        input_fname = tools.get_output_filename(f'pre-load.in.{uniq}')
+        sig_fname = tools.get_output_filename(f'pre-load.sig.{uniq}')
+        tools.write_file(input_fname, data)
+
+        if self.openssl.sign(input_fname, sig_fname, self.key_name, hash_name,
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
 
@@ -115,7 +162,7 @@ def _CreateHeader(self):
         """Create a pre load header"""
         hash_name, sign_name = self.algo_name.split(',')
         padding_name = self.padding_name
-        key_name = os.path.join(self.key_path, self.key_name)
+        key = None
 
         # Check hash and signature name/type
         if hash_name not in SHAS:
@@ -123,21 +170,34 @@ def _CreateHeader(self):
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
 
+        if self.engine and not self.key_name:
+            self.Raise("key-name must be provided when using an engine")
+
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
+        # If openssl is missing, _sign_engine() returns a placeholder through
+        # _sign() containing exactly RSAS[sign_name] zero-filled bytes, so this
+        # check passes and binman can report the missing tool later.
+        if self.engine and len(sig) != RSAS[sign_name]:
+            self.Raise("The key " + self.key_name + " don't have the expected size")
+
         hash_sig = SHA256.new()
         hash_sig.update(sig)
 
@@ -171,3 +231,7 @@ def ProcessContents(self):
         self.image = self.GetContents(True)
         data = self._CreateHeader()
         return self.ProcessContentsUpdate(data)
+
+    def AddBintools(self, btools):
+        super().AddBintools(btools)
+        self.openssl = self.AddBintool(btools, 'openssl')
-- 
2.55.0

