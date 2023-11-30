Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FFEC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 08:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B8F2875CC;
	Thu, 30 Nov 2023 09:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YmJrgQhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6974687595; Thu, 30 Nov 2023 09:39:51 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B9CC87605
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 09:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a00191363c1so89791266b.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 00:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701333587; x=1701938387; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o3iyN8NriZxwOE+nM9tSrMG4PlY7FjiC2aptz1OBjGo=;
 b=YmJrgQhzwUwj514AHvRZWmfeXfsUFy+O8o8gU+DWRosgHeelemlpMjHhryo1oM19Be
 3XwZCHffBMi3T7dtdFY6YjWB9NXWB5rLLrZgl5Fa57mAGSmOm3S3zhfq2IWwjM1VQi4q
 v5up4S3Dur7KRwIEJzWI9oUDxN4OHsMM3gy/nzxIud+MPu1gDehj0tXJ737Rq7s8a5rB
 9Es+sPYqHs2KUBOmUIcEK5caM7ucSlM7Uzyy/PCi/UQrQD1RSwOR5qAWJxivFwL9qWv7
 2uvfh+5pg3K41EAteMrYWRA1YtBy1um6Bm2NduxVLSSsBDp29obrIqjzGlD6urn05980
 iYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701333587; x=1701938387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3iyN8NriZxwOE+nM9tSrMG4PlY7FjiC2aptz1OBjGo=;
 b=gza9E5INMQobMS06/Xw1r6KBqz0NseLj41jaTif7Ifkvcw93Pa0kR9UEi7/QgVyKqm
 XrNQsYsl+Ha1JNyOee3XnOCJppY2vJA3sRQRAxF+VPIdeYJVuXjdWusrPQExPGZAIspF
 ZmHtqsIS13c6eFwXRisXjkmfzXEplUFQMHwGTRO53qV0Mm+uW8PDXuXF8+xQmsCprqHP
 g2lq1pieabJ0dzT+Yh/ayuLH/ReOSkD7vDPJlFGhkFmkAJjD+kfrJUxUfEY30uuCy1JI
 C80MjUweehLfDvoGwnU2sxP5esUK//O/W5JVENi5lPUaw7xWVut8kJpGG6yLQEYTRAFZ
 AoBA==
X-Gm-Message-State: AOJu0Yx6+srzNm0XJXTcQPu9mLfM8EvMjRJUOlp6oWXlYCk8CGnVt1VB
 IN6/cIZPN7SJzq6oaq8B83B1W/ndhiK69Idmfo7ubw==
X-Google-Smtp-Source: AGHT+IHOSc1ZsWmElUwuae1dd7dFeKtoHUr9FWzxm9n7IUL/U+TndDfmOGyEZqHcvoLGzMGp9qehYElE0e/ZBN8IMcc=
X-Received: by 2002:a17:906:b84a:b0:a00:4162:5d98 with SMTP id
 ga10-20020a170906b84a00b00a0041625d98mr16203804ejb.19.1701333587036; Thu, 30
 Nov 2023 00:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
 <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
 <CAJ+vNU3Nun6WWGq-1+ZNUwsEkQXuE4NE+AUiU_ttr+Y+AbXDhA@mail.gmail.com>
 <CAOMZO5ACEd9q4QPmdeSsKWdsN5Gu9smH-VAowpSRhBaxA3pT-g@mail.gmail.com>
In-Reply-To: <CAOMZO5ACEd9q4QPmdeSsKWdsN5Gu9smH-VAowpSRhBaxA3pT-g@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 30 Nov 2023 14:39:34 +0600
Message-ID: <CAD8XO3Z4JLJfG7ceZS6_fOFY0fyQ_7GMQLdLioVp7xxcvDSgUQ@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Fabio Estevam <festevam@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com, goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 29 Nov 2023 at 06:16, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Tim,
>
> On Tue, Nov 28, 2023 at 9:10=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
>
> > Fabio,
> >
> > You won't see this build issue with the entire series applied... only
> > with the patches up to and including 'net/lwip: integrate lwIP
> > library'. My point was there are points in the series where
> > compilation fails which is not ok.
>
> You are right and I agree with your point.
>
> I am able to reproduce the build failure at 'net/lwip: integrate lwIP
> library':
>
> In file included from net/lwip/lwip-external/src/core/init.c:38:
> ./net/lwip/lwip-external/src/include/lwip/opt.h:51:10: fatal error:
> lwipopts.h: No such file or directory
>    51 | #include "lwipopts.h"
>       |          ^~~~~~~~~~~~
>
> Thanks
>

Ok, I will try to reorder patches.

If networking for some reason doesn't work on that board (I tested only
virtual board). Please try to compile with:
CONFIG_LWIP_LIB_DEBUG=3Dy
#CONFIG_LWIP_LIB_NOASSERT is not set

It should make network activity more verbose. In many cases I saw issues
that physically MAC address do not match to lwip initialized value,
and lwip drops such packets.

BR,
Maxim.
