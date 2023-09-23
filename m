Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A0DCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F254886AF7;
	Sat, 23 Sep 2023 20:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G0qpFSzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960A28469B; Sat, 23 Sep 2023 20:13:52 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEAEE846D2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c008d8fd07so65185111fa.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695492830; x=1696097630; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tgfdQPqEnD50cu+cXij7s2KTFjPytpjCnriqB9UgOIk=;
 b=G0qpFSzxYep/zSUsQhu2yenYEXDlgsXdktcwCbOTM7NGqIXMbK065fl+S89mfQ9N2t
 Mz6AlxPemRjDBp2RTMOmNjX+sSXbNoGka+swJ/12SuzVZGu6PwW5/JQcfGiH+Ln2rOxc
 cz91jPqfRQ0cxT0DSInyaKr2QcC51XEiHYXRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695492830; x=1696097630;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tgfdQPqEnD50cu+cXij7s2KTFjPytpjCnriqB9UgOIk=;
 b=b+jKwJeqTRRnbZyqyT9DtFdfw7LdfOypjJVhQP2b+Gu1uGdFR7hydtied5IPsba3+w
 00qHosLboRk0tDYIGYTxopTWRIjMitDKMZ9yqWKROBonlr5wval+aeekSqfb2KMhTJSP
 BVPMmKco9XoaJfx+4R/W2JUulB77Ch7cXuO7xz1CGEgEMSwiCYXxCGhKJGzD/ybRzn9V
 CSzczR7PUQu/0HkauGKtrIoFEHBfVMM6wqKM1vBH3oXHxPMgjIAh0djwaCmEmyu9Q16/
 Q07NBKM21Rce0KVJdWBoR8yBcpZmiRb7lG6vfoUKcybR4W1dPrIp2aKLys1WoFuBtART
 aYNA==
X-Gm-Message-State: AOJu0Yx4XF4kv71T9YIh4jMXkApFFRulZ340LLx7zSZeo3vp35vL2ubd
 ay0W0QoKMoKG5liZ8RsNn+df9Dt9cyR+wOUBoiBfsA==
X-Google-Smtp-Source: AGHT+IHp0yrknDpBYfXAMXa81BCoV7fr/YFgnGa/qm2mt5KSrNeXJ+poGHoioiiCkpbF+j2Bv3YonPDavvNvyiEUNUI=
X-Received: by 2002:a05:6512:3d0e:b0:503:3804:d2ce with SMTP id
 d14-20020a0565123d0e00b005033804d2cemr2756423lfv.35.1695492829768; Sat, 23
 Sep 2023 11:13:49 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 11:13:48 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ11Em1cq195+KL0UTcWvo=DwtF1WPq19fnMkg9GvtgoSw@mail.gmail.com>
References: <CAPnjgZ11Em1cq195+KL0UTcWvo=DwtF1WPq19fnMkg9GvtgoSw@mail.gmail.com>
 <20230908141655.2307809-1-fshao@chromium.org>
Date: Sat, 23 Sep 2023 11:13:48 -0700
X-Google-Sender-Auth: L1Gn9jUHH6DR8nvXtsnZEwWo7AU
Message-ID: <CAPnjgZ09aRQhQiosn571df0aJHhwpcMeMwgjAUyyhpEq+uvy5g@mail.gmail.com>
Subject: Re: [PATCH] patman: Respect include directive on Git config lookup
To: Simon Glass <sjg@chromium.org>
Cc: Fei Shao <fshao@chromium.org>, u-boot@lists.denx.de
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

On Fri, 8 Sept 2023 at 08:17, Fei Shao <fshao@chromium.org> wrote:
>
> People may put their user name and email in a local config file and
> reference it by the include.* directives, however `git config --global`
> doesn't look up the included configs by default.
>
> Enable the --includes option explicitly to support such use cases.
>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
>
>  tools/patman/gitutil.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
