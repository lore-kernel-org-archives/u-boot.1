Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DCAC44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 15:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19B5C84C5D;
	Mon, 13 Jul 2026 17:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VTv9KjVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B3B484BE8; Mon, 13 Jul 2026 17:57:02 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92DDF84C12
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 17:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso1875632f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783958220; x=1784563020; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y/AtmA9/dAGsu2lQ/eOZ2tsd2QJUU7eAcWiLmV6F7oM=;
 b=VTv9KjVqF1h7IUz9dy71PLevPcrQlTe33dvbq6MuGYZc/mQNuw1RcvPKsg3YmGwKaj
 fh1nMztqxNp3rkK3N343FQgA156LWbw/sU2dMhGDfx43apJvALfHZdhvkxUgyk68Oier
 CCphzs/Ar6lvmxaRJAZovV+XARUYc+ArMuJGdODCZ62OX7oMnw7sbdb+4+rvIPo1doxE
 bLstGauhPl8eFyvvUKn7wXgMJqK8acCZf3TKEoy7FzU38VHTCP2hH0LMbcqFYiLU87H7
 boJ0/kEcgrCOkNYi/jvVxoOBbFGYu6DC8pgNu37Pk4ZHA1lQu7A1DDdbMd20NOLlI+Jp
 Z7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958220; x=1784563020;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y/AtmA9/dAGsu2lQ/eOZ2tsd2QJUU7eAcWiLmV6F7oM=;
 b=CJqcgmHShuc6FF7Nh0ffl+CwzbO1TyiEWt2ZBxvNcx/fFhFqGkkBP7pgJz2HgzefZq
 kWRSR9m65HNZBMfvwajRozAVncSFiJcQYJ1wLm6Kr4yriKOddI9ZY8OHMPFKgtwstamx
 THJRoBSbquuPymPj9qtr5mPN+SU8pShoTbU/lGSyHzm0hYnsU2tWczYYBR/GU5Y9EaX9
 52+M/kom74wc+YOT9a1rNNYr+PTZs8Gtz074shQRfyi+9j+VJP5mBDph7IVzDmZEiMbE
 nibk+38C5rzCAPpINZyhU8ZhhO2hu1bgBH86Vgg6LjAzw0vX1sErqTM5Fd3qqLm6y0yx
 4Ssg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rom6EtQJtomP2Db3dX9rOEwo3IiIcVwWNBSrv6lv35GIrAINR94ctkueI+yOlonUSNvp8x+h/Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4FfGZWuX9JBxDTWJ67tn4hl3YJv3QqU20XFGaWiiEizROwalS
 XhGnMtyYTtTBnr/1fLEIBfOkVdmsLJoqWkoVh8++bylp7BVHDKxUeGAUt+RJpJ14F6s=
X-Gm-Gg: AfdE7cnAbvgPuvYkqmlqE0iHUpB6DgYn+4x0JNRnzI51p5zjQ+AsKFaSpzrT8NEuyn9
 P9GnyEL1VAqNu5JfJMeCc/d5jUDGNPif6jIqLPCWEFZQtsMH044HbBji23wy1NMAzZU4g5Hq1i4
 rMgIrwkLPNDj1e/SGpPZI7w5VFSstYKKDXwVTKsNsOtSoy9eGlQZ76hnA0k8eLmciw8Em6TyTEl
 /R5p+RXRx6xowJpcA6vTEu+FhgRgZlsWZIEm8jAuGPpgWyGigjt/die0Ef+HtyXvfZHpRxsBmue
 TX/V0dA5OMf2N8BV+Gjep7mZePdmzUyymmb+sdaHz5oGpQHBXHpd/q7FG/qQjHuxgGBGRrai+BN
 R6zPsilGdFW9AQe11NvaSEozeoQu1BpxYnfyhoUSBykDsAkSUKpgbM7TdM5+q9RxE/wO8SdJ7mg
 22KZvtoK0rmuKYWLsy8I/rVYOpXeXMMNTWjw==
X-Received: by 2002:a05:6000:1acf:b0:472:c426:2ce9 with SMTP id
 ffacd0b85a97d-47f2dcac21amr11558382f8f.12.1783958219877; 
 Mon, 13 Jul 2026 08:56:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm352946f8f.8.2026.07.13.08.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:56:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 13 Jul 2026 17:56:55 +0200
Subject: [PATCH RFC v3 1/3] tools/patman: Migrate mailing-list to
 lists.u-boot-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-osuosl-ml-switch-v3-1-48b71dec1a23@linaro.org>
References: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
In-Reply-To: <20260713-osuosl-ml-switch-v3-0-48b71dec1a23@linaro.org>
To: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Heiko Stuebner <heiko@sntech.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=864;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jMqFFJna27R0nJL2DrUFja+iHMOb/f1mP6bOhHnQcDs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqVQrISHP5JCi0jgU4UD2hi9lMM5BODOSEEoiIoMd6
 wKUaLfmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCalUKyAAKCRB33NvayMhJ0bCID/
 4k9cjP8tOM9uwDqcu1Yy20NlUqyw+7870suLAl4hLzi1dls93exl1rELo5Lsg00ZSak/oPcMCWC5Za
 DRzZLB6tvriMwaI98WF84sUEkCwZwI/vesGhCdwTFAQuDxpjbizntAM9y5ozZ4iqrQGW8dyKP431Fo
 Z0+K47IwLTDE9qTz2pnaMvsjoPb2mH78GQDBS8i55x3xwmTh0QHdyoGurCEIX+2u6eN6Yx3sEdA+lJ
 qBBMZ2anMq6yERUd4SKt/z2a2Nsit55tSrkoQU7HhsgATOWCgay+jn2LTO6KqUnTuIAhxjNcJTkHKA
 xP2xcMwsLuIubYjO6iAgNx8gLG+glSS5BkjfY/UgPtJIysmFPkd7qHemZHhNyJo8Rd4x8wXeDfGixG
 Uhj1cQ54WVg+fK3ol2w2bKXElnXKI7Oc3zUsqR4xyQu5gCrgiFn9iDrqLIcLYBOOxfzP/hCMltiBHY
 QTBaPtt8ZRs62JGPuISGD9y9xdaTYiLMnnQ+zKU14Qpe7sEOMCKolvuOeRtNrmn2QpPH8oxK9F+mhG
 3cQ1KcMTnJJTInqezFzZzcUiM2QitpcNRJUaDbDj4f3kjiEMXyVxAAKEJZtzRcdpvyD63klbCkQXQT
 zqeHCKGba1xNFp9+cJcqQF+NzG03KWEKE0DyzcaSizUdogl/sMS7AVnOg90w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The U-Boot Mailing-list is moving to the lists.u-boot-project.org
domain, so update all references of the list.denx.de to the new
domain in the patman code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 tools/patman/settings.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 17229e0d823..fe65b1d3fb7 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
 def ReadGitAliases(fname):
     """Read a git alias file. This is in the form used by git:
 
-    alias uboot  u-boot@lists.denx.de
+    alias uboot  u-boot@lists.u-boot-project.org
     alias wd     Wolfgang Denk <wd@denx.de>
 
     Args:

-- 
2.34.1

