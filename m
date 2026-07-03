Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A57C44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA1084A75;
	Fri,  3 Jul 2026 22:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Btob2x7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D5684ADC; Fri,  3 Jul 2026 22:50:58 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE980849F0
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a1133217easo269297eaf.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783111853; x=1783716653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pAvouK9Er/LlqpABUUP6HZ1uMCCSIm4Lip9bAxZDcqY=;
 b=Btob2x7Hj8ZXHWRuybMK5QFzxdjpIWelSXch+xNEJUv5XOgXdd+1ykHR83pZzICg3k
 PbV7FODi/TXiM2CXIpQVPy46NYZs6MNTChG7N145KgQLPHwq1dP3AbZfk8kSRL7hYOD9
 qaAgzNcSNlQLrevXb9L+aWHAf78wr3jzhXwME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783111853; x=1783716653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pAvouK9Er/LlqpABUUP6HZ1uMCCSIm4Lip9bAxZDcqY=;
 b=MzSgGLkRmZGYpc9UNGZYFtnjvVAM2Mk2Bt34Np6ciHniatnqEItPOjWAWlCvZ6ixqg
 T0O8AOtBqiWOV6/ENhJME1SBevnFeHWncod75majNxPKS4q2Xr8KrYr1qFLuefC+UTaU
 c0W1K96ewYse4wSDuKeTq7YTtPwCCU4bzhowGtM9H+u47DaHxXrn9B5n1xrX8RozGySX
 Ry8RgosQJlLFIZScfb2XENcpc2CVz/s6n3R4AqMlKjl/9AE5JeO7zPQRAqcJi0tJCbNV
 G5bdDJcmxJ8N6tAU7/2CjlrmEgtTvHizjt/uDN4oBlBXasCuMpE/xSI6Hy+riLrWaUEs
 N48g==
X-Gm-Message-State: AOJu0YykSFaAMacpQn95M0SdplHggMRsqY3qyADnF77dMTBv7LQ79Qy6
 lLMH8D6iwVLL9IXj7MSin8xoCjkR7TCGCjHk6y2D9iGZyTtqoaWz/UNquNbbgf9KuGCuHz6fqLR
 1b65IRlU=
X-Gm-Gg: AfdE7cmjHoGzLcvtZyRYLuO+g1FvQTymPd+RtpMUOtjk1oIBB1LJ5axTKMxzae86GX0
 /n+j4dNiFD9gLiHJgRWJcVPAkZky1uBNR621DIQwfY+wkZUCVt/KlhhMQl6rqishMc4cxlK2jfa
 WCyXFYnlK/nH9oYAp+/pgaQ1WS+UTBG6VSDvs5IYrdwFGq72iyNHSOJLD6J8XBFG17/8zC6yLbJ
 s6QuRC7gJ2rhTzFyRy8iGncJ+iTDMAgGxJaQ2vD6mSSYc/+DvMz1KYC7+Wwp6VBHJYPGReSD/wJ
 Sy1F04DJnELFBI9boK7ztcgdaSbDbwMRukpJMrEtcdpe8lOe8NicvSxVQUUhSIy/LAjQinKqszr
 syfj26aBZZ32St4P/P/zItEPnzeZghCMimz6GMnCKcUSjcT9iDwnWHVXOLf4AMF9s/zYiXi+GGe
 LsjwsMaGw9buslp1auTaUcqq0jY9AcW1XkFAhJt0jWWkmnXi8HtZBSYQ32wRSuThqld5ap7aMBE
 op3dH6i/gH8O0Z2zp4PpTpzRV7cZGZB7Jh8
X-Received: by 2002:a05:6820:4b96:b0:69e:b788:36da with SMTP id
 006d021491bc7-6a32f5c75a4mr503280eaf.37.1783111853444; 
 Fri, 03 Jul 2026 13:50:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm3088491fac.17.2026.07.03.13.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:50:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
In-Reply-To: <20260629-typo1-v1-1-317f272c4441@linaro.org>
References: <20260629-typo1-v1-1-317f272c4441@linaro.org>
Subject: Re: [PATCH] Kconfig: Fix grammatical error in help text
Message-Id: <178311185281.3143424.860923030622027777.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:50:52 -0600
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

On Mon, 29 Jun 2026 18:06:49 +0100, Andrew Goodbody wrote:

> Fix the incorrect use of 'your' instead of 'you are' and reflow the text
> around it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Kconfig: Fix grammatical error in help text
      commit: a215eb7dd84e438ed66518714394dec1c4f7ce30
-- 
Tom


