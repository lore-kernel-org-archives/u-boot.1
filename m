Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A163CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269EA84DD6;
	Fri,  8 May 2026 20:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NaExWLQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE0584DDD; Fri,  8 May 2026 20:10:40 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC0B984DC3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bcb69c8b30bso77265466b.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263838; cv=none;
 d=google.com; s=arc-20240605;
 b=Q4EgQ/NDu+DiDg++VhGc+X6ORRkCZ2NJ6h5PZxldDBctEULcBi4BzoD6tIxV60k+7B
 pm/5OOSqZlKE/+ppjQH+/lw22Zd3siN6CFAzwlW03RS3QFnPHgKvC4+1YbUC6z/UiOC+
 F+N/FwAWLAKnRIZ3EH0pLKUpk075/2ByYvg6Fw/Kiabf8TFKsfF5YvW3wiefWm3pQtcM
 S6wGVOmUfNwUUc+2u097VZLeshF0x4OWyvcxZNsg+HwHUUzl4l2gb/wuxtlOsOjRxE+P
 Hh/6vhNI70sxAhU3kSG4B59w2DmEEhdw2WvlsnMteSTPhzkH3bnUfAUq6/MdXhpMKMj4
 0xpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=24haMHXTsp0lycj2/K1moGsekD3pJLaAfu/ikje45bE=;
 fh=L35BJGl1eOCTAl0X8L2OQ78gjsGwLgv72NZeh8dCP+M=;
 b=MknMO/vN4MG+MsHKZtLuafJgSG4DYsCDL6XpmpARUpVRVy1U+YDZD2TiyITdY10kX8
 +qon6sdbLOgfhvEgt8ZYiZ24WPnf3kXZ88QbpJaBBbMZLZlyVnrcaSir8GinX1G2aKyw
 z5Q9nx6pmGL+MgU9w3UXEzX7v/4VoHhqQ3GG2rE3gX8ShdDNgc+UAMMKG3TCBQ97u9qT
 AG9MVLRZATVzw2CYYNctmntjhEG8xhKgDWSmpEzYnmNIOt2YYdiBA8ePS7wH8Qp/oUzw
 4bu+Yvewnb6Qp4kQ6a+Z8DT8gw/CRhhmy1qAW/2m9bj1moL4cIHgLit5srZKGiTZEgLn
 6tRA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778263838; x=1778868638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=24haMHXTsp0lycj2/K1moGsekD3pJLaAfu/ikje45bE=;
 b=NaExWLQVZrxvoLMJgJrHhJLwrO4Oags0Hv8XTEZthPsGmib4ZkRKbVUPtgByW8Ff99
 QWlEIjR5sJKvEKgldSfUQJgMIIVSMcSbS2F3rg8k6+Qfp1xBZov0S70g+EnI2XG0eP8N
 j+NVGDD07nOrazk9+mqkAy1JRqe5Pqye5+J9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263838; x=1778868638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24haMHXTsp0lycj2/K1moGsekD3pJLaAfu/ikje45bE=;
 b=kamc4omR47g5+Ghelb4/PDUE5wCXvNQ3gM2dFCV9MaoM3SQEh+QcSYYQ/BdEBooQBH
 H7CQlLu1molqznCRJSG5tqLdRhMMoCVSc1YuTQs3wHObWvN5j47rYUMvx00FrCOgRkbV
 Xkg82dJ6UD5MsMX9eP2vhJE6i+yqe6eGn710IhLP4rGCj36AKG27gy+zx124i699TttB
 w0v830e00W3UCU+OpPAEU5qbzePEi+pDYXYDpENGH0WggXBqig/f+pad3jW4FtDrw7Ev
 0PX6wFChd4UQMrCboRBP1XOBjVBgoRPDon1IiqRnIzCdDpDAmfRsVVaVNM2D3qretjrM
 ubtw==
X-Gm-Message-State: AOJu0Yx+hgGQwHOcYAImaaUfUec3oFPCYpicznoTn6dqCLPgvzFL0Ono
 gP2RhoWSHNXKtcx0rWFxqSwGJjuXSEvozOq65cSTIgBkCtbO5A2QbMXdQeKkXEWqfo6unCPp8Cr
 QsFy0f/nVKObbCRBH01DyUruF2NCntjT5qR56kcjK
X-Gm-Gg: Acq92OHU2v+GfxKdAIVlmhz9VUlDQaIJ10yq+Z5gBTOxgZAWpSysfasFmrnXbzpcDBY
 HX5EdiB6dOzM7Q20AETQDaEP3O91oCm0X8eadEfX3G3YUqzk1CvU3VvWGDpvyIFBPgtdYkGl+D3
 U9xgb0pC4+6baSnTuGewBEQHAG/8CJ/1WY2Z6ok1du1GydNgK9DDG0BD9CnE+C3upiEDYHy3vkf
 FN5NaNZ8Jagwat9T2mdJtCBDaHIeqrUSSDsN3GRKT9sFrkoNPVVCzLt+l6kpSK2BNIo6hcJqC1N
 +olUD0Esfv/gR+q0
X-Received: by 2002:a17:907:268a:b0:bad:af5:7ff3 with SMTP id
 a640c23a62f3a-bc56da16383mr834970566b.37.1778263837657; Fri, 08 May 2026
 11:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
 <20260508082132.25476-2-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508082132.25476-2-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:10:25 -0600
X-Gm-Features: AVHnY4IhdB3Bge5KK0aRB-dV7LjaZVMC_P_50ksqAL0ASENJJkWwpIvSwTvy08k
Message-ID: <CAFLszTjAZECeyOPy8C5-Cz6aJciUvGdrKgqn5m=Q9LqxpfbVvA@mail.gmail.com>
Subject: Re: [PATCH 1/8] cmd: date: improve day of month verification
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

On 2026-05-08T08:21:24, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> cmd: date: improve day of month verification
>
> Use rtc_month_days instead of oversimplified local logic.
>
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>
> cmd/date.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/cmd/date.c b/cmd/date.c
> @@ -167,12 +167,12 @@ int mk_date (const char *datestr, struct rtc_time *tmp)
>               /* fall thru */
>       case 12:                /* MMDDhhmmCCYY */
>               if (cnvrt2 (datestr+0, &val) ||
> -                 val > 12) {
> +                 val > 12 || val < 1) {
>                       break;
>               }
>               tmp->tm_mon  = val;
>               if (cnvrt2 (datestr+2, &val) ||
> -                 val > ((tmp->tm_mon==2) ? 29 : 31)) {
> +                 val > rtc_month_days(tmp->tm_mon - 1, tmp->tm_year)) {
>                       break;
>               }
>               tmp->tm_mday = val;

Please also reject day 0 - the new check still accepts val == 0 for
tm_mday. A 'val < 1' on the day mirrors the month check.

Also worth noting in the commit message: for the len == 8 case
(MMDDhhmm) tm_year is not set in this function, so the leap-year
result from rtc_month_days() depends on whatever tm_year the caller
passed in. Pre-existing behaviour, but the new code is now sensitive
to it.

>
> Use rtc_month_days instead of oversimplified local logic.

This could use expanding. Please use rtc_month_days() with
parentheses, and mention that the old check accepted month 0 and
accepted 29 February in non-leap years, and that you also reject month
0 now.

Regards,
Simon
