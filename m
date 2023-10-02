Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A390E74911
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C55871E2;
	Mon,  2 Oct 2023 20:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DhhHsmk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBC8869C8; Mon,  2 Oct 2023 20:56:59 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537038712A
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so8341966b.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273017; x=1696877817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PqWIFUy4jf9eH2MfofR3LTep4LORn00381GS9pUAGu8=;
 b=DhhHsmk3fXfFdkcLFgtifrEzR3Fl7qiw5LwWztBiwH+EQYbDgTesNAHsu2AlN4W1Bm
 GiqflW/LPgQWLgAxnPfTRY5mFIitiL04wm0uEYgBmL0apj+2ZUa7ZYL7JwmkAXIwyGpg
 /53GsA/2Y5s3Yk2PPFTvO2wQH/Ia/KsR/WHTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273017; x=1696877817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqWIFUy4jf9eH2MfofR3LTep4LORn00381GS9pUAGu8=;
 b=ifpvBxq7m0kqTBjsPCYgNlPCGaODnedBkXUPmWnfx0sIS2X8u4vajw4tNe9Z5z7EnG
 K0xm4+ch9HZYApUCUuN48sSUhl1i8Bbxzd/XxmbDGQLzuA67aKaEmrvY3qXVxGex4b7E
 3uDIsSNFGyOmQNPMDo67gfe91W4fClJyuEjV4AW/T+qzn0j30JtSm9TzW1vx8SWLcxRI
 In+Rk0+Nc/2vOproyT+d/cUREKgZlKu+8WABa3/oJm2karPR/rvckN6WrNm86y3ykhdS
 499hQPB9q4I6KTbxU7ms52m+J1H13fuuvQVjcomzwixJPNasHq5UMuviQN8+Hij2m2ET
 qM5Q==
X-Gm-Message-State: AOJu0YzqBrZxfzAUbVGHlXhg+tXmwQZtHmt8lob/m017Wq72lw3szFm3
 Rt1RgPAzZINWf3Fiul+nhwalqF/cG/zEZZ3cd3YhPdFQxpyOteM5GWA=
X-Google-Smtp-Source: AGHT+IGSHUIebmM2ybelhMwGdX//taKqXAQ3lYFNPZvw8jgUC/4JRBxl+Lbx0neMwnYUke7sCEL3MpmJd0hH4HTWB4M=
X-Received: by 2002:a17:907:7708:b0:9ad:fb49:4eda with SMTP id
 kw8-20020a170907770800b009adfb494edamr10043686ejc.3.1696273016747; Mon, 02
 Oct 2023 11:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230929160654.3475279-1-sean.anderson@seco.com>
 <ae1e25f4-0fe6-3476-406b-298d6a196f65@seco.com>
 <CAPnjgZ1NEGXOjQ9QmW7150d20Ur+V0NXs1VGtF756huwXNMayw@mail.gmail.com>
 <176a961f-8f1c-f926-eab2-5d0a8b2f86ec@seco.com>
In-Reply-To: <176a961f-8f1c-f926-eab2-5d0a8b2f86ec@seco.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:34 -0600
Message-ID: <CAPnjgZ2Bzo1+v+Kb7onxEd7_E=O_nnnU2F+h1X1KAazRUCRniA@mail.gmail.com>
Subject: Re: [PATCH] test: Fix SPL tests not being run
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
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

Hi Sean,

On Mon, 2 Oct 2023 at 08:38, Sean Anderson <sean.anderson@seco.com> wrote:
>
> On 10/1/23 15:36, Simon Glass wrote:
> > Hi Sean,
> >
> > On Fri, 29 Sept 2023 at 10:12, Sean Anderson <sean.anderson@seco.com> wrote:
> >>
> >> On 9/29/23 12:06, Sean Anderson wrote:
> >> > SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
> >> > tree. Don't skip them even if they don't use the devicetree.
> >> >
> >> > Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used")
> >> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> > ---
> >> >
> >> >  test/test-main.c | 3 ++-
> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/test/test-main.c b/test/test-main.c
> >> > index 778bf0a18a0..edb20bc4b9c 100644
> >> > --- a/test/test-main.c
> >> > +++ b/test/test-main.c
> >> > @@ -476,7 +476,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> >> >        *   (for sandbox we handle this by copying the tree, but not for other
> >> >        *    boards)
> >> >        */
> >> > -     if ((test->flags & UT_TESTF_SCAN_FDT) &&
> >> > +     if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
> >> > +          (test->flags & UT_TESTF_SCAN_FDT)) &&
> >> >           !(test->flags & UT_TESTF_LIVE_TREE) &&
> >> >           (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
> >> >            !(test->flags & UT_TESTF_OTHER_FDT)) &&
> >>
> >> Upon further review, do we even need 6ec5178c0ef in the first place?
> >> ut_test_run_on_flattree looks like it's trying to do the same thing.
> >
> > Well one problem is that many tests are not run at all unless OF_LIVE
> > is enabled. The code as is is assuming that OF_LIVE is active.
> >
> > On boards where OF_LIVE is not active, many tests won't run at all
> > unless they are marked with UT_TESTF_SCAN_FDT.
> >
> > So I think that UT_TESTF_SCAN_FDT line needs to be removed.
>
> OK, so to clarify, since 6ec5178c0ef added that UT_TESTF_SCAN_FDT, you would like to
> revert that commit?

Yes, I think that will work...but just check that tests without the
UT_TESTF_SCAN_FDT flag don't then run twice with sandbox. There was
perhaps something else wrong at the time.

Regards,
Simon
