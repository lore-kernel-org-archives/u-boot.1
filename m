Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A33C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248ED807D7;
	Sun,  9 Feb 2025 03:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oeRCTE3z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8801780050; Sun,  9 Feb 2025 03:01:51 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BE5A807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844d7f81dd1so101011039f.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066505; x=1739671305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9jv3HO+0tG6epMMFshY5cnYwlIPzZFE6CSgVmyZUBI=;
 b=oeRCTE3zcegcLEHoXbzCQ4mVLAixfxn/ci9LuR14o9P4VELzLGyKi7Qc5RhuUvQNwk
 9BDlqp5R5vMI+o6Xv3ZrC88KXc8+wTYPAGc5xQIIY/8S+1zKXd90lO5lf1N/6/sTBtZR
 GitUbFk2H04sd3NLS05Xvrm0kRW9rRP5AdY7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066505; x=1739671305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9jv3HO+0tG6epMMFshY5cnYwlIPzZFE6CSgVmyZUBI=;
 b=gk2gP4WyvG9c8VGJeoxKT5S7WSUOu0y3N815W+vPlr/e63MU5cGlJs5Ip+LbSfrPI/
 zrBk1/a02yW1TCKkp1hOddu3qRsXX43TtoaRome8nkoDqQp6CcFFg6YNRGZEcI47m2Rh
 VwKjKrbdczhmpBYjTRM319omdtI8byDi2J9nyQ89YvDOlxEA7bETzIA7LPoDuRZl7k/r
 0yiKyrxlNEbW8wRxkKQSVA+k6SXw4jI6v3hvmhRUA0lzdOEnDpgpNDZmvMVtnI8klIGr
 Q+1tqiL+sTrt0pXLuC7pgk6QodSO/e47g3fmUYCu+36j7Lz6eBSTy9y6wes7ID6eovaW
 fpEg==
X-Gm-Message-State: AOJu0YxbbeMxpfSwwc9+GgjiOWPYpssIqxZgA/V+Ura5lGcuFlmrrB9n
 uCFP6ZvnhjVgu+CtnFa96TG7ufuT797/Iix5Fo/1voj4iQl9JK7Le9sr5z+hTGmGutzUe7+jN3g
 =
X-Gm-Gg: ASbGnct1TsToxjiozY/8AUSBtPN22OyC/6T7wlbizY+nhr2LKsn7MBmBomHg7TiqkYv
 ijlJU7rjW5sDaFaOgNtXq0tFxMzcYFuJop8U5roi0P6c2aDzPfDhG8qwypVGQshDV9JGh9OMssr
 i3xseV4xyurTwt2kVdSOdKDbDl8o9/SMTT8a7VH3N6cVs0mOaNzR5e5gezSWzlySFn4kRISgDqB
 MRY0XjmNfZfpCHvGRdgcidsdxwf+4t2pMcW+UB1dLU2tyUEV+VQg+MQaWeP0Z/qFJdLkr1kuDLn
 NvIbidax5j8T4WINtazcn/Lyj+lSWvjg4JtgTlDyYXP5FVBD7WrP
X-Google-Smtp-Source: AGHT+IEkE1xKtlZXrWSE5sQXQ3ejPs172imPb65DGTDxfvWVQKCXdK7oRI6TNl+wF8OZ6L+VtY7CCw==
X-Received: by 2002:a05:6602:3713:b0:83a:a305:d9ee with SMTP id
 ca18e2360f4ac-854fd903a0emr841373839f.12.1739066505264; 
 Sat, 08 Feb 2025 18:01:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:01:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/29] Makefile: Avoid using TEXT_BASE if not present
Date: Sat,  8 Feb 2025 19:01:00 -0700
Message-ID: <20250209020136.4108987-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

(no changes since v2)

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

