Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA894606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f0eE+bqB;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hfC7Ft57
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91BFE60A5D;
	Thu, 29 Oct 2026 19:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A869M4tDzt45; Thu, 29 Oct 2026 19:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F52C60A98
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793302770;
	b=r4aUOPr/DmHOV7NVNY6ZeWOTEc3gVqX9Orj7rIMW4YtRun4w2TK4sTRKeAhAMrMZFsAJ
	 6k81voMdfdhk9acf302uHNLwCbwXCBj+bfLpMD8Eq4zg1M0mQ2V/ZdV/qcmDPjmr1PdzM
	 CJPsznwXNryAm+N+JEOgvMiUED6r+TwWJzLatNMTemZjymTa411EGGT/GP/9CFzEDhYOZ
	 /O8ov17DVMU2r9t9FsRK3EjP/wjhp0pUQr0wIV+LAL8YmGjG+MXhdjvVRgjG+mKViv8K5
	 ovTV0aRNdEDk1SDiNq1F6X5XQ6OQW9mumv/n6O6OSs8FDum2krkH6a5pvDREg3LeevQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793302770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
	b=nWvSisSout6YDPbpxsOijiziEurCQ9p3lXGXLNMK1yoPakMobrfe5nlbQgxoPhVgoyy1
	 p8QPabnNo0AGRbZj72hc1QRVq7GS2k6AtgNnQc6zzJzYGTo6NWUKaesUcqZWNcaFnoY9P
	 2A5gnHAj+iHZvPOnE/SHrM7AIbn0x6ldH7++G5F0/GPuTGqmLd+dySOiup2GdG9OTFccP
	 0pMVC2fLPEf8lXdnn6AXn6Jl4cVTmIHML4ZN7LG+uEFTKrUpHBsQ48PMN7SA9qxDgGcKv
	 SMTKM8/bmntZi93cfI241pw4Mte6ZmSXKMqzMeCccZRTJsioaGaLbzaAlD1oRUfzUuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793302770;
	bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f0eE+bqBWN93xyZ5fyClY1xcU1mtF4k/jr3gBYAhM71jBwH//aU1mKTsIS2f0baWF
	 4FhUYjIap9bOlKRr33qJim6i7Tm2SbIot5bs6mG9L7XMR1NA78xZnSiSAuMFIY0VL+
	 rbV0lLafpRIoVaDm1n+ewHGyRTLBR9VsFTaW3OFEv/LAu8MmJSD3dGROJaCCiVUmcY
	 d08g8oEUbu8mXIvesYJ9IF4lxmBvFm3u3InicqZ+Ff78JZHr8B4HaVwDK7VA1/+eca
	 3K0meJyS8M2SCIKVghGT3YoQLH0DZlO/NbL6WycRX0/sNXlxwwCZn2jwTjWKzm/0+Y
	 LmalG3ZEpvlKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F52C60A98;
	Thu, 29 Oct 2026 19:39:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 537442E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B0DD404D6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0eu5TxJb1uU for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 19:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 329F740048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793302760;
 b=Hh/OZJbTB+NpKFmfFNu1uW0HtxySuC3Ln59nYSjh1eflPG1umZWPr3Hjvpa1ejAvPpSr
 i7FXhKHSYJVDUhzIddMJ7UKtAyHUuhW15qOaqm7eiG02RBX4POz7r//lgf074BGij03tf
 VO6SU4eruBRJlUrZ4H1mZh9tmJji8r6rz+k7nI6YpL6d8mL+REUaWZu/wqCKq2BsARkkC
 qAmBlWcctqjckDTgH/2eo+vXxmqJjJU47Xi2o3hvgwLkvZ6DZPR/CIQG/kiaGcr3stqcg
 BZofLlKIdQrPDkmHm9RNYX31xMfF/0LsAkbk/E0jA7LKkiWDSQcd0ERs4Y9MWEZae9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793302760;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
 b=QMhUebD+aFOpcrBgXRz3fwIKYUAUWT+t+l6W3tJUuNNBAfrh/FdKN0+AxpBjCMyYeSmX
 2AgDzAGPfwN5dA0MaSEH+BwvopBtuJiIHpACmrEIYSVIhqKcknxZFXhdnIqOeqMtTyz4x
 jHUf/EgoBcwSZs6Si2Yo2vS8TT69KUFwypCob3leHJcDR6FJqpJ6TvZZkAlmx3QVfqP2X
 0tO5YsElhVH2gWwzUE3MFfSm8I7JxWF4l7ZhbGRwXNSH/ILwbJR1FFsM0uftRBJTi5swO
 SRtq9LV6Lwx78sJA5dyPqE06m4DfK46sIFFtcdzVUVA9ZcEzLuBJKNuI3iLX2Y5G1ow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hfC7Ft57; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=hfC7Ft57
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 329F740048
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:18 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so16796105e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793302756; x=1793907556;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
 b=hfC7Ft57DlcbYK73L0704oJ/2p7rceGuY6VRsygmfXxuK/7sgapbgNc4bk8ovCTJea
 wE0sd0+ahD1z4fz+wIHjGB98uTPvU3NdRXABjy6pTi5lTamxtqRy/7ztXKLcqt9KvAp/
 F5lGVjyMyyG6MOsx4lD6y73OEPYTOV2eSojBI7e+2BdVdOKIc/9a328mX9c/A04z/pbc
 3Qcl4wqs4jazw23seInBvLS+ShcZwk9CP9hHizwliJpocMcMW8YPKtYhVBjndB93KIfx
 tDpKnJm1f8hBsjx5gi4bYSwumNP64rNTbfxPsdxi6h2wdySHp2BI4ky8gDhDFWlTcOSD
 iMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302756; x=1793907556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z/JT4OCApmUGk2p50DC/A7OKCkH91LrZuoNBOvJSO4A=;
 b=L+SuPWUuF/6vMMT4qDD89zlj78SMcgB/rLV3Ashz0ioM8Ro0mn4GsKgBMhS0TyJe5P
 c3hTaoQM5c4v1jSgqnVC0e0QAJLEWYNRrIMfYSxK76jv1k3Be57+sqITnNCfHJFrDIh2
 HRCaHxA7yGN7DKk7Gd2m4Z1yrn3qDSzehKgYW4pMIzF6p5Hf1tr8x6NjoYmPPvmjfySJ
 DCENBa/ZMABVr9AGRbpCHP6CyGq2C3vuZHikaADNUWc/1fJU+pBdVXHh25RqSCWF2GuW
 LXI/xajvJQ/dKTB3P90CCzIIJyP94y1LzWRDK8OV0NXuOhtFkU2goOScupRve0fzhj3O
 k4iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGDkOHHylJsa3EtL7w0vdTLAl73Ylc7KXDT/SbPKj/Rx8kfV4rKUSHHXP6tuiOmPwGsu+3znY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI4Wbj5NEJNWs3IXbSKSedhkDxyXb87XX6stYT4SQX7QErxAqg6
 BviD1rbVlzhWx7wIPTBCs/q9j+Ix1d+xiJGt1GGlr1ssHkXKflQw5rshnSqobqzX9AcUjW9ZMhc
 HF73M
