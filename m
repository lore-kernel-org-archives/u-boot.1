Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BABFF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25165846E1;
	Tue,  5 May 2026 07:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RwR4ioM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9EEE846E7; Tue,  5 May 2026 07:46:05 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5B084683
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-651b4d09141so5901732d50.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959962; cv=none;
 d=google.com; s=arc-20240605;
 b=HO+u6vxGkB5dnAoZ9crFQbAZHn2g1N1MokO2CUnDVWJ33SDZ77AsREy1S/yeb5OKte
 vPB0IMo6yI1taamO6efuqIK6NT8X8w2vRc0t0K0BwUmrKkUyOeDRordIxyYYqQPnfjYw
 UfkhuM3IcUOypvU/pFTjkPDh8zXImS6RKCA/xANjRO4aygaJf14fiOILNvQjUGYJ1ZLB
 8jcG+ohJ4d5X/tdlWLDDRpOyO7Ky5lvEnnCj/CIQ6O1JhnMao9gqVAR+tHPSNytxfo9d
 LP6+/8ho+zhlYl5wi8noxL4HLvUQvmtYyfPQm9M/vGTctroYUcVO1r4OWGaQQ86wIXYL
 ao9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QVbogTdVBBdqauQ3b0M3y8KtDcxrGHKcaGwLBqsf8iM=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=RPMAPFgCA/WGugwh31UZPmFhiA8erLZLYpfwDq74EDpkmvUuLIU1aHrCmm3rAIY7Li
 4V0sEVxij2H43F89byrX11OLK7WL8l535Z47p3/zYo/g/ZxpU0lYJMzM3wBU/gSb2NJa
 g2Cr/PoB0ePK3MOuUZOeB0EHpeY24Ia0APMj5Hykq6T756RU0KIjQcT0U5S6Q0dA/S6g
 XGcg3i2N4thg1YDFJ48kkKrwQn9lXRX7kUrPe0rwZhwWGDk92F8KA3VhL7X8SZ4NnNVm
 USUeQ8HGqFxR5B6f5jzOgrIuUnAMmcNxD2A40d+CGDjxSMZ+uqzIIFwGvtLu4K/JBLnA
 WfgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959962; x=1778564762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QVbogTdVBBdqauQ3b0M3y8KtDcxrGHKcaGwLBqsf8iM=;
 b=RwR4ioM3wlxmM47sxo1S2wXM2ocPzQUQylFgW3AnQd7ch+YpIZV54IdwVpeCFEKnrH
 CCB2cwHRda/30l5zdQpk5rG5F+XDUBCAnM3RN+KpFwV+MFNmmti9U+Z8ilbNyol0Q7Lw
 uxXSgzke3uWYcg/Gsxf905xJJXnOssV+Itqb86yhxyiYkCU4+PiEILuVRwJiqi4I8fHO
 Fthai0ENTXDKRBZcwdVjxybIqvgF0yU+6Lva0vpwxvrgbj2InrK4zLSaDTGOKdAEPI6p
 HHMrJTAb1bjCJE4O4ATgApN1bgR+16UtBVUS56e53WDp4M0ed6KdP3y6Qn4jcjbcbsYW
 rxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959962; x=1778564762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVbogTdVBBdqauQ3b0M3y8KtDcxrGHKcaGwLBqsf8iM=;
 b=qBGTN9uy4+cFeX5oQSSfjcg4pB9sngf+PzKIEpueH3rvKbIQRHYEAp2ZzVI49SBF4q
 HAbFB+SnpKec5G35s1eueIRLrn0MMZeVYjQ7dDFGbIzn6HHaP0PX7uV04zP72BlyhCpH
 LY+mwPGUCVSMWvG3EnwZlIJkKCKKNdgM2N+xj59044p693wpzu4cSTpmkFDl9+zuMYWn
 eUUNnV+F4VOCdjW2OLea6BISq17PgP8c2+7XaYZcZMDw2NzjzyBVJy3wvrapQJQKjlEn
 sxvLCo0cB4CARm5Fzov1DFZUTo8shR2amH3YnM5iUaayu4q3Y+oPbfKwxpmcAslT1cyM
 oXjQ==
