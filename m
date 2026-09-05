Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9044AC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5518D60635;
	Sat,  5 Sep 2026 09:15:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 276PoHezxOUR; Sat,  5 Sep 2026 09:15:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 750296070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599705;
	b=dAQ8dxGnomI/MiREuMi/qV+3aZ94d9o7LCt5lQQ8BSBl2anmUF7bZ5TdXT7ATjPksFpo
	 XYStbSdS1IdYs/hk3RZuQ+/vNu7QJa8p16A4+ob5j7wWkrul7u2mv2nDX4CGpRIHOcX4S
	 C6uROcwvLyMML6eC6XfAO1nf2hC1yvnorj5Ak9jhFw1m86/h4hjq7cj9nFu3XY1C9lSIt
	 wFYqvM8016YywgYepcxcjRFOd7lc8onO62c0bRUczXD47dzi7tGq03Gbp33vDZ5VKU2J5
	 naG0NbeUIdXK1+We93EVNVqFlAM6NimkNpsU73XZJ4Vy3Fo5q2f8YzUjxD+b9S46djw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599705;
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
	b=MvFn+dtWCjq19YUvCLkUJTtTOCWb4bzuuSl2T/5kFc7IvpgGO68vUzgEmC5BFf1mfRVV
	 VSltEhXu4ZgcXe9sUfux8l4hj1DWY8RfOtxxa6H3EtfNpIzT4DiYL3bQiePEAr2pPbkpQ
	 IbAWGiQaSVmRAvRE7wrHkEB9/yHLuUR8Fzb/w9pJqY7u+EQZW12ZcOnmEZ3wl+zAiwlDY
	 HTHlAvVdpi0RlnbqMXQ/EL0lr3VKC9NyAc8CHRM6ZU1WvMawGTVepstr1jta11GZMP5u8
	 TBjAVQdYURlBbiQc1MwJ2YUhfZJyQoJmTwhT+u4FA3OZYs1TUr3NHxc/iD6DIe3rKnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599705;
	bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DIALAI9wmoKVj76YvuQeRFmGTCO5wwIMrLCQEmmxwZ8NwNZs39zdltJJAuLZuLwJD
	 EADx+qSg61GD8jCSflFD5Bwz1uw8Qz1HZI3dA5kAtloyEFOgIiMTCenQ5hA/8xcmjD
	 jGJw60NS/Rng3h9FQ53JGjHXN06nr6fDc5+AlMC+PgbIg+MxaTuLoNEanQJHs60201
	 noiumj6BzPectv9cLODRz/ylVLju9sJll9Gb94OJtmpnzrPuFRv9ntwHe7ApZWmVfr
	 1r4Sa+m1f9/boKvPtNqoRUyb9ED1nbyB5tY0aA2Wmaab+3VTnmgN7cF/H6QzdMDnBA
	 5jMm9C5hKqFHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 750296070F;
	Sat,  5 Sep 2026 09:15:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 07CA1388
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDCA440051
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2tO8EZanF9BX for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:15:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3C9B740024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599703;
 b=nc8u3Nn7kaPo7kzvaesoZkgqHKee6lOEVz+KjggVcudOoYhbdZeAFa9CihH5oPDoid4+
 9UkmEKpp1tD+FcRljSTVY7PyoZlZkeOLOljOjyEiAmtzLGeBaPhYrgGiY/FOymLEIFFuv
 r9GpDohVSqWoyA5hDyn7aSOun+HvD9QBgx5QN0DNtmR8l8Va0CaCO+/R3kzUw65vFPUIp
 wQpOU/7U1IKrgcpFAj5c4UPfnVsBm4l5xaidzkvTvx8mHNI11yoT0OYKJuy5nEkcwFeGm
 wed6JD1fknijnX6ACPuCOmE7tQtrN59EsLPCl76T5uuVPuVaxbxa0MaOHLeD/7fSDAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599703;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=Mm2F6hCnlVWuRsMG/gmi7rpiqubv31YLho0SpK1aSnt4gvxwCwrnrJsgRtHG2DztxBWA
 i+6XC2/hGSsJiFV/WgsLSYEQ47Nqd5ibpO0ZTz26kAy2VOWSTMnSU4p4qry0yfoinrRn7
 bXUetYFZQmXEPxkDBaUnmmo4WHTNY3BMEO3XMeYsEMgN0MPj2UMNxJqhhQDJHX16Pw3tb
 0l/t961XhWHBYeJtIkmKmKkKfEiU2ENGckJZuroLuwemmEqsZeGAqsHc9y6EK83pbN1fh
 maOVRWbJ2CbEXUTs3LZUOtOll8120M1+cCqiHF5GmuUSRbn4cI7faABtpg50Dl8BAxw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=k6P41Og7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=k6P41Og7
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C9B740024
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:01 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc1cc97b84bso1496379a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599701; x=1789204501;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=k6P41Og7kOTf4xqYL5ZDFZ0FMIvcEhh7USaYPnqKkgigDHZXpuLx4THDBGo4lLcEuQ
 AstC40qOCjeWHPR/KV12gs6rAhH2IUjoBUh3NbspOwJEMSdoWd/J5BeJN0lCKl7CLvES
 QibRm0fOgc8Xey4nxWCWsA9cXUITFi7aUh+Ii0k2QCbOpoHq9z4fd/uSOJwW6/aNcBrH
 SlVUvOTTtVGMIcuRnCulMa/Ybf6HTOKxWUfx+z5Iy2XmzoOpCciFtiZ2VlHmMXdSbMlw
 T2DEMt5a5INqs8miCGM7Ycq0lgLEmV19yhTrKVr06Arswk9H0rb79YX9rJx5nZ5CAmN1
 4Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599701; x=1789204501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YZJkJAnxxIXxytAYbNONjfciX0tqSU1TJti69624ddw=;
 b=YIA7o9BenzvriQ578adlFPfOHUK1sB2ZT0ue2BxLz/SKaYw7CKRNEPsTJDWYYGOWtp
 yg3R5KAxUKegs3THhWeiF5gUNLT9+7Mq50THHiUmVTRfGxPrx7zrjq6DIudwSLH8o9iY
 1KkNu4x/6XSS85N9/5Nm0T+VlT8LreRSrMvpid2+B77gVSgeWt3RKpxbIeF1gnI7NU+t
 aYep8986AU+1lYN7uacT0EFipBw20tLrrdaGao8parJJhWg3pNrTNwvPbnbueR/4ECAT
 fzQHVKC01sH8E/R7xA/ypz75PTiZMAc24WcYy3oR7BYy/K+jfHUcN93Ddff5pZFCcKvq
 qHUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAmn8oAjX7H4yVfC5btY4vPz8xA7cb5aFwrhs3zsDwXni9m/8nCjOa8qKXGuMG3CgHi/QnpuM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mmTf3IhIV1tnWWx7rbtz+wcg5HIvCg3CfqNaIgrPl9lvUMsiov
 dbfEvqb0u3VOVZ36QVLHIEuI2ozwvC1jRc2kxFhDRnVhF/dN3ue44mDQZnnw17PEJok=
