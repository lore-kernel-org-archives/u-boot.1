Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BEFCA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 22:21:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0888334D;
	Tue, 12 Aug 2025 00:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j898aD8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C261831D8; Tue, 12 Aug 2025 00:21:05 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79FC38329F
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3e40050551bso44609185ab.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754950862; x=1755555662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFOUbEkFx1mmZJfialtmBwFqbqwIbqfD3qXrW0V0JVs=;
 b=j898aD8Wwy6koZ7evoD0CWErTXG8mPncjghi0bJmDUE0lqab/0IWkVLTjQH28vsSAQ
 Qf0V7dXpdWTAknC9054FhWyGM7yT0vpM4Fw/Zq0a5+0tQ7lAh38rlfEwsv0eHKEUifqL
 GAPzW0zbKzksbchh0cLIby2wQjiETFW4n+MfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754950862; x=1755555662;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFOUbEkFx1mmZJfialtmBwFqbqwIbqfD3qXrW0V0JVs=;
 b=ATYyppvWwJ540rofvgJPEvo1jcFbrXaXXKNw7qfT0U0cn7/sDCFGyAlIOtWXS6ZSNb
 lRlPBgn/GVnYjk+HXkisN3GKvMoHdWgzr0GxUMwarl1CUILeDsAn3orgX8hut4KjIQ97
 7mkE2UIkYcWxHG9Wt74jHJOqwvKWcfz+thzE1EnFn9NPSvkOqE6al8dh98atks/GuRX/
 EYl7v/RAsNsbgLJFt5BYGKTd21G8RF9HXWsixJr8a0vx5VUMOgubXksfa718zPioU3ta
 SnuhdzBxiaje6xODgMs+JTo33VrkejWVw5Cnw/WEEjXA3lD9Qp1rJagZfusXGazUEp5g
 5AAA==
X-Gm-Message-State: AOJu0YzZ9utikxwOoDHqzdsSN2jaM7IXR6edTwPivBn8eFGpq4T0zJ64
 09WeJLd8yIRMjDzD19gt2Cftmfvc4X6k5salpQIMn6riGOETZi2iYmWGo6iypglS9miC7f1j0IR
 w6ezI2RM=
X-Gm-Gg: ASbGnctrqgJHBPLg9E/ggLetuygOyT+3M40JucBEeFwprZEEGve63/ApZroqtjMEAWu
 c/6G89NBdFR5FQhC0DgO4E+N7XeyfU/xl6MDLdqDD5nHk0V9GoGFQ8vR3uk8pAqInBCdC792SD6
 Yqw1CSdgs6Gl7rlX4+5+kQfMdmnV/ar+jpSklu8xgBzlnGfVqpQi1HDBB5Cx4wqMIwMziSOlVHe
 94vdffmIeMZe8FCMizeqM8lBpl43wg74HSd0YdjwJgJJmMYilYAcTFmU3DBWBe/b0bRaSmy+gPV
 dauuHvLTGksgufZ5gol6HLyPd8QWT91cb8hadH6ER4j4W1yeTJhe8iH5EZ3ZRLyJiAKFuqFSh/J
 umeu/GemH2oxIORo6qnnFGa9Gn0FlBak958gvugPAJDZKwdv9psxChkU=
X-Google-Smtp-Source: AGHT+IH925RHmv+VyuNAncUWOmHtIbMhspG/ox09ggm6HmyYpdykh5ehY32/R7VXnGeEQ8BulSE4wQ==
X-Received: by 2002:a92:ca47:0:b0:3e5:4e02:a561 with SMTP id
 e9e14a558f8ab-3e55b031614mr19848595ab.22.1754950862267; 
 Mon, 11 Aug 2025 15:21:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e533cdd3e6sm42092725ab.55.2025.08.11.15.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 15:21:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250725-dwapb_gpio-v1-1-ee09ac9db7eb@linaro.org>
References: <20250725-dwapb_gpio-v1-1-ee09ac9db7eb@linaro.org>
Subject: Re: [PATCH] gpio: dwapb_gpio: Using wrong function to free memory
Message-Id: <175495086150.1657597.5345274830032284796.b4-ty@konsulko.com>
Date: Mon, 11 Aug 2025 16:21:01 -0600
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

On Fri, 25 Jul 2025 12:48:22 +0100, Andrew Goodbody wrote:

> In gpio_dwapb_bind plat is used to reference memory allocated by
> devm_kcalloc but it is attempted to be freed using kfree. Instead free
> this memory using the correct devm_kfree function.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] gpio: dwapb_gpio: Using wrong function to free memory
      commit: 916f4337d1d3db4d16040abff39a5f4419589ead
-- 
Tom


