Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A532CE78486
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 19:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F56870FF;
	Sun,  1 Oct 2023 21:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PjCvo6r0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8429F870FB; Sun,  1 Oct 2023 21:36:28 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5866186284
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 21:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32336a30d18so7651179f8f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696188986; x=1696793786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PL4i5R/gsjMGjDldWuKVQiqNL8f9MEF2rMDpwaGSODM=;
 b=PjCvo6r0IEViqQ8LJSAcHJqqH7jai0D45YrM2XWz0kClwH48Ke0zQ2dptypRckX5Wu
 9NwzRGQF1AFZDRP+U06Qk30z2bK6719Elzy6lzf++ayqRbfjpDyKSLC/QwMeRJGKKMVr
 gsG5f5Wo09u3OdNKUC4euQUDAS5cK0kLLSaAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696188986; x=1696793786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PL4i5R/gsjMGjDldWuKVQiqNL8f9MEF2rMDpwaGSODM=;
 b=hguqiHyBtwEE56VeJdgP6yqgv6xp4SoXCANEvcZplHN9zPQo0Gc1kjfzgY0Y0VaW7J
 6Y2Orht/yvK9l9Vo2fPIzKp13caWQYnvAJYlVAL5W34XHfjUjohTxeD5cWQU+aRvyprS
 EqotPQk0t1rwTaOayejfzDqafZpWzqod8ck6oUroKc1WtvascXKJ3TrpsdUiwuPeqrFp
 G9fmyOnh+8xispYYJ7QBf7SYRwnOaSSg2C5hE4/Wcs0V6OqM/JZDyngerYiGeQjmIXVk
 tdXHOIxi6iHq4RwsgJbtdJA9XzqObGpVjXq8fu4ifArjWFMubUjveUWh1kbl9696hDwQ
 +NcQ==
X-Gm-Message-State: AOJu0Yw9AcoXNIHMFlBm5DJxYIe2SltJGcg39DAZmTGgpEFrXMwAn5jg
 2jg8+ow0OQ0EniUc0rAqx/7IrJ9IAvIn3W63K6xkvQ==
X-Google-Smtp-Source: AGHT+IFStpTCX55b129DmXb5fRq1zV10tKVfrrWWpg7q/SXkefhBkq8LKyErtyKmcfFMlLQe+wLKRWxK+KBr24fvP5g=
X-Received: by 2002:a5d:40c8:0:b0:323:264d:9cef with SMTP id
 b8-20020a5d40c8000000b00323264d9cefmr7717747wrq.12.1696188985572; Sun, 01 Oct
 2023 12:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230929160654.3475279-1-sean.anderson@seco.com>
 <ae1e25f4-0fe6-3476-406b-298d6a196f65@seco.com>
In-Reply-To: <ae1e25f4-0fe6-3476-406b-298d6a196f65@seco.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 13:36:09 -0600
Message-ID: <CAPnjgZ1NEGXOjQ9QmW7150d20Ur+V0NXs1VGtF756huwXNMayw@mail.gmail.com>
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

On Fri, 29 Sept 2023 at 10:12, Sean Anderson <sean.anderson@seco.com> wrote:
>
> On 9/29/23 12:06, Sean Anderson wrote:
> > SPL doesn't have OF_LIVE enabled, so we can only run tests with a flat
> > tree. Don't skip them even if they don't use the devicetree.
> >
> > Fixes: 6ec5178c0ef ("test: Skip flat-tree tests if devicetree is not used")
> > Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> > ---
> >
> >  test/test-main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/test/test-main.c b/test/test-main.c
> > index 778bf0a18a0..edb20bc4b9c 100644
> > --- a/test/test-main.c
> > +++ b/test/test-main.c
> > @@ -476,7 +476,8 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
> >        *   (for sandbox we handle this by copying the tree, but not for other
> >        *    boards)
> >        */
> > -     if ((test->flags & UT_TESTF_SCAN_FDT) &&
> > +     if ((!CONFIG_IS_ENABLED(OF_LIVE) ||
> > +          (test->flags & UT_TESTF_SCAN_FDT)) &&
> >           !(test->flags & UT_TESTF_LIVE_TREE) &&
> >           (CONFIG_IS_ENABLED(OFNODE_MULTI_TREE) ||
> >            !(test->flags & UT_TESTF_OTHER_FDT)) &&
>
> Upon further review, do we even need 6ec5178c0ef in the first place?
> ut_test_run_on_flattree looks like it's trying to do the same thing.

Well one problem is that many tests are not run at all unless OF_LIVE
is enabled. The code as is is assuming that OF_LIVE is active.

On boards where OF_LIVE is not active, many tests won't run at all
unless they are marked with UT_TESTF_SCAN_FDT.

So I think that UT_TESTF_SCAN_FDT line needs to be removed.

Regards,
Simon
