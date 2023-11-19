Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF73C54FB9
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 16:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF4186EE0;
	Sun, 19 Nov 2023 17:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="AyX9Qnrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D41786EE0; Sun, 19 Nov 2023 17:59:36 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC4586E95
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 17:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50970c2115eso5228473e87.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700413160; x=1701017960;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXmcZulEeQks2cPTAWKQM6v+HWvfFgf+VIKnf5tbczQ=;
 b=AyX9QnrnOIsNhix+ccLt9oE7k88inrIMM2Q5M2sJTadgEsr0zdAE/55jaZwt5GfRst
 gQqlb6HeB/lPt8NemREb/+2SxxHN+fnAm+fcv5RfEkDurraE0/pm/O4LW65++XGi3xz1
 obY9hRCS1y0iakjgepviLd0OXinhOCvxxpcvFDO7cieogjtIDWud8VQ4+2VNMhlPsCRi
 eApp2M5zomlvMMuf6cy9InuN3H33F86YeGT94ssDhqoiqIAIq4XSVyKORj9WjGP1Fkjy
 L1c82LBc4fpJ1d5NSFvvJ/OFYraXsKgbQ9qxpPOk29rkYP1TRxkJQxfM74c7KSPwROaD
 DeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700413160; x=1701017960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXmcZulEeQks2cPTAWKQM6v+HWvfFgf+VIKnf5tbczQ=;
 b=jleb72nL+qjlFJ9Q8IQ85pNHXwEEKRnb3cxQeAC8hbUDOK1ntPAYVJFnKb+wYCv0Fu
 6EK6yNzfFC1/fTbvGpCNUZvQD3yIR69ZXN8Qx92jhTkTeLAp10n+cUQlKHbaOCsC8gcP
 2Ivb5vNpWlOvyfdCtiEOzjvD0uwWJsW7OEooDk/XWJplxAATwvMuDiHcfwDLvQH5ge3Y
 j+vgEFF5uFffFxLck8AH42/O03Xem2m/PAAl85zxL/Dzj47XnAq5egJj2xycGd4LPW29
 RtG0cUskJPy6LhPYVTn8BEwkA4iepAmcj+jT6GyIAMHulkKl6HcvbXTCHWrvcNr8iPFi
 zhCg==
X-Gm-Message-State: AOJu0YxizoR6f/b8gelsbcwGrGBVWGwVpDwEQR+9roIw1kDBKycbSX1s
 a6Lfeoz7aK5kbe/aggiP0ij5qWGelTyxa8Ys0BGSzA==
X-Google-Smtp-Source: AGHT+IF/ilCAxxRlpPr+YCXSpK3YW/zL8GoqAf7U4rFfq5JfleshHFFyPq+QmET9qrqCzdUWhNDqvw==
X-Received: by 2002:a19:ae17:0:b0:500:a378:db71 with SMTP id
 f23-20020a19ae17000000b00500a378db71mr3575018lfc.57.1700413160122; 
 Sun, 19 Nov 2023 08:59:20 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com.
 [209.85.208.49]) by smtp.gmail.com with ESMTPSA id
 kg27-20020a17090776fb00b009fc95fc3dabsm906373ejc.130.2023.11.19.08.59.19
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 08:59:19 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5482df11e73so3329086a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 08:59:19 -0800 (PST)
X-Received: by 2002:aa7:c490:0:b0:540:2b93:af85 with SMTP id
 m16-20020aa7c490000000b005402b93af85mr3543064edq.26.1700413159262; Sun, 19
 Nov 2023 08:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-3-i@shantur.com>
 <CAPnjgZ19Q4RZMR080gqqzginpCNkCkj4OuVgJX6drRt+dJbLNQ@mail.gmail.com>
 <CAC_iWjJapxvTqB1R-9CDMYDeyFDikJiZ=3JXCNArdLQr=FtMTA@mail.gmail.com>
In-Reply-To: <CAC_iWjJapxvTqB1R-9CDMYDeyFDikJiZ=3JXCNArdLQr=FtMTA@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 19 Nov 2023 16:59:07 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1USO=68iAYj17jseNLgc9R=azy4tprLSppyXxYjkTn6A@mail.gmail.com>
Message-ID: <CAHc5_t1USO=68iAYj17jseNLgc9R=azy4tprLSppyXxYjkTn6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bootflow: bootmeth_efi: Don't set bootdev again
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, trini@konsulko.com, 
 xypron.glpk@gmx.de
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

Hi Ilias,

On Sun, Nov 19, 2023 at 7:50=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> Thanks for looping me in
>
> On Sat, 18 Nov 2023 at 19:11, Simon Glass <sjg@chromium.org> wrote:
> >
> > +Ilias too as this involves a design decision
> >
> > Hi Shantur,
> >
> > On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
> > >
> > > efi_set_bootdev is already called as part of tftp while doing dhcp_ru=
n()
> >
> > Is that in tftp_complete() ?
> >
> > > Doing this again crashes U-boot and we don't need to call again.
>
> Yes, we should fine the root cause here instead of papering over the prob=
lem

The root cause has been identified and fixed here -
https://patchwork.ozlabs.org/project/uboot/patch/20231119165501.1305136-3-i=
@shantur.com/

Kind regards,
Shantur
