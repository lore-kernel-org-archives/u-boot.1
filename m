Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AA4CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:25:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1143C80DBB;
	Tue, 13 Oct 2026 10:25:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9AzDPAh5mTM; Tue, 13 Oct 2026 10:25:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E7B380DC2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887106;
	b=h1GcXL1KQsuvr4HoMC3T4r/NOSA0n/gjSNKlMr+dFTTlsEG2hFEwWdZe2eWnNdrBe7uT
	 hQFDa07tIo54J3mAf1CV1fsDALfXzU3JyTTGaaXqLMCzXm+O6u/iyRdQu08grf0+uFV9e
	 uc9WlGvuUuvKu48FEK87Q8fXVZCt4dCKyXGOClfsrgsS2xLrlYWAVJXWkJ3cBH7Mn1/uf
	 Cc727ZbuqIFn3xBcAKTwdoWLqOa67KQteBoID8SCbl4diguVVCobDz3vDIQiG9f6en0wo
	 nTi8Zt2WC7XLFUQpkPQYKTHiYcUzE87yIj7s6cu+xg1n+AX4Mq4KjudiXwGu630laTw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791887106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=quOsvMgegWIG2px9pE4pq/5OYSJwr8yxfWXl/4/snVA=;
	b=rr2CrSOoMmhAwlef9hVs0XJtn2Wb/r+PPbo3gL+liWWHhYq5C/QLgpZoJhfEaDnXCG7i
	 yxmZux9nKaTI/odAJHjmNvfOFT+P2PfUgmbQP0I8nPsgH2XacuJ5RhR0ad2yYCyhEh7hT
	 KV92JxsaoJh1ikQ+fWhEWwkHUvLNkIkp0tLJ52BgPm84KUg3kkS7wFhlfRoQAHtFEXz43
	 iKSyamr6qt5uU83LsIJV+/5h2fCBxhuhadIEPohTLmiwBQ7DqeSil8dnknNXdvCgQBk56
	 16G8wWPEjrNS32XBqwjpvq3vslOnKuw/mvNAkcYqxNRs1Sl+l2ZXRe6bht9wdZZFiMA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791887106;
	bh=quOsvMgegWIG2px9pE4pq/5OYSJwr8yxfWXl/4/snVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hNFsDj76U1A0a6wuaCgS+STdJnXVTOzQxbj9U4jPqnH0Xr3M2wawXEc6JFL1dEJFu
	 W8U93E76umje9a8YPpjZ6At2xOkQ+CdILEZ80dMkHEhDOsxugaxi8Iwx4+mO6f69fH
	 jfNNd/i3q7Z0V1DnCvCir0KzCe/g4fpsniPOVc5sp9sDOfzlaLGbRT3PjaxsJhrWlP
	 Wlp2TGN2u33Y81UzKvbkpbOVHDlu2Axl9IPj2AS9NwrnScCGCgJD9+vnAxlm/42Qj5
	 iLSf2QPeEFKEPlD+TYTINQL3ieRfdTV7U1fqKcGq/Q4y2iNG0C1SV5Z74XC/XfZMLn
	 5mmwkSi9CynRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E7B380DC2;
	Tue, 13 Oct 2026 10:25:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 138BD235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04D7F60688
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:25:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmQ0hSPD5LWy for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:25:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E23760679
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887103;
 b=clMmACj7m9UCB+uOgc4UFiiIHf0V2RQSzS95azTtvUaqzEU+t+5NmBwCccmNA3yEg5zx
 dUhQRITvPuOokh8vmJWSdF+ss5qCp21Fk0A+Mv/Z7S8GYCqycCLidKWg2EA5VGIWED9gq
 2jFRTeGnn05eCnNx9pJkDol2HUWhMn9uiC6IocohJxjPC5aP93/lxTDCL12lkxIuPLn9b
 o0UQfEAioHDzX0RMwz7oSNXqM+/MRABVERaxuMsBs/6vW8bvBfh9VX8eqFjp18kAmowa0
 98ToXd4+wNLaSUqfT0a5ntWRMCgly6DCCE3TdQftFY1sGJnC+lJJMOCRNDQBebiG3rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791887103;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=quOsvMgegWIG2px9pE4pq/5OYSJwr8yxfWXl/4/snVA=;
 b=mxw2+0uliVdTYRpKJV1+zcl2+WqRDMW5I6SmvXtiAG9jDtDGlgQu5WBfImZ+nyjoX6JH
 8Qy9WY1CgGFiH1CZNUxEZLDADwdL/tW4uqZHbeZCgrwcJMf9U6OBb/X75MQDxEhtioMLJ
 H/10P1qWNreiud3GobmIibljiLkzqldDHtbYRv01D8Rg4kdVGwJAeLjtt+wenHFIn57oK
 1gJxlNLxkDvIbzQnk4t/E8sh04xPPTyiifQjwnADCpqXi0XLcyBTu/KOIYpSNk9bF7QGF
 SDexYKiJPZEMjlY5cJsu5DrU1A8K35UFSlVf5dKbYGODKY5jVLqsT5+eOHuBwCKb/rA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BaclOqUK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BaclOqUK
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E23760679
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:25:02 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso2821439a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791887101; cv=none;
 d=google.com; s=arc-20260327;
 b=aTRs9rxQrUgiYp9o7oZdgbBHTvvLtIywjvuJ2i8oePzpuYktuQ6jHZjTcMHoSe7cSh
 I/dJkJbtuNdVPgTGwa9GJ9zRr74J8aodMnrcUJwzcs9YzHr7/moJ0uHGb45K1+IEDLy+
 6IJLMKoFJEVxd3kXMVzXe8ndBYPYoYldRSc4j3KettB8Y6uB5X1CkCRYUTApZvx44rY1
 HTtbP3sbeKL0J+emHzQw/zxGKHz/9YTsPAQdhppFLuE0U1u3+o8+OfOx/QXWGJMTjUyF
 CjFo16t5l1e/+uA0z3po22Tml4LGfJhEcVA4OZNB0aYIZwIq/+9BD+w1SYg/uBqAopAF
 ZoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=quOsvMgegWIG2px9pE4pq/5OYSJwr8yxfWXl/4/snVA=;
 fh=HNvyiKdY0EVXoOVdehOWSAhbBVIvKB9921VBkS5FvAg=;
 b=KhC+IiWSK4UKh2njdTxp6zeTP81/Z0BKFZPePgTZWSSi8FZhmHDBGJkk3hiYXCkulS
 N6lJN/XSc9ywxWsxqQC9jWfeiX8iybncVfDKdc6Ktg3XbbDgfjI/E04soTdJvB9uQwP1
 00wmukFRKP1R4X1c1Jb/5Bne4pObvS2sLuD3yrAJLjy4p1GwXPoE3nwJiJsnyhGcpY85
 G3dsagQTYebPwpRku7TzYJZTg7PJQ0l3Hx10y20FVsKLg9vYW6j6kssrdlo338yUqCPR
 26cDGWRxSvek/amlknheixIaM8Ubj1hc2jBLZWR0mUS5ERZJSg5UGW1IYdHDtkshp8b1
 xeaQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791887101; x=1792491901;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=quOsvMgegWIG2px9pE4pq/5OYSJwr8yxfWXl/4/snVA=;
 b=BaclOqUKA+Kz7tvRMoHHfXcw8XHA/E5cEwhJFFStSNeBNsCXgDgk0kaHtKwPquqnM6
 apB4ynCkmoP6Y2GC+/THfNGdyrz2hPi/o5PpW9ctzlYZfHudRRHV0GPLIOdMfnMrgXFt
 nbFh4TxDucc2wlMSKLnNbeX/EY4txYzBXskZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887101; x=1792491901;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=quOsvMgegWIG2px9pE4pq/5OYSJwr8yxfWXl/4/snVA=;
 b=gSniJ2YIdVGC4v5xox46cBjrrIT4wF+6ifv4Wl1ozbkXj3hWv3irxIH9leY9RMLBUs
 zUBOy0NjiynTmZ3cTE2r6WzbIBd8imFnppT/4y1t0mVJso7zTaMPyobHHapcWB/0CWts
 ypvJHhFhDBlcBvj2gm0b3wWX7mO42fROyE46ZVQAp7j24TJBvV0TQMy/twecZmtToKXf
 aptnZqqDNEoiilsl0z1V3pQyOuAMyf7gA99qJ6GdWUbLg8T91x96d14k4N0/ds0XSOUK
 TgjMFikLPpZgsXGQqv1K6GEmUAyc9v9iHy1rhcplVRDmoIM82xZTR+FV99gX24SBWFzc
 PxJA==
