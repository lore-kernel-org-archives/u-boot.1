Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1BDE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185A980690;
	Tue, 31 Dec 2024 05:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XMEHvuJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7254680690; Tue, 31 Dec 2024 05:05:35 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52CC380584
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b8618be68bso760080185a.3
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735617932; x=1736222732; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoIEPw5vAqlHuYiqcD9+At7eZRw0z76sD5CCC5Wg+K0=;
 b=XMEHvuJDeMz/+JiVdpjlJtIM02SD7092su8XQJwMbPWZywZwrSh9a6SBcRY3/FWwrE
 TdrIivRbUb54S6Hk7RZRbeGXKh6EEeqgfXFdIg1qO28hKH9IIEJEyusqVLoVZHVoQgOw
 ZEWm+3eloHepbD/QzS9qQBaW5PeFH8LUq3PMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735617932; x=1736222732;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoIEPw5vAqlHuYiqcD9+At7eZRw0z76sD5CCC5Wg+K0=;
 b=mdL/JtJO7eZev/nUgbCbyBRUpxfin9wDWMJM3gE08hvjIm/muS2KrINr+cZnTSspNC
 wpOAkXOlxV61ylF2LQAAV6441D7IJAzohcKm8bP4nixXvqF3aC1DPMKNA4Qb0UePWASD
 qZXKid8JR2FxUcpAkqL3nd+5eiVpIzNPbgNITaMtoMgFqP7/VOEGsQpfiEP7kK2OBS6L
 yPJfZ8ZyZ+OGk2O91DawbAqWboEvOCvRc5PzPlOVBA5zcml5ptoFAaXOT9sqADXYsClq
 b1G8wSe/feuSFpKo8/n+ua41dAuDLwHzD4TUNqAKqIKYhzV4JV14xaYTyvqJhtltSl/u
 OiuA==
X-Gm-Message-State: AOJu0YxY1B9TBRWnbjaEjq5o7NPFdq1hbwkbQ++xd98SAGUdFSvphMfF
 dHWvWa5SYeVgz9tF6ZfIF3bz62c6K+J2irdMqTFBvgqOOyP7JLNsa3xlBiKLphU=
X-Gm-Gg: ASbGncvhsWxiCzh1TvnszyVXgruaDTrzb93Xn7gekNcY1Bp3OzIhDuccbDqrlYM1Hmq
 4Xaem99hZVs1NmFaWlStIzEW7gUQy46R2KLHAQ/nIoitOYME8lBHpejxAChHrsl/SfnFJKTtiOV
 7BiC4WIHwPDCqJT+tvGWsWWhUsIetw32Lkoh/xM2DHImmvoCVZFmXlKokP41yJb7qBVGK30ikFw
 /q0sqFChuQy9EgnXhf7WaaacA4lFKhIzmHbeLJ0VdbOlWGHBMi3kGqk
X-Google-Smtp-Source: AGHT+IGbQs0nYnHKr8de5aZA5yv50OQJ4lYY5FBokhyqM+cHEn/1KwHzmZSVp75IpK3f8denKavMvw==
X-Received: by 2002:a05:620a:1b93:b0:7b6:e207:c8a2 with SMTP id
 af79cd13be357-7b9ba8202b5mr7138884085a.55.1735617932247; 
 Mon, 30 Dec 2024 20:05:32 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480886sm976081485a.83.2024.12.30.20.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:05:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241210063505.147762-1-JJLIU0@nuvoton.com>
References: <20241210063505.147762-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v2] gpio: npcm: Add persist feature to sgpio module
Message-Id: <173561793022.257558.14370458221395334587.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 22:05:30 -0600
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

On Tue, 10 Dec 2024 14:35:05 +0800, Jim Liu wrote:

> Base on GPIO hog to support sgpio persist enable feature.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


