Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1AEC4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 15:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED5E187AA4;
	Thu, 14 Dec 2023 16:36:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzcAr2YW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E5487AA1; Thu, 14 Dec 2023 16:36:30 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14DA987A61
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 16:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5527ee1b5c3so1024646a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 07:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702568187; x=1703172987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7aoTw4OzsLC4RfHyhEqd9IMSyhLj1y7UIdS2DuMa/Jw=;
 b=kzcAr2YW7lINM2PWD9fKyGJA+rqv3rPqSnt+iz4y3SZx4StYaSeQd/H2xghuTCAjYP
 RM+NALSfJO2Ohd1RDHEVDUmQDmE4HOY9VzQpXOmtmFZdZFrq7ssvCNxV9YCy2q0Hketr
 k02IV7wpcZKPVHJCuzIT8463xy2gHyXT+68Q4oVJNbLuZhsLSLo7Trr3dt1rF3CN8hYR
 T3Co2LEN17NTJ0Mw0kO57qGrkVkE/iURgzDZJEAm8akIEgvr6NuS7yeITUl3wTFu23r5
 yfCBR4IUlkVuUbkxdO1vkeykiNSnTBGdJ+vk5hwndba97tzTauSd8xH5redZWEqZ7nuf
 UZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702568187; x=1703172987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7aoTw4OzsLC4RfHyhEqd9IMSyhLj1y7UIdS2DuMa/Jw=;
 b=SJIt9xMd+zNC6ImKwpFOI3f+X7mMWcu6gWYhbMhIT4pyCyiInXemEebNsi1QRnF7k+
 I/Ifp1lk+r5w10icbKY3o8tFyDWVRAvvWJw94v6nBUaOA1eQAItn+640AAJU6CULTyko
 rv4uJCWOBEAx5UHPKWNbATLVgZsCfBqKMzvBWFMT0KorpaoOrf242/7rlG4VWV7BZHUR
 RsGxeFjYyRrTj8HqOJM9+UJDFeIdQZSTiudgWKQkSicF63zkrLYXp5Obj4eqymUqaY/h
 8qdB3sQIqwse3cGcbhKNS1pmSX2iyDhOS0jK0DDjWdM6iJbWVfkjWIZ6XFu2HRIMbvsi
 qbxg==
X-Gm-Message-State: AOJu0Yxs5IrmymXb/KseelB4ecgRgbg6BJlMzmtMsiNtzfH+MeokOw67
 QsqR6vSPZT8ZkCIN3oyINGI=
X-Google-Smtp-Source: AGHT+IGpJEjbt5Kw87AvVHEmj7Sqpfrh6cn5IZWW6q5OWiB43w0Gdk/CJyr7aaNhgpvuSEwj4xh7tw==
X-Received: by 2002:a50:9f4e:0:b0:551:c796:78d0 with SMTP id
 b72-20020a509f4e000000b00551c79678d0mr3884602edf.27.1702568187199; 
 Thu, 14 Dec 2023 07:36:27 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl.
 [31.11.218.106]) by smtp.gmail.com with ESMTPSA id
 fd1-20020a056402388100b0055265d5f3c6sm910575edb.24.2023.12.14.07.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 07:36:26 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 u-boot@lists.denx.de,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH RFC] dt-bindings: nvmem: u-boot,
 env: add any-name MAC cells compatible
Date: Thu, 14 Dec 2023 16:36:20 +0100
Message-Id: <20231214153620.23998-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Rafał Miłecki <rafal@milecki.pl>

So far we had a property for "ethaddr" NVMEM cell containing base
Ethernet MAC address. The problem is vendors often pick non-standard
names for storing MAC(s) (other than "ethaddr"). A few names were
noticed over years:
1. "wanaddr" (Edimax, ELECOM, EnGenius, I-O DATA, Sitecom)
2. "et1macaddr" (ASUS)
3. "eth1addr" (Buffalo)
4. "athaddr" (EnGenius)
5. "baseMAC" (Netgear)
6. "mac" (Netgear)
7. "mac_addr" (Moxa)
and more ("HW_LAN_MAC", "HW_WAN_MAC", "INIC_MAC_ADDR", "LAN_MAC_ADDR",
"RADIOADDR0", "RADIOADDR1", "WAN_MAC_ADDR", "lan1_mac_addr", "wanmac",
"wmac1", "wmac2").

It doesn't make sense to add property for every possible MAC cell name.
Instead allow specifying cells with "mac" compatible.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
List of devices and their U-Boot MAC variables:
alphanetworks,asl56026) wanmac
asus,rt-ac65p) et1macaddr
asus,rt-ac85p) et1macaddr
belkin,f9k1109v1) HW_WAN_MAC + HW_LAN_MAC 
buffalo,ls220de) eth1addr
buffalo,ls421de) eth1addr
checkpoint,l-50) lan1_mac_addr
dovado,tiny-ac) INIC_MAC_ADDR
dovado,tiny-ac) LAN_MAC_ADDR + WAN_MAC_ADDR
edimax,ra21s) wanaddr
edimax,rg21s) wanaddr
elecom,wrc-2533ghbk-i) wanaddr
elecom,wrc-2533ghbk2-t) wanaddr
engenius,ecb1200) athaddr
engenius,ecb1750) athaddr
engenius,epg5000) wanaddr
engenius,epg600) wanaddr
engenius,esr1200) wanaddr
engenius,esr1750) wanaddr
engenius,esr600) wanaddr
engenius,esr600h) wanaddr
engenius,esr900) wanaddr
enterasys,ws-ap3705i) RADIOADDR0 + RADIOADDR1
iodata,wn-ac1167dgr) wanaddr
iodata,wn-ac1167gr) wanaddr
iodata,wn-ac1600dgr) wanaddr
iodata,wn-ac1600dgr2) wanaddr
iodata,wn-ac733gr3) wanaddr
iodata,wn-ag300dgr) wanaddr
iodata,wnpr2600g) wanaddr
moxa,awk-1137c) mac_addr
netgear,wax220) mac
netgear,wndap620) baseMAC
netgear,wndap660) baseMAC
ocedo,panda) wmac1 + wmac2
sitecom,wlr-7100) wanaddr
sitecom,wlr-8100) wanaddr

 .../devicetree/bindings/nvmem/u-boot,env.yaml | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 0006f022d0af..68214b96f5c9 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -67,6 +67,34 @@ properties:
         description: The first argument is a MAC address offset.
         const: 1
 
+patternProperties:
+  ".*":
+    allOf:
+      - if:
+          type: object
+        then:
+          properties:
+            compatible:
+              enum:
+                - mac
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: mac
+        then:
+          description:
+            Ethernet interfaces base MAC address.
+
+          properties:
+            compatible: true
+
+            "#nvmem-cell-cells":
+              description: The first argument is a MAC address offset.
+              const: 1
+
+          additionalProperties: false
+
 additionalProperties: false
 
 examples:
@@ -90,6 +118,11 @@ examples:
             mac: ethaddr {
                 #nvmem-cell-cells = <1>;
             };
+
+            wanaddr {
+                compatible = "mac";
+                #nvmem-cell-cells = <1>;
+            };
         };
     };
   - |
-- 
2.35.3

