Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163D5FF886F
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 02:12:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80103839D5;
	Fri,  1 May 2026 04:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/ZoeFqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FE684198; Fri,  1 May 2026 04:12:28 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9811E803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 04:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so252671466b.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777601546; cv=none;
 d=google.com; s=arc-20240605;
 b=eIz9q/jBTq34YdFBJmKiapNL2ovpgUDwZ4T9TKQrXiNdPlk7UH1FkcMr7Wl1SFrvIk
 OYUpBHCZxdoV19nnx8rk+sUg8rDPsD5UwPRmcRBW3UWHE5YDTkvgcWD5Y4kaoLTHYPoK
 lNhEuvfAHPdZaa21XsyY2XVUE31bFZpf33dDjZj9GNvdW3dad6GexeHPTA5RSFlLtFxC
 vhywYhQo7TXU1+nPhWqpCvOhdzTJzn9cZAzLZ0ApbCBefukDqgXAUm+UyxnIRGcZU6cI
 pycbBf2HWuBpRIWupXsdgSePG9esGIlp5HeYtGnh7bsN3oDU0CFX5G6eQlHagvWHJz87
 E30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DzwfC0dG70Pe5MIfN1japrE01yXxHsnIsdmG3/kL0xQ=;
 fh=MIrqUUR6AIDQU+98GfItEKAfFHGJJTYGvw8qHcfsnUI=;
 b=Nf+Y9ZpHHUcFd6eMSFyxc8HaQ6IlraNDi2tMhUka6I1Poj567iNk16OAOeRvajGFH8
 Tt58DfzjM9UJY0ji0/M6vbLjkE6/FfdA8rJ4Ft0JuMUlwmtxsrXfw/W25O4eLAm5ySnG
 x/u4SB6YPzUeQBdrN2AIPe4TiPfv3NE17OlXcKkf0lQOJ0LR0bvA1xHLTgb/jbXQLQcW
 vP3Z1doPpfP+YQvMMMQtIs4hdjdvzrF7TtStiatwL7f7HqxhY7OH2N+e9Vwkm4pF3lFu
 aqe0sPpO1UfkrTlQuF3tm3mzY6Iuj6dqIYEI4/UUz+/nKFao1vrhMyjG7GmmaZH8qbEG
 TuFA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777601546; x=1778206346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DzwfC0dG70Pe5MIfN1japrE01yXxHsnIsdmG3/kL0xQ=;
 b=m/ZoeFqJq72fF88BV80MGDbTrkBRd8+6odyY77XGHZdFBcGzm/BvRhgcd6xEGniHoA
 oYVT2aSOVDdfmtPSjejnvZccjrTUjaAHB+yzSVc9EtnZKgU2+MFNkcvl/gzs+28qm25E
 S4ryoJS87ewSb0f0aX1idVatXNzJMSj/ixIeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777601546; x=1778206346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzwfC0dG70Pe5MIfN1japrE01yXxHsnIsdmG3/kL0xQ=;
 b=mShaYiKO5EO1GsyftSz28kO8gnIwj8ucDUBo0k+5eUbGaMAmnUobzkU9YtgRZ0VHff
 Ren85Wt+t+N+ieAUhJmA1e3DslMDdnd5ecjudKkVCqCrZ6mr65AUNueSPCcuj4ams5Rq
 carLYMS6I3Reo1dQ4sJqL+KGZH6jPD1OfYVZZGpUNLkEeh6QQPDFmMzJp9Pap6HPg8dU
 8qsprd3Yrj4dFfBASednWhm5LGrrnf+xjY4r47fkvCQvYUe4bKdcXh577tej5CMaxa7g
 e3Sclb4wyk6BfqfRh4bCNNun7Afza8hS2YhdKYfCaHcnupuSLn5GPd3A+0YeFbfDmgDY
 uICg==
X-Gm-Message-State: AOJu0Yz/gLB1tikLLWRweMy7oDouuOh/SbxWoVnMJuKrb4hc6dYuZS5D
 WG1n5wyBN3zSTxb9Rg7Bqwq9PY02mR5tSmoH+6uwsSGPm+2R598OinO9QkL13zUBJLJLZjeCDbz
 4DsCN1UU0XYHFbQH9VB+9RbpLE8fSUQky2mSs1Cq4
X-Gm-Gg: AeBDieuPCWwxeuYesWLV0jR8XIkGZtIcngZnGf8P/+eeUS+6jBC/pDA2ELvSmAHohLt
 YKPpDLkNI85QoK+ixnxPX8vtjeJI3/Oe5H9zhcI72mLYoj2Ddiz0O43LMKU1VEl5xgs9UXbqslL
 dYoPT/klAagrTREkpmdRLBHlFuPDsaU9YjrmWV/IK4UKlMQ5rToG77EWbQoDr/ozsyU4cStix6u
 MHrWChIGm6YmU00Yq+7JnrJBVuy0sE53WJfJsnh7Wp3LkbwKZdhYEm8FM2oLlQWzaevisXtmjmo
 6GFkqunujM/gUyqa
