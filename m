Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A997C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 143F0811AE;
	Fri,  4 Sep 2026 13:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7OAtMiZ9HolT; Fri,  4 Sep 2026 13:50:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD8A9811C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788529837;
	b=VckyuW0KBtYSXVXjNQSEmZDKFZGSdcb97Bd2hNIEhhqFOWPZj6I8EYDIOH1u/EkGz20b
	 M4d63+JaE9VZMTE3rOhPEfNcKm7wguVT/TFp8BCxL/DKziqdnTjcHvykb/NzNTf8KgKeI
	 aAIue0hGQKBbyPc2bFLIn2gW4liLC0T3LjO5WqqMjb5gOIGvSS5rqMjVhUg9HswelxwEo
	 2BTYj8nhREoDH3lGVOuov8r2s0BfLknpKH+6Tc0rABM63E1M2etuP1dPD3HEwZfe+taCz
	 zasMq+Sd5m89fR+vmLUVXquyeSFI2nxZmtCC5mhBHiPiXaWaYhQwxmKOCabkXxDx+nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788529837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jeprAFSgSdwUpjlfgf53RzFA+oBSvk6g+nshbFc0uNg=;
	b=a8lqUS+B1tSsxtjvGF1zH7Do9JjJknsWKimh+K6Z+Kup0+qq1BiJZsTdXp62Ac0UulJv
	 ejvNwd/DmH16lgkHji+zmJg0spP7/3861LCk+uKZkFY3bgwr53mSwFdjC0hXiObaHAZXH
	 m/fLUSb0w2DyF3+q46cz6KDxcL38yDr4nwdLYqJaD78IsUWLYmhSJW9GMS61AajiwElhv
	 jGg77xzcw3DxlRjLxuSdMJYODZlBWh2F2kmy8ccouY8PiiF3FYEapohfVqJ/jVBeY3NIN
	 R1W82sryVAkZnLuHoWeuOqTcLhqZpH6p5PSoGSU0VahcLeV9irY8diLD2MrTLpRIbVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788529837;
	bh=jeprAFSgSdwUpjlfgf53RzFA+oBSvk6g+nshbFc0uNg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFLxbK7yD64ZML3CN3NlYPqByv16LfiiYJFuFLuKAI6QTv8ufKn6vOw0nq9scWxlO
	 HTDdLMCmpKNfXcxHOUwFGSNbyjRptsG2BtHDRH+NssFeExpvw+yQZIo6RLqRixJESU
	 xbK7pMFQpZOTjgh82rOGwc+ksuW/j3AIQ9zFFrbHIxvpuqpK14zlD2YzuRGp3+9o6R
	 DYxeIB7TH5Z7K+bQIAymdA0iyh8FaICfHTJ4lRUcfm+x5EnjCGLR1EV3WF7PUxX2Qb
	 2Ftlh/xv63XMhWX6zLZCJPpOqDoEL8AM6WPre0t+8smSBFDcdDSrg59SsQgGM3fU/+
	 1F1E2c3eUSB5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD8A9811C5;
	Fri,  4 Sep 2026 13:50:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EB2E010E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD2BD60BD6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FgvykUW0P2ti for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E535560BF3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788529825;
 b=UCUv0P/4FMvwMY0PB6prLB1XGanN9jQ0HSGLnIJbwNYmmhoCv/9EW2AlAmM3JwQoZk3V
 DwEZwisStOWgjuCpk8X+pJ6hATZYUCSOTCJhI4Hc7BO7/aTF1YRG91hkcXTuCH3MnF0AY
 ub5vji+fWE7WBuRr7EuROFiVtJB8QV9sc56rQGdXoYT8+a6RIIQkdloFY3iHMqeqwCSx7
 Gf6WE4QUV7xvayPxI9VZ4C6OPEseuRclUj43WzK4nDBCgovhRHRWVktv5N8Oy21n5ELDT
 M8fSjly2bJc3ZDmJ1sJJpMAQW6liy1vTJ5ZO6B9JXFz2WUoh4d6WLVc4IMS4sxW8iNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788529825;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=jeprAFSgSdwUpjlfgf53RzFA+oBSvk6g+nshbFc0uNg=;
 b=opCFX8AAEqtRvTK73pK6VjW9TxZ5eMsgoYCBqBUwP+qIPjYplY52M3i/aAmrAKdRAq9+
 oG/L+Urm2Ln3m67i6lMfBMt36cLXVLh+izLJFyFB+j8SHzuwaIlmlrcspewcerpZFiZVa
 4bcGPhj+CZL28dSi5kRIwQ7MT/Tm9eYjoIdxF+BwUTljqiLLqZ7oGg2Hue/b7tglEd7Gv
 QQkySGz/fD4dTD6AVaob8Z4TMxxfVOjKxTOvgTO49bSEQPSMBS+LHQ6kswTqK/xdVUhUi
 qdUbz0bg6qj+lElmtvXGZJ63rPGQhAeKeR2SbnlpHwj6PGjjFa7Ei95yWfgIvpolRbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hjY2L6wh; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hjY2L6wh
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E535560BF3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:50:24 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so1086857f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788529822; x=1789134622;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jeprAFSgSdwUpjlfgf53RzFA+oBSvk6g+nshbFc0uNg=;
 b=hjY2L6whAKoydwUP9HJ8f+i2xJ6i2x9gzRSZRNvrrBoBVQC5UuPLdh1zcKlqzX2gf8
 M23sXBJ9EWgyWtBsaOxCAOC3CJwbnFTAqNSj95ZfVGZK35qhxmLTEXVpko38B+9NA80f
 f4iUqJP1WiWtwZz0kAogw99TzfP4Swg7tZnmNhnBsLOHtbPw6FQKC0EO+uhORDUeqbb/
 Q8z+DtMMXtHegohFF0N/R38bVg3QIXguiFNXkarfv/yo6/VY+7zQmeYdC0qQADLK0DaG
 pdSnwSboo57+NH+0PwLLJwZ4v9APpeYzvk+TvnzG04hTLKwgrFDTYawT6jvT3K1BXhHi
 kzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788529822; x=1789134622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jeprAFSgSdwUpjlfgf53RzFA+oBSvk6g+nshbFc0uNg=;
 b=bOvudjoqbWMdLxU9hfQDOEXddx9AyEInMAmTcd9fVhvIqR7NxUQmJpli6JXmzAmaVj
 wo9DG35u0yBTkEHsWwbqabyPAqnnGSKnAdZ/qitZNKZntw9pIWjPRE2BLaUbgVSk1hUj
 8PtUBm0aBY4DgyQ4cFNphHSKJ9H8TfOrbIXP97sXP4NEiiowxdZSVtknJywbHN3YSLzv
 KrXYy/gjnWwkjjv0jbe62gqFyRbp1HFTYj1hzMF9JLxVmWU50Ifx4pUMfP58Rx5/8OC4
 gMgltBbj97trI5J8h1gWXReZqkDM0LoWGQIweJ4pEp91oH9VzkPM0L8PdY7PXGTCbw/v
 6r0w==
