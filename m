Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3277DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 06:09:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A76187E3F;
	Thu, 16 May 2024 08:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EpM+xo4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B4187F19; Thu, 16 May 2024 08:09:20 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C2B83339
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 08:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dc6cbe1ac75so5842240276.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715839757; x=1716444557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Du6eDknbufrcX2u7rsU+KNKue/0Di1nz6YEN2LYv7dI=;
 b=EpM+xo4Q3OuLB328zhxgPD8mSEub07Y/U2qSOkKW3i9r9STrDJMaYGN/Dc+NF5FGFd
 g77eHXpQZKDGFor3WUZTHoN2FXLprGTCXwSiuYr4tuRiFJ26pC9bdrDroHqz1I63Z+yK
 VTVR/2SS8Ysm78cAMEdn4JwhCkebpbLutuKgAce+/o5SN4pUYUwxI3UHzXrW+NIR8/V7
 BuCXT1iFKW377q96eYkgKXlms9wg1+aXRUTkf8E0pp2o2xEm78rZrzroJ/nMXuXVybT9
 B8xyQVmzAUPPtRtyjuSrOM1jBb9X5afsH0RNPvl29aEzhEhmv8+dTZMdOp24EcfowOVG
 GrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715839757; x=1716444557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Du6eDknbufrcX2u7rsU+KNKue/0Di1nz6YEN2LYv7dI=;
 b=jv+I1jcmDa7j9dAZT/eYFoR6jY2XXo26f68Qzekzmt7DBQoaUtGXYCzXttT3+8vQ8S
 Nj0O9hd0ZvMUjXnSulJVnvW+wBQdP9C/ZovCbM9GVVU3rCEye5FQ4rzqFYWUP7WwF/nq
 QhYxXv9sUbsIb7YSWUbgnnVLKFaBVkT0bM6f7G/JKfolqmz414RIO8/C2Vfj0hDfajlN
 9YvfRqZCQtTxQWu3XFlokmGvSIHYsPTJ6NjxyP6WMZWNJHDCh4A6qN7GNmEObjJXSeHL
 JnOyhSvnC3pQFiceHVOOD/1F0eOj7yy3XL4W6dPlDR68YQqjsj/8sDdMg3ztmPiBPo+3
 jWyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAm2gdAkh5TQyBUUkYmiJdV9IlUiMwjHeUMGyYsF90xRiuFcivcQSrmQMJBtNnDfo4pknyPK1w3x5gHBEomVH+ThJwhg==
X-Gm-Message-State: AOJu0YwRGZvA//AIQafumqw8kvea0i6vbIlmxQMUHOMAQzCx/KR4sA0W
 0/HbFWYaKP0t7XKcpinSjSG05pfGygppXCkWxP9KLqigU/oDAHtgIPwCSK2ht4x4LOCOyd82dZI
 yJU1SQohKfgabGhrusIEUYOjo6C/miFeaD67LUTS/DCO4kY5J
X-Google-Smtp-Source: AGHT+IFIqanmRLoI5Ld6cFjg8/JofdP6A3lRrndACeKLMKurXFxmVMqHChKuZSpgm3NyDd5ORStdcpQmDP4UAHmd/cU=
X-Received: by 2002:a25:ce0c:0:b0:df4:449d:e09f with SMTP id
 3f1490d57ef6-df4449de233mr1559262276.23.1715839756955; Wed, 15 May 2024
 23:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240514164236.516595-1-trini@konsulko.com>
 <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
 <CAFA6WYPsicMrtrDg7T8m=4-vg-QAPUY1D5E=_T8gZYgT=o2b4Q@mail.gmail.com>
 <e26ab5cc-2b2d-4e96-a073-819a935f435a@kwiboo.se>
 <20240515160009.GX2568172@bill-the-cat>
In-Reply-To: <20240515160009.GX2568172@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 16 May 2024 11:39:05 +0530
Message-ID: <CAFA6WYNBCgW0nwZsOvMLF6kObgQ3gowY9SEY5rQZ3NsccnqWkg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
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

On Wed, 15 May 2024 at 21:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 15, 2024 at 11:39:08AM +0200, Jonas Karlman wrote:
>
> [snip]
> > My main concern is how to best handle new boards and features/drivers.
> > E.g. for Rockchip the RK3588 SoC is under active development, new boards
> > and features/drivers are actively added/fixed in upstream Linux.
>
> To this question specifically, dts/update-dts-subtree.sh has a "pick"
> option and in some previous quick testing, it does what one would hope.
> So for this case you could pick the N commits that need to be brought
> it, the resulting patch would be small enough to send to the list
> normally (the resync patch for v6.9 is 2.7MB) and then when I do the
> next full resync it goes cleanly still.

That sounds like a good alternative although it was proposed for any
fixes to be incorporated but it's worth giving it a try for new
features too. I think as long as the cherry pick is clean with all
dependencies being picked up properly, the next sync should work
cleanly.

-Sumit

>
> --
> Tom
