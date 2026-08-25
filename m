Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960AAC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31F0880C98;
	Tue, 25 Aug 2026 19:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DEAMD8ux4v4m; Tue, 25 Aug 2026 19:34:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787686454;
	bh=KhyJTSlMpPPKNltasVXRXfr3s5wn5YRiZ3QcNe0VXVA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ONCbpds1tpA4407A5dtOJNBKMdauj4V0+7fnTulhRe1zOH7zA/OqRyBg2eNmFdahk
	 ehfFm+oxYvE33KtHz68Ze0VOsdcQnDrWGC1O5oYSa0FSk7cQT0QDqfRN+LVvI9POTB
	 9eLbAAWbA2hqO1IkUAF4lCfXzuS2Tb/FW+kq73j8VTXeltmuqZoR3U1/lpNk5ymGyh
	 urbqgRuGGcwpqOdKzG9qLaWhAN/wxV40kvaDqz5SCp9V6L9/OG92tZYPthTtx4juJ/
	 BYCkKcfkkylMWqQARfOfFJyEt18x8OaaSfBz3PGAPe7Tdxv+sWw+jDoN8biXAxZLFU
	 Mdz6oHDyeRGOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2BF980994;
	Tue, 25 Aug 2026 19:34:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 111C0396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02170809A7
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbxtflBuq426 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:34:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=NYdDoczO
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3ACB780984
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:34:10 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4b1fcd3b1a9so195174b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787686449; x=1788291249;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KhyJTSlMpPPKNltasVXRXfr3s5wn5YRiZ3QcNe0VXVA=;
 b=NYdDoczOb7VxEC/knW3VrRTd0HDthNo74fgBhbDwWJbhnVjvwGwezCmMU9f4U1rlnw
 XgcSZyRSdCRVzAE17oAxLxPdwQ1E9SywY4B6PifRn4CkqlXMIzFyuQr50xMcdTSwMGQ0
 K4ahWywfRe1yEJZxrBc2dxK8mNyDNKRazKcDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787686449; x=1788291249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KhyJTSlMpPPKNltasVXRXfr3s5wn5YRiZ3QcNe0VXVA=;
 b=J7u/PbO9egzagXVa0+6iANfOdltIidfj4lnQxVyvIpJCrkX6cOSAeS3dvKfcpQDUG5
 p8WHGriYzhUsFBsBGssThakKesKzJ+fkmcKJDfy6SQnyS2BsAKwCNWIOWVhcRDahfYtW
 lbu1JRbUBBulCgOcaskGLO2kScTAyPPCITeLq3rMMvPvgFB9c5vgeLoBRP0xHcs0Z9/t
 F59ZC2IQ0i94hNOVV4QENybqzo89YmqB38P/ReuvPzd2VHMIXTuR4aBTqvZNAM3LsfQG
 Ms4AlrGUwa9AILx+OKZ1NZgumkhprCjRVaG9t7MSts69H0gUwkD4wJkgqVt/7mCmb746
 nxcg==
X-Gm-Message-State: AFuF++kIkWAD/qxccH3DkvuaeHdN/XHciuXmtxG4dNnwJ8/chefPh3si
 JuGl3ob+qMXMhiLZC/1ojg2oT3E1i7ow5Pcgtsmy0pCWFveg1yhJWzqLYRbf4D1GNdmqw6F6WKK
 tObhpreLD1Z1N
X-Gm-Gg: AR+sD11pULe5TlzPoClIWN+svRXFDfCUb9umob/vUH8ssCmxqPdhnmlQ30hLId2MMEE
 dFDn/nDcmLaW3GRNi096h8PNA/vhc22nwb9KZmxOoIBOm+HV5DQjQVOZmxpoDw8rOIO22NoE+1y
 t1DZ7oY6qEobjtWuZuexYzCSR7HNfQMHSRhE8i5Ts0inopbgdZnspM0+3er2n6uXNwVjhetrq5P
 GXH9QvsNm7OK4iuhFOxIsJOnE5rRIA9DNgIOywdl3HKcPporqnGhsU+MbLJzR+8XJJFtgxdjism
 k9nq2HOf+nYPWmWbUsHjRmLb9tp8p04UARKpnZcnEsaVCHN8pNNmPETCveKKk3ZvHUH120slAX9
 Kpvd7S0K0d7n0PU6zkJu4ZivsWO3OJZpgp70UIavECak3wdervH57gL69lTtQv0j9L0YsZjPkpo
 0DPxddHaTxQaBmV+uRDq3IDIggg1eMdC/alhjGtTWT+vd5otel84K9bCddXASI1b5IQD+K65yDo
 fGr4sebpTwft10w4aNih/eefOw9vJjZj2srlDCIKTgKcsgMBfzZpL+PIAJDpWSODvzq/4zHLTU0
 MknbhL4u31Xkhd3slSt+TxbjPiKkfZE69cXQve4rY2qJ
X-Received: by 2002:a05:6808:5183:b0:497:df42:1dff with SMTP id
 5614622812f47-4b3668b51cfmr2173594b6e.1.1787686449321; 
 Tue, 25 Aug 2026 12:34:09 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b367ccc014sm278654b6e.6.2026.08.25.12.34.08
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 12:34:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] CI: Sage: Enable CMD_PCI on Raspberry Pi 3 builds
Date: Tue, 25 Aug 2026 13:34:07 -0600
Message-ID: <20260825193407.2347155-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Raspberry Pi 3 platforms will be tested on all of rpi_3, rpi_3_32b
and rpi_arm64 build configurations. In the case of rpi_arm64, the
default environment includes calling the "pci" command in the preboot
command, to enumerate USB. The problem here is that if we boot in to
rpi_arm64 and we run a saveenv then later we will run the tests on rpi_3
and rpi_3_32b. They do not have the PCI command and so the test harness
marks the platform as failing. It is harmless to call the command (as
shown by rpi_arm64 doing it safely), so enable it in CI, to cover this
case.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci-sage-lab.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index 9e1c2378c6ef..4c5a4062b99d 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -186,7 +186,7 @@ Raspberry Pi 3:
     LABGRID_EXPORTER: "sage-exporter-rpi3-1"
     LG_PLACE: "rpi3-1"
     TEST_PY_BD: "rpi_3"
-    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+    OVERRIDE: "-a PCI -a CMD_PCI -a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
 
 Raspberry Pi 3 (rpi_arm64):
   <<: *sage_lab_dfn
@@ -206,7 +206,7 @@ Raspberry Pi 3 (rpi_3_32b):
     LABGRID_EXPORTER: "sage-exporter-rpi3-1"
     LG_PLACE: "rpi3-1"
     TEST_PY_BD: "rpi_3_32b"
-    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
+    OVERRIDE: "-a PCI -a CMD_PCI -a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
 
 Raspberry Pi 3 (rpi_3_32b, lwIP):
   <<: *sage_lab_dfn
@@ -215,4 +215,4 @@ Raspberry Pi 3 (rpi_3_32b, lwIP):
     LABGRID_EXPORTER: "sage-exporter-rpi3-1"
     LG_PLACE: "rpi3-1"
     TEST_PY_BD: "rpi_3_32b"
-    OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000 -a NET_LWIP"
+    OVERRIDE: "-a PCI -a CMD_PCI -a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000 -a NET_LWIP"
-- 
2.43.0

