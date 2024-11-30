Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A5D7360B
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 17:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9C65898E8;
	Sat, 30 Nov 2024 18:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o7AX2fwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E579898E8; Sat, 30 Nov 2024 18:25:15 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287DE88E00
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 18:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4668d7d40f2so22978821cf.1
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 09:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732987511; x=1733592311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JraTB8nBPyyfVtDIVa3z9F7h1WX78VDIrkSppAfe90=;
 b=o7AX2fwGaPPK1rEVOXrLZ3xDCKH9WyqDumKo9kGAu9d25TNMqf0VWhINo6YvRcqLIG
 oCLjOa1bixMmL0PlvTVUu1M0iAgfGEn46x5eyReIh2jjSYbg7nBxc2QBnyrU+JMxSarZ
 v5hn+6LILvfwu24hJMVdqt31TBANbKCE1e9Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732987511; x=1733592311;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JraTB8nBPyyfVtDIVa3z9F7h1WX78VDIrkSppAfe90=;
 b=Qzg43b+VzMroLI6GbEPH1IrKTeIM7QzpMsVlmAAze0a8g/JPnOErPx/8XumjvWi5yH
 tBmZ7GBNz5SU9Lqqfb7qgrYgV19y3MGgFFPxi4y9WofMo1tfz+FHnfTv6pTl9i2+3ykW
 5fgITSN2imVKiY50Te5cTHFPzl9hew8gyfmqakuXmOBJFa07kcRuqN4NLMv3gZF9kqIz
 FeHh43OgpCk8SypdeaDCCSR+XcbXnYMv8b7XYDIlJe98NtPNQ6ZXXGti1Qw0dyundMWv
 1TiG9tbM7V/AyjAp4slPRj8Ac4rU0fUMlIOYd97XXd8O0LV9VXnTtjQr8gKdSr1nAnvP
 SaPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoQQFGvKVHZGDFvpU+Bkt+WPB1KBtwoKVrLZmMMgcwMMzlbSLIjI4TY4xiKRhhVYNFZvDJyPo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp1PKMqo9j0vso3KpjZ1A2KtKtcpP3h8ED6rHO85OeS1EwnqWf
 FAoYInl19R02+8HzCyic7prqfvisDOef25cREW887mfl8x83FcIT1TfEd417uJQ2a3GTqapb0++
 HOf4=
X-Gm-Gg: ASbGncsgFIWY5q4iyB2jjNvDfMfvUtf6mVh7MwkPdXGC1SW/ewcZCOsCR/PoofHmiUl
 ocy66mir+QEeiVdvJlYHehp9FD04q6DmepqOIL8kHzZw+twfQr9isL3Dm/Nv1Z0nUEvXLDFFbsR
 PnSaZij8rDKrDzfVTtiQjh/jW1OJG7iCEwt/Qvvi0+cqOGjlIQ4LmfCI46syngP1VKkGmT20/pj
 a/3nhoNBR0jmJACXXqaZk9X6lDvxDvrG6AbBmW8e7IOtXRp
X-Google-Smtp-Source: AGHT+IHohYEzxg9CQ05ljT168GLH0OGJwCClGKT4NBumk1PkoyJqR72q3WshNpXkjdFxTrHhGV/eCQ==
X-Received: by 2002:a05:622a:13c8:b0:461:18f2:49be with SMTP id
 d75a77b69052e-466b35560admr241198591cf.21.1732987511068; 
 Sat, 30 Nov 2024 09:25:11 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407d882sm29218731cf.47.2024.11.30.09.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 09:25:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Tony Dinh <mibodhi@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20241115004744.3643611-1-caleb.connolly@linaro.org>
References: <20241115004744.3643611-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH v4] cmd: add a fetch utility
Message-Id: <173298750813.2255080.497311152027685597.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 11:25:08 -0600
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

On Fri, 15 Nov 2024 01:47:29 +0100, Caleb Connolly wrote:

> Add a small utility for displaying some information about U-Boot and the
> hardware it's running on in a similar fashion to the popular neofetch
> tool for Linux [1].
> 
> While the output is meant to be useful, it should also be pleasing to
> look at and perhaps entertaining. The ufetch command aims to bring this
> to U-Boot, featuring a colorful ASCII art version of the U-Boot logo.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


