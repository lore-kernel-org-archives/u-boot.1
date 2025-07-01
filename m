Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDC1C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 06:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7935F81FEE;
	Tue,  1 Jul 2025 08:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m6SBDeKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 667D881FFC; Tue,  1 Jul 2025 03:23:40 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEF8F8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4a5840ec53dso61852551cf.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1751333014; x=1751937814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=S1Bqo4orA8/KLrJHB60j3UbwtxsinwjUIrmFDAHz3Ao=;
 b=m6SBDeKySER75DxuBuVdyHjRePloscUgfaEodR6PGIqKEo0nfC/ORuAulCFaR+COQg
 /wAKPwWb6n6FVDJ8tu0kY5/FSGILNN6Ikd3l/cwSrrCkLDBdejTqej8YFoD3qJMIU/rs
 y2Wbp8pTiTDsT1iT07gqSN1cXkbZW9qldHwEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751333014; x=1751937814;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1Bqo4orA8/KLrJHB60j3UbwtxsinwjUIrmFDAHz3Ao=;
 b=suI9H0j7UupUlTeI9pzCSkW7RpOyMB1YuHqzXZFv8kQuRGlUIwY/i7ixGVUtEtnps+
 BCR/Q23bcCiTnneDv1D1Byil7djihWYADYeUxLonTkWG/HfYtI2QQ1YrVAYuVQG3g0Vf
 DiGMgmAK0dzD3Lme4OAbPAgNnF7UVwIeHnwF0QukvdBpjch9xxnq+6P70H8vfzWKyEBY
 HXja78yZM5WrMQYSUD4w7od1vloiqdUB+HQAUe29Cp3OtsdNaJh6hsrX7A/TABl6veXE
 pmJ2qDqw7zSFDqIdivY5AJeTQmfDae39t9KFOywrYLXEGxKofxB1QrPZ44tWldD69WNl
 zTCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwFgfyf7kdc7alnVPQ2LBCbmgzndxEIrTVEum9gNYzex+qPAB6hxXsfwBoX3FcC5M/N4whbVg=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+GdqWGh/NWLtP9ktGtT0bEQanx5rxEpS2xxuU6g0gFOh6uBiE
 oe018lymLKd4fDOJfOW3He3WtmEwsD5GbXOP/tMQIN1NNJmwLMSvx6kXVADpb70wuHkr2GYoJ18
 2Es2y1Q134/Z3GVQMBWcc3cDD+r14ejjrsESnbtgi
X-Gm-Gg: ASbGnctgds9qAcyMzis2/wfRtQnhhgNX2fJUSajpNLwpgQag990UshFmEsKlx8jHe5U
 ULvt5yjZQDJ9jDlwcdrGPyuwYarUwsVxd5Wlg1q/j83RsMS5EWzvPqjrmDyKSomNN6NxFy2ravV
 Wc8gMVsB+BNdLDqeOL6xaHBWvZQyhXmi+4uvawCUIOVKE=
X-Google-Smtp-Source: AGHT+IGOyMMDOIm3bM6wzZTnov4qJquvOAiI95BuNrs8DkI2FAdHXnWFBfHRnEtMishDiAZUuU+zNh1sL1ubt1A9IIk=
X-Received: by 2002:a05:622a:5888:b0:4a7:1515:8bd5 with SMTP id
 d75a77b69052e-4a7fcd31fadmr282388771cf.14.1751333013849; Mon, 30 Jun 2025
 18:23:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jun 2025 20:23:33 -0500
MIME-Version: 1.0
In-Reply-To: <df214fa3-1fbc-4f9b-8932-59de653efd27@linaro.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <df214fa3-1fbc-4f9b-8932-59de653efd27@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.11
Date: Mon, 30 Jun 2025 20:23:33 -0500
X-Gm-Features: Ac12FXyPYg8Q5gI94zb0Ky68wBNu3-LKfc0FpBY-Jq-hYYZCChu6YXJPybVmHHI
Message-ID: <CAE-0n508Zs887Yi70nW-Lmd2sxqz+ufpmBMz1NVOVByj4UPXCQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] Support to run U-Boot on sc7180 Trogdor
 Chromebooks
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Jul 2025 08:48:20 +0200
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

Quoting Casey Connolly (2025-06-18 10:59:24)
> Hi Stephen,
>
> There are multiple build errors with this branch, I started trying to
> fix a few but I think there's enough to warrant a respin...
>
> Please build test for x86 and coreboot targets (try buildman)!
>
> CI failures are here
> https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/jobs/1174915

Thanks! I lost time to work on this with work/life, but I will look into
this soon.
