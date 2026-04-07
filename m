Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72ADEDB7CC
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 08:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394E483A41;
	Tue,  7 Apr 2026 10:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NNxk5zqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C8B84034; Tue,  7 Apr 2026 10:52:45 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1D78352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 10:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66f727d6849so193936a12.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 01:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551963; cv=none;
 d=google.com; s=arc-20240605;
 b=E3M5RwjjEf1waoJxjz0gS4jJ6yjKkJ6FaquVuosNsD5tYl9BsiLriXb5bT8o6F6vwg
 xRQyeqvbw1q4Vb0BYx6Nw1Wsa2JarWCqI/9tZ/fEVefNQUlblNh9cTXaOzC2IMVPfrmb
 +cTkLMsh3e7haElTrTtP0sSZAx2Mg8YqlRKmsacTUB34406RMvpcW655aKw5iZ9AgVJ7
 i464byAJS08FiIh6TJ3XEB+ZspJmLUwv+cPEAExyQpAwYbnkSHAVkVBIfmLdHW90jswJ
 nozpKNZe90ebHxhs6dTmhPcWCtnVrmCwtkp/ZvF2sbKnbAAmcfabQ5uEgmiWEDgReJ2c
 +nsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0OQxrh8Qr5mk2NyLnlmFsetwobShS2WcGjZz36GvsW0=;
 fh=XohqLLtwbZUF7AfqOPK4AIeJcUUl3GcNFXtTWh5nw7I=;
 b=Szaxz0dtczxHdH8r6uITfjqyBx4Xf3EW3X05x13Kvpl058B9uH8FXcbXDyfNBaU4uC
 RCUgubpsWT/ksZS3oMFy1LvluGw6WeO+GxL4sAzi7eelvdz1IQJ8DEJoM7sqe0O6dTY0
 hd2b5sqERvHOgEyZhzmPNTO4CDvIo5mp8yQJ334LUqBwLv4s5jRMR8yBmp4uUNAprhV2
 1XWmCOXGBGJMikbBjNcYgXkJwyyK/7A0pzn4I++h1t96oG5/GcZTIO+qlt7F/PaKLFZy
 pp9MKhY//3YDeRnCYt/OAS67SfHi1ixIC9RBix6l5ytfRsXALPJRqEmDxTj+Sal/1MKf
 YkSw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775551963; x=1776156763; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OQxrh8Qr5mk2NyLnlmFsetwobShS2WcGjZz36GvsW0=;
 b=NNxk5zqyhwzPMNxUhdmWnNP0dMHzpjPO8oyTjV1BwR6cPeac91obLt/KI8MNlE04i0
 ClPjybzdriYkegSxiOBCNMXXpfRB/kzKfcJBOFjzIe4e+3CPS4SFP+hfSAKs1N6cDHgL
 75CM1172oFR0D+ReGWtc3FDB+Zj1wMVVBFt9A9f5DLNMaDkjP7375BOfPpxvZZ5MhU4B
 CsAxBuJ2z+ZGf3E6ExBmfdvNqw5xl0SNjQXyd+L+AozkrW5RzPy/M735xQs+rPs4c8fU
 z5kU3q1mYFtQD9ggoxIwFMLrmG/PjzMK1T7GltyegtTXILnGkeJWkWVmOETMGGRer3Z+
 KViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775551963; x=1776156763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0OQxrh8Qr5mk2NyLnlmFsetwobShS2WcGjZz36GvsW0=;
 b=Bj0pXr2MUHK59al3BtOr9Nzpr9lWQUIUd3XG/V4SESHXQByaODe0blCpYj6YqiS2fT
 B0h60/CpLPrkQfdiOV84s+wC+wfGvF3jCceVC9fIuQEG9YG6q6zcDcpD2/gfD07boG2L
 nnIfmaR5mvYwAFrj0ei/JvlQ37yBPwla9/pWIsd2QiJi0mbyK0B7D/Fkbai8jjJKplzF
 ciXTpaqnzLqOpXHGv6UjWdtptiPdpzn0ievxBaDvxK6fad/zLLDxbAQEnYOd3rcHXK1j
 a3YFM2jFyYSAKYnE9sTo2FTchow+dBv973yEylvhQn+T+37E7srAJetj5qyK2ovecAkT
 0Wdw==
