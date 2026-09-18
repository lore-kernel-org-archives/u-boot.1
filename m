Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF23C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B568812F2;
	Fri, 18 Sep 2026 20:40:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1DWajjILKvV; Fri, 18 Sep 2026 20:40:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 21736812E5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764030;
	b=LX/4Vra+owAR333njjDx0maX9suv7ZIK377KqyrE0brTXykhJtuiDrA/MEJ8FSNl4OQ2
	 mFp/b1o58XsXpCvfeS3QRIHI681Dyj0iE7DJ+GuhyUFjkUulc8Vxc8Sho36GQyU7ttDgc
	 NAwCAJXdcj+nJfycU1xdlAHdEkYAGNTVXeG5qYaGA4LTP6XNGWF/HkJB3ACFoE0eJ/mx0
	 3Az/NaxLjxnNgGUK+UK09QskCsIPfJKzDl6zV5hrEFWMkUIlnDRxfnHL0QrH3qb30qVgA
	 xhcQ+HrRmfPZGSFVjoUjCTBL41uFE5TSbUzNPrC3gd0vemtlA6aOExzUG50O2vnel+A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Mx4HMjhCo3nAwWfK10lYZAf2ij0NSjpkvj6yQpFOqC4=;
	b=lICq7g6q8QCqPIqisJ4RhEnxUuEKVB44V5Aq5jB3HFL2ApBHGINBJ2FoTTZp0O2UdI+/
	 iBvuSrIeyUOOlOeBQSjaAGz4N64N19OE33pUfxfz9cRshyqyqGVJMtXzVUQLmacGZ25VM
	 mETzAfpVipfsR0oLqSZVAhoSrREslX/y/LsNXRzs8JUgFmg+0O25Hi483KryLt5l1XlIV
	 bjH90vmoHeAe0/sE6UXiC170JmoF63ujCjfhutSq0mt6C5FMkq2P/Y3zew60/AKFME5gD
	 Exk0v6n9Ct8g3d2M/gJ0tqpSa4kAZZIKcHA4MNCS+2gVYgrJ8a+UxcL632jvPLN9CLg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764030;
	bh=Mx4HMjhCo3nAwWfK10lYZAf2ij0NSjpkvj6yQpFOqC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0dMC6mCuRR096//yGaDXHJwqpff0SjihLPX5VwR0dH4oKCTl/ELwbi1iYiYMsUXrs
	 qNEHOGNV0lFNMS0xwMGiVEv82Qm20oaD4Gn0RCBGOikvYuGxjoqgrvkxTBAUpS5zb+
	 eDNI20Q1FPIs1a1qqkIEUTGr9JaK205wNrub39D6sRQbsWYYf+w36OBpurkus4niL4
	 sFlq5fIC9zYTpCoGSO0L0NCOetICGrUlIw5dUozjr42doL7hvIkN7sIK0yMh5wXBaA
	 X4jHq+scXREPsO6njncMAg3AGVnvfap1v0t41vtTh5gwI+nbwmZ/ErCXl6q3ud6/qo
	 BQB08PA9Xjvmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21736812E5;
	Fri, 18 Sep 2026 20:40:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BAD1362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E1F34006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i1IkHhvgOgcc for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5406F40022
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764028;
 b=rIO80N/0cdtr5X5kBgWaVyIT2qqnq2eDRn1krjnl5Jg0WZQR17xq5F0Hv1oUp97omRL/
 SNibBixS4rteeLWYYYU0VU7PhxsU361X6wY/v2l4ubm8jYSZRJ1RWUJrnyYpjqiVbNgBc
 bvut+sQW/C3XLxb/DwVpcU+djaF6kK8TAdHsYU35PEWs5L2uWzBYINGZYBoMyuusXeBe5
 046+Xg95LnaJGW3DRPXorfkTXa2ZgIihe/1803HHFS7ny2vlM73UzAiTzeQ43gcqOT7Hr
 iQNvkM/y021CBcV2FKuj4hA7lxRpB3oxR9i9MvCc2nNnkqpnJrqlnpbROIFdyJ/Fx/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764028;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Mx4HMjhCo3nAwWfK10lYZAf2ij0NSjpkvj6yQpFOqC4=;
 b=e9RBqOPisBEYWbGHCEUQrtF0ku0Pmf/ahWQ6tsd5onucolOOgovm58i/rVfj4Qo6YAe4
 XG9za8AGMLG8tBjGA84/g/glSc4DIswcUbRnFPt2VQI3Fsr25VoUnM3oqCIJIqppMyb/i
 D4Mi934NSFQwI6jHQ2+RY+e5mlDdKe8EQCk1thz5oqqzXY8Ae0Zzf4SL62rPCgMJjRaDa
 lv4kphKCyTiHdUdHgJ7bZhS56BE5vTQ9jXImNGifyVqUUv2o0Kh7hXCFMURGDutcFg8Iq
 QM0xO/1YWWyPhtOebhWCcchdgVld8FXTgMpbILrMw/w0jkcitEYv89NnkQWoKvpVA/g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZnIrsBO3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZnIrsBO3
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5406F40022
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:40:27 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a9a2b95b72so1869442a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764026; cv=none;
 d=google.com; s=arc-20260327;
 b=WRQKaW8FvUhpNmiL9yV01B1hUvJ0tyuVIrda366Fcf+EWoBDCPpZ5TsoTr2JIZ29DD
 WcdLDHwAUVN1KCnnVeNccLyMb98ETSdajSrGsSCbOSBStVI9xsz4HsEeVtmkB4Fs+IrE
 jH7NoVKfZciUdXQPlVfkaN/EkLYCuol/b/QNkqSHYDKEsKl5tiuMZMR8x4DNJHA7TBgj
 sztDmeSEP4IZiqmbvk+/Bf2d9D3tYFKAgE+Gth+7Q6z8UR55qMk1PAACGm6+EPpqrruk
 C7OegJOqa4biB4tB2LET8iI+o2trNR5yhYhzO3xlxe/poDTysDKdqUBEpqJGwQRgJ9h6
 DcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mx4HMjhCo3nAwWfK10lYZAf2ij0NSjpkvj6yQpFOqC4=;
 fh=hMnzCCESv5iutVaH6AX1PrbYoVsPb+wpOEI00M227js=;
 b=jcv9N6L7+AP6CVKmI6PzDL5IR2CXRnxC4ljHlEg8ZZwFU91SmJfTtilIHI6/sh4s96
 73183bJ8WRFwcBkodYA1E+d6L9yp33uqseeH5nD6jU4syvWAO73zZq+Fe36xuZVQiHJX
 bFSZ7YFUqpYDWY2ZU+aHrUZZ23H1SRvb6IOelbzlhVE4WJqLgaXqjP3br0Kp4wvkJqC+
 8wmo0VxJEd5W8W7NEGVF2wY2l3AhpuBF7MFzmJzFJSy5rcu7xHxi1CrxfURIJwxP2Wkd
 1593OxvObZSOA96nSDP2jQm9Kcl7xmQ18yj+SdeBIIukazo/WmBAZbQ4a4bgbBGSjbJ4
 NqhQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764026; x=1790368826;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mx4HMjhCo3nAwWfK10lYZAf2ij0NSjpkvj6yQpFOqC4=;
 b=ZnIrsBO3oeqS4zKki7tuTltz3/mbAJZhtfDQZf4z16OObUlRX0OpnSm9bkhSJ12IRX
 SXNuuwfvecp6B59wfiDcikS4kGszpmDaUT14DzCrGYhKCvld5gFkzhGHEBmgYs+5FqGp
 h/3R8i5FcYfxJ62OFZ07KhNK+KeG/YFHP2Ysc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764026; x=1790368826;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Mx4HMjhCo3nAwWfK10lYZAf2ij0NSjpkvj6yQpFOqC4=;
 b=q9OwknqU+DS0nTUqUHewU8BriL5eAIkGhFN5eE6bK/c55IeZvenvht0K5aA/qComa4
 11HF9KcBKYU/D2bm0esT07g8K0HtNcePGMHPtKioOfnC0DHR/YqIBpYXYAjRo3Val7jh
 b/CrYmUYQWNNejETkRiI/YAJfrEkWCrRDCNExhH2rR3C08F+4Yv1Eg3/V7rgRKKJfYgw
 dxdht9uK+UOy50vcUZyUg55l1nEsrGLdWEXsieDCXKkUMo8yUVB8/mxENOnHnuVkYStS
 cwxZVWJj6QcCPP4QJxcg8f6VRJNPWPVyoWkGAyWgmYLCYFhelp+XOiNpbEjMo3Miqqkr
 fxyg==
