Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE61DC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4659805A1;
	Wed,  5 Feb 2025 02:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EOO8sMVx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914B580819; Wed,  5 Feb 2025 02:57:03 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F7B805A1
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5fc13355a5bso2895518eaf.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720617; x=1739325417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5nJH+11W6i5NAwxtPtMMFtfJx7q7OGOw+9IQX0qqZ4=;
 b=EOO8sMVxiecwAJJJ7WX6ZVquTo9eWspSDFysaHMJ4uE0H9vEYCDTs4zS4kGNY6o1jZ
 ZHjVYz637SoOfG3UulGa4Aa5L4IkuyXYwfTHILH7Hd8JQjibPKLic8aQJWBDC7YgGJZ4
 dpkbaQRk3GyLFUsEwivkNAofzSzWcCOBrEBR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720617; x=1739325417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5nJH+11W6i5NAwxtPtMMFtfJx7q7OGOw+9IQX0qqZ4=;
 b=CaCLoSRsLurKKGs3+mbhodcrVnYrVL/IaTvRA8ZMVKW1eU8qoSgoZEnbH46K518VQn
 acC2m3jdj+26JJHI5Dc0iRm9sxs2f4LxKaHJRA39d0A9ewZ/S86U5E6hO2E4IKVRg+J8
 2KxO5NRwQPHMX0cRvqUBwEpSubgpbMFKGzEUCDqonDDWe6rK7JyOevb5QP3/otV7mEIJ
 /TvTHa8KudTSLjhPpcAhsqtr+2xHbnt6p7c4HpkH+BYHwRPfWMOfNiJwKu7O/Ob987UC
 GnubKKSa+eot+npiIvhFkIyne+82JOA6T92S/G3tfyBWvtDiVk6TrInL1v8DNgJp9JPQ
 +8mw==
X-Gm-Message-State: AOJu0Yyhxt9Wywbw5Kd+MR/ng7C810wn02+9jlSPAP18nh9Fy/GbOmOD
 948vgaBlLnqKVGllUClmtiAcUGn+A9KANXbi6wtIsMHvLj1yOT+olEw98Oos8eB/iiUxz4F/SMY
 =
X-Gm-Gg: ASbGncvt1FCVNDUK9Ogta+A1EkKyeFvHBsJeH8hQLZpe9zhoaA+P915JWwH/MJdZLn6
 XK5FMqcl8PHc6++7p5LFgnXFxICq4n9KEAuXi7pk11W0mYHVHkPmAOj1mLaqLQBF9O8mtWS/ld0
 2voHjmaZ4AbwVB3kxh83aknkFab/s/ndoJFyiyIAhfonquPz41MNSOr1BUJOjM5+ijuwbSbweVh
 M0Wj6e2YspL2iiKY/mMd5x6YDHEqYCKK9g1axW8BmRO81gcPzk90pPLYojwbmlYzOro/fmlLp5t
 BM6TuwqQdACv0EDv2C4FGsm+aXxZck4yr/CUPdkBow2GPpQAqmLi
X-Google-Smtp-Source: AGHT+IHODHsmvm3YoDyhffqhAvNXKq8OfmTLFSgquXsI3xX5YB5o5cEUenIjv5/itUZtEftflG74jw==
X-Received: by 2002:a05:6820:1995:b0:5fa:8455:4784 with SMTP id
 006d021491bc7-5fc479deb80mr791402eaf.7.1738720617247; 
 Tue, 04 Feb 2025 17:56:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 12/29] rockchip: Specify the phase in the image
Date: Tue,  4 Feb 2025 18:55:02 -0700
Message-ID: <20250205015606.2686149-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Add 'u-boot' as the phase for the images intended for use with U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 281119a53d3..8c6e62398a4 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -53,6 +53,7 @@
 				compression = COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
+				phase = "u-boot";
 				u-boot-nodtb {
 					compress = COMP;
 				};
@@ -71,6 +72,7 @@
 				arch = ARCH;
 				os = "arm-trusted-firmware";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -90,6 +92,7 @@
 				arch = ARCH;
 				os = "tee";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -112,6 +115,7 @@
 				compression = "none";
 				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
 				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+				phase = "u-boot";
 
 				tee-os {
 				};
-- 
2.43.0

