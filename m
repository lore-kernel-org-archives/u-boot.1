Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68E6C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 21:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FAC875FA;
	Tue, 28 Nov 2023 22:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KK9nqWmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EEE870D2; Tue, 28 Nov 2023 22:13:29 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CBBB86CF7
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 22:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-da0cfcb9f40so5578405276.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 13:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701206006; x=1701810806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3jN12I6YE3sXe0ZOueHe/4weMEjV1rgv+l+JNY8Kug=;
 b=KK9nqWmFIia8NLXyWGSukeY5Efbqycy6nhpJ3nXWZCJ8PSNmOvi3hhJP5cuj1VpE3Q
 uzdglbtrG4T50BxZz3OX1VChP6ruBH/+4GGAezLqfx31nnjH1XhA5kFgkXc2DCdhkTVn
 2SgubyKO2cD4KH/SO0CCqhuk+I8qDK9P6ymIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701206006; x=1701810806;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3jN12I6YE3sXe0ZOueHe/4weMEjV1rgv+l+JNY8Kug=;
 b=jGwxJAXkByq7lcywODu0VHrU+V3ZxXrfUPMhdPVIM/ra1r8wKgS81o0JMX3ts28q9K
 N5w/PcyzjjVulegj6ZXoKDxbOBlzkxcr/ph8Rh3v60eCxspMZH8RuEFsRNR1HitV2cNW
 3Yhqc/aA44J3zpZ25lPqtiY6gnhfLVdK3FNxA5KXwfuyJ/i009ijiGy2BUE0/bWaOgrc
 OJCrzFZQ+89WiuaP93xXR+qDKNtYX2oIPI6Z6ATHvJbos5+dx/S0t6oNwSN07rcS+Akd
 wwn74sVEr56weqpWL6s1gz/AfzFGBPl3C3I9lpYs/ekkC3OQHGoGo8s6HeSeuYU6l4A+
 L+vg==
X-Gm-Message-State: AOJu0YwYdOqvNs5RTKwOf3Rtzu8L9oFMM8GI+aTveZH0xJWt4BMeQniD
 8lrqZ2FOsk7ZNyGyJXagmQQ37Q==
X-Google-Smtp-Source: AGHT+IGP/rYeUYrmmoOqcry/rsIG5v47c+O5TpmdSHUD97NlMDwvpTNBnbgvqWmCmim6oiSozEZ25g==
X-Received: by 2002:a25:ab6e:0:b0:d9b:8804:3153 with SMTP id
 u101-20020a25ab6e000000b00d9b88043153mr15993016ybi.8.1701206006059; 
 Tue, 28 Nov 2023 13:13:26 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 b143-20020a25cb95000000b00d0b0bbe574asm3831770ybg.44.2023.11.28.13.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 13:13:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Artur Rojek <artur@conclusive.pl>, Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Breno Lima <breno.lima@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Francesco Montefoschi <francesco.montefoschi@udoo.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Mike Frysinger <vapier@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
Subject: Re: [PATCH 0/9] sysinfo: Expand sysinfo with some more banner
 information
Message-Id: <170120600498.409307.13044009139201842259.b4-ty@konsulko.com>
Date: Tue, 28 Nov 2023 16:13:24 -0500
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

On Sun, 12 Nov 2023 19:58:20 -0700, Simon Glass wrote:

> The show_board_info() function was adjusted to weak so that it could be
> entirely replaced with a board-specific implementation.
> 
> The intended way for boards to provide their own information is via a
> sysinfo driver. But currently there is no way to show anything other
> than the model name.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


