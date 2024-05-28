Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF63C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 10:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDA298848A;
	Tue, 28 May 2024 12:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jHMu40L5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D775B88472; Tue, 28 May 2024 12:00:02 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D527687C75
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-529644ec0ebso969062e87.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716890400; x=1717495200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9BrpeHxzmh0cjPukC5O5UtA/cg6sVMBI6E3IKufVYu0=;
 b=jHMu40L5Mt9ALo1DIHTq6H7Fpti/vVi1wJ28XPN/75Z/w5i0koPrCwIJX3JQFmBMHy
 ztk7Z7JUXCfDHqy5f4rII4RZ4E4QlxTB9Qhn8YTc1GeRzQX8w/uKkpbD9pkVkR4iVzeu
 OnjFjutfk6kohXjrphka/kzjtB9At+WXkp3uNZIBYlh9iMy5XxPXEuyrmMv3hXM0lDPD
 3F5yrmjKuX0rNVVsm9HY8AWXQoQOsr0LgqYY/cR4egmWEGcCVpBNsMJhzjacefZmmTaz
 mJar1eBiPwxZISok1SB8Pl5zrBRi7jSz3usteSxWR9JNahv5ScszOp5YZsLKMYVFNMuF
 IPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890400; x=1717495200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BrpeHxzmh0cjPukC5O5UtA/cg6sVMBI6E3IKufVYu0=;
 b=hPgQ/x3a4C8nWcsdO8L+JHJgi8+Jz3ectvdpKLbIu1NX1VKYJ18DB+qgpMdXTK+kHv
 4HVMW98JEaOFjFBY8wAjAGBlNOx0oqSPQRUx63EQVEykcTJ6hUIlMAorOvYsvd+Pu8Pt
 qj9HfOMOwP2Pirz8AZ0ZoNu7xnTKktJgKBHWNM+crX7lI59zegAG9nKL70ktICzKkh46
 1EoSdC/dK/+960o3yJ6g9XDpB7DngSi+o+eu3dbDhu8mmmEz62IidAqiq3psXFL6fAZi
 npMIR/X2Hpq/K6nOlNpcv3vpDoqMoYNzmrINPlbqfleuwfoqTNKn3CS0EI0tuw1GxEXo
 uGFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8xTXQFh9LurLs2SlT9edtQErt/a/lvH881J4Ef/IvomfNSxn2A3nIhU7jIb1syefYjlDyuZrdPwzgfSEsWjuvzWsKKw==
X-Gm-Message-State: AOJu0YwPLQxDSfj0nTQATmhlwshb/OmoVhnoOJEOO/VfzUjCoQ4i7kLT
 UnyW/gmc1/CiX5Q+dch95ZPriiTf9VN1OsiWrydlNajxu+QvxZH1
X-Google-Smtp-Source: AGHT+IG5VeTx7FCs64r011QQ7zulIVI+buRAPOpmIxDdaq133YHHt2gXn5WE9s6KBOYeDG0NXBucGQ==
X-Received: by 2002:a19:385a:0:b0:51d:3675:6a06 with SMTP id
 2adb3069b0e04-52967a2f230mr8060545e87.66.1716890399650; 
 Tue, 28 May 2024 02:59:59 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a634da2e2absm33239266b.87.2024.05.28.02.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 02:59:59 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 0/5] board: toradex: Add new Verdin and Aquila SKUs
Date: Tue, 28 May 2024 11:59:36 +0200
Message-Id: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi,
This series adds support for 0090 PID4 Verdin iMX8M Mini Quad 4GB WB ET SKU.
It also adds two new SKUs config block support: 0088 Aquila AM69 Octa 32GB WB IT and 0089 Verdin iMX95 Hexa 16GB WB IT.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Emanuele Ghidoli (5):
  board: toradex: verdin-imx8mm: add 4 GB lpddr4 memory support
  board: toradex: verdin-imx8mm: increase maximum addressable ram to 4GB
  toradex: tdx-cfg-block: add aquila am69 sku 0088 pid4
  toradex: tdx-cfg-block: add verdin imx95 sku 0089 pid4
  toradex: tdx-cfg-block: add verdin i.mx8m mini 0090 pid4

 board/toradex/common/tdx-cfg-block.c        |  3 +++
 board/toradex/common/tdx-cfg-block.h        |  3 +++
 board/toradex/verdin-imx8mm/lpddr4_timing.c | 14 +++++++-------
 board/toradex/verdin-imx8mm/verdin-imx8mm.c |  5 +++--
 include/configs/verdin-imx8mm.h             |  6 ++++--
 5 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.34.1

