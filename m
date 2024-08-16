Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FECC52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B323B88CBF;
	Sat, 17 Aug 2024 00:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MOUC9WlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CABD88498; Fri, 16 Aug 2024 23:55:44 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A4688C78
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 23:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b78c980981so12362576d6.2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 14:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723845340; x=1724450140; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=US3QjRDxgzh6m7OchTNqxOLW6eRUo6/FLFtC9yDCfkI=;
 b=MOUC9WlBYAONsnc2c3/nBQhlsG+jrEs83OZ+muzuDuHLttKOFn3AVj+M/jMTm4zYd+
 siaef1AU86HV+p5j1gX/rDhoOmouq3JmCp54hG0XftRKi7GbOLTryNLa5hHuTB2S/ouz
 30vlFCFCk1efTS6UIBxeX7k31eHWJuTJlttth1vB9wkcN+qvAmvNg1IiYOJATCc3B5ZA
 qz22bWzUnEgM+gMH9tg32KYw4SJR6Fglf2PlNjLp9DWTF+Vl8NI4tPT8uktNwHLOmBWl
 aFMaQMeBqy/3f53IVNPBeizVsCoIWBakDo5XVwOZ6GZTEmR0XeSScx5b0GOVh2tmAzhk
 xTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723845340; x=1724450140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=US3QjRDxgzh6m7OchTNqxOLW6eRUo6/FLFtC9yDCfkI=;
 b=NUebEhTIHc0M+FnoRqgMKBPoUVKZMsql2Yp8ysUAxRM2lWLQt8CZ5C3XJA0kfjeSG2
 v4+VtRWcObwDwO0zofSljSUyhKbYChch8P/DU4A9uYpcaDykg4/3Moyt9zS6TIrHGtNq
 OKAej/jkPnQgE9OkHqGow72Cp1ffR25rpz5i0qluClrwKsbZqlSkXwWitLJJYbOqk7T3
 TYVQb+aQKRaU2n9ij9FywW1dl8v9+Pjg8idmjmBQKjC7HJj+7VXTU3s5cm4in+IMwTVd
 Bmd//HFBKxDZpJ+hhZ1/ZRiCpsurMYP63vHpCp1izuR2sA6Y6cn+zN0M3/wiYhkUltSj
 EXkg==
X-Gm-Message-State: AOJu0YxA4A9KazZIiExp5GzjwesHlaOYAV+orLWdEPeDzMult1kmvvFt
 +43rblNLiKeqnU8/4ACXyLyk6qvfqjPdNSw2PadjJjWjWuCSjZ38VPhTkI7OWCCUEHmXCMagq9r
 bbhA=
X-Google-Smtp-Source: AGHT+IHO7kGzWxv2J9Tg+AKYAoYH4YhWYscKFTH118Fqqlsidq1GD/y7/U4h2AbW+d8722prXjc3Pg==
X-Received: by 2002:a05:6214:162f:b0:6bf:81a2:2a86 with SMTP id
 6a1803df08f44-6bf81a22fb3mr28041246d6.36.1723845339975; 
 Fri, 16 Aug 2024 14:55:39 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6ff04ffbsm22044196d6.128.2024.08.16.14.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 14:55:39 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>, Anand Moon <linux.amoon@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v6 28/28] configs: enable MbedTLS as default setting
Date: Fri, 16 Aug 2024 14:44:17 -0700
Message-Id: <20240816214436.1877263-29-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816214436.1877263-1-raymond.mao@linaro.org>
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Aug 2024 00:59:01 +0200
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

Enable MbedTLS as default setting for qemu arm64 and sandbox.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.
Changes in v3
- None.
Changes in v4
- None.
Changes in v5
- Remove unused config MBEDTLS_LIB_TLS.
- Remove EFI_SECURE_BOOT from the default config.
Changes in v6
- Remove MBEDTLS_LIB_CRYPTO and MBEDTLS_LIB_X509.

 configs/qemu_arm64_defconfig | 1 +
 configs/sandbox_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 7e166f43908..2a7885d2a68 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -67,4 +67,5 @@ CONFIG_TPM2_MMIO=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_PCI=y
 CONFIG_SEMIHOSTING=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_TPM=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 484f9e1bf8d..2ca2e66d1de 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -344,6 +344,7 @@ CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
+CONFIG_MBEDTLS_LIB=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1

