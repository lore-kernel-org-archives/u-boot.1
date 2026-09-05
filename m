Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C7DC624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93B5C60BC1;
	Sat,  5 Sep 2026 09:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMOIyjgawDW7; Sat,  5 Sep 2026 09:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9A95960616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599685;
	b=i7i3HNUIr+VImWSHJzE71vBGrimLbT8lRD3WUU2y7qLm4MDFgJzSv4WsMArYuYIrP4tN
	 1yRXGGqjIjNhKoHYOSib3UjdWkb8bP8q/1LYr4klO4WhSGHJ9bYu41mBVi5WxiYJDFN23
	 nbFMt3xIK8lWX1iT9ezK2gEf/BarL1zm7BdUKrQL0lDQ0OWN+S8TxdqU/1RX6n8lQRMhU
	 XIueNuYhUv04P3FBxKh8eFiPABEzzIa3+mgvLs9KEagy7qL6UUV2NvTRk+AG23GtDxWfP
	 1CuVWlk2UwJoXu1I8VdkTBM4jIGMhmkb8WuGfrYhEdxINQwK7f49pm/gXPvbrg2+CZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
	b=cKsGjqCvwHvuebP03iagFoDLRhJ2kVBMl97j2yT/iorIkX67+vQt5pTxogIQVzw97xJn
	 ZaNl5odO09jSBc1eSWJ1HRVOvLCHMq0Bh6oDiJYvxKtae6jmL8eFP6jyvqvRG/FXdz0so
	 cT7z8gWNTA5MqGQ4h8hA2OtriPY1DSXljaQkIwiRRyF7cGm3wNXZmCK2hnIlOD8gzULJf
	 DHQcM2tv5wXcmVWmAUUaiDr38iaMImP3rFiX/nUFDidwWLpK9YP/wz0AR1Fg/YERFnNIM
	 91cpRticP+i1UqaMW8BGenu4a6dqfEdRayEaYcidIKwe1N0RIZcM4YFLy3vp4hDsfxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=nmotjyCa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599685;
	bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vUgSyON1ly0S3YCLP3c2jIp2ki0LwdwPSclkh4/JZ+72XbrZI1v4yfV+TekwY0VWa
	 6jLXaddjrssyz3lFPQ7WrfG7TszmK/DS+ikXwuYMO/tyVS4CjzondW0+gUh+fhbrNN
	 TFGd30obEqweGMjUXWl3COWWUvqmleaoetC23Hzjd7kLkG6rAbbVbAd8ZLCS8ybnBc
	 lheWsyQRggU1XC0cD7++5WZ5zmPc4IAEenrA1U7vOvQ5Xk/nHAgnH/GMSGCH6xwrgl
	 5xu440XzBtDWj5uaj7ySkESIjhc7eZVvTCoGtlOc18xErsiaJudO1uRSQR4PaPrKFY
	 jpy6DS3GwjHag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A95960616;
	Sat,  5 Sep 2026 09:14:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 824EB388
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7440660638
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 71vBdUNzslcL for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:14:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A490860616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599683;
 b=sekU7INuxk+KgXWM08VDzY6T3TUOeju1x7zHmdl/JHg/APjj7LCXNECenyn521QQGbz/
 WqfuNWsNuZTjC+AB4q7S6PP2V+UBHo4hLI7B6F3eyd1cdCL2AvFSYxeYOaHGAthxMLc9v
 zabZLcYDUiPcJD43zLd7DRhGbCMSG55nZO3snAzwl61G62vY0NKHUiz7Cs1NQwdZFghIZ
 WXEt66iAHG3/nt710hhdFEpRDFJceyrvzNgiv5A7BOPJ1qzoZIbaj/VJUyosyh/avDpxi
 4xYvvHdi+QGsA6P/ui0LPxsKGEHVvBAWNeNKKlo00lcPUHqWGWruzRx04EiUBNH8Quw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599683;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
 b=YRkO33flyZmsPJrNVN9NHpa3xXVhHhOu9QF8zOm/vag8+E0WkihSsHvfx4BFdHhXoLs0
 phhNEnUDo714irBaAYlbR2Y8mGW9yH81L5A8LPJBfQA/tOakM5PfJKn51IqIqDtdKRbvK
 cZKLwk69KQLEd5aTxtGQwoWOs3MEFt3EAR3ViZgwdYWZc3ZB4JG0IuJNyzSaO6YYzXFNH
 kpFFRUc0jHxqkDsEbD5bVTJtH8fok7TC0YrBtKbsklmhM10/thIjN51KGlInqNEdKlVUb
 tndNA9RC5CaicrAcDbkprhXe+fxvNenkf/rwCh6J98Vfy5wTbDOf4nHNl2fmJrXkyJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=nmotjyCa; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=nmotjyCa
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A490860616
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:14:43 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1505593a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599682; x=1789204482;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
 b=nmotjyCahgbd7uPQSJxjXT5BayE0yo1dInp+5rAtooVeilUeOA5I3wp+rtenTP86Tk
 E0MFdC6jlJShvfqAqhlj7Jg/5PoxValJjAxeyVIfC4+YAR6317Jrd3KBvsbVmxyZxRW2
 z+DsWS83WD1feeqg5u2/Q1ZH5m+wBuiM3lDcpAUIWbFafGFovCQEb7CA9biul363jGsO
 orXjd0zTInTEy9lmUH7hXgyw4VscnOdSuxF1Vwhj4TyBNYVoy2Buj8hCB3elem03Lnpr
 aNTml/FD4qbBxtBKCnNQRU1cgBj+zlydChz+hvcn45jFMtecnMtBcoNpiloKsRPSaGfb
 snmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599682; x=1789204482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l8Cf7boF9I+7AftYkc6cyZTM23fUc9s52WqogIxSTGI=;
 b=ON3JT78s+25t58YNOwUMuMq4JChsHVKYpm7vLXKVFAaOeHvx9VvogO0OtnUuTRqqPh
 dU/K7AlR4RlLKCBdbP46VakAfXOWM/8GY98Bd5ATJ/sr2H0744y2+BrqUUSI67jw+ETq
 wwZyJ/wC86Gwln/3da12BDTFlJMbZUXfy2s64GjGcnVjkkeLg9OxgJOSS5THr6pBL5b6
 BHaiQtNG/SKz8I1EPmbsZoyjJUUdMIqICeA7qFV8zlH6ixBaPk3r0NBJ/7xUFh0UCngE
 GzoNcesj/uh1YOmAr7D6GKOtS2iI9YuarrVyaX4HElSqFNea278B36W8nJTdarpiC1V/
 yEfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrDC9JmT/hknU58/BX7C/4agoqkAl3IRNUw19ZkHX9J/n9OIYombyimLE8Me3otsfyL70kv5A=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nnbc25QfvilxMA19Ih2iW3kxavTX91Lc4YBuzbXAw2ZOGhOT9F
 xKynZpc4NlyZQCMamu4nY8GsPItWZljkSJrsICvxJqZU086kH4utMSnD2Bm6OMMTMbc=
