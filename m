Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F1DC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 16:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41B6B88BBF;
	Fri, 16 Aug 2024 18:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LiJRC68Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA1588B94; Fri, 16 Aug 2024 18:52:00 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA945886FD
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 18:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-369f68f63b1so1276732f8f.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723827097; x=1724431897; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QosVX3ZaliYlrAmWLrgi/iA5pSeFsz+RBs1Rrghn+c=;
 b=LiJRC68ZoXBpdhXm9EYELdQz09Msek8ESSwWLo9A9tl1NNXwYYGcDvXivdJbctLoWo
 8uxm0cYVaZbBLWiOWAqiNIzQ9cuDZc+iNpIXi6cL6kicOhzelupL8SFaignaqtWoU9rf
 CXi5WhRl+7Gh8L82LA8qyN56GmEm2OZgiNbU7zCfubzfuFnm4lQY7t7ZxC1qwE0pDVB3
 CslTkeF7VEia/slfk9+el31lAMlxcN6XzRSOr3lbb4VwLj4U0/nDnbzcLPaSne8mag01
 sPmmsKRu38kV9XmDKsPwac/3R1lImNYMlQ2uxFoyFoK3N0IgqqCKkQvUSYy5iR+841oI
 Gpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723827097; x=1724431897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0QosVX3ZaliYlrAmWLrgi/iA5pSeFsz+RBs1Rrghn+c=;
 b=sdjYv8FDNZWnf5aRbQMoC2Qhjtqi3aVaPNh7I1k+Pn2BA1S8thid4o+H9VHiUM531C
 BTv7exGLNLP+Un/AwhWj6R7JppgzxzhQjAtmWPgNOGoARgzSzxu8Jv0nX0Hl5Y8CsLoG
 WaoWw3NmpW2Zuvqn2XrwrvQhLspCwtWAeR+GupjHbjntgIKux1H892YLZPFLPfUtvyre
 xCXdqbJxGe/SoESdNC4boGFPFLDyH9uNnutM0opbvwSuxj0f2Z9JhIObpYZ1dk/Pm1ci
 do1gtPGDxWadEL624ne28OV4NfRd/VQBpcpWeu5efsUSPb3ofsK9qGZEUZ4cuiIc9svj
 iY2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHKlE/w5Yy/iTo8iOABXhsjj3C/QHK10brkGukfNtnS+sovayFidyZpYJfaXXHeVtGoYQGwZHnQ0TovGsV6atOtMJAFQ==
X-Gm-Message-State: AOJu0YwAbb/1TlgLCt+nStPHeC4hWQKD6gR7xP278NOBbYGjC0gJp5ff
 mNNCT50978lkNk7vVFanO5ftu2suABUV7zJsbntouX0geKNGeM4XzMcaJuV9Tg6DToh9Fcu1ERo
 rX5P9vRufkOe3WSPC+EcYA4uVD9o=
X-Google-Smtp-Source: AGHT+IHsT/PYWohu4NcOIOCJgjGmDLsRh8fGOQ8S9sSOBlLbTt+msZkuaam3OJlhUD0C2CA6NznMgf6kGGqbEFbNnR8=
X-Received: by 2002:a5d:564a:0:b0:371:8a49:f206 with SMTP id
 ffacd0b85a97d-37194659a23mr2520585f8f.30.1723827096972; Fri, 16 Aug 2024
 09:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240807121434.11761-1-clamor95@gmail.com>
 <20240807121434.11761-2-clamor95@gmail.com>
 <CAFLszTiK=i+_TDQuW3dSgEyZgbhqvzsKD+28WO_+9SQUUoBH4g@mail.gmail.com>
In-Reply-To: <CAFLszTiK=i+_TDQuW3dSgEyZgbhqvzsKD+28WO_+9SQUUoBH4g@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 16 Aug 2024 19:51:25 +0300
Message-ID: <CAPVz0n0_vv4-AXnYrvJy0w1HXBXrT_isNgp2-mehDda4XvzefA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] board: tegra: convert boards to text env
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Thierry Reding <treding@nvidia.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
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

=D1=81=D1=80, 7 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 17:36=
 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 7 Aug 2024 at 06:14, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> >
