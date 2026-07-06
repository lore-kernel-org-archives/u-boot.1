Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFDEC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF8C5846FD;
	Mon,  6 Jul 2026 17:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCg5RMHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B516684942; Mon,  6 Jul 2026 17:38:58 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87164846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-7353fc917e2so1004739137.2
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 08:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352335; cv=none;
 d=google.com; s=arc-20260327;
 b=J5uwr3peDyfv0GZuLyYvpq/1LxrcJ6CpzPWApCzur+lWLUQczWvrKFjAhChyeeHHHR
 dAtPPr7mkU81AceAFilL3PDowxHC2YRVrhviPgdk6nbvkTAKWP5aTSPjh0Nqk+aP9fX5
 9hV7+POasRl8E3BWfpt5Wa7vm3UJTJDxVc7sBjMVQCUxY44q4TnuYoIU3rmptjzOoHyM
 ZLiWIEC/j7sbuiCjxl9x3GfbiJjKNotjhjxL0QOX4ebjurKY5YR4O+ScyFoIKLfrErwZ
 W2hMva9x1FRf6cL7WAfhTtZJuI9LAEWIYoJODssEcIoced4PQiZJhZdCNnT4RIebdRg/
 tXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v8o0c2jcLdm83qHE1FZbU/Xt/17tDwCZ1D5w1UcCxKA=;
 fh=Wcmhp1NnyhgG/fgg7g4awJsFnHMrIPejwkBt+zuPAbM=;
 b=lWAT3diqRERP6JwZR9OdB6JtEgh3EeHrkAQBu1+0HW+3BDD/dzWE83qGa53nyiceAK
 BtaGHJVHFsp430F3VYQlSMt4rduyEPfXozA9ZuaHLBexpqG/BiPeIsrNWVOwcOmT2/w1
 Gjd2MZ/zL37y7pRUsepdJDKhECNEiXkDEwVQx8n7oiHJrrcNiWEztUGL0qp/Q/z02I19
 LR5x5X48b5I4ce9NRedXQ24pMZNLs3PChODe9xgPDj7kkGvHxBjenL9SgIr93e3Al2rr
 mp48BZa6WEaSS6rrTX8M0YHn1DCLhSv0xbcPDTZtPwAIykiDKC0XMDRLS0kwwp8q//6c
 Ns+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783352335; x=1783957135; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8o0c2jcLdm83qHE1FZbU/Xt/17tDwCZ1D5w1UcCxKA=;
 b=gCg5RMHEKiOC4r9dSE/7WyNYd8urGM7Igpb6E5HzbLITK728WmtInF7NwaOAPsAiP6
 tmdluyP8ZMFWlAWzvvwJKgOTLylUX2fQ8WpgIwnrMkeC+35F/NNguD9+OGItKroxFcR5
 cG1agzLqdTnK3asSb88fvvPNfH4JZ4ImiQPZg5J43JZkz84tD1eWPSiKf/xyQby9Ew4k
 Fl9BXWOiM8mJOXlON7HrtPelKQkb43J9L48Tf6ZMMK8K0LTAIHr/0Im4WOpUTxlrEGJm
 Y03WdlUqKEVbNKe2+zjemooHCeyLJKs4jVKEAszxqy2eWnYQGDRDAPakplB5UTSDaqOo
 KGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783352335; x=1783957135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v8o0c2jcLdm83qHE1FZbU/Xt/17tDwCZ1D5w1UcCxKA=;
 b=F0sgEoB6joTBkmQP7RQ4bT87oESDV0fT1CpgPyudXJXXeVKI2OQINpHzxtEqph9N4r
 AcyX/oIA6mwvQrkzWULhRjsTuucG8Z8XBadPb01zePQW7+Mnku7OgeqTS2WDYFdGLzON
 Jao9Ow4xR7wShvZ8CC1x8xw4wCfoLEnRWQzmfHn4Z+fUxE2MVXY/ZB4COZ0L0QC/dVmR
 RYEmP3p9IIBoA2icvnVLPNRElCOmOhQxGSQIe7Oxe090aLcIq9/62YWqFSOiTQ4wqwHl
 YsDAuWtOnwxAVnDVtQPQLY5w6hW9cRgd9J8ZAnrujiD3WrWelVfZiN0KSp+GazUKOcGM
 aBTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNo5C6ys9nJfUINgWqLo5a64SgiGqTseE7uretj5W+bo9I4DH9uHLFx+KtJCJ9h9OE8hgaZwk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2rseuagqHFnqKNPGiPfZ8Noj1iRKlM0vMXbQxHUdDLzcNil1P
 Op2YA4k7aRiO1dYOyJ+cABNE744NCBfb8DvTDUqmFSdtduF6Bwx2WCaRMpW9dKDShXV8TfIlVPL
 iV22FKVa0YAhqtJzCeMhpsWW1rzcNRGE=
