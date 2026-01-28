Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D515D46C06
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 21:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2755983C6E;
	Wed, 28 Jan 2026 22:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dfzwexci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCDF83F2E; Wed, 28 Jan 2026 21:03:02 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37AF583DFF
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 21:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-382fb275271so1900971fa.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 12:03:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769630579; cv=none;
 d=google.com; s=arc-20240605;
 b=K96RH1Oz2denWdVlbZM391C1LkXbR0xZ9pBLlWSanHIi1Rdl2gDj8hDi8fUQJnJMPb
 W0dtifx6Tj9TvJ/N+KM8J7Y0FritMKhDbeKP23EOhikycDutp642+KEMtBwgON3tBmrc
 sURUn0uffaCRnUIS2TUys38W7kEvsPgFnvIG13/5l6heHi9JWEEC6rj5J4LM5kIWsz/7
 xpIifo4L6Qn3jBvhpcD75SG0ympjEgrFlB7Be5gchwcSNdh7GherDjavwGH9AEdtBdom
 Zb0WnfV1eBc14cZTN1z4maLpK+wMt4XUK2IQdpQ0x8TTnBFcRLrsd5qiuIFQoLvL4mQj
 esRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8yrWdmVrCVHIm85uWZGcIOtHIQiCmqw4BE6OfvzBkHI=;
 fh=pWROPrRRpFFL3l/rgyoH13cbpCNEhjyurkIAlh6w4dE=;
 b=UO1AQ1Vs9iW9sh0l97tc+zh7UCJVgS+FdMyuIl6sc+YcC04Y++MMmTIZqPnG85oYEL
 W0ign+YInloq9gYv52k5YI1r/Si2VRd1Bl/4kioGIIlYczw3JRbf4yDl5nbavQ+mfesZ
 vivZDur6pyDP5MvHJfdfLmhLg2iyFfshiSqPYtc8rPTRMKhoAxQUi0uxuz+SXSeVNuDp
 Bgn07qyocxp9/en7IKhyfwLvKQJ6NDSDJOq5FEgB8zHhRORttixsQve1RA4nWTZmE5l/
 49AuojpC3VWyrohY/aNpudX0aAJTlKG+guj9M8ezRn12Z/3iMZsZu63fU6f2/08FtlQm
 Hpnw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769630579; x=1770235379; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8yrWdmVrCVHIm85uWZGcIOtHIQiCmqw4BE6OfvzBkHI=;
 b=DfzwexciW39lXgvbp/DKo5mxr90xTKv7/jcDxYTjI2JQsrBkBcurx03RfmjYjSNstq
 M7LQvujIGRlUY7y7HDx/ChIDT7FsG7EE34Q7eGzf5QSzPLTw/r1K/Y+ycZV3Rml0tSFp
 tknk4VXHoE7QWGAtSTG6ytNIG6yjk/jn7SMbyE/3r8AisP5wDhafRfnFyYCHqrgeznIg
 aJa1ny8OTCxSz5xeyFiaJ3qm84XzNqZ/c+ivY4XcoY8T8c/WfRzq/HsKs4eNSCaSSFeM
 W5UVo9+8Bn3d0tdoitbw2u7xoUFzFyUasmuK5QCbiYzcmwd0E/68fPDNEx3hHB8H6FUG
 hpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769630579; x=1770235379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8yrWdmVrCVHIm85uWZGcIOtHIQiCmqw4BE6OfvzBkHI=;
 b=msKweTekDs5qivPwZcNhTdNRFU7EAuKxX4z9j2/FSBN3wjHYwpEsF47ny8O99CJwi1
 KihDmJGA0/U0vdY1NonAKBP95KmD6JCLLAFmt6bPjCTBHaN6vfTjsx68hv6Hlid16hfY
 ooDVJH/ts2NKPWOIUxwqUVK1OOQ9Y9KpG+yj7N3N/fJtsBFaUTQUlqe2a5YaBGqXTnxG
 /4WfTT4tW6Oa3CiNBfywN1XYMoreFV2qHYBVTlgInx49+t0zLB3olG+FIEhkk3Rj82ev
 wiH2ScBDiVTZt6Nnh8yCaxf/DmaMZeIPlG3K7hwpC8b3+RGEkupS1nwJbg3SA/5PhSeJ
 VP8g==
