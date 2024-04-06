Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54626CD1284
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 14:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0385587FC6;
	Sat,  6 Apr 2024 16:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UM1sCKTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5466788047; Sat,  6 Apr 2024 16:02:45 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C36A87EA8
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 16:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-343e46ec237so1227515f8f.2
 for <u-boot@lists.denx.de>; Sat, 06 Apr 2024 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712412162; x=1713016962; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=128MPsUpnBMBJL7kWRT++tO9IWOd5ocVBD7CqfU2C40=;
 b=UM1sCKTr3/XWhFeIS8NGjUL1U3Fm4mCuWEUSnKk/d6sDk1SHd+ayDbBCODNwChKpDX
 xQIFuO3chi5QUjPPxndAJJw3Ws7N+SbSdxJtl/IAL6HI7TWA35VWmzRh3a37R8wK6MOk
 shp8HmCezACmHps1lj4otXsFsm0XsBzx0HIKHByxnMOtTiplh7gssmJq3yY5vqn4emt8
 wj3FRrb4l7n+XKZr7SISSE1wx2zJ74vfeAdw4FxiSPoHGqZ0eerV+t4Vl0AsUkvhTlzh
 Jddxfh2gzyGA0zNdl1H/8lGvKMjeB9q+PurggxaGM+AbwjZEWh+IFkubtYCwfOtL+at3
 VdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712412162; x=1713016962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=128MPsUpnBMBJL7kWRT++tO9IWOd5ocVBD7CqfU2C40=;
 b=FQKgH/C250YZX26rqnrPWGKpFYnAFGQfTixcPjnFPrG0tPJCuUC4d7fHOuzWM+qQ/I
 iOOWXzOzKZ0elbBk2ESEVEduHbndi0teblJ/d0UNomLi+Jmr7nyo/KNoNdc8RW/zpVLP
 QbVpM6M2fkwURTwQCyZUsYasj8pIT79EVCpBa0DrCDuxpRioU2r5Lwho3aqYoq3dFCXi
 Sf8clTxa3yMvcKhhUEaJ4jvkbUcY1hL5urKTAU4a5leba7cGCslA70oq5Ct0qYDTqfi9
 f/kIZTkKgroQjedqEo6ueRYMLfnlxp6CoY0Tlhb+I5mHhvHyh8Z1EimQtxg48sQpHEjE
 ASbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlyjtjkWC90lg6iqoZ5AYnI7I4ywr8H3YgQSwEXBU25DzYW4CEtoUx/GHuS5vKMfFGp5+CxRF+Bgr27DhdECXgI3qOBw==
X-Gm-Message-State: AOJu0Yx8uYZjStZVzGbV7eWQWU+/oiP2rAUWA/mkapYLiOZkpOyY9pM8
 MawbLPlkpq6DvpIQEq0Jmnz/OJySELvRExmRWGcVWjdkjSOuRHZgJXVNnxemcJ8=
X-Google-Smtp-Source: AGHT+IH1KV3TfBIAm8g31GTeOzV92Fd0d5oCvzrkAfKRLAu+IAAKZogMNkZ5DCgPWcinDU3vKyUQ9w==
X-Received: by 2002:adf:f9cc:0:b0:343:6c81:8fd3 with SMTP id
 w12-20020adff9cc000000b003436c818fd3mr2927726wrr.24.1712412162556; 
 Sat, 06 Apr 2024 07:02:42 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004163de6cfabsm1729756wms.11.2024.04.06.07.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 07:02:42 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1 0/4] Enable SetvariableRT
Date: Sat,  6 Apr 2024 17:01:56 +0300
Message-Id: <20240406140203.248211-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
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

Hi all,

This is an updated version of [0].

When EFI variables are stored on file we don't allow SetVariableRT,
since the OS doesn't know how to access or write that file.  At the same
time keeping the U-Boot drivers alive in runtime sections and performing
writes from the firmware is dangerous -- if at all possible.

For GetVariableRT  we copy runtime variables in RAM and expose them to
the OS. Add a Kconfig option and provide SetVariableRT using the same
memory back end. The OS will be responsible for syncing the RAM contents
to the file, otherwise any changes made during runtime won't persist
reboots.

It's worth noting that the variable store format is defined in EBBR [1]
and authenticated variables are explicitly prohibited, since they have
to be stored on a medium that's tamper and rollback protected.

The original RFC was just enabling the memory back end. This is a more
complete version and we should be able, with small adjustments of
userspace tools, fix SetVariableRT. If enabled the firmware will add two
new RO EFI variables after ExitBootServices.

RTStorageVolatile -- contains the filename, relative to the ESP
VarToFile -- an EFI variable that holds all the BS,RT, NV variables and can
be copied to the file defined by RTStorageVolatile.

If any errors occur during the variable init, the firmware will delete them
and adjust the RT_PROP table accordingly, disabling SetvarRT.

- pre-patch
$~ mount | grep efiva
efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)

$~ efibootmgr -n 0001
Could not set BootNext: Read-only file system

- post-patch
$~ mount | grep efiva
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
, disabling SetvarRT.
$~ efibootmgr -n 0001
BootNext: 0001
BootCurrent: 0000
BootOrder: 0000,0001
Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}

$~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
Name: "BootNext"
Attributes:
        Non-Volatile
        Boot Service Access
        Runtime Service Access
Value:
00000000  01 00

[0] https://lore.kernel.org/u-boot/20240329071929.2461441-1-ilias.apalodimas@linaro.org/
[1] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage

Changes since the RFC:
- Return EFI_INVALID_PARAM if attributes are not volatile
- Add EFI_WRITE_PROTECTED checks for BS, RT *only* variables
- Add 2 EFI variables and allow userspace to write the file
- Add selftests

Ilias Apalodimas (4):
  efi_loader: conditionally enable SetvariableRT
  efi_loader: Add OS notifications for SetVariableRT in RAM
  efi_loader: add an EFI variable with the variable file contents
  efi_selftest: add tests for setvariableRT

 include/efi_loader.h                          |   4 +
 include/efi_variable.h                        |  15 +-
 lib/efi_loader/Kconfig                        |  16 ++
 lib/efi_loader/efi_boottime.c                 |   2 +
 lib/efi_loader/efi_runtime.c                  |   1 +
 lib/efi_loader/efi_var_common.c               |  43 ++--
 lib/efi_loader/efi_var_file.c                 |   1 -
 lib/efi_loader/efi_var_mem.c                  |  90 +++-----
 lib/efi_loader/efi_variable.c                 | 210 +++++++++++++++++-
 lib/efi_loader/efi_variable_tee.c             |   1 -
 .../efi_selftest_variables_runtime.c          | 116 +++++++++-
 11 files changed, 401 insertions(+), 98 deletions(-)

--
2.37.2

