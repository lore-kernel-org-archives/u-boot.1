Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9616ACA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 16:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F8A838EF;
	Fri,  5 Sep 2025 18:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ckqGMx26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1518838F3; Fri,  5 Sep 2025 18:45:02 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2254832F9
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 18:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-439fa5a0672so71404b6e.0
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757090698; x=1757695498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZoavphyfBYPgWuVJrID/FnjsrsqaMg/D9TOLXBbwIhw=;
 b=ckqGMx26q2s2HgKP9LNh3sjdxiD+1wCKxgBVHb/fAum75pheiJ73PvTy91lr0T0x1N
 lm9qObPRXsQQX1UeEkJ9zcOHRXUsalGKKhX0w/8QXbkWTmEBsk8321q/QgROCTYzf7f/
 xzRRfQ0h+i9l9bmzJ4Az9/QTs6LZLfztblYJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757090698; x=1757695498;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoavphyfBYPgWuVJrID/FnjsrsqaMg/D9TOLXBbwIhw=;
 b=UVQm6HkZWDlJRlCmHUhQGm1ytpDFoUvY+soJo6PFs6pGpjrKKMZBLmBm8ieMINcaCq
 cI47UYkzCGDqxH/I9Apo6nLQ2yqVncZHJLVnkK04BsKZiQ3Ebqz08OII1UVvSfLYssyS
 om8rKRlofgc97OsSmjZt3A21qP1KT1T5P4KuWW4ILGWEFZXXVrK6eLudUJygf9MzeKYR
 QPccfKdSnvrlY1DlqjQrx088/ycj1T/DnJ/wqpYOXNpdTGTpU4hAqxxPrC9DYUEsG0OK
 r1ueNApar17r3aO9v7UJQcd/7mne9icQgUbrGsZD3srLHWTlm0wMwu/wgJcQ0cYWVrL8
 UyVA==
X-Gm-Message-State: AOJu0YwKBYcu33o+HfeOLr4yR/lxEfNT9Cx2XqU8gf1lkdBBxLWFQ0EC
 WZvP6TQ8A6+AJloQtk4aTdKM5RXu1h7DI2lHpO+UqzmxTGjTTb6nwvOtVan2UcVgMwU1V9KtIdS
 9a3Bio0w=
X-Gm-Gg: ASbGncvrUdrrs01Or/nWxhI405OftCQf+KmuMZpbns29F3kYOPW6Y1BXKqOYjF6kr02
 /F+rj8zsBx41gHO0UcGQG56aY9dFznnjfaCLAtbn/621qnYEgzL7Hch+w6dSRqpxR7QjXBj1iLU
 jjIe3+KtH8z1gDqfvLvcTM/wnBFP2IMvZX41aKkYV8kL4NfM8PWE2XEB89V50EUo+3Yt3APwnET
 AWFaFSbLEoVKqEq+hSij7pJxjk/Id/zFjfime7SgJxZ10eUwCP+OCKrAuDixLGb/gyYFHKoZxor
 thbkWwfvAZP6UJlSrXwHiLiqyxONwpLcu50BCDAVt229toFA+K4TdBiHgoWveD70JQHcFfIqcX+
 SZyMshqCAiWe7PzGiOIEuBthf0vY3RsnXEZJNywDkTKwTLWmePKSdkb8=
X-Google-Smtp-Source: AGHT+IEnGZS9XuExJygE7pkicId+TsRrAu+eDX4Q3kVFLMyS7eDHVs2VCZ5lNMBgj5whu7MWpSxl2g==
X-Received: by 2002:a05:6808:895b:b0:438:2440:a594 with SMTP id
 5614622812f47-4382440a7camr3955865b6e.47.1757090698332; 
 Fri, 05 Sep 2025 09:44:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-62173821315sm165089eaf.12.2025.09.05.09.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 09:44:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>
In-Reply-To: <CALrBrZ3u3hGubrjAowRzuR0G2x=EOxPzoC0ezskJbi06YC_nmw@mail.gmail.com>
References: <CALrBrZ3u3hGubrjAowRzuR0G2x=EOxPzoC0ezskJbi06YC_nmw@mail.gmail.com>
Subject: Re: please pull u-boot-samsung master
Message-Id: <175709069745.3789037.12002219409703096408.b4-ty@konsulko.com>
Date: Fri, 05 Sep 2025 10:44:57 -0600
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

On Fri, 05 Sep 2025 15:39:27 +0900, Minkyu Kang wrote:

> The following changes since commit 3dc5e9a0108bb114175b6362f9cb22367402f624:
> 
>   Merge tag 'u-boot-stm32-20250825' of
> https://source.denx.de/u-boot/custodians/u-boot-stm (2025-08-26 08:33:10
> -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


