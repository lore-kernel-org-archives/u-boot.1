Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF53C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3E986699;
	Thu, 24 Aug 2023 16:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bLoskyCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C5F8522C; Thu, 24 Aug 2023 16:41:45 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D2286694
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51e2a6a3768so8958043a12.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692888101; x=1693492901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZeMoUolXxUz+8wbnoOqv0j4d7NE43mGRYLtwm8dFO8=;
 b=bLoskyCYRtNYYeJyf2OGT0m0Rd6Q40Pl96OIMwSBjpmRTbZknBJ/kuZVz3EcBOlQqv
 v84/2epcTQcNV5rxoVNJ2U4KYVjXgTkhtHt/AV5nANQCGgCYQM/tn+yC1u+BIpFKkFAR
 RfEJuyTiqxU6hHW9uO6wYboV5oSv6n9BP/+lpEniqrNUUOzlnqjHB3GWCZidiHhNR1mc
 aX1RKyGKbXgyoUUz76NRj5VuGnqXG+CplIhfLweeRetwm3wkB2lLpo9LnZDiPjAnqnqJ
 jTWe7K88Rp0XAKumY0vsmOHuWS0rLTVvj5YHo3ZYHjXbCVbX51u9GrmC7c8AX5nOa+qn
 e8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888101; x=1693492901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZeMoUolXxUz+8wbnoOqv0j4d7NE43mGRYLtwm8dFO8=;
 b=ArIcCJu1NcECV4DLbBwI3ZsAZZxZk+UBkvhEk1zlVNBgD5GH4Xg76Nv54FHXIPlaQ1
 Er80vzdjNPpKSyFDfnAxofKZvDwg30cvZgli24iAxrrFySV3cbjNX7xNSN7r7Uu0kLJ8
 Jt/7gizMc1zgyOy1WYfVDZ7bEzsdFIOWZrkWVC0NeGnu+uaGyjpViO2+7N8zj/Iorq9U
 lwX9xCGUnx9VdzYWmBCE3LWEJMw9fKTZushNrh8v17v90zVa7t+1TNFgWcCMfA1rHyQS
 2JwJTxCqZ8MPhCMZNjqtyzrCCfbRcjpjLYvs2SfuhvjEbFxGXyi4aIGmDu+R65QxxT07
 QFyg==
X-Gm-Message-State: AOJu0YxcXKnmJKDGj5YOxy0z0CaLWUNs62ppklT8LfStob8yFvdVMddi
 bDe5MvIg19fbDSJauXxVADQZ0KQ3CJWHZAq232clUw==
X-Google-Smtp-Source: AGHT+IEhm2wRW5WC6UsIpGYF0Wp7NqsKo4G2xPWi+RERYiU8dwiHACtuVIcwtzT1PBnhuygXrW7dQBIbjaN1hdLmRmc=
X-Received: by 2002:a05:6402:328:b0:523:4b9d:a80f with SMTP id
 q8-20020a056402032800b005234b9da80fmr10918770edw.15.1692888100893; Thu, 24
 Aug 2023 07:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAKsbxdE8YZRVR4jzcpqWs5K_Y9O298RfH=AqrU0=4CEjLs+U1Q@mail.gmail.com>
In-Reply-To: <CAKsbxdE8YZRVR4jzcpqWs5K_Y9O298RfH=AqrU0=4CEjLs+U1Q@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 24 Aug 2023 08:41:28 -0600
Message-ID: <CAPnjgZ2dd7+tXGBK+RwmLiK00DnMmDvuYrs-4SO940X3KZKoeg@mail.gmail.com>
Subject: Re: u-boot-hi3518ev200
To: =?UTF-8?B?0KDRg9GB0YLQsNC8INCh0YPQu9GC0LDQvdC+0LI=?=
 <rsultanov89@gmail.com>
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

On Thu, 24 Aug 2023 at 06:52, =D0=A0=D1=83=D1=81=D1=82=D0=B0=D0=BC =D0=A1=
=D1=83=D0=BB=D1=82=D0=B0=D0=BD=D0=BE=D0=B2 <rsultanov89@gmail.com> wrote:
>
> Hello!
> I'm studying Embedded Development. Now I'm trying to build u-boot for
> *Hi3518EV200
> *using sources from your repository:
> https://github.com/49handyman/u-boot-hi3518ev200
>
> When I enter the command
> *make hi3518ev200_defconfig*
> I get an answer
> **** Can't find default configuration
> "arch/../configs/hi3518ev200_defconfig"!*
>
> In the */configs* directory, I only see the *hi3518ev200.h* file
>
> Can you please tell me how to assemble u-boot for *Hi3518EV200*?

U-Boot is at github.com/u-boot - perhaps this is some downstream
version maintained by someone else?

Regards,
Simon



>
> Thank you.
>
> ----
> Best Regards,
> Rustam
