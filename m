Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04326C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34234871AA;
	Wed, 13 Dec 2023 20:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LzdFKnMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6497F87710; Wed, 13 Dec 2023 20:51:03 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3602D874CC
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e2e4c88c39so9246977b3.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497060; x=1703101860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FmX8oxx9SPTYXktS2YXVeDrvpFcZG9kOlyuJZQsn4L0=;
 b=LzdFKnMNaTrCsqRzHQppF5qSVqqrC/YAPPnKCuChKs4aEkjvPJBSzziDfevefoiNBH
 Np+4vwO/j4QRrxeuRCuyalqCrLs9fG7oUrE32Jd7q+gndevwCdK9iDmdM0lQI3eo8td9
 zwd6blzOlD7+oPZEkkfsqbagTWxwVfuGH+/G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497060; x=1703101860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FmX8oxx9SPTYXktS2YXVeDrvpFcZG9kOlyuJZQsn4L0=;
 b=gMNV7ltKfMZlNglPLq5WmVg+ShRN1RjJyEbZ0okBMMfBkUsrBG3HAHDbJ2Nj82dX8R
 /W/NpeOJwv/PPHm5lgE2nJNDh8bZKe+YQlX28PgJf9+JK2igRDAikzml2ZWZEkoeqY5x
 64MJWFXqQW5JC3MrtzpapzABMfCcvVn/jFHK2Jqz0wZDdXXL5Xni8xnz4j3P2jo/Jmk5
 WpYQcNQuYeOZ86zVFOC+Ih0FSn8101YwuyJ59WTPAeb1hK1ge3rt9m9lJ68Z28V0/fyW
 IXjwUsj9LUEqZWIxX3n7u1G55D+fZGXRRvXEW381hU16spQQkXrP0kGZgmEQEgbf56UP
 fOJg==
X-Gm-Message-State: AOJu0YwsSKubXPaBx2wF+fPw0LDKRuhnDnSM4XZ3wT+Q79WKQ7TuY2XB
 DMAOhQv+urDPqN7kTYsZwdGyihRqTbHyHY4fT2/TOWRY9NMbkt1Llvs=
X-Google-Smtp-Source: AGHT+IFYff8JGCagfPReGnYaDVnMwtE7r4aanrfvRYAyNqmoXMvNtK8EdTwtbmIcTxa6rD2rJmjsVwIUaSLPeCAde2w=
X-Received: by 2002:a25:d3ce:0:b0:dbc:d103:2860 with SMTP id
 e197-20020a25d3ce000000b00dbcd1032860mr1191305ybf.14.1702497059658; Wed, 13
 Dec 2023 11:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <20231212085236.2730768-2-lukas.funke-oss@weidmueller.com>
In-Reply-To: <20231212085236.2730768-2-lukas.funke-oss@weidmueller.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:08 -0700
Message-ID: <CAPnjgZ2_zHKFQgSWvk+EMh6_HpGaNHJ9Qp9qjRk1WORpfKgwNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] sandbox: add generic find_next_zero_bit
 implementation
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Lukas Funke <lukas.funke@weidmueller.com>
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

Hi,

On Tue, 12 Dec 2023 at 01:53, <lukas.funke-oss@weidmueller.com> wrote:
>
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Add generic 'find_next_zero_bit' implementation in order to enable the
> use of the 'for_each_set_bitrange' macro. The implementation is currently
> missing for the sandbox-arch and using the function results in a linker
> error.
>
> There are more efficient implementations in the architecture specific
> implementations. However, for the sandbox the implementation should be
> simple and portable.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
> (no changes since v1)
>
>  arch/sandbox/include/asm/bitops.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

If you wrote this yourself, this is fine. If it came from Linux, etc.
then please add mention of that.

Regards,
Simon
