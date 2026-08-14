Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE46C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DC4B40F30;
	Fri, 14 Aug 2026 14:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceSXeWHNqwyJ; Fri, 14 Aug 2026 14:48:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 433DC40F44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718902;
	bh=KHBc3UqLgsLmsFw8vhHu3LjpN8GrtbpGg9l9mVWrk80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PbKA7OyPbXcVCYG3fUWQ4aVsb8rmqdmH2iLPr+KTVMJVTNtR+N4Lb2i2j5UwtC01r
	 LQARhjE8hcTCSBQ+xBGWO+HdC/dvBQrUIqwpdZbroEsyberRqNdrthHWup9huxSPuo
	 xIPxSfJZFUmJuyCq3Klf/h9mfA4NYkeoPW4fDGqlfcNNabadjghLX2xIJz7kyKUwiz
	 MlGCbaZnALtFJuD8ZE5kLWsW28LGYVZeO3jdurtY7Xc2QuTKOiGPrWl4rwNZe3imaU
	 fSB9ZCxkSyMOJpX2CfCbI8CIi8EDMQ0+svcZQwRS1POK3/tnSSRE9C1PVowcsxXemB
	 ZzPfnlIr9lAwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 433DC40F44;
	Fri, 14 Aug 2026 14:48:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EAF3B3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD4D660866
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tEuK5YtOjiO8 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 81C5A607EC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81C5A607EC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CXytmLMs
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81C5A607EC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:15 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so393356766b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786718894; x=1787323694;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KHBc3UqLgsLmsFw8vhHu3LjpN8GrtbpGg9l9mVWrk80=;
 b=CXytmLMsrpoFrGyuGVQnxUUnttUrD0rLGv/mZTmp+MrzyPwN0kRh9EtN2dod1+dBYL
 cT3+onFXIUoam3t0gBo8IzZ12hnHEjrkQ54ssj4oe5RLBTSAzdNoDFxJ8TQjwLCv8aUh
 8Xk0YuoZ6WqFm3vP5D4g+9dW5D70+X70Mq1ik9SVuTxKmRvxHD1896IYGR5WtlfHPY/Z
 SCmoseyie9o5b6wLGZrRKU7W3vAeesOFSpw28j3JlFtf9XTBVBoCDKbiuNaK4rE5Fu+e
 DUbWRhZ8oVAeoZXoEyTXeNiQlt697+vPYYrJR8am8Orpe4RfJ3nvGRPWErIr/4twcwfg
 cdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786718894; x=1787323694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KHBc3UqLgsLmsFw8vhHu3LjpN8GrtbpGg9l9mVWrk80=;
 b=p0qV6q4TPqDNdXz/bGihgtoiFxkmbv5AQWDkFnXA+1yl6nrIwLy3dPkUxadeII7tsb
 X8oskOsgSpfndjQO3867HU3OQQjtvhzaFoZDAhdH0jy6v7f968Tl2py/DGfdx2px26uT
 TVJpdPOT9QxNEUXbkZmuBtiZfpujEEnbj+SMmQdhCqu2A/bh5OJTzG2g1snUVhyIAHX1
 sXN+fxbCVAGnQ/8KESKFj8DN6tTkmrxGljCxC3u133lNeFVuFNEcjI/GfsWA/7qvuhHJ
 u6y/d3KzbJ91XBMWFAVZ+G7MhqJ+axobXWI1F6bGfX2+vvZQzEde+l7UP904zT/WXEfc
 FZOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsuYykQAArioSGR/ZgFANYlyJsyvFZf2Dz/rdwYlw1kAtOaPj+PugABA4Ekh0LFUmjqZhcQUU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwvhSoA96RSWI2Ao7yfBWgMxCFLZVEbvGP8NslmHnKmF/wxpKX4
 jSM3oHY1I+rFpP+frHydjlWvSgryaZxc2DVQnCEDzv/KpJtDOLqAgRSM81r0gsK1rarizAAnxaH
 2sgP6kv5TAA==
X-Gm-Gg: AR+sD10Zfc+60/Opuw1jEoXfZ7//1fu7ui5rIo4Mm1F2tiN2zDpOxSVPYPYVnqR8lXO
 XhGag8gtf3Bbha8fDDbHr5pLaA0ASH5omoEzswhg/rFFQ/k5n8zkdFinL9PS+mt2JsaQujnB0bY
 DTpsf6jXJVcsf37/eq345pJry+eXTgNtacGPdeXsplv+m2f1b2gCei/TM8IbRI7XosOZWwiGnoU
 sVJ1jPDoHAFR5B6qijIfOgDltUmIz9z0zTI8JzXDTRAqG5cQ8lnrlXnwURQ4uYQL3ISj2RFQChP
 oWQhzE2AetFBC+Lg8s17awo1d6XshAnjZetu3f5eIneWTpCjQmX0HWEC536WdxRkDQtKQdfQ0Dr
 iSXTKGpcqoz2XYqZzvHDDDFjF/j/ZlKbZIDnkp3x7lDlfxFS4qM9QWsVr+MMt8+92UC8YG52M75
 82WSQg8GztbgWRSGWuqw/ZeIilM86E7LeKi3tgFzwM/PJpO1ij4ftHbNZm55SlXYu/ObHueBayw
 WJbocQrQW9pNzeU6JjxlKLkk6hoUT6lO7AGldtmGLTw5cwqKYxbQY6vgGA=
X-Received: by 2002:a17:907:c80e:b0:c1f:6539:3cac with SMTP id
 a640c23a62f3a-c212aae58a3mr299872466b.12.1786718893664; 
 Fri, 14 Aug 2026 07:48:13 -0700 (PDT)
Received: from macbook.tail959722.ts.net (static-226232.rol.raiffeisen.net.
 [195.254.226.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d9fcsm114992666b.34.2026.08.14.07.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:48:13 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 14 Aug 2026 16:47:55 +0200
Subject: [PATCH v4 5/6] arm: dts: mediatek: emit the Genio 510 and 700
 BootROM payload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-ccaione-upstream-mt8390-spl-v4-5-f4f92978a79e@baylibre.com>
References: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
In-Reply-To: <20260814-ccaione-upstream-mt8390-spl-v4-0-f4f92978a79e@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
X-Mailer: b4 0.16.0
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

MediaTek secure-boot tooling signs the raw DDR-loader and SPL payload
before adding the BootROM headers. Signing mtk-boot.bin would instead
sign an image that already carries the unsigned headers.

Have binman emit the existing payload section as mtk-boot-payload.bin.
This keeps the fixed DDR-loader and SPL layout in one description and
does not change mtk-boot.bin.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
index 16ce9cacb66..396bd3d143a 100644
--- a/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman.dtsi
@@ -18,6 +18,7 @@
 			       "-n", "media=emmc;arm64=1";
 
 			section {
+				filename = "mtk-boot-payload.bin";
 				pad-byte = <0>;
 #include "mtk-genio-loader-spl-binman.dtsi"
 			};

-- 
2.55.0

