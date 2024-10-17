Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977CBD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2120890C2;
	Fri, 18 Oct 2024 01:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J7LFnpgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9888589083; Fri, 18 Oct 2024 01:23:35 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E3489119
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbe9e8bbb1so10387216d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207410; x=1729812210; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wDSYZW51vLjDzel+fyfux2SQ6IxFNu9dK85XDMge6Nc=;
 b=J7LFnpgoxbDoeKFZFocVSNm7kScY6TRG9zUHjjuV0YDSjsbsKo857rHrfogFp//8zJ
 GP6qWPLwH8HyfE2+qn7dwChjiM4pzNzjv7Ihk+SBg8Fd32jcVhgMoRYOst5NRH9slxzl
 Co4Gv1fvLZEobSMIupd/G6d2qUNFyfzBTR8Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207410; x=1729812210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wDSYZW51vLjDzel+fyfux2SQ6IxFNu9dK85XDMge6Nc=;
 b=XymO6Kf7donQw9/KWd6pE+AgQkowx8jZvCtkI9tlyx2pbfackmfS7NQFXEZFxx/XNZ
 7VC+oSHcODpVPRhCAv4q4LYinpi/JhBYpjjIovu/5lpwDbbUD/XpfFz2Aoo8odzHf6hV
 L+bM4L77CuiBk2OJ84alz6bU1lidTXeQgCtnoog+NTZIhtqJHVN8LxJYnMAsmXBe1KWK
 O3rMDO1BZFRcOC2omGfxR5/XS1H0iYWK7Q3Wu5Jp/m9ZPpBz3/qsfoYRicLQuRC9Pc25
 5psW9TmI7UjusuPjZtxyHOLZc3nmPjby5ieUGy1J+OYheTk6WjCX7bLAk7OZ7pIBzCZk
 +MlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0xY23QQIaBKSvoHBDQQ2FeQcK/FBBw62bdpzb6hlxu9qW3VMeshwXx1ZHoIALy1kdWKMp10A=@lists.denx.de
X-Gm-Message-State: AOJu0YzeLVvgqlOVn4ggWWQAbeDPyGbaleuRNVT0/Dm19TXgXnwG0PE/
 B+lAlbjTM3Mcmp5qea4PG9yRseJhFDJ68rqNJH7rn10WlpqFc6xSHS6gvotYyhtsVLAq7YKfVWZ
 YmhOUqJPZVOmWx/772my9yXsZzRzdpa0iAXsmIUsepURBrdM=
X-Google-Smtp-Source: AGHT+IEyqbix3/IvkYq1atca7VWvktIa0DKyCuhsH16AXAIa9LJGRO/eBmyKeB4jYdOmgNxeFSEq25fuPZcNozDLy44=
X-Received: by 2002:a05:6214:3901:b0:6cb:c9bb:b040 with SMTP id
 6a1803df08f44-6cde14c5adamr9475676d6.3.1729207410224; Thu, 17 Oct 2024
 16:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-7-sjg@chromium.org>
 <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
In-Reply-To: <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:23:19 -0600
Message-ID: <CAFLszThLt96h=+28HaD3LmUk-wgj6mnQFav40ndxTxXVZDQw7g@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] efi: Use the same filename for all sandbox builds
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Mon, 30 Sept 2024 at 17:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 26.09.24 23:59, Simon Glass wrote:
> > Sandbox is not a real architecture, but within U-Boot it is real enough.
> > We should not need to pretend it is x86 or ARM anywhere in the code.
> >
> > Also we want to be able to locate the sandbox app using a single
> > filename, 'bootsbox.efi', to avoid needing tests to produce different
> > files on each host architecture.
> >
> > Drop the confusing use of host architecture and just let sandbox be
> > sandbox.
>
> As I already wrote in
> https://lore.kernel.org/u-boot/ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx.de/
> this patch should not be merged.
>
> bootsbx.efi does not exist in the UEFI specification.

If that is of concern I can get it added. Let me know.

>
> Without this patch I can test that shim work and grub are correctly
> loaded from a distro image. This patch makes the sandbox misbehave.

Why don't you do that with QEMU?

If we want sandbox to do this, I could add a way for sandbox to select
its architecture. But this patch is correct, sorry. It is basically a
revert of your patch:

3a0654ecd0d efi_loader: correctly identify binary name

Let me know if you would like a selection mechanism and I'll see what I can do.

Regards,
Simon
