Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B654C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2081876C4;
	Wed,  8 Nov 2023 05:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VqbOzddJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5025A874E9; Wed,  8 Nov 2023 05:25:22 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1450876E1
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5b499b18b28so77938517b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417515; x=1700022315; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2K9UKzgtev9af21ReQZy8t7FrL6Qis6SgWGKdRXGrVI=;
 b=VqbOzddJw+Kus7sYQoJqriQyMR869gkQcxXi3lye/6Zzvc8FzisUlC9b2BFbYd4gZ3
 fofzfZ7BmoVfcNJ9Ktk/GSmPoa8NKq56Oqj1XuV3e3XZZ3JK+Km6rmDOpY0/LDGgQjtz
 sE0ylzeIJOhWyygZyQ/Q/6idDl2LCcpO26ctI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417515; x=1700022315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2K9UKzgtev9af21ReQZy8t7FrL6Qis6SgWGKdRXGrVI=;
 b=ei+bo8F2x6MmZFjVwONLvr52gxGofs21HjH62OfV752kd/oUzTznLAEtFFMC+DHy9Z
 o+LdTpdW97lIYKLhzN5cW6o+MBxt/yMcV7gAFcZZ6dQHgdIIODCxvTjW8kBH1JPyurIu
 /kOZ0ytluayAVttI4SB31slezNkBqNUyY+uOYFgb/Te3eaed/kjGdaLoOxq7ovnLyyxK
 nqcKlWfpMC7SQLOBUquZ+w3FRWgXml39oBqnts60D5vIIQLq9tN01oZGxMuuADSzuoVi
 oA3hIQayGkQYHqTJQxUNDj0WvRFEUMrlHwrUtNyv6Lj/qE9KXqCxp3rXQ84JaGRTbx9t
 Bcjw==
X-Gm-Message-State: AOJu0YyHuzeSbMbi6SgiEVsXSy9iMcxaEFONe//V5Rgmbuqx10LYohim
 wuNX3I7TIlWmJsbVMNTGsHRWyxtHTUKgeXSgjQoLUQ==
X-Google-Smtp-Source: AGHT+IFHrHk8Y7e+lcTvHN2kbnJFW1eh+TLNzIDEc+5AaGzlA9fbrwD7S9Ehs5K+5WlJuMKD+Iz0/nKBHMDbfDxGvZE=
X-Received: by 2002:a0d:c042:0:b0:5a7:ba51:9c1b with SMTP id
 b63-20020a0dc042000000b005a7ba519c1bmr638323ywd.37.1699417514993; Tue, 07 Nov
 2023 20:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-5-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-5-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:41 -0700
Message-ID: <CAPnjgZ0sHZfJ-C7peTncf6=CD_mmkaGogx0LRzQHQJ=OGptjDQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/25] spl: semihosting: Don't close fd before
 spl_load_simple_fit
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
> On real hardware, semihosting calls tends to have a large constant
> overhead (on the order of tens of milliseconds). Reduce the number of
> calls by one by reusing the existing fd in smh_fit_read, and closing it
> at the end of spl_smh_load_image.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  common/spl/spl_semihosting.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
