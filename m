Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB67CA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5143869CD;
	Tue,  5 Sep 2023 20:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M1QfssdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4646786575; Tue,  5 Sep 2023 20:16:48 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5633D869DD
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5009d4a4897so4803045e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693937803; x=1694542603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kdWeODZXc7NsPo51rTHwj+Uaamkh5IMbLXuhCpmn1Tg=;
 b=M1QfssdRJPpL6cLCEBbcoZFCnHNM7OgGpKvqsnF6OW41RHv5buzYC0Y14WeN+x0vbj
 RZslK8dBoFereB9bhL0HndVI2CAMUYbAbQINwvoEK22N6U0Mef4Oh4hWXR/VWr13wQDW
 eTMMolkLvneqmp0kcub8eYPqaevQg/PFHNwyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693937803; x=1694542603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdWeODZXc7NsPo51rTHwj+Uaamkh5IMbLXuhCpmn1Tg=;
 b=ZQamhW5Hwz8uprVS0NMqmVbmJMJOlrxFFFz6q3PEjevmDA4S9EOAazuJOzZp1g7vNX
 CPX7a6k5OWIdgRAXMhP5UHKw2ixF02mZ272HDw5dfXikZ1vnclPPUfCExYnze1ALu279
 AgM8v29wJH0/zKfwn/tPZX2pFh3YsTsl2imzniBIAWmszNXWNYYqFEH6B9UpOvcU2ISR
 QQXsHjDrp4zfI3LnPL/BLmaO5oQaNSJkOyHmGp0s8A145bghe9cFiBzY34zbbfQ0y34u
 vAToTFWiEYiJbuBJn3HuzPtTeXAzBB3SV1zL+MELXEdcOi9SyC+rgQpF9E2UINpuDp39
 Buxw==
X-Gm-Message-State: AOJu0YxzDgpg9C7Ps1vQeF51152CArK89YmN4JyGxDKI8EbqIP5RoVms
 hmKKug7UwcftX52LS12OYd1pRJ48lw16wFquO3v4MA==
X-Google-Smtp-Source: AGHT+IEf1JfNhqZeJyLTyvITS/yFV34L8txNZB9+jrTG6mksikKPJ3/91lIXDORTWfy6uiZyy71028f6i6iysqI9flU=
X-Received: by 2002:a05:6512:280d:b0:4ff:8d9e:d36f with SMTP id
 cf13-20020a056512280d00b004ff8d9ed36fmr592702lfb.39.1693937803458; Tue, 05
 Sep 2023 11:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A957A85155C40E033B2189AC8CCB3995F607@qq.com>
In-Reply-To: <tencent_A957A85155C40E033B2189AC8CCB3995F607@qq.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Sep 2023 12:16:34 -0600
Message-ID: <CAPnjgZ1fWjL_qy+W4ygOvA2dDjK2v15zTJFkeNdqSSCDq8FuWQ@mail.gmail.com>
Subject: Re: [PATCH v2] binman: Fix SyntaxWarning: invalid escape sequence '\('
To: Rong Tao <rtoax@foxmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, open list <u-boot@lists.denx.de>,
 Rong Tao <rongtao@cestc.cn>
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

Hi Rong,

On Tue, 5 Sept 2023 at 05:47, Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Reproduct warning:
>
>     $ git clean -dfx
>     $ make CROSS_COMPILE="" qemu-x86_64_defconfig
>     $ make -j8

I cannot repro that...what toolchain are you using? Could you send the full
build log?

>     ...
>     u-boot/tools/binman/etype/section.py:25:
>     SyntaxWarning: invalid escape sequence '\('
>     """Entry that contains other entries
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/binman/etype/section.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
> index fb49e85a7634..30c1041c7e8d 100644
> --- a/tools/binman/etype/section.py
> +++ b/tools/binman/etype/section.py
> @@ -40,7 +40,7 @@ class Entry_section(Entry):
>      For example code, see etypes which subclass `Entry_section`, or
`cbfs.py`
>      for a more involved example::
>
> -       $ grep -l \(Entry_section tools/binman/etype/*.py
> +       $ grep -l \\(Entry_section tools/binman/etype/*.py
>
>      ReadNode()
>          Call `super().ReadNode()`, then read any special properties for
the
> --
> 2.41.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
