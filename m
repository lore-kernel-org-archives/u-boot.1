Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC2EE85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DAC384106;
	Fri,  3 Apr 2026 21:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ABRsHi4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720BA84181; Fri,  3 Apr 2026 21:47:20 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF99840ED
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7d4ebccf7so2023199a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245636; x=1775850436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bVsf7Nl7KpwnIR6/hh56nCKaqFkkuZXwBcoZA0uhUdI=;
 b=ABRsHi4pjPbEmkRcVdEc7zhSDHYXZgO3XmnrwEHNe/gP3TepLx3gA1yJHHHmLVAQMF
 B4VYln953oPDyL641K9j+ORcS3zRh+C4pn82snGRafXww1kN3AkvL/L6nRq6QT7o0Jth
 q58WZh7ZYNofZj/AlUcIRAnRFPTOBvwkkZSbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245636; x=1775850436;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bVsf7Nl7KpwnIR6/hh56nCKaqFkkuZXwBcoZA0uhUdI=;
 b=NKbWntZuJc+r8jZVteZogXbo7Vxox1HC/txSboIMZWg0fV0qb0A7QeT7YndfH5nJhc
 W0RxgJpprt6r+ew/bqoZObXNsQkeTnFLowNpiHVh53irVL7gDUc5HLlsOc6/bmBojxvW
 iGAnxLGyydtzKFkI56JYWLK8ATHW2ZFOIWJdVeH4O0aST+9QZyb5J5zXalViq08Eh7Yp
 HYXVd95WWr/k7nd4Zp+tZ9tdqpjmeJTAyo1bGyGCAa+1CXpjjg+Zqn13DvhBzLPFSCOW
 EXszfbzUphQmTZc8rPib6fNhCskY+/yfLufpqWFOeuOnokQF2eKwaI/FkRJ9gN8qbUwH
 wDIQ==
X-Gm-Message-State: AOJu0YyOWio03xPWZbsqCZOS0kQWhygS4fHiL0iILAzWJ7OW43PTYgAM
 jqVkhr7mucQJy6LNZXHO04sJJBQ3KM2UEhq4C0NYGf2QKCvAPF5LhCCjaH+p1xaNuntGgHHi3o9
 4trFAFh4=
X-Gm-Gg: ATEYQzyA4q+ARVooS9j3B+Xjz5A4ZT6r6/8KkabyncyvS4EACEVe+IOvbtx3YO/i11A
 7E/CNwJnugjHJXCamDR+44OGI+fA+vC6oW768WM3VWPL2c11j8Plmv21meKRz7AibXWxkqqzTwM
 hryCkfitNAgwA697fquKbNBPxD3YiY9tQIlCdPNzwoqCUDmiSo0XutNJ5Noy4NCv/7/74GZO9SU
 qAlStIsGS1UZdXnfVMy3jBPZFZGSpcggzGRNBzsqRKYG38KxMxS7045YaUaVfPCkIXBh2VOJS2O
 RdExJJyF2GHBfYHx6/NeoU9EvtYDtmwnzPTscmG4s6+3P+s7oC6WjkaFIgl+CpeXKOYaXT79Dla
 bxuvXI+O801CRfkOiiq+WUxWOE/xHPU9nfz6RhAIA82xeF3va/jX2FTbLvHNOaiRytvw71p1SVs
 So/SRWRFDJp8toA5Fi023aKZkRcJt0w3IaP2e21GjbGG7H4HnL6GuTy70JadwpiiPMXem2NocsN
 5BmpbfFQL/IvRLTBQtQRLa4d6T/QORdFqAmcMgBtCqNVdCgQKhEoaZWQA==
X-Received: by 2002:a05:6830:6d48:b0:7d7:cde1:5440 with SMTP id
 46e09a7af769-7dbb74edfc6mr2633976a34.18.1775245636473; 
 Fri, 03 Apr 2026 12:47:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205332.3788725-1-trini@konsulko.com>
References: <20260320205332.3788725-1-trini@konsulko.com>
Subject: Re: [PATCH] rtc: ds1337: Remove various legacy code and update
 dependencies
Message-Id: <177524563588.2281750.9496005219577543056.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 20 Mar 2026 14:53:32 -0600, Tom Rini wrote:

> At this point there are no users of this driver which do not enable
> DM_RTC, so remove the legacy code and express the depdendency in
> Kconfig. We can further remove code related to RTC chips / options that
> are neither available in Kconfig nor set by any platforms.
> 
> 

Applied to u-boot/next, thanks!

[1/1] rtc: ds1337: Remove various legacy code and update dependencies
      commit: 8c1ffb09d5bda6e94b71fac60aad7f1b1ba4d16a
-- 
Tom


