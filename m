Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616FDC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 295566075B;
	Mon, 24 Aug 2026 08:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZkzayNLE411; Mon, 24 Aug 2026 08:51:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561496;
	bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oxciM9IOEl0yKATFNxXVJYGjV2KsQnK18DxFq4vOxyMS7w2xc+FMLpAnRZZx7oZVO
	 8F601EaclKO1XKv7uAlnWtDN4KtC5l+NyiBjUuvqazATrUeMKa44AG8Pv+eaguXcRm
	 8zCW9JGwMyuGBMklrSHOC20s7AAkGoqS+JkcpeJ/Ejjl1/tIH5Y3Cz7V0tkigT7Spt
	 AIk1gqAaE9nLmSJeEapnia/e0pcXt7u8uZETnBtoKx2fSv6ZqttfMZK5CFkkE+g7Mn
	 gYXUeIq0CoOAlvvtPCHCwYsRuTWqsZuV2EOUNs6udE3lBwqAtwzLcsr1il/pdJlRIU
	 wEyYbGpGRvBbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0116260622;
	Mon, 24 Aug 2026 08:51:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3378B230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 316BE60622
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dtvTPMim8Fl for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:51:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=hlpRQuOg
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 419EB605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:51:33 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso486625ad.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561493; x=1788166293;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
 b=hlpRQuOgw5KWcWizsTtEHPKzbHFv8pVz7Ii0V8CA5pBUD9U4hNsDKPB/wMDZAbur4R
 T0HOPDwBlBejjzcT/vRbElP9bVy3Ykv0D3CPguJUM9HV8/msFqYX0Kp1DuNoS3yR1Oar
 eY7se5js9PKQRHdTkLounS4+SXjdmCKzrqMlbozphtBueRoTF/EuFDxwIwX3PzPF3Y60
 t052gkmJqlQdxIYNLPd01H78p2gu3veqNKPGWVbfPnmDhpwlGHIk53Q0iJ5RxRw4WRE2
 OJr016PXjCP6VOb6xlm1cxpzWMsHgvGxPBuuKBT/bPO2eiP3ZyunP7pRuHpRWYAOZ6ww
 IA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561493; x=1788166293;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=070g02ll6sMJTPvv+FTDb46uDhxkq6VKpOWuv1Gjd6U=;
 b=JOJbeeemIZvnjcxG8l0vItBq/dzrGNPY3tNRmZDnfF8D7AHFMUm2UfP240t/XR9m60
 cZdVKV2lz8Lvmt7FOTPZvyPloWe78wYfSROMuOB+J0vtUvW1MmIni/bKJmRSAMFNLidR
 hlCO2jTjCXkQ94Y2E2VOofb0L226xr7VUcUKXF7yMRvuP1cBBoKIxNgkaDZWy0VgTSMS
 94H/2xIt6EV1/Nj5MJIeESMvUSWOlRQzdJoSqR7BPTBgfsz76/8ok2tYrqg//DTPlA5s
 NTXW+LrG3e1UxOr4l5solbNEQF0qbXypLc2zLiRe7guS09wXzih4/B2w1Fj/1/84pFns
 icmA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8Tc6nTPhRixiHPKOs1DhpegrG5amoqJLE8G+9H1K81CZP29Hx5HnACmum2Q41LCTGxoClhMk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nfcjmB/b+TRCyxYBBNQb6XsRUadGzJx0XtlhuTXa0a4ToyP4U/
 rty+PNfQHg+yi6muwirAT9uyoA0ewMeyfbmS+H3iwg305MQbvk8mQwfVSzGzEDCQwWI=
X-Gm-Gg: AR+sD11YZ7QmmIezCmZSzMeGcfz0tHHYlByqnTgr21IOeRGVFrK1t7ZAglfFSz+BUei
 fQNOFoh1Glmwkqe2xrxnQAjXhx40o/RyP1ALlnYp5tYu9lWn/puU8TVG8UmJ6h+nb7YXnKK23RB
 UwMQ4rICHSQm3TPmLHIlFS+fdHqQQFa52K5S5ZrHfOXWMV5o2KibQI09/nqHCu0iazm37pRQBAv
 gvDMygnLhSiaFL452wsUYndsL3evX/mE47RLmqogGte7LB+SlNmnY8tKuKAGBACDpLwGxO+TSyZ
 3j3SxJgO5B4mjnIs9xyhd9UfK6YkRUh54TO1UtVasYvaJLE39OPREy4xboWxgEXcegYFFTG4O1I
 jzoPVC67y834nAjmzO+3EyYo/KpExHIg038kkBsXaWnieNMePWA8/obfVjw4khNlBal74lPr+Ue
 dIqPB18DJ0DkmUlg9gz+vf4Hqj5WVbLvhDEFHox/m2fiGbMSri2E/pTuT5QDpllygLB+Sg4Tj+6
 2xDR/Gy9vx8iw0y9TF8w8c3hDHe6V+rBpPsN/L5dB4mV8m3OkjcOYwRzFr2sw1ro/XcxloXSB/4
 AJpnDJaJmx43zBT6SCJGkCujKw==
X-Received: by 2002:a17:902:ebc2:b0:2c0:b6c7:227e with SMTP id
 d9443c01a7336-2d64adea473mr470833815ad.5.1787561493202; 
 Mon, 24 Aug 2026 01:51:33 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:51:32 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:42 +0800
Subject: [PATCH v10 07/17] riscv: dts: spacemit: k1-musepi-pro: add 24c02
 eeprom
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-7-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
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

