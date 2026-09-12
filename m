Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B670C88E59
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 12:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D30FA40755;
	Sat, 12 Sep 2026 12:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xuxKAyXwKbVk; Sat, 12 Sep 2026 12:37:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E857640726
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789216645;
	b=psnTvs3otuzIcVSZgC1EVHhzjjt9/qCocP8StIP4Vhv2OCLVvM7Iqi2L728IB+JoUKYs
	 nPvYq0/KZvWXhow80Zbl6TLHQTYnRZ3wDTTdW6ROlP2z4KFXwQZmg7fzJ5GRYwDSGR8CF
	 jiDbQt2tuSnGvBPJ7z5Kby81fu3A/GJPjc4QTaFtYIfsiau6nMOSTo1MIZUpstMztHZQe
	 LUh4XwazYKDEpKE3daTGT3n40608oasxdXSJT23OJ756zhObMJ1Ln17q9LiObyYDymT2J
	 V+G1YCwCDgn02/0cs1hzFlXYBMIdTcrZGDvbAQvIYUMTcu6Sj+ZZhIfuGmkNXZLwb4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789216645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
	b=aVug9j0qLKb968bFc86epNFletaypDqh6VOdUCwKjyHVGjYougIvUtrCVsbcZ0USmXzY
	 ziYWneYMM3QnqoC2yH5mIenzzWMLlb7QTqV0fxdev5cdui2ci5cnO6HgNqv6kGL+MeajV
	 TnE7Gw2rf70/5yUC+tnoM1tiCH63oC8A4Iy8/Nwnd1KLPhKjJP+BBLpgkv3Bx1R9Fv177
	 HZ5fz05KnPR1SI4+uSAWQnPu+qFPoYqt05pzhsiEt+byabvypbDrB2Ezy3fDdiOjJFrn+
	 k+/FoF7k1m6A18p4UDadV/WLs3eC/Z7Mg2RJyox9QRbkHIHaZ4U+teCQfVgtb+tZUeA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789216645;
	bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c87IaBl9kb/d7kh9PN8mx1uAEfq0jqU7vYsMNNcN1mFMXxLYJo52h3IA9wKxXeNuJ
	 EF0X8+1eVdR9X3v19Tj+nZV/vOs7bRRqiyKJhQ1XuuM0KZbAmf+yscDIl4F8sofSPO
	 N5N6cS0d/Ep0nG9kKHu2sb8nN+vpra47P5BkAcz0+VuPLUe1HBE2Ys0b6YyIsZTZvx
	 wVAin1Z9r2b07fJ0FsfUBTUD6gkQ9kEEkRyf0+3WGOW6KNBO3QvVSvUFB3X1Mz1BpZ
	 zwX6bWsaJpqzclyDzW7ZQin06cYI4e3p0QTH5pCmUuytf8x8YWAUfOXHeUUxVw5iKf
	 5jvHchNd/w6fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E857640726;
	Sat, 12 Sep 2026 12:37:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10E552D0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB32C60669
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIZWphzNG1G2 for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:37:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0797760658
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789216643;
 b=ekgwXpzZUw0mcpR6L7MBmo/t2R+ZQTVeAD+PqBjqXDbQJ1VhvHcZpFORFca4hA40e4u0
 sfRBpJKKrNUh4DE0oRzpmbOiz7Kv6iTfntQb2Gtm19NvMu3dKR+FJv4BLBQ/TwDyB6ZIE
 bWbbxj7Wwz+Qs+pMvvRWXNyxpNXGav4LAgw1CdP/brStNK3ZCEwtj3rZtb6MHjknhMzFL
 p93qfOXi/I8No2IpnRm8ofuavHSxZiScT+0GzODIAotU6mrGy6gD9N5cxNQbutU146/4Y
 +txZl02YU3pjHxU3fQYw3ok8R9VEzAqV8LbSaHB1zTct9bfP5SnkMOUzEhi0UMxOyVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789216643;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=bqm97NMVMO0UaVo40Flz9eFXCE6ZUhvy5XHKKHTQIsCKsNysrIeywa/0Q1DIulCpVw34
 hQ1rMEuGw980nj7X16MIGOmvkCTC/YpxFCPNI2AGYm8MW6Z9LHQp5K1Jn6YtWcFx3S+d1
 fpwBaIVWiidtqzwJpepnpJGeP3zw9O6BewbKKFR2+TbIja8g5ur37RLnph3S2GPa8HWnp
 sWENiMNCzFvSpBV9Zdy0AoTI6gUztOgOn4Y31Zw9Hr0fTaUe2NPwDenS1qvPk4o2j1ivP
 KAq6IU6Na8i6lNmMwuYAH/eZyMbk/8cNO1lKI8/fRD6iQp5S4yDs4HBXB8MQOnep+Jw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LgpEj7e3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=LgpEj7e3
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0797760658
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:37:22 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8692a856865so934449b3a.2
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789216642; x=1789821442;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=LgpEj7e3jj+/QfXtgdojOB1ICS3XA0eXy3TFVXfpm7CFxc/qzhiFsy0oM1jzmjqBQd
 0l5j9fXnUdAHtqxM+S3Ts1M3gSo0JYwulGJHKBj3TanPlhBodLgnBp9V8yuPsA0hUxjg
 B9CBrgVbkj/DDN3MiFeg9qnyZvAG0sKbngA5CPJLfRSt8ZGvjNAFb/sYoCpmi2v0AYr5
 mN4jbpxdg6HmQeSCmsUpqVwU8dUTBomqeZ6Z3clyzQRhxhwsOx0R9eqDGy59bpa3Aw9s
 a1WR5SUvBrt83USDtnzlYBUn71JcbMcZv+DYWqGuY8/86B1j/XwRPzrvFHmGn7eA9vFm
 NyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789216642; x=1789821442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=bCI/Ph9RoAKK+DICHxGrf31pC0Yo0JAkPZ8zprOkud5UJdywznZTfCJCWV1mSE1dFr
 O85bARdvKtdjuTpXYc5DyBeKi1JaYxLsHV3fRBTcdWTh6xdax71fX6yg7iJXACKNk2Kn
 N/Wk9BFmf7/c0LCx16myatepZg33rJmo33mOS+oyO7rcNJMSSTs2yLtuijx/oyop+no3
 yJHH0JuR3l67jw0CfMgrl25X7Mn8G1Lw6j2TA7YzRArcAu6w13nyAHoHUcYdeaQ8+O53
 xYJmkMB8km+Ku85u5s7GpwIY+Dp0wzI6U98mM9LYC43+FK/sP4p3BXGQ1TpYxW2bzfN2
 FWrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZwtlhtq+rRZ8Xuz65ZZkN3LnkXe8yM8Yszx0Fwe1pi3RibBVgap/2xMUE83i2btPUmjd6zQ8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nxclSgiPIFwWSq2+anrnQyx+IEbpd6TIc0oJopkhb7XO3TAbus
 gz8rj9i3nZzc12K/LpPk4tFQ7k20ez95RUhHtq4s6l6tsJreBdXpLZw7oVZJc0G1V/o=
