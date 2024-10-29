Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11DFD74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 828B989202;
	Tue, 29 Oct 2024 23:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UoKAWTRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B819A891E1; Tue, 29 Oct 2024 23:28:36 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E389891E3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-50d479aef64so1909089e0c.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240912; x=1730845712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQPk7IdODqz08ndrxOZ9lHCDQxyovSfi6LwWSGE3j8Y=;
 b=UoKAWTRj9SeK0ed9R6SqvAWPoBHF1HtgG07q1ARDsSNOhgVuEIhsMopvYeDY6RFbwv
 tMWmVVgZBtMWIp5Eaxo7E/smWP0n10Nb3+Iu8PZgDjHgb9or1FQBgpqPQlMYgoei9O8m
 ibSUYfertGaY+s1MNKSD6FOwdHWK7RJ4y8Ez4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240912; x=1730845712;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQPk7IdODqz08ndrxOZ9lHCDQxyovSfi6LwWSGE3j8Y=;
 b=kVgPwgFQscjhzxuL17o9nIpjHLWbF6ARvVywRpuigl2l2NEebcEwlgOmud5bk98+TV
 3FqOL//VyyqVsaWD1ST+62iZuIb2gCcqBcvmdb/9lnEXUo1jnLLUF+hc3nA7keMXVyzR
 ZSsYKmw9ASCrbyFmR3MMa/hl90KKxSdTIPzcGlNqW30V6b3ChEIcIM+Ai3SfZPaABfLs
 6e/xChoL2Pzr6sM9tzllhVnVY1jPg6od8p+GBpt2lHVu1RgtoW3hxR6EyCXhwsfjzqGK
 TS658U618DR0MD41vs1CdpXmAEeF6fthg1KzIQ6lo+sfEC7zBBNCiisSpIxVyaD8sUZQ
 9XZQ==
X-Gm-Message-State: AOJu0Yz55fBP+UoakjmkRq4HgyQRKWN0xQcbxi4z92SA+x+krsuZ06Eo
 p+/bVkTlz6aCKldQ7I9EyS9NUe6BArTbDcCX4gJNremmGNNn0A1NgQ0SpiaaElyom89F4sKTU2i
 FuVk=
X-Google-Smtp-Source: AGHT+IG4Xziog2tFIYaRuVe8+jwByQvOdCIf8RUK5QIdff/C4WW/Q/ej2J6kgZbuQkrwHL1fVhIh9g==
X-Received: by 2002:a05:6122:2509:b0:50c:eb10:9799 with SMTP id
 71dfb90a1353d-51014ff6942mr10740072e0c.1.1730240912179; 
 Tue, 29 Oct 2024 15:28:32 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
In-Reply-To: <20241026140959.1692717-1-trini@konsulko.com>
References: <20241026140959.1692717-1-trini@konsulko.com>
Subject: Re: [PATCHv2] Kconfig: Remove TARGET_TRICORDER references
Message-Id: <173024091048.2563570.16236786184646862514.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 26 Oct 2024 08:09:59 -0600, Tom Rini wrote:

> These were missed when removing the rest of the tricorder platform.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


