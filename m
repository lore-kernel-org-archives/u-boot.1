Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469A606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oLmwKne/;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EkfZDoZE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABBB040978;
	Thu, 29 Oct 2026 19:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y8tEjJ5IA4kh; Thu, 29 Oct 2026 19:39:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B77EE40764
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793302766;
	b=j8JBFb4ZQii2alE16J/zCBKr8XJKT+37d+v52WeCl9X09RF/BEawzyeg540AO15A8Er+
	 7MW/R++cIacYQrrbhqR9Jo7aYXpeWvoBaTZfL1S+8kSD7JReeBsh2XdFnNnNzy2CkG3EX
	 QLX1v2wWujeVgjB9+NSO2Fl1y705CJeZN/z/YU+ZY1xRQNzrD7LsD8rg2Kd65mgjUAPq5
	 hcD0X8GZ+wTFdjCNGYOmkzoWo/+SH8dqNsQMNSoGtTGeaiHw57LyDy2DJYk+QcXbfZl7V
	 xkHtFHwr09tcAg+fwOHGR4x2oOyWqIwQnICcBoCxqt5waaSmAiWFXaKo9IjVcj2C8TQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793302766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
	b=VWKvtSTnE08Vbc2lIVEKZr5W8v/3w4mCxIHAB/5ZmMHghvc8h7P+zKzdE9DTCXGCQ1NB
	 wy0MSqImQVuHLF4FAn/btiwKG6F/lO3EXMiLBFXo9WMHsX8XQIpUNioWRLpX+Azi07Ky8
	 8Dcbi+bc0PM02ays9wVgzmVDiqWGj6xtYa2Gqgh4baqM0JFefeK8T6Bb0B0Q+LHASnsuH
	 5aH/uoC0Tzx5UZvyhR+AHq92tItug44M3wKRgdaL8t+y852njIMD5ZbC5PQ716hc4RDby
	 QWZFsobhm8YT2LTFLp5i/OwxsKCfkrM7I0P/z7Omi09W2BNV6nfpfEB9RFmA0q7XDcw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793302766;
	bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLmwKne/S2OLRNHZVuQQvxVZsZgvAW8Md7pLZpRRD9AXvOpqOFEPCVycI94FVpOMn
	 0oFjWJqIdQvn2g2tW2r6PBwdwkGDn1znIUW7LS3qtvFmHwS3um1sSBG5IjycJhDkjs
	 NGuwmA9xowttSYCxXU7XnfFoBRqXSS74IwWj1/wtdhnQBAx0Uef6O8EeiUMuBEUEQz
	 Fy2g4J1Vb7H8WytlwMmzKbCq76Ry40X5GE7BxwA9RWNyKlz+6PpWcqRY1rv18GikUe
	 GntM/3gPDwnbblvSwl3sXYHYFPumYzCcoZnuXqD48NpLcWTscWyVRnG9XuvY2ce1R/
	 aQ8sdP+vL5gRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B77EE40764;
	Thu, 29 Oct 2026 19:39:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C465D1DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA953606B0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UO36-Zk2PPiY for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 19:39:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B489E60710
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793302758;
 b=EIgiRKqijJgv4i39KZJBXqXr5oP1cNDIKuEzjJxgMFECoGo/q/N+J+T9/s3rQe25Gbxm
 E/Vk6aBXEXID0Lq1wLZPdUuzST/myAMa8Q5Ki0dAGBArqcYxOMeFCpc5xYq/hk9GVpMwa
 9e3RsPo4KKyhSDYnYrr4kqk/fAUrcz1ZepxIaP/duycaKodHsAgOjIndxxgaggmzKyUzI
 3zzSVN+Gm5IsDZyA9Ld5f9aa/QfF6oW8L0Bmy3ONsd5lgvIpjrn097D9GBvVnUYioiYD1
 yAPKSMgqc1MgFWrjKxx4rL3tSdvT2svlfihDbGJVgteXqgRBsccAWWAdlVGzQla6aNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793302758;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
 b=grGeYGvrAeoNXI++CGz2Wyu97QtM9vojJnvz1PtsVROs6odnM7PLZQfOBRavaph+yZQJ
 4Mni5ZOWLyhphMWGxQNH8otPM2oKhVcewhzuJtdvcKs7eVr03/IKyRDuZENM3Gg28q0J/
 iIbPEWIa1X2gMcGjuN1SLoPaJlggzzb2zjCTholX5Y8hrC/WMgzdCSUfZB7FRLF2uoZG7
 c6T6YU/u9TURs/RAqLWm9enXCIksfAaa480Bsvke23Z9hyCbHlvGVd1qrgb0ByipmLTsH
 dLH8LPCp0MSc6kxIa7iRbvSBkoteHBjaTsUOxo6GQbtIo80jWWmqBdlc7PXUteMYaeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EkfZDoZE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EkfZDoZE
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B489E60710
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:17 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so26332575e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793302755; x=1793907555;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
 b=EkfZDoZEyAVDZLY30T63A9J4fxWTq6YRIolLIaCCyNbDWxXL1VY6EoFani8h3i+QHp
 mWd+EKTcUdItao2cyHC3ikyiSH+olh7QfNpHB+CZWIucST9i2cs+RqWH+MON4TXq5+Cz
 j2R5ukpYL2Q/5xL0lLROnn4cx8YjG6Cnh4wdh15dSMta4PLjDM3NV4p8oHGPgt+GGphx
 3tz4YFyhCnCvwqs+m5jSmX7gbdTD1v25EVdDqD0xTeQP5A3kvzQdmtWYa1GZ9CpHk8Nv
 PjzcuKuoFB9Icv5dwmyfZM3qEYE0SFEA6zY1z3aL6yaOs0iuTrxgttADIkCvcMd7XGeI
 zXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302755; x=1793907555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ACgWuC6pAePK4XaZtsOjEz3f8LkFy9doD8hlbKPZUqU=;
 b=iIWFXNOursNjwyAwUq/3ks4nW7itH36UJDY9wc6RbTuX8K2v2gTNP1FJAl2qlpVZ/2
 Mk/KZGCCUtNBJlVG1w/tXCKI5xUUE5e1KmOzhz8QKloP9gfoLU7ALXKfG72pJmE+DLNW
 ubFdNvRjaZ42gzF+20LGeLEM4V3GUTG2J42in9hg38Mqj0Vav6S6hgVXFA8NXXfyBOZd
 xAt5FX6d0Ki6Y21PQLO0N7G41Y2/SaYp5vm4eho+gJ1HFiMktuviy/T4ZAuLw7bjmrDN
 Hj5Mu6EBdfZmr65uFTb9lW25YjoWoxdCBeNAh4eJNLmzXO+oJi340RGHpXaUt2LvGjb8
 Oz9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAGdMQz0v7Ggtoq+ozxyFyLbHG3G9u0x5d8OxTVN+0P26CZPvYskfBz8oTYYnn9cLIrjbv1zA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJozikD2URN6AuSj0WokIVqYO1ghISx3TpMPVd6AJ9Y2xrP3DhA
 uo0l57K2dsQ3Fsazi0b2uJSnf/3j5/Avz8sR+LvJXwb14Fi/arZwcHgJjDdRZaKw+7lR6xuZvUh
 9Zzob