X-Gm-Gg: AYBFou2ZyWv+vVetUcqPbVmaClFqqwyZO/RtnMhKrubBYjht8fg+ftHWqJfjAujijGj
 5NtD4lGcQY5SOZJOy/749Y4BfJQqTZQvP5lDbq50a3+eP5sufwmVHFSc+hBu8engYXNipUHurRK
 w0ee7QlJLv9gFS6PuBb5YT0ze2qev4F+1aeBGbOi3naVTsnfKfEIyGc8Ol8W6aB4jB6SNdOkNFW
 xhDHXBqMUrKqUlKvNUt8RCNv6LwxdPHWd/gsGRe95hu7ofnKuR3adZmCLUoTfpPoSWJZBJNjZFa
 kEw+CcRvrWJsPhCPzHq2/L/ykkV+5rTRiqh8GDCRYp8VOZnb9krPUy1q4svJueR8Q4iLlZ/7Zee
 DcyLgRm5U5tsEhTGr9PEwAjJ1Z8kHYs80SUjRxamMwypG6SZKyl1hTcpjGAbIoO/CpiwKkqg0y2
 wMezCS5S5EF9vVybc27u3odAmHgxgH6GLMD6XOFfDPa652xSE62IJtfhvqGKTRnsot6njMgh577
 hkc/Iin3k7nYtUVGlBEr6EAU3fI7GPrR2CeuiDnQRve6Ph1iq2wybZwpsh60/yBkd7lZbDQL9Xu
 niSjC9Uax9SZx65RPIEYrChYSgMK051tBpqF
