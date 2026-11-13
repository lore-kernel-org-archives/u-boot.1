Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85A606A884
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0iLHmLY/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zd9xgdoV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 433FB60E79;
	Fri, 13 Nov 2026 03:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8Se-gEuxt4e; Fri, 13 Nov 2026 03:16:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B69660DD9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794539783;
	b=q0zmahkSMwwHv5uxPIRvhJV3P5GwkMoroF9Hkxs8U0CUrW/CVFMqtAG3WcWNjkpKDozc
	 43ytnGH6Mh9+Z+PxPUo72I5wkoB6qSzoip3Xqo1E5qdusDrfTjvM9t0N+zkgXPuV2ax5+
	 k6+b+oT6JrpSMvgUjml1O93ju771+bjFtOTkyk+cnN99nRO2caISeI1jl2FbS1kjitiOS
	 NkxeAeuSC/Sfvf6CWx7DSboYUlN4b0VD8+OhAIrT9bGQtItNgezCli1KkKMWWh4yAS2gF
	 XdU40U0mMhIo8jP0mFR0fQmDNyIpoEScLrsQT9QKN4ON94LaWCM7iVBPiQEwU0DJtmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794539783;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ntl70ykQFH5ZmAVhjQZNb9QHeIyY02TFXdykUadSKBM=;
	b=Ykak93epBMAajFqr/M8p3RO8bjQJ7aUbLRalrIkPg/Xmf0vvuse3I+fzL2IF5bPohOXv
	 U4wAMLqObk1oX4+vmVHwsl37G5mrPi7TqcpK6wJl6C5+1nUqSmyKT+Kg4B37Hqedfil/n
	 SxfYCUKLzTBF2+2lifh/m9lLAvN5CE+rQJV6GuhjApV3EY2nMH9RuJN45SVf0yfK1QbSa
	 /XrY0gAYTU/FgnzMyuT7rm9naT7O9Yef8Uu4XmWNtbD2YdA9+bcILog7q/ipF2iAGvZ/P
	 WeTq97YdtscIjh/nb+UayS4xAy7dxPIvjjw/em/kBHAC4Wv9oE1xWq7vR1r0rxx36rg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794539783;
	bh=ntl70ykQFH5ZmAVhjQZNb9QHeIyY02TFXdykUadSKBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0iLHmLY/SUpUDAn9qU5FWBVz9aZ0D8umlTi2D70waWxdnPW3ryKv2SW9sDF81CwIt
	 Q7EcItC9FnE/nLrCEpGaUAaW1gI1gfQls2a1kiMe7m3z5KO9ShpBEoBBiIA+J1n9bp
	 Gx0pjPRQIXlURaqV8VwcvmAzdMEo5esbPD0p8tNiqsdykf5b0Yx9yob1KzNsBn0WxJ
	 eS8Kc9DapaMFq73Q+7jsMdLU3Voko2IxEgB2kmU4kfYvFqdxOb0841vetWmLBVC/61
	 PV/nO06UCEMtuIGv+TYuprh6s+AbBXjz+n/JrOjuY+xjTubl3HwPFDMGaeHz4TXH3y
	 FL38Gcxl3ZhLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B69660DD9;
	Fri, 13 Nov 2026 03:16:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CAB61370
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7762D40D77
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lsJU6P1WuWv for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 03:16:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B019A40AE4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=zd9xgdoV
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B019A40AE4
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:21 +0000 (UTC)
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so593137c88.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 19:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794539780; x=1795144580;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntl70ykQFH5ZmAVhjQZNb9QHeIyY02TFXdykUadSKBM=;
 b=zd9xgdoV6jvrXSZ/N3cVG2s64XChWcC7240De3FQKxM/RZhTpO6j3QT/p5kJqsPjRZ
 RnRptquL1aTcGhK29KizaqkmNYAYOIvOZMaJFpA1r57qC68nCrIScwvLszSi35vLIPk4
 hBUy3q9AB4P+gEiMF7TVJc3nXPHChrBbzOXl3+Wid2n6hyricTam7bYFdBq32vrNOpJy
 L+6/3NJhtRabs/36vB9+7g2agQ8RP8dJAkCeM1H49L4BmttHfZM2OJ5tg5Emj+pIF8Y3
 3hnopdTbFRsSWd3hySfHcNDJutbMgKg3xbL5DXKTskwj7gDjF9U2iWK5mS8awdfokvIG
 gwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794539780; x=1795144580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntl70ykQFH5ZmAVhjQZNb9QHeIyY02TFXdykUadSKBM=;
 b=w0hOJUzTdO8qrN4VKzlzToKdh2YK99Ys+L7FUUVn6owLpISnLpk7mF8yVqVUbyxzbh
 XLXXVoSkX/NlzUcShDS2xGMDWfNPdoZawRovfVqEL4YSZ6CMoexME5ClOuN3iyQtFXX1
 tVpc8fgysBXKdrysziJi79o2nJCx+z+3j24y3AHsLrEP+aP3zdTbhvnR+VU7Lc1kUJB1
 QisBNqN8R8JvMmiPOKE49K4mbkZHGw5UENDhYCiBagbSAHX/iDdHtWH5kBPX0gyKkEPf
 ck8ef/uvIBngenww1IGjch6nd/2Mw0+7rFbMX6Z1eCP2HukBr1qmlOZB/Ts2gK4qvbGA
 cSjg==
