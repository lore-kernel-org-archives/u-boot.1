Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47210C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 04:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40334846B4;
	Tue,  7 Jul 2026 06:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mm.st header.i=@mm.st header.b="l4uwYsNa";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGARrAuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DCC84852; Mon,  6 Jul 2026 19:19:42 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9B0846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 19:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mm.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zaba@mm.st
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id EDAB81D0005A;
 Mon,  6 Jul 2026 13:19:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 13:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mm.st; h=cc:cc
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1783358377; x=1783444777; bh=u1xnk2kRGT
 pKvWO+4+hyFXyn6DICHHeOXs/8EZ4Q4Pw=; b=l4uwYsNaNo8IJVnrrFy0TKQiwi
 qnOopcd1ATLBjMmfI1s+Zezz7a6xdujwTjEGM/dx8v6dhoO4nHCj65k1ODmpkEVY
 2wcJnMyAylqM7JS8tx1QnPk/Gi3FrYc2XzJS4e44gy3N+TxWL2A/f8ZWp2S4tjZe
 3XIxk+GzkSGth2O1CDHRrPDhXT30aAv0v4x8w4XdIfyLYGE774O6F5Dz7Z3X6XTv
 +U5jCMhXTLXxqxhsK+2utzE9pk9Yts5ef2cmapUB2Pq9U8v2Cnc4wvlcCfqiyUfC
 /mRlxYuZWh+fHDzxF3fpXtV6wMtiFTiWbr/fLCUkYWmKWxEm1qgpklC2iW+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783358377; x=1783444777; bh=u1xnk2kRGTpKvWO+4+hyFXyn6DICHHeOXs/
 8EZ4Q4Pw=; b=IGARrAuFjQUcRv9TuPhjcdy/i18W53wjRkR24FhlH7Rw3FXGw5g
 NsNDYJag6EGUuxqJCN7SupN6oseMnyxZgY58iJTzJ/PRVyxf6QqwhN8WA8VMuUP2
 lMXiTDVEC9mu0crUu3pXzJcExOthajui/Cm++oO/ba8MidDTXBah88+/yY2SpSBL
 d2AmkyetjzFiFK/UzbYXoJVPxjRhDhD+4zGaTNKU0cB8ouvevAJDw1PdnpI9wAKu
 Qxar4fbSluTl3GNu/wv1edTHTa9+g+2IOX9g7fFB2xfUD5dH7VnJd+MFjoB0PoCg
 yIZqY1fFbgKOYjuigxZi688roX7yCBkDPYg==
X-ME-Sender: <xms:qeNLamQmFe6Y5XM5JNZkDAh5-J1HDfP92UebIaR1PMlZ6_aAohJPzA>
 <xme:qeNLajMogS2_y8B-8gqQvrhPInkCLsnvysRDW8RsjcuQRftkt4nyBCllO9-sKn3sL
 pVz4bWJimFv8SOBItNHr-nIis4fP7gdIlwJebT34w-6HldW_5anUA>
X-ME-Received: <xmr:qeNLahP4nefWxaCXJ-_Q0D7UAiIDaG4UDW3WMXZsRaHayGhHZU8kl4Aq1hDTGAn1AoyXAtto1Jyd3Uhd7Q>
X-ME-Proxy-Cause: dmFkZTF3bhW5h5/GJZNsxLn8vfWOBeST7Mi1279bYerQ+O+XZ625VdpPvxaM2bA5xxLLWq
 MLt6HvebnmOpampqOc09QXSCNRDZkSrBHVFT1DKqdttDk+XdsvM8nB5WPL50EG8dsphVVl
 RuBY22DUFryelWZXVHqkMCt4IHPirsgo2H800BrWzujySjqzXu743CY8rqb9PNQ1OkMZxq
 lo7gKiZQMQiTezecS2IqLfd9YX6khANqtTbJDIqviiHlYPosTHCYAsagUdwXl5eKY3bRo/
 H98BcU5LvkB+9mStMUkT4tsNy64QP9WiuiQgCWAI7K/nQcwBEgKkDxbyl1viY8Sa8eAqgO
 eF+e9aaPvJcaxXePoiVZ5B4FpyLpuFMpYB6T5ezSPTNLxZAxP+z0FvGNM7ISOS1re7mTxH
 tSI5L6JaGovYYmW7rM5+6it0Uqwu8FlE2seMnB9crQ/7xa7dgjg4AErfJLPJhWtaMGgpSq
 b4GvKRwLs4gtFqR/cS72MrVXKRrjOH8wL4pPCD6xt31k2sIHbGdSnAfeRqyNOWtHim6UFn
 1k1rVtuO5t+1D6BjRfqDtU5u8TibU5Ai/+qy9foIQd+MvAwWRxJZsv1xyHO+uil6OKm9hY
 1wQdj+ryFpeKbQTImgBXOgFlNNGkz+qmXXTQfbRgiolidf2KChPVoCytSo+Q
