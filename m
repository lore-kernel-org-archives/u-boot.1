Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE1D6AAE9
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0940840ED;
	Thu,  2 Apr 2026 18:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZRqrg3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4148840F5; Thu,  2 Apr 2026 18:14:37 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD4D7840BE
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so140824266b.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775146475; cv=none;
 d=google.com; s=arc-20240605;
 b=gmeuAfiFY1w0vZOCFCGKxgvahzrNXGzK+WGsNN26Zx4zetN+iag8NzOmKpMTCbWwqd
 Km+Pbge0IL0hveyTiHd8XW9JYqcoiOhZOkanBDVUVjUab9a6IUYBxUvWi/49R7BrIlMK
 bZTTITmRm15RM94RkJP1xkcvavdyzvGoqaaE40bER4touNUugQKiOy3aczGMMVYlrOCQ
 jZNPWfeE9h1IdG2Do0BKR9dM0U76JyYnWeuZXgbpa4GYW6njEF4sT2IP7hPa2984flgp
 Ynidglh3DN8lRXG8L4P3uFuhLv9HPWQy36UfrkCABzNsy0TXF558P6RiemcKCYuW85Wt
 42NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7mm58UXdXBDptkp91KDPy2aOgqRdySaJnNzLeIoyBMc=;
 fh=RnB5lhiZ2zWwUKd56qUm2o6d636ryv0VxB/lSwXL6qU=;
 b=MKmPikJq9x37vi7lhvh2xGEqNth0M6jG/ELTZ4QYxMKuK29c7ftODNdtkJ73hWZY61
 gdZ62iMWP6ZOy67/ioAPOq0WUVez/lpGmZdCej68NXbRNsPmyiX9bhRz28qvTGbucYvI
 yKauVWaT44kAjVuElt9qVwqZpbizaDtXaJSDxbnMi6u/vp3rTmYnBdGEJve8TDFkfCqG
 WJjOXe4CasSr5GYfRusT+r/raB5idJsqFqh95l0hASrFzKtAtJbX0lBtgY9S/W04BGzV
 rFHML/1yKQQBjvPtROLTMvos0dvMVib3cQucN2d8VQTK7sb7aJsZfr86HSJTbeZL+/r+
 hdUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775146475; x=1775751275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7mm58UXdXBDptkp91KDPy2aOgqRdySaJnNzLeIoyBMc=;
 b=lZRqrg3i3DaNjVJeL3M/ep3iW5WyIrTj1NxxJsGLgJLp1WeVJ+4a7kRoW/X5taNvX0
 VPuau7JX9LLIzYgEAhGmAOmCzfTvqhIrN/9Y6zntBMykl6uR0EPmlTvYnjho3jCGFjEl
 fHsuyeyVhTlv1e+q1Q1rinFcYA4F8M08+Nuh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775146475; x=1775751275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7mm58UXdXBDptkp91KDPy2aOgqRdySaJnNzLeIoyBMc=;
 b=boMOUFreMBTO/gbae/kH3wuXdX21b3vL7PTRvVgHEmTDqYa5cUMnT/dryGDgye5fHn
 iD5UrRxo9is0okZ/L671B0gNtribL0tdhv1fHmzunolwNMuMRuHg6m5O9s2qeIUuBEnc
 FWxgLHfMFIifUOznj/rURlZ1UmHRTkBClPNYAAh0LfaF/j1ZzIH1AD/MEtdrL+/Og2+P
 JE0C/3juaw9DXg6EL+83bOPOSLK7S56xBG97LSjVopfW6f1qMjCuWxo1T2D4VU4TDX9N
 0GBi+iKORWAcpsMXFNlwU8C5dieWMHpgid9OnyN95lOPZjUTE7CSX3AVZLHvQGz+MifY
 bCGg==
X-Gm-Message-State: AOJu0YyVSIrjYFMaSl28Yg/UaRGrdSg4Xm5Xmhsd/PDJMBTPSWixK3h5
 OJMNUrhIUAnFfAtwYfPQGS5xr5hD1NbOxvO44gYVjxKSkpfb9RUA50oE3cGXz7t76boQT+UwitK
 ffO8kA8USvQXUXpwVqtplwTJN2OvIqVJLNzXF2hKX
X-Gm-Gg: AeBDiesR/jtz640AkCslq0eUhlAAg8Jo0ADnVo3g5glXGM7A5C2eOSpd6AgtsE7DeV+
 Ke3E55vpVQn+h2bOeLkT7nGCK5jnT/Si+XX0/N5yqGsv/euxVro/eQxuVWQ9lE/JzIznoknewkT
 Xsk6i9K8wJvlNhPH/WY0xEG1H8HOXp2SOKTGyNCWO1tfiave3nKuC8/f5Z4TKBBIV5AORYAywZr
 1jMSbnqDmKO7kEWsLB/uv9jE2jYdA4nLFrrRH+anCQjAqCniCpK3KWAtcR4XzFw/7orv1L6OB5w
 shDBFA==
X-Received: by 2002:a17:906:9a92:b0:b88:6164:6421 with SMTP id
 a640c23a62f3a-b9c13903483mr443736166b.16.1775146475099; Thu, 02 Apr 2026
 09:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775144215.git.michal.simek@amd.com>
 <950bf29f73f44e8edc6b22cb7ea2d9a56cfe2872.1775144215.git.michal.simek@amd.com>
In-Reply-To: <950bf29f73f44e8edc6b22cb7ea2d9a56cfe2872.1775144215.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 10:14:21 -0600
X-Gm-Features: AQROBzAxhmn2XUb2jt1rpmykwONYw10P04BAxSjF4ey3DU-RbHKpHAtCprClogU
Message-ID: <CAFLszTjgO=HjfW_vy+yENZCUxfg-oVqPJDWD7TFXDD+LAX+PFw@mail.gmail.com>
Subject: Re: [v4,3/3] fwu: Move boottime checks to EVT_POST_PREBOOT
To: michal.simek@amd.com
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org
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

On 2026-04-02T15:36:57, Michal Simek <michal.simek@amd.com> wrote:
> fwu: Move boottime checks to EVT_POST_PREBOOT
> fwu: Move boottime checks to EVT_POST_PREBOOT
>
> Switch fwu_boottime_checks() from EVT_MAIN_LOOP to EVT_POST_PREBOOT
> because there is no reason to call FWU so early. FWU triggers EFI
> stack initialization before all devices are visible which prevents
> the EFI stack from scanning these devices and adding them to EFI
> variables.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
>
> lib/fwu_updates/fwu.c | 2 +-
>  test/dm/fwu_mdata.c   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
