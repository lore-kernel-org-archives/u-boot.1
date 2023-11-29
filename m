Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B0FC07E98
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 13:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966EE8706B;
	Wed, 29 Nov 2023 14:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bdYHLpC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7788706B; Wed, 29 Nov 2023 14:17:16 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2051386D12
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 14:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27fe16e8e02so1278553a91.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 05:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701263832; x=1701868632; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYmPIg64Ttcm2VIfdzvw7Ggq8uos3i84wXz8CgEF/3U=;
 b=bdYHLpC8XbpHdmiR0NbsywE05bjRgYxm9MX4J0iBxv7Wn0iWuQKcwhf6ImKGdEQT11
 Ux3h81lW7v5Cic+yK2OTjTy/4UfE/5VgPxA0t1riQmmhxudjXU0lMchgotIdh2LnYF3N
 1P0oRWHqw2eyyKOnMQx+ad4ZWR/CtFfFnWLN+qVVQa1yie71WCx2fRbr36eRKKM6EEpT
 zXd71VfETQUvsmSzI8wzlR2hs2byooUi0gYSAIwtyZIaTq13ej9Wxs/4Ll/Tq8Aadg64
 SGhfGu4t4bYE3wl+z+XgN2P3vTINVjN+XoNiM8Dh7FDl64t5bNQM358gq9m5NtdVXcaR
 kCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701263832; x=1701868632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYmPIg64Ttcm2VIfdzvw7Ggq8uos3i84wXz8CgEF/3U=;
 b=P6UBRsKHAB7PRuM86ZmocB0rfnPi9KHOms/YCotRTsoIcHwEse+oa4XWemryD2YP5K
 zT45JevEpOTHiGFHqfQlngwjs1EUVbNWSuIRMUZVV6+QNYf9324R6n8Y4mvw1R9bXl6l
 O5NeOtVRC38FMJ8tCQl4/2ZQUmQMk8I6PEIlLJ2+ZFlvMQCuMy6Aez+nKts9DPXsFohY
 LntAp+/GC9ZlPfZElutlgPS7ZPRRqOiX8WrqzrETunYT3SeiQDV+pEBim1IEbGVRqXR0
 AI4jen6oHsHPFZf3el6ZgpIhDAsphqfWf6V04zGH4Zohh7NSpfS1b326Nbb+0NcjIY2n
 vrSw==
X-Gm-Message-State: AOJu0YyJWAOy67lrsb+T404/awrx+KOrIqfiO1C9xqi8yEPch/zOfkMJ
 XNdbfJ8ZfBqRcbRinNMw6+YVm57RGb0ruKUYf8e9oqj+lh4=
X-Google-Smtp-Source: AGHT+IFV2TcaNkpiytTzSzmzRkjelujQfu7pTtnA8YXBTvkd/NG9w8A+rS1UlQoEC7eLDIyGfwsIUu4t7xonIfGEu+E=
X-Received: by 2002:a17:90b:1dc8:b0:285:71b5:7b7d with SMTP id
 pd8-20020a17090b1dc800b0028571b57b7dmr18764974pjb.0.1701263832348; Wed, 29
 Nov 2023 05:17:12 -0800 (PST)
MIME-Version: 1.0
References: <OS3P286MB1495F9E99D2BD002B94D4174F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OS3P286MB1495F9E99D2BD002B94D4174F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 10:17:02 -0300
Message-ID: <CAOMZO5CasNqMJ28QcLX-asaLPd+LuPR3B4d=8zqGD1XS=pxD5g@mail.gmail.com>
Subject: Re: TPM SPI issue
To: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Niek,

On Wed, Nov 29, 2023 at 9:51=E2=80=AFAM niek.nooijens@omron.com
<niek.nooijens@omron.com> wrote:
>
> Hi there
>
> I have the same issue as here:
> https://community.infineon.com/t5/OPTIGA-TPM/I-MX8-TPM-SLB9670-SPI-Com-Er=
ror/td-p/472533
>
> apparently the CS is released in between responses. Can you help me solve=
 this?

Which SoC are you using?

In case you are using drivers/spi/mxc_spi.c, there was a commit in the
kernel driver that
allowed to put the CS line in low when idle:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.6.3&id=3D6a983ff5102ff0d859df05ca3f5cf2f6a17c0fad
