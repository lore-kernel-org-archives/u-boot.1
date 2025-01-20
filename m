Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E24C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 19:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F5480780;
	Mon, 20 Jan 2025 20:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UBWOk8Ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A74B8077F; Mon, 20 Jan 2025 20:20:46 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A9180717
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso901594266b.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737400843; x=1738005643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=heyLE2wwrNyu4Ee6tIygptWDi2jfc01b3JimUd1hW/k=;
 b=UBWOk8EvVB03lY5WkwTz6hQ4L3cEafwQ2eAIMJyJlvTXxRv4AngQv+JOusL9mRgC2R
 gqucRa2VFc28GRULWFXaQPoEfvfqUpL6Upu6fFwmbnelyOsc8sS1L2XeolvKwmCc1Fi2
 8f9MVtu2euZF2MayNUB9LJFKL4BLd9wKY3P2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737400843; x=1738005643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=heyLE2wwrNyu4Ee6tIygptWDi2jfc01b3JimUd1hW/k=;
 b=tsTI8wO39H4oWzHFuzidMZ7WDnjNH02evW43BgV6BvSR5yB8Cjk7qyPkrEykE5R5d5
 6A79y97GKZ8proa5+LuIKDYKAJnCONTEL50iwa2iAe6bSIix06/G66acYfWY5B5DTunw
 ikF6M/iXp2gXHmdOV+RiCmUq6lzS2GJOTIOLzwoAxec8TmRXLWwlZZk7t8rRlgdngQcZ
 BgX+wCOwz0YGKOnq8I6aAREdh5JCNXY9e9kNirPT210ZxX1TZPuz+/SsU6VdkHRJOGIv
 mI3jOOEp9ec+vV59w68AA/UfCs4arzoQT0/d9seCUurTN0DuBMx18Db9Qv6VgYkKmNCo
 eEHw==
X-Gm-Message-State: AOJu0Yy0o8vKv0eAAqdF5MwBRilTG5cw00HzzfkbDI+79lERBCxogsZ+
 F4AIHN6dWvVwFf2yIC5CtnczIw1wlZL48DnFy8eveUEJL4+SxLIAJNy3vtCp5G1O+FVjqZJh62r
 cWSjmorDY/G+o4n9k8PM2IGcuv59uFnNCKOisUb5gCOLO1Sg=
X-Gm-Gg: ASbGnctnsoGWsxff4Khe+kHiGzv79z/egbNvUhHLNiv6kICJI1Ou9nkIaQMz/wXK8ho
 OLeGn2ovCPLdPnJvVsNWDmFRTdvsE98+Xr39nG+4qRmkIrccLzg1i
X-Google-Smtp-Source: AGHT+IHltjz5WG++tLZU7DRgEelyDG8yXhM+57IRiLO0dK/KGXS51qq7VYYRJQuZZ2qbqCJhddfrKf3JExbeZ++spVA=
X-Received: by 2002:a17:907:7fab:b0:aaf:87e5:4eac with SMTP id
 a640c23a62f3a-ab38b4aa1bbmr1462386066b.54.1737400842752; Mon, 20 Jan 2025
 11:20:42 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTgrJvFZyh452SOLpWnZSLA_cK6VgFjXNEMzkOrjQe9Hng@mail.gmail.com>
In-Reply-To: <CAFLszTgrJvFZyh452SOLpWnZSLA_cK6VgFjXNEMzkOrjQe9Hng@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Jan 2025 12:20:29 -0700
X-Gm-Features: AbW1kvZQP54jZNxg0smq4Qa5oysBDVA-ShHOpR_t2A40haJu_JxLF4PhqR58D6k
Message-ID: <CAFLszTh-_YEkEtYvFDduZJkpJ9KVVJCbHZtY=9vfdGz_byLAQQ@mail.gmail.com>
Subject: Re: OP-TEE test suite
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

+Patrick Delaunay <patrick.delaunay@foss.st.com> too


On Mon, 13 Jan 2025 at 12:01, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heiko, Jen,
>
> I noticed recently that the unit tests for OP-TEE are not build for
> sandbox (or in fact any board). The code seems to have gone out of
> date and doesn't build.
>
> Do you think you could take a look?
>
> Regards,
> Simon
