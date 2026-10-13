Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1461CCC6B12
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B71AE403EA;
	Tue, 13 Oct 2026 15:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t9UI7xXH2Jdj; Tue, 13 Oct 2026 15:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E3F9B403AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791904670;
	b=FrzyWxEPiw9wFjzUH+j8fq5bjzP2mybIHRq45MxP0xR6hMkhgiCOo9wGMm8P7YGo5jV1
	 h68DJe+ooS/+bDiDbadknmYozc4M65GTSmsfZBGjCnfUQ0Ks2GtXb+SRrTBOu12m7oNCt
	 I3IqIT8MQkoxRyuaKc+OfvJZ5cZj3rClfy0u0xoqnHgjE2v3Hh9+1Cj0ukvq2hg/kS1Bh
	 U5VPLXL10sdYqcavMpKJHPGNKHh7f8npKwFalvahTZTBOICPtiYbQOmM3V/HBYAvE22NA
	 TlTm0FWiciDcNZ1p3WrkdzXDuOSqztifblFNRKRa52OlORJfjFHPCt70FY5jGddjCKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791904670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F+N4TDsRLw5qIpJZwv/0TVICXoxEQDvg3xC5l2TXrhw=;
	b=KtMf98U6tXEx/5sr0+gSML9UOJLuhrIUOUfl4WKgmPrEAJdxvycdnCCa+kkmEwRDyXy1
	 /vn7SF/0CzdlzsTnwYQXd9M4iSvVdw9E30kq0eW3hrPJOKssLssqwwJ2WUJtl752PqN3G
	 SNQG2Q9g3WoaRG2wgQy7eQ9XUNq+ftoFBi6F0hR3C3cl4+4jVfI5/cKsu6JPFgyLdrxxj
	 gZSec2+JW8UK7LgDD3qy1BhPiz+WcPrd204+sARWfLCfde2fg9fau6LkeyKD2Pd8pTFf9
	 M2OLP23rUcVYNvejVEJZSNQwHkP/e1e13q+oXnQRMa4zKOsmDwsAzausMXEOoJhkMoA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=ZLThLYcU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791904670;
	bh=F+N4TDsRLw5qIpJZwv/0TVICXoxEQDvg3xC5l2TXrhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nwioj80o/cI8FdEVOAwmXLb0z68zekv5W7oqP8gwuOUwJhgTuHHchk7CE3DzRuXQn
	 5XOV0GLX6xW0RJ3lSBEn/aDC4tzIjbCODXrBORPqfWdeWzfzvT2WDlwMsKjwF4/t50
	 KqiY2VPsnq8QnYGaZJcsZYcL7ZuBBne0O//+caEgeJpEeFbYW2XksfPsYY/SWQBuVr
	 l7Ok6suVt0NX3PY8p9/86x3Aek43wTwgEnEZnVS3wsfPkpTS72hrjwsC6Dg5MgFAja
	 HMMKAyFVLw3EV5af4E43P47rNnvIf9UdrFJ3w5822C9KP0FNg9mSgxu3jBNaARyQRt
	 mV2wAhALp0VcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3F9B403AE;
	Tue, 13 Oct 2026 15:17:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE3D3362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF6C9403AE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nFdH9RXoKl8l for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 667774039C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791904667;
 b=I4LBktVSH4PTzhCpMDFAv6AYZR/rI/d+VNaPd+jnm7IZg/Zcz+8/jNYaHReNJxx8WVdQ
 YrPZE+Zw8AKI6NwsXyZsra9p8YEWQRrz8+LMjy/sEpGHGUKC4oW/3+pkqzH38zevRBQVC
 btPxBUAIpUv87nwSdxUwCMxcxM4gZ7En+AKtI57e1/U6SPBR5GXV1J60N/8e9G60MZXUz
 Q8wH098n0SrOLEX39VMDYDZyw9HdGCH9Q8aRUIbhUGPOzhrU4cRyweLj36nsJFZiJ1LP6
 E02mx202hLFCNgm6TwVTMX0+NxWv0enhLhAK5NRU5qqgluPejj2aKOw+OcNaaVi5tDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791904667;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=F+N4TDsRLw5qIpJZwv/0TVICXoxEQDvg3xC5l2TXrhw=;
 b=db9rHTLxbRWEEXOYWCz339AObeI8y9RGYAnI4QHu/DUsfV3luIcAfjLo3qQYIFzVwLJ+
 bN4QEwiLlTWIhV0e9fF0/SsyQdnnUPhOmelqI/Ve7vuc/GTLb18fxS/KLinEs9L99CGaS
 bRCkuah5JyEz5ucRJuescw0P+gUQwb1JmF/oXgCkar0uS9+Jo90MI0K2oz5mfk+NzDvQh
 apre1VwsbndR4ghgtOQKziaaeb+VnLLyEQ4IpHvIFjwTYL+fP9RFvcTczSLib6uIPJHf2
 TlPZlDHfXjGOtqy0YyvkduuqFL1cBZflw+DdcDZTi89sbAWLy9sUVGaPnrQxOwMS/DA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=ZLThLYcU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=ZLThLYcU
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 667774039C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:17:45 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ab38a051aaso24303807b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791904665; cv=none;
 d=google.com; s=arc-20260327;
 b=iVc1WI6VxSpEXyd0aAc5UhReZNo1nzSr3m8YG5VJ7rfz0VO3Xp/jmlv7IwugppqgpL
 HgZu4T42tNVVv7RPEsPfBpBt7sJ1SBG6sfgYG1TI5GJR9BfzV8iBPwHCUbPAHtApIMaY
 opFx+6NU2hKtIVcjiwY1XF+WI5jS/tUrJQ8lhZkeu4HFdcBya/ayIX8PmKYI6W3vfuS0
 eIP0K63EbtkfwwdkeL/YJNMKqN4S3ySo36G96l4Uw7RjSz4VikoP3SFC1sNkm9DmHeRk
 II5lOwRj3HPjtlusaUG0Nrfre5HRllUtMiiPFhqcNy7WMsA9zDQBK4xZRvgyLqyHVh+s
 Wfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F+N4TDsRLw5qIpJZwv/0TVICXoxEQDvg3xC5l2TXrhw=;
 fh=oIMmC8iu+RpL9QS0aPIrVHvb7dY/DmDKYgM4/PZle3M=;
 b=PslBwAAiP2uzR0K0SDKXk0wQzUdQPj2WCZXJZYVBr+j5iB6xyzrXP+ABACzo6K7ew2
 03r8PFIdGqJlHK/0t04wn2AGXRW+4zhzJOEa4f6jz0ypNwLja6B5yZkaIxhHL6xlWVUJ
 D3ik2ifEaG8b7Zhj2CIerrX82yLm+EoDgSIdRIQdf8AZ8jaV/m0XwjsVqCq4lNunndju
 jIufB+ztGa2i4NHDEhSSg0q0qv7Ry6F2UPJ/bzj1YMOltoXbO8yjoxkM7W4Lno1U+kSV
 ehaTqIMLduP4PGeJkUFat+w2yEmT7z7nDhsZdbmON+tGga5aWQPD1iPfuYetOWPnS0Ez
 +rJg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791904665; x=1792509465;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F+N4TDsRLw5qIpJZwv/0TVICXoxEQDvg3xC5l2TXrhw=;
 b=ZLThLYcUjCI73pB8HSFLhkmvvSlqZVCGB3+kgNckvacXDDKHnL2DhGpPdUyYBreGnX
 kaGW4k14EZPFgHaaR1FihA0Ijo0VSxigT0oWH+QKuHlSEoaN0yTGu8/1wBNJKu+1ZaXh
 eAzeJGpH4rOTh5Z2D2U33ckxPoRJdcuNuolyHLys4hPySGY+ukRFzblUTOUtTelFYEvX
 Cxct1a/rOsRhD3pCnpogoxLS7eHpb/MS/cirs7tjsJWY/ijrvU9GJNc/JEovKDrkv+HA
 xBoqfV5Rc4oFfyCgwiVBdBr1Y1HFmLAI88ZvJVuqBxukbaLJ+CFvWuBDXmy7YPE90LAt
 Ptwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904665; x=1792509465;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F+N4TDsRLw5qIpJZwv/0TVICXoxEQDvg3xC5l2TXrhw=;
 b=ROybrky1+rpTjhOoo2fcDJrR37ZSBMLNjAEQgGaWTuf6nKMOZCaZatsuspTHWLDZ8G
 YcqtVEjapNV9Jz1d3z2CVpu3T6SEVbVEQqsDxIwa8vuZFx8J2VJmzHvt3e+ygTSIH2N0
 obYpM3c9vMLdAQrU9kx9STatiO59p896/kGsygPFUGjX1odG7J9vN3+0paM1FKzB0XTe
 ebNm0NnhT9vYomQ8nxN3v5fp71xhXwo48wQM2vKhEqoC+sHOap/fPQ79tV947d/cxxF4
 D/QflQq6GclxhLYbcnEkj3tCfmzz7/dTRwrSPuyej5CG4eItEZofnVirO4RMRWPeLZ9C
 p/ZA==
