Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50DBF9EDDB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 14:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A093839D5;
	Wed, 22 Apr 2026 16:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LJiQ9FZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C479884312; Wed, 22 Apr 2026 16:32:03 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3F8842EF
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 16:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-694891f8f75so1813700eaf.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776868317; x=1777473117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hz9g0CB4rbgBqrP7jXG4TBlTFFMgP0uYRbCrnzqOw/E=;
 b=LJiQ9FZAhzhU/Zej8V3lEmTMn8B/s3bX2aKm60bmkNX2X3lfzMEY9z8ykYcFdE4tcw
 ylgc1veXtASxstLFrBKF1b/yHRJ36RPu9PIB0KJRhTj26ad6jZTGn5sCbobW+3WeNznl
 w7iBcxnKJMKTTG4vfzw4a9E7FaAahL8327nbpceCIZhyzQj1vdL3nBZyvPUvsUH8xfNH
 Khv+Y90TQBF9sOMlTFa8ayU7MUsCbRkrWgyp2FDktb65d241MjwR6Vzr7KNkpuU8Xwch
 9Sk8JnW59qNy2guUQ+DZLkB+cwfjqKRIGw/jBxa8fttTRaFKHzkH+zcbee3F8x6e8gR6
 8lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776868317; x=1777473117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hz9g0CB4rbgBqrP7jXG4TBlTFFMgP0uYRbCrnzqOw/E=;
 b=iqKMakkm46Z+quavzTQpEJRc7pDS0mcuv/etL/+oKIY7A6J9LGWzXZaFlr9EOMbVpb
 2nNHxw0b6GAkE+BNof94QyDNsmchoIbLEuon/m8t3I3Nn70KXCuKokBP/x3BpT+px2qH
 H8VbLOD0y+4l/FmxBldh3hdKroHfT60wiKyWrPmm4eYSuVwmji6z9pJjHvalGkcHry4q
 JzjyoWyYPVRn+1zfxu6DmhPdeeaXgIyNROIrIndvpdPB/kB4HCl6gmC2QOppmhafiLJb
 swnSCUbPP9rvqXGT/p7Bhg2fOCk48E8C7wx5SrLJtqEcaZHxy7Pz7bXh5+LvAoopCmBy
 TWxA==
X-Gm-Message-State: AOJu0Yz2cnHSQ7BsZubu+vRUqsee77euzg/LmS1hR66L+cWGoyW/erFm
 PT6fMkOtLuzN6M7VyQeJGIDQnmrtAy9QRJQoDCSa8OpshoYQn3A/lfXN/5uxKBX4NkE=
X-Gm-Gg: AeBDievEVPCUgKz8rRioPYruOyE1yZpvEGqhVk4TxZpRKB69SG67SaEa6C6CSYX9QUV
 +qY7BIg0wY+bkHR/zzPea+g55jTNWI4/SYzOuiUDpAu4qFGIbLc5hnVzPtnJ9K6uiJdU23f02mC
 tmfBuwwP1+Lg6JgymvhcFWql4tXlT33rrVSf32QNtUysZUqM1kM3MnR6ECjje6C/u0KjbQH/2YZ
 7m3z5GTuItWGtXmjcuHp8CDmIxstzBGwy25eXzBPqHKzqOyHcrxo4uygcAEY9FlxVXX1eYnyBGy
 dMEXheFsJUDWbYpO6Wo1uBXfNb2zSgcOzIZ8ChhVCSjjlYZ9p1Qy9tPcmhPVT+exjHH3c0wfznC
 A8AnooHcjtz3BlHd9KQ3HrfvqPBiKmTas5bJvMBTBiO6U+kc9EWmA9S6aVvwAjR9LeSc+JdvFHw
 eM/ljmvj8w43RDogfZ5xAa9tK6Hu3nFt3V7fkM6lgH+WxTJY3jQ3g+sTu1LrIw+cAs5gfl/woK9
 KPItXv8l2jA76rXg9+BBg==
X-Received: by 2002:a05:6820:1391:b0:688:6d55:17b with SMTP id
 006d021491bc7-69462f09dc9mr12038597eaf.51.1776868316876; 
 Wed, 22 Apr 2026 07:31:56 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394903dfsm138772501cf.26.2026.04.22.07.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 07:31:56 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH 10/16] dts: k1: add QSPI controller support
Date: Wed, 22 Apr 2026 10:31:06 -0400
Message-Id: <20260422143112.1329478-11-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260422143112.1329478-1-raymondmaoca@gmail.com>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add QSPI controller support in DTS for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/dts/k1-spl.dts | 15 +++++++++++++++
 arch/riscv/dts/k1.dtsi    | 16 ++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index 6f9407aada6..e3311af76e6 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -226,3 +226,18 @@
 		};
 	};
 };
+
+&qspi {
+	status = "okay";
+	bootph-pre-ram;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <26500000>;
+		m25p,fast-read;
+		broken-flash-reset;
+		status = "okay";
+		bootph-pre-ram;
+	};
+};
diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index fc3a693a10e..96f604b0561 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -879,6 +879,22 @@
 				status = "disabled";
 			};
 
+			qspi: spi@d420c000 {
+				compatible = "spacemit,k1-qspi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x0 0xd420c000 0x0 0x1000>,
+				      <0x0 0xb8000000 0x0 0xc00000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				clocks = <&syscon_apmu CLK_QSPI_BUS>,
+					 <&syscon_apmu CLK_QSPI>;
+				clock-names = "qspi_en", "qspi";
+				resets = <&syscon_apmu RESET_QSPI>,
+					 <&syscon_apmu RESET_QSPI_BUS>;
+				interrupts = <117>;
+				status = "disabled";
+			};
+
 			sec_uart1: serial@f0612000 {
 				compatible = "spacemit,k1-uart",
 					     "intel,xscale-uart";
-- 
2.25.1

