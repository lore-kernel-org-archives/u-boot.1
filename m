Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988EBC624D6
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67D5740A93;
	Sat,  5 Sep 2026 09:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-jWBdXt_d3j; Sat,  5 Sep 2026 09:14:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E31940A8D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599679;
	b=CMS6X2Mj/kXgzBO9aRvn8BDqKqdeG2+2QvxfVqsmNuK5VNBObpc6pCBojPIb8Psx9RJk
	 tpvq07EZBz8Mmc45GWcH9bl9lUq37qctOFwlBQEYzMBiN2JnFFR0E5nzhGtQBOqVHZ+9a
	 l6hPNZ6A2wtpJPLlogCPVvZuc5HFSxJYNluDM1E5VO+h1Cyc5hvn1nbgDqysObzVP4aNM
	 wDVDkoKVIy/98rE9pjm22zRCJtopAmJm11AaOhsNn4WKxkaJGofFm8LrHQlCn+/bq497N
	 o4FJGPYBRTvBaxBZUW2bIkrWMo7Ob01sfgNWQ4XIA3fM24t0wz96ZuBRa6ZeVtKA12g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
	b=HgT//hXkIohA8ijgDax2fYyzSHlYc5taZZqSe/gU4dfJeQovLv4m5M+Be8DT6tZgEjVR
	 M8wx7ascTfQaQLGh/VJ/djIGUxXJXStyG+eiLLdqVrkpZp5Wm3djakpEb3PYj+pLw1dYO
	 0caK6wl7Mzt2fsWj7P8Q4j8fE/5GS7mgsuvg3A86mLP6stCm8xQe4tH6+ivtN+XQAbooQ
	 RHiQWA4EMToUFU4kAtQxL3JpdqHBHb4LnVS8y13ewuLERKPA9Kz4gEaV0/QSxa2+uELXK
	 QQU3PK09Q07m9bJVNMApEYWA955vEhJcLQePnJlRe21HA9Qa10+1cekqudRnMbLlh9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599679;
	bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VbpPKv2M3M2gPhzOux7ihZ0z51Q+IxDuAFUAf+NVeGwx56wQLG5wfmEisW8mca9kN
	 L9DdsgC2BYLIIDt+FMtLe875IjUmLO1SEVqpYfNsV5jiS1rIdNcVX5AGczvf6m4Sqc
	 x70I86CFk2esgZ4lw7sniU1hAUNdyB0J0r4hB/a0s+1mITNUXmxNumzi4wZ92vD3P7
	 O44OOsL2QQ9rKQIqFDlRRQhvPdVr0IyZIPSOnCTjPYu/eXYdB8s7k8g7yWuJ7edv8k
	 F9yjyldikU4jfKIF0ZlKz8eeZhIWHiZn8TWUX3bTvuT4dT1DYP2wscczWgf9eiKCt3
	 +NQ2zKiHp6pyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E31940A8D;
	Sat,  5 Sep 2026 09:14:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1D06388
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E5CF60622
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ntxtXI8iXhK for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 489B7605E7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599671;
 b=Uv2KPrmQM0yPShDUtkODPYfgmbFY+nkjrbL2QXsAlgImeO9xxfptL9RLkp4cupMgz/iQ
 M0lNAopnj40zFuJcCV+VQ11/1Xv5NKTyljxKl8tesM5wu0s/nZgt3tOwmhPx2to4CT/NL
 racEeFH31B8XbNKQgc6yLZ3sWtbhefOy03g9W+xAB+Ba2T8QX0jYWEe5kQws0sREQks35
 EhnXJTlMYKNn65YPOUZtBd8mHDMujdZ1mWkbPoQUdPZQjXh4rmII95ofcBYFuz2yZVDPH
 h+Rq2IY5YsP3vwcAW9tI6CMW60yJYLVtLxvZTcAXbu25P/MW8jnR3uNfh9K3dhwYqDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
 b=rI10pSHmTxVrt82v3N71T+SaE3HNOztcfPDwzG9lQixGyYNm01cv9JFlXP5jYxzyDA/1
 zDdxElWO9DdDfkNQ6pKVu62u3VQJ7PTZsG/sEcVvDptax9G6f5JhiGvLw7oDw5Plwr2Ab
 2aEGLzvfd5QtwHRD+b9yxkr8tk/1GewO6N94g3PYvCEjsUdMJbn9iULOG530PgVR12mTg
 z5ljDZSUswgA8D5SyWLe10YR8K4IfD+FIno+ULYliEc4K47FzhMddeKpGG5iY5ut8PVxV
 UFoIR+zYUk06xUuVd0ZgcodHoicF0Zvgk/KYxJW4jE797Kn3xduSx5EK2pV9TqwKL0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WOsr13Ek; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WOsr13Ek
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 489B7605E7
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:30 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-85c9a79590aso1797269b3a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599670; x=1789204470;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
 b=WOsr13EkEr7IeHMQR4CcUs9u3llhvu2XQ4ErUAmfJL3vTuDN0qLcH/qGvvo+OVEDk7
 LmpPukJryTuICSsu+9C3tdpKCY5viBJn+rmBEB/As4MKpDmufyOlwEgldN+2MwlRBWHT
 eG4r+ZrB5tp0XwnXGT6jT5Viabe1V/u+B0ggaDbMhe2/aDc3d+9HLPKlzbznNpYoiLg0
 9WYgOlUJ3xqbcIyHkhpNh3SRcaWk5mafgkvqul1aaXhsqO0c5xWNdJ3JU5xo3tlWYQdz
 ocZMvfFBkt+jEHMExQdI/EZCEfVVMelFKzmw5kygSN9yD6xOGWmqDPO/vZeXXAZF4GmA
 Dhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599670; x=1789204470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OLKYRoMiXKWGmP88S7wo5+XrL3qD4A+ckBwywH4yGLA=;
 b=ergtyni6b2zd6VSIz1KmAHGMD9Y9ErbIQH6QGjmkWAVjuXqDHuzjGGlt5oLwfkx/BV
 P3YgLoUJmHirikZuZYDGJ0+TnXar9HQBbemXtWGgVlDJPzy0ngr8pEnQ2CxRV2u/pP3L
 hPnIGXIObwfpYHeHTNIeVwOmp8CPfWqJFKl/WycgcUpMVW6w8YGqED+zaiOsjpcRH9YQ
 kgYPTrRqdlkiln2HxnL0VKHfLsOOWJYJTfQQK8EhwW+c2n4fWl2an3YCAfymQOBSn8P9
 Uyo6oQrH+bzBBV959PaP/3qcUrkynPkJ15Ie8ZpfFQo/lYAD9bV496L0w5e2/9A8chU3
 au3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByUGYOvnw+H08mJqiIxj82MJkMh+1CqB4au4/aZ7NTo8wwtiEbdfMLTdO2WztTFYnXkQeK/+gU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lrf6XCadgzpPPr0snqHMTTVbJI5+/Zvu92poxFCyMw0DXjd49s
 SMsfL47q9cQBH4cMf2JL/QcYrYJDgdgzXHiJi2vrVmAyeNqoS9QMsSULiZxCRMM07AM=
