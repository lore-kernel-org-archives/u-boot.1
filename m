Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812E2C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 492DE606A6;
	Sat, 15 Aug 2026 13:09:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hE5DEBD-wXnc; Sat, 15 Aug 2026 13:09:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FE866065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786799342;
	bh=g4k14e/+7Re2fuP91n0tyqrqCmJWY5QTlEE94y84uhY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f5gDh+hnHfkv1eW5cAWtipGFdUYcrtXOLKmeJ9lTdS71GJgV5OJN1lzu5ZcNF/Ypi
	 +IXu6C/hH9LoMgF49vglW/QYQCV61uL7/lYOC0FagrZdhrpDGyy+22g28O0ZKJFyIy
	 TTuqpC3kn7ISsgxel+BMUTbjUXDJcHN2WjgJfk9R3Ke/t9946MQvL2pAAX6UGYiXVb
	 UY4K2uz2QLEaadeo7MIfyolgA8OJMDX25IXMXB2bv6Qj3t9alNAdMi4Aef9usqtMWT
	 6936cARXvLQwVM1BQkSq7iausCYJm44UbauYtk5UBOGvMHRWwCOyQD3PMw8RnVD9M5
	 pC3fdHPWYKqeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FE866065E;
	Sat, 15 Aug 2026 13:09:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B0F52BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 010BA409A3
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:09:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ytLrq8BCvqLs for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 13:09:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 353AD40983
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 353AD40983
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cOHp6nAW
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 353AD40983
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:09:00 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a09571dd5cso248101a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786799338; x=1787404138;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g4k14e/+7Re2fuP91n0tyqrqCmJWY5QTlEE94y84uhY=;
 b=cOHp6nAWJvF97Koc0ymjFNyvEqvg+FHyafw22CNltKIVCVl1RvYJbLmtzQOV/z3RNc
 dFqIxoeaK/UIzVo95zqfG+vyMn5++lWpjvjPcKyFZkG7Ib0e605mSvV4hSWEIU8ckMY2
 E5qXffGtlfYmlyHCDTgpiQ9LPfD7vuuFP/OwAPuIsBbnzubXEcjoyYBVpBHE0qdE959/
 UwlAEEP+C7c+dlwakPWiNxX/8j7W4v6WX8Qp1Dg29nGgWU6oPg7U9ToNadWcSDfW4zAf
 IfJlLCs3HO/JEQbiq5UhLp3/k8Hxg0VmsQURO6mjYogbJ9ofOl+XWigLDohx1RObg5GF
 AT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786799338; x=1787404138;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4k14e/+7Re2fuP91n0tyqrqCmJWY5QTlEE94y84uhY=;
 b=YsU/ZU+MkbrJ2NUrRMXRw3qPpDDuvrVzYkk4cHDxtvgrnrxFn/lHRPhWnrOQTy5nsN
 JyT3HapWt+E8Lj9poNe0nVksDy5MMCEEIF9BdFPyMeQ9xii6ExUR9+g178JkxK/oLYVI
 HRemKuM68fc/Zy/LJfdsLPnJFF1DVjo5qvdrHm3O10aICkdlJXtkVkpocIBPJY79j0nJ
 xN+70dCfXDv/k2ck9YHa3zv0tRf3qqe6q70QgP8AjzGZaYlAM0pghYMPK5cGStDSkHXs
 NKuGkyAAqbBWvtYEbqlEJAQzDs0FkBNH9MoL4P5I+kWWQhWsDfhTGOc8RsploN9FZKe+
 4Znw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFz9JBYxPiPEruCNDF33PqC8TJ/itnddW6sdRPrLXQxZt+ZS8JDH+JkbfhesESxwEH2XhPQuY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxxRKkoKLPp2tc06VtVWmzq65ylp3olnUI9Mn/hfmY0rjaUK478
 QOtbGipbz8OpUk6/dnnCLsTs3RJOC1A6VHKH2vLk0vVcWxd7EYpapTE7
X-Gm-Gg: AR+sD11WJI3bVl4ohKL6fTViC343Fy9UMVBPFftK6cBQoIyRozOUn2Vu0ICHcXLxzea
 +LwdRTjCO6afXBjYsu6zYJ8j1gnbb3JsoOjtSQGhTmhnsWM/0qHIhPxYY0dDSOIS3mi+zOZJrWm
 p4S3h0auokP/SY/j9XgDs1+qpiw56c4MnrX/OeIejhI/Z+Lp6ExcMfF6l/YzH8wbjg8Xr1E56V+
 N62yh5oOL6YS1OjEyPVe/hKu6TLr0Yrh8l66H83jtwWKMzGpBMGYmYDxw+QmGMKX7psQa+/k58H
 xIFKxUgW2/umdH7H9Wcxd0b1MnbK4/oz41DlwZmU+TKcUiTAVhzYcnqgzHK2mBTQFCfUbOlo7kc
 Jb+HZFQjF+ZVf5/j1T83ud+DVunME6tmiCAycw5M7eoU7q4bGIkZY55o4fpB5LltV/jvsi/G/pX
 WPVOWgBsrGax8AElMc+fP4o02lCb/GP2LV7uvFoR9jvbax/cthTubnpzlX0pUb24cxm8oqCqFFz
 UJqYI8GGJwL2PGHeNca3Q5iGfbu
X-Received: by 2002:a17:907:c1f:b0:c12:e4f7:9a0 with SMTP id
 a640c23a62f3a-c212a17c930mr273931866b.2.1786799337680; 
 Sat, 15 Aug 2026 06:08:57 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c213f43148esm137312866b.7.2026.08.15.06.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:08:56 -0700 (PDT)
Message-ID: <62f1285d-bd2e-48e5-be61-a7bc32d1a1e3@gmail.com>
Date: Sat, 15 Aug 2026 15:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v7 6/6] rockchip: doc: add notes section
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a notes section for things that don't need
a chapter. Include some rk3036/rk3066 cases.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 doc/board/rockchip/rockchip.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index d5945e805ba8..6dbff5b72d90 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -325,6 +325,14 @@ To build rk3588 boards:
         make evb-rk3588_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+Notes
+^^^^^
+
+* rk3036: SDMMC and the debug uart share the same iomux, so if
+  a SD card is the boot medium, the debug uart must be disabled.
+* rk3066: eMMC and NAND share the same iomux, so if in Mask ROM mode
+  and a NAND is the boot medium, clear the emmc_flash_sel bit in GRF_SOC_CON0.
+
 Mask ROM mode
 -------------
 
-- 
2.39.5