X-Gm-Message-State: AFuF++nfSuBh+FP1QnFP+YEtFpI90ouekm+UjndK74xssi1S/q2I3aYI
 WExqICVC69p4nZgoirZa5+QO4jKG6jxIyI8BZSDgnLhMrh2qeotmE4bODIge2iJ8/9Y=
X-Gm-Gg: AYBFou1iDojsAYDYIYjcwLOl7yD0IipjiX/bhOLcBsJ6+zX8WxseViBKqiAXnx/Yd+f
 vosl1qDFpsO0xweu5VrfRpF26u+9Jbc+2Du6NF7lTuyH+kNB2DrwAJImTAt6gIWjDL9ZTx3Pyo3
 nsu2I8jOxsCpNl+vnOEc5YDK9m4a26Gv/PAXBa2UsCq/uGAZk9f29Bx2CUSyR/ji243apPdGuki
 mpEVivloKcN19xyh9PmFHG9VRvi9vy3wnqqgb65tzjItTHkYBLjdaA0z90WZy1Wwig6OzO4Us+T
 dAbPDgycvfjMSA6KH1rmfACpVbATegWbZAtMbLwCwwjKjy2l1WEl1AU4qMUx/AWBDA0lqo+uxPM
 3I0UvyFc2vSFKXmpckd5jOi47vVdjkeYHhO31/B0GKU1K5kQneGtmJJ+H3FPVZngl3kwmvUMt4o
 QsKhQHGFQH5Qqt4ii8wXPP+TW5oFnjFXoAfObBt7D8aspUYwOJzXJ6ftZkBHxCdVOmVL2qZrah1
 d/+YW+cHyl6RMOYRvmGQyzv2+ijKDl5k+wdO0PJnLwHvPCTRwE+ft0RmdZgQ87VjQsiQlRZL/yP
 jmlf1yH5L9tu1BIIixdhXIWZFXbW0I5ubXJqBBUUXAM=
X-Received: by 2002:a05:6000:29c9:b0:484:3314:eff6 with SMTP id
 ffacd0b85a97d-4858709b390mr9519453f8f.28.1788529822449; 
 Fri, 04 Sep 2026 06:50:22 -0700 (PDT)
Received: from [192.168.1.60]
 (2a02-8428-ae02-5a01-b206-d095-5e9b-f35f.rev.sfr.net.
 [2a02:8428:ae02:5a01:b206:d095:5e9b:f35f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485881353e8sm6708786f8f.1.2026.09.04.06.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:50:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 04 Sep 2026 15:50:18 +0200
Subject: [PATCH v5 12/13] arm: dts: mt8390: add framebuffer reserved-memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-add-genio-510-and-genio-700-hdmi-v5-12-dd9dde2f972e@baylibre.com>
References: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
In-Reply-To: <20260904-add-genio-510-and-genio-700-hdmi-v5-0-dd9dde2f972e@baylibre.com>
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
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
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

Add a U-Boot specific reserved-memory region holding the HDMI
framebuffer, and point the hdmi node at it through a "memory-region"
phandle.

Both are only needed by boards driving the HDMI output, so define them
in mt8390-genio-common-u-boot.dtsi (included by the Genio 510 and 700
EVKs) rather than in the SoC-wide mt8188-u-boot.dtsi. The region is
placed at 0x72000000 to stay clear of the reserved-memory pools
declared by the boards using this SoC (the Genio EVKs reserve the range
0x60000000-0x61100000 for the ADSP and AFE DMA pools) and of the kernel
load window (the Genio kernel FIT images load and decompress the kernel
at 0x64000000).

Its size, 32 MiB, is just enough for the largest mode the HDMI driver
accepts: 3840x2160 at 4 bytes per pixel is 31.6 MiB. Raising
MTK_HDMI_MAX_WIDTH or MTK_HDMI_MAX_HEIGHT means growing this region too.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi |  1 +
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi |  1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi  | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+)

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
index 00000000000..87953c30776
--- /dev/null
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
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
+		framebuffer: framebuffer@72000000 {
+			reg = <0 0x72000000 0 0x02000000>;
+			no-map;
+		};
+	};
+};
+
+&hdmi {
+	/* U-Boot specific: the framebuffer lives in this reserved region */
+	memory-region = <&framebuffer>;
+};

-- 
2.55.0

