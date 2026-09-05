Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220C2C624D6
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC5C540BF8;
	Sat,  5 Sep 2026 09:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sf74FXXfITEa; Sat,  5 Sep 2026 09:14:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D664140B9B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599668;
	b=c+c59Sk31JLaPiTRh3JJKxO2wuMTjL1P74T/9zlCOJmyMXly2kKk+WVIJ9i7X73ZW0ll
	 Ic4oOmSqsbCgaPxDfG1q/pQ34TZ9IqRf3aOtELbmBW4XlWupc7SgF/pqXDpTMnKiKGQHn
	 /AllfZ6euzavpGOlz3BHoQjeMNB6DVijm1W1v/b0KS9ACGlxUdbU7RAE1l8qLiB2TRIyI
	 K5H6OqVgn77b9JiQX5Mi01oCPMd3iaJj88Awuwwjr666tvFrqJ7wdGOaezgt8n2Iqq2U3
	 HFnSvDoVy/z6Ut3kdoT3aRjtoawHh8Fuy1m79v8CYLq6BOm0OJWpzDvWLEoon6vTwAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
	b=gDaYgvIqeU7upHbiNqVNE/a15mmcqXFQneqYo++F26f5d1+2lnW1XcvfiTExgQ7V6sW8
	 57/ZxFpXx46IbtHqDCMB+jGE/5no9HcGyBq5b5OI4KHTf1Fgj/y5ZnsvqnT9Cfh8u7X5y
	 fCrHneZKuy0MluOhjTCyDMY1i8dDGvHwnOaXcPe9D86p4x5LrXz8FEpVt9bE+SLWZ41Pl
	 LGbK9I2DgpN6fqFyGatuED9O5zf8cobfAzqOuQGkhcfK8EYAibDnsBONW5dS23cJ+ozg+
	 xMHyy4yghXDZrH40jV3+vdaimYNLoTbs67sz5JTiHgyv7FvUKMJk+kXCwt1ggCKKcaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599668;
	bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ps3gOiBTManTGw43vJJylQG/3fC2sY0TJ8VEVD6ibMfYCKk3MAxO+QLZqM2+oxZU0
	 HB6MYTHSoPVOqtuhhNg12rGQwWCOeGqQ6+7G54GCci2RJLYW1uP2bk+BssubYvuE1f
	 /5jGYcxO1QEwJUfD+vP5wEjyDXmcT7tb+ik7vO/w4fJsT8r1el1z86ZXb53YkFyk0E
	 g0rpANCQUFI1M+Czkl6py2bMKihIP7WdJfJTN3Km1/eI7blYcgh5+ESyL79P8LOPip
	 MTp8M119d6GdV1T6XD0bum8JfZmUyOvC9KpQYk5cp3d4l7NitSsPpjUZOdp7fhRXO7
	 EV4yu+pQdYHsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D664140B9B;
	Sat,  5 Sep 2026 09:14:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 89FA8388
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7040B40051
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ojsuP0LZuBqa for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 36AD640024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599665;
 b=MGwBOMPAnwIhuaS2TNMOnt7tihf25QwihmYVB0QZV0gLlhqR5ItfQqXHv6gErZYmNd2F
 1mlCdCxeFAZwRr8JYBJTtpc/5Qep6U2wNsDWQafOOKh14XPpQVSaA6Dy9hW9YdSQiO7cZ
 uwZvyPd1RSokz2dUaEQbiBr/AJwxmIbEwiCAShDhCZupUz0JXE/KbR2ikYq4OHZuQ3pbd
 CE9oOCAo8sy5mhY//VaOfm+qSz9CxfwAmiqCFd+YwuAPGgG9+13bYDkhA5c+WNIs354C1
 eBLkM85GsO0R0OUIX13rccIAcHay0DwQ/iPIHLiT5NIEKB4KEaaDIfoOqUQOW7g8EMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599665;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
 b=j6NqSqOWg6lJVmkAatdUyO9XYzo5ipCZlZ6eOhnfO/TLO3ZG5q8JKBOSvLucGswN9lV1
 DmQejnalYE3N5Ma38VwFmhUs7odMI5XG3cqX95jcnLhc14j/hoMRIvPAxwjEl7mqWRPEu
 7sQp5gFPGFW5zJXza5B1u/6ICYetK91ZK4nvi9mt6GXW5WqUf9i8TEbKWTlHMQEvp1BzO
 Jcg/y+plSjKMMJXIxOtKvnR7/kifsxdH6pCPM9weXvDBetMeU5y9OdM8c2WpHg5dcov5p
 KcQW9DtfzxjycNGLlFjk4K/ggxhMs2A5LqPUo3SHbcMO7YnH9kRUDmHTgkFBT43Hp0Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=j9GeCya9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=j9GeCya9
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36AD640024
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:24 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so1881921a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599664; x=1789204464;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
 b=j9GeCya9Qdl6nCcFxsaRiZvo1rxXE3EUxOkbO9Vq85TrDb38a5QNAPi39O32JG7hYw
 uYnaaWfNPThME6Kg2Dw2xk9Tj2Xj12G5YlpRRRu+sVBXKvhGEBiCbVge0AhiES0HmYEX
 7x/j0qeDOMNPeL4tP1KEwBLcpsY2u/tVuy05yOhArk2whQoxU2z3Kr7kmusaoK1zvlX2
 NZDr5LMzGxMR9SNQMkRi/DvuPujmNKtB9Mt3n9Qz53fbrmU3qy2hulQFBqP/6/95VKuh
 2KgHDs41l9d5e8DW+YBsyXi7RKZ6kX7I7FN5Ojk25H+fNXPLBZOeQEenrhoZ+HpZftMV
 DVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599664; x=1789204464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
 b=qqm/dtNQjelEYGfmt1wT0wnMI8AWM5CuVHntE7Yz81qBLckI6wQIzaOrs4IgHwW618
 cBNe80UL0Msj8gFXOw/Sw9PCTVD9Efc7cmKgx8jIZXIqwQz9Q/i2szdWfXhvM0yP5x9o
 k9fnNvzEt79Oql409Q5WGxo/NaUmsY9aL9iB+6OxsZjZYCd0xOwzr1Ba+cqd7pzjeXev
 /tiWgQUsVeNi4ThWihlmmoxjWVqEteIKGlIT01SowNqrgr4LK2rgU7cGBd0Ptc1zvU5a
 cWix4XISEJPxOFbM6lQEz691b+zwhgVyI391FZCoSMzThalDMtxJzUvJIjIyQUO0o7rE
 r2Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxazreesorQ+3lzRElNLwwSZhbYtLdR5Fg44BVAzVurgqN5/NxcWcBdACd44Wo7Q8h6wkKTBmQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lr3q8zeA/9B2uwT6jCCAPZ18TzKI1ZLudmbdRweNZaklHcN5ZC
 1V6DJmaFw5+mqUKIb0Z8wX7fJwW68jMI9KMhEsSc8mDnSAT+RuDjCSla7queKk9YaUo=