X-Received: by 2002:a05:6a20:7f8a:b0:3d1:be60:2816 with SMTP id
 adf61e73a8af0-3daed167aaamr15308580637.10.1789216642160; 
 Sat, 12 Sep 2026 05:37:22 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba71cesm13288737c88.13.2026.09.12.05.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:37:21 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 12 Sep 2026 20:36:56 +0800
Subject: [PATCH v13 3/7] dts: k1: enable mmc devices in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-m4-v13-3-71043b29630f@riscstar.com>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
In-Reply-To: <20260912-m4-v13-0-71043b29630f@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>, 
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>, 
 Johan Jonker <jbx6244@gmail.com>
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

Enable eMMC and SD device nodes in SPL stage. And set the
bus frequency for mmc device nodes.

Remove the redundant device nodes that are delcared in upstream
DTS files.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  12 ++-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 136 +++---------------------------
 2 files changed, 21 insertions(+), 127 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 7f9443d69510..3077cdee55d7 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -50,7 +50,6 @@
 
 &i2c2 {
 	bootph-pre-ram;
-	resets = <&syscon_apbc RESET_TWSI2>;
 
 	eeprom@50 {
 		bootph-pre-ram;
@@ -65,7 +64,6 @@
  */
 &i2c8 {
 	bootph-pre-ram;
-	resets = <&syscon_apbc RESET_TWSI8>;
 
 	pmic@41 {
 		bootph-pre-ram;
@@ -89,6 +87,16 @@
 	};
 };
 
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";
diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index 8a9a2a09de99..d6299c96949d 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -76,42 +76,15 @@
 
 &i2c2 {
 	bootph-pre-ram;
-	status = "okay";
-	pinctrl-0 = <&i2c2_0_cfg>;
-	pinctrl-names = "default";
-	resets = <&syscon_apbc RESET_TWSI2>;
 
 	eeprom@50 {
 		bootph-pre-ram;
 		status = "okay";
-		compatible = "atmel,24c02";
-		reg = <0x50>;
-		vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */
-		pagesize = <16>;
-		read-only;
-		size = <256>;
-
-		nvmem-layout {
-			compatible = "onie,tlv-layout";
-
-			mac-address {
-				#nvmem-cell-cells = <1>;
-			};
-
-			num-macs {
-			};
-
-			serial-number {
-			};
-		};
 	};
 };
 
 &i2c8 {
 	bootph-pre-ram;
-	pinctrl-0 = <&i2c8_cfg>;
-	pinctrl-names = "default";
-	resets = <&syscon_apbc RESET_TWSI8>;
 	status = "okay";
 
 	pmic@41 {
@@ -125,130 +98,43 @@
 			buck1 {
 				bootph-pre-ram;
 				regulator-name = "vdd_core";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
 			};
 
 			buck3_1v8: buck3 {
 				bootph-pre-ram;
 				regulator-name = "vdd_1v8";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1800000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck5 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
-			};
-
-			buck6 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3450000>;
-				regulator-ramp-delay = <5000>;
-				regulator-always-on;
 			};
 
 			aldo1 {
 				bootph-pre-ram;
 				regulator-name = "vdd_1v8_mmc";
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-			};
-
-			aldo2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			aldo3 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
 			};
 
-			aldo4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo1 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-			};
-
-			dldo2 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo3 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo4 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-always-on;
-			};
-
-			dldo5 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
-
-			dldo6 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-always-on;
-			};
-
-			dldo7 {
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <3400000>;
-			};
 		};
 	};
 };
 
 &qspi {
 	bootph-pre-ram;
-	pinctrl-names = "default";
-	pinctrl-0 = <&qspi_cfg>;
 	status = "okay";
 
 	flash@0 {
 		bootph-pre-ram;
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <26500000>;
-		m25p,fast-read;
-		broken-flash-reset;
 		status = "okay";
 	};
 };
 
+&emmc {
+	bootph-pre-ram;
+	max-frequency = <204800000>;
+};
+
+&sdhci0 {
+	bootph-pre-ram;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	max-frequency = <204800000>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";

-- 
2.51.0

