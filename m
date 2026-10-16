Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBC5CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7973810BF;
	Fri, 16 Oct 2026 09:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5nHRwbTuU3Kw; Fri, 16 Oct 2026 09:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEFD280F74
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792144743;
	b=OSuMjOidjneHFWyh3R5IO7J/rIijEdHgADSC2RdnQxbnHWuX81KM/X2iZ7qUZi2El4MC
	 g8Dcl3fDSl3AYaobc6IEzHijNB1GOsrEJT9MfeZBUa09yCRVpxI4Ka1bVupJ1Hc9cSw+s
	 p4/JNhrCZXj/AeztI/FBPZQ7KS9bePJnn8Ab79s0nnucs/PRMhUFK75eVqrOMaACUgubw
	 o4j3nck/SqHdyiP+URhDP4j/r6rnBUQ9eg+z71PsUOAOzl8T42dO6mlMNhv6zOhDxeMj0
	 n5K67XFGNRM8Yr6ZSYuDgfyRjEn1ehDaT1mcQ5H01bszv7bx2pueQmgECzW5qlRYYZw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792144743;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fmAEPnbpRJHf8YS8IDGlwFmSGR6h+lcJglezsT5venI=;
	b=bPq6cDlnH791b7kbTPge4CHveidYn/R6acUR9VMniwAmjrkY+5ds4iBbbcI7Di84HdH2
	 mn2AAXTBV/udG4mO7gY3xk0MViTuocilsryvBxVgWVkMDGjdzLrXUr8RVYFPNlwPoydm/
	 prz47ij8dloWRvfVMHCYkMrOk7+1WhtiWXGuvT5XFqI5DPiHT+IJUccsH9/CaR/Uh8aKp
	 iOzdBwI3JRYaxdAylOXxFNzuzSsHYVJorOSF91H+QeAkHEoz98qqkHhDEdQHObG4dVN8H
	 E86GeeKpGlYc6FfTBvAun0zSt6xMhuS3HEaBUa/LvP/ASK9uGlH3lB9rt3co93xb+Ug==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=ja4yMTGw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792144743;
	bh=fmAEPnbpRJHf8YS8IDGlwFmSGR6h+lcJglezsT5venI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1GBz5C1G+mYFaCLCc0zTvVLpuQa7/xq6aaHCNPs8l3EilRnJGkl6SK8Vel0UhQtQ3
	 eD5hJppJ+ZEw/Ko89vqQpnQoLc+9jIysQvmhzY+WOplmfhKaApl6LY0TYdIPEZVEW0
	 0T8ufTVUMUlz7KZT6Z6qyDSceR5q2pdkaHyYW/aPZhaw6zfaETlhXDfXIEQGgANdVm
	 2egksXsqTU1aSgafzdAHiubvPbeIBglpdcutwS9OqqsrQDIpc1BeTgiCTFWNCDQuPB
	 D5ZauNwt2j83eFGvwgG30je+WOhWm3WveWUAMkgEn5bmo3omeZpp1JyLM0OEaUJy/h
	 Mpa4IPV2itDYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEFD280F74;
	Fri, 16 Oct 2026 09:59:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99935769
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9716E80F74
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:59:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrrGgx85Gs2b for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:59:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55EF180F56
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792144740;
 b=aP4U84jy5wlW5OH+x+Gx3UDWruJyULDPCcJ92H/GAjxQs7K4MNfgyCBjvsy78zzIwQep
 6g1s7jyf5F80FEY4W4zBGT7q1NzwlN9EAKOWMa5ljQCI2L5KBXFlN8H2Y/8naMfJDWObD
 g+f5sEgQTCYjOn3t3wvDcaxVnViZnCZWMAyIvS1yAG6B2oLt5KrwgifBLDT7SQxgpT0Ou
 1zq/vxymF3rh3Mj2hYcUJLQ+Px5oYQdn0/PIscUUPiHr9yA5mQEyEI7h8Emlpj94pb75W
 T6HC9mKp9v8fX7sEGKlnlOYPG51gE2BAVTKkUieWdZ0ibXZXMowTXqYgOoPnbBZaW2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792144740;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=fmAEPnbpRJHf8YS8IDGlwFmSGR6h+lcJglezsT5venI=;
 b=YdjLxZJgL3eqy0Tq/yG5eJHrl0bHchUOMkCG5grTM2FAeM1f9FFo+pcujBCrEf1EacTF
 aosnUoYj8FJZHlJvoadIgYvzKKV9vQ6Z4YwkuQvdpBuZQrz8Y3+wuo74G8zMJ1Yo4BXip
 LLzUCliHUTczYRRD1ds93FbAQpY/lUa28TqEZ1UKFcSyGlrin67ccLOS0tOAIWG9bzIb0
 n1KOtaDS/wf5m/reSaOcDGZG3/gos3ftoPXADBtlUfWLy8K8o7uw2eD7RBJZwNQX68VJQ
 9BSckZdZQ6YHx+8prv9HWLoP03YVNQKeGKmj27cioqcvPqleK8we+y1y7uMQNqDgIkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ja4yMTGw; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ja4yMTGw
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 55EF180F56
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:58:59 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c3f8d72d7ceso238605166b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792144738; cv=none;
 d=google.com; s=arc-20260327;
 b=okH8S8j/IZGayK5Ux9RgWGpcZ85Z+AI4R0ru/LwTVWmugKILAQGUQQUARk6zPxG3YB
 fFA1fvnBvKVVblZa0xAW7pSrUaWvdZwKxizCDJQ8pxQAFnCf3XZryhSiPtKslu0BEP89
 uFW8/YN5jqY/BP4FUV8jF+dyjP2ypNzZqHD12z31vNeO5Qmn1tCK36Qv/mam9yfyR5As
 XTcYXuWLCbP4IpO83hHw+KRDmV8hwCyY7IcW0vkpxI4/wt82Bolpf3btIjcLhES0OW5j
 O0heakWs5sbl2aWSMZkfaCcwaYKed/qgsi7YjTki+km72w8Tet9fpT4hEh7smXRaCgid
 aUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fmAEPnbpRJHf8YS8IDGlwFmSGR6h+lcJglezsT5venI=;
 fh=Y0v1/WwJw6kxannqFo+mURjzi9HsTY9Fquub2Y4LgJw=;
 b=gbwmA0gcf8mJHwm6geqsQCUyJ1h84R62k+pmvPmt/p4Fo2z9gFR6RWIKTlzGmcf4t0
 l5Y/xBH1VJGFIk6ulOE8gXPq/lvM9hvH7G/z1D+AgsnbDjID3RDR6FVcGAKCxADV88Ih
 0zbw/e/mSZouUHh80rP3VOmBWNjdYPApEANPGvz2SgGfdUgSOfOzY8oOWdMo5MoxQ7uf
 a9gtN4Nesxr2RwsDnYCrSp+4sJzP4vGg6+HC6fCdbeCdvZ4lcAR3+zfwIUD0yKnh1Hlc
 lV5lvpRdxvKjZEa0nlQhzVsu+/UyGaZ4vLWnTPYBHe3XxlPzKkttFIq7MY+BA76g3r0q
 r4Iw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792144738; x=1792749538;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fmAEPnbpRJHf8YS8IDGlwFmSGR6h+lcJglezsT5venI=;
 b=ja4yMTGwQeihhUeyaNTrRBmzQRFTnlgI5kR04zFfCbLByeuql7mGNCY0QzmkQf0oUw
 Rjb5j2XcfbZcy+wCa0JNzAOVd6ZIqYJ2fMPLMDCZp9K1T7i41rwUP64IsSAfJmMd/g8Y
 ZdFglyXOctR8XgL3BtgsqwozYkW4NyBFH07CBkjhF9V8jbMnFOZkuJXj5xpPG7LyB54J
 PUaPDPuVG2kH4w28599LJuhbA7MlbT1qjaRyT5UJrXR+qgpA16GbTvppi4g0Fv5Jksmj
 ce7zNBNbHNZfzt+RPtA/1H3zdNe/ogB/NGJNe1z/iJZBP62PnW6MEkM/WKGpb5k/NEUp
 nWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792144738; x=1792749538;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fmAEPnbpRJHf8YS8IDGlwFmSGR6h+lcJglezsT5venI=;
 b=f1QqpkhM8YKSR3xygZSGXAMhxu470pCdgCxd7iEhZURZeq86VJRHcaJlHrgsUwjAiB
 glNyTB4IT6XJpuYecWI0CrAuvz+8fRnbXGFTB3/xmgEmclsd8Uat0pDjqt0M79gowpGV
 0MWuXOcTLhHaUZYyZynwRpObBisTMR9JM//vaHwA2zWdpjxzepC4HgqLEUyUamro6Az0
 9BYghpdvhIjMt/jGqySdZeI6IoP6NBTN4SpKKlIfi4KDw51gRNGGT+iGx1DSi4h5YjsG
 b4x7dGZvwaKSpKJYKJvburkBnVsZjZ7lSKSfnV9BEpZ2VOPdaVk33P8WN9xqlNz0m3OS
 neiw==
