Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733CEC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0A7584CD6;
	Wed, 15 Jul 2026 20:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dz9Q7McW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B73BE84CC7; Wed, 15 Jul 2026 20:39:33 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C071A84CDB
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so4056681a12.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140771; cv=none;
 d=google.com; s=arc-20260327;
 b=WgH62q4gLJ7pi7BTBqEWSf0annA0yl9AxNjcVmj0Rb86ZsqAILBD7sY7fmnvTsqHy+
 tLMc5NFs9PRUa/Ky6g5Zk/T47NfUoRGd5/QO06gaPjGQt3jPfRfaCOlskVPK+zYEDmoD
 7f/MKSovPec93DtfBdmy9AOz9i3Re0pQ8sw72VQXEFZWJTwQgSRqYfq9F/yH04XTbeqy
 oXyXJ7qugc7GtTD4RLayVaq7QqGGyEl1GnciNuv3Ii0TJMEjyOUCpWEVphW/v1b4xKIq
 +7vDz42L7M59nF7XBDqaCn6yOnJ+zG2zldy5NWLlDjLfrOq+94/uAtSVhllNs/MoqPnq
 S8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BCoMxIzW2N3v9NAdsRz5Y61QTtmIonoEOos8S1As8k4=;
 fh=iJRW8VB93FX08DrH3y1pKDG0/UVKiIyyGubq8HI//Y8=;
 b=TdKcwP2nPBkfPHicyVQSXVzltsU5udRdjbh+hjez3s0TdK9K2jj3XJlcKoLU+HaLRV
 2AXzFRu7Fpywbid0+QmH84JqiroHyfJ+6XT5P4/I/rHVgp8IKvU08mDujfkESg0gZihf
 WVCtJl8alJfCBNy5IDYdfndO/UPgv6dSBL//yFGNQ+qkoTjMtrSV8A1NdH25e9WxC8zo
 +FGtKdPpdh2o+8iJMBlbrtzAFnKpSWBdmcoBoG3o8mA6xiP3aIYcVcNOvxUEUgdcFQfC
 OhqaGY8PCPrxRNlDCD7knnH2OVoeOefnilNgSmehI5w1VEFs5ZUYKYnybT3lp5YRz3VC
 N0eQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140771; x=1784745571; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BCoMxIzW2N3v9NAdsRz5Y61QTtmIonoEOos8S1As8k4=;
 b=dz9Q7McW7fWunzKTUcFu/eopBFIj6k773mTeWPYqSxQ61TRC4JjrN1BE8icPDDGge5
 9dhcRLYMCtijdaNg5WySzubRxaz2Ij7shOUzqobo31UXLJ9RheGV912FSOorS0j4HHsc
 mgbJ49CcaOUSc2uM3nzYvvc+o3CSTmeBYEMK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140771; x=1784745571;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BCoMxIzW2N3v9NAdsRz5Y61QTtmIonoEOos8S1As8k4=;
 b=B8SULUcUUYN3u9xq+xxhcBHXDzR1BD18ds2HHw2ctDSIXXcSaQTD3xYNfJIDHv4yTj
 25nDUaUIJRX1+LCM0BgMTLUOiEAtg3RotQ8eZQzLTmZKJVPzBd3OstseCH27tp+WoVuj
 Et49G2o8j3Asm7mkEmgiBxPsLkluvmjWIVHFR/G3J3T1Ls4AVUiMKdiFU/TYxS36DSmR
 K/GooevClxp5H0cDBwgnnTG+8gpwMvWmUMBdy74VARzmZi7GfEhjeFPj1PzMaAoXpQlI
 wbGsM9SLXHCrkknWE0G+lskuEXkabV2Ad203sU2xdTPyQ0dcTMLVFik91WKGRM38SiWQ
 V0RA==
X-Gm-Message-State: AOJu0YzbJOWXsGCa0pBnak7iLz3cSPyCfRfrSxIVuL06Y3EU80/85wYm
 bcV7YOuLhjAegGdXVgZPCErs4k+zDprBA54f2V5+UOf8uBX7FWBq9/Ai//1l9hYkTPxogHA/II5
 fsKkpKJR9HErA8scUJoulmTM2iQeBPT++coOTnu8t
X-Gm-Gg: AfdE7cmE9ZhufDl41DXFigjFjBWF/S/XNCW/HhZ9L0ZJHob1cXp/MOwiv08pSmJja41
 nUxNG42iylk4BMO2bbElxC/j+SPnZgEv82o08rohRjsGEVDst628vp+cyYaqArnE+iJtJDY79uX
 p4VcRojsWAV1LzjccCQlAO7lkyZ5ueyxV9dos8I3h8djlWxh40B+dq/OU7hbzCj9+9DLlJhnpMT
 +T6aap7Dyj89YiQA8fKP8wLFEeniokFFBPBye4oqzmAf8WpbKU4omDx2pIo565igFTLqis=
X-Received: by 2002:a05:6402:1e92:b0:698:4d33:b191 with SMTP id
 4fb4d7f45d1cf-69c5efb5b1fmr10127149a12.9.1784140771186; Wed, 15 Jul 2026
 11:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
 <20260710-rinta-watchdog-gettime-v1-6-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-6-9a982fb93f49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:38:20 -0600
X-Gm-Features: AUfX_mwh1uGnXC2GM9OKSCKVDA-Ra5SW7cOZMTSAokKbHbgmVVP-Het4dBh3k8s
Message-ID: <CAFLszTiP4cu9RFc-KvUE325DCG9Y-ziFiyeEp4QajBooRGtY4g@mail.gmail.com>
Subject: Re: [PATCH 6/6] test: wdt: add a test for wdt_get_timeout
To: juuso.rinta@nokia.com
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
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

Hi Juuso,

On 2026-07-10T04:51:17, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> test: wdt: add a test for wdt_get_timeout
>
> Add a DM test for wdt_get_timeout on the sandbox driver.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> test/dm/wdt.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -38,6 +38,10 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
> +     u64 get_timeout_val = 21;
> +     ut_assertok(wdt_get_timeout(dev, &get_timeout_val));
> +     ut_asserteq(get_timeout_val, state->wdt.counter);

Please can you move the declaration to the top of the function with
the others? The initialiser of 21 serves no purpose once ut_assertok()
has passed, so it can be dropped.

The ut_asserteq() convention is (expected, actual), so the arguments
are swapped. Since the test has already checked that
state->wdt.counter equals 'timeout' a few lines above, it would be
clearer to check the expected value directly:

    ut_asserteq(timeout, get_timeout_val);

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -38,6 +38,10 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
> +     ut_assertok(wdt_get_timeout(dev, &get_timeout_val));

This only covers the success path - the -ENOSYS branch in
wdt_get_timeout() from patch 1 is untested. The gpio-wdt device in
dm_test_wdt_gpio_toggle() has no get_timeout operation, so you could
add a check there, e.g.

    ut_asserteq(-ENOSYS, wdt_get_timeout(wdt, &val));

along with a check that the value is left unchanged on error, since
patch 1 documents that behaviour.

Regards,
Simon
