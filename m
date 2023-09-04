Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD03BC83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4F0869D1;
	Mon,  4 Sep 2023 18:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h3K9n5nq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45AE3863DC; Mon,  4 Sep 2023 18:49:51 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801368692D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50079d148aeso2749991e87.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693846185; x=1694450985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EzJjNoo2sIWChbTis4ZDuJ/D0QUqTTGY5c1Qwr01H/s=;
 b=h3K9n5nq6/UdIdWqMDOqieBPBlG9ynFoBpMnu/pUzfQYnqvh1pGou61bRb20QarCMU
 LlhvpYygbEykqG/LMin0cbdxlgN4v8/UMsTvd3QrrYGpZsFif1HQdMJDg3DvS5+8cYYw
 kwi3Xn3SztkDZWajfU0zBKrpEc9OX/E90uSqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693846185; x=1694450985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzJjNoo2sIWChbTis4ZDuJ/D0QUqTTGY5c1Qwr01H/s=;
 b=iMPK/R1uZNY9g5JiKpypcWvmFpO83g7DTumNSQc4Q/ZaiZQV4k4yI2ofbbilgR3Tyh
 fNR8b/gzopxDXPMDSWAlHf96oqdw3OWOIuGU8Oxjy4SCwaRcHO0TGOSm6eZ5wYSJhEoi
 pFMdXeCTuslurpsou2xFXn9BIV8yVd8KjFkRgHXnLDkovkaeNxwYo7pziRAJ01Dnw1dO
 2YixpW/RcpOyWX/I11NbF54lnnsAQ0eM3PE5z3x48KsFRz5CClNuckoNVgRKxGiY873f
 CIdvF5AsinZ9uMqNEW1SP5TJXh8woHHdHIaWKS8dL8p1yKr1F9QTUVAtx7SgK84cLdJb
 cFsQ==
X-Gm-Message-State: AOJu0Yw/yqvCGiPLj5XVjRF8za2o8oE9YWXhaU7zAp/sJpZ8844ns4Qy
 cMsVDfSt4DhRNyTBPLa+oP30t/QITqCijXjBvESa6g==
X-Google-Smtp-Source: AGHT+IHoRCy7VQeF7rueCojdtjKNTEmeBqiB/KmTU9DdTXvjuzy+cO8RE3W14tPTcXWYafl0MdoYm9uP4mFYBxFdxKs=
X-Received: by 2002:a19:504e:0:b0:4f8:6d53:a68f with SMTP id
 z14-20020a19504e000000b004f86d53a68fmr5458310lfj.64.1693846184548; Mon, 04
 Sep 2023 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_0D22B14196104C56C3E5BB4AD46BCF283306@qq.com>
In-Reply-To: <tencent_0D22B14196104C56C3E5BB4AD46BCF283306@qq.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 Sep 2023 10:48:47 -0600
Message-ID: <CAPnjgZ0mW0gtQdUprkR=BHoHX3pmbAqt2BTcJnH=4LyyzYxggQ@mail.gmail.com>
Subject: Re: [PATCH] binman: Fix SyntaxWarning: invalid escape sequence '\('
To: Rong Tao <rtoax@foxmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Ivan Mikhaylov <fr0st61te@gmail.com>, open list <u-boot@lists.denx.de>,
 Rong Tao <rongtao@cestc.cn>
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

Hi Rong,

On Mon, 4 Sept 2023 at 05:00, Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Reproduct warning:
>
>     $ sudo git clean -dfx
>     $ make CROSS_COMPILE="" qemu-x86_64_defconfig
>     $ sudo make -j8

I hope you don't need sudo

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
>      For example code, see etypes which subclass `Entry_section`, or `cbfs.py`
>      for a more involved example::
>
> -       $ grep -l \(Entry_section tools/binman/etype/*.py
> +       $ grep -l \\(Entry_section tools/binman/etype/*.py
>
>      ReadNode()
>          Call `super().ReadNode()`, then read any special properties for the
> --
> 2.41.0
>

Can you please regenerate entries.rst as well? We need to keep that in sync.

Regards,
Simon