X-Gm-Gg: AYBFou0C5mqfZy+c1z50WKZAsHMcRJXNt8posqFz2meYbCSDXE66GKt5bxeQi1fNopw
 YJcwm2fJDShtADwFzua3pOc4OTphrX4nwxqz0VHv/8XNo9KvVYdyi18h6pVUmHQlSleZ9/Xuyp9
 8TRSI4GuJIIt6yVS69i5Vq8tVECowbcjxzvvQdSskvccUC+PNUmLJz5buwqvfb3dUYv8s7NflhO
 8KlhNgoHwbVoYo+D1Jh0PgrH1FlbeqYoghjACiP74eDaggd0OmPnkmwN5aBQKi+/RjaLeHMZW7u
 d0lrCbcVJzC8dM/n8QelmkAmcD/7LM78pXhakSyj9CKXWLOd6nKDzg/yRK2TxWaA09SNkp0+ppC
 x1k7YR4esnO0qAjwPyq21DU+26Iw6HGUEYS2WCxvzyPTWwClWxCLcFsQNR/+B1QgSKMw9wU6MGT
 INkmqmmy6NNY+L6/cdYV8yAJ9GMXrDHgPm+20hmcdUni8og5FcwUbRcCwsFyI2qAMHw9fl99mOq
 aUFd9ytVR3Ts+Zhh9s6ynCZ3HqGQCZd2ZQq+QyBOuF6P2RkqgvXi96Q+kkCFOjD0cEvXtSTy4wM
 PxSDs6xx7Yl5Upx3xi03hwY36Q==
X-Received: by 2002:a05:6300:2289:b0:3d7:b3c1:cc34 with SMTP id
 adf61e73a8af0-3da3a2089e4mr18767249637.26.1788599701219; 
 Sat, 05 Sep 2026 02:15:01 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:15:00 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:26 +0800
Subject: [PATCH v11 13/17] dts: k1: enable mmc devices in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-13-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
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

