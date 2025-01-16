Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6725C02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 22:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 328B780312;
	Thu, 16 Jan 2025 23:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZBwMH/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB258033D; Thu, 16 Jan 2025 23:57:54 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26EE48022B
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 23:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-30227c56b11so14965081fa.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737068271; x=1737673071; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yy25Xd5LeDrBrBLLPDXRf0R8e9CRNLMm86pv7O4nbvo=;
 b=OZBwMH/M4Mq783wMyW/JbEuwIVsUdECP7nBbWmDrKCpMwQn2tA5E8zCKw4f938Qb1D
 JY3o0n896pRVvWsLHCBHZkb8oY1OpvNTYMCjAeNrbwisXBNpLxDJbFd3A75WE256kMnG
 Z0rqw0M9TbON8B9wzM5T6cV/0HMiqcXRfmAUuofU8MnkokRDZpnOKXfr/iEgOaxf2c0X
 +OEjhUTqqM32mH0cltjTW2lseciYLWl3o04pcrjQ5J1r456gqmTPc5AHpX4l2Z5YqT8B
 fQeQcrnMCsQHQRSjBQ3MEmwvnEWeiMrXRIarmhmUdIdax/lqwrQpyBN0cFHj2EPVrf8w
 YOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068271; x=1737673071;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yy25Xd5LeDrBrBLLPDXRf0R8e9CRNLMm86pv7O4nbvo=;
 b=rknUIWTLjYm4w3UfTgb9Cp7i5/q3Czb/jm8+prYLkTLJJKD0aSdieMtBAgPChAgCOp
 CX6lGY5LzUDfFTRWZ/WNIrLNNxplBs2nS2mQsQTScZVyPZF7CWHeXeY8RQdRckhSkuI/
 7t8lhsWzPtisnhxBIPkbY5jn5Re3ylO/a1bgMm01smlmhFriJXWvS9YIm2itznok2AKq
 0OiyQQPG77kmSiw0X6/DQfmw9GVVr8zkBYKFHpEyuvLUEr2JwZTbxCq9np2VK1+rWTna
 mi+H9eoVPFGVTAJn1W9ZCjpfa0dpHg5D2IxcfLsuSDdOlm6kRu42U+F4Vq+QUvr8wDlt
 2tkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeKo/KPfanWhEWmHj4FiuUzU0sDi40uEzlN66sIuGX5RtDkiCm3LK8vcbOlr3Mwc4qi8IZ634=@lists.denx.de
X-Gm-Message-State: AOJu0YyBn2TlbYw0OotsFGmXD5DkZ9FVAr2DRp2FezC36oKgmttq45y2
 ZAfODRONDWw8rBVFh7cGG04bYFY779xFfPBC4ChHIXqtl9LTNOIAgnz+abaqV5I76J/dYiMEyEr
 4eIzZLwtblm8q5atb4Xe3DvqJA84=
X-Gm-Gg: ASbGnct8Q/Vj43DJlXVNJhD9qwBOvSoh9q2a2As4QCgO6lWGWILWQ3gnBiIBg+4MfOF
 ktN7/SVycWFGlGVbiQbZWYZZKg92WgieaFKbNsacX85GhFLiH57qE6V2GsTCVNQhNNdWaAQ==
X-Google-Smtp-Source: AGHT+IFyJ5Nw5Aoei58shGRIUTPnw5M0bNwRmNWew6xK9lGnWyxIXQhFVXxjV/8pgm5YEddGk6zbHDsRiV/FRuDyX4g=
X-Received: by 2002:a05:651c:b1f:b0:302:210d:3b44 with SMTP id
 38308e7fff4ca-3072cb343c4mr1478211fa.35.1737068271070; Thu, 16 Jan 2025
 14:57:51 -0800 (PST)
MIME-Version: 1.0
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
 <20250110-phytec_imx8m_optee-v3-1-6c39dab15592@phytec.de>
 <CAJ+vNU24PA3S3aEu5CjyECaF0aKKvbs7svHVuGUyHFA08NObOw@mail.gmail.com>
In-Reply-To: <CAJ+vNU24PA3S3aEu5CjyECaF0aKKvbs7svHVuGUyHFA08NObOw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Jan 2025 19:57:39 -0300
X-Gm-Features: AbW1kvZTw2clpDt8noBlTshu0DjsPHzhg3V1p5lDRTQtblvmabyz-Q1Qfuvxs5g
Message-ID: <CAOMZO5DPBJAXm99DTwBjfgOUpUqWzCiZH=vM-Mq_cDde3QzynQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] arm: imx8m: add OP-TEE node
To: Tim Harvey <tharvey@gateworks.com>
Cc: Yannic Moog <y.moog@phytec.de>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Manuel Traut <manut@mecka.net>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Thu, Jan 16, 2025 at 7:45=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Hi Yannic,
>
> As I mentioned before, I still don't see how this builds when tee.bin
> is missing because someone isn't using tee?
>
> It looks like Fabio has merged this already to imx/master which now
> fails to build for imx8m*_venice boards because of it.

make mrproper
make imx8mp_venice_defconfig
make

flash.bin is still generated despite this nasty warning:

  CFGS    spl/u-boot-spl.cfgout
  BINMAN  .binman_stamp
Image 'image' has faked external blobs and is non-functional: tee.bin

Image 'image' is missing optional external blobs but is still functional: t=
ee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portabl=
e
   Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/tee=
.bin

Some images are invalid
make: *** [Makefile:1135: .binman_stamp] Error 103

CI also did not complain.

Yes, I would welcome a patch that removes these tee messages by default.
