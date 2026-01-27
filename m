Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDA6D340BC
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AAE84172;
	Tue, 27 Jan 2026 17:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D8r2cEIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D107C84158; Tue, 27 Jan 2026 17:51:13 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4EFC84148
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so52151215e9.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532671; x=1770137471;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fds6Goz+tZN74HzGAhRCBlTVQLomOGY8XQ8rS1uuyhg=;
 b=D8r2cEIMZjoB4C/VGmcKR8R4iYD1W7ABM/vBlaBq8YIQfu9IHcY+RCAwJzPRg9+rTl
 nvi3iov7nf/6t4P9igTaNnP5lbMUfxd0fNoVRqrHsb9vye+45CjCTSFlhkmq6B22pHFm
 Z6uTJphleK2lViIEIoFbcEpaHVcqrIsDrPEMe+MdrmokfkWsVDx5uPsQhcKZMYjNY6AX
 RKN7/gGCjvg3IxkqiU3xzBxITPnQGt73mS4sc80+2o8HssA8h0BQfD7rsT1HB2B+DDez
 0XOSTDVGsRcWkwj6GiA2wIXR3LcI0rSa2P1U9CV8El+ZWONsvJFxLcyhx5ouTqdbdEql
 iLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532671; x=1770137471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fds6Goz+tZN74HzGAhRCBlTVQLomOGY8XQ8rS1uuyhg=;
 b=TxcJkqaI1i+2LdkDq8vnp5WR+kyQaeFoEgE9DOsvCST/CmGs5bVw65WtYowYx/cecT
 FsQuIZNLPdb2AG1zE5cOCGllbJWmR+mRh0nG59cFl1qxPkDHCJ2qDODqAfuCGOKOvKL2
 o9LfT6E/gd+PhveAPfz2K/Lq+NynAuFnwfe37TXeL8QXnCXOJrBlm5K1XpMjeObkMVlA
 8m3lGmZypu2sY2TJiDuwXifoTiRLC4zrl9+LR9uNtiLKLcfdWtbVFyMdYRnHri2e0CBc
 Cah7Zm9u4MRE3woEj8oYR6PcntblrhBBp+K2Gg8tWmLhfiJ6LNn4Z8iPx/XP1EEhBWUG
 0D3A==
X-Gm-Message-State: AOJu0YxvQX/U1T5kidYZ0GLANTIiXNp4K/xF/aqPnXwIByh90bPvQnqD
 OgLqHjtVaAtUS9ux5LXaGJFGVu1P+BKFxDSiD7TxHw5j2Ghj/FB6L8r2Pfp1MKIHYVs=
X-Gm-Gg: AZuq6aJqcrA5YR+IpalP3YKJphci06sFhVgULQE2Lv2rSvF+h1HEyN8o/kZH5tY11s3
 1Cgg/5nIa22fjo7K64eMS5UzEtoo6NwSJtMiVj8QzKqfVUm5+Rpeipa0i95bge6TBJzs4M++8Ws
 y6KKVz0BRIql5W46ECKepZdb9Gn9X9v2DuMYvkLGlVZ4XQoyJKA0Vs09Dt9ggMaCLuYHebiXcMI
 Iu9GnACGTyconqXJ/xSOkkhZLMxVfQFh+z3UR33PNdqhCn/xv3FGeo2tbs+uLBadGvwksHpix0W
 bEJOF+H0xxhhMNmKGqe9e+I5sPv9de1JiRxw1T0VG5xqHhl85V+SG/o+klc/qz1EBpuwaYdWbcf
 hUNVAzlxm6QmWyRi/xFwOMmnjnUBQxoaiiom4AkOQ3LUaTpxMffE/N8s/kk/ffmKjZTEBoYThJV
 bDuKWL7ky6
X-Received: by 2002:a05:600c:3e06:b0:47e:e952:86ca with SMTP id
 5b1f17b1804b1-4806c00c0d5mr19122605e9.2.1769532671188; 
 Tue, 27 Jan 2026 08:51:11 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdeafffsm4311745e9.7.2026.01.27.08.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:10 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:18 +0100
Subject: [PATCH v4 04/10] configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-4-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zIA8eqmsLN5UbKbtqbRAkPU3FHsS/TYTvgGNOss3G4E=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN4f1WN6p+qxqNkt3cv+Str1c7IZQusuP5f6lL7pF2
 FatFDDpKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIkwH2dkuKh/htdC66FirHtl
 8tZdnNPbzX/Hnqy0/LT62NpbDsHfahkZtp/pVRXru2unYhMyx2dG4+Nn1k9Fjr/TYSj7YC63sDe
 JGwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Enable SPL inline optimization to shrink the size. After enabling
OF_UPSTREAM the size is otherwise too big. Enable it before enabling
OF_UPSTREAM to maintain bisect ability.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index bd188c252780fb541afbbe61a243bddaab79be93..17c0f840d3ad3cb6f09fa914655b304e90d0066a 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_ETH=y
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"

-- 
2.51.0

