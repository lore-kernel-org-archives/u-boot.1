Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748BACD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9BBA83FEE;
	Sun, 14 Jun 2026 18:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vsn8zOl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8BA84841; Sun, 14 Jun 2026 18:01:38 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5124083EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-691c5776f35so3923571a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781452896; cv=none;
 d=google.com; s=arc-20240605;
 b=a8Ebm+6qbaGExKT0/XjU4yr3iWzqcm1M1fbOubqzZ3tlhPTxHltPh2GjQz5if04+rC
 2Z8SwXIYxSVJsI2qPOHIZxvGVS0YGdRTsxSdP8dgZdUnLvG5Ohswt6zhR/m5PZigQ7vJ
 1Zd652/I8bLBO08oIJylUUMiboNS/tKtQwP85XAt/F3s/XSb1Xpl9Sq1AVVxIyKjC9Ho
 GkndvxvMhui++4Bff/iS+4v0+diOaIdnq9Cgx5Cz7oSpFanluXQM/5SeRBX+vA2bCvjE
 6Wa2RzVodPZrveDBgTDMjssG0HWEUnUqWVEMUhJoSSNgU7kypmviAOjwKHdWdyN3fR7L
 ZIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zYNs+6uItmzlrI65gMGLvkRHzev1NpEYANLsdt2H9NA=;
 fh=5DvzkQXSYA0JfKNvC4+WY/n2kShyZ68z+gtBt2ADqHY=;
 b=aHZ1DPvBNA8RrCOQgDSEgbp7TaxPkIWle1HTRl1EwWqxN3akgxeLOOK2rk9mnYohDp
 Co6orMHDcJvC40Kwr28KI7vjosNVZNIU2nq9tSl7gMkACYw4/5JYmfBZGT6pti9jpXwV
 geF0BfeM+gMEoZ7249k6AP0kJD8NabK34zfIAijtSTqLw23xx+8clQ9HSpH7Qp/i+v6A
 Thb15sm4XUbSj6zCMn/qRul9JbTUhMUJxVuDbgjzt4Id1NzF+yBTpbpeegqewM4FVwzv
 3qD86S2CpMSITp8PsVzXX8rVH8EH75QxoxVQpIs3mDCS1HCco2Sg4TWmwBf7LoLvtWEz
 OCdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781452896; x=1782057696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zYNs+6uItmzlrI65gMGLvkRHzev1NpEYANLsdt2H9NA=;
 b=Vsn8zOl4McBT6qC9rZ91pKbCFT5UpYZ2qYg+xfOkRRDX7BIXkclE1v/fUXbpUJSi4R
 Jh03XR2joRfHJEdxfBlK+jYADDMRNvVcckDtqNv6jKhAaXWrs3xleyDBSFbuMyPYJjiT
 qIGYfN5clsK1ZeXfs5/xrWcsrrnlKAnkkoeaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781452896; x=1782057696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYNs+6uItmzlrI65gMGLvkRHzev1NpEYANLsdt2H9NA=;
 b=RbmZxQl6vV6WelAvmJFZ0H6zz7EpgSWF7fRIucA2nbLwWxUbrrC2vsFq8xKA/wCTW2
 yXl3ndPcvtrgZDJAnir50aJPfIiI1vc0cvzZ7z34HL3euQlk6Xn2zSVa677JKu1XuOi6
 Z1Vef1MDYFDnvMY/UUn5GBKXfBfjWkWgQhToTGIo4X0v3nqFfthTc4YvXhrvZjd9LHVe
 4hFWY4TP5LNWYku27Ikv7qbPFoKl7OYLjKAVpTbYn5EGijKmNdytha9WMb3m7kQX0uB4
 0YpvjGjICgM4X09YTFDIv2ivxgiftGD4OzH+HOkpXUcgOjGgfmdGrn5K7eThCNGYWYE/
 Hr+Q==
X-Gm-Message-State: AOJu0YxValAHwMTiMgvoIhJxWc72a2+MsKCoszVXdeiCyfMwTsPUsCAg
 CfflqLTLSLKeV8uVFgeQwGZTrT8F9AmK3RVHIBpnQcBsS61TxNJNTB0IKC5FVUxl3JZWlpYYbWG
 6brsGC95n6xnBr+DTzM41jXyDDbgQ3TZ+P9bnQSuJ
