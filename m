Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB010C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 19:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE5887967;
	Fri,  5 Jan 2024 20:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kZqmmuar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5BE8796E; Fri,  5 Jan 2024 20:19:17 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A5218787B
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 20:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d9ac0521c6so223916b3a.0
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704482353; x=1705087153; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKmokWA6Lrj7KczgzuY+UNy5+L69reFVhDrGwLDMUzY=;
 b=kZqmmuarDZImFnMBGNrpl2GJEJJKfD7/pDTd5BwAAwQfvRJsGmR60HZfQ+JfLCQNEH
 5ptJi7p7GPwTYw2O3V7M1kskFYxG1fhHz1eV4Y6JCw99wq96fyz/bP3UsMMGGfjA8ezs
 pGziLfDeMTK8+Lxq/0AS8yp5iWEn/9HqFcP6wdsHdFv2bbmFWr0FSb5I7GSw/nFCXNoZ
 9v/wJ91J8XO9+6xpu7LDXvSscHUl0aUmwcw7CqC+CdNRgcnIVsDYE26FIH1JJdgq5beY
 XZZkr3nKk8VvwZl9H7vYd3eyjWig4o9g6KZ6kjKKCRgz6WvneEMS/FzpxTnMovNZYet+
 6edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704482353; x=1705087153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKmokWA6Lrj7KczgzuY+UNy5+L69reFVhDrGwLDMUzY=;
 b=jxy0VkAF+SvKKBRixCikaXiQ2GQoa4Zd4vrwQdrXDA+gUlA3JRaYRSEZoEnhBLaFqa
 X6qDyEULx6ECXXg9IdrVfpk+qOExF7kUILTn3Rj8zgumXiMUGibM6iTSUjsPwBA6ZykY
 443m4nKmMRFqk/WzUmri3oajvBKv3JY7EnPRuY8tzM7q57YySKo4NGarCjGYKrv0Zwjs
 +7qQagzLxvpmc+sGTAzf2iz52GDyjQ01OPTziTJyF4E0iZBYlqc7HC4egUAcR53qwTYm
 RPc3NZnyJVOTjwheSbLbdm4168Ievixrm99tiQUUD65Mxk+rIqj3HzZiUiyP8G4Nxt4x
 wuRw==
X-Gm-Message-State: AOJu0YwtYDtLtAgiZKStZXTrBkL5uCGP6hoOsG5YjZRDatRpiB1klbdB
 6b0iastCGgN6X9t0YkizZ7d4mERVXkJxnwMMFjw=
X-Google-Smtp-Source: AGHT+IHiX7I09mIOszu03MEeaftcetaJ2k+/+cAwZneaXvV0H8BK6nFjzg0MmzioN/PnRfUtWhxcYHD8rWEBl0PCHS0=
X-Received: by 2002:a05:6a20:ae18:b0:199:3815:307 with SMTP id
 dp24-20020a056a20ae1800b0019938150307mr2225049pzb.4.1704482353462; Fri, 05
 Jan 2024 11:19:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
In-Reply-To: <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Jan 2024 16:19:01 -0300
Message-ID: <CAOMZO5C02Fwe0ci1RW64E2Gxi4BbdDfhDAJx4ycczE_6oW-oxg@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Paul Liu <paul.liu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@denx.de>, u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Paul,

On Fri, Jan 5, 2024 at 3:57=E2=80=AFPM Paul Liu <paul.liu@linaro.org> wrote=
:
>
> Hi Fabio,
>
> I tried to investigate this by U-boot sandbox. But it seems to me that I =
cannot reproduce this issue.
> I put a file on localhost apache server and tried to download it from loc=
alhost.
> I might need a more persistent way to reproduce this bug.

Do you still have access to the imx8mm-cl-iot-gate board?

I am sure you would be able to reproduce it with it.

Thanks
