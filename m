Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F694F94CAE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 20:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89AD1805D7;
	Tue, 21 Apr 2026 22:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="axQG0U5A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9278412A; Tue, 21 Apr 2026 22:45:44 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7895980433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 22:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b9c9d03524cso654154366b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:45:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776804342; cv=none;
 d=google.com; s=arc-20240605;
 b=CZ67jADGejZ8Crg3jx4tuTHUNoAARqHrOShifbMCodYApCSIPm4l04LSPXM/EDWxjU
 o6feN3B4fx9fuxvhQg3w4763VQjVtcHk550Fg6DipFqpKiEGroBXWJVlE3EovlA079D0
 uHccFZPys2yXSMIgv1ekX8L650HLDF/VsgGD/FjDHmLlBWMQXaCHR7ySbdHEVBjDL3QV
 ZPhbA1hKLkyfyBZtEOrySb8ROD74vsDSnJYD6k6aBuh19BhUXTJ2SS5/0yQUop0l2FTE
 YaaY9ddxnxxmbZQpb7wjeV/vSFLZX5aYCTaZpoy/jRayc8qMlGaWRaDmhuowZ70zmWMx
 nv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vjlQq8Ouo5yI+NQPZ6UmHFCgQ+1axBkUeCsIpU1UAhI=;
 fh=WUSM7NyYjw1TqkhKTdZ6GOmcvqXW3L4nmfQNfz2zbrs=;
 b=l0HrozYxa0TmxfINMGkIawW01QvVfrkqkn0pITnpNHSoBNRcJsSNLUJbkmL5cd8vCB
 qPlOECYm1HLPs5hXY7hzo8SD4U2zRtQ/O1zVGsTcB64g+/HXH99616alpScAJnEM9vey
 yGOOWWcNa2GilS7B03yM9MHeMY4bOSFPizF4NPijyvGlIFTWbMGw2w9LeX4Keq3O1UjA
 /MZwvwB/ma3oUiF7ZEV99uDMf6wsjM2gDg1PYMNc+KjSdKduxWgr8EznC4XBrXW+Kl2S
 eHe5hy5zvj8Syl3v6A/DbDpfmEauHP3SQBwLOL8tAe9E/TuOw1eGjJRSSa3+3L4Dr9ap
 06iQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776804342; x=1777409142; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjlQq8Ouo5yI+NQPZ6UmHFCgQ+1axBkUeCsIpU1UAhI=;
 b=axQG0U5AzgsfolUQRCS6zh47P4MRULYQkPcXWOZnFd0RYhLtf9izK7ugqDRe2SMDy+
 lKAoB3NxeGULUOSUmqV+OTvHJApJorn0qPpTXIiXCHU6/TYEIIJduVGaDhToUEZW5AZF
 rtWX2mZGZMCGKT67tCCj+vNS0oZGV0tZ4L+f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776804342; x=1777409142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vjlQq8Ouo5yI+NQPZ6UmHFCgQ+1axBkUeCsIpU1UAhI=;
 b=BMzm5txnb1mPQCx1nL9E39c6pZcJJjq5dmp87gvUJW0D7Z1QF061UkqVnsZ+HJoH1f
 p1gOqIR9cOFTZVYMtgm9QtDzoLaaTtdsK1f0dQrxdnVVjiiGOzJBU6YambZM82autBLv
 JFUVp9y2BhOnKtRX3SiqsfiLopN2+GcpMBNCTgYIAtZfzqUPxNsZbJ09AqMuWwXHwlEt
 nhNRnA8cOU63vuJo7l8tniDWkz4oSDajVymL59JbkqLiO4RdgBBuWG+foJ+YnKX5vC7M
 LokN1OHeXYWmq0LDGXsQb7MwIOkAeb0OgccH6ve3DoNE4PFW1HaENS0AS2ru/7Acw4D5
 JUlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lezPc84mjRfTSnxLXgQ5ML3cGLu5hncIQvrGTU3AGxLMvMLjTPRIr8LTDhNUIfFAmbY/SE3E=@lists.denx.de
X-Gm-Message-State: AOJu0Yyv0M2/9VPPxEhlOBOWeeTRsKv5nFv0o70hqg3fZeQDz+i0xiOI
 nm8nFWTwMfNbT6fnzXeF8CbE18lJtSEZCWTUNe3Wx+plwz8RaJItXtaEefA0pDeWfIiPlPN/Ve7
 nSBtS9XzopWT8ksHYow9HMQPMP30Cd6U4xzEQBTrV
X-Gm-Gg: AeBDieuAP3Km7Sl1040iD598hrIJ0CpXpkeVirtFY5ndNKtnSpxvRY1rBXlyCTNzM9C
 hw6BjN/swW6Vb7GTLwG8XWEn8PTtItaKeG6SgjqKQfU1LPFDAhAJxcljw3h4Rt7iheXmcjFd+mx
 WnmLT+TccoSdZsxmKF6mVQq9x1ncKJv4R/4C9Iba2XJIDH4qcTIkpbqLzFwkTZ0kQLt+X6a63Mt
 YTMsGiq1Acj+phTE4H9IqIRunTZ7jxTisnDiJjabWr75iLKYoO4J6CtlDwpnit+1/ifOKc29kYH
 L2DnfMuaCQ3Hx+LBOyi4
X-Received: by 2002:a17:907:948d:b0:ba8:d9d5:cf9d with SMTP id
 a640c23a62f3a-ba8d9e51cb4mr392372666b.21.1776804341757; Tue, 21 Apr 2026
 13:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260418063213.110024-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260418063213.110024-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 08:45:26 +1200
X-Gm-Features: AQROBzCSpNzZZWouamOGF45NjzllIHIO-7S2VDONlQXeuCIlxfOi_Sv1DiE8B1E
Message-ID: <CAFLszTgFLLB6Z6Sj5pYcH4zEJor3i+gJ4uCnwNi3rYd8cgebuw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/asn1_compiler: avoid -Wdiscarded-qualifiers
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On 2026-04-18T06:32:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> tools/asn1_compiler: avoid -Wdiscarded-qualifiers
>
> Building with GCC 15.2 results in warnings:
>
>     tools/asn1_compiler.c: In function =E2=80=98tokenise=E2=80=99:
>     tools/asn1_compiler.c:442:37: warning:
>     assignment discards =E2=80=98const=E2=80=99 qualifier from pointer ta=
rget type
>     [-Wdiscarded-qualifiers]
>       442 |             dir =3D bsearch(&tokens[tix], directives,
>           |                 ^
>
>     tools/asn1_compiler.c: In function =E2=80=98main=E2=80=99:
>     tools/asn1_compiler.c:632:11: warning:
>     assignment discards =E2=80=98const=E2=80=99 qualifier from pointer ta=
rget type
>     [-Wdiscarded-qualifiers]
>       632 |         p =3D strchr(grammar_name, '.');
>           |           ^
>
> bsearch() is defined as
>
>        void *bsearch(size_t n, size_t size;
>                      const void key[size], const void base[size * n],
>                      size_t n, size_t size,
>                      typeof(int (const void [size], const void [size]))
>                          *compar);
>
> * Use the correct type for dir.
>
> strchr() is defined as
>
>         char *strchr(const char *s, int c).
>
> * Use a conversion for the assignment to p.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> tools/asn1_compiler.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
