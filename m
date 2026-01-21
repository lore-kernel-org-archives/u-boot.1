Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58038C44506
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 20:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911DE839DF;
	Wed, 21 Jan 2026 21:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GdTyhkr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEDE83A1E; Wed, 21 Jan 2026 21:48:44 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68EEB80077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 21:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7cfd2423793so120840a34.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769028521; x=1769633321; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+yqj1pSHRxnG/Te+VViLzGO7jJmbI5dnk1bs4/0AN8=;
 b=GdTyhkr/SM5DCDv4ZPBl+8B8ZRIFFZNJYR9OtBxruawwoiFKzRJBbKoF/XzLnFgcxC
 6rEHGxilc86yQuEd80e2i0XAFjINAMCD8zy6kEYhiLqIIgo7eCTexq117sDZqHjPKEKF
 7S5KSSGzSrCyAD5inLFT0C7oexzt+UtMknsh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769028521; x=1769633321;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a+yqj1pSHRxnG/Te+VViLzGO7jJmbI5dnk1bs4/0AN8=;
 b=FFW/4SRXjN0Nsqc2f+Xii5VhjCcDHvpURctV1TG6kkCwU3viy/7QMInGFhe274kIyt
 YK/fzLqWFNqJgzLcahhIzqJHZkRc5weYM9x71N4lGeYsSEP+6PRFdZhDrckiVfNrO0/J
 xLN2YcyyzqV+DWT4EeAeo+Xt8ulFs2cx4A4382nmGm5aIyYHB5RL6b67fo46yqIloPc5
 EBtGcapQ6agER/QJjYfTaBkap8Y5dtX15PXvLmCSeT6EeVqrV3TgOQgMw5ZHFT8r8pBf
 LNMDb9J0Nl3hV7+N7cdtaOJ1pb/O6+024N9PWKsHU7eFvlI8GvhH3IhQtDagKhhZ3n1V
 LqJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWleJDbDzSyH45c7cBZM/OkrvOP7sS/2SoaQs8WyvjQhD01Q457uGyMHfurP9XySZyrKELAWvs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw659q9FWs/WVjXLbIAvoHYrGUsbtf74h0+/nsiCUm85A0HrKtC
 Z67ocLK790pdjr/mXpO9k27rc2m219EcwXn9bQNqfyvuI+L+4wnzgzak/wnCKx4cIo0=
X-Gm-Gg: AZuq6aJ13xpf4cMmGb2JiJgq/iXh13QlM6a84ukK8XpxD8Xa5DqKYb5mXz4AABUNrHM
 wsSmJQlh4ki3Q+ygee6G0jNtGKD1GD0hCl7nfCG9BtWuArk51BkpoCfPpC2872FqjqU6hgKGYcm
 PaOFWY8D7Qt8YyMHSfgkcdlakS7cvPOX75ty6Xr+2KqG0p+tuY1HFG5SVW/uaq9C/VKqAAAfkvq
 C3GuFOu/8OWfIJfCe3wfB8uPx3T3py1E1vkSTMMaaJZB5o96gFnMqxTtWbZcGyACE7t2MJGrrD6
 0/bwuGmoJieD/JuctlfxXgAaw5lOUIsNLG9XTUDnh/D305aVvszmUfCqGdwc0GI2420b2xTxXjK
 iLsN04de9GfNoJdXrUR1aPVdEfOUTSeEjeh+YUmUY6mFCbosGG5SyauWvJXJumQvo0kPNhFZDe7
 GOcz+VOD0o85mQwbFahppGIn/uZ1Vu6udIhp9GCp7bAqJux2noe/tU4yhOWox3VHePzKlv4ct8C
 UgoUyZKCR2/qPm8/FbEPVQNAif6zwtA4XuflA==
X-Received: by 2002:a05:6830:270f:b0:7c7:62d0:b462 with SMTP id
 46e09a7af769-7d140a3d5demr3533389a34.6.1769028520991; 
 Wed, 21 Jan 2026 12:48:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm11134487a34.6.2026.01.21.12.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 12:48:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260108-clk-uclass-better-debug-v1-0-265900a42fe5@baylibre.com>
References: <20260108-clk-uclass-better-debug-v1-0-265900a42fe5@baylibre.com>
Subject: Re: [PATCH 0/2] clk: clk-uclass: debug message improvements
Message-Id: <176902852017.661474.6690173700478583306.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 14:48:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 08 Jan 2026 12:05:53 -0600, David Lechner wrote:

> I needed to debug some clock issues and found some places where pointer
> addresses were being printed when names were available. The addresses
> are not very helpful, but the names are. So here a couple of patches to
> improve that.
> 
> 

Applied to u-boot/master, thanks!

[1/2] clk: clk-uclass: fix format specifier for ofnode name
      commit: ec956adf378a4b3bf133a2c1b6614c4891743843
[2/2] clk: clk-uclass: used dev name in debug message
      commit: 2540dd7be91608af2df7138e9fd60aa9778b7290
-- 
Tom


