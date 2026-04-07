Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34607FF5130
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 18:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61675840BE;
	Tue,  7 Apr 2026 20:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="w6x6ykjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF6A84101; Tue,  7 Apr 2026 20:17:46 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAAF58404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 20:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7e9b97a73so104678a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775585862; x=1776190662;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/AUEDUuIds+AmXBL5yCqOFuMQflUB7PsLD/la6Oiik=;
 b=w6x6ykjEBqyvAqmt6kwWksVNd+RQ4qyoZxgCZ1cem3O4MeEv8moq2/ll/tvnO1RoW+
 ZFW7BwMXpqsQYz+fpqI/WRHf2BR11v3s7TbcTiVuK1b303z7XelE6a/RDLpzrMep/aQD
 gN+Z2RcqAY8FrPA2aKaVMvdE+Xr6BMuG5u0MuPXqaTakmNfjHCwf7jz3OLzgTsufpyjQ
 bN027/QLBi4q/yGfKsI2rbjrmMjgr1/e8PcdGkNspSGm7c+nluE5dIVUHu+SNfY6OgSI
 SNYrC4xGblAesIhWtCfZOaivQTOHDUiTgFV9iAShBorXgCbJPdYBNEG7x/YLarZEeTMJ
 RC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775585862; x=1776190662;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E/AUEDUuIds+AmXBL5yCqOFuMQflUB7PsLD/la6Oiik=;
 b=Y5Ny6CLEepHcqUb5kaqsa4TNajatZpyARlfBiPo00eM6/8ZwcN35uzIFWuT7k38leo
 aV0lQWuCXab9J/oFwQBNgZzHkBpUZkmsA0hlL6hWEx8XNDEtMGh9z1Sb3oER0GL+4fvF
 zp8q3tF8M2LVOwytrANY1KgYmmvyebDePE2W1+pGWGvDFn66cEjefa7sCgGswAEkscV+
 Eqp6Vz1QLgyilmWJKoeDr7NrG4i23r7WzzYvemZU/SLHnEQ2q5b01RCN4C22EZrZljrX
 tfRZ8PtxhYlJZNphSm6rORk2KLh2ijqGfakTeuCxAfqko6zHThPhgV8nHIwPjI2fTK4E
 wxcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCrjGvelXqx4fnxuwgCW56M9r2TqAvFPFS5AqxGplyuk4qI9f7ZTvXwHKHD9kE1Ly6z3MQsoQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwNq+COt70RTT2ZFU3kq4Cmh6KOJ4x4wR2A7RKCXWk6abNjeFKL
 seiGnbZeoQC7EdKUp5CiH6fBZZNEq4dgSPEmF32IsEphdZcJtRZfomRJRyj5EYOit9c=
X-Gm-Gg: AeBDieut+rXXiRGLRtYRTC+TW4xqycdOpCx1OHsUZrpmgJVKa2tGy3m49Wl8lDdd++5
 PJpi8volmrWs6bfRXHmrFcxCRBWNx+5ai32Y2p5Fm8/mL1JR2RIhugi0EPUVRBZi/JQUHlOXuyW
 fCrgAxUPe6c6VIBoH4gZz6nhvOutr0iB2N7PJOcmfVn71k1X6AU87p36Ply/bIrIdsOeWpOV/w8
 cVJtuWCj6Qces0POvyRzotFRfLILJ+SWv//9mBwj+3z27oSthFbBMXnl5fqYe43XGl96uHzSn4W
 +wbM/fMsw0y5Or/dLwAdJU3q6jF0dVqoNSyfzTY5M+2NGkTXfWkjDS2rvsyS5ZABIzOBaFRQNEu
 rRgAbXedok86u6gsWxZ0I+K3quwCVO1VV8FOnpu6nk3BwY0J8AzP/8K1bw5w8CVjTEqaZIjBKXp
 qdZovScPT49pNfZRUnRdsIvGpY8vsx
X-Received: by 2002:a05:6820:1dc8:b0:684:d388:97a0 with SMTP id
 006d021491bc7-684d38898e0mr4425341eaf.29.1775585862534; 
 Tue, 07 Apr 2026 11:17:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42356d581c1sm6044877fac.4.2026.04.07.11.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 11:17:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
References: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
Subject: Re: [PATCH 0/2] arm: mediatek: print specific CPU type
Message-Id: <177558585013.837601.5159747505182499928.b4-ty@b4>
Date: Tue, 07 Apr 2026 13:17:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=681; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hyotbFbHljA10jXa0bjLXOn9P33KLrQzPt66ogM1SKU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp1Uo++67MbmqdMxXEQygZDqUJefnUmaz1+Qq8/
 WuisHJZ+XCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCadVKPhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AZIoH/A9edKSKYrgbZJo/10bA9Wog/bub9bdyuJd+hn+
 owfatvapMgRMpnjACz+6Xf9aNSm5qCOogtjZnSFPzfugSY7cJp2UaSffB8H8IgA6EX9dUcV7Ybz
 sPGg4yLqfdQum6MkB7mQumox+MkkIkxEnSYz8HGjeOSM1z8rv7Vla/53UxWYI3MKJsPLJ9pLJOU
 yZlSiLqUFOUpkvcNXBdqz9gt76QPBjO3PWtb1txo+c2gDtqEOJJPO0uMWmkTajlKkjQDGMKQjhU
 tvPcpzy41tJGKx0gQ4d8N5lmkMuqQy1pm8T+cnqE6pUS/DEve3ucV8w56Zv6mr7KncpHmwUYoEX
 JpYU=
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

On Mon, 30 Mar 2026 15:23:17 -0500, David Lechner wrote:
> arm: mediatek: print specific CPU type
> 
> Since the mt8189 init code is shared by multiple similar SoCs, it is
> useful to read the CPU type from the CPU itself and print it instead of
> always using "MT8189" in order to have accurate information in the boot
> log.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/2] arm: mediatek: add SIP platform bininfo lookups
      commit: cde43f9bbd5d947be1ac6d03bba8d81304941cb0
[2/2] arm: mediatek: mt8189: print specific CPU information
      commit: c344faa37d287ff761813b519f8e1412b6153b76

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

