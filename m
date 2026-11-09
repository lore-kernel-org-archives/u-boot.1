Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07245606A330
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NdBvkRj1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MRkt15Ko
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D19F5608E9;
	Mon,  9 Nov 2026 17:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQqyuGDEn2fa; Mon,  9 Nov 2026 17:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0870B60A46
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245407;
	b=QpO1oK/TY1Mo5B5H/9iRYc1gTqFpDis6ctGvLV3zF77BVlW3xduKBpZkCbHfVS5wKHiu
	 tSFXVVjl2CBpM2NUWEBOnv5PK5eePfl3LvNJiabY0mif5TrOLbeKRfzu77ujm7NXzIQlM
	 qCDzR2Jz+hqS4+WXA1r7bPQClpFpR5QTGBtfKHm/7cObsa+2cl408r4OqHi5qPQVRxcXA
	 peu7qFFY7UP8fwjsQz37U6hXeqYmV88NFYMFHrWYsi8bjxajmoFrl7DHKuFLV1bgZAaFn
	 pbbtJWcNCZjrCJwLVpBv8A9/8s81hPUOCxc0wXZWrxPkDQwXl14schUDAn5/PcIv4HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=w1ZUE50yVxM2vJjBjdK9xEL6JYDO6mpwSfk4tUi/NeY=;
	b=lkgJJnZ88Ktx507StxgmWXImfkT4uL74jC+eV5vUt+djQGcG//uxc+6hwyshi4S9xpoF
	 0FHYhJfN700YkWdNQEuq5kQt3CBSU7ANC4MoRIBerql31mLwnb8yh+7UCdZvVuaxCVZEE
	 atpK4dEBg77Mt+ZxSyr1EUjU4Bx9Sh1TaoSLKgpACwtphbak6ygW9SZj4qLCmwE4/1fyX
	 JGmjtQ1hLWnoRGOyJnEz6hnZgGwigPxSFKNpbSgv7GeH7TupUMm3bLmaOKEzzmcioQ3ML
	 xxwdHDiY1gnpHRKLO6+IbEvCTSk9WKkyGnuNFbuYd2nTDTSEEVDtduF5kIxqWO2ZYog==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245407;
	bh=w1ZUE50yVxM2vJjBjdK9xEL6JYDO6mpwSfk4tUi/NeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NdBvkRj1Sc4h8oUPyVbqHMRXzySS1nmGr8o6TD5jIloQUoXaRoKVKvtNL8YrQAtuG
	 sxgZh2Fae/ZklAPqRryZEmjuFEOUiBmFYNYOlcTWGgr0oTWC+3bQn9X+qeB6fvn4VU
	 firQInJDQR3V7rQdksiPkBibVyjTGZSXipM6WLAysiXabsQFIapDgmfwlUed3MRDrD
	 Eg3hCavMoMDu7k0MCrMBJPWmbZLI5+KXt3rzqV3JXwUQUDNmZ/5jBkj901SJFIfQmu
	 DtYU4J4ql2N6Dv8sixIflbMwU6bx1DHW5kbL0uTWM+ri89M28fS8DqVZJgcU7CJzs6
	 tCPretBlZAb4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0870B60A46;
	Mon,  9 Nov 2026 17:30:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C382928C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9E3740176
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmmIf8aJe6UK for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C5CF040068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=MRkt15Ko
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5CF040068
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:30:01 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so12668885e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245399; x=1794850199;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w1ZUE50yVxM2vJjBjdK9xEL6JYDO6mpwSfk4tUi/NeY=;
 b=MRkt15KoMdnBN+b1HyfwWIwXvvP0lT4ed6hdR4lKutl2RhIMh0DqO0Wm4ZTcRw3t9/
 h89eG7aRcIJRQQNolfdemwr250yvF1z6pOajGvWHTjEC0bFJo8KJ3o/DAylCJzFVionX
 Z0MrJw82Hx5BBbfm1fimOW5NSUMYH428eWK7LW4ou5w+/w43ivV5+RMWbxg0K/3mx6AP
 MXrWRE6sJk10A7W6DgCoXTRzFvdtWoHJ+jhvj5IPbrSV4O6TIdxALBhaywgyD6vsjGIT
 yQlSjxkewtJBiFUp5HNw3PfOwplvmcoYF5WJjyjXy5zG95bkG8R3NPqFK2aCu5ZnxSnt
 MOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245399; x=1794850199;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w1ZUE50yVxM2vJjBjdK9xEL6JYDO6mpwSfk4tUi/NeY=;
 b=QQLL6FFrfNfnLLp1PyPwGxuMBBmoXYgLTTrn6busn9UBoF++S1bcBHPDynpbGCpjEt
 Gp4aFeO98dmpR61lI+29EjV0DuDeK1ivZXtOl6HTT2lJ4vchttYCuoK5NxueBF1fceiX
 /3Hy/HBy8w3hsnj9DO4h4OQSIms9pmFPVEbKfcYzG9Fz/wdtbbR+W5YetFWp3TCcAbeV
 YBlxkg1BtWGD/sq8MiDueSq0MrICy1xmjGqwv5qRi0qNJWbr6ZK1hjzWeTb+b5Sfmt7S
 StuCYzjLyBJUe+3IfraQpXjudmJ+aQoui2ljjiYGSGYowR5MwLXPzeUfmGCUjn/wuOIO
 nQlA==
