Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624FCC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC9084C02;
	Thu,  9 Jul 2026 21:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NTx7hWex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8810E84C10; Thu,  9 Jul 2026 21:14:31 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 911EA84B3B
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso176843a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624469; cv=none;
 d=google.com; s=arc-20260327;
 b=pfF/FolNUKVN5zBy98GoMmgUAcOPjvEMJeePMDaStZ6oGUBz5NXC2FnC47UV0UimHo
 atQKHv5ioOkMr/22Q+Ay4opBtAwOsiJOKN4zKrLs/3FGtGsvUy8hDIp9jc1UDwxTxprG
 0b+34l8QvUb10l+5/8OcWL32tcgFieG7o7CI9hX8xKbyLEGLDPj4mHS4buDZ1To5qYBM
 eVFe5oAsHVlFVToFqHRYXQ2vSEnxZbl0rhhE1niU2/mPgE8uIQiOclFAn1+3EP9lbP8s
 J+6zw5S+np1fZAzefUl7Ep2ZD7+/R+51BmTqcr3m8PZcvoLl83z8mBrqBr3uiaUxgPsM
 AcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AOYpWhW+H2b0XgKskoD4s0trNIFY5FTTm4ESZKOs+8U=;
 fh=FS43jQmGw96xWTfDffUvswPyPsuQ4FKbyI7t0mUcbKE=;
 b=n3UMu2PACJz/rPud15c6upzgAYtjGLnwEY2D0UVJSRuC9F1g6b8QtnDVcyXNlvD83p
 cVfejkW5DQ2xRUhWV/uwvWbS/nkaXCmYmYDrugUpnqaRMpvAGmS+oRrm8uT3EhoPuib3
 zYaTNe164X7SPh2JA0lf3mJfvHF1Bp/AgNH4rIzGhHnbCPStK34Kazt0YOxPotquifsm
 ZGLufsPdabknWpPhxPoU87sSLR7bi0V4iQ43jKpeLmd3+ds23iHzP1qSApwDqRHKmpdn
 7ZaL4iVizHuIN7jh5G/UZswcvsYDj5llujKZ9UwxJoGCBFjb3BE4/Mj5QWuS7fbGLI1I
 /NIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624469; x=1784229269; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AOYpWhW+H2b0XgKskoD4s0trNIFY5FTTm4ESZKOs+8U=;
 b=NTx7hWexnVWl5fmKCZEU2zYvqGU+HXgo6j+/wSMhdPqvmtXVHG6o+ysw6df3nzJ4ez
 kpPq6LkpqAFVSx2aH9VGvp/Sg37Qdnq43CQbylNTzr9wKuSSbO9TMrXE80x+O5e3aOo2
 +XZruqLDDanAXPs2waIuxk5m5ZUaSDLS0KNbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624469; x=1784229269;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AOYpWhW+H2b0XgKskoD4s0trNIFY5FTTm4ESZKOs+8U=;
 b=gk9EQGHKM1Z4ip6jaafWtWny+PZCP64SHBiHRXDfc2Y8yKiDgJ4NCitRHSdiy1tDx8
 8LeXGsNRcH8QONfuaIZs9d7DjNtdga2ZnK2dRVP6Cmk4UzLFu8voVMGyUkxh8QxaDM8A
 L7w7QnZoN5oDSYW1b9RQdLwSsUsHehuaC0APy0qiuO9PErurIHC3G6GGjmyv8RsaU8jD
 VdG8RuhM911ORxpsqRxnANVt1gGzelFzW1DwgmA5SbTABv6KBPmIw/Dth9B96v6GAAz+
 8RZ08cS2m3CUwwG8tInmbsmwjXcN/I91vwOLsqAkBDp4GgkNXX5xqvDhIsHUZ1xcMpwH
 /jrQ==
X-Gm-Message-State: AOJu0YyNwHGSXInk0hCr0Oa4L9CSsAzkke/dq/xdgB6i6IyHVlRg8q6I
 KlyKT9HfR1M1UXOMCePygcMoErkb2dYJVVTls42n2kFmWv6v5/asNCXeGFvW+/HRjpecaAAzM5E
 OMY4GGIxHsxc7a1fKzk+aHFg/3Ph9omZ6Gnu0ILVdguxF7l1UojbCwA==
X-Gm-Gg: AfdE7cmkgSmeYOfw5Qob47qMxGV2jCXqshbL5ycGmDLo59JlPYz77yUYwU0Y2Bd9XhV
 1bqkBDuTnVVckvz4Yor1nGlr4Xsm/SPb2Wkg8hOmx6im+7ddTOZVtWuQCFhbUJLo7s96kY34FJT
 Ksd03lHiE7jGty/Gs9cFQVXuRadrsmE78HhXS1JL5xrUK9SdrbUZh2oFCBnnl+/9s86I827QkUj
 wukH9h1NbHajpFQp/6uYVbbyQyQTGIyS1fG65i/f0zg90im2psvUoAx+VPJao2jtaj60qc=
X-Received: by 2002:a05:6402:1f89:b0:69a:9355:ec35 with SMTP id
 4fb4d7f45d1cf-69ab44b5e42mr3786612a12.41.1783624468998; Thu, 09 Jul 2026
 12:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
In-Reply-To: <20260707-binman_bootph_fix-v1-1-3603996799e0@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:14:17 -0600
X-Gm-Features: AUfX_mzhIJMqJd7pG_jRZlkjqsRI8dzilv9zFV0PSnaGcBYidRWZ28xHKrYCbWs
Message-ID: <CAFLszTg5Qu3stt8AkeBpWibTyYxp1tXAern3aLE6MEHkHmVRyQ@mail.gmail.com>
Subject: Re: [PATCH] tools: binman: fix changes not being written to source.dtb
To: anshuld@ti.com
Cc: u-boot@lists.denx.de
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

Hi Anshul,

On 2026-07-07T10:44:09, Anshul Dalal <anshuld@ti.com> wrote:
> tools: binman: fix changes not being written to source.dtb
>
> In the current setup the changes done to the dtb by binman such as
> bootph propagation are only made to the intermediary *.dtb.out but not
> the final dtb.
>
> This means the final dtb that's in *-binman.dtsi never gets the required
> changes applied. Therefore this patch fixes the behaviour by writing to
> the supplied dtb before exiting with a modified test to catch any future
> regressions.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> tools/binman/control.py |  3 +++
>  tools/binman/ftest.py   | 41 ++++++++++++++++++++++-------------------
>  2 files changed, 25 insertions(+), 19 deletions(-)

Please can you spell out the concrete symptom? What breaks in a real
build when u-boot.dtb doesn't carry the bootph propagation - which
stage reads it, what does it expect to find, and what goes wrong when
it isn't there? The *-binman.dtsi reference is confusing since a .dtsi
is a source file, not something written to.

Also please rewrite in imperative present tense: 'Write the modified
dtb back to dtb_fname so that ...' rather than 'this patch fixes the
behaviour by ...'

> diff --git a/tools/binman/control.py b/tools/binman/control.py
> @@ -677,6 +677,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
>          dtb_item.Sync(auto_resize=True)
>          dtb_item.Pack()
>          dtb_item.Flush()
> +
> +    # Copy the intermediary dtb ('u-boot.dtb.out') to the dtb supplied to binman
> +    tools.write_file(dtb_fname, dtb.GetContents())

This is updating an input file...really not keen on that! The updated
dtb should already be written into the final image created by Binman.

Regards,
Simon
