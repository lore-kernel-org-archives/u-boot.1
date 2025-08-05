Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E98C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0BE8383F;
	Tue,  5 Aug 2025 16:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dW+ZgTwT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CABA83870; Tue,  5 Aug 2025 16:46:12 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26D883835
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-42ce1441042so2373785b6e.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754405166; x=1755009966; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY67zIcCSrKKIzteIJX9z7ocENiTR/7gJVsmoc3gsDc=;
 b=dW+ZgTwTkbsBmTuI0dG5ITGB2Bg2gqev34x1PGyH24ofUNnc/x8siM8Zimh3glFbCL
 cilhlegBbgdeMWKLwgD9YIjBvh8iDBOc64dvga/6t5gtFoH31WAXvgXJq7C/HpqW5YSF
 QlMuHFn2kZnktSDZ4kAAS6UhdA39weFda4ASERj5EgRvK2VEcTAZMJAnafZkJeSmg6oS
 k+FBed/KJyN7F1iBF5J+IwTj5pNdgbv4RkvNOUz2MEFiYwdQ7OC1+sSoLfhGkmBWinZr
 DlLSgbajBHJWwjeJ5/qrgvggHKcDd0Cg+2BCakY0cloW37vD0CrLzsncPmW+m/pSytj/
 msXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405166; x=1755009966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nY67zIcCSrKKIzteIJX9z7ocENiTR/7gJVsmoc3gsDc=;
 b=cb057GHy5DRUF8bkihS2egG61RtiYozv/YMe/prU5PXMNTMgEs1/zjYytb1q58RWVF
 soT51r7nAJnDaH0o7bfMiWVeIcy86BP8mcQU19AnBN1sM3yOtmmJOaql7xdHsoDw3/Y1
 jMBeySnBdJwDb2k2+cYk4eZyzoWAQelwF1vb/L9tt4vf8c8JEKbvW1L7Fg5ytdi2Hb2y
 qU7ZSGBw4gpRJXsEc1DcV5sArh5PKcWOiYZkubp/Y8ElTIEda+EVeKU4KqEcGUi7KFKw
 gM6AXUempK4qzNsFOLj9qGVk2ktVLjTl5eMzNhIl80Dxi2EAF/wW5qp7Z/6DNISZvMmt
 l9VQ==
X-Gm-Message-State: AOJu0YweZYbaP0/QpVSE6BAYsq+wTCQSxS4WVQZtvOL34jg4Zytd8JWB
 jZp1thqmTdoVrfExgJgzHoPQWRKEzfipDIYOWO9SpfEISRnWlYEnMKzTg+FUNeGzPsZ3VB5YEwW
 8/T1oJLoZeBjI5SmxLGfIO98jkD/xfbAAUWveisGIriRNX/my8J30LQ8=
X-Gm-Gg: ASbGnctWX51y2SifqvHVZqPQcQUmEn+o6Z9FdI8B2NLdvwL7BtMKs4Z8txPy3NArxl/
 eJCbkVTB1vVU4Nm2yDI++L5yFkQ634sQX9MXam4zQ8xedlvSoZdFnvwmPBY/c+YlDZtsaOCfeFl
 /XoA3frioKqiqE6UafRzgfeuk37csVp86OMw3GaoKffAUzoUtp4wEX4UVGxS4aoaF+RsdWUit0M
 W1ULwaRvTj3Jadl8Rc=
X-Google-Smtp-Source: AGHT+IGbLtaMt0s9QZhhYzK8sQUKmmXecxp8hPf6U0CfvONNtkZ96Ky+tZtGzJ0RA4P6r8BnjsTUsGZPtY88OYFqXEM=
X-Received: by 2002:a05:620a:12c6:b0:7e6:8f41:2055 with SMTP id
 af79cd13be357-7e6962e0c1bmr1652796085a.21.1754399359825; Tue, 05 Aug 2025
 06:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
 <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p97w3vAkvOPp2=OCXrZ5qS8iDDtT0EJ-0iNO-k3LEXMrCQ@mail.gmail.com>
 <DB9PR06MB78490807DEBB894CC3EDE4ACC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p94jcSeOPP9dmPLM=-=Mdd8wd6NRFBvTi2Wn60O=38unMA@mail.gmail.com>
 <DB9PR06MB7849C9363027FCAA3A35085FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB7849C9363027FCAA3A35085FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 5 Aug 2025 18:39:08 +0530
X-Gm-Features: Ac12FXxZga_mQkMhUap9cuR8fQojaHM61lJ5qsqmaWfEvKMC8CP-PUHAobEKEZE
Message-ID: <CADg8p95gBP3UdeJrMvrR-ZeLU3vf1CixfFhu6z5__vj1rxyrJQ@mail.gmail.com>
Subject: Re: [RFC 0/1] use lmb to calculate ram left for the kernel
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>
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

On Tue, 5 Aug 2025 at 18:28, Tomas Alvarez Vanoli
<tomas.alvarez-vanoli@hitachienergy.com> wrote:
>
> >> I am not sure I understand what you mean with "there is no guarantee a=
s to where the first chunk of used memory lie above your rootfs memory".
> >> How is it different to when it was local?
>
> >Earlier, with a local lmb map, one could define a map inside a function,=
 with available memory and used memory which could be controlled inside som=
e function. This is no longer possible. There could be an allocation that c=
ould have happened above the rootfs memory, which would mean that the free =
memory computation would be non-deterministic. So with a global and persist=
ent lmb memory map, this is no longer a robust way to compute memory availa=
ble for the kernel.
>
> Thanks, now I get it. I think for the moment we will keep it like this, s=
ince we are running this code as one of the last steps in the boot command =
(after this, we only tftp the rootfs itself and then boot) and it's not cri=
tical functionality.
>
> >As an aside, I am not sure if you have considered using the UEFI interfa=
ces for booting the kernel. The EFI firmware (U-Boot in this
> case) passes a memory map to the kernel which specifies which memory the =
kernel can use, and which is reserved. Booting the kernel with EFI interfac=
es, the memory occupied by the ramfs can then be marked as EfiReservedMemor=
yType, and this would not be used by the kernel. This definitely can be don=
e on armv8 platforms -- I have not booted a kernel with EFI interfaces on a=
rmv7 boards though. Something to consider for your solution.
>
> This sounds like a better solution, absolutely, I'll look into it eventua=
lly.
>
> Thanks for your time and patience, this was helpful.
>
> Regarding the initial question, I think then that there isn't a case wher=
e you want to greedily check how much memory you can reserve starting at a =
particular address?

Yes, this won't be helpful in upstream code, as the memory map is not
static and can change at any point in time. Moreover, if any memory is
needed, it can simply be requested from the lmb module, and it will
ensure that non-overlapping, free memory is made available to the
caller.

-sughosh
