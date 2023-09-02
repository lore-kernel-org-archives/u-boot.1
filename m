Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08578CA0FF6
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 00:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0883686759;
	Sat,  2 Sep 2023 02:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eX/u68K6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 582C1867EF; Sat,  2 Sep 2023 02:09:40 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F1586703
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 02:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50079d148aeso4455278e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 17:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693613375; x=1694218175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nJUSaNJLgTDb38H7Uh0Gtjn7T6MkRKHEtMahFceNfeM=;
 b=eX/u68K6iwcVau9VXPioI4wHd3L3qUrge0lbKqFfvTJH8tTrzWy8TFRqxAdMBCb0YW
 XD9uhJw7O+mYKfCH8SasFhKHlggZfYt6c16NkE3u7QWLge+f/NeiBCsgflZAfp5IiveK
 kb62X/6UlZVuC4T78yZhzRfkE28cEeZBaPU9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693613375; x=1694218175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nJUSaNJLgTDb38H7Uh0Gtjn7T6MkRKHEtMahFceNfeM=;
 b=hTFxlxGSYMpZwSbm1bTWutabwCWQWyk2EE+7AwO9Nn6I0qBm2dBo7Es7sxqF2Jf2Ht
 ud3lb0XPE/a1RhkgU7BSmH31RVzeNNA00XWZ94WZsR9YdpSWACNPgOO7LsP0EU8CmmoB
 xk5lB4Va3iVPD1qzNFbVvFchQOwGc22bHRz9D1o6ioqM9JN7hsAWBhsr1VJkEF8JZ6kx
 /h3hmpOfdnFz383NT+Lyx49F8aJb8kWiar49mGxQNt2N7C3eyB5zXPeFgBP+el0cL6ch
 6nBZ9uOVhn4860QCmp4vjyCVQgXGyuK/UulgEFfL07HDu01U3L78AXz1iP5w1xorVdBN
 ysnQ==
X-Gm-Message-State: AOJu0YzhfDrh+KYjRswKH6LrFQXtxMivvRnukqEq3j2c+SyjSRz/xjhV
 aHeblaGupI3nM4RVCvkrwgirPR9VYnPWjSVbdEerUQ==
X-Google-Smtp-Source: AGHT+IFxzL7XKBsjMkc+vAB2lAOD5Aadx/C6U43HOZJavYnpmu/JeMV468ggpwnatqfGlUhPchUzCF7XAbSghvfr32A=
X-Received: by 2002:ac2:4c45:0:b0:4fe:629:9265 with SMTP id
 o5-20020ac24c45000000b004fe06299265mr3381209lfk.20.1693613374543; Fri, 01 Sep
 2023 17:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-4-masahisa.kojima@linaro.org>
In-Reply-To: <20230901102542.609239-4-masahisa.kojima@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Sep 2023 18:09:17 -0600
Message-ID: <CAPnjgZ32BRUtW4UsMY-KhGHfh0X5BuvZ3LnrpBPgd+GkOBvJVg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] blk: blkmap: add ramdisk creation utility function
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tobias Waldekranz <tobias@waldekranz.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
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

On Fri, 1 Sept 2023 at 04:26, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> User needs to call several functions to create the ramdisk
> with blkmap.
> This adds the utility function to create blkmap device and
> mount the ramdisk.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  drivers/block/Makefile        |  1 +
>  drivers/block/blkmap.c        | 15 ----------
>  drivers/block/blkmap_helper.c | 53 +++++++++++++++++++++++++++++++++++
>  include/blkmap.h              | 29 +++++++++++++++++++
>  4 files changed, 83 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/block/blkmap_helper.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
