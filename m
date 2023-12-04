Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDA7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 20:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB02871B1;
	Mon,  4 Dec 2023 21:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sY9rsXD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4A31877D6; Mon,  4 Dec 2023 21:21:44 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9446E871B1
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 21:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6cde104293fso3823405b3a.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 12:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701721300; x=1702326100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mjWg7Mxh3mJ2ZqoILJ3RGoUxts7+om1s4a8ko+fI6go=;
 b=sY9rsXD54IYV7vovi5T3IQvK5QqNSkWGxaM7YAaOpGORvnyBmvpIf91pOY7MDHuyc0
 Wxa6hsZiSeTmp8BehhFft78p7GKBNgJ8SfTV55ERSvXs5pV8qMd5Lk1JCSLk1QlsVZ+e
 /xSaFejM1VoNhUGDNri8D9sVV2RJhQCcoyTlwOHQ8nF8XuIKKu56W3xSLUriL1/Z/Xgz
 CZB8RvNIrM3NqZpH6nKClctYafImDHiLFsNuV7A8ztCs8vKFlUhRfy4D4GmhT7s5QRUS
 E7MEe2RC9klP+O6QYZtSbuWlJvTKPqC6txAsTnIg7BWKXe0LAElYbbe95BnRmkPlnZdr
 B0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701721300; x=1702326100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mjWg7Mxh3mJ2ZqoILJ3RGoUxts7+om1s4a8ko+fI6go=;
 b=j14c+IdrVOUgKa2DcOEU25p9FDVpJyTxgWDZKRj0pddjRiD6CTB/fdqIxsjpqcAlph
 /hlLi2mA4mPWsgTGTCZAqEAZwYdTEgfuuGJqGWponp9nEFiOHu9PZtNYv4jXYzdcW+g0
 KrXuY0rsU799b0Wcxk054RzFecBOJ/gajUQ7w1j4VVJ9dssESg3QQXsenYP/b3t/RrRS
 5PFAwbSxNZkAUOidAVQCZLI97fgcBtgjq+CmwfA+Nlbvmqf2X6z7BeHPrCSAfibT0PAF
 jG7s3hMiWSzTWz2+CsPqaff0fWno0lxpeR+UryvzFbtcxLTLIdQq20yAbk2TeCj9rVd6
 dFeA==
X-Gm-Message-State: AOJu0YzPQEzDpXiICGMpi5On/2a02e3ndDARdlWICFLfF2XGshxg1uVe
 lAYxckvowdmo22UVNZjoxd3VQCUgxeb0b1+qH1axyw==
X-Google-Smtp-Source: AGHT+IGraxFEqGBhsBJxc7AA2VjB5RyeuFFgJykHaJrlxZkxKZfexRy8e1ORldtKF+OBvmqojqaawsauZDVYmzTmcRU=
X-Received: by 2002:aa7:9a8a:0:b0:6cd:d4b1:cd09 with SMTP id
 x10-20020aa79a8a000000b006cdd4b1cd09mr140225pfi.5.1701721299851; Mon, 04 Dec
 2023 12:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-19-raymond.mao@linaro.org>
 <CAPnjgZ0yJNrpSV7dxmJky_QynEmPQQv5mTXT9MRTdn8rhVxpEg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0yJNrpSV7dxmJky_QynEmPQQv5mTXT9MRTdn8rhVxpEg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 4 Dec 2023 15:21:29 -0500
Message-ID: <CAEfUkULhw2SBEgWmijHtorKvQRmhV0q2Mf4MBd+vLyzJnW0fmw@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] bloblist: Load the bloblist from the previous
 loader
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Sat, 2 Dec 2023 at 13:32, Simon Glass <sjg@chromium.org> wrote:

> Hi Raymond,
>
> On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > During bloblist initialization, when CONFIG_OF_BOARD is defined,
> > invoke the platform custom function to load the bloblist via boot
> > arguments from the previous loader.
> > If the bloblist exists, copy it into the fixed bloblist memory region.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> >
> >  common/bloblist.c  | 29 +++++++++++++----------------
> >  include/bloblist.h | 14 ++++++++++++++
> >  2 files changed, 27 insertions(+), 16 deletions(-)
> >
>
> This should already work so I am hoping that this patch is not
> needed...these changes seem to break sandbox_spl
>
By "already work", do you mean any existing patches already done for
loading the
bloblist from the boot args?

Thanks and regards,
Raymond
