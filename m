Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FA4C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BAD080E72;
	Wed, 19 Aug 2026 03:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id myLOE6fOQOb5; Wed, 19 Aug 2026 03:57:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111824;
	bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AI5yKXXcorWsVw+IIk8AP+pXcuu32JIqw5Ys2kgekxqz6/auoTEmKdTmumNKAkrVH
	 9s7PsNfOxfeiVcJDH5NJJSwgZys+cWYgmNZmnIXz6D3wfk5ReX0zfwmo/mpMH9Z6ef
	 3V7kwZq6V6VBPIHi9Mt2H2yDeHijGVn++5AUnVW+RpalAIEjKEViOuj9QGJeeLMYTu
	 QeFH+8Q9q0+pNZmcjDdS2CzrYwTqtUAp48xoVwXYvIx09L5IwxybUEebW9BqCkbiMO
	 AeXUYxAmpxsjSRtrKPVIxe9osHJCbUG1YvGE/GyIV1URCU2w1yBJ7B6NL4cThBWRJE
	 mXY6PzuQMdgHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87F2580E56;
	Wed, 19 Aug 2026 03:57:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A349D39E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9509560656
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xJ-dgFHml0ak for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=fy6EEAaL
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 701956061F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:01 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso564574a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111820; x=1787716620;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
 b=fy6EEAaL/xnDGdCmYf3/y4MIwQgq0BR+NoAFUhOtPLfWPJexruys5jmBhkqw4IhQWs
 /N3sZoi9fVMudwsiPhpXUgHQPvxg3b9Z+6Sn5yf8+9oqj+v5Cnin8MjhrR6c1v1j8mfA
 8dQEK/vuRYBxZK5ZfQ0b7UKBUCp4RcBYXt4j/ywmWuqJF+fyh+3bWY/3Cvcr8pG6JLSK
 jVoU+vpzIcEJDkuP7Hl5eZcr8IGNKiG3eyg7ESt8w7GXhyw4CgdMzY7X96KtwLodf9/X
 iuO7VHRM5hyMtkNbracVGl8EhitHaDjOqNhuj9rdAOB6LuDKJQ6iY07VBgQ3C04zf/7q
 e1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111820; x=1787716620;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
 b=FcfDA63ZYv/KlWkNzJTy5h2Ky4t7rpBYmGZTK1Vnklw13ME/0oTg9xkukCYbp5rODG
 Zg0HZgrn3c3mVO1v309k+gB+bm5nIijQ9YNEmVEbUUhk0hC1LkxEQSHNwG36WRnmRTfw
 EzIb8iTLpZhlNCzvblbLzaGTTLr26ui1n5SPu851KK8hw9bfZhNPEGetkPZv9wDPcxPL
 5d0X1x/9YoTozawjlGXE8VUf/diseF1KDnNi30bhpHsvOIILOEwBToGfZ+HCOJOBKjwZ
 BLwZewPuSfd1M4whcifPNSc9fNOXkzgEu35FkHFEkT4QoKD8NEc5CpkY3dQzhfWNnkRO
 +22Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqC2MJByTRgP1GccrnxjOA5OJzp0fn5L3lqqjErt9r+VzfgJeaZRCvGEQROrfrjFSH4OhVGLTQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyesJaXafjvCvFhg+rzoZ7PkIW6QhoIgfEV29a+YrwFsblFC+5W
 eE0BaacuwSPWk5iehDXpN7MPfZi/AkE5vUn0w96GIetvljuCFZHJd0sPvahoPPn9wBo=
X-Gm-Gg: AR+sD13KPsDvLlSSla0skbwU1epCi1xfVBjcPIj2k9oKmIj3Dq/d5gPLcSsvAnkSA3i
 pqTUGQkf22/YSiHJAv3+zgnpNajkks3LXU4nYw+boYg3tpTdyDGVjhMPxzSPVxfno0QS4V/E3VR
 EHScjW2yoQk0ipE0AjnV+5FENZE0LT5fH8b9+SfDcY8x2NJQqbLB4Bdf2VJTEAXonGjsDqgPY6/
 UjUi7+YTMx1kMFZaEbY5vwRUGBfsjJXzkxsCBvCPujai+GROA0gxAQmAhwMvNJzyl3tpcQKUrrJ
 81sQDSR7gimteOO7/JDC6YtAW34TAMX779OFWQH7/yA1mKIjZ0AyzzWVRztFFI7X2SrqTio6rOr
 j+wHXBGZlS1LQ2AiCp3tDkdPm66qWDNVfyYJBe9PJNA/5QARdaYmjh0AQFrPcarRpvQuB22DQZY
 8WB0k0EddG0fVMxmF8azl0N+hjNgeHSQ8NheVV183Xs63/DgxNILkuMm7v1ATtOcADfNUbsO0EH
 5+0KFElRPRmj/YhJbnyxeNkjyFqBAV2Y0+dxcMfsAdtkhmj8kfa2N2Uq/SJhJYyR2y8QIRxB0G0
 M56cbnEQOOELI37higuCSV9sag==
X-Received: by 2002:a17:90b:2748:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-395810f2738mr3266623a91.15.1787111820288; 
 Tue, 18 Aug 2026 20:57:00 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:56:59 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:54 +0800
Subject: [PATCH v9 12/19] riscv: dts: spacemit: k1-musepi-pro: enable PCIe
 ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-12-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Andre Heider <a.heider@gmail.com>

Enable the two PCIe controllers along with their associated PHYs. They
are routed to the M.2 M-key connector and to the PCIe slot.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-6-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: d9ab0a855ba13f1db3ae16539348714c74010a22 ]

(cherry picked from commit b526ec8833b7e7a646cdb7ebc7b8f0af14dd154d)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index b284bf416880..898b537ba0bc 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -36,6 +36,14 @@
 		};
 	};
 
+	reg_pcie_vcc_3v3: regulator-pcie-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	reg_vcc_4v: regulator-vcc-4v {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC4V0";
@@ -272,6 +280,36 @@
 	};
 };
 
+&pcie1_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_3_cfg>;
+	status = "okay";
+};
+
+&pcie1_port {
+	phys = <&pcie1_phy>;
+	vpcie3v3-supply = <&reg_pcie_vcc_3v3>;
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+&pcie2_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_4_cfg>;
+	status = "okay";
+};
+
+&pcie2_port {
+	phys = <&pcie2_phy>;
+	vpcie3v3-supply = <&reg_pcie_vcc_3v3>;
+};
+
+&pcie2 {
+	status = "okay";
+};
+
 &qspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&qspi_cfg>;

-- 
2.51.0

