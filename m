Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8020C44501
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1047784AD6;
	Tue,  7 Jul 2026 18:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=vrull.eu header.i=@vrull.eu header.b="Bd/hscBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DED684A30; Tue,  7 Jul 2026 18:39:01 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 132FC84AD6
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philipp.tomsich@vrull.eu
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c1222885048so27817266b.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783442337; cv=none;
 d=google.com; s=arc-20260327;
 b=qHdRkQhk4kYx1Y2qT03nPQow+mUJ5WumiK8L9daeGMUCrf27INxfBmRQdarG7mA6z9
 vxmWk/Wx3NfyYKWCslU4ORJTByEys0wQZ/Vm/dsMY9cCYsLGG4vvahrBTva84jRpSG3T
 xp0tLRuYjeAvsUhdCCYeW2RNVICN4CCM8OlYX/M1DHSbEIF9/cwiW349ZUNtRxqWZIBc
 ZeBMMumP8AETcDRE9+y6t6Fyb2Vva7+WUFOFpcboJPJs2o+7SnWxOHJmXZaP8kOAE8nN
 FKwDJOQDzHgTwOn1FhI+FxAnP4oHbdkau82Kjt1P9NL4VpHYcDAlimMx4adhuANMkT7d
 Dzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kSVvDWf5J0eXk7H8JSKKXfGmY5GeA5zMtpPaVkqDjWk=;
 fh=lcJ8qvA0549YKPXHagusDFx6cXEnQPwdlUuGeF65SQM=;
 b=Mg/hYSY1+n6TuVkWN5g0n8VRm+yqVLM7evm6jT6/9vkhZ6Aj+gfE7uOB1ONVQsKV55
 suq3CZf1Ee5SsMqAwd28ibXE1IeUEiSxzw1KwFYyf+783bCOw4eQX3O7hjpz7rzd551H
 8dGSfIRYVRIg/AO4pQZ07HUGTZwVy5HOzCzewTz/UdGmyB4B6bid4/vkS9Q9YFH1HOXQ
 MP5WuKmyom/BrP6zhKaUt2m4t9aoNfE4BBpu4h/CNS4lqhMEYUeHc9s9rHwmtkt5cUyM
 4QuvcNKCp6O1WnPjDC3jXRryLIiB8+108WcpToT4QDuo/SGs9Qs1XQEymRgFSVD8oGSo
 Q/Bg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1783442337; x=1784047137; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kSVvDWf5J0eXk7H8JSKKXfGmY5GeA5zMtpPaVkqDjWk=;
 b=Bd/hscBL8J/T1Iq5SXvDffX36ZRatW6Wd0DWuMatfd8BGZUtntDxzBzbtQId9aNZM3
 PNizeW9zU+s1jy33a67C8H/RgmO1s7xWm/+z3ubnuA4fDPQa09Lc/XrChn/QqYkf3m61
 7S1dDHMcVqGQzB0PVGYe9Ronkgc3VwGtRbEQItMnehBDtbp7UKYJd3OSIveaCckIabni
 irSD5tPABYpNPYToXaTEzim9u9NGYEpevuZztCZXWe1VnXt4tccUtWtRGilyCbmZN5x1
 VpMmrcDqfsBEyhJ5vGdi4iiPlJ18PG3ZG9eG9e5DQFQE3jjE5PZQv7QdodQDFc5Ljl3h
 G6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442337; x=1784047137;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kSVvDWf5J0eXk7H8JSKKXfGmY5GeA5zMtpPaVkqDjWk=;
 b=a4ncKN+lqzGoJhjLm2jgq15SWOZICsL3wIz5JqvhK1+KkFwcf50ClcyBitEaMd6lpK
 uzKU05A6wP48gjs6R1WeU+YWYCHUQl4AYn7aJRI9S4rfYjDw3ZOpH9c8UipfOT+YI7i1
 hOJOyqxgK81xGpEVcTRd4ElWIt4UGgzRlR5LKWSqjCyHP10e3ANEnY/+EbPUxTXrwp2T
 X/0n/1LFOKE6AGKZQMJlTizVN9QUA9j8Sy6XezVDfNIxxOc0/HcSbBjSzh5nvfREnR7c
 OdtFCd7WsaG3MKgMahSefyz5RDGebiXH/xqQ4o0q67Pc0J2KgwQySJea2F7h4P9aGYJt
 hkpA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoacAk5fQUD/oOuEhTeJsdU6VwILU1ORcgNIADmHu2EAxu19a8B7H+JG5dvi6en3GJge2Khp+8=@lists.denx.de
X-Gm-Message-State: AOJu0YyyIIQwxdT9c4OQV+ggT8yHeGXNIA6xo/HB4zPflwMLPUdfOaX0
 0h5AxbTRRc54axCl6oxQ6YZ1knC51ynHCmQhkqmZ7w1j8UIevFVaR+xTlvnDp3l6RfAELAF5Hae
 vMMkhri80VTsGpAj45TWH3N6Es+a80mX0lNRwIVed9Q==
X-Gm-Gg: AfdE7ckxnMO9rfR0ObNVuX7kY9XoG/uEIYxKxSAhyYmdFrqla5/6WfEXun8/sCjsTda
 elIXjNNG4kLKtYF0Tu5Mwv9E6MLETrk45JsIigDanRhtIbQPUyDC34+dx1oycKD5O/ENzJsTXe/
 gUSmRr/+RDIL9M9WCumLYSyHTAl29C7lV9Ih8O3i8Stkp1stSHw/KspLc2QWOc26ZJgpfgouFrR
 PtSrJLSsVObU8wt4d8CCmkZXZudvNWzg+/oIUDEJttTNZ1EXkgEIwlmTRu27G7kw25cQ9Do8UGd
 ZLGoEjOUiCp1/koyZwCayGQCi0DS
X-Received: by 2002:a17:907:7b84:b0:c12:c7ca:d704 with SMTP id
 a640c23a62f3a-c12e4400c5amr454245266b.6.1783442337358; Tue, 07 Jul 2026
 09:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
 <20260707-rk-custodian-v1-11-dbc9c696e613@0leil.net>
 <20260707163754.GJ749385@bill-the-cat>
In-Reply-To: <20260707163754.GJ749385@bill-the-cat>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Tue, 7 Jul 2026 18:38:46 +0200
X-Gm-Features: AVVi8CeilA-nyModBdHyHiPqUx4KuaUZXRG7zLCEq7NGIEVOX0JJJcoMsaG1Ddc
Message-ID: <CAAeLtUCeywSD6Z0ZnBZrPgoJDKgnDxycb-5qHhgNT7yX3tNacw@mail.gmail.com>
Subject: Re: [PATCH 11/12] MAINTAINERS: remove Philipp Tomsich from ARM
 ROCKCHIP maintainers
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <u-boot@0leil.net>, u-boot@lists.denx.de, 
 Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Philip Molloy <philip.molloy@analog.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

It's been an honor!

Cheers,
Philipp.

On Tue, 7 Jul 2026 at 18:37, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Jul 07, 2026 at 06:09:25PM +0200, Quentin Schulz wrote:
>
> > Philipp hasn't been active for years so we thank Philipp for his work
> > over the years and update the MAINTAINERS entry to reflect the reality.
> >
> > Signed-off-by: Quentin Schulz <u-boot@0leil.net>
>
> Yes, thanks Philipp!
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom
>
