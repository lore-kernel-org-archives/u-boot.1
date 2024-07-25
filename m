Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D414C3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915E288667;
	Fri, 26 Jul 2024 01:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nTx19Qxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4508851E; Fri, 26 Jul 2024 01:32:44 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4405F8855C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b06e63d288so523276d6.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950360; x=1722555160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lzLzR1m5FG6I5YIT3OnfBr+6KKCTDEVoQp49Z5oYyOo=;
 b=nTx19QxeoTUF60vDxpExi1VAiKNHfX9gHoTIgoUkJ9JwMtz70G8elKQqLrRVTCPyBX
 WD4F0ChCfmDW1LEtMvA8llpGAy9NS+LHyFOltp35oi5oG7J7MKzvLGQEfH7JHK8EpV3T
 WRpNoXEiIuFRwgqdtlwUzEQEtPlgc7o2x7c4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950360; x=1722555160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lzLzR1m5FG6I5YIT3OnfBr+6KKCTDEVoQp49Z5oYyOo=;
 b=r3QSxuYgkgaBU1eanXPjlHXkedEhE4GbxoKSi64oiWNuEEnvbfEEwrp6c+LUIpOaoF
 x9BnQw+a7FneuafUAYWaMNM/1dpLHUd9v6GNWZ9kPpUgc4IEh72oFWa6r8k87fOdFNhS
 +Qw/bPNWHbZ5OBqITPjmGjYUIoNBR1aNw3bYH3yw00cemVtmGOOMrmMjguyQhvzAcjVZ
 bBTQ3zQAmE6K4p/mEJylhBak8O4DdqhQOWhnI/78A4F47HbqQdV3aOfw857cx3ZYGyDC
 gRRYZBV5vNumDRrVL7I3pHHvTtdA720Zpz7VD9tQAR/GO250OQTNi2XHx+7xBX2h3MqM
 TgHQ==
X-Gm-Message-State: AOJu0Yxhqb8lGBQy6RuTp9OgZJGHspaASz19BA7+skRw/uE3zrVdogLJ
 TrLPFZz3TanZoA6DV6jrWtIJvQpwC0bciSEm9CsEzLT09SmddJ3o6/pyqYZ3xhCT4mNdiFDUDwB
 vFFMbxWNAbSTLksIB5LKrYdG5b7MiyKzghbTo
X-Google-Smtp-Source: AGHT+IHZcbPcTmyA9W2/fFnZ7RpWRGJ7Hga8I38aD8eZLGdnsAvsw55wiBZkpJ+7JBZ3lVOTM9DyrHvq2/klvTEemcQ=
X-Received: by 2002:a05:6214:76f:b0:6b5:4ca8:2798 with SMTP id
 6a1803df08f44-6bb3ca55ccbmr54454146d6.27.1721950360175; Thu, 25 Jul 2024
 16:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-22-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-22-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:29 -0600
Message-ID: <CAFLszTiF764iDTdMRQi0wG9rLh4LuB-kB2qWTSUiez3MyN2Zcw@mail.gmail.com>
Subject: Re: [PATCH 21/40] lmb: bootm: remove superfluous lmb stub functions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Remove a couple of superfluous LMB stub functions, and instead put a
> check for calling the lmb_reserve() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  boot/bootm.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
