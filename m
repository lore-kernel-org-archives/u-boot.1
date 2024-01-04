Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9F6C3DA6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 01:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95134876FF;
	Thu,  4 Jan 2024 02:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FBGGoF57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4605F876F6; Thu,  4 Jan 2024 02:39:12 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CEB4876FF
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 02:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-781be0ccd30so5190885a.1
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 17:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704332347; x=1704937147; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TirDZzuHGTg7iZGekRNRFQWN4e7kRgCXELkHEIHshA4=;
 b=FBGGoF57eUyAiEZyhpxBc4PfecveNmLZRmCKQW+uYyRyed8KYFzEb0jsV5zPjFkmQo
 eukAPO7Ze1BkG5Je9nnpCIcZdZ4ddu5ffrLT9tc2MWPhEmdNpfT3orPV8KP4/51U9Qhg
 wRs8k9k626nQZQxYolKEtlDU2Uflktjrv7NRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704332347; x=1704937147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TirDZzuHGTg7iZGekRNRFQWN4e7kRgCXELkHEIHshA4=;
 b=YWTCnX1QT05CijI0FexidLmHp7lwCdFrvMaNSu9vWHa5aYd5lp5GQNKmIob2UTzkhs
 mYuRWY5+Ud0QdJ5TPDz1JuZyZ2OzwVRsLr6DNWbYIxrzW7rYgpfmXZzYuYFtesuf1d8n
 A66gUazYNtYjU5X9GQRq5Dd0Q1XpWNd6WAquC75QkPHG3tvTYWVtPSgywqMOguA04CWc
 jji58dTz0VKqpv1HFMBrbJ6HynvL9MQ6uxWji0iBgSX2AWYn2DXLAgz/xZIhheZf7cYl
 ZhY/0wPTUU3kX1ga2aqvu1ZqoJssT3ejsQCNjRakFEHFsdlgBMq7sB6uOyNZKHEMoX+T
 uFJQ==
X-Gm-Message-State: AOJu0Yx8OmHgqlhsRmuHVa4jaUbXL/qUG+IBdBFhyETX39z6VAoBI9Vh
 mtqsA+z0cnTZVnLmgQ3ROUsfndLqzL0/dmg3yxg8qybq6aR6
X-Google-Smtp-Source: AGHT+IGHyQctNYjI7XjgpB39GhmGRqup1RIrA0pkhvE8DMBpjv6zcn2wPdKuLrDLvPBpnB9KBwdcDsK/ySPzjye3bos=
X-Received: by 2002:a05:6214:410e:b0:680:b22c:c102 with SMTP id
 kc14-20020a056214410e00b00680b22cc102mr7117750qvb.78.1704332347232; Wed, 03
 Jan 2024 17:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20231228180154.50473-1-clamor95@gmail.com>
 <20231228180154.50473-5-clamor95@gmail.com>
 <CAFLszThd95iSPMOBr_21_Zckg74BtgA23EVpfXQKqnArFc-UDQ@mail.gmail.com>
 <CAPVz0n3OwhrW41tV9x32UXyL6yZdLr8CU9S7XuTneDiwUQY7AQ@mail.gmail.com>
 <8734vg5afv.fsf@baylibre.com>
 <CAFLszTjmvpbxGguK+FuXZLO=kpYR4pVr4E27BGn1u0B-6uB2eQ@mail.gmail.com>
 <87le964mii.fsf@baylibre.com>
In-Reply-To: <87le964mii.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jan 2024 18:38:56 -0700
Message-ID: <CAFLszTjA0_Cteg-L7VGQHysHBq5QH5YVgiVs3h2ODF532VpqoA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] common: console: record console from the beginning
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, Ion Agorria <ion@agorria.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, 
 Heiko Schocher <hs@denx.de>, Dmitrii Merkurev <dimorinny@google.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, u-boot@lists.denx.de
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

Hi Mattijs,

On Wed, Jan 3, 2024 at 5:41=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Simon,
>
> On Tue, Jan 02, 2024 at 07:06, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Mattijs,
> >
> > On Tue, Jan 2, 2024 at 2:52=E2=80=AFAM Mattijs Korpershoek
> > <mkorpershoek@baylibre.com> wrote:
> >>
> >> Hi Simon, Svyatoslav,
> >>
> >> On Thu, Dec 28, 2023 at 21:52, Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
> >>
> >> > =D1=87=D1=82, 28 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=
=BE 21:48 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >> >>
> >> >> On Thu, Dec 28, 2023 at 6:02=E2=80=AFPM Svyatoslav Ryhel <clamor95@=
gmail.com> wrote:
> >> >> >
> >> >> > From: Ion Agorria <ion@agorria.com>
> >> >> >
> >> >> > Set flag to enable console record on console_record_init
> >> >> > and not only on console_record_reset_enable. This fixes
> >> >> > missing start of U-Boot log for fastboot oem console
> >> >> > command.
> >> >> >
> >> >> > Signed-off-by: Ion Agorria <ion@agorria.com>
> >> >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> >> > Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> >> > ---
> >> >> >  common/console.c | 3 +++
> >> >> >  1 file changed, 3 insertions(+)
> >> >>
> >> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> >>
> >> >> OK, I can see the use of this...but I wonder if we can now get rid =
of
> >> >> the same line of code from console_record_reset_enable() ?
> >> >>
> >> >
> >> > Interesting question but let's leave it to a dedicated patch :)
> >>
> >> I've looked a little more into to this, and I'm not so sure we can get
> >> rid of the gd->flags |=3D GD_FLG_RECORD; in console_record_reset_enabl=
e().
> >>
> >> Removing the flag seems to break quite some tests in
> >> test/py/tests/test_ut.py.
> >>
> >> The breakage can be explained that various unit tests clear the
> >> GD_FLG_RECORD with:
> >>
> >>         gd->flags &=3D ~GD_FLG_RECORD;
> >>
> >> Therefore, I would suggest we keep the flag in
> >> console_record_reset_enable().
> >
> > From my look all of those are not needed in tests, i.e. are bugs. If
> > you are able to do a patch to remove those lines, it would avoid the
> > confusion.
>
> With gd->flags |=3D GD_FLG_RECORD removed from
> console_record_reset_enable(),
>
> When I run:
> $ ./test/py/test.py --bd sandbox --build -k ut
>
> It produces this list of the the tests that fail:
> https://paste.debian.net/1302906/
>
> I can also reproduce individually with a bootflow test, for example:
> $ ./test/py/test.py --bd sandbox --build -k ut_bootstd_bootflow_cmd_boot
>
> Produces:
> https://paste.debian.net/1302907/
>
> I did not investigate more on detail but it seems not trivial to me.

Did you add UT_TESTF_CONSOLE_REC to each test as well?


>
> I can continue the investigation in the coming weeks but I would like
> to apply this series this week.
>
> >
> > Also, by setting UT_TESTF_CONSOLE_REC for a test, console recording is
> > set up automatically, so the console_record_reset_enable() is not
> > needed at the start of the test.
>
> I was not aware of that, thank you.
>
> >
> > Regards,
> > Simon
