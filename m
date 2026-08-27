Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D539C61DCB
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F499406E7;
	Thu, 27 Aug 2026 07:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRoqCIKUsDO1; Thu, 27 Aug 2026 07:35:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816136;
	bh=2YR7n6eCnyK6CnMToBaNVOibQthdG404VcK614EhyhY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MqYWXdwExuRRrhuxZ823pVhYflVUMTqtNyoZFanz8XXo3SfwgGu7xTd8Z6PyVU6mT
	 SuxMqDdmvAehAro1O3QolMUFJt//iWHeMwFXKI4uBe6i5SJTz5taACqDsfW/rPGni8
	 5XQtdAXgYdjD2qSzSpY0+8zEvmrAWT8EHzalExGFXKeouNVQido1n3L2FyHGn7GUWr
	 NRAhUGRuo5GH0juRRb58ik2j8YgfLSC42A2HR33bDz79St/Xq+UjnyV69rxgfQuzw7
	 X2K3ffeHfjOCYPFmwq6AVOnNLxSekXY68zOw5rXiLWBbTkQO07QLFh6NvT00qFsIG3
	 Il9ObC8XHtoTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5EAD406C3;
	Thu, 27 Aug 2026 07:35:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3183E39E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1261D6079D
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5r5nIOnlP1JH for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=E5w1KrI2
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C89E6077B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:29 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so415180f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787816128; x=1788420928;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2YR7n6eCnyK6CnMToBaNVOibQthdG404VcK614EhyhY=;
 b=E5w1KrI2PGnKTnMstR+YH+KQk3ZU9FqsJS4AmIO3VxNpBW4OAZXNOxJ84xw7pVGxJO
 wVaI6y/AdXEq9rK3Is+fLkOZUIZcSOJJ45KvVo8xijoJKI9MznB81yy3IKEbvgubryOG
 NC/dw4FvvCdpl0UTbrEtmCK9l0kajw+ggfVr8/h8HcRcTBzrSL84lkgy6DUE742y3OUJ
 rmpUwn30tyBRh6/aGKq0qbiL6a97Vf2lCanwIueujBBF98+NzUJBpdqYwhAhT1tWY0PU
 hoSmCR3gnPHm0IpgpsjGj2l9Zcjji4CALvjqvX1cV+W+nrMlHhEGUy5i5qKz7Zdzkkfb
 fqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816128; x=1788420928;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2YR7n6eCnyK6CnMToBaNVOibQthdG404VcK614EhyhY=;
 b=KDFhOQNpu+vRTV/tqAoEY/FkRa/f7Xo08EulsxaXv4cAhHhFeTOf8+PYTzdalRp+z6
 Tm3u0UgM37TjC4mRkwF94CxmILidx7GRqbaRHqAs8ksuWniaNGKPdUGBSSyWnJhCYZcb
 LPg4ZHpffNM5Txgpc7jMwlWLL1WEOcAwoZLct5vCJ6U6F0NpXA7v8Yf1p7ISNWjJ+o9Q
 5MLsVHTemLEjKzfhrG021uKMl1q8Wl3O2nlr6TUO8DYtrdHRHLDBzBVZJwbO/JG3ZmK+
 L65dtmQ9WjEVAeHE9iPI6KGGz4HNksTJUQQngJIUnTnHieqM5hBh9bQy0mRyxSGT1DMX
 u/AA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqU18FMttlSLpYL2dDs0Qm19+dA9igBOGR61l++CmAjKTE/eQ09J/Z9jwSp5/vozwMOy83dBW8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nujcolnBrMdSNQjIKbCgAcxkoXP0aFjHH1+VEYO7OIeURG7l8R
 uLr5XjyceJTzPmbek3GNpQL0Ph2VKloiwN+vJMwf1qe8QvyE/briOJ+05cUvdh3u57g=
X-Gm-Gg: AR+sD12AviA+ev7F8jb+BqHV1qQ26V1DhOCC/mNc+7uJb2o9f7mQJijZn8FEySZaPit
 kYvZtjDiFTof6y3LPDnejI+X8dNj0oi/+997KTsP6MikwXnuDHEI6UVKNEXhE33j0Gf3pJUlIoW
 /P7EcFB/PC/7uCFY6E2T6itekqrGLoFSx/Wtn62BIQ2ojqftjbrx5Wa0vqImnCFf6mlDTqFXPFX
 2Jg6mVJScPuf58ck4kAi+j7AdkJqLRqTlV5TPSIFANib+54TmyQ36MJ7e+Ydf0Tvd9Yj1gqV7Di
 F+WB2xp6UW/l4pU84uRxj8OhkGc6S7Cahc9/CqiYjbVo1wCq2xTAokhQ8+5I7XPqmeChXDgmrjN
 tZgqmuwgBoHEgEYIkZ0Z55HLRjU/YLJn6Eg+l3m4M1nGk3KXNwdU78JjLhp1vgsgWLo2Uz1aupz
 JYyEtmhNiZcGoD9KnRQo3PjrbxMqAJBkbs7e+4AP0ObFh/7+SnWhYPoHErOZX1G5vwDIhNyLSUk
 dokoM01DethKE0EcGewIv2ekUS7bu4FNJ0AD65c7yKJevk9aAht8EQzE6/6N+C14l3P6BFua4IC
 aDQb937WCw==
X-Received: by 2002:a05:6000:4a13:b0:481:4697:8808 with SMTP id
 ffacd0b85a97d-482e26dae98mr18187399f8f.22.1787816127750; 
 Thu, 27 Aug 2026 00:35:27 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6788666f8f.13.2026.08.27.00.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:35:27 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 27 Aug 2026 09:35:02 +0200
Subject: [PATCH v5 5/6] arm: dts: mediatek: emit the Genio 510 and 700
 BootROM payload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-ccaione-upstream-mt8390-spl-v5-5-81d04e3ab785@baylibre.com>
References: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
In-Reply-To: <20260827-ccaione-upstream-mt8390-spl-v5-0-81d04e3ab785@baylibre.com>
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
 Alexey Charkov <alchark@gmail.com>, 
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

MediaTek secure-boot tooling signs the raw DDR-loader and SPL payload
before adding the BootROM headers. Signing mtk-boot.bin would instead
sign an image that already carries the unsigned headers.

Have binman emit the existing payload section as mtk-boot-payload.bin.
This keeps the fixed DDR-loader and SPL layout in one description and
does not change mtk-boot.bin.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
index 8fdafbd750d..1d51210ec7d 100644
--- a/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
+++ b/arch/arm/dts/mtk-genio-mtk-boot-binman-u-boot.dtsi
@@ -18,6 +18,7 @@
 			       "-n", CONFIG_MTK_BROM_HEADER_INFO;
 
 			section {
+				filename = "mtk-boot-payload.bin";
 				pad-byte = <0>;
 #include "mtk-genio-loader-spl-binman-u-boot.dtsi"
 			};

-- 
2.55.0

