Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1604D1BDDD
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 20:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3FA83BF1;
	Wed,  3 Dec 2025 21:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cY5/G9kw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E009C83C28; Wed,  3 Dec 2025 21:52:53 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA2F83BB1
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 21:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-bc29d64b39dso92712a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 12:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764795169; x=1765399969; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAJkNYPa3yikGxdlsYw23j+TVCRNl96w1L2ykMC1wv4=;
 b=cY5/G9kwwm36kVZI5V7hbFrBKF79IqpeUi8u2e1zN/GsMOgsAczmIO3asTNY708FAM
 wcmOA/jArOXYXR1yP4frOHf5wVcqN1P8NdSnrRwAMJunOcW8JLvGz9IS4ElHrulm3LZ6
 oL15Hht1C+Wpc7pC86b8RaRWkgCTikOYX/9/gFoEWNfbcp0N4J/n7zxevzVan2SdHz2v
 Lkj1DeTOnF7/FUjHf5mYZ4g1E8iLtsSGdxQ6GAby6E8nrWqgshfXc0iJI/RIOIOcOEZ1
 UkGVFX9PKHJ+vGPD/26FVAfAzChSnT47WkLeizF5GfZx4iDGirLwXO6Lufc8ylfeLKKT
 v7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764795169; x=1765399969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tAJkNYPa3yikGxdlsYw23j+TVCRNl96w1L2ykMC1wv4=;
 b=luaHJIKqpymX69y6h8CCDyRNZfLQifYIVnaxHyHqYwjF+QNGyJ3+1B/95fxjgTiAKe
 IBsH5f4pvFG7h9rAVKszB7GmZc1HIlSxCGOF7hHtFg2tE5JjXsIskjxPjXGboeIgIDYu
 2V2yXNQ7brO48y8lL9EOQs3+PQ1hSQBnkJo1nj3Cnx1YA9BK9qMqnM9kEJdCO7t+Xa21
 eXZcxBh9WiIrR7qyBGyg+LMX8d3PeddxL2wXg3AnJxXsxsT3RZdxnPTMamhTOETOfrvS
 DuNb39U00yNpHCelUlN2Fk81HTUccecFvyTHPgKFGkywrmH9zg/dM8Sg+X3W2MbhSxN+
 lCvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSHyUJEXM0n7h2sckPYIdae6UM64ZpqUuILTG2s2Jb8AczsNufUgEaCYvB0OKvNMzdGE0kzi4=@lists.denx.de
X-Gm-Message-State: AOJu0YzfC/i5ny0Dq4wVoC/nBaagq1673fPtwehqbj+g8i0Zeff9cW1L
 fGd9ZNL5MBeey13UfdnnwXmliex7dfnFfmAZ9+0Bw2inxbdhiIY/1ncExVgQLQdd7zydzBi7iKb
 EmUD3i296n8eCQsuNFr1OmC97Z+sAeem40zWZCxybcw==
X-Gm-Gg: ASbGncvISMn8rw9BjFIKzy20hThj0CSu4FPgQVS2pOHPAAQcRdal4yCmMK8WKiQ9Rzq
 r7nAoOjeg2PMXqnwHYGzEzGzPQpJdRqz9Oq8O9xvJMVjBKZXBy+v9bC7lHqVRH5dZzsZcz/aVaK
 haF5J4059gr21eLHdKGM649Onk2AtiEHoa9PcMSFj2/CVnb0nTsSXsdBwVS7MtWukB3rsOm7WKw
 8QE/RttpGMLoBLVGBUU+xFvc9KNB/RzuQOUFK0IEepRdpfPo/mseA7k42tE8uCeovcELKz1Yvno
 1flcIJXB
X-Google-Smtp-Source: AGHT+IFnCgFl8KMiYoY5MSljE8lBjIDPm0RutPVzsHrioFwzt00INYgLd5Y+g0ycO4NOTbM75k2NUWcSHx5G7TYY0CQ=
X-Received: by 2002:a05:7301:28aa:b0:2a4:3593:ddf6 with SMTP id
 5a478bee46e88-2ab92e9abb6mr1860250eec.35.1764795168415; Wed, 03 Dec 2025
 12:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
In-Reply-To: <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 3 Dec 2025 15:52:37 -0500
X-Gm-Features: AWmQ_blueLN951yRSCqK38Wb4LdurKg899VWqb5hd_-1uqo0QwOKXGkxMvrXcck
Message-ID: <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Brian,

On Wed, Dec 3, 2025 at 1:17=E2=80=AFPM Sune Brian <briansune@gmail.com> wro=
te:

> But did you disable also all "CYCLIC" as well?

I have "CONFIG_CYCLIC is not set" which disables all the others.

I also have another patch to disable the watchdog, adapted from [1].
This didn't seem to make any difference (but my ram calibration
doesn't take very long).

[1]  https://lore.kernel.org/all/20250603115442.19971-8-nareshkumar.ravulap=
alli@altera.com/

> 3) I use socfpga_cyclone5_defconfig and only change minimum settings
> that I needs.
> From this issue mentioned to current day.

Then it sounds like it is a recent issue... hmm... I'm currently on
2025.10 release version (plus some cherry-picks). I'll give a try on
master/next once I get some other things stabilised...

Regards,
Ralph
