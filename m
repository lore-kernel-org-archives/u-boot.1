Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7BCC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EDEF80824;
	Wed,  5 Feb 2025 02:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mFI/Mabt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93070805E7; Wed,  5 Feb 2025 02:57:05 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046118081E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e15d9629bso1801790a34.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720620; x=1739325420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rC9SRTHCVrEf6/o1EGQ/ZoLea5q2siVbQqcR3aH2Peg=;
 b=mFI/Mabtp1417DJF73orEGy7FrMMr0aU0Nn62R7YxrH1l8GPABzJbB55lKhQw5JjOS
 wjnpm3mwxfrtEy1aRClow2BwTsZPfn5GPvz8quh4wDOCgSOhnPW0SZBij0jAnfUinWiG
 O1st6VO6/KNGJ8BGJiG6GsvQvh+ofA9xIWG9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720620; x=1739325420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rC9SRTHCVrEf6/o1EGQ/ZoLea5q2siVbQqcR3aH2Peg=;
 b=oeVHYrP0scwUprUr2ylsDwhRIstgOhdPSOW++4qgGamIDrYV4kOZKW4rLvDozZq6lN
 LVeYLHK29GRbZTEC5xTAXWoxQs0nshB1rKDDePnDEVH1XhK0yd/uSVV6Y8tBOwt/OgCJ
 AAI4Fyi8cOMW5Oce5xBYtGiuhii6chusWEyMrzaEi0CiY856Q9jOwVrmkXVyMSDw+8iU
 phjmTpBqWspt8kGyYwgUi426v8ilkmuhMBT49/zl6SahiVGLgTlr1+/g3IhX4+zE3s6k
 a7yLHQqnxuV1wK4KZywOPY2ptVsQk+kS91tvgthGW27SrsSCKwO+OrsRI6SlGGn5q5D9
 Rrlg==
X-Gm-Message-State: AOJu0YwKjBkA3h8TBbX8Q4nC89bIpRk6SXdOsk9WNWN0nBKZA+DeuMAq
 hOcwbrOEvrE1pkV7GW4UtY2MNTivJHOWDdADxcGseRY4DLaxoEbrLBaaFhm3Ff1uGhX/4MhvIHA
 =
X-Gm-Gg: ASbGnctByvw7zEUEoMrkVH9sfUXtbsAqqj9B5iXmpIC1aZ6zsBNyg4XHb5wMIlvqyr+
 j4PlpP2OVj/mQ3QKRTp4K1akqTfujbwrubqX+l51Fu3TBnskizc/VIMgK+Fp0HwR8SyYM5Iu0JZ
 xoS+FxMoThLvyQbTafV82UDoRsfj8IpW49WTk3NGemMjACBuY+DPiAqa2NvfwhFqKWINqvKdoLi
 8/z6PML6ouwaEpkJuCKx5BW0Y9ef8wKDT7hvOa2qNiu7yi75h9p3f2BMG0tLiiCcIlZONrj6gXE
 PO9G0Pchrlghncdqmf+kPvRWndMtqB8UUBGCpC7YHDVf4oKpTS+e
X-Google-Smtp-Source: AGHT+IFSTdK05uiCRF36qEV29jN6j/J5sBBxI091cSkki4x4J3jnrQ3smg15q32gKKfJOL32fa1lZg==
X-Received: by 2002:a05:6830:64ca:b0:71f:bbbd:ab60 with SMTP id
 46e09a7af769-726a42a2e6bmr854247a34.26.1738720620704; 
 Tue, 04 Feb 2025 17:57:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 13/29] rockchip: Provide a bootstd configuration
Date: Tue,  4 Feb 2025 18:55:03 -0700
Message-ID: <20250205015606.2686149-14-sjg@chromium.org>
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

Add bootstd information for VBE.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8c6e62398a4..7cce213c32e 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -27,6 +27,33 @@
 	binman: binman {
 		multiple-images;
 	};
+
+#ifdef CONFIG_VPL
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		/*
+		 * This is used for the VBE OS-request tests. A FAT filesystem
+		 * created in a partition with the VBE information appearing
+		 * before the partition starts.
+		 *
+		 * Offsets are aligned to the media block-size, typically 0x200
+		 */
+		firmware0 {
+			bootph-verify;
+			compatible = "fwupd,vbe-simple";
+			storage = "mmc0";
+			skip-offset = <0x8000>;
+			area-start = <CONFIG_SPL_PAD_TO>;
+			area-size = <0x800000>;
+			state-offset = <(CONFIG_SPL_PAD_TO - 0x400)>;
+			state-size = <0x40>;
+			version-offset = <(CONFIG_SPL_PAD_TO - 0x200)>;
+			version-size = <0x100>;
+		};
+	};
+#endif
 };
 
 #ifdef CONFIG_SPL
-- 
2.43.0

