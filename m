Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E84DCE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8778186BE8;
	Mon, 25 Sep 2023 15:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mxNkQigv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93ED86C48; Mon, 25 Sep 2023 15:11:13 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167C686BE8
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-530bc7c5bc3so7657796a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695647471; x=1696252271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tziDOx9UXNpeYRNkT8Ff3vWlx/hpiRH3pnE2gTDfitU=;
 b=mxNkQigvRgO9k/i+5xOv3oS6nhyVU1sqkAqjKRORgO4VZIq8fqznf6rfWLuddKievR
 W+rH1Wgb+8s3342RaHZiZXrRfQo7LRnK/iNyz8cBRSEbxZqxSOtvE+zpWSrWJIn2fms+
 Wh8aBQ7m00SsA9MRWykpP4Ap8EGrXBmWBXaz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647471; x=1696252271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tziDOx9UXNpeYRNkT8Ff3vWlx/hpiRH3pnE2gTDfitU=;
 b=NJuB5fLgepTytXCROYR5op0e7hkBL2s86Caz2bC0o67k/+OPZSYkRkxY5T1Xr5KtSx
 EZ4vcxfXaYF+Ov8rJyf+g2jQBClFDeQSuLr4ONb0kj7o94xUZUO/ONy1PxxAv537dUrK
 phuyNPq1XE7jF6pxwrh2+0LjkGh93ZNAlyTdFVZLK/BpE+I0TUe7tEV+/mbqBGQOBkGl
 cmbgUv4gZ5eVWFuW88yIn7ZBcB87lc9vR1yHQNNNxBK9D+MXw9E8P6W+AJuSWJn06BEN
 bp4KJU267aq3yw9jRCr+PFVxpHRKknMeML0NmSXiyKBsu7C+M7SxxeP2+nugj6j7Jdg9
 fDKA==
X-Gm-Message-State: AOJu0YyDOIZs+Xz3oSnqiksdqlOrehgqTeaOndWZEi/JsMbWG+rtukdb
 caV6qjNc++fV9qzaB5FRxkLn8oF8AvNVceWb5BJXFy4B22o9l/by/+k=
X-Google-Smtp-Source: AGHT+IGocKB2ClfpyAGifbhmxp1X6TeJ6SOf3DPTWxIZV8OgR52qGR7g5s24YFGwL4mq3hEBfPX2tmaRkU6vrK5B3Ms=
X-Received: by 2002:a05:6402:1342:b0:523:bfec:4913 with SMTP id
 y2-20020a056402134200b00523bfec4913mr5490325edw.0.1695647471339; Mon, 25 Sep
 2023 06:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230925110101.376878-1-rasmus.villemoes@prevas.dk>
 <20230925110101.376878-2-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230925110101.376878-2-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 07:10:52 -0600
Message-ID: <CAPnjgZ2AL9twQpXGG38DKRBaL4ycdgq-sCpRQJQ8h0-dg9ksHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: serial-uclass.c: move definition of
 _serial_flush up a bit
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Michal Suchanek <msuchanek@suse.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
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

On Mon, 25 Sept 2023 at 05:01, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Preparation for next patch.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  drivers/serial/serial-uclass.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
