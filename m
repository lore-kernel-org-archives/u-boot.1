Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974ABC3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 10:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0775886AF;
	Sat, 27 Jul 2024 12:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rlpkpnl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A8988646; Sat, 27 Jul 2024 12:36:04 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D1288216
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 12:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52fc14d6689so2109739e87.1
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 03:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722076561; x=1722681361; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=osiFLReKr/wSImVw/JkAPtuT6CZk/H+lLkRavYHbVbQ=;
 b=Rlpkpnl+QGap0uFFE5ttWMaH81UsKux0GAxcD5+iXkjt9e0zlcKC8SrTdk9Nk7KFmv
 AvegzDCuNBRRcOhKYK2MEU64v96pcWvnHw+m5p0zjy3+JNTBJrE1dfyT4ZFpChFbKajW
 nyrLWabtJTRJkICUX4Ye1zSZ1DqSqLBc5gGyscrj7p5kN+qt+eINBEh2gxUWRY1zNz7W
 8ll/rA6k/0G3f+Zo4p1uifVxIi69zuMcRxiLzzgu1NVLS1DUAV39tkMeVLue1RNrJj7v
 0Tz910boZkcaaz0KYDZFlMD+Kb3x7QLxtXRsjQiDILxQzv4ZGob4uSgVeJZEoQTPvz2g
 MA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722076561; x=1722681361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osiFLReKr/wSImVw/JkAPtuT6CZk/H+lLkRavYHbVbQ=;
 b=AJyeRSLA8SWy3pyZE+Ae9ACmRq5NsgcXNu7A/IrXo35TzakKUUpajHMqT/a5QqytI9
 E1xGrVEuYhaXSFByQOTsydq5Z+dDdSOLFjb/TT+D6Jw7h22JHzTVne8XbfK14MfGiQLi
 T+37rPH/CCEJkfAFyWh3Cg+AHOLKfqs2TloniCaQ7oZ8k33rmSCVZYYgMaJrZLCnUme0
 bZCK/W0QtcQd0H8b/iB1tEZ4+azOzC3HwgYs+fIqTAiHqvPF+DFcQvPSiIoPQhA4K5oA
 p2Dv1QfiTtXQN1fVw4dv2dmMp8HRfdqIoVi9N9XkSgBhaN5bCoP6AK4NCCGSKOG6QBjx
 5Qzg==
X-Gm-Message-State: AOJu0YxBxpXcD1CByTrJlny6hWYpwn815h/E7moNpof2HSJM38HYyMJ7
 nGtoc1AjLL4Hfhpssu+XSz9D0tcoVbgLCurufWTq1R+g1CU3m2Inm/KxwiyQSLE8MS0YY+upep4
 JWezJol11WADupuLyt+E0SAuGm7U=
X-Google-Smtp-Source: AGHT+IHjzkajupcXuxdPo1YVuvoNFoEIRhWA5LTbLdc9qIn/0L2REaJZlIKeg3TqBkOmm27tdQhyUZEHhyAev91niE0=
X-Received: by 2002:ac2:47ed:0:b0:52e:faf0:410 with SMTP id
 2adb3069b0e04-5309b269bf9mr1510547e87.1.1722076561031; Sat, 27 Jul 2024
 03:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240726120721.150484-1-fido_max@inbox.ru>
In-Reply-To: <20240726120721.150484-1-fido_max@inbox.ru>
From: E Shattow <lucent@gmail.com>
Date: Sat, 27 Jul 2024 03:35:50 -0700
Message-ID: <CANV2PTMxAOrVDGrD-QJWJjdJ=+1NV-9SNcbBZTsfMuDhqiJR=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: define find_{first,
 next}_zero_bit in asm/bitops.h
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: u-boot@lists.denx.de, rick@andestech.com, ycliang@andestech.com, 
 trini@konsulko.com
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

Is this a problem in Linux upstream? or specific to U-Boot, and is it
a regression?

refrerence https://lore.kernel.org/u-boot/20240504183354.GL2568172@bill-the=
-cat/
and reference https://lore.kernel.org/u-boot/BJXPR01MB0855813DD38EF86CCA6DD=
5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn/

On Fri, Jul 26, 2024 at 5:44=E2=80=AFAM Maxim Kochetkov <fido_max@inbox.ru>=
 wrote:
>
> These seem to be missing, and trying to build fastboot cmd without
> them is causing errors due to these being missing.
>
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  arch/riscv/include/asm/bitops.h | 40 +++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bit=
ops.h
> index 35f1368b83..2f2994c4dd 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -138,6 +138,43 @@ static inline unsigned long ffz(unsigned long word)
>         return k;
>  }
>
> +static inline int find_next_zero_bit(void *addr, int size, int offset)
> +{
> +       unsigned long *p =3D ((unsigned long *)addr) + (offset / BITS_PER=
_LONG);
> +       unsigned long result =3D offset & ~(BITS_PER_LONG - 1);
> +       unsigned long tmp;
> +
> +       if (offset >=3D size)
> +               return size;
> +       size -=3D result;
> +       offset &=3D (BITS_PER_LONG - 1);
> +       if (offset) {
> +               tmp =3D *(p++);
> +               tmp |=3D ~0UL >> (BITS_PER_LONG - offset);
> +               if (size < BITS_PER_LONG)
> +                       goto found_first;
> +               if (~tmp)
> +                       goto found_middle;
> +               size -=3D BITS_PER_LONG;
> +               result +=3D BITS_PER_LONG;
> +       }
> +       while (size & ~(BITS_PER_LONG - 1)) {
> +               tmp =3D *(p++);
> +               if (~tmp)
> +                       goto found_middle;
> +               result +=3D BITS_PER_LONG;
> +               size -=3D BITS_PER_LONG;
> +       }
> +       if (!size)
> +               return result;
> +       tmp =3D *p;
> +
> +found_first:
> +       tmp |=3D ~0UL << size;
> +found_middle:
> +       return result + ffz(tmp);
> +}
> +
>  /*
>   * ffs: find first bit set. This is defined the same way as
>   * the libc and compiler builtin ffs routines, therefore
> @@ -158,6 +195,9 @@ static inline unsigned long ffz(unsigned long word)
>  #define hweight16(x) generic_hweight16(x)
>  #define hweight8(x) generic_hweight8(x)
>
> +#define find_first_zero_bit(addr, size) \
> +       find_next_zero_bit((addr), (size), 0)
> +
>  #define test_and_set_bit               __test_and_set_bit
>  #define test_and_clear_bit             __test_and_clear_bit
>
> --
> 2.45.2
>

-E
