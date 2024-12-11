Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D8EE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2186801FD;
	Wed, 11 Dec 2024 23:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VTuAdXAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1385580214; Wed, 11 Dec 2024 23:38:37 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D14F2801FD
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844bc5166deso1132239f.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733956713; x=1734561513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2avSfS8QofNuq7dgDO8C+52ct8h9vLIRHSSDoVy/jc=;
 b=VTuAdXAhRVrekHO1hczo4wXwE8ZBt/KZRQNR3oNJvcqbh/as65AyO9V1zRebdq0nP4
 i2JMwEBHwZohVLUee3mfV+NpglWB76z8Y0GCr3jDvB2NWStO/8140eIqXm6wlPOt9K7D
 0SXG6VfaIYOW5D5CWVkre7XoXY71zK7EI7wQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956713; x=1734561513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2avSfS8QofNuq7dgDO8C+52ct8h9vLIRHSSDoVy/jc=;
 b=Nqmxpwa1Mf6pBmfeAX26GQfNf8V0ZRZ7fZ43H6GqfEfiF2vS+DTEfdeD1X4Yy2zqMa
 uh8dVoJ7c86UsuJQzpYJWoB1Jv8JM0Rw3GY10nNGXG4tgqKO4KYdJ+xuPS5NGnCXOY/f
 DSowICudJWTALgFYbDQ5l3fhhc0CNyrgD28WYVnIUOfXlYJNCGCGW912sObCIL/2/jz9
 mJyxpbFp8/ahQzc/NinHzvtPZP/0DHnoSyDZYUWrzHq8X5bllTnnUx7wK/EcijKxweGg
 jThNP9q1K2+lOGGsrvV4zdJqqb++madqNob59AvA95T0WhjjrEIncmR3+9TmdPxteXAG
 5U+w==
X-Gm-Message-State: AOJu0YyDQVRFezWV02+S1VK2+cGOI8ocsWW/kwjETD817rBGt9bReLqw
 5HLXGind+ReSTlhzlYADBAJlP5RusKsQV2fwHz/D8rSc9y0PjZO/RVUPjwqPpQyVFh6Mze6WppM
 =
X-Gm-Gg: ASbGncsbh/IcKreoARrwrVeIiUdQBG8qjxzMgzPC9v/fWUh2KYPC3k/IouUZ7b+DIBT
 uYCZ3vl4HAw+LdjOazDQrIHslwB8etdgBhPUqVScmaY4DB/4yx/0Yde92YMitG1hjur2BTuCP0o
 Yg7uoui/Ct0wnApacyOYnR5hk7ib32g5IYBOtO6dnNCbmZgl8L7vdsxhf8hj3Jq4XtT27MKVoMC
 Eme48WElNJbXhtUUzW3397Z69q/yu4dEgPtDs7Uc9RmW7/tBq4cNzmOUHW7vQKo/QcBoQbdweYg
 HyLwRq+gBiSY+vQpxA==
X-Google-Smtp-Source: AGHT+IF0N6zKQd9nJYFsQ+jzSw/u1EaOY6t+pRPLWSa2FHuuFxniXe7BT1TU6hiacPOsyldumo+qzQ==
X-Received: by 2002:a05:6e02:1fce:b0:3a7:8149:6aa with SMTP id
 e9e14a558f8ab-3ac4e07ed54mr14907655ab.24.1733956713089; 
 Wed, 11 Dec 2024 14:38:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bce7981bsm1902816173.67.2024.12.11.14.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:38:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v2 2/7] efi_loader: Make efi_run_image() static
Date: Wed, 11 Dec 2024 15:38:17 -0700
Message-Id: <20241211223822.2446254-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211223822.2446254-1-sjg@chromium.org>
References: <20241211223822.2446254-1-sjg@chromium.org>
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

This function is not called from outside this file and has no entry in
the header file, so mark it static.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_loader/efi_bootbin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index afb13a008c2..ec8f4e4f7f4 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -141,7 +141,7 @@ void efi_set_bootdev(const char *dev, const char *devnr, const char *path,
  * @source_size:	size of the UEFI image
  * Return:		status code
  */
-efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
+static efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 {
 	efi_handle_t mem_handle = NULL, handle;
 	struct efi_device_path *file_path = NULL;
-- 
2.34.1

