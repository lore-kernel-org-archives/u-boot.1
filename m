Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CAC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 14:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138B188453;
	Wed, 17 Apr 2024 16:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="r7wjg/82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F10A8845D; Wed, 17 Apr 2024 16:01:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 539F488305
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 16:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AF7293F85F
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713362496;
 bh=OJ0O3V9Q9lrZICUT17Oi1TFLR/fompw+OHn2Eq0im0g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=r7wjg/82awJMAacrDIQ0KmIqmFpLmC2NUc6Qe6MZC8o3nSwNAIB6jbmLr8YNawY4S
 Ot524LarvEO4d0qtU2uJ4vmk1wkUZe99zuU7GrpWODBnzlQTHaQmgCfM1ae4YzvJ5O
 sZ2c0CRypAMvMaZse7aRiyVe0WhcI7kTmGbOdOaJW7W71atmH/cDq/YewpPa2XiaCa
 2dkH8C2pjuJjV+ndrppphUyzxLrVAt6RZuL7q2n6OG5142LxY2vuYlJ66x1Sff0wpr
 MI4ih7UIYAwEYs+Agx4Asx5KwJwbu6ROWO418T9XBZMcqwHMzc8dvu8fSnDig11AV8
 ViBHE1iVfBN2g==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-346d3020e08so3636878f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 07:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713362496; x=1713967296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OJ0O3V9Q9lrZICUT17Oi1TFLR/fompw+OHn2Eq0im0g=;
 b=lPh4bM9N7UCe88/xxHoH2EWnld71z1De6Bv1ey0NdA9/8Kmqc2pn8siKyJnL2EBj5p
 idHfyfBtnKb0+VLbkV43oESC+/YvwSTHqs90T++8xKvTdqPyAc7xA6lk4k0Zz7rNPlee
 kjWHDps5npFrJDAZZrnTEcnmkBU851yTj6sKnMCPxgN5ruV/fa/0OWKwRgWSJfQmIvfv
 s69E279B+dP/fPzj6X3z9RKHynOCPIX1cLGEHgxo/DOVnomvBx8KM2BjS/XoTXy4oNOx
 IH7/OWRGZD+J/ykkpIsIwrVAQOyg1C2FTdQOXeykb00C+1EmdbacAs44R9XzdZYuiFtd
 7OuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAu/ym15QFTx51B5ioQTCY74A8dM27hc4hq9W7tQq8kJ1ovDUAgWb0PWQ3yeSPGb6rwLYcLfmlkJcfd+gC9sQtHKhpNg==
X-Gm-Message-State: AOJu0YwYSa13WSIgt0/6vjKuDbV6vN54zZfyWVnIdT8vzEKSG73/pxeD
 7YXXNF4+LzlurIrC3hpJpS+uAH3KpP2hNMOKpNpkIX4DIA4mb6F0dkkpOFgCFFdhj0JL9keeaoN
 pgWLRBQBaztqJvI948M/Ou53Z+W03/Xfo4diKbYFq5zxdcMm96dvi+EqFih64tWI+T1M=
X-Received: by 2002:adf:fe90:0:b0:343:740c:5d14 with SMTP id
 l16-20020adffe90000000b00343740c5d14mr10986424wrr.31.1713362496313; 
 Wed, 17 Apr 2024 07:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpM8jFPDOeEhG0RlC+OB5quohCxR0axUUvQXDZQE2bU5Bh3GOGG+XVIi3MB5zcmr4ALnPlmA==
X-Received: by 2002:adf:fe90:0:b0:343:740c:5d14 with SMTP id
 l16-20020adffe90000000b00343740c5d14mr10986399wrr.31.1713362495861; 
 Wed, 17 Apr 2024 07:01:35 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 cg17-20020a5d5cd1000000b0033e7a102cfesm14723908wrb.64.2024.04.17.07.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 07:01:35 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>
Cc: Leo <ycliang@andestech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] cmd: sbi: add Supervisor Software Events extension
Date: Wed, 17 Apr 2024 16:01:27 +0200
Message-ID: <20240417140128.100372-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

OpenSBI has implemented the Supervisor Software Events Extension.
Allow detecting it in the sbi command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 cmd/riscv/sbi.c              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index d1113f3d703..ad32dedb589 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -34,6 +34,7 @@ enum sbi_ext_id {
 	SBI_EXT_NACL = 0x4E41434C,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_DBTR = 0x44425452,
+	SBI_EXT_SSE = 0x535345,
 };
 
 enum sbi_ext_base_fid {
diff --git a/cmd/riscv/sbi.c b/cmd/riscv/sbi.c
index bd9d9c4765d..55507b0aa63 100644
--- a/cmd/riscv/sbi.c
+++ b/cmd/riscv/sbi.c
@@ -54,6 +54,7 @@ static struct sbi_ext extensions[] = {
 	{ SBI_EXT_NACL,			      "Nested Acceleration Extension" },
 	{ SBI_EXT_STA,			      "Steal-time Accounting Extension" },
 	{ SBI_EXT_DBTR,			      "Debug Trigger Extension" },
+	{ SBI_EXT_SSE,			      "Supervisor Software Events" },
 };
 
 static int do_sbi(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.43.0

