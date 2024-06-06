Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835CFC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99531883AA;
	Thu,  6 Jun 2024 17:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Krh5fG23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CA188459; Thu,  6 Jun 2024 17:04:37 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA6A88414
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6ae84d171fcso5227146d6.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717686273; x=1718291073; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uHesfHVe4JezYGN/wMef0sSkERj2UE62aB13MNn76OA=;
 b=Krh5fG23M4zyljJk5szlJ5Dkya0kkVYf4j88JK2I7RNOPvND47HLjuaMyVDRc+iGvm
 FRqydOWxLRy2HcoZZ5weB1VkIRFK3f6bOhw/HF9BZRJgFc6K+kV5aWhFyVHBhrhL0G1x
 Yhs6LDYeQ0u4q1rXdQ8SY6aMZ9Esi/MI7eL2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717686273; x=1718291073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uHesfHVe4JezYGN/wMef0sSkERj2UE62aB13MNn76OA=;
 b=kyZl3ZA7eGEJM7cQdNEindw23tM2FaUHaqNH3bJpU2vPLc8rSIkU5LgJJ9DIjY/MGT
 JTzzQfrGUVOxR+baXM9v7F+NJ/pEFKEGyxekfk39q3/d2diKJC+RV4nyvAN9ByWofeFs
 MybXH0XwGbg8Mac7/VU2mBj/+9jc+6BmHdn6I86DwqmU7wpAD1kGBJymv69rxPM6bakS
 MaOg2jH6fANokpmhVKTwLFPqS9mQyFZ8zdaI3FOMoPkJuvFHcGcsc76mwl/+kz8B+u+I
 RMB5JH61RQzDNTjA4SwGTLZuKt8Xv/ayLHH+4rpJGND4iR/wV2sbRP8oTzZ10KbUHDCS
 osfQ==
X-Gm-Message-State: AOJu0YwrTKdSunWGNwGlJCR8O+N8fELN+QMshhW4j7h7/S9V6hlFuvvw
 vsj1+uiH0sYZ1khKmfZfUJ64Q4cgcBr1EEeiwFnzhj1kB+4bIJHD7U4OVr6kDm3ajOwTEkcCAJy
 48ogLY82SJ0fZfK4ufoP86xVpiXjbiHlmETXSyaN2XO04Nz8=
X-Google-Smtp-Source: AGHT+IHPp2gClKpsrrAJxcSIp0pXoG5BRoC9rIjR1lG59kBBfJ0n17qQ3Ure4hGx6qjM+gPaRb6YpAnWYR8fWIhMjdc=
X-Received: by 2002:a05:6214:598e:b0:6af:3d64:3421 with SMTP id
 6a1803df08f44-6b02bf0ec0cmr65833436d6.7.1717686272948; Thu, 06 Jun 2024
 08:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAMn3X6ODsCzBdpJC-PYAA_Y9WrK4eN84KatHGe-aEQB0yG=fZg@mail.gmail.com>
In-Reply-To: <CAMn3X6ODsCzBdpJC-PYAA_Y9WrK4eN84KatHGe-aEQB0yG=fZg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Jun 2024 09:04:22 -0600
Message-ID: <CAFLszThz1m27488Mc9SVncfUoN4jS1Cr_sQTZchS6NrsL6vwsA@mail.gmail.com>
Subject: Re: Needs a check in the device tree
To: jianqiang wang <wjq.sec@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Jianqiang,

On Wed, 5 Jun 2024 at 07:40, jianqiang wang <wjq.sec@gmail.com> wrote:
>
> Dear Das U-Boot developers,
>
> I found that the u-boot device tree implementation lacks a check for the
> off_dt_struct field in the device tree.
>
> In file scripts\dtc\libfdt\libfdt_internal.h, fdt_offset_ptr_ returns the
> dt struct address. It calculates the address by adding the header address,
> fdt offset, and a specified offset. However, the fdt offset is read from
> the device tree and lacks a proper check. The returned pointer can even
> point to any address, leading to arbitrary read or write.
>
> Could you please confirm it is a vulnerability?

Doesn't fdt_check_header() help here? Where are you calling the code from?

Regards,
Simon
