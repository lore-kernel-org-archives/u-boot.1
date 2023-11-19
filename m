Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418F2C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 23:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F7786FE5;
	Mon, 20 Nov 2023 00:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="x8XXJvs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CFBE86EEC; Mon, 20 Nov 2023 00:17:34 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182D18752B
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 00:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507f1c29f25so4984699e87.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700435843; x=1701040643;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYWCkZlXJ4B0t6rFXA39fRpajwrYFlXimEjkUmpXzFQ=;
 b=x8XXJvs0oYEcAhaCsb0MbyjewaLL1c0IO2IvgMaaOFhlb5IW58WTxpeBJoNewuZ6+d
 mAxShWZNO4lkeDIjN5TbAtH6o9D6liaTfAvUudfLKH0+/miWtk1bW/Na4r40R4Tj/hSS
 JhdRv/nM7hNrbvAllVqjqLXWAXoLgl2vqDPd/Mqh/Zlnluo8cuY/Lu1JFQMhcOxhUZNq
 lkFiSeKnuzkr2v862TweZ4XL0uoqUfmYZfmI/Qi5IBqnn3c3cIyg+JsJrMMiya768J3z
 J9Ys3zB4RTKLgINndQpnk3gJMRYBamJ0KQ7HIe/BkDOUjHxkDi0ACX2A+BVBbu5Ad+TE
 juOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700435843; x=1701040643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYWCkZlXJ4B0t6rFXA39fRpajwrYFlXimEjkUmpXzFQ=;
 b=onb0kplJUvDZoHyLs2zpwlE1PcO/Dfl0Y9VKwiBsqfBLZBz8RTlkaQkOSfYn6aDDXl
 vLtouceHm0Uh0aLrouiRILysX2eXZ4C/5RpP029ayGkfXa14UXYuIbcpgvrwmBsCoeau
 nC66iVYjstlpjTm9iuZNNKW3shJz56EK5FPoZ/snXu60Dlo1gplQ/UiHng/n8rkN//55
 o/iT2SzOlpBRqPr6yPYM94rPv9qdd+/msYSGIa/Zau1e4+KMXAYMO7a/hFFj/La5cV9w
 F4u6lcWDmdDwUTG+tdFxDjMJ0+RyxksA2zUIlByw+VtsWUOvLDTDBnwTFWNp7vVBnXRH
 wyOg==
X-Gm-Message-State: AOJu0YxfWDEuKG5zs4oKbqmgmMbdxact4MqARdSdY8CkT3HsVGapgd3Q
 lFMgFCLrIhRbiOpDGC9m7tVcwyHGe6YceCZf2SuRp1OP
X-Google-Smtp-Source: AGHT+IGhqAOw0rFMC3s09CnjoZCbPPYfipOQF06FqhXDTRo/24Ie495MC9ltDcaOZp1i/pEpwA0UrQ==
X-Received: by 2002:ac2:43b2:0:b0:509:1790:e1d5 with SMTP id
 t18-20020ac243b2000000b005091790e1d5mr4084054lfl.28.1700435843550; 
 Sun, 19 Nov 2023 15:17:23 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com.
 [209.85.167.43]) by smtp.gmail.com with ESMTPSA id
 m8-20020a05651202e800b005031641b40asm983943lfq.159.2023.11.19.15.17.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 15:17:23 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so711594e87.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:17:22 -0800 (PST)
X-Received: by 2002:ac2:491d:0:b0:509:4a02:1205 with SMTP id
 n29-20020ac2491d000000b005094a021205mr3925668lfi.46.1700435842580; Sun, 19
 Nov 2023 15:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
 <fe844c63-0c44-469c-a4e0-f0e1f2ac63fc@denx.de>
In-Reply-To: <fe844c63-0c44-469c-a4e0-f0e1f2ac63fc@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 19 Nov 2023 23:17:11 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2WFZH65MJENGvC6u21ETcRn47ceQd8jrHV9DVmmM10Vw@mail.gmail.com>
Message-ID: <CAHc5_t2WFZH65MJENGvC6u21ETcRn47ceQd8jrHV9DVmmM10Vw@mail.gmail.com>
Subject: Re: [PATCH 0/8] USB fixes: xHCI error handling
To: Marek Vasut <marex@denx.de>
Cc: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 asahi@lists.linux.dev
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

On Sun, Nov 19, 2023 at 8:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 10/27/23 01:16, Hector Martin wrote:
> > This series is the first of a few bundles of USB fixes we have been
> > carrying downstream on the Asahi U-Boot branch for a few months.
> >
> > Most importantly, this related set of patches makes xHCI error/stall
> > recovery more robust (or work at all in some cases). There are also a
> > couple patches fixing other xHCI bugs and adding better debug logs.
> >
> > I believe this should fix this Fedora bug too:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2244305
>
> Was there ever a V2 of these patches I might've missed ?

Is it this one?
https://patchwork.ozlabs.org/project/uboot/list/?series=3D379807
