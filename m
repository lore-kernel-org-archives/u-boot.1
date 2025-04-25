Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C83C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 02:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A97F8082A;
	Fri, 25 Apr 2025 04:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFpq1uew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A3D809D4; Fri, 25 Apr 2025 04:35:37 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8D28059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 04:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-54d65cb6e8aso2128522e87.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745548535; x=1746153335; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9Vose88kANFVO7g0MX4bzljzbMewasKyDAUAk9fqQA=;
 b=SFpq1uew7DTHQciebLTqcDjl3S2LYC13p4eVE570YPcnGwXIhuLL41WElIxh5+0qk1
 GNZDbBckYpJKjMgpqBBBDTUG6MAqf1yVKqj4eH/8EDitx8ndDoITFkD/M8eVU3VT+lpV
 rzpGK3ibPJfNCfZjLIFQe4zL3UsE/ArZAljikfPQ7nCQi5Fn8DCR+rCF+/L8Al+Gz9e3
 n5zG4F+IW5VE11Um0HSNO7lqEHdQhrop9+51OrJcwiodcp8D9HVmUpFh9bUJ2IcLsE4w
 yhHVi1h5ad43ijnGt3lasAxoVKe8JRR7dF0WkX63454V8I6zUdLmmGTH+z+BT627nUKo
 gazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745548535; x=1746153335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9Vose88kANFVO7g0MX4bzljzbMewasKyDAUAk9fqQA=;
 b=JasjmWTO9QuE4of7WlhZBnZd6R3jj1mjIZ8K6XnCBQ9WMw6eHpz6gcUxDZNP30wzC3
 vqTgpOiVOhShC4pH+AD30XUw276FyKIBWhgBKCDOae/3G3yhj8acNE7OJgvHQwZCqGtU
 2OH3DpOBMt8Qz5SO2v+5Io+qMNRQhz7Ul8rITfgHn7ttt9qydtbzAaPGuDlmXYT2sNOj
 dGB7MPtXE7M5uIG58yzymqfGlgAmFWIw9p8ZFxQIRCviy87YDznaiXHHXVLO6VejcRk2
 AUMxVmYFWXXAPDDsDYc6NQejCJF1uzwPzRcZ0LXuwmgjfv+1DewbBR/PMxucbDG+tUXe
 jt0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXslCKnzOHYw7OnBQxt7h2vRtAVHPw1Ee66vwuV36q5UPOVlJaCBKc9nDcOpItAK9T+6Cu2yvI=@lists.denx.de
X-Gm-Message-State: AOJu0YwVfMLjs4L6ByVRykLmi3ab0mVkghzts9E6fvVfr+VHUipYqhAg
 kxPMOa4alvf1DMz9GFMOpGTsCLY+L5NRt41C1INnIM/oj7F+6T7msjEwcaje9khmhVClzFL5dG3
 Op9ptqt8Z8U8o6xjLmFXU0rqplnvjHw==
X-Gm-Gg: ASbGncvbH5+s+oMmKkr44pQ9qQpQmWTEJ2HzmuycZrqHUnwVr6xB/DyiZ2aZmXmfQlw
 ynlBOvSbUVVEnNpYOTv5f8rHxaOl9tYeYWqmXmQrvUpGbB50x/meHS6P+bz9h30ZbXhe5cMccQY
 QfCVr6yPWO+6Xb92pthx51IxA/0rMxgC+WB1J4jiTz0Wg2qPNOCvHS6w==
X-Google-Smtp-Source: AGHT+IEOQgOhdVCi0nrjc/66MkypODQeiK3R1Q+CQ1bISKhz6AcGtJWLdjnS8uWZIPsBGuQZQU10LFRisgyEv7iFZis=
X-Received: by 2002:a19:5e15:0:b0:545:576:cbd2 with SMTP id
 2adb3069b0e04-54e8cbcd15bmr126742e87.10.1745548534355; Thu, 24 Apr 2025
 19:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
 <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
In-Reply-To: <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Apr 2025 23:35:22 -0300
X-Gm-Features: ATxdqUESScmEYg0G2frVGHMihqOsZ8m8y9sDFzGMUwRPZMUIS9qgeajJKIGMheE
Message-ID: <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de, 
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Thu, Apr 24, 2025 at 11:20=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> Probably some timeout in the esdhc driver, maybe some clock are not
> enabled ? I don't see it on the MX8MP.

Same here. I didn't see this error on an imx8mp-evk.

>
> Did you already apply
> Re: [PATCH] clk: imx: Finish converting clock-osc-24 back to osc_24

Yes, I applied this one locally, but it didn't make a difference.

I haven't had a chance to debug this issue yet.
