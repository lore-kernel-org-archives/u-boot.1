Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F42E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B7D86E8A;
	Sun,  8 Oct 2023 01:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AWAr2B5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F070086DF5; Sun,  8 Oct 2023 01:12:19 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D77C86EA1
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59e88a28b98so29533087b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720299; x=1697325099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d/bsO+pUYYSO6ux3BB/KfKOadkY7zF+2aiYnO7+B5aY=;
 b=AWAr2B5DHiPhva/BtP3x14lbxOar/QjuK+nImWuoLXrnEZpu/E4CEdNW2bV2pi5R2z
 7GeoFWjQY6fl/fLWBgtg5d3bdyREOntF2AxnAr1S3tF1bkpEdwvv++e2r+3RANOTaaaG
 m/a29vLY/74NdrfLJgyKHTL0W+KLkxT4kqO9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720299; x=1697325099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/bsO+pUYYSO6ux3BB/KfKOadkY7zF+2aiYnO7+B5aY=;
 b=nG5dBfBelVBwzSZL+T9R7QmoiI8Pi3Kue7wNOxYh8heTn4VAuheMvFpFHYls0CrxlK
 qlrM9x/9Xqp87G5w5kM8RP5CK5meRZXQfy1ueDa1rZIOd8yVr7MDGGHnBzr7mfD8u8JT
 9VlW/CdHy0zTeEdtA9q02e+1AHe5RgPHns/4ZxsZD87imsBop3TnV/L2XKchIoWVfoZI
 /vVxkrOWMgEZb8KJzEunllVv5CDKSfE18bTeE2VYVSBcVYwXzrKT4sqzVdCx6alb6QrL
 C3QWRujVyQO427Cw8V9uyDdfrON0rg0qNHL5tYXuvnagAR1TCKOrQ1UJtwE6R8IQhHn2
 QRIw==
X-Gm-Message-State: AOJu0YwbDB08zgX2LVSi/3SKQfMzLpbB1iqRAkx13j6sexRsVsFw7GvX
 l08IdO3Zwj53jqdCYGSJzseSRTok6HA6HKr288qAGQ==
X-Google-Smtp-Source: AGHT+IEwKinIdlhgk1uB05aLzvTCqyLOX0A9oexo0H1foGepiixpO4p2XKqS7058IFMRcLYej8s9zXU16xQoLw9CYvw=
X-Received: by 2002:a81:6e44:0:b0:577:3f8c:fc60 with SMTP id
 j65-20020a816e44000000b005773f8cfc60mr4910273ywc.1.1696720299254; Sat, 07 Oct
 2023 16:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230929160654.3475279-1-sean.anderson@seco.com>
 <ae1e25f4-0fe6-3476-406b-298d6a196f65@seco.com>
 <CAPnjgZ1NEGXOjQ9QmW7150d20Ur+V0NXs1VGtF756huwXNMayw@mail.gmail.com>
 <176a961f-8f1c-f926-eab2-5d0a8b2f86ec@seco.com>
 <CAPnjgZ2Bzo1+v+Kb7onxEd7_E=O_nnnU2F+h1X1KAazRUCRniA@mail.gmail.com>
 <2cb8bc98-567e-3267-0a2f-fc5e951f98c5@seco.com>
In-Reply-To: <2cb8bc98-567e-3267-0a2f-fc5e951f98c5@seco.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:10:05 -0600
Message-ID: <CAPnjgZ1EWk1XLiD5CUj_hkn=Wn1wky=cR1oVtBNpF5rrYTOnxg@mail.gmail.com>
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

On Thu, 5 Oct 2023 at 16:24, Sean Anderson <sean.anderson@seco.com> wrote:
>
> On 10/2/23 14:56, Simon Glass wrote:
> > Hi Sean,
> >
> > On Mon, 2 Oct 2023 at 08:38, Sean Anderson <sean.anderson@seco.com> wrote:
> >>
> >> On 10/1/23 15:36, Simon Glass wrote:
> >> > Hi Sean,
> >> >
> >> > On Fri, 29 Sept 2023 at 10:12, Sean Anderson <sean.anderson@seco.com> wrote:
> >> >>
> >> >> On 9/29/23 12:06, Sean Anderson wrote:
> >> >> > SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
> >> >> > tree. Don't skip them even if they don't use the devicetree.
> >> >> >
> >> >> > Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used")
> >> >> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> >> > ---
> >> >> >
> >> >> >  test/test-main.c | 3 ++-
> >> >> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/test/test-main.c b/test/test-main.c
> >> >> > index 778bf0a18a0..edb20bc4b9c 100644
> >> >> > --- a/test/test-main.c
> >> >> > +++ b/test/test-main.c
> >> >> > @@ -476,7 +476,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> >> >> >        *   (for sandbox we handle this by copying the tree, but not for other
> >> >> >        *    boards)
> >> >> >        */
> >> >> > -     if ((test->flags & UT_TESTF_SCAN_FDT) &&
> >> >> > +     if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
> >> >> > +          (test->flags & UT_TESTF_SCAN_FDT)) &&
> >> >> >           !(test->flags & UT_TESTF_LIVE_TREE) &&
> >> >> >           (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
> >> >> >            !(test->flags & UT_TESTF_OTHER_FDT)) &&
> >> >>
> >> >> Upon further review, do we even need 6ec5178c0ef in the first place?
> >> >> ut_test_run_on_flattree looks like it's trying to do the same thing.
> >> >
> >> > Well one problem is that many tests are not run at all unless OF_LIVE
> >> > is enabled. The code as is is assuming that OF_LIVE is active.
> >> >
> >> > On boards where OF_LIVE is not active, many tests won't run at all
> >> > unless they are marked with UT_TESTF_SCAN_FDT.
> >> >
> >> > So I think that UT_TESTF_SCAN_FDT line needs to be removed.
> >>
> >> OK, so to clarify, since 6ec5178c0ef added that UT_TESTF_SCAN_FDT, you would like to
> >> revert that commit?
> >
> > Yes, I think that will work...but just check that tests without the
> > UT_TESTF_SCAN_FDT flag don't then run twice with sandbox. There was
> > perhaps something else wrong at the time.
>
> Actually, upon further review, I think that the above patch is correct. A revert would
> cause tests with UT_TESTF_DM but without UT_TESTF_SCAN_FDT to run twice.
>

Thanks

Reviewed-by: Simon Glass <sjg@chromium.org>
