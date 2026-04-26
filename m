Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039D7FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 12:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA377840ED;
	Sun, 26 Apr 2026 14:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFjOW/D9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAECC8407E; Sun, 26 Apr 2026 08:14:46 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC7C80077
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-68244d317e5so5436702eaf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 23:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777184083; cv=none;
 d=google.com; s=arc-20240605;
 b=NvysPDF1pVTpZdiG1gCdvj8WGXMYE7Gd2Nao4aoTBmrzZnmESzcnAJBI35jQF5/X8t
 suU3eCyJ8fkuDf1LwLLFj7ZG8rssIMUOd/6K9vEjMMpPPnWoMmuBWj+y+27z8dzn8NIh
 oAXALTSGQRZpmugdj1VrF3a1zTEo9dPODHphUeC8GJBLcyRZGG28MIFzT+O85N8/z2Uo
 GKUm+jIu9FWBcBs1EVo4DtcTyiFXw30akfP/NWPTi9hHugSUGbVYxEhc0TwtilToXzYj
 bEe7QHSsLqUL0cDL1LhP2q7tWbg23Mpgi+mXWQO20bj69k9t4duByTnwSYHPGjfJ5xlX
 vCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fz4Tq9bhZEZfCTTEuVMVpdKRszuIHhQin+JItX/GhK0=;
 fh=f5PWalaLFelLRXTZ33NAGCWY/jwtjHa5uIBj0ILGaKI=;
 b=KmjuxaKJaHTC4wN3DcWN/wqQSz61vQvdf73Uofswtu2xL5Jde8AHxEt9KEuqK2f3Yi
 nKIORS8JTOqqfzZaszlzUkM+q1e13d+BoSboP3ZcsaHiHsxN4NUEECB6xHckFIdsZsHt
 yhvlMgZbJxIX/BH6u0k1/yrd7fdKZvnuex4JzUKDrK17hNasrZwIpPDWzd/EJ1uXH+hf
 9YHzeeBiagIcThFvZ6U7mWHhboac5CNJOjDqwllYKV0CRXt2GFxldZkqaVlW/fVgpFOw
 UPl+8ogLVhOynuVPjAMYA+wiuCL37lFm5OIGFMHmj1WKAyLbm+GzRPuNnfTq1GwG7hfE
 C0Qg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777184083; x=1777788883; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fz4Tq9bhZEZfCTTEuVMVpdKRszuIHhQin+JItX/GhK0=;
 b=XFjOW/D9W238HMGaba6uXx9J4ulKrERtfJUEcyUjGCrp6ChoGeFO1Fd/2vgX26Ab7i
 S+OPMIcf4qg265miajbP3gSMGYXdSpo4v14JpJgC1WN8MNrEs7FHLYGob4b+TP/mSRxe
 Y32IXP8W8Gu619Zjmm7xNbC+AA80Da2zIm74Xe4z7Ap8jOYzhT3+Iqmoo1KyJa8yvwYu
 xulWwjdd0tSSp0jILn+UZREkzjomWADYaFioqIFG/yiXuoYlLNIh5Vt4/DvArofnBKxW
 VoMt+FT6wvdrKQAwR2FtaMTpnyAYnSHSVZbcVxU3tIVoIDtzrBgaxbRnM/ziH3Tcc3Cn
 OGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777184083; x=1777788883;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fz4Tq9bhZEZfCTTEuVMVpdKRszuIHhQin+JItX/GhK0=;
 b=SDRD3GMEpe/uSXfkIrQAFDbypcYxj+TWOjPdUSZWIPqyx2b50v+1wtO97jg9aNplhx
 xjwd7w5eAg5p3niFgPOSjteIStTsQ9WwAhvpWvruT+wtmX328Ow/Jo8duOVh3JkaJXUe
 sC/DCq/U9nS4cudi0w4js+8ZHbA67oimAUHbxrYibXutJlkd1zZhzOWQYFnptjh3bQ4z
 4WPIqqw3PfFBb8NWWijXdZN5L2o9c47zovbtUuToKKY8wynZrPbrhyckedVNpwHjyv7U
 ffuA8pN4ECX5k637IoW5eVR19Vd9hD1Iq/nf38D6tpUt8zkzI4287BAMJTmTPaNBRfV9
 V35Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/qIm+Trr29aB0aQYG3E/lkWitegWkuCs6kJsb3E+M/KxWbn3HPG9cyaiNsh/C9YZN3GR9ru4=@lists.denx.de
X-Gm-Message-State: AOJu0YxoogQtsKQjl45RQSq6w/2IpAIc/CgWUNPu3q2rgDbMC9gL3j41
 q9jHKYCpaoxMoq7xmDAIRkrhy8zVxn4fgIM4SAOyiQfG8DFfYxy7/NNha0kyXt+AZsPTm4VTP3y
 gifHTGInkBDeTIJR4DBSnlkzwRRzs2v8=
X-Gm-Gg: AeBDietmipxOc04vHTTSzAwHrYtes62LM96N6hOD/b1QgIXfRIQyPQpQyNrxMDQHlJE
 +zM5CdesD8bU8aCfDG5iiQLaXSKcO9sfZboPKSigHBSKge0bCXoai3nO22lziWpcUiljABF8beo
 +k6dNZE/udfzYKRhhdwUO5V7sHRqiUKB6j2Sj+bJGEwBwIf7wkvrkE7nQdIw8WOn+OdRlhkQkyh
 vKBzc4IFmdPGmBcBd2lb4u0IMpVCGhI0l5bW1JAdXzoGN8axe9nz+SEUnwl/eUpZ+gxKGS1yghh
 lDOL/BsfxHBBSTkiiJw=
X-Received: by 2002:a05:6820:620:b0:694:a339:43af with SMTP id
 006d021491bc7-694a3394618mr11914826eaf.28.1777184082780; Sat, 25 Apr 2026
 23:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260424160316.157380-1-micbis.openwrt@gmail.com>
 <20260424160316.157380-2-micbis.openwrt@gmail.com>
 <12a998f2-5115-488a-92f0-44c94e89a645@mailbox.org>
In-Reply-To: <12a998f2-5115-488a-92f0-44c94e89a645@mailbox.org>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Sun, 26 Apr 2026 08:14:31 +0200
X-Gm-Features: AQROBzDS2ybtA4rGh094CbqdwWgNHfT2MixNug03PBp1dwtK8ujb6Cjue1BThzM
Message-ID: <CAP8xZ6mPr4WuYxThP5KDzmDXp+pNhF4Py-2ucuUNBptqVkyqWw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] usb: gadget: rcar: Fix gadget registration
 lifecycle in remove
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 26 Apr 2026 14:57:25 +0200
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

On Sat, 25 Apr 2026 at 06:00, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/24/26 6:03 PM, Michele Bisogno wrote:
> > The driver currently fails to unregister the USB gadget when the
> > device is removed or the driver is unbound. This leads to dangling
> > pointers in the UDC core and potential memory corruption.
> >
> > Add a call to usb_del_gadget_udc() in the remove path to ensure
> > a clean teardown of the gadget interface.
> >
> > Reviewed-by: Marek Vasut <marex@denx.de>
>
> Please do make sure you collect actual RB tags as they were provided,
> without any modifications.

Apologies, I am not even sure where I copied it from. :(
