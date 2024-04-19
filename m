Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED466C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53211886BA;
	Fri, 19 Apr 2024 03:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YSgC+ns5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1070A886B6; Fri, 19 Apr 2024 03:58:06 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D804688692
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-de45e5c3c68so1777054276.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491882; x=1714096682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2je+TodrdFBknw0XTxyGYknEUVHSLApJzM0SOVAF3xs=;
 b=YSgC+ns5/9/vGxe3Jdx/bRDXtp3ROJ7rrLaTR0bKyOrbtw8ohp8yZoQKIL8Hu0W54D
 THI+pZ4XJ8QxekVNib8Cr7zVAl6ycVOUR4u8B4/kX8K4nNcj0MZAO5BF8IWGM+g1Q0HU
 jbFj0YkTqrPc9G6+0d1H+n9+X+Okbke3cLdvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491882; x=1714096682;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2je+TodrdFBknw0XTxyGYknEUVHSLApJzM0SOVAF3xs=;
 b=Q30nSIHWQUf+7XKSEclyE64MEL7CfUQ29aXm5hgAthShO4FwuqKrurZzEvbWNr8Jmy
 rgJ/42eBGL8lfGKxbxIh0/tBEJXAVECihiyHw/07MKH4PnebBPAd6wxZmz8RnToorRSt
 j0rhpsCouUxCDalaN23JZLGw63FQshkSiW6rRWrDT9N5UtPSJEu4uWL/QyybKbDh9iwB
 TW35sl5Xgv4PtvP6DyWPgMhofeJZYuiDZeAt6eRmNFoOO7EPLpzAZ4uCT0+FyM6j29tf
 mFK3K6uZYJH1B+7c2gBGuYSGmHKACH5QMRMWRze/D0tP3jq5AmYScDcdLTEL5LwNyxXb
 tbLQ==
X-Gm-Message-State: AOJu0YwPG9zuI2dtWzNWxY3mcTmGhQmAg1hF3kNJ8beODOdPkn6jYH++
 swiOkusDn07nUJahhPOPClaDfJt95UwYNc3H0DnbztIxGdwGo+ndwtikE42uDs4=
X-Google-Smtp-Source: AGHT+IEdkIDmAmnw/lz4M9vFz2CUETG6GJ6cyWYxlCZtg6c2RY/4NaKKgiq8FhK6kP1BYltqYP9mGw==
X-Received: by 2002:a25:3610:0:b0:dc7:4b43:db3f with SMTP id
 d16-20020a253610000000b00dc74b43db3fmr638438yba.21.1713491882631; 
 Thu, 18 Apr 2024 18:58:02 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:58:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <4ac3dca43448d6b6660c947cd7d50b1112cd235d.1713169203.git.michal.simek@amd.com>
References: <4ac3dca43448d6b6660c947cd7d50b1112cd235d.1713169203.git.michal.simek@amd.com>
Subject: Re: [PATCH] Kconfig: Remove all default n options
Message-Id: <171349188090.1524174.9812328361446159024.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:58:00 -0600
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

On Mon, 15 Apr 2024 10:20:05 +0200, Michal Simek wrote:

> default n doesn't need to be specified. It is default option anyway.
> Similar changes have been done by commit 18370f14975c ("Kconfig: Remove all
> default n/no options").
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


