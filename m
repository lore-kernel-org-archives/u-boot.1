Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A2CFED9EC
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 17:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6798D841FF;
	Tue, 17 Mar 2026 18:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lMjpZAfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8639C8421D; Tue, 17 Mar 2026 18:06:31 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BF58415D
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a133502accso7337554e87.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 10:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773767189; cv=none;
 d=google.com; s=arc-20240605;
 b=XJ6VBiBlfgpI+Cs24lZzOrCjNuZMizTi3/zenV7ZXO/N92vq5xPP9jUGFVEEuS+e4h
 fy/1/C/N4wVa1gKb8/nOCi0h5UQq3oJqrr3v+HcuC7bUQtslJ/o1gsJSS5bd0P3duD6b
 rsA8ggWUCtGAnYQY4FVIAyVc9wQAxRJYI7mVarOJ5tluimP6D6aMl4b+rV/FIoGTFvxb
 uaNXoo7QUq9ZdIKjBausg9KrQE23oG9KLTs6H8FraeThxckMMzyr+dvr1TjzCZv1l47h
 aIGoeXFnWPBHJBORI3olAbJQaZbgNN9vEkRTVNJOQQJZN+J4XWs3/KXKeJReuQ0ZRdsQ
 hx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=773uEbqKphRdQ7wmff9S6OXgcGshNKEYkF3DDM1EH3c=;
 fh=cPWHQaowfHOc6wdJpq+4+GI3lnGWU9mGJUQ4sEUOMJI=;
 b=er41EMDAizAsa6byE2Bm25pqC3gVosSyT8BBBa62+qqe9XB78Izd6WqQEa5Xmbj6nH
 K+1yKRgTQmF7wd+/MBUNvlyytRbSaD/jXWsdCKVp2O1Zf41LdOqyrgzOTHmkt25MDbC2
 OjNi9WGQxB2ghVA31CKfW1UlvsprIW0BXgsFUysBixmB0TFbEJ5O/PZypNvdKP8AmhKw
 LuPg63ykmCnAym7xznshLTrFdJYnFIdVx3Hvbiniu8IEEFEqlkfRjByM67fGR4R835nY
 zaeC1tAgGi2/YXYhH9bfqaieKhkI673W2Drk0kZ/IFl5aFgzKX7Rpa0m+WsXIG/1yZuM
 wTxg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773767189; x=1774371989; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=773uEbqKphRdQ7wmff9S6OXgcGshNKEYkF3DDM1EH3c=;
 b=lMjpZAfktsyqsQPGOcSD2lffLenMUg6AeYrQ8bZgkPv4KWD/PJgNvBMN0Z8Wcffqu4
 Wt4QyagYxhigYa9hQAGOB7XLOAVOTByKlc2SkBa2z7URrG7wZDNNgRG2Do5dapeGQ141
 eR1baZCHZF/EpBTuQCiGgs9d0kc3uL4pgCYxsH7Iw4w4kI79xXr1JityT/zIGzsnLqkF
 iDnoEAH+iPpRKpFCoG0IdUeGBxdUmMqeZYPBif1LuKU96M48BSMfLhZwP47KQWkxG2HA
 QZpIu73PEp7Kkhs+28qAhs79lJxL3r+3lR5qrn6uoJTAVIFEjTB/kRE6SKhW2y9QC2KJ
 vrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773767189; x=1774371989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=773uEbqKphRdQ7wmff9S6OXgcGshNKEYkF3DDM1EH3c=;
 b=YVJm5EWf2XHOTiLRHNy+fXf7d4695ou+IeboiOdddn21Axbi+tcoYHhp0cVxTtQLBl
 3oDwCJuthgBVyxABKKiBKFF1wnABAR4lxAJjDWxtdk258pOJhnfH7OkkTcW/sIJMW4aE
 6t7kX7Jfbj/Cmz7cv6b1HFitxQuTWDpghTaVgM65OJWYU4VCSvWX8nXnZ0/bUgKGLMUW
 4lcynp+St1V/THLrmfhq7GiiHXHarc9uCRUDgx5+TpUbJKuu6UuFvB4zzHWTZTkyCVfd
 P8IHs/QIrLixNGUkgZIl6PA+L6jBcWXgN27xlyY0wQLDh3WWf6UFIxcksSQi7D8etybB
 t/ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlImjvXmiQFeLk2dNKYsRjrDoib+aZ1q0fBMUcZAhmvukZghcdW/GAmav9yqgt8XNLsBZMWNw=@lists.denx.de
