Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E0FCEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B363C83F9C;
	Tue, 18 Nov 2025 19:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Knbj2Epc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3D683FA5; Tue, 18 Nov 2025 19:04:29 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEC783F9A
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-450c9057988so1047750b6e.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489066; x=1764093866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tq3P2GSWqKQvv0wuEro/qWkAugDi3j1nG4f+EXME7FQ=;
 b=Knbj2Epc8xP0m+V9Lzlb0KgIHwtyNOsfE/jbF7iJCeVK3SstuDImZPbjT3G8+t4iNE
 VdjGhD28Iv4Tw+hH3pJKbq8DYCL+9Z+p3dLjBBXn658SjIofuvBDtHLY7eUGjtB5ofM3
 ASOawEDvKylenHELbqNpk9Gp5g9ZHXMSDMcII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489066; x=1764093866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tq3P2GSWqKQvv0wuEro/qWkAugDi3j1nG4f+EXME7FQ=;
 b=Hs4JFjJQiCmn2qEmBWPbZHjVwyDLAMsopz/2n/vUUxnsDuOsU/qYU6d3X1jobQBv5+
 RalvE0iSuZ0SDhPexVGB6xEiUbjrCZXv9JaSi5VrnbCF7kjtoRytH4SkeUvqlsTUw/uA
 pM8NfrYZkk/WYz2tl/GXXDrp35MzlaUkIRmsnobhICkJDzohsjl4zJ+5xpu/Ah867fto
 mc7o+IwMnZ0FnU+yctbGUsA5t2C9vxTWwAUm15/NiTyhdJxHY4x1H/IvnIo4TNSQl0ZA
 HeLdg4MEROrXDsa8VH1mc7x4qYHeKtsm5dh19l6V6h8wGCp3qDmdObAVI5qhU/FGP6Va
 4SlQ==
X-Gm-Message-State: AOJu0YxYAvLkFHfh3q1Ht4zvwESH4QH5u8vsfoAzok3Gl306QMaotOyU
 I2a/xyawFxCu+S/3OefGjN7nsMGg4QjKz7Ng6nMylXm3UtrAuCJi33Wahn8HQPgyr7vY3Xi0DlF
 sF2gpBeD5xw==
X-Gm-Gg: ASbGnctqu9BtMac3yOq/ppGc/2IQLRYD3D9XwY/fSY3BCVgbqbLhxW3e+r53SQes3VQ
 AxcYNz+10CFjxpv65EfSAq/TyXpm6vwY6GzlpAqVp0RhE1TEjlNDKbcFVB3vkUyqiMSYyNYi2nw
 cxRHCah/N4tM+b3w/ZXFYe+IU0TrytgQyaYjNdapRogcyEtwDQnHC5/lDdKg4/B2hq3LipIp3Z3
 vPUR+u0gyBBaG8qsChFAEKFItqtLh21RC+eXzIRTWt5liC9+9APbzsLf1ydq4ZC7DXEIgtpf33+
 VgzzL708d8GO21sdCqlLyUZ0o5tkxHzJRltE4SbTqVK4A5pP7+hW0RSmicJY+JIVOuzbjQeg/dV
 aRKzfGbIP/uGyMZ8S7UPvSY8j5mDzBeo06OuuXFinKpp0HVIu/0XY3n9q59izVaaEs/Jj/KByK2
 QUaPfgxOOMcdHuIykk8QdN8e3hX5ZlAediLvC2sqAhWxx5+fstOyHrwd+x8+/6mFUQRK6jrQLxP
 Q==
X-Google-Smtp-Source: AGHT+IE25ukXhC8edGEoBGV7BVZ1pc0R4sxw6F9xTWbJriplucuxC2YkmtSc6XM9pY+SkLeJYZP3jg==
X-Received: by 2002:a05:6808:4fca:b0:44d:aa8b:58f6 with SMTP id
 5614622812f47-450973ba4d3mr7624122b6e.1.1763489065828; 
 Tue, 18 Nov 2025 10:04:25 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450b8ea2651sm2517325b6e.4.2025.11.18.10.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Parthiban Nallathambi <parthiban@linumiz.com>
Subject: [PATCH] mys_6ulx: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:24 -0600
Message-ID: <20251118180424.591379-1-trini@konsulko.com>
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

Cc: Parthiban Nallathambi <parthiban@linumiz.com>
---
 include/configs/mys_6ulx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mys_6ulx.h b/include/configs/mys_6ulx.h
index ddd46c8f945b..35a69f15211e 100644
--- a/include/configs/mys_6ulx.h
+++ b/include/configs/mys_6ulx.h
@@ -32,7 +32,6 @@
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200n8\0" \
 	"fdt_addr_r=0x82000000\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"kernel_addr_r=0x81000000\0" \
 	"pxefile_addr_r=0x87100000\0" \
-- 
2.43.0

