Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB412C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F9587861;
	Fri, 22 Dec 2023 13:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="vvoYRKQP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A468387868; Fri, 22 Dec 2023 13:05:53 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81A7387858
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-20403a18a51so1015587fac.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 04:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703246750; x=1703851550;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLiqvnLrKlOANE7f0eFliK8JUtHjed31p/45EBPmMrs=;
 b=vvoYRKQPnCaB5ewgMmgisj6lssBjgMbqbV09lil06qD5ys8MQ03P65QyS3il+ywYKK
 tNTb3TtPyuvSBVOVYawsHQD/mvuWma0tusc7op9JhQur52R5+dzsgBOE/HgJKkptPV+v
 joK0QTDMvR3Yfx3qxaAH4GyUVyA9xDNyG4GVfOqPEVhk8i00rXmGdTXKgZfKj05VGonp
 g97h4L6XUllPIbH5u1ievU00WTNtAtM/HP3UveK3tM/eM5uv1haMfss8ZlnkDe0bAJ0x
 IyWdfm6BVIwY1EwJQMRSIjILzCyyHQbxKgDfrDJi83J+w0dRnaMvr7VF83o++hJYGXgF
 v5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703246750; x=1703851550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLiqvnLrKlOANE7f0eFliK8JUtHjed31p/45EBPmMrs=;
 b=pVzj+V4xQHytiHbLqHeFPiemcPrwqg7gXH5v99ec6w4QieVlX7FjetcfIxie1l9890
 DV1YpZqzPOU9z5u6bJP7AUTUMYxdoEpKQ3QiBCULP9TKLkRpFVmC7z4uQLn40+WN1AOv
 E/37ljkOzTymCFx/F7af0KOAGz1ieTjwmshh5EmweiJvnlxnFoKemFVJ0apCdDRu9aUe
 PFdsePaLfYdpcFmImjn1IHZ8ymijpivw64PdJYe1QrYjtjsXGuzX5g969pFcKBR6+2W1
 F0dYdKRpRF7PpgEq3g46z7oBpPVX2k9eHww6/HrLz6/A9XTXInZg2Dodk5J9o5KOPSrV
 Cy7g==
X-Gm-Message-State: AOJu0Yy8deg7/v3jupZEZ1ZBYCGIXW6QIushcD2r26uYiBiVunLxSmYG
 LJzxO9Yxd1iM4VAX5qhSE2xuwSpqmT4hh3iCFyXmnEOahr8ZrA==
X-Google-Smtp-Source: AGHT+IHItB5v4RtkWIIDCRKcaNRKjplhWcb0UvSSX1sIA9cx3THcQ1IbbSehiJMrBpb0SbP2DDYgg015vtcW5ngnoQ0=
X-Received: by 2002:a05:6870:f69d:b0:203:bcd8:c5c2 with SMTP id
 el29-20020a056870f69d00b00203bcd8c5c2mr1305144oab.78.1703246750184; Fri, 22
 Dec 2023 04:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
 <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
 <CABEcMwUDnAQG3h-jrPEim2u_19UMtqhjcG5cSiE-QpjawHACCQ@mail.gmail.com>
 <20231209205627.GI2513409@bill-the-cat>
 <CABEcMwXYCczbTRVgqGC=USRJw138tDM0RkbmGoR4zSY7pBj1PA@mail.gmail.com>
 <CAPnjgZ3gEoOFxahZ2mg=MTQTmBPyCBphS8uVcpSSwq2bg4eJwQ@mail.gmail.com>
 <20231211181918.GS2513409@bill-the-cat>
 <CAPnjgZ3+yJCNgO635gSsDbrb-BpQvJTOqo4qHoWxunvbHZ8jyQ@mail.gmail.com>
 <20231211182710.GT2513409@bill-the-cat>
In-Reply-To: <20231211182710.GT2513409@bill-the-cat>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 22 Dec 2023 12:05:39 +0000
Message-ID: <CABEcMwUuoHp2JWDkPacadL1X3-x9wVKH-OZuYx6Cvx_kWCCNUw@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
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

Hi all,

On Mon, Dec 11, 2023 at 6:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Dec 11, 2023 at 11:22:45AM -0700, Simon Glass wrote:
> > Hi Tom,
> [snip]
> > > I think in hind-sight too much stuff is omitted without BOOTSTD_FULL.
> > > The option itself then enables other stuff too by default, but some
> > > parts of the bootflow command itself should be visible even without F=
ULL
> > > to make things easier on the user.
> >
> > At the time the goal was to avoid growth compared to the distro
> > scripts. We could perhaps add some more things in with BOOTSTD_FULL
> > but still have it as an option?
>
> Right. But now that we've tried this, some of the feedback has been that
> it's just too minimal right now. Like looking at the help message for
> bootflow, list and info should probably always be available. And maybe
> the flags for "scan" should be re-thought? Too late to change things now
> but "bootflow scan -b" should maybe how it's always been for "scan and
> boot".

What would be the preferred approach for this patch?
Is it to update the default capabilities of bootflow or we can have this pa=
tch?

Thanks
Shantur

>
> --
> Tom
