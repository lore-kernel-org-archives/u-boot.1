Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0724C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237EA8883F;
	Mon, 29 Jul 2024 17:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="daq6Pvue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3ED188850; Mon, 29 Jul 2024 17:28:16 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0690F88860
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7af49e815so21742026d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266892; x=1722871692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R2DWNapPFHqXVlDg4GeW/zJjGfHyTnFsozz90oHXY2A=;
 b=daq6PvueDAbVLl1++bMkMtaLT4HYmII+LC5y5HKehXFgOLytERBWISRzhi0LfrxtSD
 Gabwtd/pd+F8qhFMI+HhYrNWLsUynESCTsRXQrMqLbCqTdmFNcZyUAiadujfdltKHiEZ
 VGQzDBMoe/3pvrseKHdkGGyJomLX+ZlElYW6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266892; x=1722871692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2DWNapPFHqXVlDg4GeW/zJjGfHyTnFsozz90oHXY2A=;
 b=OdXFcTCXEJZTE+K17j59DyT+W6BHBIHKXeFXdvPGubJWD6sk44meBoI8j76n+QH1T1
 XbO9nKhTn+kFku/VV0WPkCgtPhLHqdZg35B89XW0TjtbAL1jp/Gh365WW25mKWfCFYuw
 75V6zh8S1N/d8sPlp42CpbC2RWzWaY/fnrLMVKxm8mAK/H7uR2MGBhsGyjSgtPxJGI0P
 xu/6q6l41PTIMBgXn7lP5CksYr9wdVy+83cS1sT6Ah3rbLvicT+CUw1m/yvoCg8LLBzT
 yBEFvCJ92yGNEj1dxyqrLrJ2VzchvX5NgHxzpxqIoRRFwGuSG3CO0vgltGtQ29sxYnDD
 zIgQ==
X-Gm-Message-State: AOJu0YzuwgFniVdKh6N5ZtvrS7hF2NXk79/2GpQCmq1iVGgQHDdmB+iW
 T+QGp12WUzG993d0mpjKKFsImeNZXXgb5Cq5Y6mjEMfjFLEimL0rI7zbOO+qK3xERlPG+dKzVKx
 tXdxwDXG4yFF+z5eibJST5kUxQhPAJb/YvONz
X-Google-Smtp-Source: AGHT+IGVelVd8QIw1o/YkWbWFUpVE3SJXkQ3UULnaBLj+zLh5NKvNEVqp4yKHaeeek12nEj27y4yFRMBdmn6+S8YHto=
X-Received: by 2002:a05:6214:212c:b0:6b5:e6b3:72f9 with SMTP id
 6a1803df08f44-6bb559f8e05mr132404806d6.9.1722266891961; Mon, 29 Jul 2024
 08:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-34-sughosh.ganu@linaro.org>
 <CAFLszTg1nywmyXRJ2Dgsg97Mfbps7P37jDD72dNafo0wHF3RZQ@mail.gmail.com>
 <CADg8p97S84J7wrEchCfP-Y7L8qdC4F=koyuhzV0+jYxiM=YhRg@mail.gmail.com>
In-Reply-To: <CADg8p97S84J7wrEchCfP-Y7L8qdC4F=koyuhzV0+jYxiM=YhRg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:01 -0600
Message-ID: <CAFLszThRiRLXE2Nz7CM4_tDCM6=6d1v4snsDfYBCnvPnoXVPYg@mail.gmail.com>
Subject: Re: [PATCH 33/40] test: cedit: use allocated address for reading file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 02:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > Instead of a randomly selected address, use an LMB allocated one for
> > > reading the file into memory. With the LMB map now being persistent
> > > and global, the address used for reading the file might be already
> > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > address from LMB and then read the file to that address.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: None
> > >
> > >  test/boot/cedit.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> >
> > No, we should not start putting lmb into tests like this.
>
> The test fails if the address is not allocated through an lmb api.
> Although I can check why.

Neither am I, but you did put the tcg in the same region so perhaps
that is an issue?

Sandbox is designed so that low memory regions can be used in tests. I
pointed you to the memory-map docs.

Regards,
SImon
