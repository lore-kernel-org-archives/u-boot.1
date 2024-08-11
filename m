Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF6C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B4B8878A;
	Sun, 11 Aug 2024 16:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lyYNXELk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2D088100; Sun, 11 Aug 2024 16:50:22 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9109887E8
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-49291b02e20so1212507137.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387819; x=1723992619; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nyM+iDwWYon9F/XodBbfHF6PmiqLNBKbNj3I5wtv1U=;
 b=lyYNXELknTsI9GRN1nYIRL0vhZH8NnF6h3pGYFqtaWL+OGXitVnYhINGNPFVBNKqF1
 aGlDgtd0JB4jUf9vrjUuaFDFQZDZhYXx4b+QBuYj+KMyjYbT233mFZrQQOprm8mBnHIC
 BMRWc5XpQqDKzak7FQUIjn6wCENFNK9d1N88c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387819; x=1723992619;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nyM+iDwWYon9F/XodBbfHF6PmiqLNBKbNj3I5wtv1U=;
 b=fXjci5NmqiUBzLydPJ4hNRPakfkhVumRUCCbaq7ZUYAg20GOyOjOqe/CcTYhUPlEz0
 nt6EqMuqfeyxDFMxLIFvzT9+BDMYnt/pBDgDOxoUHQppGmczDlzdRwO+waIktBe2AwNI
 eYwhlvq/Yaqk/bhcr0p3Z03YpjpJOH0QXU2dzxq0BOv4S0VK6uqoEoA+p2v5FzWuDlk+
 r7VUaFYV0SvVihxHvc/sFTKGUF1LABO53+50dmNXESzHnA+1iSaVYZ1kbQFWoSOCmGov
 T0NYcqldoN2TiqjBmVRvc4x8FRlhnRVFHXgDemKR8gryeq/OiCfVoaLagww2i5azpzZX
 Xs6Q==
X-Gm-Message-State: AOJu0YwE8KfLdM5aketO+eAnnUCrsyP5qXAOq5sfyw/divoNAH4MLyki
 y9bh9Xa4jwRlkyPN/jdn71Tqiox+MmP/rOKy8SpqdV9y3tg9HWHdG0/gkddDTSg1TJB7QpW5ImS
 7AKSCmyw3zHc6gbOc1ExElXGCl0QvF+MW58uN
X-Google-Smtp-Source: AGHT+IHPzBdMTakbQ7kpzF8DVVYIS/+R29wRoXED6cav2hneKCROLmZphavQw4WxsuEFXkmD7W9DyESwfHPWQgmCx+E=
X-Received: by 2002:a05:6102:2831:b0:497:954:56d with SMTP id
 ada2fe7eead31-497095425f2mr4117251137.31.1723387819494; Sun, 11 Aug 2024
 07:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEttap-5P=x0WMjVNwVUVhYe8eHtuQKyzbWcSOFjTahOLbZYgA@mail.gmail.com>
In-Reply-To: <CAEttap-5P=x0WMjVNwVUVhYe8eHtuQKyzbWcSOFjTahOLbZYgA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:08 -0600
Message-ID: <CAFLszTg3DXEOGFfTgOCkoopZFzdQdbwcduJHGVpt2eqM4nAQfQ@mail.gmail.com>
Subject: Re: I think I found a typographical error
To: =?UTF-8?B?6rmA7YOc7ZiE?= <kimth0312@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi,

On Sat, 10 Aug 2024 at 07:40, =EA=B9=80=ED=83=9C=ED=98=84 <kimth0312@gmail.=
com> wrote:
>
> Hi, I was looking in the 'arch > arm > cpu > armv7 > start.S' and I think=
 I
> found a typographical error.
>
> On line 45, 'This allows U-Boot to loaded to ...' should be 'This allows
> U-Boot to *be* loaded to ...'
>
> Please check if it's right or not.

Yes that sounds right. Would you like to send a patch to fix it?

Regards,
Simon
