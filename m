Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E735FC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 18:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B347887F6;
	Tue, 23 Jul 2024 20:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fsOsyyKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8784A8876D; Tue, 23 Jul 2024 20:23:30 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E02E8831F
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 20:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6510c0c8e29so55872127b3.0
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721759002; x=1722363802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5cHfGxJiP5oEb6KOlo6HJWFSHhXnt3ee3uQq+VnTbwg=;
 b=fsOsyyKzHeMz4o//C7fW1OX4yj7HMaj0grjyBFrgcDMOOx6yKFQsmFyLPjdxIswK0z
 1XkjBqYCIerS6BSySkxrZgMfGuO2tdRQB/6lGIepooz4dY9LgI14FVhICjKDWuURYWfZ
 SDdoLf7xaZy6BtsxM6V9ouwZz7MMYcgr784J0SJVsGpV71aJzX6pe9tsZu0VF57JzlfL
 SwsioqCb1m3qWTQ9UA0FvwasJDZsImkcKRnzqDY13QXbwdnQFuCmwZsLWF7S+rB40dyn
 SJHdyTSoEbYuykBjorT2LEMAktKdzaTbfsHhHCExaO5DG40QZo5hij32LFQosfRjElNH
 nlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721759002; x=1722363802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cHfGxJiP5oEb6KOlo6HJWFSHhXnt3ee3uQq+VnTbwg=;
 b=Mvx813Wba7WcmchtDfXI0wgSP99T54bhyLf2qI7bPbyxGAtf6esSbM72PTdObdePGH
 Do6kKHPVZPQppQc3lwXP1BH7F6Ao9Q6PziAXL7BQCp9Wj/ho82td0LzM2Qnfb0fU2JrV
 nNbtqZuaX2h8ATRZT2SZrPlh+h57yEorXTuFbUoEgEv8DNseTGSOhrsvKeu2+ycAQ2bN
 aEYMoANWoxCigQnTVXCf0jnQrmFCjJHRLWwUZxunCDcB/Y8rAwezTgN5/bvZF+GjuIN/
 BKJrorVmTAOIJCZC1F1cNVih08ut3Xr4nBnUqp6o6YPdV2XDt/4sP7oOhVDpcNtjF+mM
 BnyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG3RVf4uVR479EuhockC+GAVrqN4ug4BiteJ3TmSU9TFT0K0zC6LrA2KMDjBxLQ6WtvmHiF5KhNvI7TDQ5djhL0HR8Ig==
X-Gm-Message-State: AOJu0YxFd2fy+BgGKT17MkMQlun6xOV1uQ2kw/U2CaPh4SQtz3pCsDbH
 eSve0BwLxaUQpiDmgv0dBQTtjr/YPz3r4R0odkhJAw8iD9wHT5uL2JfQUix7fpIH5WkuWeuG+Pc
 ozyItH1pozDPH6u6XvoQUphtBAcLHxy/V2nZLfQ==
X-Google-Smtp-Source: AGHT+IHTtBG/ESzpPiV2BaD5rznBlSSulCMrTlofaI72g8XmQOfHC67mGQ8eJEsAdO0irQOTjDM34EAiRjI7fwksqLQ=
X-Received: by 2002:a05:690c:ec4:b0:627:d23a:44ff with SMTP id
 00721157ae682-66e4b7ecfd1mr45739107b3.3.1721759002322; Tue, 23 Jul 2024
 11:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240716031709.24943-1-semen.protsenko@linaro.org>
 <CAPLW+4mAqpgWwiX4fvZFjWMWPtY9Mx11b9oPghzfpFoD8FU98A@mail.gmail.com>
 <CALrBrZ1d-1Ytxtos9-NzDjNwyyY8T+aOqHU03+KDhJLdMYPt6A@mail.gmail.com>
In-Reply-To: <CALrBrZ1d-1Ytxtos9-NzDjNwyyY8T+aOqHU03+KDhJLdMYPt6A@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 13:23:11 -0500
Message-ID: <CAPLW+4n1zkoT8L6QDW1CKxVn=auK=VhaNR4LmJs60hvvzyNs2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] arm: exynos: Enable TRNG for E850-96 board
To: Minkyu Kang <promsoft@gmail.com>
Cc: Anand Moon <linux.amoon@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

[snip]

>
> Your patch was failed to apply to u-boot-samsung due to the e850-96_defconfig.
> please rebase the patch.
>

Just sent v3, please take a look.

> and about mmc patches, those have delegated to mmc maintainers.
>

Do you know if I should I ask some specific MMC maintainer to apply
that series? That series was pending for a while now and I really want
to get it merged as soon as possible :)

Thanks!

> Thanks,
> Minkyu Kang.
>
