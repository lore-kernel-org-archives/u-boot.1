Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE57606A331
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QcP7xi3E;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kQ1NfIxs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADFE681776;
	Fri, 20 Nov 2026 22:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_ItdlxYWnN5; Fri, 20 Nov 2026 22:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B716819ED
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212346;
	b=rl1CrTf6M1KQql3FKS4U+hrn4G4YrPsFkzyZZuKAdQ2FEwpl5Q0Ef+3vMGwLbEVr3/Q3
	 JTRy95ucfRiPajt4/EA1qN2CfLhFsz6mD1yGli/UstQBVol6J+7ezQcTz8ViL3ojJ3Til
	 cIIBFhqKqDsh8GiD8o+sdt3/VYxypgqcOrdGPWTGjPh7UgoYqEz8Q8QpXl2pMIDDRSzx3
	 2StHG/tJ/g4SHZ9Ks0r0nFYFoT4+G2OA7L2o5LUgphrzNW64JnxYRx1KPZ3Ps1niCPGKL
	 4CAZQzQXy8lhuW4E1K/Prap0WgmXUIPESfqknKU3zRoO/Yo4Z6kby0JKHhpBuP9JSqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Zs3VDt4w02NToxWKcB1EuAyFcqm8gFmKeoHfZKjiGys=;
	b=dcy6mZS786ecJPO1dc7PXFF1+EO36Sut8PbR3+QDql81xKD68YuutnzsKg8IbvhwKF4F
	 t781X/L1AruNVne/h26yBneGn6ELqbYNn1A3zA4+6B/ib+DeXPlwZgwKsNeKrj+hGlTz6
	 Hz47JzvecYLJSrGGqCNalIq/lDgixpqlW0OPy7TD0KtDCQQ+CcC7Ge3zffxS/ioMSxW5S
	 /Cd33IitgEQuaFR+TLGsBrD2MzlRrmG3O6YvGQhnr9zE/Qm0nuriyCWsWqOg/euJFrD9F
	 Qt7qsBRYBTbcqI6Yc6ZnbF/Pm3AWl4lST7ObX5FnHGYxZPU4Kov6D8S2zedIbjAHBgQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212346;
	bh=Zs3VDt4w02NToxWKcB1EuAyFcqm8gFmKeoHfZKjiGys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QcP7xi3EtDikxKQS0E1ns2Bi/52kYdrXZaz3TjKAY0DyTwy4YrreQ7wiVx2P6418e
	 xVoDecsAI221vDPRHDE/KWBKU+R3d0wsh/Sznj2jIYrjgXAMfD0AUcEOhZvqouQklW
	 Tk7gESmSQAJtv8LQiJcplWdLGt0kCiydCnfTlGiwVcHWaUbqiSNGLl6z2pG7qUaE1h
	 UjdqqLxnzBzYEYwvHWTtS56GA7xkMk3iE6304RFQwobBWDNo5qrFcKM7fyDjkUL2xJ
	 7AmvwEnaq2h/KbIVa2i6V77bBnfPBnMGnP7Vg2g8KkgXLHWj+1M2SvaQlV1hflHdI8
	 lN80nwHWOH5Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B716819ED;
	Fri, 20 Nov 2026 22:05:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB2C4310
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 917F240208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ElS0adQIUf25 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BFE0940176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kQ1NfIxs
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFE0940176
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:32 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-499f20c7054so781158fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212331; x=1795817131;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zs3VDt4w02NToxWKcB1EuAyFcqm8gFmKeoHfZKjiGys=;
 b=kQ1NfIxspwQ8BmHhbYCfmtNKyYKJXrwnSRBPo8ZVyCfj0mDtaEBh6pPzavPHbYv8ay
 Nv0JLcKNFa+5GPIPjeC4/7GzFXKIBhUW6APgMHzWTkzLOWj9rOe/cWs7mluoOFbfLY7I
 oHG/dobI4zfYvH+M83U9noSA+bEwr0VKjfNMQBGDNEgjG1vqkhwBJunhhjTByBpllxKy
 rPQhLxi7xX2YJNywSGQKZ/Vh5Gs8m1q9wt5XW/qCoUt/BBxv7f5mubiejj7vmQRT4VgF
 NUxG2oZm8TjkqydfgxryVQbq8xl0A00mDv6or75cQtES3mjbv8p8TxVf9c8J6n2g9bs+
 XMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212331; x=1795817131;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zs3VDt4w02NToxWKcB1EuAyFcqm8gFmKeoHfZKjiGys=;
 b=NxAIBgqBNgKg26v5t8NN6aoZAyloxjzdfqQ9NjwUpodcuyrO5dN47EJVJJgUqfiHTh
 kS9mI91lUBJShM/oQHtyTGXo9Sw4nbYb2iFZ1dXUosqNY7W71vKM3f/ep9gpsqVdlG1M
 PLFrvAcW6iPaZluQEKoew459yewI71E2RsZjBoKVHOGshcPG5KsjSL0hP5ciNMkD+VM0
 yzIRIzewkvQZD04KSlNlQQww7vEuh4qKJ1q48WaIe8OYy0ZgjxneDVBcRBbX7sJdUtUZ
 5g7UsVfSeEZA5DycN8iuAy4jSdSwtoZZRCkb2z0qhmv9f4fP3l7wVefdPpzpb+8+bl8v
 Y1+g==
