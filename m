Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAD3C282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C1481A19;
	Tue,  4 Mar 2025 14:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ArZHV+a3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C9181BF4; Tue,  4 Mar 2025 14:14:03 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0693081A04
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e4cbade42aso8492905a12.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741094040; x=1741698840; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aTWfFPYxnOPNjTWbPlxa+TqjIt+RjN5dCdzMm9lFIU=;
 b=ArZHV+a34UQgbsnnh9uJnzxUe4stsJw9QCAYykVeUlkgCwUn637zD38paNT5AlczTI
 Uo3Hgu/+5nDec9yFVLNmFKWqwHJ7wGeMn5kLXuoHdtDv3KNwvw72ORaASpgiJPfOwkG3
 hqB4ux+cY4xtWCtU08995uNCBlEy2Yxf/uALo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741094040; x=1741698840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aTWfFPYxnOPNjTWbPlxa+TqjIt+RjN5dCdzMm9lFIU=;
 b=bp0/DNB7qjC5+/ul6VZHjUW3ATZBYzyOK6t1KdRoZ0tS0sNaTVAnAxIXRhVZDD8gxN
 Aj1PikgomAXUHCFHre/NdoVnhtYkc+2IPmVgcrr4FlegdwlEPBky556g5h0EJvMiMWuz
 LUDNHeYp9tHtbkHqv3DmJSpD47tGVtjYLxwzszL4ykQUvklUpPQDknegDSZAAcQ7jctA
 USjTstE7lqbu83B+/YIzjB7jN1FrtZgUpBGFePKuDSSx8au35+59MLbfY2KK6SbVXx24
 mbpzr5KIwIImtUcVBp1uWzrR5TZGRFrpmwho66Ti4QzHSvEIzxy2nTH/XTK8cUYlMtuk
 Eeog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsnV4vGlt9aPfZB5oACrnKXuzkppH/Hnu4BmQQnWhQxbM+KhQR3rXfo/K3jAic/wKRF2TpFXE=@lists.denx.de
X-Gm-Message-State: AOJu0YxRLmudOeNtr7LLyS5g/+/x5NV1OxqxG301U/zUTQODnDhUHiW7
 +Pf57wQJRtilIMwO5E880M7YqFcdTKyJIyQrlL3qsYOanLg/XHsXFiDC50yzvi9pZNWzCXyvnAr
 oCWJoIO3YZxtKnjmAQfe0YJIBUdMPFTl8ki6i
X-Gm-Gg: ASbGnctbrde0nUlkKwDo3sfE0IMdlGHepJrF02v5PAwdJod6VVJupwva5LffSAxK/29
 yRPKDuqukWaskAG9pZD/PyOUjajIGRqJXMK9O4bEGNNM//o/kLHJOjnokelhwFjLH1F0T8Gog8D
 2pNjJBPNHHvEgG9Ms5lcQJl/m01PQ=
X-Google-Smtp-Source: AGHT+IETjN1YfQ2avJyILeAOF79PLWRhJl11LTQ/bsw2Dvwz4CpP5sO+ExbJt8UiR2GDnXwdM4IIIzsxulR8OKAhecI=
X-Received: by 2002:a17:907:6d22:b0:ab7:b82:899 with SMTP id
 a640c23a62f3a-ac1f123f6c2mr250110766b.22.1741094040375; Tue, 04 Mar 2025
 05:14:00 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <20250129-ge-mainline-display-support-v4-5-a43b3657ed7c@bootlin.com>
 <CAOMZO5BwB75QnfYKkcnq_kS_7N8yXzLNdpyzcWQ2Jy3zu9V1NQ@mail.gmail.com>
 <87y0xma4ib.fsf@bootlin.com>
In-Reply-To: <87y0xma4ib.fsf@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 06:13:46 -0700
X-Gm-Features: AQ5f1JrToVvtM0UYgp6fmLJi3N0WpUujxT1ZkZl-wn0beWfERS-Jn2MZQQOloRs
Message-ID: <CAFLszThZzGu6p1XnKuBUQTvDi+Q=ySzXirtiUJug9dGGZHrQhg@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] power-domain: Add refcounting
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Miquel,

On Mon, 3 Mar 2025 at 01:43, Miquel Raynal <miquel.raynal@bootlin.com> wrot=
e:
>
> Hello Simon,
>
> On 08/02/2025 at 08:09:30 -03, Fabio Estevam <festevam@gmail.com> wrote:
>
> > Hi Simon,
> >
> > On Wed, Jan 29, 2025 at 7:22=E2=80=AFAM Miquel Raynal <miquel.raynal@bo=
otlin.com> wrote:
> >>
> >> It is very surprising that such an uclass, specifically designed to
> >> handle resources that may be shared by different devices, is not keepi=
ng
> >> the count of the number of times a power domain has been
> >> enabled/disabled to avoid shutting it down unexpectedly or disabling i=
t
> >> several times.
> >>
> >> Doing this causes troubles on eg. i.MX8MP because disabling power
> >> domains can be done in recursive loops were the same power domain
> >> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
> >> timings to respect and it is easy to produce a race condition that put=
s
> >> the power domains in an unstable state, leading to ADB400 errors and
> >> later crashes in Linux.
> >>
> >> CI tests using power domains are slightly updated to make sure the cou=
nt
> >> of on/off calls is even and the results match what we *now* expect.
> >>
> >> As we do not want to break existing users while stile getting
> >> interesting error codes, the implementation is split between:
> >> - a low-level helper reporting error codes if the requested transition
> >>   could not be operated,
> >> - a higher-level helper ignoring the "non error" codes, like EALREADY =
and
> >>   EBUSY.
> >>
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Are you happy with this version?
>
> Would you have any feedback on this? I believe we agreed on the
> implementation but it's been a month and I didn't heard back from you
> since then, and I believe Fabio was waiting for your feedback.
>
> Thanks a lot,
> Miqu=C3=A8l

Yes it looks fine to me, thanks.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