X-Gm-Message-State: APuU4Z/lm7DI9OD1tblaN3NK6L3SENu/hVMGc5sW6CKw+Ajp79/gZVsZ
 3etjN8JnxFxzbdkVYPrvLMC+JP15kOSeogzhqDn2kTOoiNJqADPyBVTzyVNUq4uutIs=
X-Gm-Gg: AYBFou1P3NuvYsGXJjLbCjY8cbLKVqj6ggXk3/LlEwG4xz7KTEUupO+AMdu28LhlyiE
 nde1+ynIYbUJA8M7WEI+QXTbXsPm8trdBTMakGcDtAAOlfneAhJi+AHe7NS3am3aRhQ553/SC7T
 XCrgl9U6yBbDwbqu/x8qBcxRHRV7egbegGDucc6nBG7LCrv2egBL4D+OnFVVW2T9DAScUeXdlTi
 rnlMyiSz63fQO8X0T7bTsG4gzPeGJnZaHKGD6wbMXckowXXvhuBjBEMzwyzFZzE5tJUUKBj7f1S
 wrvK9RDOwYAROMT/4wK3J4CKHbSzhHwSkSZ2uYLlcathz4w4pFsUs3A5WlSIG+TZa1XhH7cDrZc
 CHtLtKWzenW5EpPVc3DpYZb24KTY5siBF7VgsxYMLkIs1/vkKKFdRxNy7jS9VkO3phEYmTkHKng
 70ymFJ8mjb00osICjui9E6bXXqMcueoJ8aTh/F9VK+ZXgIgfw5zpN20wsNDPd0iY5d4YkTbeKrs
 tngPK0FNpA6KYYbld8mtPfxppNynnxjghs2lCyZag7EHP0fd+p2A3KWw7nbAtdLkI1cZTw+HVWN
 3u1YpBXM6vzqdY7wBFrKmH/FMuNZFKU=
X-Received: by 2002:a05:600c:4f13:b0:4af:9cae:df63 with SMTP id
 5b1f17b1804b1-4b963c91294mr109002135e9.31.1794245399239; 
 Mon, 09 Nov 2026 09:29:59 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835c37bdfsm113661f8f.22.2026.11.09.09.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:58 -0800 (PST)
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
Subject: [PATCH 09/11] video: tegra: hdmi: Skip modes larger than the DC frame
 buffer
Date: Mon, 09 Nov 2026 17:29:57 +0000
Message-ID: <ab368609-f5ab-4169-9c53-c9590766cadf@gmail.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

tegra_lcd_bind() reserves a frame buffer for LCD_MAX_WIDTH x
LCD_MAX_HEIGHT, and the DC takes the mode its HDMI bridge read from the
display's EDID, but tegra_hdmi_mode_valid() only checks the pixel
clock. A display announcing a larger mode makes the frame buffer run
past the reserved memory.

Move the DC limits to dc.h and have tegra_hdmi_mode_valid() refuse the
modes which exceed them, so that a smaller one, or the default 720p
mode, is used instead.

Fixes: 2dd1092ab887 ("video: tegra20: provide driver support for the HDMI controller")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/tegra/dc.c   | 4 ++--
 drivers/video/tegra/dc.h   | 4 ++++
 drivers/video/tegra/hdmi.c | 5 +++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/tegra/dc.c b/drivers/video/tegra/dc.c
index ced49718834..07e26f23970 100644
--- a/drivers/video/tegra/dc.c
+++ b/drivers/video/tegra/dc.c
@@ -49,8 +49,8 @@ struct tegra_lcd_priv {
 
 enum {
 	/* Maximum LCD size we support */
-	LCD_MAX_WIDTH		= 2560,
-	LCD_MAX_HEIGHT		= 1600,
+	LCD_MAX_WIDTH		= TEGRA_DC_MAX_WIDTH,
+	LCD_MAX_HEIGHT		= TEGRA_DC_MAX_HEIGHT,
 	LCD_MAX_LOG2_BPP	= VIDEO_BPP16,
 };
 
diff --git a/drivers/video/tegra/dc.h b/drivers/video/tegra/dc.h
index 2a4013b3355..20b417e7b57 100644
--- a/drivers/video/tegra/dc.h
+++ b/drivers/video/tegra/dc.h
@@ -14,6 +14,10 @@
 /* arch-tegra/dc exists only because T124 uses it */
 #include <asm/arch-tegra/dc.h>
 
+/* Largest mode the frame buffer of a DC is reserved for */
+#define TEGRA_DC_MAX_WIDTH	2560
+#define TEGRA_DC_MAX_HEIGHT	1600
+
 struct tegra_dc_plat {
 	struct udevice *dev;		/* Display controller device */
 	struct dc_ctlr *dc;		/* Display controller regmap */
diff --git a/drivers/video/tegra/hdmi.c b/drivers/video/tegra/hdmi.c
index bfb48b25187..caf2b3f2f34 100644
--- a/drivers/video/tegra/hdmi.c
+++ b/drivers/video/tegra/hdmi.c
@@ -431,6 +431,11 @@ static bool tegra_hdmi_mode_valid(void *hdmi_priv, const struct display_timing *
 	if (timing->pixelclock.typ > priv->config->max_pclk)
 		return false;
 
+	/* The DC frame buffer is only reserved for modes up to this size */
+	if (timing->hactive.typ > TEGRA_DC_MAX_WIDTH ||
+	    timing->vactive.typ > TEGRA_DC_MAX_HEIGHT)
+		return false;
+
 	return true;
 }
 
