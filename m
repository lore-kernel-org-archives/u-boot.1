Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746DFCD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D28A9846A5;
	Fri, 15 May 2026 16:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sno7ob4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1740846D7; Fri, 15 May 2026 16:01:36 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02CE80086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so184417166b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778853694; cv=none;
 d=google.com; s=arc-20240605;
 b=RoAR1qmNCaeVTDIqeM4VfB++UgIB8MmkEwTN8oSNENI4FIzl5xY6dXC+5nXaIngoGW
 88vN/t25BtEHQS4hRI7W34BfSiJRJXzAPKjS60ntnZ9hvPKhX6tx+HnvwG6k8FNLSgzw
 76tqK+oXNey+M36zjJlHpsi4moXUQEQRBObauJyva4xhtL6QcoUTUO8QadeURK8LWg7h
 zGpHZo9FtnG/y8ES8PoiijXdS6G8YVORaOW3Egmzv04tyPUTPMRDUMxoxNBXhGqWW3Yh
 +DONYvRas3DGjTdcWuPdgwdRL13oYb0/jAqI7eH20vJCl0WPwpJcWvPQU8/lu6FTP1PL
 3nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qccdEluf5yF2RZB7AJF7SHJJPiv97DGJL1j1aTn/k54=;
 fh=5DvzkQXSYA0JfKNvC4+WY/n2kShyZ68z+gtBt2ADqHY=;
 b=FhnTjxl0p/hODtUp8bC+lLG6ZRrVLDPGmZhZqw6zR6WhMRRx7opoNMIapPKRpc0o/i
 3vryxaYXFvza+Ydjq2GUYEbZ5GY5BQO9zegHfeoo45uISpaOsy17THZpWXgB5hondY96
 rQGl8Gz5GJhIS1ceB79OX7aECmxS/TdzJU8ZrAkVht9s8KfX0c9do0xUjUd1o9zDw4A+
 YKxoierkEgBmt+kqrGHtCgElktzad5BoGVyKhc+jUKrN6u+ZaS136jHQymGCqAn5SBJZ
 RCXoabkofWDeDcK0L1iVDRc6qmNaQiDwwMcuDPaN/ld0X+9LFq+F2XL5ke+Q1O4Mua1W
 TeAg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778853694; x=1779458494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qccdEluf5yF2RZB7AJF7SHJJPiv97DGJL1j1aTn/k54=;
 b=Sno7ob4j5CGkZ8oSS40BKcPCUQmPw1XDrZA10uRgkyGGz9X/WEtyaF00AfofKFFAPu
 bGLK1Nfk+w936XVIzG8lwmc3/vkFHFCCezuGlUdE9yNV2/wYfcZcr9zaeR2F5phbcLtk
 VCwx4xSTQudkDgPkd5nKK0M6q3svViA8wKg3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853694; x=1779458494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qccdEluf5yF2RZB7AJF7SHJJPiv97DGJL1j1aTn/k54=;
 b=tMHJNbU6DGUF0ROIxia2HCsxM2eL9dWKso6cFlJrDbfqU7+xXeKDTk052ylUMK+7GT
 HpxVqp2exx5Bf8Y6VXymzt+3JSSTmjILVgiqUUijRHPRppg5r7G5RdVKpSj5sacQuFP+
 2UtpzBMhiaa6Zy22DDThVQaGK+bwPJDmMyXqFIvepKDpyHOhzUc3tOC6ce6CNzRx4al/
 Nw86ahb5bktXRPXvT4hy11yr5pUHvUqV9fday7UJURmJ+KXLw0a8Y2ZPlobsN/OG2apW
 1tneqhiHLtv/Q5GdwJ3Vj/gM1oCMdeSJloYXhwQKhTDcJzHE3/NoM3W/PqJGhMJj+38a
 FPzA==
X-Gm-Message-State: AOJu0YztKWUaxrNEZIwwLeTeMAUHroXF7UWLqr9rhzWN/peExsIKKdNn
 Ic4OWhjRIFgWV0SX/i3IlBByKvj6MMX0KtvErvt1TVApEYMvREQE0oCjAnYqM145IzGyAbUPZTP
 GefLhRwLn4dJG5eqW9Y2xxYGkdkjPPZ7dcmknJHmE
X-Gm-Gg: Acq92OHqrkyhXfqWPMkwdvX74HOEmHcTpdq+g1jHNtcyiSqq+Th0lV1OcNWf0DuoS+2
 d1rcApQMPrxYhYg1eITXV2S/2rAzHr9PbpuBZro9XcynAUcPExHLZAD/2eBxhkDlbrQzfJmlzFG
 XbL2j5zHUlnvLUpE52KuKJBvFSCxJHecpx323p8fnbRCbLxriSJNGDfXTLWu82U+1ZLAFw2bInr
 APavSOWZUKHzO9wQIvclvnDR5dIL5tmurlRKnEvnKST0q8Fuq1cnC2E+rbHZd5eqOYk5BXaewlj
 +o3e1g==
