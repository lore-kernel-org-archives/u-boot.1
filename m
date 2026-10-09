Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4380CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF0C0608D0;
	Fri,  9 Oct 2026 16:15:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhJJ4bURgWUF; Fri,  9 Oct 2026 16:15:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF580608CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562556;
	b=WFo9ZhavPCXIGvgbxvh45/MneuF3gnUKcVK5ERb1sQzkxuC5YOq8errhDKtYs6OmK5qr
	 SL5nWywPg9LppW2Qc2sp9i611Cuxuy+7BThCDi5Y7fm3NODYbZDTkov7V+g7WWv8188R2
	 nBfOZcL7+eLTOMVzoyGWMPjaCS5Y97XlkI8xgt64/lcVw19YYJ01ix5d76+EpAX8qz0E3
	 6qo4NPSXLxxGgxCNJmepfxaAmJiJ4uPTA5yKZ2wmDg0AkzON62Or4BsPTwqwJ8ozONtsV
	 v5RS4sEy9zISNU1fNQHs5TeSGneIbhFuo4XrcqUEnY1GMpRiIkhKKH/ov+wMkI+QLiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ymBuVTOcudsrFQQkjl5vTi1OLszOtfXnNp/spZ4/QO0=;
	b=M3c3J6+P5TVLrE5U5yyi/VoMLQ51lsnd7EnAmDJ5EaRZpX1BnoVSJuSfsLw2ddcn3ZNj
	 NK1hxODPKI2RmYCJtlN8xqM4JRAmC+ZUYG5vqnYkQSypbAaW8YHUTTknJf0Gx9gTSYUTR
	 mFWaDMKMf8g6pjmRg5WPZ4l2jP2ii2k8fuPDV6xSzZ4WGn0munZHmFgDe9qshnj6Hx51o
	 4F16k0ard3/VlV7uybh6nD85r2TiXpQDTGSA3+wurjns4fWvry84BuZmupuhopP4kFnmR
	 AxKjhfW27LartcDAd2ziCbuFVh82IlmwcQ/xrzACkQRkRzRKEvacY89tY6ckb73XzIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562556;
	bh=ymBuVTOcudsrFQQkjl5vTi1OLszOtfXnNp/spZ4/QO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RaZFvvLXbWHzyYQULs7Ce+sA25frjwFYaXBHycZBctGfX14yxNc/R4qpc5gpSGcZX
	 UNI7weOkAdiexmM0+o0QayIH9xPErdy5Z+VcUt7dMJmdrj9ijuadBMtminKhW0A/zY
	 cGBFSif4rwkEHm0igINXwCKB7yQnNzvDDq5AKoyhCQLv4c9ThZdEcjoNkAENAO24sE
	 OAonGlmJjxjne0j4D3BEdGiY8WtBLNMBFOAcKNQIvKxd2WaBMMF6mhCog+8I/Iiipb
	 iFc+TG4BeNGg6gmdV3g03yBVSIm1Yc17wD7tZ9mhMd/ZCj4DdB3iK454Wo1EPy3Cya
	 lcxG35XZV/EcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF580608CE;
	Fri,  9 Oct 2026 16:15:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29C47356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EE3881416
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1dCDQSNfKtq6 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 550CF81412
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562552;
 b=P4kDhHIVO7asXsz9zo/XYYFznaDb7wvADNXTkBfB2rYU9M+FcUqFthhsYoRrT4Q9d2sj
 KLeg8idcacAQJE/u3joMcMUWmFmWmsxbEsG9DI3rHid9OKAMpSFIR2zA0KhF/Zbova6wE
 +0kwKt3mHQacwxEVjZyuudQnLE9l+oFrrKoLRVswxLh/EVjUORTFqaoVNCVr3iGJ7JRxk
 WewUqqNnI7MKPbxrao71Gd0aGmyf8FiLrWncskC+LXNoUN+6aFPo7OmlQCr8qEwnOP7Kc
 yLs2XJ1+dMkLIP6INieBxhhXSA4vsiQ60hC97L1gpD2C/CzhgsYn6ZiFAnbF0ANnk5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562552;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ymBuVTOcudsrFQQkjl5vTi1OLszOtfXnNp/spZ4/QO0=;
 b=C2LVF1eo2qv/Rjlpk4yDkLfKk2jecgd30/Ek6KWN1JfZdlg6SssSupocP/HsCh20h6tY
 vWDs6UD+WeFg9WFJ/5sgXG58b+72TIJnBc4TTZzNgF5SxOzN1HLelGl+5NKuM9/i0V/eg
 RHYZj5JWFuX8qCdPISs+dPNzT4JRihvuwfDpfLkHXWgbtOI07eaB+yFMCQ/FR+92jN7JV
 xNMjHe8IQwVAuUo8JwxHHq23PHRQExhIIuTB3zpdxXwqxYKXucGw3PPs1i3/NsK6YykXO
 aJCWF1yaTAUstQFnwZKGAkBAHscUbN2FFriXZK0SUX/sLzQteqym3sHuzQFwQMllflA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mIiC05x0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mIiC05x0
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 550CF81412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:52 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-504ae5941faso1265644b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562551; x=1792167351;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ymBuVTOcudsrFQQkjl5vTi1OLszOtfXnNp/spZ4/QO0=;
 b=mIiC05x09hQllDT9mRYtIMpNGtReC/rQPTtZpNUqa87kHb8O95nB4/R8QGEX2MdEna
 dFtrMLPyGfedg+2EsdRpnDb2o1xCtYwntZhPJm6bGeBpCMOnjQVC636VytFNwSqj1R9j
 t20hoMU6GcsCb/aLCoYEEfukPHJQQjqhc0mR/feMEU3CYlKAzXgz5c6RH2t7q3jwgmg7
 KNef1d8Rjl7xgU7Squ3eG4/wJDcUc/QHZjQ/UkwbJnxxOwvzDdeF78Err9gaXKPe0ooU
 sBRNtOBXmR7g/F7TBHvdPQU7tC5ug2lMIMEG6VEb7VfKCRRp+B5Ny9DY8dvxL4Rz5hdd
 +zKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562551; x=1792167351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ymBuVTOcudsrFQQkjl5vTi1OLszOtfXnNp/spZ4/QO0=;
 b=iyri8YXR+VFobAbvE6EegeAdHEPjH2N5yaC6tTQuCZrBw7EstJlzSVt1Vll5mo4kd0
 iVhge8F9Jr4OrhRRxyM8oWPnjuTVOGIJ9/whs172ibQLDkRJJfa9cIzMGTfY6Fhl77bt
 EZgsVl0UoRTofBuRNS8qAzlyHVsiMiDiK2yQ+ticpywNMd21DpZxQS7PAMx0TMzfVHEw
 jn5c8oOs5VWXm8xPhyKjMgaWfywvpIQDhASZGrfu2u/0CRWDCAdR79pbwlqcfVdihLIz
 qpLRpq6Pp79gsdJ36w2W9uUsKjlp8/pS8zGUHNYiCQRMnOXRyHz1vGS6HfEaXFmqPufP
 XjgQ==