X-Gm-Message-State: AFq9FYKyMDcX/xEVaKhgsYJoZIzVeIgrNXKN3lCwUQPkHCyJP+XA/GRT
 qH2Ya3qynhldzKtwq9L9jYpivEAYXCMdUgArfQWD+s5EoB+v+3KFd4DcPBSIQylC9jXQEMdA6Up
 Lt7Qj38NRFpENPQK+P/psSyRhk96QxFLto54mRcKq
X-Gm-Gg: AYBFou1uNXBV/zd1blcqz5e+UOjdyH1P5wOsztjUtAfdf9oREDoMoYh36AqggclLtVH
 BMR+NzoRSBKZQpcpD/F4dRSnYNF9plkHU79Dr3bQwSrLzU26sTKChHICES0f6h58gxMj8JJNtLJ
 tgJHbWa42Dvn36SrjO4w26GVuJowV5iFVcdWbq9+Jw41Akwe9bel7x1Dz6LRMKwJqEFrstqXVpQ
 N1VjULWaEciT1dg3DLwR7r9mbJkEFkEfOAKK13UoKBNTr4vlGYutPA4hpL0ovKRZ65pE0ypdkqM
 lTkYkzz0IFZrUCu3cGIQAs2zSZTVn1uLz4a+B0jHZsLKwUAXzB1eIsRLew==
