Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436B5C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E6EA87A7B;
	Thu, 28 Dec 2023 16:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fjevGq6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E91287A92; Thu, 28 Dec 2023 16:21:09 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B71E87A68
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cdf90e5cdeso811854a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703776865; x=1704381665; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qr7IXe2WxT+VMVv6KGW+ex43vAxcIX1rVSoKwtqPw90=;
 b=fjevGq6BBo7EzdBsbfY3Ooy669RQYtBaQ3yrA0PTiz2HqwxX+NUV8x93sqW7p57miS
 8NFfEcth1yGSQjz3MNfJWL7aWYZDRmgaH/B1oTA9TxpFFtrH6ZPbfEbvGjb0avPpMQXR
 xqGF557my3oA3YZE4UvUAqnCJgmxx50O3JaQqgcuEM8rSfPoc5rr755kqDISTwp7SdJn
 6jAL5NDAYeg8qfnQ4EjG8Gdc/mBPr3ycMC07SWPdaZBSvfXClRWQd+xSsomzKXtqKsjG
 fIRM9WTVG235CoXBJduoMOPG/bquPYcbsRGMVEjY3Iv6hHzkyVBYvKsWZ8rScz2Sng7R
 nGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703776865; x=1704381665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qr7IXe2WxT+VMVv6KGW+ex43vAxcIX1rVSoKwtqPw90=;
 b=jrgQOv4qNbph1k9aBVaQYsFpYzxNgnFT9/+skkleh7O1KSkZJc1JIun6IKmrc276+2
 PEfUtf4xtDwdei4BJr0f6cRlmL97ZIPizXhNjGVIxOpmzLkNnaAFipstL9ELxBBHFI0v
 GAkX9kaaRasT6GT74BUaxZFywBsaSDArjGGd9u/d6RqcFGEIc1JI7OunIla9vIhmdI5m
 g/NZ9XA52xeFN0bhYrrpRNbCCSnSEI3+X+qaXL2CEnD5BhnnJb9K3qJgvwf4+9cj+26H
 OMhwYTx1sm1rUymLejooJqMFjSGikkmm7TNiua8H83HWJe5MbUtyua7viqvThJejrCMW
 fYoA==
X-Gm-Message-State: AOJu0YzQ8DtMLFSBHBbDgtirOvh3ZmqVnfS3wbUyF/WdxdWuVxDP+wyB
 /uBar/g14J1aKGX25pEUf208FXtZkdeZu2tVhQzWXfgW
X-Google-Smtp-Source: AGHT+IEF89Vy4TYDgd26UIDGz8cPiBWDyRgGDgYhsUpfvrl2PCLN97Yadw3O3Blh86ZnSyDsCbn7uj4jz4Bywa07zsg=
X-Received: by 2002:a05:6a20:6a86:b0:196:106e:9822 with SMTP id
 bi6-20020a056a206a8600b00196106e9822mr5627679pzb.3.1703776865232; Thu, 28 Dec
 2023 07:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20231209114555.16951-1-m.othacehe@gmail.com>
 <CAOMZO5DEwTgffO6RZz8BaFq+bmxM170mz6wWN+MQ76ss7r8O2g@mail.gmail.com>
 <87h6k274ys.fsf@gmail.com>
In-Reply-To: <87h6k274ys.fsf@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Dec 2023 12:20:53 -0300
Message-ID: <CAOMZO5AZ-610XqiXUc71J+on8ajsN7K=H+aH-pH8_isbz13eGg@mail.gmail.com>
Subject: Re: [PATCH] Add imx93-var-som support
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Mathieu,

On Thu, Dec 28, 2023 at 11:54=E2=80=AFAM Mathieu Othacehe <m.othacehe@gmail=
.com> wrote:

> For now, I am testing the bootloaders I produce using those
> instructions:
> https://variwiki.com/index.php?title=3DYocto_Build_U-Boot&release=3Dmx93-=
yocto-mickledore-6.1.36_2.1.0-v1.1
>
> I understand that it would be nice to have u-boot do the image
> construction with the firmware, ATF and so on, like implemented on
> imx8.

Please give it a try to add binman support to build the U-Boot binary for i=
mx93.

I am adding Peng Fan here in case he could help.

Unfortunately, I don't have any imx93 board to help with this.