X-Gm-Message-State: AFuF++kbUhOm0z5WW+uiMoUUl0aO+JujsQN/zT+wd+pCZoNJJmcbCYMX
 dxKR67QN9NGdGxAwDdo5lJqNcXxeM3LCHkoWh+9+CSA6qa4XWB464FFRiVUqf1qcrdk=
X-Gm-Gg: AYBFou0negw0TaDm5pJMRDe/ZUcOsPoHZA6WYCw3g/HiSS/bFAGjDMrivfxELL98Dft
 rDXq8XFUg+lqhGIlTSXTx2CX7089gDk1s80GvGRzABIddaYPZvtMZ3KNgvzQ5fYsypl/DGANRor
 ZdMeGEIENgIX4ct140JzhP0ClT4E2Xg9J8uvRd1cmYe7LUXI/fDXtj8wXAX/amaU3yeHy8p2oKE
 QI+dVblFYHHgWElcNLcMY8XCZR7IDV8Icu1lyAyl8iaNpRFym0ntzVpVDhjt+vVUwjsny+DKemK
 tu7MybxqzgCT3txEgFFQzLuTyM8dRZo3vIg3oKvsaR6naw5hG+kilnJk6vHxmNEjgjvF65ElFn3
 ZuKzMqyke0qhlTAzbmUAZ0fabvH5O7sukwi9TlE70OAu457yloPkcfd8nPa8ilMd6NKz9hA/y1h
 QgMpUYT8gbAq1hIbpaXvD9LH9WTpQzlFJsB+bmDz8HI9QVbVhCFWknSZ8Ygi4ffPJNVo/RfGYh1
 v4=
X-Received: by 2002:a05:6808:1583:b0:4e7:8e25:37e5 with SMTP id
 5614622812f47-50c50f2e813mr1634698b6e.17.1791562551151; 
 Fri, 09 Oct 2026 09:15:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:05 -0500
