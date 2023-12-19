Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E77C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 08:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8A6286FF7;
	Tue, 19 Dec 2023 09:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=londelec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=londelec-com.20230601.gappssmtp.com header.i=@londelec-com.20230601.gappssmtp.com header.b="yfi1HxFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C0C86FB8; Tue, 19 Dec 2023 09:51:05 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F144487073
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=londelec.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=cody@londelec.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e23c620e8so4005453e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 00:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=londelec-com.20230601.gappssmtp.com; s=20230601; t=1702975860; x=1703580660;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/SY+ajO6S3kK0lwR465ZeFt2LeKuHk20HT99E2GQWI=;
 b=yfi1HxFgg/TMByZLsRpa3TvsHs3pT9UCbVO+ku/Tyk/u/mBLgD08IJrjXdXp3CpPA4
 G4HQxfNvn2ZP5NR49HN4UDs1oSVORCtk7UEq9pM8ql++am7YWVFGkY08TTYJf3CGhAAC
 N/Y2rgiODoEMcUEM5iWFG9kN3bcXZroEsbkBxL+wmc+xHDXKIphyhUzGnt2rCigWR5hp
 gzgx5yeH1oLkSKJxghxLsAFLb27Ng0KV+jYqcknIdem/IxIHvoN/oO/2Hmp0DEwb78+s
 JKX++4aD3NQB5G6EWV1R5e157xVyJpXfApDC75WrY78kp6H/WqFs/36q7yjKPyzRfvXu
 LnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702975860; x=1703580660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/SY+ajO6S3kK0lwR465ZeFt2LeKuHk20HT99E2GQWI=;
 b=M1bSJPOSfZRREMWDHyuYYWr2KMBb7V0h+yG6f1abvstVP5zHJ3HzMp6PZ8+Q6C0rfx
 mR629GSAhjsdUE6Fb7xxV6QdHcJtZNxngc/oeqxjVbybFJw31kxDtUsIaR9YZ+1+lN8G
 d0tmN8KvetOARlU/jPDmmQw7yh91Mrhv9IjNRnSWYFeXtbWpG52PzJu6tEBF2fcsZCzK
 E4ylt+iCvV8s9drTZbiAQS2jymtF2iXHDgMd7Gq9DNgeIPaZtBzcY1Fw4XZsFxnDDPhD
 W2Lr0URVVXvEuOg6L8HQbUrOd5ZlpRsTjd0ApM08aEIWz2RQEggqEC4ZQ8pGhycr7H26
 QI3g==
X-Gm-Message-State: AOJu0Yw0Bxe43YW7MXkn5vmAKjZ/LteTGHDk36X3COBgBScLn8XT0tVo
 LkDure3ODloBlqhNSYF63crsH4PDDOgb1hmzJ0wOEg==
X-Google-Smtp-Source: AGHT+IFaOXnlob4m9gy6e2Wfm+LpPQlYz1ok1IKDa2/Nqb6L+JlT3Z2Bu87EAQKmPOmNMJymAEeBxw==
X-Received: by 2002:a19:7510:0:b0:50e:22cb:6f2e with SMTP id
 y16-20020a197510000000b0050e22cb6f2emr2344320lfe.0.1702975859201; 
 Tue, 19 Dec 2023 00:50:59 -0800 (PST)
Received: from localhost.localdomain ([87.110.52.154])
 by smtp.gmail.com with ESMTPSA id
 j15-20020ac2550f000000b0050aa6e2ae87sm787845lfk.2.2023.12.19.00.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 00:50:58 -0800 (PST)
From: Cody Green <cody@londelec.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Stefano Babic <sbabic@denx.de>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alan Kay <alan@londelec.com>
Subject: Re: [RFC PATCH] mxs: Don't enable 4P2 reg if mx28 is powered only
 from DCDC_BATT without 5V
Date: Tue, 19 Dec 2023 08:50:18 +0000
Message-Id: <20231219085018.8266-1-cody@londelec.com>
In-Reply-To: <CAOMZO5Cj9WcNKLUWzcNgjUOjyb7DGaTV+WTcSvoMgBPuJobuow@mail.gmail.com>
References: <CAOMZO5Cj9WcNKLUWzcNgjUOjyb7DGaTV+WTcSvoMgBPuJobuow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


On Fri, Dec 15, 2023 at 7:23 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Fri, Dec 15, 2023 at 1:20 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> > Ok, what about the patch below?
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20230703205700.9120-1-cody@londelec.com/
> >
> > Is this still needed?
>
> I looked in the i.MX28 Reference Manual, and the one above looks a
> correct fix. I will queue it.

Yes, this patch is needed, thank you for queuing it.