X-Gm-Gg: AYBFou2WGWUw6UX4c4Lierrpth6dyOS4UyxojOlJIq9z0sE2MRD6kQ5rIfzYijXD12a
 ZFVIpLu39KSX1JUfS8wryzUlOaTcvZ+AXcvWy2fxXaKp7A/OgqLf4Pc4Pbj4vdPFgIY9RtlJJOV
 m0OHn/iPWWtdY1iW0kozMOZ23b0L9vMVPxPgdGdQONqUODCQEpyLMn/Ua6nM0hBl6e4Fvee5UGz
 N9nlAF4uZ+mSpt7PpX4CPIyFkeZXAgY6M8liJz3gUsebcZZBCMNl6EIp2Wj/O3AfFPdodnHEFfg
 iZyhEXIVRxJD3WyMTGsBpeC9EsMl2Uh+hgLCh4YwS2FHZnJFsPvgzHTWCzwt8IEvdpopPGK/Fa3
 r7sBIY+78gCS23gifhfY4tR2S4jB5rIi+Aml4jDRh8FC8vejVmO+mOyCLCDfbzl1AeD1jAa6yJk
 QH8/kCVmifJiL9tLTCQB4cROpPyU041xsL0jVWX12L55IRRsYzKo+6uH9i6C4rHyxOpTUrgacnH
 YMWFJjZGH/gsRmhD8qfjGPAKd6WjUBwQOwh1tzosv6fyLmKpwip35cTKvM1LrOsmD27ZP0RDKsn
 D9BNhDK9zcN2QO5sOowPM+5fhH3LILweMqYnvPa5v2l7Q5J7cyGgO+UuoiwtBFQU0IqW6wq42eX
 sa2eUkiMMYgrXBEe5AYo=
X-Received: by 2002:a05:600c:3b0e:b0:4a7:7d22:c50c with SMTP id
 5b1f17b1804b1-4ac150b2243mr255955e9.2.1793302755324; 
 Thu, 29 Oct 2026 12:39:15 -0700 (PDT)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm1987645e9.3.2026.10.29.12.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:39:14 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 29 Oct 2026 20:39:00 +0100
Subject: [PATCH 2/4] usb: onboard-hub: add TI TUSB8020B power and reset support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-ccaione-upstream-mtk-g700-usb-v1-2-6b0dda25be38@baylibre.com>
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

The Genio 510 and 700 EVKs describe the USB 2 and USB 3 sides of their
onboard TUSB8020B hub with usb451,8025 and usb451,8027. Neither ID
currently matches the onboard-hub driver, leaving its power and reset
controls uninitialized before USB enumeration.

Add both IDs with the 3 ms reset pulse and single vdd supply used by
Linux's onboard USB device driver. The existing peer-hub handling keeps
the shared power and reset resources under one instance's control.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/usb_onboard_hub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 0684f7bfd47..ead8bf44cd5 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -289,6 +289,12 @@ static const struct onboard_hub_data usbhx3_data = {
 	.supply_names = { "vdd-supply", "vdd2-supply" },
 };
 
+static const struct onboard_hub_data tusb8020b_data = {
+	.reset_us = 3000,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
@@ -305,6 +311,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
 		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb451,8025",	/* TUSB8020B USB 2.0 */
+		.data = (ulong)&tusb8020b_data,
+	}, {
+		.compatible = "usb451,8027",	/* TUSB8020B USB 3.0 */
+		.data = (ulong)&tusb8020b_data,
 	}, {
 		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
 		.data = (ulong)&usbhx3_data,

-- 
2.56.0

