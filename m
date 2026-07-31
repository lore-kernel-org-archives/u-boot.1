Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D052C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 15:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58C9360896;
	Fri, 31 Jul 2026 15:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0zrQA06Ii4i; Fri, 31 Jul 2026 15:23:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5490460816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785511398;
	bh=n/TFQhIsPTbqHAxlAwphPQLc9P9CGQ/+wupk69VqsD8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OXomfWRzNHLOxBBK7yqi+UfrXLA6Wmr/lYjK6MVp7Ppgy0JhZZTDn4U8FEDFKr9ev
	 FV/STx96QZ/UewedAzWTtvk/2dOdTy7kOdbM1XEAXwRkkeapM2lwAVSuBbOqsEVWt/
	 dlviNHeLzOTgAmRcJlIczlXWZftaNq5SkfNZSyIwfvqV7PV6jj7lGGbf+vlQwmQETz
	 Xk34mXQCaDY/+o9X6aQBgwTCFHn/a9b+y0mZ3li+vh1L+SM4DwRP0ZjqMZTDUAsAVd
	 0Wg/WHIvdQ8IU3fE6K49UsnYkdEUIx9Yz2XAxgJs912oGcM6B55YfTyErO0z/G2aSU
	 6KGrEIWHUrncQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5490460816;
	Fri, 31 Jul 2026 15:23:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9263269
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90033808AF
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:23:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7VS7WwrBOX8 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 15:23:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9EEC9808C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9EEC9808C0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9EEC9808C0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 15:23:16 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15f47e6297so125652966b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785511395; x=1786116195;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=n/TFQhIsPTbqHAxlAwphPQLc9P9CGQ/+wupk69VqsD8=;
 b=X54H5JWGjELI+OG45kEwx0l+bYWm85AQ3zoZ+baoJE+FzAaFDwEQd7YBJtxeLKgi0t
 GNo75zHNWV8jap9HQYmt/vqgm6v+VxKNvgaGmxEwG4By8OTXhNirJMPH5nU+0yUw0EF0
 JzyxyVm0UWNK45MrWPnhLyujCdB20TOgrGRoxTAXM2aSQN0pvdJfqUFOS65dMiSkwllz
 lVtWSVNqm8Nq/s78EmnSw9uKTXhaoWvs5ncshWayqzHH32Pjb1XER6Ock9efjIxdH8Mk
 4VDhBhlD0wvrzFoAj5Ex93UKVsXGEjnK5DCIT9r4ZgjgX7msxQy81EbqrFwlVNDiIRkf
 NVNQ==
X-Gm-Message-State: AOJu0Ywfd6K8XUixZyppYKuwspRcOGTDnJ0aTssb8jjeEFtTnQ2fd0ar
 UyITBEqbZ/1YZmUQWafoliKimAiLscLtbrANZ5V79S1Rdcw+Ncwm/JCM
X-Gm-Gg: AR+sD12cgmpoV2N4o8gZgRhYUlfMvcx1W/X0HORwz8p302jvY2cVgPbWIdXEWk5vhAj
 gYW+FKF9xngUByqtaH75WBwqHpXnWeSNB1cXqSxFclgQhZXhix8K82txOacd80LBYQC8fCKqgku
 ywWg2zeyrtBq7AKssC09l38MO4z77yqj9VUguGEwdD2OckqAncfDWGIWH9FSa6KTfBGBkNJaQUd
 2Lm3kmN+VhHjnraHAtvjgihb1QipdiqgCnwO447bQ2zv6o+is25eR3cbbbF9YhV5fT4nnV99tzv
 4/pKHa5X5b02WyfAoFa30pxiWGhwaEN6UNcX5wppVIY896C9o1dLaNHjfI0HhU0p5xNOJQH1sFH
 x9hWC76fK/E2l3MeM/aZYs0VIzTVUlNORO638E/sj4Gacx8P+fFBIvglZCtu62LxCtZRYFvG/3E
 9aBk68LRHmGNg2qgR+YnfrwMu1G5bmwnYdfL4HvJeoWgl504ti+3r0Wq6e2EOofmJ5a/DKuwirE
 43Q+atjzK6fHeQZNS9QN9+TIVzNveG9a1krxYeasEHyQSU5/4eG9dc7EUuNf9yyV8rg+OCBgGBV
 jyWJvCKM99eeLeuPpmV9qaFzGc8GKT47XpfjnA0=
