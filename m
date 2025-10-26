Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A640FCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 14:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8C083710;
	Sun, 26 Oct 2025 15:27:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FF89qNK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC7583837; Sun, 26 Oct 2025 15:27:34 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D764882E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 15:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63e12a55270so5351812a12.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761488851; x=1762093651; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuvhzIPLq9HhzldqNIm3e/HnOf2i2O2jMs5djytGFoI=;
 b=FF89qNK6b1yBZrM42XHlDHCtxIbYskGI3zIz973y8vK+m4/dSWuAapGLPd641eX/hZ
 T4vShYT7dD8T36GzGhl3SvC4QS1fcBLpTh0ybqIGr6E7NiErWzDZBgMK+e8x0JNi1sT2
 WHRJVBJdxa5RiuVwvjcaA1zdfBWe3yxb9E7mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761488851; x=1762093651;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZuvhzIPLq9HhzldqNIm3e/HnOf2i2O2jMs5djytGFoI=;
 b=XERb9L2KxsDxkdNHkIkHhbpXdzKxGSzRSZvduMp+6JYaUBMj3kwY8NT12CZC6/Bndz
 kRr76KaMIXgztvIiJr1QYeOz9PJVKyB0SEzozzo5YhkONAt4iKESeUG58t3IVQJ6tjcs
 n7PK23iwEVftFyhUPv3hVBL6cUs4kx2yhNIDbvuHEvTu95cMIZsQp/3Y4c7838LcciMJ
 34Cswe2Zd/jhk1XreZRJKAG3LeEdCFJBzzPo/6wDZuyUfvkNu2JFvu5HF7lDCWrFwxjx
 q2ezfHDsLLHczJ3mjLuFczDuiVf4DvuDl0YZkIjNfUZ+2S4rkvm7shrC/vRASrnyuZrm
 kyrg==
X-Gm-Message-State: AOJu0YwZXF20n6u0Z3OOj0/YWJ1dr6hYz1tNcqRMigMFfSb8sIwYomXT
 8Nm8ZKRwb7uvP3T/k/zyn1EAEZQon+cIE5wdLa9EslKn0iTEzkruuoK8mDItmf1LN5RNe1Jjz4m
 Ju0UKsUcD0IcUBHSql9/xUj9vZZNQKyYLT/DrclzRg+8K5prLdY6J6Q==
X-Gm-Gg: ASbGncvPw4FYhroguuKj/2Pyebo/xmw1zKHlKOuOKzIfEQIkQV6ueBwQZmUT8xSepL+
 KSoQo3hQA4uQFGM1IJRm/lHh0GKL/654ig26mVO+tV8P+Wiy8r83CgkKZbIj31NgRRrJh/VxORF
 wjmLN0oIoH48bCe+Bt9I9EKy0RcruRj54lYULGlSuNrNvRK6SK8NpxmGq00sEjOWdN32QSBvWlY
 22PDRAIkCOfZTx/ZAy1Ctoh8GVn8p0dvO3ho7l+IZ6MVhskWMFfbdI/UDDs
X-Google-Smtp-Source: AGHT+IG1//K0NUNKmFJFdjGcYicaAFG4GYg1z0ybVlzT/qgGzpDXZJBe7lzh/dtGj/R0mfZr0YYfKznHJ3+p+rEE8co=
X-Received: by 2002:a05:6402:1d49:b0:63c:43e6:16f7 with SMTP id
 4fb4d7f45d1cf-63c43e618d3mr32367169a12.26.1761488851311; Sun, 26 Oct 2025
 07:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-7-wolfgang.wallner@br-automation.com>
In-Reply-To: <20251024151219.100970-7-wolfgang.wallner@br-automation.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 26 Oct 2025 14:27:04 +0000
X-Gm-Features: AWmQ_bnjl-zDSiPrSEcqdDQ72fvdbf0JQ5JApuOd8QbXnGmT-KrvfqeY--2DiNc
Message-ID: <CAFLszTj_d7nAE=CDq6Ueo8OMqG3yZ=40WGCkoEnRSjxVDQ_jww@mail.gmail.com>
Subject: Re: [PATCH 6/9] bootm: Fix typo in bootm.h
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
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

On Fri, 24 Oct 2025 at 16:12, Wolfgang Wallner
<wolfgang.wallner@br-automation.com> wrote:
>
> Fix a typo in include/bootm.h.
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> ---
>
>  include/bootm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
