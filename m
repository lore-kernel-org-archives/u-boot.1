Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A52C4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 08:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C8788098;
	Sat,  3 Feb 2024 09:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYx8EzFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4BC28809D; Sat,  3 Feb 2024 09:32:56 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B79E087CBA
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 09:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez.ortiz@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5113a8ab4ceso1450462e87.1
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 00:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706949174; x=1707553974; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UfrmVqBJECb3VwdBHJjC6T15FZ3+QdffmbCLBUW6i7U=;
 b=HYx8EzFm9mpQgh7B1Hx5j3kg9CGKz3rOuxA0YSvJxNNY/CKirJ2yMjLsM2VC+LsRSM
 qkrYMDmBOzX6C4Vn2XAtipgHlQTT9bXP/WQ3MEF7Df4XStS5V6cxkq+nSNrB903Bt8Mp
 o+LSwTTI2EhUblRSky+2qvVnP9tpEm7tPWpHOtChE0Zf4LYYuF4D/9fUerImbQqy7mi3
 9MFDSyfK0YJ90wXtzz0iZ7K+B6yJvCl3zUrTthNCQ/3NjMraMJWxoDQptoiDcpB7WFZL
 Z3t1+UbEiZF3C/gCbwpmVMxzXnQ9O/PdOy8ZxpcUwwTBmUGd+s3e4k13px/nltJgzJXx
 92hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706949174; x=1707553974;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UfrmVqBJECb3VwdBHJjC6T15FZ3+QdffmbCLBUW6i7U=;
 b=OpJ+IUf8y3YUHJNCB0p+ya1Qs6J0yDDxhLo1t17FoabL6ZdNeDdbhvIyoj9gJeRc3U
 xgkItNvizDZRlrcuc/uH+nSJSeiaaaSbV47j3UUmtSua7EMvt7uQfS19twTk2GVOgXkf
 yNFUG9UrmFNHV95gRv7UrbV/UOod3Jw9IW9JtDGP+SDJIiH1IM9H4T+JFcnhZk3uBnuc
 azRU2nrl9yc0+PUILGW0r/U2U3sabrzSsVr8iMFM41G4IA2xiR6F8EGTA8idj/mwJT+k
 SNCBJFB1rZ5RrU+L7YTGt8eAN3HcDJbGDI6FooZCo8r8GxFGSDpED5JLg6MsS8ePC2MU
 yNBg==
X-Gm-Message-State: AOJu0Yw19v0URKeNAD0rtddNXdHh55Ux22q8j1SutZyXnpU13Uf73TiD
 HnEOzpwdB5xR3T6y6iNZeGuDoGByGDSDqHuoXV8EK1BiZEC5Yw5E
X-Google-Smtp-Source: AGHT+IFkFXZBH8ZVfswuh1XHTAAmopKoDLIFw4uN1Tu/vKbujEhjw+cic3YZZDl2c2FWMCZemjOhhQ==
X-Received: by 2002:ac2:528c:0:b0:511:3a1f:1cec with SMTP id
 q12-20020ac2528c000000b005113a1f1cecmr2167304lfm.0.1706949173665; 
 Sat, 03 Feb 2024 00:32:53 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXp2DDOisFd9OvesfbG0l1g4QM+oAdc7FYqO88YJyDivEYBNwzEfLuJ8MgmCHhAbFIk7pzLOH/2PFzm5+DSXTrfdyPUVWAhtOK2DvRpX+RxbIH2ROCgfSpwfqpli0tb6O4g2tCXUEhtWSyFSPC/+dTq0l7gFVThXoQPH3Ph7KXKMoYNGlF7edyy6LnaS4oA0BD4VF4DGEtMHDNkqSu1jEOTPz9g
Received: from trax (8.red-79-144-185.dynamicip.rima-tde.net. [79.144.185.8])
 by smtp.gmail.com with ESMTPSA id
 n41-20020a05600c3ba900b0040ec66021a7sm2205265wms.1.2024.02.03.00.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 00:32:52 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Sat, 3 Feb 2024 09:32:51 +0100
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] poplar: add myself as co-maintainer
Message-ID: <Zb36M+p4z2+zd+XB@trax>
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
 <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
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

On 03/02/24 07:54:22, Shawn Guo wrote:
> On Sat, Feb 3, 2024 at 5:44 AM Igor Opaniuk <igor.opaniuk@foundries.io> wrote:
> >
> > Add myself as co-maintainer for Poplar board, as I'm currently
> > working on it (re-testing releases, addressing issues etc).
> >
> > CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>
> I'm not actively working on poplar any more, so maybe remove me in the meantime.


hi Igor,

Yes please go ahead and thanks for offering.

I'll sync with you later next week (I found my Poplar in storage, so maybe we cam improve things a little)
Also it would be good if we knew there are still users.


Acked-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>

>
> Shawn
