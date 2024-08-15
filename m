Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BF8C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562E888C0B;
	Thu, 15 Aug 2024 22:34:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T1qBRReH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE0788C69; Thu, 15 Aug 2024 22:34:33 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4856988C6A
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d1fe3754f4so999949a91.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754066; x=1724358866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7GaXejhIViWG86G8BA4gzqrdcAVomcw2QLw/XHaGKWs=;
 b=T1qBRReH4Y6uud1BFqwZ2jkCLdm7Yints0g/o3fCvilr8GqBuZWPaM5sI075MvEecg
 nLOh20ydQa/7RC+jqu4f0FxdzLE0ddvmuliXIBEI/vbjVxXO57+4Bc4mZ0XT4rmlKub+
 WTY7cR6mXN4IqNihHl6K0Tv6fplu35at+JQPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754066; x=1724358866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GaXejhIViWG86G8BA4gzqrdcAVomcw2QLw/XHaGKWs=;
 b=bFHis5o2rNhO3Q1Cgf0442UYS37Ahn3DLK/NfztyAI3RPuJNbSZKnRkPIXya0ghdmP
 4P/SobWurAMcUqecnO88PS9HxTimI8jv8555JxeKJlA2wjMhqFwGQNiPeAikxhkjHW1K
 Qmr0YY2Wz0UAtfPphz6jwLyFh1Ze0YVEnWjalIlXQPCK7CF2phXYIu7X0k96psH1Lrvc
 64V23lw+ivZbyeN+I8qzNk4ha3wmCQ4dpE+L+ietICaAAclk70LmW6eAgi+lbqvj5US5
 VISBtx1K5PQ+2xEhApeMzI+j4V66a4cLOcJ40Gk48G4fvHAav4sGCQPTprfMgdFHMY6b
 Btng==
X-Gm-Message-State: AOJu0YzKoBVFcFNyaM1WOsasS52u9UNVd4s4e82XYbECX/WqVu8MTXBh
 og57YLZYzzALbvvN6ZHUldeeEGhe73O/VOmzI8rBI/KpTApBhuYR6TGNKyVv7Wabr89D8hlOdHw
 leKnd/PlOGfWwHP/lEuRx2vfpnxDdLpJtJl+e
X-Google-Smtp-Source: AGHT+IEx1D9PJb+hJcD24EUwce4GK/f4B6mvlH1J9tWfs6X20gJkSgIpeq/vkNA3QwmeUaR3PcytahSXbluScPC8aX0=
X-Received: by 2002:a17:90a:c28b:b0:2c9:80fd:a111 with SMTP id
 98e67ed59e1d1-2d3dfc6c299mr997121a91.18.1723754066363; Thu, 15 Aug 2024
 13:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-30-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-30-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:34:15 +0100
Message-ID: <CAFLszThpgPcJXpu6uFaLYA4uyiM9t6_s1DfsEp=Mbb_nJec9xQ@mail.gmail.com>
Subject: Re: [PATCH v2 29/32] test: bdinfo: dump the global LMB memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 14 Aug 2024 at 12:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB code has been changed to make the memory reservations
> persistent and global. Make corresponding change the the
> lmb_test_dump_all() function to print the global LMB available and
> used memory.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Get the alloced lists through the lmb_get() function.
>
>  test/cmd/bdinfo.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>

As mentioned elsewhere, since this is an existing test, it should be
kept working throughout your changes.

Regards,
Simon
