Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57546C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 14:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1460740BC4;
	Thu, 30 Jul 2026 14:18:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M_mMPvXHyY3W; Thu, 30 Jul 2026 14:18:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5243340B92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785421128;
	bh=QZRb8DGL63yi5HY/urZvNk46QHWtigsOFM8okiV0WuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EYXXILlOxVjcBJ4bAeBsCeT8CFyq62F/miAM4w+tOT/KmroAfBrI2KSMY/F2dvJHL
	 5oti/W9ddyYhGDrELkSkqKtg5KiieJUsf9ck/jdGxywetVsOXw3FtV70dqH42ZJ7fw
	 ufFWur3pejYLJiu4/19ODr0BA+1gSPpb7c/E1k3oU/usY8K6K7xmM/Ed/ZeSCHIdmA
	 K1A5sSAYdy2cMIHUe3jNzzeb4wuiASNNHxmk7+LXbKox5Efve/PsIuCruXc9a+fsCv
	 RriCFMNdtRiyNi6z3Yp3k79UCY6y33kXafbEed3PGQJ7NQ+O39VngaDbGEROBapcuD
	 oc4ucfQwO8APQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5243340B92;
	Thu, 30 Jul 2026 14:18:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E4B969
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8029160896
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNTXEdzT_f7P for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 14:18:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 89E0C60898
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89E0C60898
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89E0C60898
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 14:18:45 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so354012866b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 07:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421123; x=1786025923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZRb8DGL63yi5HY/urZvNk46QHWtigsOFM8okiV0WuM=;
 b=g9mUbdLB2gxOt0zVA1fXaBK3azWT76x7nIdTRWaV7fR6dRz28hnDUhiHPAVEb8O7u9
 7PvaO1AvHhMK0Zqe93A5Y3kKevCfurvHm8fY41yB4wrQmQkVXP0+ZT0AUbwCVCkiVDin
 9QzpDD6XfSAlzePVW1RJYpHV9W+mX4CPOppNeviAkMsVSfcp53FsszO1U3WS+0BpiLq2
 p9dFN8iQWH7fRPItj6ezGFL4V8NeDAp1AfOGsVj/XVw7WhzCZCTV5ziUybwhrDxR61N4
 8G0xhupvOQhf2E8seaM4Ygz73cJEQjaS7Jo5+jcVSnjPkrXRU21XtTM5etO761PokZHQ
 SQgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWG9b1T/oR/tp35V4ncYNTESZBAAu3oTsqOaiQviBOH2AkeekMS/UWQ/1wdFBWpTZkoPP4bLc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yyb/prhCbPbndhuA8OpV+vAyeeqsrrwfRWGoNSpsK9rbnIT8mr+
 n2M23totHLZQUwH0QOjee2s2leJPcVpFs5KXDJ0783uX4fVXc2A3WF2+5UJMTRIGlro=
X-Gm-Gg: AR+sD138yz7lrvvi4K7atlS51iHqNWzTXUzCQS8fMHk63FbPzy/6hAWtoaaWDT/PX+x
 kX99OoV0R18m1QCVkNhXu3HjT8cD6nYWDXu7vYcEtUnSksRBcPePLW3oEFmMdGSCN+SKN+5Ri1s
 6sz57Rjh4NPaj71j+hsSfFq6I2DP/1UtB+ft11M+0n+LIlsyu8R3WKqDh6NtXo4MgHtZtzNqXfa
 A30Ml17iLunIP4UO88JkMZIv3TdmhcgQFt72Nmx9oBx+uIvQAoO0rnmCWkqIlIaO92p+mzeZU32
 8q0Js85CyFlI3UHleIPZIFme+jIXznxbBmeNb8+rZ9HiIy1QWKzzEnUrhvt12V2P9EcdcY0tlww
 pD0KNs1i6Sn/BwCSqW5GeCnVH52oxHWsGSnIFkacwapm0egcJ0ML1q4M6dWyKH5jylSgRhuKoiP
 pr3Dk5NYLRGzThdo8pXpRmrGVWGoSLoc8BhHCm5ntIZac1yhqTRTROKxoNbYaJdjBYyR/EXFg0J
 ySuyPPOKkWOtTsSc2QMtCltDVqQKOfJrZ+P353J81LAGDdf61pCZYB24YjIGh3oR3G46HDxB/QE
 dPRuUQ==
X-Received: by 2002:a17:907:c08:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c1fa545898bmr134847666b.20.1785421123301; 
 Thu, 30 Jul 2026 07:18:43 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.retail.telecomitalia.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa851b369sm78608266b.9.2026.07.30.07.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:18:42 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 30 Jul 2026 16:18:11 +0200
Subject: [PATCH v3 5/6] arm: dts: mediatek: emit the Genio 510 and 700
 BootROM payload
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-ccaione-upstream-mt8390-spl-v3-5-82fb3bca27a4@baylibre.com>
References: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
In-Reply-To: <20260730-ccaione-upstream-mt8390-spl-v3-0-82fb3bca27a4@baylibre.com>
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
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785421123; x=1786025923;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QZRb8DGL63yi5HY/urZvNk46QHWtigsOFM8okiV0WuM=;
 b=FnFbNzBy8oiUtNJkS6vhjp+RoNd8eRXbtFbkhlB6jT3k/5MIXXpjFDdfuqkzuAaEwt
 xBNeSlzCRZgHCkv9yDXX5wJeVyerWvMYGAAUzCNA7E2rKksmZuy9DW1IRR44HZLs0yZn
 JfWqySAE1dIhpGH3AtOSKY1JLM4aVAT/LWW8JwIm5uR4SZUdUPDzNkQW3O67IYwvE+U5
 NOcbw+bcc1Xgfkh2EnzKWoT1fJRKMXfgC8oR1cywQ2mfOPNzUlUy87qp32CA5N3e105D
 WcS1mQPELdRblfNRli+gsnOXIv1X3CUg2MLcX5o+LfruYxmz0taqGVn0R2kzskeDhND2
 Ql9A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FnFbNzBy
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
 arch/arm/dts/mt8390-genio-common-binman.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/mt8390-genio-common-binman.dtsi b/arch/arm/dts/mt8390-genio-common-binman.dtsi
index 1fa5502c17e..b9ff1214245 100644
--- a/arch/arm/dts/mt8390-genio-common-binman.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-binman.dtsi
@@ -22,6 +22,7 @@
 			       "-n", "media=emmc;arm64=1";
 
 			section {
+				filename = "mtk-boot-payload.bin";
 				pad-byte = <0>;
 
 				/* Must match SPL_OFFSET in the external DDR loader. */

-- 
2.55.0