X-Gm-Message-State: AOJu0YzuPiF+Q1aWO85WSNtLlW2xZPQ/j1v/Y6HDOP0CSIlIWXvo8mw+
 f+vCuqHSOnSRa7249HJGIKDPKfAPXEKRM4tIUy0Z0kdxco2xZ+NGfdeFerxA4OJlShVSxdYTkGu
 3GEf5CGfOEe0EBnsLXtA/rmvIlGrKEitSFOgSxeElpA==
X-Gm-Gg: AeBDieu5944KPFr8qSsPtNeg7wS6dO17ACcJtDBD2Fg41w8lTxmYRABJFAcjqBgpY19
 q5heJfY0JgEHI/DMV14pH0ZdpU/QexMmf0w5jSx6TSj6Z2hob8ZVDxdvzUWZpr522kt0kXYhmdM
 n+binOSWJL3L9m936nD8y3Jvy6xM22kOMZfKNkyriZBPtCRLEx6zomoyAQX/27k5Vm63jNZhKXE
 0E+TTfYjhTTlIMptNhcYqI0KeCIkYT2yBk7FTaqSJX4IaSG0nPz/rswD2odlR0UWuG9OhCZh6yJ
 MyKxqOJz8v7Y0povPQn7J5CAgqXh5ldSxuFi0qEfVrBjZgR5k3viEg8JunV5nJKbONuImsUycWc
 vz1BW6dh8ZfxsRGJux4dQbLx1F4vbKzDwc2hvXFwuaaE+H+wC/N4lHUPTQBygrOPVAy2ndBxREH
 1lwtyi0lr+Rd8/Aw8b5ED1GRD2JpritPMBDC+303AuSOaG8/HEXjVtUD6XDGgd5ygcReSvp6Bqq
 Ojir41EnDrBPidxEzwj+AZ96mdoJtFpQ1XaaO8SccSwTnX50+ZWicWrYyh+iRAYWOVFBWl9d9ci
 uHldpyfUwfF3zadyoiNAhQdqvM4AVZM2UAl0PnlHy7Z0OAGq5arRFNOJi1EmbvDtwWNBbE9ruUI
 wUOzTXLNuhRtkpacgTXgYRqkUrOg=
X-Received: by 2002:a05:690e:1189:b0:656:a9d2:9155 with SMTP id
 956f58d0204a3-65c680ffcfbmr2061483d50.44.1777959962496; Mon, 04 May 2026
 22:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-11-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-11-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:45:26 +0300
X-Gm-Features: AVHnY4I82bq3TI9ii1QGkrXTEyYalWX3zBn8PoMcNcPk_9p5dVnP2oqRciMa8sI
Message-ID: <CAC_iWjJ=VwHRkF5W59kGSes0myYWtFCG7YQKVVyUOUMKFx2whg@mail.gmail.com>
Subject: Re: [PATCH RFC next 11/18] kbuild: unify W=e and CONFIG_WERROR
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit e7a10929c574cf30981a8e19ef39bc35e63e8b46 ]
>
> Original commit log:
>
>   The two mechanisms have the same effect, unify their implementation.
>
>   Also avoid spurious rebuilds when switching between the two.
>
> [git conflict trying to remove the KBUILD_CPPFLAGS for CONFIG_WERROR,
>  because U-Boot didn't have it before, due to missing backport for
>  e88ca24319e4 ("kbuild: consolidate warning flags in
>  scripts/Makefile.extrawarn") which we won't backport for now due to too
>  many conflicts]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  scripts/Makefile.extrawarn | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 65954320e0f..b5b1a762cdc 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -99,9 +99,9 @@ KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
>  endif
>
>  #
> -# W=e - error out on warnings
> +# W=e and CONFIG_WERROR - error out on warnings
>  #
> -ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
> +ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
>
>  KBUILD_CPPFLAGS                += -Werror
>
>
> --
> 2.54.0
>
