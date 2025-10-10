Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC16CAC5BB
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 10:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF1683FB0;
	Fri, 10 Oct 2025 12:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sl/eKYu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D3C83FC9; Fri, 10 Oct 2025 12:36:36 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB2F83F69
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 12:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-639fe77bb29so2735129a12.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760092594; x=1760697394; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HcQjc7s3L/klzs6MvpjFrW9gvlkJ6j80WHNKCn6LT5Y=;
 b=Sl/eKYu4hJGub499iROBOcFQprBEOR2uvuXiaPyHoO57cDLKGmgaMQwpsjamM2wRvx
 x7O/DhsZqYd26ksLRFeaH56+lINT4M7UcgSoB3nDEmiYOmIxyWMQJ2SY4w1lYHYgkGRf
 +HUooHyU571Zv562Qavza2knLGtxnDqAdoSuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760092594; x=1760697394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HcQjc7s3L/klzs6MvpjFrW9gvlkJ6j80WHNKCn6LT5Y=;
 b=xOwv34zBdF7ZZzvFzeWWiQ50dz8bmzDV6rqI+XZEkqTO3x95wO6a+Kr6k6LtWIYdzP
 zkOuatXAOA2jASlSNfLppRXXrnTAVkdpNH5xQKwGRyv6G9UisQTUj68sDb6ILMjpoDB3
 IB7d19+sSbbfBzv9s7EkTuxF2ffLEEM4DMwFV27ze/xXT3KDXjYJzC4UPz1+0Q6r71fk
 Rxn09piu8ErfwcMdlAB/HbseMhT6cf05eU7HGvJxH5cHh8QalKphn+ibKkUqeJRyfa5E
 zmcPDO8nsfSyjeagTxfO21MJcZMZO8AMdhcbqVnf1GE44LqLLweELAlkFH4PoZBfOZSs
 j22A==
X-Gm-Message-State: AOJu0YxIWYZZjIQq6FEsfYTWrAECDkdQaAeaq4nB7CBQOEtL3HjPRgNp
 R1UZ9C9tC8tm5D5uuNI4snO9/zCYjt7PNGXK8Wwi4TzlVOwvnsuAZgJW2vES0eBOgj31qh/aJbM
 I0ibkZJ+vvoZsJMC0pXvpsmVPtjRAJgIylNCYa/PE
X-Gm-Gg: ASbGncvnVPwO1cJDgsVcXNhHTTTlCzp+M1fGqGwOgT0moaL5PDitwDofY3JWk82O1UM
 mlOVn4+C6VQY0vCs0jinPTrf70mbAUZLkz9YMiriLP5I88r+h9NCFlLe+V/2JLeN8TDSEb2kQEC
 ME/zMr9LbrX8ePfcc28jIjRiT+lDNOqDkV4UmJXc/2rtWBqq/WneU6cPtCwnSZDieutyv/XcR9I
 R6rCA2s4KZYJJt/dmU9PQ6BXrG3LQwn
X-Google-Smtp-Source: AGHT+IHrZ/D6TfGYIYmArXU0c/TxO3XHSnLV0OhkMX1HgiP1d46HJFFrJ3rvFdOi2L9XslG5ChcD2E9FsxcThrQEOgY=
X-Received: by 2002:a05:6402:3488:b0:639:fbd0:4e4a with SMTP id
 4fb4d7f45d1cf-639fbd050e3mr4936783a12.21.1760092593941; Fri, 10 Oct 2025
 03:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-5-sjg@chromium.org>
 <20251009173522.GR298503@bill-the-cat>
In-Reply-To: <20251009173522.GR298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 11:36:20 +0100
X-Gm-Features: AS18NWCluFTtwpVQjRdfCZ8GOZxass_ZzkDtvDHzzez7KSON3wyrOYZLG8KKsaM
Message-ID: <CAFLszTisxbgD3WLLQNvfi5MO1Mhbk2V_cCEnMQSod=eE8Phijg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] boot: Move preparing bootdev into a function
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
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

Hi Tom,

On Thu, 9 Oct 2025 at 18:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 09, 2025 at 03:29:55AM -0600, Simon Glass wrote:
>
> > The code at the end of iter_inc() is already somewhat tortuous. Before
> > making it worse, move it into a function.
>
> This is not a great commit message. Taking a look at v2 as a whole, the
> reason to extract this logic from the end of iter_inc is because you
> will be checking it in multiple places. That is a good reason to move
> the code. Adding another 5 lines of code (a single if test) alone would
> not be.

OK, so how about:

The code at the end of iter_inc() is already somewhat tortuous. A future
series needs to call it in from two places in iter_inc(), so move it
into a function.

Regards,
Simon