X-Forwarded-Encrypted: i=1;
 AL+hErGZWwa5kiVvbBa2IqNEqwTyqSBc94GYtNwuPQlNxUEt3ZFZsd7usDhAhxE2KfAmRn4xfwZEC8g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/nBo1DHIEDmXDGQIEwA5UVyp8nvXsle6akmadRCqh4OgOaZj+v
 W+XlYENnF9zixfx+2xCWpKJofPV0ib//JhIcjxcM5MpDFbUzQMBx8giC
X-Gm-Gg: AYBFou0XSFGtQEkJgF2+6dfa98Lgj2fjteLr/QaLTdh8vYSxoMnRExwUXsm0LfccY/6
 lcFfd12623EwMu3+RP02JzunZN/D9Y44cNHnSIzEdVpRYl81i4LSjAQHFfXKlzE2ETZFU+8zXc4
 7341x8ICHa/ehdJlOdMyGF76MxR/K526YdjYirdgzRW4VI+ohOlGu9deG/wJ6r1GDYD2zHQ/AhZ
 uSOGTvLx4JNYxn9E2DmqQ+0T6wn3wtIPBqhvJCupIasLBOM1zN/+zy+jqlVjhYIx7/qiyTPereM
 LEF4hn9EKQRqs6Woo2wP9INxGinRcQYE8u3j+k5i2JT37DmKVl5UV/lG5x3nw/RygYmyPZbwEwN
 j3Z5wwsp7AJ72sPLwtjDqdW2ghI3dlcawgck4teTpjwNKbtJOu4NQj+ByH9kPuvuX6b5R/ddB9B
 3Tv5N6BeLBFeUJicrkSPTNHmTNB3AIgauZR5c9LNn3GVYW2YFpufIE5zHL3eAg8kzzhazSKJLE8
 Vvbzbrm6rg09oYxkNUM5zfnPxvh8zEV9G2sSRxB3qMQcfOe7LuRNDleU3GSrq6j4E+LuAmCaHXg
 9s0yfyQt+CKDWsdbUf23oFrWJFRS9zpBhrXKTyKdw3GVvUtqNgHdb/4iNTKW88+E0+mv5SmE6JE
 7JCI8t3+ynO1UZIkpWP/b76rFiG5FJbbLIYgBrdCWDQtHvyZRzxtJl3fNg+j1R7lNKGzFeOLiCE
 3Ob1tEqEZB
X-Received: by 2002:a05:7022:3c84:b0:1b4:fa58:9d3 with SMTP id
 a92af1059eb24-1b5030bb43dmr1289944c88.24.1794539780104; 
 Thu, 12 Nov 2026 19:16:20 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50313d990sm3864579c88.4.2026.11.12.19.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 19:16:19 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 1/2] usb: onboard-hub: Add support for VIA Labs VL817
Date: Fri, 13 Nov 2026 11:16:12 +0800
Message-ID: <20261113031613.435429-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
References: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The VL817 is a USB 3.1 Gen 1 hub controller with one supply and a reset
pin. Use the same reset time as Linux.

The Milk-V Jupiter and the Banana Pi BPI-F3 have one in front of all
their USB ports. Without this, U-Boot leaves the hub unpowered and in
reset, so no USB device is found.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Tested-by: Zixian Zeng <sycamoremoon376@gmail.com> # Babanapi-F3
---
 common/usb_onboard_hub.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 0684f7bfd..0ed70a6ba 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -289,9 +289,21 @@ static const struct onboard_hub_data usbhx3_data = {
 	.supply_names = { "vdd-supply", "vdd2-supply" },
 };
 
+static const struct onboard_hub_data vialab_vl817_data = {
+	.reset_us = 10,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
+	{	.compatible = "usb2109,2817",	/* VIA Labs VL817 USB 2.0 */
+		.data = (ulong)&vialab_vl817_data,
+	}, {
+		.compatible = "usb2109,817",	/* VIA Labs VL817 USB 3.0 */
+		.data = (ulong)&vialab_vl817_data,
+	}, {
+		.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
 		.data = (ulong)&corechips_sl6341_data,
 	}, {
 		.compatible = "usb3431,6341",	/* Corechips SL6341 USB 3.0 */
-- 
2.56.1

