Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC05EC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B148844F;
	Tue, 16 Apr 2024 21:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iH4HTNp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A8188843C; Tue, 16 Apr 2024 21:01:51 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C748843B
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6962e6fbf60so41234956d6.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294100; x=1713898900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZbJOiBZgQ7IG/wDSz97Xp+97sroutu0BUvQBuie7z0=;
 b=iH4HTNp1PaueFryUqWNaGTvhEkX2ns30/jJb+DegAlameYopn2hE2Pc1I6PlUXOM5w
 PASVBVMZ8cgx6Y4aJ1m7viihRV1DtPhDdmjNLdiEY4df3irFvUvYYNa9MniCZvtCwEPw
 dmap/YJzdQVv5qu0XwLYBkHbI/uefTNorSr/SquhI/YTp/eUGxa+cb7IMwNqLa2ExvXT
 LbUZPHYsLpA/8DTERFhuMxf0ibKydcY4SMgfMke8oustsW96WKL/Wri4ukDQeLNIJZ3x
 Z8uMecARGr6GT18ZCBQ4MmnjfG7KpiwQProQeSSvDFBf4QIGN0fFa9V+sVG4G4T7OkAs
 oLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294100; x=1713898900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZbJOiBZgQ7IG/wDSz97Xp+97sroutu0BUvQBuie7z0=;
 b=kKsnreNQu7I1Psjv/SDefwMQCEFN4u/TeoqM/vSHzMuNs8nN5z6gf24xiakVUqhbyV
 2FW0FxVGNNxoOJMWDx/gyzbiKuKKb4H8a9laD3N4lHA8VcXvBZf6f/Ac5sc0UsrLHgw4
 PhSCdzHDfiZNMr9Z6DW95Tc/qnR8sugsFh+NvgsPs2194D4VunSV1WvyRFXbhJtwHQdp
 OBLxFeqMpMocG5sFTO2KcVBWV201B/fq4QcOgZdcGJlXbnCeT62v1TgVHBOp9C2UlRFE
 /wNjbSxvAEhWIjY9egizXvSrBKUoM9hs/uQEWBBiOBYTRKgvpVdM92JyB8dj/wfF8Kwd
 y4Qg==
X-Gm-Message-State: AOJu0Yx8wz1cNWC9vZVWMG+K69Ly3JGjPy5ylNd+rsWt82wm3raYFuBa
 OufJ8T6aB+Nq4c21PA4Qi3txFe68Hsf6lp+n6HH44SCsZbsn41mb55lfPn1MM8H5ac5yzRovZiY
 h
X-Google-Smtp-Source: AGHT+IHt5Vc1njNoN6vBugfYSvjeDCGkT/cz9mOGTfdbVRYE5LpX2R7CK4TBck5eD8PKdE7iBTFmYg==
X-Received: by 2002:a0c:efc6:0:b0:69e:b96d:26a0 with SMTP id
 a6-20020a0cefc6000000b0069eb96d26a0mr1915326qvt.27.1713294099830; 
 Tue, 16 Apr 2024 12:01:39 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:39 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 04/23] arm: EFI linker script text section alignment
Date: Tue, 16 Apr 2024 12:00:00 -0700
Message-Id: <20240416190019.81016-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

Add text section alignment to fix sbsign signing warning
'gaps in the section table may result in different checksums'
which causes a failure of efi_image_verify_diges()

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 arch/arm/lib/elf_aarch64_efi.lds | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index 5dd9809169..bffd9a0447 100644
--- a/arch/arm/lib/elf_aarch64_efi.lds
+++ b/arch/arm/lib/elf_aarch64_efi.lds
@@ -28,6 +28,7 @@ SECTIONS
 		*(.dynamic);
 		. = ALIGN(512);
 	}
+	. = ALIGN(4096);
 	.rela.dyn : { *(.rela.dyn) }
 	.rela.plt : { *(.rela.plt) }
 	.rela.got : { *(.rela.got) }
-- 
2.25.1