Subject: [PATCH 02/13] linux: drm_dp_helper: add the definitions needed for
 eDP link training
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-2-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=klHh/qklqTpRq7G5ghzuFJ194TBiMY1yDsQT1+liUBc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRLdAxBnD0mA7DTlXS8OMizxnEt4AMxsXUZal
 JiYjOpwDdCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskS3RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdecH/ihOsMQAunV1j60a1r8XQi01XCmAx/gxP5eUDuj
 jkiJl4I3ag5QGmYoatTTLMHaNy/V0VuHHYgYvRX9zugzNV4YVuvWlNf3UZUbmGeqypm4SZHcVWV
 EZsMf1jkFFrZJjS/945tnR+0QVDaNlqz4lImReSKYSGt3h+7GO8m8nEg1k6CtPPpTPl3ukZkfju
 IAMlcKghEFPAs5n/vE0i/L7BUXWcUI/VnYB2ShhLJmDG8KVYtKgZc4dW9ZJPnhE0kzhgqzXHd7i
 gn2zeR3CBpy0hWRgsr5TNt4T5q6S739mV6jjiYTxtbcz8/CtywPsnZ50ugGbEcB0OGplwlQ3rTc
 Cgec=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add the link rate, training pattern, AUX read interval and downspread
definitions, along with the sizes of the receiver capability field, the
link status field and the AUX payload. These are needed by a driver that
trains an eDP link itself rather than relying on firmware.

The names and values match the Linux header. Keep the (1 << n) form the
surrounding definitions in this file already use.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/drm_dp_helper.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/drm_dp_helper.h b/include/linux/drm_dp_helper.h
index 758e4a4015a..ac74d5daf63 100644
--- a/include/linux/drm_dp_helper.h
+++ b/include/linux/drm_dp_helper.h
@@ -67,7 +67,9 @@
 # define DP_ENHANCED_FRAME_CAP		    (1 << 7)
 
 #define DP_MAX_DOWNSPREAD                   0x003
+# define DP_MAX_DOWNSPREAD_0_5		    (1 << 0)
 # define DP_NO_AUX_HANDSHAKE_LINK_TRAINING  (1 << 6)
+# define DP_TPS4_SUPPORTED		    (1 << 7) /* 1.4 */
 
 #define DP_NORP                             0x004
 
@@ -98,6 +100,7 @@
 
 #define DP_EDP_CONFIGURATION_CAP            0x00d   /* XXX 1.2? */
 #define DP_TRAINING_AUX_RD_INTERVAL         0x00e   /* XXX 1.2? */
+# define DP_TRAINING_AUX_RD_MASK	    0x7f    /* 1.3 */
 
 /* Multiple stream transport */
 #define DP_FAUX_CAP			    0x020   /* 1.2 */
@@ -152,6 +155,7 @@
 # define DP_LINK_BW_1_62		    0x06
 # define DP_LINK_BW_2_7			    0x0a
 # define DP_LINK_BW_5_4			    0x14    /* 1.2 */
+# define DP_LINK_BW_8_1			    0x1e    /* 1.4 */
 
 #define DP_LANE_COUNT_SET	            0x101
 # define DP_LANE_COUNT_MASK		    0x0f
@@ -162,6 +166,7 @@
 # define DP_TRAINING_PATTERN_1		    1
 # define DP_TRAINING_PATTERN_2		    2
 # define DP_TRAINING_PATTERN_3		    3	    /* 1.2 */
+# define DP_TRAINING_PATTERN_4		    7	    /* 1.4 */
 # define DP_TRAINING_PATTERN_MASK	    0x3
 
 # define DP_LINK_QUAL_PATTERN_DISABLE	    (0 << 2)
@@ -401,6 +406,13 @@
 #define MODE_I2C_READ	4
 #define MODE_I2C_STOP	8
 
+/* DPCD 0x000 - 0x00e: the receiver capability field */
+#define DP_RECEIVER_CAP_SIZE		0xf
+/* DPCD 0x202 - 0x207: lane status, align status and adjust requests */
+#define DP_LINK_STATUS_SIZE		6
+/* An AUX transaction carries at most 16 bytes of payload */
+#define DP_AUX_MAX_PAYLOAD_BYTES	16
+
 /* Rest of file omitted as it is not used in U-Boot */
 
 #endif /* _DRM_DP_HELPER_H_ */

-- 
2.53.0