X-ME-Proxy: <xmx:qeNLars1cp9A_cujTdBrQsdGhYkvljoV30hI_NMUmIzs_3Cohu7I3Q>
 <xmx:qeNLajVerJxT1NVDsenzevnFCwndVOyDszir0eGd609UFgWMTnMGew>
 <xmx:qeNLars7dWthnb07UdeQsXMkBaHNDIsU4ZSEoVt560qNrLL0kUZDIg>
 <xmx:qeNLanV6y7ycb9LC9_K-FkoYbNvBHjDXcMoPdDcTikpSrYqnhfy2fA>
 <xmx:qeNLapXNach3kHvzAmK427Wt20TZxUyO-KJXGr3MrX3_yvqvLJJT1K-v>
Feedback-ID: i4e034308:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 13:19:36 -0400 (EDT)
Date: Mon, 6 Jul 2026 20:19:34 +0300
From: Vsevolod Kozlov <zaba@mm.st>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH] lib/mbedtls: Do not use ERR_PTR with mbedTLS error codes
Message-ID: <akvjpkbY-69iK7jF@Vsevolods-MacBook-Pro.local>
References: <akn9xLl9CGrLtvYb@Vsevolods-MacBook-Pro.local>
 <CAMDkj5wwc=mU=EA_duycozt374gFq=tapuO0u3QoejTpUYwezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMDkj5wwc=mU=EA_duycozt374gFq=tapuO0u3QoejTpUYwezw@mail.gmail.com>
X-Mailman-Approved-At: Tue, 07 Jul 2026 06:50:28 +0200
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

Hi Raymond,

On Mon, Jul 06, 2026 at 11:38:43AM -0400, Raymond Mao wrote:
> The direction is good, but the fixes do not match the commit message statement.
> In the commit message, only the MbedTLS native error code will be
> substituted, but the fixes below arbitrarily overridden all error
> codes including the standard U-Boot errnos.

Thank you for the review.

I have re-read the code better and I think it would be feasible to
convert return values of mbedtls functions to negative errnos right at
their respective call sites, because there are not too many of them.
The only exception is the mbedtls_asn1_get_tag function that gets
called quite many times in pkcs7_parser.c, but a wrapper function
could be added for it.

Do you think that is the right approach, or should perhaps these code
paths be converted away from ERR_PTR/IS_ERR entirely and just return
NULL on error, given that none of the callers do anything with the
error codes anyway?

Thank you and best wishes

> Please see my below inline comments.
> 
> > Signed-off-by: Vsevolod Kozlov <zaba@mm.st>
> > ---
> >  lib/mbedtls/pkcs7_parser.c     | 5 +++++
> >  lib/mbedtls/x509_cert_parser.c | 6 +++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/mbedtls/pkcs7_parser.c b/lib/mbedtls/pkcs7_parser.c
> > index bf8ee17b5b8..2c85dcc9699 100644
> > --- a/lib/mbedtls/pkcs7_parser.c
> > +++ b/lib/mbedtls/pkcs7_parser.c
> > @@ -495,6 +495,11 @@ struct pkcs7_message *pkcs7_parse_message(const void *data, size_t datalen)
> >  parse_fail:
> >         mbedtls_pkcs7_free(&pkcs7_ctx);
> >         pkcs7_free_message(msg);
> > +
> > +       /* MbedTLS error codes lie beyond MAX_ERRNO and are not suitable
> > +        * for ERR_PTR, but can be useful for debugging. */
> > +       debug("mbedtls returned error: %x\n", ret);
> > +       ret = -EINVAL;
> 
> This collapses all non-zero failures to -EINVAL, including valid
> U-Boot errnos such as -ENOMEM.
> 
> >  out_no_msg:
> >         msg = ERR_PTR(ret);
> >         return msg;
> > diff --git a/lib/mbedtls/x509_cert_parser.c b/lib/mbedtls/x509_cert_parser.c
> > index e163e16b9bc..1c70a8fcdcb 100644
> > --- a/lib/mbedtls/x509_cert_parser.c
> > +++ b/lib/mbedtls/x509_cert_parser.c
> > @@ -425,7 +425,7 @@ struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
> >  {
> >         mbedtls_x509_crt mbedtls_cert;
> >         struct x509_certificate *cert = NULL;
> > -       long ret;
> > +       int ret;
> >
> >         /* Parse DER encoded certificate */
> >         mbedtls_x509_crt_init(&mbedtls_cert);
> > @@ -443,5 +443,9 @@ clean_up_ctx:
> >         if (!ret)
> >                 return cert;
> >
> > +       /* MbedTLS error codes lie beyond MAX_ERRNO and are not suitable
> > +        * for ERR_PTR, but can be useful for debugging. */
> > +       debug("mbedtls returned error: %x\n", ret);
> > +       ret = -EINVAL;
> 
> This collapses all non-zero failures to -EINVAL, including valid
> U-Boot errnos such as -ENOMEM.
> 
> Regards,
> Raymond
> 
> >         return ERR_PTR(ret);
> >  }
> > --
> > 2.47.3
