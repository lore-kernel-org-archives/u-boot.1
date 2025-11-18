Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471F5CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F9A783F9B;
	Tue, 18 Nov 2025 19:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tn8oHtXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BB283CB9; Tue, 18 Nov 2025 19:04:27 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE8BC83F95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so3999531a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489064; x=1764093864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+tWt4Vzh1/y2nxPy15wsUMzXsuS8LIvbb27Xfx9pYY=;
 b=tn8oHtXQsNutKIVxy4sGoB8m4b2RAxkkWBFZy9a7UU6WCjiMmuLS0Xt6JjYrjpAj94
 G0jxLgPkGgWEXE2VKFKtBe+HG4Konzz3kCmuoNV76NnuiVhZmEyov+RKxMfoKugM4Hnt
 RUBJY6sOiowROXqGpwYD5FokUbduWwYj9haUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489064; x=1764093864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+tWt4Vzh1/y2nxPy15wsUMzXsuS8LIvbb27Xfx9pYY=;
 b=uco4pQUwZE6KIJWtUr9Kvd02jEiq+1lYeuWRlkBt7qqs9lM88fC4m+caOwPuYFCGN7
 FDZAPLpHpwrhj2U5Z7U0LVSogCybWv7WBDwqXnz+FN3uN6zF1B+iHCh8jHsED2XE0TLs
 LJ+bRFPhhOAcr2pBx4igfdINxs8BTC1QFxQUsRMjwmnWjg35qbIwuEitxA0mNZeD7uWY
 N++cO7dJFzTsHJmC53EKa/Y2nYBWW6jmFmiysxgN5XyuCykBNnjT5/eGLZCTaTVQEBtc
 02HvlWqVAYF3UEhUcl1WQFZJez+QbGbYEsa7+dR5cIxIgMyQhB+Y6rXPjpqeZFilwRk4
 dmuQ==
X-Gm-Message-State: AOJu0YxSFH5Cf1yY6cB/DRqoq9csmqsBDUDKj7YgmeUr4HRA33/EX+NI
 1tEIVbsl2az6u7F0KD5d1sYpurUIaYrGEWrffPfU9utWXq/DoxA2vCoIKkKLQyblMzAGIsoPJNZ
 x2O4IMN27Aw==
X-Gm-Gg: ASbGncvqsLIjeF5TmoGWjliTPRTykRsrPG1A1VdhlwhvVN4OJIJOERS/S4CkhDSvzot
 TjuWzm/NMzQT+CIJ/iTgs+EryJoorROIJqAKcM8uu/7HgxjArFPyTxtPTKpF9rKvaQzPCjGoLBN
 EBpId5xe//wgEGkkaOJSsvUvZDiiS0EV58At9jWQQpGo1qyIIr/LfwaFwh6042A8Zmq3KbdoGhe
 XOTnIPtcBt9RNtMVYzhJ9ytb7IBYOcEKsIEMXykgEXIMMM/b7eR0uG67YGu7Xdfy2rrUOLS+3Hj
 Pi0W4RGjH6la+KkME/V701NFbsjTzA/M1AjBiiEqG3nYyWsCJGnjIXBv09BTvpX6WfuhERJiiP9
 Ko7HJlpqAnk5H2nx5K2kz5/B8hKbzkJc7l+ZWuzqpB6S2qFA8USknbekMS20XMqlr7B8PHG+35b
 QfroApOaMQ06MANDMTgFLoGdVNtw475tNTtg7KePBhE9olPzLn9+u3
X-Google-Smtp-Source: AGHT+IGPfGNjwCD29zalne5D0QWN00pzNuiM3FomFLRzQaxrS/OBP+VO+6ZIl4JThMYX/DVJkqh/gA==
X-Received: by 2002:a05:6808:1a18:b0:450:c0ef:8075 with SMTP id
 5614622812f47-450c0ef86cemr4294076b6e.8.1763489064337; 
 Tue, 18 Nov 2025 10:04:24 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75f729497sm2975128a34.30.2025.11.18.10.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mx7ulp_evk: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:23 -0600
Message-ID: <20251118180423.591332-1-trini@konsulko.com>
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

Cc: Peng Fan <peng.fan@nxp.com>
---
 include/configs/mx7ulp_evk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index 654537684ba9..ace1eee70cf6 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -31,7 +31,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttyLP0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx7ulp-evk.dtb\0" \
 	"fdt_addr=0x63000000\0" \
-- 
2.43.0

