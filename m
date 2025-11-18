Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD8ECEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13A7383E48;
	Tue, 18 Nov 2025 19:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TKYCO4vX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3206683E0E; Tue, 18 Nov 2025 19:03:52 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A90C839B1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e2d1477b9cso3301028fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489029; x=1764093829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mn6UoqbLQt9RAzdGfrJ6EdxpxM0RFTR8XvDUFlCwKZw=;
 b=TKYCO4vX5Nb95oaPvMQ+uwG4SYJjwyRfkfRYxkhdUElmIBFphvNqWGO6XzFK4gVKEm
 S6z0VEev+EOR0FqceoOKKnleSd67kURFZMTvIXi5BepwqpJNU5Pn7OvAa00UBve5cvGl
 Ee9+P9nJbSD1JbuioCy2LQlOH7i58pruXQUzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489029; x=1764093829;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mn6UoqbLQt9RAzdGfrJ6EdxpxM0RFTR8XvDUFlCwKZw=;
 b=YOdYW1QLvhofHW2llDYYQz6jteKEzIAAvYKrRSc0H/sMa35Wrvrr7ZmZcnBY8RZr2d
 HsF6xNaGeLURLC29VPqpPnzJrrQ0ctBcp6LDmSytXwQOGJILkn3njpEaBY8jtOMk3s21
 DAI3Kz2MdmFUgqrInNVabN3n4L1MV6lZSH02MyDNEbtu1EJEmbv10vQ0C7anZ/qdaL8M
 Xqyquc0jfT5IUm3d+OnbBrDjELga/g5bJE5wyTi2AhQbUx8vvvM/L1fofaXaf3qLkPfM
 Er7kKAM39k0I2QTxVEEayCkuKIX2qDGCi6V0ECvNpQ+gIj4kNAxG0fXSk1gAGfYRdhq3
 sv/Q==
X-Gm-Message-State: AOJu0Yx18dMNSL6w/lmMxGsW0pkyGHKODEUnA2N2UX9b5GKQ9qS3wMGX
 2AtCyoFfaOSdBq6d+Dz/2UwIzh2Krn9lx1zYy6ABXisFcuOeid8n8ooUW5Mv8xXQeBzpeR5ozAs
 FTxiCwyjzgg==
X-Gm-Gg: ASbGncs2TomdXkKvRI7d2SY5Z88qLG/gKa6mIqeYLX8XgQ8bbOBFT3+q9bjdH7x9AYG
 4H0ZcTwYcOGZN+jymqAseWLtgAuyzO4HgnoGYSBUeDbNY94n6WL8PLCZXZCC0feK+Q8O1jW2O7t
 AzA/P+GIUkQ7PqzMODrIch/n8j1fU35WyiphKIyQn0TM/oFtuNZC4oeCetFgknnHJXF2ruLXU9L
 kxr7KtWSzkpMP7/2fMemWAkywLX6K65soP5XISwLzhu0ktO+W6k2g78awIoYyaGuccEPwTsJPBb
 HLKGPpddWWivx482fX3jpSZAiUBFfdbHgY3nymU9/5PGaD63tY1pDlWBTdeH3icodn6wUI7mv20
 k178D0OxMdLeneumWZwG00B/CLVAk/FWSYZh9gy8EYoA2wEqzdtBsLHrVbOhe3hRmdC4jW5B3E2
 d0jupzdKGUts6sZdy5fy3ZFESKzlMMfcXBoPad38jS0J1QnYrw1adm
X-Google-Smtp-Source: AGHT+IF14fk3muVvKGsGh2lzAeNrXBSwXNBnVvsej9VTDvO7cN++oUwkkZeImR3aZt6wyAE8qbqtpg==
X-Received: by 2002:a05:6871:22c5:b0:33f:dc6b:ba35 with SMTP id
 586e51a60fabf-3e8691b56c5mr7634585fac.36.1763489028822; 
 Tue, 18 Nov 2025 10:03:48 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e85206082asm7273929fac.10.2025.11.18.10.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH] imx6dl-sielaff: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:47 -0600
Message-ID: <20251118180347.590933-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
index 9aafa3c9984a..a7ce75a6e575 100644
--- a/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
+++ b/board/sielaff/imx6dl-sielaff/imx6dl-sielaff.env
@@ -9,7 +9,6 @@ ethact=FEC0
 fdt_addr=0x18000000
 fdt_file_legacy=imx6dl_sielaff.dtb
 fdt_file=imx6dl-sielaff.dtb
-fdt_high=0xffffffff
 image_legacy=zImage
 image=fitImage
 initrd_high=0xffffffff
-- 
2.43.0

