Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF4EC10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0689688377;
	Tue,  7 May 2024 19:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gPWc6T2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC955883BE; Tue,  7 May 2024 19:53:46 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885DC8836C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69b5de48126so10350226d6.3
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104423; x=1715709223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYxoRjxWSqY+duT/+85jTwVW/Ebk/XPVemnnDiVRRac=;
 b=gPWc6T2YvvExl9cBNWMNvy17ajD7hfA6LBroC/d0Lc8Npv24Bow9F+0bMUy9+zVwJ0
 R9Jj1Kkd6MsZ2lLuldLI++Eh70gQTSHz5OL6QqB1B4AMorrhVTk+Bos7WP0z3zPZjpMY
 l3VgbC+VHmxMnBiA2O7IegUcVNuaQW6Ctl1pq8sF4PHE8k8MwvO/pQTdRkf5vXfT9Kc1
 LZNLVN1FeeR1kHJneAH9uEmlwZ1dMC4LwBBlYwunQV/jCq/4Ranzx/nicKipMFhCkVwF
 2Ob/MMJyR2G6cPbljnFB9l3OZnqoeLD5MPO/ZMNZcBz8UwY37H3/pKkVy5aFLobMd8b7
 9pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104423; x=1715709223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYxoRjxWSqY+duT/+85jTwVW/Ebk/XPVemnnDiVRRac=;
 b=t5P8DfNz795gHdy9it3EZ2gGdv23g73ilC3lYM8vHmFn41GYhs0/P1GeqGxHpq/OQz
 HcNM3YiR6YJ1akV5QlrlVDDNkiy2Ej5duf/ER1QMKskqs08C87SNyX9/Hfyku7uo2/fd
 x3Lfw1k0cJ9Pz/UdO0sq4U4CmJHCZQAcOZZjNkeqRgtJKZzo+AeE7CR6X3pVxKDrvTR6
 5GqAioXGPTYYcQRdI+PNqTeEIfoOwGPjaNLjxGFinBnB+CfurfWbSggQpeOetGjABQy7
 79pLBRU0JZBCH322uTR6LYqzHc78yM+5nz6LngfbTPRo/W5UnUe4U1QBEu89HrCOzsou
 Dqnw==
X-Gm-Message-State: AOJu0Yyqiuevzcpjz7AAx74xAkpVnFQ+eEeftTmsNEZDb4ox9EmLohap
 OfRM9TuAe5Y2XjG2OsXoepsARv8TJ5q2lUHK0xa+jbrOtJx4i/ANwiWT0gw94oaKKWxwKYUMTUe
 t
X-Google-Smtp-Source: AGHT+IHIXT/+a1bwjoaV7Q1mT0k+IZDep3QyBKJerEZ9MNO0kqdKH45Um7TCB7AwestNs1GOJ8QsKw==
X-Received: by 2002:a05:6214:5016:b0:6a0:cceb:b261 with SMTP id
 6a1803df08f44-6a1514e8bd8mr6518486d6.57.1715104423083; 
 Tue, 07 May 2024 10:53:43 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:53:42 -0700 (PDT)
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
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 04/28] arm: EFI linker script text section alignment
Date: Tue,  7 May 2024 10:50:46 -0700
Message-Id: <20240507175132.1456512-5-raymond.mao@linaro.org>
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

Add text section alignment to fix sbsign signing warning
'gaps in the section table may result in different checksums'
which causes a failure of efi_image_verify_diges()

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 arch/arm/lib/elf_aarch64_efi.lds | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/elf_aarch64_efi.lds b/arch/arm/lib/elf_aarch64_efi.lds
index 5dd98091698..bffd9a0447a 100644
--- a/arch/arm/lib/elf_aarch64_efi.lds
+++ b/arch/arm/lib/elf_aarch64_efi.lds
@@ -28,6 +28,7 @@ SECTIONS
 		*(.dynamic);
 		. = ALIGN(512);
 	}
+	. = ALIGN(4096);
 	.rela.dyn : { *(.rela.dyn) }
 	.rela.plt : { *(.rela.plt) }
 	.rela.got : { *(.rela.got) }
-- 
2.25.1

