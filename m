Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF8EC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C53C0879B4;
	Tue, 24 Oct 2023 20:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9oOInpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63CE879A9; Tue, 24 Oct 2023 20:04:27 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48BD5879AD
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ac376d311aso22783607b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698170659; x=1698775459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fcB3QuQl0TbkTY3efo4pbFPWmuE7L/ltddyabV1TfdY=;
 b=L9oOInpQ4TQ+GX6RRrx5DL52xO6NJj79PXi5ojsXkVvLA8C8R56SDzYn+Qai2/DX+d
 9Hcpl7NQbn16a6diJ7VjUkU706YBLlkhN4gMYVsJhuzS39+Qpp3LyNF41q+6eo9FTsa1
 qNZ4QkXru3R7jFn0gekSQXMabaqan1neAqRo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170659; x=1698775459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fcB3QuQl0TbkTY3efo4pbFPWmuE7L/ltddyabV1TfdY=;
 b=sCbuiuphD8Fp3KaLKbmeNfu6qAVXJihCm3MdP6E7YuJo0VpBDZGfExLI1+LFwtaiO2
 a5i0OeEAyD7EO2mNJKN3Ugg8xMgdcfuteG4KeYPAWOqkKSCpntjgGH2/bdHIghcJ8TGQ
 9PPsMO0ncycW8iF6LkG/sq0uxsK7oZFP3mZq2JHgQubQEbSbuhD28SnKx/Bn3GQ3Hbjs
 mKMV2V0rZ2HX1n+L7OzE1qzu7+DwZwl2jKf6lB00r+usWkWy6s71EoEcgW8XrthyKD+J
 7wq7rX4vYnO0RmS/ADcI5gE5IjskzPOpZQqIibduuOp47WBuNhyJ5QOxJdBVKnXRz15r
 v7nw==
X-Gm-Message-State: AOJu0YxlTofqf30I8LpC3jD7IdpOH4zogQAkwWeZJBmNKuoRQx/2FSGu
 e+2tk+VjC0XDUpOIE0jB9ByPw99732/dRV/p3tEmDg==
X-Google-Smtp-Source: AGHT+IFIL/Y04483DgTNa1tUwMIUxXBMY/0pjyjLGepVaE2uxnVsHxEWg+23dXsQV8AMB6DUEx8FT3zU6NKGFmeqgqE=
X-Received: by 2002:a0d:cc41:0:b0:5a7:c777:2be1 with SMTP id
 o62-20020a0dcc41000000b005a7c7772be1mr13406384ywd.11.1698170659044; Tue, 24
 Oct 2023 11:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231023080103.3780998-1-n-francis@ti.com>
 <20231023080103.3780998-2-n-francis@ti.com>
In-Reply-To: <20231023080103.3780998-2-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Oct 2023 11:03:31 -0700
Message-ID: <CAPnjgZ1nA0bOBW4Kk+eFSJS7d=WF3DQBgVWauXTKvjdS_P6Qcg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] binman: openssl: x509: ti_secure_rom: Add support
 for bootcore_opts
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, u-boot@lists.denx.de, 
 vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com
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

On Mon, 23 Oct 2023 at 01:01, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> According to the TRMs of K3 platform of devices, the ROM boot image
> format specifies a "Core Options Field" that provides the capability to
> set the boot core in lockstep when set to 0 or to split mode when set
> to 2. Add support for providing the same from the binman DTS. Also
> modify existing test case for ensuring future coverage.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Link to J721E TRM: https://www.ti.com/lit/zip/spruil1
> Section 4.5.4.1 Boot Info
>
> Changes in v4:
>         - corrected function comments, 0 for lockstep, 2 for split mode
>
> Changes in v3:
>         - updated function comments
>         - removed inconsistency in setting bootcore_opts to 32
>
> Changes in v2:
>         - included TRM link in commit message
>
>  tools/binman/btool/openssl.py           |  6 ++++--
>  tools/binman/entries.rst                |  1 +
>  tools/binman/etype/ti_secure_rom.py     | 11 +++++++++--
>  tools/binman/etype/x509_cert.py         |  3 ++-
>  tools/binman/test/297_ti_secure_rom.dts |  1 +
>  5 files changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
