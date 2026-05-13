Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D766BCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABF88467C;
	Wed, 13 May 2026 16:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lxRz+mMs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E0784686; Wed, 13 May 2026 16:47:47 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46B7F83EF9
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so575615766b.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778683665; cv=none;
 d=google.com; s=arc-20240605;
 b=FseCrGLybVQjkDguP7Xde2d7n9okRxF5WSiQqHL8UkIeQCWubeQXp4tRNcTrYkHYjt
 Y6vDjmY3jvVbEJqcO3sJpmDET/YGs3O+AYAcfaqTBQzxotDb0jMvBjhDuB8Ly3f74OtL
 or8PuA3VuWLmIymvimh1dyc1afYg3xCWN/oFNLbzFbYt42mZktWuFPiVKW0aLTv2GutX
 HgCe4XE+LkPDtD1MULTmX74Ds416RIOIu7OIVg2rjWlXeUhiDbQ3uldUGoEb5yWLRkDU
 gmq/qaBEDQBGloSSyKUliPNvP0iZ67PhigOuGit4SZ54LZzkAatj4dA4z17F/2Xna19n
 AdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GtRROAR8eyC+l8ZCv62CFMmqt6epSfbE1cxEER4Lz9k=;
 fh=DFckRsv0qokwsicMGANTSyuTqOOhjVTjcJimUrc7cIQ=;
 b=FDtY7cwa+7ynMevyZQ9B7LVCLXS/TU79mnksW7beq/Kao2yv/VF8aY/DHHcRdrZ6k/
 WWhrh1XTO6MhkL0AkH4X4RZuPNj6tlIw6amxgF0t62TB48WbBDco5COMvHqSXSjIiMpf
 vYhxtnuCVyiFL3P1PZTwbXnHDKTnJBsZrLif8EV1M1m/DB+dyLEnXTIKnSsU/r39RAu8
 DkZwtACjYjgB15xKyDMurRmYSW0yOtBylsiOlrlQ92F/BwJm9JVzGjzpjQpYSarM8Aa2
 Ud2ei0yQr4Tg2fn+kn/LvnmBlvzr0xDVujpcQBOyEsYSu6wRAPLBT0EH59g/ZIReyoTz
 5cmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778683665; x=1779288465; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GtRROAR8eyC+l8ZCv62CFMmqt6epSfbE1cxEER4Lz9k=;
 b=lxRz+mMsfL16RN3a9qezbv81o2FGLiPcLyCeDux7WN/Mg/5H7xhrb/TDTjJsazlVsd
 jtkLuuOFjw6gd2vORiuCj9kLWg3CvmJ6E8N00Oy9hCWiHOdo8C0XbtnIob4113s+pZjx
 AktlBRiXgmP77IogxqtPDF/9EbAJE0i/SXBNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778683665; x=1779288465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtRROAR8eyC+l8ZCv62CFMmqt6epSfbE1cxEER4Lz9k=;
 b=Sd0sF8+mEWKYbtW9QbVIPb2nTMp1vmH0UvvqXvVICKv815ANCG0FpGW55t0hJG7Llb
 X4bbbROtXUOiWt38TvFVs+7q6ahumv037+7M+IjChREbVdUx0mES1l5c1Ee4P5jaesPo
 EnufkTSXJOk3RCXPEPZzhRyae7XW95KzjOBANINtPpNLEZ/VJldjOYdESWK6+GmwLiEU
 ijpNvRf+jeLiw6UUiqbHy5sD2N8Nuxc9AbzSK/WmJ6RCe2dDp8nbrXRErrjyR+w+Yum6
 /2eryLU0kHMUIQbo31dhW9Eev7EM2TfEnbfRd02bXMVJj41scPWYxJfwqAhjhbFEq9c0
 Ingg==
X-Gm-Message-State: AOJu0YyNNlkRMTW8dDddEk0XJMOeeja/XOmTDlsgskjRErXm1Oeky3Xo
 QN7XrE3/xusRUn2t842H6RRY+6QoBjWhe9oRTu/uRtlUtggwLL9ISlPTUADjMRVFLMqpspZlkRa
 FPUd63NmZnEs1ZV3oA1KcLTfv9xgo8fnjYbukOm/0
X-Gm-Gg: Acq92OEneE3TnlxxoG14orBAdDDXCiWWv7m39KM23fjZU2EBaBt+YJL8A41mdlIrEeM
 nDpednUKWwGsnobVVT3xxO+5x9dcRUs96MEZl+J1ca82Vfsig7Sa8WqxHv1p6Ko5F6KNonXRpGA
 7ZTmkqZuZhBcWD9bxIPu3auv7JpXTF/xIX8C5+RbAzEWgRf2zGfUCEDqF8iJw9emCQqh/wNIMxP
 pNSsuis/d/dhc/NNcO16r4SpaxPpfoEEI/wm8bfTLa2SuMMVaKkJFcEUe/UTTFBThGM6UVVdlQX
 EzmPMA==
