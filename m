Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3B7C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E152081E13;
	Fri, 14 Mar 2025 15:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M6l45TTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA3781E02; Fri, 14 Mar 2025 15:44:15 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39DDA81DE9
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so372836766b.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963452; x=1742568252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e9z5RcSR7stov4Bhhudyy563tQLKBIERbsSIjPpIXCM=;
 b=M6l45TTB4rnqwEkyoPBLn8nCjLaJpZLItKAF4tgM5NYR85hSUmq9ONnxiaMFtX+3rG
 gZ3wU7p8MjIgIg2uHgHhAxa6a1aSCzxmmTRzgHNepgKdvVBpkSc9ezSynWx4VqTypR5/
 AmtlzhBaVKbd+m2fLw83wjH9ULnvfP6BOyV5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963452; x=1742568252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e9z5RcSR7stov4Bhhudyy563tQLKBIERbsSIjPpIXCM=;
 b=HTQMAdwQ5RGAy1//m5Batik0guBqm8jzL9XhE26PoVM+m53gxfpdWTyJlYDBoBLPY+
 ZRUhHdwKrwrgZDDaRXAAUFMk8zx82WkcgCCGkDywzYHR/nkHaJfpQgqOB5//Ds7fSaJX
 j/nY1REBRqesh4dZFNwYbdmPC/KxU7Nw4JCiz5iVM3V+VEupoJ+N1PiC54vqS2pGVaQ4
 x3cSQFvidNea+oA+MLWvfyqTVs+8GI/BJHBGyCU57fN18SmJ8aFOAuARwlQZQZNr7htG
 GhIXvMcDbfudBWx1DNVxbtxz6QcKzqSH9+vjp+L6GfPq4LK4MKFCQmZrIgVn4h0naBfT
 EVCA==
X-Gm-Message-State: AOJu0YxZlY5cUGg51DX9RyEdQ1eAhfhpygzcwA7EOToS4IxqHETMHbMd
 wU4WuWt3jLUgj35g3KsZh1PU5QNBzJX01dmJByEZc5Sekorz578D+pie6+Ymidvnebg9juGpCQB
 5SsdUDzvKKfQ29KK3hEKLkAAL+FGhJ55On6nB
X-Gm-Gg: ASbGncscHvbv464jmhTqPxxYVyECYQ39FPiRougZ57Yg7yVyjijXZNCWUS43yu2WFcp
 o+XjIvjc0itMU8kqE/0eONCHsu52bMafNON4y4e6YQLINiBNy+SBvjl7t2Za/cUpx66Ke3D2TbV
 wUHiqEuICqMIVOB+iz2HnqgGpn1+cm
X-Google-Smtp-Source: AGHT+IGd1obm9EpDcUPCxaM43KQIvcxu7SuucYyNZCWJVtTNWjhqNIWrrQp4RYiN6ZcdTUb/CU9kwHBxzAYyUf5SyFs=
X-Received: by 2002:a17:906:6a0a:b0:ac2:9c7d:e144 with SMTP id
 a640c23a62f3a-ac3303f770amr311269266b.40.1741963452585; Fri, 14 Mar 2025
 07:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-47-sjg@chromium.org>
 <20250307142436.GM2640854@bill-the-cat>
In-Reply-To: <20250307142436.GM2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:44:00 +0000
X-Gm-Features: AQ5f1Jq3Y0y8TPNN3qyvzTUh8VCrQDQIWBQyvhIW-pf-8oEo3lZ2PD7VOk-m0LY
Message-ID: <CAFLszThxRPX8N8pnJfEkm60OJ3BxJx18YbbfVE_0janzmOdWvQ@mail.gmail.com>
Subject: Re: [PATCH v4 46/47] RFC: test/py: Deal with timeouts
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

Hi Tom,

On Fri, 7 Mar 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 06, 2025 at 09:04:13AM -0700, Simon Glass wrote:
>
> > The distro test takes a little longer to shut down and restart, so
> > add more time to this operation.
>
> In the test, make use of u_boot_console.temporary_timeout(val) ?

ensure_spawned() actually sets up the initial timeout, so I don't see
how I can do this in the test. It is immediately overwritten by this
function.

>
> > Disable the sleep command for now, as it seems to be unreliable on
> > QEMU with '-cpu host'.
>
> Update the sjg lab stanza to also make use of TEST_PY_TEST_SPEC I think.

OK ta.

Regards,
Simon
