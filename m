Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D0AC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0AEA80757;
	Wed, 15 Jan 2025 14:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qouAVs5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAEA8806DD; Wed, 15 Jan 2025 11:33:14 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D5280027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ab2b29dfc65so1006746466b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736937192; x=1737541992; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K+3TRDZytilIPkz01HdiG3b8bge2fcDZFWNP2jrhXvM=;
 b=qouAVs5/IDbyIGIR2ITc9HuHwRuF1DFBhJRtN4UmnnwmW4roB5eVqTFGWS/TpD0Npy
 4aEk9XE5L65xCzjNgIpw8hmPAZdJqISuW6AgRTbFHWVrQ+lcRrn/8QD8map8H0HQr03M
 YKSnp/x2amwaWr2fP/GGkdUq/tY9GWwYN6MhdPQiH/PWz+ldbqI3nhu15RYHzSPGDi86
 zp8P6A2Ww7M4n/D4G2xSc7sdAVe7hG8fDgZRG7p7JRnhq3AN8ftJ9/rHxPakbODQ1egb
 s4hGXzjrjS2USeDEj6HMm1JXdsHTrHl/FoWi0Fhu/S/HccHKDB3wRTyQh3wbgy4XrZ6M
 h0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736937192; x=1737541992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+3TRDZytilIPkz01HdiG3b8bge2fcDZFWNP2jrhXvM=;
 b=g0oVinUOuB4XxnGCfEbg98xNJhH8mLeIj8XZjmggbru8M14hwwkRfmOjiQSoOXAg/m
 aDTZHHQ5lvoVnbNFhUgHNrvQYo5ZiOPSBMMujmhtdmSkTkAEMHvyrAz6qGiDOWcpDNVS
 iowR905MXu4NTPywZPDQsID+QDrvKVoQLewGU72wISRghR/lUeKkMFc4dFGrl3wkLvpr
 1FWWD7r0R3zVTGudDrPp8UdDy0JN+QP25GSjxOw70QdxmpUbOa4SLpcFOBiuatCbfdce
 3qryKzsD6jAC5uSmcCCI0hMH3CfppfIntV0RRzB4/2bDrAGaKZm9crrzFTi8iZNw0i9j
 3xAQ==
X-Gm-Message-State: AOJu0Ywkny9+nnDpcx38FJVL6ECvzPYI9lQpk82AVxmdG5Zc/Bv9uXp0
 eL+cCUJRONuMRvJ1hiIHpfG7psMAHyE88V0PJoxBfrsVDm/ep6XlQImzKKrd/DM=
X-Gm-Gg: ASbGnctg+5/7sZy4sIJlaz6WGt47Op5bcE80nKF5QmLxVz0ND+NIpnrzSjflK7AVlhx
 f489jDePvkgkhl+wDv+SYkmkPjDXBG6YkOWLTCb8djaP4lqMF4FGd0h99WzzAC80ItMZMjc2NBz
 7HM9vFw4kdosZkkzqaAqdmHZgyYuxESToiGkUSyL2waF/X01I+OdliZbHTZztMIpNb96qNm0N9q
 UEGaS6pFAER1zakf7Tiv2Se+Qhgh4/HN4iN0EVBiDLxusDaHax56Hi+hspQQPC45USOYWA=
X-Google-Smtp-Source: AGHT+IEtKNuBZAN913Fqf9dd8RwdmHRmBOLfrUWhiZQlkXwLUF1YR/Ev2en0/w3vQL6mLirXXOP6CQ==
X-Received: by 2002:a17:907:6ea2:b0:ab2:d8e7:682c with SMTP id
 a640c23a62f3a-ab2d8e76ce6mr1994148266b.38.1736937191901; 
 Wed, 15 Jan 2025 02:33:11 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af24bsm742045166b.134.2025.01.15.02.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:33:11 -0800 (PST)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Wed, 15 Jan 2025 10:32:58 +0000
Subject: [PATCH 1/2] .mailmap: update email address for Christopher Obbard
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-wip-obbardc-update-email-v1-1-0b4cd69c91fd@linaro.org>
References: <20250115-wip-obbardc-update-email-v1-0-0b4cd69c91fd@linaro.org>
In-Reply-To: <20250115-wip-obbardc-update-email-v1-0-0b4cd69c91fd@linaro.org>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=886;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=8GD0ds3inuuwwr7PBCk2l9ta/WLOqy1RDsYbUiTjhFU=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBnh47mM/5BsTgVgNTUE6fwZJAvnzpE0lMMwhHpw
 9FTWTz1ETCJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ4eO5gAKCRBjTcTwaHBG
 +JUtD/wJ/5q4GcFwdx3Z7KcFRf2czk7+EvTbUiQPiKQ3tWCI1KQZfQTJv8q93KBsrNypy5v9Br8
 J4eaphZToJueI8NCcFD6HkuIy6oO3X/FctUceFRDXaL7enk6mlLE01cz3rnHXVCc4FyI8SdSxFp
 TFaG4T9StFsWIiJncHukccGyBzrJ7JNpMi9Yue7aDhLrQQshbpLQoLI66uyJRALKoiDA7hraEWd
 oqkH/uubIkt1m5T16J2pHuZP7yxORAYRtFMmNoyNO2XWVC2sxX+TSBWX2cbi7HhVBWA3CVwrDsa
 rgoZ4n3ncsCRHnwCXxzJ93Fu/o68afwN2teFRZFSw1f/A5c7pITc4lEQWaTGygDbjHJk+O+cH+J
 GxawunQYnfMJ30PoycmxJkpTUOwA1Rzr3G27CVKGRbvktQIWeuef6/BgKzED4X6lS4KK1NPaJfg
 k1JcnqjlPme+QvGUMq+54utqLY44s13Uz3MEB2GRJFU8vl0RCH2lS7XjzhiCtqX4pSfBt1qYu1N
 1ZXtlX6NntlM7YFttCnZKZ9GCVuhRH14iE7IuwDAT1id0xuccik6LDPiWfoOsYtqxqh3aLFI6NL
 ppppArbxtWFePao8oSRc14sQ4ziFrYHURbqNJdi2nqhtJ2tN1+ElLQvRc3ks93rk1P64pIwDhhT
 pg64u4nnBxzKE4A==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Mailman-Approved-At: Wed, 15 Jan 2025 14:37:07 +0100
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

Update my email address.

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 005e965b84f8ec441f7868664eeaf394076264a0..dc11775d4e7f8294f77f5bef55214c7f743e3202 100644
--- a/.mailmap
+++ b/.mailmap
@@ -36,6 +36,7 @@ Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
+Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
 Eugen Hristev <eugen.hristev@linaro.org> <eugen.hristev@microchip.com>

-- 
2.47.1

