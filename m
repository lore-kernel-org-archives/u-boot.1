Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE6EC02183
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12805801CF;
	Mon, 13 Jan 2025 20:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0V/cPVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC8B80619; Mon, 13 Jan 2025 20:02:01 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693F980027
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso24499566b.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736794918; x=1737399718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=momjkciuTOCeVyHQrdrUdy9N8OyEOSInt1c6xBAxDao=;
 b=V0V/cPVgsa2E/zHUwiODe5CKGF/6mhbPv2sGzDrQKBw9GO0+oVXOcvgG9Vd4GvH/7e
 5ZCKwdsm9ldMMwdFnKZhPvo29sXgL4l4w51dbpoDfV+B208juHtP2zlLeL+RuL7XY8wP
 ytfz7NU4gstsICwhXiuJ/qz+KyWnA+4uVqCGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736794918; x=1737399718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=momjkciuTOCeVyHQrdrUdy9N8OyEOSInt1c6xBAxDao=;
 b=b3RIEyNqjT3xYBJsLZ+nf0+xUuJE81n7c4yjcIT9UkPERX2nNXGkd8guBlFrrLk+ON
 eoUNqSJnObQPnHlv3DfUN2xkTumadZxMI2EsJ8iGVYqPUi3ZHlyb+Qtab9EQG/Da8EHW
 nmzenYB9bs46zDokG938yK3jigYj5U0R0ZszT19cK57ie/KRdOEbYAI/neHNqz+q/Yth
 bKxxdnQN1XByrU4wwNTZaMyi3ikNRVDReqT+PYa0L6Altv97e02O/JLRamH8J0v1OGIu
 dv64lHcaZwP3PJfWcfaW43JBe3xPuyHihmiIxS81NDSQy36PkXHmFJPRZuh1FIuBVrbW
 RvzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd9npU/ThE8km3DG+bmY8mt5G46k2llpKXycggczrmCf82v5kZdVtkTG2SjGJBOEFeJIOHNeI=@lists.denx.de
X-Gm-Message-State: AOJu0YwAW6cWLlBzn9nrCTp/C6729MjbinLgniKaVsgEPUpzjC7hneRB
 OjOgHxdrJRCu1T1NC3wGaw5ujEXmV7ZuOJ1CmuyUP5NDNoze9EmzqDTJ/HR6/5n1JPoNRqNAG0l
 tqgP4ioBGwYdXi1EciTuwRiCr+VzKSR+CmC9V
X-Gm-Gg: ASbGncvQ8ZAAx9JgQmt6ZaCZ3ib2IioUHg+VuzDsZkyFopFJByemyD+1zS0q/lOovDM
 9bqSQ+x9PkVvzyq+F83L9pNjlvQosYZykQletDKA=
X-Google-Smtp-Source: AGHT+IGn5XxzozQluxnPfy3zSSVS9I79zP/BqhJExl6QcPDqM58vf5ICeQ6B1W6Kap4gVlK50KZKho2RAN8k0pP/SSI=
X-Received: by 2002:a17:907:9447:b0:aa5:b1bb:10db with SMTP id
 a640c23a62f3a-ab2c3c2833bmr1451546566b.1.1736794918612; Mon, 13 Jan 2025
 11:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20241127070631.16412-1-heinrich.schuchardt@canonical.com>
 <20241127070631.16412-6-heinrich.schuchardt@canonical.com>
 <20250110224554.GA2278614@bill-the-cat>
 <CAM=mAOmee=By9ErZrvk0hVbZyLH_viguu_wMfOsV3LzTwddArw@mail.gmail.com>
 <20250113015108.GT3476@bill-the-cat>
In-Reply-To: <20250113015108.GT3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 12:01:45 -0700
X-Gm-Features: AbW1kvYIJCRk1v33kXZ4ZPxLNfLerbDqqs_nTev7S1fhLZ2G41W1Gctb-nsraV8
Message-ID: <CAFLszTh7S=jmezZNwg=b+96+6ravY41iRbgJ_ssJ48nx4d=0QA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cmd: bootmenu: add parameter -e for UEFI boot
 options
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Sun, 12 Jan 2025 at 18:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Jan 12, 2025 at 08:08:13PM +0100, Heinrich Schuchardt wrote:
> > Tom Rini <trini@konsulko.com> schrieb am Fr., 10. Jan. 2025, 23:46:
> >
> > > On Wed, Nov 27, 2024 at 08:06:30AM +0100, Heinrich Schuchardt wrote:
> > >
> > > > The bootmenu command can display
> > > >
> > > > * menu entries defined by environment variables
> > > > * menu entries defined by UEFI boot options
> > > >
> > > > Not in all cases showing the UEFI boot options is desired.
> > > > Provide a new parameter '-e' to select the display of UEFI boot options.
> > > >
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > >
> > > Very strangely, this leads to the EFI selftest "Executing 'random number
> > > generator'" test failing on Pi 4, where was was passing previously (and
> > > Pi 4 has an RNG, unlike Pi 3), and this is
> >
> > Do you have a link to the log?
>
> Here's the failing part:
> Setting up 'random number generator'
> ESC[0;37;40mESC[1;32;40mSetting up 'random number generator' succeeded
> ESC[0;37;40mESC[1;34;40m
> Executing 'random number generator'
> ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest_rng.c(52):
> ERROR: ESC[0;37;40mESC[1;31;40mRandom number generator protocol not
> available
> ESC[0;37;40mESC[1;31;40mlib/efi_selftest/efi_selftest.c(114):
> ERROR: ESC[0;37;40mESC[1;31;40mExecuting 'random number generator'
> failed
> ESC[0;37;40mESC[1;34;40m

This might help make the log more intelligible.

https://patchwork.ozlabs.org/project/uboot/patch/20240811145209.4191404-37-sjg@chromium.org/

Regards,
Simon
