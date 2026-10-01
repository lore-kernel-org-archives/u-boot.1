Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D482CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:27:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38F3D40CE1;
	Thu,  1 Oct 2026 16:27:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fw1IqVnQ1zfd; Thu,  1 Oct 2026 16:27:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 618CD40CC4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872028;
	b=lExwTsrbUeH5m+kLiLpPV9j3F4r0Sg8NjKolTkPzgyj2wyLwKWVQP1hi+nB6ZUjqFJiE
	 4/3V/I8D3qbZ42al2J5h/2zASkc3G03REaoYJmN5jzFB9GzJoc6diRWAdl4M31mKZEmLx
	 7efCNmEdjLlz2bivuETdSwk/sTIKOWvSnI5vuolemx2A/Eh0CUlpCTFFifU2qg74vk5d5
	 Bvdht3uPOrbr6au5Oqra/DALRIffzSm6HGxEXbFpLFAPIoFvuv4qc+K/kfqxmfr7AU7t1
	 soEPu0Q5eOUUsp+7F6qtTtTrWQHg8/KM1sEOmAfhPxim7binpiMFzPNP398ktKVCruQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872028;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
	b=BmV2ZmlCWyYwpd+P1/PiYyCK9j27LxH7qNZSGEIzrpmAYFZlNNLbhbC5vjhurIwPtM65
	 +/O6oi49Zx8OOmvuxYkJMTO5Oa3aMLu9svopzKnNSB92Wrybujc4Ea5W1ukMx+QV+b9u4
	 AtTBx8RUXwQLDD4dZXdRqCFAs0XWzMXE5tkKCyhdYyrXQNhSlvO7ydCOBj5BGIajddTfc
	 GnbpE6Hr+eZ0XS09fCKhQaI1P0QXhSN+LTaMqLvXEb6nBU0jwT/ypnYVRYfdJaO71K1hI
	 PWFNZbvB6u+KyhBFQDuG6POjoUhKsNKfVdTleTKCON74kSYWHJ63BDZgGif/P+C4A6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872028;
	bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNYgxjNcG68w8NVOqhH83RijsCQZ3kh7EX4JYS5LiA16L0qYVr2Z9QtqcjFuzdcDS
	 QX365uidKJHAPY6VvKv+1L7UqlDJVtXG0MBQEIKV025+n5/5TPeQxQq0lmTbK8gpIG
	 cTrF8Ao7o/1MtamjwJxyVnmxDgvaTRPi7PxuxR+KVf1c0YgN0sK2rrGbLJP5jKbIsa
	 CV1l60Yy9WJkxb5Tcalvm7ZoXvK4xGD5gb3g0+vOnk55FgF/pS3spM/lhlby+mxX/c
	 ktj3Wexdl3kmD5QfbcgRjcuHvQNCryWESrJWaLUD0Uh9dbAnpcspSIfJ/gRQp+uqVZ
	 Rs7yqLIRnWW+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 618CD40CC4;
	Thu,  1 Oct 2026 16:27:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC48532A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA08D40185
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sghFOYbvfOKW for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:27:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A0C6240098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872026;
 b=iYuQk1uFy/0TQbWRIqqAWcw9zuJdmQ2IjTkGRIHpRVOz023iGvG1MRxphT7PaKOJnZBA
 b2Pfkeod6F43UfsBkUgMuwKr6mVOxoADthe0ACNtVhMxD2i6aIZ60lYGAdTqYMOH9wloT
 AoSJ0BWkFLJEco3UD+iBBXTiz/vazA/75l+v6RYdN0qnj3P5j+4WRpWtip7HrcPjoenlK
 WM9yJMbeYLkixfofZQVimFmCYvPQ1cuXyPIIPYhhByX8ytximOjWjZ6cIt5ifDrM1/c9U
 zf7a9FNkZCFrHz2/vi1X8sGLBfB/CfaVbRvXPdFiPUAg5K4GYiEHci7a+RPZbtDaXqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872026;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
 bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
 b=HjJg2VlDTr6rYnJVabYH7pl1wf7kuNTqKUg7stbRxBOaQ/dhnRNfNkNDg6Fd3zKCKpJE
 B0bxw6qW7087wgY7eyXys5NIMR9+uJqugHXnI0b/KKQeduXnYltLejimam9bWUXNAeAnj
 uaRNONRvMiHxIzqJ/nF/uP7ITpoln2aicPMv1rYKEV/49yU6uZiinNd0Xf90K+yt8ktve
 Hoem3m0tR8MpB4Dj3DnO+0Evgr9CBRcDiH/cRrtrH4ejPI+t0I+QNfICqnvMsGXKgY09c
 qDqdxslSc/QBCnhMZBQ1jFR9a4ayyzPZLwA3p02XsEHsGNzNhB5bCadv1KqnJSwB/Vg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=JHqfwsYg; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=JHqfwsYg
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0C6240098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:27:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 31FC14E413B2;
 Thu,  1 Oct 2026 16:27:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F38A960343;
 Thu,  1 Oct 2026 16:27:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2AFFC10328310; 
 Thu,  1 Oct 2026 18:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xa9XP1pXZrI/hq56WRDHgO5nH8nW5oPGPimbz7pYOng=;
 b=JHqfwsYgMcMDd/OtQzlzQ3qUrgPlWlE1j/6GQ/k8eYfqG6rjz/tnW+KvyUib/wNegT/PIo
 ijZ6D9pm4AaDj+kpY8zNp9mMnILcqo5CrQVnv2gQXsx+GN+GgZFsa4yOoXFBbCncNhodF/
 /GVYoMAVrzzX7pquJ8CWaXpl5lahetywTw5UmZj7dFsmRNu9x4b56mE8K4NuIBBRAKcERr
 EWNlqQT0nrCcdGIN30xq8elpgLsddOQ4IEUxljV5igbptJHEOSpaHSLJb8eX4lq/BrJl01
 JroV5LApnOybJjMMW5fsi9V+zcVlDILE1qhBdosFh76+aXxTXm0caU1qnI5Seg==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Date: Thu, 01 Oct 2026 18:26:21 +0200
