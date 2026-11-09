Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA721606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x78v15g0;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z0JbdJiE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C688A606B0;
	Mon,  9 Nov 2026 17:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFFTSbgl0qnt; Mon,  9 Nov 2026 17:28:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 15DAC606EC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245339;
	b=MUDxjuXTxlCVcJo9CY06IvybSvOAJmqx0JWYc1ZYEg12DFXxCncgE/LeuTdcjE15HF8H
	 B5yKvRJ0vnwgN7f/acBUlWyqOKpaUXs72PTs8AJvu+AROuMiGVmJiP41oq4uteXM9R8ZL
	 5I3DJipNZh40K2zRTF7Tsxq59YDE8usj97geBfWT8XEXwZctGORR4NY8syXuMSNEszTHR
	 dtDaqFcZY6ZSvMVyB7lgU9lhqt8q2+VKV637yPWmljSm8K+QITqRpRlj4caOUXyFVf2yM
	 0c8pEmFyhuvXw2AP0e7PvqTYk/ENaQE/3zybVT0HgQlP4iQvPZIb34TMjV4+bsZFkQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Y36p5JGnany0mL1pwWtBnfmWSBFEBTza8Dc3m2QWqiM=;
	b=FPgNGNzhZmcvAGykn9sfTjOzYS/YmOyuYbkeVGw5uHJH10yqZYfDrJiW0gFqzQp7AOtr
	 xhb9b/PkYG4fHkJIPS13oiW2ABM00J2uOvEGa6zUNhuozxIsW13vdUUw40nh4T/LWU6CN
	 lkLcdS0y13jXKfTi8usHBHfWxHAFGMCEtDih2zNjCCozOzv5MuiNL4FPyociDZPg0T/1E
	 YbhVAWGhpuvikMi+i8Hu7kZTtwjZImbDCl8eVnpfJcrgpIOBOco/7ffVN9Bl0F2xVZDFx
	 HEkBYlrfTiLxarsBytu3B1qCXtDmZCnAeKjkXl0Xc2ZZSyEnxpciLvL7UvkMXI2r4tQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245339;
	bh=Y36p5JGnany0mL1pwWtBnfmWSBFEBTza8Dc3m2QWqiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x78v15g0WigqdPq8Nx1ZuirKd0OkJ9wIXWQaoxqGbyGaEakOEX02V0fpw1hM67xVK
	 K1jXWjszmmYSeBGN2PWvzYKNmvP1qIEU1dyhLh0bOn+ewyPueEuYE4hzpLs7PCmgHk
	 B7jmLO0+c9mdE0nzgQXaY61RHmr7cyht53NqxLtf/rkPA56H/KlA5U17eXkr9PZFml
	 vX4a7PDOx4kESjB1hpFSdxUiyJU03fMRF8IJ3/RtyVr1yyjaoGGWImNyjrwlyOlbz4
	 a5cPdq0zBqcAQSlKvUoY5CrZCBBTsimp9yqk6GftFI3tCD/hqlz9JQITczs1j0MN/Z
	 HWdyG3KckoYHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15DAC606EC;
	Mon,  9 Nov 2026 17:28:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 843FD251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A61F81095
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B1vPYhKd47vk for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:28:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89A4980FB5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=z0JbdJiE
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89A4980FB5
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:55 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so780546f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245334; x=1794850134;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y36p5JGnany0mL1pwWtBnfmWSBFEBTza8Dc3m2QWqiM=;
 b=z0JbdJiEJTXIOexmHelzKS4x6Twbv92jWkGZ7ABWVybhTHQVDXxVJq9HMPSjo19YPa
 HVpzwu84eXaKcodJtK+VvteIJQ+PYZnuS64tP560R3QU6kxBEmpoPyjfEwF22Tcoxgy/
 rj0mMbRQfI0WefxvqHuOIIfAgYwXDw4yaA7vMRc8m79MXlZrtno+FBMDx1AMWHjmov18
 U0RrclAgyIxMpEeR/8s6R7yNRFHjHMT/zyLCBjOo5+Anz1bjN5LPCEPzhQ8iedivGY4I
 M8rUDM69p48LxNej71K4yco0gX7KpPPXiZlwlfsL7gp7AkhHNiuhZFhr+1+Y8yt7VDOL
 oG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245334; x=1794850134;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y36p5JGnany0mL1pwWtBnfmWSBFEBTza8Dc3m2QWqiM=;
 b=N97LlC3/9GTq1jXDNeddQU7yWC8HC8TY42PvfRfCkUznUfhouXx4U9w5xO9p45nz5Q
 Mm1UNQsJU+a+g06fZ7JKZbUhKdH4jiPdlsyLijtEtbBmA8fcgY6EO7pfEeHcInOGDj2G
 /B3VXs2WIvAEH02EyS2+qbDx/+c7rEwEtA9cHdCKlJl9WQHebckcGn02vmURGoU2O5ys
 HNlc2zokBePjCCR0bAZJzQSTzo6W3id5IJy63UKUDynSg9ng4RXfggNGta2QTs7wuhTV
 +XDL4bjmAcESAi14swLY73wAQMCevf1pL19K8iqA30zb6K6jYczgFCvf1At+vUayLcIA
 kiWQ==
