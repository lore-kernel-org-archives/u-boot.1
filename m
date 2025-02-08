Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97632C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C168083F;
	Sat,  8 Feb 2025 18:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hqqXheMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D55DE80820; Sat,  8 Feb 2025 18:12:11 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4226380820
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso244561339f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034727; x=1739639527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twAJdcoqW6Hhmcz7t4XbbP7/XHadISls0bzvx4thqZE=;
 b=hqqXheMNxtrZauQtixTPHMP416fJ2rxNzDoZdnt1BeIsOxvo+nU6eECEeHE57fCVOx
 7LzWegg0ge/Dab8oZ/BkxIEcqm9lDtTyyK/tthS4bswhLx6pXA1JCVOq1hL7EOXRuOci
 ZxkfqBEJQImGsHrG2+YxGAN/fCHzozAzPG2lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034727; x=1739639527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twAJdcoqW6Hhmcz7t4XbbP7/XHadISls0bzvx4thqZE=;
 b=cnJW0ZbQoHg6YBunhQ64ejewp2xHXnFaMlsUKTJAVMYXPKQUrR/rN296PeKp2wJbCA
 Xvi5SVMuMc/d5RWiMmh48aRYbmRzDfVNGOzqjw1aE5liQpqNl71UdDD3sVyvg2DXSWA+
 CR/zgEQTaQ7OT3vBr6ihgpiapW80pcRp+TGO1ebhjcCwxvxfGs2H1gViK87YNxu69umM
 5nr2ZZ7KeeeawbC1pW/IoZLStyxryE3GQ+YINSA+ZSK1rtgbiloBnMQFjHCyTpXewq8a
 qlqoToPcNIeitW7Wnm0QbgNZEOBqgok6xv/HEhfwFF0FjW2iAkgVFpml29r8ksWqD+Yi
 XADQ==
X-Gm-Message-State: AOJu0YwAaKQq2+449XD6f/XOP9P5JHRpUJxeo9jfoHo4C0AzoAaRLB69
 +AsUwDwRZn7V66ppvyJCRvSIGC51IusAHS1R9OVOhuVHR+v7CgdcYu4b5AvV1U1BC+KAKczZDJQ
 =
X-Gm-Gg: ASbGncudZF28HRTuEROmupn5/vZY3Q4qpzJp7Na6nUmCjewf9SjCLOF88Z0zk47ZvXH
 a1BONtiD4MFOiOeEFIpgMyzBTqrncsUodE4HbNR4JauGBNHiXVba396RA6FYFB7UxCVLqIXlZHm
 JQJpCS05wDYHo0ZkZ5krGDGYB+2b7NK5BYngwmqhprBOFdcNq51tdWk03RWxcYW1hOVDTVjMSi+
 X7QDhwLt+kheyHL3chfVGszmLbGdBNU58DT0Z/4uY9D1vLH+j0mqRM57eFa4Eh9RRtoyLkbO7IO
 oOdJDMCd26SSCKeRx1166GOeC0S/HpkRGo2UkGOAikJInjiO9b3q
X-Google-Smtp-Source: AGHT+IHcNzgHe/um22JjfazIQb4LFTfaeujnlYrzwAxSCMkVzeq/2ZsCV6HxyWihBmokYr3DHhTLAA==
X-Received: by 2002:a05:6602:3713:b0:843:f220:fa3d with SMTP id
 ca18e2360f4ac-854fd8b2d05mr703759739f.7.1739034726741; 
 Sat, 08 Feb 2025 09:12:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/29] Makefile: Avoid using TEXT_BASE if not present
Date: Sat,  8 Feb 2025 10:11:21 -0700
Message-ID: <20250208171154.1305761-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

This value is only available if CONFIG_HAVE_TEXT_BASE is enabled. Add
conditions to avoid introducing errors in link scripts when it is not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Depend on CONFIG_EFI_APP instead
- Drop change to u-boot-elf rule

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 2f7614191a1..f989c31073f 100644
--- a/Makefile
+++ b/Makefile
@@ -1050,8 +1050,10 @@ LDFLAGS_u-boot += -z notext $(call ld-option,--apply-dynamic-relocs)
 LDFLAGS_u-boot += --build-id=none
 
 ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
+ifndef CONFIG_EFI_APP
 LDFLAGS_u-boot += -Ttext $(CONFIG_TEXT_BASE)
 endif
+endif
 
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
-- 
2.43.0

