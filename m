Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC404C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 17:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACDAB82D4E;
	Fri, 20 Jun 2025 19:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dqOEXtbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D53882E08; Fri, 20 Jun 2025 19:49:31 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B4482D4E
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 19:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c47631b4cso1369649a34.1
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750441768; x=1751046568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uN7f4o/nkwve2sBEQxjjZzowV1D9NDiQt24N+1lcIig=;
 b=dqOEXtbEuKkFNvGIwacMbACKClIcaBMPpD63nVypBudIF8Cu+nZE2ChoPoau0qmPUd
 VUsHpK0ptQ43KjVBsUZn1npbmINB2q2OijtVF6F7fO2vnX/PiyaSwlI7FBItjIKctJeH
 cX8dpZANYJpwcjgpUO+ajZXrKTog1U3Ltpo9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750441768; x=1751046568;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uN7f4o/nkwve2sBEQxjjZzowV1D9NDiQt24N+1lcIig=;
 b=lQ1EL7GAs8pEwppRq5EU9K1xOAbYnNIfB6XPZ1yMgooW/Ycta6Tm6IytPUD8+T/lOk
 +dubcBIZJ1gejQlFwDVQvpCrvWR6PGADwTBFese9LK2IF5MvNK1BapzCe4KWEXMLSG/R
 FloQEL3n8+6NMJGyAF7BlDgfQgZf73pvarBiuanC6JUlJaKFQvvXXJPKJs3zAC+rO+m7
 XwVlD7BthbupV173pQRbLI5E7O6Lw8ohe+UvRagXjqo38ngBPZOaYsA42ztTcemYKNrx
 kxnilHpr1xb3xz8lES/zAQzkEf33Oyom59mZtD8XzZtiiRyCaWr8WwYZ5r3zO0W2ScCX
 Rh5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHje5B31xhl+bJm/JnnE4pxURe9VYVKSlxW8IvYoD069OUcZ/nYVVZfOTVAvsBM9lZgCe/jJo=@lists.denx.de
X-Gm-Message-State: AOJu0YwksK00F4JgXefCSCwfnqpd6IsvuhsOeMP8fM/wcwoHwwx9MCkk
 3PhTF8yeRYl+f4aE9oHlbs8LEIjFhnHxp4jIVIgHEEa36ddA02ZfkIlrHrx0IPj9ga4=
X-Gm-Gg: ASbGncseiTVVEtSh86mbvBaQ9wyPCyY6dogZ2LfU4yjpZSies3kBFX3IV5mGRRebxq4
 txmNCPOmUChfsIUYpdLnRqEVuqvfjnhmgfrcK4+e/jssknTyg8DMG0/aLWTDjkeMpIbFfUl4Zy4
 mmBWxJ0ArMsD/kYQsofo0i+pBEN5BbIxH/9JOAfUbdDNk63awkFrolqX089CwcG/z4FFO0qI8H2
 8ISNzkHFs1A/xvt1swBySCAvrvYR+aCwWP/7ABzfUUL4Owc+q/YKCNUc59KWKntIFwJ24cu21Cq
 8Slhvh9ijkLZwJsWjGCP5+mSINAQQCLxfzmm0kD5i1Dei1CNdKozjT6B6httRlrjoSBHI19jqYn
 jISFDoQdSTcHWi0YopaF+Pw==
X-Google-Smtp-Source: AGHT+IEG5oLhyV7tI3gu6VMzV39nWYDeR4i8xqxH/OOui/Dfx633o/AnOLGivJPEcqFx3LL3E/zoxA==
X-Received: by 2002:a05:6870:2397:b0:2c2:174b:c829 with SMTP id
 586e51a60fabf-2eeee38e7f8mr2482495fac.15.1750441768087; 
 Fri, 20 Jun 2025 10:49:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee58bc74b2sm480067fac.0.2025.06.20.10.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 10:49:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
In-Reply-To: <20250112034213.13153-1-semen.protsenko@linaro.org>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH 0/3] bootstd: Fix efi_mgr usage in bootmeths env var
Message-Id: <175044176689.3427696.5945400433067455935.b4-ty@konsulko.com>
Date: Fri, 20 Jun 2025 11:49:26 -0600
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

On Sat, 11 Jan 2025 21:42:10 -0600, Sam Protsenko wrote:

> Defining the 'bootmeths' environment variable with efi_mgr causes NULL
> pointer dereference when running 'bootflow scan' on the E850-96 board.
> This patch series fixes that, and cleans up the surrounding code a
> little while at it.
> 
> Sam Protsenko (3):
>   bootstd: Fix memleak on errors in bootmeth_setup_iter_order()
>   bootstd: Probe bootmeth devices for bootmeths env var
>   bootstd: Fix incorrect struct name in bootmeth_setup_iter_order()
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] bootstd: Fix memleak on errors in bootmeth_setup_iter_order()
      commit: 11319e0e2bbf7b3892658d45017cd80c41ad961b
[2/3] bootstd: Probe bootmeth devices for bootmeths env var
      commit: 8da358c0a15a4f538d561602f600b2695fedeb56
[3/3] bootstd: Fix incorrect struct name in bootmeth_setup_iter_order()
      commit: 8c61fc082e9ae045534dc2f18ed50493adf35e6d
-- 
Tom


