Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCFDC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D2B88663;
	Mon, 10 Jun 2024 18:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TG/u/m3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7965888655; Mon, 10 Jun 2024 18:51:12 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB0A88655
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d21ebe1c3aso55224b6e.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038269; x=1718643069; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwizfuEzSK670/vIED0fNRHezZ5rH1lempfxDW6Uhrw=;
 b=TG/u/m3QGVARFqTN5Qo7VGPMOr2gTVWiA9w9rkG18uT7gELM7fsOJngz0xesTqJzm1
 F3IEYF+lUirsZtSUaLcd+nFYMJHgORM/gmopss2pq0wQg/UqTC9pkN8k5imziN637qCu
 z5SE2iMevoGWTRjMq3oXAjPRrEABa1HevR8D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038269; x=1718643069;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwizfuEzSK670/vIED0fNRHezZ5rH1lempfxDW6Uhrw=;
 b=uX9xdIZkyyIspTdISDHNqYYAh5oH3JP34xNKzkWhnFrs1gD8QI3taJp6CMiOJ1YnXw
 NYMyYz2bLx4EDo0AigCIcBEvG7B3n346PaHSNUu92QQgyjOEJ0BNigFPfzPeAxDw2rkk
 FkBAMRlsbuHezaUzUk3nlHx4p2xKo9PdUcbUvvP1Em2E9zCIWU65HVK/VpwSWz66ux9o
 aUs4peN5P/vL4wavSu/+PQnhOlIsAizJaHrAqmr1Gy/qeuGR412KW4CR+Ll7JbGk0Js9
 1EnZnPDhEpJPnbRnv7Z068OsvdTwaB/SNkeWHJEoTdll4+991VKbuALfMA4EcRR4Mfwx
 eV3A==
X-Gm-Message-State: AOJu0YzV1DwgjGHfOhlUMw1vIx2hnbz7ixyQN46Q1xHL/V+R8jqGHFPa
 wMyb3Z7KFBHA9/LcW7mSyY1bTfZkXzVPQXxNZfl6/Qlz0kEfY3fubx+SqyPKjC4=
X-Google-Smtp-Source: AGHT+IFqP5VoIWtm3pE3398vVBl7ATlanbMslQIifukGTgoKy+qvv140us2NG78A7HhjA69QLgEyOQ==
X-Received: by 2002:a05:6808:199e:b0:3d2:1cc6:9d67 with SMTP id
 5614622812f47-3d21cc69e7fmr8662481b6e.31.1718038269177; 
 Mon, 10 Jun 2024 09:51:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb57sm1668475b6e.10.2024.06.10.09.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:51:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, xypron.glpk@gmx.de, CFSworks@gmail.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, 
 ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 BMC-SW@aspeedtech.com, joel@jms.id.au, eugen.hristev@collabora.com, 
 sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com, 
 michal.simek@amd.com, aford173@gmail.com
In-Reply-To: <20240528061827.183403-1-ilias.apalodimas@linaro.org>
References: <20240528061827.183403-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] arm: move _end to linker symbols
Message-Id: <171803826788.2405130.990713547605236692.b4-ty@konsulko.com>
Date: Mon, 10 Jun 2024 10:51:07 -0600
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

On Tue, 28 May 2024 09:18:27 +0300, Ilias Apalodimas wrote:

> commit 6e2228fb052b ("Merge patch series "Clean up arm linker scripts")
> was cleaning up linker scripts for armv7 and v8 but was leaving
> _end and __secure_stack_start/end.
> 
> commit d0b5d9da5de2 ("arm: make _end compiler-generated")
> was moving _end to be compiler generated. _end is defined as c variable
> in its own section to force the compiler emit relative a reference.
> However, defining those in the linker script will do the same thing
> since [0].
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