X-Gm-Message-State: AOJu0YzUx3U1TngXBgdRhI+b+CqjsG+X08rXwdf9dr974iq/2KUT714p
 hx6UFjYLfcLLoT0ztdBWAAh41pFdP+K78jLp5HeazfOp01ZC2rYevh1zHmQXD3bcQLyH4GjVvzR
 p25HLLRaSMuWQlCl/RD73iPFmXOEKCIOT3GTe
X-Gm-Gg: ATEYQzxr6+OZ7rUffalo9SktvwD3vH7EREs1qkE3TJNbjrlUqxJOlaHQMuqc5VBfnka
 4Txs/WsM/OTqdXMxBqkVZU9obtMenWoXtgRCCm4NJYsecVMKYSCHq1D+RPUf6iTiVuxCHkQzRKD
 lIPMNGnJT3shmgj9ahITdzH2drkEeIjaA9eWE6p4cedfwtRYgjJQNeBBW2u/f6Bp6PS4X4QX2Vc
 DESeNYQTWChFACeTeVWIdJX5S+uhNZ5tDJO1ljWHfnPszIxrShwDyWnF+n6arL0j+R4Z+As7qI8
 2fZenh2i6nqrAiZT+np7VteIT133ZDgvWeremDQfyPjXJlpi/vtB1DdP99rCjK3euukCovY=
X-Received: by 2002:a05:6512:370a:b0:5a1:382c:3a49 with SMTP id
 2adb3069b0e04-5a2796b05demr73838e87.32.1773767188367; Tue, 17 Mar 2026
 10:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5D3yqFaDgriO2x3fnCrwGm0oV-chLsy3eOR2O3yg_MvNw@mail.gmail.com>
 <4e42b1c5ea6ea728c84ba1a8d48f48ae55780332.camel@phytec.de>
In-Reply-To: <4e42b1c5ea6ea728c84ba1a8d48f48ae55780332.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Mar 2026 14:06:16 -0300
X-Gm-Features: AaiRm515KsEFuw0Xjolt-T3PLNfA2ZljVTluBYEFU3TZxVWSLR3s5LqvwnxZzWQ
Message-ID: <CAOMZO5Df1w5nO330M-Ls6=iMHtViv1ymeZ63vEUzp1+25X7mUw@mail.gmail.com>
Subject: Re: OPTEE on i.MX8MP
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Yannic and Peng,

Thanks for your replies.

On Tue, Mar 17, 2026 at 3:41=E2=80=AFAM Yannic Moog <Y.Moog@phytec.de> wrot=
e:

> My guess is that you copied tee.bin, not tee-raw.bin [1] to the U-Boot di=
rectory.
> We need tee-raw.bin.

Yes, besides that, I had to pass the BL32_BASE option to TF-A and the
CFG_TZDRAM_START option to Optee-os:

TF-A (Mainline 2.14)
make -j12  SPD=3Dopteed PLAT=3Dimx8mp BL32_BASE=3D0x56000000
cp build/imx8mp/release/bl31.bin <u-boot-dir>

Optee-os (Mainline 4.9.0)
make -j12 CROSS_COMPILE=3Daarch64-linux-gnu- O=3Dout/arm
PLATFORM=3Dimx-mx8mpevk CFG_TZDRAM_START=3D0x56000000
cp out/arm/core/tee-raw.bin <u-boot-dir>/tee.bin

U-Boot:

--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -9,6 +9,7 @@ CONFIG_ENV_SIZE=3D0x4000
 CONFIG_ENV_OFFSET=3D0x200000
 CONFIG_DM_GPIO=3Dy
 CONFIG_DEFAULT_DEVICE_TREE=3D"freescale/imx8mp-evk"
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=3D0x56000000
 CONFIG_TARGET_IMX8MP_EVK=3Dy
 CONFIG_SYS_MONITOR_LEN=3D524288
 CONFIG_SPL_MMC=3Dy

With that, Linux registers the optee device successfully on kernel 6.18:

# dmesg | grep optee
[    0.000000] OF: reserved mem:
0x0000000057c00000..0x0000000057ffffff (4096 KiB) nomap non-reusable
optee_shm@57c00000
[    0.000000] OF: reserved mem:
0x0000000056000000..0x0000000057bfffff (28672 KiB) nomap non-reusable
optee_core@56000000
[    0.501959] optee: probing for conduit method.
[    0.502012] optee: revision 4.9 (c2b0684fcd899299)
[    0.522839] optee: dynamic shared memory is enabled
[    0.523251] optee: initialized driver
# ls /dev/tee*
/dev/tee0      /dev/teepriv0

I'll submit the patch for the imx8mp_evk_defconfig change and will
also add an Optee entry in doc/board/nxp/imx8mp_evk.rst

Thanks,

Fabio Estevam
