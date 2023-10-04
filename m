Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC415E8FDC3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06C3886E88;
	Wed,  4 Oct 2023 04:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PIcJanH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE3DB87192; Wed,  4 Oct 2023 04:11:18 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D39E686E88
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso290399466b.2
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385475; x=1696990275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tFPpZPQujTuwYdlneZRE0G0XqhL3huhQ3rfr+YL28cg=;
 b=PIcJanH+6v12Wcwlmr9Ffor5Ybi/U8xTf4Shu3tEPQxlhNDc2C/HcRhdR6sIw2PIPU
 d2TObgnJ7eQgi7lCbAt3LwAdLi+oQ11ODPQEwLk0VRmkpmrQKAgL1E7WAz1u48AFMly1
 ERgyFU1k2xTYa2pCGecOO+SE6oZpc0dskgqY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385475; x=1696990275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFPpZPQujTuwYdlneZRE0G0XqhL3huhQ3rfr+YL28cg=;
 b=Lw89lRc6BabI9Qi4odU0yV9CFI5/wksCYiBxc9wwV2QJr4FPvYxZfpqC+y9/3BArOR
 lJ6UBYZGxuFJ/detnmZkpdJqQhbuOfc9mtIU/EpyU75V6ujYfcSoPQczR2NR810RsJF2
 Ew595e7F6wcts0iV4dixYH3lpoFSCFnI3hsB9IMDxsQ0ixllwJzM5JKy31uJSsppCRq6
 KduIYD795T0tcRsy2NqqE1QGL1INUrHjhlOmT4w4BYCPy9seh5hHxHqG0oHuLu2zH7i9
 2FbDPoA74KWn/zyw7FaHHX0Jr6KZQ0p7aLQmAeBGvEwFhMbhujl5KKz/0rkN5HtRpvhN
 65LA==
X-Gm-Message-State: AOJu0Yzof2C/5+a7EwMteDw1msaGsz71Qjkr2mQa/l27y6LhOFlfFHTS
 8JivUF4NSoLI7eK2ZjZj1U3hAoDB0DpTmSPbu56K5w==
X-Google-Smtp-Source: AGHT+IGRmFa5pYHQRrhD3ZDHaIkNkzzHfDcxPGurmUk9ADOqla3oj9HkkRYmo+hWOfaaVKhJqx0qbdIIIfjYVNxbW8A=
X-Received: by 2002:a17:906:32c7:b0:9a9:ef41:e5c7 with SMTP id
 k7-20020a17090632c700b009a9ef41e5c7mr794106ejk.8.1696385474783; Tue, 03 Oct
 2023 19:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-binman-firewalling-v2-0-b1a084ec634d@ti.com>
 <20230926-binman-firewalling-v2-2-b1a084ec634d@ti.com>
 <CAPnjgZ14Uy+gBC8kgqVA7m9NXN_WiXFffu5Ob=vz=E76rMDMPQ@mail.gmail.com>
 <20231003112107.qxyzl2uyle2lhspz@ula0497581>
In-Reply-To: <20231003112107.qxyzl2uyle2lhspz@ula0497581>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:11:00 -0600
Message-ID: <CAPnjgZ0SfYaf8a47QpMego7bt16Pd66tOaYhALU3o_6xyUUVbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/8] binman: ti-secure: Add support for firewalling
 entities
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Tue, 3 Oct 2023 at 05:21, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Simon,
>
> On 19:17-20231001, Simon Glass wrote:
> > Hi Manorit,
> >
> > On Tue, 26 Sept 2023 at 01:58, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > >
> > > We can now firewall entities while loading them through our secure
> > > entity TIFS, the required information should be present in the
> > > certificate that is being parsed by TIFS.
> > >
> > > The following commit adds the support to enable the certificates to be
> > > generated if the firewall configurations are present in the binman dtsi
> > > nodes.
> > >
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > ---
> > >  tools/binman/btool/openssl.py   | 16 +++++++-
> > >  tools/binman/etype/ti_secure.py | 85 +++++++++++++++++++++++++++++++++++++++++
> > >  tools/binman/etype/x509_cert.py |  3 +-
> > >  3 files changed, 101 insertions(+), 3 deletions(-)
> > >
> >
> > Please do check that you have 100% test coverage here (binman test -T)
> >
>
> Name                                                    Stmts   Miss  Cover
> ---------------------------------------------------------------------------
> [snip]
> tools/binman/btool/openssl.py                              42      0   100%
> tools/binman/etype/ti_secure.py                            57      0   100%
> tools/binman/etype/x509_cert.py                            70      0   100%
> [snip]
> ---------------------------------------------------------------------------
> TOTAL                                                    5588    134    98%
>
> I did check that, did you notice something else that I might've missed?
> I just checked for the files that I have changed, I am not sure if there
> are any dependencies that I also have to keep in mind. Do let me know if
> I missed something.

Yes it seems to be a problem with a Xilinx tool. I sent an email about
it, so don't worry about this.

Regards,
iSimon
