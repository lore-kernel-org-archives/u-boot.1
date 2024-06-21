Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6502EC2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A32F8856B;
	Fri, 21 Jun 2024 16:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h/2wE8Ek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD0C48855E; Fri, 21 Jun 2024 16:58:08 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914C8880F1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-44218680203so9999871cf.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981885; x=1719586685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ANh61mclIUkpSE+/hJd+KHwSwOJqxkUvFSp6lwka4sE=;
 b=h/2wE8EkyKafnjEpv+lNTLwpU/hRi0oZidN9fgune3d2ZUnoDLG1ne2fAlHwQOzwOw
 nXDJRV/HYKF99yhD08dS1qwMwvP4patlxvO3qh5FEpeRW2iYdO6qtsg7MdAG5xCWWhRl
 eXCMA6YlALGhpnI7SYfGWXl4lIPoxS5h3nw3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981885; x=1719586685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ANh61mclIUkpSE+/hJd+KHwSwOJqxkUvFSp6lwka4sE=;
 b=eBENoxvY9SlSPsH1iCVoQBSJEumwZ0FeZ68GdP31eL1atoBwGjGNXXYY5Z8c500TgV
 Ocu3lw3m+iiwMS97wW2liCZTThmuu7Y5jDU6RgrodFAstkVKUG0KQplVkBKWUA1/8hpw
 XZLlx0o0Unz1iuxvJeibiSkvzdb7+RwnuK2pYWu+CqlVDOT1Zw965mcdwzfiV05qbXBu
 gauMBUvGEIvxKQz2A1ovDY1Fb5q98nnKAb0w9wPTkEhJ7wsr7M+2rtFsYcubCT7ReW/t
 3/jdkw5cwKHczutwNAKgUz4/pHbiGpdd4Mg+XwvYtXhBKaImRMYMWYeIYW6BfbsH20En
 5O/A==
X-Gm-Message-State: AOJu0YzxeRjX+UeqE+QqlYFbWEkjBvBWHh+aoyOUvlmRkthN4nTZdjKe
 eCOXUKaQ/i3TNmUc4T2m1xuNCFsJg5m1gYwZPvB4nHgQr75FJMAs3g508UDUx6yvaH8+YFHYrh4
 Ti1z2QoH90Mh7rO3jr7eDmSRjftr8iZncZzj031LQCfK33Uc=
X-Google-Smtp-Source: AGHT+IFh11Q7cpeCbQcWoXBKwv5tSIvp/ROAkSD1ZvxpOGDIZLhV0kWuarl1HJFB52XWEbW9eaNdlVa3weznKeVuu2A=
X-Received: by 2002:ad4:48d3:0:b0:6b4:fcf7:2a31 with SMTP id
 6a1803df08f44-6b501e2f0dcmr75474496d6.28.1718981885361; Fri, 21 Jun 2024
 07:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240621074720.203001-1-ada@thorsis.com>
 <20240621074720.203001-2-ada@thorsis.com>
In-Reply-To: <20240621074720.203001-2-ada@thorsis.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:54 -0600
Message-ID: <CAFLszTjWK-oo7WnM888sJ2Gt4WizRiL3ftR8aAAT5v0FRKVYGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: develop: testing: Fix broken reference to pytest
 suite help
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Fri, 21 Jun 2024 at 01:47, Alexander Dahl <ada@thorsis.com> wrote:
>
> This should have been adapted directly with or after
> v2021.01-693-gca6583d4e08 ("doc: move test/README to HTML
> documentation") or v2021.01-694-g0157619d5c8 ("doc: move
> test/py/README.md to HTML documentation") already.
>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  doc/develop/testing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
