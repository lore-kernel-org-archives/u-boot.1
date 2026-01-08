Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971F4D1D494
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7E6842E0;
	Thu,  8 Jan 2026 21:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hBSiDOMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73EC684286; Thu,  8 Jan 2026 19:06:26 +0100 (CET)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3628427F
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso2365742fac.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767895582; x=1768500382;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CTtQ7CWpQOnu2GmCfGdU6i9qkoc3nTMjfs5z6leQZSQ=;
 b=hBSiDOMatroCJw7bA+oVlDtrm/O/BFOwyyM3HJFYTDBL1wnO8Kzgv4EkNX0esc1J1n
 yjUkrZYyTG1Ah7wFy1oAveJiFwyV/hFT7D/x0dHJrp5jx0JETWrvgEB8twB8XCBpKSwU
 oPUpSf/6sYE+nv7rDANG2c8A3kLUJr3QI42doJH0m/u75Qz3qGAU7AiHpV36jj4ivtUp
 SRDSj/tFL9wF5ZzvMHmSAVu74zRm/4GPrMCl0uskY0DXMntWD98GzUf33cdV1Ifm1A2B
 MqXGK0lAUDBaxiT4nQi5Iw4zZG2EaRjeW/n6D6QmDMCnguBk5PlUTcKBstDNz/WrM8vU
 mCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767895582; x=1768500382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CTtQ7CWpQOnu2GmCfGdU6i9qkoc3nTMjfs5z6leQZSQ=;
 b=fWvfl43XE6i3xxVzVS5Z2IW3rravfg7vFrWbTjo0YouTk8kk3pcVv08aP1SgBZKFgm
 9VBFM7x2LxUlWSuMwRM0JP0neb3L4kckFLruyF4QklzRNaxL1NYwcbV1ZCFcBm/Xmb6F
 pC0AdPPU/j/uSTOIddz3d+nanjSciI8GGeE8Hqga79ZW2IPfgCn95bQWJ9kYs8bSf2HU
 MpicIo3IRM/Zi/5O2knUTDNvmCLS0YNOloezc2WVoa/cj1oeXhzniMaewYKOsA1UO9yw
 EZaPg9L7OjXxH38HNBRhQOLRKE1YpixIjLDBs3BMQVSlPYLEBHc0iELQrksXRK4fDEJZ
 g5rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9b8UsDpoZkp/jC4a6FDQXNKl4uxFm8Qh8bN2HINPiyOmtMAkx8Puhg4V+0HDtcgSEsXRs9xY=@lists.denx.de
X-Gm-Message-State: AOJu0YziWAtWU2Yl2Qqwkn6tz4d4GslTal1xxSACX8+0lyyWYqKvFBpw
 71vAVLuBlfO1eQf1EzivK+b70ZGxKifo+TyhC0t74iiA4A9XmvapM9CprETDawvtr58=
X-Gm-Gg: AY/fxX6G2QbYqQ7atCHXFuEv9pmMbtJz5Pq14871R5CDRcsicVpmZ8ssppA+WfhXdin
 84LzeerytDsRljJ8dVOvK9y0fM4woDDFMuNiEN67ktO1svcqW3gVInDstK80gwBnt4QohxWELTk
 znaSE3cf5G15idX85VMgKteFsY6gJCdYJt2T5YAMicZsPzg1hT8vpsKfp1wIswzq7+lyNb5CELj
 zlXaaPvOkbwjMWX4XoBn9KzE8k5t4KmSe9/Ps9nJTM1kKtzNTp+HyPpS9NCpQK+yzEwdC0v/iGF
 /QUqSGlEKiwMzuRjaRA3joDWXGP/P6D2yQBtVU5NItblJZLY3a9qgAE66DQOsaQpPxy7rMJpoj+
 muEhNYm1M4wjOWBO329R/BT7d6vPDcvC1FwsNkzHsf2t4iqEWrMYEsSoiU0pu1GVyn7CcESA92g
 sjXwaol83ObpQdh1g=
X-Google-Smtp-Source: AGHT+IFdSFG3JV5+SOg1o0kjP5pP9wpu6tl3Is4zKOw6A8/0fHLh5Q2GuJvw1tx2gkJx7B0GCK7vZw==
X-Received: by 2002:a05:6870:8322:b0:36e:8381:db00 with SMTP id
 586e51a60fabf-3ffc0959dd6mr3391581fac.9.1767895580856; 
 Thu, 08 Jan 2026 10:06:20 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c69c:7b5c:ce9b:24be])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4a9099csm5391100fac.0.2026.01.08.10.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 10:06:19 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 08 Jan 2026 12:05:54 -0600
Subject: [PATCH 1/2] clk: clk-uclass: fix format specifier for ofnode name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-clk-uclass-better-debug-v1-1-265900a42fe5@baylibre.com>
References: <20260108-clk-uclass-better-debug-v1-0-265900a42fe5@baylibre.com>
In-Reply-To: <20260108-clk-uclass-better-debug-v1-0-265900a42fe5@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=758; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=PxhH9dWZ4nHfqDdR6m3HAIARrnOx0n3XAN4mBO/2B5w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpX/IMKYGIloRyyQAAykSYOeJCjDJJeETCkbmPa
 ObI8I25zgmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV/yDBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZG8H/2OA+2YDc6P8JoTFsOOI4/4lLSIw8dEhkAZUmQZ
 IMWW//MLm+WTMLWavf1VO92EE7rF6wtV5BVG0QjzsnW9lFlub9X34k0ehKVsnaJUYzJCpo+HtUK
 Pp+l1084w0m3DmQhRktd2qsIdyIxxYAvJV04+A5pWN3OXx3RypFW56ueUrvLBWyCiFgoyjxEYw6
 rstqk1WqQ8KeewIEnVWW/JhNa06gXENr8m90v+nMHgVZ90csu7uWeyBGNnd0mPz3HDfho4Mj5+G
 EHKh5xQF6LnF1ldZF7jDSaYiQYpzLW93eda4sciYBza9NnnOUMtPqvz+YuaUni4oJoEL4tL9AD0
 NfkY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 08 Jan 2026 21:24:28 +0100
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

Change the format specifier from %p to %s when printing the ofnode name
so that the actual name is printed instead of the pointer address.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 0584429bed6..0e56d207b0e 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -410,7 +410,7 @@ int clk_get_by_name_nodev(ofnode node, const char *name, struct clk *clk)
 {
 	int index = 0;
 
-	debug("%s(node=%p, name=%s, clk=%p)\n", __func__,
+	debug("%s(node=%s, name=%s, clk=%p)\n", __func__,
 		ofnode_get_name(node), name, clk);
 	clk->dev = NULL;
 

-- 
2.43.0

