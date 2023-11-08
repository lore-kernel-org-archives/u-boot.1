Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93751C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DACE87764;
	Wed,  8 Nov 2023 05:27:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OzhPva7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80A487760; Wed,  8 Nov 2023 05:27:09 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 153FF87767
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a7b91faf40so76925317b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417621; x=1700022421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i8xc8Y2evn5DfLwCRHnD8i0awGC1QEK7NtABWtUK+sY=;
 b=OzhPva7FkPJptJwlPNlliB4YXunLuEVaSRCbvlDyE25RUBQEIucr4SYfo9ea43BQ8D
 JZkybpO/a3A/2vXiyTY06z1CY6QqUtRADWdpif7qNKHhpRy585/qLZgRuAhK8ZlEPhjo
 dvbbm4jidk5sWVQR940UcgsHVJLOQDokNqWuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417621; x=1700022421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i8xc8Y2evn5DfLwCRHnD8i0awGC1QEK7NtABWtUK+sY=;
 b=cDaPWah0qB2nBFcmeXheIFoA/SAJqNiXz5t2CR8GORy96YjQkOz84iLLM0dtsBJt53
 FGkZfsIxeGNgqIQU4QYXBb+CFAbBxf68HU8+orYL1GmpqO54Xq806rBg8al8DnZRUr7N
 TEGmGpNuQ7r/WoWSPk9qeLXsAaF3nvr/cFQpHpPy+YEGV75avGTKQ4bXpty62QJS5Qu9
 JJBC7Ey9IB8qVOB/JC1jnoSjaDHXrqyGeNI0NZq7xchn/aFtniJAv8WkKEsE4ge4wsgi
 nRxgl+4lnQDEqfF1AN9Ym8ZN9DStfndaRo4MHNbKMNjL5Jwvvnh1bSCNDx9YWrvRxQf1
 s0dw==
X-Gm-Message-State: AOJu0Yynr36oWoBLeg4kQxx2J9HXd3ZhSh+SHcCTOysCzsVWefW2OJGn
 mtNnuh1fI7MpGcPSRcZyZX4Q4NeWG5c/t0w7igh7cQ==
X-Google-Smtp-Source: AGHT+IEM1ne6ok+HoJ4xW8+qMh3uDTa+uhx2kjUhTDZrUZLelHZrd904Hih7pNl4EQW2rDSTMPQ3eQPPgVxZhOChaWA=
X-Received: by 2002:a0d:d9c9:0:b0:5a7:afcc:80fe with SMTP id
 b192-20020a0dd9c9000000b005a7afcc80femr736874ywe.3.1699417620660; Tue, 07 Nov
 2023 20:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-20-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-20-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:05 -0700
Message-ID: <CAPnjgZ1+OLOptkSS-2LgA5=v9BQFGx4KUu5VzZQKOhLRGiZy9g@mail.gmail.com>
Subject: Re: [PATCH v6 19/25] spl: Convert net to spl_load
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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
> This converts the net load method to use spl_load. As a result, it also
> adds support for LOAD_FIT_FULL and IMX images.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - Explicitly initialize load_info members
>
> Changes in v5:
> - Rework to load header in spl_load
>
>  common/spl/spl_net.c      | 29 +++++------------------------
>  include/spl_load.h        |  1 +
>  test/image/spl_load_net.c |  2 ++
>  3 files changed, 8 insertions(+), 24 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
