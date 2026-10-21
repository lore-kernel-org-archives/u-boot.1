Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79937606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XBua2egp;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=PDpGUpjm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 514DA60AFD;
	Wed, 21 Oct 2026 12:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5qboxWVvwi4a; Wed, 21 Oct 2026 12:55:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E385608EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587336;
	b=I4rBJeL/W1tAU1ocppwkgrUsmhELGny44JcWQJ81T1ezeshe/Sb2/hBvaYEK2rJAsmBZ
	 xaNtvt0OJsFfT4O6oWbPhiCtcESqqH90sTNxdWgaWRvyzBA9kpFt/Nzz5cnUk5hPI92Gq
	 /I8NnPH/TgF76VrfeHE9iT23esZ7E3nZviwl+CwDvPS6R6yDGz69SXGpWhuKU702BzCwz
	 HCitj75pLY1njzYkAz1OMJd+6Tn/zGsXmt7ma/50mnM+PYfis56MkQb1m0PObWnGvS3Vg
	 NQo1m0dEWmbWvB2XZbU2D09hJCP3S/zatBjpGKyHYHynsamBrlCV4Ero63aKLVHoxJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587336;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lBsWZEywnK1dQWbrnWBGPhggIWJGqZBgzIYeGjxxziw=;
	b=KKsULk6p2qU1a+CJ06RI1VYrMvkjqNb94vb95M8dQeve6YCz7l6ytneehDUf6iUzhzJr
	 cNFxk8X3K6VkDnKo8mUcS0L3Ff4F9GLrV7y7v4/bd29WEK//0tz5lY/kyH2k43KrOdDs6
	 kQ1S50u+rcpoleY6+lw6+IIebZPC6s1GaLa2XUzFsv2DT5jwkJB2vfot/r3mi5ih/xFlX
	 Z/wN8Fb2HlHgXOcODjn08Pn2V+bvHSq4r64KXGtIq8yEhqKeiwkRLsyrbe8Ow41AHaw4G
	 cr7F1PkjPuP4Hhwox/tKA42voVedFvkH0cFWvNZdK31pjScnov4XHjbimukMWEdQcFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587336;
	bh=lBsWZEywnK1dQWbrnWBGPhggIWJGqZBgzIYeGjxxziw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XBua2egp0Gfh/HkObjmrHP3Z778J3qsruq1fx+xj/oc40kvlXDNFuHl3q5BMabIXJ
	 lsT2GeL4zkvV9mmUTb1tVPbsm3eBiyg+AN8WV9hl5WETEnwcmls15dxWifhj9l4l8A
	 2OtEELvgUWGGOoEDQqlR2qM1KnT7OsRb+WYRPlDGIWxGOWGwe1yXj9FGHr2LMABT3T
	 EqgZotWPGhVDNwbQsyxdbbxZSKZ1Cz4J4kpxcZmz3inCTJ9tVFTLGJzh7QFrwmlcD0
	 af9aJO61fKuLwpvg/2nss7sc/t2EUKa3atNOTM6Lh00dpk8fNb4eAg4ZYAfyQtis/G
	 okUPvqlAOEYVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E385608EA;
	Wed, 21 Oct 2026 12:55:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F1FC4765
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3E61810C5
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tqH02B_LMMdf for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF64E810A2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587334;
 b=iu/qngX8jr9ilRDK0gEb5OwDvz7OyqpObi1j4uhiwlqdyH9ExIxLhupt1My+jrIP40Bf
 UGqFpWasipOq3/GX1zOUDtzU8RiXe0uZIpLfFdSWCDE/ujJLbMfpDpKrEr6EBdX/wCm0k
 9RKEt6LOdxSx2BA70XFrT524+ceoKfMDIE30/IbQBICEHA1JsAHT27uamilEcg2EG2FZK
 crdI3yQXclejf8ahplZ00pGdx/VvV3IdsLtndXgjloEGaiFu+3vH2ID4W5kTc6vFdHvQ4
 K5sfP3BieHguxtHIHzDW+mvCluNkGj5bD/3pOzs9NOtc3VZSK4q/kpwgk+BV31D8inA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587334;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=lBsWZEywnK1dQWbrnWBGPhggIWJGqZBgzIYeGjxxziw=;
 b=ottwDw9H3DPJM7CgRXb7sO2F2M0eUQP6tCAPJ3LOcGCyQ/erl5xV2m79WGboKe3uxblG
 hNgx1yU9SGSfp+koUcWGYVL42Wes1/JA/WOwpIbIOQYCCBOk/1uu8bGseC2E5EX0rEZd0
 qgq4E+SYRG606WJKRM0zYn/h9JLBcpgX7lG58nWCS69Mi2xTbjKEG7iXpCIpQNRz/49ed
 z4pqU2ZzRiJ+IkW+dX+qeWwgwL9vu5v8ih6p7kCkLsMWRX3wJoeV+agqq92s12Efs26IS
 ZFFBBtH5ejQHxl0P3PVdw7nuvc3NCb7CJvFkAU656P53axRb9aebcI1ZmSA9Lw+7YFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PDpGUpjm; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a34; helo=mail-vk1-xa34.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PDpGUpjm
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF64E810A2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:32 +0000 (UTC)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5eab93a9862so182701e0c.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587332; x=1793192132;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lBsWZEywnK1dQWbrnWBGPhggIWJGqZBgzIYeGjxxziw=;
 b=PDpGUpjmNA/mLZpVUfDQE3FaQ4e0j6Lk74Lr6htO8vQrV269YnFrkudYJ1hO5Tjx/W
 +ZWfgAjF3iwQgnV+X7TJLvP5T53ijTbAepN+ulGyKDyWBv7jW3O0P+RmaYJvNTHOQUpu
 rG/njKS0QmJCPb+4yN0da8AKeDN+eMWC5kZHhgQ0gkd76w7g1FKSrtaaOHNuLIh08GDi
 rBikDiI78QqMyYvxmKIgHb9FYk0FB9W4J5TI+//SIislD9L4uripBkdS+GyTL0vAvoHN
 trWRSz1aWLhN/J8DX3pfLc6ByErGQ8n/yhjmUIZU7JxAnLURclSS3tAWx2GYPAjwcfYg
 VX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587332; x=1793192132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lBsWZEywnK1dQWbrnWBGPhggIWJGqZBgzIYeGjxxziw=;
 b=oxEAF//Pt5zpi5UUta8Xw/eJ6CjOTphENYkbg/TshxSKT+P2OLhI24YGEeRz8K+I4d
 LPTOxyvefkyiMvpXh0JpUQDwhJNOb6q1Urr/3QiHY1328e8z/b3ITsKz7QHvrJTHtW3S
 F7WGcZ1U6plqfOzpsiv3DR6Z9PWHNaXoCQcX7uTX4r4s2jfcXse+nyxAvf0MWoWlf0+h
 XC1O1s+i2YqdMgwYOD5bLz3TynihfDy59ykARe+6W8dTu5E1meLA4XBxEzqwdxjMsDTw
 8lS9CLFbRHwF3pkvQBL08HpyM0Q4qNzCjva+7JHArJAM/97OOeLXXXH6V7TEDd2VosPw
 duEA==
