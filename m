Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05276C7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 22:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB9682CEB;
	Fri, 20 Jun 2025 00:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H/dhj09Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A68A82CF8; Fri, 20 Jun 2025 00:04:40 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D174582D21
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 00:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e75668006b9so1281397276.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 15:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750370674; x=1750975474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0XPJD0sNo1KFeiOLdpWiyEimF6bWuBwgBhzJ+/PnS4=;
 b=H/dhj09ZJ2mMtbe1JGodD69dOxWx8OLInNqUkGcs5qjxW2W56fEYXER7BUXx0i+aKG
 7Ng2ZLTz960XTp+G+2JoDkeGjNvkWlpjDlHsO4mn6f+DApudlzNjI2MglzycOBbN8TFp
 73u4/nxVj83YTqTn7h46daULe0DVZMhUgKXd19vq5if5KWy447u4EOIdHKs7rQqFjfAN
 GgaFby1BApOvbq/t/2wzQP3CGsW4vwbGXtVJ8LD9mjKqPc3eLZpPaDovA7NvGFEmSwhq
 WqejKQ/TZtaWXWQN0gp6MtAmWsE/xyNx43ubwkxN5WrUmXS+SPT2z1Ht2dU8X2O02p8I
 Iqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750370674; x=1750975474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0XPJD0sNo1KFeiOLdpWiyEimF6bWuBwgBhzJ+/PnS4=;
 b=c3bJsSHeHHCVzJ7g3XRRPi1M7W5n5QW9eq5Y6Qmd/cHK9H7nFJUQUcYs5XEILUV2T5
 2SoWz3jCitucgrAyNVBLKBvy24JhxJfBuFqrZYnoDNmho8BhBWhJuiIj7xMd61OOSsJ8
 DDe+TIxg+qQ7HLSgLgwL0YUJMuZoX41B7cnGtrVXMIw19IXFMTFos+4oUaPcL2hrMdnC
 9o6en9Zvwuah/qJTEUzimMa9jSZnrEzvmL2/TX3jnIDaWNj0mqhmEq/fKiJoIoqTCyEU
 rRnLgMk2xx8/Hcahr+GWlP2sWlwUoLvFiz8hMihpHTsiIx6Q7VXcYdY3Qi1j649PL+3V
 lngw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlanMiFkvklB+Vld0oyziv94Z0exGBw+94WaMQInU63ZLUHoS15WfdbyCG7uzhxjog/cad7U4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/lXR1EygunU2DZ9w92OEwdoKjNBmkP93DCjeW92tOLW+PCsnK
 1rDvK+4uGiqwGdP3bDx/L3v0Zimo3pO14CLyAnltVqiJktMag4VP+zc9hSptZuptSkEv3rvXDry
 pAhLipIt52rntO/m50BtXoIGYcdcy6v35Ad/MgESE0w==
X-Gm-Gg: ASbGncvzD1vkqU+rYQFSygm3MwRylca2CB+q3DDG2j0sST1ynqvs5oC/wr1n7CguxoE
 akvh3nrqnwGuKJqrr1qc7k5GHe4VZf20ASUaGYQvvr9mnl1y9PxLFjIZkv1+KOHCtSe2QbYr3OW
 U+Iy41+qjje7mymoBvEQIQb4Y5NYRGUu01GF7k5ncDUAtb/fkowU/qQ8+EtIGhCxqp7WY2sbRym
 AF7Qg==
X-Google-Smtp-Source: AGHT+IFEjk/aiAWBd1K4ZnTHJ/St7Un1KLOVsci6+6w/GR+iKeMnX6AR+Gl45l28dCBpIR8M75tSX4K7YROzkhiAYKA=
X-Received: by 2002:a05:690c:708d:b0:70e:7882:ea97 with SMTP id
 00721157ae682-712c63afd4emr13061307b3.10.1750370674605; Thu, 19 Jun 2025
 15:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
 <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
 <CAPLW+4=38cBhUXyngbLG-iypxx+ksXp2-3Cjm3Wgd1V+pMmfCg@mail.gmail.com>
 <CAFLszTiZdbMu64_+=LV3gxUf_Jm9Ngxdmg=+XrVhGNHR9FDAnw@mail.gmail.com>