X-Received: by 2002:a17:907:1b28:b0:c1c:6f0c:86f3 with SMTP id
 a640c23a62f3a-c1fe7ea7171mr4526666b.7.1785511394232; 
 Fri, 31 Jul 2026 08:23:14 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd3c90ec0sm218012966b.15.2026.07.31.08.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 08:23:13 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 31 Jul 2026 17:23:07 +0200
Subject: [PATCH] toradex: tdx-cfg-block: Add Aquila iMX95 0243 PID4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-add-0243-aquila-imx95-v1-1-dd0a3e609e82@toradex.com>
X-B4-Tracking: v=1; b=H4sIANq9bGoC/yXMQQ6DIBBA0auYWXcSRJTQqzQuQEYd09oKakyMd
 xfr8i3+3yFSYIrwzHYItHLk75iQPzJoejt2hOyTQQpZCV0ItN6jkKpAOy38tsifzZTojNS50co
 7UpDaX6CWt//3Vd+Oixuoma8ZHMcJaCNPu3kAAAA=
X-Change-ID: 20260730-add-0243-aquila-imx95-b9271974dbe4
To: u-boot@lists.u-boot-project.org
Cc: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785511394; x=1786116194;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n/TFQhIsPTbqHAxlAwphPQLc9P9CGQ/+wupk69VqsD8=;
 b=aQR3CZrI0gIdUScX0SyozSIAxlOvFgl54oZ2MgzNFVkWIG8+04zh7ZH+0cANXo+uyO
 Y6rEhDrRPZy1vFO4jtjrONqUNmjjz1npIp9CK0cfTkogr3RetJ8AXwcxRk0bCSCrOKrU
 zRfQGnXrGTEhx5WaKKXk9d4IA3oHY+hBss4UhDvE5y7fmumBgw7vk+772bqs1qrSI6Jo
 QDMBWiTnUTHjk2xeQoc+qyLDnggDPXb7YV6W/kKikJndwFJ+TAEqOK3tXPvY6mp5Ppxf
 5mAK8gNV351fbBjLD0/Fv8pe8iU3F/G4L7+mwtXCkFyWOth+vfLVU5wYTdJW/K2NMvFw
 oNiA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=aQR3CZrI
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Franz Schnyder <franz.schnyder@toradex.com>

Add the new 0243 PID4 to config block handling:

- 0243 Aquila iMX95 Hexa 8GB IT

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
This patch adds the new 0243 PID4 to the common config block handling.

This change depends on the patch series linked below, and should be 
applied afterwards.

- https://lore.kernel.org/all/20260710143258.285091-9-ivitro@gmail.com/#t
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index 1998411ebde..0b1798dc812 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -201,6 +201,7 @@ const struct toradex_som toradex_modules[] = {
 	{ VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,      "Verdin iMX8M Mini Quad 2GB WB IT",     TARGET_IS_ENABLED(VERDIN_IMX8MM)        },
 	{ SMARC_IMX8MPQ_4GB_WB_IT_64G,           "SMARC iMX8M Plus Quad 4GB WB IT",      TARGET_IS_ENABLED(TORADEX_SMARC_IMX8MP) },
 	{ VERDIN_AM62D_1G_WIFI_BT_ET,            "Verdin AM62 Dual 1GB WB ET",           TARGET_IS_ENABLED(VERDIN_AM62_A53)      },
+	{ AQUILA_IMX95_HEXA_8GB_IT,              "Aquila iMX95 Hexa 8GB IT",             TARGET_IS_ENABLED(AQUILA_IMX95)         },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index bf6a0861378..32305c61c83 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -164,6 +164,7 @@ enum {
 	VERDIN_IMX8MMQ_2G_WIFI_BT_IT_64G,
 	SMARC_IMX8MPQ_4GB_WB_IT_64G, /* 240 */
 	VERDIN_AM62D_1G_WIFI_BT_ET = 242,
+	AQUILA_IMX95_HEXA_8GB_IT,
 };
 
 enum {

---
base-commit: fcb76c8913f29c6bdfd5853911904a1a603e1128
change-id: 20260730-add-0243-aquila-imx95-b9271974dbe4

Best regards,
--  
Franz Schnyder <franz.schnyder@toradex.com>