X-Gm-Message-State: AFq9FYJmr9lF/cL1Vt9OrMktbURGi04AF8Zo72vBeiLiZ5TE6aCMWlNV
 qbSKVqjq5wH5E/dKmnaOTkxYEfI6cNZwNu7LRnrry/e4BAjajCBDXbpR30HRa93wXi0=
X-Gm-Gg: AYBFou25bIe3XJdJwFrbjGxASxwWC8CXuu5pacGVhpR1DuaXS3nMDuEPlwTkFdT9H9x
 d0IIIhAvNsraYeobVGZyPN4z4OmRCRCLSO9W4IGP1AmkCOv71kdct3rJ5A5n8PCcq7PoUE+OnKG
 0QM8PRO8mFbb3tBKWP7guwg0gsXbzTSSh71AsciESWZ1a3rFDKmPGd2MhOn2L0t441CK0Ql0WhD
 gHt6GLTjkNF6zE3fxFLzmuBGYf0lSmEoBaSZIaYMh2iwQ6epsLusGiPV+3VsqNE/K3s0otY6RJ1
 UIIhia3OZ+rLHzvAcJSyaL+xFaVoRzUU+D9YZRFlwpNY4Yzt3M0h8w1Lo3bs7m8B7ZPIXpP1u2v
 zoUJ+/GD7foFb4MlS5MjagdnAiaCuwaQH3dOGckm0lFy7HMJ4fmoGdCyMYBYISGsPsdERLi6XKd
 H27StRk8riNdrLH1RWWCGfd9ehL/0HtJqTGlfOkwXKR+6gtcu988e1rUbM1qTfzU1kYZccGK5+N
 brqFhlXhnqQXYDZV7Lb1dyiHvOdXMOGmyOW7R0RFAqfPxOeBA+7ujX7tU8rgpIwd+AMS+iazQO6
 q2foA6LPN9ph0cdAOUM=
X-Received: by 2002:a05:6102:524a:b0:7cc:232b:f5a9 with SMTP id
 ada2fe7eead31-7cc92740daamr585573137.24.1792587331403; 
 Wed, 21 Oct 2026 05:55:31 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:55:30 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 21 Oct 2026 09:54:24 -0300
