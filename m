Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFFEC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:43:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CAD6878DE;
	Wed, 13 Dec 2023 21:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wq+WlSHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 276528789A; Wed, 13 Dec 2023 21:39:26 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D9487889
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c9f7fe6623so93478501fa.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499963; x=1703104763; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RBySf3WqvdBd83eqJ6jpEVr/0rPC2z5hO6idair47jY=;
 b=Wq+WlSHqthwZiLSa0261CoCL4NGs7z4UWlD/iSeFA4b1WQOVFDufeGdd0EIdkJIgrn
 zy0p7sANxB3GON1KgX29FwuT2pPmKXkq7PNeb7u3UTV1ldvVEKfW0gQ7bMgtFDUA5H6a
 uQfHGtfN9kBZEfKpJ2lIfy4+cepUdvNlNCqUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499963; x=1703104763;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RBySf3WqvdBd83eqJ6jpEVr/0rPC2z5hO6idair47jY=;
 b=inOc2PbUh/BcZKQKvlsvkYIJRJhWF0LCMskYnFbA3AFaANthoxeHqftfxub8EBDvpF
 OU5raFxBgeKJKUlq1dqwsLObWgfI+7oKVLNDjQAEEgGVKxDnn3j5046Civb9oV/wexJy
 YV3us1OiuxAEhAeORzMz42KBLvdmv26st8nRKty8lO2n+EYoXg/P7KkFoTnq6faZYFx4
 pdfLvBGHxJfLDGB/vGIt3vt8AikgHOYfci6NwR7D6uZZ5lLF1aDqCrdCDvss9msteBaa
 a1kMsHlt1ga+sSmhmGljLyoEHfAhN1jyA7CBboaOXKBpg3SqsEaSFKKpWj1MO2oi/14C
 +ecQ==
X-Gm-Message-State: AOJu0YyrOtJj6OtVOBeKQI/FFX0q3S2dsn/gvdDSCEqjaiRIFE0fbPQZ
 mb8uB81umeoYBAwkyv9ZA3x9HmOFqyK1NuRZNso6og==
X-Google-Smtp-Source: AGHT+IFB3k3a5MBAmGyAhs/JJ9HFGbhDRyLd2SKM+EaSzK/21TxpZvG2g6A9yyyRPhu/VQxxsG83t8luk7YvUkOSG/8=
X-Received: by 2002:a05:6512:1081:b0:50e:ab1:452c with SMTP id
 j1-20020a056512108100b0050e0ab1452cmr1419490lfg.167.1702499963294; Wed, 13
 Dec 2023 12:39:23 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:21 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231112152754.130399-7-sjg@chromium.org>
References: <20231112152754.130399-7-sjg@chromium.org>
 <20231112152754.130399-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:21 -0800
X-Google-Sender-Auth: xzVnPaiQlIuehrz5-200kQO6b2o
Message-ID: <CAPnjgZ3WJvALOmQCy3Nqys2HHkUNuWL_V+exshLJYqjohJd84g@mail.gmail.com>
Subject: Re: [PATCH 6/7] fdt: Drop the confusing casts in lmb_free()
To: Simon Glass <sjg@chromium.org>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>, 
 Jerry Van Baren <vanbaren@cideas.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Safae Ouajih <souajih@baylibre.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Just use map_to_sysmem() instead of all the casting.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
