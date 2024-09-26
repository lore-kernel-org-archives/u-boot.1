Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541CFCDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E932388F41;
	Fri, 27 Sep 2024 00:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hcLCQhg7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB52188EAF; Fri, 27 Sep 2024 00:40:42 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA8A188966
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-45aeef3ce92so8646561cf.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390439; x=1727995239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw2aRuZtuhE4no2kAOWP3LK86Efv+ig5LuUCZQO1R0U=;
 b=hcLCQhg7A4c/MtKNkr3RgQwGevUi8sKD7ut9LWwxIIxD4cvId7DlmPcc+7sZDHFESJ
 OUwhCDh4ToGePmcnIyiOcWH9BXpdV0upj6WENl04TsSu8Da6IBlNXMo2jUN09w1Xdk6L
 q0S3VpAO1XftleC5Hz+Ym/b6NMvVNsJz03anQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390439; x=1727995239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nw2aRuZtuhE4no2kAOWP3LK86Efv+ig5LuUCZQO1R0U=;
 b=jm5WFzg89EwHf8tUVNKGkBYcmrYkVvSXno3CNEdq7QTP/bDkQ2vWIhOLtUoNCqEQO5
 0Gck1XAOoG4ZYmK2n0I7eTAGO9hsrYGvrcTs2jhOAdqLIUEQblSkFwC5roy4B9bRrc41
 OcPTI1ZwMM7V8ri+cwFKaMDoDbELfPUTrUaP18gN7pb8Q2vvHS+wXE9oeYYtWGNzg8PS
 csuGIDzGmP4YNG590phniACBsHo4LGHprNadGnEaAMiPW7vXtPxqbRLE0UUDbYfvJmNa
 vNxQjQABNp7lWx+ODiwaGT7TGrpvHEbsemstRyw9HGqd2ErJBi8MTuXX/LsFeOx1hdn/
 A3hg==
X-Gm-Message-State: AOJu0YyTDM+WV+/68TZv80vX9kYPVzZqdF5/xr8QxQLBcT1zUNH68DCT
 +4OXf+40GE1dXSiXTg2MxHTjE1PfimNURqSIerkmPs/Ku/nPQ1YpOj5sy8JbxmzQK+cm9Bkp/hE
 7g4eXLeA=
X-Google-Smtp-Source: AGHT+IFpnhVO83mP7utnCmAg2wyZd5hcCCAFEUYXdDwxj9gX/mt/51VBH2Libt9JZy/Qdlc9zdzy+A==
X-Received: by 2002:a05:622a:1444:b0:455:9ef:8895 with SMTP id
 d75a77b69052e-45c9f1e6549mr12878251cf.11.1727390439437; 
 Thu, 26 Sep 2024 15:40:39 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:40:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH 06/42] doc: Update SPL docs for the xPL changes
Date: Fri, 27 Sep 2024 00:35:31 +0200
Message-ID: <20240926223814.1276764-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Update the various references to SPL in this document. Make sure to
refer to 'phases' instead of 'stages', which is not a U-Boot term.

Fix a few U-boot typos and try to improve grammar a little while we are
here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/spl.rst | 81 ++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 4bb48e6b7b3..fba4a439d3a 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -1,11 +1,12 @@
-Generic SPL framework
+Generic xPL framework
 =====================
 
 Overview
 --------
 
-To unify all existing implementations for a secondary program loader (SPL)
-and to allow simply adding of new implementations this generic SPL framework
+To unify all existing implementations for secondary/tertiary program loaders
+(generically called xPL)
+and to allow simply adding of new implementations this generic xPL framework
 has been created. With this framework almost all source files for a board
 can be reused. No code duplication or symlinking is necessary anymore.
 
@@ -13,36 +14,39 @@ can be reused. No code duplication or symlinking is necessary anymore.
 How it works
 ------------
 
-The object files for SPL are built separately and placed in the "spl" directory.
-The final binaries which are generated are u-boot-spl, u-boot-spl.bin and
-u-boot-spl.map.
+The object files for xPL are built separately and placed in a subdirectory
+("spl", "tpl" or "vpl").
+The final binaries which are generated for SPL are u-boot-spl, u-boot-spl.bin
+and u-boot-spl.map
 
-A config option named CONFIG_SPL_BUILD is enabled by Kconfig for SPL.
-Source files can therefore be compiled for SPL with different settings.
+A config option named CONFIG_XPL_BUILD is enabled by Kconfig for xPL builds.
+Source files can therefore be compiled for xPL with different settings.
 
 For example::
 
-   ifeq ($(CONFIG_SPL_BUILD),y)
+   ifeq ($(CONFIG_XPL_BUILD),y)
    obj-y += board_spl.o
    else
    obj-y += board.o
    endif
 
