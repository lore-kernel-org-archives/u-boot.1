Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC47C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 18:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFB888154;
	Fri,  1 Mar 2024 19:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I+0jTU0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66F388157; Fri,  1 Mar 2024 19:53:36 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0762E87DE3
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 19:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6084e809788so28965537b3.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709319211; x=1709924011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc8wTtWLJ/imMC66wII0Hl8vZEj+h5PpFUSrKDBJr3c=;
 b=I+0jTU0ZOsAxjiSnpls3lCx5gYJaHh0korcNMvJK3Y6FMreH1l+q6xgvGQsDWSfCQ0
 zoqq+uj//S2hcjUSjlRuYq3EojtuXMBKrkfpWYSiW0rbF/xHkjiDZ8YBDXTxI7M+k4A8
 uyvDcT0KkJJfjwIvqeDYH/0FFx5QG4bJgpRCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319211; x=1709924011;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc8wTtWLJ/imMC66wII0Hl8vZEj+h5PpFUSrKDBJr3c=;
 b=VtQW+Illh/nMm0fQ7+YVH3zZAMcAfNmhirtCUb31l9qxZP/Mr+iT31CMUKMlYAAlt2
 N3lCUMSeflKNTkQtwzRzTjiQIP4HVhaZmYaB15VDwtZsbfKP4jZNZxb4g3iDccK1ptSd
 7EXMidcpE+8A8Dqcg89dN1CK70FBScmBSWySksnjOg/yffBToluTpGui5VMVKcz43O4m
 W+gfRlJ1P8/uUeKpupvRKcsP+lg21lrhXcJsD2fLoXqp2zG24jtPJYApBC8xOx7LRE8S
 kFzNMQi9z7fDU6FjjZj1XzUXWWlfw/4RR1ACZCSYOfjMxt+yLPtVRYpJP182hX6g6wcb
 1Xqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5135yBul4VY+nmcmzxgo0vKcG826VT5XtGgbwvtJbi9MsEBMqdwDpkXQio4eYAE95lwVhQm6qeaeCyqu+PaY9x3qbUQ==
X-Gm-Message-State: AOJu0YxDHTckmFfaCVEOlCc+fYiYc3ez2eMyAUA5lIdA9d8sMfAPcAg8
 TgOXObLDsi4y7iid/KwTYTO/ydz0IkTkEy5akdDLFlPEcGMqQCiQxDf0MIFDiAo=
X-Google-Smtp-Source: AGHT+IH6OK9TT1bpKF1J904bdQColt2hrhj0pq2RAfgVKCQkHMBTt9l5Ywu5qxdSCqUqkyEb+bwafQ==
X-Received: by 2002:a0d:dbc2:0:b0:608:b8bb:f0e4 with SMTP id
 d185-20020a0ddbc2000000b00608b8bbf0e4mr2055645ywe.25.1709319211627; 
 Fri, 01 Mar 2024 10:53:31 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 z81-20020a814c54000000b0060851e1095bsm1083179ywa.96.2024.03.01.10.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:53:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de, 
 Sahaj Sarup <sahaj.sarup@linaro.org>
In-Reply-To: <20240223091143.9561-1-francesco@dolcini.it>
References: <20240223091143.9561-1-francesco@dolcini.it>
Subject: Re: [PATCH v2 0/7] toradex: fix reset and hardware detection
 regressions
Message-Id: <170931921063.1228636.17279914845817206379.b4-ty@konsulko.com>
Date: Fri, 01 Mar 2024 13:53:30 -0500
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

On Fri, 23 Feb 2024 10:11:36 +0100, Francesco Dolcini wrote:

> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series fixes two regressions affecting multiple Toradex boards
> (i.MX, TI and TEGRA based) and targets the current master, e.g. v2024.04
> release.
> 
> U-Boot `reset` command is broken on all Tordex i.MX6* based SoMs since
> v2023.07, this series fixes it enabling the `wdt-reboot` driver.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


