Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BDACD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 23:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C41800AE;
	Wed, 13 May 2026 01:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHx57t9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1BF83E36; Wed, 13 May 2026 01:48:32 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6431B80086
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 01:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5a865d1547aso6351546e87.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:48:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778629710; cv=none;
 d=google.com; s=arc-20240605;
 b=lnJTM+zOixnWRsslsA7agk3Yr51U3MP7+lpdvXKh9teuDkI/ANYjlwyWCTwypxGubw
 CVOmYhQH7o82xbqU7EzRKVolEbx5ttoyIH/hNCaHV4/o6HtlAp1rfAIlL6wiuSC0XEA3
 5QYbHyHj51X58PUjUMGi/62VRo4GpEuPSK7chu5uQu7YCeinKWBopfybWMJsJpil82H5
 vJUMnvuZr3KlPiC8x7tcmm13XPXQBho2LcJSyt7eSoaOvpQRCTtxR1dA/2OKCWp2ed9i
 EQH9Z+tuH83CrnRRaFkElUrrujD4TGXb86BjBt9/gPb1OyuLvCu278jgNoan/Lc1jTSI
 l+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TQ4kjE8J/opiX2xWgils7nNaWf9smLIJdfotEhM7TSk=;
 fh=D42NaSs1V65Uenkj+zQqfg6zEyfqH4GchOWTTb7p3bE=;
 b=SvfWgDie4xTAzEy4LFtrFA3BXyblovJUum9PO2Yni5h4IuNd2GErpgDUO/vjBFd+Y1
 RqAokYFDOv7BSMvZSqscoia+N3wfBYNNZ33YkXeXW/AYe41HXnVplSYAp+5wo4pAqaYD
 +pepRYVJyzI5OJ1AEvi01zCLMlt/oZiZZwushupOt6gGNTWIbsYHlwxTNmsr4//cBVlW
 jfGTaUPF8oEkarTgeqamM8vSvIhdmRvTYX32psQID1X8O9nOSloMBd5lJKNjscaYQnjJ
 x2itoOykshnL/LkAVk7WEOmHBcy2CW7uyA9ArNHpM242rXsobkXq0fN1RU5L1uJBnkks
 tkRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778629710; x=1779234510; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQ4kjE8J/opiX2xWgils7nNaWf9smLIJdfotEhM7TSk=;
 b=ZHx57t9SqDYYKosUm4EhUA9lvBzpCiXnoz7JOrUGfBMvloNTBl0MEBxjsM7wwL6dUA
 a4743fSb5w8wKJhsWLk60XWZdNzA6oGp+KReC8bLO4awXuMPZ+FuJFCgpAqLE6p3OfhV
 qRWpEp8OqAV41pisvM5Yy1u5LS4s7ylZM76R/QQDUqaxNd/gIDErC4UVA3Ft/Hc0AW9q
 0mSvqhzM/wm/SmJeHc2nT4uK2f8L2fD1B75UY7oqB1jSTxo+BLkxiG9El1EaBlSYDXJn
 oXk9q+Uhfw28AqiNwvexwPkWuaLwDjFb8hpoLtoF8j7UbpmyO41X/VCORBfc9KY70KLy
 90tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778629710; x=1779234510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TQ4kjE8J/opiX2xWgils7nNaWf9smLIJdfotEhM7TSk=;
 b=SA9YGoBI0AIiBul03vWvos8F7paWCSw8JGEynp5t1ex51+Cmz0sXjyNyc8MR79HZs7
 pdDeVG2eZ2eUhltpPITD91Q08s4oMxsQ0c5FyuIMO/1n5L514EjlxZFis1LNwL7HLcHd
 Wioi2gKmNq736x2T1cOFwM0QddDEAHYigBC26GAahIqp6xdGFWqVooIuYQ1zso+q04uM
 2JOqjsIhpwsC30ozQPtZuCDV0uEI94kbPFztdbVTevcq/eEVd9/RrCF/2qIXmEjOUiw/
 RrQUQ7pnhAx7MgXFHRQzB9Mmb2oQ/DUA5W+UbRsz7sULHoVxhhpByjVZRw8LwUzVGX1r
 2Pcg==
X-Gm-Message-State: AOJu0YxrNoT+y3JEM9uMdXHqFeGcnkhyWsPEdA5R10/cOnFAB/xqoER7
 xSV+NUfWvPi7XdkE8RalmMOR6ALUws3WMPHzW6vaJat6+gD81dlo4jEn1/whRjErgCCxnZOi0Qv
 5mzmrGMsBfoacjBCAZoL/nb8BMczuGqA=
X-Gm-Gg: Acq92OG8PYWj9k/I6q4E19Y69XB+4qX/+kj4Mhx5kSTIn+rBz+wE+qlW98BWHiqEePc
 tV/GdE6TCVI/sD93rIVb23AoGkEaMfZY6WoYz3WvFvL58O0h6i1DL+dA/6QbbehS77sEBBBejjf
 RfkTW8DwNVZDPCboLS3a28XxXvTf3XCGMzwYAKRnhZx27GZMWcPSkE3AmENPYHOSq+KR3UxA7Ix
 IE2HfZmNM4tn+uw7AN14IUinrD6Le5QAQ0LQmGF9JGDOYn1w2aHwhZHOla/+VIUppA/7sCIrt/q
 Q+61MidnlpFrarG2mpvd1RuCJBsOBq2uc591zdnnI6aWspxcGAeYoTEy7gN8W0dKDDFt7qJM
X-Received: by 2002:a05:6512:3c9d:b0:5a3:e7f1:5946 with SMTP id
 2adb3069b0e04-5a8e0ed3a9emr1873852e87.9.1778629709322; Tue, 12 May 2026
 16:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAP3gb7avhnVqkBAMg-2f5GXZ_7u9rU+Dm2UoNhYHKdvBj64Vvw@mail.gmail.com>
In-Reply-To: <CAP3gb7avhnVqkBAMg-2f5GXZ_7u9rU+Dm2UoNhYHKdvBj64Vvw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 May 2026 20:48:17 -0300
X-Gm-Features: AVHnY4IAyiaUfFNvMw_HLrAAULC7fKFCFqx4chvKnSEebs9x3mhHyxZGbqoHIb0
Message-ID: <CAOMZO5DF1qVtUKQUrWAUbGkWzc4-hEKnC1guydo5Sy50eFP61w@mail.gmail.com>
Subject: Re: USB3.1 detection Failure on u-boot
To: Kavita Awasthi <kavita.mnnit@gmail.com>
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

On Mon, May 11, 2026 at 4:24=E2=80=AFPM Kavita Awasthi <kavita.mnnit@gmail.=
com> wrote:
>
> Dear community,
>
>
>
> I am struggling to find a solution for USB3.1 Sandisk key detection on
> u-boot. I am getting following error Bus usb@32e40000: USB EHCI 1.00

What is the board and U-Boot version that you are using?
