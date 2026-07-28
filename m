Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099BCC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8F7B6089D;
	Tue, 28 Jul 2026 12:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yedSy99TXzTC; Tue, 28 Jul 2026 12:29:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C16856088D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241792;
	bh=PJB4eAsUqenASyzVaBBa+ytlzFwv4vAUaYVG0BhJRxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S1Px3lp8jmRQYaj1rtM/g5ewKYUuTyKjvaLxqcwqLXEzcw8KUmM4yaGh7ATLjIZVQ
	 kyQpyntvSxO+8Sk6CaJbEKWmHDn5ERR4bR6YVUEuJJfAM1yCxKmcRfZaCwxcmW1pcY
	 dUmMc39FbP30HLD3bfaSGm8duA7fWVMgeFUP8hJhB+p/VzCBLwdlP2A63lEEG6Hcwp
	 BgMk+ctgYuyJCXKWkbkCTqn6D/F3LKvWwseY3NnSx3CAALg5N4t+L4Liuit5WnEzkn
	 24Mww8fSWjwdvSRsvYKNwsnVu2PFLQEkNbIkp926ab7KxXcamvjOKd/UMoVbtQu9ly
	 1eUhWwBHHRY1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C16856088D;
	Tue, 28 Jul 2026 12:29:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 11E384BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04163409FA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwxBn2Hly8DL for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:29:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 157A0409B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 157A0409B0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 157A0409B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:29:42 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so2165547f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 05:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241781; x=1785846581;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PJB4eAsUqenASyzVaBBa+ytlzFwv4vAUaYVG0BhJRxM=;
 b=fSY2cYvtIyEyHFKrrefILSS+ApWc5kpVhM/cK2qFmEpgIK/cWRS3tEFaApFa4dpG0F
 rMkv34if1zwi0KG92DZGckxWk7Ym6h3v+9X8lvP5c0RNwuYYsIiqjzI0dUORbyuLMtwm
 Vz9rkuxG7dDulIdouarIn7W529QsNq2G9H83gfpjksNAqetOTH4Ad57koXUTMVcDZaf0
 B+rNbs+G9kWYvRdFCVR9Y3Skaj/t1rmOLl4NXoWCRNR5d0mt/gKFUthr6E8z0oRttNYT
 W5QYpZRkLx9o06JvWOAMyTrAxPzZ5FLXBhFdz/92c/VtYaGqyRoJf1no6/uuDk5WVFnm
 lXmw==
X-Gm-Message-State: AOJu0YxW/W/wDhqmDgHWAkfsgTKbASQ8P0uoN3twHKlTgm1lnW6xHrFy
 jjWo6Y0BycGEIYf4+aeW/Q3SFVTVgz+u2ACjapDKLR5u9AEyoNRIUWujIivnor/I6nw=
X-Gm-Gg: AR+sD13smDHe2UZ6g0ehWTqk7p6nh8NxEMmpPfIVL5J5k0UWae0djglABA9nAUA0tNa
 Lj5DkhHUQy//m+lWfI5PG4seifKTisiwzDUZsmXfVHCKjA6e17jTIjaCb++eiSJtDOlMwmpq5xW
 7Q0UgAwtpPQUcorCLpAYuG7qB5Xq9WWkWwIpW2j5gmKSoLxwCJp29WhlvaYr1YGeXbdM2caXOig
 0WiuiFUcf6u3WIw8VM+484TzWFUggrqHBnWc9uSlW5JjybHS9dMo/xnbYFGAkSkFiWa1EpFGt7o
 tHGmUL9RyuGhhE+YPYWVhrOT2d58I0q6Rnlk7LkZ1zDHw7ZsZyvAlItpIklMsM+uMZ9bymWKLY/
 aUrIxTOgO7evSvwrx4RbTERiNIMn8u++GWqStasJFU5bzeYGrHSBSTK+7n63Hrqmnb27uTXngaN
 0wZe0E1AfAwYhbjJTNIanceJT5RLmXQc4LNEf/W8K6hPp3A2iuCg2I5yXEwBtmLSLZipnfJ1L28
 k/wpF403po3xNT7aAP/PE41rUbe8b/+u9hDfduY6QHSKjHtSmgACTfwsrN6R+w=
X-Received: by 2002:a05:6000:4811:b0:47f:80e5:b9b3 with SMTP id
 ffacd0b85a97d-47fb1f13ef3mr2624846f8f.33.1785241780655; 
 Tue, 28 Jul 2026 05:29:40 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63bd3sm58324766f8f.27.2026.07.28.05.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:29:40 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Jul 2026 14:29:43 +0200
Subject: [PATCH 11/13] arm: dts: mt8188: add framebuffer and splash
 reserved-memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-add-genio-510-and-genio-700-hdmi-v1-11-ac54bd75f960@baylibre.com>
References: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
In-Reply-To: <20260728-add-genio-510-and-genio-700-hdmi-v1-0-ac54bd75f960@baylibre.com>
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
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785241781; x=1785846581;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PJB4eAsUqenASyzVaBBa+ytlzFwv4vAUaYVG0BhJRxM=;
 b=LQff+Y3OX2o88y+AJvAftqn9qlvmUNtbsi9shcO+5z2UPm3nzt5FtTHD27k60eQgZt
 wELKg1N0zwCvMhOGJB86zUig9gDhP7u9gpLJGofvhFe5DyD/LKUZQvYdeUshjmpbGyBG
 RV2uIjdswLzyx+XoigYNRI94pOhp9DIAxv2Lq/z0vuVTeviC9tjxUuxgMvv1eAAkWgxM
 Moa3Z4LcgjbIbUwgzIRzYTlHTfzB8jKIsVk7JE1KDqwz5rEMgnsWPRGmQUYlnEaeVuab
 ZR71TOKqVmQr5PEECYCAbLPpSubWPYN3y4H38339RIgdvKYEJfYmXWusFv58jqhLR+0Y
 ez6w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LQff+Y3O
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

These regions are specific to U-Boot, so define them in
mt8188-u-boot.dtsi. They are placed at 0x70000000 to stay clear of the
reserved-memory pools declared by the boards using this SoC (the Genio
EVKs reserve the range 0x60000000-0x61100000 for the ADSP and AFE DMA
pools) and of the kernel load window (the Genio kernel FIT images load
and decompress the kernel at 0x64000000).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8188-u-boot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/dts/mt8188-u-boot.dtsi b/arch/arm/dts/mt8188-u-boot.dtsi
index fd1121a72cd..923e52522de 100644
--- a/arch/arm/dts/mt8188-u-boot.dtsi
+++ b/arch/arm/dts/mt8188-u-boot.dtsi
@@ -5,6 +5,25 @@
  */
 
 / {
+	reserved-memory {
+		/*
+		 * Keep these regions clear of the board reserved-memory
+		 * pools (the boards using this SoC reserve regions up to
+		 * 0x61100000 for the adsp/afe DMA pools) and of the kernel
+		 * load window: the kernel FIT images load and decompress
+		 * the kernel at 0x64000000.
+		 */
+		splashscreen: memory@70000000 {
+			reg = <0 0x70000000 0 0x02000000>;
+			no-map;
+		};
+
+		framebuffer: memory@72000000 {
+			reg = <0 0x72000000 0 0x02000000>;
+			no-map;
+		};
+	};
+
 	vdosys1_pipeline: vdosys1-pipeline {
 		compatible = "mediatek,mt8188-vdosys1-pipeline";
 		reg = <0 0x1c100000 0 0x1000>;

-- 
2.54.0

