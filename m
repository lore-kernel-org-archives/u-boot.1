Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A50DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7A084AF2;
	Mon, 13 Jul 2026 14:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cyc+H3AN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DC184AF5; Mon, 13 Jul 2026 14:41:24 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D0684AF1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso4567312a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 05:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783946481; cv=none;
 d=google.com; s=arc-20260327;
 b=KdL511fd3rJ4hzdIXt8sACVDxEjoSOSWjdwHAhZPjEzJF5xCbCeEXDCWKvDos3soma
 Y/ukM5J1VOgJREPrY5wpb1o8qK/1m+5jyhF8T+ZQ+Gpho8o2vwKvzLn6q/k5fikhPTWP
 ESst0zytkotRhrpIobwPIVMNeuuK82GRG32T6nJT114Av5UhUkK/UaJ8iCmsXrf2Kxs9
 ALFUazLaoAES6lwKX3sqAZ3fAv8B55AkyGR3qEa6d9fNaA/XBfLkcUbP4OgKHvYOG9VJ
 3inV+9UvvwLU7X6HBKKlc1sbD7Bg3pll4DnLj1hA+02hDedMSCIuASmlTv4+EJHluESP
 y2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wpeEX26VMcjaubvvDzZ0+EgtYjgo2p/K4s8Zhx3AHl4=;
 fh=CcuDZmTrATCCWiOVlvhRNk3dyUsaw1UrvxWB/NarpSo=;
 b=ilHlCtIvArBol3orcGOs+YnfZKIIBMmE3tc4Fw8WOl9sDxAfXj6YIoFAR9kIX9fM/z
 CNpWNdt0YhLHI1vB3CjAOjosAeyDR3bkNYMNsPGdua2zqGUFmQHxXuUUkX2Ta8bmmLr7
 4b2gJ2et2KIVqCWg89PkcEHRdKaJmAcqLnVegjqxzAYW1syb1QdMU2Gn1b+kyMzTK5/o
 TytQkJ+PrnCp4dMrKidfQhf7hhKZoFAb/esavRKOhl3HatuqTh/1G6W32FuGGsWpv7b7
 u9B5SKew32PW25ttDMJcelDKF9ZZNDw5pEDNvphCPjayNrSWCXCh+Wyb1p+Lsl5gthFB
 qQDw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783946481; x=1784551281; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wpeEX26VMcjaubvvDzZ0+EgtYjgo2p/K4s8Zhx3AHl4=;
 b=Cyc+H3ANKiukU53FF1KlRYxID0ehPVrwDDYmkOzs/RwV1e9J40k9jgmfFcbYodhNqM
 sKrP6XuNWEMDby5Xk+szBjAwSXFAiLbTYh0mlQVQZUpVNsyyjRpOAotF1vpPS2/IRqfH
 h6E+J5amiCHTY6iwTy7uUNBTKS+MKgtX2nfhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946481; x=1784551281;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wpeEX26VMcjaubvvDzZ0+EgtYjgo2p/K4s8Zhx3AHl4=;
 b=QNHN2YFLrEDqdXJvZjccmHdHeUnYRlPg/nXU1j8sjeyMC1s4lnJZI/P/tN3grnLRJF
 9zJwlLTsz4kThORDGQOSxS+fnuVPQFjTF+RTcH2uKhbQWfbTMH2GYQRuKvjbAtvZaSBS
 GpiGMe30nn/sX1o6Alb99Jmfi95sZpiVG2miE5EdjtDKqwG6XyQsZbiX5dlIQyVzDuMl
 JYfIjh6ZcjWklqqyB3O6Q4izN3dP+5dxbdcQ644tGM9VFR5JTjwxM6GTvGcVn4pwW6Wy
 wLFtmQewH3TdL16cV5WetTfIIR7VY0pd61OX3SEBiPdX13UnkSv9dtLzHo491lycY0tv
 p9yg==
X-Gm-Message-State: AOJu0YwcC8YDsJCV6MClIDnfgLjf6CeLuJCKm9SGy7KTZl9fa1i0R4uj
 WnAFu6nzu/INMAjmDXzHK/pI1Q+4DS10owVzAeob6xzSzPL+roPmyikdSJGp3Pq+EMdl73v9VA4
 5CiZ9RGN4KAvBVpVDLOKK8II6Jc3fnxIjPljAW1OV
