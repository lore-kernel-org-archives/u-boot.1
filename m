Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F4FF99C65
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 21:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4B0484214;
	Fri, 17 Apr 2026 23:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="CvFaf5GN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 284948422D; Fri, 17 Apr 2026 23:07:17 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25948420C
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-47018d341f8so782952b6e.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776460033; x=1777064833;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69lpp69D7sXT0gPOFXUT8j/Ex2bixnjBOhOvJXr3lBg=;
 b=CvFaf5GNDXaFxCnGDy+dE0M6maynC8F6yJDjsDTKvyRW9nXlQ9L0ZwBJYv8Az71l2+
 /Lo+kzxxaJWseiXe5HayXaq+gxzG0+E4EZe+CD6FBKHN3Un4Ful0lRnKqkyb/VMRBlLv
 LRXzt782tzmMqtzctDdgIK9EWveIxW2ac0P7vsL0AqMxLcojSM2qspGCnKvM/4BiJ6zL
 iMtFr5Xl9P/V5e986uux7tpTQYySbyxOkpF17e/2eruvhB3oyFpxIG56MeKPJTPHQbz9
 qXqKRt2QSmtRzSPS7M8LwPxJz6xJSnTPf+DKvVVwWVAqu0J/tLMequGrYOzn1e9TU5lK
 xeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776460033; x=1777064833;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=69lpp69D7sXT0gPOFXUT8j/Ex2bixnjBOhOvJXr3lBg=;
 b=Gg0d2Iz2e+1Wx79bOy0HUJXZYBo/UEGOwpEpuX8o6+jdnQeesFpABT576I8NdvaQ3C
 gI72tOejGo3Azdq4gTb4VGKibDyqUKvqH47U+ue6OX+Sd4XwR7K387XWcHJVcn3SHtML
 66Ol8Zv6byzsq81F9HTXjsPqPQMUxxHPXx3aWXmFPO22vXZ/35fqtr8T3a+DbuKF+Vcm
 G2NtL4WZSUCnoukSnj9UyPQSRUILuz2vkQv1zU2aXEUeAhk+XToHVGLaUXJNn74A/K8Z
 2nKZ7EcutjMYZC4HTLw4PmHQ22CtT5oEXlEHrsnug0apctxBZZ2rTMX+BadaWgaj+VWZ
 3xVg==
X-Gm-Message-State: AOJu0YwNQN0Jm38+1UTTo3kNBCkjsbLQaCLlKrY3R45rqCw70lWJ7K0K
 BVxCjGxRRVVpeYv0yZXUzY+Ursi7NNJEb/eCSVoLPi69qCFjpmKvDeZueCvGufM7q+o=
X-Gm-Gg: AeBDievjhfBA8BU6o2oGTr2s/VGFvzKqeHtgRYB7l1aJF+RGMOBj4WZ5scwExz3mLS7
 +6g57iSbTTyUrQIakskhS4JSwDlbOPpNb1TrzYDFIOOSFhajTY+V5krLnV52wYJCRr7WOG8tRpo
 kUHSOxxIM5EszqHS76EAHs3s7Q93s7qCxVF+YDwG+HzcM2obAmP7RxZIl/7OWYY2R6UOCXqjzrF
 FkzRizYIqKfJm71akvc+MrytQ29jpTesKllUugocLRE4CVW205jLMPSAsb2xBDa9MO8GCpaUjBy
 lHGK6CESI4asr22ltoMUWzZ5DQNb1DAYfb9Wv6JlZwjL5xyVQh85SlJGIFFK6S0qLu3NYXHUiI4
 x001mAEQ8GVlg70qEQHch6AbMxhXSNaUkfQ1aLuUsTqHjWl+70mgcqMhhcIK9zcYL160ljiK3Qu
 QQrJzYIeMjfcKcFSsi8HUIbSPUhrA+BVUVH5pbIQ==
X-Received: by 2002:a05:6808:1b21:b0:467:5403:3780 with SMTP id
 5614622812f47-4799c610d38mr2477383b6e.0.1776460033539; 
 Fri, 17 Apr 2026 14:07:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef27:3314:b886:cd3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc9751920asm2053326a34.9.2026.04.17.14.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 14:07:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <cover.1776326933.git.weijie.gao@mediatek.com>
References: <cover.1776326933.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH v2 0/3] Fixes for parent rate lookup of mediatek clk driver
Message-Id: <177645981839.59267.13645786826188172672.b4-ty@b4>
Date: Fri, 17 Apr 2026 16:03:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=5ZuDpRd/eeNO5rkOj2kwH6ZXS1AyftiAcy6tFq9OYIk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp4qD4aPL8/FR4uFqyFSok4buYpIhiCAPbTbVu+
 iWrvgGymzKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeKg+BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AR34H/RCgdQ3lLWVpCGz5wLhn0Vb+Lrj9pSAHYMTgmfH
 dGohronK3IJ0SdgTSM5g8RQOyGEDpXSwJ/lJLX6cK0t9JzD9Xm8bZDqWB01iKVR589myzsJXSUK
 LD1WpUgaTn1qa/jxKr6qxyKIMYlCsgmQKU2xdyCI8iJ2E7ej6EXyGoaTU852AF9LeAQc14mAuls
 WB/o9RSUSYRDQjqKI5imxqb58Ey5zeb0tQEsyyBHYn2jFBCGdZGttTDxQaTQvisrPcybZdSPxD3
 a5H7bQj0OJEuZQZ1tzV5WLO5tQuwDaA9m/kdaTOdKmTURO1RuN8vbjBcR3G9MNawBc6PomlHf8F
 PKXo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Thu, 16 Apr 2026 16:22:51 +0800, Weijie Gao wrote:
> Fixes for parent rate lookup of mediatek clk driver
> 
> This patch series aims to fix a clk issue that breaks all MediaTek Filogic
> platforms where flash device can't be initialized correctly.
> 
> Sam Shih (3):
>   clk: mediatek: remove redundant forward declarations
>   clk: mediatek: add grandparent variable in mtk_find_parent_rate()
>   clk: mediatek: fix parent rate lookup for fixed PLL clocks
> 
> [...]

Applied to mediatek-for-master, thanks!

Note that, in general, fixes should be applied before other changes. Please keep
that in mind for future submissions. I reversed the order of the commits when
applying them, so no need to rebase and resend this time.

[3/3] clk: mediatek: fix parent rate lookup for fixed PLL clocks
      commit: 1b7e79b6a62a5529b77fee886b2f9fbe702c6a44
[2/3] clk: mediatek: add grandparent variable in mtk_find_parent_rate()
      commit: ff981dbb0b5210792ec8db00c5ace5616e20e11a
[1/3] clk: mediatek: remove redundant forward declarations
      commit: adf707f65b02c742761120a7203512486d8ed1d8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

