Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A38C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00B3760792;
	Wed, 26 Aug 2026 13:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jIXbvwajIcJa; Wed, 26 Aug 2026 13:09:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749797;
	bh=ftwqUzyNXSf/FGc/p7fJ2h1FOe+b1wx95IQ3fHtCuFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=blzrYrPaK2ROPgTZb9EGXNU23pNAojbrIi0+gd5P4xSS2xtktNA9c1zIcOgFwIclu
	 +A9OM4T2g/Xodx9aX4HtHAKOrX/n2PnPJ1of97jjPH6Atjt5hsW419UTOHDO6etvNH
	 ZUTamoLyrAiVr9qI+DoRNIPOm0JaMPZ0T32EpE92fmq1C/4MLRnoA7CFhwutf8Tjkr
	 uKdg6dG5y1KM//iOLWRHZZCsemZ1O65W1tlbgVQclGOdqJJOlhKb483kz/nXWbH/PO
	 GaJ0LRFNPg02TfMGO7OYWyb11P8zVDoODPoHoSkud6afF0z64efczDtuqWaElpcEVF
	 vOdFPPnh3IVMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B2BD6077C;
	Wed, 26 Aug 2026 13:09:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A61AE396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 967CA406FC
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SQMzFJiOUvHo for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:09:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Z8w4lfQw
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9ED54406EF
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:09:49 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-482e4998d28so338291f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787749787; x=1788354587;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ftwqUzyNXSf/FGc/p7fJ2h1FOe+b1wx95IQ3fHtCuFg=;
 b=Z8w4lfQwh0ydtJK0Cxw4tYjpuJVlugJLBWz+1RGeXj0mkqpXA1WjJ6gumLpvlc/SfR
 OksOf5U8cloSMJ5WBIINN7wXlOsuj7FRC1/3G88VweI6qptjAb8sp80SIBjIUGKRZE6Y
 6VfyAqxSpfpNpnZENOSOfSi6i2ncnslCjuCBkbKCdbamuH20vu1+R27G3jV5yAESy7zW
 mMvfEjapSYpovSDWeE4CLUbBXM2DHva3FR/5JkqG+WeKuyZ+5ZtBWhvvjecjcB2OCr/U
 F2acrrLazkifTrkIP+DNIEdBwos9SxJVfXsuobi7nULBSivY2VuT40Of7Y1+Slk9c9eh
 2rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749787; x=1788354587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ftwqUzyNXSf/FGc/p7fJ2h1FOe+b1wx95IQ3fHtCuFg=;
 b=ZKeFVV5Mgvmte+KtHKzQcmzNhtVEhNIuELD3Z2hNs4awRdRBqFWnXtYGPSy4PgsaqZ
 fIEdKjEJG46VsG+LbMr9hxhLE6F9T/FTaUyvgU6H6YShDMqhaNABGIwHQSAHmp0nFrUa
 34RpvTpz77AZLxQBIimNQtDxtDTFRxRxNtxInzaYJuE8qUZ9vCEYlYbTU4T0rzrRizqU
 VLJ80LJxm4yGYgFjgZt5G7rd4WAM1xWgUuHZ71tEGgdJvbKxt2zEGL+lo59z4srhDfpQ
 PmSG/CGyF89tqIyD6Ftzo85jig6rrqKvWworKCTzHNZ3DugkUvnWdhaAkIiyg0Jv+7z0
 Xlkw==
X-Gm-Message-State: AFuF++mQfSRArQvM/nj4gsLwUqOl25WAzRFbCjzAWnCY6sFaC0dFhyVM
 pNV/4eeAS7RkmZyE4UwjX8Nnz3TwoV8T2QxijJ+LBb3psMBN0EC7/RdasBgy+Om3uWo=
X-Gm-Gg: AR+sD10YHpytLG6NkEjWIuZjOXZe02ONcS5ocaJcK0nH4UNs7IEZ6b7AzJ+HFSKy0Nq
 u8h42MTKRQLottVqWEtBHyJxYENiBRG4/gR4RTo6odQsLooDSw6HYAUsSHoG5zE16MKQANhnv+g
 iJNN6IiDxzMkJQL8Qi1yBNJ9HkQl1VqH1pO9IQvtrWAcLejYRp4mkcQusn+RrhnjhL+w3cgevXI
 ZNLtW5m0wMPMBbuzuu8NVTX/IXK6q4ZvH0YkBgSr62rdm7oqTu4kW+QRC/s71bKbRyBMqpafUvM
 55d4tMjNexs9WdG62sH09fPQL7NpmG1A9glfOqvDV+MZ/IN4IkqWzIiuYl/KIBk6lWs4eepDN8B
 mAa/jRj7fOB5Y/o/i2BnzBS/Qs4jLXSRCnlByTMo2JiJzkoLV66Ymqt7dhCVJkd605dyjWZz8E1
 vM4DXqhr0SoC3I1eom+4N/+O5Iw9nLGAizMIM74FjmY8m8f6VbJc5ro2ywyWPL6zj1v5EhPPJJs
 n3UU/bBoFGKMjKwzRYF6VWc3+HAfgDqvqMFQfo1e7imckalVV5USiZ1UIO360XlrIqwTe+GfSI6
 EJPy2dPbbcwzhqKGUqGYcMQiQ8p/1KEkuPbZCQsrhq/s4g==
X-Received: by 2002:a05:6000:46c8:b0:47f:e377:8d61 with SMTP id
 ffacd0b85a97d-482e26add2amr6025419f8f.11.1787749787080; 
 Wed, 26 Aug 2026 06:09:47 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6917sm2635817f8f.35.2026.08.26.06.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:09:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Aug 2026 15:09:40 +0200
Subject: [PATCH v2 13/14] arm: dts: mt8390: add hdmi override node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-add-genio-510-and-genio-700-hdmi-v2-13-68ebb1bf17df@baylibre.com>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

The mt8188 SoC provides an HDMI encoder and PHY fed through the DPI1
interface attached to the vdosys1 display data path.

Add the U-Boot specific bits to mt8390-genio-common-u-boot.dtsi:
- a "memory-region" phandle on the hdmi node pointing at the framebuffer
  reserved-memory region;
- aliases for the pipeline resources that have no upstream alias (the
  vdosys1 syscon and the larb2/larb3 SMI larbs), which the video driver
  resolves directly since U-Boot has no DRM framework to walk the graph.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
index 95b2f66973c..9485315b79b 100644
--- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -5,6 +5,18 @@
  */
 
 / {
+	/*
+	 * U-Boot specific: the video driver looks up every pipeline component
+	 * by alias. These resources have no upstream alias, so add one here:
+	 * the vdosys1 syscon (whose register block holds the display routing
+	 * muxes) and the SMI larbs feeding the display data path.
+	 */
+	aliases {
+		larb2 = &larb2;
+		larb3 = &larb3;
+		vdosys1 = &vdosys1;
+	};
+
 	reserved-memory {
 		/*
 		 * Keep these regions clear of the board reserved-memory
@@ -24,3 +36,8 @@
 		};
 	};
 };
+
+&hdmi {
+	/* U-Boot specific: the framebuffer lives in this reserved region */
+	memory-region = <&framebuffer>;
+};

-- 
2.54.0

