Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BB4CFA472
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 20:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C07C68939B;
	Wed, 23 Oct 2024 22:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SxZIpCci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E737A88B11; Wed, 23 Oct 2024 22:11:20 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5722087F7D
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 22:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e2b9a22f60cso27606276.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729714270; x=1730319070; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALHfwdDoDWdYEJAhWktodFsUcTIz3WmSt3lHBLI74bg=;
 b=SxZIpCciXjmBVKIIee/V08cxlsP1kiw9o8fkaaOz2fB9ZBpKAuihZTcsIFytuRgBr+
 bBcoYlOpC3EzOthg2+tCR3CTyGTddd/+WfVDCSVxXLHoj+EeKv+6F4G4wHGFbiGAIrk7
 OTkQghiW+fag044/q1rCw75rI+bpQnAOQQojczv8KmBHrE0T7D+9/sjOk+pKMBN215/N
 OK8q9f6h34cvM14fu2iXy5gIf2B9HS7oIfsUa11LnIZ84ynY8cR1WUPNkBZsD7byF4Au
 6CwzxlG5DmN+0bqk/Af4XeRri3N6opVgQ8hPzB1XABjru9M+mC3ZsgwC8YzUcAxwaqbc
 JRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729714270; x=1730319070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALHfwdDoDWdYEJAhWktodFsUcTIz3WmSt3lHBLI74bg=;
 b=jQp0625xXFJWQaC4HWh1cZuwfODnAFqnrIIjrZj2w3+FLpvZyJcUIJL3u1EOLVrhuP
 NQyycchsDRPu3D0oxU8+LPgCUIFgPNg0prUEK6QjN5vgU3UBUvYAr0GUl0BWMR2NgKzH
 2UxHae2SItQQPf+J/Az6Y6iJEO0SFVNFH6QmmN9HQsuY5VoPC0ZrvwT/byWHSqZ4GSiV
 b17aVpA5YSO6jTBcSRWs8585yJLqv5NtjNpTvmBbrtoZH2goVVzRQoPyyPUthplHAvbG
 b2yx0SgkWgZ767NKfl7s5/yThuDbiBhtHoSJulr2X+7XuifltMkbJ9ldJuHeNzt0R6KC
 InJQ==
X-Gm-Message-State: AOJu0YzrDZV5OvLuhr2bFAsut6ASUtlPjJL1MmYngyabHeXzSL8TyNZX
 fu9VLLKhECbvlVaw+VZX5EvgV4Hm6jIKjqStUStFhfT2mjNjs8CFGolID4VQmfrOqUTML/9UjLj
 ++L9y0g3w7Pytmw44PGU6Xt2Bzlo=
X-Google-Smtp-Source: AGHT+IF1yb5stqC9/+mA1JPWYIt0RhQJ8ODdK2Dunh1oRIFh9FyVb4xT4jxRrb3hNVergwwqNvTZ+lKOc9V6cvK8Ku0=
X-Received: by 2002:a05:690c:4a0d:b0:6e3:2066:2693 with SMTP id
 00721157ae682-6e7f0fd8255mr16170097b3.10.1729714270120; Wed, 23 Oct 2024
 13:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-3-l.rubusch@gmail.com>
 <ce29c957-4198-4947-b7de-7e10ed385eab@denx.de>
 <CAFXKEHZLwbU=w4LH4iiZeo4ycwOKjgi5YZesHHgxzy6Ac+TOUA@mail.gmail.com>
 <5ba375a1-cf1d-463c-8590-3ddf46c47f3e@denx.de>
In-Reply-To: <5ba375a1-cf1d-463c-8590-3ddf46c47f3e@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 23 Oct 2024 22:10:34 +0200
Message-ID: <CAFXKEHZ4+zPw7LuNYK2QZYOQj4v=1UMuf29CSGAEibSOWU48SQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] ARM: socfpga: add Mercury+ AA1 SoM support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sumit.garg@linaro.org, sjg@chromium.org, 
 xypron.glpk@gmx.de, michal.simek@amd.com, jit.loon.lim@intel.com, 
 barnas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 23 Oct 2024 22:55:07 +0200
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

Hi

On Sun, Oct 20, 2024 at 7:02=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 10/18/24 11:47 PM, Lothar Rubusch wrote:
> > On Mon, Oct 14, 2024 at 8:42=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >
> > [...]
> >
> >>> diff --git a/board/enclustra/mercury_aa1/fpga.its b/board/enclustra/m=
ercury_aa1/fpga.its
> >>> new file mode 100644
> >>> index 0000000000..cb42d61fbd
> >>> --- /dev/null
> >>> +++ b/board/enclustra/mercury_aa1/fpga.its
> >>> @@ -0,0 +1,32 @@
> >>> +/dts-v1/;
> >>> +
> >>> +/ {
> >>> +     description =3D "FIT image with FPGA bistream";
> >>> +     #address-cells =3D <1>;
> >>> +
> >>> +     images {
> >>> +             fpga-periph-1 {
> >>> +                     description =3D "FPGA peripheral bitstream";
> >>> +                     data =3D /incbin/("../../../bitstream.periph.rb=
f");
> >>> +                     type =3D "fpga";
> >>> +                     arch =3D "arm";
> >>> +                     compression =3D "none";
> >>> +             };
> >>> +
> >>> +             fpga-core-1 {
> >>> +                     description =3D "FPGA core bitstream";
> >>> +                     data =3D /incbin/("../../../bitstream.core.rbf"=
);
> >>> +                     type =3D "fpga";
> >>> +                     arch =3D "arm";
> >>> +                     compression =3D "none";
> >>> +             };
> >>> +     };
> >>> +
> >>> +     configurations {
> >>> +             default =3D "config-1";
> >>> +             config-1 {
> >>> +                     description =3D "Boot with FPGA early IO releas=
e config";
> >>> +                     fpga =3D "fpga-periph-1", "fpga-core-1";
> >>> +             };
> >>> +     };
> >>> +};
> >>
> >> Can this be generated using binman instead ?
> >
> > This would a oportunity for me to learn the binman tool. Great idea! I
> > need to read a bit more on binman to get a better understanding. I'll
> > give it a try and let you know. Thank you.
>
> This commit might help:
>
> 5fccc2891e28 ("ARM: dts: stm32: Generate u-boot.itb using binman on DH
> STM32 DHSOM")
>

I face a problem here. First, to apply binman stances in the .dtsi and
integrating it as -u-boot.dtsi is very interesting and I actually like
the solution to bind everything togerther in this way.

But, I face the situation where the very design specific bitstream(s)
for the FPGA are actually not supposed to be upstreamed. Having u-boot
binaries and bitstream as .itb separate, allows to build the u-boot
part even w/o the bitstream, i.e. the u-boot setup can be quite
generic, can be tested and verified building. Is this still possible
if binman requires it as binary blob? On the otherhand it allows to
wrap the FPGA logic and exchange the .itb separately when developing a
design w/o the need to modify the bootloader.

So, I'd like to hear your opinion on that. Would the .itb appraoch be
acceptable in this case? Is there still a better way? Does it make
sense to make a separate binman setup instead?