X-Gm-Message-State: AFuF++kuDYr9wHNKLXZSB5P24Bafz77hPsJxFARzblRdFhixBXd9CzAX
 Ts45wN4VkqpBlReDg0FLv/bHU1cUvRX+IlsC2tP2IRWQQIaqJ2LzU9o4k4CcgIhRY5lNuMpAzPf
 gXXrK447J7295hpty7B4/DhneGijybPwbAOlb+hyb
X-Gm-Gg: AYBFou2g1ZLbBrdQADHXTUK5q7313dkgpfkblTKHCp3XbeWH9tdSLPmHZMOnqjbxdOr
 Mg9WqPJ0zBUZ3yyHwWFhsVRP+jI93Q8g0C0yHVw/6ByhMI+IfkOqaF5RB1D4TjsN2Wr+589ZPtL
 EKOJmrCB1T43rE9twlX5r+jmQi4w5+MzMeiIAS+mNlT8mEaxSgKeiDGrCofvRpgDq29iAx/ShN/
 c3E6Pmz4KLkPjm8c4kLKDHm7clKMu/Y2KH/f9Gh2S0kAWtPnd5A+MfLC/ensR0va2ZTGm9fnoJb
 i6gg9SYGUmcKi7ivef5f1QjaF5dUTYQYUHXnO0yVeTLtPOQM7056IZ/5