X-Gm-Message-State: AFq9FYLNRRcRPrrN8JBIUrLZar+dKrBPzSklHBNClfJxgrMVxUXtmU5M
 PaiwumGpVCBvO9p2vm0hI2uli8KDnenGvv46Bv89ngPeIGmBrkWKV1H9YUlX89R6NBHuzL6C0Vw
 FXOyH7kbkmiC8QxFeOo7HS2xYa5hMypB6c9jSyUqUzlzk20P8+wr/4Yc=
X-Gm-Gg: AYBFou3vunVHpyz+BAKXa4XnaG1+DvyHlmfPPJkBnCJvx5KHqIFOfyfUNWcag4vzosb
 /+LkWgYJIdiffb+7r3Gio+6rDUJTwLY2geUPu4IoitFRcs69o+1ankPU9Dzt3SYF+IeIPz8a+Il
 KtfTqWOpsnG96kkpJGVI01a7BBkYl4fi5bPjLKiOhCgl6LGghNYhYb+dO3VRtqtbhKarLdpeHkn
 UvUZyoiF7RPcvBCRVTz6OKw61cyAmydkLCzthCCkpE7KRgtKt5t1qdUdBCTQplRzOjnZ5caTk0T
 ClZ/8yHoI/3VA3x+eHA36JDJnkC9xUHkKxPKR/f3PuH8hgAF/md0yxQ6FdkIqhvNhW+Rc+AWq4Q
 lFnk4pXZ/Kg==
