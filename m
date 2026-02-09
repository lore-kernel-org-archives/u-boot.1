Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F75CEF0712
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 06:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7943C83BC9;
	Mon,  9 Feb 2026 07:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H6ffndjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8806183BDD; Mon,  9 Feb 2026 07:38:56 +0100 (CET)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5833F839A5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 07:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-124a1b4dd40so1272307c88.0
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 22:38:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770619133; cv=none;
 d=google.com; s=arc-20240605;
 b=KzmmJ/NCPPS6cz2yZIJgBWaX3l6t4s8bE9HMQ+Q7rncln8+BDX/x1tEchee6Zx4Z5Z
 3oqWadNoDoY9idmZL1oFkMQJOz7y1tE+yZKa17d+9gkfvuFWyoMxdymWFjgRpCTm4lhU
 /7hQ/6HWi2jL2yoZe4a2WoOFaDtx+m3UtOzBWg2GutzQFZc9IjeYJSHHY1BYdhgpuRds
 lfjNv9prl1Tt8mRQr5BK3mudK0X75VP7+x29A7hbAYbJOVS0ES4kkAncYDossYz4rS0/
 9h5+tN/SUFKPvwPO7PYrV8EJfU7uecBW/a+XefEJ5gpj56c/rleh2FcoCdWWtM+SLfTd
 cnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h6O+obJp1gjkS7qJ7UUY6CofYXoMrtTycoV8atQIy2w=;
 fh=Lj6PJZg5EyEsez7uQJBDdIgKrnJnn4wabpHH7NsjTTU=;
 b=fO3zWwWHHhHKETnx5OcLYJzST3qvUhldAeOFGrn//7nCRdx3FE+sl7SVI026pCLSPu
 pGZ8nULOzz9DnUQA8utvz8ZLzFK64mkCgnxuIfTVyjVii4WrKBbnvbrjCCseEeqrPEgO
 rCJrwea864gcXysw/X+Ux5saMx/g2d6UJ09CC0OHaUo2V6CBepV/n14RJiPX+4p8KluB
 9tpHi2TtJvMNY0bqbN2BU1oXZ7LzZrGyjEccLCxxHMqL7fZn+XAqej0YiUTfMnmOvp8n
 36u4t1E5pyoq3ZMdfKPEVhblCV5nMgWA0cSVlU5NsMF9++n43AnUWe+ByFhLdpX/ZcRU
 9pbg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770619133; x=1771223933; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h6O+obJp1gjkS7qJ7UUY6CofYXoMrtTycoV8atQIy2w=;
 b=H6ffndjIvhJAEoUmE78hU50yaAybcMRnk1uu5Pk+uD8akHUbSf9YnXFhZ1co4HkChg
 AMnabt7hhtOJ2HAs85xBVtDSj9nqprVpwqKCpP5s/460UtUjzCFjvx058+FN9lJC8Z2K
 csB9Si6DBLEIo1h43u1mxZAZT/DYYXr0w23ASe/j/xV9Sc1xu6u1vliZPhIWud8FHv0a
 /vbyWIXA45zG7Icb7bdptngrQja8AnbV6HojsJfY1DiMOiJgtIWyVqDfpvYwip1gYI1i
 PBOFNiPwoX33a3J7T6fCiLLlnJtM3s15mDoeQbjFGtiuvDlRb2AYVeiLuiu2ijLCSNOX
 x44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770619133; x=1771223933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h6O+obJp1gjkS7qJ7UUY6CofYXoMrtTycoV8atQIy2w=;
 b=b/LEv3unjt+4lUUJt9Ah0ENW/UJH1xfcOloaIRJsJSkO2pt7M0+4DO18Aj/2QYJHGN
 G01vI1S5mkXGUfjOJ17NNfecNPBTJNG3Na9AwZ+IqXhowcyOXbWaVrAjflnEO07Jm49X
 Ckmlv2xaZkzkdNhjaAQaOxqPVSudvQGtNkF9/uqSATCKLePaRthZPy/drl5jpYsEUmjt
 pHt09CQlj1WzEEEwuqzKgvusc1sLW2q1pwal7Zv7oIJwdt3SdWfVGGgBHObEHrJ7vnQD
 YvN3SvajD2lNPGfKfTgpqeWsEI+Ei8cpkIblinpuWfsVVfPLEDscHMJAamA4Zuw/u+B2
 E44Q==