X-Gm-Gg: AYBFou3K3crRfR99Mod1ItQ1nTo8uUEqvy0JPMZMmyszuxs/bffwWJgJ400yo5oXqPZ
 RBRm1iXawKFscTqHCmXl8dOAR1HrbelNPRetAtqmKmxcWLHcvFdzHwc/e1HKK6agJ88wGSPL/bn
 hx1cVi9eDAABiGO5d60BD0Du3HmzmKr4XZmPaAiwJ9P1QfLEYy3F1QIB8TPFRzYtgpk+1lCebRN
 pNJDxIJUXlm0DzFeomqRC+ppcIMk1knwPpuB9Oo0FmXTO/17zVRhHdDJxZ3I0ZgTaBla0j/Ik2L
 0yN18ima9WFQi60wyAkc/7jK61UaE0S13eKVDhHkpKNJarOJSGspJVxDDVGl6Hh00TA3UlikC64
 MWt9yV1Py8TZugU7tLU6JodZro8bVtNFXNGG85cRJk4iS+a/AoWGtcpic7x+jaaSq3I06bSu0Jd
 +ZSOL1txGaex4Bfkj1iOBp9fwWUqz1hoqmXyhYoLoJQ9X5KvjoZpACbNOP9YKO4Lmij1IRiNfG/
 zzhESi1Z38byVjQAQ8mTIQa+Av/uVwiRabV5jJ/8EVS1ZJzkD64YW6/W5MQ25fxaV5lEg0bhkH4
 hsA0e+V8fT9/gv7hSQsS721YRA==
X-Received: by 2002:a17:90b:5343:b0:398:e46e:ade3 with SMTP id
 98e67ed59e1d1-39b2628fc1amr18849128a91.23.1788599664230; 
 Sat, 05 Sep 2026 02:14:24 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:23 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:20 +0800
Subject: [PATCH v11 07/17] riscv: dts: spacemit: k1-musepi-pro: add 24c02
 eeprom
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-7-235eacd94fe0@riscstar.com>
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

Enable i2c2 and add the connected GT24C02B EEPROM.

It contains an ONIE TLV table:
=> tlv_eeprom
TLV: 0
[  12.162] TlvInfo Header:
[  12.162]    Id String:    TlvInfo
[  12.165]    Version:      1
[  12.168]    Total Length: 58
[  12.171] TLV Name             Code Len Value
[  12.175] -------------------- ---- --- -----
[  12.179] Product Name         0x21  16 k1-x_MUSE-Pi-Pro
[  12.184] Serial Number        0x23  17 BPMIMXXXXXXXXXXXX
[  12.189] Unknown              0x41   1  0x02
[  12.194] Base MAC Address     0x24   6 FE:FE:FE:XX:XX:XX
[  12.199] MAC Addresses        0x2A   2 2
[  12.203] CRC-32               0xFE   4 0x395ECD34
[  12.207] Checksum is valid.

(With 0x41 as TLV_CODE_DDR_CSNUM)

Signed-off-by: Andre Heider <a.heider@gmail.com>
Link: https://patch.msgid.link/20260513071958.29574-3-a.heider@gmail.com
Signed-off-by: Yixun Lan <dlan@kernel.org>

[ upstream commit: 6bc75cfa56e885c2eab80e215f0a610075505846 ]

(cherry picked from commit 53114539cb9edac100d8804ba4386ea8a8b37ced)
---
 dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
index 653e5a1bf41b..b8e73eed8e62 100644
--- a/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
+++ b/dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts
@@ -17,6 +17,7 @@
 	aliases {
 		ethernet0 = &eth0;
 		serial0 = &uart0;
+		i2c2 = &i2c2;
 		i2c8 = &i2c8;
 	};
 
@@ -82,6 +83,38 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		vcc-supply = <&buck3_1v8>; /* EEPROM_VCC1V8 */
+		pagesize = <8>;
+		read-only;
+		size = <256>;
+
+		nvmem-layout {
+			compatible = "onie,tlv-layout";
+
+			product-name {
+			};
+
+			serial-number {
+			};
+
+			mac-address {
+				#nvmem-cell-cells = <1>;
+			};
+
+			num-macs {
+			};
+		};
+	};
+};
+
 &i2c8 {
 	pinctrl-0 = <&i2c8_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0