X-Gm-Message-State: AOJu0YwKzUxpH0st+1M+TH5Ff0hGfX0DZXSY5V97DEQsnPZb9E1en1WS
 glrvg9fJWsfcnz9SR3WsBOYMsCN3ZoEVycahdvHHhqNBRHOq1Rrv8yQv9tIRO7oNkc+ISPgmwZw
 6iS6Zpg/FL1IqFur2OGnBGdU5v0bXbJIwtElw
X-Gm-Gg: AZuq6aJ2aCgj5pZes5Mn5t/K7AWkTOlU6bvo+vnN+fMC33Bz+HGwIJE4RrV8/LXsNLp
 T4Xw/oVSvHsKUgjMrJn7g3wFqM8PMoAFuMwts4UmZWzwVP3wEkrf/QP2vmvyOfhLUwUnh8Q1MMu
 PpVWNOeC+j9OpY/0vWZ/fk2Lin+yV/vH/u+3UB+HkqsaqjTgb2472vCjt0AEP9Rwdba8ZxIO0My
 N+VSTe8SyNV6mJpn4CYnP8BmMVaCEbHY0OEu8kFZaAsu98FYdfAJG/IEJLF90l8bzuVHOrBiKDz
 Qqy6B3q4f94sVetb1k1pu1KcWWjt
X-Received: by 2002:a05:6512:ac6:b0:59d:f2f3:7e9a with SMTP id
 2adb3069b0e04-59e04027a89mr2951174e87.36.1769630579028; Wed, 28 Jan 2026
 12:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20260128192617.1724570-1-trini@konsulko.com>
In-Reply-To: <20260128192617.1724570-1-trini@konsulko.com>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Wed, 28 Jan 2026 17:02:47 -0300
X-Gm-Features: AZwV_QjTQEJMPCM5ZTiy5SDX2sl9sKts5PoEkO6UeLrdRnhz12Ek8dxxYBjIYfE
Message-ID: <CAP8WwTETA8ZXSC19bhvtTRLP2t-nvcqa+ER3HrYpshQDr05iAA@mail.gmail.com>
Subject: Re: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailman-Approved-At: Wed, 28 Jan 2026 22:49:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

Indeed, there are a lot of PPC targets that try to use this symbol, but as
Peng Fan reported before, his CI reported a build failure.

On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wr=
ote:

> On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
> >This patch adds CPLD support via IFC to the ls1021a-iot board.
> >
> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
>
> CI report build failure.
>
>   CC      drivers/video/hitachi-tx10d07vm0baa.o
> In file included from drivers/misc/fsl_ifc.c:8:
> include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or director=
y
>    16 | #include <asm/ppc.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o] Error 1
> make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      drivers/rtc/ht1380.o
>   CC      drivers/video/hitachi_tx18d42vm_lcd.o
>   CC      drivers/rtc/i2c_rtc_emul.o
>
> make[1]: *** [Makefile:2191: drivers] Error 2
> make: *** [Makefile:362: __build_one_by_one] Error 2
> Cleaning up project directory and file based variables
>
> Regards
> Peng


Is that okay now Peng Fan?

If so, then my v2 patch would have worked.

BR,
Mateus

On Wed, Jan 28, 2026 at 4:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> This symbol is used on a number of PowerPC platforms as well, so make it
> available there again.
>
> Fixes: 424b324165ea ("armv7: Add CPLD support via IFC to the ls1021a-iot
> board.")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index be7fdab56d14..a0aa290480eb 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -695,7 +695,7 @@ config ESM_PMIC
>
>  config FSL_IFC
>         bool "Freescale Integrated Flash Controller"
> -       depends on ARM
> +       depends on ARM || PPC
>         help
>           This driver is for the Integrated Flash Controller(IFC) module
>           available in Freescale SoCs. This controller allows to handle
> --
> 2.43.0
>
>
