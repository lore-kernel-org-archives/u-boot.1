Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D619D1D488
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C46E484286;
	Thu,  8 Jan 2026 20:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JJDRhA2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8662D84132; Thu,  8 Jan 2026 20:36:57 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFEB8415E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7c78d30649aso2462890a34.2
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767901014; x=1768505814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C05H+ZTLdOC7R+1X+mnN8Zf2Lvrr+ry5yfo7Tj6U2Lk=;
 b=JJDRhA2CE6/SncYkLv0e1Z2scQksHASp7JYz9ANX6Ci135bco9PBtc8LRusQWOLyIe
 h0vF0ll/SZJ600DeY2+LgVNG9Cao+/t/QAQtVVm/zzldIHupXar2FVKdSWP3vyw9rbpM
 XwhV2044XCgeNAthWM/Sq+4IT886zlPxDVLIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767901014; x=1768505814;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C05H+ZTLdOC7R+1X+mnN8Zf2Lvrr+ry5yfo7Tj6U2Lk=;
 b=LqNNSker2P9W28v1ykvP7xGwyIPlO4786Bp2NPiThIq78zT87IBEWeLnjV7O5t9V3r
 RS7ZLINZL7433i5Y1afRVLN4WOFognt6/4NU3Pirg1K7abXzchCpvN44j2rG5X8QG6ZR
 ufuEgiPmEgA7Q9arlv72H8UFoawkleinHT1ptcZoghlWMNR9FrhepnHRrg8+Y3u47bWB
 VqeotEKCuxONTVxfeyIpObvCU9S5cVB3BLoxIlCpqPmYuGwPEoQrHtyLEeUbeiRSKgI8
 x+3fyGWp6/0AbTPNGP/PQejtukEQin90bWUeAmuCxZTZK0h5UkYxVD7OsLA7RJKSf9Bn
 r5+A==
X-Gm-Message-State: AOJu0YxnyfcjxXpkav44/HZCtXlP+D55HcZhHqisDHlNlIS9T3w5UGQd
 nPU5tt66rM+Zbkbh5LEC8Ucc8sCgrk23oeGiDBb69D6W9rT7zlKTjpfEAeXYOs0kDv4CaFnigzS
 Ujf3oowI=
X-Gm-Gg: AY/fxX7/JjIMAxPLnm+0laKYpqlienJDtMI8Ypd8YCehXnXG7ZWwyiCpzULt0I0iLpk
 gJhD35FAcX1SLGXuYY+6+tLJahhc/kOkvisTrNfdEGbyDx6mZwV1ywO1w72SM5GcWPQ9CpPC5VK
 ke2fTvLYGWwHchF+/TAFSQSW5VN25jIK+qLqoOXglxjLpc6FegerFMo+637aH8Y0lx4+EubdEGX
 Uo3IGofInIT570anlZTrRur8DBxjt7oZM8XSeIYFdNZzxWIAsjOb8yPTgsg3HQIBZ35RCJFX4QV
 BhiMMGzFEqeeD8oJ8L3OtGWWcA3/EBn48qghw5eYO9HgsUOF2fcf4VCHC9bHMiLEltBkKw9w3yw
 hxewnYnDhnxE2QG2R6HV/81kJUC/2MzzQIp6GtIeirl7FmSoLkXIJ6uPFzLyvZMy6XbMQWWHlqJ
 tmdGY/Naf+X0Oq4BaQBpNEvWZQ6udRg31pIJ3JLZ9DA9nT77nyjWlWBQBMQzBaLXUIZlVf0Jie7
 XjVMiElZDJJQht1fMyHCLLNdlkJzxyb5O+lxPcR0hW7yCVn
X-Google-Smtp-Source: AGHT+IGiZJT+mptWVJ2SV1cyxgUcgBReZ/XZfafj3xEBJ5eo6vWnZLL0MupnsbAN9qIYenBRpWrmaA==
X-Received: by 2002:a05:6830:43a0:b0:7c9:5bef:e9b with SMTP id
 46e09a7af769-7ce508a5f79mr4479566a34.3.1767901014152; 
 Thu, 08 Jan 2026 11:36:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce4781c447sm5950108a34.9.2026.01.08.11.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 11:36:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
In-Reply-To: <20260108151111.11593-1-marek.vasut+usb@mailbox.org>
References: <20260108151111.11593-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <176790101348.1229465.18209225993296676944.b4-ty@konsulko.com>
Date: Thu, 08 Jan 2026 13:36:53 -0600
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

On Thu, 08 Jan 2026 16:11:01 +0100, Marek Vasut wrote:

> The following changes since commit 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6:
> 
>   Merge patch series "test: env: Add test for environment storage in SPI NOR" (2026-01-07 12:31:56 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


