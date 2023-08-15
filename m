Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298C9C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 15:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D00E8679B;
	Tue, 15 Aug 2023 17:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nYsUiIMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64A2867F0; Tue, 15 Aug 2023 17:34:03 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E384586785
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 17:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so4394847b3a.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692113634; x=1692718434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dmqSsucRvztnOnQRvI/YTtAxBTSLn4MG8aNiveTdIe4=;
 b=nYsUiIMK4imTZuFgYnEU2GiESFPgE4xoXELZt3Yz4GuIF3+y0Gq5mZwdMe0LBsxPOb
 UmKmnhZ6dtsLQHO5MimvZGFBMGVExWMNsSXpZhLFoYgtUdoXqTgyUvWs4aPEGztkRzen
 HxVEIkBODX6SoW3+WEPzuMmAhsZEYpvMMYtiz0x2G6eOXilHc1McpHoz8IMBLEGzwcPh
 E7KSmdbCIzUvTheZZBrzM/YT7TUgyLwGgMDSc+VQnvRxIrAkHuaXuLLkxMeZ58S8UDea
 dS1Jxej4GOE/TNfADftDlWlHU2aP08lMIkxasbm3tTdRRr5odbsRt8Ap1cjTZTbJMwaM
 vy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692113634; x=1692718434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dmqSsucRvztnOnQRvI/YTtAxBTSLn4MG8aNiveTdIe4=;
 b=fshNoYMAxqncVbMX4SXWrFm5sKSnMClc1CdlQb00rmqTFgBBTjS2dDEpLnudsmzPah
 YqQjZriJUsdW3re5HSnDWDmDvetnj07t/6mXmlPATlufwwvFGEqofFZc1XGL/tJ/Clhc
 tT+1KKFxPWALPy5PZwIsyLwf+I9bsKXwg+6KrEHq8IVyblzNk4IiKi/tJLbRtzuDutNA
 LF+e6d1GtUuJNdUzUNNk+WzkUDc1lHwnamDzozs+fbfYhNXAzqXZcYq3Vbj7ybuw44i4
 ctBvDVIwtPh7umGrZS4pjCHUOXuLMvknz/eirUWvaLb+YBUPaCecjZPYSg6zLxNxB+bJ
 RsTg==
X-Gm-Message-State: AOJu0Ywnb/2rojuVAN4vxzzYmt6BF2zGc88STAHrmHK4LZbwxDGW8REr
 3KXDKMS7H45OX0HBYJnbtoNzW9tdIeRJY3c+QpajYwjVliOa4919
X-Google-Smtp-Source: AGHT+IFWQ+Cv0mOdhsEzEWK5xFRRrEvzznzAZFS99gVs7jHZasRpa+0NQUfuluxVCQu/8eCE7xwJvZw5htoOrL2InaI=
X-Received: by 2002:a17:90a:c68c:b0:26b:db8:2973 with SMTP id
 n12-20020a17090ac68c00b0026b0db82973mr3012725pjt.5.1692113634210; Tue, 15 Aug
 2023 08:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230309021221.306044-1-paul.liu@linaro.org>
 <20230309021221.306044-2-paul.liu@linaro.org>
 <20230815144227.GI3630934@bill-the-cat>
In-Reply-To: <20230815144227.GI3630934@bill-the-cat>
From: Paul Liu <paul.liu@linaro.org>
Date: Tue, 15 Aug 2023 23:33:43 +0800
Message-ID: <CALG-KHwSCD=R-AFUHBCc4AxVEgyM37k8TH5aYSx9XSMnXcNXgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib/vsprintf.c: fix integer overflow in vsprintf
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tom Cherry <tomcherry@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Yes, I think Rasmus is correct. I didn't have any real cases that can
trigger the bug.
So let's don't include this patch. I'll see if I can revert this in
AOSP's branch.

Yours,
Paul



Y

On Tue, 15 Aug 2023 at 22:42, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Mar 09, 2023 at 10:12:21AM +0800, Ying-Chun Liu (PaulLiu) wrote:
>
> > From: Tom Cherry <tomcherry@google.com>
> >
> > vsnprintf_internal() adds 'size' to 'buf' and vsprintf() sets 'size'
> > to 'INT_MAX' which can overflow.  This causes sprintf() to fail when
> > initializing the environment on 8GB.
> >
> > Instead of using 'INT_MAX', we use SIZE_MAX - buf, which is the
> > largest possible string that could fit without overflowing 'size'.
> >
> > Signed-off-by: Tom Cherry <tomcherry@google.com>
> > [ Paul: pick from the Android tree. Rebase to the upstream ]
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Link:
> https://android.googlesource.com/platform/external/u-boot/+/43aae5d4415e0f9d744fb798acd52429d09957ce
>
> So, this link here leads back to
> https://issuetracker.google.com/issues/200479053 which isn't public.
>
> Rasmus followed up and asked pointed questions, that weren't followed up
> on.
>
> --
> Tom
>
