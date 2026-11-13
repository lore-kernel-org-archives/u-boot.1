Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1488606A32D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dug/IJgj;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mW6c5mV/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD36A4095B;
	Fri, 13 Nov 2026 15:26:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pm6k6WKeThPi; Fri, 13 Nov 2026 15:26:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A862409D3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794583572;
	b=TYHng4Q5rfiz0xqUrwUhfiH8PgK+58vbOIKD/rWesppy7mhAnCReVcFu2CUMDuyxc/Vc
	 K0NaCjRdUBgk+7kFDBimpXBN2rfKoRJbx9tNCdLvIpiK3zZ+82PFtLSiC1OG+Isv3poOa
	 Kk4nhiDIGP57UFiLQ8YuKXpFZmXJVcGzBNyEvlm4icyP9oVDTgSYgKvB/blE4AIirMr7Z
	 IfyqHvYl9WBuSrnsAl+fZQDsDrwJ82wtHswy46jltZ1BXg162LH3qVgYuUtssS0eQbufD
	 XxvNC6fjpp8xyrPNQJZtczg8J0FeOnxsYKbM1cbnN8ODLrV8ziRDn6QXvxndy3Y+S8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794583572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=crFHYtpS9BL+JI9fV9vR0h/NR/ERpfbEcZwdbIHlQUk=;
	b=pSJAx5NAus5IMY9MyqgO1U/E3X5/E2D8ISdoIMmeZ3r4k6YRz8qaPIu+WbfDZAgTogr4
	 jhQJjtdbsLpJTccj01eVL+6XtsqB7zW/myk+/Zc36XQ7G9iuyM++GKEZs59lFry/Tf3rr
	 2NL+bKXvDEyQj5kiqEvGSmmOy5XFclwTnjvmbwOcOPxq3HDLAEARAyy93PdHa19uul5qo
	 I7uotJrQh0A5loyyuBtQWtvjlA3weTbjkcbZPb3udttl6frf+XBdo1dUvGoSP7evjzZaN
	 gbPDJrl2AW2LiCtuKr1/qbT9y8UZsTQsqOLHhzBl37BD9/vqTXxF9SwMze6UJhouyIA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="mW6c5mV/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794583572;
	bh=crFHYtpS9BL+JI9fV9vR0h/NR/ERpfbEcZwdbIHlQUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dug/IJgjGCJ/4RXjtoCtOegGnMfnvl/+D9UnBqn5ouvAJroiRDg+SFbgbSh9haUtd
	 lzJnjZKv5KCgVT337/QNBBsofNpGHpAFzPSbLaBFQQrw2EkRyGxMY4iRd0sTKilrfc
	 sIjagI5u8hMT7FB35P8naB+lx5XMxOn9MqPJwxBlZlTgY8Oe4q61MHKAjzPP5+nWcU
	 cql5ip5VI4+JPFQC7IW504PdDcP2SgTrdwXzVRlEi8rXwWwwqsMgLZnu086lCaGvyM
	 JJG+XJPbmzQYqtcZF0OBmxKzZEdFRYgebfGZ3MA3sFMaWLo6/i3mUb5w/nOy877yFZ
	 YNxP1vYJ3R3tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A862409D3;
	Fri, 13 Nov 2026 15:26:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B8ACAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3824F4096E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DuS1GPpKskM4 for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:26:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3D1B64095B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mW6c5mV/
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D1B64095B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:08 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so3977435e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794583567; x=1795188367;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=crFHYtpS9BL+JI9fV9vR0h/NR/ERpfbEcZwdbIHlQUk=;
 b=mW6c5mV/LONqorxZXo4sCKeryCIweKKSPLMRhA1G8bO7Av0g0rWhx+wPCvuk5oHbs2
 8asb0yJt8sfVV2jj8da1YrzrD+9RmN+mHTlOf0aE0+f3Q1RCK6JiZSltWvF4C6RjrwP7
 wfH12SCpXnAph3UFZdzDA/ygiSx0UrsjfZ8i5n6HlIp1zLXnJVnrR7r8IYp2CTlpNA+x
 4h13fpFWFwyuPQOhla+ft086v/wP5vkXofyt919kdQDdUr+PyJa+gvxMB01t1oW26l94
 pqwbjAWLxSbAKZlmdvz3Y6khqIfApZBbOAGM/Ifrp3/KM4cZYGlh72nggS02SINDN/Qd
 tORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794583567; x=1795188367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=crFHYtpS9BL+JI9fV9vR0h/NR/ERpfbEcZwdbIHlQUk=;
 b=2SzI/I5XnbvwsKReb8Yp6AWdV5tVM7FyIXuOh4Ye0+9WKqZHP1Ux1NTTwEa63YStQ/
 SsKSmtSkvnzRdbYn1ZOSCnRhx7AyNargAvZJoNi01+5i233K9TwgKhXmYjs2INLjBaIY
 xzDfWlfAiuoZnohzbwUcb1AhMJQ5W/qtspOHH9YDiamld9038OztMzqzMKvWGTppEWO+
 erG6aNweEx3EnzsH2k/Snu3KFHMfHGadGMtC4dAbiVyzxEg+SiRhCwbFXn3+TpgH5dyY
 h29XD8ER4EkzeDTcdVR88egpfZzrgNZbXVUqQSs5IpNA9XV0XnDFWtzrzRtU+pRkJTjE
 ryNA==
