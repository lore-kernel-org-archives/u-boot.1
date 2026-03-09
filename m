Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD47F41807
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE41683A8C;
	Mon,  9 Mar 2026 16:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ko67wSpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CBCE83F82; Mon,  9 Mar 2026 16:54:11 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0656583952
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso106883995e9.0
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773071648; x=1773676448; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QGiPkdKR+XWGlegOibRZVdoacz0wL2hrVGXx2XKjYtA=;
 b=ko67wSpzHlZwh+w3TW7HNkk31qzRZ7eCasQDxOwrP1TQ/IT14d6iJw3vwU2oTRs22+
 q2QZXc1CGHZZ2wKosZGpJ/3RUpbkUME0thTPW68viEKSWwvj/5rdb/AqvztBfQW4SryC
 JCh3g6E1/ChybnpsxgpuiFRWQo91Z3AEKr1L+c/XrPgv9AzMP5TQkq7cW5TpaAj4ZGQ4
 4NogoF7uFdNM6Cw0S4P/2rQaw5BpJEjQqe+lhjIdnFl/C02OOlxw0pjRd+mlRNlogtZT
 8EIC8To6JmJA6ip3QVQErhlSrVNWYoNL3Ra7Ab87b/ExZrDNsN9hCgRTKvPBoOoCVdmw
 lYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071648; x=1773676448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGiPkdKR+XWGlegOibRZVdoacz0wL2hrVGXx2XKjYtA=;
 b=w6v1wxqJ0RV4h0IgqyZ4Hsq+yclAgz/e7ZmMzDQihlCCfdp4h8ig+alIknYd7yl+DW
 ii6Ho9uc1mp2S5ewBgnjMJM9K7Gn0Sg6WjpnDBR5tpBVCsafWbB+pCTnPtWfkcPxYuEe
 5BczRrUEbQloswOHopnB/r7zKMGy8ZfI4mkQXvvBKHkwL0sRHi8XvYum0LPaOTPCSDtm
 ooeiRCYrlWZQpw39sXjOEQgGlbTo3oak3oHKlCpn6hPnWSuBEzd+JBGQjgwOy+ciK98h
 /JxNKVI+oBWpjEzZRgqc4f3OypC3g8EXA7TcF5DJbSMT5RPcgwn+QBP/M3LMBwzic8wI
 Z4Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ljQC1q3YiUCeo1pROGrZTwJu76nF6E/vj6GgjizCDd+9ArX58UH0yhfyqpMUPC1QOGFnM8w=@lists.denx.de
X-Gm-Message-State: AOJu0YwCWe58BzCFZNRzG49i+V2jYjbq0ypB975K486ew6qy3o3bVX7p
 yCrB13n1iZl4ETI2OZAlFqIo4VVqNMakWL2zslbBpoJgtezuHpDJH3QL
X-Gm-Gg: ATEYQzwK/jvYUpVlXqu5epvlRHA5vhkt7P9RPBm/Ovz+vWzWA5uLbfc0C/KcLLBlDLv
 FInqxRIbWf8FVnRNAVjDDD4M6jaRB8IWs0/6GY0X7PL90W65J/T9TSwZMXJzNjxL/M1Dbag+kMR
 TlXg60w0N1ppz4aMxrHg7B541wB1XjtROnh53Ic6VUk2/N/x4CsqQ8uVopv6Wi5L4jc9vjjqvdW
 KBnP/I2qQxVlUKwIBaSgVf8o7bPuoyQ3CO6SGdyrL4KV1mdYkWaoRJ2+ThLfPPj9Q8bLnQAcPo4
 GQjVnKPTYFFyTNq6hZutiDaUE4g08CZnRYU+WtDblGSzKFTP2Ij9ddYonO5hWrQkAWRreeTXI3h
 rutnhBBeGwGM9UmZbdoWwOL8Ig2cjG126t8X+C0Xm5DbrIEjnDDX3CMaaIxto/xJQs2lqn1DJgN
 v6MB3wDNAHTUf69hHdMBQcCmIgUa8qozfHRjuUQRvt0viITAYLqEluTpI7COb3ou5l4ZoHJizRz
 sC/A2cLhYOrv8YiqUb+8mHZaIuUmsmSp9B4G7vx8uH2
X-Received: by 2002:a05:600c:a12:b0:480:3ad0:93c0 with SMTP id
 5b1f17b1804b1-4852695d1e2mr189431735e9.23.1773071647970; 
 Mon, 09 Mar 2026 08:54:07 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485358cd26bsm84408215e9.8.2026.03.09.08.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:54:07 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 0/2] DDR configuration refactor and 16GB dual-rank support
Date: Mon,  9 Mar 2026 16:53:06 +0100
Message-ID: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This series refactors the DDR configuration handling for the
Toradex Aquila AM69 board and adds support for a 16GB dual-rank
memory configuration, while changing the HW_CFG pins value to
DDR configurations mapping.

Emanuele Ghidoli (2):
  board: toradex: aquila-am69: refactor memory configuration
  board: toradex: aquila-am69: Add support for 16GB dual rank memory
    configuration

 board/toradex/aquila-am69/Makefile            |  1 +
 board/toradex/aquila-am69/aquila-am69.c       | 26 ++++++---
 board/toradex/aquila-am69/aquila_ddrs.h       | 15 ++++++
 board/toradex/aquila-am69/aquila_ddrs_16GB.h  | 11 ----
 .../aquila-am69/aquila_ddrs_16GB_rank_2.c     | 54 +++++++++++++++++++
 board/toradex/aquila-am69/aquila_ddrs_8GB.h   | 11 ----
 6 files changed, 88 insertions(+), 30 deletions(-)
 create mode 100644 board/toradex/aquila-am69/aquila_ddrs.h
 delete mode 100644 board/toradex/aquila-am69/aquila_ddrs_16GB.h
 create mode 100644 board/toradex/aquila-am69/aquila_ddrs_16GB_rank_2.c
 delete mode 100644 board/toradex/aquila-am69/aquila_ddrs_8GB.h

-- 
2.43.0

