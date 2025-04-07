Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF77C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 23:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8885B83092;
	Tue,  8 Apr 2025 01:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K3EyzYzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD0A830E3; Tue,  8 Apr 2025 01:52:20 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D948307F
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 01:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54afb5fcebaso5515513e87.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744069938; x=1744674738; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J6ohlPXE0F4jjviW3aRlXSBhbXtkVPM9FQNqNsR/reg=;
 b=K3EyzYzn0mYA1Moxm1D38Aqc2yGQdDfvJQKaaNh6LPLjHARFzW5F7ZDjBQMMqHsYAN
 m5gSr6JrDoeuRNG1SWD70oRyNvzSYoX7ng9k8vUcHzalZJm01ib7a0bEox4yGXuzpuhg
 xhsujApcJOJ1zicUmN7iMZ1v7EhHkAhyaslYi9MZd5iEUQ+Kk0ettqJxF0HiLmMf5XOB
 oQwoexiZpPzvTwsNUhX2OdmG/rupCT939Xj8uvYWyc/mP4zZ18qn/wg3iHX4o61ocTSJ
 FHIJTnyrJX3VRHe2SwICybyhCIl/Jyg6GvuheCg9+EjUzYkB8WA98B0P7BtVydsybF/E
 yisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744069938; x=1744674738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6ohlPXE0F4jjviW3aRlXSBhbXtkVPM9FQNqNsR/reg=;
 b=BnA77leJmns88YjEzkkFp91glO+1jbCLF9Boj75YQC8pm/9IsVvFewTTYT08h/fb6M
 XTuwQ3lmqqVCYfGrrVTTTvY3p2hu3rW8UWQjnOR6Hjcxswzdpkuh3+ah+r2rm1mJEkqK
 vgHy6coUIeiappz0pti4R3VJ81nn9GMsAwaUighobn9tk67qkk98pg418OcyKPFjRJUz
 fyB4Ga8G3MKCFkYHJQuxf7yXI81VZN4N+pWtLgnnBgYH3uUFV3rFbBmC25j8qXR1bQuL
 jBLIrHaoOE4gZUDCKGEsOhgyr1eLAM9JHkFiL9fjmvBPza6WTg13C2QWXxN1T29ral+o
 gS/A==
X-Gm-Message-State: AOJu0YyIbPzfgQeM0UmWc1SqaZF8JLO0XEDKytwm15pMmzbbQXU0uw/L
 nwi8aqzZP29NeLUjFl9Bd/Xzmbdip+TZEEf2SLfv9J2drwcx/xfYo7yVgQQLMKM6ueL89gi3NIF
 QuCtGPR4q+Pt7g8+CCa2fGxGAtmQ=
X-Gm-Gg: ASbGncurwvHAQCSl1Log4COegOHvH6U/J9jQ3rWPBRYsXvU+v3QHy+9YS0O+0eJlbEb
 gNKgEJjIXFGxlrdaB2X0scShf+FBWd+LmV3CmXUkRy8Uu1ZW2I2y+CqGV700xHuWOHPUaTfaY9U
 zM34Ms5VWO+JL2RTQ0ggiCI+T2d0KEHY/96mN41amcul8kPFc5WmNVi32KKg==
X-Google-Smtp-Source: AGHT+IEKlxNYlO1jBrnN+WAk5f/1BxKpNIsinbNBLCQJLl7iTscbjN/UDTyZvUDdYzscPdrrshdSz3DIlsBFf0Lx/YQ=
X-Received: by 2002:a05:6512:2209:b0:549:8d60:ca76 with SMTP id
 2adb3069b0e04-54c29836d56mr2829828e87.38.1744069937715; Mon, 07 Apr 2025
 16:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250404113919.3860489-1-festevam@gmail.com>
 <d046117c-2a69-490e-8093-3d0f3499514d@linaro.org>
In-Reply-To: <d046117c-2a69-490e-8093-3d0f3499514d@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Apr 2025 20:52:06 -0300
X-Gm-Features: ATxdqUEhBkm5-GQpcIlQaa0cp48ajJv8BHnIvAnjulWWewXFZDm4_kwf_6rNh5k
Message-ID: <CAOMZO5Bq5tECSLVsz8pC7zJx4rr0bjmjyHMsvgaJUOEkqYF1Ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] board: atmel: sama5d2_wlsom1_ek: Fix spurious
 serial output
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Apr 7, 2025 at 3:39=E2=80=AFAM Eugen Hristev <eugen.hristev@linaro.=
org> wrote:

> I am not convinced.
> The purpose of this early UART would be to get output *before* the DM
> code would enable clocks, pins, etc, for exactly that purpose, early
> debug output.
> So to remove all this and make the initialization rely on the SPL DM
> code would defeat the purpose.

Ok, but if we have CONFIG_DEBUG_UART enabled, shouldn't we then
disable CONFIG_SPL_SERIAL?

The change below fixes the serial garbage shown in SPL:

--- a/configs/sama5d27_wlsom1_ek_mmc_defconfig
+++ b/configs/sama5d27_wlsom1_ek_mmc_defconfig
@@ -16,7 +16,6 @@ CONFIG_OF_LIBFDT_OVERLAY=3Dy
 CONFIG_DM_RESET=3Dy
 CONFIG_SYS_MONITOR_LEN=3D524288
 CONFIG_SPL_MMC=3Dy
-CONFIG_SPL_SERIAL=3Dy
 CONFIG_SPL_DRIVERS_MISC=3Dy
 CONFIG_SPL_STACK=3D0x218000
 CONFIG_SPL_TEXT_BASE=3D0x200000

I suspect CONFIG_DEBUG_UART and CONFIG_SPL_SERIAL conflict with each other.

Is the change above acceptable? If not, what would you suggest?