X-Gm-Message-State: AFq9FYLMI4rhK7gphhBfDW3N3KEq/CntHWAAd6kAKCAQbJ63Jq0wfypz
 0+OEWNoS+IiQHzwHwSgruqATYHQysuV+2Hdf8P15n07Pgo5JZ1v/yAm0WAUi5cLW0KPZSsFNZ5w
 vowMBRHs+3S2Hd9vfcVH2R2rWXikB6wfFfRK+Ewi1Fg==
X-Gm-Gg: AYBFou2ZQ2ix0C+9ODt1tH/+6Ef33E1u7WguIA3CxCP8oZxCl9+hBW6r7LoKLXy/ZWd
 kfbwigyyM7uh08s4ERnQbMfqIWZXdXMYhVyt2nTe8k2l8awTK4eB9ifAR0wVNL+GZqD4perfQXn
 xToBV500YDRIUOAxOwcYP9XlY9bVoXSRhQTRkib+BabCYr+jchBqi3sqvALZsk7MTe3SZQBphw2
 NaGPVWSEYrrt6yUf997s4vKhYVjuXEJUfocAbFEEUz4zr79m+CqKZ4pL7KltixG1LQOanl9hohH
 w+tkkFwmyF86NZ7qIpwvIKJkPIoUh7qN5DC8nm9XBdRg2sa71Xf2H4SoiCWzro9S2VyjoiScM6t
 Di+VJ1iD4SVtaECuhfNBX8Y4=
