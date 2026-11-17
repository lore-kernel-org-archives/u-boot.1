Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84503606A32A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yi9ij6Ej;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=tZOSbD9X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A95460A4D;
	Wed, 18 Nov 2026 01:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8qgo9a1ZbrrY; Wed, 18 Nov 2026 01:26:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8BCB26084B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965181;
	b=MA9bBqQmJNm/O7xpTF/dEGJjb6LhIsVf/x3xV1ikfwdfVIpFoGxkgDepQGmssY0kpKk7
	 VNvrfhPeil+gK6znlqI1ZGc3MloU9uFSwkNvknKyJ4L6TbuRmGvB7ceYXBRYRkNbozgOF
	 QMdcGmsS3VgmZvauucQn96SqwAObxH6YZgEOG1Ci3rhCfXLcva2sczuVufBnKWGuV1a8G
	 l2ShafMMVoJ/FOKFvLxTvXuBnBcJThfc7qAnVaO96E1EYcucbNVryJn8+3+NNQLnZtJu5
	 ayxdo3PJevl3mZDZ0NCxATxx439lNV8U3c0j2SOF8UVxJ53GJjMcE+lqqHJLaeSIawA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965181;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NKWH4zlvSb3bH0jErz854XFRpbqzT2lGBhXCNxChDWc=;
	b=AzABpIpDp+0nyXxlXG7qh3hjCSOJadyf26Eu6SxmCz6MKlm0Wmp1vVxkBs+RN2fr9InY
	 wNFNxPjB4nfuAgbGHQXe0p7qwq09ilkzNSs7VlKRubFdqD2Ob7U9ME1uwwiKqCHH0HAqn
	 dwyAWahpeMyagyi0bgwh3c5pkqw/n9w8COOeRgKyr0ZSpRd/3knURlDlXc4fZDdjJqLpl
	 yDvh/GxcExbILsJ64vPSFPKqHX4QwnN+9rFSQ7p/e59uyEzZO615mKhYfqa7h5QTvHNJR
	 OZ6k1vwKkNzMpeEczldos04oo8SQXYYfUT4Fq5Ejj+jiD+PMq6c5U/RwJSRQjQlDRSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965181;
	bh=NKWH4zlvSb3bH0jErz854XFRpbqzT2lGBhXCNxChDWc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yi9ij6EjFbN1lxBimPi0eXwcwv22LA34TxR1xx8xnGOJBN0kLeUe+PfZiO/bPfs5p
	 2Bk4cOAlA0/pupwxrja9ARET/NzA6MZROqC5mSZSlWNgDeR7PcEQgHKjFDqkFT0isl
	 /vmCg60X5GfCrMnB5o5nZKABhpUINERUBgbjPOcNz34HVi3138MhDJauS34BX8qdQz
	 lFQoOQmHIQ/iEFjF1TPDlSJA9eEcxWzWjVOmsoUC10wGh3iM+FxyAu1Iq5BSv4lL1x
	 TvK3QUE6dpMGHZ8ba2OVF1SDspleE4tp1juJY7pnkYtb6SzirtJcXPU/it+xH/7q59
	 7FASaIIY/fz6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BCB26084B;
	Wed, 18 Nov 2026 01:26:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59C19A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FF7B810AD
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C5gOCDmeFk88 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 23:57:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2569C810AC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=774fa3f08=romain.caritey@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=tZOSbD9X
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2569C810AC
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 23:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794959824; x=1826495824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oEN6i+umb8EJVr4XcJyCF5ckEJ7K6pDoDPRgN8cwMDE=;
 b=tZOSbD9X3hI6ysDETHFYswRm0WyJOgbCgMTEJ8tvG3es2F6VMgduAXHJ
 MjeXw5ZG1FVSSRjdI13oUK4XibfT0h8cbp1P8MKX1uB+79TiYUSYhPi6Q
 zXGOIlkCIFmPIb3mBFgL+XCzqru8TBG/COYk1lOqMMADv9doez/nX8mlH
 sZsPnLnkNmgXzTqBVkGqjwKUyBm3wajoRIf20h6S6g8rMB5mBtoxmAZmg
 zZPWf80JZ6WYtFKKk32byH1UVmxmXzhCxecpFPZoBZnBbc5vFgHQx6dhC
 H+Qu0R9ofUEqrzEc63XhUx/rHh6/PzExPOFdMcUm/KulJ9Jfj970qG37J w==;
X-CSE-ConnectionGUID: +cqOnbdoTx6dbGfcVfwRjw==
X-CSE-MsgGUID: v1j3+fc5Sder8rbPqY4I1w==
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="77405151"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:55:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 17 Nov 2026 16:55:59 -0700
Received: from bby-cbu-c71245.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 17 Nov 2026 16:55:58 -0700
From: Romain Caritey <romain.caritey@microchip.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tim
 Ouyang" <tim609@andestech.com>
CC: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 <charles.perry@microchip.com>, <mamemaria.mbaye@microchip.com>, "Romain
 Caritey" <romain.caritey@microchip.com>, Simon Glass <sjg@chromium.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>
Subject: [PATCH 2/4] riscv: check that only R_RISCV_RELATIVE relocations are
 generated
Date: Tue, 17 Nov 2026 15:54:11 -0800
Message-ID: <20261117235433.3601945-3-romain.caritey@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117235433.3601945-1-romain.caritey@microchip.com>
References: <20261117235433.3601945-1-romain.caritey@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 18 Nov 2026 01:25:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot proper is linked with -static -pie on RISC-V, so the linker
resolves every symbol and only emits R_RISCV_RELATIVE dynamic
relocations. Any other relocation type in .rela.dyn would mean that
the image can not be relocated correctly.

Add a checkriscvreloc target, modelled after checkarmreloc, and run it
for U-Boot proper so that such a binary fails to build instead of
failing at run-time.

Signed-off-by: Romain Caritey <romain.caritey@microchip.com>
---
 Makefile             | 10 ++++++++++
 arch/riscv/config.mk |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index a9cc6ec2bd3..09d6bf7fe11 100644
--- a/Makefile
+++ b/Makefile
@@ -2516,6 +2516,16 @@ checkarmreloc: u-boot
 		false; \
 	fi
 
+# RISC-V relocations should all be R_RISCV_RELATIVE, as
+# apply_relocation in arch/riscv/cpu/start.S only handles that type.
+checkriscvreloc: u-boot
+	@RELOC="`$(READELF) -r -W $< | cut -d ' ' -f 4 | \
+		grep R_RISCV | sort -u`"; \
+	if test "$$RELOC" != "R_RISCV_RELATIVE"; then \
+		echo "$< contains unexpected relocations: $$RELOC"; \
+		false; \
+	fi
+
 tools/version.h: include/version.h FORCE
 	$(Q)mkdir -p $(dir $@)
 	$(call if_changed,copy)
diff --git a/arch/riscv/config.mk b/arch/riscv/config.mk
index eddd6a3b9a2..dc7bd603add 100644
--- a/arch/riscv/config.mk
+++ b/arch/riscv/config.mk
@@ -41,3 +41,8 @@ LDFLAGS_u-boot		+= --gc-sections -static -pie
 
 EFI_CRT0		:= crt0_riscv_efi.o
 EFI_RELOC		:= reloc_riscv_efi.o
+
+ifneq ($(CONFIG_XPL_BUILD),y)
+# Check that only R_RISCV_RELATIVE relocations are generated.
+INPUTS-y += checkriscvreloc
+endif
-- 
2.47.3

