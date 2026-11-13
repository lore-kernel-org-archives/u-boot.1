Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7F606A327
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OskdWsxo;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BsU4Yogc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 053E56069E;
	Fri, 13 Nov 2026 15:26:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53RDDZhFfZLM; Fri, 13 Nov 2026 15:26:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C02B60619
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794583567;
	b=Bb/XZPJLOykatxO4eMD4ay4Yb0utrLXrllNv7SG85rHs7V6V3TA65mBtzHDWLo6JKoQd
	 xXemMaMLc1v8UyxEtL47qLK0NAaw/XfZp37h0ZMfSjmUz3yDwNSr0CQbXiU381uLQFVzn
	 lVjkI0bVUE8Aq8CsWUm5B6g9XbHw7b/wnr1nm4iglK8/w6+eolZoknpS1ySn88HJ7kcVS
	 GiG69FxrCga7tM73HRTZ4DpPrXD/+T3ojkd48MMatuQHFY1qkb0RwzGarHGE3NIe6iYf2
	 WZF9DjjRxte+zsiJFNpdoCcwNkb+TvHuVuwV8A3vur1YLpHPLUMrmYCpo350QxeEhKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794583567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fHIE4XnjEYWDP9GAmvKmWYZE63sCzfDxDJBWt/+t/d0=;
	b=Rz2pMwYs8KqQStHR53Cy/0eyD7VSrDqDk0KJJ8fyeqA9efG/zFocnXHmolMup5J0IR4c
	 YKWxl/X4yH6N7iaZYT74LIoap+V8oXaAtD1ArgoZuwvShsMJhzIoQ9+kQu3IC6BNQKZQp
	 eqQ8l3obVwwgCO5FXEgWNL8u8jSq10nC2Fz1vTHNpEb6dIZBG01UgyRhAxZpLNGz7zdkN
	 QH1WEym1O+JkVBYtHuF5lBXjimDo3IA8YNGdyWr4AqjAddlK8z4MCaploA8Tjmtz0WV5Z
	 WGdzhLDoZN2p3pVvRHO3opQY+hE97umsXUpBndASZ46WKXmPD6FzNT02Q4j2+qp8Lkw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794583567;
	bh=fHIE4XnjEYWDP9GAmvKmWYZE63sCzfDxDJBWt/+t/d0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OskdWsxo49T7MWFD2UKVKgWNVll9FwalQfv5lgVZYKHiWRcaxyaBuLp8HB22PHSOx
	 CWu30TM4Akt92qke9+oqCLJrmRnZ3tQkHwhctfJN2xAsMBBgLAkQfAZfzJdKL0TYNP
	 UeUga/wKKiogH/KU3lWS92jNuMD5elehew69+UnPTV7jcs5YcGDyLDrNemnqqhBX7p
	 uf/rciZx7KwhmeL/vbNuYDV1U9MPSmhbZfkMwpQcBUhkWTXC4b/xdUkuxAxy2C0HDf
	 PWB90D6rbhkACc0RlYXJ6RFe8oeVH2PQh1MwSnMlNU2+5v0i68JQiPfrYHrHf3+tTb
	 KJd2eESX5Bdcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C02B60619;
	Fri, 13 Nov 2026 15:26:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 824AAAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7392C40955
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3aVOGpi0YHE for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:26:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 542CF4094B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BsU4Yogc
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 542CF4094B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:01 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so11850325e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794583559; x=1795188359;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fHIE4XnjEYWDP9GAmvKmWYZE63sCzfDxDJBWt/+t/d0=;
 b=BsU4Yogc7r/PMYRdS/jfqoYI79GpIhKGO2vhBFiA3n/ts19FtkVp1ihUDh91tj+QlR
 DxDVTbnFe1oV8gVxQ02+AOtATSBaxLVWA8xZCzyqNBkukAd5KP/DymCoLBq/P11S9cPV
 nfT7p32O4snfhjqfRagS4ee/1RgezQsEPB4h7drwx/4SKxFUpe6ccUaubFAll/nlkjxf
 Z+G/b5iMo/nc6Q72ondPtBQApQMiWMyWgzZWi83+0pKJSBRp/uZ4s+A0U3pWwSbFhSKV
 YwdZenHwURPZFOA6ibA1Mo5bpvV7BuAboKWQjxXLWvNP4XyTPNmvqoZCNjk6KaKGFxoX
 Vgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794583559; x=1795188359;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fHIE4XnjEYWDP9GAmvKmWYZE63sCzfDxDJBWt/+t/d0=;
 b=2pXYoUrCx7G3PWv/u/eRknVXW1ZiPUpIddZEJ8vXoG6fB0r5rFkQM6qt5ibgIVUtn6
 uFDPxvgMgMwA5pcgmnJ6Db0+nu7XJ8XVxjDto6+U7u2XBcRH/xruBSy7lxt+noOE605J
 ueDpEGhuWAX/0Lq9BaPqN9UcX3IxD1sQkdY2BiqOIqPAcpAa0Q2ijLCuS6MsjC53qBpg
 ZDaPRZesgku8KjsPTAQ45599dHtEv/twRyxPiJVmeasGDwe/hd9ZpKn+QeHUP6SGR4sh
 Q6hRy0+yRGl+TW+lJK4qRQ1NBxpj5qKE30YshwAaWeA2ijeY3oUWGWp3ozYSMTkIqWl4
 juBw==
