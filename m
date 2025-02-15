Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6044C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABC280FB4;
	Sat, 15 Feb 2025 04:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WALeaxCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C9F280F9C; Sat, 15 Feb 2025 04:24:03 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE41280756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d18f97e98aso17866175ab.3
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589838; x=1740194638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCde0bQEHfgN7EAeawnv299sbGGKVtzag4sUWemDxFM=;
 b=WALeaxCprhuyffyAOL62V+O2qGDdMTSbihZqUkYaqDdv5vl8Nvjyw6CXVLa/tjrZsh
 pML5q24fHrIuAUFJGXDkPm9VUtAOkx3FwJx++URx0JKr5Cd3AO8AbticNXbifrIIn+yL
 VwXFluFWhLVCgNwsi7fM9sZEjsii31XjZHPlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589838; x=1740194638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCde0bQEHfgN7EAeawnv299sbGGKVtzag4sUWemDxFM=;
 b=dKIG6AYwLXwshuBVkoiSO9rCe6K7wOT9As/0vYkwJP/jpmgWmpBaxKLals9ejfh4MF
 XEvfHZa25skbkpwaGqWXDE47jvw26XYc5OxmlRN8GW0awZgbf49McuA1i1/TUBB+suPB
 aWnELAmez6jyqbtbL/4gvlHq4Jm2pvCk+7U+LuTgZdqykKAs/2TdP2ZJjksAX61oVkPh
 lMPkmhV3dtITDxwd+bG0T5S0yz8/hSVYmuWVXexs0gjX6Xha2/Xc78J/ttitRZkT3Sxw
 nCua3qAeWbmFFzcpPtIqvQOHJiYSCBkVwuNDUXX6pLglFSJ2KtV6BoLOEKkqI55hJBRd
 UPIQ==
X-Gm-Message-State: AOJu0Yw+cdvWWyg7OFUm30uPkzdtg66Q6fSJ6HamyTWgPznnwKPvKff4
 71l3sBKUdjCyRSpEcSHGP5GdWp8+rWJ9rKvTUnN1qgIDjTiPApTFNJDJ3F4w4bsq4T1MDW4w5zg
 =
X-Gm-Gg: ASbGnctb10m+yZkoz4xntbxhOxBHPh9xYu+ZkTW3yMS37wq5i2NfBXa5hpkjxJzEld5
 7Ub/5s2edL8tVX26e+LBxI8EewOOdLRhpETv+W5/PPaDzY6NjDw0YPu0UF5ZxHQgJ2MP4O3Ao17
 9LszW/zI58SddJBll8gysgoGv3AjJEb05iOmYEItR9UWynwI1Jwj2r5+MXTucdcZ+qFS0qCDoX5
 DMPC7fD4xcmMOdBse2Rs6KYCe7ww2at1kdTLeVIMGvGFQmqxq7nb1Q1AQmcb0PFv9cJKgoYtkTC
 59ErUaOhGHoN5z7qS++6H27ZLc6YHK1+BBFTk3D4PbfbDzF3bvho
X-Google-Smtp-Source: AGHT+IGPo2j2t5rea88EA20Df5a2/g3p/dB4WExH3yZHqOoMEsYr0HcN11P+fy1eg91zoO77ZUUH5A==
X-Received: by 2002:a05:6e02:1a67:b0:3d0:1fc4:edf0 with SMTP id
 e9e14a558f8ab-3d2808f4c6cmr13341975ab.15.1739589838639; 
 Fri, 14 Feb 2025 19:23:58 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH v4 18/29] efi: arm: Omit the ARM start-up code in the EFI app
Date: Fri, 14 Feb 2025 20:22:39 -0700
Message-ID: <20250215032254.4121030-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

This code is not used with the EFI app, since it enters through a call
to efi_main(). Remove start.S and crt files from the build.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/Makefile     | 2 ++
 arch/arm/lib/Makefile | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index cb87a684754..2e569b330d0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -104,7 +104,9 @@ PLATFORM_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs))
 
 libs-y += $(machdirs)
 
+ifndef CONFIG_EFI_APP
 head-y := arch/arm/cpu/$(CPU)/start.o
+endif
 
 ifeq ($(CONFIG_XPL_BUILD),y)
 ifeq ($(CONFIG_SYS_SOC)$(CONFIG_SPL_FRAMEWORK),"mxs")
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 14e3990925a..9500ba6fddc 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -7,19 +7,21 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o \
 				    lib1funcs.o uldivmod.o div0.o \
 				    div64.o muldi3.o
 
+ifndef CONFIG_EFI_APP
 ifdef CONFIG_CPU_V7M
 obj-y	+= vectors_m.o crt0.o
 else ifdef CONFIG_ARM64
 obj-y	+= crt0_64.o
 else
 obj-y	+= vectors.o crt0.o
-endif
+endif  #  CPU type
 
 ifdef CONFIG_ARM64
 obj-y   += setjmp_aarch64.o
 else
 obj-y   += setjmp.o
-endif
+endif  # ARM64
+endif  # CONFIG_EFI_APP
 
 ifndef CONFIG_XPL_BUILD
 ifdef CONFIG_ARM64
-- 
2.43.0

