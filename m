Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC83C2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C1D86C52;
	Fri, 18 Aug 2023 02:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MCPPo+H8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BD1A86C05; Fri, 18 Aug 2023 02:27:28 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E2D86C0B
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34984bff431so1346985ab.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318443; x=1692923243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaxqOw5EqRH6u22Fe/YACO+zzCQ5mwtMS6CpphZI1N0=;
 b=MCPPo+H87nmct7C+DnAD/48mMsxaLbRj7U2gQJCuveVpTFl+CqrWybDDc36QLFH9gk
 4ILOh/BCaulUW8wO/EEPMa3KU2rqg5olmGZrSTSGozbRitGRXRJid1RRN+Lt5cuuIJ7s
 DFc58nL8st0px6j8xukkOzSbHnXYkn+0O7Zk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318443; x=1692923243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaxqOw5EqRH6u22Fe/YACO+zzCQ5mwtMS6CpphZI1N0=;
 b=GOgveac9HmZyhfsvfY+Sz3jI0StvNmu9Iyo+2aoznr7BgGUofovRsPK2rF1xv3U735
 9RFqfn1EsdCAAD+ns7xd63F0T6eT9DpaKvqEB4mHOyQsX8AgGO1dwTgGoumbzgNwYRDp
 yIsR9ELqdhKSIyB8a9PRnBVs1cZLi8R1QVoXGxp1DN3BNFRWPusFes37Po0CYj0H0UoO
 Eb9GLNaq5kdAH7uDWBMPGhcGofkI272gu/O+D9SjO6BCK1urh5Uz53trxEyFAv3IHE/w
 HK1B0Tcx1rHAUSRQOCjrxMAYPsNAwYOcD0HbXd9V0R9HMvZQe8/m/ZkppP4+D6P+1y/K
 q20A==
X-Gm-Message-State: AOJu0Yxr1aCzCxVU11EIlmsxrY2FqA+ilzHGpnjxmRi0wasVCl/IP4vy
 fyaO8ljz1rIiE/Pg+O1DpYOffg6l9MJbytHhMis=
X-Google-Smtp-Source: AGHT+IEsfTjVq/710mBo28hqvFcM7TQdrh08qWG/zUmYLWeSZVWH230ZB6xOGhkiY9w+E678zkrW0w==
X-Received: by 2002:a05:6e02:d09:b0:349:785:adc7 with SMTP id
 g9-20020a056e020d0900b003490785adc7mr1217177ilj.15.1692318443639; 
 Thu, 17 Aug 2023 17:27:23 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 12/20] x86: smbios: Add a Kconfig indicating SMBIOS-table
 presence
Date: Thu, 17 Aug 2023 18:26:51 -0600
Message-ID: <20230818002706.853550-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

When booted from coreboot, U-Boot does not build the SMBIOS tables, but
it should still pass them on to the OS. Add a new option which indicates
whether SMBIOS tables are present, however they were built.

Flip the ordering so that the dependency is listed first, which is less
confusing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch

 lib/Kconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index a9dca5f52b5a..b7bbf3f81c56 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -984,8 +984,9 @@ config BLOBLIST_TABLES
 
 config GENERATE_SMBIOS_TABLE
 	bool "Generate an SMBIOS (System Management BIOS) table"
-	default y
 	depends on X86 || EFI_LOADER
+	default y
+	imply SMBIOS
 	help
 	  The System Management BIOS (SMBIOS) specification addresses how
 	  motherboard and system vendors present management information about
@@ -1054,6 +1055,15 @@ config SPL_OID_REGISTRY
 	  unambiguous persistent name (https://en.wikipedia.org/wiki/Object_identifier).
 	  Enable fast lookup object identifier registry in the SPL.
 
+config SMBIOS
+	bool "SMBIOS support"
+	depends on X86
+	default y
+	help
+	  Indicates that this platform can create System Management BIOS
+	  (SMBIOS) tables. These provide various pieces of information about
+	  the board, such as the manufacturer and the model name.
+
 config SMBIOS_PARSER
 	bool "SMBIOS parser"
 	help
-- 
2.42.0.rc1.204.g551eb34607-goog

