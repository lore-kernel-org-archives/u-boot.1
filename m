Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B1C47DB3
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56E687C29;
	Tue, 30 Jan 2024 02:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tn99MRXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE9DB87D18; Tue, 30 Jan 2024 02:54:14 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E785187C29
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-603edb4c126so4867687b3.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579650; x=1707184450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqaLWrtBr2J/ptehxZs/qRqPgUsXcX+d1Ob2jjfo+zM=;
 b=tn99MRXSV4RAbrDRyJHVUxlbf4g+Sm4kSUkZ7t3YkQpAXxhBS8MgUK6wPTLPQDCNlx
 rF4xMj/5CoU+CmCWTROaMictaueL4XHsEtwaxNQgQDQdoQGlMmG4yxSssONz+gdA9bHW
 PBaMRrkpSfchUcoz2E/FE+T5g4g5bbFb3iAbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579650; x=1707184450;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqaLWrtBr2J/ptehxZs/qRqPgUsXcX+d1Ob2jjfo+zM=;
 b=TnPzYsPdR/CSH6Jef9rCLacwfdS6N9+DJ/ftPcWVePjbKCyhpmGsqLApDy6ZhCXslH
 oRywZYCnTdoOrvXVSDEFZV2tMCglUX6xx2MHIwEkQ7AxrFcKayP7DiFWZbVsv87kO39c
 JEszLdkNliYWSEmd7/Tohyfi3mj9dRnn/7q/dom5yAZWKTJYKerjxckn6PYXp9/LACT4
 9AhCvKrVoxkgpLnIi3BZpK6mLrP4mn952eeKyB0aSqqSXLwJNWlQTXR1NlTrOMiUkvdx
 Jhg7CjwvK+cWdopazCIDI9Uh/Ba2Ia1XNmPvhD+nVjGkN8jTNsSfxodgSQlE8zBBNQc6
 bQvw==
X-Gm-Message-State: AOJu0YzQccLbFNX1qzuyOoxF1zsp6l/2r5rkP4UBRpCiVqccJXrLllB/
 AmjnbDjnaBwK7GCMvwbdRoKTVY5jmqMDDuY10yohL2PNdXUw2E5Qa8avUZsekLw=
X-Google-Smtp-Source: AGHT+IFyede8Jc8In9eaEiCKFfaQ6L06VsbnYL/22Y2nnBumg4ajC8z1/rVro8EzlGq7dEqzfcorMw==
X-Received: by 2002:a81:ae28:0:b0:5eb:d94d:4300 with SMTP id
 m40-20020a81ae28000000b005ebd94d4300mr4954849ywh.19.1706579650214; 
 Mon, 29 Jan 2024 17:54:10 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 x124-20020a81a082000000b005ff93c11cf5sm2881712ywg.100.2024.01.29.17.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, n-jain1@ti.com, 
 Devarsh Thakkar <devarsht@ti.com>
Cc: praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com, 
 j-luthra@ti.com, nsekhar@ti.com
In-Reply-To: <20240124090509.303787-1-devarsht@ti.com>
References: <20240124090509.303787-1-devarsht@ti.com>
Subject: Re: [PATCH v2] common: splash_source: Don't compile ubifs splash
 cmd for SPL build
Message-Id: <170657964938.1823400.14777098223707220298.b4-ty@konsulko.com>
Date: Mon, 29 Jan 2024 20:54:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 24 Jan 2024 14:35:09 +0530, Devarsh Thakkar wrote:

> Don't compile ubifs splash mount command for SPL build as this command
> is not supported (and also not enabled) during SPL stage.
> 
> This fixes below compilation error, when CONFIG_CMD_UBIFS is enabled in
> defconfig along with splash screen enabled at SPL stage:
> 
> "aarch64-none-linux-gnu-ld.bfd: common/cli.o: in function `run_command':
> u-boot-next/u-boot/common/cli.c:51: undefined reference to
> `parse_string_outer'
> u-boot-next/u-boot/common/cli.c:51:(.text.run_command+0x10): relocation
> truncated to fit: R_AARCH64_JUMP26 against undefined symbol
> `parse_string_outer' make[2]: ***
> [u-boot-next/u-boot/scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> make[1]: *** [u-boot-next/u-boot/Makefile:2053: spl/u-boot-spl] Error 2
> make[1]: Leaving directory 'u-boot-next/u-boot/out/a53' make: ***
> [Makefile:177: sub-make] Error 2"
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


