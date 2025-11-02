Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76C0CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 11:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C56B83642;
	Sun,  2 Nov 2025 12:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AFCiNtM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FD5D838C7; Sun,  2 Nov 2025 12:20:33 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C028307F
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 12:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-33be037cf73so3736782a91.2
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 03:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762082429; x=1762687229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cahkdBc/ysaYUM1biwLookvEy0+v49A18g2Mg54mAaQ=;
 b=AFCiNtM7xwFzCdQDua6ZXsQPD7VZ9ja3pzJ6LMSFcBfRsshwiW2M+tFMhN/W/9Euwi
 YIpXg+jiC3cWF5DjQYUdnd5qWL87mAwSjdiifBdGQqE15xLNh2VPFp5U8wDKgtoVXUfm
 H7RM8mOtflth7hg6XBcCf0Fkcw1FD4IEXVGI1kL7ec/r3+ORDQfrjVIlItjMRMbqohv8
 +d68X0G5HA2G1CdrNU+Sx3TV3cfdDuaSUVAlSRFxF0AYtgFCjSQfx3pQwieqTm5bnq9h
 sDj5V135O9hIQZcBTq4O2Jy+xKSngSE5JHpA/Wam9zdTGWHtM7YL2lGdqkw+Iuh2ByEk
 XM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762082429; x=1762687229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cahkdBc/ysaYUM1biwLookvEy0+v49A18g2Mg54mAaQ=;
 b=xVPiKHzTdnimXVNYHwvzeVBEzlom0iUcReAiEsFnOj0VIFW07XithbQ3i8CDU7TUEv
 Vl7igaPgaPVoiz7A4JIX3qkIewofnIZZIncJuBWhhMiLGm9MkjwbukthosNWP05WlT6Z
 F/Y8rK5f5SFS/Ugx8s47JYok6mS5bET8mTJvY4xqbpQKl/w7t+k1W3kswx6xxh0eYGX0
 wrfbWns5YpSFQANczeyuUBRTTk8WnNwBLKPapQUiAPWGNVrymO0yHEFHCL2JREM/0D53
 O1ztdJCtoMwjhupLs0072YjlrYN4cdIIWXDgMD172zNDuxVwjQ6sAjts1N0wT71PTlJ+
 CyQQ==
X-Gm-Message-State: AOJu0Yz1AWmVUubOInZHN3u3yX6GGRx6nCFoSf5rK2w8Y8PRTWW7KZEk
 RU5l1kQXSIWhTbCo2YH2GKl9pGmdNTL0yaqn6tBKbcsQRwMVQt9ny84guiFDMNOtvhU=
X-Gm-Gg: ASbGncsIVFknOVbbwvEz+s/X6FRfeTGDUB/9x+RSUjCBtRSwNA3CnMj6I5F/95zCSzi
 0RkEAxIuwh3VgfpaOK9SguPJFnCHJKe/IkTrvY75oViwaV+ulI00T2x//T/ng9/52anu6pA+XJN
 GuHt33eA594WlRDCfwkgk3UpcS9Ke4mB+RlZNjA4gKBm/TIxwfesIwSCZqgz+Pd+8mXJVlDHG7F
 J+7XBfXQYDTchlIn5S7z4RO91BHjpGvqps1wc2IVd6HoYOLDXS/89tE4JnjH8aonAA3Hc7sNX0z
 s8+vznp/k56qBneYuW4qxnBSjq6hUZYkRXOxOvlIh7qYeQClGdLj++MKQO2PCsna/pNNdfyhHGt
 y6SUI5idgXPjQdQmzpxnerYOqAMRvxo4GMWsE0xQh6sUQEW51UiWqIA4dCoSFLTpS5RMZLNYzKw
 6Utl5YOxenit7xHtqmdxWLW4oiZzrKLamcpmb3tgDctT2LwC3j9VwI97qeHzFyduKuvqh1Deq85
 VbOlvIjc6j+NmsKjSplUwfH+bI=
X-Google-Smtp-Source: AGHT+IFbyw4hHjeOwDEG6OmZLmwAekfWimTpv5od93iXY2y6jxPyono8rG0BzhvEk4VLCfu1zrQGww==
X-Received: by 2002:a17:90a:e70b:b0:340:2a3a:71b7 with SMTP id
 98e67ed59e1d1-34082fc3919mr12321623a91.12.1762082429027; 
 Sun, 02 Nov 2025 03:20:29 -0800 (PST)
Received: from sun-virtual-machine.localdomain
 (ec2-13-112-158-202.ap-northeast-1.compute.amazonaws.com. [13.112.158.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b93be404874sm7199858a12.29.2025.11.02.03.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 03:20:28 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: u-boot@lists.denx.de
Cc: Ssunk <ssunkkan@gmail.com>, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, trini@konsulko.com, Takahiro.Kuwano@infineon.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Add support for Dosilicon DS25Q4CB/DS25Q4DN
Date: Sun,  2 Nov 2025 19:20:18 +0800
Message-Id: <20251102112018.5334-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827122403.20159-1-ssunkkan@gmail.com>
References: <20250827122403.20159-1-ssunkkan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi all,

Gentle ping — any comments on this patch?

Link: https://lore.kernel.org/u-boot/20250827122403.20159-1-ssunkkan@gmail.com/

Thanks,
Ssunk
