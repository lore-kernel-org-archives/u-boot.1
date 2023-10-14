Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36E0CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA24085E44;
	Sun, 15 Oct 2023 09:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ikitCntF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1953A86F84; Sun, 15 Oct 2023 09:00:34 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE25086CAD
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c518a1d83fso7593671fa.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697353097; x=1697957897; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jocrpBq3+rR0lswm7l/VoOlNQWDJ+HHzHY1+Bhr4eXs=;
 b=ikitCntFdwsT4khAxVkIJ4cdd7tUhbjyy9mLpVu+znr2NINAlGDkV2+D1TxGH1HRD0
 61J1k16FD729FlHmCKUdHlEpFE6rty/pJwfIJy1+t+nFKNWcrfc6ZIElclQ55b1pZu1q
 VTgOAhVysiponK4B0WFkK0mRAcaXU2QC3Ku+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697353097; x=1697957897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jocrpBq3+rR0lswm7l/VoOlNQWDJ+HHzHY1+Bhr4eXs=;
 b=JGeoZgZqTHHEYoE7LtECVp0Qd/g3ToGr4BlGnBqo3m1jdHi+N9V8U4NZT0c3M/nPL7
 bZ7prLv6ASZxcKsydzDLnCvlYNdKEyu0NROexb8kIVSER6F1HLUuIzyeqqovhcGmJSGJ
 1ut3UyBTJP31KHEqyVD/l6hdi0zUqpouvbz5l7zU3ppKiRTi3R7nCDF4qPOmquPyCFhd
 9bLk694YC5lpFNfRrP8z+GWCGs6lZ6C/bK9Ww2qWyIAJ+l98DzxBjw62icDf2yyrzWua
 xzTlOx7O2w1gXfpkm4/lvbP4aaGwF9qD0pOdtHo3zeZWdUd8+f7xUkoJvjiwfkWu3NGf
 PZKg==
X-Gm-Message-State: AOJu0Yx1q0gn206hffrhruA3EsxknsiVs5g5UAiawM8N/fAnzdIN97PV
 xTGfqfM1sU9xUNEBQituhju1T+/rMysJcwx5JPs9VKowkisa1teSKSg=
X-Google-Smtp-Source: AGHT+IEnYTM1PqSOeyYDLb8K0EZWarHYjZlaE9+wd40Gt8YaIZxheMHVKfOziN1llYri/jueNOqAyH+95tDCzMyzgfk=
X-Received: by 2002:a17:907:ea3:b0:9c0:2286:2c92 with SMTP id
 ho35-20020a1709070ea300b009c022862c92mr379638ejc.38.1697326519808; Sat, 14
 Oct 2023 16:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-15-seanga2@gmail.com>
In-Reply-To: <20231014204805.439009-15-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 14 Oct 2023 17:35:02 -0600
Message-ID: <CAPnjgZ2Gd39BB=Y1VgdD7JP3kRRcC6qkjwLM1wLMsgbojvB44A@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] fs: ext4: Add some defines for testing
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sat, 14 Oct 2023 at 14:48, Sean Anderson <seanga2@gmail.com> wrote:
>
> Add various defines which are not necessary for reading/writing
> filesystems, but which are useful for creating them. These mostly come from
> Linux v6.5-rc2 (what I had checked out).
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v2:
> - Split off from fs test
>
>  include/ext4fs.h     |  1 +
>  include/ext_common.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