X-Received: by 2002:a17:907:869e:b0:c3f:61:fe5f with SMTP id
 a640c23a62f3a-c3f00621ebemr427349966b.46.1792144737771; Fri, 16 Oct 2026
 02:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20261002-unaligned-decomp-v2-0-675466ced78a@flipper.net>
 <20261002-unaligned-decomp-v2-1-675466ced78a@flipper.net>
 <9e0762c4-57b1-4e61-adb5-32031da77c93@0leil.net>
In-Reply-To: <9e0762c4-57b1-4e61-adb5-32031da77c93@0leil.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 16 Oct 2026 13:58:49 +0400
X-Gm-Features: AclHuK8g45cSSaKpUuf3AgE6lGlcgBS0uRbS7tqqd3U5bdjPINl_xxsnPvEMQJw
Message-ID: <CAKTNdwFVRTjq14Sjn8MdAG4DCWTmDPs-81qfsJGcCNo_Ay+-tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib: Let the decompressors use unaligned loads if
 platform allows
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>,
 Cole Munz <Munzzyy1@proton.me>, Kever Yang <kever.yang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On Fri, Oct 16, 2026 at 1:06=E2=80=AFPM Quentin Schulz <u-boot@0leil.net> w=
rote:
>
> Hi Alexey,
>
> On 10/2/26 12:04 PM, Alexey Charkov wrote:
> > ARM passes -mstrict-align (-mno-unaligned-access on ARMv7) to everythin=
g,
> > because when the MMU is off any unaligned access there faults. The
> > compiler then has to assemble every wide unaligned load out of single
> > bytes: one ldr becomes eight ldrb and seven orr/lsl.
> >
> > This is especially painful for decompressors which refill their buffer
> > in 64-bit words. On a Rockchip RK3576 SPL, zstd unpacks a 30MiB Falcon
> > mode Linux kernel in 1947ms built this way and 596ms without the flag,
> > and the SPL gets 2.3KiB smaller by cutting down on the byte-wise loads =
and
> > ORs. gzip, whose inflate walks its input a byte at a time anyway, gains
> > 6%.
> >
> > Add ASSUME_UNALIGNED_ACCESS_OK for a platform to state that the MMU is =
on
> > by the time it unpacks an image, and let the decompression libraries dr=
op
> > the flag when it is set. The arch exports the flag it added rather than
> > lib/ naming it, so this stays correct for anything else which adds one.
> >
> > No functional change anywhere until the symbol is selected.
> >
>
>
>
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   arch/Kconfig                 | 35 +++++++++++++++++++++++++++++++++++
> >   arch/arm/cpu/armv7/config.mk |  3 +++
> >   arch/arm/cpu/armv8/config.mk |  3 +++
> >   lib/Makefile                 |  3 +++
> >   lib/lzma/Makefile            |  8 ++++++++
> >   lib/lzo/Makefile             |  8 ++++++++
> >   lib/zlib/Makefile            |  8 ++++++++
> >   lib/zstd/Makefile            |  8 ++++++++
> >   8 files changed, 76 insertions(+)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 8d63afeb138e..606b9d79ecd8 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -27,6 +27,41 @@ config SUPPORT_LITTLE_ENDIAN
> >       bool
> >       default y if !SUPPORT_BIG_ENDIAN
> >
> > +config ASSUME_UNALIGNED_ACCESS_OK
>
> I only see changes in ARM and ARM64 config.mk, should this (and SPL)
> symbol depends on ARM/ARM64 maybe? I see in the second patch you're
> adding another dependency on !SPL_SYS_DCACHE_OFF, any reason for it not
> to be a dependency in the main symbol in this file here?

