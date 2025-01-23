Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C964C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 15:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9645F801B0;
	Thu, 23 Jan 2025 16:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hjczooHe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8805F80214; Thu, 23 Jan 2025 15:13:30 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0FE80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6f8524f23so112290285a.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737641607; x=1738246407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eERqPruwiTWnHiQsvt5ljovDpjq+Zymfh5ljGqkPce0=;
 b=hjczooHeqg7CRAoaPvyAyhMUQWXHBUjgXXsFD9iLJ659JLu2SUD1k3zdV4F6sw+Q7n
 MkRIuyzIIbGTOsRAxGxMi4VrU84DMd/Mt4fDZfr2GU6F4Mj0Q4QR1GtEFiynETR4Ld6U
 UdSssEofKM4D5c0yHocgpH0Oq2MBYBboOyPOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737641607; x=1738246407;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eERqPruwiTWnHiQsvt5ljovDpjq+Zymfh5ljGqkPce0=;
 b=xLhef5HnqwpfMKuPHenFdnkAHH/XJ4dh+QfmCLeYqlTref4pCRHtTpMraksPDdXaR+
 9O67v9s8ilghR/urbYiw6NIWCRJKw1NYlGEFiOs+lgx1agoRMFwYqGsdOYWLRLVpENPJ
 fo/SvW8q8arKZEbqL2eBjmQPFTbLeRWu8OkIb/i9wI/6uFb81CxGeQ1qYcBe5vVawrsA
 EN53CyCaU25KDZlaDJSeF4SkYXEMW8eUh62mk98RW8Q2WT6LB3JdmSNIhT1W9ZGHog4q
 EZiuCMAMOvEZhb/hkmtqyV1p4OpmMYjBvDjMl/bSK6brQ75eVmRwQ8mEN5xu+fqi+A7G
 jsIA==
X-Gm-Message-State: AOJu0YzJxJ5wYh/B80s/T5urJomYSUHTYFE50mBSdyDkjW3RsaAVyHmj
 VhngQZGFrO7WjhE5GeVkz0qDkrhrzttruM0PD5oXxjIo/b7+tG3MWwL3qO0C5B8=
X-Gm-Gg: ASbGncssE3b6ykokdYSZW5dEAcBQAaY1BV1SmGJKeWKzjtVGI3KpiGFz9I0Bvoh7opH
 HtGIYY1XdApoD/ibn8/PASuH5c+zPvwAtIeHc9WyazGf0l9jvZ4Uw/7JjdnnpOTc1HG+RRFBIgp
 0EXIc7iR1qWHySbSVcCtkO0/W5jUJVGXrsaWdR3SP8NGN3/zx+SjfwYlBaUQOmzpwpL44FvMqeT
 8YorQbT1Ouj+CO1jP/oxAtLe1aQ5MYDm0w09067WnRA6MDm8FVXGMRyjcdnoaXc/Crlie1Hhxk9
 0O0=
X-Google-Smtp-Source: AGHT+IEFLmBs3cQ4Kizz0jiNS19LCwkvVsu2bWqifm8fDSmQf6pR3ieI5TE23AYJPAES93uPePU9/A==
X-Received: by 2002:a05:620a:258b:b0:7b6:dac1:cb73 with SMTP id
 af79cd13be357-7be63253df2mr4399939785a.56.1737641606876; 
 Thu, 23 Jan 2025 06:13:26 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e1030e4ddsm76706901cf.40.2025.01.23.06.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:13:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: =?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>, 
 Alexander Dahl <ada@thorsis.com>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Chen-Yu Tsai <wens@csie.org>, Christian Marangi <ansuelsmth@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugo Cornelis <hugo.cornelis@essensium.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Janne Grunau <j@jannau.net>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthew Garrett <mgarrett@aurora.tech>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>, 
 Stefano Babic <sbabic@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
Subject: Re: [PATCH v3 00/30] upl: Prerequite patches for updated spec
Message-Id: <173764160279.210100.4402866218713283083.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 08:13:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 23 Jan 2025 16:31:28 +0100
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

On Fri, 10 Jan 2025 16:59:59 -0700, Simon Glass wrote:

> The current UPL spec[1] has been tidied up and improved over the last
> year, since U-Boot's original UPL support was written.
> 
> This series includes some prerequisite patches needed for the real UPL
> patches. It is split from [2]
> 
> [1] git@github.com:UniversalPayload/spec.git commit 3f1450d
> [2] https://patchwork.ozlabs.org/project/uboot/list/?series=438574&state=*
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


