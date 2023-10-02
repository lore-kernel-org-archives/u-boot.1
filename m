Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E83E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8FB8724A;
	Mon,  2 Oct 2023 03:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NVizGSdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1DA38726A; Mon,  2 Oct 2023 03:19:47 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820A98747B
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a2379a8b69so33788227b3.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209553; x=1696814353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/v9C6d7Tp5RlKlanoLICKpl7djw/itMbBAcj9ElYt8k=;
 b=NVizGSdz4cQxiilIQwO9dygcxYu23OD/5ocAOSBnMbEWUW4ecY/gHRPI/tC7R1c4XV
 rgD/hlqN9FX3NQM+ubpK85EZC+eowqnDP4Vipx8XZ7N4ia6Wn3kBHhu4e4q9sbpxHB5a
 AykiyyI0kSd0NK8sbcsf9MYlNH3Rhz2Qly4M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209553; x=1696814353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/v9C6d7Tp5RlKlanoLICKpl7djw/itMbBAcj9ElYt8k=;
 b=kEevhCeIuX2K9dxqzYC0JN2qoPRyrvFtzWL/zRoMiGvPrDiEq9xocBFr6lAdftoGFg
 c6fiM2Mzo25mUOi/airIxg/slCbu9M7/JfJTdmDi161m1V4ODIPAoXRRpYXiZCXNGzAa
 2scxYt3EiHKknWUCsAjtmoKJCuE4L1F1mYRrTYeiTurhWr7hiKiCttVHs561zLNtqlkj
 9eMfH2PobKM35GbelOr+PzTA43Za0Z/EX5uAdWhh5H9sTw0cTo2B/YZEbamDf5pCT13n
 FfBqYo5vCIEmA1H6I3mYRHzaefELyvpDrOng+KB7V0xD5qK8arLCS3bgf3O1LL24c+Pv
 H4wQ==
X-Gm-Message-State: AOJu0YyD4b5OnFUm4URR+iw6RjpaPn2uc+CS2BmRLWJ2XXftOinFxgYi
 7tAol3umwVGWAY3fED5sxD2xQ+Xr8QORTwlOfMU6OsnqnF+pykh3B4Y=
X-Google-Smtp-Source: AGHT+IHQNH+AfJKt6pc+xz35IxBGc+44lolvEm+LQ3GWyHfsID6kypvUxF3a0XWRGAdGMC7++gOMhhnLlhVKccZ79YE=
X-Received: by 2002:a81:9190:0:b0:59b:e666:1fb4 with SMTP id
 i138-20020a819190000000b0059be6661fb4mr11127004ywg.9.1696209552806; Sun, 01
 Oct 2023 18:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-12-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-12-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:02 -0600
Message-ID: <CAPnjgZ2gqf3dNZNxuXRkuKDqmidEU6DkxJuOS3ZuwA+DTMBm+Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] dm: blk: Rename get_desc() and make it externally
 visible
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Suchanek <msuchanek@suse.de>, 
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, 26 Sept 2023 at 02:56, Bin Meng <bmeng@tinylab.org> wrote:
>
> get_desc() can be useful outside blk-uclass.c. Let's change it to
> an API and make it externally visible.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/block/blk-uclass.c | 26 ++++++++------------------
>  include/blk.h              | 12 ++++++++++++
>  2 files changed, 20 insertions(+), 18 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
