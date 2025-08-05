Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CFDC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 23:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696C3831E4;
	Wed,  6 Aug 2025 01:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LgxuGZSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 214EF834AD; Wed,  6 Aug 2025 01:10:03 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC0CF83102
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 01:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55b9c2482e9so3742352e87.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754435396; x=1755040196; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0M8pGidDHWg65BOBaqJAGajmHvfqqNxWeqNFk6fB9EA=;
 b=LgxuGZSOqv9NJHRbWddleUkuLvtp/0F0cZdKNkLp/9QzpHGep8NjmWM6ANyBkn/c/T
 KZAtwWuva2gsAgLoG1NSV4UG41uK9LYFyTuyZs3s3PMV4xHfezdjrZ3I4z8qastt+mQR
 oxUg/N8aAvYxaSSSlxXxBPvmRGWdHlCNlClYX4/xH6wRz5ajwmXXzAtERgB3mwsA7UmH
 ibjW3P3xgjeHSBgZQpSZQsiDrvZmfDX1c7EuZSfiQFIVySRpzi46zDOIfdViBTf+s4wh
 ixmZ+NzzD8lj7WSWnNtqluNoW1Z0z0KUmYcRlfv66g78nrI5JmO0GHkukX8shmc2afCz
 ajvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754435396; x=1755040196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0M8pGidDHWg65BOBaqJAGajmHvfqqNxWeqNFk6fB9EA=;
 b=BhQkmTDw1i3QOVTn+0/Hc0edDo7PWfabsBtg2IIgP+ktkEtLu26lXZgP3wmdKcw7Lp
 92g0std8qjHYgjTS6tA5zpXh93FavRaQwDXC93ZAVD9FEjzu+fQ9S40/DB79ybJ1RSM7
 flrl6ZpiwEEP/DB7wjPQj3ctI4K03uaFPZQjZng0rRRiGjj3byZMsDWO3EM5k9Ze7eRB
 AwX2VV7YxwP1iGbfw/ukYOymSNuAF8gx2OSSSPAbdt32FmBzNSJRzxpjSlavU8AoK5cS
 jH00BLBkei7X2LW+JWYACb5xXCkpcTof+yymhoAuGRZzMPtuTev6ellfRYhxtEHSucSr
 Ze5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHMkcS7o3bBJISHXC4BAWs8yj0R1XwJx2rrAZiUjpJB8La/+AA3IfJQi2ilBopuAcUCc91+eE=@lists.denx.de
X-Gm-Message-State: AOJu0YytFCCKD+b84Eqe6BX5GrjDAD+zdX/FYXk/KEKOfa2EnrKlfGoc
 56yl3yx1SJ+4cFulMm7HMdY8RfvrRa1ohiSh1r8SPcBmDXx4IFhMJp4a+oJnayz5a27i+wPPWXo
 VAlmVwJ5nXc+ORWT/on/n2y8vQngNwkw=
X-Gm-Gg: ASbGncu0nL+20hwif+ELLFOZT5JQzXNV5QkSwgUOXoux1Qeh24Ms5dbDuYuP7nFMo47
 2skxhoC19uQe+iy/S8Xy2uPs+DA3PC7mLdnsL5O7F4cmy8kueTTiTD8VHDcYzZHpYPvuD4xWO8g
 wQb4uzPBKSI93J2dXWvJqXxKWwuKRvY8rdyj3g+cq/MNFuIKgcJ/0Sp3u483yVMSnM5qlvsXga8
 n3b2pyOOlumgcmbRwlOALMgEPWbGbxkHmIhMykCi1ixRdOcTQ==
X-Google-Smtp-Source: AGHT+IFsKOgTaX5sVxZeUAD/b06nIQxthccQwX4mfRQSCkTGaJtbmxysMIr7r+8KX72OcaKlqyT5UVhE0sAhmjnpa0Y=
X-Received: by 2002:a05:6512:3d27:b0:54f:bdfe:ece5 with SMTP id
 2adb3069b0e04-55caf2fba1bmr160344e87.14.1754435396017; Tue, 05 Aug 2025
 16:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250731-imx8m-optional-optee-v1-1-5b5ea143468f@phytec.de>
In-Reply-To: <20250731-imx8m-optional-optee-v1-1-5b5ea143468f@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Aug 2025 20:09:44 -0300
X-Gm-Features: Ac12FXzrRJ4R9MTiqtcLEWSm7tYmY4Canrxjz3o_PwMTMTEqeFwe26pV6GboPlc
Message-ID: <CAOMZO5BFYcXNmERqyUSOoHQ-cEaqYaMgYMub-ZGT5OLFJEMaTw@mail.gmail.com>
Subject: Re: [PATCH RFC] dts: imx8m{m,n,p,q}: Make optee packaging optional
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Thu, Jul 31, 2025 at 9:34=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> binman can omit packaging an optional blob when it is missing.
> This allows us to not bother with config options.
> The core challenge is the interaction between tf-a and OP-TEE where
> U-Boot/binman does not know whether tf-a was built with SPD=3Dopteed or
> without. This is important because tf-a might jump into the void when no
> optee_os is present, leading to boot failure. Thus by marking it
> optional, user is prompted to recheck (due to the warning message)
> whether they really have the right combination of tf-a and optee.
>
> Note that after this commit a warning will be printed when optee is not
> present for a binman build.
>
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Due to a bug in binman, we had to guard binman tee.bin with OPTEE config
> as builds would error when tee.bin was not present in path; Even though
> optee_os was marked as optional in the binman tree.
> Since the bug has been resolved in
> d4f61eae2ab7 ('Merge patch series "Fix handling of optional blobs in binm=
an"'),
> we can mark it optional again without getting build errors.

Please include the paragraph above in the commit log and resubmit it
without the RFC tag.
