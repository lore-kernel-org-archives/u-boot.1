Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F8B606A331
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mSVGdeiW;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gDApravN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10077810AA;
	Mon, 16 Nov 2026 21:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQCRzvLY2X9o; Mon, 16 Nov 2026 21:35:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 05E02810A2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794864931;
	b=lrNSTvsIaB+shFy66TxzcgFHJJ6VL70VlNiNpY2Q4I1E+VC2w9aPlVbB1TRn3sQYN9Wi
	 z8+b34sX0EErirEGVOSpHgBCSbvMIQJUkhRBLveUMD8IQTd6F0QZIXeLUcWdLTNhAOtCm
	 r5EO/peaJInJ/2grWrUKmBxNLunFD+mcISp0zdmFKptUmKiZ58ZtDF1cNIxlc0O9k2/l9
	 luc1+UdNEtVcBxOtchJAI/R2gayy4vIVzl2cJ8yS5CFvIYbQpiI/h2nkYVlFnZKyaYcPM
	 tezTBIH+RVeo9fovkMjuVHA2NNSpAJoCVA4R0ypYSaepDNABF2FdoD68Rc9/S9OejrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794864931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jLqoyIKeosEptTDE9JtJC9ej3D/gKbOuA0cB3K8luis=;
	b=nMNoUi6YIC5k1aNmMyHum4vUjtnM38fqFLqyoNpW0Skk1MuwYtBX7CUzEqPAbdHFw+q0
	 A35NqugwWjSW2QMkMday9Jf8IonwIK9XtwtBcaeJFjbGB2CBgdVAifYz9D9CMIeUJlcIt
	 wIOBkuzDdEHBd6RgDb+XFSiBMTjSqU9qDURLJwcZg0rvo6KkXjcaHZoWan5DdA/N/v77g
	 XAjoI1/rfM8zwDLQMB+6uwaXpDGxTSdQzS9WshhN7Ir7EkQ3ut3A6I9PKZveAo4hLN4Ha
	 Fhs9qGS+Ee1Sz2zfC6/Kc07RCTrDKvXhTl8cqhsM49WgXLbYXwfja/2+SSVuc0ywWnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gDApravN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794864931;
	bh=jLqoyIKeosEptTDE9JtJC9ej3D/gKbOuA0cB3K8luis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSVGdeiWJ+Jh0Qk8m4kWdSRusWhnUX48ONyFrwGfZoQ6Y27USHJtcQxZrAodepYpp
	 /jDoIGifuPuNewNZ4O0zFqg43prLVBOrOnN/KJO1cv50R701cWO6PmjNoyS26Y6SFN
	 ZmQQA7bZqvO+8XQ1GUmtAYo3pyJiomamopqqu7p6ntevlxfs8nDUSEvBZpCkiE++cc
	 plRDrPw6mT5p4Nh+H+NUHrg0GwplGO38OC/35Illi+dwLWdT7hwXODxhhMF7QyuYrC
	 ZnxXHaEoqFbkowOOURV9RGcXhXtOrdOpVuRvdfKz1RAuy2sCblTpoCWu+gE06GXgk5
	 hov6C2jfZ10BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05E02810A2;
	Mon, 16 Nov 2026 21:35:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2AC91A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3B3181067
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whkRg1wadmD0 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C51A80F58
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gDApravN
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C51A80F58
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:24 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so41882715e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794864923; x=1795469723;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jLqoyIKeosEptTDE9JtJC9ej3D/gKbOuA0cB3K8luis=;
 b=gDApravNNnvJnfPpUdrXj+tcopgbkzA7mczm8YYpsaLH9Yhl6TlBlyUF+CRpwEAOU8
 1BZrs/xuH49ib/ISMBGAOkimmWOaNXdByCXwZvVRJsnG7ceFPPJsztHiwJVggRVXbJuJ
 YOhhDVr93AMU5oxpZ2oZ65kf/vd8A0RQQl1tozFkSRMWLgl7PzdX3Vw9hLL0tu0HJLYz
 2HV3NaFExhlCLsUScu8iBWq9VAYz0+u0DINZZxOD1dLTChl0U74VuRH7TSNdbgw6c76r
 hthyHXSLQV2XWak5m3BNrd3xbEVnV8Uhx+h2YP3emxX4ogLVkD3oNTcOWGyilh+UObgc
 hcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864923; x=1795469723;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jLqoyIKeosEptTDE9JtJC9ej3D/gKbOuA0cB3K8luis=;
 b=P+4ToCvzOx7Y3GinjFo5ZeX78Qhv90S41s+aQAUO2p1oI+qw22VhTI4c7QWGT6P1n0
 tEDB6ldDZg28vU0Zj6gqKwUjbO906jczaReKOmu6xNlUl4j3moUL5jXvHyZQYuW7V4sC
 oyi3EYxzbguW8qND2RuM6b1fev8ihMoAAfPB0gBra4cOZGp1dp43sh5fzPN10ijoEg+T
 joUxIDVlmsxVgTv7J71f9vyAsGXlAu8Byw/nQQgw1zqeP9dJU6cteuX48V+zq3cX3f/v
 8W22tkA/UjeNLwnAaFvQ/GSD0qK15z10k8a++/07myocndV4+ZpOHHVM877x45fXvN26
 xBPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE+e3HlNT1UTu36CJLcB4pksUAnaMvOjnIkrl4ge2bxLszP6lNyBrjyw6MGYxiqQXO9uYdG7qg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/0ZwEdKA4jSXiJTxncQEC+d+7RsGc8a10LJ+eNs4vcom2VXSnl
 zO5+scTsB80XiIE3mMZM1IILLkoMJHm+zD7+wK0h7ElZFM+dsikJMJczO+k3WR8Ws+c=
