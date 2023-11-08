Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E32CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D18687714;
	Wed,  8 Nov 2023 05:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F1zXVqFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C010087703; Wed,  8 Nov 2023 05:26:40 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E5A8770A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7b91faf40so76923357b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417595; x=1700022395; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQCbeWyL0D/4e/W1OHHwQU9Y61Cg5ww81x/xX07cNtw=;
 b=F1zXVqFU9A3m9POv9rNinQuyC+4p2Q56LQvp2LVKIKu6O4lDp5oRgTxYUpqClwvBum
 LdrphCOVOkrAtqRfsk+LOgUSO0tw5OFAdfeXhaWTC14gl9nXLSWJM2QDZZPa5D7tfoWV
 0CuVr0GbJjC3fGoM8pktcCtK4Vd2B9dN4NJTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417595; x=1700022395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQCbeWyL0D/4e/W1OHHwQU9Y61Cg5ww81x/xX07cNtw=;
 b=VVF9jmWuQhQOynRrhO3e0NOVPMNhgWU1SodSnThj+6JZoljt5hg6fteWshCrkrcQB2
 CpzZn5QXFm9zyxFrFRQlU74vcQ8sqizqTH5OXZR4xtzbZPb4wct2PLX5jd4OJeMSf3rM
 USry31D2Yt4+D9txYlxDMrXPLnpajhrHBynmvf6hV1GqYKT1Xw7e6q8hweM2cxqUK6ao
 L7g0yiZkgVt7d/ZaZZQS/KQ8WHy/Jt6UjGFD7QWVpJdRJm6fl9kOUUSaCO1/PmFE6Yq+
 lMLYccAWsvl5C5rs5Ot+NHLWHPN8j9bu0LTBl4JtyfQ62bhE4wpBzTJAU92wX2SYuNoi
 kOMA==
X-Gm-Message-State: AOJu0YxgQWObYq11A8thyqsGQ+hB/T5LdKuPIeP5tGUP1CDIKFpDvECK
 piTEiKeLtFdXQliD8A8vKoPCZvCeveV1bpIlZ61YfQ==
X-Google-Smtp-Source: AGHT+IG/0xmsX5fhOpn04hfuFwXgXtkGFlli+jk6/bh/wuH8p3ZhhRjJytcT+mLBhwsuGNxYBfqeviyXKCOw/3Iy/3U=
X-Received: by 2002:a81:4891:0:b0:5a7:c973:c82 with SMTP id
 v139-20020a814891000000b005a7c9730c82mr752815ywa.13.1699417595437; Tue, 07
 Nov 2023 20:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-13-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-13-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:56 -0700
Message-ID: <CAPnjgZ0gR=XhzG302wT7rVdXCO1Obx7M8--OtOaOeTe0eqfXLw@mail.gmail.com>
Subject: Re: [PATCH v6 12/25] spl: legacy: Split off LZMA decompression into
 its own function
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> To allow for easier reuse of this functionality, split it off into its
> own function.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/spl_legacy.c | 73 ++++++++++++++++++++++-------------------
>  include/spl.h           | 13 ++++++++
>  2 files changed, 52 insertions(+), 34 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