> > Convert boards to use text based env. This is the first stage of
> > conversion, common inclusions should be converted next.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  board/asus/grouper/grouper.env                | 15 +++
> >  .../asus/transformer-t20/transformer-t20.env  | 17 ++++
> >  .../transformer-t30/configs/tf600t.config     |  1 +
> >  board/asus/transformer-t30/tf600t.env         | 16 ++++
> >  .../asus/transformer-t30/transformer-t30.env  | 17 ++++
> >  board/htc/endeavoru/endeavoru.env             | 13 +++
> >  .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
> >  board/lg/x3-t30/configs/p880.config           |  1 +
> >  board/lg/x3-t30/configs/p895.config           |  1 +
> >  board/lg/x3-t30/p880.env                      | 15 +++
> >  board/lg/x3-t30/p895.env                      | 13 +++
> >  board/microsoft/surface-rt/surface-rt.env     | 14 +++
> >  board/nvidia/cardhu/cardhu.env                |  2 +
> >  board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
> >  board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
> >  board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
> >  board/toradex/apalis_t30/apalis_t30.env       |  9 ++
> >  board/toradex/colibri_t20/colibri_t20.env     |  3 +
> >  board/toradex/colibri_t30/colibri_t30.env     |  9 ++
> >  board/wexler/qc750/qc750.env                  | 15 +++
> >  configs/apalis-tk1_defconfig                  |  3 +-
> >  configs/apalis_t30_defconfig                  |  1 +
> >  configs/cardhu_defconfig                      |  1 +
> >  configs/colibri_t20_defconfig                 |  1 +
> >  configs/colibri_t30_defconfig                 |  1 +
> >  configs/endeavoru_defconfig                   |  1 +
> >  configs/grouper_common_defconfig              |  1 +
> >  configs/ideapad-yoga-11_defconfig             |  1 +
> >  configs/p2771-0000-000_defconfig              |  1 +
> >  configs/p3450-0000_defconfig                  |  1 +
> >  configs/qc750_defconfig                       |  1 +
> >  configs/surface-rt_defconfig                  |  1 +
> >  configs/transformer_t20_defconfig             |  1 +
> >  configs/transformer_t30_defconfig             |  1 +
> >  include/configs/apalis-tk1.h                  | 58 ------------
> >  include/configs/apalis_t30.h                  | 12 ---
> >  include/configs/cardhu.h                      |  4 -
> >  include/configs/colibri_t20.h                 | 11 ---
> >  include/configs/colibri_t30.h                 | 12 ---
> >  include/configs/endeavoru.h                   | 43 ---------
> >  include/configs/grouper.h                     | 45 ---------
> >  include/configs/ideapad-yoga-11.h             | 58 ------------
> >  include/configs/p2771-0000.h                  | 20 ----
> >  include/configs/p3450-0000.h                  | 13 ---
> >  include/configs/qc750.h                       | 42 ---------
> >  include/configs/surface-rt.h                  | 18 ----
> >  include/configs/transformer-common.h          | 91 -------------------
> >  include/configs/transformer-t20.h             |  4 +-
> >  include/configs/transformer-t30.h             |  6 +-
> >  include/configs/x3-t30.h                      | 44 ---------
> >  include/env/nvidia/prod_upd.env               | 60 ++++++++++++
> >  51 files changed, 332 insertions(+), 476 deletions(-)
> >  create mode 100644 board/asus/grouper/grouper.env
> >  create mode 100644 board/asus/transformer-t20/transformer-t20.env
> >  create mode 100644 board/asus/transformer-t30/tf600t.env
> >  create mode 100644 board/asus/transformer-t30/transformer-t30.env
> >  create mode 100644 board/htc/endeavoru/endeavoru.env
> >  create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
> >  create mode 100644 board/lg/x3-t30/p880.env
> >  create mode 100644 board/lg/x3-t30/p895.env
> >  create mode 100644 board/microsoft/surface-rt/surface-rt.env
> >  create mode 100644 board/nvidia/cardhu/cardhu.env
> >  create mode 100644 board/nvidia/p2771-0000/p2771-0000.env
> >  create mode 100644 board/nvidia/p3450-0000/p3450-0000.env
> >  create mode 100644 board/toradex/apalis-tk1/apalis_tk1.env
> >  create mode 100644 board/toradex/apalis_t30/apalis_t30.env
> >  create mode 100644 board/toradex/colibri_t20/colibri_t20.env
> >  create mode 100644 board/toradex/colibri_t30/colibri_t30.env
> >  create mode 100644 board/wexler/qc750/qc750.env
> >  delete mode 100644 include/configs/transformer-common.h
> >  create mode 100644 include/env/nvidia/prod_upd.env
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Francesco, have you checked this commit on apalis-tk1?
