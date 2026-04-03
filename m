Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64305E8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA85841F2;
	Fri,  3 Apr 2026 21:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SVkwZTFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63299841D5; Fri,  3 Apr 2026 21:47:27 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C81284178
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46808125c65so745666b6e.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245644; x=1775850444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=los3EwhVpNeSH5YkiPm6C/qOdIVh0ins1I4iB+1F8TU=;
 b=SVkwZTFL7lPe39hpx2EIDxXKgoDkQF8hZYIhjbqDUAQzsOcxfJv6g+1ezTRdSJj6+V
 daEZOxdz6x5LRcIANx4zyZlyQq+4NulWDUZeKEhq2S/DqjCX8TTlAXkeywF8Pg8e1TAZ
 BYm8ZKMEgXSWoJsvWndw8OfOH+UXtc6yWxu9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245644; x=1775850444;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=los3EwhVpNeSH5YkiPm6C/qOdIVh0ins1I4iB+1F8TU=;
 b=EL2CQ7DbkIbpZuSTPvRas22NwVG0UDpAZojMe+Y6nf411TmAKglF9P1SUEx0uA26mr
 HLyjbp9FX+MCB7uRf3AUbL/RS/dHHVsTELosV+J/XMSmhkWbnrQXbrUJG8+LqIHM88ig
 xux+tEuf63WVj1bf9O3EOv8RCdmq09/zVv7PyI1+X8sUq2N6A24iShlMR/Au+jqg8gWf
 55j13BKsAwfvg4iqemACDXRDBAHZZ8hmax4c5zmPpHp2rD3e+Pw8fFkOgONmm/3Jn2YF
 GrQ9HOUWhpi8qwo4iGeMd21twLIleFMNvk8QpqjhrRG/xKGACipgDSY4NYM5p+3WoeB0
 FJ6w==
X-Gm-Message-State: AOJu0Ywgu71/IhIoTb5coUvAfww7SfjsHH/J4X+/uoZHjldwf2samuEb
 4quLOJMqQGX7eOdq6S7cYyiA7/6I26QSrRHLVwV4yCgkB6BHvgrrI51UbGEPAtsFFk/yFMt7yqf
 lt+Bv3/A=
X-Gm-Gg: ATEYQzxVBcxHSEkL+d39lNSKEMyjz0F5Rh5lzUPEjTJ3ajlTBlI4NQ+BxeQf68N7n3Y
 ElGuKTCpNa4LOY5x0+2Xx92lLc5qvuocn8Y6rcDWC3F3OIN5tSzM3gDtDte4uveefwCO3/8vrNk
 D7725jTVmI7xFopcxvJGsCIbrb/FKJprV2vNtWAW7ASEruLxhvJ2SR3XhKC3RHtJZRWMRHww+T1
 cW6GALzgPixhhIFnf6mEfsTov0pvKX8MLU3gu+vmS6GZ55ShClVk42PqHYExfvhblCl7BF7MDcB
 1xHNlC9g8Mqdi1Twhj5mQcI/SEzluAAb7scxreUmuDIEWioI/ljuACvcRrpKMp/HNuk0MC6NVgi
 Gss4LnXOraWm2iTcXYpJ8NLdkPZYe1EVuMnCGvQzgVX/U2iOp7yYSamY4DtNMlcJ8FJ7s4cotmm
 Aop95CULjKB87DsLwqeKP4NL2ccSDTfrroVXeG9q26Gu6q2W1fA+qGXsfMGzTSpFj9Xamk8yShf
 QgVgqLxVxq4ty5Ux6UpeVXuRGlT/nuR2voY4ywW9kV7vbM=
X-Received: by 2002:a05:6808:4fc8:b0:468:bfcc:11fa with SMTP id
 5614622812f47-46ef821476emr2051987b6e.38.1775245644032; 
 Fri, 03 Apr 2026 12:47:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205348.3789079-1-trini@konsulko.com>
References: <20260320205348.3789079-1-trini@konsulko.com>
Subject: Re: [PATCH] gpio: Correct dependencies for legacy CMD_PCA953X
Message-Id: <177524564348.2281750.12705556458378334264.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:23 -0600
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

On Fri, 20 Mar 2026 14:53:48 -0600, Tom Rini wrote:

> The legacy CMD_PCA953X command can only be built when the matching
> legacy driver is enabled, add that dependency to Kconfig.
> 
> 

Applied to u-boot/next, thanks!

[1/1] gpio: Correct dependencies for legacy CMD_PCA953X
      commit: 56b896511c0ed9e2b2f9df9a400c3bb1e9659f1f
-- 
Tom