-   obj-$(CONFIG_SPL_BUILD) += foo.o
+   obj-$(CONFIG_XPL_BUILD) += foo.o
 
-   #ifdef CONFIG_SPL_BUILD
+   if (IS_ENABLED(CONFIG_XPL_BUILD))
            foo();
-   #endif
 
+   if (spl_phase() == PHASE_TPL)
+           bar();
 
-The building of SPL images can be enabled by CONFIG_SPL option in Kconfig.
+The building of xPL images can be enabled by CONFIG_SPL (etc.) options in
+Kconfig.
 
-Because SPL images normally have a different text base, one has to be
-configured by defining CONFIG_SPL_TEXT_BASE. The linker script has to be
-defined with CONFIG_SPL_LDSCRIPT.
+Because xPL images normally have a different text base, one has to be
+configured by defining CONFIG_xPL_TEXT_BASE. The linker script has to be
+defined with CONFIG_xPL_LDSCRIPT.
 
-To support generic U-Boot libraries and drivers in the SPL binary one can
-optionally define CONFIG_SPL_XXX_SUPPORT. Currently following options
+To support generic U-Boot libraries and drivers in the xPL binary one can
+optionally define CONFIG_xPL_XXX_SUPPORT. Currently following options
 are supported:
 
 CONFIG_SPL_LIBCOMMON_SUPPORT (common/libcommon.o)
@@ -75,7 +79,7 @@ CONFIG_SPL_DM_GPIO (drivers/gpio/gpio-uclass.o)
 CONFIG_SPL_BMP (drivers/video/bmp.o)
 CONFIG_SPL_BLOBLIST (common/bloblist.o)
 
-Adding SPL-specific code
+Adding xPL-specific code
 ------------------------
 
 To check whether a feature is enabled, use CONFIG_IS_ENABLED()::
@@ -90,7 +94,7 @@ U-Boot Boot Phases
 ------------------
 
 U-Boot goes through the following boot phases where TPL, VPL, SPL are optional.
-While many boards use SPL, less use TPL.
+While many boards use SPL, fewer use TPL.
 
 TPL
    Very early init, as tiny as possible. This loads SPL (or VPL if enabled).
@@ -177,29 +181,30 @@ files instead introduces another set of headaches.  These warnings are
 not usually important to understanding the flow, however.
 
 
-Reserving memory in SPL
+Reserving memory in xPL
 -----------------------
 
-If memory needs to be reserved in RAM during SPL stage with the requirement that
-the SPL reserved memory remains preserved across further boot stages too
+If memory needs to be reserved in RAM during an xPL phase with the requirement
+that the xPL reserved memory remains preserved across further boot phases too
 then it needs to be reserved mandatorily starting from end of RAM. This is to
-ensure that further stages can simply skip this region before carrying out
+ensure that further phases can simply skip this region before carrying out
 further reservations or updating the relocation address.
 
-Also out of these regions which are to be preserved across further stages of
+Also out of these regions which are to be preserved across further phases of
 boot, video framebuffer memory region must be reserved first starting from
-end of RAM for which helper function spl_reserve_video_from_ram_top is provided
-which makes sure that video memory is placed at top of reservation area with
+end of RAM for which the helper function spl_reserve_video_from_ram_top() is
+provided
+which makes sure that video memory is placed at the top of reservation area with
 further reservations below it.
 
-The corresponding information of reservation for those regions can be passed to
-further boot stages using a bloblist. For e.g. the information for
-framebuffer area reserved by SPL can be passed onto U-boot using
-BLOBLISTT_U_BOOT_VIDEO.
-
-The further boot stages need to parse each of the bloblist passed from SPL stage
-starting from video bloblist and skip this whole SPL reserved memory area from
-end of RAM as per the bloblists received, before carrying out further
-reservations or updating the relocation address. For e.g, U-boot proper uses
-function "setup_relocaddr_from_bloblist" to parse the bloblists passed from
-previous stage and skip the memory reserved from previous stage accordingly.
+The reservation information for these regions can be passed to the
+further boot phases using a bloblist. For e.g. the information for the
+framebuffer area reserved by xPL can be passed onto U-Boot using
+BLOBLISTT_U_BOOT_VIDEO
+
+The further boot phases need to parse each of the blobs passed from xPL phase
+starting from video bloblist and skip this whole xPL reserved-memory area from
+end of RAM as per the blobs received, before carrying out further
+reservations or updating the relocation address. For e.g, U-Boot proper uses
+function setup_relocaddr_from_bloblist() to parse the bloblist passed from
+previous phase and skip the memory reserved from previous phase accordingly.
-- 
2.43.0

