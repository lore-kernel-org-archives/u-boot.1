Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B692DCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 472C183BC8;
	Mon, 11 May 2026 15:29:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DddV+HWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4883A83C51; Mon, 11 May 2026 15:29:51 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4211B80398
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-678adefbd26so7988339a12.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506189; cv=none;
 d=google.com; s=arc-20240605;
 b=kU2rULOkEtB1MmniqhZyHfoUJ3LaL3MI6ygCxqhoTv+quVCZDiZyJeMVJgZPdJ4ry5
 NInff7g8lSVOjXrlpIToht/j5xgVRXhIwEnxNqSzZKaKssTAZ3MEOFzfvpEiOM/D5HpA
 T3MfawwgcnI70991KSls8v4kSwj1PMp/iJRIJKLevxWozf2o617QL4MQ81Jp6TutZu8M
 O3rViMjtk4EiqR0S7grQ+7rcDSmqfqeNkFpLeKLD4UBQwV6E9wt1P6v9jc2Rhq0bOQsR
 xH8EVMDjw11k2XwaTwomDAEjx95Nop6vXr4QB4c9DSF3SG7xnjipVWxRMZFcyUL7TUhw
 0LPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZSkMG4M5i27HgcYyJrQ+8+E3/R0rhjSBvpCE7CTYyF8=;
 fh=L35BJGl1eOCTAl0X8L2OQ78gjsGwLgv72NZeh8dCP+M=;
 b=d5RnABtMfb+t7MzMsSldYboTn6tI5qXj0pb+pyMvoAVf0NyAmAHPWFhEm0GNW3QeRn
 YxWEFWoenwh8SChEAFIW2LGQ3xlsNuJMBtd1LoHo2Sy31KFyxIX14MdCGp73m0r4tNaO
 XEyJWJIwrZwilGO0j7A7HphsZSgQJGZTdrgKBr8weutmhyCnbAOuYOmi5tt4Y7wVgUTD
 QRU6jlEu5j00jOQAExdZCeHfUfeyYYugSziz7a1tB8qnATyPExsDrz37FGNo331BBA1l
 sgfeF7kXdKjH43esYpodQZulwMNyBTosLbxEEdr8sMoV2loVibWK6keOt2XgkkzLDQyJ
 jYtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778506189; x=1779110989; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSkMG4M5i27HgcYyJrQ+8+E3/R0rhjSBvpCE7CTYyF8=;
 b=DddV+HWNisBFf0w7Q4pX+jsfmCV+HNcRTAN34ja6R15ogxUbOOYKwgIgC4/H2OPRRM
 8KlMSRInw21wJICMc8yHAsAtww7c0qdyef2c9vQ+hQ9+utVilEzlknGrG5FuEswAxaai
 04KkyVihlrluZBqYQbxihD6mqYeCTdqqQ2BQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778506189; x=1779110989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSkMG4M5i27HgcYyJrQ+8+E3/R0rhjSBvpCE7CTYyF8=;
 b=FyhbfbWdhSEv7QHh46T/XhGQIwDMz52VvQt7fOkuJeD1f26RA1E3GhsJG2ytjWh0sT
 /jJ3VLknOxkjwCxCe+BDByeMFQ+Mb7E3Q/Rs+2TS7fsMSmMjdfOBpDZYPrHLyTWuO/iE
 ne8XUt1OagdA8AYyFxylECfoXMYv/S0kzdXsqz43dpL7oubmWzo/ArFsqM6P7VwYCEqc
 sgNHqFZcX3V21oZNDoWNEVoJtCDWft79dHPgoDH16+jVTYd/9UEaJnSLqbNfSrpMW1sA
 RLoIBEUQ+lcKaHyEItOYb4j96z2tAJvwHbPtDcnHxxiNQ+PORGuPyRGLDx/FBXosP3In
 LpsQ==
X-Gm-Message-State: AOJu0YzLD0XWQzorqOVJr0wKMOHrgm/vVq+sbcXduvrlGM69Gl6ArvDp
 NDwnotaqSHq3NNDmzfpF6IdOE2cxaMfhdtLOzuMYWIv6PRM7r5dTYqvmu5UlY9VIwdfncaq9pjE
 9Q06d7zR8ScLFIqu5uF9YmGP0v85MCBvh+cGtVoVy
X-Gm-Gg: Acq92OHZfBRzg8FoGgGUbIGgTwIV1QHr+X6tocdleWK3KQcedeK7ffZpZQosgZRb3pI
 hJnVk6IJvorM3C4vAknPbB56Xh/0utWdYc1vFYYKyXYNbKuczTA2J20eyozD3pEO9dNI+QNI81R
 ueun4l9xcjfKsHNlxy8RYtwHLD8i3wRx2wvVHxnlGAU01r1hRlJqxRl29OKyeFe5/KrwQtJi3wn
 haTsYeCqDPaX8VHwg7rhF/LrUo6p9axOAI0WoBSNTWDh53uAzk/vOBHjN75u05ATMxMFwWqSTis
 3LEiTw==
X-Received: by 2002:a17:906:478e:b0:ba5:885d:3280 with SMTP id
 a640c23a62f3a-bcaaa54ff6dmr783757166b.17.1778506188569; Mon, 11 May 2026
 06:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-2-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-2-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:29:36 -0600
X-Gm-Features: AVHnY4JyM6aiEoit63ObPAE6IiFig084N-EezsRsJwHlfFOYCN2Xj_q7tQEsMP8
Message-ID: <CAFLszTjfq8g1xU=FTtsdLRwXC5nojbq+YwnwEcLcYaTRvd_vBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] cmd: date: validate date using rtc_month_days()
To: Alexander.Feilke@ew.tq-group.com
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>
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

Hi Markus,

On 2026-05-11T12:09:09, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> cmd: date: validate date using rtc_month_days()
>
> The old check accepted day 0 as well as Feb 29th in non-leap years.
> With this change, both day and month 0 are rejected, and the local day limit
> logic is now handled by rtc_month_days(), which correctly accounts for month
> length and leap years.
>
> Because of this, special attention must be taken in the 'MMDDhhmm' format case,
> as tm_year is not initialized. The leap-year calculation in rtc_month_days()
> therefore depends on the value provided by the caller. This is pre-existing
> behaviour, but is now made more explicit.
>
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> cmd/date.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

> diff --git a/cmd/date.c b/cmd/date.c
> @@ -167,12 +167,13 @@ int mk_date (const char *datestr, struct rtc_time *tmp)
>               /* fall thru */
>       case 12:                /* MMDDhhmmCCYY */
>               if (cnvrt2 (datestr+0, &val) ||
> -                 val > 12) {
> +                 val > 12 || val < 1) {
>                       break;
>               }
>               tmp->tm_mon  = val;
> -             if (cnvrt2 (datestr+2, &val) ||
> -                 val > ((tmp->tm_mon==2) ? 29 : 31)) {
> +             if (cnvrt2(datestr+2, &val) ||
> +                 val < 1 ||
> +                 val > rtc_month_days(tmp->tm_mon - 1, tmp->tm_year)) {
>                       break;
>               }
>               tmp->tm_mday = val;


The commit message says tm_year is not initialised in the MMDDhhmm
case, but do_date() calls dm_rtc_get() into the same struct before
mk_date(), so tm_year holds the current RTC year on entry. That is
what makes the leap-year check work. You could rephrase to something
like 'tm_year is not set by mk_date() in this path, so the leap-year
check relies on the caller having pre-populated it (do_date() does,
via dm_rtc_get())'.

I wonder if mk_date() could be static?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