X-Received: by 2002:a05:690c:c4e5:b0:890:659e:3c84 with SMTP id
 00721157ae682-8b07ee83a52mr50233087b3.57.1791904664587; Tue, 13 Oct 2026
 08:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
 <20261003-aspeed_vbios_fixes-v2-5-f8e593f024ab@oss.tenstorrent.com>
 <CAFLszTg=sjS0hHdh9peMk-bzbHssVpMFPDyTu694-nf3W7p8HQ@mail.gmail.com>
In-Reply-To: <CAFLszTg=sjS0hHdh9peMk-bzbHssVpMFPDyTu694-nf3W7p8HQ@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 13 Oct 2026 10:17:33 -0500
X-Gm-Features: AclHuK-4ubNRVUL00kOaa8TzH8EiS9WW-ppj4fpE0UjLBBxym534LAJjAmgDU-8
Message-ID: <CAEev2e-CYqKF75DtQj6A9qXpTGxSyJJUbLRieyxaX6YDWOaf7A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bios_emulator: extend VGA I/O ports to include
 ports 0x3B4-0x3DA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Tue, Oct 13, 2026 at 5:25=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Anirudh,
>
> On 2026-10-03T20:07:54, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> > bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA
> >
> > The IS_VGA_PORT macro currently doesn't cover the 0x3B4, 0x3B5 and 0x3B=
A
> > I/O ports. Reads/writes to this currently fall through to LOG_inpb/outb
> > which are unimplemented on non x86 architectures (which don't support
> > I/O ports).
> >
> > Add these ports to the IS_VGA_PORT macro, and implement reads/writes to
> > these ports. 0x3B4 and 0x3B5 are mirrors of 0x3D4 and 0x3D5 that are
> > used in monochrome mode (bit 0 of 0x3C2 is not set). Implement these
> > with the same logic and env state as 0x3D4/0x3D5, but with the bit chec=
k
> > condition for 0x3C2 flipped. 0x3BA is a mirror of 0x3DA, so the
> > implementation for this falls back to the same logic as 0x3DA.
> >
> > The extended range also covers the non-VGA ports 0x3B6-0x3B9 and
> > 0x3BB-0x3BF (LPT1 on legacy PCs): reads return 0xff and writes are
> > dropped instead of reaching the real inb/outb path, which is harmless
> > from the VBIOS's perspective.
> >
> > The write side handles 0x3B4/0x3B5 but not 0x3BA, consistent with the
> > existing lack of a 0x3DA write handler.
> >
> > The Aspeed AST2600's VBIOS uses these I/O ports, and these changes are
> > needed for it's VBIOS to run.
>
> Please use 'its' rather than 'it's' here.
>
> > [...]
> >
> > drivers/bios_emulator/besys.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
>
> > diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besy=
s.c
> > @@ -270,6 +270,18 @@ static u8 VGA_inpb (const int port)
> > +     case 0x3B4:
> > +             if (!(_BE_env.emu3C2 & 0x1))
> > +                     return _BE_env.emu3D4;
> > +             break;
> > +     case 0x3B5:
> > +             if (!(_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
> > +                     return _BE_env.emu3D5[_BE_env.emu3D4];
> > +             break;
>
> This repeats the 0x3D4/0x3D5 cases with the condition inverted, and
> VGA_outpb() does the same again. You could add a small helper that
> checks whether the CRTC port matches the current mode, for example:
>
>     static bool vga_crtc_active(int port)
>     {
>             return (port >=3D 0x3d0) =3D=3D !!(_BE_env.emu3C2 & 1);
>     }
>
> Then 0x3B4 can share a case with 0x3D4, and 0x3B5 with 0x3D5, in both
> functions, removing the duplication. What do you think?
>
> > diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besy=
s.c
> > @@ -321,6 +333,10 @@ static u8 VGA_inpb (const int port)
> > +     /*
> > +      * 3BA is a mirror of 3DA
> > +      */
> > +     case 0x3BA:
> >       case 0x3DA:
>
> Just to check: on real hardware 0x3BA only decodes in monochrome mode,
> so a read in colour mode should not reset flipFlop3C0 or toggle
> emu3DA. The existing 0x3DA case doesn't check the mode either, so this
> may not matter for the AST2600 VBIOS, but it would be more accurate to
> use the same mode check as 0x3B4/0x3B5. Also, a single-line comment is
> enough here.

Let me propose a different solution here: What if I just drop this and
the previous commit (support 16-bit reads on VGA port)?

If I implement custom ops in the Aspeed VGA driver for all
BE_(in|out)(b|w|l) calls, then I don't need to touch this function at
all. All the port/range checking needed can be handled in these ops
that biosemu will call. The existing biosemu code will just look for
the custom ops in the driver and fallback to the existing generic
version.

>
> Regards,
> Simon