X-Gm-Gg: AfdE7ckCFcfF683dcRkC0SRKk3QAtcREE4Yr62IQJDFeJ8ZSmJHb7nadCZS4nHmo/cG
 Hbp68WIwnaOckt4xKydDuKEn9n5MQOEfcWB4d2RW/O1Ra+wvxpjbtB7vxdAAnI3mHTCnpcgCB9V
 jA7qsq54fCZmKTAhxJk7Fb9cVkZ+el+nKBsfDV8zqrmmK7mWtpiJLnyYf9kWWvgNkFjrykTkFXM
 DlTYIljaAuiCAnu7ZTM/VlD5aNyrGKMS30q66TjEk/bS4IVYdh4bd3emlrPCladBuxBwRg=
X-Received: by 2002:a05:6402:440a:b0:698:3b7c:7e41 with SMTP id
 4fb4d7f45d1cf-69c5f25cac1mr3916264a12.33.1783946481154; Mon, 13 Jul 2026
 05:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <20260710123618.2036728-4-ravi@prevas.dk>
In-Reply-To: <20260710123618.2036728-4-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 06:41:09 -0600
X-Gm-Features: AUfX_myQS9VGxJe_FEi1FeIRejnI3nBL9HSWrA8cQhGeHkUOi9s9KnqUvUDSR7g
Message-ID: <CAFLszTj-qB1P9B8tdDoOF0MsUXe7Z5bSXnt9gYvkrUDXQK1-bQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] binman: x509: fix CN emitted for basic x509
 certificates
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Rasmus,

On 2026-07-10T12:36:12, Rasmus Villemoes <ravi@prevas.dk> wrote:
> binman: x509: fix CN emitted for basic x509 certificates
>
> I'm pretty sure it was never the intention to emit the output
> filename (cert_fname) as the value of the CN distinguished name.
>
> The cert-ca property was parsed from the dts node, stored in
> ._cert_ca, passed on as the cn argument to x509_cert(), but then not
> used at all.
>
> Now that we always read a distinguished-name subnode if present, use
> that method instead.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> tools/binman/btool/openssl.py            | 7 +++----
>  tools/binman/etype/x509_cert.py          | 3 +--
>  tools/binman/test/security/x509_cert.dts | 5 ++++-
>  3 files changed, 8 insertions(+), 7 deletions(-)

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -68,8 +68,7 @@ x509_extensions        = v3_ca
> -[ req_distinguished_name ]
> -CN                     = {cert_fname}
> +{self.dict_to_config_section('req_distinguished_name', req_dist_name_dict)}

If the entry has no distinguished-name subnode, req_dist_name_dict is
None here (the ti-secure types fall back to their hardcoded defaults,
but the plain x509-cert type has no fallback).
dict_to_config_section() then returns an empty string, so the config
still says 'distinguished_name = req_distinguished_name' but the
section does not exist. I tried this and openssl fails with:

    Unable to get 'req_distinguished_name' section
    Error making certificate request

So this patch silently makes the subnode mandatory for the generic
type, with a rather cryptic build failure for anyone using x509-cert
without it (previously it worked, emitting the filename as CN).
Please can you either keep a fallback (e.g. CN = cert_fname as
before), or raise a proper error from the etype when the subnode is
missing, so the user gets a helpful message pointing at the node? A
test for the missing-subnode case would cover the 'if not d' branch
added in patch 1 too.

> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> @@ -44,8 +44,8 @@ class Bintoolopenssl(bintool.Bintool):
> -    def x509_cert(self, cert_fname, input_fname, key_fname, cn, revision,
> -                  config_fname):
> +    def x509_cert(self, cert_fname, input_fname, key_fname, req_dist_name_dict,
> +                  revision, config_fname):

The Args docstring below still documents 'cn (str): Common name' but
the parameter is now req_dist_name_dict, so please can you update it
to match, as done for the other functions in patch 1?

Regards,
Simon
