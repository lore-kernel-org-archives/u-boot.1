Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232D8C3ABDD
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E700C82C67;
	Tue, 20 May 2025 07:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZCzaLKdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 647D582C57; Tue, 20 May 2025 07:22:14 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A40D82BF2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so2779764f8f.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718532; x=1748323332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RId3ynH0dbdaC44l+hzrdwIGHuq1A4xDU8SjctHA4Y4=;
 b=ZCzaLKdCEgT5ziwv36QHMq0vFe3dX9ZyV2ef4EtKwgSZajsi658mt/SbvMP7zzblsQ
 DxNWxHUj7r68uS4IlkpOu7lzv2Lk0hIPIkifmmSV/kz2nF5FUmgrdRrkKwDxhf8HBqJN
 zMRO0kYRfzafSLAUCqS0KLRC+A6u8A9vKQzWU4Hj8PqiGiLLrKN2ShmshdNLTyW/wZB1
 yk1u+ClO6sRQxbeoTO9EFAMeYbUcSNOLUH2zePGafulGdd17FTdzHueSC1G/hfPMQmlU
 PxUR4vmLgGvkz1qi28020m/pjwlr4RAnY5Ja2r3g8HHsDopTeapyQxZJ+mOkSbsB5H16
 5a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718532; x=1748323332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RId3ynH0dbdaC44l+hzrdwIGHuq1A4xDU8SjctHA4Y4=;
 b=n93LY1VPJCcMefWkgA1fbiNYD3jjbw2ZHCaL5kScjnyOlrfYFRJ0mLfWC1NCEcf8Kh
 DR3zyjhhgVWoTajtHt5sap5Yzli/mAqYVP+gGhTUpmSARKJId/FLkT4UkxzeLWGfhVER
 6WLU9QZhu7RtPQPmEwe6EmKNxBLboVJi+aSOUMmYCGOQNEtndqutYLLLGLIf0zegpHbz
 uPOkyojfT7qRNvt4gVrxnxTwrIonjsU+iRpuG6WglEPoMYldGtGO8vrV4ap7LTnLkCU/
 wKfWfGaZOZy1B/Z/kEFGRqmRzrpVlEW70GkJDrhpq6h2Nupqbbj0A8N/rNft06wtkB8v
 Kpxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvSVWNfDdejxMVaDnayVivxBOAC+mK6ROBvaid1BtjRU3BZXbo2n5ZCO059MAM9S1VV+Dys64=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+53nuIq7cCUkB5pzzssgnxvKW3S44qtRJRiHSLw7vVE+/9/jv
 5rzLo4NNB4tivSbiGU7a3dDkY9dFeNnvLuFF60RFOeZJDAkSN6l+9DrtJ145qzlMG34=
X-Gm-Gg: ASbGncuSty0AWO24SRo1aKiycU5DoplGnzoHsnZ3eIB/MNlJjf9mMlMNFRyo4euhB82
 GAOU9QrcyEqVmkp66RbwY9vFJQyplTgZ9tQ8Cg8f7e+HCmU9KjTkfkRnk1yQuATmARIMISUFEbm
 EziOp1WA+wFS+2np1gZz2smIWD05eNQM6tkLlEqRUbsfZ3P9jVFgdLQ8COKXN3GdY+Nztow6zxA
 66rgknZRSo6OWFvJYFsjIBgYXqZmozsAayt5dx60x4//cRuwx3xFsTIMDI9NBo1oGOGcDlloovv
 WYcitO6ElTQaoz6JLjh+KC3ahjUHK652OlkpA9HXjRiHn3glCui/KWkkUsizu7kA05ETaj4a90w
 =
X-Google-Smtp-Source: AGHT+IGKmGMBYAvyan0+wt4fjVx3jF5a1k7J6M5GKs2bcJI1GbRaMqeHVseQ1nGmhw54j/WCfb6Pqg==
X-Received: by 2002:a05:6000:18a9:b0:3a3:6d01:1ed3 with SMTP id
 ffacd0b85a97d-3a36d012147mr6090222f8f.42.1747718531925; 
 Mon, 19 May 2025 22:22:11 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:11 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 05/24] kbuild: remove redundant target cleaning on failure
Date: Tue, 20 May 2025 08:21:16 +0300
Message-ID: <20250520052153.307194-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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

Bacport from the kernel

commit 172caf1993b7 ("kbuild: remove redundant target cleaning on failure")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 scripts/Makefile.lib | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a2b3b2e63872..7690cc61f9a1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -288,8 +288,7 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 # ---------------------------------------------------------------------------
 
 quiet_cmd_gzip = GZIP    $@
-cmd_gzip = (cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@) || \
-	(rm -f $@ ; false)
+cmd_gzip = cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@
 
 # DTC
 # ---------------------------------------------------------------------------
@@ -562,26 +561,22 @@ printf "%08x\n" $$dec_size |						\
 
 quiet_cmd_bzip2 = BZIP2   $@
 cmd_bzip2 = (cat $(filter-out FORCE,$^) | \
-	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	bzip2 -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
 cmd_lzma = (cat $(filter-out FORCE,$^) | \
-	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	lzma -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 quiet_cmd_lzo = LZO     $@
 cmd_lzo = (cat $(filter-out FORCE,$^) | \
-	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 quiet_cmd_lz4 = LZ4     $@
 cmd_lz4 = (cat $(filter-out FORCE,$^) | \
-	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -627,13 +622,11 @@ quiet_cmd_uimage = UIMAGE  $(UIMAGE_OUT)
 quiet_cmd_xzkern = XZKERN  $@
 cmd_xzkern = (cat $(filter-out FORCE,$^) | \
 	sh $(srctree)/scripts/xz_wrap.sh && \
-	$(call size_append, $(filter-out FORCE,$^))) > $@ || \
-	(rm -f $@ ; false)
+	$(call size_append, $(filter-out FORCE,$^))) > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
 cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
-	xz --check=crc32 --lzma2=dict=1MiB) > $@ || \
-	(rm -f $@ ; false)
+	xz --check=crc32 --lzma2=dict=1MiB) > $@
 
 # Additional commands for U-Boot
 #
-- 
2.49.0

