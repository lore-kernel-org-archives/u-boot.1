Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C9C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D39889C5;
	Tue, 30 Apr 2024 01:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AXdDCKME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C2F889C5; Tue, 30 Apr 2024 01:04:12 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29EEE889B9
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78f04924a96so420786285a.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431848; x=1715036648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=odeVriCOpZrzkd5z1lYMPjPjPoNds3iK6ddswkbEKnE=;
 b=AXdDCKMET5gRIlmhV4nf8WMh+SN0r8VF5YGSnszyHQr4eRGqIM0f0ZaMRscmCld+Wf
 jPoQ02wBFr76y0Tls9DGADIWzJerYWdXh+KjxQ545sawM/ibP9hFeoAlnS0QDv8kAfLV
 OLO8qmp/P4LVm2IBV0sYCwDUQjbE4PJPEZ30c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431848; x=1715036648;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odeVriCOpZrzkd5z1lYMPjPjPoNds3iK6ddswkbEKnE=;
 b=MFGrGn5h1N9bNTxs2PW4H7SXzZqLlXk/8WBw770hNwiGUCckvUJsdLJb3qAgoAnOj6
 au66ntYq7DRJgm7sEJgWbhWKd5EIiAfRhejtrbASH4Rqv7XfydjHb/UQeZV+A2iy4R2p
 AcwtF67IsN6+ZSlv7dktQJ+J4Lgh5yFLzzpGzfdABo3sfPoEaf1j+q6J0MKq+NczR12C
 2T53bweFHLuByPDbPvgwppZ7OGw1SV2jSg052Oy15gR/CEgJjkfelk9CxYhr3dU5rtUX
 IkrzKIqGCCnbCG9C4j/IZRQB6az46SV5kOxc9DthbyVK3IHwkluTmFk2yl7D33yvTGFl
 7nhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Hw77EGTJKXf0tpRV+lwEh8wgGgx9s5Cd/O1dWwtrWM29DIvVsgouCEbr7E2x7WmHU0jY3eAnyugq8tEmRh1Asc8P+Q==
X-Gm-Message-State: AOJu0YzWF9IWkOI397s4+Nw+HOxASkqCRpml5/SoSsEXVQORucR8WLWT
 xDVzSpK0gIAeUJdCfEd0IGLXtQSpBTMhEgXwkLLcsWlFKcydkktieYJDEoSTEcKrtPl8Bhhl3DX
 s1pg2gg==
X-Google-Smtp-Source: AGHT+IE60UFr0JZed+2PPP3ZUZRhFLENEx8h51aIjzhopPMM2kHeWJNZ+gQzPZJpCusOiJGsRDtpEg==
X-Received: by 2002:a05:620a:221b:b0:790:9974:733b with SMTP id
 m27-20020a05620a221b00b007909974733bmr12387620qkh.35.1714431848600; 
 Mon, 29 Apr 2024 16:04:08 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20240418131302.19693-1-francesco@dolcini.it>
References: <20240418131302.19693-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] board: toradex: verdin-am62: Remove not needed env
 variables
Message-Id: <171443184756.1749944.13252726345212019342.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:07 -0600
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

On Thu, 18 Apr 2024 15:13:02 +0200, Francesco Dolcini wrote:

> Remove not needed variables from environment.
> 
>  - boot_scripts is not needed, the default value is just fine and
>    already includes boot.scr
>  - setup variable used to be executed from some bootscript, however
>    it's not required and there is no point on having this small helper
>    here
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


