Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA226C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 17:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8138304C;
	Tue,  1 Jul 2025 19:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wqpUl4Tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D1E82F8E; Tue,  1 Jul 2025 19:09:00 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6EF82FE1
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 19:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae3be3eabd8so45246166b.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389738; x=1751994538; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dN1TvZWB9DH48Rq4Ld9XviduQOC5JMT75jlXGTrXYDE=;
 b=wqpUl4TkIsD+psz5iszX1RZJ3dB6jN4e9lmGIFpjwpRggYUfuLU08k+61MNCQ0DCC8
 b7w1FWzVu6MI+uY9BUN21SHDi9DWwFXkbPUuLTyuOKG68cX33nCe026gcRDiPxYZ0Gb6
 qw/BJZtRT4b7afFOapOxSh2KL7ZXIraOrETUrujfwGtXE2ZExvk9bX7sJtvivQTLqRuB
 i30NKVMvinD2aucDkck2cIfzPpsfFoFtQXWmmiRJ66OwL2zdGvwebY8BhSCZYxCePXvv
 pXTb2JqDnYAGtsOFIUxa7It0euJDVyLcZdZwYwBB4fXOGvO7z5WRmgz8B42TfjMq/jQr
 Ok5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389738; x=1751994538;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dN1TvZWB9DH48Rq4Ld9XviduQOC5JMT75jlXGTrXYDE=;
 b=JI7qi6HEtGXMGWOYhvyuBiwK9vlHh53/IbV55hSbd53w7gXjmr17JaWcFxMLRtNNTE
 lB/OQ3xMz8sja00QaW+xzktsef0zocBRk1U5huOgjzaf+HWAyzCGjvvgqAeWM/GvXJPa
 JNfBlq37lRf5lEvmDknGLmdRPwfm+Fufb2GMOi2P9jLn2OMRyMhIYu/OhuSxzQb8RPXk
 IduobfG4WjGGzQj1WhA21tyiYsSDfD7ph0Fv0a3DZrghOg1pnG63GFQiKirLEuJSW/si
 55zNEBnRqncweoJ1rA2DY7CE5dYJ5i83T9QMMepyiiH6sseQEYBY82SMajxQhillj6KL
 JDxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMhUTYqP05wbkDXOYfouZd2C0F/gSvXsbEig2E8eIb14tFswy0VM3iE4nm61R+2kh9Gv+AUaY=@lists.denx.de
X-Gm-Message-State: AOJu0YyV5h2FBS+vhp/Abp92wpU5c034l0LXTd0kyCFUks9UcXAoM2xS
 nk1eXzJgSs08joQv0QhxBzr9igL1fu3/W6Yri6KraOtfHscyAn2eJt0dyteed+Dz5tA=
X-Gm-Gg: ASbGncsOABzKVHOMwlhgVleHnwqs4UgZhHgFnsHl5SB52mYRS19wFIFKRRM4OLVG+fB
 fNAi807xoQro3ISWYt1ThFgEs7ViFT4xBEOnta+gE9Rcj2clrAUmZj+Pu3cUbxAAXZOjx4WjFin
 hXkiZqzDEFaCTDvbnheLD16Im0AwTuQg29Rr4UhBZQ/Qjnx07MTyOq5f+cwd+2H+MUjb8ICDcZ2
 CNjiDNngmySODYGp9BO02W+Ia7wzHRV0pKiEv5GJJrJKtaup832a/zersrIx64UFHmiFbUIawh2
 bI3rYewO9PIy+IsoPF1KJ08yI+uNZ5SFhbosrCUy9JigUXaYYH1AAg40K5ZzmmomMzDvy1I4woU
 VGahkLdCP+F8gIib1IOuBf9tT
X-Google-Smtp-Source: AGHT+IH+GQOEYfJFPJKM9DqRNFBBUU+XbpHENSnCuhxzlLGW7hxW+FRbXSK9M3Un58ncdwK00SKqww==
X-Received: by 2002:a17:906:6a25:b0:ad5:6174:f947 with SMTP id
 a640c23a62f3a-ae3aa2f64a4mr421286866b.22.1751389737630; 
 Tue, 01 Jul 2025 10:08:57 -0700 (PDT)
Received: from localhost (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c0138bsm899730766b.85.2025.07.01.10.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 10:08:57 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Jul 2025 20:08:55 +0300
Message-Id: <DB0VUHAKWAJN.EIPJLG1R2OKU@linaro.org>
To: "brock_zheng" <yzheng@techyauld.com>, "Tom Rini" <trini@konsulko.com>
Cc: "David Feng" <fenghua@phytium.com.cn>, "Albert ARIBAUD"
 <albert.u.boot@aribaud.net>, "U-Boot Mailing List" <u-boot@lists.denx.de>
Subject: Re: AARCH64 clean bss bug
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.0
References: <zfknlzcemnnaka5w2er5wjwefwoidrpndc4gjhx6d5xr6nlcjr@pasfayjiutii>
In-Reply-To: <zfknlzcemnnaka5w2er5wjwefwoidrpndc4gjhx6d5xr6nlcjr@pasfayjiutii>
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

Hi Brock

On Sun Jun 29, 2025 at 7:37 AM EEST, brock_zheng wrote:
>
> Hi, all
>
>     I found a bug on AARCH64 platform about clean .bss section after relo=
cating.
>
>     In crt0_64.S, it use instruction 'ldr' to load the start/stop
>     address of BSS after relocating.  My testing shows that
>     __bss_start loaded successfuly, but 'x1 <=3D __bss_end' got the
>     address _BEFORE_ allocating.o

One of the problems when using the literal pool is that the access is PC-re=
lative, but
the entry itself contains an asbolute address. This code runs after relocat=
ion right?
It the literal pool entries relocated?
Any idea why __bss_end is wrong? It would be helpful to have a more complet=
e commit message

>
>     If I swap the two instruction sequence, the result is swapped
>     also. But neither code can gives the right result of those two
>     addesses _AFTER_ relocation.
>
>     my patch use 'adr' instead of 'ldr', seems OK for my RK3568 chip.

Uisng adr for linker symbols is fine, but can you please use adrp+add inste=
ad of adr?

Thanks
/Ilias
>
>
> --
> Brock Zheng <yzheng@techyauld.com>
> =E9=83=91 =E7=A5=8E
>
> =E5=8C=97=E4=BA=AC=E4=B8=AD=E7=A7=91=E8=85=BE=E8=B6=8A=E7=A7=91=E6=8A=80=
=E5=8F=91=E5=B1=95=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
> =E5=8C=97=E4=BA=AC=E5=B8=82 =E6=B5=B7=E6=B7=80=E5=8C=BA =E4=B8=9C=E5=8C=
=97=E6=97=BA=E8=A5=BF=E8=B7=AF8=E5=8F=B7 =E4=B8=AD=E5=85=B3=E6=9D=91=E8=BD=
=AF=E4=BB=B6=E5=9B=AD27=E5=8F=B7=E9=99=A2 =E5=8D=83=E6=96=B9=E5=A4=A7=E5=8E=
=A6A=E5=BA=A72=E5=B1=82 (=E9=82=AE=E7=BC=96:100193)

