Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF3CC7EE2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1D288A7F;
	Thu, 29 Aug 2024 09:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kUBKQlBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8882F88A7F; Thu, 29 Aug 2024 09:02:32 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA698841E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42ba9b47f4eso1541295e9.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724914950; x=1725519750;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L1YczRCxBZFxHWTEBQrzLL19zjDhyJ1sZKGIEOsHEeg=;
 b=kUBKQlBITlAOvYri1L9U5OU78pINzpsDkj5QRWKdJjA7jIL9+rD7NmrfKtVYRDd9Xh
 2BXJR/eDAUbZORJ7LvCCjC3KHCA360/PI/h/78MAM1q4vlEsGiH8ut3cnjtbTWo80RQn
 7IB1kUBZmpLQ57G9VUo6V70PmR0WS9grqSSPASQrOjMlHislg9XxfOtazUmKJ3HrjFhG
 SrMnMVZQIekm4FLWr1JNMvYZfIOO66q1NAemnAlqj4VeWO2w5x8qV4R4gEWMeiwG3Dt5
 OrCmNnUGZL5CRrP9N4FOPfKPbKD3VLiOZekAKQDnNWyJGfDBGvh7FqXwCo49DzxFisCy
 8gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724914950; x=1725519750;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L1YczRCxBZFxHWTEBQrzLL19zjDhyJ1sZKGIEOsHEeg=;
 b=WUszfSXj0wcpsN3zZMf5Ls5qRDXK0OX0kEwTdqyaTjNuPYMIzWHzoek3izCSzFSm/e
 J1zbaPiIalkQ6KVHRTS3/r+ltIrUiUHYVZ+crVdlY+GrT9Bm8Dlr/icjbm6lq/bX95Ub
 SnlH8Z6lw/6xlMK2Sh5Ph123UZWBD2JoSW4zf41tK5YN/+HvHeiyWSDK8P2lCUaGHZpm
 rfUvqmnpHf8/k6M+yeur+sP7D+H+nPZ0JIuP90YSJoKJXcXLuiHO8RC/A+1YM23OmoWa
 Q+DlB1j2JBt0F4sZ6Gty0ANKjnxqLp40ABWdxom7CfeB31rsU/8bQbpSaIcXftCLVhYq
 NKZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA6uOiqydk0TNAiuPVH1OH8epIQeYypVoBzb69rVozNhBx40lf9h7PdE10hTZgQZ8rAby98fw=@lists.denx.de
X-Gm-Message-State: AOJu0YzMrt5o9xHxuQpkBUGMkfb5kICMHlxAdqhgfw8BVtsqkqAYHtcJ
 GiOYNDON5IOTWuQKDR2vj99Zpn8h1wEZpYuYE6ZpYrSXpUPSmyluTIdycrY8+20=
X-Google-Smtp-Source: AGHT+IEh95qGQzCiAY300IYV99aniWm8WqXU/ELaVA7JCQG/4HT7OThKyX3XM4Q+drkQ4qPcwkCcMg==
X-Received: by 2002:a05:600c:4584:b0:42a:b32b:cc65 with SMTP id
 5b1f17b1804b1-42bb4c4058fmr8488475e9.2.1724914949153; 
 Thu, 29 Aug 2024 00:02:29 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0a4dsm7815275e9.12.2024.08.29.00.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 00:02:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
In-Reply-To: <4e154bda-6d7d-45b8-bb7d-ba4d0623a932@denx.de>
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
 <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
 <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
 <CA+Gyqea1r6rP8gXfS6nOtOaKZ=sJ1+z_KguGzzJygQKmSNRakw@mail.gmail.com>
 <c7c61399-8b64-471f-bfcb-71afd387317b@denx.de>
 <CA+GyqebS7gVMpLJuMdxN9c8U=CpBLiTuFkqm_4-bA+LstLJpsQ@mail.gmail.com>
 <a86dd37e-2e55-4947-b665-06d68831b63a@denx.de>
 <CA+Gyqeair5Ak2-b32JL9PkoPrJaa9dg1NwQ3s+8+ycCxdv-HDg@mail.gmail.com>
 <5a278214-6343-418d-b1b4-05804585319c@denx.de>
 <c4e92485-439a-4216-a4d9-ab192e0bca80@denx.de>
 <CA+GyqeZ+_Lg7Jrga5N2+kAvWcM4Vtkv3hyqEs=+o583PoGw0Gw@mail.gmail.com>
 <4e154bda-6d7d-45b8-bb7d-ba4d0623a932@denx.de>
Date: Thu, 29 Aug 2024 09:02:25 +0200
Message-ID: <87bk1bstfi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On lun., ao=C3=BBt 26, 2024 at 16:40, Marek Vasut <marex@denx.de> wrote:

> On 8/26/24 11:12 AM, Zixun LI wrote:
>> On Sun, Aug 25, 2024 at 2:13=E2=80=AFAM Marek Vasut <marex@denx.de> wrot=
e:
>>>
>>>>
>>>> I am looking at the usb_add_gadget_udc_release() and
>>>> usb_gadget_probe_driver() and I am thinking, sigh, all that code is
>>>> ready to be replaced by something cleaner which does not use this
>>>> special struct usb_udc and udc_list, but instead only uses U-Boot DM
>>>> udevices . But I am reluctant to ask you to do all that rework, because
>>>> that is WAY out of scope of the problem you are trying to fix.
>>>
>>=20
>> Thank you for looking into this, refactor udc core could make things cle=
ar.
>
> Sigh, yeah, I think you ran into part of the UDC code which is just ...=20
> not great ... sorry about that.
>
>>> Maybe this could be a start (compile tested only):
>>>
>>> https://source.denx.de/u-boot/custodians/u-boot-sh/-/commits/usb-udc-ud=
evice
>>=20
>> Tested no regression with usba_udc.
>
> Thanks for testing, patches posted.

For reference, the series was posted here:

https://lore.kernel.org/r/20240826143851.8020-1-marek.vasut+renesas@mailbox=
.org
