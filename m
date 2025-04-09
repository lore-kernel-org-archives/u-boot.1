Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5CCC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 13:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4398380E;
	Wed,  9 Apr 2025 15:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LKTX1FW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C101D83831; Wed,  9 Apr 2025 15:23:19 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE78A837F6
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 15:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso1391359a12.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744204996; x=1744809796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yWDQZcnDwZd/xPM74r0Vifo6poJ+gzIoAiqCPtaG1Ic=;
 b=LKTX1FW4nh8QwNwyaHC0FAzYmGW+1clDgYqZTmqgWLcYCwKjySUitoxnioxEt8O+wr
 vBoTLDAqzSvhEZ38bXl9LI+9b4ggZZBpSemExQeB6qWj2dqroa/0lJleTk6AZV8ssyPR
 LfuXmUiN/ri30Cfl4FS3ejZ1ABrYrKBkm9JFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204996; x=1744809796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yWDQZcnDwZd/xPM74r0Vifo6poJ+gzIoAiqCPtaG1Ic=;
 b=epDKG61F5rMkENXDAdwKxln4HmLINghSZ/lkJUaeMct77EOv0dh+GSMI19LzkaKEG8
 xw9DCSsvvMsPulgugpIaHiFOaRAPOP5H54wUYQpPPfOymBN/P+OqDY+OEbMct3pDANRF
 XwitotIPU/d1kx4O8kk+cLkY3bBCfmoRzrA4KXWLFhahvpdYb8Ppgvo+1I/Z0mnftsr8
 tL5jKyrOGyA/a6C0YPo3Fw/AFJUHG9ZEXuqSHeYeAlGLKaEm1hZ/E9+G2lLtlFSVgIsW
 fXYff9+h37Dl7Jaj3yz5+DOzJpARD67P150D8t2OHI8pzAgW3bgAGDZv2Ha7MmcozqDH
 ID2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXqvrRtIeKaCfcN6xfYQ9HdKndPX3uc37O3F+IUIQ9VMuc9fB7782XiwBgnmJAL62stUr69Xw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6kMIaykZ0wFxb6Dkakr9bNLH5xY+LY4KcHJqnM7efKN7qanPI
 gyP5o5Xr3k3OHRtFUKDTPTog4YRCUtac4T1qQ8tHRzfTlOiEdJhFqhaYZLsgWl3FZJStn8ItOl0
 IQHXb5XLJyc03I4mVRMVSd7A3tBrqiWihSwNr
X-Gm-Gg: ASbGnctxtxIykfNuRKAjSK/Fe/49HuCx1md43FknNw+A6xRvgXOD49MkHQ0WPI6R/9X
 NJEsv+BxCOX9mI+PzbCyxB4yNWHB3vS7PxRxoY+Vo/GcwfB0XRms1uaLD5i6YBxOV1Rz7jqWTcZ
 zzvGAChz6taZ1IcJoQnYwge38=
X-Google-Smtp-Source: AGHT+IF5DbhCWj4Hkmi5Cf0CIMAe45GM9q/mYOGMs9QrEPMkVngkeFkVBP5m0Ul/s9vO/BT4xU9flxe3byqB0e3eXso=
X-Received: by 2002:a17:907:2d88:b0:ac7:e4a6:20e4 with SMTP id
 a640c23a62f3a-aca9c0d8b65mr190360566b.19.1744204995972; Wed, 09 Apr 2025
 06:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-8-jonas@kwiboo.se>
 <6b940128-c5aa-4499-b62b-1a63613d91e7@cherry.de>
In-Reply-To: <6b940128-c5aa-4499-b62b-1a63613d91e7@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Apr 2025 07:23:00 -0600
X-Gm-Features: ATxdqUGB6ILvUpFgyJvGxB7RFR7lrDkCsnmhARtkRvhlf1-gGFBAFNPxqZK5oro
Message-ID: <CAFLszTiwwyXuEv10SJqtypbVs_POwS3+SyaDVQZ3o6ybYwU6zg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] rockchip: binman: Include a compatible string in
 each configuration
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
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

Hi Quentin,

On Wed, 9 Apr 2025 at 04:03, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Jonas, Simon,
>
> On 3/29/25 4:06 PM, Jonas Karlman wrote:
> > From: Simon Glass <sjg@chromium.org>
> >
> > Provide a compatible string in the config nodes that U-Boot can use to
> > help decide which configuration to use.
> >
>
> Can you tell us more about this?

See [1]

>
> I don't think mkimage -l/dumpimage -l actually provide that information
> and the docs are sparse as to what "so that things work correctly with
> FIT's configuration-matching algortihm." means.
>
> Looking a bit into tools/binman/ftest.py it seems like it's a way to
> expose the DT compatible property from within the first entry in `fdt`
> array property (a DTB) into the configuration node in the fit image.

Yes, the root compatible string is how we decide which devicetree to use.

>
> I think it'd make sense to update dumpimage/mkimage/etc... to dump that
> information as well?

Yes, I think that might be useful

>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Thanks!
> Quentin

[1] https://fitspec.osfw.foundation/#configuration-nodes
