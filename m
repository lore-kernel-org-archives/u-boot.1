Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29594C624D4
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 14:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E873C4077C;
	Tue,  1 Sep 2026 14:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mdh-mZI7ja-F; Tue,  1 Sep 2026 14:39:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788273547;
	bh=Wx9jTZKIGnt9GRjIRwJ71VMElZ1boGnDobHMLDryY0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nr2ZhCVaC2Qmp0GSIBkqDzGeiLxp6LVsscG6cpx8XFiEQEcpuHRCLV6/0xL3qBUZk
	 rlxTeA3Mk37eNB6Nfz44eD8Sy8X+4YkpmWfqwqt40xOXU9IC7FlJhlW3ygy0TSV9Mm
	 BRHw9qE9obEkDZ6irLVmLtiXybc33+DzWx5R+DMf4ytDlQtCmZi5kLmJAJK6/jbrLy
	 CO/8YpPamd0pr4yMpyWAvBtiV9qc6KKHhUwfVqmY16Kdviiyls0v5OPgYULN46D6Ci
	 dVW8MtZW3r2ncvqlIJ6FcakngoBVWh00w0QIZPhbyUm3Ukzq86uSS0QNHIYuQRGf+1
	 DnPtWvWDMFp/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 459F14072C;
	Tue,  1 Sep 2026 14:39:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BA80279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DA5F80DB4
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:39:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqBmeDQt4hOn for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 14:39:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=h7WudMIv
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04ACC80DB2
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 14:38:59 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so27644475e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788273538; x=1788878338;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wx9jTZKIGnt9GRjIRwJ71VMElZ1boGnDobHMLDryY0M=;
 b=h7WudMIvAilupbR2qpDaF8LK/l1uGsLwiIOq4LzLO5a7e+/5X8FMk5nlpQJaJ6ih5J
 AlJApYmyzknNMF+AsFP0fS/75BjWYIyiFLp6gnbLUOdxchq08s2bNt+iOsCcLcf1xcdD
 xYJ8/DZgeqF9uh15TKVTFJMcXucvV7IcfzhUQqwcRr94/Ru3VscSetMaYBtNM2NtUCbO
 JqZAKu9q9isIp+8UDUQ8DoBrzN+9AtAC4Q/gp9DvednodlNNdbAzAgIFuxOuCSwDUiHo
 aZdGhq52s0D4o2j8bpGSZM1HlGj4ihnf8IJnM+rPykPTLk/9Eti6uiXvazy1NWIuC+PG
 smRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788273538; x=1788878338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wx9jTZKIGnt9GRjIRwJ71VMElZ1boGnDobHMLDryY0M=;
 b=pawc1+Ai0v3ahQDprblJVuRe/QEH63J/uaRmij9b0yj9wT0Qm0v7fjbT7QFgvk2Fli
 3/o2ji2Q++8O7ti2458K/xrE6FEMO1o1NChaI6HxA74C/WSVno3X7aszcG6g+RDRSt/Q
 IFXOV2izqdGHA0NK/jUoIJWQszi5gLSclJd+rEz1W7imphkUW0Q9kdDcjeLa20CVpQuA
 /jn0lPxMi3ACB/eLgwispYz0zTvTZV5gMNIQbjyxJ2v/LyWOQPyodnQ2m7kl5QCVvUHr
 x7P+vOIDU4cW4vHiMdqRrqYQWWMewSt1twId+/wOSf7bW5XaCFO9OOLD4N3eS4ku1/GI
 4U2Q==
X-Gm-Message-State: AFuF++n4Tbk3Fz6MJuXRIqTZ7BNhPginYC6vkgB0oi5AmKSrwKB9Ltlz
 0QUtBAL4Lm10Am603RsSaoU1XgeGph1+zuGSofoclVg3h8UGDCxSewMw2Y/zxmzmh0U=
X-Gm-Gg: AR+sD13t12JBUUG877tdqX+b4OoPKQGHQBNqObT39WdLwxheNdGULwd0cmEUHN9PmXU
 9itYecAh2lfU0swjfwCvMGXN4JKtWoZb627JwMz2lRxmW3lHzR0AUDJcwjvBHs4sO8/3tZFdQBD
 W+yxntAE2EWoDBNzIbeDAwzcwIJzTxDg7Bdqx+dLkZU1Czt+lm4p+cOico7UUBM8p8va/YbHPo5
 yQC0ptGVyu7WQsQnm0yy430ct8c/7vMJKrHCRbe2CDOIJHI/6l5bdwxxlTt5bFxco1u0/MJYNCB
 D2hqcvSvVntM1jxxhw7Q0dypwiVulyFV8KO7NZtKWeZmy1w2ojT5D7Qc2pf6yz0kaxz6qZc/ALj
 1yabdlU3r1Te/tukmF3t+/VE4EWJQx/q/4dRHN8VMcJ6hcIazAvlBVX2311MQ226k/9c8g8M2yc
 wpyC0Ygrrxqv+aaZ4CtI5Fi3K/83OP1mvXVVXqIWwb7mjwNJwXt8tblg3pFE3nWTYniuN/pZrBv
 HXq3VoyPO+fD0SeT/0+z+0CBKGwtv0tr5fLifj2mgp9YWlaRy/hehdoti7CK0afOhNSc7I13Hn4
 d3WHYTjFExsow3SNlnANUdmp4rBlLSUj3avB3vgWbd8z
X-Received: by 2002:a05:600c:1389:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-49b91c1713emr490972415e9.3.1788273537809; 
 Tue, 01 Sep 2026 07:38:57 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce1e3a9sm71533655e9.15.2026.09.01.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 07:38:57 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 01 Sep 2026 16:38:58 +0200
Subject: [PATCH v3 12/14] arm: dts: mt8390: add framebuffer reserved-memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-genio-510-and-genio-700-hdmi-v3-12-38194a531b9f@baylibre.com>
References: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
In-Reply-To: <20260901-add-genio-510-and-genio-700-hdmi-v3-0-38194a531b9f@baylibre.com>
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

