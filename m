Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB99C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DAC4876A8;
	Tue, 19 Dec 2023 15:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iRKlMOrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9841875FC; Tue, 19 Dec 2023 15:55:15 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF8787561
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d3758fdd2eso35955237b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702997711; x=1703602511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAK1WDNnOFgUqHfY0A5E7EDTPOfhKmizOE7/AMTswnU=;
 b=iRKlMOrXSAdml3f3vMPYEa1suBwn8a6gelyULcG01QSf5YS7E4TvdcsCWUYHqvIltO
 dv+Pm8LasVOVTxDTqK9uUS8SkT9w80cj0i7jNn3F425sfd/89L5dYnkM5gzjnZSO8UWH
 T1eHp3R3gelRaImEkEuWthm30pWKSG+buT9Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702997711; x=1703602511;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAK1WDNnOFgUqHfY0A5E7EDTPOfhKmizOE7/AMTswnU=;
 b=pG6DHIHSMEJYHeraDc4HSU3OGoOzVyuosME1KhignYQ0WFNlZRVUpdC0Oj65ukYaE4
 omPdPR1ZFYscnwBWVu8v42RnoC1/IQJEYotMIt3Zgkmi2wTjsPGoQ/etYiqEtLGS/BY7
 eQiebZ6RtWMXiDzviHClVRmtWQFzDgnf/FwakUZtrmH27hTwA/slJ5ZdhNpBymsVZc3c
 NmDvjtD430qXTqQq1SnzDOZiPl8t4NSmBQV5MHAHxsyDWOPOZp4EUuMbpcV1I7hbGKiB
 rPlzRMkPXi0Tqr2ORc77cli4jrYkcwoQyRdN53KifG/JXAzXQXxoNLaMH2svUZjJs3na
 vTKg==
X-Gm-Message-State: AOJu0YxTCfhNCuDMOw7VJTCYIiYrvyw6EbMuF+Kck12OTuOWTTBqLY+F
 kf0LJIzbw1gQk2F80+dVhMuBYA==
X-Google-Smtp-Source: AGHT+IFAeQwVBULkZLyKz5X8pP3aQRkRz72V97uNKSt6baK+krFKtXAtIqoPfDi/lbtZJWMdvTSMKA==
X-Received: by 2002:a0d:e6c4:0:b0:5e4:8583:b52d with SMTP id
 p187-20020a0de6c4000000b005e48583b52dmr4495726ywe.58.1702997711389; 
 Tue, 19 Dec 2023 06:55:11 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a0df504000000b005d746ac7f6bsm9657580ywf.69.2023.12.19.06.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:55:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20231219082533.8399-1-francesco@dolcini.it>
References: <20231219082533.8399-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] arm: dts: k3-am625-verdin: fix DDRSS configuration
Message-Id: <170299771005.2342388.15337948742972099173.b4-ty@konsulko.com>
Date: Tue, 19 Dec 2023 09:55:10 -0500
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

On Tue, 19 Dec 2023 09:25:33 +0100, Francesco Dolcini wrote:

> The current DDR subsystem configuration occasionally results in write failures,
> impacting memory stability, on Verdin AM62 Solo 512MB WB IT 0072 SKU.
> This commit addresses the issue by adjusting Drive Pull-Up/Down and
> Write Latency to improve the eye diagram and ensure reliable write operations.
> This configuration is shared with all Verdin AM62 SoM and
> it does not introduce regressions.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


