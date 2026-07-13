Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7820CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DF584C45;
	Mon, 13 Jul 2026 16:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eUsODT6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29ECC84C46; Mon, 13 Jul 2026 16:25:52 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBB484C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69c5eb6dfd3so3348381a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952750; cv=none;
 d=google.com; s=arc-20260327;
 b=bQWliBgk8xTgrN3yzeSvYVozFZXY4ThLr/cAgLajC5gZqKgDTVJrIlxRutLPWSBBl8
 wUPPqRE64JGnmtVGcWtRnqvTWxidPU2guAhrKP2WFwq/yGbfMgd7q2d+jkrht9dqO78N
 Depvzfwshrpukod2jVFNlzAZ7k8ZsAAAFKQGxVnZxvBbhG/nioUBXEJp3Uf6zcXwdHJ9
 OslQG+1owb6M5DVrhzNBaYMVIZG7r7gIJ5NZpJFSib1kPsxW0SMCb1klCWz9v64LVRhn
 sGeeb4CmDM3nPcrkYRbDYjEnqsRxdEeUm3Vz/VaKlQPAjtzcKC8WuUB6TYfbCC5fae4G
 OVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BAwxHVBYprHSK4g+EUVWyWetXL15D8hr7bTrJlnODoU=;
 fh=DhZET7cDUzI6QRLVUqbfPCahw4i9orid+jUJ7a5f+R0=;
 b=J/OJ0D/cLiWtfSw1Z1V6o4dGgpRmwmP+87hKrkWsPavv041Gp9U50dPeieRe//t9z+
 ltlU97svFEAcem1IWuCEAtY4PQ/wRu4+x0gjF2WuC5016gYIHLkldYoP+PfYlHqqlkVP
 Z02YG3zojttmAQiloZJI8ecvIpyXCH6j4Dno+nCFt1tVSP0xQWilLAs0aFwzaXNC+TZc
 CBPFVI06KH3sONoZxsK3kiwnf4nIAx1gdrctAqYlG7GzfkTKhN2nvu2366wpEbjeQ+17
 q2rEyG0D8Uljc+Oxy1XcjWq/9bH2A5ZJBHuT8yg+zniAn5h17nkYfMY7dw61e3Qwa6rQ
 ol3Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952750; x=1784557550; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BAwxHVBYprHSK4g+EUVWyWetXL15D8hr7bTrJlnODoU=;
 b=eUsODT6YkRwKV+RvmNP/iQ+2Osr2g+SrqLdJmvE2f1jA+dL6ccJD4TltxLtg09X/Qi
 6ESLnH6U6ArKsQZEGUexrU75ppj8W/+nB74pVurpU2LZS6LqdEBkDGkWYhwbFUDKV8Sv
 sjZBkof89R5yxEYIjRK6nGAcy3L2vMlbDnKRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952750; x=1784557550;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BAwxHVBYprHSK4g+EUVWyWetXL15D8hr7bTrJlnODoU=;
 b=p03rrssaZJq4CDCq1MY9oJO+L/a1Nyz0kIcYutf3qv3U6dyUtVZpa8PSOtHaJWoQWN
 oy+mNNFBZ6HmC2RQjaUW5Hgqvi2BH2F8dICz23ztcYh1PHOCieDfYVviKcA8L18s1ssy
 59VIHVKimDNzG09y+KzRSAmXwJcqNc/SPXGgjFgpNJDKw17aU4t8k6DiRlYYLRePIvqK
 M7L/TTKv25iyI3yJ3VS6gkGZ6Vf2TUbykjSdOzlggUO9aBuStBVOXG3cuOKmPd6JS28/
 XMOY/qGFma2yo9zFqRf71XyOtHeWoZqz1fvv8Wb8y+7At7HzjYp7HY67c5G46gaIhQgv
 zcwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqI3fmJjC4Ybj7q2/bNjiRwzuu9iEY5re0vaJXkMqes51GJ2Ep7gAc8NngQx5s8W5twYmED+Ic=@lists.denx.de
X-Gm-Message-State: AOJu0YxuSqXNcz7atk9Fq6EhyxS4qHCHRmZ8f2dwl3xBveL6vWF0zHib
 8e1qnDkDVCGuQFtd6unljdtYxuMx9+B56RmtRDaePFnwsKqEM7alsff4V3d8alTrbaOTorZFiGh
 XXx7qQ+FpBvUcAj4vYql/BCrL5oP+28zF5TIZE3A7
X-Gm-Gg: AfdE7cmOco9iTNNGJbY2djJBKReLHMQ+UDD2V7az13Q61yEaScgsEJ5Z4O5A0f7DuEa
 7lU5Lw4Tq7Eu8vgo62bc8V2wIOoRy1WuklneWktMYz3O1DSSA/ROkRr08gBIM9iSdA5ijGinMkD
 GY9wRWfiwwTWhexH3Zc4AxQhgBOB3cOBBSIeRioSEKRI39ALCP07/5CRnWaHpNvCe9kgbEYRk4g
 bSQj1ld/cZVFhu0CDcOaBKm+QkQxsK/+NX3CIkj9akvorh4BDX0RuJ0Xhig78UIm9RIA5U=
X-Received: by 2002:a05:6402:3224:b0:698:3b7c:7e45 with SMTP id
 4fb4d7f45d1cf-69c5f37fa8cmr4131742a12.37.1783952749759; Mon, 13 Jul 2026
 07:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-8-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-8-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:25:32 -0600
X-Gm-Features: AUfX_myt-9M2RQHcTbm1_7VhgirjgsS3wUiOyBD8Pl9YqqKoerT_mZvd8-jZ5-U
Message-ID: <CAFLszTjykFMU-3b16NcLJ8bXsXpOnFwE1WbKe8p4Rjin06mxTg@mail.gmail.com>
Subject: Re: [PATCH 07/11] Kconfig: Depend on correct xPL symbol
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> Kconfig: Depend on correct xPL symbol
>
> Change to depend on correct xPL symbol instead of a xPL symbol intended
> for a different phase to make affected symbols available for correct
> phase.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> arch/Kconfig         | 2 +-
>  common/spl/Kconfig   | 2 +-
>  drivers/core/Kconfig | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
