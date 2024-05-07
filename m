Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB330C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E5C3883C8;
	Tue,  7 May 2024 19:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vmz+/D7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF93F883D2; Tue,  7 May 2024 19:54:11 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97C58836C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3c96a298d5aso1598543b6e.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104448; x=1715709248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPjYNPqX1Tgna69E3svOvEyI4bw9APWQvUI+IO3XSkY=;
 b=Vmz+/D7igTgjpnqSo41J+qWioxby00trzUlwSYPvSfGBpagLKEFizY/pZV9auSpJVN
 iu0KaL7tDJXjPPp7XzP/XhZn80HopHvlCAgYx2drzwcE2j578pw7f00hkekcumo0pQFe
 7R9JH+ypX/75Relj9//kiTv/UTBNXUDcARUSg3DvvPPEZT5wQ+b2nQLGuOp767tIUvXE
 AKRLO2ZJzCISUbqYzOqVgd1FPphmCyAsU6lBGWafrYj3zbysuCnUkH7ivI04SQiM8DnT
 4uXqTthdkoniZ8e4k7D+ITKSmDiDgCf4z+BJWdJaQuvExhYeU/qvbIbQ9qLpaylHxk0H
 R0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104448; x=1715709248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPjYNPqX1Tgna69E3svOvEyI4bw9APWQvUI+IO3XSkY=;
 b=vcgVnuYjbGfqAOMDaRbqgWi1NHB71OKwZclIVXgmSmpOTZFY0dAU467wnJb98N1ace
 rQKIXoOAJjvzarrHfHqhyM20Sd1QY0Yw0DOwrBE8AQlOY9G2tkWTs15AHCDC7P6X69HK
 FNmGrIeWuzxxh99rPoHGY06tHU0oMi8w9QbcVQN35UvoIYmHeVJQcpb60i1a7Dy23nMx
 YH/77H1v+1d8PuNKNHPdZo8zlL2CKyY3E0L43/Rdh6Ns5c3/CkNSbskhawRzq/DTMFFy
 D9s0eq6vk94BMcxsPIlGrrx4L/vvA56dxO8jiR6SvIyM39wgqU5R8aJnMktZMN15Bmcw
 3Dtg==
X-Gm-Message-State: AOJu0Ywz8uECKsLfj6oTb0Hz+r6PJsJX/dQ07ecD4L52Ma5cFFvzrUvG
 QIs9KRCa5PxmZaDgk1XqDOajzwQXd5fk5bgdzl7XHyOXxfSaE/R0G7RZwSHfouRmKi7e5lW12qA
 7
X-Google-Smtp-Source: AGHT+IHrVS37B93LI3BRSDrGI5Zw0VyCQozoE04ZyfR9uHN6Hb4yqKvPObn3WX3oeThGIFEDbNNzow==
X-Received: by 2002:aca:1c09:0:b0:3c8:2fb0:dc4 with SMTP id
 5614622812f47-3c9852ab0d7mr373834b6e.4.1715104448295; 
 Tue, 07 May 2024 10:54:08 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:54:08 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Andrew Davis <afd@ti.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 05/28] image: remove redundant hash includes
Date: Tue,  7 May 2024 10:50:47 -0700
Message-Id: <20240507175132.1456512-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
u-boot/sha256.h and u-boot/sha512.h

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 boot/image-fit.c | 4 ----
 boot/image.c     | 2 --
 2 files changed, 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 89e377563ce..1efc39f4408 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -38,10 +38,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <image.h>
 #include <bootstage.h>
 #include <u-boot/crc.h>
-#include <u-boot/md5.h>
-#include <u-boot/sha1.h>
-#include <u-boot/sha256.h>
-#include <u-boot/sha512.h>
 
 /*****************************************************************************/
 /* New uImage format routines */
diff --git a/boot/image.c b/boot/image.c
index 073931cd7a3..e57d6eae52d 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -26,8 +26,6 @@
 #endif
 
 #include <asm/global_data.h>
-#include <u-boot/md5.h>
-#include <u-boot/sha1.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 
-- 
2.25.1

