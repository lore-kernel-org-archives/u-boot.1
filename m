Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF3BC54791
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 12:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE6A87E64;
	Sun, 10 Mar 2024 13:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="no0qTCAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0901587E0A; Sun, 10 Mar 2024 06:58:49 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED9087BF4
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 06:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3663be565d5so2780155ab.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 21:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710050325; x=1710655125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=603qhtnK/kOF8p/1jgDsQCp6QyJ/n1dEAi1ARhs0dak=;
 b=no0qTCAHj2IhNLwpD57muCPO02Ctg+iJOmU6O77DprL1GcMR8LTJm7+738bgU5Uc7C
 UNpXVWh+yX5osBhRNcNAJU3Lup4hbi+eJurIUgr167UwnWf9vDrmKJpnLYbpdmOjC2W6
 RTOPNj7+2jymFqkLRuYOWHBj6MbnElcePL0NKgROgHHcgazVINUR9dC5jVENoroMzD6w
 G9dISzprBPbPZBZ2TLzIiQJ+A9C8TMM4dmyg61sVZSdCepP/YyGMhh4rNTLAAWb0cIwQ
 N+UiBwik7/S93cIeNh3arjp9V5aE7UoL7LDBo9is9jRwKHMj/PkHfzTN8Ucut/XhPgvo
 qWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710050325; x=1710655125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=603qhtnK/kOF8p/1jgDsQCp6QyJ/n1dEAi1ARhs0dak=;
 b=SbMeTbchgaf0OAVdAJPrvQ0xhDaCgVSLqgQXKQV8DWQiNjFoQrxPiEWyViDGmZJK1/
 dmS58VgWMl+HHmmuusKWPPy62vydDnJJs1AffMSogpuj/8yzi8J7Cgk19axEGF0MFS7R
 uRJy7qZotR1I9osNBO1gU94rac24Tdx8fSubtVXEBlbYEyLeSbRjQ/HEZPdbv7sd7Pjj
 3vOdvtF9Lr7S7fw9GynB7jBD1T56S2srk7DNZY2ohAPN8UkoKsrjMDTKY+OwJxcALqON
 5YqlmzyaEK2uKdElNgcp2/ufKNPZ8Z3iFzeROyo+4kbEkHu1d39gZcN4CVqGHUDO5YS4
 FEFg==
X-Gm-Message-State: AOJu0YyoexcuZl3tqfbOEjg8gCQL31x6R0s6HwNX3pEE2cgqvNObhgDp
 rsL+0zj5/QnKJgpqJssVVC3yvurAhzAt5LJOHdOZNM4rQ2qcz3gGCuAocbO/j5kPWA==
X-Google-Smtp-Source: AGHT+IH9hFECbLAC/tXhRoHJMEJwDlvXv8tWLAzpyCcuvM1hJYTikfyLs4lgyIrNvpyuRTi4t16WQw==
X-Received: by 2002:a05:6e02:1a23:b0:365:224b:e601 with SMTP id
 g3-20020a056e021a2300b00365224be601mr3955922ile.2.1710050324743; 
 Sat, 09 Mar 2024 21:58:44 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 i15-20020aa787cf000000b006e508b6a13dsm2037522pfo.58.2024.03.09.21.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 21:58:44 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] riscv: dts: sophgo: Add ethernet node
Date: Sun, 10 Mar 2024 13:56:45 +0800
Message-ID: <20240310055816.11575-3-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240310055816.11575-1-seashell11234455@gmail.com>
References: <20240310055816.11575-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 Mar 2024 13:10:19 +0100
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

Add ethernet node for cv1800b SoC

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 arch/riscv/dts/cv18xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/dts/cv18xx.dtsi b/arch/riscv/dts/cv18xx.dtsi
index ec99c4deeb..013372a40c 100644
--- a/arch/riscv/dts/cv18xx.dtsi
+++ b/arch/riscv/dts/cv18xx.dtsi
@@ -197,6 +197,12 @@
 			status = "disabled";
 		};
 
+		ethernet0: ethernet@4070000 {
+			compatible = "sophgo,cv1800b-ethernet";
+			reg = <0x04070000 0x10000>;
+			phy-mode = "rmii";
+		};
+
 		plic: interrupt-controller@70000000 {
 			reg = <0x70000000 0x4000000>;
 			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
-- 
2.41.0

