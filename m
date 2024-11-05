Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA5FD2B921
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 13:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9150488FCC;
	Tue,  5 Nov 2024 14:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UJfcYt1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F23088FD0; Tue,  5 Nov 2024 14:03:59 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD2A8852D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 14:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso948647766b.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 05:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730811836; x=1731416636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tG+S5uxLvA38dm8zOd7rNm3bd9itnFV6oU7WVwadrOw=;
 b=UJfcYt1ZYZcfPRG2lc7Dx0ctQ1wBgzwbtglfxUY1qlzzMHDKbPUCAXAqmIDcB7Reqj
 TpqdskepD/h4HlbRirrTdHKsOHuGK8GL0yXwaFad8evH6e4RYKANU9OMn4MeFNSe2DxV
 nZEkF8NTa46RaDYHX/vDj09NncmQ+sAx1xSes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730811836; x=1731416636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tG+S5uxLvA38dm8zOd7rNm3bd9itnFV6oU7WVwadrOw=;
 b=rb9iyiJJuazx2ppinNB+N6rT1b1y5rT+ua4RUYSk5dXZ+O86HZzSZ4OVa3m4Wa0PEf
 FiGqOgUKoSp0DJ3dYAq0BeCTr4yQmcm4bTdi9g1BuadDb6eDBbUhXLhHrSmHNgrs6uub
 pITmSKfKfV3lTGsU8wZUNyM1Z80XUOBh5yx1I0SK+QgN3aFmAxyyXfAkNddAHtNSWIXG
 XYQfrQj4KTqsLnTc2cp05SwH8NEFIth9ypFpwiNMhz1fyhB98fjphOzGeS8mbtj+LZG3
 Zd5/hbOkDv9DnpKXCtyAGbNyKu/1lp7/7V9OSlsrE2VHKB8EyYgMiDIOVid379Bfy0BI
 ka1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFy/HHtjw6ShS6hknb9Xc0aFD6h1VpFZjiOyF4fwFcJwgBvuNMxp9TAO7+EMp6J9+KPH7az8Q=@lists.denx.de
X-Gm-Message-State: AOJu0YwrMDsZn3lp67nW7Bl9PqO40HDm1Hp036YWf1eVoEVrzspF8cus
 mn93mI4M7uEYy3+qiwIcmaVArFHEo7/6TADSMl16gU37FpHwj78lhsKkkZ02bQQ6J25fQ+pCGaC
 tyWPpH+N1nGDAGOgsys2gUM+dleRpa2D2NjBb
X-Google-Smtp-Source: AGHT+IEpyjLa6btW1guAf3aPAEUx1LayqdNuWHrQSPi/BDynIK908O+E1N24LWGT49xCgPul+OZqQsf6zorARXi8nJY=
X-Received: by 2002:a17:906:6a1d:b0:a9a:11cf:2a73 with SMTP id
 a640c23a62f3a-a9de633b135mr3411391866b.64.1730811836198; Tue, 05 Nov 2024
 05:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
In-Reply-To: <20241104233227.GA3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 06:03:44 -0700
Message-ID: <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

Hi Tom,

On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
>
> > Legacy TCP stack is bad. Here are some of the known issues:
> >  * tcp packet from other connection can break a current one
> >  * tcp send sequence always starts from zero
> >  * bad tcp options processing
> >  * strange assumptions on packet size for selective acknowledge
> >  * tcp interface assumes one of the two scenarios:
> >      - data downloading from remote host to a board
> >      - request-response exchange with a small packets
> >    so it's not possible to upload large amount of data from the
> >    board to remote host.
> >  * wget test generate bad tcp stream, test should fail but it passes instead
> >
> > This series of patches fixes all of the above issues.
>
> I know Peter asked on the last one, but I want to ask as well. With lwIP
> merged, why do we want to add features to the old stack? I can see
> fixing issues, but not adding new functionality as well. Thanks.
>

Let's apply this. It has tests and the old stack is still used by a
lot of boards. At present lwip is only used on one. There is more work
to do on the new stack, including finishing off the sandbox
implementation.

Regards,
Simon
