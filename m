Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9559FC3DA61
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 23:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB56D885F5;
	Fri, 19 Jul 2024 01:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ui5ATtgL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 459FF88746; Fri, 19 Jul 2024 01:10:21 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DA888AD4
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 01:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d93147ac6bso776811b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721344217; x=1721949017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APp9PgWt2rkBzJb4MR314gehBulobzlQUSQvyvGAYew=;
 b=ui5ATtgLy4EqglS1aw4j96ch035H5KEB20eShZFWPWzOYT8i1OqtksGdktQyicAHrf
 s3ltnFNNdNHcBoIOOH0yqBq/bYUem0u8dVftTQkVnoDV7jCZjGhFfmJtNIzHvg5sc/S+
 gHb6cnBFDKOwenFV0dktxWrq3r2v2bsQn0S5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721344217; x=1721949017;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APp9PgWt2rkBzJb4MR314gehBulobzlQUSQvyvGAYew=;
 b=tdgSg9lU4BaYVG2scHHp+7IsJqu2ttuWbcFsks1hTMXTUsplO6lEu6uIfA9JhSFwT5
 qSHJU7sgwcIxI2vcgJESxIttPwqPbLz9dvgK86VXrNHkvW0Tyj86fIAp6LNRpP/q+qOi
 cYx4KyBNMcfF5gQvubAr+fk7cOfbOYrhCFIkAql9YeoduMYSJHqC/RI+MdRURSvnNGb/
 67SrgVbpX/fVPZ6XaXM0QAeSxFovzrUMlVn6yaaQRdqhYNqBuVFfL5yoMvU5P0I9Yygh
 ISSNC8SMX/iKPfLoAjs0hbv2RYEX699WpYKgB0mrgGYlUyO1bG4ypXvu9vwFnEHa6si1
 /pCA==
X-Gm-Message-State: AOJu0YwTz+rXNIxgShiobu24xCARNptiAeBksFMobGD7cZl+UUP1DpSV
 Xk/S9pn8F1ZX08NoPmvxeaUOitpBn5iKrLuMlfo1ZsScYoPHiGvGt2dY/ggm1Ys=
X-Google-Smtp-Source: AGHT+IEXvtJg/hTi8CVtepD9cv7ADXwAe9vYE/6tlf4ThHapMW0WMS/wpTb/5EQ6SDwR3yuH1+5Vsg==
X-Received: by 2002:a05:6808:1506:b0:3d9:303a:fc6d with SMTP id
 5614622812f47-3dad1f6b44emr6848246b6e.41.1721344217459; 
 Thu, 18 Jul 2024 16:10:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dae09ce8aasm55128b6e.45.2024.07.18.16.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 16:10:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Marek Vasut <marex@denx.de>
In-Reply-To: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 0/5] finish using .dtso for overlay source files
Message-Id: <172134421663.2776895.9972329671939660065.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 17:10:16 -0600
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

On Wed, 10 Jul 2024 09:16:07 +0200, Rasmus Villemoes wrote:

> This is a followup to the patches that landed in 2024.01 and nearly
> made sure that source files for producing .dtbo files use the .dtso
> extension. In the same release, a few new .dts files snuck in, and
> there was also some test code involving .dtbo -> .dtbo.S -> .dtbo.o I
> didn't really know how to handle at the time. This should finish the
> job, bring us in sync with linux (at least in this respect), and drop
> the .dts -> .dtbo build rule.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