Subject: [PATCH 8/8] doc: board: sophgo: milkv_duo: document the SPL boot flow
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-milkv-duo-spl-v1-8-ee7618860237@baylibre.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
In-Reply-To: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the board documentation now that SPL replaces the vendor
FSBL: OpenSBI is built standalone and passed to the U-Boot build via
OPENSBI=, which produces fip.bin directly instead of u-boot-dtb.bin.

Replace the FSBL + vendor fiptool boot instructions with copying
fip.bin to the SD card, and refresh the sample boot log to include
the SPL banner.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 doc/board/sophgo/milkv_duo.rst | 71 ++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
index d99a945a61f..39d54d70cf3 100644
--- a/doc/board/sophgo/milkv_duo.rst
+++ b/doc/board/sophgo/milkv_duo.rst
@@ -14,54 +14,65 @@ Support for the following drivers is already enabled:
 1. ns16550 UART Driver.
 2. Synopsys DesignWare MSHC Driver.
 3. Synopsys DesignWare Ethernet Controller.
+4. SPL with DDR2 initialization.
 
 Building
 ~~~~~~~~
 1. Add the RISC-V toolchain to your PATH.
-2. Setup ARCH & cross compilation environment variable:
+2. Build mainline OpenSBI for the generic platform:
+
+.. code-block:: console
+
+   cd <OpenSBI-dir>
+   PLATFORM=generic CROSS_COMPILE=<riscv64 toolchain prefix> make
+
+This will generate build/platform/generic/firmware/fw_dynamic.bin.
+
+3. Build U-Boot, pointing OPENSBI to the fw_dynamic.bin file:
 
 .. code-block:: console
 
    export CROSS_COMPILE=<riscv64 toolchain prefix>
    cd <U-Boot-dir>
    make milkv_duo_defconfig
-   make
+   OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin make
 
-This will generate u-boot-dtb.bin
+This will generate fip.bin, the image the BootROM loads. Binman builds it from
+the SPL, with the 32-byte BL2 header the BootROM expects, followed at offset
+0x40000 by a FIT image containing OpenSBI, U-Boot and the device tree. The
+vendor fiptool is not needed.
 
 Booting
 ~~~~~~~
-Currently, we rely on vendor FSBL(First Stage Boot Loader) to initialize the
-clock and load the u-boot image, then bootup from it.
-
-Alternatively, to run u-boot-dtb.bin on top of FSBL, follow these steps:
-
-1. Use the vendor-provided tool to create a unified fip.bin file containing
-   FSBL, OpenSBI, and U-Boot.
-
-2. Place the generated fip.bin file into the FAT partition of the SD card.
-
-3. Insert the SD card into the board and power it on.
-
-The board will automatically execute the FSBL from the fip.bin file.
-Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
-U-Boot.
+The BootROM loads the SPL from the fip.bin file in the FAT partition of the SD
+card. The SPL initializes the DDR and the PLLs, then loads the FIT image from
+offset 0x40000 of fip.bin through the BootROM API and jumps to OpenSBI, which
+starts U-Boot in S-mode.
 
+Copy fip.bin to the FAT partition of the SD card, insert the card into the
+board and power it on.
 
 Sample boot log from Milk-V Duo board
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 .. code-block:: none
 
-   U-Boot 2024.01-rc5-00010-g51965baa36 (Dec 28 2023 - 13:15:53 +0800)milkv_duo
+  U-Boot SPL 2026.10-00011-gf0ec1f67053d (Oct 20 2026 - 15:08:30 -0300)
+  Trying to boot from ROMAPI
+  SD/0x40000/0x200/0x200/0.SD/0x40000/0xca000/0xc9ee9/0.
+  OpenSBI v1.9
+  ...
 
-   DRAM:  63.3 MiB
-   Core:  10 devices, 8 uclasses, devicetree: separate
-   Loading Environment from nowhere... OK
-   In:    serial@4140000
-   Out:   serial@4140000
-   Err:   serial@4140000
-   Net:   No ethernet found.
-   milkv_duo# cpu detail
-     0: cpu@0      rv64imafdc
-      ID = 0, freq = 0 Hz: L1 cache, MMU
-   milkv_duo#
+  U-Boot 2026.10-00011-gf0ec1f67053d (Oct 20 2026 - 15:08:30 -0300)milkv_duo
+
+  DRAM:  63.3 MiB
+  Core:  23 devices, 15 uclasses, devicetree: separate
+  MMC:   mmc@4310000: 0
+  Loading Environment from nowhere... OK
+  In:    serial@4140000
+  Out:   serial@4140000
+  Err:   serial@4140000
+  Net:
+  Warning: ethernet@4070000 (eth0) using random MAC address - be:2a:c8:b9:53:10
+  eth0: ethernet@4070000
+  Hit any key to stop autoboot: 0
+  milkv_duo#

-- 
2.53.0

