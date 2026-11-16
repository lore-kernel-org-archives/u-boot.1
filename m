Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36B606A333
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=caqPMDDC;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=pl4qT46u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5013481067;
	Mon, 16 Nov 2026 21:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6FFSnUQIH6X; Mon, 16 Nov 2026 21:35:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D1918108A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794864928;
	b=ABLbt0lSzVRvPWp8FCKvW5ONoU8kEXLEZOYpqMwUMUcgn/+sLtN7Qm02PQX00EQfvDzz
	 pqHmwtNgc3Y51Ire7eHXUzGuTadjSV1oDU7hXWmJAobz68ohGarsrRa0K9Z5O2DXtaOcN
	 hFGEE+Ftxq6R0wDm78pvcGQ6EKbGxwbN0UW3aCUk1Ti1WNGKbqD8aGS43PkLhM+Au3LzW
	 X6sJeQRpGMUfCHCWvF+XIVdxsI0DkM9HmwmkllDDe1DzPTgFzipCZKaidOOgOKAg5+a+J
	 H+A5JV6MjNKr8uWxKCi7kcwHBfXGQDrld2JXyGHXV1+r2sym7QQMr+PF/MF3ooDLWXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794864928;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s6YBEBipoR0F7bqV3F/gq5POdCcS6R8HU5tD1Uy60/A=;
	b=LGynw5Gycw2jWI3w39hS7IDe1DimS/g2j2jmS/kUADw76oBWmVU5xJPME9wN1tJYGTyh
	 Lf5WWyg+v+W7NfHmZMWV1nxvV3aVfHmA9a0oRUybUZHKjfpL8r7JpXpYttioWjBhcCmTM
	 31l02rws/EYsGMAm3+PFFnLyl0XNu1bjfmjKqUf/1XBqaeydUEf2w5Z9bnDF7GO5RL3He
	 v7QT6tim9jWH6shNCXpntzQheFPO0oCuaVUDz2XX9pYr/sasBh3g66HD3zlkLP23hQAql
	 /0MR10BYXgKct1v+cdraujNgLvP++RsHXa2AZdVbJ2X/PcEjZHW3B6jXBjoKXFwel0A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794864928;
	bh=s6YBEBipoR0F7bqV3F/gq5POdCcS6R8HU5tD1Uy60/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=caqPMDDCwsDrCFmNwCARoAZZdRt1e9SBTb6iB1s95p/HcyxJqmuimNMyMrI2yS8vX
	 GPAJnGoGjbN1M8xX0ygP+177Cu/fS3BfX2N6vjgbvuSWBARCIP0aogHTVfMi0LFBtc
	 q2LKsuxQtALoT+FtuF2IebcxfG0dqonx8i6tiH21h35E4PDqiizrcuSpFj5h99mT20
	 J9TNmZlKRkbhe5lwTfk5sdhufK+3dcvgCeD8JQLbJSB+wPBykBhWShVqFgo/JnXcCe
	 G10tKEBdGngj6YRQz528D+wuM12bU2TSzZ+fTj9NxBBZ9OU6OtvsSEjhNDEdoHRgAy
	 /Am32enAMBbhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D1918108A;
	Mon, 16 Nov 2026 21:35:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1406D1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE6F3402CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydhOI9PDOL5C for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 033B6402CD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pl4qT46u
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 033B6402CD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:22 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso21130215e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794864921; x=1795469721;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6YBEBipoR0F7bqV3F/gq5POdCcS6R8HU5tD1Uy60/A=;
 b=pl4qT46uBRYTJXeCfh45hDoOsJ3w+9HoYl3tF37oXgDhXQheFxaeeJl8zAOI2w2xBV
 teMhH2zqsBpQOd8VqQkqM38eEowZsqzILZ7/XLwdimTbyLkkL5+JFuCC7InKtqDZgvN9
 8rg+v2T4lTkBkDglrXI6OOc5Qcoz6LOe81QbiM3iRXFPiM1zxsmEHMEgQfrP+IpG8Sfw
 gnrrBOUmu9xHuYsfdg7JSLZ9USWr9UUrIfG/hZ6vMPEEWgJmwGN9CUoOtvz7T1bI9gsz
 DeUDhbD6HyGHaiZ11IS1lcKSTniVky89Lq2FamQK0A7Lj27+vJxcJd4rPv1vDVleZ+Jz
 rlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864921; x=1795469721;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s6YBEBipoR0F7bqV3F/gq5POdCcS6R8HU5tD1Uy60/A=;
 b=YGNgmyfahj7ke1PEqLojuRBoRz7POELdFfqtq655KPIhmvJFZsojenoLNCaltR1NAr
 1QqF3UU5pG+FBbsNXaFuUxUjUhnr5t/T7ZGECWc0nkwL/W+O5fAFisHbraleoMcGFCjg
 Y5iejuviWD5vfsEOZO+ooFYmx7N8C7KY1GXb7qUUTJksTF+E3PHq67u+rohp1F6TNcDf
 a1q9ZfjpsmJxk0I+cJrmqlhixTk8DjzZF3SH7s781bGJKBSnLphA0iG2LTvaFyTMG9JF
 o4K3jPHG5AIa91D84iSH4ges/KbWTzaNVz3ldd2GZdxTV7AHpxYTDwmiebsO6kKt4QVp
 qxNA==