X-Forwarded-Encrypted: i=1;
 AL+hErF+xCPRGlWih+ANXIQ3TF4h4zvQXPws2LgBxN7b6UNfsAuL6gK55Nsti76eF+HV0XcbH3FocA4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ZQxYqG8Vv5B6wnOLKNtoFoHP15nhnGmdbhFwMg8+yldb9qUFC
 shQ42oO/ke0+Pyl0SH0t7M3khFXw9I0BYARzBHGMQ+Kzcxzp82ylXN14BkuZWat04DE=
X-Gm-Gg: AYBFou1W1EQ/ByWh7wSSpEy/ArCOpJ6GfzWukDElTJjse1QP4edD+/PowE3umUDIu0Z
 Oa5OruwhWP8ZVhq03fUgExYFmjtJJIFdJoqTiv8tCR3p1y7mtXS7N+3w0Oh66EuCacdBwEPbOk+
 WJ77gtpWf3bp6GSqI10IzDdCRltC7tJBtwdQKP2uAG6aa3eiDgVqXUHzfTYSKn8SFT68uBbXls2
 usSHMHruramycTSOjc26e492CfL8PDHUTO3DamZK2PHISdEhLpE2a8U44KzQSVo21BNhZDlGdHM
 Sn3l/zljwr3eqeGeEbYKybw1G1Azp4cIIbrUCs5VWMLrpYFY5b93shbwfsgiJyZfuB4/oguaiPb
 GWFgJSI0MPX/qJcw6oaX2h9DuHHjzzjRHH9dvvYBO//+o8gVGp5k28f6SNsWxlzLZz+vKKZGKj6
 v91Plq+6VO8pLF3AkezKOFDCGO+KBry81zh6az+zFE8SWyq1TA+xPO3uIPkIHqes0CO/2nAyKki
 vCPGBKl0dxpDc/ACcZq9lfvmtYr40PuyD6NmLa97SLxWvkVGW3fGH49P4YmetLfpvlNPwOm9uIt
 5JRjqYULgzzGXvoR/Ert7Z2m29DYql0d7RId7WtNBrpNw61JG9/886h6xEx4xEXzHUQlTKD8SnN
 YgjoWJlt8+DQuA8bfNwhefT6wM5MdENW/3rgaTg7ObR3XFhWzDb71vC/+/GUwNSuI7RE=
X-Received: by 2002:a05:600c:4f90:b0:4b7:6c16:7b43 with SMTP id
 5b1f17b1804b1-4bb55a47602mr56720625e9.10.1794583559446; 
 Fri, 13 Nov 2026 07:25:59 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ace535sm70042255e9.6.2026.11.13.07.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:25:59 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 13 Nov 2026 16:25:38 +0100
Subject: [PATCH v3 2/5] usb: onboard-hub: add TI TUSB8020B power and reset
 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-ccaione-upstream-mtk-g700-usb-v3-2-78b554604bbb@baylibre.com>
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

The Genio 510 and 700 EVKs describe the USB 2 and USB 3 sides of their
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

