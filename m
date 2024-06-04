Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E2DC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 23:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49518879F3;
	Wed,  5 Jun 2024 01:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjYPJ7OO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD6A88096; Wed,  5 Jun 2024 01:13:16 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7357D87D0A
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 01:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a68a288b8a4so214711266b.2
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717542794; x=1718147594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Wf9wuPsx+3XX63Q9cDup0/WINIXm/EpQw8DReG11Io=;
 b=HjYPJ7OOQlQh3bSf3x7uvhzlgA0xo4im/5LhuqgaigNFH55AcaVHghh7K+eSSzXk1A
 iY4w6RJMXi8lcYq6Qs2EAD8xNkxPIWTYZdcCZQdXgnceY4URnbVG2DrrGX8uzSXdTiQ9
 z+FFwnN1TUDXgcVn7xLKjjJxHcvqmZ/BZWQGBsJ3VE7fBZLlj3XyI8wA09l8Xoo1SAot
 dguscrXeznOMroASOUCVJH9GfVesu/rgHFu/jmatv57Y3xABIyBzXgIPpx4hORmCrD/I
 WNIBOOCQIQK8SXk2qMiCcaUvKgdRUfMk9DI0aOr3Qthrlz0huEHbyroGetxaXVAxSoqz
 wohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717542794; x=1718147594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Wf9wuPsx+3XX63Q9cDup0/WINIXm/EpQw8DReG11Io=;
 b=oiBuiafxXWiKkpUP6wUWFvblGUr8/kM5q3OTLe2JKWb25jWRblXycNTSOo8lYxUC0W
 7Drubu+bm3U+oCSx2lEh1DOUkNW7orQxmV05vGdBAKW1oH3EpZiiAxBs1IOMdZAIYICD
 8ZhOhNlqjMqQJFdZn7xs+63h/IOZ3qdDfNQT8URJe4qqmAt29tx6dPjA/j7vy+TU4gva
 GnGm5Fj4i7OUSEQ8N5CXQOMu3F8nGHj00BBnZylMg8xerNJlt0c8jBOb/iVtyw0H4LJs
 rg3fJ53Eq/6kUl4LlM2JVQdKd9xhCqffPbL9c+rruwLHe4v+Zj+JpkyiEYdkA3tQ8Lk8
 WoMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLjSBQ04RvDA27SEAUNACdoil4ysbxWMkSn8thbMaQk4v1PySlUKUr+jae6nSQNZHYvzeyNCjmX8zZ3trSgHWYTgi3fA==
X-Gm-Message-State: AOJu0YzupPl7ddgMBleEdd5tNXuJixpaR3PtFeO3qGidEhfsECj7V+IB
 pqTv/JiHtfgIxAvs0CQV7EkiFxoT+4LsO15ZKkXKPmr40diJ0b3PF7GbF/EY9awNaZ/18fPcxAY
 vM8A4g87n1ZMZ0V1bt6iBxcG78Jg=
X-Google-Smtp-Source: AGHT+IGjKYHwFXsGluUxaP4FR8oi3eiBleX0ne1pzcgyzp58i/uBPEQVNXewycRqTJp22rIkOEeGfQrQIRrVKx6M4dY=
X-Received: by 2002:a50:d54f:0:b0:578:5756:1519 with SMTP id
 4fb4d7f45d1cf-57a8b6ac996mr657631a12.16.1717542793702; Tue, 04 Jun 2024
 16:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527092301.GA7851@francesco-nb>
In-Reply-To: <20240527092301.GA7851@francesco-nb>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 5 Jun 2024 00:13:02 +0100
Message-ID: <CALeDE9NrH1VF81i0VxaUr7mna2acibp8aF1ty=-maJqL7cOUJQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
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

> On Fri, May 24, 2024 at 06:19:54PM +0200, Jerome Forissier wrote:
> > - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
> > has some additional lwIP and Mbed TLS patches to do so. With that it
> > becomes possible to fetch and launch a distro installer such as Debian
> > etc. directly from the U-Boot shell.
>
> Why this is enabling this use case? Or it is just that currently,
> without TLS, is not supposed to be something you should do?
> I am a little bit confused reading this sentence, since to me this is
> already possible using tftp.

A lot of companies don't want to run tftp any more when http(s) is
more straight forward, especially when used outside of the data
centre, it can be cached/proxied etc and has a bunch of other benefits
before you even get to things like security and auth. Also a lot of FW
vendors are starting to drop PXE/TFTP support in standards due to
various things like standards requirements from governments.

Peter