X-Gm-Gg: AYBFou24+witMFeeqDKuVudnTqp6+o5Meze5o1SfhsYpbE/sPXec9IakTATnAbPi8nh
 25CBYAOiFkn0YRMGJhLNvbC8pdKepNE/qgfImn0W7SNyEVcqehMtxirvjt1cmJR5RoPYPl29B0f
 A+UF2JoBkwscyDg993PZ1fOhQaPwBFCdbCM1PcZXP7n6LD5OS5++nRFfRodRLO3vswHZPe2+Epr
 Jb0J+Nb1AVlVOA1Mz5XCCB0ENhykOSOUvgcg9gWqSoNQqY0EJmlvhGngbeXwYRCxBsFObOicA1d
 xE6Ft1bGG8WzY9pPdYxAjHDhN4tH49oVE+xec6/0c4Xf5swnU3/L1cIwhun1e3X3BTEL5WHf3YX
 xPJedcKh+LGwN6OK3/UeQ+rVTtH0O7psgjzXg9ud5IpnTTbAJmDxF7oifecy6UcWWNHmIxTq9Xt
 F3MK7teNHR0e7InIQ7HCN0NnYOvcLchseUPBaFqDdEmV/3QNhBmrqDq6qSItX9X/jkyKH1a4WT1
 HQDaLrZ+y7r+5A03Nev5k/0varEgnW5hifJQxArARpDpNnEkM6HKBMLTRod86ZOseOq3bx5uPCS
 9qKG0Kmu5oDyWJooecjBpN5mDg==
X-Received: by 2002:a05:6a21:6e04:b0:3cc:f008:8125 with SMTP id
 adf61e73a8af0-3da39cffb2amr18005411637.1.1788599670172; 
 Sat, 05 Sep 2026 02:14:30 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:29 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:21 +0800
Subject: [PATCH v11 08/17] riscv: dts: spacemit: k1-musepi-pro: enable QSPI
 and add SPI NOR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-8-235eacd94fe0@riscstar.com>
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

From: Andre Heider <a.heider@gmail.com>

Add the QSPI controller node and describe the attached SPI NOR flash
(Winbond W25Q64FWSSAQ).

Add a corresponding vendor flash partition layout.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-4-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 735b1b205d07bf7bfa55b1f50f5485b9cc42a251 ]

(cherry picked from commit 30ccfd225cc1aa971a0748faefa14e735e49807c)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index b8e73eed8e62..74841cffd5f5 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -44,6 +44,15 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reg_qspi_vcc1v833: regulator-qspi-vcc1v833 {
+		compatible = "regulator-fixed";
+		regulator-name = "QSPI_VCC1833";
+		regulator-min-microvolt = <1833000>;
+		regulator-max-microvolt = <1833000>;
+		regulator-always-on;
+		vin-supply = <&buck4_3v3>;
+	};
 };
 
 &emmc {
@@ -239,6 +248,47 @@
 	};
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_cfg>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <26500000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		vcc-supply = <&reg_qspi_vcc1v833>;
+		m25p,fast-read;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			bootinfo@0 {
+				reg = <0x0 0x10000>;
+			};
+			private@10000 {
+				reg = <0x10000 0x10000>;
+			};
+			fsbl@20000 {
+				reg = <0x20000 0x40000>;
+			};
+			env@60000 {
+				reg = <0x60000 0x10000>;
+			};
+			opensbi@70000 {
+				reg = <0x70000 0x30000>;
+			};
+			uboot@a0000 {
+				reg = <0xa0000 0x760000>;
+			};
+		};
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0