X-Gm-Gg: AYBFou1XJuGFq4d8pXgyv6lTExmlkqf/kGBxIHPbNmleJwJAecj8+unNgIrreeBuQzY
 fHan/KxY2LDAl380Z1vieSfBNhHTKpphOPa2WIAjg6loAs8eziC7//Mkt/IIxVcARBYqrGDWPlu
 ETvPAN218N/gNr9jSs7NOY7jtZ/danSLwvkLTOze0RpBaJhlbcj/6uXPhohjMysJlLDSGKUlZ0x
 zbpkDXAZgGLTyObQ2gYocl2BD14qBe4PvFWpi+titqHfnZeqFE80coWQ0npKpjMoJvdlouqn9Z1
 cGfgkoyvFnfPmUQj2TY2QtGAeKMJXkUp6Mxts6tKXEXwe44V5y32GOBjLq0VaEephnmDpBlRoa+
 FNF4KFl1MVFSKQAF0v8ChKy8X6/tRKaS2bctJALEJX/4hzem8Na4iRvTqcKwOOh4/pqfgvxrQbN
 wOdBkdwe32uzX5o/cAZsSfF9sJg9DoisA8SlNdjcIxJfwq8rxdCO22F/ol4y9YaShRCiC/HKjWm
 yXKQcCqvST3aAdVtd4EvQw3Gb2pCcPkNQhkLqXICMsAZOHXrFf29FOsEx3/09IUvDdyzYyiehoJ
 rXGgIIivhNBOIKnBYWNyrGiItg==
X-Received: by 2002:a17:90b:4cce:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-39b260dd4e9mr18331723a91.2.1788599682466; 
 Sat, 05 Sep 2026 02:14:42 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:14:41 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:23 +0800
Subject: [PATCH v11 10/17] riscv: dts: spacemit: k1-musepi-pro: enable PCIe
 ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-10-235eacd94fe0@riscstar.com>
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

