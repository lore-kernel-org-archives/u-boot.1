Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2A4C5AD5A
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 22:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E79F96061C;
	Sun,  9 Aug 2026 22:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9BDpibsKw3Sa; Sun,  9 Aug 2026 22:08:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53B06605EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786313301;
	bh=KeYrrO2WmTl6zlDN6TOCDgDSmr5+0Z7/NCPDP/vwm0E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lyx+5mWg4P6wb3ERmilUg2Py6AyYAF4kOoWFaMlh/Fh6E1A0wmjdqGPFFfu0l0Pc5
	 sS17Tp97Bg3uyJRPx1EmPtfVmdkMzru4ceXZCdzYtetma9Nb/M5Fj/CZ1J6wxWFztg
	 y6aW1Zk3CIfaCG3HDfYlsilTuesWZGWhTz9SHIQu7LUYlJaCQ5nowXQRKM9qHq3Dhc
	 XKP7hZUYdJyTpgaXXmgLeH1u5m48xc60mtTx/n5QtDcoLCDIXn5xAaMlvTQGdvpYbD
	 buDeu6dfjQzJvKlu9jReSBVk5nsmmjOOBcV0GlFJAFQ83+gcWQSq3RT4wpRhkAnwYf
	 Za6mFQJhrXLeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53B06605EE;
	Sun,  9 Aug 2026 22:08:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1518B296
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 22:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06EF1605EE
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 22:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7SrsVAo8dTl for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 22:08:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 41F09605D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41F09605D4
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 41F09605D4
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 22:08:18 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6aae36ea5c4so772937eaf.1
 for <u-boot@lists.u-boot-project.org>; Sun, 09 Aug 2026 15:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786313298; x=1786918098;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KeYrrO2WmTl6zlDN6TOCDgDSmr5+0Z7/NCPDP/vwm0E=;
 b=lFcnOUywNS+L5S2v5Q+XLLofrd4lmNTfm9wu2x92/IX11LD2ZdZBPFr6KfzJtGiyKk
 cZxBIjjUXnhAQKJTnxu4B8c87dzUEoMeaESM/LANok/vN+PgiV74YsDjdu+x8YzgQyG3
 jKUHmUnMh6g57BuPjZndYM6hxbGXjZAeeXihR5ijKVihj402ejv0Usb5DFspfWj+HPnT
 u1zw4vc0vJLzMXdE1WTi9CmAXoF2vFT9aodNcLmeVezVmdC1m+5sLRwoelwb8eKHN5tI
 3xU5i8N4lR8fKt4GsocmZ5y0vjgp1cQR6bLmX8e+isFnjuuTgkM2OArneSJ+dtKMjvgV
 xsMg==
X-Gm-Message-State: AOJu0YwVfMakPl+4qoMCl2ouNDEXApNX2BEbm4RQD6UiXf2TqYIRWgQ3
 ytN9036FvOt3PO4bTqXSYw+bnXB+NggkD9S9On4gS8eYURyE1y0BNQgIO/svH0dICzO9/D9qzTM
 oU3deFVY=
X-Gm-Gg: AR+sD10Sq6R/mPcWNk0fyCxCzUdvArypD1hTklBAItw1hh6b67+wKc6L92Ti26P1z42
 pCGYci9mC7+In8OIcvCGAzHk0f2IkDv+ljISJEjfjr87NEjiib4fDTrl0d1yK9qwPxpGyRsSQGw
 SErW1TsXGoyL28XjzKadCgwvz2cXZr7m3p5AR0ZCBzQ6s2qjYNlmWZZE6DF5o8blNlvIWgO/yh2
 ZoyzEAxt2tYq1PrJjhMWpq2oTPZ9YXhqkQAupHmgithhqAMJQ2uEaoho2FxrsKhLK1jUcGS36DJ
 pt6Ncg+mm/7FuvG7HiHoeBpB8XzF05IirRRgZFAlCcygKQzRBKRRPluLpztE7ywwBb5UHHMTjYo
 s3Ofl2NZGmqcDM0vRKJppPYKHRx9eYh9OaXDZ80aQZpdH3oRwWjAAr374icv8IEnL0CPXrvifjG
 uSWA0Hpk//1FBKPgOFH/O4X+lOSPs5pxBwhiGCCQN3f6bYTOTDyjigBnym8lpf0iIfb0bmeSMxS
 ujwpUwyu+8lIit5l6/RD6MeXpluGqDiVdQr0EKw0jN18tMZ2tdB73degZrQryLOsQ8h/t6ajJqp
 Z23a+oP7
X-Received: by 2002:a05:6820:188e:b0:6ae:46cd:e908 with SMTP id
 006d021491bc7-6ae96ec7afdmr20937286eaf.17.1786313298017; 
 Sun, 09 Aug 2026 15:08:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be475b6sm7881835eaf.11.2026.08.09.15.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:08:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260808042549.145756-1-marek.vasut+renesas@mailbox.org>
References: <20260808042549.145756-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/main
Message-Id: <178631329692.1212230.12098030971679985934.b4-ty@konsulko.com>
Date: Sun, 09 Aug 2026 16:08:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786313298; x=1786918098;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KeYrrO2WmTl6zlDN6TOCDgDSmr5+0Z7/NCPDP/vwm0E=;
 b=GbE+PcdFoznG7nAd4OHYdVnudiRMpNijYlfTja/6g280jG8FBG/f7y16ACOD194QQT
 fO3mLUKli1R/hO275vs7XKbuIOg54eX2xrZJzJWElMmFwpMYcFNJ1nJY41JPeHKwXz+3
 Yv4t3u4kJJyLEd6sanq4uf8h4p0pX7j7YVlS8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GbE+PcdF
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, 8 Aug 2026 06:22:48 +0200, Marek Vasut wrote:

> This includes temporary U-Boot DT ECC carveouts for R-Car Gen5, they
> will be dropped from U-Boot DTs once OF_UPSTREAM DTs get re-synced.
> This also includes RPC-IF support for R-Car Gen5 and env storage in
> RPC HF.
> This also includes an update for R-Car Gen5 UFS controller driver.
> 
> The following changes since commit 06c866fee0052579dbd27456fac425d002d44a80:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