X-Gm-Message-State: APuU4Z8w+W4YUeIgW9gasj5J0WIeBXXJe75+SpvwKxO0ENk2jWGhz8ID
 3KdTTOtkFmlRBDUvRsfLp6SX0HbH/iNDC3y04g8vTGn1eI+ec5wRy57OrnHS/3A3UAc=
X-Gm-Gg: AYBFou3ofmRv9r405x7nVjVfvH6bP8eWaIBnTI/HsenFQGvat6cUYP+p3iQgwZf82xt
 lN3jF45Yhpup8sW5fX31lAJoDgpjESI7cN7kr8SCtxnMUdD7xXQH/9VxUhI3CIt8VJmL3nnZN6c
 6G6V9w72C3p4FPVyQIRAOmS/CNSUKwzsZyEfoO1q8aLbZ7zIp/o2wch+rzygTh0TXAaezIJ9fMb
 5/EQThZ0uN5H/BbxbpvZfQlMcRRuem4sa8G6y6f11r9IkeGaeAefN2KuYgq13wU7ITs6k78hOWH
 k1fcIQouQxB02gYEyQUW1nJyCxnQIKLRYoDckz9+QTdNkD5hiFv3ZqkNpTQnJwtB42BGd1PJZds
 s8u6/UtN3cFAN6P1B3yBYy9H5lk5zvk9l5rJccxh9Oq9VBWuArZ8rTTzgwky0DM6kyhO2aG6gi/
 uWQ+Vxz1IyOGyAah1UPVQFWi1/gP6S/VrSNBjdVDl+7XLRn1iXsZSNKYYUrjPcJ+7sDzbdAFO5B
 3qNAa9qg8dUNByspCE0B9rQPuKW2A2uGhpjyRekTt2qNVNESHpvwtqXz015l/bHGdzHbDBhUMHz
 Y0IoEy/xW0q0+RFFzUPlrpg5R24+zJg=
X-Received: by 2002:a05:600c:198a:b0:4b6:5dac:b61e with SMTP id
 5b1f17b1804b1-4b963ca042amr87321185e9.32.1794245333870; 
 Mon, 09 Nov 2026 09:28:53 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea745sm2008835e9.10.2026.11.09.09.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:28:53 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Subject: [PATCH 01/11] configs: stm32mp23/stm32mp25: Size the frame buffer for
 the LVDS panel
Date: Mon, 09 Nov 2026 17:28:52 +0000
Message-ID: <d49cbe10-bb1b-422a-9bbd-f78970fa131e@gmail.com>
In-Reply-To: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The boards built from these defconfigs drive a 1024x600 LVDS panel at
16bpp, but CONFIG_VIDEO_STM32_MAX_XRES and CONFIG_VIDEO_STM32_MAX_YRES
keep their 640x480 defaults, so stm32_ltdc_bind() asks for half of the
1228800 bytes the frame buffer needs. The display only works because
the frame buffer is aligned to 2MB, which leaves room past the size
asked for.

Set the maximum resolution to the panel's, so that the frame buffer
fits in the size asked for. The video uclass is about to check that.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 configs/stm32mp23_defconfig | 2 ++
 configs/stm32mp25_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/stm32mp23_defconfig b/configs/stm32mp23_defconfig
index 04aaa0f6b26..8d960a51e02 100644
--- a/configs/stm32mp23_defconfig
+++ b/configs/stm32mp23_defconfig
@@ -97,6 +97,8 @@ CONFIG_STM32_OSPI=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_LVDS=y
+CONFIG_VIDEO_STM32_MAX_XRES=1024
+CONFIG_VIDEO_STM32_MAX_YRES=600
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index e55ca2e3f0f..ac9f562c8ed 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -97,6 +97,8 @@ CONFIG_STM32_OSPI=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_LVDS=y
+CONFIG_VIDEO_STM32_MAX_XRES=1024
+CONFIG_VIDEO_STM32_MAX_YRES=600
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
 CONFIG_WDT_ARM_SMC=y
