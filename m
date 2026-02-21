Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76112C61DFB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 17:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A466E83DFF;
	Sat, 21 Feb 2026 18:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jMXloGhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1830A83A41; Sat, 21 Feb 2026 17:32:35 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88968801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad22a5e245so20986005ad.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 08:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771691551; x=1772296351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HhEHp7EOoJA00ad3lsdzaaoyWg7wiuFZHOyZ8T3YO0=;
 b=jMXloGhkMNKwVLldWg5W9Kll/9r6cOsWVHHVD4Dy1d+5aaQfkeYzNjuIsveVIP7s25
 so8tCrgTz6O5PgpUriHHSvMZroxjFs3aKLOKPSjtjhfRhFBl7Cx6KH75y3esqnlJEbTB
 25Ik4uIw/YILRGj/0PAyN/6B44p+n0jwpyjgHPv3bg7mn8netuPqqxzMVHkfOuy7jKhg
 fdjHuLdyJBVpvcPE+jzmZnlptG0j0txrzCkUiA0JQjhOph8lLaumz0A1Xq0dybilzlNm
 cI0E8V0C4Fi8lCY9CBil3pZntqZNu2t51DbOo+37sqHoLOnYBs/62t3+ofSeGOimyDOu
 nNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771691551; x=1772296351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1HhEHp7EOoJA00ad3lsdzaaoyWg7wiuFZHOyZ8T3YO0=;
 b=NqsAZa6/kgF3HkmRvSp8SId0mzYFdHJDjMp97GvMVTNJWJK1K23YuZ5X+L8hxtHLPK
 SLQQzlE/iVjT9PkJUN9cZtoTku4guqWfO34QriUuqODBA2Y5iXbyEm3e+6nCRefx8+su
 qqoaoTkDrGyG7wkW+gWj4RYfk+2wBdxBv6DOyB19oeVJsGwiuXRst1uW4ORa7AKc+Gjk
 UxEyf/RYI+FyqeDTqSlRo5Y28zXN7RSr3TEYS4wiidvdiKs9p4xlyB5Pf3Q134WxAvDa
 bR5xe88W+lcCbpT3vXgzXBiUwY3m2o6xnaWcg0DhcGorm+PU81DS8VkrnDH+YtydHOXH
 FI5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/LMY8V9Cx+ztWtn7nhKixOLvez+VO6vKA/hrIu14/pzHFtjhPjChGUy3KvIxeeAbOj7OdRqE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywzg76JKofOJiZJlfUWiWaU1bM+WODpyJol/hISxg2d4jgBQMy2
 bao56c6okyGSb142q0lUHRficGZQm/21+iRJMesJN9e0Nk+V25ofvESapMEU4w==
X-Gm-Gg: AZuq6aJXnpMd2Le8vQQS0J4UpF4WuiCaU51AD++7FKWy8rn8RnH3nBou4YK91Io+Dk5
 01F67Fy13z418IG+lpvf+e9TV+J8cYqgaTOSI12Zr4BHIoW4xtsqvAnXGBuGBsYkBT5Mxz7R44G
 pN6U68Bzq9XMuGGeglJUTXeOwHxgSxzvFadM2zfIVacUbmLw6cu8awTswLoMB9gq2WTd0ccQV1d
 MGIT2XTGHbt8z12JGqwiH76z3BOtYOysd4NjNifESTPQ/GOZhNMwydmcB46CaO+IT2hghohv+Mz
 ijXK3/+wWkiEKqwYkEv+U40GwqwdGsRFjBo8Zxa6zxl7w39+6mDFF5zlIisl2zXZQ01PP/kEt8r
 CAbzPsScaU8fmObGfqzfshja6H8Uzl6/xrz2dPPdybtDPCbEm267nl0x7IwpY7I1xPVO4mp6Efv
 3VZgcvD6/gCvL2CBohcFzd/cNS3RrbSUHNPraeC5y0pQnoogK7BEsTJMsp9QFXWNGpNC/JVPsTG
 kayZcy9TXJVHomgV4gLQw==
X-Received: by 2002:a17:903:2c05:b0:2aa:d671:e613 with SMTP id
 d9443c01a7336-2ad74523121mr31317685ad.38.1771691550805; 
 Sat, 21 Feb 2026 08:32:30 -0800 (PST)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7500e062sm36868365ad.48.2026.02.21.08.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:32:30 -0800 (PST)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v1 3/4] dt-bindings: net: airoha,
 en8811h: deprecate pnswap-rx and pnswap-tx
Date: Sun, 22 Feb 2026 00:31:13 +0800
Message-Id: <20260221163114.87553-4-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221163114.87553-1-lucienzx159@gmail.com>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Feb 2026 18:32:49 +0100
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

Deprecate the proprietary airoha,pnswap-rx and airoha,pnswap-tx boolean
properties in favour of the standard rx-polarity and tx-polarity
properties defined in phy-common-props.yaml.

Update the example to use rx-polarity with the PHY_POL_INVERT constant.

Link: https://git.kernel.org/linus/44f62aa1b1209232cedcfb39097fc1bfbe75bbc7
Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 dts/upstream/Bindings/net/airoha,en8811h.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/dts/upstream/Bindings/net/airoha,en8811h.yaml b/dts/upstream/Bindings/net/airoha,en8811h.yaml
index ecb5149ec6b..0de6e9284fb 100644
--- a/dts/upstream/Bindings/net/airoha,en8811h.yaml
+++ b/dts/upstream/Bindings/net/airoha,en8811h.yaml
@@ -16,6 +16,7 @@ description:
 
 allOf:
   - $ref: ethernet-phy.yaml#
+  - $ref: /schemas/phy/phy-common-props.yaml#
 
 properties:
   compatible:
@@ -30,12 +31,18 @@ properties:
     description:
       Reverse rx polarity of the SERDES. This is the receiving
       side of the lines from the MAC towards the EN881H.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml
+    deprecated: true
 
   airoha,pnswap-tx:
     type: boolean
     description:
       Reverse tx polarity of SERDES. This is the transmitting
       side of the lines from EN8811H towards the MAC.
+      This property is deprecated, for details please refer to
+      Documentation/devicetree/bindings/phy/phy-common-props.yaml
+    deprecated: true
 
 required:
   - reg
@@ -44,6 +51,8 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/phy/phy.h>
+
     mdio {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -51,6 +60,6 @@ examples:
         ethernet-phy@1 {
             compatible = "ethernet-phy-id03a2.a411";
             reg = <1>;
-            airoha,pnswap-rx;
+            rx-polarity = <PHY_POL_INVERT>;
         };
     };
-- 
2.34.1

