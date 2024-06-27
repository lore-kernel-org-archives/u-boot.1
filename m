Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680C3C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 20:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC5F0881EC;
	Thu, 27 Jun 2024 22:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAZF6zqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD07884FD; Thu, 27 Jun 2024 22:29:14 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD1C880C5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 22:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-425624255f3so10920475e9.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719520152; x=1720124952; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GLv0XMF2u2HeAZ1VUXPBPwqCXoeHlssgwDJR825pvZY=;
 b=FAZF6zqm9r5GLL0v0JHQtMru1onVkoMHYlN5QBvkryxPDTsRHHDjyjgrpHM6M8LgUJ
 BpNFeDDgQSEafbbkHWfYnVNCU6cPiFHp7h5y6FmI+q9IIDldFOu3GGlO0MpwoDx8NOUs
 IRyX0pQX/+AITVQieZtUsA/2gs55tfVln3nfdnmuKj7SXZhYdognvXLG7aPlG4RcpQNa
 4b7S+1YDQ0jAun787dH+a9z2Z/XiEAWOSg+qQuxS3OF3COjU2o3qdouM2mqdzCdqoj10
 HkVCDhNm07YG8OdmKoOIlSxHTP7zLqL+EiXtYlo6zQU3ifU0JziptNFUZKhq3mQGj6Q+
 cxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719520152; x=1720124952;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLv0XMF2u2HeAZ1VUXPBPwqCXoeHlssgwDJR825pvZY=;
 b=Akz4WFivDp4fY07BD/PPzBC+wamby3p983rQtjEXXKChkOL8qt4k/GdqfymWf+hsQd
 HfkQ9wzzdoWCs45VSbvaQ23EOIahPBdAkYrA9Tdllt9TgPug3P1G859Yjr5bip6kQPTR
 KvvCoV6vU65Z5Py0lc9OgUhXK/82C7oCPgOPFelBYyogKadFVmXwQg174fimtdWwKWMc
 /e8hn5JwRxbLZjX0k7HTHLizokhH4TPQGKOJi17MwSwIaY5AqHwWi+bpG59N6vaHpuwH
 Q79YU+JBcDOVBcK153Qi655jWgBaGGzw3mrC1yYZETJeDKqg1iSrIdz2Og61XRDtuCp7
 xkOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBHK8wiM3jbWNCC7WDN9ZTOxJimfhR07r7h+FZnfA8BJ69rIb9/l90+yTlXiqbyMXYwIYnAMhuwFYlIVtbSX/XfDB/bg==
X-Gm-Message-State: AOJu0YzJnvePGVuaCKfAPoCyONP+8LxLQnoWq3TXo7AwfUhyMa0SM4Lu
 xUAiy+PxTChXap0EgEy5OVa04ZykQyfbEMzGUrDaf0z99M9AKO1q
X-Google-Smtp-Source: AGHT+IEhJsCsRNO0eWE77u/fMiYVj6ztjn1gB5I+C9eujmPwRL5phcTzbsnxwgP9n6IaEFQoIlpY7g==
X-Received: by 2002:a05:600c:68c4:b0:425:6485:7667 with SMTP id
 5b1f17b1804b1-4256485768dmr28045135e9.4.1719520151922; 
 Thu, 27 Jun 2024 13:29:11 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097b77sm6002625e9.33.2024.06.27.13.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 13:29:11 -0700 (PDT)
Message-ID: <667dcb97.050a0220.98d34.34cd@mx.google.com>
X-Google-Original-Message-ID: <Zn3LmUr2jI9KYhj0@Ansuel-XPS.>
Date: Thu, 27 Jun 2024 22:29:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
Subject: Re: [PATCH 1/2] led: Implement software led blinking
References: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627193609.GF38804@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627193609.GF38804@bill-the-cat>
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

On Thu, Jun 27, 2024 at 01:36:09PM -0600, Tom Rini wrote:
> On Thu, Jun 27, 2024 at 02:31:13PM +0300, Mikhail Kshevetskiy wrote:
> 
> > From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> > 
> > If hardware (or driver) doesn't support leds blinking, it's
> > now possible to use software implementation of blinking instead.
> > This relies on cyclic functions.
> > 
> > Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> > ---
> >  drivers/led/Kconfig      |   9 ++
> >  drivers/led/led-uclass.c | 190 ++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 195 insertions(+), 4 deletions(-)
> 
> As one of those "well, hunh" kind of moment, I'm cc'ing Christian
> Marangi who also just posted patches foor this kind of functionality.
> 

Eh... Well this implementation is better. I had the idea of adding
support on the uclass level but I preferred to limit it only to GPIO.

Think this would match how it's done in upstream linux kernel so I think
mine should be ignored and this taken (for sw blink).

Should not change a thing for the series since all the bits were using
generic LED functions.

-- 
	Ansuel
