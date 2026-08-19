Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AA3C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 04:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2FF060681;
	Wed, 19 Aug 2026 04:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7eEeXjtOR3g3; Wed, 19 Aug 2026 04:52:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787115146;
	bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jDvqRkruYy9Btrr/Aqi29/FICzYrqtEOVQBfXztyKg34CTrYoZfiUzSPuE8RMTlXA
	 upod61XXE1VwlxdbAnb93gAcjJHTMhBf010WdqmEE4+FsjJIDkemo1MAngf2tJdfQY
	 d8upcKMa9GNs/pFdfB+hkfGgq+6uO7Fr3kCP5hZBxrCQKCHtX9WTgnexiYd6+U/d+u
	 w4LTS7B0RlcVbv8D9Yc57ONe02yAlcDMe4+X4Rlnakx17RZsw1ffVjmsljVeMku2+F
	 yU0BOT3UMy/OvHEL6IZEeWt0sK41qcjvvy/eg7iQLJouiA9Vv+23t0X3Hez3FNYNOU
	 CPu89oF0uV+6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1A1F6066D;
	Wed, 19 Aug 2026 04:52:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 178102FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F14CB80DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5kH1E-UcM9x for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=D1kekYB3
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31EFA80C31
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:15 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so536797a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111835; x=1787716635;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
 b=D1kekYB33yOezpp1WAONMEAqHJLRdtQSHosV1Co3dXK+8Fo5J2YUwgGsmHdkF3dNOp
 1rfqQUzO1dNK7Pb/YH7+uICVVBXNxqHU7Z5lBxPO6Bf+0xDexnFvO3tydsCUzHV+Ypu6
 tNR2o5MojniwAmU2Q0Yig/t3z55kxxIapBxaqKYoWsNEW5NP1MIuMovrPePsJcqBUVrp
 op3V7GrxLOpdT6TbAwcLom3jsXmmZTiSot77GSOr/7jAlsTvf6tXgKRaK3EFdMFeRnW2
 rmwnkUK3x++q88UeQzJz0MUi2A85tJbxz0Ne8fQbHxYq5kqu/bPqwlJdcQVX53lIppzY
 F/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111835; x=1787716635;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1pvBEDdciSg6TiqtaJq0E+tzPWj6bO+yEQ9qdahn0w8=;
 b=l+sEKhKVOHmTm+BdBV/ez06VfwjTPbxXade2VbnWU8a9BPG7r822yJzGFhbBfye5Jq
 yGIPsBYDv4TpBEyQoAZnnexoNr3lN5HREUzsTKFyd3mSkqK3xJhVBv0j/RiLeIBjtwJG
 1ugxGcpOYzi7SYcl02HFdrCMXD/G/5osh7tgzpXlwEEbNKv1T80cgAkS2anXneHT2JnS
 iiIyi/RRO0nkmjwCVfxfvI0K/xzW3Wb0VH2MkscVsVBsCAu733KQCgV+Gagtef05BkIY
 0cdasXEKwRupLpj5akU6zAvG5jDxY7nBQC27jCE5zrC9QDewCwJ7XOxDp5vUcLIXFnqg
 D4IA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpzb+R+NEkdGCWRklsd5ltUh2wKp1XSL7Ey4Ee/lDzdpDj3wy95DpRrf+AnbFB4n8usx/9m5/4=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwLd1afDIRisaVlNudQio2cYQpGWdkmgQTJTy/jbmlm+bDcAdtO
 b+Jul+7EkvEE57rKffn3EwtPnulcxaikAB0hMYLasvSt2spr8IjKAGPxZ1yFHeIp6OM=
X-Gm-Gg: AR+sD10MjvTVwg+jUQ878K3TVYhu7whA6iwOd+2m54fYS0A5DcJhlHkh84lL4yaw2aC
 e/MOQuVHUSgpVUI37rV374Nkwwu66qRmRLwQUZbPR/0Hm0Azb4lXJIGsBNIK9+Aq/odYMu440nI
 et9qTryuY+6jDnQM0+4sMmp8uL/IO0jwk/Ab/wdN2PXtZ70yJQt0ienuqXXwe3BpnmCzUihgIC0
 UGg+G0Bx+w/vI2aUjyYqkqMhC8qOwU+vmYhI3rwvXdS6uAWpxdWesaqO7U5ph3OTJgQOB6MexhX
 DS2yWKMjogS8MYDdQdiALJmspaXbXTSiJS2nSa+83SHu4XIJFh2mV47G+upeeDMwRLywpnB6vBy
 i56ULQIRTZXpUC+tObiyrGYEJJ+xEb/f8cNdTTi/SQCFCH/vAQ+7YFs8Kq1F4Aw7E6IMPOTeWif
 xm7efzDm/Px0ZRVPT+CuZlaQ9RT53F470WcJuV+SdQvgDDo8z5cyZbC1XBeKC1IVN1/eiIu2jhz
 mNXTNyM2rrmVB83usqKkpmcCJhSvBkoD81OJyutc1wYhstHW9S5zvVTVihZKj25ebhDNTIwInWr
 IwT9SEU5MnsozqgOFcc//4WGFg==
X-Received: by 2002:a17:90b:268b:b0:395:5f66:15f1 with SMTP id
 98e67ed59e1d1-395812349ffmr3240121a91.17.1787111835235; 
 Tue, 18 Aug 2026 20:57:15 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:57:14 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:56 +0800
Subject: [PATCH v9 14/19] riscv: dts: spacemit: k1-musepi-pro: add SD card
 support with UHS modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-14-6e66016392b9@riscstar.com>
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
 Eric Chung <eric.chung@riscstar.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Andre Heider <a.heider@gmail.com>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 04:52:19 +0000
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

From: Trevor Gamblin <tgamblin@baylibre.com>

Update the Muse Pi Pro devicetree with SD card support to match what
was done for the OrangePi RV2 in [1]. More precisely:

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with internal pull-up support
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes
- Add stable MMC device aliases (mmc0 = eMMC, mmc1 = SD card)

[1] https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#

Tested-by: Andre Heider <a.heider@gmail.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://lore.kernel.org/linux-riscv/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com/T/#
Link: https://patch.msgid.link/20260520130624.1763487-1-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 85e4c5733cd7efa39f10d7200095c016ce4a2815 ]

(cherry picked from commit 9f9e7116bf6057433905f05a6ea06dd17a4b41c4)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 4aef287353ca..0d809e4ad3b1 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -19,6 +19,8 @@
 		serial0 = &uart0;
 		i2c2 = &i2c2;
 		i2c8 = &i2c8;
+		mmc0 = &emmc;
+		mmc1 = &sdhci0;
 	};
 
 	chosen {
@@ -218,7 +220,7 @@
 				regulator-always-on;
 			};
 
-			aldo1 {
+			aldo1: aldo1 {
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -384,3 +386,21 @@
 		reset-gpios = <&gpio K1_GPIO(123) GPIO_ACTIVE_LOW>; /* HUB_RST */
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4_3v3>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.51.0

