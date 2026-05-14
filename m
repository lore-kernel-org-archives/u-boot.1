Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9225CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 21:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1BC8467A;
	Thu, 14 May 2026 23:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEfT5w5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901168467B; Thu, 14 May 2026 23:17:58 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A170F844BF
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 23:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5a40d02b58bso6156580e87.3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778793476; cv=none;
 d=google.com; s=arc-20240605;
 b=C0dipbwq91G+/yQUjytsWNldqzZt4eBicouI0yTW/MP07JRAXjWyIR0+1BAAPx5AoM
 gR2OSZzhAEExOnccMgL+GYVDFm23OjgqIsIdikAZZUe5FdnwrJfhuLdMe9yNDAeS6Ext
 vB9JNUYAI4ybRmvKY6IPX1uQEd4FgB7R7Qu/fumJY74JioUHOnmNywtvDHL8XiiN9SMb
 AWot64hKP04SQJReJhRjVtvg3iWVZ2MylXyYvuTi1VxJhaB9cRbKKazicWE6Rsdjp5Ur
 ocUnkjJCOVS3lpGxi1YaTdy1VcKzWRYqabM+iLB6fXIxFcbAvPV5cWL++xZ0dpXTZddL
 /7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=r+UixiYI+Hs3YohiElyjD+1ss4ik/Y3xLQLgFlxQu1Y=;
 fh=bMpfiGCvenhbV+JiR4gu5Cq0PEhrzBAOLKDZKk5jlSo=;
 b=ShkNMWk1RGS3fccf3HtyZlgStfdLsCkQQt6xVjADQx3VfCQgdp+cof6h/O/NHdxaDg
 ETJilmkM5jg5Kp8MbIVPd4lBg9plkB32jIuuCP3ovisjfhpWeHZfRE54wvEkkQLeQRll
 utCDfBcrfU+DazrmsgSYhZF1xexeecSbN3yGn7IIpz8SVCnRR5rp34ZHQk7rGGtPpEMf
 SoX7aCfUzR/2bvL55Ezzv8+DWKpUe3kqj//2tV0Rl9vIO2OYLCN5+adgq16Jqci9KBO7
 cGHsqGqa6wfEQt1nvzP84yfA9sJROaovm3KoflNXVnOhoWFL8FoCQ2DXh0cULDcEUhBv
 ZcpA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778793476; x=1779398276; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+UixiYI+Hs3YohiElyjD+1ss4ik/Y3xLQLgFlxQu1Y=;
 b=mEfT5w5L60GAV6gthzl8bNXoCXJRlyC0C9p/1SeMlJ2MiwaxNDmlGAshrMBh6r6meS
 Cw2e/bDIoZxPoCErwAKsau1owUP8JLg40ODpKudrkkRH6n1WgutQryZHh2QFndNKwxEY
 OLaRZ3gMkheOwJol0oBIi8FxfI1x/ANUB9zLfFt6q+8G/tAn6jlKAz4IhL0/NIluPSja
 6vjF01MdiqLhsHzcbrLXa2NHpmaU1g3ysJU9U2Xytt6aEfONjxVfKnQ0nZuSKkHU5EkV
 NfqDusStg0lKgWxZmGekqhBYCQyw2ZgWAKt0r/dGLZWjLdSvVSOPkuV0ROUZGYF32vsM
 rbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778793476; x=1779398276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r+UixiYI+Hs3YohiElyjD+1ss4ik/Y3xLQLgFlxQu1Y=;
 b=epqgXOMsIHD6fbBzLSYCvG1hE6plyvJerpt7AkOKM0ARcK42KH/HdHQ1yTufzJWtQL
 FL6LOolYl85NMtZu12sO0lnDYLbiaRFYvtr34TPf6R3K8q2OQKjB3fH7Mzze3ilHYTAf
 QwelkWXpq1bI7KGNZr+6y8uELFmoqDtlR5BI4xyWzFNyF/qdXAAjLt/fiLXlbv0z2dZq
 tiKiuwcOGZiFpkIBjUqbEbcVQYYRMWtk71jvItl2OTDOMKAfTxIfhpop5DYelTZb2oa+
 jQ3oJR9qQrLPFF4SFWrrcQJORb3vFq9B9z2/UoyZ0tZVdaWjY1W1dnmjgLyuEvn/a2HV
 CyFA==
X-Gm-Message-State: AOJu0YwTYsRlmctiSnIQ1Fkv5uzvYxrP9C0Xw3WBYAR7W/m8qe64rvvZ
 PVfK0DLWoIe5WLeWFs+hFdNARFLFFiz823s4NCOESNmE5W040CdbHs+6ivXKgp+gXSM3bnd6qHb
 1lX03k+2WSto1PgkUiqelZJKpUCjLlBDNdQ==
X-Gm-Gg: Acq92OGsXPlr/lXduk6mJXYp7S7h0wj64NUrvvHiVZBdHsfhV9XGB2kihrkkYnOtYfI
 h7Nk1pXWTMyqaCySRATt7koPE8eU5lagFudKnc4DCRgTkpupIlq06fHoBUHkLn4VnJXLuS2B9xa
 /9sQwvwJU5S68egClOyhGC61UIVMF5/2M15xA354p8pf1K+ToWusO05kbZ0o1aQz48Uzr9rn9vt
 mPUpP0UGNt+AMs6ztXRRGQBKm0cGfac/nw+s8TdRYNJTQT+syfOZ6fdPSI5B8r4brzxVIwV/dev
 PyThB+o5VpOWtz4LLHmOjSCnb4FRxxll/6EmXNj5R17l3+n3usX9TpYcoo5n3qVVrgx8fDYl
X-Received: by 2002:a05:6512:3b96:b0:5a8:a754:f9d6 with SMTP id
 2adb3069b0e04-5aa0e769b74mr182779e87.29.1778793475322; Thu, 14 May 2026
 14:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAP3gb7avhnVqkBAMg-2f5GXZ_7u9rU+Dm2UoNhYHKdvBj64Vvw@mail.gmail.com>
 <CAOMZO5DF1qVtUKQUrWAUbGkWzc4-hEKnC1guydo5Sy50eFP61w@mail.gmail.com>
 <CAP3gb7a6L7Mb4sFrvho+cgLgJ=siSGVbH3UKifM6TGMci6UEGw@mail.gmail.com>
In-Reply-To: <CAP3gb7a6L7Mb4sFrvho+cgLgJ=siSGVbH3UKifM6TGMci6UEGw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 May 2026 18:17:43 -0300
X-Gm-Features: AVHnY4JNurFPxB3qCE_Wh8H5JPzMZgHl5dN_jK9Sosn7VjrZyMjYLxnwA72I-Jo
Message-ID: <CAOMZO5Ai-xsq+qHSDQWe9UssnhA3aXN_jFRUSAQ5RXoJkvnGbw@mail.gmail.com>
Subject: Re: USB3.1 detection Failure on u-boot
To: Kavita Awasthi <kavita.mnnit@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
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

Hi Kavita,

[Please do not drop the mailing list]

On Wed, May 13, 2026 at 6:16=E2=80=AFPM Kavita Awasthi <kavita.mnnit@gmail.=
com> wrote:
>
> Hi Fabio,
>
> U-boot version: 2024.04
> I am using imx-uboot. Its my custom board with imx8m MINI.

This is a very old version.

I suggest you try the top-of-tree U-Boot mainline instead, not the NXP
vendor U-Boot.
