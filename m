Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F4DC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF1886EE5;
	Fri,  3 Nov 2023 20:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oNDvNt+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE0F87169; Fri,  3 Nov 2023 20:39:16 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1495886E54
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so4071869a12.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699040348; x=1699645148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qUWFmho7qqEE180EEgHKYvyweSUi4CaYYI5cFwTdTLQ=;
 b=oNDvNt+3QHA3BsTViIRt1ymHIYJWJwEou8AJOTn06aR8h9d84GT8EwoLF/5PjGQHWY
 bJe+l+quhrO2t3jYXnykp8u2kJdYqfO5njmuiEQuO0cf4OxKAG6zAJBx3ZLqAG+1405M
 z0Wd8kd7BvK7XC1ICuN2tIq1z72h5Hf6unryc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040348; x=1699645148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qUWFmho7qqEE180EEgHKYvyweSUi4CaYYI5cFwTdTLQ=;
 b=s0t72hobcAZVQWme6ujCmdj8b2drgj7hGxE/oUzFn4VFqNcQuZxjKrQDibMozfj06L
 GQxWxH0j3N1NtzEnc4Np+8I63FWtXOjaSCwhV+XOYmKlyYwcqP7jSkjrVE3wlcbJ1beG
 NdtkXrCRmXvjXexsiVv4aM/lzXcKVj23KJLYWL6ZzPSqpYWELiDtSUJ0DwtMLrG60eVR
 vylYryH4qJUlnJCgvR5Gn2vpCnRbpeC3oWh5ayeuNgaaAVTwma6C0JPo28sOduRPPeXG
 bNUiYN5s3WvF8aUrSe+QpJTSdFz+8Yy27rZBcMLdAilJBhwwYI1OfDH3iMTlVmd7J3kh
 M2DQ==
X-Gm-Message-State: AOJu0YxwcclwcwyjrX5h820ho+D4jEPP20s6DO4oPLfeSacBlWEIbRD1
 qdmmPrNLN/W09qk1ONDcdKRz8SzAhHWwpG8KVbZvKw==
X-Google-Smtp-Source: AGHT+IH22O+TeXKQcIDfhclg4NySL2Fjc/FbOwppLYZBs4xJ+uKV/3+VWjrx8qbjB1OL9uIVxynfdmIOymLb7x42nxg=
X-Received: by 2002:a50:a690:0:b0:53d:b52a:5f4b with SMTP id
 e16-20020a50a690000000b0053db52a5f4bmr16530543edc.41.1699040348160; Fri, 03
 Nov 2023 12:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231103183844.2308934-1-seanedmond@linux.microsoft.com>
 <20231103183844.2308934-6-seanedmond@linux.microsoft.com>
In-Reply-To: <20231103183844.2308934-6-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Nov 2023 13:38:56 -0600
Message-ID: <CAPnjgZ3PxKpdgNaCdaozC-B_cS6+K27DCj8jNwT=RbvJ2LtfcQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] fdt: Fix compile error for !OFNODE_MULTI_TREE
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, dphadke@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
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

On Fri, 3 Nov 2023 at 12:38, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> Required to fix the following compile error when building sandbox:
> /tmp/cci9ibby.ltrans21.ltrans.o: In function `do_cedit_load':
> <artificial>:(.text+0x601d): undefined reference to `oftree_dispose'
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  drivers/core/ofnode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