X-Gm-Message-State: AOJu0Yw8EkBoFlIExKmXUH7g9kvJ5sMmDEE0lMOF1cetrQWD+BafWg3Q
 BJQ0HB6S3iizB0KAx60MSwbpPGRnxcuFjiCVEw55idMkaXSegjvvX5nZIUtE1vR8tBGhFiMU9gq
 VKT2PkW5rtPVrgOQy94dhO8FXYIIk1Fd0
X-Gm-Gg: AZuq6aJyqn3RsMmzKMSAu7wFCD2OxoZZo6iglpkZJ1g95zFwp9ZGCVrU2uVNI0FKbu7
 Sl21xEmGEarKsVw/2/5WvNkzLKl/+IoDoXVz5GuLSIQD7s6SjBUxNMus4wg2+4buqfKyHFG+sR8
 hlBgZOtAVGVEcaFUNQIqt1v3XDf0scfK5Yxw2odX7dFGRLbY1Pk8N1aoE40PRcuMhjNjstdcWZc
 /q4csCZLDa2rDfauAvJFGDrEQU05xeCnm6IcE/ZHm28cdRBbRR3GISsKKSixtYGiuKbRVB9xrYA
 ngZf7xFG4cwJuKOwaSykG3pys0c=
X-Received: by 2002:a05:7022:e20:b0:123:2e43:eceb with SMTP id
 a92af1059eb24-12704002b64mr4775719c88.29.1770619132607; Sun, 08 Feb 2026
 22:38:52 -0800 (PST)
MIME-Version: 1.0
References: <CAA=Y9tYS6=KJDyMYK5VAR5JDiv57M+MAv+i-m3cykb=nCtv3qA@mail.gmail.com>
In-Reply-To: <CAA=Y9tYS6=KJDyMYK5VAR5JDiv57M+MAv+i-m3cykb=nCtv3qA@mail.gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Mon, 9 Feb 2026 01:38:13 -0500
X-Gm-Features: AZwV_QisOXq-741-T8EtaRsp6HibBavOWtA40QVr4P8iyB_5zRt1uV59svrEO14
Message-ID: <CABdDSeUX_QrW6KE0aeepbFZNmiFCYSG4-h4A5kO7zwG--9u2og@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
To: Caleb Ethridge <jcethrid@gmail.com>,
 Philip Molloy <philip@philipmolloy.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>
Cc: u-boot@lists.denx.de, 
 "caleb.ethridge@analog.com" <caleb.ethridge@analog.com>, trini@konsulko.com,
 linux@analog.com
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

Hi Caleb,

+CC: Philip and Utsav, it looks like git-email did not pick up the cc
output from get_maintainer.pl.

On Thu, Feb 5, 2026 at 11:58=E2=80=AFAM Caleb Ethridge <jcethrid@gmail.com>=
 wrote:
>
> From: Caleb Ethridge <caleb.ethridge@analog.com>
> Date: Tue, 3 Feb 2026 14:45:53 -0500
> Subject: [PATCH] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
>
> Updates the polarities for the GPIOs on the sc594
> EZKIT, as the current version was still on an old
> revision of the hardware. The GPIOs now match the
> sc598 EZKIT as expected.
>
> Fixes: be79378 ("board: adi: Add support for SC594")
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>

Can we add a bit more detail to the commit message? Were the GPIO
polarities incorrect before, or are the polarities different between
two revisions of the SOM? We want to make sure that if a customer with
an older SOM uses mainline and finds that they cannot access octal spi
flash, that they can find information saying specifically that their
version is not supported by default.

>   octal {
>   gpio-hog;
> - gpios =3D <8 GPIO_ACTIVE_HIGH>;
> + gpios =3D <8 GPIO_ACTIVE_LOW>;
>   output-low;
>   line-name =3D "octal-spi-cs-en";
>   bootph-pre-ram;
> --
> 2.34.1

I assume this will be similar to the corresponding change for the
SC598 that I mentioned caused all SPI flash to stop working for me on
Rev C/D. Luckily on the SC594 SOM the flash conflict is different, so
I don't anticipate it to prevent it from running entirely, but I do
want people to know why if they see strange behavior.

Thanks,
Greg
