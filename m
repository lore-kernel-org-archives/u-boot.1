Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2F4E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 01:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE35480719;
	Wed, 15 Jan 2025 02:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DlJJfjOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 479DC80755; Wed, 15 Jan 2025 02:23:38 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE188060C
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4678664e22fso59180391cf.2
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736904215; x=1737509015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ri7CVdRdc+ubSLzMJwwdGA28mAhatcB+G4KC7zxxDiM=;
 b=DlJJfjODllfMi8v0G2ZpRPeB2VZUv/i4VU7xq940BDbcYAO3xCQFDGwfTEujaxhuZ3
 P2F1+scVCbOmMSBT0uhvdEDueG8LbseAnnvDU1VLzxf8MH9YcHxkdwc0saYgHQZ04ivO
 4CXTvMlQEPhNhGHRH1DH39jktLgVBXQlUvHwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736904215; x=1737509015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ri7CVdRdc+ubSLzMJwwdGA28mAhatcB+G4KC7zxxDiM=;
 b=hCUMKFdkiP4tyUl+9Fdw3wRa9Kl8SYegEIxRq+/FzW67VI3VCDJ4qMuzCB6G4cDOOW
 UkxIVzY5B5RUZtNTBLeBuEZKkTislten9Cru1kFGJotfl9zIILp/MmvqUZ0RqdDmar8u
 aZ699u5CFrlZ1FRKQYKXah8dIbXFuatLRDb9geod2GVJNZ2Y+AXPyv30OVeTf2k/58wO
 BtZlarhCBiHUJsH3wXTq706/imPBJS68eS8uZ6LxGRz38LbqjUumsJG9K/EVoDWV4k5C
 0VKx+ZcMJBz0OUPTHg6Vm1V2AgWs27G5DzgXeBSmgJOpo1u7GBqX3ZjTC9LtfyrSDkQ/
 v+Xg==
X-Gm-Message-State: AOJu0Ywk4Er9fKdn7A7tzKuHjsA7GpfAuz59hYFkVodzG0N33sZJ2oZW
 +Ldp+nMCJ20/yV/Rbi/d/RYT7f1fn1Eu8b4MUZ34s60yQsn0cdB0XbkDQL2iK4/yjX+A1PuS8OH
 h
X-Gm-Gg: ASbGncvq7BLBMoMLm3ZKThiocqVRhxnnwP9On1qNxtVUIW8bbpj2tmAezG0vNbcbbfk
 k+AWi91mthm2r4E28z5bPfR2XSrU3Kc/JyJTUzQXGzEVAeFPb6OR0CNiCoUpqM/G5LhRu6crKel
 O2sntcDmmsUjSODKrwqJF0tcpyb5amUKwOXHuBvpIZFBpbT0GiTyrbQLSO7eYvM8Ps9hCDdZOeU
 Nkt6T2xgkifmdspU1Ppoadm37PqizzZ8mVa+gKAYGMQvwAfpwjQ7LK186s1aJoAjTLTiCZggQFi
X-Google-Smtp-Source: AGHT+IHa97EDdcRcs96cKQdFfdgDATJ3O7zrrbJRDuFCYtpL/QuiPmEyc5s9NP84g9ztZMz0nQDdQg==
X-Received: by 2002:a05:622a:1196:b0:467:65d4:42aa with SMTP id
 d75a77b69052e-46c710e4ef9mr485480181cf.37.1736904214773; 
 Tue, 14 Jan 2025 17:23:34 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad9a2358sm59817096d6.50.2025.01.14.17.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 17:23:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCHv2 3/6] efi_loader: Depend on BLK
Date: Tue, 14 Jan 2025 19:22:10 -0600
Message-ID: <20250115012322.215243-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115012322.215243-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20250115012322.215243-1-trini@konsulko.com>
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

In reworking the BLK usage in Kconfig, I found there's a few issues with
EFI_LOADER=y and BLK=n. In general, we can easily say that
lib/efi_loader/efi_file.c also should only be built with CONFIG_BLK.
That however leaves the bootmgr code, eficonfig code and then parts of
efi_device_path.c, efi_boottime.c and efi_setup.c which functionally
depend on BLK. While these calls can be if'd out, I'm unsure if the
result is usable. So rather than leave that buildable and imply that it
is, I'm leaving that combination non-buildable and commenting that
EFI_LOADER depends on BLK in the Kconfig currently.

Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
Changes in v2:
- None.
---
 lib/efi_loader/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c46ffe3a9d89..798dced475e0 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -8,13 +8,14 @@ config EFI_LOADER
 			SYS_CPU = armv7   || \
 			SYS_CPU = armv8)  || \
 		X86 || RISCV || SANDBOX)
+	# We have not fully removed the requirement for some block device
+	depends on BLK
 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on !EFI_APP
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
-	select BLK
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
 	select DM_EVENT
-- 
2.43.0