X-Received: by 2002:a17:907:97d6:b0:bd3:329e:81e0 with SMTP id
 a640c23a62f3a-bd4f333f97amr454812666b.9.1778853694203; Fri, 15 May 2026
 07:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
In-Reply-To: <20260513175640.1830541-1-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:01:21 -0600
X-Gm-Features: AVHnY4KSQol8IvkPdUem_GUs_E9Nb7QK166FL0fcgWiCiObeECCMleooBEjFUxU
Message-ID: <CAFLszTjXNhFU7pPQhi-uoZ2z2Bi3qxB7iuF59x+aEJ2=68zK+Q@mail.gmail.com>
Subject: Re: [PATCH v4] binman: x509_cert: add PKCS#11/HSM signing support
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

On 2026-05-13T17:56:34, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: add PKCS#11/HSM signing support
>
> Allow X509 certificates used for TI K3 secure boot to be signed via an
> HSM using the PKCS#11 standard, so that the private key never leaves
> the hardware token.
>
> A new make variable BINMAN_X509_KEY_URI is introduced. When set, it is
> forwarded to binman as the x509-key-uri entry argument, overriding the
> keyfile property at signing time:
>
>   make BINMAN_X509_KEY_URI="pkcs11:token=mytk;object=mykey;type=private" \
>        OPENSSL_CONF=/path/to/openssl.cnf
>
> The OpenSSL pkcs11 provider or engine and the PKCS#11 module must be
> configured externally via openssl.cnf. Two URI forms are supported on
> OpenSSL 3.x:
>
>  - Provider path: pkcs11:token=...;object=...;type=private
>  - Engine path:   org.openssl.engine:pkcs11:pkcs11:token=...;...
>
> [...]
>
> Makefile                            |   1 +
>  tools/binman/binman.rst             |  50 +++++++++++++++
>  tools/binman/etype/ti_secure.py     |   5 ++
>  tools/binman/etype/ti_secure_rom.py |   5 ++
>  tools/binman/etype/x509_cert.py     |  52 ++++++++++++++--
>  tools/binman/ftest.py               | 118 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 226 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thoughts below

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -6905,6 +6906,123 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        # Find the softhsm2 library path via p11-kit
> +        p11_kit_config = configparser.ConfigParser()
> +        p11_kit_config.read_string(tools.run('p11-kit', 'print-config'))
> +        softhsm2_lib = p11_kit_config.get('softhsm2', 'module', fallback=None)
> +        if softhsm2_lib is None:
> +            self.skipTest('softhsm2 module not found in p11-kit config')
> +
> +        # Find the OpenSSL pkcs11 provider module via the modules dir
> +        # reported by 'openssl version -m'. This handles multiarch paths
> +        # like /usr/lib/x86_64-linux-gnu/ossl-modules on Debian/Ubuntu,
> +        # which OPENSSLDIR does not point at.
> +        m = re.search(r'MODULESDIR: '([^']+)"',
> +                      tools.run('openssl', 'version', '-m'))

You construct the bintool instances above (openssl, softhsm2_util,
pkcs11_tool, p11_kit) but then call tools.run() directly. Commit
08bcf962c5f routed the existing eight call sites through
<bintool>.run_cmd(), at Quentin's suggestion. Can you do the same
here? - p11_kit.run_cmd('print-config'), openssl.run_cmd('version',
'-m'), and the softhsm2_util.run_cmd()/pkcs11_tool.run_cmd() calls
below.

> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> @@ -168,3 +198,15 @@ class Entry_x509_cert(Entry_collection):
> +    @staticmethod
> +    def _build_pkcs11_key(uri, pin):
> +        """Append pin-value to a PKCS#11 URI when a PIN is provided.
> +
> +        Uses '&' as separator if the URI already contains '?', else '?'.
> +        Returns the URI unchanged when pin is None or empty.
> +        """
> +        if not pin:
> +            return uri
> +        sep = '&' if '?' in uri else '?'
> +        return f'{uri}{sep}pin-value={pin}'

The PIN is concatenated raw, but RFC 7512 says the query component is
percent-encoded.Wouldn't it be better to use urllib.parse.quote() on
the PIN before appending? You could add a simple test for that.

> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> @@ -18,7 +18,25 @@ class Entry_x509_cert(Entry_collection):
>      """An entry which contains an X509 certificate
>
>      Properties / Entry arguments:
> -        - content: List of phandles to entries to sign
> +        - content: List of phandles to entries to sign.
> +        - keyfile: Filename of the PEM key file used to sign the binary.
> +        - x509-key-uri: URI of a key to use for signing instead of the PEM

...
> +        - cert-ca: Common Name (CN) embedded in the certificate. Used when
> +            generating a generic x509 certificate.
> +        - cert-revision-int: Integer certificate revision number. Used when
> +            generating a generic x509 certificate. Defaults to 0.
> +        - sw-rev: Software revision number embedded in the certificate by
> +            the sysfw/rom variants used by the TI K3 secure boot subclasses.
> +            Defaults to 1.

Ideally this would go into a separate preparatory commit.

Regards,
Simon
