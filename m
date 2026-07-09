Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9669C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 19:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7022284C25;
	Thu,  9 Jul 2026 21:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ktlW8WnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A1584C1B; Thu,  9 Jul 2026 21:15:33 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4194384C27
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 21:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-697de23bd7dso229542a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 12:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783624529; cv=none;
 d=google.com; s=arc-20260327;
 b=ZvmoBmUfa4FUpJgFbCA09vcrFc6MjH6hDEseZ9xRgpxtz1S667a8A+AfLDg+Y0mfEj
 Rsar1F8S5vZIrjaVFn2eIPvzuEknUiL+75PH3qxbzEsY6NH2TZdfN1XvDdbiWlfwbQK7
 bHCGyaaZOYom9mPG7UEN/MY5OiBajuX25YiXKQ/l6TnQlNzyBMZryAFlFzA5PgD1bOwh
 KK9i+I9FX7k7DXMvW/5/alpoLVM44fWPd/Ia4hSg1Ix/TaYuURGFHy1i/NtZ9YVnQcbb
 K8tEFVPjfDRkfAD/0vazBw6Q8yyoy2b+XC7mzOFTmmhHISpvqQJdtvOm6QMG27x66pT7
 VpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QYYRcm1SDT8iK7p94nRSp0osnP5uLl6vyG2s/iO1ff4=;
 fh=cX2a5uS3m9+hU+YaZez7ihgAHbtevX6/NcttqBcYz7Q=;
 b=H8fKIREgF/JsqY/JFkBYvItzXaCXtJssPyULnWgN7+/r0a0YsxH94Ezg5Ga4kKDe+x
 dvmxXcTyyr8V3kHim2wecFr3FYOlaBeHeBxMp03alTd0/gj9tGS5shoUNZ9d6Hq24gcJ
 zxeCxWUX7ex3X34EWCDkv0SwnH+BYoE8sDQASBF+x5VD2QqR2tXogY9SGjCZYTZE3xyT
 BTGkj1fdbpge8BsbvE6r/JKzGKZnyCsOpz0QeTtvvQSqthlWXbD5hzFEDoTdTU63oIwG
 iSsp+7hHYUxxlLMvsI5PJaeJE/FWHjZXMT/BiWXo/bxTZ75cvN5DHrHprJIZOUDXu3t0
 HxBw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783624529; x=1784229329; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QYYRcm1SDT8iK7p94nRSp0osnP5uLl6vyG2s/iO1ff4=;
 b=ktlW8WnD1fpAMvZ0GStur1UMtbDI1r9mtaWqSf/GvE/Z6ECMq0y2qvif7BNU9HUZV+
 3GQnY5/gt9COYDEocIRWOUD8B5DWxDAka8WMbwvs3Y9G+6kQ0jmmpNg2zDFbavwI2t3W
 FY7YQUWzL36/e1KyQ2L7mezpWaaRAWGzBiHsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624529; x=1784229329;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QYYRcm1SDT8iK7p94nRSp0osnP5uLl6vyG2s/iO1ff4=;
 b=Ykgv1fyJS74ufxGGXkFvedrMHeLd0uz7ZTgW8YQT9iofHHPfsdNmt0yQbtCDqq1lzc
 H0MrgcMquGw7bQy63QKznE5F7sdC1/+ksO2mTuZz9KEChjXrGoCNJoEMvAoe58kSgFlq
 YVhcd82pLufzE9IO890pkZpSXnwRY3afOGDbyghBUkRmLwTeizcteHwRTHiqVijk6p6c
 PsMd1lFrN6NKrW40+aPKOYooS7Ah2v8NACfHbPeAG2GK3OmpBTEMiXr5CLVBBfoV/2Zc
 YkB253Gu3R5BcKfeSN2BGnZvWWqlZwyOCVy+myYqQnyGnGyvtC6LXrgfoNG55yiGQZ/D
 nhxw==
X-Gm-Message-State: AOJu0YwJKE2cwaeB1k04FXAU7MWneyLJ9D8L7BHN0ZfwgjeruzMbNWwv
 c54ggDoAoetY/svjMRagAEpTC2jooZDFoqi7qSlk6JJwodVU3buEvV2kDbvVHdlYyNtH/u0bike
 l36d9QR4e5lSVBU+FzouWhUB04mmZIIF/RcCtjXsH
X-Gm-Gg: AfdE7cl6kDMCyJkg5++qWCZ9jCU6KTraRGbNQbpoS0ydWXfY1OY1o26IqupDLe+jxA0
 MPXxxN9VWKppgGPGz0leS0axaXcc7bBc0e+A2Ha8dTygEEImKFf2fZgIav8ALlAsQF8S7XeTRTl
 kGDQc7JKfMplvmno3pqLGLWZ4INpKHsi1EQbQBa+UAlbegiJ05WPc+AjSABWmhjql+Ed6Syi7vJ
 M/fwStdQJvvZm6uepaCfi5ErvWVJfKjd3CxiK6R60dNBPhlLjSQ5LUcrI+2V9mGG3Kmkzc=
X-Received: by 2002:a05:6402:5386:b0:695:572a:7abb with SMTP id
 4fb4d7f45d1cf-69ab449f2eemr3467814a12.22.1783624529642; Thu, 09 Jul 2026
 12:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
 <20260703-dm-core-v1-3-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-3-076d395bded4@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 13:15:08 -0600
X-Gm-Features: AUfX_my9MRGLY2nv_bcd1pyXSgVP9lSUOGtEJHMxMvq2HKApHoXhY3ExXcGlLrU
Message-ID: <CAFLszTguDVY5bFMw-3mxydK4KxyZX631ZE5_GNCsT7=Pk2SGQQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dm: core: Correct calloc arguments
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-07-03T09:11:23, Peng Fan <peng.fan@oss.nxp.com> wrote:
> dm: core: Correct calloc arguments
>
> Every other calloc in drivers/core uses calloc(count, size) with count
> first. Fix the two reversed calloc(sizeof, 1) calls for consistency.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Rapha=C3=ABl Gallais-Pou <raphael.gallais-pou@foss.st.com>
>
> drivers/core/tag.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