X-Gm-Gg: AYBFou0OC++hH1qhTq5Fz89ZL4/P9QmvScws3Z+LSeGbia/oqk0OOmgmlT2+eNgB3D6
 OdxcrwjBz67iZiifF97gBUUP5UYdXjFE7LZX6BEmuJhK0fnHGOLdu1x+QpSi1iHLqrOfvJW9CY4
 Yn4HexJZHVLOwqoHv/jY4xuTtlAdAuBFE6RoX7w0lnnd6HBesCAVRYPmFwQBszNCXs5LL3qBnaR
 8Y1cKrpi0Vw3jgQT48kbr9jHIzXV7hfxfqJwwTx80xYVGuUwqxlr1NJPrZzgVn0yMjv7iXJ3BGs
 aTu/nlg/zAaJNKt3JiFM58cBiH27kxccANjO1+g7aZLklHbtRXkq53ILy5PGta6/Wd6mQLddtzO
 tghtpyQY1kFL9XAgpA/f6Fyih42wo7MJ+gSGlajEKJa6U4Du1rLNWHFEC4atE+PeAu7f7bpFJlW
 EziH5B9zPLnkPsuDDZX2O//1Y2rVi/yzY0mCJSNNizrYtPJr/XUDvc3tN/MnSsnCXMtS8RUR4eT
 SiOtpywScapZ/56XedLjy9uiA39NFvOL3t+R4HxuPnVT6V3s3dJ+pVnczS/vn/MyfnLMNaumEgd
 oho/TTWdrtxv1j2fmDdWW3U43bijUK3vrkjMtUxP2TX9/2/+oS2Xv7pofaRGyhVIeTnLFLhmMvz
 SbN62Q2NUSfCvRQZqDw==
X-Received: by 2002:a05:600c:1909:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4a9674e8089mr144348015e9.26.1793302756561; 
 Thu, 29 Oct 2026 12:39:16 -0700 (PDT)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm1987645e9.3.2026.10.29.12.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:39:16 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 29 Oct 2026 20:39:01 +0100
Subject: [PATCH 3/4] arm: dts: mediatek: configure Genio 510 and 700 USB-C
 hosts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ccaione-upstream-mtk-g700-usb-v1-3-6b0dda25be38@baylibre.com>
References: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
In-Reply-To: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
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
 Quentin Schulz <quentin.schulz@cherry.de>, 
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
and connect the xHCI controller to the GPIO-controlled VBUS regulator.
The shared device tree assigns this regulator to the Type-C controller,
whereas the U-Boot host path needs to enable it directly.

Keep the USB0 download connector and the USB2 M.2/header controller
inactive in this host-only configuration. Their OTG descriptions would
otherwise also select host mode when USB_MTU3_HOST is enabled.

Put these choices in the shared U-Boot-specific device tree so both
boards use the same settings and the OS retains its existing connector
and role-switch descriptions.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
index 6e84dfcc6f5..1aad2514b8c 100644
--- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -85,3 +85,20 @@
 		bootph-pre-ram;
 	};
 };
+
+/* Only use USB-C PD as a host; leave the other OTG controllers inactive. */
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
+&xhci1 {
+	vbus-supply = <&usb_p1_vbus>;
+};

-- 
2.56.0

