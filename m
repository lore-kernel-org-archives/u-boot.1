Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34662C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84B6A810BB;
	Wed,  2 Sep 2026 14:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_XwZ29Whm6S; Wed,  2 Sep 2026 14:16:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358601;
	bh=Wx9jTZKIGnt9GRjIRwJ71VMElZ1boGnDobHMLDryY0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NuN/CSbRQTg8JyYA6OjrAK+fPtzv+WCNF3QJDF1wFK+BBVoKsSQ/GVhS7WBnd3gIG
	 ++M2Eol/bOTA8/3kvCaAPi6EMsYLr1OzJXi044c29i0ROyZBTMObAHB+uPkYX3s2gZ
	 HAsOspY8rbWXvqPT9Uj0NGb2FiSwNW8BHRShTaViSnAZpRLeaDW8A41r6gOwnqxBLW
	 FySnB9g+1Qguv7hPdtLO3K+McGFJI2dUURwpIlji/iStJQDm7eLF+o9FnKOm3e+mF1
	 jK2/8ILQ82I1ZVXFJVBmISi4vxzLyHflx62LrLE5BG/kSFlc9e1yWouA63t68gRmNT
	 QlVWQA9u/tCvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F11ED80FAE;
	Wed,  2 Sep 2026 14:16:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AF42230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CB8340839
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UNjLGTBTvMll for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Fy5ngIll
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31F21406FA
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:37 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-484415c8cb1so850320f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358595; x=1788963395;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wx9jTZKIGnt9GRjIRwJ71VMElZ1boGnDobHMLDryY0M=;
 b=Fy5ngIllvImjm5U43x06XdtlXyYt0RV6zXkSVJM7h2jwkh33IyWz3qOErucNIV66Yc
 9I6zWvSNwSkK2eoUMyklpmrAE4dl/360gj1Hq9a9/WhIWd56alvkmIImKdWGZjdQJQ4R
 fKDrWVgGUKmBvve87yNGgix3wuY5vpm+5UG4m1OkFk8uz+8Fl1A59Cc6bXy1KdS4rgll
 Aj6AFmdt/E1d2u5+DUshyS9e1OV7lPdvk1xYoVABoQrFnyN7Wi3TRbIw5L0ClEo59qd5
 mLF0O72rmKjbsu3VZR9sRCylR5MNqxOL9/ySbAMa4nbPt33oZ2/EMC0GU3W9qq6NMwWE
 S0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358595; x=1788963395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wx9jTZKIGnt9GRjIRwJ71VMElZ1boGnDobHMLDryY0M=;
 b=NKuBc/0Ja0s3b1LRgnv0w+Cou8cLGvVNLKyVCiPKAkojUdUKYnyYgnQj9z/eTZhyQx
 MrEtv65kAsmmY6SBVyDnhh0nAGJBFw2AQpnTGR/1UetiMaUaSiVc6lR0uK1zjiBrVFpG
 tNkWtIMkObXu67nEG7T/whWJO5Mux9SHcszuu0YaXUZS8IiU7oNoG6/NLPvyjhZsz8Sb
 0nDH+ypk9CRB/zzzQVE7WddWFh27Lu9EYncGryrWITtmoBL3NqP9ugc7knrLIOKnxW/L
 86woLvV9iQIg4SVwA/s3CEOBEx8Z/0ujka3Oj7a/q99JIoqPt+y8H/CDmtCBReSrfu/s
 nwPw==
X-Gm-Message-State: AFuF++nnY24G2GjQTJMWDBLDfPljTqzIsHPel28Ix5PrJDiQv1XnDjEO
 c9EnYXT/S0Xe2J4aWDpSPf1UUZscuobPvzouC08Ng2b7AQkVmmjLDF6zeSc2/KnGg8I=
X-Gm-Gg: AYBFou2kM8HUxV/gT/g8GHUP3xdBvg9gh49ojBroE5YnK2a3xt/TNyry2ATUB/SeVk/
 t/lbRcYz/ndSZN+av+Hgvhzrr65xuH1f0TJdndU+iUGLfO3Qz/1+uA7ORMEAbmcG0BDJGS1GBeF
 95xPdmb5jOfqPotpSz6VK9J1dVq1SfK68M15cyVzV4/U+KYHOKkxqFjGyh0BsrX+BUnyPHhogC6
 LM95zT9/F8IKHcYVoyr6+DJ7IjcBmbVxfd3MfbqHXWYv3tpqNqDLwGe00VEeo+ZUbXEkKe5JQqS
 WsCm8C+2Ip1DGKet+1KfXD27mpWiAR0XwIDXc9h0cSrODc4BOfhN2OfBVfB+hoowBZQYv/BKrsd
 FsmpRgWdLI3JgGg8qLWtE3dZ2iGWxHxvOVj8eT/8x1Noc6X2SoN3Nia3e4bnaF1zSn2xwo4VO/5
 dkqcJe1D9va1gIHPbruO1kFBgGO8HlAfnV1DteVedergKMjLlF3AuGWitlq2SLmg+EBN8bLLLie
 5aCTiL0OtISAO1Cu1G4rdACexr6vt2tZAz58USPhwsqIYL28ebXcL1wJHKKmweffgGTeO9CPaAG
 YyUoJCJD+RgVQn/ChUNK2BUFnjTmy95ANOIyciHhHH1D
X-Received: by 2002:a5d:6f02:0:b0:484:3604:c7bd with SMTP id
 ffacd0b85a97d-48488f24133mr10507964f8f.17.1788358595353; 
 Wed, 02 Sep 2026 07:16:35 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:16:02 +0200
Subject: [PATCH v4 12/14] arm: dts: mt8390: add framebuffer reserved-memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-12-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
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

This region is specific to U-Boot and only needed by boards driving the
HDMI output, so define it in mt8390-genio-common-u-boot.dtsi (included by
the Genio 510 and 700 EVKs) rather than in the SoC-wide
mt8188-u-boot.dtsi. It is placed at 0x72000000 to stay clear of the
reserved-memory pools declared by the boards using this SoC (the Genio
EVKs reserve the range 0x60000000-0x61100000 for the ADSP and AFE DMA
pools) and of the kernel load window (the Genio kernel FIT images load
and decompress the kernel at 0x64000000).

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  1 +
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
index 586d15bf72e..dda05bcf7f4 100644
--- a/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi
@@ -5,3 +5,4 @@
  */
 
 #include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
index 586d15bf72e..dda05bcf7f4 100644
--- a/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi
@@ -5,3 +5,4 @@
  */
 
 #include "mt8188-u-boot.dtsi"
+#include "mt8390-genio-common-u-boot.dtsi"
diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
new file mode 100644
index 00000000000..a4db2186e2e
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+/ {
+	reserved-memory {
+		/*
+		 * Keep this region clear of the board reserved-memory
+		 * pools (the boards using this SoC reserve regions up to
+		 * 0x61100000 for the adsp/afe DMA pools) and of the kernel
+		 * load window: the kernel FIT images load and decompress
+		 * the kernel at 0x64000000.
+		 */
+		framebuffer: memory@72000000 {
+			reg = <0 0x72000000 0 0x02000000>;
+			no-map;
+		};
+	};
+};

-- 
2.55.0

