Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03954C61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 22:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9F7870DE;
	Fri, 24 Nov 2023 23:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JahyZ5WO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BF9F8712B; Fri, 24 Nov 2023 23:50:08 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF83870AF
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 23:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5079f9ec8d9so2466738e87.0
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 14:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700866204; x=1701471004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4V2AsoxZ9H0bnLDzpPD/vm2yERpUrH+fY5OHjM/F+C8=;
 b=JahyZ5WOA5fVUfvWGouWcc3wzO0oEoPxfBHRx2AM16HxWGJf0AoWXbWVGrxH9EqTkR
 zsCzY51nP/cdUO4b1ydxUuyi/WjGb3WVzctuU8nyOAEgoC7FgWRcZH9xnTDxetAXuenB
 egXy7D0w0Xh0OvdIjT0FLZRdc1ldyContypWbyVyn5tFw1+YjnQmyxbDxmju/xlpaMw+
 zgREK3CUCREYUyCXed+XDL5yAmUmAQD86gl/pL72ygyEYwLugk2croofJco3AMN26jI5
 KZLrlbAet4c5swptr/cAOLUBnVsA0+SGdkJ3bEjMJnYuUoWEvwt9isM4cFbjdVPrHl2M
 tDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700866204; x=1701471004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4V2AsoxZ9H0bnLDzpPD/vm2yERpUrH+fY5OHjM/F+C8=;
 b=FoJ14aHC52mEq+BddhpUmUO6guVy8wO5dcXR3v1SSv+GP36lfQdoGZOKrxOaOtc3FP
 oLeLLzNpSWEm2Bkuj7yYavc+Qg5SYcjAMOiI8IOxZLOTnY89pCrs2r0Wc+pt/yoZFNry
 FvSvXBjPuVKVG2gYIh7TRF3qW8VzkA32wELwKYMlwdLJKQdK7YoWZ3E3wSS17XsGQ+/q
 ZIECo3ZGXXzNA42/OIDSzieoVTYXU8V/b8EblBa3Ka1emrBZCovx135Z8cXu/9t59sE9
 iLhm/2JEK+4e5/WMLR5aiv1mvXwNuaF37CdT2AxGe3Y9HvjoqktPxer1d1xrcCOmRQ/l
 DdvA==
X-Gm-Message-State: AOJu0Yzzi9boreFwAuDwbvVf2CPc1aiatbG2FdF1Bnpb0N72VVET6H3J
 qaz4QZ0ZOtlOgKQLzYf0vT7LSGOmvQuIWEeNOj7bPQ==
X-Google-Smtp-Source: AGHT+IGpQjWlnbSr4jun4YDtjVmjlAs4mPu1cX6CPYTirLt0hezYiuXwCQLtxvZZlvPXa2S9UqFa9h+dr1nIDA/1w/s=
X-Received: by 2002:a05:6512:1090:b0:50a:a79a:b32f with SMTP id
 j16-20020a056512109000b0050aa79ab32fmr1481400lfg.0.1700866203716; Fri, 24 Nov
 2023 14:50:03 -0800 (PST)
MIME-Version: 1.0
References: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
In-Reply-To: <CABEcMwVkWqwKVGCUTJw366rM7qk1NGGpJ_Aw8cX4wRCSvJMwPw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 25 Nov 2023 00:49:27 +0200
Message-ID: <CAC_iWjKNf6RxPoKzPjJiLV+UnQES344wb=sqS1wCnQzC+J-Hkw@mail.gmail.com>
Subject: Re: efi: Set Variable Runtime implementation
To: Shantur Rathore <i@shantur.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, takahiro.akashi@linaro.org, 
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

Hi Shantur

On Fri, 24 Nov 2023 at 18:51, Shantur Rathore <i@shantur.com> wrote:
>
> Hi Heinrich,
>
> I am trying to work out how to enable the SetVariableRT service in
> U-Boot and came across your patch [1] which initially had the
> SetVariable RT service enabled in EFI but in the final patch this was
> removed.
> I am hoping to implement it on top of the SPI Flash EFI store [2] to
> be able to set Boot order and boot items from Linux the UEFI way.
>
> Can I pick your brain on why it was dropped in the patch?
> Is there any limitation in SetVariableRT service ?

I recently had a talk about it in Plumbers [0]. Generally speaking, RT
+ hardware owned by the kernel is a very weird combination since you
can't guarantee exclusive access to the flash or the bus and you have
to preserve a *lot* of code alive in u-boot.

I'll respond to your v1 patchset and we can discuss details there as well.

[0] https://lpc.events/event/17/contributions/1653/

Cheers
/Ilias
>
> Kind regards,
> Shantur
>
> [1] : https://patches.linaro.org/project/u-boot/patch/20200331060541.4212-1-xypron.glpk@gmx.de/
> [2] : https://patchwork.ozlabs.org/project/uboot/list/?series=383699