X-Gm-Gg: Acq92OFjlUsXJ6N17GvQdeLmIIprrneSAUpf1KO9wqUP/m8Pi0w9Sql/MMzelQ6R5gn
 XiUhZGZYmWUck4r0cpHgC+kwFP6KPtgxtMRmeF1gEuYgBy2mMBQDNhpIqgMLttyZcQy4w+Mprqw
 4Xc3D0Kj9v7P/Zs2AMl1sULs/PijoxbEdlgd6kFG4G/vlUlPKyLdZD7NUoKLf68ZP13Ts7iQ3QV
 vwsCrp+MBYKpAIDNhoKo081suFGvvM8e8l31d3/+LYaG+31/cZ+GT55r7uWnufDkJ+Y7Ar0pt+Z
 lkPkxA==
X-Received: by 2002:a05:6402:364c:b0:687:cfde:ddaf with SMTP id
 4fb4d7f45d1cf-693c6a636f7mr2411315a12.7.1781452895754; Sun, 14 Jun 2026
 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <20260525132828.3348679-3-sergio.prado@e-labworks.com>
In-Reply-To: <20260525132828.3348679-3-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:01:24 -0600
X-Gm-Features: AVVi8CcK4Iwiwt-AMvpoR8fphvMKv5p7AkrFhxzfIZMjk56aVQ61UQyoaHn0wic
Message-ID: <CAFLszTiWwxiP3BOrAQ61QHr8X6WYbxWsQp5KqFKSBvLxzsoq6w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] binman: x509_cert: support PKCS#11 URI in keyfile
 for HSM signing
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, xypron.glpk@gmx.de, y.moog@phytec.de, 
 afd@ti.com, quentin.schulz@cherry.de, Wojciech.Dubowik@mt.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Sergio,

On 2026-05-25T13:28:26, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: support PKCS#11 URI in keyfile for HSM signing
>
> Allow x509 certificate entries to be signed using a key stored in an
> HSM by accepting a PKCS#11 URI (RFC 7512) as the value of the
> 'keyfile' entry argument, instead of a path to a PEM key file on
> disk. The URI is forwarded as-is to openssl '-key', which resolves it
> via the pkcs11 provider configured externally through OPENSSL_CONF.
>
> A new make variable BINMAN_X509_KEY_URI is introduced. When set, it
> overrides the 'keyfile' entry argument for all x509 certificate
> signing operations:
>
>     make BINMAN_X509_KEY_URI="pkcs11:token=mytk;object=mykey;type=private" \
>          OPENSSL_CONF=/path/to/openssl.cnf
>
> Two URI forms are supported on OpenSSL 3.x:
>
>  - Provider path: pkcs11:token=...;object=...;type=private
>  - Engine path:   org.openssl.engine:pkcs11:pkcs11:token=...;...
>
> [...]
>
> Makefile                                    |  1 +
>  tools/binman/binman.rst                     | 55 +++++++++++++++++
>  tools/binman/etype/x509_cert.py             | 37 ++++++++++--
>  tools/binman/ftest.py                       | 92 +++++++++++++++++++++++++++++
>  tools/binman/test/fit/openssl_provider.conf | 14 +++++
>  5 files changed, 194 insertions(+), 5 deletions(-)

> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> @@ -88,6 +93,15 @@ class Entry_x509_cert(Entry_collection):
> +        # When keyfile is a PKCS#11 URI and PKCS11_PIN is set, append the
> +        # PIN to the URI so signing runs non-interactively. The preferred
> +        # way to deliver a PIN is to configure pkcs11-module-token-pin in
> +        # openssl.cnf; PKCS11_PIN is the convenience fallback.
> +        key_fname = self.key_fname
> +        pin = os.environ.get('PKCS11_PIN')
> +        if pin and 'pkcs11:' in key_fname:
> +            key_fname = self._build_pkcs11_key(key_fname, pin)

nit: the 'pkcs11:' substring test is loose - a filesystem path
containing that token would be treated as a URI. Please use
key_fname.startswith(('pkcs11:', 'org.openssl.engine:')) instead.

Also, the commit message says the URI is forwarded as-is to openssl
-key, which isn't quite true once PKCS11_PIN is appended. Please
reword to match the code.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -6905,6 +6906,97 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testX509CertPkcs11(self):
> +        """Test X509 certificate signing via a PKCS#11 URI in keyfile"""

The test only exercises the provider form; the engine prefix is
documented as supported but not covered. A small extra case in
testX509CertBuildPkcs11Key for an engine-prefixed URI would catch
regressions in the combiner without needing libengine-pkcs11-openssl
installed.

Regards,
Simon