Given that it's strictly opt-in by each platform and not
user-selectable, I don't think adding explicit dependencies in the
main symbol helps much. As for !SPL_SYS_DCACHE_OFF, that's
arch-specific. E.g. on ARM/ARM64 unaligned accesses fault by default.
The exception is when both the MMU and D-cache are up and running - in
which case they work just fine. For some other strict-alignment
architecture the set of conditions would probably be different - and I
have no idea about those, so I'd rather leave it to the respective
architecture/platform code owners to assert, not add any direct hints
which may or may not apply to their case.

> This is very compressor/decompressor-specific, should we rename the
> symbol so it's clear only those would/should be impacted by this symbol
> (hoping that its usage doesn't get extended in the future).

Compressors and decompressors are the primary beneficiaries and the
only current users enabled by this patch, but the mechanism itself
isn't strictly limited to them. I also hate overly long Kconfig symbol
names, and the current one is already stretching it a bit :)

> > +     bool
> > +     help
> > +       Assume that an unaligned access cannot fault by the time U-Boot
> > +       proper unpacks an image, and build the decompression libraries
> > +       without the architecture's strict-alignment flag on that basis.
> > +
> > +       Architectures whose unaligned accesses fault while the MMU is o=
ff
> > +       pass such a flag to everything, which makes the compiler assemb=
le
> > +       each wide unaligned load out of single bytes. That is both slow=
er
> > +       and larger, and a decompressor refilling its bit buffer in mach=
ine
> > +       words can spend up to four times as long for it.
> > +
> > +       The assumption holds only once the MMU is on, which on most
> > +       platforms has not happened by the time an image is unpacked, an=
d
> > +       nothing checks it. Select it from code which enables the MMU
>
> Crazy idea, but should we add a flag that specifies whether the MMU (and
> dcache?) has been set up, and then read that flag in places where we
> have this assumption? Then we could at least clearly hard fail on this
> flag not being set and tell the user something went wrong before the
> system does a HW fault by itself?

Do you mean a runtime flag? I'm afraid that will add more global state
affecting all platforms, and some platforms with tight SPL size
requirements will not love it.

Best regards,
Alexey