X-Received: by 2002:a17:907:961e:b0:bb8:5a91:9d39 with SMTP id
 a640c23a62f3a-bbebeafe1c3mr51866166b.1.1777601546047; Thu, 30 Apr 2026
 19:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-3-sergio.prado@e-labworks.com>
In-Reply-To: <20260423154536.768603-3-sergio.prado@e-labworks.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 20:12:14 -0600
X-Gm-Features: AVHnY4IMxWVZkjgoKXal2eCSwflylAtymE_TJuvzQnp5_WAfXZuK13wbJUYDecA
Message-ID: <CAFLszTi0WnJ1HYjgTK7ahKxYXM=UqhndULF6yDdU9JpgLZJYuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] binman: x509_cert: add PKCS#11/HSM signing support
To: sergio.prado@e-labworks.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de, xypron.glpk@gmx.de, 
 jerome.forissier@arm.com, afd@ti.com, quentin.schulz@cherry.de, 
 Wojciech.Dubowik@mt.com
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

On 2026-04-23T15:45:36, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> binman: x509_cert: add PKCS#11/HSM signing support
>
> Allow X509 certificates used for TI K3 secure boot to be signed via an
> HSM using the PKCS#11 standard, so that the private key never leaves
> the hardware token.
>
> Two new make variables are introduced:
>
>   BINMAN_PKCS11_URI    PKCS#11 URI identifying the signing key, e.g.
>                        pkcs11:token=mytoken;object=mykey;type=private
>   BINMAN_PKCS11_MODULE Path to the PKCS#11 shared library (.so), e.g.
>                        /usr/lib/softhsm/libsofthsm2.so
>
> When BINMAN_PKCS11_URI is set, it is forwarded to binman as the
> pkcs11-uri entry argument, overriding the keyfile property at signing
> time. BINMAN_PKCS11_MODULE is optional and only needed when the PKCS#11
> library is not already configured via openssl.cnf or the
> PKCS11_MODULE_PATH environment variable.
>
> The openssl bintool gains three helper methods:
> [...]
>
> Makefile                        |   2 +
>  tools/binman/binman.rst         |  18 +++++++
>  tools/binman/btool/openssl.py   | 117 ++++++++++++++++++++++++++++++++++------
>  tools/binman/etype/x509_cert.py |  47 ++++++++++++++--
>  tools/binman/ftest.py           | 110 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 274 insertions(+), 20 deletions(-)

> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> @@ -61,6 +85,10 @@ class Entry_x509_cert(Entry_collection):
>          self.key_fname = self.GetEntryArgsOrProps([
>              EntryArg('keyfile', str)], required=True)[0]
>          self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
> +        self.pkcs11_uri = self.GetEntryArgsOrProps([
> +            EntryArg('pkcs11-uri', str)], required=False)[0]
> +        self.pkcs11_module = self.GetEntryArgsOrProps([
> +            EntryArg('pkcs11-module', str)], required=False)[0]

keyfile is still required=True, so a user driving this from
BINMAN_PKCS11_URI must also supply a dummy keyfile= on the binman
command line, otherwise ReadNode() raises before the override in
GetCertificate() runs. If pkcs11-uri is to be a real alternative to
keyfile, one of them should be required, not both.

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -35,18 +41,89 @@ class Bintoolopenssl(bintool.Bintool):
> +        if key_fname.startswith('pkcs11:'):
> +            pin = os.environ.get('PKCS11_PIN')
> +            if pin:
> +                sep = '&' if '?' in key_fname else '?'
> +                key_fname = f'{key_fname}{sep}pin-value={pin}'

Splicing pin-value=<pin> into the URI puts the cleartext PIN on
openssl's argv, where any local user can read it from
/proc/<pid>/cmdline or ps. Maybe that isn't critical depending on what
machine it is running in. Both pkcs11-provider and the libp11 engine
accept the PIN via pin-source=env:PKCS11_PIN (or OPENSSL_PIN for the
provider), which keeps it out of argv - could you use one of those
instead?

> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> @@ -80,6 +108,13 @@ class Entry_x509_cert(Entry_collection):
> +        # Override keyfile with the PKCS#11 URI if provided. This must be
> +        # done here rather than in ReadNode(), because subclasses (e.g.
> +        # ti_secure_rom, ti_secure) call super().ReadNode() and then
> +        # overwrite self.key_fname with the DTS 'keyfile' property.
> +        if self.pkcs11_uri:
> +            self.key_fname = self.pkcs11_uri

Doing the override here, in the middle of GetCertificate(), is a sign
the data flow is wrong...it runs on every call and quietly changes
state read by ReadNode(). I'd prefer keeping ReadNode() the single
source of truth: store pkcs11_uri separately and have the openssl
helper choose between key_fname and pkcs11_uri at the call site.

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -35,18 +41,89 @@ class Bintoolopenssl(bintool.Bintool):
> +    def _run_cmd_pkcs11(self, pkcs11_module, *args):

Threading pkcs11_module through every x509_cert_* variant (and every
caller in etype/x509_cert.py) is a lot of plumbing for one piece of
state that never varies within a build. Since Bintoolopenssl is a
singleton per binman run, storing the module path (and uri/pin policy)
on the instance once and consulting it inside the existing run_cmd
path would avoid touching all four signatures and their callers.

Regards,
Simon