X-Gm-Gg: AfdE7cl0ehv303Ts9oh1koK0SpXcCPy/6em7Yd80mzQRdu3iO9tB7juLj90+Ke+F4IG
 n7QC31DRy4NwWdM9pt2bYRLpt8A7w0mpq877DR+fL0KhSW2+0giBkF6OGty2tKlnMvkMMqXCN4f
 sgBiHKsVaoD4zTlmUM0G/0eygVed2e2VmU8h1LUC2mmfeSqCryP67OzI690lZlrrJOJvmVTVWSl
 pwuWy9NWlZLL/OzLQyrL6Q6gSyxJf33y1wCP7mUQrjxUkf+GrHwHQhB0laK+6uE1762Akpr
X-Received: by 2002:a05:6102:548a:b0:726:f965:722b with SMTP id
 ada2fe7eead31-744b7cb8d8fmr488256137.21.1783352335154; Mon, 06 Jul 2026
 08:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <akn9xLl9CGrLtvYb@Vsevolods-MacBook-Pro.local>
In-Reply-To: <akn9xLl9CGrLtvYb@Vsevolods-MacBook-Pro.local>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 6 Jul 2026 11:38:43 -0400
X-Gm-Features: AVVi8Cfsv4X_f7TyyoAu4q864k11roxAi4ToJZsc-gjZdgAHHy4qa9ILmwK6tag
Message-ID: <CAMDkj5wwc=mU=EA_duycozt374gFq=tapuO0u3QoejTpUYwezw@mail.gmail.com>
Subject: Re: [PATCH] lib/mbedtls: Do not use ERR_PTR with mbedTLS error codes
To: Vsevolod Kozlov <zaba@mm.st>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Vsevolod,

On Sun, Jul 5, 2026 at 2:46=E2=80=AFAM Vsevolod Kozlov <zaba@mm.st> wrote:
>
> MbedTLS functions usually return zero for success and negative error
> codes to indicate failure, but its error codes lie way outside the range
> of -MAX_ERRNO, so using them with ERR_PTR creates values that do not
> pass the IS_ERR check and lead to crashes. Substitute them with a
> fixed error code to avoid problems.
>

The direction is good, but the fixes do not match the commit message statem=
ent.
In the commit message, only the MbedTLS native error code will be
substituted, but the fixes below arbitrarily overridden all error
codes including the standard U-Boot errnos.
Please see my below inline comments.

> Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
> ---
>  lib/mbedtls/pkcs7_parser.c     | 5 +++++
>  lib/mbedtls/x509_cert_parser.c | 6 +++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> index bf8ee17b5b8..2c85dcc9699 100644
> --- a/lib/mbedtls/pkcs7_parser.c
> +++ b/lib/mbedtls/pkcs7_parser.c
> @@ -495,6 +495,11 @@ struct pkcs7_message *pkcs7_parse_message(const void=
 *data, size_t datalen)
>  parse_fail:
>         mbedtls_pkcs7_free(&pkcs7_ctx);
>         pkcs7_free_message(msg);
> +
> +       /* MbedTLS error codes lie beyond MAX_ERRNO and are not suitable
> +        * for ERR_PTR, but can be useful for debugging. */
> +       debug("mbedtls returned error: %x\n", ret);
> +       ret =3D -EINVAL;

This collapses all non-zero failures to -EINVAL, including valid
U-Boot errnos such as -ENOMEM.

>  out_no_msg:
>         msg =3D ERR_PTR(ret);
>         return msg;
> diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parse=
r.c
> index e163e16b9bc..1c70a8fcdcb 100644
> --- a/lib/mbedtls/x509_cert_parser.c
> +++ b/lib/mbedtls/x509_cert_parser.c
> @@ -425,7 +425,7 @@ struct x509_certificate *x509_cert_parse(const void *=
data, size_t datalen)
>  {
>         mbedtls_x509_crt mbedtls_cert;
>         struct x509_certificate *cert =3D NULL;
> -       long ret;
> +       int ret;
>
>         /* Parse DER encoded certificate */
>         mbedtls_x509_crt_init(&mbedtls_cert);
> @@ -443,5 +443,9 @@ clean_up_ctx:
>         if (!ret)
>                 return cert;
>
> +       /* MbedTLS error codes lie beyond MAX_ERRNO and are not suitable
> +        * for ERR_PTR, but can be useful for debugging. */
> +       debug("mbedtls returned error: %x\n", ret);
> +       ret =3D -EINVAL;

This collapses all non-zero failures to -EINVAL, including valid
U-Boot errnos such as -ENOMEM.

Regards,
Raymond

>         return ERR_PTR(ret);
>  }
> --
> 2.47.3
>
