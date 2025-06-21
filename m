Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA271C7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 21:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABC2482CF4;
	Sat, 21 Jun 2025 23:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bTFgY+It";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D820C82D21; Sat, 21 Jun 2025 23:54:57 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D6580C93
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 23:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c40235c34so747825a34.3
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 14:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750542894; x=1751147694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9FBJzCMtVV0Z4kD02yNM40lD9fGXKR/LcUs4C00azU=;
 b=bTFgY+It9H54h687sx2bdgiOI4vMmBVEfcpWVSBXIHBWU1q1x1ZlLp8XXT1NAElvpv
 PAf3x0LLl1rBNU1QGmYcRpe/aEI0ctSVRf/rz+TAmRNNLmf6oltcGlNrAu2G0k7i8sz8
 qILY4P+SvyW9mcfiwg/feEiTc3VHsOQYby460=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750542894; x=1751147694;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9FBJzCMtVV0Z4kD02yNM40lD9fGXKR/LcUs4C00azU=;
 b=XeovdmqEoTwFtQQfrjkfZsa6Hhgi67CnbR8yRF0qYVJqoi5L5HZxxKzM8mrsn8OYJA
 27QdeRLqj2la2B21T0kio441OvN6xiDgBk0MjrFjPBdoDXpGQ4Q2r89HfWOSryR+2POB
 g53cvuotCjbUQtA1n4uzTzMSxVTWM260d61PUb4zzvDRuLlfsxTA2N3LHUZnBeSYrAQi
 aQoJ+INDPyIz5FAd4KaF9thAmZcKIEb10dtY/3nzXQn89xAg3Hu2Az1A+PGamfBMbkKN
 CedGZkgN8TEw9da1gi78JG3dJ8wiY+bMEO+mW1p3m3FLdS2FPyzfazrmmiiL//NDftGd
 Tk+g==
X-Gm-Message-State: AOJu0YztP1/BuGvot5RAHGUybmWnt3dE3CdWDuWHU4SO8ScjWDK5NFLn
 vIS7cVIF6GJUtAYUAXlBZYUkysHoKGUx4KZxh2Llk49FDNcFF4HT3nZDu8ekYWK5efDA73YqfCO
 jTa2kt+s=
X-Gm-Gg: ASbGncsq+duIrFA6YM0rGspPOjQe+dIQHegzdQfLtgxt6dVdkzgZAO6cTYsdbFOtBPn
 jVetmDyD+QbQGKSWFtcbIuoUtTCfR3iBtxEOMoF9ZIMcCSVdcQkLIz+oIrh+DDAqhRxqym7zoXe
 9wuChQqz+4WZcr0TTcTMUNk65TwRBc5dsvcq3AO2LiJuBYxRrOUD1UUgmK9NFcdhe87/kzqCv9J
 Et+chGCBtJ9qEaeci8ZmSCnAZjR+QXa1dxpH0Z3mfyzJnFpX3DC7mFPYOvkeAHCDxzDM5JNdhhr
 baCnjuugV4kQyCl8EudPVsM3GKp3zWHi/sFW8q9xe2YBONa2UUulL4FgG1sfZt1IIjmf4WyarAu
 EnldMTOA7fpVhLvxsk6gYCA==
X-Google-Smtp-Source: AGHT+IG6bitFMuo18B8rxcsMnlZQnvz6oBiQ8VOHuhl6VKeOvwzqWtzN45r+360buAy81BsI3vUCoA==
X-Received: by 2002:a05:6830:6991:b0:72b:8889:8226 with SMTP id
 46e09a7af769-73a91c59284mr5070383a34.7.1750542894349; 
 Sat, 21 Jun 2025 14:54:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90aee76dsm859664a34.2.2025.06.21.14.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 14:54:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <20250621032205.19329-1-mibodhi@gmail.com>
References: <20250621032205.19329-1-mibodhi@gmail.com>
Subject: Re: [PATCH] arm: kirkwood: Maintainer for RaidSonic ICY BOX ib62x0
 board
Message-Id: <175054289338.3757745.17480908878927013683.b4-ty@konsulko.com>
Date: Sat, 21 Jun 2025 15:54:53 -0600
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

On Fri, 20 Jun 2025 20:22:04 -0700, Tony Dinh wrote:

> Add me as  maintainer for the RaidSonic ICY BOX ib62x0.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: kirkwood: Maintainer for RaidSonic ICY BOX ib62x0 board
      commit: 418acf8c78ed21f2cfdfa2cf3471446ee96374b5
-- 
Tom


