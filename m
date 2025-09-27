Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18B2CAC5B8
	for <u-boot@archiver.kernel.org>; Sat, 27 Sep 2025 14:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE22982A9E;
	Sat, 27 Sep 2025 16:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mke22SwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D95830B4; Sat, 27 Sep 2025 16:04:54 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7268006D
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 16:04:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7b00927607eso601402a34.0
 for <u-boot@lists.denx.de>; Sat, 27 Sep 2025 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758981891; x=1759586691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8+TqwVa9ZsnfC/8FstgrOX764Fw792I6qQc4jz5RE0=;
 b=mke22SwFUMANfQ+g4fWZxGIXvzXV70rqInPJd1bB17b6z8ItLftx3RtUpZjSWYMQoW
 KdIdSxNnS22e42Z31LZhtlj9dml5+vjnD9skr43ohjnitCk8fVY/Ngswk48LAx6eQNhN
 4qAkZQhIhOP1v46Y6aON5ziE5YEUafZ2CvfaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758981891; x=1759586691;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8+TqwVa9ZsnfC/8FstgrOX764Fw792I6qQc4jz5RE0=;
 b=JjweSn45FANFrwmFnDKAHyAYMozavUXgQBnCFr9L5R4SuWkcEYnFetTtsF1sKM3cJf
 /pjkj67+PwH9budwLx94NO3hRF/PtGp+XbLJg+ueYzJFipi4f3PPzHWfZlVM5ZOSmP31
 GHrc+cmAHlKLp+Ru/+FMYfYxxeeBd76UM9fVFkBhMk5LfJ72M2oELfxqf2jKf5C4G2ai
 A9MAdPMwLuuj+kLZt+tcl3QMPSSS4C8ysNu1ZW0NQVNNrF1gnqSCIfHKx/ESmQBjrjDJ
 SlUlqfzzNBW7nrSKjY4mFXBl3ZeSIGKWnAUqzBfKbu00fUSgaHCkIP1euljWSbyqAbP9
 wp0w==
X-Gm-Message-State: AOJu0Yxpr6epRJhlQ10qiPXAa/BqeE0NsGtmZxOck4R+jj/nd1Z5IEvU
 NMSmQAsDCK+7sc3NCcSJkqkERGvwXVCiwbskdbVFBiZcqeHRL+NSywxf4FALg6YpZ8g=
X-Gm-Gg: ASbGnctmkz9dZD9xJrCAqZOYHhTCiWfGirZF+OvSI2aBKjPfVyygj1A4EVqvFTPyX66
 xaor8rghP1s6kkaw5zD+WK7iR7eWqQPux686U+4xATjbt/j12bETMzkZ3CUxksdZPSZ7xTv2AFQ
 NU209OBPNaCVTXWKq63Ibx95Vr1EiKLuXcxoe3wHZfnhbvQU77OBX81oeX4O0RuMrJjUUUmpoFy
 E7ZhA5CzNICRxINx5td3Hkv9Pkt9n3IMA2bLGgpFKur7+mFxn9W+590GB7tUoZiJuJqlUJ+EkCX
 fduhQCb8bwWxX2JgATjK2aWdxJ9omQujdfFFcxcNbjNdzTCx1kZO6c1EVZgeDj/G9mYaRu8GHtO
 3NTtjxT+xjdeYFB7PCc3sGrtAISqpEZTNOjEImEycbuTsHymtIcPc2fU=
X-Google-Smtp-Source: AGHT+IHmP8cq1q9K31iNPx4Cjny6nD8mNGpL7EDvzYqh7VVpsn55f4uvvolAgZgQJjk7jbrQsOhbqw==
X-Received: by 2002:a05:6830:6b06:b0:7ad:28e0:22f8 with SMTP id
 46e09a7af769-7ad28e023a9mr3068270a34.32.1758981891472; 
 Sat, 27 Sep 2025 07:04:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7b4c0e92da9sm20077a34.26.2025.09.27.07.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Sep 2025 07:04:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul Barker <paul@pbarker.dev>, Peng Fan <peng.fan@nxp.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sam Day <me@samcday.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 "open list:ARM SNAPDRAGON" <u-boot-qcom@groups.io>
In-Reply-To: <156e2f6f07731efd50688f1e59630b9caae4db65.1758095642.git.michal.simek@amd.com>
References: <156e2f6f07731efd50688f1e59630b9caae4db65.1758095642.git.michal.simek@amd.com>
Subject: Re: [PATCH] arm: Change SYS_INIT_SP_BSS_OFFSET from int to hex
Message-Id: <175898188863.3905802.13054751176045069997.b4-ty@konsulko.com>
Date: Sat, 27 Sep 2025 08:04:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 17 Sep 2025 09:54:06 +0200, Michal Simek wrote:

> The most of OFFSET values are in hex instead of int which is easier for
> layout description.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: Change SYS_INIT_SP_BSS_OFFSET from int to hex
      commit: c8a74db0cd2ae90720e81b55795cf2809762a995
-- 
Tom


