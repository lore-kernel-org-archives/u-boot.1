Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5636C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391F7810E8;
	Tue, 18 Mar 2025 13:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrR8/U6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A29E817D8; Tue, 18 Mar 2025 13:57:57 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE1881026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 13:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5499e3ec54dso5640204e87.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742302675; x=1742907475; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zW65MGCkwG3SZiJjviYwE8iJjlEsoylm9wifg3NwsqA=;
 b=TrR8/U6gUDJdJd5hZ4/MVRVaEZ4rQ2Fs6VMUzqmjNhuddVkwgXH+IPxILkkf8kOnoG
 Dcq/WaTupYJRrO1yYlQ8/zzsEqwkxRbAb5Ly7ur/+uPss9k0MTWtlwodyo6mn7KeKwsx
 odh9KGxWZnMKJTB3G9SP4hP8yD7snt0EjcTSbLWrxmRFPU9Xl6+M3KknfRC0ssjX6GKg
 NYKwK7ED0nMoKAVOnJIcjMUoDWL0/omvE+W22xQ77mj0xbfVs+ZLvB7Y+CBM4+V6LGQj
 oOo4M83AHTbCayUr5LaCMrIX9WZL/qqnTM6Ye+95Dwtkf+jfucR4tY0UEbBX1VWuJ1ON
 RXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742302675; x=1742907475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zW65MGCkwG3SZiJjviYwE8iJjlEsoylm9wifg3NwsqA=;
 b=nmHKCHSOT8oY7mfnE9wHFestidmI4y3CSvvfJbpPkc3SWpOezm0EGdbVu4Grexq347
 6pabpBFNWNIVMXuBGrgSPFtUhFnFUHMd9prBefm35jLEyJ4wA4YzXfHd688HlZu/KnUZ
 m1CDKMTh/UYAeBKzIebIOPov1Fpb01ENx0YBaJa7y0I563O8pqcXe235BqupgkoqntEc
 krcIdB2bDIV7BrbvGws0cBGfrXDyJ8oJI1zI+sWlFBAwD9VQMid5qO6EdkhIrjNw5lfS
 FOH81CAE0Hozc6uX8ZQI5cRcsrunnAqCiVCxQsGTe4Fsr7ykE0WhdIfJk2M071JiFKxy
 oEeg==
X-Gm-Message-State: AOJu0YwbfzR82tF5TBfXHD8fvhgSFjd83iGGZ72+5GySme+qx4ldo7Dd
 WKKy7qRTgIn0CS18Su6oYqsenNxjXo13sM/T/VcnebhnvqUdAjpKmR8f5GyTL4P9a54Rh5Wa39m
 DzkoFd7sI08ZxwMS4DFqnGXSIoVQ=
X-Gm-Gg: ASbGnctY29nHCA+ckZ0PTyP+OonyjyTY+cLfx6KdZfYdouF2uqctnJBHkj1diltNUkc
 GMnDO2fdCqwiqUUkSRRxbnpvUDltYUvW1m4P1QnXuhAU/jAuL/Xpq/oUuRpJBaweghD+iLKk/jt
 /y2O8J2JYXxIXjl27Enfsv/ZRW6kIYSeU5D0X3pCXwBfeZkan/mQfyTdm3yg==
X-Google-Smtp-Source: AGHT+IGA5LTkFJD5vIt8OzMfJn/34CWZOIG3BeshJXCtVOba7eStuUQy1Q/AlYdyoHTTVvjYzM4mMhyqx7TmY/BTaU4=
X-Received: by 2002:a05:6512:3f07:b0:545:c89:2bc9 with SMTP id
 2adb3069b0e04-549c39aaac3mr9388531e87.43.1742302674456; Tue, 18 Mar 2025
 05:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-3-jerome.forissier@linaro.org>
 <CAOMZO5DRxYEgL7aW4s86i9GBWCZTwTQKQWLw8d-SrrvHmKF-wg@mail.gmail.com>
 <913699e0-816a-4b69-921d-d4ead3e3bf0b@linaro.org>
In-Reply-To: <913699e0-816a-4b69-921d-d4ead3e3bf0b@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 18 Mar 2025 09:57:42 -0300
X-Gm-Features: AQ5f1JoHmYn0LfksKhfApYzjh68P2iKLhju42ccSoc2gFNsR8TEtfsyi6LphjI0
Message-ID: <CAOMZO5CCjFnaiZ_VwNj-eEW0XDhBF=eTPP8M=hfL=QVXDR-gGw@mail.gmail.com>
Subject: Re: [PATCH v4 02/14] arm: add initjmp()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
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

Hi Jerome,

On Tue, Mar 18, 2025 at 9:51=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:

> The motivation is described in "[PATCH v4 01/14] arch: introduce initjmp(=
)
> and Kconfig symbol HAVE_INITJMP" [1]. Do you think a few words should be
> repeated for each and every platform (currently: arm, riscv, sandbox)?

Yes, repeating the explanation for every platform would be better.

Thanks
