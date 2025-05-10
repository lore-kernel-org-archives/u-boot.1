Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DF9C3ABCC
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B40D82952;
	Sat, 10 May 2025 13:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HLGH+dcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11829826AA; Sat, 10 May 2025 13:27:42 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E3D082B39
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f6fb95f431so7549236a12.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876459; x=1747481259; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TINxdqc1J+fUDwY3glXUFXCEJ5i4pc9feRSftIYf5RU=;
 b=HLGH+dcL49/uq6bNjCQ/AgC8AI48mGQVZGQAiBmI6Sgzaou7Ub4fWRO5bRC6vnTMWG
 cRriT2EuFELB4q4d+UWqIPEIzphDV9LVrVM5Yc9SzUUdeymOKhRCAiPKT++TOLX/Yerf
 YWX2LzpEHUF/LvoOthjd/n5i+gjmOc7LqE+5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876459; x=1747481259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TINxdqc1J+fUDwY3glXUFXCEJ5i4pc9feRSftIYf5RU=;
 b=hhRlZj2l0+TTQNAbJYEpM9E+pnrRhsarJHwRJ8PUvOIxDBScwx6X0J32EMNWOUMXdu
 2GNHadYOu//deicGnknYZPCRg6QzfqF5raOKMFKPlt0v4NP6NcWIJ1yx3FBd1y/dzZxE
 XhQZRAKVmSEQgUfuXY53kJ56gYcK13yk/XlhwUiZ7Zp3/2lEJMvEXvhE/RLLCTyKzZUc
 UmOf8r00dN911lPODGvD16SkwH4e4jEMG3RModsZSXTqqpdj0NpRkJwJz2yHyVwC5dxj
 5Jf6jucaKjH0U/TcgPQwh+QEuYqgIgpO8m8egonxikuFEnNqa6JMAvpE850UFfhglLx1
 j71Q==
X-Gm-Message-State: AOJu0Ywj2EBr4cq4TLryfHEkI+5mnm39ief+1pe5Zos5Q0DX7h81NGpO
 SiC5Q8bQiovtCb4+i23r2hJNwI1UAnd9g7bN5GeEXUJfpEa9a6RA6K6xqHVWb7KDNhpoHTjXC1+
 joKVR1lnBphnMctFKRT8mJqiIochY/0TGk8WD
X-Gm-Gg: ASbGncus7X+UB2InHucDEdhlZiR/8uDtINyaePkbzFxRfXSSbWGjpmU5saz/+CiXYKI
 OU/rmGDh3w78W7cKJ4NlhqMufHy2Wti07694Z2W2C378RHwxEPmMtJIT2QBML+SCmk31m6C0WC0
 5G8pWHV/BJrREdyPi3FRmMzKYnINZWlf9F+A==
X-Google-Smtp-Source: AGHT+IEBVnQxAVawaXDpWnVO1INP0UjQJZql1Z1JYWSBnE/aYBDnch/+tZ5hlEUtqnJvzLcx3SJ51mEmy2RvS3uJkbE=
X-Received: by 2002:a17:907:868c:b0:acb:124e:81fa with SMTP id
 a640c23a62f3a-ad21b14c3a7mr631798866b.5.1746876459196; Sat, 10 May 2025
 04:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
 <20250508214222.643020-2-trini@konsulko.com>
In-Reply-To: <20250508214222.643020-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:27:25 +0200
X-Gm-Features: AX0GCFttldeg5kwJEOr7eiaPwBowE7pkUPqF6XKSEzbZTLzMPhYXBBoTgcjvSaQ
Message-ID: <CAFLszTiB1Xc9oRWk-kdQ4c-gxNn6sycuGyNYE7+80+2P_FtVBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: pytest: Document the test_bind test
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 23:42, Tom Rini <trini@konsulko.com> wrote:
>
> Add this test to the documentation. None of the functions had comments,
> so attempt to explain what each does.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/pytest/index.rst     |  1 +
>  doc/develop/pytest/test_bind.rst |  8 ++++++++
>  test/py/tests/test_bind.py       | 12 ++++++++++++
>  3 files changed, 21 insertions(+)
>  create mode 100644 doc/develop/pytest/test_bind.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>
