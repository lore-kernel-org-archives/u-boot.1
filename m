Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAD6D5E12A
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 10:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9640D83971;
	Tue, 16 Dec 2025 11:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="WJ9jIvI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA978397D; Tue, 16 Dec 2025 11:55:51 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466ED8394E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 11:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso2428387a91.0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1765882546; x=1766487346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QtXHhh/27PjU1w94YWXLgr70ZyKesvaqBAXEEhQB55k=;
 b=WJ9jIvI5PvCYS35dxYjrH1zq/3POXAQfNWLLFuXm9momDQ9ejJnGy+EKt0jQxmD6XG
 6v03lLq2MVUO01WzuB5pf3NpDd3fNpCvTleh/CGVpPVaZVzlIMVhMgK4lkDbpDZMiLdW
 lgKoOgt3tyo6CMlKnD0AQxDmFrGiSVd6PPLbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765882546; x=1766487346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtXHhh/27PjU1w94YWXLgr70ZyKesvaqBAXEEhQB55k=;
 b=HH6MQ2njY7Q1RPT2Z3R3mUwCTpX+y2jw0e2tF2uI39+gYqWhWxeRAwf35g0qHqOoqp
 iwvMF4QIKAhCf8Ued/Y/YdmGlzXrRsGICQtlgwnoEOk6bbBV5evFb+FdgMO4e56+FKGv
 OiyD27NOS+TCjQYXKBVG36gZLK7+agUXqb62KmCNbGbaUr2G6OXvCdK6i6Bl+9309Mg+
 8R6T7iQ03tiAU3zSeZzdtGT3vTUMz5VGfc6O6VBi4njr7WBQB2RYzlrhXBPB+99BU5oq
 f1MelpEbrCg5xaYiWBYgmdgzpDdo5+RysBxI+LwLgM7x7Y/jRBbsYCsmgICPPTLlNtXJ
 WDBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2vPsCW7wFAnW2CQta933ufR7D650BWgPiQhGF/LLgT3tR8nkcw9gW7poMtPZgRsQk1vs9tEw=@lists.denx.de
X-Gm-Message-State: AOJu0YxDU1nEB0+u7eWcNULZcM2FjsCQ7IASW14u6/Tvk+mMygn+2eD5
 FlPwWVfSpWa/VmuDtuT1yrf1kXH0pXgVODQ3Lvivd8TqwSacFDSVAmA6zIWWCihV8mC327cbfKV
 f2EwfwQ5zPrq5v36RDJiP3rigLbX5zL4/ml4TpuipTw==
X-Gm-Gg: AY/fxX5S2o8/oGepjb24sLQAHhayd3nrJte5S+6aCu1aP8X/J4ynPE+PMU6mhYWwYlY
 7Tr5CZezmaOgM7MGnvZyWYC3xWyl71XVtj8OnrUboH0oFh2IGWZKNIzPwFwFmgG5moXyxOhhFJR
 jF094GynskOSJZ/qQhgSnuL4tPBPKyxcwVDXJnEsQhMxptzM6pTL5DiD676ZRvx8pDyEWbv3LkM
 SAO4OtsVLLPm5Z2dliMMQ+TsZmYfrGQ3pUv8x1M5BRCGqi9GEX2WO1gnu+zM9IFrEj8+P7GiFiX
 2VCGlJA=
X-Google-Smtp-Source: AGHT+IFg9K08hNzY1Yb8DfnVGeUuB5Pjm7Gph36Xfu1W2hV130jR4SOpWCkqFEm90IQqWQjD4PNcYbYDJmSvaZ2+kfA=
X-Received: by 2002:a17:90b:2e48:b0:34c:2ecf:2b2e with SMTP id
 98e67ed59e1d1-34c2ecf2d4fmr11717930a91.12.1765882546471; Tue, 16 Dec 2025
 02:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20251216093513.424736-1-daniel@thingy.jp>
 <9a87c145-ff0f-4f44-9dee-20af2f843b2b@cherry.de>
In-Reply-To: <9a87c145-ff0f-4f44-9dee-20af2f843b2b@cherry.de>
From: Daniel Palmer <daniel@thingy.jp>
Date: Tue, 16 Dec 2025 19:55:35 +0900
X-Gm-Features: AQt7F2rTReHAQ-ovXolm0PZmayzjT0EVAjbQt_kp-vzLRWK8BwFI0doBGzU0rBE
Message-ID: <CAFr9PXnc5okVixsjfLCDvSoJa5x3eMfXpwaKQysena1OXxgefA@mail.gmail.com>
Subject: Re: [PATCH] lib: elf: Fix typo
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: trini@konsulko.com, u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Tue, 16 Dec 2025 at 19:11, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Looking at the code, I believe it should be "EI" instead?

Yeah, I think you are right. The comment seems like it should really
be above the if where the check is happening but I guess the intent is
to show the function is ok for either 32 or 64 bit because it checks
the class.
