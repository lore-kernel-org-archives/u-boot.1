Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9229CE7AA0
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 21:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1049088440;
	Thu,  5 Sep 2024 23:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CvR97nfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E657A88CC6; Thu,  5 Sep 2024 23:53:40 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FF588001
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 23:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-27045e54272so729773fac.0
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 14:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725573217; x=1726178017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G35gR2E2+YjjF/EhycLWgtc2t7/ccir2fAA+yvHv7x8=;
 b=CvR97nfCnTYTQ/1YnZWxnJaGve06vnQjgvlMLrgoSZStvdf4s2s4XeiHjr2XMRTvZa
 tO0kJD6E7b+1sMosrZwg2CHpyIIJzIltHZEzG1KCNSj32HtGqjLiSxkb+uHPbS/kx8Rq
 zjGYd3JJue+aWZ/SBKzjsAscW3prvs6SjQq40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725573217; x=1726178017;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G35gR2E2+YjjF/EhycLWgtc2t7/ccir2fAA+yvHv7x8=;
 b=lcoJcFvFSxSo7It3KE33pQR0eeX+ZT82ab1PEaR5CCLjnZkzZgQyABVg36hXt0uOrj
 +J6232g+ta8WzkYPzddX9nlA4HgMeQ/UlCYEE3kOp235MxhYYrWUd+L+EYbEX6oSM6V+
 J8ud8Ii0O6xgzpCG8+n5Uu96RYgm/qL90UIZR2vV9wC4FG2MGiZWz7yMXOUGgM1mDgJQ
 Q7YqO4YUffJJ+rNEt7YmIK6+kmYO25j3sZMPwYlOoE8ChxXvGcPF0F5TSrLGPXW0llke
 8SeAjReyMXchrPQFRjkForkGuhGYhycd5bt5ums86HReeHCBXnWRL67la45YM4OwOe/I
 sHCw==
X-Gm-Message-State: AOJu0YxstD/ITQ+CtlAth0mXvFGddKCyMcg5PiCDySq3UpQo2GQXALtU
 pH1AgYRTEumeF7xC1NkaFt79hjU6Yhpx3VTrh7UI31fsDURrNeibBOYAmfAE3VIahbdyJc6r8Mw
 dvdU=
X-Google-Smtp-Source: AGHT+IGI3y6oMssTNtfaKWOxs/nK31oz8esNfBkq0L1+/luJPuaoVjdP2jlzwO/ApdBCoyR1pY9/FA==
X-Received: by 2002:a05:6871:82c:b0:277:e1e8:a085 with SMTP id
 586e51a60fabf-27b82e8b0ffmr771152fac.23.1725573217517; 
 Thu, 05 Sep 2024 14:53:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a98efeb91dsm111404985a.94.2024.09.05.14.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 14:53:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Dragan Simic <dsimic@manjaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Avri Altman <avri.altman@wdc.com>
In-Reply-To: <20240531153635.246154-1-tharvey@gateworks.com>
References: <20240531153635.246154-1-tharvey@gateworks.com>
Subject: Re: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
Message-Id: <172557321583.1821583.17172986472580226946.b4-ty@konsulko.com>
Date: Thu, 05 Sep 2024 15:53:35 -0600
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

On Fri, 31 May 2024 08:36:32 -0700, Tim Harvey wrote:

> Modern eMMC v4+ devices have multiple hardware partitions per the JEDEC
> specification described as:
>  Boot Area Partition 1
>  Boot Area Partition 2
>  RPMB Partition
>  General Purpose Partition 1
>  General Purpose Partition 2
>  General Purpose Partition 3
>  General Purpose Partition 4
>  User Data Area
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


