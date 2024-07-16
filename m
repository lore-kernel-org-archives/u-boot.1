Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B13C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63616889E4;
	Tue, 16 Jul 2024 09:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HcT5/892";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F86889E4; Tue, 16 Jul 2024 09:04:53 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8BD288865
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4f2c8e99c0fso1872501e0c.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113491; x=1721718291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q/OsfrEDgX7Bd9a2W4nWEYnMUbWfuLQ7P+wIyTEUaQc=;
 b=HcT5/892phaGZGONfMgBJzfus+5qr7W7TnuQ+CxKtdS2OZ/WSlGW2CuaLAm9gIjl+s
 GcIqQxsQmrde76sWZpauGm5vkELAMPVQUUxgE58tSZaG4rQcgib1wNT6IlDk9DQR/xLR
 SLXu23VUvDXxluTYjjwLPsegxxc6yUmIbTRik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113491; x=1721718291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/OsfrEDgX7Bd9a2W4nWEYnMUbWfuLQ7P+wIyTEUaQc=;
 b=iFRA0rh8fLSr0n0oX9WHap9qHhBVUQGYX5l/3WlYsjc4FuELYGyf3p2N+Bb/E3CoPn
 SxWcDN6BcQee6bq9pg/1WAxD8ABkH0j/eaeCCeuZ7iENwbzQctwLdkaqNFAESVS7nPN3
 pEhzRJDSqxfzqT4viLwlmzwFh+WSGRBfp5bHuyEB+8UTu0eqiQ5iqoGsJXfOPCePGPF4
 lIIsPilNlRpulJlAkXdjfp54JQJXHYUaJizY8sX0ZLY7XxvyQ4veJJAO1tr3jRklh7wG
 OxH2zZOThA5QQwlGUU9HxLlCL23pUMbSxkRo1bI7+9mbGUj3jZIS5VIZQvg2UiUSQNCU
 bQXA==
X-Gm-Message-State: AOJu0Ywf7tf/mus0XXElt8cr51ZCUAoh92V6WjjloZbu1lov1U3P77Y8
 L9o9m9ScDZ2x3PiJ+OXfiNgYTUWcURjWASUPwga0LkbTKiAmPdcF8cQHpTD+qDrPczqNe4+F5Jn
 pJQbUZG+oGgb9mBRo9HwxFBQTGBKTf5TUL44m
X-Google-Smtp-Source: AGHT+IEqMlGnD6J2kyrMFNZV3STB9cUrABepROIYrZvka2vYCRk42+kUPQ5lD0IBVr3J4PUe5in5pS6m03RZ02gmS/o=
X-Received: by 2002:a05:6122:318e:b0:4ed:26:790a with SMTP id
 71dfb90a1353d-4f4d0788172mr1428606e0c.4.1721113490661; Tue, 16 Jul 2024
 00:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240715184527.560645-1-trini@konsulko.com>
In-Reply-To: <20240715184527.560645-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Jul 2024 08:04:39 +0100
Message-ID: <CAFLszTgnBAiUBnLvvea8AseQGmV4V8JpW+N9WEvdfV5WUWbMnw@mail.gmail.com>
Subject: Re: [PATCH] test/py/requirements.txt: Bump setuptools to 70.0.0
To: Tom Rini <trini@konsulko.com>
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

On Mon, 15 Jul 2024 at 19:45, Tom Rini <trini@konsulko.com> wrote:
>
> There is some potential security issue resolved by upgrading to the
> latest here.
>
> Reported-by: GitHub dependabot
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  test/py/requirements.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
