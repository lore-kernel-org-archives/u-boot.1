Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09A0C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C4583438;
	Sat, 24 May 2025 06:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bq0lR+To";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1AD833FA; Sat, 24 May 2025 06:25:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F8A783564
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad5740dd20eso69457266b.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060745; x=1748665545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5VKJRHkiJjVE2SHgnjOeO5aM8iC0nTS0gV+gpOmAdWc=;
 b=Bq0lR+ToUcEW3OOImvpj2u3QeneHwQKdtT3BzuFAu/maJv6+KVAS4IYTRBgiPRTCrb
 7k1Qdydt2qL+sENZLbyLgMYYIxgrvMYkQkxJtq4sEBhPjlFDGYIUX0zEKG9dtIhj69Hr
 gp2JbKLTgz7+DZeiG5ThHMG3R0v9xMtRJEKDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060745; x=1748665545;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5VKJRHkiJjVE2SHgnjOeO5aM8iC0nTS0gV+gpOmAdWc=;
 b=lotzcXCDN1XnSE0q7iK/NCd3rGbSHzET5fXKIY68WQD12FuYoolqsiCwgwj04eAgKW
 JM/vFGbzE/NaEi8VhgTuguWSKmvjU+P2Nqhgw5LztttLIDp3pp3jDJh9iYpJRyv19LpF
 MKzM6qIPSxqkWECPp6uyxCCdMi1UfodwvxT6DAokTVBY/XDzcCrxwU4OChx2hqfD+vnI
 Dmz2GFug67TWY5wqtO9cUXWcc39dkKbRF2sihyxYAiD8eWRvGWAorPwSfrWw/NG4rqKf
 cvjCuaq0EOG5UG3AeAbMd/Ldl/XohyB17n8nn7/tyU6Hax39jYn2zJniRbuuMgysFK72
 1O1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLPPydnxYJhk/V2EIi2qD4/5Uwsm/5aGubn8eWX4biAUXvkisEgciF8GdZcqL0gW8Y0QK81O0=@lists.denx.de
X-Gm-Message-State: AOJu0YxLewnLe2ifMN5LVggONYu/crEjIEodOgJPQUWq7cdBDypqBCPk
 uWPOYqGnXeEyIRcnMahAEJl4G8+/81hKLsVh7ACDAHUKhSGJO/XwsRrukm1N3EXi9RSQFu/Ng45
 tlkSLMGOk1MoPonP5MV0zS1TrVldRebS4Z5GAf/Yn
X-Gm-Gg: ASbGncvpqqkoT3VsXqN3egIfmjxePze5fa8Sg8xVZ6Am3qDSkLuv6iA+o6eopTT/xik
 lowYHHQTPE0zv2ocUf5GcSSgQ5Vly9M0MGlDjuUkG6vOspWNR5wZ6DYbdrWeTvDde0R95lrIq8i
 XAmojr+KO1cbekTGsTWbFYYMEosPASmM4=
X-Google-Smtp-Source: AGHT+IEMkYpC31Rq4VvAlN+6FsBRFfWLnQO9Do+cfEaXMCTba5NjTmWlcekvY4mdtZLKqvmaPzbpLnKq0L/vKCgy2Ng=
X-Received: by 2002:a17:907:96a8:b0:ad2:48f4:596b with SMTP id
 a640c23a62f3a-ad85b0d2377mr142532866b.19.1748060745555; Fri, 23 May 2025
 21:25:45 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:44 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:44 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-6-sjg@chromium.org>
References: <20250508072907.207175-6-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 21:25:44 -0700
X-Google-Sender-Auth: 1_ys8l_dYX_zDKKUBIj3Hxa8rMI
X-Gm-Features: AX0GCFuJr8sW7mQMILhDm_I0txehGYi2-EEk3GzHZeFkvQebdbSt-Hwm63DCh1E
Message-ID: <CAFLszTjZ9JrCO=EY6PGM51TEbuC_FEnQM1O5aFAjYWY-PfAJQQ@mail.gmail.com>
Subject: Re: [PATCH 05/20] patman: Allow setting the current directory when
 sending
To: Simon Glass <sjg@chromium.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Plumb a current-working-directory (cwd) through from send all the way to
the command gitutil libraries. This will allow better testing of this
functionality, since we can use a test directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/checkpatch.py  | 12 ++++++++----
 tools/patman/patchstream.py | 14 ++++++++++----
 tools/patman/send.py        | 33 +++++++++++++++++++--------------
 tools/patman/series.py      | 13 ++++++++-----
 4 files changed, 45 insertions(+), 27 deletions(-)

Applied to sjg/master, thanks!
