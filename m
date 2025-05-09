Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AF5C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7766822D7;
	Fri,  9 May 2025 14:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eaC2HCNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31C1A826AA; Fri,  9 May 2025 14:22:31 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54368210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 14:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-acb615228a4so601855466b.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746793348; x=1747398148; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NEFsgDDGLTs5Ps7N5n9oYMLc5l7IeRRgSeb5mwSKyQ=;
 b=eaC2HCNf1C2xJ0MHUQHe/jlDR7aiPR9i7rJIrPdBv6THYeuysrlttDKxMZe87Kc+JY
 noz0biYeV5RoCj5p5N3me5qLF7VN/0xzfdiRSbsMhhbVLn+l3lGdaBTdigN6+8iCAGQ1
 k0tMIpMIJVbN0VK89PH+uGbliqinFnVdisck/s7XbwJi1MH8ln/Vk6fbsY8AlLUyWhfW
 NoenhtYB5WEwAXFUYoiWdW2jBd5/4An1PhgGzc9SC8FRAljtUbMDo9LahDWa8knG6AN4
 cByqcs0mbfUodhsltB/mtBwXgCYFB4P0LkL5IZziKWSHTOSH2z0Uq6O6nJSH3Eg56VmF
 5XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746793348; x=1747398148;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1NEFsgDDGLTs5Ps7N5n9oYMLc5l7IeRRgSeb5mwSKyQ=;
 b=AC42r9XXMoKfyneZ0g6TlHqKE1OESMDyDhqrMfi9jwQPHdsEG3+wyoLb+EmPbr0XMF
 1HIdtAouVEoxpTn0kj6+edXaz5K+CD5AqmDJtuNjGLOrlzT5YHJk2Rd0Wl0M6/Wl61Xe
 XhF+zWzQzxm+0iIzrMRE+35bZQAVXg2ySUr3I0FLrb5zFMh+mk5vtBy94hTRGtaM6yal
 Jm2Vcp4sFOF5q75tAAw7pixY6iSN2yg5nBr9IXvFGBcPx++TXG7Y9k57XU9M22VMoZjm
 mFhlL8Nm2gyqzT0YI7L7UyvhZzJIy1G4XH5mSxqdOMvdD4r6B/1/h7kA1+uO7mI+Yrno
 Qv/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNTaw4QMZTKQQdllagbrzLrgeCR9KRf0dbB+hz/wOYCsh+n8ys9QvZjDQEc4KWgLj+9CsyQx4=@lists.denx.de
X-Gm-Message-State: AOJu0YxZCg9a72xPYqEyMQPdCg2vsIZ77Hog3SMv2YgsBPhM53hzVeAQ
 6ztuC6/+T7a5Y4DjIZN3cUpvr8YVTbiv7mrFKX7s4xDSsutoqbJ4a7/2t/wcEsc=
X-Gm-Gg: ASbGncuL5WSANB3HbMD5rHRP2w0z7yPt3Irjqz6coD0bX8PTKO5lnBtFzo5Gi6nSChU
 XLIjeDYdm9G+Xj7/566qNSO9nUhwkrHrRbj2+B6wTB63UuFeH1oD4RLNgwp3FnH5vXGe1e/796Z
 qRK7x2ParEDOF/0JnLX/NhRsTxfBNnMx2MqhXVPUQfxS3VP+mRW32fKvFAwZpLMZFR/kFyTAXyo
 YEq9soPiAr/+LQG4DHWtLayH7/Ow6aM9iNVOEulWB5nbPgq4N2D45zulxBCvkzqgkNiml807A0L
 iFEm+gnjS5Zt/5ZfwyEY7MkB4QWpMsQO7XWFpn3XHAoEdQMt
X-Google-Smtp-Source: AGHT+IHCsqrFITK/4YBNDvkDUeFLgt3hacBmO+fnIkf0UoqF7UR6bGr80G1TbOpGgqAuY2VHc0n8RQ==
X-Received: by 2002:a17:907:a4ca:b0:acb:aa43:e82d with SMTP id
 a640c23a62f3a-ad21b14c5a8mr337278866b.3.1746793348195; 
 Fri, 09 May 2025 05:22:28 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2197bdd74sm143011066b.150.2025.05.09.05.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 05:22:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 May 2025 15:22:26 +0300
Message-Id: <D9RMK91R8Q2I.3BA39TM77AYZA@linaro.org>
To: "David Garske" <david@wolfssl.com>, <u-boot@lists.denx.de>
Cc: "Todd Ouska" <todd@wolfssl.com>, "Larry Stefonic" <larry@wolfssl.com>,
 "Wolfram Kusterer" <wolfram@wolfssl.com>, "Aidan Garske"
 <aidan@wolfssl.com>
Subject: Re: U-Boot support for wolfTPM and firmware update for SLB9672/SLB9673
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.0
References: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
In-Reply-To: <145501C2-B034-44EC-A16D-4F1A150347FB@wolfssl.com>
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

Hi David

> Hi Denx,
>
> We at wolfSSL have developed a port for wolfTPM in U-Boot. The patch allo=
ws using the current built-in TPM 2.0 support or switching to wolfTPM via C=
ONFIG_TPM_WOLF=3Dy. It also supports TPM 2.0 firmware update for the Infine=
on SLB9672 and SLB9673.
>
> I think there is probably some more cleanup and testing needed, but I wan=
ted to submit this to start the discussion and see your thoughts.

It's easier if you CC the appropriate maintainers for each subsystem next
time!

>
> The wolfTPM library is GPLv2 and added as a submodule. If the license or =
submodule is an issue let=E2=80=99s discuss! I=E2=80=99m positive we can re=
solve anything.

We recently added a few external libraries. mbedTLS and lwIP. Both of these
are pulled as subtrees, so I'd like to stick to that.

I briefly went through the patch and I don't disagree in pulling an
external library as long as it's reasonably stable and will continue
to be maintained. A few questions since I am not familiar with wolfTPM

- Have you made any size comparisons wrt to the final binary size?
- Does wolfTPM have stable releases that we can use?
- Is there a CVE policy ?

The current patch is quite big and I honestly don't have time to go
through all of it in detail. I'll be away next week, but I can give some
general feedback in ~10days. The easiest thing to do is try to split it
a reasonable amount of patches -- and only include the bare minimum of what=
's
required to work.

Thanks
/Ilias

>
> Attached is the patch based on latest master 3b6760ddeb4 to review.
>
> =EF=BF=BC
>
> Thanks,
> David Garske
> Software Engineer, wolfSSL
> +1 (530) 409-2990
> https://www.wolfssl.com <https://www.wolfssl.com/>
> https://github.com/wolfssl

