Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7FCC61DE1
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 10:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB80583E61;
	Sat, 21 Feb 2026 11:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="npiU8qsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0954383E13; Sat, 21 Feb 2026 11:00:53 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C96A83936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65a36c8bcabso4592613a12.1
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771668051; x=1772272851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaiXPfx7qFXFneWvFtY8bsCeFS62xz7AgrsXG0Rnxmk=;
 b=npiU8qsfpHLOfnKwFKeyUZK3rGTOq3R3aDA+mafiXGasJdUtTP8zVPm6gm1gZT8Np2
 2kRATjtKMNiTFMYx64FkUA+5zAiA0i+tjEtY4kmTu+O9cCnXEZdZeW9lyEZ2ntdC6btC
 763nNjIwHlwoNnQzEI49si9cZQsPdlGVxmxIVw8rvJwxH5Kqs1Q8vHDw3vKP6HxI1dVB
 xu0DNvloh1qyzR5aEtSwbQ9/E41jkDXr0XZ1r1g7cgjYYL+2YY4cjCNRIj6fVh2sSzcF
 LJl2O2cGL3HLNXXJ/XPRLfOmyshXApTu/n7OSZqykoJquGikTB/gKO0/LRiwE+tXwXu1
 HYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771668051; x=1772272851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EaiXPfx7qFXFneWvFtY8bsCeFS62xz7AgrsXG0Rnxmk=;
 b=kST9SSX7dTfSoAFqjndaVNMPnu5B2PEIUNaQFvhzmtAMmDhiiCvUDq3C192/NSuYjo
 pxq/TK3wChxTkU+aOiD5MaypLJDuncZZ9g5io/ZaD0iSJYJ5nojtJ3J0sLrr18s/Bab2
 l0tXc4L0EbUN6AUT4n4EwaYaDxsuT+XE8882hSTCSLOt8lRSw2+6nGs+964VrNSeID/A
 uziBCBs29Fo2LSsa+sQdwtjveUQ6ExZLc73XetcSRX26nQ1hXCit+qdJwNoK5YPfxTVu
 6Ul8ABZomoEAmSgWv7MHGA6gPjpDPV4+YTx6MoSffSslXCSrHLdOhWSRqFKMOYScJhs3
 YXAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNvj6K4YIUnZE03zC/MX8TU1a0VRV+LTxg3YH0015Hep27mZ7iXwsls1M9u5BBfmybr1+a8XI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxl0BH/dEOga+JUD5QkahzI+eH/T/SxnNbp6Z9DD1UY3m0RpYZL
 5R2+Gx1gddiK9K0dkYy/i+/KSe4R5RkDAgcwS0FHsv+Clxpx9rZhDy1p
X-Gm-Gg: AZuq6aILF7aNFhFiSXNMWCL4QxyKP5/AVyjE+HMOEG0tqUzv52F+CV43NLqiwsG1rTn
 YTY3HmEUcuV2mB+HG9KrgGdv+OBgFf0qrxL228REqtBZEJEgigH6pY3ruPDFA1QNKr/MEUYD+3a
 92NR+xYTwiqCNYwc7j7s11KzDdQ7vzIARtqZQLKzPXkINpIeI1aHqgOjUHM4EBfULwIRXck8QKB
 MEAcEkbCnIAd0IQBJ9vhcMS8v7bSH6DI8pQoL17DvtCCG8hdBTTKteTyykTAt00XvNvleHAwwxR
 OF12oYOXrgdKMEuzadR3qhSBBrmUym1XfH8kIBv6sLY28fTRSB30q6MvJ2SC7Ynf8SJh0uh1/gY
 CwF/UBGL8/nf7XgSA+lnk5Lxa5QM0dfUhRmr//ROlwrjtm6IGpWsSlkwBil5rg+nHf0NHFYLyll
 mafiv6ZIdBeIVvauibiygZtHsgzaFhRbx5/m/JXO242GwX9jhNHoMa26S81mvadVUO
X-Received: by 2002:a05:6402:f18:b0:659:4b76:74f4 with SMTP id
 4fb4d7f45d1cf-65ea4f1a583mr982363a12.16.1771668050550; 
 Sat, 21 Feb 2026 02:00:50 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9aabb2sm421298a12.8.2026.02.21.02.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 02:00:49 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/6] fw_env: use "erasesize" variable in writing loop
Date: Sat, 21 Feb 2026 11:00:06 +0100
Message-ID: <20260221100011.29049-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260221100011.29049-1-zajec5@gmail.com>
References: <20260221100011.29049-1-zajec5@gmail.com>
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

From: Rafał Miłecki <rafal@milecki.pl>

Use "erasesize" instead of "blocklen" in flash_write_buf()'s loop. This
change touches code executed for bad NAND blocks so it doesn't affect
any behaviour (for NAND flashes "blocklen" and "erasesize" are equal).

This just makes code a bit more consistent as "erasesize" is what is
used all around inside the writing loop.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index 425faf380fb..c69da0b926a 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -1096,7 +1096,7 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 		}
 
 		if (rc) {	/* block is bad */
-			blockstart += blocklen;
+			blockstart += erasesize;
 			continue;
 		}
 
-- 
2.51.0

