Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75515C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D5787258;
	Wed, 15 Nov 2023 14:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kCYu2CD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223F9871AF; Wed, 15 Nov 2023 14:16:58 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5799186F53
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:16:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5401bab7525so10904077a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054216; x=1700659016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+RHIGYXLC+q5TK4U+SMfExFJfPeC59cjURwBnAGqEws=;
 b=kCYu2CD4m2UUMnlwz0ECUH+dns4ApKEV8FPI4+2rQrNI6/qOKPg22ARcroJBt0B9g5
 GJkWd2YWo6HJncbuPOzVRpbAAKvVGTITAvye9erpyX51hqcQNsyWGfuLbcKy4Vnq4WVy
 xghyX4zkCLKPjaw0eyTop/3vqdDgOKw+jhW30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054216; x=1700659016;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+RHIGYXLC+q5TK4U+SMfExFJfPeC59cjURwBnAGqEws=;
 b=YJujHo/V11PqXq/Ajwp2TRl25RN7Jtc5ze1LCQmr3mfWYf3oi14gvhGHsOi0mE0mXR
 +l1kF6y2sTv7IWyfFLe/mWb08dAahC/e/57qZKxj5GjebdliKkMisoVjs64iDXXVmEAu
 mdLzKwrvsf750Sw/2ZzKn7hbbBvnImSime+gGZBds76e9RX4LYBcATmLBJNyUHgK5Bls
 5BCut4fcEYJdE+Fn8mTNeYWhxkfFmtDqrnmH70XoiGblpI4imr2qX2pZpNJQNh+Ouygx
 zJwIOMB1jlbDdSHhvb1REwieq2CIPJ43wNRtnYK7ytfbt6hkdzGuzy8njCNXuAcqxPAG
 JsTw==
X-Gm-Message-State: AOJu0Yw2to6dpKxI1NYehRClXPZOD7wpI4mefW4XBtAqVH93sNSX9LCt
 rK/wl3v8FilJTAkmhS9Y6IndZur8NxOwnS2Z8fFhbErS1muvPvPPfog=
X-Google-Smtp-Source: AGHT+IHNJR8MO96wqvP0GsPhl38Dl6UK3ThzMbcTBSl65hqAIQFs/0pJ0Cf3pWWbO4PP561wbWyCKXP4biI8nWgF38M=
X-Received: by 2002:a17:906:c314:b0:9ba:33ef:fe4c with SMTP id
 s20-20020a170906c31400b009ba33effe4cmr9324793ejz.64.1700054215567; Wed, 15
 Nov 2023 05:16:55 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:16:54 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0iuuaVEmZNGNUFwxSE5xqvbVix+kVnm=68j9mO16inFQ@mail.gmail.com>
References: <CAPnjgZ0iuuaVEmZNGNUFwxSE5xqvbVix+kVnm=68j9mO16inFQ@mail.gmail.com>
 <20231104195733.1576679-1-seanga2@gmail.com>
Date: Wed, 15 Nov 2023 05:16:54 -0800
X-Google-Sender-Auth: DgMMwWv1EzgILwVH99ZoDO_U7zs
Message-ID: <CAPnjgZ3MO9Mhw0tddm7pgpas5HXq5=o4ue4GBUq5oS8OnQwGEg@mail.gmail.com>
Subject: Re: [PATCH] sandbox: Close file after mmaping it
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>
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

On Sat, 4 Nov 2023 at 19:57, Sean Anderson <seanga2@gmail.com> wrote:
>
> After opening pathname, we must close ifd once we are done with it.
>
> Fixes: b9274095c2c ("sandbox: Add a way to map a file into memory")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  arch/sandbox/cpu/os.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
