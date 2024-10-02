Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DD1CF31AF
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 10:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0384889057;
	Wed,  2 Oct 2024 12:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zmlihokj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77A788F7B; Wed,  2 Oct 2024 12:36:34 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 472AA89001
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 12:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fadc95ccfcso18355091fa.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 03:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727865390; x=1728470190; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLi+jGuLpSKAFJFGn29Pyc/jX/0LUwQftGJ2/qtEFA8=;
 b=Zmlihokj6wczEoUAt+84A2fKFIrvIzzt8+ljP9qBcOSk0xPe0Q4vaja6psGdA4ezEC
 B+xye4EHcDL91NSghbG+AebzT+UxZfE+99cetRG1TQqJe0mcxhxfu+IfYSvUQ111ylxm
 7K5TLFYBt9s/X091Qs7TmRa26vNDU5EPeS5//3pWJaaXvGMTy4iVtxKlEXJzoakhhRV4
 H3R8m4yV04U65NyFWTsUxZaeh6/mBFLae0kvE7loOAm94d/P6fz7Qj2PVye8UDkxZONV
 vOay3srvFNyA7K+/0L5oJY51tfUfZocEMPFjoS9HPpK467j7mmeNbKxrGlfG4O1mDRF/
 Jvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865390; x=1728470190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLi+jGuLpSKAFJFGn29Pyc/jX/0LUwQftGJ2/qtEFA8=;
 b=pCHWWKjzdoQ50jFnHSHlPcAK11PBFhEUrPX8Tl+iNqQ5xR1jf/4UC2aFthsr6iawwS
 Pr47cYknU2hUVBS9vyfoJ4rp5NgFInHXD4Gt2SRr51IhgrQqLDJNuOECClL34qRH8lwr
 ouqRg12PWugZosQ6V06gTx6Vi3nAy8CzMJRXt2ll4c6Vh1GNQZ12Bb45sb6DNThikhkI
 xY2SoGR6Ju+HrM/XK9jbnqrWQs2jLLpKDDv90kMGsaYhlaKxIvSfaZhD+ArJTSExqmAv
 hpTJISuSZRWftk6qXVrduvIqV9ma2qXsP2oCVe2eXYSqdlrU8Sp+/fy9z76zHU7Rj9DS
 /x/w==
X-Gm-Message-State: AOJu0Ywy6XTAJEsHksf2TWLtGnBNuJWeK9YdbQNVU3k1bAN1Idk6hCOS
 T3F6XbpTZZ4hzZs1aL4gvTpYQIG1ef0atABB+7bi4RF9h5u3qtb6Rqvvg5SscNrHnMq/tS6r1FE
 CqSPzfsdBfz8AMwkZ3o6UgYB70To=
X-Google-Smtp-Source: AGHT+IEopmSk/CXRzcOnkL0K/BKCQj85BjZd2KYyvL9lnZt+uGWLh0QPb2zwTNcMi52kxomjn2oWq6g4T4oFj9H29+0=
X-Received: by 2002:a05:651c:210f:b0:2f5:806:5cee with SMTP id
 38308e7fff4ca-2fae1015664mr18313361fa.11.1727865390159; Wed, 02 Oct 2024
 03:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20241001160324.3894617-1-paulliu@debian.org>
 <20241001160324.3894617-2-paulliu@debian.org>
In-Reply-To: <20241001160324.3894617-2-paulliu@debian.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 2 Oct 2024 07:36:18 -0300
Message-ID: <CAOMZO5DgL_UjFxGiqU=iDENRR53mr91mbGzyTzXjvsG2+jD7Fg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch: arm: dts: imx8mm-cl-iot-gate.dts: add
 no-mmc-hs400 to mmc2
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

Hi Paul,

On Tue, Oct 1, 2024 at 1:03=E2=80=AFPM Ying-Chun Liu (PaulLiu)
<paulliu@debian.org> wrote:

> diff --git a/arch/arm/dts/imx8mm-cl-iot-gate.dts b/arch/arm/dts/imx8mm-cl=
-iot-gate.dts
> index 425701204a..aa6ca070bf 100644
> --- a/arch/arm/dts/imx8mm-cl-iot-gate.dts
> +++ b/arch/arm/dts/imx8mm-cl-iot-gate.dts
> @@ -350,6 +350,7 @@
>         pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
>         bus-width =3D <8>;
>         non-removable;
> +       no-mmc-hs400;

Looking at the usdhc2 node it passes:

no-1-8-v;
mmc-ddr-1_8v;

Would that work for usdhc3 as well?

I don't have access to the schematics to confirm.

Also, this board dts has been upstreamed in kernel 6.11
(arch/arm64/boot/dts/freescale/imx8mm-iot-gateway.dts).

Please consider moving to OF_UPSTREAM at some point.

Thanks