X-Received: by 2002:a05:6402:208e:20b0:6aa:1112:62fc with SMTP id
 4fb4d7f45d1cf-6aa57818ee8mr1964405a12.15.1789764025854; Fri, 18 Sep 2026
 13:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260912124454.13578-3-aristo.chen@canonical.com>
In-Reply-To: <20260912124454.13578-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:40:12 -0500
X-Gm-Features: AcwNN1V7zWcLEPjJiHVH0E1dAGHANwBbxfL3MSdYLX-hN5e3hYunkqYvLDV5mns
Message-ID: <CAFLszTiVxud4Hvsz6B=GGuQKHnjxtXXXqbPRbQPaEhpXjrCUjA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] tools: mkimage: resolve image-data references
 between FIT images
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Aristo,

On 2026-09-12T12:44:46, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: resolve image-data references between FIT images
>
> An image node may carry an 'image-data' property naming another image
> node under /images whose binary data it shares. This lets several
> configurations load the same payload at different addresses without
> storing it twice, as described in the 'Shared image data' section of
> the Flat Image Tree specification [1].
>
> Resolve the references in mkimage after any external data has been
> imported: the target's data is copied into the referencing node, so the
> later ciphering, hashing and signing steps see a normal image node. The
> property itself is retained in the resolved FIT as a record of the
> sharing relationship. When mkimage re-processes a FIT that already
> contains resolved references, the node's data must match the target's
> data exactly.
>
> A reference is rejected when the target does not exist, when the target
> itself carries an image-data property (chained references), when the
> node's existing data disagrees with the target, or when the node mixes
> image-data with external data properties. Since encryption happens per
> [...]
>
> include/image.h   |   1 +
>  tools/fit_image.c | 286 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 287 insertions(+)

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> @@ -1169,6 +1169,287 @@ err:
> +     ret = fdt_open_into(old_fdt, fdt, size);
> +     if (ret) {
> +             debug("%s: Failed to expand FIT: %s\n", __func__,
> +                   fdt_strerror(ret));
> +             ret = -EINVAL;
> +             goto err_munmap;
> +     }

In practice this function should not fail if the DT is corrupt, so
debug() seems good here.

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> @@ -1169,6 +1169,287 @@ err:
> +     extra = 0;
> +     fdt_for_each_subnode(node, old_fdt, images) {
> +             const char *ref;
> +             int target, len;
> +
> +             ref = fdt_getprop(old_fdt, node, FIT_IMAGE_DATA_PROP, NULL);
> +             if (!ref)
> +                     continue;
> +             found = true;

When mkimage -F re-processes an already-resolved FIT, every reference
hits the 'Already resolved' branch and no data is copied, yet the
function still allocates a full copy, runs fdt_open_into(), fdt_pack()
and rewrites the file. Please track whether anything was actually
copied and skip the rewrite when nothing changed.

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> @@ -1169,6 +1169,287 @@ err:
> +/**
> + * fit_check_shared_cipher() - Check cipher settings of images sharing data
> + *
> + * Two image nodes can only share binary data if their cipher settings

The kernel-doc blocks on fit_props_equal(), fit_check_shared_cipher()
and fit_resolve_image_data() are missing @param descriptions and a
Return line. Please spell out the parameters and the return value,
particularly for the cipher one which conflates the source-.its and
re-processed-FIT cases.

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> @@ -1169,6 +1169,287 @@ err:
> +             if (fdt_getprop(fdt, node, FIT_DATA_OFFSET_PROP, NULL) ||
> +                 fdt_getprop(fdt, node, FIT_DATA_POSITION_PROP, NULL) ||
> +                 fdt_getprop(fdt, node, FIT_DATA_SIZE_PROP, NULL)) {
> +                     fprintf(stderr,
> +                             "Error: image '%s': image-data must not be combined with external data properties\n",
> +                             name);

Just to check: fit_import_data() runs before this and, on success,
deletes data-offset/data-position/data-size after importing. So this
check only fires when the source .its declared those properties in a
form fit_import_data() refused to import (e.g. offset without size).
Is that the intent? If you meant to also catch a well-formed
'image-data plus external data' combination in the source, this needs
to happen either before fit_import_data() or by updating
fit_import_data() to skip nodes that carry image-data ... otherwise
the external payload is silently absorbed and the mixing goes
unreported.

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> @@ -1169,6 +1169,287 @@ err:
> +     if (fdt_getprop(fdt, ncipher, "iv-name-hint", NULL) ||
> +         fdt_getprop(fdt, tcipher, "iv-name-hint", NULL)) {
> +             if (!fit_props_equal(fdt, ncipher, tcipher, "iv-name-hint")) {

Since you are adding a new feature that leans heavily on iv-name-hint,
iv and data-size-unciphered, please add FIT_IV_HINT / FIT_IV_PROP /
FIT_DATA_SIZE_UNCIPHERED_PROP alongside FIT_KEY_HINT in
include/image.h and use those here. It keeps the cipher-related
property names in one place and makes future renames tractable.

Regards,
Simon
