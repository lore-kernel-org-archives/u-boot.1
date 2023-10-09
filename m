Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C967CCD6114
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 17:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F15186DA8;
	Mon,  9 Oct 2023 19:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mmZZN2sk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A35686DA2; Mon,  9 Oct 2023 19:57:35 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AFA586D56
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 19:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a24b03e22eso58987137b3.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696874250; x=1697479050; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HQodDi/KaijfzZnC2cxwby1HGey/QDTm7Ekr0eJ8Jwg=;
 b=mmZZN2skzIMKGfjYCbnFZ0/BytTKoGnsE70Pp1FjsRSjJbhypmrPxQRIcg42BVlHQ7
 aemAkXIu/D4TbSG5rbO+X6q2Wk9vb6NgvXbEr1nvml9mHTs7Di80ydkXl1BFm4yK99Bf
 JKTdnbfhUMBdCNbELaZUzKs8Yru+XvYJPK8j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696874250; x=1697479050;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HQodDi/KaijfzZnC2cxwby1HGey/QDTm7Ekr0eJ8Jwg=;
 b=r4hJ2LPfvxOoB8trppmKNWyxp3TA4NN1tL9T+mqTIeWm6h6Tc8hLcSKeR0HY2ZL9j8
 pz3wC45pCSIgHjMnOLMUFoEmU+2nFL/EVgecuxeFYZ7Q+UwwYUOnXCVAjOfMgmL5VWwU
 FAIY+foZKAAQna4MNU6fqOBY2ew6Zv1IDKTzHXbZenEt3LJXvwTPHFqZpK+kBc40ce0w
 lZ7e7EcvdJIToEnyceszTWJa1KFrW1U1BGwhUvhOKUzDU13QwLDKYjgaKYqcqZBLQNN0
 F3QonZPf7QQvDr/2irhY5VaosoG2zo6Hnayr3BNwZDi62Kr9lOtxU4xDCshyhg8iPL7t
 Sz2Q==
X-Gm-Message-State: AOJu0Yx1k2G91ijyvFBrjJPJL5Sof3xsAkBjjzrz/X+ZV6xozq62nwkZ
 XqVKtBGkHtsCT4k1dqlnleHATk7iIb2Vy2CERXpYrqhDpWt9fmbZA60=
X-Google-Smtp-Source: AGHT+IE1sWG7xfBnuvQyNf2HfSY7G4GrYDh6qERJnw91dIJ6Qo4ojIY56Pz2RquI4F5CbrEvmXpoRqwAkBF1Iw6o6JE=
X-Received: by 2002:a81:6c92:0:b0:5a7:b918:26be with SMTP id
 h140-20020a816c92000000b005a7b91826bemr498288ywc.15.1696874250029; Mon, 09
 Oct 2023 10:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231009144151.773721-1-artur@conclusive.pl>
 <20231009144151.773721-2-artur@conclusive.pl>
In-Reply-To: <20231009144151.773721-2-artur@conclusive.pl>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 11:57:00 -0600
Message-ID: <CAPnjgZ1q_TEUzLB3t6H0fw7APDJ5PcYzgnF4Q_3=-nrTVKrLDg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] common: add prototype & rename
 populate_serial_number()
To: Artur Rojek <artur@conclusive.pl>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jakub Klama <jakub@conclusive.pl>, 
 Marcin Jabrzyk <marcin@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?Q?Rados=C5=82aw_Adamczyk?= <radoslaw.adamczyk@conclusive.pl>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 9 Oct 2023 at 08:42, Artur Rojek <artur@conclusive.pl> wrote:
>
> Rename populate_serial_number() to a more descriptive
> serial_read_from_eeprom() and provide the missing function prototype.
>
> This is useful for boards that wish to read their serial number from
> EEPROM at init.
>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
>
> v4: - revert to the approach found in v2
>     - keep the new serial_read_from_eeprom() name
>
> v3: - restore original function name and make it static
>     - provide a generic function for reading EEPROM serial number and
>       wrap it around the existing tlv logic
>     - move the env var check out of populate_serial_number() and into
>       the new serial_read_from_eeprom() in order to stay consistent with
>       the documentation
>
> v2: - rename the function
>     - move function documentation from .c file to the prototype location
>
>  cmd/tlv_eeprom.c | 14 +-------------
>  include/init.h   | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 13 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
