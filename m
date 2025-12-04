Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986BCD1F9DD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14AC7840A2;
	Thu,  4 Dec 2025 13:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T78a2W6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051A283FE6; Thu,  4 Dec 2025 11:26:42 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C08A83FDC
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640aa1445c3so1059480a12.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764843994; x=1765448794;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ezBWhVyvZmKYOmciqa54jm6+3a0I0XPnDPsfj4xwrjQ=;
 b=T78a2W6q1yc2IB0uAMBc+SCtiQB4hqGU1xo5/Gk0dQ1/7Gh7YrmehKfW/S3xf3d5//
 TIe37ZMBwRQZpyp2pUgWOy5fiPwrOuqN5BgnRngo38CL4Gev37KEcLEyW4FvAlDBncD9
 wnyXEhbWYDllxa8ck65NDHIwOnU6zz0NQVv/4cXorYz2bC65lu4A7yslWPpV/6O4EvG9
 6dzhfE0jWw8Jc0818wuH7ZAoFUOOfh35OHwLy1pCFjch/qX+EffMi1zl3iaEUwBzW8+A
 75I8XdAROupywfdTi3edbAZWyhGBlm5Kmh5vxVG4Avj/AlIA8+yVTnyGMpkwcujipF6o
 xg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843994; x=1765448794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ezBWhVyvZmKYOmciqa54jm6+3a0I0XPnDPsfj4xwrjQ=;
 b=tmjgl3revE8zW4TrDCoHyJCWIVQ/Y1Cs4b3wgcjNQydB0mkGjSrdagYvpROn5bqzwx
 5oiWuEAHjiXkNMvKAmrG2/6Sg80RyBjXnD4RWL5in7PTPG3AL2IOlv4JtKfXt2a5yUUu
 W9y3Zjj+AAoqIn6+VtNMnBl5Pc9cZw/svgST90NvXTjEN0ixyuQFv1TzkSwf2Kxigvi1
 wwBZ+IeoHae0cp1nlPlGSGOqSbPEi8EbnB6s4jNGv7NjKjUKjrbNs7KhgnM1rcnEHfid
 GUdMVujtJT9OQkE/ISQcpqV/xItFyQRKwBfUWEZ+jk/ZA3LnvaEugxEHKnezYJlkO6If
 QSKg==
X-Gm-Message-State: AOJu0Yww3dzpsAfnWR+m2vaaQCkPLNhCAedECc9Wk14znFcmkzKLUNZh
 oFpxvV0wHtIGaBukMYERQfrrpnzv0/od3sqN3ySUb+Hb5bOuCIOgp38ej2TqKoickNE=
X-Gm-Gg: ASbGnct2TQItIeTnMIOX8S88PpKtqG6YOYh0YxZ+H/MUMN834wdPiAxUmF7UHAiR0L9
 vfoNu+pG5tEj2bRDnio6G6AXp6bGnjYqoFOuNovinluPCtV/PjYbzs3TcDILl7d7/1r+OPY57ga
 /W2yHbvn1IlkdE68oOtI2Yb2xohsokQGTo1I+jmWIEq0IF9qH/TjQNvFSqTMGlm77fTdk3d25qn
 ipEFWoRZKMMylIH5i4ipM17osBSg+f5p+9Jken2MMCd6Ui1ifXKvkxwN7h1ZIb5t88LZ1i+f0C6
 8u/IDkjSiEb2i1olf//GgFBeEmugYtobw1SLE6B2zqa3npKv55Ktn/xKo2CJwIAoWLAfPRb2NNo
 LdkaBZK3vHdeydLWAGCXXIM+GbgTGN8Mj3r2+cyPNEeGOhXU+b8WuAAAgtYh+8VHRPWv3zwCA3S
 TTDr+RMjo=
X-Google-Smtp-Source: AGHT+IFBnrFYB/C5i/GYzbEZXSzzzgvkkT9UUQ4ipVHe1qFCmUGxf98zdK0kvWTifmUHnz07UuMIzw==
X-Received: by 2002:a05:6402:1454:b0:647:57c5:549a with SMTP id
 4fb4d7f45d1cf-6479c47fb85mr5037599a12.20.1764843994009; 
 Thu, 04 Dec 2025 02:26:34 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b413b590sm873255a12.35.2025.12.04.02.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:33 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:37 +0100
Subject: [PATCH v3 1/9] arm: dts: am335x-evm: Add backlight to the panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-1-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MOaBRsJLiMn5KFLHX+aP+ShC5FNcUUiJ60lJ1DW+oYM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxNXz92jd1bySe+OUxYGdjS59R1sn7sv5qMXosnGqx
 8QvMe9vd5SyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBE3kQw/DM/63VnWtrvy9lO
 sq0f5gd5vTsbvfbPoo1R6vGvFO36Oj8yMhz6ezRAp26Gm5R92iUp/asOz+ufHyxuXDmzyTvCUXZ
 CGDMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

Add backlight phandle reference to panel node. Without this reference,
the display driver cannot control backlight, leaving the panel dark.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/dts/am335x-evm.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/am335x-evm.dts b/arch/arm/dts/am335x-evm.dts
index 1b5b627006822a9bb4df1c6433ce7eff114dc029..52ca4ff6809ad24fafbdd515fbcde840715cf20f 100644
--- a/arch/arm/dts/am335x-evm.dts
+++ b/arch/arm/dts/am335x-evm.dts
@@ -94,7 +94,7 @@
 		};
 	};
 
-	backlight {
+	pwm_backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 0>;
 		brightness-levels = <0 51 53 56 62 75 101 152 255>;
@@ -106,6 +106,7 @@
 		status = "okay";
 		pinctrl-names = "default";
 		pinctrl-0 = <&lcd_pins_s0>;
+		backlight = <&pwm_backlight>;
 		panel-info {
 			ac-bias           = <255>;
 			ac-bias-intrpt    = <0>;

-- 
2.51.0