Subject: [PATCH v5 4/9] imx93-u-boot: wrap SPL and U-Boot nodes in a CST
 node if AHAB_BOOT enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-imx93-secureboot-v5-4-d97dea41bd1f@bootlin.com>
References: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
In-Reply-To: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2229;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=ZkEmdyR3F1pUrAFHik1ktGcW3RljQLHrC1VaN9f6v+g=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom4Q6zYDGsV4KKDI1xl59JXJYOcKKvf+wkIA
 pDbEYOWlSaJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JuAAKCRArAF6gG1qP
 AyB3D/0TvwFWmsdiefwjN8wuWy2V0zeqSG43OAB2I5VKAD8a/QbJT+85gHCwZsP4ZKk6n/CrvBQ
 vTlB84SfUXxFfadvXYaAesi1KhhnFxXd79pEjkbhIVxk7PEfGI9HY3q8JurVS8GV6XLxvgSbFHT
 mgABOF4SFz5LbWbWWuIzBUwmPGAqO4QfaJC7hSDTnXZtu//vRWKPPtYjxuQguDFPGtc168ws50B
 WeBxNjmdEPxlIPfu0JiK+1tklK3P9w38IUTXQX0wIkC6ckWzMrynD0IekQDV9V6BopgfWyoH1s/
 BZy/NPe5j3hGHM9AdpNrmaUbsGq/nTH3LWpcigedfq80N4jPYcMui3AHbhEvrr4L6e7SNarSntZ
 /MdM2sNZlPRz2L9zMjYlrRYxzZZ4r2hx+8+imJhvm40HyT8HBWI8+o99eQcwK7evUPi3bMrvXCu
 GhXq2WnNK8mqcZSi6z+u087DhYNn3MHZclMQxTu5b8VsTmbJqHhliTREX/DqTrAvMLkkbgWOoGK
 l3iP3CIq0W/IxwpX7M6Yxc+IKjmRPs3Qo+N4kdFHW8FuEUNKqUO+xyTpxGb6JsInOsEgflJ1IES
 gfsJJN+BDkIQKDpyo9pjZaqS+3gig90DijL1jIMiotJmL1mSiPVFzdg/+NucZQSpq2JM+7J0kfb
 vh9d+62rMkxhgMg==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
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

When CONFIG_AHAB_BOOT is enabled, wrap the SPL and U-Boot binman nodes in
a CST node so that binman signs them automatically.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 54 +++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index bd970c955cf..569b3ef5d9c 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -47,32 +47,48 @@
 			filename = "flash.bin";
 			pad-byte = <0x00>;
 
-			spl {
-				type = "nxp-imx9image";
-				cfg-path = "spl/u-boot-spl.cfgout";
+#ifdef CONFIG_AHAB_BOOT
+			nxp-imx93cst@0 {
+				filename = "spl.signed.bin";
 				args;
-
-				boot-from = "sd";
-				soc-type = "IMX9";
-				append = "mx93a1-ahab-container.img";
-				container;
-				image = "a55", "u-boot-spl-ddr.bin", "0x2049A000";
+#endif
+				spl {
+					type = "nxp-imx9image";
+					cfg-path = "spl/u-boot-spl.cfgout";
+					args;
+
+					boot-from = "sd";
+					soc-type = "IMX9";
+					append = "mx93a1-ahab-container.img";
+					container;
+					image = "a55", "u-boot-spl-ddr.bin", "0x2049A000";
+				};
+#ifdef CONFIG_AHAB_BOOT
 			};
+#endif
 
-			u-boot {
-				type = "nxp-imx9image";
-				cfg-path = "u-boot-container.cfgout";
+#ifdef CONFIG_AHAB_BOOT
+			nxp-imx93cst@1 {
+				filename = "u-boot-container.signed.bin";
 				args;
-
-				boot-from = "sd";
-				soc-type = "IMX9";
-				container;
-				image0 = "a55", "bl31.bin", "0x204E0000";
-				image1 = "a55", "u-boot.bin", "0x80200000";
+#endif
+				u-boot {
+					type = "nxp-imx9image";
+					cfg-path = "u-boot-container.cfgout";
+					args;
+
+					boot-from = "sd";
+					soc-type = "IMX9";
+					container;
+					image0 = "a55", "bl31.bin", "0x204E0000";
+					image1 = "a55", "u-boot.bin", "0x80200000";
 #if defined(CONFIG_OPTEE)
-				image2 = "a55", "tee.bin", "0x96000000";
+					image2 = "a55", "tee.bin", "0x96000000";
 #endif
+				};
+#ifdef CONFIG_AHAB_BOOT
 			};
+#endif
 		};
 	};
 };

-- 
2.55.0

