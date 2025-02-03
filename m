Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D896C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0555F80725;
	Mon,  3 Feb 2025 18:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nSxHNp3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFDE8096D; Mon,  3 Feb 2025 18:44:33 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1BE800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eba0f09c3aso1112957b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604669; x=1739209469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24AH3XqAfL8Y9kurFurPPsOMB3Z/UEFz8hPlTtpv+Tc=;
 b=nSxHNp3DBeHNikBjAI92XJaa8aJpSDhRrWafwn9v6GCXl39bnkdo244uT1z3cQM4it
 TpjLZQipk2EgfDzeljNmNdR/pWtcmF6WgmYiZbHlzw9Wu4XuSW46xVlaDiIEuevACgFU
 ueYN0awZ7kVNRuekGU4SlyVr0zOSTN/hzEP1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604669; x=1739209469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24AH3XqAfL8Y9kurFurPPsOMB3Z/UEFz8hPlTtpv+Tc=;
 b=iHPgkWOXajgvz1YeZlo5k7rnYJht6+s/0JjBcGs/YSrkFtnJl/kbExRNSm6xITg0/v
 LwWh6LB4v4HmkntdPkDP4me7hGgFNhcrExQlEtJPjD7hKbVxsGE+FlDIvIk0z43MffDN
 0fCL77xZvBIiEhbhMt17T4GMEoq1ILs8rpSQUHLa+kLl3knC+i0fg3hMAc+mn693EXlB
 D+y2ilyh4MTAhteNKa6uFY1Oizz82cSw6cdJ5lkGVGWnV+mscDn1uXgQjbiIZlmOYgbm
 /CnRd+KYFlb/5wIDqmA8Vi4k+Om5h1P58tpyjDkJ+l0xJUrBdpGvd93tzuCmzWu17VwS
 dqow==
X-Gm-Message-State: AOJu0Yxgb2DTr2k1IXdQvuYzXVI+yQVhG0/na0NSaXx9Sl30JULuHfLU
 gc30gO8pwn7zrKI4s2Terr57ugPJP0cvxErSZP7BDQecxe6ALADKP5WD9cQXX8AJJd9xmi/1io8
 =
X-Gm-Gg: ASbGncu5HH6VPrJgqyIE2yN3svWWJsql4vPNE/EXw+7+f13BaIBUWEXOHwCY29Pzwo+
 yG8weMoPQPn0wp1rYMsn/LUXGe++DDi/352WVZMgQsbPOepne7Lnvo8jOGDKss2JeQVLcCJyqlO
 KteYEz0RIiSpLlCpiU+b9rWHpwrkUyLTg17UZrQZqMz2bX4VuplxFb9uH7eq0p2du7+y8L1vq38
 gKogxmYWRkVqobrntWKjoZRO1l9AKfoN/AcsJRV3wWZsNmtROi27HGeb/pXtvyFEkU2n8SrdE7e
 mgWzobdJm3HP+61iJKkOPS/V9eEnddwgRQZZQwd5axCnTbuTj0J/
X-Google-Smtp-Source: AGHT+IHj0io4GJzhkNGmtZcXGspXrEC9fOtCQcvFbgt9BP41DXP/+z/GjHvGwokhPjUK6GkH4kViqQ==
X-Received: by 2002:a05:6808:38c6:b0:3e7:eac3:ec8e with SMTP id
 5614622812f47-3f323b7886dmr16967553b6e.33.1738604669687; 
 Mon, 03 Feb 2025 09:44:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 28/32] efi: Generate the app as a shared library
Date: Mon,  3 Feb 2025 10:42:21 -0700
Message-ID: <20250203174245.1331464-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

The app should be built as a shared library, with position-independent
code and the -shared flags. Update the Makefile to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 3958ea45b9a..990114731b4 100644
--- a/Makefile
+++ b/Makefile
@@ -452,9 +452,13 @@ KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
+ifdef CONFIG_EFI_APP
+KBUILD_CFLAGS += -shared
+else
 # Don't generate position independent code
 KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
+endif
 
 # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
 UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
-- 
2.43.0

