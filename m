Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81266CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F098A847C3;
	Thu, 18 Jun 2026 15:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LTMLhTmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF8F84874; Thu, 18 Jun 2026 15:05:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F538460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bec4639953dso145483866b.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781787955; cv=none;
 d=google.com; s=arc-20240605;
 b=BfIaeGOiARKDQRgdM7koQFIVf2pWR5bhCYPRY9caOgQaxF1NpOwqlQv7y+mdL1BgV0
 v4jYgU/n5EhDGkXiW1rdztg0g4FYTcNJkh+ELhwLq3M3CYO8EzNs2YLrDCRjkvrVEiUt
 zn4+n1qfZCHgX2KmgamTIFFvFYrMqHTlbe/+h4TKR4vVcyHCC2cKvb/ONEUO2kUZJNOI
 DcRf1kyxrYpT9EdwdW19i9nv3rzUD+JX8ZJgqcZvrS/rY4pTpZGC4nV/Kc/V3bUZkBGG
 YC3py4SQHk5Q15X2g6JSe9Y6k0oGpTv24AASPrENA91SswoTsMwvyIN76wkIV2wU23ff
 62Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tOw7g3BLJkGjXE9wXKtT4SYPnFfO4tJJ5DmOBkYVBPo=;
 fh=aCJ9LYRt3Tx3PJdHtcGy/8qd+yIJTSdchejP/X/BvkQ=;
 b=DdQYjUecNs05PLKmzkgjqTsd0rz6DL8e8g49LhmQgKpI12sEiX15Ome8qyzvF1K8cI
 7sJxErTflUYsWNihmuPU3SjvwQ95iul7K4YT9tOrkn6NxFnCOGaCTL3rEk6rihiQtx2L
 RPmK9P9f8RqVH/axv7Ezsf8LktDJtuvZ1BE/UafhD8wNCt515Ksp39YSyH8KGoT7sP10
 VIJ7fLw1Qe6AwaP2ztkfrAHc0KrWoPAZM1l/YTwXWFkh0UmLb8dO12aQpHdQcJaHXXqT
 MHJAMxRWrsgHaTMe4pjwaEeIV7RKujY1lH7t0N9DChy/uI7W9/VWAo9vvGyJ4EEX0efD
 vw6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781787955; x=1782392755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tOw7g3BLJkGjXE9wXKtT4SYPnFfO4tJJ5DmOBkYVBPo=;
 b=LTMLhTmEGZGlweBe9LD5aj82YWgbOU6NB4NaqyYcRok8ZrIU77muyKH0++YuxXpNry
 lWrQUGPVcR/WyHlh4ucjvxKick3Mhf++Wo9rIvWIZKCFQRPy2xb+6Valkvg93SVPh9hW
 HClNN7QzBIUrwSEUiEYwBL5lcxMsWlbnvbhdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781787955; x=1782392755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOw7g3BLJkGjXE9wXKtT4SYPnFfO4tJJ5DmOBkYVBPo=;
 b=K1SUEaq3ZQx4CT2cApDJ2Jc0zvvdo8lCKMKdIHYr7EmeFjj8kKtRHroj+S0aDn/8CU
 TZMq77pNy636M9iOkv2INH/3knRzFa/vl6zlC5MHNnKfU/ZqCcXv+C4alPhmzxSHgOkB
 Lt6zIa7Y6Th+ykrNaqZjP738d2RqA12Gmm+xsZTaH2eesAGvhdAlGp/Xg5ab3e/gve0B
 ppfol1rthS8uBwoXVVN1FREwB39f/MwsAyF72uFy6k2MHpiQ69V80vvUa/V8Tc56/+hX
 2k1kpVfS2UbRw64I04U/5ne7FNKZWU7jsjG9auP+qbrqpXxJXQkjuMjq9ujINOIDrZll
 2GUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MgSVVebsAs67VARI5+DodwpMkR5xRMpYL7ll5eTG45rXSXAkp0fWiBXrIgptIASanuBJzddA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf0Xv4xpglYuRyYabkT3a36V5WLYz/YXaBwbPIPDgdFj082zHv
 WqzR1WKhQiGJWiz09IWFbpnqWPgA+S2oyp8XnKEGpYEtCNDP3s27ugdVaPD0Zg9fR4JrdCd+yBD
 4Uw5a7dbrFszH/D0Je/lNpzG+UnDu85ucJ1a8cRa/