X-Received: by 2002:a17:906:9f8a:b0:bd0:def9:4119 with SMTP id
 a640c23a62f3a-bd3ae250c67mr225731366b.16.1778683664701; Wed, 13 May 2026
 07:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777984225.git.michal.simek@amd.com>
 <21c23cc7403153b45a81c958118b8d9f85f73140.1777984225.git.michal.simek@amd.com>
 <CAFLszTiYJU028+L40rzNa=X-qqDYCfbPqYMfGhzpK3Xq2mr8ag@mail.gmail.com>
 <cbadd601-4337-4eaf-bf6b-8c98645dc089@amd.com>
In-Reply-To: <cbadd601-4337-4eaf-bf6b-8c98645dc089@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 May 2026 08:47:33 -0600
X-Gm-Features: AVHnY4JGk50B7V9afPfZhLcUsw_jo1fBLOxwp-Dkk4HGyvFrEEaOOnP3gjH2pAY
Message-ID: <CAFLszTgZzZ8LHZ5KWMWqx2a54dPLBk1V86AxPGd=jEK1PQrPpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] reset: Add sandbox tests for reset_reset() and
 reset_reset_bulk()
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com
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

Hi Michal,

On Wed, 13 May 2026 at 02:53, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 5/7/26 23:11, Simon Glass wrote:
> > Hi Michal,
> >
> > On 2026-05-05T12:30:28, Michal Simek <michal.simek@amd.com> wrote:
> >> reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
> >>
> >> Add DM test coverage for the new reset_reset() and reset_reset_bulk()
> >> API functions. The tests exercise the assert + deassert fallback path
> >> since the sandbox reset driver does not implement the rst_reset op.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >>
> >> arch/sandbox/include/asm/reset.h   |  3 ++
> >>   drivers/reset/sandbox-reset-test.c | 14 ++++++++
> >>   drivers/reset/sandbox-reset.c      | 31 ++++++++++++++++++
> >>   test/dm/reset.c                    | 67 ++++++++++++++++++++++++++++++++++++++
> >>   4 files changed, 115 insertions(+)
> >
> >> diff --git a/drivers/reset/sandbox-reset.c b/drivers/reset/sandbox-reset.c
> >> @@ -66,6 +69,21 @@ static int sandbox_reset_deassert(struct reset_ctl *reset_ctl)
> >>        return 0;
> >>   }
> >>
> >> +static int sandbox_reset_reset(struct reset_ctl *reset_ctl, ulong delay_us)
> >> +{
> >> +     struct sandbox_reset *sbr = dev_get_priv(reset_ctl->dev);
> >> +
> >> +     debug("%s(reset_ctl=%p, delay_us=%lu)\n", __func__, reset_ctl,
> >> +           delay_us);
> >> +
> >> +     sbr->signals[reset_ctl->id].asserted = true;
> >> +     udelay(delay_us);
> >> +     sbr->signals[reset_ctl->id].asserted = false;
> >> +     sbr->signals[reset_ctl->id].reset_count++;
> >> +
> >> +     return 0;
> >> +}
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Some optional nits / thoughts below.
> >
> > The commit message says the tests exercise the fallback path since the
> > sandbox reset driver doesn't have rst_reset op, this patch adds that
> > method below - so the commit message could use an update.
>
> Will update.
>
> >
> > If you want coverage for the fallback you could add a second
> > sandbox-reset driver without rst_reset, or hack the rest to clear and
> > restart ops->rst_reset,
> >
> >> diff --git a/drivers/reset/sandbox-reset-test.c b/drivers/reset/sandbox-reset-test.c
> >> @@ -96,6 +96,20 @@ int sandbox_reset_test_deassert_bulk(struct udevice *dev)
> >> +int sandbox_reset_test_reset(struct udevice *dev)
> >> +{
> >> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
> >> +
> >> +     return reset_reset(sbrt->ctlp, 0);
> >> +}
> >> +
> >> +int sandbox_reset_test_reset_bulk(struct udevice *dev)
> >> +{
> >> +     struct sandbox_reset_test *sbrt = dev_get_priv(dev);
> >> +
> >> +     return reset_reset_bulk(sbrt->bulkp, 0);
> >> +}
> >
> > You could pass a non-zero value here if you want to test the delay.
>
> udelay is called and because there is missing check for 0 value it does timer
> reading once. Don't think that make sense to delay tests.

We try to avoid delays in tests, although 10us wouldn't matter. We do
have timer_test_add_offset() but I don't think it helps with udelay()

Regards,
Simon
