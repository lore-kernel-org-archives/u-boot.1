Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA6CC5ACB3
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A7486DEE;
	Sat, 18 Nov 2023 18:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W67/1Aax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA676874C3; Sat, 18 Nov 2023 18:11:52 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A888187208
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-da7238b3eb4so3086301276.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ca7qDawVkKTn9Fwx6nlCycVeGAnRKH6YUjj046st9U=;
 b=W67/1Aaxlkqg2eVjyaSeq3H1STnyLh0WsStBPlTMQhU1BBUI1Z/seky9PCL0rxmC8X
 Qzm2ijYZVrB/9e+elFvZbQrX3+qxvU53GhGdbGKOZ/a7xnc0m8FnP/7Vobq+GIfKvang
 XNfY2520sRrcsPY/chY2aF0Q1QYLEBD9V4aOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ca7qDawVkKTn9Fwx6nlCycVeGAnRKH6YUjj046st9U=;
 b=NMJ0nEiz+spBmsf+mB3Snp3v70Ueu+Uu/zjruF3GO15QbSgMCHzjWqdGMHZBhattg3
 ezagK6C7MAR9TRoJEweod4Ar2anAsFW8mXDab3GTYMnJw5mmcC6afJInke0k7FloCfZ6
 42S5fAGM+ODQuDP2dGPxldjWMrR08Z4H8zdQOMNoKcGhhfyTbQt5Bv7MXIBy3Od32cR+
 EzxJD83/MRaVOp6V1njVtTIU1EnK+91yRulsuSCyHtsWSb1Kr83x+kzW/WNzPYVC35+W
 Uzb1r4sxTWftKjVxRGgTx0p+LcyClri8yjYWhbPduNJL7neoO5WNLR8Lrqz88lT8AfC7
 pUcw==
X-Gm-Message-State: AOJu0YxVIGVIqL2wn6GmrsYQec3fBLNANu1V0dL6PogLDRT3KVvYVFtC
 di0hrfr8GuNgMRhu5cCk+N3OYnpGp1JcWIsd3XBuFQvnJtPf6qlD7EM=
X-Google-Smtp-Source: AGHT+IF/HMhD+/tnEJQePTDgl00j+IGTLCk/fZG2mDrwcA9co8hYA34NCgKU7R9p1ucc/kUMtke0iUiiYa6z6rJnRL0=
X-Received: by 2002:a25:6c4:0:b0:d9a:5244:32e5 with SMTP id
 187-20020a2506c4000000b00d9a524432e5mr2905902ybg.35.1700327504844; Sat, 18
 Nov 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-3-afd@ti.com>
In-Reply-To: <20231117223829.346652-3-afd@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:01 -0700
Message-ID: <CAPnjgZ2Q6wCK0o7j4NqQ22OvkJ9Vu-u9axrAubCEE=AybusS7w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: keystone2: Remove unneeded inclusions of common.h
To: Andrew Davis <afd@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, 17 Nov 2023 at 15:38, Andrew Davis <afd@ti.com> wrote:
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/mach-keystone/clock.c                | 1 -
>  arch/arm/mach-keystone/cmd_clock.c            | 2 +-
>  arch/arm/mach-keystone/cmd_mon.c              | 1 -
>  arch/arm/mach-keystone/cmd_poweroff.c         | 1 -
>  arch/arm/mach-keystone/ddr3.c                 | 2 +-
>  arch/arm/mach-keystone/ddr3_spd.c             | 2 +-
>  arch/arm/mach-keystone/include/mach/mux-k2g.h | 1 -
>  arch/arm/mach-keystone/init.c                 | 1 -
>  arch/arm/mach-keystone/keystone.c             | 1 -
>  arch/arm/mach-keystone/mon.c                  | 1 -
>  arch/arm/mach-keystone/msmc.c                 | 1 -
>  arch/arm/mach-keystone/psc.c                  | 1 -
>  12 files changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

missing commit message
