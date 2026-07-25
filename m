Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48916C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 10:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96ACA6068C;
	Sat, 25 Jul 2026 10:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbLMha24FdON; Sat, 25 Jul 2026 10:42:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D222760675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784976127;
	bh=QpTO3HLc302Arp9VulXcpWmaxGeODArsxW8P+TsRsYk=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qliEVYbkbmERwL4iHMtlxrGTZXv53wJw6NMVuLcIxmhUoUxqUEdUgqsfCYzzSqnK5
	 vA6EzQc2gqmTs+ZNJnTsGN81x4HQrg9i/CFrzsURrpE6FfJ69Xea/omEGz5+iBwRq/
	 RO1m37I61z/VN5ngrjuTumAfdOIVKJE5Z+rS+7Wrf4YluuJPOy+w3FkWerShUucuyP
	 nHOA3gSf0hYN49yuSOIanBSvyoqmhfhvLl1iarnsAUejYGGr3+Mj5u8CYM5PVlOm+U
	 agiP3jQtOLWC46i4rEQXyZ3wIossuQBaKcaG8TnZAcYpbPlPsORgXhKFUxjR/IbpZP
	 HvsfZIimE2wbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D222760675;
	Sat, 25 Jul 2026 10:42:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 575BF36E
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 10:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D0E560655
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 10:42:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oD8gCsbOB0c7 for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 10:42:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=leo.liang@sifive.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 26769605E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26769605E0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 26769605E0
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 10:42:04 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so16331325ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 03:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784976124; x=1785580924;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QpTO3HLc302Arp9VulXcpWmaxGeODArsxW8P+TsRsYk=;
 b=SFA61yBcbGbRiTC8fpSPtVtuBFFi5/mrvMmHwmpfJcH9Eo5Gz2PQcH8X0jczW43oXx
 W3JKg6WdsGs9J10DJ9SPgaFUNtMnxgJLNXbYkSsmkoOQqEO38lijTquXQlodYGsjClt+
 8tntskjylq/j3fdAD7QGPPI/eJYQnylKAgyEMPI9wu6VhThdp95/05S6+rwRpE6hx0Vn
 b4PseKJE4170hgCP9H/KRUlEfjtSwiFuPBSFOSmHK4UIw9a9mIE7DlSeGviAhgA8JwT7
 10UXe/KrDSF6mI+aSNMkA95C4Y4VT6PNoZxEuFcjEPRN4V41yTdmUPrxHABaf1RyA20j
 AwjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXp6t8eNeE5IlNi+Q9/fmZkpCx009mwYcAZ2Vo9yBwMFAMnhe32il2Ag1BUk9if4qQjiEHdz8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxxXYtDZsWkk47k87yBRPFek+vomCIytw48zKrBr65hgM3o3Uiw
 4ujfhWAHILBaJiRehpd7tlIEp93FXXyeeNwWtaReP4/1aYbQY/o9euNSru579ZG2d9A=
X-Gm-Gg: AR+sD10nogq2lBg4PPP3y8cI/iI1EoVR++4ho/LmKt+RXR1iCiAW7MNTmi1mH3rTZQJ
 Qv79pOhtecj5Me9ZLO1gdvViBxAvrkIDKxnbG3oD7pzGoa2W5I9Rub6IsPcRU3Z70EmfMlyRuw9
 VxXgPs+ModJLUWb5XaAGsWrfxgdas5qoBBFkR/a87pqfQfR/J7KvHm7rq1ZGfCKWE2FJsMIBxkA
 InrtKs/G7e+aeyQ8IyEm9gJ1tfkfkucvBBr9OoEyN7YJyxvN6LpLLpdxc8O8o53UmxaW38BfM+J
 5q9RD3a8ET6uT/JXGeYHIMZa9IB1W+4ZFu/WyodoZIcQanI9USr89LBPrNZ0zrk3GTTMyR0QNJV
 ksCN7AoJwBbj7iDn/dOhoeZjr07vVgiAToyyFxwLne7QWyja37shzhz1VTY1YOaAAiaxwz9hEJJ
 71byVhXsQmjqhXajgwlrY=
X-Received: by 2002:a17:902:fc46:b0:2cc:b480:28ba with SMTP id
 d9443c01a7336-2cfde8a9eafmr20046155ad.44.1784976124080; 
 Sat, 25 Jul 2026 03:42:04 -0700 (PDT)
Received: from lliang-1876.localdomain ([136.226.240.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7ee3b1sm8118455ad.62.2026.07.25.03.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 03:42:03 -0700 (PDT)
Date: Sat, 25 Jul 2026 18:41:58 +0800
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] riscv: remove log_debug() in enable_caches()
Message-ID: <amSS9gMuX1EThezO@lliang-1876.localdomain>
References: <20260622194308.70639-1-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622194308.70639-1-charles.perry@microchip.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1784976124; x=1785580924;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QpTO3HLc302Arp9VulXcpWmaxGeODArsxW8P+TsRsYk=;
 b=K4DPAYY/45r1tSWydzz+tO5paYjD8cnwK2UNEoocjlTVJDsTESuPjZPCU/35vgZpLR
 3Xs8Zw/ojmEGcWkLO5mN9eZYSgo2ymdg7WDjhnoVT1V0SFT5ZNDH6QJezHqXX+X4W5ZY
 YmF8yC6xUaXyeWeQbcXfyBPX1s8wyHhu6Qo9tn2BvPrl3cu/sR5fJxB9KH9zmeJV2+jA
 YzWImRCooWcWfPNsJJ5svZ3cr3BrhNlDxhwohJmBwBbZj02Msf0UXPHYhdFVWOcIQbeJ
 v30jKvnR76AbWqoW/BIuhsWvQzoLA+dCqTS6dUgisjZYNAedO9KZNhY9zJ5C+SFm/Ctu
 OrsQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=sifive.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256
 header.s=google header.b=K4DPAYY/
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
From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Leo Liang <leo.liang@sifive.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jun 22, 2026 at 12:43:07PM -0700, Charles Perry wrote:
> log_debug() cannot be used before log_init() has been called. Remove the
> log_debug() statement in enable_caches() since it is called after
> log_init() in initcall_run_r().
> 
> This fixes a bug where a RISC-V system which does not have the "zicbom"
> extension (such as PIC64-HPSC/HX) would get lost in an infinite loop in
> log_dispatch().
> 
> Fixes: 9e859849e2ca ("riscv: cache: Add CBO instructions")
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  arch/riscv/lib/cache.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to u-boot-riscv/main, thanks.

Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>

Best regards,
Leo
