Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F6EC25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 19:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2025088660;
	Wed, 29 May 2024 21:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dHhTybDj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C8388627; Wed, 29 May 2024 21:49:24 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D633F87FA7
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 21:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3cabac56b38so17016b6e.3
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717012160; x=1717616960; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YRj6SN5/fZtZk0N5PFIBN4tqaOKH4JdTbBv6Q0mnteM=;
 b=dHhTybDjLW7hSjwHGXKxZcFHKejqVlM0uFLwog3dhYUpsF+WufGwlt5WzpfG802N/M
 8qZJLcAm21w5NeUsae+nv5MtER0AXHd/0yzo8VNHaGvtsoQwubLGrZtI6uDhji8mMtav
 oJHA6/0MXWA55hk2HjB/+okdwMHOwTLP7tIpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717012160; x=1717616960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YRj6SN5/fZtZk0N5PFIBN4tqaOKH4JdTbBv6Q0mnteM=;
 b=svA2Z6hPp+RRy5ziGtJzD0j+fxJyQNwB0BbK3ALYCBCkyC+AJ1nePqAeZ9qNaXY3g+
 NmzRnlGaFN9IEhsw1eXODS8PiZWBkwJ9EqP0Obb2GgQ0Xv99HbRGeYSxarTitsgJgDb5
 pKVJnGmJveGdo9tPIdPnC5zPScl0BF8hhoOzb/7n8spdD7q2+phU1MFLweGmBwev+njt
 HWggn/rj6mMKOAtIrXzZl/ID0Svtuy6WN6foZEmGoZw+KRLNDbgdSQiJVqhfCf9Sr6R0
 xepQL7R1XCO4CK4XZ26ZJk8bwa/UmHlBbmThXMjcYJjxblMgF8cYqeka5jGHnGgg599U
 2q8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbkHM7qvHjnoBzdbbWcuQjvToo4FBfx/qvoTyZDSH/GiW4PyZEzTNBLj7yRnAe+BtvTFEmQktvlmHyqLWh8cbqIHdp9A==
X-Gm-Message-State: AOJu0Yxul0R7yw7UQ7dbUWdxZcwgZK5YOlxwQtslXStDhV66LMeULrIO
 4zEyE/7BAng4eLfI8TnWmvMn+wJHZVo8RqMMEx0QD88K8EbOSwXtZzIlrDEW3aPhPUdocMG+sIH
 d2y77LnfeQSaUKDUs9BiBG8VrU6+oxtUnVhbk
X-Google-Smtp-Source: AGHT+IHoDLoZuTOjr0GY0+C/APwIysLO0s7lUw6moBMLLnXVMfkz9THT9UMOKxla6IU7yTaiKRHIFb2WTATKuOQ7tLg=
X-Received: by 2002:a05:6808:10a:b0:3ce:f332:9a5a with SMTP id
 5614622812f47-3d1dcca518emr24004b6e.15.1717012160531; Wed, 29 May 2024
 12:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <CAFLszTj8vfZVW+0YPqcg6ST3MndW=mFJkOz3dJXuFb=P1HP3kw@mail.gmail.com>
 <b10fbb50-18fb-4483-a90a-22ec11db94d1@linaro.org>
In-Reply-To: <b10fbb50-18fb-4483-a90a-22ec11db94d1@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 13:49:09 -0600
Message-ID: <CAFLszTiMjvPk7m9h9RAEPfxtL5B1sY-Y7-VbCEgbjEhL+jat_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 21:49:54 +0200
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

Hi Caleb,

On Wed, 29 May 2024 at 13:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
> >
> > How about using the compatible string, instead of a GUID? Is that possible?
>
> Could you elaborate?

Well, the compatible string (in the root node) is how we normally
decide which DT to use and which machine we are targeting. So I am
wondering if we can somehow use that, rather than producing a GUID
from it?

Regards,
Simon
