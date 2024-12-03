Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD7AE6C5E3
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB99895EC;
	Tue,  3 Dec 2024 01:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PQBlZ5LJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38F8895A9; Tue,  3 Dec 2024 01:20:34 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74708895B9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa55da18f89so743967466b.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185232; x=1733790032; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBHeFqeuepA8wtOMgLftMdsPDKoA9F/+WYORnNMw6is=;
 b=PQBlZ5LJcPEnyNdHHfiaFEC2zDuj+aLUbcDpf5SUa0EJd/xskPolrheBYr8e+3Vmfd
 TMyC3O7OcclQ0JjvG9zaLYlTbAZs4LSsHCPQfQSTUIkFSxfn6PXrfexDNtp+pw4Q5cEB
 0Ep34Fkj8ZvElJlnZupxJv+wSwvm3F6lGxmo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185232; x=1733790032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBHeFqeuepA8wtOMgLftMdsPDKoA9F/+WYORnNMw6is=;
 b=M48bIZ3w8MYR3CoxL06Kw2CrwQrTYCyQaW4UNAYQRwYA9D93ib7cYNe2r6eQeRwnAm
 FRB9AQiuvx1sKBrQVHQQOMTbXbucqe3dLLC/bWJkgNMLSMcxjsp6aPD0LC/AHkPQOnq+
 ciOctT1NpUkpbaVaeCcS0g2uHGdkrb6BQ9+lAWq/J3u/EDQ2lRPmlJCed0CVdf+XG7yH
 1bYJVW3zu9Y7OCStCYXbN2qOxjA/U1g6UAWoikU25gAJ7KAMmMYXG246iePI9Q3yNB6X
 pOXlAuXAF6QoK+pMeTi3F/Xjngts5UK54Vvq2/fal/18dlF4KvxECLZ6Cls3ytT1JbEx
 ahfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0cpyc/63p1h12lzUwcsKM1TBoyr9tS626INW37MSm3+y400Kdrse01IQsD3VKIkcid1dQKYo=@lists.denx.de
X-Gm-Message-State: AOJu0YwMaDX18WO9Mf3yNXfxSqGz1gbsf2qu2Kn5ZE6iL6Dr7Y1gw6wi
 s2/n08TjMxbdPS+xwUM06dvbDFXfW8CVIj9eNrot3uswTrA/0QU3uWigMpEuIg3gcCL9RGc8oiS
 0Fw0H04hfImZKVLq3tJxtH3YzzyWHKs14SLFI
X-Gm-Gg: ASbGncuyM9wldRBRtb/T0XQVSdeESFpGDwTni+pfAiKk+GgpW40825uCYoyZdaLmdDK
 SotnZYXGeU7obbr4Zv298XDzvOGZ8Wtrt
X-Google-Smtp-Source: AGHT+IFoGA8tIYFTX4dHMAuZclsq/XBhqDoEAEmkqbtAwMXTx2BrE/XkivvZsr4D2MccCrysvBKEoN2pS9tYrWFCyUc=
X-Received: by 2002:a17:906:3d32:b0:aa4:9ab1:19d5 with SMTP id
 a640c23a62f3a-aa5f7eefba8mr14929566b.42.1733185231887; Mon, 02 Dec 2024
 16:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
 <20241128-bootconfig-v1-2-0e63a5dae82c@baylibre.com>
 <CAFLszTgFBtQBiC_Hd9gjUJa26aFFXLGuuvJ5gVDLEaKH-SV-dg@mail.gmail.com>
 <991937a4-9bcb-43f8-99d9-013d0c9d2dff@baylibre.com>
In-Reply-To: <991937a4-9bcb-43f8-99d9-013d0c9d2dff@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:20:20 -0700
Message-ID: <CAFLszTjY8YUhY5ZowWN0BgCK4tis8TJKJhX-n=d=MwFynq0E7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] boot: android: Add bootconfig support
To: Guillaume LA ROQUE <glaroque@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
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

Hi Guillaume,

On Mon, 2 Dec 2024 at 01:03, Guillaume LA ROQUE <glaroque@baylibre.com> wro=
te:
>
> Hi,
>
> Le 30/11/2024 =C3=A0 21:24, Simon Glass a =C3=A9crit :
> > Hi Guillaume,
> >
> > On Thu, 28 Nov 2024 at 03:15, Guillaume La Roque <glaroque@baylibre.com=
> wrote:
> >> For android vendor boot image version 4 bootconfig is mandatory.[1]
> >>
> >> In the android_image_get_ramdisk function, after copying both vendor a=
nd
> >> boot ramdisks, we extract all androidboot.* entries from the kernel
> >> command line. These entries are added to the bootconfig section.
> >> We then update the sizes of the ramdisk and bootconfig.
> >> Finally, all androidboot.* entries are removed from the kernel command
> >> line.
> >>
> >> [1] https://source.android.com/docs/core/architecture/partitions/vendo=
r-boot-partitions#vendor-boot-partition-v4
> >> Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> >> ---
> >>   boot/image-android.c | 29 +++++++++++++++++++++++++++++
> >>   1 file changed, 29 insertions(+)
> >>
> > I am not seeing any tests for this code. Can you please update the
> > test to cover this?
> i don't know if it's possible with test framework in uboot, to validate
> bootconfig raw partition is reading by android kernel. i don't really
> know how i can do this , if you can say me if it's something possible or
> not .

We don't have a way to boot a kernel (yet), but we do have tests that
check things are correct - e.g. bootflow_android() - and after a
'fake' boot - e.g. bootflow_scan_boot()

>
> for kernel command line part is it possible to read it in test to check
> if we find some androidboot.* entry ?

There is test/boot/bootm.c which checks the cmdline. A small amount of
refactoring was used to allow this.

My suggestion here is to write a sandbox test which 'fake'-boots the
Android kernel, similar to bootflow_android() but with a
'bootflow_boot()', then at the end of the test you can check various
things.

Regards,
Simon