X-Received: by 2002:a05:6402:46d2:b0:6b1:d62b:a8c2 with SMTP id
 4fb4d7f45d1cf-6b1d62babbfmr3098281a12.5.1791887100537; Tue, 13 Oct 2026
 03:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
 <20261003-aspeed_vbios_fixes-v2-5-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-5-f8e593f024ab@oss.tenstorrent.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 11:24:42 +0100
X-Gm-Features: AclHuK9y0Z2RfHGOfLodhH96ypU5YSJTkGLpSM1EyYr1dMa924lEuzA4tKiaI-0
Message-ID: <CAFLszTg=sjS0hHdh9peMk-bzbHssVpMFPDyTu694-nf3W7p8HQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bios_emulator: extend VGA I/O ports to include
 ports 0x3B4-0x3DA
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Anirudh,

On 2026-10-03T20:07:54, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA
>
> The IS_VGA_PORT macro currently doesn't cover the 0x3B4, 0x3B5 and 0x3BA
> I/O ports. Reads/writes to this currently fall through to LOG_inpb/outb
> which are unimplemented on non x86 architectures (which don't support
> I/O ports).
>
> Add these ports to the IS_VGA_PORT macro, and implement reads/writes to
> these ports. 0x3B4 and 0x3B5 are mirrors of 0x3D4 and 0x3D5 that are
> used in monochrome mode (bit 0 of 0x3C2 is not set). Implement these
> with the same logic and env state as 0x3D4/0x3D5, but with the bit check
> condition for 0x3C2 flipped. 0x3BA is a mirror of 0x3DA, so the
> implementation for this falls back to the same logic as 0x3DA.
>
> The extended range also covers the non-VGA ports 0x3B6-0x3B9 and
> 0x3BB-0x3BF (LPT1 on legacy PCs): reads return 0xff and writes are
> dropped instead of reaching the real inb/outb path, which is harmless
> from the VBIOS's perspective.
>
> The write side handles 0x3B4/0x3B5 but not 0x3BA, consistent with the
> existing lack of a 0x3DA write handler.
>
> The Aspeed AST2600's VBIOS uses these I/O ports, and these changes are
> needed for it's VBIOS to run.

Please use 'its' rather than 'it's' here.

> [...]
>
> drivers/bios_emulator/besys.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -270,6 +270,18 @@ static u8 VGA_inpb (const int port)
> +     case 0x3B4:
> +             if (!(_BE_env.emu3C2 & 0x1))
> +                     return _BE_env.emu3D4;
> +             break;
> +     case 0x3B5:
> +             if (!(_BE_env.emu3C2 & 0x1) && (_BE_env.emu3D4 < CRT_C))
> +                     return _BE_env.emu3D5[_BE_env.emu3D4];
> +             break;

This repeats the 0x3D4/0x3D5 cases with the condition inverted, and
VGA_outpb() does the same again. You could add a small helper that
checks whether the CRTC port matches the current mode, for example:

    static bool vga_crtc_active(int port)
    {
            return (port >= 0x3d0) == !!(_BE_env.emu3C2 & 1);
    }

Then 0x3B4 can share a case with 0x3D4, and 0x3B5 with 0x3D5, in both
functions, removing the duplication. What do you think?

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -321,6 +333,10 @@ static u8 VGA_inpb (const int port)
> +     /*
> +      * 3BA is a mirror of 3DA
> +      */
> +     case 0x3BA:
>       case 0x3DA:

Just to check: on real hardware 0x3BA only decodes in monochrome mode,
so a read in colour mode should not reset flipFlop3C0 or toggle
emu3DA. The existing 0x3DA case doesn't check the mode either, so this
may not matter for the AST2600 VBIOS, but it would be more accurate to
use the same mode check as 0x3B4/0x3B5. Also, a single-line comment is
enough here.

Regards,
Simon