X-Forwarded-Encrypted: i=1;
 AL+hErGXXfP7SdYxi7//+V9Ak59jQgkP5/3Ka91KDCD8ZpcngiQX1vYX9NbW9GdFBZ4nUW0OceQM9X4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9RR4oDOKEIinELD6rnGW20NKwnPiU83nBzN8KWvEAGgyTXSe/d
 lgtvn7smLI2IWYqAb92S9rY4wPUvDHmoYnV5W8m7LOVR6QHyTmijacL17qEJ9ZfCmvw=
X-Gm-Gg: AYBFou0GeDyb9PDe9wvQjfKUpuuPOxPGbfqprdbhGr1/WTmiEuUJlLSnJlWgfhGVkQp
 TP/7IhALdfIZesrxxWOU2yPP2D2Q5FyllUaJH+Kd5q15ptNsLvvPppQjkrtj5e21E1PmfvO1YFf
 3iTxXsCT6QZTlj8c30ZmmPsRt3gT3VnxoloFkP981J0FYHB5uySs586DLnfnpkyYN2OVdT/LAez
 UstVlAV5h793sTKAmKzVdGHi4zbz/ig0Vs0IA7bczMHzafRSTysuwqgHp6qV/pcT+A3gkZiQdze
 uej6RmkraiU1rUFgAChFg2xomo/0lMKtJqD3xX/QH/RnH/QWp/2NGV15nmrJDbvc5kLOE3Ko/Rn
 L2ms5D0PxpO8wUc7UO7khOCNF+8xq4Tl9v1cXDtg0ACqukHjdDy/frtIQ4BTh9AQ5KKO1cZC5zb
 zdEzvFkHfH8Rv3ff+iZ0UXETK8XZ1xo8+1TiAKGa2RtLqHTdK/Owoi0l8rlVzehtdS37BFbUyI7
 1n/LfhkeaUVlPWR43LdGEcyAfwf1NnKWS6EgAKhd+8foSGuarcaCY2CuWqwP/zIkr6EIej49r+e
 15eFbg+cgupmGwL0zXlxPq6DXVmPK9uZG5JKjNndXRw2ZX32LJFEgnp0+k+tapeYzuRE8l22K+F
 RMr8Y2ysMXt1jlLY+RUVNhyJC69zyUoglNgir72rg7zs2VQ==
X-Received: by 2002:a05:600c:1d08:b0:4a6:b49f:9ae5 with SMTP id
 5b1f17b1804b1-4bb55a898abmr54239265e9.34.1794583566517; 
 Fri, 13 Nov 2026 07:26:06 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ace535sm70042255e9.6.2026.11.13.07.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:26:02 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 13 Nov 2026 16:25:40 +0100
Subject: [PATCH v3 4/5] arm: dts: mediatek: configure Genio 510 and 700
 USB-C hosts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ccaione-upstream-mtk-g700-usb-v3-4-78b554604bbb@baylibre.com>
References: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
In-Reply-To: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 510 and 700 EVKs share the USB1 controller, onboard hub and
USB-C PD connector wiring. Use that connector as a fixed host in U-Boot
and select the USB1 DRVVBUS function on GPIO87 to control the external
VBUS supply through the USB controller.

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
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 6e84dfcc6f5..e1c446d4ee1 100644
--- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -85,3 +85,23 @@
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
+&usb1_default_pins {
+	pins-vbus {
+		pinmux = <PINMUX_GPIO87__FUNC_O_USB_DRVVBUS_1P>;
+		output-high;
+	};
+};

-- 
2.56.0

