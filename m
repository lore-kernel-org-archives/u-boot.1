Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C5ACF9C6F
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 14:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BA988A0D;
	Tue, 24 Sep 2024 16:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bxsv8LvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D948F88A0D; Tue, 24 Sep 2024 16:29:59 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF0A88AC2
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a99e8d5df1so569875885a.2
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 07:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727188195; x=1727792995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PATTZiY2rH41+DaiRDhmgf4TZHSb3rBbXL0FmLfSdEA=;
 b=bxsv8LvXumu1YPiH1+qUV/SQIuuqNBcfhj/89qNVEWYA9pfMQrzpK+mGrTq9ZWMIv9
 8rlo0tvoDl6sq799KymgwXPvR50ontdlqapZbqaWmc73ha3qEwIF/RSWJGnBOuWP0MiX
 keIXzEQr+dfYEqSTmllB4fE34imWs+Aq6I3DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727188195; x=1727792995;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PATTZiY2rH41+DaiRDhmgf4TZHSb3rBbXL0FmLfSdEA=;
 b=FCsXxtYwMB4KnDp71lcwc+KgaP5SkzIV1j4ym/YejjhXfcx0CzyPCbkL6+hj7NuIFY
 mnX1IBGawmSp0vT8vIKcgqmc5b5aOXEt9bEunC8PL26ZPam4Al2f8YqkXrJVN+U+WHSq
 ZDopOU5XJeNqxWH20vMmfaFq/CmItmda1Rd8AmDPPFe6Z+upwlVh53TI4nUj7KRahdGJ
 tEoaWP6rmnYTwVuSlfh/uZ1qb7d96qyO2pLlhYvyEeOyG3d9GpK96i48u8JUDmv4S2DU
 9d18kLezZgtpBeg3tWpZwuzm4X9+/aHfksuwj0KqheMHX5qCVSSLVjwrRSgqMEPK/BFj
 vGFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2CBvhnqtJHKBNrhLXMiceLywf5rbFVVsZ7fWDTR41S8jqFxh/Ylr4iaCWi6t7Zq90jgJWR7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxhIPhrjczKVghChjMcVZy3szwOTiLXPJs6q40nh21gai6GU3Dn
 SNhrhV/FyqbwznjG1OzLwAoGLXdHKfv4zJz+q4wQD0E2l/x5NWIC9+i7B0luVmQ=
X-Google-Smtp-Source: AGHT+IGxVtOYNc/dETC4GVy5JIOQ9lrIv185DM7X2T0Ajpbmjy1L23wFUKPa+E3+Db/ZXN3EK+dKng==
X-Received: by 2002:a05:620a:410:b0:7ac:d673:205a with SMTP id
 af79cd13be357-7acd6732194mr645615885a.38.1727188195175; 
 Tue, 24 Sep 2024 07:29:55 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde56863esm73556985a.62.2024.09.24.07.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 07:29:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, n-francis@ti.com, bb@ti.com, 
 Andreas Dannenberg <dannenberg@ti.com>
In-Reply-To: <20240829083453.647044-1-u-kumar1@ti.com>
References: <20240829083453.647044-1-u-kumar1@ti.com>
Subject: Re: [PATCH] ram: k3-ddrss: Handle error properly in lpddr4_start
Message-Id: <172718819356.4076286.8880826617626896869.b4-ty@konsulko.com>
Date: Tue, 24 Sep 2024 08:29:53 -0600
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

On Thu, 29 Aug 2024 14:04:53 +0530, Udit Kumar wrote:

> In lpddr4_start function error returned by lpddr4_enablepiinitiator
> may go undetected due to overwrite of return code.
> Add support to handle error in above case.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


