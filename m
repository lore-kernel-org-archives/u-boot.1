Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B90AE7717B
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFF689735;
	Fri,  6 Dec 2024 20:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SGtVEHGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C8828974C; Fri,  6 Dec 2024 20:16:47 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076A088F0C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ee8aa26415so2090021a91.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512603; x=1734117403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fgX1qk/kbyxeWxISZF0oskLsZLObWrA0Dfm+ctBdmoE=;
 b=SGtVEHGEFJgqxH8ypSLV4WbwOx358zs5ekOC8PrCC+Y8Irf6/hLO/CrC6Gy3zI6K2V
 m8wH6xwj5O3VW8GcfbCwjn6LYU6mSEKdaRfqmLXqSLzbmNmxuk36nx/RJ4tJyw1pvyKJ
 Afg9spQjwgBmujZiuB7xLX3jFPVuHm9mTDcec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512603; x=1734117403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fgX1qk/kbyxeWxISZF0oskLsZLObWrA0Dfm+ctBdmoE=;
 b=qSw39u+NHGNyjQQoMLBuLYy2egQZDdExoBey1zVQcfkFfXvIUrjP2Y9cAWGgATHwtm
 7e3R079tuDK4GT8ji72gdsuuL3UKvWTL4mQpFRCNDbpYW2Yqcp/DTnSoqvob1347sSEC
 exPoOEQ5Pf2YZ3xrejh7lEZklsgfGLHvpx/5ANNx6CzmB/dHfECb8ltz83oSHjORpZX8
 aEDUrQ395ZEB8GU5bVZGpvsaxB59tx+/HtDQNU5VxRwqPrPEBGaT11vZbgvyEn288VZz
 /6Ouh+ECUZ/eCyVMSFzto6WBYg6pIdR0b1NVx1W9JsOq0tHTQovmd7FaQxCxKnRVC4nn
 55Gg==
X-Gm-Message-State: AOJu0YyhFx96Mt+PMnFIBle1wK1XjGrSArHQcUAaSC7L2isSqCIfVcoQ
 uU+pqR2kLUF0IKglAlcmJT/ddwbvQ6wtoWW4W/UIXYKG8PogNpOW+RHM0e/DUyiSKfFzS2b+qlE
 9FZpB2vPnbnBwhTTxWzw2KEmBdmyNy+Rn5vCq
X-Gm-Gg: ASbGncuKEwSAdJyGp+5coXxaL+fzo52/KJGAQhpMMWdahPbtyzatvebehrQumzqPuXi
 eSnr3lcAmAKXBOyqSlyD0PAqvSa8ku0iS
X-Google-Smtp-Source: AGHT+IE9if/aUNC2onrXfoT3IPAZ1eEGjI+T7FE/PReNnuBN2nV5NFnyUOWnTZSDo7D/NUNyIFZdHfnrBh13RaI6aXY=
X-Received: by 2002:a17:90b:33c4:b0:2ee:d433:7c54 with SMTP id
 98e67ed59e1d1-2ef6a6be862mr5299591a91.19.1733512603688; Fri, 06 Dec 2024
 11:16:43 -0800 (PST)
MIME-Version: 1.0
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
 <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:16:11 -0700
Message-ID: <CAFLszTji=8atrVcZg9yz4dZdghq5YOcno8r5yNN3jsJZgcujaw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com, 
 al.kochet@gmail.com
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

On Mon, 25 Nov 2024 at 10:47, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Test the property 'fit,encrypt' to encrypt FIT data.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v4:
> - Update the tests to use 'fit,encrypt'
>
>  tools/binman/ftest.py                         |  45 +++++++++++++++
>  tools/binman/test/343_fit_encrypt_data.dts    |  53 ++++++++++++++++++
>  .../test/344_fit_encrypt_data_no_key.dts      |  53 ++++++++++++++++++
>  tools/binman/test/aes256.bin                  | Bin 0 -> 32 bytes
>  4 files changed, 151 insertions(+)
>  create mode 100644 tools/binman/test/343_fit_encrypt_data.dts
>  create mode 100644 tools/binman/test/344_fit_encrypt_data_no_key.dts
>  create mode 100644 tools/binman/test/aes256.bin

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW you could use tools.read_file() as well