In-Reply-To: <CAFLszTiZdbMu64_+=LV3gxUf_Jm9Ngxdmg=+XrVhGNHR9FDAnw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 19 Jun 2025 17:04:23 -0500
X-Gm-Features: AX0GCFsF9iPKKO7h625SEIylHJfZjApYMsFIB66_gGjrlsx_LU8I8_U2EwRMnWg
Message-ID: <CAPLW+4nCr1j4MxR9mjAt3JtocwsxBKgWpah_ARODX+6ENs-xDg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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

On Fri, Feb 7, 2025 at 7:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Sam,
>
> On Fri, 7 Feb 2025 at 18:11, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:
> >
> > On Tue, Jan 14, 2025 at 7:14=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > On Sat, 11 Jan 2025 at 20:42, Sam Protsenko <semen.protsenko@linaro.o=
rg> wrote:
> > > >
> > > > Free memory allocated for 'order' (array of bootmeths) on error pat=
hs in
> > > > bootmeth_setup_iter_order() function.
> > > >
> > > > Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths =
separately")
> > > > Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
> > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > ---
> > > >  boot/bootmeth-uclass.c | 16 ++++++++++++----
> > > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > >
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > How about adding a test to check there is no leak? You can see
> > > test/lib/abuf.c for similar tests.
> >
> > That might be a good idea, and I already have the test code handy. But
> > frankly I wasn't able to successfully run the current bootstd test in
> > sandbox, it fails before it can get to memleak check I added. Firstly,
> > when I do:
> >
> >     $ make sandbox_defconfig
> >     $ make -j32
> >     $ ./u-boot -T -c "ut bootstd"
> >
> > it says:
> >
> >     MMC:   Can't map file 'mmc1.img': Invalid argument
> >
> > and I can see only empty (zero size) mmc1.img in my U-Boot source code
> > root dir. Then I was able to trigger its creation (I guess) by running
> > Python suite somehow, so it generated 20 MiB mmc1.img. But even with
> > that added, I hit this error:
> >
> >     test/boot/bootdev.c:218, bootdev_test_order():
> >         0 =3D=3D bootflow_scan_first(((void *)0), ((void *)0), &iter, 0=
, &bflow):
> >         Expected 0x0 (0), got 0xffffffed (-19)
> >
> > I've read corresponding doc [1] ("Tests" section), but still don't
> > understand how can I successfully run the bootstd test locally. If you
> > can help me out, I can send the memleak test you mentioned in v2.
>
> You can run the bootstd tests with something like:
>
> test/py/test.py -B sandbox --build-dir /tmp/b/sandbox -k bootstd
>
> although it sounds like you have already figured that out. After you
> do it once (to create the images) you can run the C tests directly as
> you did above, but yes, sadly, some of the tests are affected by
> others (with bootstd). You could take a look if you like.
>

Is it possible to just apply this patch without a test? It's clearly
fixing a memleak. Not that I'm lazy or anything, I came up with a test
like below, but I don't want to send something that is quite hard to
test. If you think this test is really essential, I can send it once
bootstd tests are fixed and can be run in one command without any
extra non-documented work.

8<---------------------------------------------------------------------->8
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index 9af947868707..f4746ee4fb61 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -194,6 +194,7 @@ static int bootdev_test_order(struct unit_test_state *u=
ts)
 {
        struct bootflow_iter iter;
        struct bootflow bflow;
+       ulong start;

        test_set_skip_delays(true);

@@ -201,6 +202,8 @@ static int bootdev_test_order(struct unit_test_state *u=
ts)
        bootstd_reset_usb();
        ut_assertok(run_command("usb start", 0));

+       start =3D ut_check_free();
+
        /*
         * First try the order set by the bootdev-order property
         * Like all sandbox unit tests this relies on the devicetree settin=
g up
@@ -277,6 +280,9 @@ static int bootdev_test_order(struct unit_test_state *u=
ts)
                        iter.dev_used[3]->name);
        bootflow_iter_uninit(&iter);

+       /* Check for memory leaks */
+       ut_assertok(ut_check_delta(start));
+
        return 0;
 }
 BOOTSTD_TEST(bootdev_test_order, UTF_DM | UTF_SCAN_FDT);
8<---------------------------------------------------------------------->8

> Regards,
> Simon
>
> >
> > Thanks!
> >
> > [1] doc/develop/bootstd/overview.rst