X-Gm-Message-State: APuU4Z+HjsIVVO3DFlptY5WSOF67dnHkEMjF7dn0y8fLeWsz9aWiVQu2
 CdAbpZTxVA4++4rEj2CwwI9gWa7oasynyxZCPh9azaPyPcYL0gj7p7ixi37der/GyuY=
X-Gm-Gg: AZFdTZdoWASJK4X2Og+5tbp8z34VtRq9r7nNorD4S3teqyZSz4yxMfxbGX6lwhybUUf
 SoVLeOVfC/UMqzzkO53h2T/vtz217jfS+ygJtki+O11iHCB+spcCLpuWoTROoYehDYeVsCdTHcF
 4FSc3qHgHYnsw5LBGl0s5pGN1utdf7IxbyHc5lPOFAzNrBM+2fFRel0vDOez7Q9MrMaW328satG
 /fpVCKSOMx50MWaEBvaMSKfsRAowjM7MdiPcBVpUlPyrw1B66KnXeHz6WQMuDxz8LAfIhLoRugj
 PEf9SISC/2yhlE3C3k+t52Bq2ueYq10kMzRAuLPY0r8n3AFeoQNDIOI8oPG9NJtqxwsAq8bk7X/
 UJqWjEp4VoJhUh1gCPmhhu2cr1428op0hUfagFOKUv7ch8gJw76E6hEA0d9/kUw2oY0CZZnhamD
 7Gt0MQxXXaIlQqcmatDmhEqR2F4Xarw3eBIqefMkt6FEq5qe8VjP7Lm4XxEinPw9ciT3Df28N54
 4ktiXzDzOzQhtknoeaTBGKNVRGRhTP2cE2lH+uS5EQTiQNG0envDusNqN6DxXuO1rrEHP+X4gl+
 M6sSBIgyMzWV7YHPYxEUd+ABLjXNto95
X-Received: by 2002:a05:6871:6916:b0:49d:c9c2:b770 with SMTP id
 586e51a60fabf-4bc802e9771mr4332881fac.18.1795212331281; 
 Fri, 20 Nov 2026 14:05:31 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:30 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:50 -0600
Subject: [PATCH v2 09/10] board: mediatek: add a Genio boot images config
 fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-9-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Q/9DYm4fbt4GEjn86ag8ALt6tFQNtGoTRpyBweRmvQk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMQEtj7oMFcWV3xhgRt8qZSwyI+NCmSlqst5+
 1jw4fs89lKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDEBBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A06wH/jwNVBPaMuaZCBUnYXI88pXSwDVZfJhbhNUR3MO
 VlsI5YN0EZD/GxHNt8eoj7NGmygoCne6ckQ0AL+nKWtZD5rxTn7IPfTtddWDX1gMh86Y2O3EabC
 OXKY0P1fdYcxan24vEUAw4A0SdS0jTfQhp2eOY3VykpgwE5yEtzrzNk923bSO46IMl3QY9hm4Wh
 LJufrC8Gf5ayLiUa5+E4u8fXDbMdTlzaOO/oAPoq3YQzjRfq7TBlrRZL/HhP7zaeFCs//ho6MvD
 nW+Rc0uIj0KHr862IxjRitjEn7mzF+0zYBi9IZznw9gDZrwD3Yl32TqqcZxuvm1yewVocWCzfWK
 sSko=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a config fragment that enables building the complete firmware
images for the Genio EVKs, so that it can be given on the make command
line together with the board defconfig, for example:

  make mt8391_genio_720_evk_defconfig genio-boot-images.config

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS              | 2 ++
 board/mediatek/genio-boot-images.config | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 9b600d5d94c..a518c4778dd 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -6,6 +6,7 @@ F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
 F:	arch/arm/dts/mtk-genio-*-binman.dtsi
 F:	arch/arm/dts/mtk-genio-binman.dtsi
+F:	board/mediatek/genio-boot-images.config
 F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
@@ -34,6 +35,7 @@ F:	arch/arm/dts/mt8188-genio-binman.dts
 F:	arch/arm/dts/mt8370*
 F:	arch/arm/dts/mt8390*
 F:	arch/arm/dts/mtk-genio*
+F:	board/mediatek/genio-boot-images.config
 F:	configs/mt8188.config
 F:	configs/mt8370*
 F:	configs/mt8390*
diff --git a/board/mediatek/genio-boot-images.config b/board/mediatek/genio-boot-images.config
new file mode 100644
index 00000000000..4471532c928
--- /dev/null
+++ b/board/mediatek/genio-boot-images.config
@@ -0,0 +1,5 @@
+# Build the complete firmware images for the Genio EVKs with binman.
+# This needs external firmware: see doc/board/mediatek/ for the board.
+# Use with the board defconfig, for example:
+#   make mt8391_genio_720_evk_defconfig genio-boot-images.config
+CONFIG_MTK_GENIO_BOOT_IMAGES=y

-- 
2.53.0