X-Gm-Gg: AYBFou1C1N7n2/jEx3hFdLjFKhDaxD6WamQ4jWCueT6VpBO7Ffb1t2N6zqEweQZrIYV
 9zD2hyTitq6+sI9kqEa5QU4ATSx8eNKC9VhJqOHXO0aQSoj/SBfxpqr7LeyovywQ3PMnhZe/ZTE
 v+28To3Vu5y7rg/bxcphVwNv3yLY2z10gePMG1CNEzufievHTj5JXH2TYUEmuAA7vTk5QSVehHF
 ufJKVKgvwYPTj2KnwwXfyKhPvV3D/3BgLzfoO7NEOHHjt8aiBijZ5HFhDPhTSZFaVeJQ8UydHNd
 avpuwNtbxfdykHf0trJZGYv8UOMo5bs+J5OeyYp48Ugh6k2t3glWEpANCDiT5vAFXnU/M1KYRkn
 ZZ2dQD/3kPF3JJhbCrCmFcpbIuOym7hdozzDag7muETtQ+yAsVReQmCQY4ZZPXA1aP171V16E39
 Z5mB3lW5njlxKNT7UtoGiCB0L1mRFJCqaAnYlhhZb/uZJRsJKl+pNW7BwxvQjMwhow8bt1tUdL7
 XrIoa62rfJd1JOAdxd4ERkgeZ9I/fDuCfrbU2wmHEZgAe0u6xVH2n0TfTZvbQ14tHXYi4r8lvPA
 S19iHutUbkaPidHddMmdBfNVogJsogw2+6dvCKTnT7XhlQgu91WTzQsnIsb7L8bZky2svCccWrH
 uvcxNhClmS1zcM2VKAmA=
X-Received: by 2002:a05:600c:8b0a:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4bb55a95dbamr252457645e9.31.1794864922846; 
 Mon, 16 Nov 2026 13:35:22 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm26314066f8f.0.2026.11.16.13.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:35:21 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 22:35:02 +0100
Subject: [PATCH v4 3/4] arm: dts: mediatek: configure Genio 510 and 700
 USB-C hosts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-mtk-g700-usb-v4-3-2de4cf90365b@baylibre.com>
References: <20261116-ccaione-upstream-mtk-g700-usb-v4-0-2de4cf90365b@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-mtk-g700-usb-v4-0-2de4cf90365b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.16.0
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

The Genio 510 and 700 EVKs share the USB1 controller, onboard hub and
USB-C PD connector wiring. Use that connector as a fixed host in U-Boot
and select the USB1 DRVVBUS function on GPIO87 to control the external
VBUS supply through the USB controller. This fixed-host setup does not
check Type-C attachment before enabling VBUS.

Keep the USB0 download connector and the USB2 M.2/header controller
inactive in this host-only configuration. Their OTG descriptions would
otherwise also select host mode when USB_MTU3_HOST is enabled.
Explicitly re-enable USB0 in the download-agent override so both SPL
and U-Boot proper fastboot remain available.

Put these choices in the shared U-Boot-specific device tree so both
boards use the same settings and the OS retains its existing connector
and role-switch descriptions.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi     |  1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 30 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
index 249441fdf0e..b57351bf892 100644
--- a/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
+++ b/arch/arm/dts/mt8370-genio-da-u-boot.dtsi
@@ -17,6 +17,7 @@
 #endif
 
 &ssusb0 {
+	status = "okay";
 	dr_mode = "peripheral";
 };
 
diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
index 6e84dfcc6f5..aed16b8a6d2 100644
--- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -85,3 +85,33 @@
 		bootph-pre-ram;
 	};
 };
+
+/*
+ * REVISIT: Add the missing Type-C/role-switch support for this board.
+ * For now, only use USB-C PD as a host: USB_MTU3_HOST would also force the
+ * other OTG controllers into host mode. Download-agent builds re-enable
+ * USB0 as a peripheral.
+ */
+&ssusb0 {
+	status = "disabled";
+};
+
+&ssusb1 {
+	dr_mode = "host";
+};
+
+&ssusb2 {
+	status = "disabled";
+};
+
+/*
+ * Use USB1 DRVVBUS to control the external VBUS supply enable.
+ * This fixed-host setup enables VBUS when USB starts, without
+ * checking the Type-C attachment state.
+ */
+&usb1_default_pins {
+	pins-vbus {
+		pinmux = <PINMUX_GPIO87__FUNC_O_USB_DRVVBUS_1P>;
+		output-high;
+	};
+};

-- 
2.56.0

