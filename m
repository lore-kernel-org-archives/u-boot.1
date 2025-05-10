Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D6C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5930082B31;
	Sat, 10 May 2025 13:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z3qzDTME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A64082AF4; Sat, 10 May 2025 13:26:04 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE7F82952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad238c68b35so103670166b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876362; x=1747481162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yDVhSGSC3+4geynwr5r0jH7uMzoE1eZdfBz6semzQuk=;
 b=Z3qzDTMEwVJL95aexo71nFCFbsoyOJoeU2CVUupdxkBwCxrhYDL0Cc5IGEEKydz+qi
 bDhIzHsVc1gkD49xR9GYvubCGzJzCPvGMl7sBvHmNeOXiD+ziA/t/XG5uFpeS0qhjT/Q
 jVTI4QbA5jsJP3FgeuSzP2tLXBpYxNFg4E+9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876362; x=1747481162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDVhSGSC3+4geynwr5r0jH7uMzoE1eZdfBz6semzQuk=;
 b=QnMUwPHJRA95cwDnKfjV2VTyqeWosEYWz1+iYyowh6Sro/wqvLVL58rCQWtm+lTees
 yIPV1NIjtapNePp5ymjWR28vxDBIBePxJD4PjusmxnLRP6fi4538ybM0D2Cye2aGxdnu
 ypn2MdyTi5jBEjyN62Lx0YsktAeVEQl8Qufy1p7ro6yCC8i0VFVEm5rZJO56XUTpnbRo
 uDSUgp6QgZc2r0xJ9nejsi4sFkJQoU5WhBwakUs75gj8VfDvp+RNQMzlZiwIYiP0lP17
 0KiJV1DgUAaLeZaSPLK8R/4WUl//AU2ciR91FNHV9H+I7QXSkVc8pFkIfGc6kDUstcYK
 EKuA==
X-Gm-Message-State: AOJu0Yx1ASgZlrqOKu0ZgRd5d9KuT8ekjG3XkFanN//FTHNO6NCwkfiE
 5uG8itL5PPj96ecgzTHgoYAufJkuBg/BuO/SFpvYrbVYcGrWuqnOcOhr8myl2xCZD0HBalGBLUw
 NI2KjY5P3uN4Xyb1fDpKr/UtfPPrITgYw45qyiiOCf+j5Qaa8SqXUGIyEkA==
X-Gm-Gg: ASbGnctm+833S6pep3DNYZulplnxGfhhjts9MraAnVvPyBWP21ObT32gsg2RApl3CWN
 IyI2UeYUiyeZAMHuWHZolwRVAMQzJDBvOSdCvdUP1EBU4KN30QlGcWU0SkxOZTBSwfznSVtKaq4
 8L14PMTkvCkAPRfSlcZOJHUWiAnATgXzq83Q==
X-Google-Smtp-Source: AGHT+IHcR8gWUzu3zZTkhmcduPd9jWfjtfh9Isi6vJXMl9CfJTrVSyAZXWAYp9nNKTwm1J3uirPESrHJrl5qIh7kbAY=
X-Received: by 2002:a17:907:a647:b0:ad2:15c9:9c73 with SMTP id
 a640c23a62f3a-ad218f7e47bmr556369566b.34.1746876362109; Sat, 10 May 2025
 04:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250507221112.518041-1-trini@konsulko.com>
 <20250507232500.527782-1-trini@konsulko.com>
 <20250507232500.527782-4-trini@konsulko.com>
In-Reply-To: <20250507232500.527782-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:36 +0200
X-Gm-Features: AX0GCFuYQpsOq7DIrQCdEG5KTj9_OJvwSHgaSUb8kFKflLBMMkZPc8YL2t1s3cg
Message-ID: <CAFLszTj8BZFkXYBjJe7VjMz0bTHMXFcgRjoFymyh_WR0L526ow@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: pytest: Document the test_efi_loader test
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 01:25, Tom Rini <trini@konsulko.com> wrote:
>
> Add this test to the documentation. We need to add a code-block
> annotation to the example and indent it correctly. We also need to
> document the do_test_efi_helloworld_net function and that in turn means
> changing the documentation to test_efi_helloworld_net_http and
> test_efi_helloworld_net_tftp to reflect what is and isn't done in those
> functions themselves now.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I honestly wasn't sure if this merits a fixes tag for commit
> d2056e2ed03f ("test/py: test_efi_loader: add HTTP (wget) test for the
> EFI loader") or not.
>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/pytest/index.rst           |  1 +
>  doc/develop/pytest/test_efi_loader.rst |  8 +++
>  test/py/tests/test_efi_loader.py       | 87 ++++++++++++++------------
>  3 files changed, 55 insertions(+), 41 deletions(-)
>  create mode 100644 doc/develop/pytest/test_efi_loader.rst
>

Reviewed-by: Simon Glass <sjg@chromium.org>