X-Gm-Gg: AfdE7cnAa/T5mSvUS4PV8HZDH/5Vks8EpgO3+c1vfKZHs8UR56Oinc1Vzoyruj641Oh
 ggniFahvu6ArgoazOC1xRw1TtLg4vBOi6piFKrEp20pmWAmvE79Dx/UK5c/KdlH4rnpvotBg0bf
 mF9dBwP+CGzRNw3Uu7TbCmk2sZGvA0Yzejx5aC8AiaLwBBhiJrkPMfqLBiGexg8k0NRNkD5eAWu
 uy4wPgiN0LgUBIAeiAzDaDqXYbJBveuzfp8xQ82sgnDqCtF+Pn0DuHGGCOoegIGsgZD8AzC9A==
X-Received: by 2002:a17:907:801:b0:c07:e025:154d with SMTP id
 a640c23a62f3a-c07e02527aemr98377466b.52.1781787954999; Thu, 18 Jun 2026
 06:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
 <20260610-ip_defrag-v2-2-060f6eeaeaa1@nokia.com>
 <CAFLszTiiBtrthYHEAeppEqUoksW3fv7j9UNmztPOVd0MVCV8Mw@mail.gmail.com>
 <dfa39230-ac45-44bd-a2f3-4baf840d34fe@nokia.com>
In-Reply-To: <dfa39230-ac45-44bd-a2f3-4baf840d34fe@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 14:05:42 +0100
X-Gm-Features: AVVi8CdqvD7k52VCJp8IiGXTDhHQCDPOHWxPLNkd04qCJv2B-7tfbbO70mw7kKY
Message-ID: <CAFLszTjLeaohZWKR7u0OGh8kVXWiv9JJ8yNJ7+TxqV4MA_XuDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: net: add IP defragmentation
 duplicate-fragment regression test
To: "Mateusz Furdyna (Nokia)" <mateusz.furdyna@nokia.com>
Cc: Ben Warren <biggerbadderben@gmail.com>,
 Alessandro Rubini <rubini-list@gnudd.com>, 
 u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Mariusz Madej <mariusz.madej@nokia.com>, 
 Mikko Heinonen <mikko.heinonen@nokia.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alessandro Rubini <rubini@gnudd.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>
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

Hi Mateusz,

On Wed, 17 Jun 2026 at 16:19, Mateusz Furdyna (Nokia)
<mateusz.furdyna@nokia.com> wrote:
>
>
>
> On 14/06/2026 14:16, Simon Glass wrote:
> > Hi Mateusz,
> >
> > On 2026-06-10T14:25:33, Mateusz Furdyna <mateusz.furdyna@nokia.com> wrote:
> >> test: net: add IP defragmentation duplicate-fragment regression test
> >>
> >> Add a unit test for the IP datagram reassembler (CONFIG_IP_DEFRAG) that
> >> covers the duplicate-last-fragment scenario.
> >>
> >> Without the fix the last fragment will re-trigger datagram delivery,
> >> increasing udp_rx_count to 2 and effectively failing the test; with it
> >> applied the test passes with udp_rx_count == 1.
> >>
> >> Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
> >>
> >> test/dm/Makefile     |  1 +
> >>   test/dm/net_defrag.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 83 insertions(+)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> >> diff --git a/test/dm/net_defrag.c b/test/dm/net_defrag.c
> >> @@ -0,0 +1,82 @@
> >> +DM_TEST(dm_test_net_ip_defrag_dup_last, 0);
> >
> > Just to check, does this test actually use driver model?
> No, it doesn't. It drives net_process_received_packet() directly,
> nothing is actually using DM in the test path.
>
> I'd followed the existing precedent in test/dm/eth.c
> (dm_test_string_to_ip6(), which similarly doesn't exercise DM), which is
> what prompted my earlier question about whether "ut dm" was the right
> home for this (and stopped me for looking further, my bad).
>
> I'm happy to move it to the lib suite, for instance. Since Jerome has
> already queued this v2 for net/master: should I create v3, a follow-up
> on top of what's queued or just leave it as-is in DM?

Since it works, this is fine. We can always adjust it later if problems come up.

Regards,
Simon
