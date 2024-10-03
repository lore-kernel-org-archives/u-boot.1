Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03263CF8555
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6AC88FAA;
	Thu,  3 Oct 2024 04:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ojWSKjdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54C98901D; Thu,  3 Oct 2024 04:52:36 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5457988EC4
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cb3bbb9cf5so4283786d6.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923953; x=1728528753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAoIH9rpc5gUykBKlbtHt/RAvchwRfmYPy8UEu/+j9Y=;
 b=ojWSKjdfC+VQZZpt5DzAL5TFu0m1BTFZ36tKKlylDw7pMAo3jr2Ue2hbtKSfVGOnuc
 uZu36C7C2WcL/BTi2EtepKS14TDp0n34HzAv9NxeWAnTHIqBTAqKsVTmuBF/6vYFcwvV
 qbuICkuMOFoYS4zL/t+p9Q3oD+h5mvVFkVhUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923953; x=1728528753;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAoIH9rpc5gUykBKlbtHt/RAvchwRfmYPy8UEu/+j9Y=;
 b=mlntutcZEjhI/aRIW5z297zaNXqfxT8lfdJXeh7Qxqn1983GlP7qM/9SX9jo3znx14
 yScgnCOFoZ/Jw4ZcGpaoK2OlyL8k24aFG+emI+OtfsGUoaNsuhZKR1I2YxZL3DfTprQx
 BVXGslV5mA4qxADYfAlxW/DFXYofEqgqtaNsO/MIbWirrSGKT9+bcMLN5OtGhWrw4l/A
 F5tqXYOiuRsdA7MKXrsj2G5xQ1cGc8YYLERO9KuyfH6WRseCEPTTNvkj8OG57n0+ODPt
 4tMy2s8yRTMkskAWGKQnwUCpEqjkzB1xKE5x/m3qeSnAr0/hP1FQg4yN/ddfE5BOADr3
 17Ug==
X-Gm-Message-State: AOJu0YyKw2ikvnatVVcgaoXggPlK0IoPW9GbP3JqILCXHi4QFPqYbAla
 iFsf71PwYX1xwUcL5LK35r6WPHqQHIYVRj7RRUoLWxBgIkNtdSY/cVFVHQr/Z90GQxrgujAlEuf
 NSik=
X-Google-Smtp-Source: AGHT+IHnjaS4RYW0J/DrWLrkQIs3AwfntAe6ys5bge587BVjdgrltRhadfBVTvU3Vn0PWK4/D7uZCw==
X-Received: by 2002:a05:6214:5408:b0:6cb:5aa6:97a with SMTP id
 6a1803df08f44-6cb81a37809mr84690416d6.24.1727923953202; 
 Wed, 02 Oct 2024 19:52:33 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>
In-Reply-To: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
References: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
Subject: Re: [PATCH v2 0/3] Add Android 14 bootflow support for AM62X and
 AM62P board
Message-Id: <172792395131.1516896.17863834996391400868.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 12 Sep 2024 09:29:56 +0200, Guillaume La Roque wrote:

> Ths patchset add support of Android 14 with boot image version 4
> for :
> - AM62X-SK EVM: https://www.ti.com/tool/SK-AM62B
> - BeaglePlay: https://beagleplay.org/
> - AM62PX-SK EVM: https://www.ti.com/tool/SK-AM62P-LP
> 
> Android Images use to test this series are on the Official TI website:
> - AM62x/BeaglePlay: https://www.ti.com/tool/PROCESSOR-SDK-AM62X
> - AM62PX: https://www.ti.com/tool/PROCESSOR-SDK-AM62P
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


