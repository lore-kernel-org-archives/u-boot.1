Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2547AC3DA6E
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 23:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7E387225;
	Wed, 15 Nov 2023 00:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jTjxuQ7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7BE863C9; Wed, 15 Nov 2023 00:31:00 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7731A871FB
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so9591907a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700004601; x=1700609401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9BbWMr02KN2wQdbEq7oMo1blnIEQzY9jhoWFdjeTtlM=;
 b=jTjxuQ7xe4lwpsaNL186LqTnLuylrr8xrSyiH/ypuhCpYy9BjgswfJbXrnbMXyfQxj
 LDH4P+q75dfWPmzsQ4Rnr1PjFTgdQS7XTsLDoKsGHYCxXd5IgeHFop5+K7MDCk7OEvVx
 jEhfkd+F0Ukuxjk6o5pUX/eRVEXNqiyZt3gK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700004601; x=1700609401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BbWMr02KN2wQdbEq7oMo1blnIEQzY9jhoWFdjeTtlM=;
 b=OJrFaEQ4Xs8bCryVDGWDoIeB+gouqNzy+sSu01/VL6TwC3dI8I3DBtGKrgG9+V1Zcd
 pKsDJVBU1t5S8U++7rtR8j7wNiX0iOLBRC0ylVGQdxb5mxUGe6Q3rSXKgudnIQgv4Fwz
 osnirMTqUrJ0r9Vo/SlUmrfDDGOa2xxhfj+Be6U58Bb7LO9/tqqIfLAjr+9WzrzEapMF
 g1oj/Yls6mc8i4yDmvxteRzUfIENXmRb9BVc9Ux0Kdw8q/3zg784BzvTZVb8Ar7XFkcG
 F11/P3HbVy8w+GuJrSDAu2uQ9scI2dCafLzF8fxhAYB7RRuCi8jLYY2O/wuHoZ5clUtP
 2iTQ==
X-Gm-Message-State: AOJu0Yxsx3xfVrS2mjFbMXZiuLHdw7RdaBqOZ74FmrJUieZAs9suDWG8
 P6LJFqPmKOpCM0CNQpbM3oDTPyh7QLc7rmcY2bzp6w==
X-Google-Smtp-Source: AGHT+IE1b6kZLIxNSt+g1PW8SM9olhEE1Td68gaCUVKi9xnPw9mo1vsZSD7jjJPXu/8vF2/DdJC2vEywBCL9+RpJQ68=
X-Received: by 2002:a17:906:32d9:b0:9cc:97b:5a15 with SMTP id
 k25-20020a17090632d900b009cc097b5a15mr7465837ejk.64.1700004601428; Tue, 14
 Nov 2023 15:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20231114110257.2488-1-ivprusov@salutedevices.com>
 <20231114110257.2488-2-ivprusov@salutedevices.com>
In-Reply-To: <20231114110257.2488-2-ivprusov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 16:29:46 -0700
Message-ID: <CAPnjgZ2yUAKoU9mdFuPvn4Gi+ERFinqv55uqDVOQ+xpbNrYUng@mail.gmail.com>
Subject: Re: [PATCH 01/13] sandbox: move asm-generic include to the end of file
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de, prusovigor@gmail.com, kernel@sberdevices.ru, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
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

On Tue, 14 Nov 2023 at 04:03, Igor Prusov <ivprusov@salutedevices.com> wrote:
>
> Generic version of io.h should be included at the end of
> architecture-specific ones to make sure that arch implementations are
> used and to avoid redefinitions.
>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>
>  arch/sandbox/include/asm/io.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
