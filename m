Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32ABC02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4A98082A;
	Wed,  5 Feb 2025 02:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FsRmXWKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C35807A8; Wed,  5 Feb 2025 02:57:16 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17056807F1
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5fc0c7b391fso1506992eaf.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720628; x=1739325428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7R0jo/rUYFma5hLL50+g7Ch8buA0BPEJfjxJhw6ed6A=;
 b=FsRmXWKIcdIYqwIMe+1/3iAvxWNyFFAf1hUXdd3RKzCGhsKrxp2bAxHzZzZl5q4iJm
 225lMedwadm20PVIbnpmA8ohgSQzC8eigVvQWu0+NAlSqJom9NzSZCR7FApC3MupuJLc
 PjE9axZk+kdTLj8vY9EmMwluscxhe47+ZdizA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720628; x=1739325428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7R0jo/rUYFma5hLL50+g7Ch8buA0BPEJfjxJhw6ed6A=;
 b=LNbSX641HSq+IexznhAM0PfBzWsN8Pbx9yJelmHR4e9A5f2F8g7dATu4PJrgac5jqB
 vPsQGqNK0ZON2quNXYhZBESwOCnDIXYHO1zho1P82WOUBcDRG9NCad94EyfFbr3gvF2O
 gqtXdbAhDL4mEfosLLw8ZxX/Yf6d5d2A6IEZZexRQyOw/OH09md16JbBS57h/Pk86xCG
 4BqRi0VurKIR+N+b4rD/hdO3xR6xv00UcAsKOOFRjaSCyDl3tCCCuuPS3zNQcLA8o6Q3
 aReEseXV9hHi6IQhRrtB+ovCKPctNarv4q4PUvzrlQeiCy4Cjq6ArnFHdBPcuzWkVSHE
 DP8Q==
X-Gm-Message-State: AOJu0Yz3Cb+aJgcH6PlCVAClktbZLHQEFZznlq/QeVFzngHRjtcEI1Qy
 GgKiautflID63ybxIN3wn+94aJpg7prCAISz3JNsERuEnL9Hw+ywoUK6gjbos7dSKlpbPSW5fZ0
 =
X-Gm-Gg: ASbGncvkOpE/WOb1Lpzfa52kNnOUxSBl/0QUn0nzKO7fYxnJ2wpi9+gUIWKXM7fPxdl
 5PS4cn3cqE7YZX4JdxkEiomAArGzShLpmW3QSqS/8+dK01ErOo5aO0hSYm4jU4MJqn/Iw5Q9EtF
 ZF3onqwvuY8zKULAXAJ+Gmqu1FIb3ZSEUtkbPvTsPiz09s3M/XOT2+EIPBrwCpsauEW/tWeObDT
 202kCIM5w/B/B4LjNRxWZVEnyxhtfCJZNMFi20EBRBNPDWYeF2kJfymosk3/0yy7stigVMmc++j
 kxooc2rYhy4j4jhl6+bnt7K0NOfgAPAHrsakekt5U+vaxea49KPY
X-Google-Smtp-Source: AGHT+IGZQrrBMgfLLLM2RVGgunMau0CHm2y/5QeuNymwqXJg3lIcFvHTbLvHwh6hLVR3ZJ57WhzIcQ==
X-Received: by 2002:a05:6820:1ad1:b0:5f6:b5f7:4f13 with SMTP id
 006d021491bc7-5fc479110femr701211eaf.2.1738720628329; 
 Tue, 04 Feb 2025 17:57:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH 15/29] rockchip: Include a compatible string in each
 configuration
Date: Tue,  4 Feb 2025 18:55:05 -0700
Message-ID: <20250205015606.2686149-16-sjg@chromium.org>
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

Provide a compatible string so that U-Boot can decide which
configuration to use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/dts/rockchip-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 39908495894..67cb2c3d165 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -200,6 +200,7 @@
 				fit,firmware = "op-tee", "u-boot";
 #endif
 				fit,loadables;
+				fit,compatible;
 			};
 		};
 	};
-- 
2.43.0

