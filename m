Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFD8CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E8784886;
	Thu, 28 May 2026 19:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XwkrJQ2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB41848BD; Thu, 28 May 2026 19:11:41 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFFC848AA
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dd73b7c757so6080873a34.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988298; x=1780593098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+v0ly3OEe7Nb3GdlEfeFV7933Mo42BV2j1USMkvH7o=;
 b=XwkrJQ2Zxu26vCNFf20ACzsAv00BSWLZPXl+/w3F7bxone9a84uBPw/qm3lHrTS+Vn
 OZ8GOa3HkpFv0p04fnmnvdz0TznYeH97FZhPJnt24v8ZyfEYf5twbXkPOOOjZ2tHtj4C
 BZj1DRJCgv0AwAuH49K90ysWHemRbbslAWZ3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988298; x=1780593098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i+v0ly3OEe7Nb3GdlEfeFV7933Mo42BV2j1USMkvH7o=;
 b=btjxAyVJc3jlM17M1sdAQ7rZS+ak0jx5JcpIqpn0Fwz9dqLyrNAwQTIimGlK76Y6jI
 JInBXezGO5tLzqGNqU/Er1ILJZo4Wx2L4m6UOq629/OOrCkx6UyX4m8HA2yi1o/PLorU
 9M6UAMTtsDRxMMzD5pANvYf/lo7CB7+gJfI8HpZ1JOiGXFfvqn3V6cmcAH2KHzqA6mmp
 8OXAzP2Cq0uRwr/fZiDED/rULuVWVqyEmA2npXPU4Mu5hm5Tf+y3KXgvSPLTqMUzwFzL
 Y6O2eZdVEIcmDQUNooeKP35d0L/tBA+R0WghIcaHZxoD+KA+zWlGlx1LDTmMuyn8eUBb
 P8Kg==
X-Gm-Message-State: AOJu0YzVx4+5VUUx+IOLL7MZxEkti38EsZIWpm5s6RjhgNuSDezRqz6o
 4i1JLxYXP0AamCpSJwCWqnm7VpDkYTgjTQKuSXGuB9NWnFosLHZkbb8wfGn8IF2N5gTAkhO/8TE
 im/weMiZ5x/o=
X-Gm-Gg: Acq92OFLODUz2Hhs+WwUI5FbsFrSr0SC6Nz6FdI5gA5rYHQTG1lX43oLMWyPcaGaIGO
 +TLNEfzdvVUMCrQRR8uBTnsNsB31IhA2eCj0HzRk27tx7nzpZgz8OnkPBSrbp5nFKq0vLuxkzUR
 zgMc3M7eEKjZkEuz+Baeby23wGswf3Jdkyz14m+y6hM2M7fE5ECG/fmpaVGDSGowTBe4CJWUpTh
 zcGpAhK3px6Q6x2ezAeFJ+JBofuR5O6RuY80JRfIYd0ZuqL7Dh5UX/URV+UYrQ3o/gKgeL8YfMG
 BPGIyx5vOyqxEUqoUbQP81OFvRKUPU/nl99XAWI9rpBMsdX+cfIrh02jDqiuN2Fdq6q3mLcojpA
 BXJqMBGnhYAlJNldZ8teBM3ZIlylbQVHQI1exjpHNW8g8W0fvyeP80gpqdtFz1R7cH/KjZxQ3Id
 iY6QITvqPmEIQKHRXhkQNRoSB3dKah
X-Received: by 2002:a05:6830:828b:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7e5fed4d53cmr18503220a34.5.1779988298084; 
 Thu, 28 May 2026 10:11:38 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Chris Morgan <macromorgan@hotmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Niu Zhihong <zhihong@nzhnb.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 18/22] rockchip: Add documentation for VBE
Date: Thu, 28 May 2026 11:10:25 -0600
Message-ID: <20260528171043.910264-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that VBE is running at a basic level on rk3399, add mention of it in
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/board/rockchip/rockchip.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 141071f528a..f90d27cac78 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -533,6 +533,19 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
+Verified Boot for Embedded (VBE)
+--------------------------------
+
+VBE is supported on rk3399 at present, with SDRAM being set up in SPL. The full
+A/B/recovery flow is supported in U-Boot.
+
+To build this, use the rk3399-generic board, setting CONFIG_OF_LIST to the list
+of boards you want to support. All boards must use the same SDRAM type.
+
+VBE uses internal SRAM (IRAM) for the TPL, VPL and early SPL phases. The stack
+stop is near the top of this (0xff8eff00) with the 256-byte bloblist immediately
+following.
+
 TODO
 ----
 
-- 
2.43.0