X-Forwarded-Encrypted: i=1;
 AL+hErFcjc59DZsx+fY+F9jlX9kB4EsSRJmMgHnKHHTLyttPTPBNtRY54iiCG4igh+q42w9UWtMvWn4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9SxVfQiMPCWDy6kk+qOev38r6+XXDpV9qZ52FWmWLogeFDXDKC
 LdXRdCfhXmPgloP4U73MODHmnV6qzy7HKHKpu2hDLDTwlAWQSKvsC2yrpzVwtskz1ck=
X-Gm-Gg: AYBFou2H7WF6yv8BMlBe3ZiJGymiW1POYmVxV+xSKSqOU9dIMOPC+J9DcqGaXwyu8QC
 0tAJyxYVpQugqzPPDpOQrOc6sFr9rY0cJhtGNfIp9xCRZN7nJ0wu1hdr2NSUOhUR8L3EW/87cO+
 LtKlQa1vZKV/3ZAl1zhTI6bTBq6I8Ppyia81V/2HPQDvPu3IqL6QoTnPVFtn35ub3R4h1V6kC0T
 2/I3XjnIa7ixtzszLeULG12hPjo5Wmk9Zh6sM4PplBuB1GAUYQ+7xPh1CpH87JvnwOctKXtw0dj
 Uzs+8eGsYlSp0aMgkp8rPusvnj17NrIKYpJH1SbjqoSUuB4H3P4+LYXaz+EbbfDMZTsWupxcIdV
 Kr5V+FKubZANdKYSMzaCkCjHL1XHDCWXR/l4cc38xSkHQ4N2VL29Ag+ErhbyuvB5XAZqDEi4R9A
 Hh8H7xc1tiEeiElLpiVJJeCXYuog5WomIMyQcIa5sHuOXXL/QeMIQV/0FbvITLG8R1DesbZgSMF
 L0A5qdXDK0C89SBimaoDYXO8xHGnbSgooGvv0tYu5cyWVyiaDu2Ab+QNChnLEp0JEdkqlxusj3/
 mJ1Sil47HuvzlnT0h+S17B6Lj2hTQweG0NalJtYXx/LLBLLvsS2k975bYcJb85cR3kMQX8oMp5g
 7QbOwhLieNgb1/wvPEA==
X-Received: by 2002:a05:600c:3e1a:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4bb55a878camr215143595e9.27.1794864920767; 
 Mon, 16 Nov 2026 13:35:20 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm26314066f8f.0.2026.11.16.13.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:35:20 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 22:35:01 +0100
Subject: [PATCH v4 2/4] usb: onboard-hub: add TI TUSB8020B power and reset
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-mtk-g700-usb-v4-2-2de4cf90365b@baylibre.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 510 and 700 EVKs describe the USB 3 and USB 2 sides of their
onboard TUSB8020B hub with usb451,8025 and usb451,8027. Neither ID
currently matches the onboard-hub driver, leaving its power and reset
controls uninitialized before USB enumeration.

Add both IDs with the 3 ms reset pulse and single vdd supply used by
Linux's onboard USB device driver. The existing peer-hub handling keeps
the shared power and reset resources under one instance's control.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 common/usb_onboard_hub.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 0684f7bfd47..f0e84730482 100644
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
+		.compatible = "usb451,8025",	/* TUSB8020B USB 3.0 */
+		.data = (ulong)&tusb8020b_data,
+	}, {
+		.compatible = "usb451,8027",	/* TUSB8020B USB 2.0 */
+		.data = (ulong)&tusb8020b_data,
 	}, {
 		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
 		.data = (ulong)&usbhx3_data,

-- 
2.56.0

