Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E87C71136
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 00:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD7C182D21;
	Sat, 14 Jun 2025 02:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MWt5Uz8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F317B82D2E; Sat, 14 Jun 2025 00:27:10 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC91B82B70
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 00:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72ecc0eeb8bso1120643a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749853627; x=1750458427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53LCWwtjBsJih5SgMyaJboAcq2zuL0xQA5d2JRjx47M=;
 b=MWt5Uz8t/EqH4oMvFyELm65EZhzjAYW8hkDobljAFLy2BZUn4JdAczc+dkY3lK75Uu
 l6j+XQBOEKcueDYkM4B2v/Xyy1o1QNVC9RwK9q26sk3huSxR1++qhij4JVCUoXBtxvvn
 rnxYmmwRczRmkDOb1p5PoDtQGCuPKOgrgiqY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749853627; x=1750458427;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53LCWwtjBsJih5SgMyaJboAcq2zuL0xQA5d2JRjx47M=;
 b=TlfGo/dAEkLX2vMp4y0zXm9Ugrl5zgI3ZJn+vhILhSKxasVL5e0p/CUBzBZQhKqcMc
 jzPF3id+j5hOkEFryG83IN0SdDqca94FZPljyLZ0oqzBUQa5ngzStpR9hdMbRUclM8dD
 eUYQrWFKzYXdDB/qhzjiJsF4z4Ca7Cx73YquLzwK92jb/6ifyLzJxTTvfiUQE0mf1huH
 ksdz9FA6iA9tN7p+W0dQ11bW9HgfrVpfvtCRaq1mBhF433yACTOGbfLx+31ZhWoOy3CP
 G8aHoq5I2sWXKlSYL7DEZVb0/L4cXPwsZNZ/vX4Egwg57nTlbywRp3A+Cx5MrB3msX1W
 vgJw==
X-Gm-Message-State: AOJu0YyYn46S0bEJ+4xlLpBP2z4fRYyljUlBfRdlZS6kCLolD1zKtxID
 E90UnWVT8e6Upcu3mFyTcy5uPHFdOqnnWLG8mEKyuQ80Q38x1oP9EYe10SAlPNO9Bzo=
X-Gm-Gg: ASbGnctrE/Wy909nwCugex1dgpCoXvKd9d1GiJ4C0YyP7l8fCdtrU9OvnElcbADYxFP
 Beec70ELPgS72bJ2fxeDEtfVoHj4iZGuUAZh+keAkoOgCMXzsiGEsffchZczNTIY/8Ex315KPHG
 fZ7HjqU/+HBcAfrEhF0H69SAhnOartoGmxgpsnAqVtMXsvB47rbsREJ3jV+5InuuBN6ZZZixbZe
 eyZIUxNED0DcGnbQ3zjHsYbJ78x9icSUOWEJYbZTWefQXGLO2Ex+Y7ZbhmvrnW0FfrzWpaMn/mu
 qeVh/B3s4sJJuWq/kKVLqpaPFaztsnqUeJ5qiVRPpRaKtiqEHCY1swyyoKZ240kLZan06NTCoTR
 yZ62uzQ7cbOB/uxNnMocv+CIJJmi1gyDj
X-Google-Smtp-Source: AGHT+IGQyeJdGTk+cQHSXuElQOzxDQBhOErOvVmfeHFfTnl10vp1osa6jYCZ8GdFy3zMo4IBMG6fQQ==
X-Received: by 2002:a05:6870:1cc:b0:2e9:512:ee1a with SMTP id
 586e51a60fabf-2eaf0835465mr889020fac.4.1749853627250; 
 Fri, 13 Jun 2025 15:27:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eab8e6bec6sm885548fac.35.2025.06.13.15.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 15:27:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: =?utf-8?q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Phelps <andrew.phelps@canonical.com>, 
 Alexander Graf <agraf@csgraf.de>, Boyan Karatotev <boyan.karatotev@arm.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Fabio Estevam <festevam@gmail.com>, Harrison Mutai <harrison.mutai@arm.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Liya Huang <1425075683@qq.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH v5 00/25] passage: Define a standard for
 firmware data flow
Message-Id: <174985362441.860502.7163329201162812483.b4-ty@konsulko.com>
Date: Fri, 13 Jun 2025 16:27:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Sat, 14 Jun 2025 02:36:08 +0200
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

On Wed, 28 May 2025 06:32:02 -0600, Simon Glass wrote:

> This series adds a standard way of passing information between different
> firmware phases. This already exists in U-Boot at a very basic level, in
> the form of a bloblist containing an spl_handoff structure, but the intent
> here is to define something useful across projects.
> 
> The need for this is growing as firmware fragments into multiple binaries
> each with its own purpose. Without any run-time connection, we must rely
> on build-time settings which are brittle and painful to keep in sync.
> 
> [...]

Applied to u-boot/next, thanks!

[06/25] spl: Rename jump_to_image_no_args()
        commit: f73450918d66565c5efacf2bb57227ba94bdaa40
-- 
Tom