X-Gm-Message-State: AOJu0YwZ8VnZW5KSRtcUlG/Fcoix02bGLuzQY/J+yeh9RCHFJEtmn4Lb
 rv4hSjBvb1nQRr69f26qlwyefQQxedgCTR1fYUUB8m7K9RMrka0bjbJfL/VHLP4fTXlw2E/OWxu
 9IichyQk5us5wexfMnM1Frgba3iDV9BypAz7r
X-Gm-Gg: AeBDietYbRRWOqiFXFZqYlJO6T38OZVqB50AoLj5hXez0FJYlT8TTFPFS1kWckiQf7k
 beFWchlVw1l5IlEJ7hfGCS/9+ZICYXffF79qUp46eWYftxj7BdiqBAgXtr0Dej0bx8ndVszeqzI
 eajH3PTKWMMzqsQOdOinBfMc2tJU1hoU7rkHsJM5vLVV/34FOhFhXsY/Qe6Zs3xehzdeQ2uupok
 9dEr68VpByXJ6welJhGBfIrQsmIvs8jMyVvnCLJfvJFBqlA6WSUqbVZrG6DKOTiBUiwPbVnaUQX
 UZNBXa2QgU2ZPTcSCjHj2r4VLWUHdXWnrgP9V3/Ahwiobs4oLseaWxcm2tth8TShIHK36EtJrmp
 UP08Z1gWV3R2SXYQ/PwbRBx5JFUZUbNF8ZbbnAGAbxYQnDJqq
X-Received: by 2002:a05:6402:50ce:b0:66c:1805:bb4a with SMTP id
 4fb4d7f45d1cf-66e3f70a8f3mr7387105a12.15.1775551962636; Tue, 07 Apr 2026
 01:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMFOmXFjh1rXWb7bacrLHAZahe6tcyEyjYAKv5=SHP=dJf3nA@mail.gmail.com>
In-Reply-To: <CAOMFOmXFjh1rXWb7bacrLHAZahe6tcyEyjYAKv5=SHP=dJf3nA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 7 Apr 2026 09:52:31 +0100
X-Gm-Features: AQROBzBaOhbVay2lIaOrTy0MWl4SUCv5vnc29CHehNYJfHnrc3VCwyvciC0OAdE
Message-ID: <CALeDE9P7d3eHd1TF99GB2_PYsokvbv5UED42cQRC2Z8ZYsq9Yw@mail.gmail.com>
Subject: Re: Switch ARMv7 Cortex-A processor to ARM mode right before jumping
 to target
To: Anatol Pomozov <anatol.pomozov@gmail.com>
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

Hi Anatol,

> I=E2=80=99m facing an instruction set mismatch issue on ARMv7. The system=
 uses
> a proprietary U-Boot=E2=80=93based bootloader (based on v2022.07) that ru=
ns in
> ARM mode and then jumps directly to my application. The application
> itself (Zephyr-based) is built in Thumb mode by default, which leads
> to problems when execution is handed off.
>
> Unfortunately, I cannot modify or rebuild the U-Boot binaries, as they
> are closed-source in this case. The only control I have is through the
> U-Boot environment (uboot_env).
>
> Given these constraints, is there any way - via U-Boot environment
> configuration - to switch the processor into Thumb mode right before
> jumping to the application?
>
> If not, are there any recommended workarounds for handling this ARM
> <=3D> Thumb transition when the bootloader itself cannot be modified?
>
> Thanks in advance for your help!

So unfortunately you're going to need to go to the vendor to solve
that problem, there's not much we can do, we don't know what changes
the vendor has made, or even what options they've enabled/disabled.

Do note that U-Boot is GPL software so they should be releasing it as
open source, U-Boot isn't closed-source as you state, the vendor can't
just pick and choose, the requirements of the license are very clear
if they wish to use U-Boot.

Peter
