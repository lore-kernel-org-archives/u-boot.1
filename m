Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E88AD2E9E6
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E0E89368;
	Mon, 11 Nov 2024 14:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LS4s4Da5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4AF89232; Mon, 11 Nov 2024 14:03:50 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D54C889366
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d473c4bb6so4192590f8f.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731330228; x=1731935028; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RucLlCXwQum08jdr0/0VPfmgkaLzY2tpZGSbiiUaGbo=;
 b=LS4s4Da5mRzrGo+VF3k2/Z6DG3voAoEpfeJChDjBDtwYr1zAFt9AtwkTNuYKT0kub2
 AcAL7VEPT+THz52Y56iIZhFozXSbVtvd/zDtVkDi2jSeGA/cdbbpkS2dAmMhuIjkpcru
 cNN2BIn9W+YLPT410l3BUt1kXiaFFCKiOkIXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731330228; x=1731935028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RucLlCXwQum08jdr0/0VPfmgkaLzY2tpZGSbiiUaGbo=;
 b=K/MR2VfjPOYE1xKRkGQZ3mBBlYlShyWvStf44Mq4R2eYqTLyDUakPVhQNBXa53av4+
 c11B943sWzCyCc82/emxF290SAZ8+5t+lVKe6rgU/wpzvYbYRbYM0kAlnJURKzUdxQRz
 K4iKXEQKdf9p2RpO456xax9cSQjMla2lrEo9eAHbZNv5v68lutEjiq10//hISYHIgKh2
 X7FOla+dQiweaQNBeAhgWVZLyvdrMHGHvq7wO+wnlBZ+gvOtZtuIe1iFQMOaNybDPMzZ
 ivMsHgxYtgrsLz/zPNbi06SkASwygzJzRrCpw6aPKCHi67ycNFS1NNwY74mguWRfL7ln
 ocgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsiOZUKm3NH4ylXkQqeg9h3c1mHTCuv/FAIbgQ74zFD8NSnJlm2druwvI75IUopB6ktE5q8cQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwZYUULGtt3IGxL5YmsKb69EiBlVGJ2Hgk1NV/YkWSHq0Zv3D49
 vpVgpVlH+BV9eciGGGI4qdwhlESw8Rtx6rFIJ92E4JyxB0cGeP8+w2umYTHjyBXx8tfpbfEt/zM
 At3pnsIYgrSqI0dJmB4puKXtGIoLmO6O97NhN
X-Google-Smtp-Source: AGHT+IFnI6YrsQXX2PRmr08YzeQgQxdsuCVTw6FQJ41SBF1NYXAQmUAWg4WjbAm+JirynHCjrc4ioJDpTBy56znRUhs=
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21c0 with SMTP id
 ffacd0b85a97d-381f44325f1mr8498974f8f.57.1731330228155; Mon, 11 Nov 2024
 05:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20241110083017.367565-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Nov 2024 06:03:32 -0700
Message-ID: <CAFLszTjxOTvckDzO0-Shda7q+rcKxCLQF7+8Zpmm8eLiXNLKwQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6]
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, Anton.Antonov@arm.com, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 u-boot@lists.denx.de
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

Hi Ilias,

On Sun, 10 Nov 2024 at 01:31, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> This is a respin of [1] adding https support to wget. In short
>
> patch#1 enables the crypto algorithms we need in mbedTLS
> patches#2, #3 enable anf fix the lwIP part we need
> patch#4 is adding https:// parsing support in our wget
> patch#5 is making https:// the default for QEMU lwip defconfig so
> people can easily test
> and finaly patch#6 updates our documentation
>
> [1] https://lore.kernel.org/u-boot/20241024112449.1362319-1-ilias.apalodimas@linaro.org/
>
>
> Changes since v2:
> - Use a bool variable for https:// support instead of relying on the port number
> - changed a memcpy to strlcpy to avoid reading extra bytes from the source buffer
> - Removed unrelated whitespace fixes
> - CONFIG_IS_ENABLED -> IS_ENABLED on mbedTLS header file
> - Add r-b tags by Jerome
>
> Changes since v1:
> - re-arranged the Makefile objects so they only get compiled when TLS ie enabled
> - Fix all the applicable remarks Simon had on the wget patches
> - Fixed the title of a patch pointer out by Peter
> - Rebased on -master
> - Collected r-b tags
>
> Ilias Apalodimas (4):
>   mbedtls: Enable TLS 1.2 support
>   net: lwip: Enable https:// support for wget
>   configs: Enable https for wget on qemu arm64
>   doc: uefi: Describe UEFI HTTPs boot
>
> Javier Tia (2):
>   net: lwip: Update lwIP for mbedTLS > 3.0 support and enable https
>   net: lwip: Add Support Server Name Indication support
>
>  cmd/Kconfig                                   | 19 ++++
>  configs/qemu_arm64_lwip_defconfig             |  1 +
>  doc/develop/uefi/uefi.rst                     | 45 +++++++++-
>  lib/lwip/Makefile                             |  3 +
>  .../src/apps/altcp_tls/altcp_tls_mbedtls.c    | 49 +++++++----
>  lib/lwip/lwip/src/core/tcp_out.c              |  8 --
>  lib/lwip/lwip/src/include/lwip/altcp_tls.h    |  2 +-
>  lib/lwip/u-boot/lwipopts.h                    |  6 ++
>  lib/mbedtls/Kconfig                           | 12 +++
>  lib/mbedtls/Makefile                          | 31 +++++++
>  lib/mbedtls/mbedtls_def_config.h              | 52 +++++++++++
>  net/lwip/Kconfig                              |  2 +-
>  net/lwip/wget.c                               | 86 +++++++++++++++++--
>  13 files changed, 277 insertions(+), 39 deletions(-)
>
> --
> 2.43.0
>

Can you also please update doc/usage/cmd/wget ?

Also test/cmd/wget ?

Regards,
Simon
