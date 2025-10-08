Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B08CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:54:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC3283E23;
	Wed,  8 Oct 2025 14:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DnRT3efg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3FDF83E70; Wed,  8 Oct 2025 14:54:35 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBED083E21
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so10921728a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759928073; x=1760532873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ffMY/6JuKqf5HzJQdN6qByd1zkMDF6WtGhCKcfv5Rl0=;
 b=DnRT3efgVjZ1pXM9oMORDpYzPBn0ozttL4i2b18AqttxA5wcfUPBofX3X80FpRe/9d
 C2MgqNNl4n4nF9sVkefljHRoN8ZYm5ROJQOwQxC2Tmxo5X2VYAFlWKzJplEIqNdswUpa
 RQPtmkfUqAtIedS5jX60sY+nBtz7ltseDnkRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759928073; x=1760532873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ffMY/6JuKqf5HzJQdN6qByd1zkMDF6WtGhCKcfv5Rl0=;
 b=M52IP4dTFDZiinY3JuAKv8lXWZVi4FPpSGmnbLgDzcxnoANtFJUKjJhn21IZ53LGHc
 QmUjfoe+DiABzZhdYMsBECxRdbut8E23ReTCJhcdiEipz3rftWSVd89Gkr390/sn1bIE
 v1kkHsenMUXvPMoxSmNY95FlCkakg+Nl1zHzKUUeDNxNKiVo6UZVOgBwBcjJcpZMAGZW
 6DM7tvrAynvH5i9u56ah7MQneNRdSomsIgTB41echl8gnZMvijwpwr8Q8+zOjAwIPDsx
 BLaW/pXCBADn9UbVpgKeWwDCaQtp45UkKUBc7qzcnY55NmGmx2LJCevUG5ZNXVhFmBAo
 4UKQ==
X-Gm-Message-State: AOJu0Yz0fOD7oZwACA0/fHIPQeqfw8uXY48a4s6eK75hM0GRll1GRITN
 pcpNdc+PGtiAe4h0k+8mUDHkga2AVh8dRQsd1z+MPZmUR9pZpU18cAwlatOiRD7TF6v53d1A3NR
 GZwayPRku1O8S80fLHY5Ds215Xec/0wupsDq1Fx+Wooub+BVkBRg=
X-Gm-Gg: ASbGncsGHJ17EpSBYfs6qSMocp2MPPVIsy8eraajlQ77hRRBJHKJ7/0vs2GeW+A6xB5
 J9z8Dgf+jU3TtcmV6YYc3kt8pPQ/CWyHg0dENJcJmtp1eBljaZ5g+lq600Vn80onUrp0bzqJzPx
 +cQDHvSbwQpRuU6TtoBPzUGXQnjUnsCJyqNxTSrNbp4rVLVOCUiLwSfRu5fb4lodKF/Jy9VmiEy
 wQOKGK+cB5pKYHqGCYJk9wc7q2wng==
X-Google-Smtp-Source: AGHT+IHCA5PKChZGn2IR8DcxAl0TdizlVwZFjMqY3B1i2PLr3jepdc1Lx35hvRTVK+QYltbEkpqQZE3ltq1aQqbzfrc=
X-Received: by 2002:a05:6402:1d52:b0:633:57e8:ea3e with SMTP id
 4fb4d7f45d1cf-639d5c6a5c7mr2642457a12.33.1759928073341; Wed, 08 Oct 2025
 05:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-7-sjg@chromium.org>
 <20251007175849.GN298503@bill-the-cat>
In-Reply-To: <20251007175849.GN298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 06:54:21 -0600
X-Gm-Features: AS18NWCBQ7WNgwek7ReHjeYSZGS_RqvBW4irunjk4pJMeRwHQ-rc5KusHqklYeA
Message-ID: <CAFLszTjEDa-YueKQu7i5E7C=qP15HnEhLour0xynvws7P76SZg@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] boot: Add a new test for global bootmeths
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi Tom,

On Tue, 7 Oct 2025 at 11:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 01, 2025 at 03:26:31PM -0600, Simon Glass wrote:
>
> > These have different behaviour from normal bootmeths and we are about to
> > enhance it. So add a test and also an extra check in bootflow_iter()
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> > @@ -388,6 +390,49 @@ static int bootflow_iter(struct unit_test_state *uts)
> >  BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
> >
> >  #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
> > +
> > +/* Check iterating through available bootflows to test global bootmeths */
> > +static int bootflow_iter_glob(struct unit_test_state *uts)
> > +{
> > +     struct bootflow_iter iter;
> > +     struct bootflow bflow;
> > +
> > +     bootstd_clear_glob();
> > +
> > +     /* we should get the global bootmeth initially */
> > +     ut_asserteq(-EINVAL,
> > +                 bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
> > +                                     BOOTFLOWIF_SHOW, &bflow));
> > +     bootflow_show(0, &bflow, true);
>
> Here is the one call of bootflow_show outside of where show_bootflow is
> called today, and bootflow_show is called by the end of this series.
>
> > +     ut_asserteq(3, iter.num_methods);
> > +     ut_assert(iter.doing_global);
> > +     ut_asserteq(2, iter.first_glob_method);
> > +
> > +     ut_asserteq(2, iter.cur_method);
> > +     ut_asserteq(0, iter.part);
> > +     ut_asserteq(0, iter.max_part);
> > +     ut_asserteq_str("firmware0", iter.method->name);
> > +     ut_asserteq(0, bflow.err);
> > +     bootflow_free(&bflow);
> > +
> > +     /* next we should get the first non-global bootmeth */
> > +     ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
> > +
> > +     /* at this point the global bootmeths are stranded above num_methods */
> > +     ut_asserteq(2, iter.num_methods);
> > +     ut_asserteq(2, iter.first_glob_method);
> > +     ut_assert(!iter.doing_global);
> > +
> > +     ut_asserteq(0, iter.cur_method);
> > +     ut_asserteq(0, iter.part);
> > +     ut_asserteq(0, iter.max_part);
> > +     ut_asserteq_str("extlinux", iter.method->name);
> > +     ut_asserteq(0, bflow.err);
>
> Nothing in the rest of this test is checking the output of strings, and
> nor should it since the test is checking the struct itself to be as
> expected. Am I missing something? If not, I don't think we should bother
> with the previous patch.

You're missing that when the test fails you need to try to figure out
why...it is much easier to do that if it prints out info on the
bootflow. In my case it was printing a completely different one.

I'm happy to remove that line (and the patch) if you like.

Regards,
Simon
